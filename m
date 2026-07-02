Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB33C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4415D10F1AF;
	Thu,  2 Jul 2026 07:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hLPcnB6a";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0916D10F1AC
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:35:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FE876001D;
 Thu,  2 Jul 2026 07:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054121F000E9;
 Thu,  2 Jul 2026 07:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782977736;
 bh=0N654+hR1lkSbKU+ZZww1OmEOc55Ias8FFTaT0eNW+M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hLPcnB6aRo55J27nxdjYmNrRQxigiVOjY9DINTJoC0lig4Q5ojcaxySrDKeMAxdhq
 TnB3qDdbUtJRqPSihJpOn+T83uXnQ/V2U95ndZVlta2y2TM7RF9XuEDLwJ8Bod6HNn
 g8OWwTxQm8gfPTLtINDWBB7H/RZkh9ni7mRWV40XQrzgoeD715BNUqRFqMYxzAATbJ
 1CecpCUaCmfE8qZwjqyYjIftcejHPnq6o1vvtW1O/e2WCyOxtVPFA6JkqR80pu4NB4
 vGBgtUeKe7SBBvaRPSje5kO82inNdNQqLL+/ofdi0jWA+CJ1k0eYvYul9NuZXl8MZp
 /36Y8gu37OrGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] drm/vblank: Add a 2-stage version of
 drm_crtc_arm_vblank_event
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702072154.171324-3-dev@lankhorst.se>
References: <20260702072154.171324-1-dev@lankhorst.se>
 <20260702072154.171324-3-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:35:35 +0000
Message-Id: <20260702073536.054121F000E9@smtp.kernel.org>
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
- [Medium] Insufficient memory barrier for ordering MMIO hardware programmi=
ng against vblank event arming
--

commit e7abec27222d12389651c409a1f108b4e73b0d3e
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/vblank: Add a 2-stage version of drm_crtc_arm_vblank_event

This patch introduces drm_crtc_prepare_arm_vblank_event() and
drm_crtc_arm_prepared_vblank_event() to allow arming vblank events in two
stages. This avoids taking vblank-related spinlocks with interrupts disabled
during hardware programming, which is useful for PREEMPT_RT kernels.

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13e423..b52e0215312f8 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
[ ... ]
> +void drm_crtc_arm_prepared_vblank_event(struct drm_pending_vblank_event =
*e)
> +{
> +	WARN_ON(!e->postponed);
> +
> +	/* Ensure previous writes are visible */
> +	smp_wmb();
> +
> +	/* remove the flag to be processed as a normal event */
> +	WRITE_ONCE(e->postponed, false);
> +}

[Severity: Medium]
Is smp_wmb() sufficient to order prior MMIO hardware programming against th=
is
memory write to e->postponed?

If the intent is to order the prior hardware programming (MMIO writes) agai=
nst
setting e->postponed to false, smp_wmb() is strictly a CPU-to-CPU barrier f=
or
normal memory. On weakly-ordered architectures (like ARM64), the CPU can
reorder the normal memory write (postponed =3D false) before the MMIO write=
s are
issued to the bus, potentially causing the vblank interrupt handler to proc=
ess
the event before the hardware programming is complete.

Does this need a full wmb() to correctly order I/O against memory?

Conversely, if it were intended for CPU memory ordering, the reader in
drm_handle_vblank_events() lacks a matching smp_rmb(). Since all other CPU
memory fields are protected by event_lock, there shouldn't be lockless CPU
memory writes to order here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702072154.1713=
24-1-dev@lankhorst.se?part=3D2
