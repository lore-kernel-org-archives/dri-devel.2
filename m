Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD71C44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B56410EFED;
	Thu, 23 Jul 2026 07:23:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 109EF10EFF8
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 07:23:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 475A760051;
 Thu, 23 Jul 2026 07:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D9F1F000E9;
 Thu, 23 Jul 2026 07:23:48 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/backlight: allow hybrid pin-enable + AUX
 brightness panels
To: "John Foushee" <johnfoushee@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722154802.3760046-1-johnfoushee@gmail.com>
References: <20260722154802.3760046-1-johnfoushee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 07:23:47 +0000
Message-Id: <20260723072348.C9D9F1F000E9@smtp.kernel.org>
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
- [High] Hybrid eDP panels supporting luminance control (luminance_set =3D=
=3D true) but lacking AUX enable capability (aux_enable =3D=3D false) will =
fail to turn on the backlight.
--

--- Patch [1]: [PATCH] drm/i915/backlight: allow hybrid pin-enable + AUX br=
ightness panels ---
commit 5c1988c15272e150c5abfa3acb528c1a51340cb5
Author: John Foushee <johnfoushee@gmail.com>

    drm/i915/backlight: allow hybrid pin-enable + AUX brightness panels

This commit allows the use of hybrid eDP backlight configurations (where
brightness is adjusted via AUX but enablement happens via the BL_ENABLE PWM
pin) by dropping the DP_EDP_BACKLIGHT_AUX_ENABLE_CAP requirement in the VESA
backlight check.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/16679

> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driv=
ers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index 7a6c07f6aaeb4..a5c03c32a7d43 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -616,11 +616,15 @@ check_if_vesa_backlight_possible(struct intel_dp *i=
ntel_dp)
>  	u8 bit_min, bit_max;
> =20
>  	/*
> -	 * Since we only support Fully AUX Based VESA Backlight interface make =
sure
> -	 * backlight enable is possible via AUX along with backlight adjustment
> +	 * Brightness adjustment must be possible via AUX. Backlight *enable*
> +	 * may come either via AUX (DP_EDP_BACKLIGHT_AUX_ENABLE_CAP) or via the
> +	 * BL_ENABLE pin, which the VESA backlight code already supports by
> +	 * falling back to the PWM funcs for enable when aux_enable is not set.

[Severity: High]
This is a pre-existing issue, but does the PWM fallback actually execute for
panels with luminance control?

Looking at the existing logic in intel_dp_aux_vesa_enable_backlight():

	if (!(panel->backlight.edp.vesa.info.aux_enable ||
	      panel->backlight.edp.vesa.info.luminance_set)) {
		u32 pwm_level;
		// ... (PWM fallback enable code)

If an eDP panel supports luminance control (luminance_set =3D=3D true) but =
lacks
AUX enable capability (aux_enable =3D=3D false), wouldn't this condition ev=
aluate
to false, skipping the PWM fallback entirely?

If the fallback is skipped, the backlight enable pin won't be asserted via
PWM, and the AUX enablement won't happen since aux_enable is false. Could
this cause such panels to remain permanently black and unusable?

> +	 * Some panels (e.g. Tianma Y156ZAN02.0 in the Google Pixel Slate)
> +	 * support only that hybrid configuration and ignore the PWM pin for
> +	 * brightness adjustment.
>  	 */
> -	if (!(intel_dp->edp_dpcd[1] & DP_EDP_BACKLIGHT_AUX_ENABLE_CAP &&
> -	      intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP))
> +	if (!(intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP))
>  		return false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722154802.3760=
046-1-johnfoushee@gmail.com?part=3D1
