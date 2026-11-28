Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5D606A68B
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 02:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=eFqF34Ia
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79CCC112E77;
	Sat, 28 Nov 2026 02:16:43 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43598112E77
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 02:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795832180; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NaSJ2TviINSri/J4g5Oddmz0oKFgqxdVj7QY/ICEo8zYmgfVzkDDTwum1sxycYPVS7Id43fVHP18RNa5hcWfs0Yf8X6OikqazGHOr3zPln9huHxuElLwTnRh0Djv7TJy4Q5JRKZ0aGy7WnCx1yCvl4rZqQceye4RZX24rcjzoAE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795832180;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LpWGezFlxywpiQGUby293UqJ0D4grej8p24s7DenqI0=; 
 b=MCxo01s3tSM65yG6L8xtI9AaKtWmYYC+acUUOnCOFszNChAm4VSLPX+NQw4wilibVyn6vhALvR1VSHEH2WOvIagW5fc2ejY2fDuv6qoDC+uyilXflxTcPK49JJRlEW9Gp6Ok8rP7f4kUp+XyMnZYYPgt9JBw11qVpXG7eB1lwEg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=eFqF34IaB2Pnlvt430hit6LR+Xaj1jWg57MGle/XjAcKvxs9C5qPyEYBqZTSilfmipnxe8wXhT8cwZUMPQnoxQmBW75oq75VomnBusEqi/G6Le36oJtG0sRK1E2muixkQVN7C4ZyTUb3e01iuZalNkuViODWKUDzpcZJp9TI8Us=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=LpWGezFlxywpiQGUby293UqJ0D4grej8p24s7DenqI0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795832178280496.02796124222414; 
 Fri, 27 Nov 2026 18:16:18 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Nov 2026 23:15:45 -0300
Subject: [PATCH 8/9] drm/tyr: flush the caches after disabling an address space
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-tyr-mmu-irq-v1-8-2fcb9f9465cd@collabora.com>
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

as_disable() flushes the caches and only then switches the address
space to UNMAPPED with UPDATE. Between the two, accesses through the
address space can bring its data back into the L2 and load/store caches
that the flush has just cleaned.

Flush only once UPDATE(UNMAPPED) has completed, like panthor does since
commit 9a96e169c926 ("drm/panthor: Move cache-flush after
UPDATE(UNMAPPED)").

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/mmu/address_space.rs | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index dddf5d41f3cc..fa4c26a6eb12 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -312,9 +312,6 @@ fn as_enable(
     fn as_disable(&mut self, io: &IoMem<'_>, as_nr: usize) -> Result {
         self.validate_as_slot(as_nr)?;
 
-        // Flush AS before disabling
-        self.flush_caches(io)?;
-
         // Release any pending LOCK before disabling the address space.
         self.as_send_cmd_and_wait(io, as_nr, MmuCommand::Unlock)?;
 
@@ -351,6 +348,10 @@ fn as_disable(&mut self, io: &IoMem<'_>, as_nr: usize) -> Result {
 
         self.as_send_cmd_and_wait(io, as_nr, MmuCommand::Update)?;
 
+        // Flush only after UPDATE(UNMAPPED) has completed, so this address space
+        // can no longer bring data into the caches.
+        self.flush_caches(io)?;
+
         Ok(())
     }
 

-- 
2.56.0

