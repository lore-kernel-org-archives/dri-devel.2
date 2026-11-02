Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E6606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8kqkWNu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E33310F11A;
	Mon,  2 Nov 2026 18:17:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF86510F11A;
 Mon,  2 Nov 2026 18:17:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7671D43CD4;
 Mon,  2 Nov 2026 18:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C981F00A16;
 Mon,  2 Nov 2026 18:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793643456;
 bh=oGb9IJZmXS8J+4dewRtB+Tt+Cu4qeQQWLvEE8ttL52E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W8kqkWNumfz32fr93d/DzbBJRlmFuJ/kSpCwkVGTdvwQHZomPtQsp4QIQhyv6EK6z
 QI/Vve9AHcnIKjTCRdH+EpoYZ2C5VfjLRz2R9sLoOgwBsGMj+V/rdf3bJGAzWqd0nr
 DSS2EWe6YUoCfsNrwOEZJJImgIX3YaR5yfij7Dz5TNxzQDdsTIZ5GnEL8DQG+CMGTh
 f5TNJuBZa5+TcyTRPxMydnHl6qRNrp7LRvaborpZptHwZJ98Kwb1p83ziKVTItGtAX
 mKV3yFMb0yoHP+qunSeiJiY6idMg/22y6lc0m977GRLWvJHE04htoeVrGYbTRv22J1
 oJLpwNfkyHHpA==
Message-ID: <sashiko-outbox-193920@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/15] drm/i915/display: add luminance property support
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261102-superm1-backlight-property-v10-6-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-6-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:17:35 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/i915/display: missing acpi_video_backlight_use_native() call
- [Medium] drm/i915/display: stale backlight level programmed on modeset en=
able
- [Low] drm/i915/display: build failure in intel_backlight_set_luminance()
- [Low] drm/i915: unmet BACKLIGHT_CLASS_DEVICE dependency for ACPI_VIDEO
--

commit e18daa9a197d727d1dc5e00c9bb74f3e09fc2495
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/i915/display: add luminance property support

This commit adds support for the DRM LUMINANCE connector property on eDP,
LVDS, and DSI panels in i915 and Xe when CONFIG_DRM_LUMINANCE is enabled,
while retaining the backlight class device when it is disabled.

> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> index 71426b9c91f00..720191673a1e7 100644
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -26,7 +26,7 @@ config DRM_I915
>  	select IRQ_WORK
>  	# i915 depends on ACPI_VIDEO when ACPI is enabled
>  	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
> -	select BACKLIGHT_CLASS_DEVICE if ACPI
> +	select BACKLIGHT_CLASS_DEVICE if ACPI && !DRM_LUMINANCE
>  	select INPUT if ACPI
>  	select ACPI_WMI if ACPI
>  	select ACPI_VIDEO if ACPI

[Severity: Low]
Does this cause an unmet direct dependency for ACPI_VIDEO when
CONFIG_DRM_LUMINANCE=3Dy, CONFIG_ACPI=3Dy, and CONFIG_BACKLIGHT_CLASS_DEVIC=
E=3Dn?

In drivers/acpi/Kconfig, ACPI_VIDEO depends directly on
BACKLIGHT_CLASS_DEVICE:

    config ACPI_VIDEO
        tristate "Video"
        depends on BACKLIGHT_CLASS_DEVICE

Both DRM_I915 here and DRM_XE in drivers/gpu/drm/xe/Kconfig still have:

    select ACPI_VIDEO if ACPI

When DRM_LUMINANCE is enabled and nothing else selects
BACKLIGHT_CLASS_DEVICE, Kconfig warns about an unmet direct dependency on
BACKLIGHT_CLASS_DEVICE and drivers/acpi/acpi_video.c fails to link due to
undefined references to backlight_device_register() and
backlight_device_unregister().

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu=
/drm/i915/display/intel_backlight.c
> index b128896cb1c2d..6d658c7b5d99f 100644
> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c

[ ... ]

> @@ -1712,6 +1723,15 @@ int intel_backlight_setup(struct intel_connector *=
connector, enum pipe pipe)
>  	return 0;
>  }
> =20
> +void intel_backlight_set_luminance(const struct drm_connector_state *con=
n_state)
> +{
> +	struct intel_connector *connector =3D
> +		to_intel_connector(conn_state->connector);
> +
> +	intel_panel_set_backlight(conn_state, conn_state->luminance,
> +				  connector->panel.backlight.max);
> +}

[Severity: Low]
Will drivers/gpu/drm/i915/display/intel_backlight.c fail to build when
CONFIG_BACKLIGHT_CLASS_DEVICE is disabled?

