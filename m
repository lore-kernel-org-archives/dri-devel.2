Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33378606A33E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsHr6zGZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C26210E039;
	Wed, 25 Nov 2026 18:12:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F142610E039
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:12:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C23AD461D1;
 Wed, 25 Nov 2026 18:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8CD1F000C0;
 Wed, 25 Nov 2026 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630327;
 bh=FdtKe+UtIBioXqmGwjWgR7+kCcSV7e1NnFJPjab9dUQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NsHr6zGZZXW8tPnk5vgzmaV9J93Gff+fnE88QL0Q0llXDzf2Bhsy8QRZf/dpYMdqM
 vzSOBZyPeVtkUryykWokRX4uHMpeSMxIb7rU6k10/qFpxABh+CCBCbMt5wj+pXc8/L
 KYURsAgVsynVNrLbWGxDMPY1iJbyH7uEVORDqLIg9b8cMA/5lluhuF5LvnPNXXTPKI
 9MKPVYFUpy/Gdp559UP0/xC6qv+fSM80F1/Fg9fzPjsKP22Qwjait8pRVX1leLiaLD
 6K67rNL991c50GDEPmRvuhtrj9ItCDaki2DLpgMja49APNOeW7zWDJEwzW0Tt68lTe
 hBh7KjzaY1sMA==
Message-ID: <sashiko-outbox-233922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/32] drm/atomic: drm_atomic_private_obj_fini:
 protect private_obj removal from list
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-15-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-15-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:12:07 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/atomic: race on obj->lock after unlock in
  drm_atomic_private_obj_fini()
--

commit 3a87086f7fda1b1abd7935fa8244d82c32bc24a2
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/atomic: drm_atomic_private_obj_fini: protect private_obj removal from l=
ist

This commit wraps the list_del_init(&obj->head) call in
drm_atomic_private_obj_fini() with DRM_MODESET_LOCK_ALL_BEGIN() and
DRM_MODESET_LOCK_ALL_END() to serialize private object removal against
concurrent modeset locking.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 1c3fe07b327ec..096f85419b369 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1106,6 +1106,9 @@ EXPORT_SYMBOL(drm_atomic_private_obj_init);
>  void
>  drm_atomic_private_obj_fini(struct drm_private_obj *obj)
>  {
> +	struct drm_modeset_acquire_ctx ctx;
> +	int ret =3D 0;
> +
>  	/*
>  	 * Some callers ignore drm_atomic_private_obj_init() failures
>  	 * and unconditionally register a teardown action that calls
> @@ -1117,7 +1120,10 @@ drm_atomic_private_obj_fini(struct drm_private_obj=
 *obj)
>  	if (list_empty(&obj->head))
>  		return;
> =20
> +	DRM_MODESET_LOCK_ALL_BEGIN(obj->dev, ctx, 0, ret);
>  	list_del_init(&obj->head);
> +	DRM_MODESET_LOCK_ALL_END(obj->dev, ctx, ret);
> +
>  	obj->funcs->atomic_destroy_state(obj, obj->state);
>  	drm_modeset_lock_fini(&obj->lock);
>  }

[Severity: High]
Can a thread that already observed obj before list_del_init(&obj->head)
acquire obj->lock as soon as DRM_MODESET_LOCK_ALL_END() drops it, racing
with atomic_destroy_state() and drm_modeset_lock_fini()?

For example, if drm_modeset_lock_all_ctx() hits -EDEADLK on obj->lock
(because another atomic operation holds obj->lock), modeset_lock() saves
&obj->lock in ctx->contended and drm_modeset_backoff() drops all held
locks, including connection_mutex, before slow-locking contended:

CPU0                                  CPU1
drm_mode_obj_get_properties_ioctl()
  DRM_MODESET_LOCK_ALL_BEGIN()
    drm_modeset_lock_all_ctx()
      drm_modeset_lock(&obj->lock)
        ctx->contended =3D &obj->lock
        returns -EDEADLK
  DRM_MODESET_LOCK_ALL_END()
    drm_modeset_backoff()
      contended =3D ctx->contended
      drm_modeset_drop_locks()
                                      drm_bridge_detach()
                                        drm_atomic_private_obj_fini()
                                          DRM_MODESET_LOCK_ALL_BEGIN()
                                          list_del_init(&obj->head)
                                          DRM_MODESET_LOCK_ALL_END()
      modeset_lock(contended, ...)
        list_add(&obj->lock.head,
                 &ctx->locked)
                                          atomic_destroy_state()
                                          drm_modeset_lock_fini(&obj->lock)
                                            WARN_ON(!list_empty(&lock->head=
))
                                        ...
                                        drm_bridge_put() -> kfree(bridge)
    drm_modeset_drop_locks()
      /* touches freed obj->lock */  <-- use-after-free

The same race occurs if another thread blocks directly on obj->lock
without holding connection_mutex, such as drm_atomic_get_bridge_state()
while bridge->chain_node is still on encoder->bridge_chain (since
drm_bridge_detach() unlinks chain_node after drm_atomic_private_obj_fini()),
or __drm_state_dump().  When DRM_MODESET_LOCK_ALL_END() unlocks obj->lock,
the waiter wakes up and duplicates or reads obj->state while
atomic_destroy_state() frees it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D15
