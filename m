Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F827606A692
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=PxguGPgm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5BD112E89;
	Sat, 28 Nov 2026 02:16:44 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3276A10EB25
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 02:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795832172; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hLEoaxATPcak6Xq+L3c14uO8SZLTtKdj3s1nNqrKb88v9WY+elVm2P4y9KTfmodE6yfdFg7v4ozlihJ8uF2AbioARty+2a0SPjMUhYNxYiNgAWjJkfNtjpA49dne3Ptkj7hDY4RKF5/3Oc5s7APpXo+UrZxa4EXQN7nGITBbWVs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795832172;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=njf1+mnTFL9x9Uh6nOSJO8XaqKoVPCc5MS+FCBLTRUg=; 
 b=inYfQ9TCFhsBxSzsEF7dcWpkrCI+neB4cik2qlf+jyEx4YI3t7XlXRAhXaRILuVeEvmBXu0dgmA7Wfsl13AsntC6K1Ym6/wAYJBa95BRnUt8blMp8Q2Bxwj4cgQ5e/n5WFWXcVkYtp3yEJ0P9K2YhztG8+XmISeCcSFikFNEMmc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=PxguGPgmbqkeGmyF+VOugE300tOpYv9H51mzre4znJ99h+K7/Zm5dK7TNiMIpVSppwc+/GdQEbvZJxn/W7lcBQr2dbKqCOZyyQBd+z7nmvXNjD3dSTStldYCNvUPF7s6kL2aC1CwHvEB4uLaK6LzRa9t9Andkll/pG5EKyYMSFo=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=njf1+mnTFL9x9Uh6nOSJO8XaqKoVPCc5MS+FCBLTRUg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17958321697001023.4332267587624; 
 Fri, 27 Nov 2026 18:16:09 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Nov 2026 23:15:42 -0300
Subject: [PATCH 5/9] drm/tyr: use FLUSH_CACHES instead of FLUSH_PT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-tyr-mmu-irq-v1-5-2fcb9f9465cd@collabora.com>
References: <20261127-tyr-mmu-irq-v1-0-2fcb9f9465cd@collabora.com>
In-Reply-To: <20261127-tyr-mmu-irq-v1-0-2fcb9f9465cd@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tyr cleans and invalidates the L2 cache with FLUSH_PT, an address space
command that is deprecated from Mali-Gx20 onwards.

Use GPU_COMMAND FLUSH_CACHES followed by UNLOCK instead, like panthor
did in commit dd11c7dec74b ("drm/panthor: Make MMU cache maintenance use
FLUSH_CACHES command"). Also clean and invalidate the load/store caches,
which FLUSH_PT left alone, since after an unmap they can still hold gpu
writes to the unmapped pages, which must not be written back once the
pages are freed. Panthor does the same since commit 6e2d3b3e8589
("drm/panthor: Add support for atomic page table updates").

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/gpu/irq.rs           |  2 ++
 drivers/gpu/drm/tyr/mmu/address_space.rs | 36 ++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tyr/gpu/irq.rs b/drivers/gpu/drm/tyr/gpu/irq.rs
index 3dd1f634c847..91166d77cd9b 100644
--- a/drivers/gpu/drm/tyr/gpu/irq.rs
+++ b/drivers/gpu/drm/tyr/gpu/irq.rs
@@ -90,6 +90,8 @@ fn clear_status(&self, io: &IoMem<'_>, status: u32) {
     fn mask(&self) -> u32 {
         // Only GPU faults are handled. DOORBELL_MIRROR must stay masked because
         // GPU_IRQ_CLEAR cannot clear it.
+        // CLEAN_CACHES_COMPLETED must stay masked because the MMU's cache flush
+        // polls it.
         GPU_IRQ_MASK::zeroed().with_gpu_fault(true).into_raw()
     }
 
diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index 34f5481a6957..d266beec7b40 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -45,6 +45,12 @@
         Mmu, //
     },
     regs::{
+        gpu_control::{
+            FlushMode,
+            GPU_COMMAND,
+            GPU_IRQ_CLEAR,
+            GPU_IRQ_RAWSTAT, //
+        },
         mmu_control::mmu_as_control,
         mmu_control::mmu_as_control::*,
         MAX_AS, //
@@ -425,7 +431,8 @@ fn as_start_update(&mut self, io: &IoMem<'_>, as_nr: usize, region: &Range<u64>)
     /// Returns an error if the slot is invalid or if the flush command fails.
     fn as_end_update(&mut self, io: &IoMem<'_>, as_nr: usize) -> Result {
         self.validate_as_slot(as_nr)?;
-        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::FlushPt)?;
+        self.flush_caches(io)?;
+        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::Unlock)?;
         Ok(())
     }
 
@@ -434,7 +441,32 @@ fn as_end_update(&mut self, io: &IoMem<'_>, as_nr: usize) -> Result {
     /// Returns an error if the slot is invalid or if the flush command fails.
     fn as_flush(&mut self, io: &IoMem<'_>, as_nr: usize) -> Result {
         self.validate_as_slot(as_nr)?;
-        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::FlushPt)
+        self.flush_caches(io)?;
+        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::Unlock)
+    }
+
+    /// Cleans and invalidates the L2 and load/store caches, and waits until that completes.
+    ///
+    /// Taking `&mut self` keeps calls from overlapping.
+    fn flush_caches(&mut self, io: &IoMem<'_>) -> Result {
+        io.write_reg(GPU_IRQ_CLEAR::zeroed().with_clean_caches_completed(true));
+        io.write_reg(GPU_COMMAND::flush_caches(
+            FlushMode::CleanInvalidate,
+            FlushMode::CleanInvalidate,
+            FlushMode::None,
+        ));
+
+        // The GPU IRQ leaves CLEAN_CACHES_COMPLETED masked, so its handler does
+        // not clear the bit under this poll.
+        poll::read_poll_timeout(
+            || Ok(io.read(GPU_IRQ_RAWSTAT)),
+            |status| status.clean_caches_completed(),
+            Delta::from_micros(50),
+            Delta::from_millis(100),
+        )
+        .inspect_err(|_| dev_err!(self.dev, "GPU cache flush timed out\n"))?;
+
+        Ok(())
     }
 }
 

-- 
2.56.0

