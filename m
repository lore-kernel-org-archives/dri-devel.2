Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B1606A335
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=D10N5VNG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E32AF10FFEA;
	Wed, 25 Nov 2026 22:48:16 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1798710FFEA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795646877; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SfW+528XIq4Ya4WrOIVxsZglBhek36jRzqCABOJb1kbIUs9Tg98SaDaIxA2SbHVv55uIzqgvvFFsBGmEGXaxqbKOAbtHhy2w+Ed9vr6Kad4ZKacow51mmpeTPxV3CU85uxAKFvtq3+uQmeNhVWyQQ5B0DQVkYVR0JD32mELCS/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795646877;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/1i4APE0O0sIQ50uMj0gHU7M6QnWF8z8Fcq204FWJZg=; 
 b=YSS/47tfA9apuHIxCkeyhtescZr2DqA/x657yLGP7168L5CWUCIg+34YojJNe4w2LWeVmfEw0fVTjyUhFT25AHlnLGjRFM4TIKdrTEea1r6Lt0aJd9Zg2nYnbUBagKe//WvXQB0HBpkBvz09/b5wXPBUHMaHQWVjyFKTP4BtDyk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=D10N5VNGv1dIDwDlQlZXoE6mS8eTjweW/S8NLNsnnM2VJPWR4hhK9mbIY2+EQu3K6B1iCyDCFB4wpAyFChiBxkTpqP0Mp04ivNkxjufBq2F2441D+CVgCzYtpU1niIx8qWgr7spicab9oIgXmor2YPEJFKcdGzS1X5IoTLNBTr4=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=/1i4APE0O0sIQ50uMj0gHU7M6QnWF8z8Fcq204FWJZg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795646875957665.9814107041586;
 Wed, 25 Nov 2026 14:47:55 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 25 Nov 2026 19:47:01 -0300
Subject: [PATCH 10/13] drm/tyr: add split_u64() for the 64-bit register values
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-b4-tyr-as-casts-v1-10-2b2f53164d86@collabora.com>
References: <20261125-b4-tyr-as-casts-v1-0-2b2f53164d86@collabora.com>
In-Reply-To: <20261125-b4-tyr-as-casts-v1-0-2b2f53164d86@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An `as` cast silently drops the bits that do not fit the target type,
and nothing at the cast shows whether that can happen. As part of a
larger effort to reduce the number of `as` casts in Tyr, add
`split_u64()`, the counterpart of `join_u64()`, and use it for the
64-bit values that the MMU code writes as two 32-bit registers.

The two casts that the split needs are now in one place, each with a
`// CAST:` comment, where there were ten.

