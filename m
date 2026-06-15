Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813A1CD98E0
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1EF610E6B8;
	Mon, 15 Jun 2026 20:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jkny/4s9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD9910E6B8
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:46:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 93777414F9;
 Mon, 15 Jun 2026 20:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586301F000E9;
 Mon, 15 Jun 2026 20:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781556399;
 bh=QeP2nQ/WaAsISRFZegPYqg7T7Igd+Wic0uwOSKpt0nE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jkny/4s91Pph2cFYnZ9sPdS10WLWLC6cccoeoYOpmk/MJ2jB2thVnrLy4s/OyNXO8
 sDob5OJuaHnAF4W3FyJeipzYaEeElgMLy+JTudFMaDMACbBlYCKfkj8lljV2Z3nj/2
 otwJSKb36JA5bdF4WpX6UcSslpyytHEmbFYYEDH0hzEsKMOm9LdnKAMzdEpt74uNpz
 Z3+so30FvOi1hMbeaoun4pmsnlH3pnmVluuWOTpBPV2l1pn+lBmiLapYml42I1HYAJ
 2R2JHCXBOeB1EIVslV1toWLwEQIZ8LyixE7wPnc3JyT2aHJUN7XXBK3h3zIvPeYjzt
 yUsooWgqMTdhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/27] drm/i915/display: Use intel_de_write_fw in
 intel_pipe_fastset
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-14-dev@lankhorst.se>
References: <20260615201846.307297-14-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:46:38 +0000
Message-Id: <20260615204639.586301F000E9@smtp.kernel.org>
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
- [High] Missed conversions to `_fw` variants in nested and adjacent functi=
ons called during the atomic vblank evasion window.
--

commit 1b8145ae8a083acd96357095f72f68d606b4e071
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/display: Use intel_de_write_fw in intel_pipe_fastset

This commit converts several register writes in functions like=20
intel_set_pipe_src_size() and intel_set_transcoder_timings_lrr()=20
to use the _fw non-sleeping variants. This prevents a "sleeping=20
function called from invalid context" BUG during atomic evasion=20
on PREEMPT_RT.

> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index e2e4b00a8fa99..2e3ade44f28ee 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c

[ ... ]

> @@ -2839,9 +2839,9 @@ static void intel_set_transcoder_timings_lrr(const =
struct intel_crtc_state *crtc
>  	 * The double buffer latch point for TRANS_VTOTAL
>  	 * is the transcoder's undelayed vblank.
>  	 */
> -	intel_de_write(display, TRANS_VTOTAL(display, cpu_transcoder),
> -		       VACTIVE(crtc_vdisplay - 1) |
> -		       VTOTAL(crtc_vtotal - 1));
> +	intel_de_write_fw(display, TRANS_VTOTAL(display, cpu_transcoder),
> +			  VACTIVE(crtc_vdisplay - 1) |
> +			  VTOTAL(crtc_vtotal - 1));
> =20
>  	intel_vrr_set_fixed_rr_timings(crtc_state);
>  	intel_vrr_transcoder_enable(crtc_state);

[Severity: High]
This is a pre-existing issue, but it seems the fix for PREEMPT_RT might be=
=20
incomplete.

intel_set_transcoder_timings_lrr() unconditionally calls=20
intel_vrr_transcoder_enable(), which in turn calls=20
intel_vrr_set_transcoder_timings(). That nested function still uses=20
intel_de_write(), intel_de_read(), and intel_de_rmw() rather than the=20
_fw variants:

drivers/gpu/drm/i915/display/intel_vrr.c:intel_vrr_set_transcoder_timings()=
 {
	...
	drm_WARN_ON(display->drm,
		    !(intel_de_read(display, TRANS_DDI_FUNC_CTL(display, cpu_transcoder))=
 & TRANS_DDI_FUNC_ENABLE));
	...
	intel_de_write(display, TRANS_VRR_CTL(display, cpu_transcoder), trans_vrr_=
ctl(crtc_state));
	...
}

Because these non-fw accessors acquire locks that are sleepable on PREEMPT_=
RT,
will they still cause the same panic during the atomic vblank evasion windo=
w?

Additionally, commit_pipe_post_planes() runs in this same atomic window and=
=20
calls intel_vrr_enable(). This eventually executes multiple sleepable=20
intel_de_write() calls:

drivers/gpu/drm/i915/display/intel_vrr.c:intel_vrr_enable_dc_balancing() {
	...
	intel_de_write(display, TRANS_VRR_DCB_ADJ_VMAX_CFG(cpu_transcoder),
		       VRR_DCB_ADJ_VMAX(crtc_state->vrr.vmax - 1));
	...
}

drivers/gpu/drm/i915/display/intel_vrr.c:intel_vrr_set_vrr_timings() {
	...
	intel_de_write(display, TRANS_VRR_VMIN(display, cpu_transcoder),
		       intel_vrr_hw_vmin(crtc_state) - 1);
	...
}

Do those accesses also need to be converted to the _fw variants to fully=20
prevent the BUG?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D13
