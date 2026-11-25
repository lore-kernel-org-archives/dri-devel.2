Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441C606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=g6hO2tlR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A129310FFE0;
	Wed, 25 Nov 2026 22:47:51 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D8310FFE0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795646853; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kLfiw5KeLOviKR14fDVtO2jnMiUygd6cpZk4NpowS0uHmYqOfmy+Xx+tj5TRnhZU766929XwTcbYIjTzAKxPYkOeYWzz3TfrILlbeqYJecVxO7ftPE10AtHKihG77k9mGU20KkF897HqjrXTdAgSZUIxS+2S72LaDukVzZMaJMw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795646853;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mBDqk7dnIKeAVaEQ8ukQZV5cRW9aOo0WCUoVaNG9E70=; 
 b=T3Tpei0uDy6D3KBOBHK3kAAb7wXvdEqMWzF7WXV1BmZm5KFvaloWbK63HhV0ujSHx3Dqwb7KcXG9zZ2so7Vh8DfiTeo7CmpUkdFTQIYA141XwoVGqR/qR/OgTOghqIKzuJKGksP2WAtawwYAuyXKlkDXjoXPG8uam9gUOMItymE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=g6hO2tlRXP9Iup0bKkzSAfKFsmA7BIRhineOmJ+G4LpWCzPZOOSWcMAFVxxce1EfbO2HovaUyNK+lXXadaxT3DTSD1BJfHPxdVTcKTirSzoqNSAHaoYFRrR1B2APe/KOuvvo23ZZvfRWL0CGzcxmbeK8Kba84XViNI4rUeiVmbg=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=mBDqk7dnIKeAVaEQ8ukQZV5cRW9aOo0WCUoVaNG9E70=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795646851749477.6835426595662;
 Wed, 25 Nov 2026 14:47:31 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 25 Nov 2026 19:46:56 -0300
Subject: [PATCH 05/13] drm/tyr: use SizeConstants for the u32 and u64 size
 constants
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-b4-tyr-as-casts-v1-5-2b2f53164d86@collabora.com>
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
larger effort to reduce the number of `as` casts in Tyr, use the
`SizeConstants` trait for the size constants that are not used as
`usize`.

The `SZ_*` constants are `usize`, so an expression that mixes one with
a value of another integer type needs a cast on one side.

The `SizeConstants` trait provides the same constants as `u32` and
`u64`, so that neither side has to be cast:

    va % SZ_4K as u64          ->  va % u64::SZ_4K
    va.start as usize % SZ_4K  ->  va.start % u32::SZ_4K

No functional change intended.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/fw/parser.rs |  4 ++--
 drivers/gpu/drm/tyr/vm.rs        | 32 ++++++++++++++------------------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/tyr/fw/parser.rs b/drivers/gpu/drm/tyr/fw/parser.rs
index 89de560bf192..6ff681aa78d1 100644
--- a/drivers/gpu/drm/tyr/fw/parser.rs
+++ b/drivers/gpu/drm/tyr/fw/parser.rs
@@ -20,7 +20,7 @@
     device::Device,
     num::Bounded,
     prelude::*,
-    sizes::SZ_4K, //
+    sizes::SizeConstants, //
 };
 
 use crate::{
@@ -334,7 +334,7 @@ fn parse_section_entry(
             return Err(EINVAL);
         }
 
-        if section_hdr.va.start as usize % SZ_4K != 0 || section_hdr.va.end as usize % SZ_4K != 0 {
+        if section_hdr.va.start % u32::SZ_4K != 0 || section_hdr.va.end % u32::SZ_4K != 0 {
             dev_err!(
                 entry_cursor.dev,
                 "Firmware virtual address range {:#x}..{:#x} is not page aligned",
diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 1dd11b2b1253..72c8593c489e 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -42,11 +42,7 @@
     },
     new_mutex,
     prelude::*,
-    sizes::{
-        SZ_1G,
-        SZ_2M,
-        SZ_4K, //
-    },
+    sizes::SizeConstants,
     sync::{
         aref::ARef,
         Arc,
@@ -491,9 +487,9 @@ pub(crate) fn map_bo_range(
         flags: VmMapFlags,
     ) -> Result {
         if map_size == 0
-            || va % SZ_4K as u64 != 0
-            || bo_offset % SZ_4K as u64 != 0
-            || map_size % SZ_4K as u64 != 0
+            || va % u64::SZ_4K != 0
+            || bo_offset % u64::SZ_4K != 0
+            || map_size % u64::SZ_4K != 0
         {
             return Err(EINVAL);
         }
@@ -545,7 +541,7 @@ pub(crate) fn map_bo_range(
     /// This removes any existing mappings in the specified range, freeing the
     /// virtual address space for reuse.
     pub(crate) fn unmap_range(&self, va: u64, size: u64) -> Result {
-        if size == 0 || va % SZ_4K as u64 != 0 || size % SZ_4K as u64 != 0 {
+        if size == 0 || va % u64::SZ_4K != 0 || size % u64::SZ_4K != 0 {
             return Err(EINVAL);
         }
 
@@ -791,27 +787,27 @@ fn sm_step_remap<'op>(
 /// Returns the page size (4KB or 2MB) and the number of pages that can be mapped at that size.
 fn get_pgsize(addr: u64, size: u64) -> (u64, u64) {
     // Get the distance to the next boundary of 2MB block
-    let blk_offset_2m = addr.wrapping_neg() % (SZ_2M as u64);
+    let blk_offset_2m = addr.wrapping_neg() % u64::SZ_2M;
 
     // Use 4K blocks if the address is not 2MB aligned, or we have less than 2MB to map
-    if blk_offset_2m != 0 || size < SZ_2M as u64 {
+    if blk_offset_2m != 0 || size < u64::SZ_2M {
         let pgcount = if blk_offset_2m == 0 {
-            size / SZ_4K as u64
+            size / u64::SZ_4K
         } else {
-            u64::min(blk_offset_2m, size) / SZ_4K as u64
+            u64::min(blk_offset_2m, size) / u64::SZ_4K
         };
-        return (SZ_4K as u64, pgcount);
+        return (u64::SZ_4K, pgcount);
     }
 
-    let blk_offset_1g = addr.wrapping_neg() % (SZ_1G as u64);
+    let blk_offset_1g = addr.wrapping_neg() % u64::SZ_1G;
     let blk_offset = if blk_offset_1g == 0 {
-        SZ_1G as u64
+        u64::SZ_1G
     } else {
         blk_offset_1g
     };
-    let pgcount = u64::min(blk_offset, size) / SZ_2M as u64;
+    let pgcount = u64::min(blk_offset, size) / u64::SZ_2M;
 
-    (SZ_2M as u64, pgcount)
+    (u64::SZ_2M, pgcount)
 }
 
 /// Maps a physical address range into the page table at the specified virtual address.

-- 
2.56.0

