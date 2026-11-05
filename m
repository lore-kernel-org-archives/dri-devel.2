Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21132606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRB/VdiS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63FA310E18E;
	Thu,  5 Nov 2026 16:30:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D30410E172
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:30:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5FD31600E4
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E822D1F000C1;
 Thu,  5 Nov 2026 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793896217;
 bh=I+Ys1AM1qTB8Jm3CIcax4JWaBeoehAtXHJHdxdxv2Tg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hRB/VdiS0b+ir6gyW/h5JOyyEIrwfu1DcMIihNUwX4A8aJUb55shZ+ik7r6TPUBJK
 ceZ1LZl/vsvIEh1+luztRU+n4ZZGOMKV4nrW38wHBQfvdTboKfZ1tscvEvkb+h4BAy
 7tIZPXvBMWDRKlJa9yivJHedvyELmMLWde/R+4Vlj29WsbaThYhYmmVfQsZVIppZ2K
 WsfHtWwlNSO2vnkjvFby3soGir6TAOZIMfJt1+anXK96XUf8KgXkXp0z3RL2XmUpLG
 cTrsrvah+W+x0UrsG39pgwgmU9bo3IAVezoxTs5GSmCzU8O5Y4FtU0aKUAd0r+437s
 nYhOJiuTusrJQ==
Message-ID: <sashiko-outbox-199498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 05/83] drm/hdlcd: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-drm-no-more-config-reset-v1-5-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-5-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:30:16 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/hdlcd: invalid drm_atomic_helper_shutdown() on hdlcd_probe()=
 error path
--

commit 05385ee4b911593ec2d698a13a97eb831b545f6c
Author: Maxime Ripard <mripard@kernel.org>

drm/hdlcd: Switch to drm_mode_config_create_initial_state

This commit replaces the probe-time call to drm_mode_config_reset() in
hdlcd_probe() with drm_mode_config_create_initial_state() and jumps to
err_vblank on error.

> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_=
drv.c
> index 340b1bb38bf92..58ee8ad1d2ea6 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -318,7 +318,9 @@ static int hdlcd_probe(struct platform_device *pdev)
>  		aperture_remove_all_conflicting_devices(hdlcd_driver.name);
>  	}
> =20
> -	drm_mode_config_reset(drm);
> +	ret =3D drm_mode_config_create_initial_state(drm);
> +	if (ret)
> +		goto err_vblank;

[Severity: Medium]
If drm_mode_config_create_initial_state() fails in hdlcd_probe() in
drivers/gpu/drm/arm/hdlcd_drv.c, jumping to err_vblank disables runtime PM
and falls through to err_pm_active, which calls
drm_atomic_helper_shutdown():

err_vblank:
	pm_runtime_disable(drm->dev);
err_pm_active:
	drm_atomic_helper_shutdown(drm);

In drm_mode_config_create_initial_state(), initial state objects are
allocated sequentially for private objects, colorops, planes, CRTCs, and
connectors. If state allocation fails before or during
drm_mode_config_crtc_create_state(), hdlcd->crtc.state remains NULL.

Calling drm_atomic_helper_shutdown() then invokes:

drm_atomic_helper_shutdown()
  drm_atomic_helper_disable_all()
    drm_atomic_get_crtc_state()
      drm_atomic_helper_crtc_duplicate_state()

where drm_atomic_helper_crtc_duplicate_state() in
drivers/gpu/drm/drm_atomic_state_helper.c hits:

	if (WARN_ON(!crtc->state))
		return NULL;

Even if crtc->state was allocated and connector state allocation failed,
drm_atomic_helper_shutdown() attempts an atomic commit on partially
initialized KMS state after pm_runtime_disable() has already disabled
runtime PM (and before any modeset was committed, which also affects the
existing pm_runtime_set_active() and drm_vblank_init() error paths).

Should drm_atomic_helper_shutdown() be avoided on probe error paths where
initial KMS state creation has not completed or runtime PM is already
disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D5
