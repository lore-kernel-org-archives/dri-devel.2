Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E24CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 22:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041C710EEE4;
	Wed,  6 May 2026 22:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DyJKl05g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB2C10EEE6
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 22:11:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 030654406A;
 Wed,  6 May 2026 22:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83AFC2BCC4;
 Wed,  6 May 2026 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778105465;
 bh=WqnqVDXE7PEFLewRIxuny1MyhNaqsV7/dGlY5N1/SHA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DyJKl05gBAQGXeOfRoVsLh+QTk+kni40nVqUpz1StnfzGOKTDskr7NobSPIsPFHsx
 mDDhctvxjgilowaWmV05iQ+HCzMZOUT39rhK3HapJmzw2dH0u59dnchXL30IS15n4H
 Khu4umK4WINDOoDsuq7WmaXF+nQDwCgSGjo/4/TYMZ/P2ndwMmhRr06AvBFimkzcjg
 GK/RpiC6yMxCP2/7cQP2bYlhFWbeF7QaUVrmdS+qzlhBWkrGy19upft12z8LRMwJs9
 7WoH2Qazd6t4CMG3QCia4Bu7eQ+bI3/neaREJD3r0iYU9zqxP2dIGOYEKrV5M1/t+b
 etGHLjDWrLbFw==
From: Danilo Krummrich <dakr@kernel.org>
To: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 daniel.almeida@collabora.com, acourbot@nvidia.com, apopple@nvidia.com,
 ecourtney@nvidia.com, deborah.brouwer@collabora.com, lyude@redhat.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Cc: driver-core@lists.linux.dev, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6/6] rust: drm: Pass bound parent device to ioctl handlers
Date: Thu,  7 May 2026 00:06:04 +0200
Message-ID: <20260506221027.858481-7-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506221027.858481-1-dakr@kernel.org>
References: <20260506221027.858481-1-dakr@kernel.org>
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

Pass &Self::ParentDevice<Bound> as the second argument to ioctl
handlers, obtained from the UnbindGuard via Deref. This gives ioctl
handlers direct access to the bound parent bus device.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/file.rs | 5 +++++
 drivers/gpu/drm/tyr/file.rs  | 3 +++
 rust/kernel/drm/ioctl.rs     | 3 ++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 4c9fa409a8be..df9760947d58 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -4,6 +4,8 @@
 use crate::gem::NovaObject;
 use kernel::{
     alloc::flags::*,
+    auxiliary,
+    device::Bound,
     drm::{self, gem::BaseObject},
     pci,
     prelude::*,
@@ -24,6 +26,7 @@ impl File {
     /// IOCTL: get_param: Query GPU / driver metadata.
     pub(crate) fn get_param(
         dev: &NovaDevice,
+        _adev: &auxiliary::Device<Bound>,
         _reg_data: &(),
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
@@ -45,6 +48,7 @@ pub(crate) fn get_param(
     /// IOCTL: gem_create: Create a new DRM GEM object.
     pub(crate) fn gem_create(
         dev: &NovaDevice,
+        _adev: &auxiliary::Device<Bound>,
         _reg_data: &(),
         req: &mut uapi::drm_nova_gem_create,
         file: &drm::File<File>,
@@ -59,6 +63,7 @@ pub(crate) fn gem_create(
     /// IOCTL: gem_info: Query GEM metadata.
     pub(crate) fn gem_info(
         _dev: &NovaDevice,
+        _adev: &auxiliary::Device<Bound>,
         _reg_data: &(),
         req: &mut uapi::drm_nova_gem_info,
         file: &drm::File<File>,
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 6262114c6a8d..9f53da7633ab 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
 use kernel::{
+    device,
     drm,
+    platform,
     prelude::*,
     uaccess::UserSlice,
     uapi, //
@@ -29,6 +31,7 @@ fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
 impl TyrDrmFileData {
     pub(crate) fn dev_query(
         ddev: &TyrDrmDevice,
+        _pdev: &platform::Device<device::Bound>,
         _reg_data: &(),
         devquery: &mut uapi::drm_panthor_dev_query,
         _file: &TyrDrmFile,
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index dd177bc399b2..181918303f2f 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -83,6 +83,7 @@ pub mod internal {
 ///
 /// ```ignore
 /// fn foo(device: &kernel::drm::Device<Self>,
+///        parent: &Self::ParentDevice<kernel::device::Bound>,
 ///        reg_data: &<Self::RegistrationData as kernel::types::ForLt>::Of<'_>,
 ///        data: &mut uapi::argument_type,
 ///        file: &kernel::drm::File<Self::File>,
@@ -157,7 +158,7 @@ macro_rules! declare_drm_ioctls {
                             // SAFETY: This is just the DRM file structure
                             let file = unsafe { $crate::drm::File::from_raw(raw_file) };
 
-                            match $func(dev, guard.registration_data(), data, file) {
+                            match $func(dev, &*guard, guard.registration_data(), data, file) {
                                 Err(e) => e.to_errno(),
                                 Ok(i) => i.try_into()
                                             .unwrap_or($crate::error::code::ERANGE.to_errno()),
-- 
2.54.0

