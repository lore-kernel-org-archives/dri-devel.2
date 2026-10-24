Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C2606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7kzU72C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249D610E02D;
	Sat, 24 Oct 2026 12:20:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE2D10E02D;
 Sat, 24 Oct 2026 12:19:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9103441228;
 Sat, 24 Oct 2026 12:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5BD1F01825;
 Sat, 24 Oct 2026 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792844398;
 bh=dtE7j/jX/gKHJiZ1uT4G8lAYvOj53k+dec7TisSIbOQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=l7kzU72CB6r0KSISrf6sHP5gP3jQLLzxd9vz2fa+Lpmu1YEn3MCDZoa1VdsBcG62Q
 5w2WkaqfCgUJit5LNdRqE0V6kRku8V9y91lIMhvlBBrons30dxv9sXN1Yuge62468M
 zdJH5B2UojICADuzYoeAPfRT9ogMfVV795uJNFG9B7QSnhu9vYoN9ExNhmCEIpKcUj
 YKHygIVdIkVqQpyBpPXIg3ZXtEmvYM/H5BP3f5aKkeTAR7vhIJpTdEhFJmAKms5WXp
 2EamCTMnMTJQvjOdISx08fWAHbhryw+JlHCQCDi3gyYmigcvlAP0b6z/GEO9tOgdV7
 OYknXkdS9bn8w==
Message-ID: <sashiko-outbox-183708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/hdmi: preserve cached EDID on DDC failure when
 connector is forced
To: "Aman Sharma" <amansharma6122002@gmail.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <179284356403.1659508.10439113185286055496@gmail.com>
References: <179284356403.1659508.10439113185286055496@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 12:19:57 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] drm/i915/hdmi: cached EDID still wiped by intel_hdmi_detect() on=
 hotplug
- [Medium] drm/i915/hdmi: stale dp_dual_mode state in intel_hdmi_force()
- [Medium] drm/i915/hdmi: stale detect_edid retained after Gen11+ disconnect
--

commit 3cd457134d1b7d17ad43e200eb7f55647f7587b7
Author: Aman Sharma <amansharma6122002@gmail.com>

drm/i915/hdmi: preserve cached EDID on DDC failure when connector is forced

This commit retains the previously cached connector->detect_edid when a DDC
read fails on a forced-on HDMI connector instead of unconditionally clearing
it in intel_hdmi_force(). This avoids wiping the cached EDID and falling ba=
ck
to the 1024x768 no-EDID mode when an external monitor powers down its DDC/I=
2C
controller during DPMS standby.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index b6fa1a1558b82..140d98a61a9c6 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -2568,6 +2568,18 @@ intel_hdmi_set_edid(struct drm_connector *_connect=
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
> +	if (!drm_edid && connector->base.force && connector->detect_edid) {
> +		intel_display_power_put(display, POWER_DOMAIN_GMBUS, wakeref);
> +		return true;
> +	}

[Severity: Medium]
Will this check ever trigger when intel_hdmi_set_edid() is called from the
hotplug detection path, or will intel_hdmi_detect() still wipe
connector->detect_edid on hotplug?

Even when connector->base.force is set, hotplug and poll handling in
drivers/gpu/drm/i915/display/intel_hotplug.c still runs
intel_hotplug_detect_connector() -> drm_helper_probe_detect() ->
intel_hdmi_detect():

drivers/gpu/drm/i915/display/intel_hotplug.c:intel_hotplug_detect_connector=
() {
	...
	status =3D drm_helper_probe_detect(&connector->base, NULL, false);
	if (!connector->base.force)
		connector->base.status =3D status;
	...
}

In drivers/gpu/drm/i915/display/intel_hdmi.c, intel_hdmi_detect() is the on=
ly
caller that checks the boolean return value of intel_hdmi_set_edid(), and it
still unconditionally calls intel_hdmi_unset_edid() first:

drivers/gpu/drm/i915/display/intel_hdmi.c:intel_hdmi_detect() {
	...
	if (DISPLAY_VER(display) >=3D 11 &&
	    !intel_digital_port_connected(encoder))
		goto out;

	intel_hdmi_unset_edid(&connector->base);

	if (intel_hdmi_set_edid(&connector->base))
		status =3D connector_status_connected;
	...
}

On DISPLAY_VER(display) < 11, or on DISPLAY_VER(display) >=3D 11 when
intel_digital_port_connected(encoder) is true during standby or wake-up whi=
le
DDC is still powered down, intel_hdmi_unset_edid() frees
connector->detect_edid and sets it to NULL before intel_hdmi_set_edid() is
called.

When intel_hdmi_set_edid() then sees connector->detect_edid =3D=3D NULL, it=
 calls
drm_edid_connector_update(&connector->base, NULL) and returns false. Because
drm_helper_probe_detect_ctx() sees the returned status differ from the forc=
ed
connector->status, it increments connector->epoch_counter and triggers a
hotplug uevent, causing the subsequent userspace mode probe to find
connector->detect_edid already cleared and fall back to 1024x768 anyway.

Should intel_hdmi_detect() also avoid calling intel_hdmi_unset_edid() up
front so that connector->detect_edid is preserved across hotplug detection =
on
a forced connector?

[Severity: Medium]
Can this early return also leave connector->detect_edid out of sync with
connector->base.edid_blob_ptr if an unforced connector on DISPLAY_VER >=3D =
11
is unplugged and later forced on?

In drivers/gpu/drm/i915/display/intel_hdmi.c, when a sink is disconnected on
DISPLAY_VER(display) >=3D 11, intel_hdmi_detect() jumps to out before calli=
ng
intel_hdmi_unset_edid():

drivers/gpu/drm/i915/display/intel_hdmi.c:intel_hdmi_detect() {
	...
	if (DISPLAY_VER(display) >=3D 11 &&
	    !intel_digital_port_connected(encoder))
		goto out;

	intel_hdmi_unset_edid(&connector->base);
	...
}

When the connector is not forced, drm_helper_probe_single_connector_modes()
in drivers/gpu/drm/drm_probe_helper.c handles connector_status_disconnected
by clearing the EDID property to NULL while connector->detect_edid remains
non-NULL:

drivers/gpu/drm/drm_probe_helper.c:drm_helper_probe_single_connector_modes(=
) {
	...
	if (connector->status =3D=3D connector_status_disconnected) {
		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] disconnected\n",
			    connector->base.id, connector->name);
		drm_connector_update_edid_property(connector, NULL);
		drm_mode_prune_invalid(dev, &connector->modes, false);
		goto exit;
	}
	...
}

