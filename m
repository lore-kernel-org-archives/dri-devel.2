Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05085C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0D310E0DD;
	Wed, 19 Aug 2026 07:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VGLM7/gg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22B810E0DD
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 07:07:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C212A601FB;
 Wed, 19 Aug 2026 07:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0901F000E9;
 Wed, 19 Aug 2026 07:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787123273;
 bh=8Moz7vjmn5Bqbin1QniTOR4WC7OUjGtLgG+T3Vs7iSE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VGLM7/ggbUTZcdAB1+t6sgFE5UJORHrZzwRF6EfRVcnYElUDzAP7ZHaNsPtJADl7a
 gaFMN6ddF0DVbhHKwo51NQ3CJBMw9mXm3x59oQIAEbsZQ6ImZstbVC0QavvDjQUmWj
 zkgDglf4DhUGhYk/E5PNGX1badKMyBvMVjuhVvOiVMXMIqqUw9pK3lAb4L8YaFLhIV
 5CQ82jKREmA8o7vgxEgf7OJAfG4C7lQVHbH6k11u4iVBKJRBa+eSb2z9MSdnQmADf0
 sFO4tLJRY6aunjQcM1cp9Xy2D7pSP6ookDTJwlYw+TXQjYdkUS0arx1vUaCgqnaYSU
 IVDTfnSY+auqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mediatek: Add missing IS_ERR check for ovl_adaptor
 platform device
To: "Haojie Li" <lihaojie@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819065642.136222-1-lihaojie@kylinos.cn>
References: <20260819065642.136222-1-lihaojie@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 07:07:52 +0000
Message-Id: <20260819070753.5B0901F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The dynamically registered `ovl_adaptor` platform device is leaked=
 on probe error paths and during device removal, causing duplicate device a=
ccumulation.
- [High] `platform_device_register_data()` is misused to create a shallow, =
byte-for-byte clone of a `struct device` object.
- [High] `mtk_drm_bind()` mistakenly drops the `private->mutex_node` refere=
nce on `-EPROBE_DEFER`, causing an unbalanced put and potential use-after-f=
ree.
- [High] In `mtk_drm_of_ddp_path_build_one()`, if `mtk_drm_of_get_ddp_ep_ci=
d()` fails early, it causes a double-put of the current device node in the =
loop.
- [Medium] In `mtk_drm_of_ddp_path_build_one()`, if the initial call to `mt=
k_drm_of_get_ddp_ep_cid()` fails but sets `next`, the acquired device node =
reference is leaked.
--

--- Patch [1]: [PATCH] drm/mediatek: Add missing IS_ERR check for ovl_adapt=
or platform device ---
commit 6317e1a251b60c3bf25295a5bff30bc7683eb97b
Author: Haojie Li <lihaojie@kylinos.cn>

drm/mediatek: Add missing IS_ERR check for ovl_adaptor platform device

This commit adds an IS_ERR() check after platform_device_register_data() in
mtk_drm_probe() to prevent a potential kernel crash due to an invalid point=
er
dereference on error.

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index c86a3f54f35bc..667d7fdbfbac6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -1112,6 +1112,10 @@ static int mtk_drm_probe(struct platform_device *p=
dev)
>  							    PLATFORM_DEVID_AUTO,
>  							    (void *)private->mmsys_dev,
>  							    sizeof(*private->mmsys_dev));

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to pass
(void *)private->mmsys_dev and sizeof(*private->mmsys_dev) as the platform
data?

platform_device_register_data() kmemdups the provided memory into the new
device's platform_data.=20

Copying the entire struct device object (including its kobject, mutexes,
and list heads) byte-for-byte might lead to subsystem operations running on
cloned and broken locks or kobjects when used by the OVL adaptor driver.

> +		if (IS_ERR(ovl_adaptor)) {
> +			ret =3D PTR_ERR(ovl_adaptor);
> +			goto err_node;
> +		}

[Severity: High]
This is a pre-existing issue, but is the dynamically registered ovl_adaptor
platform device leaked on probe error paths and during device removal?

If probe fails later (for example, returning -EPROBE_DEFER) and jumps to
err_node, or when mtk_drm_remove() is called, it doesn't look like
platform_device_unregister() is ever called.

This could leave orphaned devices accumulating on the platform bus.

>  		private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev =3D &ovl_adaptor-=
>dev;
>  		mtk_ddp_comp_init(dev, NULL, &private->ddp_comp[DDP_COMPONENT_DRM_OVL_=
ADAPTOR],
>  				  DDP_COMPONENT_DRM_OVL_ADAPTOR);

[ ... ]

> static int mtk_drm_bind(struct device *dev)
> {
>       ...
>		of_node_put(private->mutex_node);
>		return -EPROBE_DEFER;
>       ...
> }

[Severity: High]
This is a pre-existing issue, but does mtk_drm_bind() mistakenly drop the
private->mutex_node reference on -EPROBE_DEFER?

If it drops the reference here when the disp-mutex device is delayed, and t=
he
driver is later unbound, mtk_drm_remove() will call of_node_put() again on
the same node pointer.

Could this cause an unbalanced put and potential use-after-free?

[ ... ]

> static int mtk_drm_of_ddp_path_build_one(...)
> {
>       ...
> 	ret =3D mtk_drm_of_get_ddp_ep_cid(vdo, 0, cpath, &next, &temp_path[idx]);
> 	if (ret) {
> 		if (next && temp_path[idx] =3D=3D DDP_COMPONENT_DRM_OVL_ADAPTOR) {
> 			...
> 		} else {
> 			if (next)
> 				dev_err(dev, "Invalid component %pOF\n", next);
> 			else
> 				dev_err(dev, "Cannot find first endpoint for path %d\n", cpath);
>
> 			return ret;
> 		}
> 	}

[Severity: Medium]
This is a pre-existing issue, but does this initial error path leak the
acquired device node reference?

If mtk_drm_of_get_ddp_ep_cid() fails but still sets next, the code logs an
error and returns ret directly.

It doesn't appear to call of_node_put(next) before returning, which would
leave the reference dangling.

[ ... ]

> 	do {
> 		prev =3D next;
> 		ret =3D mtk_drm_of_get_ddp_ep_cid(next, 1, cpath, &next, &temp_path[idx=
]);
> 		of_node_put(prev);
> 		if (ret) {
> 			of_node_put(next);
> 			break;
> 		}

[Severity: High]
This is a pre-existing issue, but can this error path trigger a double-put =
of
the device node?

If mtk_drm_of_get_ddp_ep_cid() fails early (for example, returning -ENOENT)
without updating the next pointer, next will still point to prev.

The loop calls of_node_put(prev), and since ret is non-zero, it also
calls of_node_put(next). This would decrement the refcount of the same node
twice.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819065642.1362=
22-1-lihaojie@kylinos.cn?part=3D1
