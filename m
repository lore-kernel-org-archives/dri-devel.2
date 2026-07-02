Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A36C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DA610F1B3;
	Thu,  2 Jul 2026 07:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jPAlADWa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20A310F1B3
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:37:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 75B956001D;
 Thu,  2 Jul 2026 07:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005771F000E9;
 Thu,  2 Jul 2026 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782977822;
 bh=koufIXM0tiUVmN/ZiinwIGRfNlHLQZgDTu47GdM3rQo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jPAlADWaRvK9TjEunvEu35FGhsjl5j6HAkBqSpyR45Aj8w1Gu8BXLi6aE7kRQYsZz
 4rSpF+PO3su7Jz1t5b/bNZHK9bkfyxBEgscK6FM8DELiRe8Iz5zmkWZ1qIshg0vyjs
 Jy2URYk2lgT1vTeYmoe7jF8nrS+0nPPavWZme1Gk59oF9uHkecyxseJKfbqUkUtoFW
 Qg7tC9FuqXSBJxeGyxBz8hVW/sBjamAlMDqFcWjE+jg3QCmZANz5zQBg3k98CuaIfG
 8+gkiyF9jLGF3KB6240qgrdDj/u7EW8SROaXzAfIot6dqTLHlCDt7DtKsNg5bMpWyS
 Ox7HqL25zPRWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] drm/intel/display: Convert vblank event handling
 to 2-stage arming
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702072154.171324-5-dev@lankhorst.se>
References: <20260702072154.171324-1-dev@lankhorst.se>
 <20260702072154.171324-5-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:37:00 +0000
Message-Id: <20260702073702.005771F000E9@smtp.kernel.org>
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

New issues:
- [High] Moving vblank event preparation and counter sampling before vblank=
 evasion causes events and workers to fire one frame early if an evasion wa=
it occurs.

Pre-existing issues:
- [High] drm_crtc_vblank_put() is called within a local_irq_disable() criti=
cal section, which can acquire a sleepable rt_mutex on PREEMPT_RT kernels, =
causing a lockdep splat and potential system crash.
--

commit 90a4948ef379d3e7a2ebc312abe7069b65f38a68
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/intel/display: Convert vblank event handling to 2-stage arming

This converts the vblank functions to be called with interrupts
disabled, even on PREEMPT_RT kernels. Instead of using the normal
vblank functions inside the critical section, it prepares the vblank
at the start and enables the work after hardware programming completes.

> diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/=
i915/display/intel_crtc.c
> index 805645318747f..34a159f7c9a43 100644
> --- a/drivers/gpu/drm/i915/display/intel_crtc.c
> +++ b/drivers/gpu/drm/i915/display/intel_crtc.c
[ ... ]
> @@ -607,6 +626,8 @@ void intel_pipe_update_start(struct intel_atomic_stat=
e *state,
> =20
>  	if (intel_crtc_needs_vblank_work(new_crtc_state))
>  		intel_crtc_vblank_work_init(new_crtc_state);
> +	else
> +		intel_crtc_arm_vblank_event(new_crtc_state);

[Severity: High]
Does moving the vblank event preparation and counter sampling before the
evasion wait cause the event to fire a frame early if the wait actually
spins?

If intel_pipe_update_start() locks the target vblank sequence to the
current vblank count + 1, and the CPU is delayed so that the evasion
wait spins:

intel_pipe_update_start() {
    ...
    scanline =3D intel_vblank_evade(&evade);
    ...
}

The hardware latching point will have passed, meaning the registers will
apply at N+2. However, because the event sequence is already locked to N+1
prior to the evasion, the event will fire a frame early in
intel_pipe_update_end() when un-postponed:

intel_pipe_update_end() {
    ...
    drm_crtc_arm_prepared_vblank_event(new_crtc_state->uapi.event);
    ...
}

Could this lead to screen tearing or premature compositor synchronization?

[Severity: High]
This is a pre-existing issue, but does calling drm_crtc_vblank_put() inside
the local_irq_disable() block later in this function cause issues on
PREEMPT_RT kernels?

intel_pipe_update_start() {
    ...
    local_irq_disable();
    ...
    scanline =3D intel_vblank_evade(&evade);
    drm_crtc_vblank_put(&crtc->base);
    ...
}

If this call drops the last vblank reference and immediate vblank disable is
configured, vblank_disable_fn() executes synchronously and acquires
dev->vbl_lock.

Since this spinlock is converted to a sleepable rt_mutex on PREEMPT_RT
kernels, will this cause a lockdep splat or panic by sleeping in atomic
context?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702072154.1713=
24-1-dev@lankhorst.se?part=3D4
