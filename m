Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCB1C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F3010EAF7;
	Tue,  4 Aug 2026 15:37:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YYjWIR2n";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DA810EAF7
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:37:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DFFED60A75;
 Tue,  4 Aug 2026 15:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5667B1F000E9;
 Tue,  4 Aug 2026 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785857860;
 bh=9etF0gJ3X1/zHrRN/t6dkfO4BZ5KTDCOy02R6y+ps/8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YYjWIR2nV35A6ZdMU23HeIGUyOQDQzR6FpPB8VKSovRNZWMOT/f6A3HZG48FX/5aC
 px3ZWzJgV5wc4jUBo988fK/gg1/vEzk8nA+/UOxX+fQjjDg8UeWtLKwxsahfELoqP2
 +cNOzhmkmwuYxdgvRLi4rjKcK4CUULRfKdyT/JUCyGDxu9OwrYHFZ2/byFFxhl/5kh
 BpzNjpVgEssJFMbUdzX8GAvRCco9DbJVgoCQbcasJuQgMKRsZqyHALjnvALIdwQStm
 6IqIju+bKqTL2p//1MfpYZUOisto+TFubhy6WzmdLebsVa8YRzx59lCYi9pOJ3CW1W
 t46mkVmwdHWiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/meson: clean up KMS polling on register failure
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260804150802.45262-1-mhun512@gmail.com>
References: <20260524160657.17802-1-mhun512@gmail.com>
 <20260804150802.45262-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:37:39 +0000
Message-Id: <20260804153740.5667B1F000E9@smtp.kernel.org>
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
- [High] NULL pointer dereference in error path if devm_kzalloc() fails to =
allocate priv
- [High] Use-After-Free due to DRM objects allocated with devm_kzalloc inst=
ead of drmm_kzalloc
- [High] Kernel panic/Resource leak on driver unload if initialized without=
 component framework
- [High] Use-After-Free of devm-allocated bridges due to leakage in the glo=
bal bridge_list
- [High] Use-After-Free due to drm_dev_put() dropping the DRM device before=
 component_unbind_all() accesses it
--

--- Patch [1]: [PATCH v2] drm/meson: clean up KMS polling on register failu=
re ---
commit 86a9a25dd06d99107bc269bc3d6752c0df753219
Author: Myeonghun Pak <mhun512@gmail.com>

drm/meson: clean up KMS polling on register failure

This commit ensures that drm_kms_helper_poll_fini() is called when
drm_dev_register() fails in meson_drv_bind_master(). This stops the
KMS polling helper before the probe error path unwinds the IRQ and
frees the DRM device.

Link: https://lore.kernel.org/r/20260524160657.17802-1-mhun512@gmail.com

> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/me=
son_drv.c
> index 49ff9f1f16d32..bcc36f2cdc9a9 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -351,8 +351,10 @@ static int meson_drv_bind_master(struct device *dev,=
 bool has_components)
>  	platform_set_drvdata(pdev, priv);
> =20
>  	ret =3D drm_dev_register(drm, 0);
> -	if (ret)
> +	if (ret) {
> +		drm_kms_helper_poll_fini(drm);
>  		goto uninstall_irq;
> +	}
> =20
>  	drm_client_setup(drm, NULL);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but can this error path in
meson_drv_bind_master() trigger a NULL pointer dereference?

If devm_kzalloc() fails to allocate memory for priv, it jumps to free_drm:

drivers/gpu/drm/meson/meson_drv.c:meson_drv_bind_master() {
	...
	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
	if (!priv) {
		ret =3D -ENOMEM;
		goto free_drm;
	}
	...
}

At the free_drm label, meson_encoder_dsi_remove(priv) is called, which
immediately dereferences the NULL priv pointer:

drivers/gpu/drm/meson/meson_encoder_dsi.c:meson_encoder_dsi_remove() {
	...
	if (priv->encoders[MESON_ENC_DSI]) {
	...
}

[Severity: High]
This is a pre-existing issue, but does using devm_kzalloc() for the DRM pla=
ne
risk a use-after-free?

drivers/gpu/drm/meson/meson_plane.c:meson_plane_create() {
	...
	meson_plane =3D devm_kzalloc(priv->drm->dev, sizeof(*meson_plane),
				   GFP_KERNEL);
	...
}

Because devm_kzalloc() ties the memory lifetime to the platform device, if
the device is unbound (e.g., via sysfs) while userspace still holds a DRM
file descriptor open, devres frees the plane structure. Later, when the file
descriptor is closed, the DRM core cleans up and accesses this already-freed
structure to invoke its .destroy hook.

[Severity: High]
This isn't a bug introduced by this patch, but does the driver unload seque=
nce
leak resources if initialized without the component framework?

drivers/gpu/drm/meson/meson_drv.c:meson_drv_probe() {
	...
	if (count && !match)
		return meson_drv_bind_master(&pdev->dev, false);
	...
}

If no matching components are found, it bypasses the component framework.
However, during driver teardown, it only cleans up via the component
framework:

drivers/gpu/drm/meson/meson_drv.c:meson_drv_remove() {
	...
	component_master_del(&pdev->dev, &meson_drv_master_ops);
}

Because it was never added as a component master, meson_drv_unbind() is nev=
er
called, leaving the DRM device registered and memory allocated while the mo=
dule
is unloaded.

[Severity: High]
This is a pre-existing issue, but if drm_simple_encoder_init() fails, does =
this
leak the bridge in the global bridge_list?

drivers/gpu/drm/meson/meson_encoder_dsi.c:meson_encoder_dsi_probe() {
	...
	drm_bridge_add(&meson_encoder_dsi->bridge);

	meson_encoder_dsi->priv =3D priv;

	/* Encoder */
	ret =3D drm_simple_encoder_init(priv->drm, &meson_encoder_dsi->encoder,
				      DRM_MODE_ENCODER_DSI);
	if (ret)
		return dev_err_probe(priv->dev, ret,
				     "Failed to init DSI encoder\n");
	...
}

If drm_simple_encoder_init() fails, the function returns an error without
calling drm_bridge_remove(). Because the bridge is a devm allocation, its
memory is freed on probe failure, but a dangling pointer remains in the
global bridge_list.

[Severity: High]
This isn't a bug introduced by this patch, but can the teardown order cause=
 a
use-after-free when cleaning up components?

drivers/gpu/drm/meson/meson_drv.c:meson_drv_bind_master() {
	...
free_drm:
	drm_dev_put(drm);

	meson_encoder_dsi_remove(priv);
	meson_encoder_hdmi_remove(priv);
	meson_encoder_cvbs_remove(priv);

	if (has_components)
		component_unbind_all(dev, drm);
	...
}

The call to drm_dev_put(drm) drops the final reference and frees the drm
device. Then component_unbind_all(dev, drm) passes this newly freed drm poi=
nter
to the unbind callbacks, which may attempt to access it. This same sequence
also exists in meson_drv_unbind().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804150802.4526=
2-1-mhun512@gmail.com?part=3D1
