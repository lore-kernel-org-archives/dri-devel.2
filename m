Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17583C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 07:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A7710E013;
	Sat,  4 Jul 2026 07:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A2ZF8f8W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E09A10E013
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 07:12:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 640AB600AF;
 Sat,  4 Jul 2026 07:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D104B1F000E9;
 Sat,  4 Jul 2026 07:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783149137;
 bh=q8HqhBZIjhvX+DWSU/mvCT09fYJlQCkx9Wi6XzHSUPc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A2ZF8f8W+znxkCG/WBEFJXQqf2VLtjvcXzDZn1vlMhTancow1cJ/XWxVVRgAT/Num
 EIkP2R31teH8IamouyagiOyN3k5xu8NEpTKpErMJqGoyfQOas1Ac51rY7I00Mb6LNp
 aRgYrco5cC+J3fz5uIsnOPcoSOmAS0MdnAgsxTtT7O8RlFjMFWMK1n1DNPoobrDbG8
 4fScCgyTURrrAmHLl78rxIDIWLfsSUJFJyweL3DSevBUSXMItiIHvtQ5IbrGvCxj4c
 CDbNCcE1Ih06PH4cNQJWQqxnTYqr5QTL1BzLa73A4/Tq/hnXDWRP+8ldHE5uNaeG9E
 zZMHNDEGs7LYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/panel: samsung-s6d16d0: Power off on prepare
 failure
To: "Laxman Acharya Padhya" <acharyalaxman8848@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260704070648.35249-1-acharyalaxman8848@gmail.com>
References: <20260704070648.35249-1-acharyalaxman8848@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 07:12:16 +0000
Message-Id: <20260704071216.D104B1F000E9@smtp.kernel.org>
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
- [Medium] Early return in s6d16d0_unprepare() on DSI error leaks power reg=
ulator and desynchronizes DRM panel state.
--

commit e398cf036f75b574cfdb355a824bb1c7fcdb24f9
Author: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

drm/panel: samsung-s6d16d0: Power off on prepare failure

This commit fixes an issue in s6d16d0_prepare() where failing to enable
tearing mode or exiting sleep mode would return without asserting reset
or disabling the power supply. The change updates the error path to
correctly assert reset and disable the regulator before returning.

> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/=
drm/panel/panel-samsung-s6d16d0.c
> index 1b14aa4efe359..54a65abf7e890 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> @@ -88,16 +88,22 @@ static int s6d16d0_prepare(struct drm_panel *panel)

[Severity: Medium]
This is a pre-existing issue, but I noticed a similar resource leak in
s6d16d0_unprepare() located just above this function in
drivers/gpu/drm/panel/panel-samsung-s6d16d0.c.

If mipi_dsi_dcs_enter_sleep_mode() fails during display disable, the
function returns early:

static int s6d16d0_unprepare(struct drm_panel *panel)
{
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

Can this leak the regulator enable count by skipping regulator_disable()
on the error path?

Would this leave the DRM panel state machine desynchronized since the
resource cleanup is skipped?

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
> =20
>  static int s6d16d0_enable(struct drm_panel *panel)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704070648.3524=
9-1-acharyalaxman8848@gmail.com?part=3D1
