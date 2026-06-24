Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891D3CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E014D10E0BE;
	Wed, 24 Jun 2026 17:16:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MyceSHIv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 094CF10E0BE
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:16:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2949442AC;
 Wed, 24 Jun 2026 17:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689EB1F000E9;
 Wed, 24 Jun 2026 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782321406;
 bh=m4k0RBQ3Qg7yRfUoq49mFShUqHEvWN0lgqtisYQWq4w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MyceSHIv4Ia/JlqANytv6vqYirRzLXI9uMsGlngV61SFRcTILwWk68hpGLAXzl/DM
 Yy4aVwWP438ITGbJr9j95fDnDPOcRTARMoRLuBig4LFJ/LIB6BcXbIAiQiawgAg8hs
 vDMs42nVqGo3hCQk3uotfQ7xeSF9A5U/iPWWQb9Mu2Wb+6eu0ypR6c6lNZAkpwx+us
 UXWMNso7WerLR9N7kFoPikA83TIK6DExadnUBqDG081WfKh+zzR0qcmeCybaCRZuTG
 L3ikB+1xju8DiDyIaHuxsvGthwRYSVloxXvIGL0/71JHuqA5/9iVTCYclNOlUZFNXo
 Wwclb4+QlT/zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/10] drm/amd/display: Drop brightness caching in
 amdgpu_dm
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624165751.2014759-9-mario.limonciello@amd.com>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
 <20260624165751.2014759-9-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:16:45 +0000
Message-Id: <20260624171646.689EB1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Removal of brightness caching and restoration logic causes the dis=
play to remain at incorrect brightness levels after modesets, DPMS ON, and =
GPU resets, and permanently drops backlight changes made while the display =
is off.

Pre-existing issues:
- [High] Unsafe iteration of the global DRM `connector_list` without holdin=
g `mode_config.connector_list_lock` or using the `drm_connector_list_iter` =
API.
- [High] Unprotected access to `dm->dc->current_state` and its streams can =
lead to use-after-free during concurrent atomic commits.
- [High] Missing `dc_lock` and IPS (Idle Power Save) handling in `amdgpu_dm=
_backlight_get_level`.
--

commit 38d7d185db9bb8880779014318e409480bde8a6d
Author: Mario Limonciello (AMD) <superm1@kernel.org>

drm/amd/display: Drop brightness caching in amdgpu_dm

This commit drops brightness and actual_brightness caching from amdgpu_dm,=
=20
relying on the DRM core to restore brightness when a connector is turned=20
back on.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9653cfd99c6ad..43b22ab9180e8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -5399,10 +5393,8 @@ static void amdgpu_dm_backlight_set_level(struct a=
mdgpu_display_manager *dm,
>  		if (aconnector->bl_idx !=3D bl_idx)
>  			continue;
> =20

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to iterate the gl=
obal=20
connector_list in this loop without holding mode_config.connector_list_lock=
 or=20
using the drm_connector_list_iter API?=20

Could this lead to memory corruption if there is a concurrent DP MST hot-un=
plug=20
while a client reads or writes the sysfs backlight property?

> -		/* if connector is off, save the brightness for next time it's on */
> +		/* if connector is off, DRM core will restore it next time it's on */
>  		if (!aconnector->base.encoder) {
> -			dm->brightness[bl_idx] =3D user_brightness;
> -			dm->actual_brightness[bl_idx] =3D 0;
>  			return;
>  		}
>  	}

[Severity: High]
Is relying on the DRM core to restore the backlight sufficient here?=20

Since amdgpu implements a custom atomic commit tail that bypasses the stand=
ard=20
DRM core restoration helpers, it seems changes made while DPMS is off are=20
never pushed to the hardware.

> @@ -5410,11 +5402,10 @@ static void amdgpu_dm_backlight_set_level(struct =
amdgpu_display_manager *dm,
>  	amdgpu_dm_update_backlight_caps(dm, bl_idx);
>  	caps =3D &dm->backlight_caps[bl_idx];
> =20
> -	dm->brightness[bl_idx] =3D user_brightness;
>  	/* update scratch register */
>  	if (bl_idx =3D=3D 0)
> -		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightn=
ess[bl_idx]);
> -	brightness =3D convert_brightness_from_user(caps, dm->brightness[bl_idx=
]);
> +		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, user_bright=
ness);
> +	brightness =3D convert_brightness_from_user(caps, user_brightness);
>  	link =3D (struct dc_link *)dm->backlight_link[bl_idx];
> =20
>  	/* Apply brightness quirk */

