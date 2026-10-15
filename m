Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191ADCC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B21010E281;
	Thu, 15 Oct 2026 15:23:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BA710E281
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:23:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C53416022A
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBA41F000C4;
 Thu, 15 Oct 2026 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792077813;
 bh=9GIj2+AeJh5A1dyQCUC+PGxVOF+E3qX38yuqW19pd7c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DOTbLIEJwHmfA2jnQa8Hobqi7Hi7aQhGJ+SgXB9DKpnMM2YId1a5I1byY0hdtlMkR
 X23GiY7Udbe2cbKOh6IEEYhZPtmJ56y4Yie5XSYSt4w+Rfh5xp2nPheg4S9PN32RzA
 ZO5dKeoQ4XhlUFSjXJZxiCm35RgXDb7MTMSp0TbrtHYLbtn/INqNf46UEvy93TdnZX
 Q0FjJzso779SF0/pSBPD46E87YVR+nPcfeY9u/JMK/Fk6peTXRGHxtArvIq64DiSXH
 a5e6E8klXndZuhw9XWjvR8uMBETydDpiJIKPNqFrqy5+oMVxE3BmeBgmFBJ7RrOzIY
 s1+kd8B7qUKmQ==
Message-ID: <sashiko-outbox-173059@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/28] drm/atomic: Add drm_private_obj name
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-2-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-2-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:23:32 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm_atomic: ignored drm_atomic_private_obj_init() returns cause li=
st corruption on cleanup
- [Medium] drm_bridge: missing kasprintf() NULL check in __devm_drm_bridge_=
alloc()
--

commit 7310711925ad29e1494d52640c5914ade7203851
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Add drm_private_obj name

drm_private_obj does not carry a human-readable name, which makes
debug messages hard to interpret when multiple private objects are
registered on the same device.

Add a name field to drm_private_obj, passed through
drm_atomic_private_obj_init() and freed in
drm_atomic_private_obj_fini(). Update the existing callers to pass a
name.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 9973becb75aee..53703b23be8f0 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
[ ... ]
> @@ -1037,6 +1039,12 @@ int drm_atomic_private_obj_init(struct drm_device =
*dev,
> =20
>  	obj->dev =3D dev;
>  	obj->funcs =3D funcs;
> +	obj->name =3D kstrdup(name, GFP_KERNEL);
> +	if (!obj->name) {
> +		ret =3D -ENOMEM;
> +		goto err_lock_fini;
> +	}
> +
>  	list_add_tail(&obj->head, &dev->mode_config.privobj_list);
> =20
>  	state =3D obj->funcs->atomic_create_state(obj);

[Severity: High]
Since drm_atomic_private_obj_init() can now return -ENOMEM due to allocation
failure, do all existing callers need to check its return value?

Currently, callers ignore the return value. If kstrdup() fails, the function
returns early without initializing obj->head. When the caller later runs its
teardown path and calls drm_atomic_private_obj_fini(), it will call
list_del(&obj->head), resulting in a null pointer dereference.

> @@ -1051,6 +1059,9 @@ int drm_atomic_private_obj_init(struct drm_device *=
dev,
> =20
>  err_list_del:
>  	list_del(&obj->head);
> +	kfree(obj->name);
> +	obj->name =3D NULL;
> +err_lock_fini:
>  	drm_modeset_lock_fini(&obj->lock);
>  	return ret;
>  }

[Severity: High]
Similarly, if atomic_create_state() fails and takes the err_list_del path,
list_del(&obj->head) poisons the list pointers.=20

Because callers ignore the return value, the subsequent teardown call to
drm_atomic_private_obj_fini() will perform a double-deletion on these
poisoned pointers.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index e7f9e6d589272..d474d60204110 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
[ ... ]
> @@ -421,6 +422,7 @@ void *__devm_drm_bridge_alloc(struct device *dev, siz=
e_t size, size_t offset,
>  	INIT_LIST_HEAD(&bridge->list);
>  	bridge->container =3D container;
>  	bridge->funcs =3D funcs;
> +	bridge->name =3D kasprintf(GFP_KERNEL, "bridge-%s", dev_name(dev));
>  	kref_init(&bridge->refcount);
> =20
>  	err =3D devm_add_action_or_reset(dev, drm_bridge_put_void, bridge);

[Severity: Medium]
Does kasprintf() need a null check here?=20

If the allocation fails under memory pressure, bridge->name will be null,
which is later passed to drm_atomic_private_obj_init() where kstrdup(null)
will return null and fail the initialization.

[ ... ]
> @@ -649,7 +651,7 @@ int drm_bridge_attach(struct drm_encoder *encoder, st=
ruct drm_bridge *bridge,
>  			goto err_reset_bridge;
>  	}
> =20
> -	drm_atomic_private_obj_init(bridge->dev, &bridge->base,
> +	drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
>  				    &drm_bridge_priv_state_funcs);
> =20
>  	return 0;

[Severity: High]
Here is an example in drm_bridge_attach() where the integer return value of
drm_atomic_private_obj_init() is completely ignored, masking the
initialization failure and setting up the teardown crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D2
