Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABABCD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84EC10E0C9;
	Fri, 12 Jun 2026 12:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aWBBLlbt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E16610E0C9
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 12:34:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB50E60008;
 Fri, 12 Jun 2026 12:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00B01F000E9;
 Fri, 12 Jun 2026 12:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781267664;
 bh=Y54MncDyC20nn430l0lNofQfX53i/RP2TTU+Lej2ES4=;
 h=From:To:Cc:Subject:Date:Reply-To;
 b=aWBBLlbt7aUtx1s0B0hQ0hCj46Uj8qAVVsaIP+B9s54oK4L7NChXQ7+FsoeBkL4zV
 av49Uc6R/iCc18vM0Un+LOjCKJwHaS89AVFJaljJ+71LuCQe4AFWHHl0t+TMZsrIzC
 wo9SokJI2su3/iG7q/SxJ5qeFHkDZiHUGXdgBTBXmy8Tgi0MtYIzLKHiImgBIeQSbE
 He68LoEimGL3ZSdpPg1VWJuBhqcGYMe/gAa5sXoNDIrr6gDhITQgtVPPaWSyJvD9UJ
 GYtbJ7DFrvCVFrv3C9Kp78eJ0jw7zmE+Yq/Ds6bnBRvNF9Ve6w7HDwMd2BcgW8xc8D
 bGyFWxnQE47VA==
From: Gary Guo <gary@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH] gpu: nova-core: remove `#[allow(non_snake_case)]`
Date: Fri, 12 Jun 2026 13:34:00 +0100
Message-ID: <20260612123401.2684025-1-gary@kernel.org>
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
Reply-To: Gary Guo <gary@garyguo.net>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Gary Guo <gary@garyguo.net>

Since commit 5423ef9d4db8 ("rust: pin-init: internal: suppress
`non_snake_case` lint in `[pin_]init!`"), mere use of the non-snake-case
identifiers would not cause the warning to be generated. Thus remove these
allows.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
This should be applied after the merge window when v7.2-rc1 is backmerged
to drm-rust-next tree, so the pin-init changes are picked up.
---
 drivers/gpu/nova-core/gsp/fw.rs          | 8 --------
 drivers/gpu/nova-core/gsp/fw/commands.rs | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 4db0cfa4dc4d..d96ea0b216b4 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -219,7 +219,6 @@ pub(crate) fn new<'a>(
         gsp_firmware: &'a GspFirmware,
         fb_layout: &'a FbLayout,
     ) -> impl Init<Self> + 'a {
-        #[allow(non_snake_case)]
         let init_inner = init!(bindings::GspFwWprMeta {
             // CAST: we want to store the bits of `GSP_FW_WPR_META_MAGIC` unmodified.
             magic: bindings::GSP_FW_WPR_META_MAGIC as u64,
@@ -674,7 +673,6 @@ fn id8(name: &str) -> u64 {
             u64::from_ne_bytes(bytes)
         }
 
-        #[allow(non_snake_case)]
         let init_inner = init!(bindings::LibosMemoryRegionInitArgument {
             id8: id8(name),
             pa: obj.dma_handle(),
@@ -793,7 +791,6 @@ impl GspMsgElement {
     /// * `sequence` - Sequence number of the message.
     /// * `cmd_size` - Size of the command (not including the message element), in bytes.
     /// * `function` - Function of the message.
-    #[allow(non_snake_case)]
     pub(crate) fn init(
         sequence: u32,
         cmd_size: usize,
@@ -876,7 +873,6 @@ pub(crate) struct GspArgumentsCached {
 impl GspArgumentsCached {
     /// Creates the arguments for starting the GSP up using `cmdq` as its command queue.
     pub(crate) fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
-        #[allow(non_snake_case)]
         let init_inner = init!(bindings::GSP_ARGUMENTS_CACHED {
             messageQueueInitArguments <- MessageQueueInitArguments::new(cmdq),
             bDmemStack: 1,
@@ -923,7 +919,6 @@ unsafe impl FromBytes for GspArgumentsPadded {}
 
 impl MessageQueueInitArguments {
     /// Creates a new init arguments structure for `cmdq`.
-    #[allow(non_snake_case)]
     fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
         init!(MessageQueueInitArguments {
             sharedMemPhysAddr: cmdq.dma_handle,
@@ -947,7 +942,6 @@ pub(crate) enum GspDmaTarget {
 
 impl GspAcrBootGspRmParams {
     fn new(target: GspDmaTarget, wpr_meta_addr: u64) -> impl Init<Self> {
-        #[allow(non_snake_case)]
         let params = init!(Self {
             target: target as u32,
             gspRmDescSize: num::usize_into_u32::<{ size_of::<GspFwWprMeta>() }>(),
@@ -966,7 +960,6 @@ fn new(target: GspDmaTarget, wpr_meta_addr: u64) -> impl Init<Self> {
 
 impl GspRmParams {
     fn new(target: GspDmaTarget, libos_addr: u64) -> impl Init<Self> {
-        #[allow(non_snake_case)]
         let params = init!(Self {
             target: target as u32,
             bootArgsOffset: libos_addr,
@@ -986,7 +979,6 @@ unsafe impl FromBytes for GspFmcBootParams {}
 
 impl GspFmcBootParams {
     pub(crate) fn new(wpr_meta_addr: u64, libos_addr: u64) -> impl Init<Self> {
-        #[allow(non_snake_case)]
         let init = init!(Self {
             // Blackwell FSP obtains WPR info from other sources, so
             // wprCarveoutOffset and wprCarveoutSize are left zero.
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 7bcc41fc7fa0..6c31d825b746 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -27,7 +27,6 @@ pub(crate) struct GspSetSystemInfo {
 
 impl GspSetSystemInfo {
     /// Returns an in-place initializer for the `GspSetSystemInfo` command.
-    #[allow(non_snake_case)]
     pub(crate) fn init<'a>(
         dev: &'a pci::Device<device::Bound>,
         chipset: Chipset,
@@ -99,7 +98,6 @@ pub(crate) struct PackedRegistryTable {
 }
 
 impl PackedRegistryTable {
-    #[allow(non_snake_case)]
     pub(crate) fn init(num_entries: u32, size: u32) -> impl Init<Self> {
         type InnerPackedRegistryTable = bindings::PACKED_REGISTRY_TABLE;
         let init_inner = init!(InnerPackedRegistryTable {

base-commit: 614f7220e548a8df6262887c0140d9267841dbc1
-- 
2.54.0

