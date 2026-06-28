Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC304C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2592C10E614;
	Sun, 28 Jun 2026 14:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BUv3LHPQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3822010E614
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:54:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB56643ADF;
 Sun, 28 Jun 2026 14:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0091F000E9;
 Sun, 28 Jun 2026 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782658452;
 bh=h0jpkAZNtsHGk3Wd8Y63SEq9/8SiZCMBQdR1ISNQCPs=;
 h=From:To:Cc:Subject:Date;
 b=BUv3LHPQjYAqdPFoBdrHya8vQsu22YPxE7YvShCVnkZSs/STb1N+UHgeDKV2JETjX
 nH/X2BBJbdG7VAj4/pz9r4CJHDABkH1bkJ/IMSMrm/jYwhUBtWLRA6Tn5xoLENMK3G
 hDeNSqISUKMG9B4+LMMAK1nu4LdaNcwLi3lYVpZ6UVb/dFTRQpj/bNmBIefDoQEAMk
 YxsLBUn+wM2UILeVcSJQg9WWaOphunP47BXSioLdGhrdfwF88hNDYp+L2U79bwzLWE
 mvNMg5dkbFoFNxLEn+wY4iLyeuWJES0bHVtiSrDz2Oh616FVlbFS3j+x3nH2ESKQw+
 PjaZ4s2E/1g7g==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 acourbot@nvidia.com, ecourtney@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 deborah.brouwer@collabora.com, boris.brezillon@collabora.com,
 lyude@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v5 00/19] rust: drm: Higher-Ranked Lifetime private data
Date: Sun, 28 Jun 2026 16:53:20 +0200
Message-ID: <20260628145406.2107056-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

DRM ioctls run in process context without any guarantee that the parent
bus device is still bound. This series solves the problem by introducing
RegistrationGuard -- a guard representing a drm_dev_enter/exit SRCU
critical section that proves the parent bus device is bound for the
lifetime of the guard.

As initial plumbing for this, the DRM DeviceContext typestates are
reworked: Uninit is renamed to Normal, defaults are adjusted,
AlwaysRefCounted is restricted to Normal, and a Deref chain from
Device<T, Registered> to Device<T, Normal> is established. This gives
Device<T, Registered> the semantic that the device is currently
registered and the parent bus device is bound, which makes the
RegistrationGuard and ioctl dispatch much cleaner. An Ioctl context
restricts registration_guard() to ioctl dispatch, where the DRM core
guarantees prior registration.

On top of that, add RegistrationData as a GAT (Generic Associated Type)
on drm::Driver, allowing drivers to store data whose lifetime is tied to
the parent bus device binding scope. The data is allocated in
Registration::new(), lifetime-erased to 'static for storage, and made
accessible through Device<T, Registered>::registration_data_with(). The
closure's HRTB ties the lifetime to the closure scope; internally the
'static pointer is cast back to the closure-scoped lifetime. The
reference is valid for the duration of the drm_dev_enter/exit critical
section held by RegistrationGuard.

Also update the ioctl dispatch macro to wrap every handler in a
RegistrationGuard, returning ENODEV if the device has been unplugged,
and pass the registration data to handlers.

