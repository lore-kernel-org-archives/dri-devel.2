Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B2BCD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 00:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 700A010E157;
	Sat, 20 Jun 2026 00:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SBmQ3YRo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0831B10E157
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 00:59:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E424A41A47;
 Sat, 20 Jun 2026 00:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0CC1F000E9;
 Sat, 20 Jun 2026 00:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781917194;
 bh=hnLJscSYFxaJHX8//CAzr3Tijjv4ko8kGOqkgAPa8gA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SBmQ3YRoV9s5NwSoL1z1guf7zs8L5lkeh3TMZ0nlCrHFgTBYJmjt1A9EcQJotHtmG
 HU3AMiwVEA2B7un5D0aR2jooLyxVGQV8KfQStjj/fNg6AHHnUdHd1DhQ5aaxFgH6J+
 dGG/1SfM3VM1D0rzu5PHH6I9dFHO+WOTfhfJdp6DdGlZyiEygg9FhIZqVTSDdEZ//j
 Oth6GS1IkN9ZX7X4IBuuMcZasoa1g00BvagOP+aqck6oQlLXnp/iZ9MrqbTiJqdI78
 uc1EJa7dj5JNGYuONv4fD06Es79ZQAqZIIVw4Dd9e3YEtcXPcZg2pnfOUwsPebFLjc
 FlAHwbu5jP43A==
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
Subject: [PATCH v3 12/13] rust: drm: Pass registration data to ioctl handlers
Date: Sat, 20 Jun 2026 02:51:24 +0200
Message-ID: <20260620005431.1562115-13-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620005431.1562115-1-dakr@kernel.org>
References: <20260620005431.1562115-1-dakr@kernel.org>
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
drm::Device<Registered>::registration_data_with(). The closure's HRTB
ties the lifetime to the closure scope, and the pointer cast shortens it
from 'static internally. The reference is valid for the duration of the
drm_dev_enter/exit critical section held by RegistrationGuard.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/file.rs |  3 +++
 drivers/gpu/drm/tyr/file.rs  |  1 +
 rust/kernel/drm/ioctl.rs     | 16 +++++++++++++---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index a3b7bd36792c..4c9fa409a8be 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -24,6 +24,7 @@ impl File {
     /// IOCTL: get_param: Query GPU / driver metadata.
     pub(crate) fn get_param(
         dev: &NovaDevice,
+        _reg_data: &(),
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
@@ -44,6 +45,7 @@ pub(crate) fn get_param(
     /// IOCTL: gem_create: Create a new DRM GEM object.
     pub(crate) fn gem_create(
         dev: &NovaDevice,
+        _reg_data: &(),
         req: &mut uapi::drm_nova_gem_create,
         file: &drm::File<File>,
     ) -> Result<u32> {
@@ -57,6 +59,7 @@ pub(crate) fn gem_create(
     /// IOCTL: gem_info: Query GEM metadata.
     pub(crate) fn gem_info(
         _dev: &NovaDevice,
+        _reg_data: &(),
         req: &mut uapi::drm_nova_gem_info,
         file: &drm::File<File>,
     ) -> Result<u32> {
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 31411da203c5..6262114c6a8d 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -29,6 +29,7 @@ fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
 impl TyrDrmFileData {
     pub(crate) fn dev_query(
         ddev: &TyrDrmDevice,
+        _reg_data: &(),
         devquery: &mut uapi::drm_panthor_dev_query,
         _file: &TyrDrmFile,
     ) -> Result<u32> {
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index c6a03be018e6..ecc1a0383635 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -83,6 +83,7 @@ pub mod internal {
 ///
 /// ```ignore
 /// fn foo(device: &kernel::drm::Device<Self>,
+///        reg_data: &<Self::RegistrationData as kernel::types::ForLt>::Of<'_>,
 ///        data: &mut uapi::argument_type,
 ///        file: &kernel::drm::File<Self::File>,
 /// ) -> Result<u32>
@@ -143,9 +144,16 @@ macro_rules! declare_drm_ioctls {
                             // type to `$func`'s first parameter, which the compiler cannot infer
                             // through method resolution and associated-type projections alone.
                             #[allow(unreachable_code)]
-                            let _ = || $func(dev, unreachable!(), unreachable!());
+                            let _ = || {
+                                $func(
+                                    dev,
+                                    unreachable!(),
+                                    unreachable!(),
+                                    unreachable!(),
+                                )
+                            };
 
-                            let Some(_guard) = dev.registration_guard() else {
+                            let Some(guard) = dev.registration_guard() else {
                                 return $crate::error::code::ENODEV.to_errno();
                             };
                             // SAFETY: The ioctl argument has size `_IOC_SIZE(cmd)`, which we
@@ -160,7 +168,9 @@ macro_rules! declare_drm_ioctls {
                             // SAFETY: This is just the DRM file structure
                             let file = unsafe { $crate::drm::File::from_raw(raw_file) };
 
-                            match $func(dev, data, file) {
+                            match guard.registration_data_with(|reg_data| {
+                                $func(&*guard, reg_data, data, file)
+                            }) {
                                 Err(e) => e.to_errno(),
                                 Ok(i) => i.try_into()
                                             .unwrap_or($crate::error::code::ERANGE.to_errno()),
-- 
2.54.0