In drivers/gpu/drm/i915/display/intel_backlight.c, scale_user_to_hw() and
intel_panel_set_backlight() are defined inside an
#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE) block:

    #if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
    static u32 intel_panel_get_backlight(struct intel_connector *connector)
    ...
    static void intel_panel_set_backlight(const struct drm_connector_state =
*conn_state,
                                          u32 user_level, u32 user_max)

Because intel_backlight_set_luminance() is compiled unconditionally outside
that guard, building with CONFIG_BACKLIGHT_CLASS_DEVICE=3Dn (for example wh=
en
CONFIG_DRM_LUMINANCE=3Dy) fails with an implicit declaration of
intel_panel_set_backlight().

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index d5d4453f283bb..3c81ed630c365 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -7696,6 +7696,8 @@ static void intel_atomic_commit_tail(struct intel_a=
tomic_state *state)
>  	/* Now enable the clocks, plane, pipe, and connectors that we set up. */
>  	display->modeset.funcs->commit_modeset_enables(state);
> =20
> +	drm_atomic_helper_commit_luminance_enables(&state->base);
> +
>  	intel_display_power_dc3co_compute(state);

[Severity: Medium]
When a panel's LUMINANCE property is updated while the CRTC is inactive (or
in the same atomic commit that enables the CRTC), doesn't calling
drm_atomic_helper_commit_luminance_enables() after commit_modeset_enables()
initially turn on the panel at the stale brightness level?

While the CRTC is inactive, drm_atomic_helper_commit_luminance_enables()
skips calling .set_luminance(), so panel->backlight.level keeps the old
hardware brightness level while conn_state->luminance holds the new value.

During a subsequent modeset enable in intel_atomic_commit_tail():

    display->modeset.funcs->commit_modeset_enables(state)
      -> intel_edp_backlight_on() / intel_enable_lvds() / gen11_dsi_enable()
        -> intel_backlight_enable()
          -> __intel_backlight_enable()
            -> panel->backlight.funcs->enable(crtc_state, conn_state,
                                              panel->backlight.level);

This powers on and programs the backlight with the old
panel->backlight.level and waits for vblank before
drm_atomic_helper_commit_luminance_enables() calls
intel_backlight_set_luminance() to update panel->backlight.level and
reprogram the hardware a second time.

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm=
/i915/display/intel_panel.c
> index 81e638d0c7b33..501573a75b89c 100644
> --- a/drivers/gpu/drm/i915/display/intel_panel.c
> +++ b/drivers/gpu/drm/i915/display/intel_panel.c
> @@ -610,9 +610,11 @@ int intel_panel_register(struct intel_connector *con=
nector)
>  	struct intel_panel *panel =3D &connector->panel;
>  	int ret;
> =20
> -	ret =3D intel_backlight_device_register(connector);
> -	if (ret)
> -		return ret;
> +	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
> +		ret =3D intel_backlight_device_register(connector);
> +		if (ret)
> +			return ret;
> +	}

[Severity: High]
When CONFIG_DRM_LUMINANCE is enabled, how does the driver coordinate with
ACPI video backlight detection and BIOS OpRegion ASLE backlight requests now
that intel_backlight_device_register() is skipped?

Previously, intel_backlight_device_register() called
acpi_video_backlight_use_native(), which notifies drivers/acpi/video_detect=
.c
that native GPU backlight control is present (setting native_available =3D =
true)
and checks whether native backlight control should be used. It also set
panel->backlight.device.

With intel_backlight_device_register() skipped and
intel_backlight_setup() attaching the LUMINANCE property without calling
acpi_video_backlight_use_native():

1. In drivers/gpu/drm/i915/display/intel_acpi.c, intel_acpi_video_register()
checks:

    if (panel->backlight.funcs && !panel->backlight.device) {
        acpi_video_register_backlight();
        break;
    }

Because panel->backlight.device is NULL and acpi_video_backlight_use_native=
()
was never called, intel_acpi_video_register() will register a conflicting
acpi_video backlight device if CONFIG_BACKLIGHT_CLASS_DEVICE is enabled.

2. In drivers/gpu/drm/i915/display/intel_opregion.c, asle_set_backlight()
checks:

    if (acpi_video_get_backlight_type() =3D=3D acpi_backlight_native) {
        drm_dbg_kms(display->drm,
                    "opregion backlight request ignored\n");
        return 0;
    }

Because acpi_video_backlight_use_native() was never called,
acpi_video_get_backlight_type() will not return acpi_backlight_native, so
BIOS OpRegion ASLE requests will call intel_backlight_set_acpi() and modify
panel->backlight.level behind the atomic LUMINANCE property's back.

3. In intel_backlight_setup(), the LUMINANCE property is attached even on
systems where acpi_video_backlight_use_native() would return false.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-ba=
cklight-property-v10-0-b2a6f24131f5@kernel.org?part=3D6