A branch with all patches can be found in [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=drm-lifetime

Changes in v5:
- Replace __call_ioctl() helper with a simple for<'a> fn(...) coercion
- Rebase onto latest drm-rust-next, which requires a faux::Device type with
  AsBusDevice impl and motivates the removal of the DeviceContext generic from
  shmem::Object entirely
- Replace ForLt with a GAT type RegistrationData<'a>
- Fix drm_dev_register() error path race on the C side
- Add a few missing #[inline] annotations

Changes in v4:
- Fix pre-existing unbounded lifetimes in ioctl handler arguments.
- Fix registration_guard() being callable on unregistered devices by
  introducing an Ioctl device context typestate; registration_guard() is
  now only available on Device<T, Ioctl>, which is exclusively
  constructed in ioctl dispatch context where the DRM core guarantees
  prior registration.
- Fix type inference allowing handlers to obtain Device<Registered>
  before RegistrationGuard is acquired.
- Make RegistrationGuard !Send via NotThreadSafe to prevent potential
  lockdep splats from cross-thread SRCU unlock.
- Store &Device<T, Registered> directly in RegistrationGuard instead of
  calling assume_ctx() in Deref.

Changes in v3:
- Rename UnbindGuard to RegistrationGuard
- RegistrationGuard no longer dereferences to &Device<Bound>; it
  dereferences to &drm::Device<T, Registered> instead
- Drop Registration::new() and rename Registration::new_with_lt() to
  Registration::new()
- Rework DeviceContext typestates: rename Uninit to Normal, restrict
  AlwaysRefCounted to Normal, establish Deref chain from Registered
  to Normal
- Add AsRef<ParentDevice<Bound>> on Device<T, Registered> for parent
  device access
- Move registration_data_with() from RegistrationGuard to
  drm::Device<T, Registered>
- Ioctl handlers no longer receive &Device<Bound>, only registration
  data and drm::Device<T, Registered>
- Use Device<Registered>::as_ref() to access parent device in nova-drm

Changes in v2:
- Replace unsafe direct registration data access in ioctl dispatch with
  safe UnbindGuard::registration_data_with() closure
- Eliminate unbind_guard() free function; use type-inference anchor to
  enable direct dev.unbind_guard() method call in the ioctl macro
- UnbindGuard::registration_data_with() provides both parent device and
  registration data to the closure
- Add nova-drm conversion patch demonstrating lifetime-aware registration
  data with &'bound auxiliary::Device<Bound>
- Various safety comment and documentation improvements

Danilo Krummrich (19):
  rust: drm: ioctl: fix unbounded lifetimes in ioctl handler arguments
  rust: drm: rename Uninit DeviceContext to Normal
  rust: faux: add Device type with AsBusDevice support
  rust: drm: Add Driver::ParentDevice associated type
  rust: drm: change default DeviceContext to Normal
  rust: drm: restrict AlwaysRefCounted to Normal Device context
  rust: drm: restrict AlwaysRefCounted to Normal GEM Object context
  rust: drm/gem: remove DeviceContext from shmem::Object
  rust: drm: split Deref for Device context typestates
  rust: drm: pin ioctl Device reference to Normal context
  rust: drm: add Ioctl device context typestate
  rust: drm: Add RegistrationGuard for drm_dev_enter/exit critical
    sections
  rust: drm: Wrap ioctl dispatch in RegistrationGuard
  rust: drm: return ParentDevice from Device AsRef
  rust: drm: add AsRef<ParentDevice<Bound>> for Device<Registered>
  drm: fix race between partial drm_dev_register() failure and ioctl
  rust: drm: Add RegistrationData to drm::Driver
  rust: drm: Pass registration data to ioctl handlers
  drm: nova: Use drm::Device<Registered> to access the parent bus device

 drivers/gpu/drm/drm_drv.c        |  34 +++-
 drivers/gpu/drm/nova/driver.rs   |  38 ++--
 drivers/gpu/drm/nova/file.rs     |  22 ++-
 drivers/gpu/drm/nova/gem.rs      |  18 +-
 drivers/gpu/drm/tyr/driver.rs    |  25 ++-
 drivers/gpu/drm/tyr/file.rs      |   8 +-
 drivers/gpu/drm/tyr/gem.rs       |  11 +-
 rust/kernel/drm/device.rs        | 293 +++++++++++++++++++++++--------
 rust/kernel/drm/driver.rs        | 111 +++++++-----
 rust/kernel/drm/gem/mod.rs       |  98 +++++------
 rust/kernel/drm/gem/shmem.rs     | 257 +++++++++++++--------------
 rust/kernel/drm/ioctl.rs         |  56 +++++-
 rust/kernel/drm/mod.rs           |   4 +-
 rust/kernel/faux.rs              |  69 ++++++--
 samples/rust/rust_driver_faux.rs |   3 +-
 15 files changed, 660 insertions(+), 387 deletions(-)


base-commit: fa8cc4e3067f958ea2057f37a8a6f9c6b10a9c03
-- 
2.54.0

