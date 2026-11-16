Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814A608118A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVbb3gXn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6ABA10EF66;
	Mon, 16 Nov 2026 11:10:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306DC10EF66
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:10:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6880455EA
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2761F000C6;
 Mon, 16 Nov 2026 11:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794827408;
 bh=Wet0LUa+OoAdP//pFP7NlgVLjZX3JFfPIGeJIg8y5Fc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cVbb3gXn+5u0Dnlxx1NxqYrPuSWm28Kzj1ALRT7F8yn89SQA16aBAFGB0oQ6HDZED
 aZvJl+TeLks+npVRsnMhDYA9QcAer1Wx1x+XkfiDNKKxaC6XpgVvxTiM8746eocIIT
 uYyPf1KGdsXYYZhY9Tpu4AAPm9PYLIYx7n7kT0uE7V/fGn+9TPBbsLwLAxCTkX5bMT
 QXecE8QIqMe3xkTwC3P1+0LIMAm+C2j1Ye8cYlYBOQjRMnlw5XL1dWbw1oPkeOb8E0
 6SSfAafNhSQykIa0DJLh92leTzciGK3zuZfqBzE2N8X15INrs6aoNOuqFPkBzeUhpv
 MjL3lIdp/EoQw==
Message-ID: <sashiko-outbox-216850@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 43/64] drm/tilcdc: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-drm-no-more-config-reset-v2-43-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-43-0bb471f4d1e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:10:08 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/tilcdc: tilcdc_pdev_probe() skips tilcdc_crtc_hw_reset()
--

commit ae76397fb05d05122d64d74fa8d16d0b22b1c809
Author: Maxime Ripard <mripard@kernel.org>

drm/tilcdc: Switch to drm_mode_config_create_initial_state

This commit replaces drm_mode_config_reset() with
drm_mode_config_create_initial_state() in tilcdc_pdev_probe() to initialize
the KMS state at probe time.

> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc=
/tilcdc_drv.c
> index 1d6c9a423a410..da718d9cb1d69 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -422,7 +422,9 @@ static int tilcdc_pdev_probe(struct platform_device *=
pdev)
>  		goto unregister_cpufreq_notif;
>  	}
> =20
> -	drm_mode_config_reset(ddev);
> +	ret =3D drm_mode_config_create_initial_state(ddev);
> +	if (ret)
> +		goto stop_poll;

[Severity: High]
Does replacing drm_mode_config_reset() with
drm_mode_config_create_initial_state() skip tilcdc_crtc_hw_reset() during
probe?

tilcdc_crtc_hw_reset() is wired to drm_crtc_helper_funcs.hw_reset to turn o=
ff
LCDC_RASTER_ENABLE and wait for LCDC_FRAME_DONE when the bootloader leaves
the display controller active at boot, as introduced in 46a956ab3c5b
("drm/tilcdc: Turn raster off in crtc reset, if it was on in the HW") and
6e531fda1d6b ("drm/tilcdc: Move hardware reset to hw_reset hook").

Because drm_mode_config_create_initial_state() calls
drm_mode_config_crtc_create_state() without invoking helper_funcs->hw_reset,
hardware scanout stays enabled while the initial CRTC state is marked
disabled, causing the first modeset in tilcdc_crtc_enable() to reprogram
timings and DMA addresses while the raster is still running and time out
loading the palette.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-drm-no-mor=
e-config-reset-v2-0-0bb471f4d1e0@kernel.org?part=3D43
