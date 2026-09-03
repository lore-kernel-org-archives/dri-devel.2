Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2786DC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D9C410F44C;
	Thu,  3 Sep 2026 07:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fkLvqC8l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADE510F44C
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 07:50:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1824143963;
 Thu,  3 Sep 2026 07:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF921F000E9;
 Thu,  3 Sep 2026 07:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788421806;
 bh=tRh/NK4IVnp938BOdcI0x9+E9gLGwa234UJNihOmewY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fkLvqC8lkeVl9Q+LckFlSSxGDDbJZ/8AJySJ6O0ZFLcaGJlmekKaDy0MtUuRfCf3x
 M/fdhCe5CsFMW0cxRtHiD96OtHSB8qNzGTE8Z8nKsMpJLPyfU4w3s2dh/vbGuQUJu4
 FWrR62bHcMM6ROT/dh5PHbRB7/cQ0AVwz2aRB/zVs4ZsNxFvSLh30Xf20w+fRPGR1p
 wTqRYW5gj1tDI4ZdJaIqdKioC87XEkGDJm+X1n0QkjTmUzT/7QI+B2zOZBd4uHG8ON
 YvFUmjDOe+zlTZunEiQClR6KeIC6EyUqvDcB4KyoxWcV2WV9BI9iZQ/hWK8j+ltGb7
 n23fSXPkUW6mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/amd/display: pass userspace brightness to
 power module
To: "Andrei Rusu de Castro" <arc@empyreal.works>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <065649410e7f8682d15048a7a49cff5d89e54fb3.1788388049.git.arc@empyreal.works>
References: <20260902-brightness-cover-abf809f2@empyreal.works>
 <cover.1788388049.git.arc@empyreal.works>
 <065649410e7f8682d15048a7a49cff5d89e54fb3.1788388049.git.arc@empyreal.works>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:50:05 +0000
Message-Id: <20260903075005.CEF921F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] The brightness quirk mask is not applied to `backlight_millinits=
` for AMD AUX panels, causing firmware to write unmasked values during auto=
nomous operations

Pre-existing issues:
- [High] Unprotected traversal of drm_mode_config.connector_list
- [High] Unprotected access to `dm->dc->current_state` leading to potential=
 Use-After-Free
- [High] Potential division by zero in brightness conversion functions when=
 firmware capabilities are anomalous
- [High] Incomplete bounds validation during power module creation allows m=
ulti-display setups to trigger a division by zero
--

commit 8608a59a12eb05fd14ffc0e7cb1af582e44dade9
Author: Andrei Rusu de Castro <arc@empyreal.works>
Date:   Wed Sep 2 22:31:59 2026 +0000

drm/amd/display: pass userspace brightness to power module

The patch adjusts how brightness is passed to the power module in amdgpu_dm,
keeping it as userspace percentage (millipercent) instead of converting to
PWM domain first. This fixes domain mismatch issues and handles panel-speci=
fic
brightness quirks for AMD AUX writes.

Closes: https://sashiko.dev/#/patchset/20260902-brightness-cover-abf809f2@e=
mpyreal.works?part=3D3

> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
[ ... ]
> @@ -218,6 +218,39 @@ u32 convert_brightness_to_user(const struct amdgpu_d=
m_backlight_caps *caps,
>  }
>  EXPORT_IF_KUNIT(convert_brightness_to_user);
> =20
> +static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_bac=
klight_caps *caps,
> +					      u32 brightness)
> +{
> +	unsigned int min, max;
> +
> +	if (!get_brightness_range(caps, &min, &max) || max <=3D min)
> +		return 0;
> +
> +	if (brightness >=3D max)
> +		return 100 * 1000;
> +
> +	return DIV_ROUND_CLOSEST_ULL((u64)brightness * 100 * 1000, max);
> +}
> +
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

[Severity: High]
This is a pre-existing issue, but while convert_brightness_to_millipercent()
properly guards against max <=3D min to avoid division by zero, the
convert_brightness_from_user() function called here lacks these same guards.
Does convert_brightness_from_user() unconditionally divide by max, risking a
kernel panic if anomalous firmware sets max to zero? Similarly, does
convert_brightness_to_user() risk dividing by zero when evaluating max - mi=
n?

