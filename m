Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C56C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5563F10E292;
	Wed, 26 Aug 2026 17:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cpWUnbd5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C7D10E292
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:01:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9164560AAA;
 Wed, 26 Aug 2026 17:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6331F00A3A;
 Wed, 26 Aug 2026 17:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787763694;
 bh=bMiXf8BHEI12gcPDg4t8Wz+w6zbg6VQ2A63AQMYxizc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cpWUnbd5RxfBw/rMuEaOfGvTClQ90M0fcVvYpAJFNYVNEDSz2V7sY30COqzGGc4qG
 VwGzS7N+peGy2RUkUbwJ34PFpsEpQm1KC5RDfa1lQI2chBcgi94XTDPZerzit3p9pb
 C6wex3kU5MjgmqwqG7ZzML8pPp7arwrtdX8hy9hi1B+xI1ugeECo4xDVMNoGhaBocw
 3w8OF6lga58gpjLkA6+h/ltS4g4OdjGSVTTY8n33KZNhHIzOGhuces4eK5gWPxeF/j
 n6lNcAE6Dm21bu70H9PEa9/99QRVmfUCXGNAlQXbujGabawubDeUoa/TciCIElAbdZ
 7yYVHyVlvjlTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/13] drm/vino: add the USB driver frontend
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260826163913.7052-12-mike@fireburn.co.uk>
References: <20260826163913.7052-1-mike@fireburn.co.uk>
 <20260826163913.7052-12-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:01:33 +0000
Message-Id: <20260826170134.0D6331F00A3A@smtp.kernel.org>
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
- [High] Calling sleeping functions in Plane and CRTC atomic callbacks
- [Low] Non-compliant import formatting.
--

commit 8a75fe9a885fe8920f6bb62eb588d5aa17fbe92e
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: add the USB driver frontend
   =20
Vino drives DisplayLink DL3 docks as ordinary DRM devices, replacing the
out-of-tree EVDI module and the closed-source DisplayLinkManager daemon.
It adds the probe lifecycle, places the device by family, and handles
presence and EDID workers off the probe path. Sinks that drop and return
quickly are absorbed to prevent dock-wide re-activations.

> diff --git a/drivers/gpu/drm/vino/vino.rs b/drivers/gpu/drm/vino/vino.rs
> new file mode 100644
> index 0000000000000..0813faa43c031
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/vino.rs
> @@ -0,0 +1,1747 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (C) 2026 Mike Lothian
> +
> +//! DRM/KMS driver for DisplayLink DL3 docks.
> +//!
> +//! Vino drives the Dell Universal Dock D6000 using a clean-room impleme=
ntation of its USB control,
> +//! HDCP authentication and compressed video protocols. Each device owns=
 its control session and
> +//! exposes two atomic KMS pipelines backed by shmem GEM objects.
> +
> +use kernel::{
> +    alloc::flags::GFP_KERNEL,
> +    alloc::Flags,
> +    device::{self, Core},

[Severity: Low]
Does this import block violate the vertical import style requirement?

The kernel Rust coding guidelines strictly require a vertical import style
instead of nested brace groups.

[ ... ]


Also in drivers/gpu/drm/vino/drm_sink/mode_objects.rs:

[Severity: High]
Does this call read_cursor_bgra() in VinoPlane::atomic_update() from atomic
context?

VinoPlane::atomic_update():
    if let Ok(bgra) =3D read_cursor_bgra(fb, usize::from(w), usize::from(h)=
) {

read_cursor_bgra() allocates memory with GFP_KERNEL and invokes vmap(), both
of which can sleep. Plane and CRTC atomic callbacks run in atomic context
where sleeping is forbidden, which can cause kernel warnings and deadlocks.


[Severity: High]
Does queue_scanout() sleep here while in atomic context?

VinoPlane::atomic_update():
    data.queue_scanout(
        dev,
        fb,
        PendingScanout { ... },
    );

It acquires the data.shadow Mutex and calls SourceBindingCache::get(), which
allocates with GFP_KERNEL and calls vmap().


[Severity: High]
Does this acquire a sleeping Mutex inside VinoCrtc::atomic_enable()?

VinoCrtc::atomic_enable():
    let mut pinned =3D crtc.vblank_pinned.lock();

CRTC atomic callbacks run in atomic context where sleeping is forbidden.


[Severity: High]
Do these acquire multiple sleeping Mutexes inside VinoCrtc::atomic_disable(=
)?

VinoCrtc::atomic_disable():
    drop(crtc.vblank_pinned.lock().take());
    ...
    data.pending_scanout.lock()[connector as usize] =3D None;
    data.settle_repaint.lock()[connector as usize] =3D None;
    data.shadow[connector as usize].lock().discard();

CRTC atomic callbacks run in atomic context, so acquiring sleeping locks he=
re
is forbidden and can cause kernel warnings or deadlocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826163913.7052=
-1-mike@fireburn.co.uk?part=3D11
