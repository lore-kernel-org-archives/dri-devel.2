Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F397C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C6610EE36;
	Tue,  7 Jul 2026 15:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BuLARFFM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DECE10EE38
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:43:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 09E3D41199;
 Tue,  7 Jul 2026 15:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97731F00A3E;
 Tue,  7 Jul 2026 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783438996;
 bh=yRYLim4gCfn1hF1+K94x1OWWXeG8MImZc9aDA0XxeC4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BuLARFFMG3/X8W5mYf7yXaudH1gFPvGjYQvjxL6ib1SmeN0BtzDowMETv39AMl7JS
 H87Md1y350VmxQD2E0F6FEDDYtiPSDZAzDjNOfkTckjg/TuKpKMBOmfH7RoGyigfG1
 /vLkKWevCd1hijhx9DQOakmIZc6MXIOr2WIZdOl97ZbRJp9+OmWMXCHaCk6okSb1g9
 7gezqAgfUGqhWOFt7JglB6eSg/yVKwzczBbYCh50WJOiFyax+BlgRV9+AUDu/gFdcS
 R2bIFpYO+4cUnU9fRflNoc+c0iu/I2h2wgBpqQDutShClHoI6OgxDZ8iPUSfYfuXqB
 iCCd67QQeme9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/xlnx/zynqmp_dpsub: remove dependency on DRM
 simple helpers
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-xlnx-simple-v1-1-df50c6665b02@gmail.com>
References: <20260707-xlnx-simple-v1-0-df50c6665b02@gmail.com>
 <20260707-xlnx-simple-v1-1-df50c6665b02@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:43:16 +0000
Message-Id: <20260707154316.B97731F00A3E@smtp.kernel.org>
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

New issues:
- [Medium] The commit message inaccurately claims the patch uses 'encoder a=
tomic helpers directly', but no atomic helpers are attached.

Pre-existing issues:
- [High] The return value of `drm_encoder_init()` is ignored, which can lea=
d to a NULL pointer dereference and kernel panic if initialization fails.
- [High] The sleeping function `msleep()` is called within the `zynqmp_dpsu=
b_crtc_atomic_enable()` callback, which executes in an atomic context path.
--

--- Patch [1]: [PATCH 1/2] drm/xlnx/zynqmp_dpsub: remove dependency on DRM =
simple helpers ---
commit 3da90995bfda87eb7ff24a962cee94ae68627efd
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/xlnx/zynqmp_dpsub: remove dependency on DRM simple helpers

Simple KMS helper are deprecated since they only add an intermediate
layer between drivers and the atomic modesetting.
This patch removes the drm_simple_encoder_init() helper usage in the
xlnx zynqmp_dpsub driver by open coding it and using the encoder atomic
helpers directly. This is a step to eventually get rid of this simple
KMS helper, once all drivers that use it have been converted.

> This patch removes the drm_simple_encoder_init() helper usage in the
> xlnx zynqmp_dpsub driver by open coding it and using the encoder atomic
> helpers directly.

[Severity: Medium]
The commit message states that the patch uses "encoder atomic helpers
directly". Is this description accurate?

The patch only defines a basic drm_encoder_funcs structure for cleanup and
does not attach any atomic helpers (e.g., via drm_encoder_helper_add()).

> diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zyn=
qmp_kms.c
> index d5f9224505655..698ac692abce9 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c

[ ... ]

> @@ -436,7 +439,8 @@ static int zynqmp_dpsub_kms_init(struct zynqmp_dpsub =
*dpsub)
> =20
>  	/* Create the encoder and attach the bridge. */
>  	encoder->possible_crtcs |=3D drm_crtc_mask(&dpsub->drm->crtc);
> -	drm_simple_encoder_init(&dpsub->drm->dev, encoder, DRM_MODE_ENCODER_NON=
E);
> +	drm_encoder_init(&dpsub->drm->dev, encoder, &zynqmp_dpsub_encoder_funcs,
> +			 DRM_MODE_ENCODER_NONE, NULL);

[Severity: High]
This is a pre-existing issue, but the return value of drm_encoder_init()
is ignored here in zynqmp_dpsub_kms_init().

If drm_encoder_init() fails, it returns an error code without fully
initializing the encoder structure, including its bridge_chain_mutex and
bridge_chain list head.=20

> =20
>  	ret =3D drm_bridge_attach(encoder, dpsub->bridge, NULL,
>  				DRM_BRIDGE_ATTACH_NO_CONNECTOR);

Because the return value is not checked, execution blindly continues to
drm_bridge_attach(), which will attempt to lock the uninitialized mutex
and call list_add() on the uninitialized list head.

Can this lead to a NULL pointer dereference and kernel panic?

While reviewing this file, I noticed another potential issue in
zynqmp_dpsub_crtc_atomic_enable():

[Severity: High]
This isn't a bug introduced by this patch, but does this code sleep in an
atomic context path?

drivers/gpu/drm/xlnx/zynqmp_kms.c:zynqmp_dpsub_crtc_atomic_enable() {
    ...
    msleep(3 * 1000 / vrefresh);
    ...
}

Calling sleeping functions like msleep() from CRTC atomic enable callbacks
can lead to kernel warnings and potential deadlocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-xlnx-simpl=
e-v1-0-df50c6665b02@gmail.com?part=3D1
