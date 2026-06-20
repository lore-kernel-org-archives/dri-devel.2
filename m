Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19BBCD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 00:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A2D10E0BB;
	Sat, 20 Jun 2026 00:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EOVNusge";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 318D310E0BB
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 00:59:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E443D43367;
 Sat, 20 Jun 2026 00:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11D01F000E9;
 Sat, 20 Jun 2026 00:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781917140;
 bh=gePMJcqUlZra1jCxXx3KAnHckGwv664LYHgjEFwKHF0=;
 h=From:To:Cc:Subject:Date;
 b=EOVNusgefsrTJgsz/o1Y7JzDMeMslmZsfR8QawdBNYw+LjVR6UfO8jUx9SEFjB313
 vFCsisjHRgwnkyhg+xPW6lcSUJrWdKwVJXY+eosq2ExKz4CWPM2elO+Sv2Z/qQTz5R
 zMGM4SZ64P1dbFuWST0RsCleno9z1l5UuIS765QlhfexOaOrDprYktPr4W+8ENElOD
 +u2DKp2hg4+reXZWVwbpiGrUpMxv3SNbJ7aSlaWgibDSwAL+26bJYeZQuxBx5MMWja
 YZ0sa0l/abwnZuu0xBo93KvKTcwfh0rUzs8Fb3hNaI8FnIGTB4ZgJXM2Z2Vg23mqVN
 ipK5k6cgHslxg==
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
Subject: [PATCH v3 00/13] rust: drm: Higher-Ranked Lifetime private data
Date: Sat, 20 Jun 2026 02:51:12 +0200
Message-ID: <20260620005431.1562115-1-dakr@kernel.org>
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
RegistrationGuard and ioctl dispatch much cleaner.

On top of that, add RegistrationData as a ForLt associated type on
drm::Driver, allowing drivers to store data whose lifetime is tied to
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

This series is based on [1]; a branch with all patches can be found
in [2].

[1] https://lore.kernel.org/driver-core/20260618230834.812007-1-dakr@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=drm-lifetime

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

Danilo Krummrich (13):
  rust: drm: rename Uninit DeviceContext to Normal
  rust: drm: Add Driver::ParentDevice associated type
  rust: drm: change default DeviceContext to Normal
  rust: drm: restrict AlwaysRefCounted to Normal Device context
  rust: drm: restrict AlwaysRefCounted to Normal GEM Object context
  rust: drm: split Deref for Device context typestates
  rust: drm: return ParentDevice from Device AsRef
  rust: drm: add AsRef<ParentDevice<Bound>> for Device<Registered>
  rust: drm: Add RegistrationGuard for drm_dev_enter/exit critical
    sections
  rust: drm: Add RegistrationData to drm::Driver
  rust: drm: Wrap ioctl dispatch in RegistrationGuard
  rust: drm: Pass registration data to ioctl handlers
  drm: nova: Use drm::Device<Registered> to access the parent bus device

 drivers/gpu/drm/nova/driver.rs |  41 ++---
 drivers/gpu/drm/nova/file.rs   |  18 ++-
 drivers/gpu/drm/nova/gem.rs    |  18 +--
 drivers/gpu/drm/tyr/driver.rs  |  28 ++--
 drivers/gpu/drm/tyr/file.rs    |   1 +
 drivers/gpu/drm/tyr/gem.rs     |  11 +-
 rust/kernel/drm/device.rs      | 264 +++++++++++++++++++++++----------
 rust/kernel/drm/driver.rs      | 129 +++++++++++-----
 rust/kernel/drm/gem/mod.rs     |  98 ++++++------
 rust/kernel/drm/gem/shmem.rs   |  79 +++++-----
 rust/kernel/drm/ioctl.rs       |  27 +++-
 rust/kernel/drm/mod.rs         |   3 +-
 12 files changed, 449 insertions(+), 268 deletions(-)


base-commit: 9ece8b7075e983bc01223a4aa1eb1c99285f83ad
-- 
2.54.0

