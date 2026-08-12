Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79232C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC42310F11D;
	Wed, 12 Aug 2026 20:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kGNJWRbh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3017210F11D
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 20:08:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4FD91600AD;
 Wed, 12 Aug 2026 20:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FFB1F000E9;
 Wed, 12 Aug 2026 20:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786565319;
 bh=3z7rNG4BBVq1jSqAXqzS//Rp8x1WmGge/jV6kDpQjks=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kGNJWRbhye3ZiaStyb9P7yKio2iUCD7VWZO2n3SJ3bsYkEpnoA0CDriNOE4oEduAM
 ku0T1n4qN2/rNnGlF6wIy8RJF+AcbGisD2MhEpFNj4IWwmZEyHaKxH6GRE3dl/QZZx
 QDzOYIGnSAOascutYHNJvwo/U92XT14y28YGr6ZYFV7we+9uo80302NBRO17ESPs6a
 iJVLvGOwl/1C3Ca7X+wLT0Q8yjck74OQJ+XY40vhP6uYHnrkNlu7LBmPpWUUx8RmGo
 Fcr6jhaEIAWKOHLYRIc7bp1lnKp0YkNo1/zSGMJf6RUTmKCN0mVyfPDVLSDnI4FMsc
 WlLMRYkheHvNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] rust: pci: rework device enabling API
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-2-5d0b5594e52b@mailbox.org>
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
 <20260812-b4-rust-pci-edu-driver-v3-2-5d0b5594e52b@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:08:38 +0000
Message-Id: <20260812200838.A0FFB1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Replacing `pci_enable_device_mem()` with `pci_enable_device()` cau=
ses probe failure on platforms with unassigned legacy I/O BARs.
- [Low] Missing `#[must_use]` attribute on `DeviceEnableGuard` allows silen=
t, immediate device disablement.
- [Low] Missing `#[inline]` attribute on the `enable_device()` abstraction =
method.

Pre-existing issues:
- [High] Incorrect struct field drop order causes MMIO unmap before child d=
evice unregistration (Use-After-Free).
--

--- Patch [2]: [PATCH v3 2/5] rust: pci: rework device enabling API ---
commit d9e225d5ab32388fa1a595e83eeef86ed5e5b2b9
Author: Maurice Hieronymus <mhi@mailbox.org>

rust: pci: rework device enabling API

The commit replaces the unmanaged enable_device_mem() with enable_device(),
returning a resource guard DeviceEnableGuard that automatically runs
pci_disable_device() on drop. It also converts the only user, nova-core, to
use the new API.

Link: https://lore.kernel.org/rust-for-linux/DJOEYVBS17MJ.1YD3TNGQBWHNK@ker=
nel.org

> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 5738d4ac521b7..99b15da59e819 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -30,6 +30,8 @@ pub(crate) struct NovaCore<'bound> {
>      bar: pci::Bar<'bound, BAR0_SIZE>,
>      #[allow(clippy::type_complexity)]
>      _reg: auxiliary::Registration<'bound, ForLt!(())>,

[Severity: High]
This is a pre-existing issue, but does the struct field drop order in NovaC=
ore
cause memory mapped I/O to be unmapped before child devices are unregistere=
d?

Rust drops struct fields in their exact declaration order. Here, bar is
declared before _reg. When the driver is unbound, bar is dropped (unmapping
memory mapped I/O) before _reg is dropped (unregistering auxiliary devices).
If those child devices attempt to access hardware to quiesce it during their
remove callbacks, could this result in a use-after-free or page fault by
accessing unmapped memory?

> +    // Declared last so the device stays enabled until everything above =
is torn down.
> +    _enable: pci::DeviceEnableGuard<'bound>,
>  }

[ ... ]

> @@ -75,7 +77,7 @@ fn probe<'bound>(
>          pin_init::pin_init_scope(move || {
>              dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
> =20
> -            pdev.enable_device_mem()?;
> +            let enable =3D pdev.enable_device()?;

[Severity: High]
Does replacing pci_enable_device_mem() with pci_enable_device() cause probe
failures on platforms with unassigned legacy I/O base address registers?

The previous method, pci_enable_device_mem(), safely bypassed this by only
requesting memory resources, which is typically all modern devices need. Si=
nce
pci_enable_device() internally requests both memory and I/O resources, could
this cause probe failures on platforms (such as many arm64 systems or modern
x86 without legacy vga I/O) where a device has an I/O register but the
firmware or pci core did not assign resources for it?

>              pdev.set_master();

[ ... ]

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 4def9ca1824ce..bd9a8113af358 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -452,11 +452,36 @@ pub fn pci_class(&self) -> Class {
>      }
>  }
> =20
> +/// A guard that keeps the device's I/O and memory resources enabled.
> +///
> +/// # Invariants
> +///
> +/// The device's enable count was incremented once for this guard; dropp=
ing the guard decrements
> +/// it again.
> +pub struct DeviceEnableGuard<'a> {

[Severity: Low]
Could the lack of a #[must_use] attribute on DeviceEnableGuard lead to sile=
nt
logic errors?

If a caller uses the API as pdev.enable_device()?; without binding the
returned guard to a variable, the guard is immediately dropped, running
pci_disable_device() right after enablement. While nova-core uses it
correctly, omitting #[must_use] on guards might allow logic errors to
compile without warnings.

> +    dev: &'a Device<device::Bound>,
> +}

[ ... ]

>  impl<'a> Device<device::Core<'a>> {
> -    /// Enable memory resources for this device.
> -    pub fn enable_device_mem(&self) -> Result {
> +    /// Enable I/O and memory resources for this device.
> +    ///
> +    /// The device stays enabled for the lifetime of the returned guard;=
 dropping the guard
> +    /// disables the device again. The guard borrows the device's bound =
scope, so it cannot
> +    /// outlive the driver binding.
> +    pub fn enable_device(&self) -> Result<DeviceEnableGuard<'_>> {

[Severity: Low]
This isn't a bug, but should the enable_device() forwarding abstraction
function be annotated with #[inline]?

The rust guidelines state: "For abstractions ONLY: Functions that are
small or forwarding to a binding call should be annotated with #[inline]."

>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
> -        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()=
) })
> +        to_result(unsafe { bindings::pci_enable_device(self.as_raw()) })=
?;
> +
> +        // INVARIANT: `pci_enable_device()` succeeded, so the enable cou=
nt was incremented once.
> +        Ok(DeviceEnableGuard { dev: self })
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-b4-rust-pc=
i-edu-driver-v3-0-5d0b5594e52b@mailbox.org?part=3D2
