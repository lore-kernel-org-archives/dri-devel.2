Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E688FCA9ED8
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E90C10E426;
	Mon, 12 Oct 2026 04:57:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D444610E19E;
 Mon, 12 Oct 2026 04:57:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A563443CB2;
 Mon, 12 Oct 2026 04:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473881F0089B;
 Mon, 12 Oct 2026 04:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791781020;
 bh=FpOWpXMW8ZRnZz1SOveLZVrcvB1sxHwMoRpU6Y2N7yY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OKDpoCvHLirQb6BW/4DKCktY/h99rfQZuN9OGqINDuI61e5/xiiyHuNGld9kwYw87
 sbDmrfxARFZ495zXfRgLrRgi57n9MpiCJQAeQ9FRJMrxGEqf1ci5f0UkgK11QK6DHB
 6FjdPvuze8bPVoj6aNXwykGzU3HGSLrwUUEGCWER9/cjA/f6PiFmrFquf6cYtI7KvV
 K/ACnFOZrip0ZI8UdjmSzhy6pLy6Ks1SgVuWVCj/Rz0aS7ozSUqHlicIqIgWKfU7Xy
 6Rov/3GXEWgH8E6pHXqwRPndnujJIFNzmJuDje3moplMLLPczCWewRLVnADd/VDFuH
 yTjbpNJIV4qnA==
Message-ID: <sashiko-outbox-167646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 37/56] drm/i915/hdmi: Add FRL port clock valid
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-38-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-38-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:56:59 +0000
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
- [Medium] drm/i915/hdmi: FRL mode_valid rejects valid modes by checking ma=
x_rate instead of required rate
--

commit a29948ea9df1fcfe40f2c9e5a0c8d6354286b145
Author: Vandita Kulkarni <vandita.kulkarni@intel.com>

drm/i915/hdmi: Add FRL port clock valid

Introduce hdmi_port_frl_clock_valid() which validates the FRL link
rate against the maximum FRL rate and the source PHY (c10/c20 or LT).

Call this from the FRL mode_valid path.

Since PHY PLL table units are in 10 kbps, add a macro to convert FRL
rate per lane in Gbps to 10 kbps.

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index b82c636b46f93..8e742165a50ad 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
[ ... ]
> @@ -2046,6 +2061,7 @@ intel_hdmi_frl_mode_clock_valid(struct intel_connec=
tor *connector,
>  	struct intel_hdmi_frl_dfm frl_dfm =3D {};
>  	int max_rate =3D hdmi->max_frl_rate;
>  	int lanes =3D max_rate < 24 ? 3 : 4;
> +	int port_clock;
> =20
>  	frl_dfm.config.pixel_clock_nominal_khz =3D mode->clock;
>  	frl_dfm.config.hactive =3D mode->hdisplay;
> @@ -2064,7 +2080,9 @@ intel_hdmi_frl_mode_clock_valid(struct intel_connec=
tor *connector,
>  	if (!intel_hdmi_frl_dfm_nondsc_requirement_met(&frl_dfm))
>  		return MODE_CLOCK_HIGH;
> =20
> -	return MODE_OK;
> +	port_clock =3D FRL_GBPS_TO_10KBPS(max_rate / lanes);
> +
> +	return hdmi_port_frl_clock_valid(hdmi, port_clock);
>  }

[Severity: Medium]
Does this code reject valid modes by checking the absolute maximum FRL rate
rather than the rate required by the mode?

In intel_hdmi_frl_mode_clock_valid(), port_clock is computed from the absol=
ute
maximum FRL rate (hdmi->max_frl_rate) allowed by the sink EDID and VBT. The
function then checks if the PHY supports this exact max_rate.

However, hdmi->max_frl_rate is never clamped to the PHY's actual capabiliti=
es
during initialization. If max_frl_rate exceeds the PHY's capabilities, or if
it evaluates to an invalid non-standard rate, hdmi_port_frl_clock_valid()
returns MODE_CLOCK_RANGE, rejecting all FRL modes.

For example, if an OEM limits the VBT to HDMI_MAX_FRL_RATE_3G,
max_src_frl_rate incorrectly evaluates to 12 Gbps (3 * 4). If the sink supp=
orts
>=3D 18 Gbps, max_frl_rate becomes 12. The port_clock is then computed as
12 / 3 =3D 4 Gbps (400000 10kbps). Because 400000 is not in the PHY tables,=
 the
PHY check fails.

Does this break FRL entirely on that platform, rejecting even low-bandwidth
modes the PHY could support?

While compute_config iterates through supported rates in later patches,
mode_valid remains hardcoded to test max_rate through the end of the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D37
