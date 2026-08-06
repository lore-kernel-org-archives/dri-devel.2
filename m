Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339FDC5AC7C
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B5010F25B;
	Thu,  6 Aug 2026 17:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="c7nGzpCG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7911D10EB6D
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:09:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D7D48441F4;
 Thu,  6 Aug 2026 17:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3178C2BCF7;
 Thu,  6 Aug 2026 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1786036195; bh=QHl4zF104FjEJv5EfdoTh+Dh51gSw1NGDy/nsEhLv34=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=c7nGzpCG4HP0eMzipChrBvI8RvpbuY9GEOT7K9O+5/hjdm6BaQSl3MRLh/u1hTh/2
 8lD8mVffWrgqt4UwcvBG9aW0LF9HZo73WuK8GstPLRqRh2m01n4qspo07ndnD8yY6D
 ECeSpqOKflVkqBfSwmGMWNQVAIZCEl52Vk8m11w4=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8A1C5AC80;
 Thu,  6 Aug 2026 17:09:55 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Fri, 07 Aug 2026 01:07:30 +0800
Subject: [PATCH v3 8/8] drm/tyr: add gpuvas debugfs file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-tyr-debugfs-v2-v3-8-ff5595ac66ae@linux.dev>
References: <20260807-tyr-debugfs-v2-v3-0-ff5595ac66ae@linux.dev>
In-Reply-To: <20260807-tyr-debugfs-v2-v3-0-ff5595ac66ae@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Greg Kroah-Hartman <gregkh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786036192; l=2935;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=QHl4zF104FjEJv5EfdoTh+Dh51gSw1NGDy/nsEhLv34=;
 b=EDW+LINfipfjQN40BZXGiBJkys+ojiHl56VY5LRMvBSzMZqZ0CzU2sJ5et2gOdpgT3surAqHC
 jpT5U223SjcBunTKuYhnu03wROWdcR8/GWF+Ulr6NbP3VqA8N8F6rL+
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
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

Add a gpuvas debugfs file listing all GPU VAs for the Tyr DRM driver.
Collects VMs into a shared list during firmware init and renders them
via dump_gpuva_info on read.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/tyr/debugfs.rs | 20 ++++++++++++++++++++
 drivers/gpu/drm/tyr/driver.rs  | 10 ++++++++++
 drivers/gpu/drm/tyr/tyr.rs     |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/tyr/debugfs.rs b/drivers/gpu/drm/tyr/debugfs.rs
new file mode 100644
index 0000000000000..0e93c629829cd
--- /dev/null
+++ b/drivers/gpu/drm/tyr/debugfs.rs
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Debugfs support for the Tyr DRM driver.
+
+use kernel::{
+    debugfs::SeqShow,
+    prelude::*,
+    seq_file, //
+};
+
+use crate::driver::TyrDrmRegistrationData;
+
+/// `SeqShow` implementation for the `gpuvas` debugfs file.
+pub(crate) struct GpuvasShow;
+
+impl SeqShow<TyrDrmRegistrationData<'_>> for GpuvasShow {
+    fn show(reg_data: &TyrDrmRegistrationData<'_>, m: &seq_file::SeqFile) -> Result {
+        reg_data.vm_registry.for_each(|vm| vm.dump_gpuva_info(m))
+    }
+}
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index f26c3bb332e70..20be2dafa8421 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -7,6 +7,7 @@
         Clk,
         OptionalClk, //
     },
+    debugfs,
     device::{
         Bound,
         Core,
@@ -45,6 +46,7 @@
 };
 
 use crate::{
+    debugfs::GpuvasShow,
     file::TyrDrmFileData,
     fw::{
         irq::{
@@ -87,6 +89,9 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
     /// Firmware sections.
     pub(crate) fw: Arc<Firmware<'drm>>,
 
+    /// VM registry, used by debugfs to enumerate GPU VA spaces.
+    pub(crate) vm_registry: Arc<VmRegistry<'drm>>,
+
     #[pin]
     clks: Mutex<Clocks>,
 
@@ -198,6 +203,7 @@ fn probe<'bound>(
         let reg_data = pin_init!(TyrDrmRegistrationData {
                 pdev,
                 fw: firmware,
+                vm_registry: registry,
                 clks <- new_mutex!(Clocks {
                     core: core_clk,
                     stacks: stacks_clk,
@@ -252,6 +258,10 @@ impl drm::Driver for TyrDrmDriver {
     kernel::declare_drm_ioctls! {
         (PANTHOR_DEV_QUERY, drm_panthor_dev_query, ioctl::RENDER_ALLOW, TyrDrmFileData::dev_query),
     }
+
+    fn debugfs_init(dir: &debugfs::ScopeRef<'_, TyrDrmRegistrationData<'_>>) {
+        dir.seq_file::<GpuvasShow>(c"gpuvas");
+    }
 }
 
 struct Clocks {
diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
index e7ec450bdc9c0..6eb13c15d1657 100644
--- a/drivers/gpu/drm/tyr/tyr.rs
+++ b/drivers/gpu/drm/tyr/tyr.rs
@@ -7,6 +7,7 @@
 
 use crate::driver::TyrPlatformDriver;
 
+mod debugfs;
 mod driver;
 mod file;
 mod fw;

-- 
2.43.0


