Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECC8C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AF210F4BC;
	Fri, 14 Aug 2026 23:29:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BbzBPuH/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E225B10F4BC
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:29:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 413A460008;
 Fri, 14 Aug 2026 23:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A651F000E9;
 Fri, 14 Aug 2026 23:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786750186;
 bh=S9CASVhCtnLwmPXLd8hbBHezKQSIzUF/vbY5Go0UMCw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BbzBPuH/HPqN8qPzJYQUPUqSoHU7v5Mmbkn72Y1LBemhQ1Dx4WUf5mKt0bdrz5gKm
 eW8RxY3nJLaBSOVbjqGDOzta28tRZ0tlBsrd4Xt+TG98JJOZQCdT516FQb+1L0zYPU
 xi/dEF6vP6H2mimeWMwPR4iK4tpAsDUv5YtmZFxySWhi0pvTu2vhocoNp8oBqsXGVk
 WjZaGlzFtzKLX/6kr8oFY+KiuRPZjggl97TR3Wc3Ic8CvwI4ySfRY5STskOripUVcC
 5S0yxnB7ngt7laE9WTGeKyV6ocheDJJ3ir5UoDgcMP8g5n1FEtaIgT+sDoIOmAkrnW
 Lmc82Vl7xC3Eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] rust: drm: wrap fops open with RegistrationGuard
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260814230923.1292966-6-dakr@kernel.org>
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-6-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:29:45 +0000
Message-Id: <20260814232945.A0A651F000E9@smtp.kernel.org>
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
- [High] Re-acquiring the DRM minor by ID in `fops_open` is vulnerable to a=
 TOCTOU race, breaking type safety invariants.
--

--- Patch [5]: [PATCH 5/7] rust: drm: wrap fops open with RegistrationGuard=
 ---
commit f19fe1023e3626e0af6b5b4f7cdaf8f59acc5f98
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: wrap fops open with RegistrationGuard

Add a Minor abstraction with RAII release and a fops_open() wrapper that
holds a RegistrationGuard (drm_dev_enter / drm_dev_exit) across the
entire drm_open() call. This guarantees that drm_dev_unplug() in=20
Registration::drop() waits for the full open sequence to complete.

> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index a2940e172073a..09903ed783e15 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs

[ ... ]

> +    /// Wrapper for `fops.open` that holds a [`RegistrationGuard`] acros=
s the entire `drm_open()`
> +    /// call. This guarantees that `drm_dev_unplug()` in `Registration::=
drop()` waits for the full
> +    /// open sequence.
> +    extern "C" fn fops_open(inode: *mut bindings::inode, filp: *mut bind=
ings::file) -> c_int {
> +        let f =3D || -> Result<c_int> {
> +            // SAFETY: `inode` is valid.
> +            let minor_id =3D unsafe { bindings::iminor(inode) };
> +            let minor =3D Minor::acquire(minor_id)?;
> +
> +            // SAFETY: `fops_open` is only installed for devices of type=
 `T` (via `FOPS`).
> +            let _guard =3D (unsafe { minor.device::<T>() })

[Severity: High]
Can this sequence cause type confusion if the DRM minor ID is reassigned?

If a device T is unplugged concurrently with the open call, the minor_id
can be freed and reassigned to a different device U.

Since the VFS already resolved filp->f_op to T::fops_open during
drm_stub_open, the following sequence could occur:

1. VFS calls chrdev_open which resolves to drm_stub_open
2. drm_stub_open looks up minor_id, gets device T, and sets filp->f_op to
   T::FOPS
3. Device T is unplugged, and its minor_id is freed
4. Device U is hot-plugged, and drm_minor_alloc reuses the same minor_id
5. T::fops_open is called by VFS and invokes Minor::acquire(minor_id)
6. The returned minor now belongs to device U, not T

When minor.device::<T>() is called here, it unsafely downcasts Device<U>
to Device<T>. This violates Rust's type safety and aliasing invariants.
Is there a way to avoid looking up the minor by ID again to prevent this
race condition?

> +                .registration_guard()
> +                .ok_or(ENODEV)?;
> +
> +            // SAFETY: `inode` and `filp` are valid. The RegistrationGua=
rd ensures the entire
> +            // `drm_open()` runs within the SRCU critical section.
> +            Ok(unsafe { bindings::drm_open(inode, filp) })
> +        };
> +
> +        match f() {
> +            Ok(ret) =3D> ret,
> +            Err(e) =3D> e.to_errno(),
> +        }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814230923.1292=
966-1-dakr@kernel.org?part=3D5
