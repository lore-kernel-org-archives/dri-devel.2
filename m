Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF5BC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 17:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732AD10E650;
	Sun, 28 Jun 2026 17:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JHjyTbJM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB35B10E645
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 17:10:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D7BE460054;
 Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C64DC2BCF5;
 Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782666616;
 bh=MbhhfDxuj1yYAs9vqEGFr/7A/9WYijEGfRUwA4iJXlI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=JHjyTbJMrvpKPO14Ae7HViIEfnewdXXyo1ewJqzrX55Utr53TM5zctrZi9QELggg5
 WruztBtyo13L8dbGrLN3sGFig9p+sfeIuYKhh8nzZy9Y7tLb+J5SxAn55nA1rjVUg3
 FBb+SDCbQpXI83rfnRicG5dFMSRb8y4PdOtDW7SsN30TjkOOurEmuINmFhCe0PNmw1
 niV7lo6oXEBU41dARb7Plj/bEk7P5lVO/mPV8sSlGi0B8YZaz1NpQG+nUE5IgP4z8C
 33AzEFqxBtpjOxGUJeCcbMP3C9x5vTKKWAsXn9tpCj9kVweWQj0dqIwtbCYKSs/iVW
 xBYxWYWggGbcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5D156C43327;
 Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
From: SeungJong Ha via B4 Relay <devnull+engineer.jjhama.gmail.com@kernel.org>
Date: Sun, 28 Jun 2026 17:10:16 +0000
Subject: [PATCH RFC 3/4] gpu: nova-core: gsp: derive zerocopy traits for
 the msgq POD types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-dma-zerocopy-bridge-v1-3-9a2895ebe30d@gmail.com>
References: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
In-Reply-To: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 SeungJong Ha <engineer.jjhama@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782666615; l=4702;
 i=engineer.jjhama@gmail.com; s=20260103; h=from:subject:message-id;
 bh=R8N7uz7lecMVzg1CNhtXwHL1Y4crgy5OUPwWz3q1NvM=;
 b=yd+JlLel3gWsMW5+EVRbKPADJedct6vwmdR42C6U1lhZI/wvT1BYNoEzObKVsrYUfI1ItXzf3
 rG9dVLK/ikiC3DZMEGEquhZHRQOndHLy8C39W1iRWN6UaFo+ojGX2Fb
X-Developer-Key: i=engineer.jjhama@gmail.com; a=ed25519;
 pk=G5nmjm+RTiWBpyCvc5xjR1b3li/2zipLSMyz+T4fj5E=
X-Endpoint-Received: by B4 Relay for engineer.jjhama@gmail.com/20260103
 with auth_id=590
X-Original-From: SeungJong Ha <engineer.jjhama@gmail.com>
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
Reply-To: engineer.jjhama@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: SeungJong Ha <engineer.jjhama@gmail.com>

Replace the hand-audited `unsafe impl transmute::{AsBytes, FromBytes}` on
the msgq header newtypes (`MsgqTxHeader`/`MsgqRxHeader`), `PteArray` and
the generated bindings (`msgqTxHeader`/`msgqRxHeader`) with `zerocopy`
derives. These are padding-free PODs, so the derive applies directly.

The bindings derives are hand-added for the demo; canonically they come
from bindgen's `--with-derive-custom-struct`.

Assisted-by: Claude-Code:claude-opus-4-8
Signed-off-by: SeungJong Ha <engineer.jjhama@gmail.com>
---
 drivers/gpu/nova-core/gsp.rs                      | 13 ++-----------
 drivers/gpu/nova-core/gsp/fw.rs                   |  8 ++++----
 drivers/gpu/nova-core/gsp/fw/r570_144.rs          |  2 ++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  4 ++--
 4 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 69175ca3315c..d7da16e9177a 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -12,11 +12,7 @@
         DmaAddress, //
     },
     pci,
-    prelude::*,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    }, //
+    prelude::*, //
 };
 
 pub(crate) mod cmdq;
@@ -48,14 +44,9 @@
 
 /// Array of page table entries, as understood by the GSP bootloader.
 #[repr(C)]
+#[derive(FromBytes, IntoBytes, Immutable)]
 struct PteArray<const NUM_ENTRIES: usize>([u64; NUM_ENTRIES]);
 
-/// SAFETY: arrays of `u64` implement `FromBytes` and we are but a wrapper around one.
-unsafe impl<const NUM_ENTRIES: usize> FromBytes for PteArray<NUM_ENTRIES> {}
-
-/// SAFETY: arrays of `u64` implement `AsBytes` and we are but a wrapper around one.
-unsafe impl<const NUM_ENTRIES: usize> AsBytes for PteArray<NUM_ENTRIES> {}
-
 impl<const NUM_PAGES: usize> PteArray<NUM_PAGES> {
     /// Returns the page table entry for `index`, for a mapping starting at `start`.
     // TODO: Replace with `IoView` projection once available.
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 4db0cfa4dc4d..623ab33847c5 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -696,6 +696,7 @@ fn id8(name: &str) -> u64 {
 
 /// TX header for setting up a message queue with the GSP.
 #[repr(transparent)]
+#[derive(FromBytes, IntoBytes, Immutable)]
 pub(crate) struct MsgqTxHeader(bindings::msgqTxHeader);
 
 impl MsgqTxHeader {
@@ -722,11 +723,11 @@ pub(crate) fn new(msgq_size: u32, rx_hdr_offset: u32, msg_count: u32) -> Self {
     }
 }
 
-// SAFETY: Padding is explicit and does not contain uninitialized data.
-unsafe impl AsBytes for MsgqTxHeader {}
+kernel::impl_transmute_via_zerocopy!(MsgqTxHeader);
 
 /// RX header for setting up a message queue with the GSP.
 #[repr(transparent)]
+#[derive(FromBytes, IntoBytes, Immutable)]
 pub(crate) struct MsgqRxHeader(bindings::msgqRxHeader);
 
 /// Header for the message RX queue.
@@ -737,8 +738,7 @@ pub(crate) fn new() -> Self {
     }
 }
 
-// SAFETY: Padding is explicit and does not contain uninitialized data.
-unsafe impl AsBytes for MsgqRxHeader {}
+kernel::impl_transmute_via_zerocopy!(MsgqRxHeader);
 
 bitfield! {
     struct MsgHeaderVersion(u32) {
diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144.rs b/drivers/gpu/nova-core/gsp/fw/r570_144.rs
index 2e6f0d298756..4b6280fab674 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144.rs
@@ -23,6 +23,8 @@
 )]
 use kernel::ffi;
 use pin_init::MaybeZeroable;
+// Hand-added for the demo; canonically emitted by bindgen --with-derive-custom-struct.
+use kernel::prelude::{FromBytes, Immutable, IntoBytes};
 
 include!("r570_144/bindings.rs");
 
diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index ea350f9b2cc4..82b1e8b155f0 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -846,7 +846,7 @@ pub struct PACKED_REGISTRY_TABLE {
     pub entries: __IncompleteArrayField<PACKED_REGISTRY_ENTRY>,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, IntoBytes, Immutable)]
 pub struct msgqTxHeader {
     pub version: u32_,
     pub size: u32_,
@@ -858,7 +858,7 @@ pub struct msgqTxHeader {
     pub entryOff: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, IntoBytes, Immutable)]
 pub struct msgqRxHeader {
     pub readPtr: u32_,
 }

-- 
2.54.0


