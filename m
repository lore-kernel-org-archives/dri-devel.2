Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAE606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKv09H+y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F89F10E2A2;
	Mon, 26 Oct 2026 07:11:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE8310E2A2;
 Mon, 26 Oct 2026 07:11:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1F7F600DA;
 Mon, 26 Oct 2026 07:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529721F01825;
 Mon, 26 Oct 2026 07:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792998690;
 bh=799IyKvuAO7uQV6uccRk8uEueF5w3wG/Vg+rFiQGfoI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=IKv09H+yq+sbOEPANQ+bkTKGjRd8cMnk7AZ3IaDyzArww4BW9TiOFl2N9sYq6ppku
 KhR8ijNLNCzH7KDW0Rd51XHnjcK+1/RiJQNB1ghUyv97bqDiKOCWIqW1UYxHUBYjb6
 LZU8/PozPWI7I93CrQIlbDjecgWkeuAZaA3lVK/0LIsz13/BYDb98HmvO9CuuW4HAH
 3NMh1K9jq+KILu3FRd2GSfZ31EmmszxKsBaVQU6GNvuMVqtCXkhwEivZUGz2SbpXE7
 CQHzPiy9LkBat/X7XYDtEVRdIdpDzi2dbnX1FNKyLu5qIAYfZ1XlavK1R+7KEsr/g+
 gi/ol/1NC7WaQ==
Message-ID: <sashiko-outbox-184652@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/20] drm/i915/alpm: alpm_init() for DP2.1
To: "Animesh Manna" <animesh.manna@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261026054001.799894-5-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-5-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 07:11:29 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/i915/alpm: wrong transcoder ALPM_CTL access in intel_alpm_disa=
ble()
--

commit 16555494a05a6a62d73ca6ad3e0999793ea5b8b4
Author: Animesh Manna <animesh.manna@intel.com>

drm/i915/alpm: alpm_init() for DP2.1

This commit initializes ALPM for DP 2.1 on display version 35 and newer,
separating the ALPM mutex initialization from DPCD capability initialization
and checking source support instead of sink capabilities in
intel_alpm_disable().

> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index cb1d68fef1986..b6307862b7560 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
[ ... ]
> @@ -750,7 +763,11 @@ void intel_alpm_disable(struct intel_dp *intel_dp)
>  	struct intel_display *display =3D to_intel_display(intel_dp);
>  	enum transcoder cpu_transcoder =3D intel_dp->alpm.transcoder;
> =20
> -	if (DISPLAY_VER(display) < 20 || !intel_dp->alpm_dpcd)
> +	/*
> +	 * Don't check sink ALPM caps here, they are reset on disconnect
> +	 * before the CRTC is disabled.
> +	 */
> +	if (DISPLAY_VER(display) < 20 || !intel_alpm_source_supported(intel_dp))
>  		return;

[Severity: High]
Can replacing the intel_dp->alpm_dpcd check with
intel_alpm_source_supported(intel_dp) here cause intel_alpm_disable() to
modify ALPM_CTL on the wrong transcoder when ALPM was never configured on
intel_dp?

Because struct intel_digital_port is zero-allocated,
intel_dp->alpm.transcoder starts at 0 (TRANSCODER_A, rather than
INVALID_TRANSCODER), and intel_alpm_init() does not initialize it. Across
the driver, intel_dp->alpm.transcoder is only set in
intel_alpm_configure():

drivers/gpu/drm/i915/display/intel_alpm.c:intel_alpm_configure() {
	lnl_alpm_configure(intel_dp, crtc_state);
	intel_dp->alpm.transcoder =3D crtc_state->cpu_transcoder;
}

which is only called from intel_psr_enable_source() when
crtc_state->has_psr is true or from intel_alpm_lobf_enable() when
new_crtc_state->has_lobf is true.

However, intel_ddi_disable_dp() unconditionally calls
intel_alpm_disable(intel_dp) whenever any DP or eDP encoder is disabled:

drivers/gpu/drm/i915/display/intel_ddi.c:intel_ddi_disable_dp() {
	...
	intel_panel_unprepare(old_conn_state);
	intel_psr_disable(intel_dp, old_crtc_state);
	intel_alpm_disable(intel_dp);
	...
}

And intel_dp_short_pulse() also calls intel_alpm_disable(intel_dp) if
reading DP_RECEIVER_ALPM_STATUS fails or reports an error:

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_short_pulse() {
	...
	if (intel_alpm_get_error(intel_dp)) {
		intel_alpm_disable(intel_dp);
		intel_dp->alpm.sink_alpm_error =3D true;
	}
	...
}

Previously, !intel_dp->alpm_dpcd caused intel_alpm_disable() to return
early for external DP connectors and eDP panels without ALPM support. With
this change, if an external DP connector on DISPLAY_VER(display) >=3D 35 (or
an eDP connector on DISPLAY_VER(display) >=3D 20) is enabled on
TRANSCODER_B/C/D without PSR, Panel Replay, or LOBF, intel_alpm_configure()
is never called and intel_dp->alpm.transcoder remains TRANSCODER_A (or a
stale transcoder from a previous modeset).

When that connector is later disabled or hits the short HPD pulse error
path, intel_alpm_disable() will lock that connector's intel_dp->alpm.lock
and clear ALPM_CTL_ALPM_ENABLE | ALPM_CTL_LOBF_ENABLE in
ALPM_CTL(display, TRANSCODER_A). If TRANSCODER_A is active on another
connector (such as eDP on Pipe A), this races with Pipe A and disables its
active ALPM/LOBF state; if TRANSCODER_A's power well is off, it triggers an
unclaimed MMIO register access.

Should intel_dp->alpm.transcoder be initialized to INVALID_TRANSCODER in
intel_alpm_init(), reset to INVALID_TRANSCODER in intel_alpm_disable(), and
checked for INVALID_TRANSCODER before accessing ALPM_CTL()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026054001.7998=
94-1-animesh.manna@intel.com?part=3D4
