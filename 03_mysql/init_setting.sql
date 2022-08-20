CREATE DATABASE kurly;
CREATE USER 'kurly'@'localhost' IDENTIFIED BY 'kurly';
CREATE USER 'kurly'@'%' IDENTIFIED BY 'kurly';
GRANT ALL PRIVILEGES ON kurly.* TO 'kurly'@'%';
GRANT ALL PRIVILEGES ON kurly.* TO 'kurly'@'localhost';
FLUSH PRIVILEGES;


create table category
(
    categoryName       varchar(50)                        not null
        primary key,
    parentCategoryName varchar(50)                        null,
    createdAt          datetime default CURRENT_TIMESTAMP null,
    updatedAt          datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint category_category_parentCategoryName_fk
        foreign key (parentCategoryName) references category (categoryName)
            on update cascade on delete cascade
)
    collate = utf8mb4_general_ci;

create table filter
(
    filterName  varchar(100)                       not null
        primary key,
    description varchar(200)                       null,
    createdAt   datetime default CURRENT_TIMESTAMP null,
    updatedAt   datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP
)
    collate = utf8mb4_general_ci;

create table user
(
    userNumber bigint auto_increment,
    userId     varchar(20)                        not null
        primary key,
    userName   varchar(20)                        not null,
    password   varchar(200)                       not null,
    email      varchar(100)                       null,
    createdAt  datetime default CURRENT_TIMESTAMP null,
    updatedAt  datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint user_userName_uindex
        unique (userName),
    constraint user_userNumber_uindex
        unique (userNumber)
)
    collate = utf8mb4_general_ci;
create table product
(
    productId    bigint auto_increment
        primary key,
    productName  varchar(100)                       not null,
    categoryName varchar(50)                        null,
    company      varchar(50)                        not null,
    price        int                                not null,
    weight       int                                null,
    score        float    default 0                 not null,
    imagePath    varchar(200)                       not null,
    createdAt    datetime default CURRENT_TIMESTAMP null,
    updatedAt    datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint product_productName_uindex
        unique (productName),
    constraint product_category_categoryName_fk
        foreign key (categoryName) references category (categoryName)
)
    collate = utf8mb4_general_ci;

)
    collate = utf8mb4_general_ci;

create table preset
(
    presetId      bigint auto_increment
        primary key,
    presetName    varchar(100)                       not null,
    presetContent varchar(300)                       null,
    categoryName  varchar(50)                        not null,
    recommend     int      default 0                 not null,
    buyCount      int      default 0                 not null,
    views         int      default 0                 not null,
    producer      varchar(20)                        not null,
    createdAt     datetime default CURRENT_TIMESTAMP null,
    updatedAt     datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint preset_presetName_uindex
        unique (presetName)
)
    collate = utf8mb4_general_ci;

create table preset_detail
(
    presetId     bigint                             not null,
    categoryName varchar(100)                       not null,
    productId    int                                not null,
    createdAt    datetime default CURRENT_TIMESTAMP null,
    updatedAt    datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint preset_detail_preset_presetId_fk
        foreign key (presetId) references preset (presetId)
)
    collate = utf8mb4_general_ci;


create table purchase_history
(
    userId    varchar(20)                        not null,
    productId bigint                             not null,
    count     int      default 1                 not null,
    createdAt datetime default CURRENT_TIMESTAMP null,
    updatedAt datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint purchase_history_product_productId_fk
        foreign key (productId) references product (productId),
    constraint purchase_history_user_userId_fk
        foreign key (userId) references user (userId)
)
    collate = utf8mb4_general_ci;

create table cart
(
    userId    varchar(20)                        not null,
    productId bigint                             not null,
    count     int      default 1                 not null,
    createdAt datetime default CURRENT_TIMESTAMP null,
    updatedAt datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint cart_product_productId_fk
        foreign key (productId) references product (productId),
    constraint cart_user_userId_fk
        foreign key (userId) references user (userId)
)
    collate = utf8mb4_general_ci;

create table preset_preferences
(
    userNumber bigint                             not null,
    presetId   bigint                             not null,
    preference float                              not null,
    createdAt  datetime default CURRENT_TIMESTAMP null,
    primary key (userNumber, presetId)
)
    collate = utf8mb4_general_ci;

create index presetId
    on preset_preferences (presetId);

create index userNumber
    on preset_preferences (userNumber);

create table product_preferences
(
    userNumber bigint                             not null,
    productId  bigint                             not null,
    preference float                              not null,
    createdAt  datetime default CURRENT_TIMESTAMP null,
    primary key (userNumber, productId),
    constraint product_preferences_product_productId_fk
        foreign key (productId) references product (productId),
    constraint product_preferences_user_userNumber_fk
        foreign key (userNumber) references user (userNumber)
)
    collate = utf8mb4_general_ci;

create index productId
    on product_preferences (productId);

create index userNumber
    on product_preferences (userNumber);

create table user_category_binding
(
    userId       varchar(20)                        not null,
    categoryName varchar(100)                       not null,
    createdAt    datetime default CURRENT_TIMESTAMP null,
    updatedAt    datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint user_category_binding_category_categoryName_fk
        foreign key (categoryName) references category (categoryName),
    constraint user_category_binding_user_userId_fk
        foreign key (userId) references user (userId)
)
    collate = utf8mb4_general_ci;

create table user_filter_binding
(
    userId     varchar(20)                        not null,
    filterName varchar(100)                       not null,
    createdAt  datetime default CURRENT_TIMESTAMP null,
    updatedAt  datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint user_filter_binding_filter_filterName_fk
        foreign key (filterName) references filter (filterName),
    constraint user_filter_binding_user_userId_fk
        foreign key (userId) references user (userId)
)
    collate = utf8mb4_general_ci;

create table user_preset_binding
(
    userId    varchar(20)                          null,
    presetId  bigint                               null,
    recommend tinyint(1) default 0                 not null,
    buyCount  int        default 0                 not null,
    createdAt datetime   default CURRENT_TIMESTAMP null,
    updatedAt datetime   default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint user_preset_binding_preset_presetId_fk
        foreign key (presetId) references preset (presetId),
    constraint user_preset_binding_user_userId_fk
        foreign key (userId) references user (userId)
)
    collate = utf8mb4_general_ci;
