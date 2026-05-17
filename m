Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B21ECD4F3C
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 00:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD10B10E645;
	Sun, 17 May 2026 00:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tWAQTXre";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 612AF10E645
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 00:04:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4843941A4D;
 Sun, 17 May 2026 00:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C710EC2BCC7;
 Sun, 17 May 2026 00:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778976281;
 bh=rJ9Zf42krWnw6GFHxY+YcEyrmhC+ZgJmklrrd85+jss=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tWAQTXreNrT3sTiNeC5mlLs5oVKJdEHYos4o7ou+u0R5pKnc2F5Lv6UNooFPq5D4o
 Du1SZ/+CZ1vHAo6IAkKY9t7dV0xKvnV2QQVKgva7CpVxCTnJWm4nP4S30nxOHvnNAm
 Y7yOc1FCSsnXkp7T5FHMYjz6dZuuCi+nX/FXZ4zJKgkSgmYjgIwYlh4M0QxG6VUtUS
 OmX9auaax/8hdAk2ehehF5hxFZ50EJfwBjKc6keA1TUq5clH/AgME35e7VBXZEgw4Y
 DfDPPsgMZzGobzLlZlQkz3O4NhcqV+9A76HMxhizG7hskO/4NMYTN84KczSRT8z4rE
 oB4RF47wbDJ2A==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com,
 pcolberg@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH REF v3 23/27] gpu: nova-core: rename 'a lifetime to 'bound
Date: Sun, 17 May 2026 02:01:11 +0200
Message-ID: <20260517000149.3226762-24-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517000149.3226762-1-dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
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

Rename the generic lifetime parameter from 'a to 'bound in nova-core.
This makes it explicit that the lifetime represents the device binding
scope, consistent with the convention established by the HRT series.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/firmware/gsp.rs    |  8 ++++----
 drivers/gpu/nova-core/gpu.rs             |  8 ++++----
 drivers/gpu/nova-core/gsp/commands.rs    | 10 +++++-----
 drivers/gpu/nova-core/gsp/fw/commands.rs |  4 +++-
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/gsp.rs b/drivers/gpu/nova-core/firmware/gsp.rs
index 2fcc255c3bc8..9dbd88c55f7e 100644
--- a/drivers/gpu/nova-core/firmware/gsp.rs
+++ b/drivers/gpu/nova-core/firmware/gsp.rs
@@ -65,11 +65,11 @@ pub(crate) struct GspFirmware {
 impl GspFirmware {
     /// Loads the GSP firmware binaries, map them into `dev`'s address-space, and creates the page
     /// tables expected by the GSP bootloader to load it.
-    pub(crate) fn new<'a>(
-        dev: &'a device::Device<device::Bound>,
+    pub(crate) fn new<'bound>(
+        dev: &'bound device::Device<device::Bound>,
         chipset: Chipset,
-        ver: &'a str,
-    ) -> impl PinInit<Self, Error> + 'a {
+        ver: &'bound str,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             let firmware = super::request_firmware(dev, chipset, "gsp", ver)?;
 
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 0f6fe9a1b955..9288b30fe4c3 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -241,11 +241,11 @@ pub(crate) struct Gpu {
 }
 
 impl Gpu {
-    pub(crate) fn new<'a>(
-        pdev: &'a pci::Device<device::Bound>,
+    pub(crate) fn new<'bound>(
+        pdev: &'bound pci::Device<device::Bound>,
         devres_bar: Arc<Devres<Bar0>>,
-        bar: &'a Bar0,
-    ) -> impl PinInit<Self, Error> + 'a {
+        bar: &'bound Bar0,
+    ) -> impl PinInit<Self, Error> + 'bound {
         try_pin_init!(Self {
             spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
                 dev_info!(pdev,"NVIDIA ({})\n", spec);
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index c89c7b57a751..0da5b92f4b27 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -35,18 +35,18 @@
 };
 
 /// The `GspSetSystemInfo` command.
-pub(crate) struct SetSystemInfo<'a> {
-    pdev: &'a pci::Device<device::Bound>,
+pub(crate) struct SetSystemInfo<'bound> {
+    pdev: &'bound pci::Device<device::Bound>,
 }
 
-impl<'a> SetSystemInfo<'a> {
+impl<'bound> SetSystemInfo<'bound> {
     /// Creates a new `GspSetSystemInfo` command using the parameters of `pdev`.
-    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>) -> Self {
+    pub(crate) fn new(pdev: &'bound pci::Device<device::Bound>) -> Self {
         Self { pdev }
     }
 }
 
-impl<'a> CommandToGsp for SetSystemInfo<'a> {
+impl<'bound> CommandToGsp for SetSystemInfo<'bound> {
     const FUNCTION: MsgFunction = MsgFunction::GspSetSystemInfo;
     type Command = GspSetSystemInfo;
     type Reply = NoReply;
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index db46276430be..d3ef7ecdd73e 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -24,7 +24,9 @@ pub(crate) struct GspSetSystemInfo {
 impl GspSetSystemInfo {
     /// Returns an in-place initializer for the `GspSetSystemInfo` command.
     #[allow(non_snake_case)]
-    pub(crate) fn init<'a>(dev: &'a pci::Device<device::Bound>) -> impl Init<Self, Error> + 'a {
+    pub(crate) fn init<'bound>(
+        dev: &'bound pci::Device<device::Bound>,
+    ) -> impl Init<Self, Error> + 'bound {
         type InnerGspSystemInfo = bindings::GspSystemInfo;
         let init_inner = try_init!(InnerGspSystemInfo {
             gpuPhysAddr: dev.resource_start(0)?,
-- 
2.54.0

