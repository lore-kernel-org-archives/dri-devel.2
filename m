Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D8606A6B9
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=cnPynOjz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F09610FFFB;
	Wed, 25 Nov 2026 22:48:34 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8253510FFF2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795646882; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b2bb7N6sSW2Mb52dg3QmwdVS4iQq3y0/WygTcHGbpQ5a3K/pQt78sD0dCBSU4t389HiFmMO3aKifUZ2TMCOlv8xUGEuhve2611OVqfTbqkIC23rvWsDy72mN8zIC3QSNoTVGaYkpT0pLUpp4jQZ655a0tOAOP/p8ZkwpFhh8tDg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795646882;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2dKHKGT3XxjKwes7CxkzvU5EljIpE3zcFDKRCRkPWT8=; 
 b=b148siIbvoSG6Tm+HP4xsZbzXwk/Wn3n2ySlD4eynqQOtQpf/UDL5pbeO+1B8LNgGjLOnp6sK7Wntr+01ldJPlzQqOuheWh99RkDiRwHzMl8Klg9On9QGtAxx8lca5KCCNck769E2J77cWk9WzoMCAH/cVG9tgAeeThrjp3hyxQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=cnPynOjzxvIEwczRTiHJEH3iQzUPbeioccX87X8cbqrEZOZy4GXvVs5QSYWC5Sx+/LgB7kMOmVcd+vt7RC3ZuRwSVzWw/+cXNA1giiGeSYOUWtnqjUUqLdsLgzF4aPwIYPuddoywHjZGltfmLgn9q+huAdunSxPjEQ7emjn1i34=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=2dKHKGT3XxjKwes7CxkzvU5EljIpE3zcFDKRCRkPWT8=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795646880805415.89340071566994; 
 Wed, 25 Nov 2026 14:48:00 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 25 Nov 2026 19:47:02 -0300
Subject: [PATCH 11/13] drm/tyr: return usize from get_pgsize()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-b4-tyr-as-casts-v1-11-2b2f53164d86@collabora.com>
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
larger effort to reduce the number of `as` casts in Tyr, return the
page size and the page count from `get_pgsize()` as `usize`, the type
that `map_pages()` and `unmap_pages()` take. Its two callers cast both
values.

The page size now comes from the `usize` size constants. The page count
is computed from `u64` values, so it is still cast, now in
`get_pgsize()`, with a `// CAST:` comment that gives its bound.

No functional change intended.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/vm.rs | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index f06d5b02d8d7..673fc6819070 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -788,7 +788,7 @@ fn sm_step_remap<'op>(
 /// can be mapped before we hit the 2MB boundary. Or, if mapping 2MB pages,
 /// figure out how many pages can be mapped before hitting the 1GB boundary
 /// Returns the page size (4KB or 2MB) and the number of pages that can be mapped at that size.
-fn get_pgsize(addr: u64, size: u64) -> (u64, u64) {
+fn get_pgsize(addr: u64, size: u64) -> (usize, usize) {
     // Get the distance to the next boundary of 2MB block
     let blk_offset_2m = addr.wrapping_neg() % u64::SZ_2M;
 
@@ -799,7 +799,11 @@ fn get_pgsize(addr: u64, size: u64) -> (u64, u64) {
         } else {
             u64::min(blk_offset_2m, size) / u64::SZ_4K
         };
-        return (u64::SZ_4K, pgcount);
+        // CAST: This path covers less than one 2MB block, so `pgcount` is below 512.
+        #[expect(clippy::as_conversions)]
+        let pgcount = pgcount as usize;
+
+        return (usize::SZ_4K, pgcount);
     }
 
     let blk_offset_1g = addr.wrapping_neg() % u64::SZ_1G;
@@ -809,8 +813,11 @@ fn get_pgsize(addr: u64, size: u64) -> (u64, u64) {
         blk_offset_1g
     };
     let pgcount = u64::min(blk_offset, size) / u64::SZ_2M;
+    // CAST: `blk_offset` is at most 1GB, so `pgcount` is at most 512.
+    #[expect(clippy::as_conversions)]
+    let pgcount = pgcount as usize;
 
-    (u64::SZ_2M, pgcount)
+    (usize::SZ_2M, pgcount)
 }
 
 /// Maps a physical address range into the page table at the specified virtual address.
@@ -869,8 +876,8 @@ fn pt_map(
             pt.map_pages(
                 curr_iova,
                 curr_paddr as PhysAddr,
-                pgsize as usize,
-                pgcount as usize,
+                pgsize,
+                pgcount,
                 prot,
                 GFP_KERNEL,
             )
@@ -933,7 +940,7 @@ fn pt_unmap(dev: &Device, pt: &IoPageTable<'_, ARM64LPAES1>, range: Range<u64>)
         // We know that this page table has one or more consecutive mappings
         // starting at `iova` with the total size of `pgcount * pgsize` because
         // gpuvm callbacks provide exactly the range that was previously mapped.
-        let unmapped = unsafe { pt.unmap_pages(iova_usize, pgsize as usize, pgcount as usize) };
+        let unmapped = unsafe { pt.unmap_pages(iova_usize, pgsize, pgcount) };
 
         if unmapped == 0 {
             dev_err!(dev, "Failed to unmap any bytes at iova {:#x}", iova_usize);

-- 
2.56.0

