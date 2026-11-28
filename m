Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF9606A335
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=HQ2i6/PN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4EC112E8D;
	Sat, 28 Nov 2026 02:17:12 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58AEE10EB25
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 02:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795832178; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Z5Wgo/oeJ4X+pYDP3K++zUQiShYJkAy46eNSW8Te82/eIZ6t2lgjn8jc2qhLb8zjKOjzqs4o/8p4B29d0RnFKWyqomj46yoy+Us+pAkMYdYi5BhsdWs7cZlLVmHZLy45fdXfc4/O3aXncwHYkkS6kNE1tWpK7ho1Kp8OA3SoMGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795832178;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=noX1O5wIhIXkaFPpFQLL1PDoUo+1OgKAJgfMh+rsgoM=; 
 b=E6VqmqjlKxnTN/Od29HRE627iEQyLJrxFfkU11hCidoL6M/p1X5Jlg7QgeWzPqf5H4Lt6NjBL25bQy9y6bKQRgLDh0BcObHzTqBPKIW4nOCmBqTfSGso43nKymbnMnuGNq/CMlaLa5I637k7CKrbf4b0Kra+bcXuo36W6F2fJwk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=HQ2i6/PNSQUg7Eji132/GXcP9bzphhqBULBHj81KauNRqtbIV/LPBInHhpJzQ+v9Uj7KeQKXGofSlVoc3uYimaZD7EOHI7ZpDr4ExxSobmSwufrvuo3p4RuKqRWUXRcyCaDOolOGDpA5bfB4Rma9iRaXmf9QcBx2CMCUAyI4z4s=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=noX1O5wIhIXkaFPpFQLL1PDoUo+1OgKAJgfMh+rsgoM=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795832175431426.15764727825297; 
 Fri, 27 Nov 2026 18:16:15 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Nov 2026 23:15:44 -0300
Subject: [PATCH 7/9] drm/tyr: use FLUSH_CACHES when disabling an address space
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-tyr-mmu-irq-v1-7-2fcb9f9465cd@collabora.com>
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

as_disable() sends FLUSH_MEM, which cleans and invalidates the L2 and
load/store caches and then unlocks the address space. FLUSH_MEM is
deprecated from Mali-Gx20 onwards.

Do the same with GPU_COMMAND FLUSH_CACHES followed by UNLOCK, as
as_flush() and as_end_update() now do.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/mmu/address_space.rs | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index fc617f282cbe..dddf5d41f3cc 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -306,14 +306,17 @@ fn as_enable(
         Ok(())
     }
 
-    /// Disables an AS slot and clears its configuration.
+    /// Disables an AS slot, clears its configuration and flushes the L2 and load/store caches.
     ///
     /// Returns an error if the slot is invalid or if register writes/commands fail.
     fn as_disable(&mut self, io: &IoMem<'_>, as_nr: usize) -> Result {
         self.validate_as_slot(as_nr)?;
 
         // Flush AS before disabling
-        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::FlushMem)?;
+        self.flush_caches(io)?;
+
+        // Release any pending LOCK before disabling the address space.
+        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::Unlock)?;
 
         io.write(
             TRANSTAB_LO::try_at(as_nr).ok_or(EINVAL)?,

-- 
2.56.0

