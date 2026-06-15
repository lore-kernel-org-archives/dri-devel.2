Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308ECCD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C5E89444;
	Mon, 15 Jun 2026 20:29:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aKj09iam";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 304CC89444
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:29:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE8AF42DC0;
 Mon, 15 Jun 2026 20:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932591F000E9;
 Mon, 15 Jun 2026 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555379;
 bh=8GhdpJQtSYDZDMbNvzOVtNwuFFupZmAJKs2lcm+T87s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aKj09iamoObeMXu7eWi3riWVFhbwjOvp7mAXLMiVB0jCDTOJTnhx7tNE5V5a/bm/O
 OEbW7OaBKYZOlD6LojEjt7OB4LpTNW6fwSzGSh3lZPA7nhnjbx5BuSYm134irem6gd
 Jcmx9oSNLAoI2q622yHg71NEJ5pBpjWRENbkfXTYslpUAbOslqZ15AUkY3wGfWdE2c
 K2xgTEa802P17yMOQYEGHDUkLUXwRM+BjNv+2w+NB/2z1bcPQ8JfPQGup8L3py3bC2
 AeOR28JPoTZWNGtq+9lF5qp5ps4JAviBAT9z2zPeZ2t1B+CWxEy187wWShvG87XaZ1
 u8934NbOQ/w4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/27] drm/i915/display: Handle vlv dsi workaround in
 scanline_in_safe_range too
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-8-dev@lankhorst.se>
References: <20260615201846.307297-8-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:29:39 +0000
Message-Id: <20260615202939.932591F000E9@smtp.kernel.org>
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
- [High] Moving the VLV/CHV DSI scanline workaround into a sleeping wait co=
ndition causes missed vblanks and 1ms timeouts.
--

commit 73c9aa3755ab5a555f9a46d12d2906f90594656d
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/display: Handle vlv dsi workaround in scanline_in_safe_range too

This commit moves the VLV/CHV DSI scanline workaround from a busy-wait loop
in the intel_vblank_evade function into the scanline_in_safe_range helper.
The goal is to make the vblank evasion more deterministic by reducing the
time spent looping with interrupts disabled.

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

[ ... ]

> +	 * FIXME figure out if BXT+ DSI suffers from this as well
> +	 */
> +	if (evade->need_vlv_dsi_wa && *scanline =3D=3D evade->vblank_start)
> +		return false;
> +

[Severity: High]
Does moving this condition into scanline_in_safe_range() cause a stall duri=
ng
atomic commits?

Because scanline_in_safe_range() is used as the condition for sleeping in
intel_vblank_evade():

intel_vblank_evade() {
    ...
    timeout =3D wait_event_timeout(*wq,
        scanline_in_safe_range(evade, &scanline, true), timeout);
    ...
}

When the vblank interrupt fires and wakes the waitqueue, the scanline count=
er
will still read as evade->vblank_start, since the hardware leaves it at that
value for a full scanline duration.

Since scanline equals evade->vblank_start, scanline_in_safe_range() returns
false, causing wait_event_timeout() to put the thread back to sleep.

As no further vblank interrupts will fire for this frame, will the thread
sleep for the entire 1ms timeout, leading to a regression with missed vblan=
ks
and dropped frames?

>  	return *scanline < evade->min || *scanline > evade->max;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D7
