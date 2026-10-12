Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDEBCA9ED8
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 05:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 639C110ECA6;
	Mon, 12 Oct 2026 05:01:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D3210E417;
 Mon, 12 Oct 2026 05:01:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0DF160AB5;
 Mon, 12 Oct 2026 05:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332731F0089B;
 Mon, 12 Oct 2026 05:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791781308;
 bh=lyngVLtYKa77fxaxR8GxLgLQWY0G4ojXk3xhtYDZmsc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HmnrCGPDYvfiOZ0X5U43qznl6bASGqV4tRFe5eep0rAZ/TR6iunXeYbYcJGcTTM/0
 Z6C7RA+0Dkbetc6QAT7oNw7vmAHrVdZRd10kQoRIzdNGf+ApGSbzeJnCU0VAi9KxSn
 WK1cdUTpokSyQi/CaWtC/NEW6reKcM8cXySN3qDtIoa5JNYUh+lh3CdIFq7GNo3Eh9
 IJ41X8PUHE4VRNmI9j2w3ej2BEyrgmABv6hVwY0+7UZVDYfAD8UaE93EN3hqcBrwQo
 t/zHq+LNZ5m1imtr1OmUZxOU+Q26yRDWlsHCwwiCws3Rn3teGMyWprMWdsx+LZwfYH
 8AR9odpNUruWQ==
Message-ID: <sashiko-outbox-167649@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 56/56] drm/i915/hdmi: Allow Pipe joiner for HDMI
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-57-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-57-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:01:47 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/i915/hdmi: TMDS validation bypasses max plane size, breaking w=
ide modes and FRL joiner fallback
- [High] drm/i915: NULL pointer deref in intel_hdmi_has_joiner for SDVO
--

commit ede50d511c51a1eac2ca7425fa38667d98b1e4a1
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/hdmi: Allow Pipe joiner for HDMI

Pipe joiner is used only with FRL mode, so allow it only when the platform
and the sink both support FRL.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
[ ... ]
> @@ -4378,3 +4378,11 @@ void intel_hdmi_frl_get_config(struct intel_crtc_s=
tate *crtc_state)
> =20
>  	intel_hdmi_frl_dfm_read(crtc_state);
>  }
> +
> +bool intel_hdmi_has_joiner(struct intel_hdmi *intel_hdmi)
> +{
> +	struct intel_display *display =3D to_intel_display(intel_hdmi);
> +	struct intel_encoder *encoder =3D &hdmi_to_dig_port(intel_hdmi)->base;
> +
> +	return HAS_HDMI_FRL(display) && intel_bios_hdmi_max_frl_rate(encoder->d=
evdata);
> +}

[Severity: High]
Does the existing TMDS validation bypass the max plane size, breaking the w=
ide
modes and the FRL joiner fallback that this patch relies on?

In intel_hdmi_mode_valid_format(), if the TMDS clock is valid, it returns
MODE_OK immediately:

        status =3D intel_hdmi_tmds_mode_clock_valid(&connector->base, clock,
                                                  has_hdmi_sink, sink_forma=
t);

        if (status =3D=3D MODE_OK)
                return status;

This bypasses intel_mode_valid_max_plane_size(), meaning a mode with an
hdisplay greater than 5120 but a valid TMDS clock (like 7680x1080@60Hz) is
incorrectly advertised as valid to userspace.

Then during atomic commit in intel_hdmi_compute_config(), it tries TMDS fir=
st:

        ret =3D intel_hdmi_compute_formats(encoder, pipe_config,
                                         conn_state, false);

        if (ret && enable_frl) {
                ret =3D intel_hdmi_compute_formats(encoder, pipe_config,
                                                 conn_state, true);

Since TMDS only checks the clock and ignores the plane size, it succeeds and
skips the FRL fallback. Later, intel_plane_atomic_check() calling
skl_plane_check() rejects the un-split plane because the width exceeds the =
max
width of 5120, returning -EINVAL. This causes atomic commits to fail for
advertised modes and prevents the driver from falling back to FRL, where the
pipe joiner could have correctly handled the wide mode.

> diff --git a/drivers/gpu/drm/i915/display/intel_joiner.c b/drivers/gpu/dr=
m/i915/display/intel_joiner.c
> --- a/drivers/gpu/drm/i915/display/intel_joiner.c
> +++ b/drivers/gpu/drm/i915/display/intel_joiner.c
[ ... ]
> @@ -33,6 +34,9 @@ bool intel_joiner_connector_can_join(struct intel_conne=
ctor *connector)
>  	case DRM_MODE_CONNECTOR_DisplayPort:
>  	case DRM_MODE_CONNECTOR_eDP:
>  		return intel_dp_has_joiner(intel_attached_dp(connector));
> +	case DRM_MODE_CONNECTOR_HDMIA:
> +	case DRM_MODE_CONNECTOR_HDMIB:
> +		return intel_hdmi_has_joiner(intel_attached_hdmi(connector));

[Severity: High]
Does this code handle SDVO HDMI connectors correctly? When this is called f=
or
SDVO HDMI connectors on older platforms, the connector type is initialized =
to
DRM_MODE_CONNECTOR_HDMIA. However, SDVO HDMI connectors are not backed by an
intel_digital_port.

When intel_attached_hdmi() is called for an SDVO connector, it calls
enc_to_dig_port(), which evaluates to NULL because the encoder type is
INTEL_OUTPUT_SDVO. Then enc_to_intel_hdmi() takes the address of &NULL->hdm=
i,
resulting in an invalid pointer offset.

When this invalid pointer is passed to intel_hdmi_has_joiner(), the
to_intel_display() macro calls hdmi_to_dig_port(). This reverses the offset
back to NULL and dereferences it to find the device pointer, causing an
unconditional kernel panic during boot.

>  	default:
>  		return false;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D56
