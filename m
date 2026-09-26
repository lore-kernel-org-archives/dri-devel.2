Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6B1C98338
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876DB10E2F9;
	Sat, 26 Sep 2026 12:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lAIVUBmL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A5810E1FD
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 12:44:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DCFD143F82;
 Sat, 26 Sep 2026 12:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44851F000FF;
 Sat, 26 Sep 2026 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790426653;
 bh=fll1LaJlEPwgfTtTI1+UE721Sfzu3Pk1wXbGHZdj54U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lAIVUBmL3kMirvNZevzNmY0iq8jpnznlT2kZvUcbW4ADX7H/Ev6NWGR+mXTaYPopE
 b9HOHFRQA8vjHw2ODVtXEIVbW8DzxRO303VD5IKdC4b3VHgiPw46Tos5Jn0gB5XVaX
 LKAn8JqZQztaxUAfTiK1tkb61O3+Kl6uKBWd2sypIt5xgHtzsJA7pByDk+j5n85Iha
 8HKo1qKv8iypjUqarGQMTxNK3VZCSR6ny2yUAgCYgy7a7s8yqgceMVMRGw71ge5X+g
 dmCYqt3ym8/F8yhob8uy1u5/9cvGpIVo4WGsQdTi7yBULVHsTqc/kqrZS6L+cBngG3
 5v62E1H7kbOCQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 3/4] gpu: nova-core: mm: get rid of Arc<BarUser> in
 BarUserAccess
Date: Sat, 26 Sep 2026 14:43:26 +0200
Message-ID: <20260926124405.604707-4-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926124405.604707-1-dakr@kernel.org>
References: <20260926124405.604707-1-dakr@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There is no need for a reference count here. BarUserAccess can just
borrow from BarUser.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/mm/bar_user.rs | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 6c8fa06d9f4b..855244f06983 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -7,10 +7,7 @@
     io::Io,
     new_mutex,
     prelude::*,
-    sync::{
-        Arc,
-        Mutex, //
-    },
+    sync::Mutex, //
 };
 
 use crate::{
@@ -63,11 +60,11 @@ pub(crate) fn new(
 
     /// Map physical pages to a contiguous BAR1 virtual range.
     pub(crate) fn map(
-        self: &Arc<Self>,
+        &self,
         mm: &mut GpuMm<'_>,
         pfns: &[Pfn],
         writable: bool,
-    ) -> Result<BarUserAccess<'gpu>> {
+    ) -> Result<BarUserAccess<'_>> {
         if pfns.is_empty() {
             return Err(EINVAL);
         }
@@ -75,15 +72,17 @@ pub(crate) fn map(
         let mapped = vmm.map_pages(mm, pfns, None, writable)?;
 
         Ok(BarUserAccess {
-            bar_user: self.clone(),
+            bar_user: self,
             mapped: Some(mapped),
         })
     }
 }
 
 /// Access object for a mapped BAR1 region.
-pub(crate) struct BarUserAccess<'gpu> {
-    bar_user: Arc<BarUser<'gpu>>,
+///
+/// Borrows the [`BarUser`] managing the mapping for the lifetime of the access object.
+pub(crate) struct BarUserAccess<'a> {
+    bar_user: &'a BarUser<'a>,
     /// [`BarUserAccess::release`] [`Option::take`]s this; `Some` at
     /// drop time means `release()` was never called.
     mapped: Option<MappedRange>,
@@ -390,10 +389,6 @@ pub(crate) fn run_self_test(
     drop(vmm);
 
     // Test 4: Exercise `BarUser::map()` end-to-end.
-    let bar_user = Arc::pin_init(
-        BarUser::new(pdb_addr, chipset, SZ_64K.into_safe_cast(), bar1),
-        GFP_KERNEL,
-    )?;
     let access = bar_user.map(mm, &[test_pfn], true)?;
 
     // Write pattern via PRAMIN, read via BarUserAccess.
-- 
2.55.0

