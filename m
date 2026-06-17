Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D40CCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6605810EA51;
	Wed, 17 Jun 2026 15:15:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fx+iOUmR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E50910EA51
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:15:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF295600BB;
 Wed, 17 Jun 2026 15:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452D41F00A3A;
 Wed, 17 Jun 2026 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781709319;
 bh=xSAhFBR39uU056nTBcbGxNOfnA00kTlHm9sfXaREbOg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fx+iOUmRAZBFHpVDPWpSYkioGlp7Isy5dxSj7DK5qxQuUcrMAfQk9VF9KdSvm6EJE
 cCDzQRBEyfLgaEUqb1wSLM3ODfKAWEA9ocsq2SAlpU8+r4ufwhZGD/nhgFC15qlSjY
 Vj+dtNAAH9MJQKwh9bnn3IuAkTXU78+2vTDnFqPixXOf6h28uBPyWdYAwzl3Rl2hYT
 FdY0Cta65B3eDMY0E7CsLaYlc6Q/HHOptplFTHeVi0WEprUKTNJ0hvXsezYF6NHo3C
 S2vf5E4AIgU/G7hvWqhE3ItrmvCBPIeMAadoi0QYZ5XzmA5+X0d6CO1yv83XGLRbGA
 svlI4A5k30WWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: drm: unplug the device on Registration drop
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260617150303.2259-1-mike@fireburn.co.uk>
References: <20260617150303.2259-1-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:15:18 +0000
Message-Id: <20260617151519.452D41F00A3A@smtp.kernel.org>
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
- [High] Unconditionally calling `drm_dev_unplug()` in `Registration::drop`=
 skips hardware shutdown for permanent devices utilizing `devres`-based cle=
anup.

Pre-existing issues:
- [High] Managing DRM device registration strictly via `devres` executes `d=
rm_dev_unregister` / `drm_dev_unplug` too late in the device lifecycle, vio=
lating DRM teardown ordering.
--

commit f0dfb3d109f75fcca313ecc2c206c5b4154e5e05
Author: Mike Lothian <mike@fireburn.co.uk>

rust: drm: unplug the device on Registration drop

This commit replaces drm_dev_unregister() with drm_dev_unplug() in the Drop
implementation for Registration. It aims to make device teardown safe for
hot-removable buses by returning -ENODEV to open file descriptors instead
of causing use-after-free errors.

> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index 5233bdebc9fcd..78ca589a8b1c4 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -119,7 +119,15 @@ pub trait Driver {
> =20
>  /// The registration type of a `drm::Device`.
>  ///
> -/// Once the `Registration` structure is dropped, the device is unregist=
ered.
> +/// Once the `Registration` structure is dropped, the device is unplugge=
d (which also
> +/// unregisters it). [`drm_dev_unplug`] is the hot-unplug-safe teardown:=
 it sets the device's
> +/// `unplugged` flag (so the DRM ioctl/mmap paths return `-ENODEV` to an=
y process still holding
> +/// an open `card`/`render` node, rather than dereferencing freed device=
 state), drains
> +/// in-flight `drm_dev_enter`/`drm_dev_exit` critical sections, unregist=
ers the minors, and tears
> +/// down userspace mappings. For devices on a removable bus (e.g. a USB =
dock) this is required
> +/// for safe removal; for permanent devices it is a harmless superset of=
 `drm_dev_unregister`.
> +///
> +/// [`drm_dev_unplug`]: https://docs.kernel.org/gpu/drm-internals.html
>  pub struct Registration<T: Driver>(ARef<drm::Device<T>>);

[Severity: High]
This is a pre-existing issue, but does managing the DRM device registration
strictly via devres execute the unplug/unregister operations too late in the
device lifecycle?

Looking at Registration::new_foreign_owned(), it transfers ownership direct=
ly
to devres and does not return a handle:

Registration::new_foreign_owned(...) {
    ...
    devres::register(dev, reg, GFP_KERNEL)
}

Because devres cleanup executes after the driver's remove() callback
completes, any hardware shutdown manually performed in remove() happens whi=
le
the DRM device is still fully registered and accessible to userspace.

Could this create a race condition where userspace IOCTLs can access the
hardware concurrently with or after its shutdown?

[ ... ]

> @@ -166,7 +174,9 @@ unsafe impl<T: Driver> Send for Registration<T> {}
>  impl<T: Driver> Drop for Registration<T> {
>      fn drop(&mut self) {
>          // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The =
existence of this
> -        // `Registration` also guarantees the this `drm::Device` is actu=
ally registered.
> -        unsafe { bindings::drm_dev_unregister(self.0.as_raw()) };
> +        // `Registration` also guarantees that this `drm::Device` is act=
ually registered.
> +        // `drm_dev_unplug` is the hot-unplug-safe teardown (it calls `d=
rm_dev_unregister`
> +        // internally after marking the device unplugged) =E2=80=94 see =
the type's documentation.
> +        unsafe { bindings::drm_dev_unplug(self.0.as_raw()) };

[Severity: High]
Could unconditionally calling drm_dev_unplug() here skip hardware shutdown
for permanent devices utilizing devres-based cleanup?

The DRM core documentation notes that drm_dev_unplug() marks the device as
unplugged before drm_atomic_helper_shutdown() is called. If a driver uses
devres to manage hardware teardown, the Registration::drop action executes
first on module unload.

If the device is unconditionally marked as unplugged, will subsequent devres
actions that attempt to shut down the hardware via
drm_atomic_helper_shutdown() silently skip execution if their disable
paths are protected with drm_dev_enter()?

Does leaving the hardware enabled while the rest of the driver and its
backing memory are torn down lead to IOMMU faults or memory corruption?

>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617150303.2259=
-1-mike@fireburn.co.uk?part=3D1
