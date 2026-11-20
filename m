Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E2606A500
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gepsF1oV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6BD112625;
	Fri, 20 Nov 2026 06:15:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D952112598;
 Fri, 20 Nov 2026 06:15:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 707D961D5D;
 Fri, 20 Nov 2026 06:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CB71F000C4;
 Fri, 20 Nov 2026 06:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795155307;
 bh=GRbvgJJWFSlVigZd+xmH46CWx0Lpi5Q22MWtBJUCdqs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gepsF1oVbhaDEUQqxcfpjBEGq8gCtQWmYClpEh7xHqdLXKsDPmjuLTpEu9QmsOy8C
 qcriFuG04QozUEzU9VGqRE/NqZrP/MC3vYHukqXmrC8DwWyNoE/spNniVB0asAsST5
 eaVWAHSoAoSss97nkdJTHZKelFfoi3lk4oXEguUKXhGSEG47i9Wvl3nUKKQgQUakA4
 sfRfsl3g0pGSWgW9b0oHFckX8Tgl79L0UdPetkKLUZfT3ndnannumPO0lX2QXx9KZx
 Vk0hhcnlPssb5qrn4PjzoOUViUpxWMBc6Alc5kOu24CctDaVUQtBiZz4NjL32kRaVm
 uaWFMACwV/vbA==
Message-ID: <sashiko-outbox-224547@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP when
 TCON supports HDR
To: "Yitian Shao" <fighters390@qq.com>, intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <tencent_083AD2514CBC235A9F55EE00BDF72D3B9209@qq.com>
References: <tencent_083AD2514CBC235A9F55EE00BDF72D3B9209@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 06:15:06 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/i915/dp: broken LSPCON HDR in
  intel_dp_compute_hdr_metadata_infoframe_sdp()
- [Medium] drm/i915/dp: unchecked union read of intel_cap in
  intel_dp_add_properties()
- [Medium] drm/i915/dp: fastset skips TCON HDR update when SDP
  computation is bypassed
--

commit ee42402ceca82543288507d878602e90d81ac27f
Author: Yitian Shao <fighters390@qq.com>

drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP when TCON supports HDR

This commit attaches the HDR_OUTPUT_METADATA property on eDP connectors
whose TCON supports PQ (ST2084) decoding via the Intel AUX HDR interface,
and skips computing the HDR metadata infoframe SDP when the encoder does
not support gamut metadata DIP.

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 47741957935ae..3faa5ddb4c60b 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -3239,6 +3239,9 @@ intel_dp_compute_hdr_metadata_infoframe_sdp(struct =
intel_dp *intel_dp,
>  	int ret;
>  	struct hdmi_drm_infoframe *drm_infoframe =3D &crtc_state->infoframes.dr=
m.drm;
> =20
> +	if (!intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
> +		return;
> +
>  	if (!conn_state->hdr_output_metadata)
>  		return;

[Severity: High]
Does this break HDR metadata transmission on LSPCON outputs?

intel_dp_has_gamut_metadata_dip() unconditionally returns false when
intel_bios_encoder_is_lspcon(encoder->devdata) is true, because LSPCON
connectors defer attaching HDR_OUTPUT_METADATA until
intel_dp_connector_register() probes intel_lspcon_detect_hdr_capability().
LSPCON encoders still rely on intel_dp_compute_hdr_metadata_infoframe_sdp()
to populate crtc_state->infoframes.drm.drm and enable
HDMI_PACKET_TYPE_GAMUT_METADATA in crtc_state->infoframes.enable for
lspcon_write_infoframe().  With this check, HDR metadata is never computed
or sent on LSPCON ports, and the state checker will report an infoframe
mismatch if VIDEO_DIP_ENABLE_GMP_HSW was already active.

[Severity: Medium]
When intel_dp_compute_hdr_metadata_infoframe_sdp() returns early on pre-ICL
port A eDP panels, can a fastset skip programming the TCON HDR parameters?

When userspace toggles HDR_OUTPUT_METADATA,
intel_digital_connector_atomic_check() sets crtc_state->mode_changed =3D tr=
ue,
and on platforms with gamut metadata DIP the resulting change in
crtc_state->infoframes.enable causes intel_pipe_config_compare() to reject
fastset and run a full modeset.  Returning early here leaves
crtc_state->infoframes.enable unchanged, so commits without another pipe
config change are downgraded to a fastset (update_pipe).  On the fastset
path, intel_ddi_update_pipe_dp() calls intel_backlight_update(), which only
calls __intel_backlight_enable() -> intel_dp_aux_hdr_enable_backlight()
when !panel->backlight.enabled:

drivers/gpu/drm/i915/display/intel_backlight.c:intel_backlight_update() {
    ...
	mutex_lock(&display->backlight.lock);
	if (!panel->backlight.enabled)
		__intel_backlight_enable(crtc_state, conn_state);

	mutex_unlock(&display->backlight.lock);
    ...
}

Because panel->backlight.enabled is already true on an active panel,
INTEL_EDP_HDR_GETSET_CTRL_PARAMS is never updated in the TCON.

> @@ -7018,7 +7021,9 @@ intel_dp_add_properties(struct intel_dp *intel_dp, =
struct drm_connector *_connec
>  		intel_attach_dp_colorspace_property(&connector->base);
>  	}
> =20
> -	if (intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
> +	if (intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base) ||
> +	    (intel_dp_is_edp(intel_dp) &&
> +	     connector->panel.backlight.edp.intel_cap.supports_2084_decode))
>  		drm_connector_attach_hdr_output_metadata_property(&connector->base);
> =20
>  	if (HAS_VRR(display))

[Severity: Medium]
Can reading connector->panel.backlight.edp.intel_cap.supports_2084_decode
here access the wrong union member when the VESA eDP AUX backlight
interface is selected?

In struct intel_panel, panel.backlight.edp is an untagged union between
vesa and intel_cap:

drivers/gpu/drm/i915/display/intel_display_types.h:struct intel_panel {
    ...
		union {
			struct {
				struct drm_edp_backlight_info info;
				bool luminance_control_support;
			} vesa;
			struct {
				bool sdr_uses_aux;
				bool supports_2084_decode;
    ...
}

supports_2084_decode sits at byte offset 1, overlapping
vesa.info.pwm_freq_pre_divider in struct drm_edp_backlight_info.  If
intel_edp_backlight_setup() selected the VESA AUX backlight path instead of
the Intel HDR AUX path, drm_edp_backlight_init() populates vesa.info and a
non-zero pwm_freq_pre_divider will falsely attach HDR_OUTPUT_METADATA (and
trigger an out-of-range bool load under UBSan if the divider is >=3D 2).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_083AD2514CB=
C235A9F55EE00BDF72D3B9209@qq.com?part=3D1
