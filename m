Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A38C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12A510E2BC;
	Mon, 31 Aug 2026 14:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D3W5ZMvs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8A310E2BC
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:58:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8CB1343221
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1E91F000E9;
 Mon, 31 Aug 2026 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788188320;
 bh=gnDOdONqPHCGOtWJ0MCHSL6Xpn1SF0ga8IHgWXpftV8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D3W5ZMvs7cR08COAa6QW7WtiVIF9UJy0rRElf+2ezKW0WhWhA26G69aoQOAATJKMU
 c6/DfdRNgW8x2SNdRD6q8PSsjNLSoYBWpkJlorpLK6nqiNLSpG+qHJ5g8qPxrtWZ8O
 UUMPZKsPQQM+dvuKb2Znn3TZWM+gaE7bjFM+3Ayl1gZllsGgBxifgKRS48tjxjO50C
 eDSJGtiUIs9CSN9E8tmmhydkc3DifWnXd6KHvEFfResaXGcs+UnWoM7+W+ZJNR4OI8
 +GL3aAjlgoILmwVdlYqVjtt+WZY0i/EG+PsuFpVzZ+qHOBk5+OiknNr5wlJ0bsHGb9
 RFUoCD/GUHkhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] drm/amd/pm/si: Fix updating clock
 limits from power states
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-205-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-205-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:58:39 +0000
Message-Id: <20260831145840.4E1E91F000E9@smtp.kernel.org>
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
- [High] Incomplete fix: the `radeon` driver still contains the identical b=
ug, leaving laptops using that driver stuck on the lowest power level on ba=
ttery.
--

commit fcad112d0493cf1ee7c6a33503caa587b8452254
Author: Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
drm/amd/pm/si: Fix updating clock limits from power states

This commit fixes a bug where laptop GPUs were stuck on the lowest possible
clock frequency and power level on battery by updating maximum clock limits
for both AC and DC states in the amdgpu SI DPM code.

> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index 3a9522c17fee3..828bfb51e9174 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c

[ ... ]

> @@ -7285,12 +7286,30 @@ static void si_parse_pplib_clock_info(struct amdg=
pu_device *adev,
>  		si_pi->mvdd_bootup_value =3D mvdd;
>  	}
> =20
> +	/*
> +	 * Update maximum allowed clock limits.
> +	 * VBIOS can contain conflicting values between:
> +	 * - the maximum allowed clocks and voltages on AC or DC
> +	 * - the clocks and voltages in power states on AC or DC
> +	 */
>  	if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) =3D=3D
> -	    ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE) {
> -		adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.sclk =3D pl->sclk;
> -		adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.mclk =3D pl->mclk;
> -		adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.vddc =3D pl->vddc;
> -		adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.vddci =3D pl->vddci;
> +	    ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE)
> +		limits =3D &adev->pm.dpm.dyn_state.max_clock_voltage_on_ac;
> +	else if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) =3D=3D
> +		 ATOM_PPLIB_CLASSIFICATION_UI_BATTERY)
> +		limits =3D &adev->pm.dpm.dyn_state.max_clock_voltage_on_dc;
> +	else
> +		limits =3D NULL;
> +
> +	if (limits) {
> +		if (pl->sclk > limits->sclk)
> +			limits->sclk =3D pl->sclk;
> +		if (pl->mclk > limits->mclk)
> +			limits->mclk =3D pl->mclk;
> +		if (pl->vddc > limits->vddc)
> +			limits->vddc =3D pl->vddc;
> +		if (pl->vddci > limits->vddci)
> +			limits->vddci =3D pl->vddci;
>  	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the radeon driver need
this exact same fix?

Looking at drivers/gpu/drm/radeon/si_dpm.c in si_parse_pplib_clock_info()
and drivers/gpu/drm/radeon/ni_dpm.c in ni_parse_pplib_clock_info(), they
both still contain the older, unpatched logic that unconditionally
overwrites AC limits and completely ignores DC/BATTERY limits:

        if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) =3D=3D
            ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE) {
                rdev->pm.dpm.dyn_state.max_clock_voltage_on_ac.sclk =3D pl-=
>sclk;
                rdev->pm.dpm.dyn_state.max_clock_voltage_on_ac.mclk =3D pl-=
>mclk;
                rdev->pm.dpm.dyn_state.max_clock_voltage_on_ac.vddc =3D pl-=
>vddc;
                rdev->pm.dpm.dyn_state.max_clock_voltage_on_ac.vddci =3D pl=
->vddci;
        }

Since the radeon driver is often the default for SI (GCN 1.0) and earlier
GPUs, affected laptops (like those with the FirePro W4170M or Radeon HD
8790M) might still get stuck on the lowest power level on battery when
using that driver.

Would it make sense to port this fix back to the radeon driver as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-205-sashal@kernel.org?part=3D1
