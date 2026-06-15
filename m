Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4777CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B0910E64F;
	Mon, 15 Jun 2026 20:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eTrLAzQv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8345D10E64F
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:31:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB082601E1;
 Mon, 15 Jun 2026 20:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3121F000E9;
 Mon, 15 Jun 2026 20:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555511;
 bh=qWME0agGyN1PP8W25nS+K3pSB5xR1TBQSc+zU6E1BUY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eTrLAzQvBtbYodAOF+nm24DHtTulmNEh3oc70fApbuotwlC897vTw0KqXsbdnt484
 iCNIgVNZjJgFgFdZ+QYcXYp79DhFG7+B49a4f39N9drKqX6+hJEmQwqsCWvRasPQIc
 lF6WGlFWndPDqR6EOrjS2Ajzcbg4ub9Rr4iPAzGKr71c18n1U2mv3BTn9DF60N3vya
 vIr10pO01mLArFFRtNoCRUv5d1qJzEBzb0crM3/011iUoZSCUoqkIizXN6jPcp87EN
 wEfMwnwbR3WqwuM96d0pZwAXo8El3PxJhKb5Qq3g7cDKtpZyukgf+KLrz+DO/k7r6I
 H6zKjUl+n7CfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/27] drm/vblank: Add a 2-stage version of
 drm_crtc_arm_vblank_event
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-3-dev@lankhorst.se>
References: <20260615201846.307297-3-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:31:50 +0000
Message-Id: <20260615203151.4C3121F000E9@smtp.kernel.org>
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
- [High] Missing memory barrier in drm_crtc_arm_prepared_vblank_event() all=
ows premature vblank signaling.
--

commit 876541f26b4001b93fb6f0b7d16d814d3b08e2b0
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/vblank: Add a 2-stage version of drm_crtc_arm_vblank_event

This patch introduces a two-stage mechanism for arming vblank events to
support PREEMPT_RT kernels and increase determinism. It allows the event
to be prepared before hardware programming and armed afterward, avoiding
the need to take vblank locks with local interrupts disabled.

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13e423..6856eff97dc97 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c

[ ... ]

> +/**
> + * drm_crtc_arm_prepared_vblank_event - arm prepared vblank event *after=
* pageflip.
> + * @crtc: the source CRTC of the vblank event
> + * @e: the event to send
> + *
> + * See drm_crtc_prepare_arm_vblank_event(). This function is a 2-stage v=
ersion of
> + * that call. This function is called directly *AFTER* programming the h=
ardware.
> + *

[ ... ]

> +void drm_crtc_arm_prepared_vblank_event(struct drm_pending_vblank_event =
*e)
> +{
> +	WARN_ON(!e->postponed);
> +
> +	/* remove the flag to be processed as a normal event */
> +	WRITE_ONCE(e->postponed, false);

[Severity: High]
Could this memory update be reordered with the prior MMIO writes on weakly
ordered architectures?

Since this function is intended to be called immediately after hardware
programming, there might be an ordering issue. For instance, on ARM64,
functions like writel() guarantee that prior memory accesses complete before
the MMIO write, but they do not provide a memory barrier after the write.

This means the CPU could reorder the WRITE_ONCE() update to occur before the
MMIO writes are globally observed. If a concurrent hardware vblank interrupt
is serviced by another CPU, drm_handle_vblank_events() might observe the
cleared postponed flag and signal the event to userspace prematurely.

If userspace receives the event and frees the old framebuffer before the new
hardware state takes effect, could it lead to the hardware scanning out
unmapped memory and triggering IOMMU faults or display corruption? Would
adding a wmb() here ensure the MMIO writes are properly ordered against the
flag update?

> +}
> +EXPORT_SYMBOL(drm_crtc_arm_prepared_vblank_event);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D2
