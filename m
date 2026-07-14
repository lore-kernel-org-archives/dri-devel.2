Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AB8C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C21310ECE9;
	Tue, 14 Jul 2026 10:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ItrD2uGa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC65E10ECE2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 10:47:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 58FB742B39;
 Tue, 14 Jul 2026 10:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBCD1F000E9;
 Tue, 14 Jul 2026 10:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784026033;
 bh=TFIf2sErBZkBkTP7wZ/PflsiUQ8bxGAbyrmoHzwNd9k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ItrD2uGaoxQ0ZW0ZJkYkoxgfvHcZrcSDNTdMYDG9dyL5tmye2BV4Mst4WiRZnu5Wd
 tfW2huk5o4EjlzHRYEZkmwc+4/tdVFlW1pbu7hCM5bbk+PSoYUnb7gFDuxNY4eq7ey
 xQ4pYYFHRZme1Flsvh0w9ZshQOd+q5CVaaf4YzLFf40p1eArn3y4DlZ90eQw3p0gwg
 FSYLDrwldvkgIEKyfxhzp8OczGaMbeqZcY0/hb9N6WDTNQFQnSys0iMlgeWRrxcBoa
 or+W26SVlzThgNZ3J/TSCkLya8gAGY3hpZWboV0KVXzL4OKxZMSmt6yJdn3NQro0hs
 H935t5NoeuP5A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] NOT FOR MERGE: drm/glanda: Add x86 platform
 test device
To: "Leander Kieweg" <kieweg.leander@gmail.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260714101146.200416-4-kieweg.leander@gmail.com>
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
 <20260714101146.200416-4-kieweg.leander@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:47:12 +0000
Message-Id: <20260714104712.EBBCD1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing DRM unplug protection in IOCTL handlers allows Use-After-U=
nmap of MMIO resources.
- [High] The plane atomic update callback calls multiple sleeping functions=
 while executing in atomic context.
- [High] Premature shared IRQ registration causes a NULL pointer dereferenc=
e if the interrupt fires before CRTC initialization.
--

--- Patch [3]: [RFC PATCH 3/3] NOT FOR MERGE: drm/glanda: Add x86 platform =
test device ---
commit 6108d4cd0cea176f9e750373bc9ba705d3d2a6c7
Author: Leander Kieweg <kieweg.leander@gmail.com>

NOT FOR MERGE: drm/glanda: Add x86 platform test device

Register a mock platform device on x86 architectures to allow
testing the GlandaGPU driver inside QEMU without cross-compiling.

> diff --git a/drivers/gpu/drm/tiny/glandagpu.c b/drivers/gpu/drm/tiny/glan=
dagpu.c
> index 8f87ae096a2e3..c1e9370f2a4b1 100644
> --- a/drivers/gpu/drm/tiny/glandagpu.c
> +++ b/drivers/gpu/drm/tiny/glandagpu.c

[Severity: High]
This is a pre-existing issue, but is it possible for a concurrent ioctl to
access unmapped MMIO memory during device removal?

Looking at glandagpu_remove(), it wakes up blocked ioctls:

drivers/gpu/drm/tiny/glandagpu.c:glandagpu_remove() {
    ...
	gdev->cmd_done =3D true;
	wake_up_interruptible(&gdev->cmd_wq);
    ...
}

However, it lacks drm_dev_unplug() and drm_dev_enter()/drm_dev_exit()
synchronization. When glandagpu_remove() returns, the devres framework
automatically unmaps gdev->mmio_base. The forcibly awakened ioctl could
then resume and write directly to the unmapped MMIO memory:

drivers/gpu/drm/tiny/glandagpu.c:glanda_hw_clear() {
    ...
	writel(color, gdev->mmio_base + REG_COLOR);
    ...
}

Could this cause a kernel panic due to a use-after-unmap page fault?

[Severity: High]
This isn't a bug introduced by this patch, but does the plane atomic update
callback sleep while in atomic context?

Userspace can initiate a non-blocking DRM atomic commit, which executes
glanda_plane_atomic_update() in an atomic context. However, it appears to
call multiple sleeping functions:

drivers/gpu/drm/tiny/glandagpu.c:glanda_plane_atomic_update() {
    ...
	dma_resv_lock(shmem->base.resv, NULL);
	ret =3D drm_gem_shmem_vmap_locked(shmem, &map);
    ...
	mutex_lock(&gdev->lock);

	ret =3D glanda_wait_idle(gdev);
    ...
}

Since glanda_wait_idle() internally uses wait_event_interruptible_timeout(),
could these calls cause system instability, scheduling-while-atomic warning=
s,
or deadlocks in the DRM commit worker?

[Severity: High]
This is a pre-existing issue, but could premature shared IRQ registration
cause a NULL pointer dereference during probe?

In glandagpu_probe(), devm_request_irq() is called with IRQF_SHARED before
the DRM CRTC is initialized by drm_crtc_init_with_planes():

drivers/gpu/drm/tiny/glandagpu.c:glandagpu_probe() {
    ...
		ret =3D devm_request_irq(&pdev->dev, gdev->irq, glanda_irq_handler,
				       IRQF_SHARED, "glandagpu", gdev);
    ...
	ret =3D drm_crtc_init_with_planes(&gdev->drm, &gdev->crtc,
    ...
}

If another device on the same shared line triggers an interrupt immediately,
the handler reads the raw REG_ISR without masking it against the interrupt
enable register (REG_IER). If the INT_VSYNC bit is set, it proceeds to
handle the vblank:

drivers/gpu/drm/tiny/glandagpu.c:glanda_irq_handler() {
    ...
	if (isr & INT_VSYNC)
		drm_crtc_handle_vblank(&gdev->crtc);
    ...
}

Since gdev->crtc is still zero-initialized at this point, could this
dereference a NULL crtc->dev pointer and lead to a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714101146.2004=
16-1-kieweg.leander@gmail.com?part=3D3
