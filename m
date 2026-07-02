Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D016C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D9B10F22E;
	Thu,  2 Jul 2026 08:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n8kva+81";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB51910F22E
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 08:19:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E198360120;
 Thu,  2 Jul 2026 08:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5591F000E9;
 Thu,  2 Jul 2026 08:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782980352;
 bh=FpwQ3yWLXtt7sZKtMM0MrQ1r1M4n/nvKM3WIVk0Nqa0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n8kva+81/uRHVqYDMwXK9zMWr5mFjn+n8TNQL0h4BAD2dfaaNHzCbvnXMzpCRHFCi
 MjnISb/mPJfO/KC97lqjqL+ooTbiRxWqxMdvicObIQfZ+nXGjKKFOWLo9lMub2g5Y3
 kqOCzNIqaNZsLWd8Yvm3aFbt5RGTKVfNAZykcPpwVZm+dZ8iGWRfnIh8NLbGxoEsdl
 N7yXpcuX8t1DBbGTlIYzdMhHcl9orwInNYqRiayx93YSSHfNbhLqP9HkfMTlK4ZZTa
 Wn9tALTIx10Y7sftlaxZUqLo6DKK1Gf3NIFZbTTamYIZuSfERWFaPml9xTV0VByyyg
 1Z3pLCBKPOI8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/i915/display: Make set_pipeconf use the fw
 variants
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702080346.431508-5-dev@lankhorst.se>
References: <20260702080346.431508-1-dev@lankhorst.se>
 <20260702080346.431508-5-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 08:19:11 +0000
Message-Id: <20260702081912.6C5591F000E9@smtp.kernel.org>
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
- [High] vlv_atomic_update_fifo() takes a sleepable spinlock (uncore->lock)=
 inside a hardware-interrupt-disabled critical section, leading to a 'sleep=
ing function called from invalid context' BUG on PREEMPT_RT.
--

commit 5a85aa91d02b113ff09052cce4d68e8a6b54e2ce
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/display: Make set_pipeconf use the fw variants

This commit changes i9xx_set_pipeconf() and ilk_set_pipeconf() to use the
_fw variants of register read/write functions. This prevents sleepable locks
from being taken inside the interrupt-disabled critical section, which was
causing a BUG on PREEMPT_RT.

> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index f5dac380aa7ff..deb93d26e0e94 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -3030,8 +3030,9 @@ void i9xx_set_pipeconf(const struct intel_crtc_stat=
e *crtc_state)
> =20
>  	val |=3D TRANSCONF_FRAME_START_DELAY(crtc_state->framestart_delay - 1);
> =20
> -	intel_de_write(display, TRANSCONF(display, cpu_transcoder), val);
> -	intel_de_posting_read(display, TRANSCONF(display, cpu_transcoder));
> +	intel_de_write_fw(display, TRANSCONF(display, cpu_transcoder), val);
> +	/* posting read */
> +	intel_de_read_fw(display, TRANSCONF(display, cpu_transcoder));
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the explicit acquisition
of a sleepable spinlock inside an interrupt-disabled critical section in
vlv_atomic_update_fifo() violate PREEMPT_RT locking rules?

drivers/gpu/drm/i915/display/i9xx_wm.c:vlv_atomic_update_fifo() {
	...
	/*
	 * intel_pipe_update_start() has already disabled interrupts
	 * for us, so a plain spin_lock() is sufficient here.
	 */
	spin_lock(&uncore->lock);
	...
}

Taking a standard spinlock (which acts as a sleeping rt_mutex on PREEMPT_RT)
after local interrupts have been disabled causes a kernel BUG splat 'sleepi=
ng
function called from invalid context'.

The vblank evasion critical section initiated by intel_pipe_update_start()
disables local interrupts. Inside this critical section,
commit_pipe_pre_planes() calls intel_atomic_update_watermarks(), which on
VLV/CHV maps to vlv_atomic_update_fifo(). This function explicitly acquires
spin_lock(&uncore->lock).

Since this patch fixes the same locking violation in i9xx_set_pipeconf()
and ilk_set_pipeconf() by using the _fw variants, is it possible this
instance in the exact same critical section was missed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702080346.4315=
08-1-dev@lankhorst.se?part=3D4
