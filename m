Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C4606A690
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=aAw2PTrR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C026610EB25;
	Sat, 28 Nov 2026 02:16:27 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C66B9112E77
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 02:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795832174; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mP2at//5/FGy9jote8+ecpOKonzuEdX2Lf5H2rxhSkY5Z3OAu+WYq30az92B08yIYDCko72JfVgXw2A7qUBOMEollppzsFbUeD8KnJjIKU4RNGm3Ab+9JT/nvPGgw8s07cBAiw3eqHaJDiIbTuhNmOpO/UliGhDj9HTL96/IlDA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795832174;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kA1PAQNXubjiqx5Cvaqa2i6f3lZjlznUI6bg/jd6Fac=; 
 b=Tc8LJJrMqEhvxNmWCaXVPhPC7lJfWdxpFkFFVRB2tiEsUiOwZqS262/TGLyjsDg/THhhYFnawn6cijXibAzEBNzK3RS1AjJVeA0WI4MN5j1ktoXD7lGQEKY2XO58FEIsbAzzAe+g7E9ymi9i/w1IcznMd9jRWAkJTaoTgLohM+o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=aAw2PTrRHN0VBSkfgpdXCHbQaqQZ0Ma7NQdfbz1fuBwZL29gNPL1zl7JP3Z4dNiYxWWhru+LsnjNXP7e57+1fJKwzOTiRdKVImENC5Jr8GdrEJTWPgYF/UHHF9ff0XsX5v+J73UcY4I6YrJCRyGbkjEDiCT09tXnAqo4hlamRiY=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=kA1PAQNXubjiqx5Cvaqa2i6f3lZjlznUI6bg/jd6Fac=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795832172540715.9887203570161;
 Fri, 27 Nov 2026 18:16:12 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Nov 2026 23:15:43 -0300
Subject: [PATCH 6/9] drm/tyr: do not issue a cache flush while one is pending
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-tyr-mmu-irq-v1-6-2fcb9f9465cd@collabora.com>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a cache flush times out, the next call to flush_caches() issues a
new FLUSH_CACHES while the first one may still be pending, which has an
undefined result in the hardware.

Track the pending flush and return -EIO until the gpu reports it
complete, like panthor does since commit 3c0a60195b37 ("drm/panthor:
Recover from panthor_gpu_flush_caches() failures").

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/mmu/address_space.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index d266beec7b40..fc617f282cbe 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -167,6 +167,9 @@ pub(crate) struct AddressSpaceManager<'drm> {
 
     /// Bitmask of present address space slots from GPU_AS_PRESENT register.
     as_present: u32,
+
+    /// Whether a cache flush was issued and its completion has not been seen yet.
+    flush_pending: bool,
 }
 
 impl<'drm> AddressSpaceManager<'drm> {
@@ -191,6 +194,7 @@ pub(super) fn new(
             dev,
             hw,
             as_present,
+            flush_pending: false,
         })
     }
 
@@ -448,13 +452,21 @@ fn as_flush(&mut self, io: &IoMem<'_>, as_nr: usize) -> Result {
     /// Cleans and invalidates the L2 and load/store caches, and waits until that completes.
     ///
     /// Taking `&mut self` keeps calls from overlapping.
+    /// A flush that timed out may still be pending, and issuing another one then has an undefined
+    /// result, so after such a flush the next ones fail with EIO until the GPU reports its
+    /// completion.
     fn flush_caches(&mut self, io: &IoMem<'_>) -> Result {
+        if self.flush_pending && !io.read(GPU_IRQ_RAWSTAT).clean_caches_completed() {
+            return Err(EIO);
+        }
+
         io.write_reg(GPU_IRQ_CLEAR::zeroed().with_clean_caches_completed(true));
         io.write_reg(GPU_COMMAND::flush_caches(
             FlushMode::CleanInvalidate,
             FlushMode::CleanInvalidate,
             FlushMode::None,
         ));
+        self.flush_pending = true;
 
         // The GPU IRQ leaves CLEAN_CACHES_COMPLETED masked, so its handler does
         // not clear the bit under this poll.
@@ -466,6 +478,7 @@ fn flush_caches(&mut self, io: &IoMem<'_>) -> Result {
         )
         .inspect_err(|_| dev_err!(self.dev, "GPU cache flush timed out\n"))?;
 
+        self.flush_pending = false;
         Ok(())
     }
 }

-- 
2.56.0

