Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E636C88E7F
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D78610E743;
	Wed, 16 Sep 2026 17:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ll6H4fbz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B1D10ECF0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 17:57:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 47A9A601FD;
 Wed, 16 Sep 2026 17:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32161F000FF;
 Wed, 16 Sep 2026 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789581423;
 bh=Rxf52q7m0XLLaGWl95zuXypp2FtwcdsJBVE4lvNVpCw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ll6H4fbznSI7mNLP1pLgKpFGoUnNVytKimGf/ORTpIx5kyOXc9nhP68m4+k766wMD
 9mHP+E1CA25rsjH47vXpij+1LWNaMjLis9cCM34zmqcmeo5jCCaa7MH+SveIdWUSrH
 wTm6ZujhmJPrtFxPKDNkjtaunKcjo1fx3Sy5bbLDBGjKQJ6mPLE909unDz9fJ9MXmu
 K07+wpBS1TMePRdP0tneIz70+IbGUiqn1rSMetsIWOgyBC3HboGPRrEk7CHzOseEzQ
 KAqdOd/UHrsoVCHB0MluQ5WkXP235WMSJgRT+yReaRiIL3w8Wkx5y0j43OfVs0al65
 b3mx1fRw3dbXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/meson: Fix next_bridge reference leak in
 meson_encoder_dsi_probe()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260916174543.2089062-1-vulab@iscas.ac.cn>
References: <20260916174543.2089062-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 17:57:02 +0000
Message-Id: <20260916175702.B32161F000FF@smtp.kernel.org>
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
- [Medium] drm/meson: incorrect fix creates latent double-put of next_bridge
--

commit 3ff757ce4681fc8ee49157913542af343fd3e021
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/meson: Fix next_bridge reference leak in meson_encoder_dsi_probe()

The commit attempts to fix a reference leak on the next bridge by manually
calling drm_bridge_put() on error paths when drm_simple_encoder_init()
or drm_bridge_attach() fails.

> diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/=
meson/meson_encoder_dsi.c
> index 3e422b612f74b..4367145d37753 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> @@ -135,17 +135,21 @@ int meson_encoder_dsi_probe(struct meson_drm *priv)
>  	/* Encoder */
>  	ret =3D drm_simple_encoder_init(priv->drm, &meson_encoder_dsi->encoder,
>  				      DRM_MODE_ENCODER_DSI);
> -	if (ret)
> +	if (ret) {
> +		drm_bridge_put(meson_encoder_dsi->bridge.next_bridge);

[Severity: Medium]
Does this manual put incorrectly circumvent the bridge lifecycle API instead
of properly removing the main bridge?

The correct way to manage this reference is via the main bridge's lifecycle,
as __drm_bridge_free() automatically drops the next_bridge reference when t=
he
main bridge is freed. Because the patch neglects to call drm_bridge_remove()
for the main bridge (which is why next_bridge was leaking in the first plac=
e),
the main bridge is left leaking in the global bridge_list.

If the main bridge leak is ever properly fixed in the future (e.g., by addi=
ng
drm_bridge_remove() or using devm_drm_bridge_add()), the manual
drm_bridge_put() introduced here will result in a double-put and
use-after-free.

>  		return dev_err_probe(priv->dev, ret,
>  				     "Failed to init DSI encoder\n");
> +	}
> =20
>  	meson_encoder_dsi->encoder.possible_crtcs =3D BIT(0);
> =20
>  	/* Attach DSI Encoder Bridge to Encoder */
>  	ret =3D drm_bridge_attach(&meson_encoder_dsi->encoder, &meson_encoder_d=
si->bridge, NULL, 0);
> -	if (ret)
> +	if (ret) {
> +		drm_bridge_put(meson_encoder_dsi->bridge.next_bridge);

[Severity: Medium]
Can this second manual cleanup also act as a latent double-put trap?

This applies the same incorrect manual cleanup on the second error path.

>  		return dev_err_probe(priv->dev, ret,
>  				     "Failed to attach bridge\n");
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916174543.2089=
062-1-vulab@iscas.ac.cn?part=3D1
