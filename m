Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD08C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0105110E9D1;
	Mon, 20 Jul 2026 16:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dt9TPmxz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A742310E9D1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 16:08:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FE0941B0A;
 Mon, 20 Jul 2026 16:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3311F000E9;
 Mon, 20 Jul 2026 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784563714;
 bh=9KrDL8WVRykRNu0EQzamEj6Vx3hZLwfviLgeAZ2Q/J0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dt9TPmxzdzl8Hq/nfOa3hH2HizLmhwCwmeBMcDGIvwGxdrRXIdqqOyLqyHXrMuPm3
 XS6aNl53STL8Ioyfc2oczocKjyHgZylMIfCEO6GKyAUY9ThGrqxvwWqjt0iguPtugz
 oQDczUi/99qQbh+PBU0t/8WqcEkIIlu427lZzD8yib2DT5w7Brl/ntb2FRb8fhzRCZ
 6WZca3vlz4dEMpoc74ngnl3Uv5zOxPcQn7ao/EdshKtZgPn0KaRG6YZjpiQfZ6DSh2
 mov3C1s4SrTufUBBmavRqjxHdsGH6UPHovayAZKP5licQDAzA4ill6rUHxrI6XH8Mf
 XkayUWLC5+3FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/15] drm/tidss: remove dependency on DRM simple
 helpers
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: Frank.Li@kernel.org, linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
 wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260720-drm_simple_encoder_init-v2-7-5020b630668a@gmail.com>
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
 <20260720-drm_simple_encoder_init-v2-7-5020b630668a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 16:08:33 +0000
Message-Id: <20260720160833.BD3311F000E9@smtp.kernel.org>
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
- [High] Missing drm_encoder_cleanup() on error paths causes an immediate U=
se-After-Free during probe failure due to devm/drmm lifecycle mismatch.
--

--- Patch [7]: [PATCH v2 07/15] drm/tidss: remove dependency on DRM simple =
helpers ---
commit e1bc7736cc3d912bd63a6e7abbb830479e2c82e1
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/tidss: remove dependency on DRM simple helpers

The simple KMS helpers are deprecated because they only add an
intermediate layer between drivers and atomic modesetting. This commit
open-codes drm_simple_encoder_init() by calling drm_encoder_init()
directly and providing driver-local drm_encoder_funcs.

> diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tids=
s/tidss_encoder.c
> index 698f8d964ca00..10dbcc6cdf6a8 100644
> --- a/drivers/gpu/drm/tidss/tidss_encoder.c
> +++ b/drivers/gpu/drm/tidss/tidss_encoder.c
[ ... ]
> @@ -95,8 +99,8 @@ int tidss_encoder_create(struct tidss_device *tidss,
>  	if (IS_ERR(t_enc))
>  		return PTR_ERR(t_enc);
> =20
> -	ret =3D drm_simple_encoder_init(&tidss->ddev, &t_enc->encoder,
> -				      encoder_type);
> +	ret =3D drm_encoder_init(&tidss->ddev, &t_enc->encoder,
> +			       &tidss_encoder_funcs, encoder_type, NULL);
>  	if (ret)
>  		return ret;
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does this function leak the
initialized encoder into the global mode_config list on subsequent error
paths?

If drm_bridge_attach() or drm_bridge_connector_init() fails later in this
function, they return an error directly without cleaning up the initialized
DRM encoder:

	ret =3D drm_bridge_attach(enc, &t_enc->bridge, NULL,
				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
	if (ret) {
		dev_err(tidss->dev, "bridge attach failed: %d\n", ret);
		return ret;
	}

Because t_enc is allocated via devm_drm_bridge_alloc(), devres frees t_enc
as soon as probe fails. The DRM device itself is also devres-managed, so
its cleanup runs after t_enc is freed.

When drm_mode_config_cleanup() iterates over the encoder_list and calls the
.destroy hook on the now-freed t_enc->encoder, will this trigger a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-drm_simple=
_encoder_init-v2-0-5020b630668a@gmail.com?part=3D7
