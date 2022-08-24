CREATE DATABASE kurly;
CREATE USER 'kurly'@'localhost' IDENTIFIED BY 'kurly';
CREATE USER 'kurly'@'%' IDENTIFIED BY 'kurly';
GRANT ALL PRIVILEGES ON kurly.* TO 'kurly'@'%';
GRANT ALL PRIVILEGES ON kurly.* TO 'kurly'@'localhost';
FLUSH PRIVILEGES;


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
    charset = utf8mb4;

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
    charset = utf8mb4;

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
    charset = utf8mb4;

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
        unique (presetName),
    constraint preset_category_categoryName_fk
        foreign key (categoryName) references category (categoryName),
    constraint preset_user_userId_fk
        foreign key (producer) references user (userId)
)
    charset = utf8mb4;

create table preset_detail
(
    presetId     bigint                             not null,
    categoryName varchar(100)                       not null,
    productId    int                                not null,
    createdAt    datetime default CURRENT_TIMESTAMP null,
    updatedAt    datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint preset_detail_category_categoryName_fk
        foreign key (categoryName) references category (categoryName),
    constraint preset_detail_preset_presetId_fk
        foreign key (presetId) references preset (presetId)
)
    charset = utf8mb4;

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
    charset = utf8mb4;

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
    charset = utf8mb4;


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
    charset = utf8mb4;

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
    charset = utf8mb4;

create index productId
    on product_preferences (productId);

create index userNumber
    on product_preferences (userNumber);

create table preset_preferences
(
    userNumber bigint                             not null,
    presetId   bigint                             not null,
    preference float                              not null,
    createdAt  datetime default CURRENT_TIMESTAMP null,
    primary key (userNumber, presetId)
)
    charset = utf8mb4;

create index presetId
    on preset_preferences (presetId);

create index userNumber
    on preset_preferences (userNumber);
