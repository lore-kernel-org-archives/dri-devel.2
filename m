Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AD1C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4794510F1C6;
	Wed,  2 Sep 2026 12:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nKlSfge4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6AF10F1A1
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:57:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D409E40386;
 Wed,  2 Sep 2026 12:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC1A1F000E9;
 Wed,  2 Sep 2026 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788353842;
 bh=Q6/hzATBrWHNUW8K8ael1hrNvs+dEmWIooLBA5vGu7M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nKlSfge4WPHc7TMJwx/C9wIWy+3/8Rp2zb/gnOSeQ2LG2Ee/Kzd8wMnlOEUNjuw+0
 tbn0qoR3WibgADxDBVjpFF0L0EYnn6xIMH8ci4Y8UQoc4l1gTeh9Qr4Ejp0lPFVki7
 KT6xQ7+PYI3xSLjFln3A9QkgOvMCvLnQkn1OWIJNGplzLcUTqdLO8+hq4gKQ6eqx9r
 JWBdZGzJiQ0d1ygGf5A1yBunhrD3UC1YLroXX17Y0n9GYUvRDPE5oxrgvdbJMeGWni
 s9tdERzIZpe1cIfnr4zK8byy/wiI2mkcgbTT7AbhGYYf4A5X2MIvTO+L8NqWwbZee7
 3FXacEecEEikQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/amd/display: pass userspace brightness to power
 module
To: "Andrei Rusu de Castro" <arc@empyreal.works>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902-brightness-3-50f94618@empyreal.works>
References: <20260902-brightness-cover-abf809f2@empyreal.works>
 <20260902-brightness-3-50f94618@empyreal.works>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:57:22 +0000
Message-Id: <20260902125722.8CC1A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Double application of PWM bitmask quirk and mathematical corruptio=
n on millinits.

Pre-existing issues:
- [High] Sleeping function called from atomic context.
- [High] Potential division by zero in brightness conversion functions when=
 processing malformed firmware capabilities.
--

commit 5d73b2399ca1fd59d638eb586a83e6e63cc7a221
Author: Andrei Rusu de Castro <arc@empyreal.works>

drm/amd/display: pass userspace brightness to power module

The power module consumes millipercent and builds its own PWM lookup table
from the ATIF brightness transfer characteristics. This patch passes the
original userspace percentage to the power module on PWM panels and keeps
the existing nits conversion and source-unit brightness mask for AUX panels.
It also wires the brightness bypass to the power module's existing linear
bypass.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 424b33573a734..04e810af4623c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -218,6 +218,41 @@ u32 convert_brightness_to_user(const struct amdgpu_d=
m_backlight_caps *caps,
>  }
>  EXPORT_IF_KUNIT(convert_brightness_to_user);

[Severity: High]
This isn't a bug introduced by this patch, but can
convert_brightness_to_user() in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c trigger a
kernel panic via division by zero?

If a connected monitor's EDID/DPCD reports identical max_luminance and
min_luminance values:
amdgpu_dm_update_backlight_caps() will set
aux_max_input_signal =3D=3D aux_min_input_signal.

This causes max - min =3D=3D 0 to be returned by get_brightness_range().
Subsequently, calling amdgpu_dm_backlight_get_level() will execute
convert_brightness_to_user(), which evaluates
DIV_ROUND_CLOSEST_ULL(..., max - min), triggering a division by zero.

This could allow a Denial of Service attack against the host system by
plugging in an untrusted, maliciously crafted DisplayPort monitor or dock.

> +static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_bac=
klight_caps *caps,
> +					      u32 brightness)
[ ... ]
> +STATIC_IFN_KUNIT
> +u32 convert_brightness_for_power_module(const struct amdgpu_dm_backlight=
_caps *caps,
> +					u32 user_brightness)
> +{
> +	u32 brightness;
> +
> +	if (!caps)
> +		return user_brightness;
> +
> +	if (!caps->aux_support)
> +		return convert_brightness_to_millipercent(caps, user_brightness);
> +
> +	brightness =3D convert_brightness_from_user(caps, user_brightness);
> +	if (caps->brightness_mask)
> +		brightness |=3D caps->brightness_mask;

[Severity: High]
Does convert_brightness_for_power_module() in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c erroneously
apply the hardware bitmask quirk to a mathematical millinits value prior to
handoff?

For AUX panels, caps->brightness_mask is OR'ed into the mathematically
scaled millinits brightness variable here. This corrupted value is then
passed to mod_power_set_backlight_nits(), which converts it to a PWM value.

> +
> +	return brightness;
> +}
> +
> +EXPORT_IF_KUNIT(convert_brightness_for_power_module);
> +
>  STATIC_IFN_KUNIT
>  struct dc_stream_state *dm_find_stream_with_link(
>  	struct amdgpu_display_manager *dm,
> @@ -262,7 +297,6 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_disp=
lay_manager *dm,
>  	bool rc =3D false, reallow_idle =3D false;
>  	struct drm_connector *connector;
>  	struct dc_stream_state *stream;

[Severity: High]
This isn't a bug introduced by this patch, but does
amdgpu_dm_backlight_set_level() in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c safely handle
calling mutex_lock(&dm->dc_lock)?

amdgpu_dm_backlight_set_level() explicitly locks the mutex, but it is
reached via amdgpu_dm_atomic_commit_tail() during non-blocking display
atomic commits. Calling a sleeping function from atomic context can lead to
kernel warnings (lockdep splats), system instability, and potential
deadlocks.

> =20
>  	list_for_each_entry(connector, &dm->ddev->mode_config.connector_list, h=
ead) {
>  		struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(conn=
ector);
[ ... ]
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/driv=
ers/gpu/drm/amd/display/modules/power/power_abm.c
> index 5e86889eaa841..4d7d80ac60c9b 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
> @@ -1020,6 +1020,10 @@ void fill_backlight_level_params(struct core_power=
 *core_power,
> =20
>  	if (backlight_control_type =3D=3D BACKLIGHT_CONTROL_AMD_AUX && !is_hdr)
>  		backlight_level_params->control_type =3D BACKLIGHT_CONTROL_PWM;
> +
> +	if (backlight_level_params->control_type =3D=3D BACKLIGHT_CONTROL_PWM)
> +		backlight_level_params->backlight_pwm_u16_16 |=3D
> +			bl_prop->brightness_mask;

[Severity: High]
For non-HDR AUX panels falling back to PWM, does
fill_backlight_level_params() in
drivers/gpu/drm/amd/display/modules/power/power_abm.c apply the bitmask
a second time onto the resulting PWM value, leading to undefined hardware
behavior?

>  }
> =20
>  bool mod_power_set_backlight_nits(struct mod_power *mod_power,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-brightness=
-cover-abf809f2@empyreal.works?part=3D3
