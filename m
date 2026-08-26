Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE7FC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2483510EDA4;
	Wed, 26 Aug 2026 17:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e7q4l8Of";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B7C810EDA4
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:10:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FC2B431D9;
 Wed, 26 Aug 2026 17:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF011F000E9;
 Wed, 26 Aug 2026 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787764226;
 bh=qRxjVYfvs+9fkYqk3pA7bPBOX1SbegoZMoFgiUgj0/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e7q4l8OfQhTioMew7wlolXIE3Ue1T9tFGt+07MN6GCwu5zQlzbt4v3q5I7T0b9aqA
 6zrMGKFs/JKLRVZ36Xmf4XcKhn0Mw8KYziybG498qAiDmhCct03/cibMG3k+I5B2sg
 Fin/mQ4xA2QZZbz6kbb6sqJmXPE9HQi397yMMucN9RkEJB74sy7pNqL4iBtePnEakL
 xsmmT6h37DYiHdeLza7NzFC35SHOnmOvek9AXOsMc9Swx2THHOZbF3ShVQ0pf4sVRG
 vr6EKwyZqQSEjOkq2SIoBDPmjzrDVPMQ056DSAGNpX9Yiwf2aWW95vtlyC6DYvGThp
 PDVPdPRr5q2qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/13] Documentation/gpu: document the Vino driver
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260826163913.7052-14-mike@fireburn.co.uk>
References: <20260826163913.7052-1-mike@fireburn.co.uk>
 <20260826163913.7052-14-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:10:25 +0000
Message-Id: <20260826171025.BDF011F000E9@smtp.kernel.org>
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
- [High] Sleeping functions (GFP_KERNEL allocations and Mutex locks) are ca=
lled from atomic KMS callbacks.
- [Low] Sphinx build warning due to title overline and underline being shor=
ter than the title text.
--

commit fb3eb13f9dac446a54542b31ed570e00753ca4c1
Author: Mike Lothian <mike@fireburn.co.uk>

Documentation/gpu: document the Vino driver

Describe how a dock is identified and placed by family rather than by
product ID, what the driver implements in-kernel in place of EVDI and
DisplayLinkManager, and the module parameters an unfamiliar dock or a
converter with broken DDC may need.

> diff --git a/Documentation/gpu/vino.rst b/Documentation/gpu/vino.rst
> new file mode 100644
> index 0000000000000..98e82297a82a9
> --- /dev/null
> +++ b/Documentation/gpu/vino.rst
> @@ -0,0 +1,254 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +Vino DisplayLink DL3 driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

[Severity: Low]
Does this title formatting violate reStructuredText syntax requirements?

The overline and underline are 26 characters long, but the title text is 27
characters long, which can cause a Sphinx build warning.

[Severity: High]
Can these sleeping functions be called from an atomic context?

In read_cursor_bgra(), a GFP_KERNEL allocation is made, which can sleep:

drivers/gpu/drm/vino/drm_sink/scanout.rs:read_cursor_bgra() {
    ...
    out.resize(len, 0, GFP_KERNEL)?;
    ...
}

It appears this is called from the atomic VinoPlane::atomic_update callback.

Similarly, do these code paths acquire a sleepable kernel Mutex during atom=
ic
contexts?

drivers/gpu/drm/vino/drm_sink/dispatch.rs:queue_scanout() {
    ...
    let pending =3D self.pending_scanout.lock();
    ...
    let mut pool =3D self.shadow[connector].lock();
    ...
}

This appears to be called in an atomic plane update context.

drivers/gpu/drm/vino/drm_sink/dispatch.rs:queue_cmd() {
    ...
    let mut pending =3D self.pending_kms.lock();
    ...
}

This seems to be called from the atomic_enable and atomic_disable callbacks.

drivers/gpu/drm/vino/drm_sink.rs:update_color() {
    ...
    let changed =3D if let Some(slot) =3D self.color.lock().get_mut(connect=
or) {
    ...
}

This also appears to be called from VinoCrtc::atomic_enable and atomic_disa=
ble.

Calling sleeping functions like GFP_KERNEL allocations and Mutex locks from
atomic context can lead to might_sleep kernel warnings, system instability,
and deadlocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826163913.7052=
-1-mike@fireburn.co.uk?part=3D13
