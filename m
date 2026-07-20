Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294B9C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 606D710E9AA;
	Mon, 20 Jul 2026 15:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h1sF0eU/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7681610E9AA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:50:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B072960A5C;
 Mon, 20 Jul 2026 15:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC5D1F000E9;
 Mon, 20 Jul 2026 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784562656;
 bh=qJQU5tT4gBWPtLIh3ibKXTeM8itlzBuYVgP05V0atv8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h1sF0eU/to38WbjOxI4rKStfKZXgTUuGYSwOT/8ZSG4nslE/0S+ZLaTo36X6bXpjD
 muMARxPlmMavvJjYjkgQ1M/uhyphfqBE0zMf8YFeegyRUqiquY/0U0e6WkCwjzJtyf
 dM+mhK7oaVL0Gy+DuuO2lJiHFewqWHSfTAS5GI2VOA9c73DO+UHCmtySNths9ioBTn
 XqWm3ipLKW9CDiWc8gfQUm3eR3kBnCzkoLbgoUxVCM6SA5Il6EJoqU1nNI7GAzIDTa
 s2gTDvG4zU5P4O1BOhIXvrIhre9Q0RFAeNxtRFj7UTrrHwPtREOL8XftS1H7aSN6b1
 nOBItbX9MYvbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/15] drm/hisilicon/kirin: remove dependency on DRM
 simple helpers
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-amlogic@lists.infradead.org, wsa+renesas@sang-engineering.com,
 neil.armstrong@linaro.org
In-Reply-To: <20260720-drm_simple_encoder_init-v2-11-5020b630668a@gmail.com>
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
 <20260720-drm_simple_encoder_init-v2-11-5020b630668a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:50:55 +0000
Message-Id: <20260720155055.EEC5D1F000E9@smtp.kernel.org>
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
- [Critical] The `dsi_data` structure, which embeds the `drm_encoder` objec=
t via `dw_dsi`, is allocated using `devm_kzalloc`. This violates DRM lifeti=
me rules and leads to a use-after-free when the platform device unbinds.
--

--- Patch [11]: [PATCH v2 11/15] drm/hisilicon/kirin: remove dependency on =
DRM simple helpers ---
commit b9a0117f6ac1e860030dfb53be58e44730659ad8
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/hisilicon/kirin: remove dependency on DRM simple helpers

This patch removes the deprecated simple KMS helpers by open-coding
drm_simple_encoder_init() to call drm_encoder_init() directly and
providing driver-local drm_encoder_funcs.

> diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/d=
rm/hisilicon/kirin/dw_drm_dsi.c
> index 15042365dec00..62c5bd3277da1 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c

[ ... ]

> @@ -687,6 +687,10 @@ static int dsi_encoder_atomic_check(struct drm_encod=
er *encoder,
>  	return 0;
>  }
> =20
> +static const struct drm_encoder_funcs dw_encoder_funcs =3D {
> +	.destroy =3D drm_encoder_cleanup,

[Severity: Critical]
This is a pre-existing issue, but could this setup lead to a use-after-free
when the platform device unbinds?

The encoder is embedded in the dsi_data structure, which is allocated
using devm_kzalloc() in dsi_probe():

drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c:dsi_probe() {
    ...
    data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
    ...
}

If userspace holds an open file descriptor when the platform device unbinds,
the DRM device and its mode objects will outlive the platform device. The
devres cleanup will free the dsi_data memory, but the DRM device will still
hold a pointer to the encoder in its internal lists.

When the DRM device is finally released, drm_mode_config_cleanup() will
iterate over its encoder list and invoke this .destroy callback
(drm_encoder_cleanup) on the already-freed memory.

Since you are refactoring the encoder initialization here, would this be a
good time to transition to drmm_encoder_alloc() or drmm_kzalloc() to tie the
allocation lifetime to the DRM device instead of the platform device?

> +};
> +
>  static const struct drm_encoder_helper_funcs dw_encoder_helper_funcs =3D=
 {
>  	.atomic_check	=3D dsi_encoder_atomic_check,
>  	.mode_valid	=3D dsi_encoder_mode_valid,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-drm_simple=
_encoder_init-v2-0-5020b630668a@gmail.com?part=3D11
