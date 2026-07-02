Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9337C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA5510F1AA;
	Thu,  2 Jul 2026 07:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z6nFOvNz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9AD910F1AC
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:34:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 093276001D;
 Thu,  2 Jul 2026 07:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939C71F000E9;
 Thu,  2 Jul 2026 07:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782977667;
 bh=NRXv0donPn67T1qUm6CCx+4X4BQelaLxXfd/ltCNQeY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z6nFOvNz1pEZu/59SIBBhzBlCMvnEKGfc2bXfP/CWNvVN0qLwqLlTZ85H1Eh01eWW
 yNErysUDm2RzVmq0riMYhUlE6KDcOwAeHL0O+NE7ZVTC/ryK3xG1AQTBmLgfJU6m3h
 03YFgCr2rD7qhhCX4gtqHljL2LLUAvjFPiro3aGebv4cYRqnvF/ZxLB2COoLuYfvTZ
 /xaCUOIJ+4nB3XpTrDW5gzjk83iSH3FIPnK8uSvdZJN65IEKgJ+dknFoXJTNE1E8Fs
 CguvR7MOiT3WtqygEQ8Ai74cipwiA5vK35byFOYNJaCZdXYGZemZkUhIkM5kS/H+Xu
 r9kC5VulxENAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] drm/i915/display: Move vblank put until after
 critical section
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702072154.171324-6-dev@lankhorst.se>
References: <20260702072154.171324-1-dev@lankhorst.se>
 <20260702072154.171324-6-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:34:27 +0000
Message-Id: <20260702073427.939C71F000E9@smtp.kernel.org>
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
- [High] The fix for moving `drm_crtc_vblank_put()` out of the time-sensiti=
ve critical section was only applied to the legacy cursor update, leaving t=
he identical anti-pattern in the main atomic update path.
--

commit 43066708128be1b281ea9a6a390e979ec4569021
Author: Maarten Lankhorst <dev@lankhorst.se>

    drm/i915/display: Move vblank put until after critical section

This commit moves drm_crtc_vblank_put() after the time-sensitive critical
section in intel_legacy_cursor_update() to avoid acquiring locks with
interrupts disabled. It also introduces a flag to defer putting the vblank
reference until programming is completed.

> diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/dr=
m/i915/display/intel_cursor.c
> index 88384dea868b4..68b44a00567e4 100644
> --- a/drivers/gpu/drm/i915/display/intel_cursor.c
> +++ b/drivers/gpu/drm/i915/display/intel_cursor.c

[ ... ]

> @@ -922,8 +925,6 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
>  		local_irq_disable();
> =20
>  		intel_vblank_evade(&evade);
> -
> -		drm_crtc_vblank_put(&crtc->base);
>  	} else {
>  		local_irq_disable();
>  	}
> @@ -939,6 +940,9 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
> =20
>  	intel_psr_unlock(crtc_state);
> =20
> +	if (has_vblank)
> +		drm_crtc_vblank_put(&crtc->base);
> +

[Severity: High]
This isn't a bug introduced by this patch, but should the same fix be appli=
ed
to the main atomic update path in intel_pipe_update_start()?

If the kernel parameter drm.vblankoffdelay < 0 is set, dropping the vblank
reference synchronously takes dev->vbl_lock inside vblank_disable_fn().
On PREEMPT_RT kernels, acquiring this spinlock (rt_mutex) with hardware
interrupts disabled causes a "BUG: sleeping function called from invalid
context" panic. Even on non-RT kernels, taking locks here causes jitter
that can disrupt hardware programming.

drivers/gpu/drm/i915/display/intel_crtc.c:intel_pipe_update_start() {
    ...
	local_irq_disable();

	crtc->debug.min_vbl =3D evade.min;
	crtc->debug.max_vbl =3D evade.max;
	trace_intel_pipe_update_start(crtc);

	scanline =3D intel_vblank_evade(&evade);

	drm_crtc_vblank_put(&crtc->base);
    ...
}

Could drm_crtc_vblank_put() also be moved out of the IRQ-disabled section
here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702072154.1713=
24-1-dev@lankhorst.se?part=3D5
