Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FACC79FAC
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FEC210EA19;
	Tue,  8 Sep 2026 04:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fXBpNIGw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D1B710EA19;
 Tue,  8 Sep 2026 04:57:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26456601DB;
 Tue,  8 Sep 2026 04:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F571F00A3A;
 Tue,  8 Sep 2026 04:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788843421;
 bh=LTw7oPUB5qsIzmkPq7jctl86v6y/Bzdvyc18djgV3sc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fXBpNIGworgIrw9ZdpjejOVxepR3yDnWd0/TL4INbILImw6y7aDpKQwfruvWxVZcR
 MxGv3YaIVP3WvdjVG4nuXTfICUf1hjJ+HNNXWCcZ8iWZO3snRFgZtpMZAwkJc9XojZ
 h9/DRoYL1a5CjgyO3/pLTVdUQxCHxQJIXTm7f2RW/UYsu99hF6/zjahf7Cz8b5mG1I
 IZJ9sACm4ZC0KVXrCyHCKAHIqEtO9iq4m6q7IdBbqjy0luXyQiszIZsLBQO8InzVX9
 x7WyjU15pIfCYeEkp5OlpdKAPxGFoF8jijlNAGC+3amJ4/D0CIX41Fp6xHb5dhiwD5
 CeF166FF2HqCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/14] drm/amd/display: use drm backlight
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260908044035.62093-9-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-9-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 04:57:01 +0000
Message-Id: <20260908045701.A9F571F00A3A@smtp.kernel.org>
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
- [High] Unconditional creation of the DRM LUMINANCE property breaks bright=
ness control on systems relying on ACPI video backlight.
- [High] Lockless access to the global `crtc->state` pointer during brightn=
ess-only commits leads to a Use-After-Free (UAF) and race condition.
- [High] TOCTOU race when accessing `dm->dc->current_state` leads to a pote=
ntial NULL pointer dereference or Use-After-Free.
--

commit 2a535fc7f658113715bee173a4202a46e91b7048
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/amd/display: use drm backlight

This commit converts the AMD display driver to use the DRM backlight
infrastructure, exposing brightness control through the connector LUMINANCE
property.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2fe934036e363..f7b1eaf34b59d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -5050,10 +5050,21 @@ static void amdgpu_dm_atomic_commit_tail(struct d=
rm_atomic_commit *state)
>  			old_crtc_state =3D drm_atomic_get_old_crtc_state(state, &acrtc->base);
>  		}
> =20
> +		/*
> +		 * Apply the LUMINANCE property first: a brightness-only commit
> +		 * does not pull the CRTC into the atomic state (so new_crtc_state
> +		 * is NULL), and a modeset is skipped below - in both cases the
> +		 * backlight must still follow the requested luminance.
> +		 */
> +		drm_atomic_helper_connector_apply_luminance(new_con_state);

[Severity: High]
Does this introduce a race condition leading to a use-after-free?

Since the CRTC is intentionally not pulled into the atomic state during a
brightness-only commit, the CRTC lock is not held in this path. However,
drm_atomic_helper_connector_apply_luminance() dereferences the global
conn_state->crtc->state->active property locklessly.

If a concurrent modeset or display disable commit acquires the lock,
swaps the state, and frees the old one, this non-blocking brightness commit
could end up reading freed memory. Is it safe to call this helper without
ensuring the CRTC lock is held?

[ ... ]
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 406a821d03cd6..1fefe3837e4cf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
[ ... ]
> @@ -224,13 +225,17 @@ struct dc_stream_state *dm_find_stream_with_link(
>  	struct amdgpu_display_manager *dm,
>  	struct dc_link *link)
>  {
> -	struct dc_state *cur_dc_state =3D dm->dc->current_state;
>  	struct dc_stream_state *stream =3D NULL;
>  	int i;
> =20
> +	if (!dm || !dm->dc || !dm->dc->current_state || !link)
> +		return NULL;
> +
> +	cur_dc_state =3D dm->dc->current_state;

[Severity: High]
Can this result in a double-fetch/TOCTOU race?

This code checks that dm->dc->current_state is not NULL, but then immediate=
ly
re-reads the pointer from dm->dc->current_state.=20

If a concurrent modeset or teardown updates the state between the check and
the assignment, cur_dc_state could be NULL or point to freed memory when it
is subsequently dereferenced in the loop below.=20

Should this be changed to read the state pointer once into cur_dc_state,
and then perform the NULL check on the local variable?

[ ... ]
> @@ -600,6 +610,13 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_=
display_manager *dm,
> =20
>  	amdgpu_dm_update_connector_ext_caps(aconnector);
> =20
> +	caps =3D &dm->backlight_caps[bl_idx];
> +	amdgpu_dm_backlight_fill_props(caps, power_supply_is_system_supplied() =
> 0,
> +				       !(amdgpu_dc_debug_mask &
> +					 DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE),
> +				       &props);
> +	drm_backlight_create_property(&aconnector->base, props.max_brightness, =
false);

[Severity: High]
Does unconditionally creating this property break brightness control on
systems relying on ACPI video backlight?

By creating the LUMINANCE property here, we expose it to userspace before
verifying if the native backlight backend will actually be used.=20

During later registration in amdgpu_dm_register_backlight_device(), if
acpi_video_backlight_use_native() is false, the driver exits early and never
links a backend to this property.=20

Will modern userspace compositors attempt to use this exposed but
non-functional LUMINANCE property and silently fail to adjust brightness,
ignoring the working ACPI sysfs interface entirely?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908044035.6209=
3-1-mario.limonciello@amd.com?part=3D8
