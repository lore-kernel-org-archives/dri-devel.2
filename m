Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87474C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68AB10F19D;
	Thu,  2 Jul 2026 07:30:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I1Re/eiL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FC510F19D
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:30:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4DCD641743;
 Thu,  2 Jul 2026 07:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1EF1F000E9;
 Thu,  2 Jul 2026 07:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782977408;
 bh=g3Mnl0DUwH4XWcVmN/VjirdozQzJWlBK6KGjXVoiRdc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I1Re/eiLYAyHOebbICWa5Apc0yP8w2Ozv4hRRaRLv6QfNLHVI3nneWMvAQfBvQaqW
 D7SjwCcefpPFDdD4ecbiHhEU1go2Y2x0XUk9uVAwE8WxNfEw974kLGVspoMjr5Ql9O
 gAJf4enRYytgCGb29/Vq0UxNSnxQD7Q3lDCahdpMHPPgeQGSYglW3gtXl1ary2mCYf
 psTTp9zGJUILVuQFLCPp+MKxX31r1JbxJuYXkCbjy34pomxa+TeQ56WAlHdG1HBK/m
 mh28B7mHO70FSG3Fzlapsibk1lsdbvFowVoxBuvV2zKYbTByj562pQY2/o6LODQbxZ
 HosSR2NtJBJQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] drm/i915/display: Handle vlv dsi workaround in
 scanline_in_safe_range too
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702072154.171324-8-dev@lankhorst.se>
References: <20260702072154.171324-1-dev@lankhorst.se>
 <20260702072154.171324-8-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:30:07 +0000
Message-Id: <20260702073008.0E1EF1F000E9@smtp.kernel.org>
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
- [High] Moving the VLV/CHV DSI hardware workaround into `scanline_in_safe_=
range` replaces a microsecond-level busy-wait with an unconditional waitque=
ue sleep, causing a massive latency spike and breaking vblank evasion timin=
g.
--

commit a51b3c62707f214ae277254b37dc4aad780644a2
Author: Maarten Lankhorst <dev@lankhorst.se>

    drm/i915/display: Handle vlv dsi workaround in scanline_in_safe_range t=
oo

This commit moves the VLV/CHV DSI hardware workaround into
scanline_in_safe_range(). This is intended to make the vblank evasion
code slightly more deterministic by not looping with interrupts disabled.

> diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/dr=
m/i915/display/intel_vblank.c
> index ca08059e088ea..6f1fa952b5391 100644
> --- a/drivers/gpu/drm/i915/display/intel_vblank.c
> +++ b/drivers/gpu/drm/i915/display/intel_vblank.c
> @@ -739,6 +739,24 @@ static bool scanline_in_safe_range(struct intel_vbla=
nk_evade_ctx *evade, int *sc
>  	else
>  		*scanline =3D __intel_get_crtc_scanline(evade->crtc);
> =20
> +	/*
> +	 * On VLV/CHV DSI the scanline counter would appear to
> +	 * increment approx. 1/3 of a scanline before start of vblank.
[ ... ]
> +	 *
> +	 * FIXME figure out if BXT+ DSI suffers from this as well
> +	 */
> +	if (evade->need_vlv_dsi_wa && *scanline =3D=3D evade->vblank_start)
> +		return false;

[Severity: High]
If this returns false because we are in the bad scanline window, will the
wait_event_timeout() in intel_vblank_evade() put the thread to sleep for the
timeout duration?

Since the vblank interrupt fires early on these platforms and there are no
subsequent interrupts for the frame, it seems this wait queue would sleep
until the 1 jiffy timeout expires, rather than busy-waiting the ~10
microseconds for the scanline to pass. Could this cause the atomic commit
thread to completely miss the safe window to update display registers?

> +
>  	return *scanline < evade->min || *scanline > evade->max;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702072154.1713=
24-1-dev@lankhorst.se?part=3D7
