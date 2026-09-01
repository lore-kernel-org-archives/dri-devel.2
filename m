Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA53DC624D4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E08DC10E3C1;
	Tue,  1 Sep 2026 14:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AOVCwMSL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C560C10E3C1
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 14:23:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62BEB40F89;
 Tue,  1 Sep 2026 14:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255B21F000E9;
 Tue,  1 Sep 2026 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788272587;
 bh=JuV5nrZ31qXqLxwRP4sRV2gbfpCRqD1YBqmVr32CtQU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AOVCwMSLlymQWpds9zrYs7BtcljBp5aCsPjDB2KGld1mXjrnJLxMCbniPNIr9hvL3
 mtsV8xBekTJB7385dABMno0h87uKcz1SMoIEgkye0piaKHlCRzepVxBmUR4ki9sgsv
 KPU1YcUKkALqSzVdtxte8RHDIeRoBhHdiel2UGqhQL3zJIO8wNFqxibrcuzHSk/BUY
 NL+YdjT8CJ0PCWnI9NYmvZepy54tm1APv2I3cCuSz9Tb3fJAB1kqiNTIGfa4cBiItV
 Y03FBLqR27S5e/F6JQ53uVTUKVqeEZsbyZlmzvQ44IIF01+wm+j5ObA8tda25QiGKI
 yzXak88Me9Scg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: use linear backlight curve on Linux
To: "Aarav Kumar" <aarav.240604@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901140155.19129-1-aarav.240604@gmail.com>
References: <20260901140155.19129-1-aarav.240604@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 14:23:06 +0000
Message-Id: <20260901142307.255B21F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Enabling use_linear_backlight_curve creates an asymmetry between t=
he backlight set and get operations, breaking readbacks.

Pre-existing issues:
- [High] Incorrect millipercent calculation adds the minimum brightness off=
set twice, artificially doubling the minimum backlight level.
--

commit d81c87ee8304f9423dd46886dacd5118c129a998
Author: Aarav Kumar <aarav.240604@gmail.com>

drm/amd/display: use linear backlight curve on Linux

This commit switches the power module to use a linear backlight curve
on Linux to preserve the existing brightness-to-PWM mapping. This fixes
incorrect brightness levels observed on affected systems.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5723

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index eb00c62c6f724..1ba74924859dc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -418,7 +418,7 @@ static int amdgpu_dm_init_power_module(struct amdgpu_=
display_manager *dm)
>  			!(amdgpu_dc_feature_mask & DC_DISABLE_FRACTIONAL_PWM_MASK);
>  		init_data[i].use_custom_backlight_caps =3D false;
>  		init_data[i].custom_backlight_caps_config_no =3D 0;
> -		init_data[i].use_linear_backlight_curve =3D false;
> +		init_data[i].use_linear_backlight_curve =3D true;

[Severity: High]
Does enabling this flag create an asymmetry between the backlight set and g=
et
operations?

When the write path uses the linear curve, the read path in
backlight_pwm_to_millipercent_legacy() in power_abm.c lacks support for this
flag and unconditionally performs a binary search on the non-linear ACPI LU=
T.

Can this cause sysfs readbacks to return incorrect values?

[Severity: High]
This isn't a bug introduced by this patch, but using the linear curve stric=
tly
exposes an issue in the millipercent calculation in
amdgpu_dm_backlight_set_level() in amdgpu_dm_backlight.c.

In amdgpu_dm_backlight_set_level():

	brightness =3D convert_brightness_from_user(caps, dm->brightness[bl_idx]);
	...
	get_brightness_range(caps, &min, &max);
	brightness =3D DIV_ROUND_CLOSEST(brightness * 100, (max - min)) * 1000;

Since convert_brightness_from_user() returns an absolute value scaled betwe=
en
min and max, computing the percentage without subtracting min first causes =
the
millipercent value to already contain the minimum offset.

When this is passed to backlight_millipercent_to_pwm_legacy(), which comput=
es:

	min_backlight_pwm + (millipercent * range)

Does this artificially double the minimum backlight level and prevent the
screen from dimming properly?

>  		init_data[i].def_varibright_enable =3D 0;
>  		init_data[i].varibright_level =3D 0;
>  		/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901140155.1912=
9-1-aarav.240604@gmail.com?part=3D1
