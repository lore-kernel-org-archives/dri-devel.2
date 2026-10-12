Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697FDCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D14EB10E117;
	Mon, 12 Oct 2026 04:48:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5744210E3EA;
 Mon, 12 Oct 2026 04:48:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ACD5E601FA;
 Mon, 12 Oct 2026 04:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4D21F0089B;
 Mon, 12 Oct 2026 04:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780530;
 bh=SOW0sPLYeXj/M1VVqwSzxngbVVMbYl1lSWVTW+8Ja4Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gt1+qjQrapeRcI9OCLOL5ZiW3A5BXy56H8JhpYH6THnwMS460eiZ7rPSW5bsAA/ji
 Cl8+kWHvoKPhaIFHpEfXGFcetfqqYXoVbEtbF1JhcuY4wIroKtHGnKqnTNdKPboBsi
 qtvvy/EMpzPKTB8Ir9FHxWFhLx8EgX8vllajDr1LSXWYxPRjRjwEBQGZMsFgT6jC7E
 XPvt08Hbf4/u6E1lPZsOOWXoi37lsWRlaFNVGYy+9J8K1fYUodGy+E66+I9Nr9nA9N
 fXG5iqp+d9OCW3HeFA4ECapfgklRBrHl4RnovhcBjYQkUq1AGQjxm2R4PGrxHRBZ1+
 5uhDUXtwVFADg==
Message-ID: <sashiko-outbox-167628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 29/56] drm/i915/hdmi_frl_dfm: Add non dsc frl
 capacity computation helpers
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-30-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-30-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:48:49 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/i915: unsigned underflow defeats max() zero-clamping in FRL pa=
yload logic
- [High] drm/i915: unsigned underflow in margin calculation bypasses FRL ca=
pacity validation
- [High] drm/i915: 32-bit integer overflow artificially truncates required =
audio packet count
- [Medium] drm/i915/hdmi_frl: 32-bit integer overflows in DFM timing calcul=
ations
--

commit 6d21cc13348026a7ea42c4821a0b77f14d185b3e
Author: Vandita Kulkarni <vandita.kulkarni@intel.com>

drm/i915/hdmi_frl_dfm: Add non dsc frl capacity computation helpers

This commit adds helper functions to the i915 DRM driver for computing
non-DSC FRL link characteristics. It includes computations for DFM
constraints, link overheads, audio hblank requirements, and capacity
verifications.

[Severity: High]
In drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c, within the
get_num_char_rc_compressible() function, the calculation for cfrl_free is:

    cfrl_free =3D max(((hblank * kcdx100) / (100 * k420) - 32 *=20
                     audio_packets_line - 7), U32_MIN);

Since these variables are unsigned 32-bit integers, does this subtraction
underflow when the required audio blanking space exceeds the available
hardware hblank? If an underflow occurs, the value wraps to a huge positive
number. Because the comparison is unsigned, the max() macro would simply
return this huge positive value rather than clamping it to zero.

This huge value then propagates into get_num_char_compression_savings():

    u32 cfrl_savings =3D max(((7 * cfrl_free) / 8) - cfrl_margin, U32_MIN);

Could this corrupt the downstream link utilization checks and cause the
driver to incorrectly validate video modes that lack sufficient blanking
intervals?

[Severity: High]
In the verify_utilization_possible() function, the link capacity margin is
calculated as:

    margin =3D 1000 - (utilization + frl_dfm->params.overhead_max);

    if (margin > 0)
        return true;

If an over-utilized video mode requires more than 100 percent capacity
(where utilization + overhead_max > 1000), does the unsigned subtraction
underflow to a large positive value? This would cause the subsequent margin
greater than 0 check to evaluate to true, which might lead the driver to
validate modes that actually exceed the maximum FRL hardware bandwidth.

[Severity: High]
In the compute_audio_hblank_min() function, the required audio packets are
calculated using standard 32-bit multiplication:

    frl_dfm->params.num_audio_pkts_line =3D
        DIV_ROUND_UP(audio_pkt_rate * frl_dfm->params.line_time_ns,
                     FRL_TIMING_NS_MULTIPLIER);

For standard low-refresh display timings transmitting high sample-rate
audio (for instance, 192kHz multi-channel where audio_pkt_rate reaches
around 195,195, and a 1080p24 line time of around 37,037ns), the product
exceeds 7.2 billion. Does this overflow the U32_MAX limit of 4.29 billion,
causing silent integer truncation before the division?

Should this use mul_u32_u32() and DIV_ROUND_UP_ULL() to avoid calculating
artificially small audio packet requirements?

[Severity: Medium]
In the verify_frl_capacity_requirement() function, timing requirements are
calculated with direct 32-bit multiplication:

    tactive_ref_ns =3D (line_time_ns * hactive) / (hblank + hactive);
    tblank_ref_ns =3D (line_time_ns * hblank) / (hblank + hactive);

Although the commit message mentions using 64-bit math for DFM timing
products to avoid u32 overflow, these lines still appear to use 32-bit
arithmetic. If a user-space client requests a mode with a very low pixel
clock (where line_time_ns is large) and a large horizontal resolution, can
line_time_ns * hactive overflow a 32-bit integer?

If this wraps, it might trick the capacity check into returning true and
bypassing mode rejection for invalid display modes. Does this require a
transition to 64-bit arithmetic to safely handle edge-case timing values?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D29
