<?php

// This file has been auto-generated by the Symfony Dependency Injection Component for internal use.

if (\class_exists(\ContainerYJJrMbw\srcProdProjectContainer::class, false)) {
    // no-op
} elseif (!include __DIR__.'/ContainerYJJrMbw/srcProdProjectContainer.php') {
    touch(__DIR__.'/ContainerYJJrMbw.legacy');

    return;
}

if (!\class_exists(srcProdProjectContainer::class, false)) {
    \class_alias(\ContainerYJJrMbw\srcProdProjectContainer::class, srcProdProjectContainer::class, false);
}

return new \ContainerYJJrMbw\srcProdProjectContainer(array(
    'container.build_hash' => 'YJJrMbw',
    'container.build_id' => 'fd8d4385',
    'container.build_time' => 1539531966,
), __DIR__.\DIRECTORY_SEPARATOR.'ContainerYJJrMbw');
