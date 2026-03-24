Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2529AF532C4
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 00:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DB610E573;
	Tue, 24 Mar 2026 00:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="MO2q+RBm";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079E410E505
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 00:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774311502; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lAH7vwivSgwq++HcdcOyLo/w59Vw9ERUFf1mnzVqzFbdOkVbQkGsz9Jm+5lkLBH9V3/PrCJRxdlA1bTBd3ws1Numh9raS1Q+rua1XU6UIuH4ANyfMadwRwcIlrPFLc861MqflJiX7Q/IhvmwgwGRSGHXhvbHN+P6zdDR77TyXmk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774311502;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KQpX+v61IHHdbwq3jnORj4SrTacjHP8jinwRfZX56L4=; 
 b=Uwl3jpeEhtlieedVs+vNR8mv6BhnAKXX7dmfN4+hU44LTknx9+j2Oa7379TlkYbyFczS21Bp6C2zcQxYhmCvrr1CJ4Ihl2CutH/1GsqX1aEvtjpOvROP5+kDntmnwx8QMsgXGfUK+Jrakz4U+VOHLRmDFL1Bm3yAnQ69nOIvvnU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774311502; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=KQpX+v61IHHdbwq3jnORj4SrTacjHP8jinwRfZX56L4=;
 b=MO2q+RBm/DGiSFuPNvVHTQWUfyQu1JP5kUyH/d/z6VZJe58p/LLtn2/LyOdIo8+v
 GxOsfZkKlFIdsCRlLlFLO1qMlwZ+w6sfJbKGzvqxSQK/ALO3/OlcI+BNPnqdO+kbpI7
 vS/PUAm5tEebdz4FJs8Y34JF5z5VemPtNZBt+t5M=
Received: by mx.zohomail.com with SMTPS id 1774311502015342.0233472743241;
 Mon, 23 Mar 2026 17:18:22 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 23 Mar 2026 17:18:11 -0700
Subject: [PATCH v3 09/12] drm/tyr: Add fields for COMMAND register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-tyr-use-register-macro-v3-v3-9-a87daf9e4701@collabora.com>
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
In-Reply-To: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
To: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Boqun Feng <boqun@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2654;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=GenPpPmuP0v5sT/X+5OG/phJ/Z2yLyF2hy7MjjkNbls=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJkHbzjs+56V/V8k9MNbB1N7mSPK2dZPqlMmTA+/tXtXw
 +sXijfqO0pZGMS4GGTFFFnO2hv1iFe9N9Kd/78ZZg4rE8gQBi5OAZjI/vmMDHeZpzKGnjnyU0NF
 lqfhasDthSZfymp2ln949vyu2MsHV+UZ/qnxRH7fvXey3d8rjSWC/HsbH646csl24kMrn38ma96
 uz2ECAA==
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

The MMU COMMAND register accepts specific commands. Enumerate those
commands and use the register! macro to ensure that only those commands
can be written to the MMU COMMAND register.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/regs.rs | 47 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 9bf2723ab6412034be9a77930532cc89d0adb128..6fbd6268724eb6b2ea8d76c5d991353dcbe87068 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -1048,8 +1048,53 @@ fn from(val: MMU_MEMATTR_STAGE1) -> Self {
                 63:12   base;
             }
 
+        }
+
+        /// Helpers for MMU COMMAND register.
+        #[derive(Copy, Clone, Debug)]
+        #[repr(u8)]
+        pub(crate) enum MmuCommand {
+            /// No operation, nothing happens.
+            Nop = 0,
+            /// Propagate settings to the MMU.
+            Update = 1,
+            /// Lock an address region.
+            Lock = 2,
+            /// Unlock an address region.
+            Unlock = 3,
+            /// Clean and invalidate the L2 cache, then unlock.
+            FlushPt = 4,
+            /// Clean and invalidate all caches, then unlock.
+            FlushMem = 5,
+        }
+
+        impl TryFrom<Bounded<u32, 8>> for MmuCommand {
+            type Error = Error;
+
+            fn try_from(val: Bounded<u32, 8>) -> Result<Self, Self::Error> {
+                match val.get() {
+                    0 => Ok(MmuCommand::Nop),
+                    1 => Ok(MmuCommand::Update),
+                    2 => Ok(MmuCommand::Lock),
+                    3 => Ok(MmuCommand::Unlock),
+                    4 => Ok(MmuCommand::FlushPt),
+                    5 => Ok(MmuCommand::FlushMem),
+                    _ => Err(EINVAL),
+                }
+            }
+        }
+
+        impl From<MmuCommand> for Bounded<u32, 8> {
+            fn from(cmd: MmuCommand) -> Self {
+                (cmd as u8).into()
+            }
+        }
+
+        register! {
             /// MMU command register for each address space. Write only.
-            pub(crate) COMMAND(u32)[MAX_AS, stride = STRIDE] @ 0x2418 {}
+            pub(crate) COMMAND(u32)[MAX_AS, stride = STRIDE] @ 0x2418 {
+                7:0     command ?=> MmuCommand;
+            }
 
             /// Fault status register for each address space. Read only.
             pub(crate) FAULTSTATUS(u32)[MAX_AS, stride = STRIDE] @ 0x241c {}

-- 
2.52.0

