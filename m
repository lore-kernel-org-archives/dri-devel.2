Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6222C43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2314310ED89;
	Fri, 26 Jun 2026 13:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gih9d4Xz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E0E10ED89
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:38:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F8B1600C8;
 Fri, 26 Jun 2026 13:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2086C1F000E9;
 Fri, 26 Jun 2026 13:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782481108;
 bh=89C8Ddyrn1BCNGEuCZ30ANY2nDi6vqPqzUTD/c2ut/I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gih9d4XzDcEvAIM+fj6SOdyGuKePomwDJI3tB3w4Dex024ygf2281n34XW+5sp0Y7
 y9B3n3uIEprS66QAlD2j99M7nBaVk8LaOZEKrpuHdEWK/lTiyikzt0GhNtB4qVg+u9
 7T996rcCczI3BYYCKlMGWfJyckSKMhoq+7zhtnOWQv/poDkwSz6dRpRsHN45YjjvG+
 6Pr3vTQu3CQparO/fVAicrbEEyDNfQY0G8QBTFpwex7bsqpKuu4RvqsUA+mLNaygyz
 fGABd1ysskUBUKoB7qcKMM915GMU1bYe5522HBOtR/1b9qYQhL57HJO9Fhi7MHBDdX
 J33pR/tTzAw3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/mediatek: mtk_drm_probe: of_node_get in loop
 overwrites previous   node references without release
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626132849.38694-1-vulab@iscas.ac.cn>
References: <20260626132849.38694-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 13:38:27 +0000
Message-Id: <20260626133828.2086C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double free of device node reference during display pipeline build=
ing.
- [High] Missing error check for platform_device_register_data and resource=
 leak of ovl_adaptor.
- [Medium] Memory leak of device node reference on initial endpoint parsing=
 failure.
--

commit f5070502c5d9a79054533fcb309f450daf5da836
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: drm/mediatek: mtk_drm_probe: of_node_get in loop overwrites previous n=
ode references without release

In the for_each_child_of_node loop, private->comp_node[comp_id] and
private->mutex_node are assigned via of_node_get without first releasing
any previously stored reference for the same index. When the same comp_id
or mmsys_id matches multiple nodes, earlier node references are
overwritten and permanently leaked.

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index c86a3f54f35bc..2c0d8db9ade29 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -1138,6 +1138,7 @@ static int mtk_drm_probe(struct platform_device *pd=
ev)
> =20
>  			id =3D of_alias_get_id(node, "mutex");
>  			if (id < 0 || id =3D=3D private->data->mmsys_id) {
> +				of_node_put(private->mutex_node);
>  				private->mutex_node =3D of_node_get(node);
>  				dev_dbg(dev, "get mutex for mmsys %d", private->data->mmsys_id);
>  			}
> @@ -1153,7 +1154,7 @@ static int mtk_drm_probe(struct platform_device *pd=
ev)
> =20
>  		if (!mtk_drm_find_mmsys_comp(private, comp_id))
>  			continue;
> -
> +		of_node_put(private->comp_node[comp_id]);
>  		private->comp_node[comp_id] =3D of_node_get(node);
> =20
>  		/*

[Severity: High]
This isn't a bug introduced by this patch, but looking at mtk_drm_probe()
slightly earlier in the same function, is there a missing error check for
platform_device_register_data()?

drivers/gpu/drm/mediatek/mtk_drm_drv.c:mtk_drm_probe() {
    ...
	if (mtk_drm_find_mmsys_comp(private, DDP_COMPONENT_DRM_OVL_ADAPTOR)) {
		ovl_adaptor =3D platform_device_register_data(dev, "mediatek-disp-ovl-ada=
ptor",
							    PLATFORM_DEVID_AUTO,
							    (void *)private->mmsys_dev,
							    sizeof(*private->mmsys_dev));
		private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev =3D &ovl_adaptor->de=
v;
    ...
}

If platform_device_register_data() fails, it returns an ERR_PTR.
Would taking the address of &ovl_adaptor->dev on an ERR_PTR and passing it =
to
mtk_ddp_comp_init() result in an invalid pointer dereference?

Additionally, if the registration succeeds, there doesn't seem to be a
corresponding platform_device_unregister() call in the error paths (like
err_node or err_pm) or in mtk_drm_remove(). Could this leak orphaned platfo=
rm
devices permanently on probe failures?

[Severity: High]
This is another pre-existing issue, but in the related
mtk_drm_of_ddp_path_build_one() function, is there a potential double-free
of the device node reference?

drivers/gpu/drm/mediatek/mtk_drm_drv.c:mtk_drm_of_ddp_path_build_one() {
    ...
		ret =3D mtk_drm_of_get_ddp_ep_cid(next, 1, cpath, &next, &temp_path[idx]);
		of_node_put(prev);
		if (ret) {
			of_node_put(next);
			break;
		}
    ...
}

If mtk_drm_of_get_ddp_ep_cid() returns an error like -ENOENT (e.g., at the
end of the pipeline) without modifying next, prev and next would point
to the same node.

Since of_node_put(prev) is called unconditionally, wouldn't the subsequent
of_node_put(next) in the error block result in a double-free of the
same node reference?

[Severity: Medium]
This is also a pre-existing issue, but earlier in
mtk_drm_of_ddp_path_build_one(), does the error return path leak a
device node reference?

drivers/gpu/drm/mediatek/mtk_drm_drv.c:mtk_drm_of_ddp_path_build_one() {
    ...
			} else {
				if (next)
					dev_err(dev, "Invalid component %pOF\n", next);
				else
					dev_err(dev, "Cannot find first endpoint for path %d\n", cpath);

				return ret;
			}
    ...
}

If mtk_drm_of_get_ddp_ep_cid() populates next with a reference but
returns an error, won't returning ret directly leak the reference
held by next?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626132849.3869=
4-1-vulab@iscas.ac.cn?part=3D1
