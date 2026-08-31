Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CD5C624CE
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 23:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B0710E350;
	Mon, 31 Aug 2026 23:12:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LO7XAf1S";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E995310E201;
 Mon, 31 Aug 2026 23:12:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B46354040B;
 Mon, 31 Aug 2026 23:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA231F000E9;
 Mon, 31 Aug 2026 23:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788217943;
 bh=WKREeC0A9FWebX8fIUO6hK8tETdofiaG42KeQZDptds=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LO7XAf1Ss8S0YS5MeOIZ+InJyJLywUwlHBw2Wl0OjO74l5ENygkvR2FdMY5vYcl01
 HwUbhfs4+xgkGX0y3z1NmXuXqK+6753HFaMy7lHECc4Fq6UcOOktr/Pf3viPKwToZ8
 LkEmt3BQgjErrYSiOef+cl1XLBBRM0J290zKIoxjBG0+k2jkyexlvx+NsuX6pU6pxA
 cAeK/n/gBWLIxomvoiBC/YweF9DUMXxgvfUizTCvWEnXuII+lruwRjUckscyKw5WZd
 6odxrI3AzUHgFBtMPbkEn9xZtLwosMzT706MjUNk11bDAbnbjpX6+sfRiMV6tqR9tA
 H1L+m0zyKSDkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/12] drm/amd/display: use drm backlight
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260831210531.2334221-9-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
 <20260831210531.2334221-9-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:12:22 +0000
Message-Id: <20260831231223.5EA231F000E9@smtp.kernel.org>
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
- [High] Data race and unconditional kernel WARN_ON due to dynamic DRM prop=
erty creation after connector registration.
- [Medium] Luminance property updates are silently dropped when an atomic c=
ommit includes a modeset.

Pre-existing issues:
- [High] Atomic check and commit paths dereference a NULL CRTC state if a c=
onnector property is updated without the associated CRTC being pulled into =
the atomic state.
--

commit 3fc3b85f7e3897f97fa8465e7158825ddd3e0dd7
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/amd/display: use drm backlight

Convert the AMD display driver to the DRM backlight infrastructure so
brightness can be controlled through the connector LUMINANCE property.
Link the registered backlight_device to the eDP connector and unlink it
on teardown; the DRM core owns the embedded backlight state and its
property, so no explicit allocation or failure handling is needed.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 284aac4d96bce..b5254c775a778 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5048,6 +5048,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm=
_atomic_commit *state)
>  		if (!acrtc || drm_atomic_crtc_needs_modeset(new_crtc_state))

[Severity: High]
This is a pre-existing issue, but does this code dereference a NULL pointer
if a connector-only property is updated?

When a connector-only property is updated, the DRM core stages the property
but does not add the CRTC to the atomic state. The drm_atomic_get_new_crtc_=
state
call returns NULL when the CRTC is not in the state.

If userspace submits an atomic commit that updates only the newly exposed
LUMINANCE property without modifying the CRTC, new_crtc_state will be NULL
and immediately dereferenced inside drm_atomic_crtc_needs_modeset().

>  			continue;
> =20
> +		drm_connector_update_privacy_screen(new_con_state);
> +		drm_atomic_helper_connector_apply_luminance(new_con_state);

[Severity: Medium]
Will this cause luminance property updates to be silently dropped when an
atomic commit includes a modeset?

The continue statement immediately above skips the newly added
drm_atomic_helper_connector_apply_luminance() call if the CRTC needs a
modeset (e.g., when changing display resolution).

Since amdgpu_dm does not use standard DRM modeset helpers, the skipped
luminance update would never be applied to the hardware, and the backlight
would remain at its previous value.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index ed1f85650e280..0174339f0ee79 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -496,6 +497,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_=
connector *aconnector)
>  			dm->actual_brightness[aconnector->bl_idx] =3D real_brightness;
>  			dm->brightness[aconnector->bl_idx] =3D real_brightness;
>  		}
> +		/* Link the registered backlight device to the DRM connector. */
> +		drm_backlight_link(&aconnector->base, dm->backlight_dev[aconnector->bl=
_idx]);

[Severity: High]
Does this trigger a kernel WARN_ON and data race by dynamically creating the
LUMINANCE property after connector registration?

Because amdgpu_dm_register_backlight_device() is executed during the late
registration phase (amdgpu_dm_connector_late_register), the connector has
already been exposed to userspace.

The drm_backlight_link() call creates the LUMINANCE property dynamically,
but adding properties after registration is prohibited by the DRM core.

Could this also cause a data race if userspace iterates the connector's
properties array (e.g., reacting to a sysfs KOBJ_ADD uevent by issuing
DRM_IOCTL_MODE_GETCONNECTOR) locklessly while it is being reallocated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831210531.2334=
221-1-mario.limonciello@amd.com?part=3D8
