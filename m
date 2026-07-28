Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8346BC54F54
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53BD10E5CC;
	Tue, 28 Jul 2026 18:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LmYi2ewL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D88710E5CC
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:54:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73D2560A5E;
 Tue, 28 Jul 2026 18:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BC21F000E9;
 Tue, 28 Jul 2026 18:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785264860;
 bh=tm5vJYVUwUvc2qE+rGc8/W5OYmCnmF/BjhivI0umahI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LmYi2ewLJErUdhkn7nICd8A6MW4WTjjaG3HCl+wLGToNYPkXuObgqoGYgJiE2KjMQ
 X6J1m+YGE4xfVCuQQ2IicFfGF6lU0R4NFzGo6u2YNZZywBr6oC3tWrDbTc2FULi3zF
 NhrhwnLsci103FSNBag0Kc7p9zU6Y5U5Wb0n+eLNCl9R/FokHSGhdpuBsGciZvpv9J
 SGw7k21/IyZixKTt1OFcrLd1AtlkY1wyt80fo1OR08eN69igLnkdDUKeE2Sr1EwfJ6
 LY7jAFbJirsHRIiDUdG0jcuz5VjDLoZB+XXUOtaoNvAxGHfdoTsRBb/qW67g5mMAYt
 jarxVzBBeudDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/7] drm/tyr: add a kernel buffer object
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260728-fw-boot-b4-v10-5-9187aefa3f2f@collabora.com>
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
 <20260728-fw-boot-b4-v10-5-9187aefa3f2f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 18:54:19 +0000
Message-Id: <20260728185419.E7BC21F000E9@smtp.kernel.org>
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
- [Medium] Resource leak: `KernelBo::drop` permanently leaks the GEM buffer=
 object and its virtual mapping if `vm.unmap_range()` fails.
--

--- Patch [5]: [PATCH v10 5/7] drm/tyr: add a kernel buffer object ---
commit f17ba69672f18401371cf98a1da7881e0b938c23
Author: Deborah Brouwer <deborah.brouwer@collabora.com>

drm/tyr: add a kernel buffer object

This commit introduces a buffer object type (KernelBo) for internal driver
allocations managed by the kernel. It wraps a GEM shmem object and automati=
cally
handles GPU virtual address space mapping during creation and unmapping on =
drop.

> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index c28be61a01bb2..69e1c75e59a55 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs

[ ... ]

> +impl Drop for KernelBo<'_> {
> +    fn drop(&mut self) {
> +        let va =3D self.va_range.start;
> +        let size =3D self.va_range.end - self.va_range.start;
> +
> +        if let Err(e) =3D self.vm.unmap_range(va, size) {

[Severity: Medium]
Does this leak the GEM buffer object if unmap_range() fails?

If unmap_range() encounters an error (such as a kmalloc failure due to
memory pressure when preallocating GPUVA objects to handle a mapping split),
it aborts the unmap operation.=20

Because the error is caught and ignored here, the drm_gpuvm will retain its
reference to the GEM object indefinitely, leaking it along with its
physical pages.

> +            // If unmap_range fails, it is still safe to drop the
> +            // KernelBo and its ARef to the GEM buffer object because
> +            // GPUVM also holds a reference to the GEM buffer object.
> +            // The physical pages won't be freed or reallocated.
> +            dev_err!(
> +                self.vm.dev(),
> +                "Failed to unmap KernelBo range {:#x}..{:#x}: {:?}",
> +                self.va_range.start,
> +                self.va_range.end,
> +                e
> +            );
> +        }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-fw-boot-b4=
-v10-0-9187aefa3f2f@collabora.com?part=3D5