[Severity: High]
This is a pre-existing issue, but does the unprotected access to the stream=
=20
returned downstream from dm_find_stream_with_link() risk a use-after-free?=
=20

If a concurrent atomic commit modifies current_state and releases the old=20
dc_stream_state objects via dc_stream_release() before=20
amdgpu_dm_backlight_set_level() passes the stream downstream, the memory=20
might be freed.

[ ... ]
> @@ -5522,7 +5510,7 @@ static int amdgpu_dm_backlight_get_level(struct amd=
gpu_display_manager *dm,
>  static int amdgpu_dm_backlight_get_brightness(struct backlight_device *b=
d)
>  {
>  	struct amdgpu_display_manager *dm =3D bl_get_data(bd);
> -	int i, ret;
> +	int i;
> =20
>  	for (i =3D 0; i < dm->num_of_edps; i++) {
>  		if (bd =3D=3D dm->backlight_dev[i])
> @@ -5531,11 +5519,7 @@ static int amdgpu_dm_backlight_get_brightness(stru=
ct backlight_device *bd)
>  	if (i >=3D AMDGPU_DM_MAX_NUM_EDP)
>  		i =3D 0;
> =20
> -	ret =3D amdgpu_dm_backlight_get_level(dm, i);
> -	if (ret < 0)
> -		return dm->brightness[i];
> -
> -	return ret;
> +	return amdgpu_dm_backlight_get_level(dm, i);
>  }

[Severity: High]
This is a pre-existing issue, but does amdgpu_dm_backlight_get_level() need=
=20
to acquire dc_lock and call dc_allow_idle_optimizations() before reading=20
hardware registers downstream?=20

If the hardware is in a low-power state when a user reads the sysfs brightn=
ess=20
attribute, could this missing lock lead to a hardware hang or MMIO timeout?

[ ... ]
> @@ -11085,18 +11050,6 @@ static void amdgpu_dm_commit_streams(struct drm_=
atomic_commit *state,
>  		}
>  	}
> =20
> -	/* During boot up and resume the DC layer will reset the panel brightne=
ss
> -	 * to fix a flicker issue.
> -	 * It will cause the dm->actual_brightness is not the current panel bri=
ghtness
> -	 * level. (the dm->brightness is the correct panel level)
> -	 * So we set the backlight level with dm->brightness value after set mo=
de
> -	 */
> -	if (set_backlight_level) {
> -		for (i =3D 0; i < dm->num_of_edps; i++) {
> -			if (dm->backlight_dev[i])
> -				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
> -		}
> -	}
>  }

[Severity: High]
Without this restoration loop in amdgpu_dm_commit_streams(), does the drive=
r=20
fail to correct the hardware brightness after the DC layer internally reset=
s=20
it during modesets?=20

It appears the backlight might remain at incorrect hardware default or rese=
t=20
levels upon resume or modeset.

[ ... ]
> @@ -11604,13 +11557,6 @@ static void amdgpu_dm_atomic_commit_tail(struct =
drm_atomic_commit *state)
>  	/* Update audio instances for each connector. */
>  	amdgpu_dm_commit_audio(dev, state);
> =20
> -	/* restore the backlight level */
> -	for (i =3D 0; i < dm->num_of_edps; i++) {
> -		if (dm->backlight_dev[i] &&
> -		    (dm->actual_brightness[i] !=3D dm->brightness[i]))
> -			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
> -	}
> -
>  	/*
>  	 * send vblank event on all events not handled in flip and
>  	 * mark consumed event for drm_atomic_helper_commit_hw_done

[Severity: High]
Does removing the explicit manual backlight restoration from=20
amdgpu_dm_atomic_commit_tail() cause the pending backlight level to never b=
e=20
pushed to hardware when the display is enabled?=20

Because this custom atomic commit tail bypasses standard DRM core restorati=
on=20
helpers, it seems changes made while DPMS is off are permanently lost witho=
ut=20
this loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624165751.2014=
759-1-mario.limonciello@amd.com?part=3D8
