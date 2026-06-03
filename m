Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76130CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D69BB113BC8;
	Wed,  3 Jun 2026 01:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QKA7bQlt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65316113BC8
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:28:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D6C2432C1;
 Wed,  3 Jun 2026 01:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7582E1F00893;
 Wed,  3 Jun 2026 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780450103;
 bh=hRinYvXRXA4hFT5GQKiVH1LPW6fzeLKqdFLtLzEGSO8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QKA7bQlti5voVN9YQMzeqRevAT3ae8HEvEdB6OpYEMd5lRZffFQtgxqaVXmZlf6RH
 /zMa8zVzCAtcN5yTfss1IfA2zALnMH3jKwley4CAmirX57gkqp9hPkJ2xwOyKt0yYf
 4pX7meXJZjBTcmgE/kfj/DpTb/4Od9oLVUtWGMRvOwzsANcO3o29Cun40aQZ8mAvCM
 BXcVTgWKbbVA+q2YwIfibVzHkE+OIjot2j4+On3E34DDoPdt0cAhs+sYoTulZamVqU
 dXo8r/5p6Ni4tzq9ujlrRqZb1NiPf3/wotxKme/BTN2jdlzN6VqXTf8q5Dh5VEI4Ay
 vxchtgDRUX/MA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 acourbot@nvidia.com, ecourtney@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 deborah.brouwer@collabora.com, boris.brezillon@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v2 6/7] rust: drm: Pass registration data to ioctl handlers
Date: Wed,  3 Jun 2026 03:15:48 +0200
Message-ID: <20260603011711.2077361-7-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603011711.2077361-1-dakr@kernel.org>
References: <20260603011711.2077361-1-dakr@kernel.org>
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

Pass registration data to ioctl handlers via
UnbindGuard::registration_data_with(). The closure's HRTB ties the
lifetime to the closure scope, and ForLt::cast_ref_unchecked shortens it
from 'static internally. The reference is valid for the duration of the
drm_dev_enter/exit critical section held by UnbindGuard.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/file.rs |  3 +++
 drivers/gpu/drm/tyr/file.rs  |  1 +
 rust/kernel/drm/ioctl.rs     | 15 +++++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index d43f92ee181d..df9760947d58 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -27,6 +27,7 @@ impl File {
     pub(crate) fn get_param(
         dev: &NovaDevice,
         _adev: &auxiliary::Device<Bound>,
+        _reg_data: &(),
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
@@ -48,6 +49,7 @@ pub(crate) fn get_param(
     pub(crate) fn gem_create(
         dev: &NovaDevice,
         _adev: &auxiliary::Device<Bound>,
+        _reg_data: &(),
         req: &mut uapi::drm_nova_gem_create,
         file: &drm::File<File>,
     ) -> Result<u32> {
@@ -62,6 +64,7 @@ pub(crate) fn gem_create(
     pub(crate) fn gem_info(
         _dev: &NovaDevice,
         _adev: &auxiliary::Device<Bound>,
+        _reg_data: &(),
         req: &mut uapi::drm_nova_gem_info,
         file: &drm::File<File>,
     ) -> Result<u32> {
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 181475f18c18..9f53da7633ab 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -32,6 +32,7 @@ impl TyrDrmFileData {
     pub(crate) fn dev_query(
         ddev: &TyrDrmDevice,
         _pdev: &platform::Device<device::Bound>,
+        _reg_data: &(),
         devquery: &mut uapi::drm_panthor_dev_query,
         _file: &TyrDrmFile,
     ) -> Result<u32> {
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 2229dc55764b..773683da7d6a 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -84,6 +84,7 @@ pub mod internal {
 /// ```ignore
 /// fn foo(device: &kernel::drm::Device<Self>,
 ///        parent: &Self::ParentDevice<kernel::device::Bound>,
+///        reg_data: &<Self::RegistrationData as kernel::types::ForLt>::Of<'_>,
 ///        data: &mut uapi::argument_type,
 ///        file: &kernel::drm::File<Self::File>,
 /// ) -> Result<u32>
@@ -146,7 +147,15 @@ macro_rules! declare_drm_ioctls {
                             // type to `$func`'s first parameter, which the compiler cannot infer
                             // through method resolution and associated-type projections alone.
                             #[allow(unreachable_code)]
-                            let _ = || $func(dev, unreachable!(), unreachable!(), unreachable!());
+                            let _ = || {
+                                $func(
+                                    dev,
+                                    unreachable!(),
+                                    unreachable!(),
+                                    unreachable!(),
+                                    unreachable!(),
+                                )
+                            };
 
                             let Some(guard) = dev.unbind_guard() else {
                                 return $crate::error::code::ENODEV.to_errno();
@@ -163,7 +172,9 @@ macro_rules! declare_drm_ioctls {
                             // SAFETY: This is just the DRM file structure
                             let file = unsafe { $crate::drm::File::from_raw(raw_file) };
 
-                            match $func(dev, &*guard, data, file) {
+                            match guard.registration_data_with(|parent, reg_data| {
+                                $func(dev, parent, reg_data, data, file)
+                            }) {
                                 Err(e) => e.to_errno(),
                                 Ok(i) => i.try_into()
                                             .unwrap_or($crate::error::code::ERANGE.to_errno()),
-- 
2.54.0

