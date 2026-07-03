Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C35FC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B6C10E63D;
	Fri,  3 Jul 2026 17:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NTql2rRO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF0C10E63D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 17:06:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 441A56014B;
 Fri,  3 Jul 2026 17:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6C31F000E9;
 Fri,  3 Jul 2026 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783098377;
 bh=Sq/FLPEf5IujXj3xKNTAIdqqvDlukdn5odMcsc08vfM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NTql2rROlNEu0l8XC0pJqqfxy+Uiyau58BldAN5HOEkJWDE3Bif/3aM5adqrMSdZy
 MkDOBcwj9cEx8nb8xrcRIaj766jiIBR/QmTd5IfLh40KUcAFVfyawQtzNG870Yoppj
 H5FhCMyKzWvkWqJdKmfP2S4ZKryrgsAgVCth5jHD43sToWR2cTVu0O9jXPxzh/r1gQ
 vgMee15NcwCIcHBYpggAXmIGJCJHUfuIW8ymgcboUztU+0DjJsMT/hr30ihWWlTA+o
 vb2hZ2uYXoknRvEMyXQPe4LmNSEcCDosxKGiuhP9e6Dv8trL8fUTVio7RIwWHZTlUr
 kZnrg11zW4kGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/panel: samsung-s6d16d0: Power off on prepare
 failure
To: "Laxman Acharya Padhya" <acharyalaxman8848@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703165632.27027-1-acharyalaxman8848@gmail.com>
References: <20260703165632.27027-1-acharyalaxman8848@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 17:06:16 +0000
Message-Id: <20260703170616.CD6C31F000E9@smtp.kernel.org>
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
- [High] Early returns on DSI command failures in teardown functions (`s6d1=
6d0_unprepare` and `s6d16d0_disable`) bypass hardware power-off and cause D=
RM state machine desynchronization.
--

commit 5d36b39e4bbd28714a2875efbe7aa78f7026a69d
Author: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

drm/panel: samsung-s6d16d0: Power off on prepare failure

If enabling tearing mode or exiting sleep mode fails after the
regulator is enabled, s6d16d0_prepare() returns without asserting
reset or disabling the supply. Since the DRM panel core leaves the
panel unprepared, a later unprepare call skips the driver callback
and the supply remains enabled.

Assert reset and disable the supply before returning the DSI command error.

> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/=
drm/panel/panel-samsung-s6d16d0.c
> index ba1a02000bb9d..04e19b5f22f8b 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> @@ -89,16 +89,22 @@ static int s6d16d0_prepare(struct drm_panel *panel)
>  				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
>  	if (ret) {
>  		dev_err(s6->dev, "failed to enable vblank TE (%d)\n", ret);
> -		return ret;
> +		goto err_power_off;
>  	}
>  	/* Exit sleep mode and power on */
>  	ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
>  	if (ret) {
>  		dev_err(s6->dev, "failed to exit sleep mode (%d)\n", ret);
> -		return ret;
> +		goto err_power_off;
>  	}
> =20
>  	return 0;
> +
> +err_power_off:
> +	gpiod_set_value_cansleep(s6->reset_gpio, 1);
> +	regulator_disable(s6->supply);
> +
> +	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but since this patch fixes the error path in
s6d16d0_prepare(), does the same early return problem exist in
s6d16d0_unprepare() and s6d16d0_disable()?

Looking at s6d16d0_unprepare(), if mipi_dsi_dcs_enter_sleep_mode() fails,
it returns early:

drivers/gpu/drm/panel/panel-samsung-s6d16d0.c:s6d16d0_unprepare() {
    ...
	ret =3D mipi_dsi_dcs_enter_sleep_mode(dsi);
	if (ret) {
		dev_err(s6->dev, "failed to enter sleep mode (%d)\n", ret);
		return ret;
	}

	/* Assert RESET */
	gpiod_set_value_cansleep(s6->reset_gpio, 1);
	regulator_disable(s6->supply);

	return 0;
}

Can this early return bypass regulator_disable(), leaving the regulator
permanently enabled?

Furthermore, because these functions return an error, the DRM core skips
updating the panel state.=20

Similarly, if mipi_dsi_dcs_set_display_off() fails in s6d16d0_disable():

drivers/gpu/drm/panel/panel-samsung-s6d16d0.c:s6d16d0_disable() {
    ...
	ret =3D mipi_dsi_dcs_set_display_off(dsi);
	if (ret) {
		dev_err(s6->dev, "failed to turn display off (%d)\n", ret);
		return ret;
	}
    ...
}

Will the early error return in both of these teardown functions cause a
permanent desynchronization between the panel and the DRM state machine,
where subsequent attempts to enable the panel skip the prepare and enable
callbacks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703165632.2702=
7-1-acharyalaxman8848@gmail.com?part=3D1
