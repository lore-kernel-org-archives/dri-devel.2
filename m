Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91E8C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4A710E5CC;
	Mon, 13 Jul 2026 12:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="borrz59b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B9710E5CC
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:57:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B79586004E;
 Mon, 13 Jul 2026 12:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D37E1F000E9;
 Mon, 13 Jul 2026 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783947467;
 bh=LXkjJI9vh5y8xghzOW/1LY+U/IXCxqWQ+8+1mMwySWE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=borrz59bJzOaq9vHbkVopd7u7H2Z6UBHkas+me3Tm+BuPyVDWtcuxMxpjIar+5fo3
 NJA1TGBMrJug5Tas+7PujMNjdgVkz3eg4HTdNTQw1WE1cXQ8MIqfoi6D7YOcvFq2y6
 TY49a62eyTholRCGW1K6Nt3T/wBd6v+1tbtpUbxT5p3fStFR8Wi50jOOfm7rkLNW4D
 ukE+konvNb4swrQEQ1NHPMKIn2y28wkDhiQ1w24vKZZZYlfsYBhbe7aCpn4RUwaIIp
 nUrrULI91j/+mjnPVLS64hpmyu6UOj/uPuFEviMaxmi85yWdBSViK43NeNWxMSgJ7g
 vchYCvh0pTwpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 19/19] gpu: drm: meson: Fix DMA segment size limits
 and maximize allocation boundaries
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260713120840.17427-20-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-20-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:57:46 +0000
Message-Id: <20260713125747.2D37E1F000E9@smtp.kernel.org>
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

New issues:
- [High] Uninitialized pointer dereference in the error handling path of `m=
eson_drv_bind_master`.

Pre-existing issues:
- [High] NULL pointer dereference when `devm_kzalloc` fails to allocate the=
 `priv` structure.
--

--- Patch [19]: [PATCH v7 19/19] gpu: drm: meson: Fix DMA segment size limi=
ts and maximize allocation boundaries ---
commit 5509f37f742bf971664f2f0e723c6187dedff8d4
Author: Anand Moon <linux.amoon@gmail.com>

gpu: drm: meson: Fix DMA segment size limits and maximize allocation bounda=
ries

This commit addresses DMA layout configuration constraints by setting a 32-=
bit
coherent DMA allocation window and maximizing the scatter-gather allocation
segment boundary check constraint.

> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/me=
son_drv.c
> index 49ff9f1f16d32..899e70bca4ce2 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -202,6 +202,12 @@ static int meson_drv_bind_master(struct device *dev,=
 bool has_components)
>  	if (IS_ERR(drm))
>  		return PTR_ERR(drm);
> =20
> +	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		goto free_drm;

[Severity: High]
If dma_set_mask_and_coherent() fails in meson_drv_bind_master(), the code j=
umps
to the free_drm error path before the priv pointer is allocated and initial=
ized.

Because the free_drm label unconditionally passes priv to encoder removal
functions:

drivers/gpu/drm/meson/meson_drv.c:meson_drv_bind_master() {
...
free_drm:
	drm_dev_put(drm);

	meson_encoder_dsi_remove(priv);
...
}

And meson_encoder_dsi_remove() dereferences priv immediately:

drivers/gpu/drm/meson/meson_encoder_dsi.c:meson_encoder_dsi_remove() {
...
	if (priv->encoders[MESON_ENC_DSI]) {
...
}

Will this result in dereferencing an uninitialized stack pointer?

> +
> +	dma_set_max_seg_size(dev, UINT_MAX);
> +
>  	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv) {
>  		ret =3D -ENOMEM;
>  		goto free_drm;

[Severity: High]
This is a pre-existing issue, but if devm_kzalloc() in meson_drv_bind_maste=
r()
fails to allocate priv, it will be set to NULL and the code jumps to free_d=
rm.

Similar to the above issue, this will pass a NULL priv pointer to
meson_encoder_dsi_remove(), which does not check for NULL before dereferenc=
ing
it:

drivers/gpu/drm/meson/meson_encoder_dsi.c:meson_encoder_dsi_remove() {
...
	if (priv->encoders[MESON_ENC_DSI]) {
...
}

Will this cause a NULL pointer dereference during an out-of-memory conditio=
n?

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D19
