Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1511CA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D891E10E671;
	Mon, 12 Oct 2026 04:33:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8169510E4E7;
 Mon, 12 Oct 2026 04:33:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5246C41B39;
 Mon, 12 Oct 2026 04:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FA51F0089B;
 Mon, 12 Oct 2026 04:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791779620;
 bh=/RK7jEnZHk889z7tiVxmfO9tO9mHYDX8vsWG4euldhg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UgjLdvQyaQqnDEmVEEyCYjtpkbfHJ8NTbDuOwxl2IQmK8eh21ABovBCmWm4Hi/0Re
 dlOzj73Er3gIYQmcF8XxsF1r19/Z8P9qCsgAP0V4CNQo/HEpj1IRJiyAmhBdwl136J
 FMgoltJEwoYROXTm62DjgVMrZF8+CfmlRCASdo650fLUDk9N+qQE47DACHba6QGYkN
 dMS36WMrr1AkkV1tjrbVZHfQKa8jCihIfYc2q4q1pTbMHySQ4gnCtwP3AQoAwTJ549
 IPA2mDx1GIM0+hHXrlZ/gCHRPAJUYCEETr5AXNS45QFc8YWq1FsRKzJPOgFF7cKjP4
 gx7J5R1SuutSw==
Message-ID: <sashiko-outbox-167609@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/56] drm/i915/ddi_buf: Add Vswing table for HDMI FRL
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-24-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-24-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:33:39 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/i915: HDMI TMDS mode restricted from using new Vswing table
--

commit 1071ffaee88538fd9a5d81d11c59c1e1061c15b6
Author: Suraj Kandpal <suraj.kandpal@intel.com>

drm/i915/ddi_buf: Add Vswing table for HDMI FRL

This commit defines a Vswing table for HDMI FRL to set signal levels
for LT PHY on Xe3PLPD and onwards.

> diff --git a/drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c b/drivers=
/gpu/drm/i915/display/intel_ddi_buf_trans.c
> index cc5912178d9cd..597bf1c781045 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c
[ ... ]
> @@ -1164,6 +1165,14 @@ static const union intel_ddi_buf_trans_entry _xe3p=
lpd_lt_trans_edp[] =3D {
>  	{ .lt =3D { 1, 3, 0, 26, 0 } },
>  };
> =20
> +static const union intel_ddi_buf_trans_entry _xe3plpd_lt_trans_hdmi_frl[=
] =3D {
> +	{ .lt =3D { 0, 0, 0, 48, 0  } },
> +	{ .lt =3D { 0, 0, 4, 38, 6  } },
> +	{ .lt =3D { 0, 0, 4, 36, 8  } },
> +	{ .lt =3D { 0, 0, 4, 34, 10 } },
> +	{ .lt =3D { 0, 0, 4, 32, 12 } },
> +};
> +
>  static const struct intel_ddi_buf_trans xe3plpd_lt_trans_dp14 =3D {
>  	.entries =3D _xe3plpd_lt_trans_dp14,
>  	.num_entries =3D ARRAY_SIZE(_xe3plpd_lt_trans_dp14),
>  };

[Severity: High]
Because xe3plpd_lt_trans_dp14 lacks an explicit .hdmi_default_entry,
intel_ddi_hdmi_level() will silently default to index 0.

Index 0 of the dp14 table is { .lt =3D { 1, 0, 0, 21, 0 } }, which provides
a very low voltage swing of 21 instead of the 48 that is intended for
HDMI TMDS.

[ ... ]
> @@ -1780,6 +1794,9 @@ xe3plpd_get_lt_buf_trans(struct intel_encoder *enco=
der,
>  		return intel_get_buf_trans(&xe3plpd_lt_trans_uhbr, n_entries);
>  	else if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP))
>  		return intel_get_buf_trans(&xe3plpd_lt_trans_edp, n_entries);
> +	else if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI) &&
> +		 intel_hdmi_is_frl(crtc_state->port_clock))
> +		return intel_get_buf_trans(&xe3plpd_lt_trans_hdmi_frl, n_entries);
>  	else
>  		return intel_get_buf_trans(&xe3plpd_lt_trans_dp14, n_entries);
>  }

[Severity: High]
Does this condition incorrectly restrict HDMI TMDS outputs from utilizing
the new _xe3plpd_lt_trans_hdmi_frl table?

The newly introduced _xe3plpd_lt_trans_hdmi_frl table contains the entry
{ .lt =3D { 0, 0, 0, 48, 0 } } at index 0. This index is never accessed
during FRL training because intel_hdmi_frl_level() strictly returns 1-4.
The index 0 entry (voltage swing 48) appears to be explicitly designed
for HDMI TMDS.

However, by gating the use of this table with intel_hdmi_is_frl() here
in xe3plpd_get_lt_buf_trans(), HDMI TMDS configurations bypass it and
fall through to the xe3plpd_lt_trans_dp14 fallback table.

Because of the missing .hdmi_default_entry discussed above, this fallback
causes HDMI TMDS outputs to resolve to an invalid voltage swing of 21.

Could this result in poor signal integrity or link training failures for
TMDS HDMI sinks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D23
