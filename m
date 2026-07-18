Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178F9C44521
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 23:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A28110E61D;
	Sat, 18 Jul 2026 23:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TU2/0IaU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A529510E61D
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 23:54:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EF4760008;
 Sat, 18 Jul 2026 23:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5664F1F000E9;
 Sat, 18 Jul 2026 23:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784418880;
 bh=nHUy++hDRX3zDmfeKYf9s2cnoNqoIu2sJqwOijvW2f4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TU2/0IaU8zD0v85PljVEtfywQY4KiZ1DQDKVaQBmTPPKH7JnlKNg9dVti5XcizzRE
 ATUVK4n59C1hrUqp7okt0VDtvKMAIxfjprkkdrp0CjYJqA/waON5y8zpWlu3b4sASf
 tsa96v1wORx8aVOv8UM242iQ5juDZ87YdoCCeZWpWkLT+0dZJh3B/bGUNWgljlKFNB
 2ExPbKn8ezpakLXBZp1ZiujKKrPNHm/KOrapof4Iy7Rjbw4tkHh20R/gPWsgDX4zeA
 iPKMkyMSR0VS6md2HjRGFIYqqZrmuvJblDjvmJgubxRhiY8ePcujv9QTBN11kySZfK
 QB7Hl+ebbJqfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/15] drm/tidss: remove dependency on DRM simple helpers
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com, imx@lists.linux.dev, Frank.Li@kernel.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260719-drm_simple_encoder_init-v1-7-a78c509e3062@gmail.com>
References: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
 <20260719-drm_simple_encoder_init-v1-7-a78c509e3062@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 23:54:39 +0000
Message-Id: <20260718235440.5664F1F000E9@smtp.kernel.org>
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
- [High] Use-After-Free during teardown due to object lifetime mismatch bet=
ween `drm_bridge` and `drm_encoder`.
--

--- Patch [7]: [PATCH 07/15] drm/tidss: remove dependency on DRM simple hel=
pers ---
commit e6abfa8d59d485697fcfe2a3a199e7f378a7e23a
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/tidss: remove dependency on DRM simple helpers

The patch removes the deprecated simple KMS helpers from the tidss driver.
It replaces drm_simple_encoder_init() with a direct call to
drm_encoder_init(), providing driver-local drm_encoder_funcs to handle
cleanup.

> diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tids=
s/tidss_encoder.c
> index 698f8d964ca00..10dbcc6cdf6a8 100644
> --- a/drivers/gpu/drm/tidss/tidss_encoder.c
> +++ b/drivers/gpu/drm/tidss/tidss_encoder.c
[ ... ]
> @@ -81,6 +81,10 @@ static const struct drm_bridge_funcs tidss_bridge_func=
s =3D {
>  	.atomic_destroy_state		=3D drm_atomic_helper_bridge_destroy_state,
>  };
> =20
> +static const struct drm_encoder_funcs tidss_encoder_funcs =3D {
> +	.destroy =3D drm_encoder_cleanup,
> +};
> +
>  int tidss_encoder_create(struct tidss_device *tidss,
>  			 struct drm_bridge *next_bridge,
>  			 u32 encoder_type, u32 possible_crtcs)
> @@ -95,8 +99,8 @@ int tidss_encoder_create(struct tidss_device *tidss,
>  	if (IS_ERR(t_enc))
>  		return PTR_ERR(t_enc);
> =20
> -	ret =3D drm_simple_encoder_init(&tidss->ddev, &t_enc->encoder,
> -				      encoder_type);
> +	ret =3D drm_encoder_init(&tidss->ddev, &t_enc->encoder,
> +			       &tidss_encoder_funcs, encoder_type, NULL);

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free during
teardown due to mismatched object lifetimes?

In tidss_encoder_create(), the t_enc structure is allocated via
devm_drm_bridge_alloc(), which ties the memory's lifetime to the bridge's
kref.

Then the embedded encoder is initialized here and its destroy callback is s=
et
to drm_encoder_cleanup() in tidss_encoder_funcs.

If the driver unbinds while a userspace application holds a DRM file
descriptor, devm drops the initial bridge references. Later, when the final
DRM reference is dropped, drm_mode_config_cleanup() calls the encoder's
destroy callback.

Inside drm_encoder_cleanup(), it detaches the bridge. This drops the final
kref and frees the t_enc container. However, drm_encoder_cleanup() then
continues to access the freed encoder memory, causing a use-after-free.

Does this sequence cause memory corruption during teardown?

>  	if (ret)
>  		return ret;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719-drm_simple=
_encoder_init-v1-0-a78c509e3062@gmail.com?part=3D7
