Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C15BC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 17:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E321610E64F;
	Sun, 28 Jun 2026 17:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gULMJxTc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70DEC10E645
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 17:10:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D226943F25;
 Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F0C8C2BD04;
 Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782666616;
 bh=np2+vPFSuN+cOSZOmNE6SH9tNHV5vMgBhylcZGo4+/Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=gULMJxTcv1fnLi6GBibNEu2LoPI8Ps5qEFyHdpGuZf7JYNJKS3e0ixOHEKsO7TYZ/
 5b08eksNn3ooFE+tOiZpQw8A7PTy0oqHcPyJ3TRmuWax+/Bvv3x4o7d2S1Xdan40MF
 JozJTSl4IEtX+Jukqv5jE0/py3LoOh64WCJKiYv1sJs7SWvaEn7hFNr4wL12E/MZLd
 w0RFs32nA/EVBCYLFU8ZYu/Q+Fcrdl+qMIxBWWavMub1Jl3eJ3QMevI53rQoNdKfza
 jyhZ3qAh+G6BEmeIFenqNQCuRDcnIXzatMxmpvvM6A5Y+lx92NVbqL56wL+bLI61+v
 5iM3l/o0k3jkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7C531C43458;
 Sun, 28 Jun 2026 17:10:16 +0000 (UTC)
From: SeungJong Ha via B4 Relay <devnull+engineer.jjhama.gmail.com@kernel.org>
Date: Sun, 28 Jun 2026 17:10:17 +0000
Subject: [PATCH RFC 4/4] gpu: nova-core: gsp: convert GspMem to zerocopy
 via the transmute bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-dma-zerocopy-bridge-v1-4-9a2895ebe30d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782666615; l=3247;
 i=engineer.jjhama@gmail.com; s=20260103; h=from:subject:message-id;
 bh=d48cCKivvnRDQm68ktq/uR1zz28Xdd0SmnJqbZoZy8s=;
 b=cbZUKUyzt14pXOSdfcV/Qr/zy05EzjhD6ozy2Be8nSFBJTeQdzYIN/uROEzeTl6S0D9Uj3Xh0
 LscCwKdgDkoD8EZCt4wGkOdBVvWJ8k51VxlaEYKAoUsoTH00crVDMue
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

`GspMem` (shared with the GSP over a DMA `Coherent`) carried a
hand-audited `unsafe impl transmute::{AsBytes, FromBytes}` that did not
actually meet the no-padding requirement: `Msgq` embeds a page-aligned
`MsgqData` after two small headers.

Make that padding explicit (`_pad`), derive the `zerocopy` traits on the
`MsgqData`/`Msgq`/`GspMem` chain, and bridge to `transmute` via
`impl_transmute_via_zerocopy!`. The `unsafe` is now machine-checked.

Unions (e.g. `GspFwWprMeta`) are left on their hand-audited impls, since
`zerocopy::IntoBytes` cannot derive for unions.

Assisted-by: Claude-Code:claude-opus-4-8
Signed-off-by: SeungJong Ha <engineer.jjhama@gmail.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 070de0731e95..d9929d24d316 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -152,7 +152,7 @@ fn read(
 /// This area of memory is to be shared between the driver and the GSP to exchange commands or
 /// messages.
 #[repr(C, align(0x1000))]
-#[derive(Debug)]
+#[derive(Debug, FromBytes, IntoBytes, Immutable)]
 struct MsgqData {
     data: [[u8; GSP_PAGE_SIZE]; num::u32_as_usize(MSGQ_NUM_PAGES)],
 }
@@ -169,6 +169,7 @@ struct MsgqData {
 /// read pointer of `rx` actually refers to the `Msgq` owned by the other side.
 /// This design ensures that only the driver or GSP ever writes to a given instance of this struct.
 #[repr(C)]
+#[derive(FromBytes, IntoBytes, Immutable)]
 // There is no struct defined for this in the open-gpu-kernel-source headers.
 // Instead it is defined by code in `GspMsgQueuesInit()`.
 // TODO: Revert to private once `IoView` projections replace the `gsp_mem` module.
@@ -177,12 +178,16 @@ pub(super) struct Msgq {
     pub(super) tx: MsgqTxHeader,
     /// Header for receiving messages, including the read pointer.
     pub(super) rx: MsgqRxHeader,
+    _pad: [u8; GSP_PAGE_SIZE - size_of::<MsgqTxHeader>() - size_of::<MsgqRxHeader>()],
     /// The message queue proper.
     msgq: MsgqData,
 }
 
+static_assert!(size_of::<MsgqTxHeader>() + size_of::<MsgqRxHeader>() <= GSP_PAGE_SIZE);
+
 /// Structure shared between the driver and the GSP and containing the command and message queues.
 #[repr(C)]
+#[derive(FromBytes, IntoBytes, Immutable)]
 // TODO: Revert to private once `IoView` projections replace the `gsp_mem` module.
 pub(super) struct GspMem {
     /// Self-mapping page table entries.
@@ -205,13 +210,7 @@ impl GspMem {
     const PTE_ARRAY_SIZE: usize = GSP_PAGE_SIZE / size_of::<u64>();
 }
 
-// SAFETY: These structs don't meet the no-padding requirements of AsBytes but
-// that is not a problem because they are not used outside the kernel.
-unsafe impl AsBytes for GspMem {}
-
-// SAFETY: These structs don't meet the no-padding requirements of FromBytes but
-// that is not a problem because they are not used outside the kernel.
-unsafe impl FromBytes for GspMem {}
+kernel::impl_transmute_via_zerocopy!(GspMem);
 
 /// Wrapper around [`GspMem`] to share it with the GPU using a [`Coherent`].
 ///

-- 
2.54.0


