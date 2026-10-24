Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF48606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDhmsvR5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A97D10E582;
	Sat, 24 Oct 2026 12:47:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC6310E534;
 Sat, 24 Oct 2026 12:47:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 62B99601DE;
 Sat, 24 Oct 2026 12:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7A91F01825;
 Sat, 24 Oct 2026 12:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792846054;
 bh=tmF62NjlscGkeWZQjI3YN977k0WOLrEhQNAYoYbUTKI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=LDhmsvR5OPS90ZFWZo9Q/gCK0Ix37mbFsOYnIGvL3922jcAe/ksp4OUSUAdsxvo7t
 jqwNHfKMcUu75JP9pPcCnaPN7LMz3obVHDAuOuqPQTSLTYUeDg9OYmq3Msff58i+AL
 W2kvbpfASpVa4UzS33QsXuPJJt9Ja/DrKbmk0UUrIuAVBUPB4w2ZSYFgab7bW7+htM
 EXzS2yb8TVQkTRCtAGDAdIGdI5eZHSiDVLtQTOAyAseYKX/JfXv91PV7PvK9iUz56o
 pkmZ1PrMa8GqjSXQ6KZ94bMfjfWRFQPPqxUfgC1jAemygLaS9x5F8tbNBws/iBWHql
 0K54UFdBTdX6g==
Message-ID: <sashiko-outbox-183732@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/i915/hdmi: preserve cached EDID on DDC failure
 when connector is forced
To: "Aman Sharma" <amansharma6122002@gmail.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <179284522321.1666644.7085985666852699043@gmail.com>
References: <179284356403.1659508.10439113185286055496@gmail.com>
 <179284522321.1666644.7085985666852699043@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 12:47:33 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/i915/hdmi: DRM_FORCE_OFF treated as forced-on in intel_hdmi_=
set_edid()
- [Medium] drm/i915/hdmi: CEC invalidation and hotplug churn in intel_hdmi_=
detect()
--

commit fa3007d46f607179adb22d75054bb3efa254e38b
Author: Aman Sharma <amansharma6122002@gmail.com>

drm/i915/hdmi: preserve cached EDID on DDC failure when connector is forced

This commit preserves the cached detect_edid on forced HDMI connectors when
DDC reads fail during monitor standby, moving intel_hdmi_unset_edid() into
intel_hdmi_set_edid() and skipping EDID teardown on Gen11+ disconnect when
the connector is forced.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index b6fa1a1558b82..89ab9a790a419 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -2568,6 +2568,19 @@ intel_hdmi_set_edid(struct drm_connector *_connect=
or)
>  		intel_gmbus_force_bit(ddc, false);
>  	}
> =20
> +	/*
> +	 * If the connector is forced on (e.g. video=3DHDMI-A-1:e) and the sink=
's
> +	 * DDC/I2C bus is powered down during DPMS standby, keep the previously
> +	 * cached EDID rather than wiping it and falling back to 1024x768.
> +	 */
> +	if (!drm_edid && connector->base.force &&
> +	    connector->detect_edid && connector->base.edid_blob_ptr) {
> +		intel_display_power_put(display, POWER_DOMAIN_GMBUS, wakeref);
> +		return true;
> +	}

[Severity: Medium]
What happens here when a connector with a cached EDID is forced off via
DRM_FORCE_OFF?

Because enum drm_connector_force defines DRM_FORCE_OFF as a non-zero value,
connector->base.force evaluates to true when the connector is forced off
(for example via connector_write() in drivers/gpu/drm/drm_debugfs.c, which
sets connector->force =3D DRM_FORCE_OFF without calling fill_modes() or
intel_hdmi_force()).

When a subsequent probe runs intel_hdmi_detect() -> intel_hdmi_set_edid(),
drm_edid_read_ddc() explicitly returns NULL for DRM_FORCE_OFF:

drivers/gpu/drm/drm_edid.c:drm_edid_read_ddc() {
	if (connector->force =3D=3D DRM_FORCE_OFF)
		return NULL;
    ...
}

In that case, intel_hdmi_set_edid() will match !drm_edid &&
connector->base.force, skip intel_hdmi_unset_edid() and
drm_edid_connector_update(), retain the stale detect_edid and dp_dual_mode
state, and return true as if the forced-off connector were connected. The
same boolean check in intel_hdmi_detect() also skips
intel_hdmi_unset_edid() on Gen11+ disconnect when force is DRM_FORCE_OFF.

Should these checks explicitly test for >=3D DRM_FORCE_ON (or !=3D DRM_FORC=
E_OFF
&& !=3D DRM_FORCE_UNSPECIFIED) instead of a boolean check on
connector->base.force?

> +
> +	intel_hdmi_unset_edid(&connector->base);
> +
>  	/* Below we depend on display info having been updated */
>  	drm_edid_connector_update(&connector->base, drm_edid);
> =20
> @@ -2609,10 +2622,11 @@ intel_hdmi_detect(struct drm_connector *_connecto=
r, bool force)
>  	wakeref =3D intel_display_power_get(display, POWER_DOMAIN_GMBUS);
> =20
>  	if (DISPLAY_VER(display) >=3D 11 &&
> -	    !intel_digital_port_connected(encoder))
> +	    !intel_digital_port_connected(encoder)) {
> +		if (!connector->base.force)
> +			intel_hdmi_unset_edid(&connector->base);
>  		goto out;
> -
> -	intel_hdmi_unset_edid(&connector->base);
> +	}

[Severity: Medium]
On DISPLAY_VER(display) >=3D 11, if the sink drops HPD during standby so
!intel_digital_port_connected(encoder) is true on a forced-on connector,
could jumping to out with status =3D connector_status_disconnected cause CEC
invalidation and hotplug churn?

In intel_hdmi_detect(), jumping to out leaves status set to
connector_status_disconnected:

drivers/gpu/drm/i915/display/intel_hdmi.c:intel_hdmi_detect() {
    ...
out:
	intel_display_power_put(display, POWER_DOMAIN_GMBUS, wakeref);

	if (status !=3D connector_status_connected)
		cec_notifier_phys_addr_invalidate(intel_hdmi->cec_notifier);

	return status;
}

First, this invalidates cec_notifier even though connector->detect_edid and
display_info are kept, and subsequent calls to intel_hdmi_force() ->
intel_hdmi_set_edid() while DDC is powered down return early before reaching
cec_notifier_set_phys_addr().

Second, returning connector_status_disconnected while connector->base.status
remains forced to connector_status_connected causes
drm_helper_probe_detect_ctx() to see ret !=3D connector->status and increme=
nt
connector->epoch_counter on every probe:

drivers/gpu/drm/drm_probe_helper.c:drm_helper_probe_detect_ctx() {
    ...
	if (ret !=3D connector->status)
		connector->epoch_counter +=3D 1;
    ...
}

In intel_hotplug_detect_connector(), connector->base.status is not updated
when connector->base.force is set, so old_epoch_counter !=3D
connector->base.epoch_counter triggers INTEL_HOTPLUG_CHANGED and sends
hotplug uevents on every HPD or poll while the sink is in standby.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179284522321.166664=
4.7085985666852699043@gmail.com?part=3D1
