Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B92C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B0D10E20A;
	Wed,  5 Aug 2026 12:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="obuLpPZN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC6A810E20A
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 12:23:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3CE160A75;
 Wed,  5 Aug 2026 12:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607661F000E9;
 Wed,  5 Aug 2026 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785932601;
 bh=yGkT0vQ0zp/p3QgqkKlA4D865YPX8ZG9tTguALeR7dQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=obuLpPZN8CXWJxpTe05S7i8iKsNPqAQBjyqZm0lNyb5mJJtnsJf7ACFCTAQMpxuPs
 B6ZULLytWhY76XTnzehJ5CPm2MY+G/WSOqJ24CPF5bCvHI/fRaPt/pFIy4YJ9MxEK7
 uIWyDCZ6XuFyG5DvmHDzz7oIFk1TRffUlpClvXh65djrV7tq4DQJdNi6sOpObp92IB
 4jo9Qfq6Sumb2Ilu74Q04O48dqVVAlwn8zRL+Pqb64N1eGVqRqpWPZi/hJlCdASqd4
 X93mLEriW5sfrkZ1hSOVZxe9mbgMYPyJmoiOovtaDI1tbUlvOpZeSIMMZi6+4Ep7//
 /Ivtno9QRzXfg==
From: sashiko-bot@kernel.org
Subject: Re: Patch "drm/dp: Read the PCON max FRL bandwidth only for HDMI
 DFPs" has been added to the 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2026080551-trimming-acting-66fa@gregkh>
References: <2026080551-trimming-acting-66fa@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:23:20 +0000
Message-Id: <20260805122321.607661F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unvalidated access to `intel_dp->downstream_ports[2]` in `intel_dp=
_check_frl_training` can lead to unintended DPCD writes on non-PCON branch =
devices.
--

--- Patch [1]: Patch "drm/dp: Read the PCON max FRL bandwidth only for HDMI=
 DFPs" has been added to the 6.12-stable tree ---
commit 2ea84f7dc055ccb41f2cbb8400d14ddf081c3a76
Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
Date:   Wed Aug 5 12:04:51 2026 +0000

drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs

This commit updates drm_dp_get_pcon_max_frl_bw() to verify that the DFP is =
an
HDMI port and that detailed capability information is available before pars=
ing
the PCON max FRL bandwidth. This prevents misinterpreting DP descriptors as=
 FRL
bandwidth limits, which previously caused valid high-resolution display mod=
es
to be pruned on some adapters.

Link: https://patch.msgid.link/20260610193825.2933-1-alexander.kaplan@sms-m=
edipool.de

> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index 6ee51003de3ce..e2fd2a8ac80d3 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -3145,6 +3145,18 @@ int drm_dp_get_pcon_max_frl_bw(const u8 dpcd[DP_RE=
CEIVER_CAP_SIZE],
>  	int bw;
>  	u8 buf;
> =20
> +	if (!drm_dp_is_branch(dpcd))
> +		return 0;
> +
> +	if (dpcd[DP_DPCD_REV] < 0x11)
> +		return 0;
> +
> +	if ((dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE) =
=3D=3D 0)
> +		return 0;
> +
> +	if ((port_cap[0] & DP_DS_PORT_TYPE_MASK) !=3D DP_DS_PORT_TYPE_HDMI)
> +		return 0;
> +

[Severity: High]
This is a pre-existing issue, but can unvalidated access to downstream_port=
s[2]
lead to unintended DPCD writes on non-PCON branch devices?

Looking at intel_dp_check_frl_training() in
drivers/gpu/drm/i915/display/intel_dp.c, downstream_ports[2] is evaluated
without first ensuring DP_DETAILED_CAP_INFO_AVAILABLE is set and the port is
an HDMI PCON:

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_check_frl_training() {
    ...
	if (!(intel_dp->downstream_ports[2] & DP_PCON_SOURCE_CTL_MODE) ||
	    !intel_dp_is_hdmi_2_1_sink(intel_dp) ||
    ...
}

If a non-PCON multi-port branch device (e.g., a dock) without detailed
capability info has an Analog (Type 1) or 'Other' (Type 3) port as its third
downstream port, its short capability byte at downstream_ports[2] will have
bit 0 set.

This incorrectly satisfies the DP_PCON_SOURCE_CTL_MODE check. If an HDMI 2.1
display is connected, intel_dp_is_hdmi_2_1_sink() returns true. FRL training
will fail, causing the driver to blindly execute a TMDS fallback and write =
to
DPCD register 0x305A (DP_PCON_HDMI_LINK_CONFIG_1):

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_pcon_set_tmds_mode() {
    ...
	ret =3D drm_dp_dpcd_writeb(&intel_dp->aux, DP_PCON_HDMI_LINK_CONFIG_1, buf=
);
    ...
}

Should the i915 driver also verify DETAILED_CAP_INFO_AVAILABLE and
DP_DS_PORT_TYPE_HDMI before evaluating downstream_ports[2] in this code pat=
h?

>  	buf =3D port_cap[2];
>  	bw =3D buf & DP_PCON_MAX_FRL_BW;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026080551-trimming=
-acting-66fa@gregkh?part=3D1
