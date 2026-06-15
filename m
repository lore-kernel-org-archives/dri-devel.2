Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D49CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE4410E6BA;
	Mon, 15 Jun 2026 20:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="njiaXHDg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0769B10E6BA
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:35:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 617FF601E5;
 Mon, 15 Jun 2026 20:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044E71F000E9;
 Mon, 15 Jun 2026 20:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555732;
 bh=WsN83VE6IT5v1qfjApzVZN0VPuj78re4wX0yhWQs3ww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=njiaXHDgma9pLutQkPa4yY1Aih9G+F8qml9LVSHCj5Wqd8LnNCB4qHh5sovZVOi7E
 WmbOTp80zV9dYAYn8Ar+aNkhN7RHm6JuAoiij7v+d62URTqNyTF6EMp0M6Ue0GXCd0
 FI54v9FjhnmWSUiT0SIJmLvjwZs0rPJ6vZ/1/PWGpqSzESpX+AXkCtdrAUaPZvQYaR
 7ueZdpHzumtBDNg1BRzq/UAlbW1x2IF9LdT6UQWdKbASmjAQaXU2FDFKeqaaDhc6W5
 V5wb16LXVGpp/K/6RSJCOczQOwWcFlQNbMbWPF51sUnuxfZI+teY6C0ZklOeylhF8O
 70zaFiywIZBCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/27] drm/intel/display: Convert vblank event
 handling to 2-stage arming
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-5-dev@lankhorst.se>
References: <20260615201846.307297-5-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:35:31 +0000
Message-Id: <20260615203532.044E71F000E9@smtp.kernel.org>
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
- [High] Vblank events and workers execute one frame too early if vblank ev=
asion occurs, causing premature page flip completions and potential use-aft=
er-free.
--

commit 4b140829cb62a6227f3079e278066d8cfb9ea1b4
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/intel/display: Convert vblank event handling to 2-stage arming

This converts the vblank functions to be called with interrupts disabled,
even on PREEMPT_RT kernels.

> diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/=
i915/display/intel_crtc.c
> index 365267c79e54f..6b71810803139 100644
> --- a/drivers/gpu/drm/i915/display/intel_crtc.c
> +++ b/drivers/gpu/drm/i915/display/intel_crtc.c
> @@ -527,6 +527,10 @@ static void intel_crtc_vblank_work_init(struct intel=
_crtc_state *crtc_state)
> =20
>  	drm_vblank_work_init(&crtc_state->vblank_work, &crtc->base,
>  			     intel_crtc_vblank_work);
> +
> +	drm_vblank_work_schedule_disabled(&crtc_state->vblank_work,
> +					  drm_crtc_accurate_vblank_count(&crtc->base) + 1);
> +
>  	/*
>  	 * Interrupt latency is critical for getting the vblank
>  	 * work executed as early as possible during the vblank.

[ ... ]

> @@ -607,6 +626,8 @@ void intel_pipe_update_start(struct intel_atomic_stat=
e *state,
> =20
>  	if (intel_crtc_needs_vblank_work(new_crtc_state))
>  		intel_crtc_vblank_work_init(new_crtc_state);
> +	else
> +		intel_crtc_arm_vblank_event(new_crtc_state);
> =20
>  	if (state->base.legacy_cursor_update) {
>  		struct intel_plane *plane;

[ ... ]

> @@ -754,29 +758,10 @@ void intel_pipe_update_end(struct intel_atomic_stat=
e *state,
>  	 * event outside of the critical section - the spinlock might spin for a
>  	 * while ... */
>  	if (intel_crtc_needs_vblank_work(new_crtc_state)) {
> -		drm_vblank_work_schedule(&new_crtc_state->vblank_work,
> -					 drm_crtc_accurate_vblank_count(&crtc->base) + 1,
> -					 false);
> -	} else {
> -		intel_crtc_arm_vblank_event(new_crtc_state);
> -	}
> -
> -	if (state->base.legacy_cursor_update) {
> -		struct intel_plane *plane;
> -		struct intel_plane_state *old_plane_state;
> -		int i;
> -
> -		for_each_old_intel_plane_in_state(state, plane, old_plane_state, i) {
> -			if (old_plane_state->hw.crtc =3D=3D &crtc->base &&
> -			    old_plane_state->unpin_work.vblank) {
> -				drm_vblank_work_schedule(&old_plane_state->unpin_work,
> -							 drm_crtc_accurate_vblank_count(&crtc->base) + 1,
> -							 false);
> -
> -				/* Remove plane from atomic state, cleanup/free is done from vblank =
worker. */
> -				memset(&state->base.planes[i], 0, sizeof(state->base.planes[i]));
> -			}
> -		}
> +		drm_vblank_work_enable(&new_crtc_state->vblank_work);
> +	} else if (new_crtc_state->uapi.event) {
> +		drm_crtc_arm_prepared_vblank_event(new_crtc_state->uapi.event);
> +		new_crtc_state->uapi.event =3D NULL;
>  	}

[Severity: High]
If intel_vblank_evade() spins and the hardware vblank counter increments,
will the target sequence number calculated earlier in
intel_pipe_update_start() become stale?

Since intel_crtc_vblank_work_init() and intel_crtc_arm_vblank_event() now
run before evasion, the target sequence is calculated as N + 1. If evasion
occurs, the counter increments to N + 1, and the hardware will latch the
new state at N + 2.

When drm_vblank_work_enable() or drm_crtc_arm_prepared_vblank_event() are
called here, they are still targeted for N + 1. Could this result in the
event firing immediately and signaling completion one frame before the
hardware actually latches the new display state, potentially leading to
premature freeing of the old framebuffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D4