No functional change intended.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/mmu/address_space.rs | 29 ++++++++++++++++-------------
 drivers/gpu/drm/tyr/regs.rs              | 12 ++++++++++++
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index f6ccb0d7e3ed..dfa8499a8ebd 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -47,6 +47,7 @@
     regs::{
         mmu_control::mmu_as_control,
         mmu_control::mmu_as_control::*,
+        split_u64,
         MAX_AS, //
     },
     slot::{
@@ -255,34 +256,34 @@ fn as_enable(&mut self, as_nr: usize, as_config: &AddressSpaceConfig) -> Result
 
         let io = &*self.iomem;
 
-        let transtab = as_config.transtab;
+        let (transtab_lo, transtab_hi) = split_u64(as_config.transtab);
         io.write(
             TRANSTAB_LO::try_at(as_nr).ok_or(EINVAL)?,
-            TRANSTAB_LO::from_raw(transtab as u32),
+            TRANSTAB_LO::from_raw(transtab_lo),
         );
         io.write(
             TRANSTAB_HI::try_at(as_nr).ok_or(EINVAL)?,
-            TRANSTAB_HI::from_raw((transtab >> 32) as u32),
+            TRANSTAB_HI::from_raw(transtab_hi),
         );
 
-        let transcfg = as_config.transcfg;
+        let (transcfg_lo, transcfg_hi) = split_u64(as_config.transcfg);
         io.write(
             TRANSCFG_LO::try_at(as_nr).ok_or(EINVAL)?,
-            TRANSCFG_LO::from_raw(transcfg as u32),
+            TRANSCFG_LO::from_raw(transcfg_lo),
         );
         io.write(
             TRANSCFG_HI::try_at(as_nr).ok_or(EINVAL)?,
-            TRANSCFG_HI::from_raw((transcfg >> 32) as u32),
+            TRANSCFG_HI::from_raw(transcfg_hi),
         );
 
-        let memattr = as_config.memattr;
+        let (memattr_lo, memattr_hi) = split_u64(as_config.memattr);
         io.write(
             MEMATTR_LO::try_at(as_nr).ok_or(EINVAL)?,
-            MEMATTR_LO::from_raw(memattr as u32),
+            MEMATTR_LO::from_raw(memattr_lo),
         );
         io.write(
             MEMATTR_HI::try_at(as_nr).ok_or(EINVAL)?,
-            MEMATTR_HI::from_raw((memattr >> 32) as u32),
+            MEMATTR_HI::from_raw(memattr_hi),
         );
 
         self.as_send_cmd_and_wait(as_nr, MmuCommand::Update)?;
@@ -322,14 +323,15 @@ fn as_disable(&mut self, as_nr: usize) -> Result {
         let transcfg = TRANSCFG::zeroed()
             .with_mode(AddressSpaceMode::Unmapped)
             .into_raw();
+        let (transcfg_lo, transcfg_hi) = split_u64(transcfg);
 
         io.write(
             TRANSCFG_LO::try_at(as_nr).ok_or(EINVAL)?,
-            TRANSCFG_LO::from_raw(transcfg as u32),
+            TRANSCFG_LO::from_raw(transcfg_lo),
         );
         io.write(
             TRANSCFG_HI::try_at(as_nr).ok_or(EINVAL)?,
-            TRANSCFG_HI::from_raw((transcfg >> 32) as u32),
+            TRANSCFG_HI::from_raw(transcfg_hi),
         );
 
         self.as_send_cmd_and_wait(as_nr, MmuCommand::Update)?;
@@ -405,14 +407,15 @@ fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> Result {
             .try_with_size(lockaddr_size)?
             .try_with_base(lockaddr_base_field)?
             .into_raw();
+        let (lockaddr_lo, lockaddr_hi) = split_u64(lockaddr_val);
 
         io.write(
             LOCKADDR_LO::try_at(as_nr).ok_or(EINVAL)?,
-            LOCKADDR_LO::from_raw(lockaddr_val as u32),
+            LOCKADDR_LO::from_raw(lockaddr_lo),
         );
         io.write(
             LOCKADDR_HI::try_at(as_nr).ok_or(EINVAL)?,
-            LOCKADDR_HI::from_raw((lockaddr_val >> 32) as u32),
+            LOCKADDR_HI::from_raw(lockaddr_hi),
         );
 
         self.as_send_cmd_and_wait(as_nr, MmuCommand::Lock)
diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 443e9a1e7a21..76892a911227 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -32,6 +32,18 @@ pub(crate) fn join_u64(lo: u32, hi: u32) -> u64 {
     (u64::from(lo)) | ((u64::from(hi)) << 32)
 }
 
+/// Split a 64-bit value into its low and high 32-bit halves.
+pub(crate) fn split_u64(value: u64) -> (u32, u32) {
+    // CAST: The upper 32 bits are dropped on purpose. They are returned in `hi`.
+    #[expect(clippy::as_conversions)]
+    let lo = value as u32;
+    // CAST: After the shift, the value fits in 32 bits.
+    #[expect(clippy::as_conversions)]
+    let hi = (value >> 32) as u32;
+
+    (lo, hi)
+}
+
 /// Read a logical 64-bit value from split 32-bit registers without tearing.
 pub(crate) fn read_u64_no_tearing(lo_read: impl Fn() -> u32, hi_read: impl Fn() -> u32) -> u64 {
     loop {

-- 
2.56.0