If the user subsequently forces the connector on (for example via sysfs)
while disconnected or while DDC fails, drm_helper_probe_single_connector_mo=
des()
calls intel_hdmi_force() -> intel_hdmi_set_edid(). Because
connector->detect_edid is still non-NULL from the previously unplugged
monitor, intel_hdmi_set_edid() will hit this early return without calling
drm_edid_connector_update(), retaining the unplugged monitor's stale
connector->detect_edid while connector->base.edid_blob_ptr remains NULL.

> +
> +	drm_edid_free(connector->detect_edid);
> +
>  	/* Below we depend on display info having been updated */
>  	drm_edid_connector_update(&connector->base, drm_edid);
> =20
> @@ -2638,10 +2650,10 @@ intel_hdmi_force(struct drm_connector *_connector)
>  	if (!intel_display_driver_check_access(display))
>  		return;
> =20
> -	intel_hdmi_unset_edid(&connector->base);
> -
> -	if (connector->base.status !=3D connector_status_connected)
> +	if (connector->base.status !=3D connector_status_connected) {
> +		intel_hdmi_unset_edid(&connector->base);
>  		return;
> +	}
> =20
>  	intel_hdmi_set_edid(&connector->base);
>  }

[Severity: Medium]
Does skipping intel_hdmi_unset_edid() in intel_hdmi_force() when
connector->base.status =3D=3D connector_status_connected leave stale
intel_hdmi->dp_dual_mode state behind when a new EDID is read?

Previously, intel_hdmi_force() called intel_hdmi_unset_edid(), which resets
intel_hdmi->dp_dual_mode in addition to freeing connector->detect_edid:

drivers/gpu/drm/i915/display/intel_hdmi.c:intel_hdmi_unset_edid() {
	...
	intel_hdmi->dp_dual_mode.type =3D DRM_DP_DUAL_MODE_NONE;
	intel_hdmi->dp_dual_mode.max_tmds_clock =3D 0;

	drm_edid_free(connector->detect_edid);
	connector->detect_edid =3D NULL;
}

When intel_hdmi_force() instead calls intel_hdmi_set_edid() directly and a
new EDID is read, intel_hdmi_set_edid() frees connector->detect_edid and
calls intel_hdmi_dp_dual_mode_detect(), which returns early without clearing
hdmi->dp_dual_mode when type =3D=3D DRM_DP_DUAL_MODE_NONE:

drivers/gpu/drm/i915/display/intel_hdmi.c:intel_hdmi_dp_dual_mode_detect() {
	...
	if (type =3D=3D DRM_DP_DUAL_MODE_NONE)
		return;

	hdmi->dp_dual_mode.type =3D type;
	hdmi->dp_dual_mode.max_tmds_clock =3D
		drm_dp_dual_mode_max_tmds_clock(display->drm, type, ddc);
	...
}

If a DP++ adaptor was previously connected, or if an unforced connector had
assumed DRM_DP_DUAL_MODE_TYPE1_DVI from VBT before being forced on via sysf=
s,
won't intel_hdmi->dp_dual_mode.type and intel_hdmi->dp_dual_mode.max_tmds_c=
lock
retain their old values, causing hdmi_port_clock_limit() to clamp the maxim=
um
TMDS clock and intel_dp_dual_mode_set_tmds_output() to send DP++ I2C writes
to a native HDMI sink?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179284356403.165950=
8.10439113185286055496@gmail.com?part=3D1
