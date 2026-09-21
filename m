Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9628FC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CAB10E050;
	Mon, 21 Sep 2026 16:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ho9/NaoW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42CAC10E050
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:08:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B4A74214F;
 Mon, 21 Sep 2026 16:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23671F000FF;
 Mon, 21 Sep 2026 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790006906;
 bh=09jzDk2SecoBb2lf99E5yZzEwmWqub87jUZjnBjLuX4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ho9/NaoWotb4zyeLWIkVMvHxt/eYBiAer9xDJr2nMonayw0uUUqZTGh2rWyOt807K
 NROuvDEXK8o6B9cTB2X2D1Ww/zfHo8FJJ27f3+yy+V3GdKKqbcrFa1ie4f4Jpcdra9
 M99gy/PgV7Of9H6aLXNSvadEi/DjlwbaddHchcYLvPy/tz7FEZp0VFgRZPbxUuNm1S
 BjrnJA8+YQX8dynT9WYXeZgTtnE2IC8ZfaLYDWGpB237t6Xb88nomc0eJurdOImj9O
 slmuDijvNoPY8yFRGYgezQ7sneFmsZ3v4fWKfftX4haL1pMCi4Xt9+kybNSkD7MKBJ
 ks8qonpAjsVFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/25] drm/edid: Add a query for vrr range
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-1-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-1-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:08:25 +0000
Message-Id: <20260921160825.E23671F000FF@smtp.kernel.org>
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
- [High] drm: false positive VRR capability for HDMI monitors with generic =
EDID range limits
- [Medium] drm: off-by-one payload length checks skip valid VRR limits in H=
F-VSDB
--

commit e42644d1c43977633d9a0e950d2749308a75d1b1
Author: Derek Foreman <derek.foreman@collabora.com>

drm/edid: Add a query for vrr range

This commit adds parsing for minimum and maximum VRR vertical rates from the
EDID.

> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 3148038747b6e..a1494028e0f5e 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
[ ... ]
> @@ -6309,6 +6309,25 @@ static void drm_parse_dsc_info(struct drm_hdmi_dsc=
_cap *hdmi_dsc,
>  		hdmi_dsc->total_chunk_kbytes =3D hf_scds[13] & DRM_EDID_DSC_TOTAL_CHUN=
K_KBYTES;
>  }
> =20
> +static void drm_parse_vrr_info(struct drm_display_info *info, const u8 *=
hf_scds)
> +{
> +	struct drm_monitor_range_info *range =3D &info->monitor_range;
> +	const int pld_len =3D cea_db_payload_len(hf_scds);
> +
> +	if (pld_len < 10)
> +		return;

[Severity: Medium]
Does this overly restrictive check skip parsing the VRR minimum frequency w=
hen
the payload is exactly 9 bytes?

If the payload length is 9, which is sufficient to contain the VRR minimum
at index 9, the condition evaluates to true and triggers an early return.
The monitor could lose HDMI VRR support or fall back to incorrect limits.

> +
> +	if (!range->min_vfreq)
> +		range->min_vfreq =3D FIELD_GET(DRM_EDID_VRR_MIN_MASK, hf_scds[9]);

[Severity: High]
Does this zero-check prevent the driver from overriding generic VESA limits
with explicit HDMI VRR limits?

Since generic VESA limits are parsed first and populate the monitor_range
structure, this check might actively prevent the function from applying the
explicit HDMI VRR limits, sealing the false positive capability check below.

> +
> +	if (pld_len < 11)
> +		return;

[Severity: Medium]
Does this similarly skip parsing the VRR maximum frequency when the payload
is exactly 10 bytes?

If the payload length is 10, which contains the VRR maximum at index 10,
this check causes an early return and skips reading the data.

> +
> +	if (!range->max_vfreq)
> +		range->max_vfreq =3D (FIELD_GET(DRM_EDID_VRR_MAX_UPPER_MASK, hf_scds[9=
]) << 8) |
> +				    hf_scds[10];
> +}
> +
>  /* Sink Capability Data Structure */
>  static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
>  				      const u8 *hf_scds)
[ ... ]
> @@ -6371,6 +6390,13 @@ static void drm_parse_hdmi_forum_scds(struct drm_c=
onnector *connector,
>  		dsc_support =3D true;
>  	}
> =20
> +	drm_parse_vrr_info(info, hf_scds);
> +
> +	if (info->monitor_range.min_vfreq > 0)
> +		hdmi->vrr_capable =3D true;
> +	else
> +		hdmi->vrr_capable =3D false;

[Severity: High]
Does this unconditionally assign HDMI VRR capability based on a field that
might be populated by generic VESA monitor range limits?

If a monitor provides generic VESA continuous frequency range limits but
does not support explicit HDMI VRR in the HF-VSDB, it might still have a
non-zero min_vfreq. This could falsely mark the monitor as HDMI VRR capable,
causing the driver to attempt VRR signaling on unsupported hardware and
leading to blank screens, flickering, or modeset failures.

> +
>  	drm_dbg_kms(connector->dev,
>  		    "[CONNECTOR:%d:%s] HF-VSDB: max TMDS clock: %d KHz, HDMI 2.1 suppo=
rt: %s, DSC 1.2 support: %s\n",
>  		    connector->base.id, connector->name,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D1