> +
> +	return brightness;
> +}
[ ... ]
> @@ -262,7 +295,6 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_disp=
lay_manager *dm,
>  	bool rc =3D false, reallow_idle =3D false;
>  	struct drm_connector *connector;
>  	struct dc_stream_state *stream;
> -	unsigned int min, max;
> =20
>  	list_for_each_entry(connector, &dm->ddev->mode_config.connector_list, h=
ead) {

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to traverse the D=
RM
connector_list using the raw list_for_each_entry macro without holding
mode_config.mutex or using the drm_connector_list_iter API? Can a concurrent
hotplug event removing a connector leave this loop traversing a freed point=
er,
resulting in a use-after-free?

[ ... ]
> @@ -285,12 +317,9 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_dis=
play_manager *dm,
>  	/* update scratch register */
>  	if (bl_idx =3D=3D 0)
>  		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightn=
ess[bl_idx]);
> -	brightness =3D convert_brightness_from_user(caps, dm->brightness[bl_idx=
]);
>  	link =3D (struct dc_link *)dm->backlight_link[bl_idx];
> -
> -	/* Apply brightness quirk */
> -	if (caps->brightness_mask)
> -		brightness |=3D caps->brightness_mask;
> +	brightness =3D convert_brightness_for_power_module(caps,
> +							 dm->brightness[bl_idx]);

[Severity: High]
This is a pre-existing issue, but further down in this function,
dm_find_stream_with_link() is called before acquiring dc_lock. Inside
dm_find_stream_with_link(), the dm->dc->current_state pointer is dereferenc=
ed
and iterated over. Because this sysfs callback runs concurrently with atomic
commits (which free the old state), is there a risk of a use-after-free cra=
sh
by reading a stale current_state pointer before the lock is held?

[ ... ]
> --- a/drivers/gpu/drm/amd/display/modules/power/power.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power.c
> @@ -157,6 +157,8 @@ struct mod_power *mod_power_create(struct dc *dc,
>  				init_params[inst].use_custom_backlight_caps;
>  		core_power->bl_prop[inst].custom_backlight_caps_config_no =3D
>  				init_params[inst].custom_backlight_caps_config_no;
> +		core_power->bl_prop[inst].brightness_mask =3D
> +				init_params[inst].brightness_mask;
> =20
>  		// Do not allow less than 101 backlight levels
>  		if (init_params[inst].num_backlight_levels < 101)

[Severity: High]
This isn't a bug introduced by this patch, but further down in
mod_power_create(), a loop validates the brightness ranges for eDP instance=
s:

for (inst =3D 0; inst < edp_num; inst++) {
    if (core_power->bl_prop[inst].nits_range !=3D 0 && ...) {
        is_brightness_range_valid =3D true;
        break;
    }
}

Does this premature break cause the loop to exit without verifying remaining
instances? If panel 1 has a zero nits_range while panel 0 is valid, could
this lead to a division by zero later in backlight_millinit_to_pwm_legacy()
when it evaluates panel 1?

[ ... ]
> --- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
[ ... ]
> @@ -1020,6 +1050,11 @@ void fill_backlight_level_params(struct core_power=
 *core_power,
> =20
>  	if (backlight_control_type =3D=3D BACKLIGHT_CONTROL_AMD_AUX && !is_hdr)
>  		backlight_level_params->control_type =3D BACKLIGHT_CONTROL_PWM;
> +
> +	if (backlight_level_params->control_type =3D=3D BACKLIGHT_CONTROL_PWM)
> +		backlight_level_params->backlight_pwm_u16_16 =3D
> +			backlight_apply_source_mask(core_power, backlight_pwm,
> +						    panel_inst);
>  }

[Severity: Medium]
When backlight_level_params->control_type remains BACKLIGHT_CONTROL_AMD_AUX
(for instance, during HDR playback), the brightness_mask is not applied to
backlight_level_params->backlight_millinits here. Because these parameters
are subsequently passed to the DMCUB firmware for autonomous operations like
PSR/Replay exits, will this allow the firmware to write unmasked brightness
values directly to the panel, bypassing the quirk? Should
backlight_millinits also be masked here when the control type is AMD AUX?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788388049.gi=
t.arc@empyreal.works?part=3D3
