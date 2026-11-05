Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC5606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efWvzxxz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7810910E2F9;
	Thu,  5 Nov 2026 20:15:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93CDE10E2F9
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:15:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34C8D422C3
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CC71F0089F;
 Thu,  5 Nov 2026 20:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793909715;
 bh=J+w9igy4IpsYU/i26Vt1umv6eyoro6OGd2vf+at2hsQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=efWvzxxzzk+Ixdi6eDo6Axew5Xa2mm3agwf5BIZICqq5SsmrMKqnoxHMNKFX8FWGC
 ZjP5yi6QWNBASTExPDsFXTjfEOvCeOrQRG5YY0qEfgJrf/Rx1/xnUM9IhnLLSfK2tM
 M5PQ2aIewZ2TqibrjwpOM/cUP3fCcr/lhoOjdEIYXLWogv87VMsKKOLfQKhCBZi1eV
 qwjBsBi3wUBqodzv47oPdaEitKQwbAezAba+syEfxnGN/SYQPgqmYEkHDy+DLPKKMu
 axR1w36W0jyazfGv4sLQAVyvfTHdFbsREreOhqJqia2YryfenZH8fU0mJvyihfQHsg
 AvvHjqeELLI2Q==
Message-ID: <sashiko-outbox-200087@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 46/83] drm/stm: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-drm-no-more-config-reset-v1-46-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-46-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:15:14 +0000
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
- [Medium] drm/stm: missing ltdc_unload() on initial state failure in drv_l=
oad()
--

commit 98591c9473b768ebdd97e226182eb80066137927
Author: Maxime Ripard <mripard@kernel.org>

drm/stm: Switch to drm_mode_config_create_initial_state

This commit replaces the probe-time drm_mode_config_reset() call in drv_loa=
d()
with drm_mode_config_create_initial_state() and propagates any error return=
ed
during initial KMS state creation.

> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> index 0967b9b3451db..60343ffe02f7d 100644
> --- a/drivers/gpu/drm/stm/drv.c
> +++ b/drivers/gpu/drm/stm/drv.c
> @@ -104,7 +104,9 @@ static int drv_load(struct drm_device *ddev)
>  	if (ret)
>  		return ret;
> =20
> -	drm_mode_config_reset(ddev);
> +	ret =3D drm_mode_config_create_initial_state(ddev);
> +	if (ret)
> +		return ret;

[Severity: Medium]
If drm_mode_config_create_initial_state() fails in drv_load() after
ltdc_load() has already succeeded, does this leave runtime PM enabled on
ddev->dev without calling ltdc_unload()?

In drivers/gpu/drm/stm/ltdc.c, ltdc_load() enables runtime PM via an
unmanaged call before returning:

ltdc_load()
	pm_runtime_enable(ddev->dev);
	return 0;

When drv_load() returns an error, stm_drm_platform_probe() in
drivers/gpu/drm/stm/drv.c jumps to err_put, bypassing drv_unload() and
ltdc_unload():

stm_drm_platform_probe()
	ret =3D drv_load(ddev);
	if (ret)
		goto err_put;

	ret =3D drm_dev_register(ddev, 0);
	if (ret)
		goto err_unload;
	...
err_unload:
	drv_unload(ddev);
err_put:
	drm_dev_put(ddev);

Because platform_set_drvdata() is not reached in drv_load() on this failure
path and runtime PM remains enabled while ddev is freed, a runtime PM callb=
ack
running before unbind completes could also see a NULL ddev from
dev_get_drvdata(dev) in drv_runtime_suspend() or drv_runtime_resume().

Should drv_load() call ltdc_unload(ddev) on error if
drm_mode_config_create_initial_state() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D46
