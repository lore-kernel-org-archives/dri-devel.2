Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956C9C5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A633210E6FA;
	Mon, 24 Aug 2026 10:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IkFHTkuW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF5CF10E6DA
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:30:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89E3D41342;
 Mon, 24 Aug 2026 10:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418481F000E9;
 Mon, 24 Aug 2026 10:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787567455;
 bh=2sZ1VqrgNQgzoLdNF5UlH0idYwZ/+il7ct1GbP7va4c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IkFHTkuWW3ljDo0jHRSS76Zu/XEXB6p6rcR5iUOKJWjxMqfYQ8fbAEzquK58udHxQ
 m0TB+DYE5xLotCZHAnKfECgEAy6bwPxz3aBLsHHX2hROQq2U2obgiyAj47s6SoIPgM
 dmPhzXE3+3e1l67sI4x5ClGy0vyTl82rii016rRxfpoDTkGzvwYSsWh4aVTsQqs76V
 APdE3QzGep2pbL6K7SBhMIfUPx9HJ7zdwwzndObRkRj/I1jnlkh3Gfpgo265DgAvS4
 Pdel4BMFjwx0hQIzXikvMFphYkXQCA0qdsFIMzlsdxqERCQvAQgylE4t4AcWH4fiJS
 8dIb0rpDvZJZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/rockchip: rk3066_hdmi: convert to
 devm_drm_bridge_alloc() API
To: "Johan Jonker" <jbx6244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260824-drm-v2-1-7f9273c6020b@gmail.com>
References: <20260824-drm-v2-1-7f9273c6020b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 10:30:54 +0000
Message-Id: <20260824103055.418481F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a Use-A=
fter-Free vulnerability on the error path of `rk3066_hdmi_bind()`. If `rk30=
66_hdmi_register()` fails, the code jumps to `err_disable_hclk`, skipping t=
he encoder cleanup label `err_cleanup_hdmi`. Since the DRM encoder was adde=
d to the DRM device's list during `drm_encoder_init()` but is not removed, =
and the `hdmi` struct containing the encoder is freed by devres upon bind f=
ailure, the DRM core retains a dangling pointer. This will cause a Use-Afte=
r-Free when the DRM core later iterates over the encoder list or during tea=
rdown.
--

--- Patch [1]: [PATCH v2] drm/rockchip: rk3066_hdmi: convert to devm_drm_br=
idge_alloc() API ---
commit bdad67e77f8f693946bd674b1a40ce7af3ce54c3
Author: H=C3=BCseyin BIYIK <boogiepop@gmx.com>

drm/rockchip: rk3066_hdmi: convert to devm_drm_bridge_alloc() API

This commit converts the rk3066_hdmi driver to use devm_drm_bridge_alloc()
for allocating DRM bridges. This conversion was missed during the initial
conversion of all bridges to the new API.

> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/roc=
kchip/rk3066_hdmi.c
> index f28d6a883e099..39c65ee07caac 100644
> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
[ ... ]
> @@ -747,9 +746,10 @@ static int rk3066_hdmi_bind(struct device *dev, stru=
ct device *master,
>  	int irq;
>  	int ret;
> =20
> -	hdmi =3D devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
> -	if (!hdmi)
> -		return -ENOMEM;
> +	hdmi =3D devm_drm_bridge_alloc(dev, struct rk3066_hdmi, bridge,
> +				     &rk3066_hdmi_bridge_funcs);
> +	if (IS_ERR(hdmi))
> +		return PTR_ERR(hdmi);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the
allocation of the hdmi struct in rk3066_hdmi_bind() inside
drivers/gpu/drm/rockchip/rk3066_hdmi.c, I noticed a potential
use-after-free on the error path.

If rk3066_hdmi_register() fails after drm_encoder_init() has been called,
the error path in rk3066_hdmi_bind() jumps to err_disable_hclk:

	ret =3D rk3066_hdmi_register(drm, hdmi);
	if (ret)
		goto err_disable_hclk;

This bypasses the err_cleanup_hdmi label which destroys the encoder:

err_cleanup_hdmi:
	hdmi->encoder.encoder.funcs->destroy(&hdmi->encoder.encoder);
err_disable_hclk:
	clk_disable_unprepare(hdmi->hclk);

Since the encoder was added to the DRM device's internal lists during
drm_encoder_init(), and the devm-allocated hdmi struct will be freed when
rk3066_hdmi_bind() returns an error, does this leave a dangling pointer in
the DRM core that will cause a use-after-free when the list is iterated or
torn down?

> =20
>  	hdmi->dev =3D dev;
>  	hdmi->drm_dev =3D drm;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-drm-v2-1-7=
f9273c6020b@gmail.com?part=3D1
