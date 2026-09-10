Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3930DC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 16:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE60410E136;
	Thu, 10 Sep 2026 16:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VHUW1P2c";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B7610E136
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 16:57:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF58E4106A;
 Thu, 10 Sep 2026 16:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBBB1F00893;
 Thu, 10 Sep 2026 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789059472;
 bh=SydUxsZS+bSoa1t5GI+dsmdirvhjFORum6ucYa25lyg=;
 h=From:To:Cc:Subject:Date:Reply-To;
 b=VHUW1P2c2JS31SzScIqlQTMoZcvj78zQzZ+fMkeOwFmS6Ck8RigvIwJ6h5RNtSQJt
 DARIKloqKUQolKi9AqwFi1slMGTE540lmnBD7wybxsbY5lgcLW+FhtOey9BRYC8bGJ
 avVlsmiiLq+cpuuFKaZoImtKnnWB55//K2E1yzM+XoUw2ieTCwln/ZczxBtczXDs6z
 LldQkLqZQBov/OUiEe5+VTzJ9uHvzXJdvjGG7H8B/N6qcsC9ycF526bQLVr0/MchMQ
 shiIOx8vUrNnMUvcnT40eJRg5PDu7NtkZV6rNItvOZK+nb/BQvk3ThO/yEIBD8ds3z
 Ey6b6DfJ4189w==
From: Gary Guo <gary@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Gary Guo <gary@garyguo.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tyr: use `bitfield!` instead of `register!` for
 non-registers
Date: Thu, 10 Sep 2026 17:57:33 +0100
Message-ID: <20260910165734.80378-1-gary@kernel.org>
X-Mailer: git-send-email 2.54.0
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
Reply-To: Gary Guo <gary@garyguo.net>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Gary Guo <gary@garyguo.net>

`SectionFlags` and `MMU_MEMATTR_STAGE1` are not registers themselves. Use
`bitfield!` directly.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/drm/tyr/fw.rs   | 12 ++++--------
 drivers/gpu/drm/tyr/regs.rs | 11 +++++------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 7edb5eff1707..aea151ff1f93 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -14,6 +14,7 @@
 //! [`Section`]: crate::fw::Section
 
 use kernel::{
+    bitfield,
     device::{
         Bound,
         Device, //
@@ -27,7 +28,6 @@
     },
     num::Bounded,
     prelude::*,
-    register,
     str::CString,
     sync::{
         Arc,
@@ -39,8 +39,7 @@
 use crate::{
     driver::{
         IoMem,
-        TyrDrmDevice,
-        TyrRegisters, //
+        TyrDrmDevice, //
     },
     fw::parser::{
         FwParser,
@@ -101,11 +100,8 @@ fn from(value: CacheMode) -> Self {
     }
 }
 
-register! {
-    base: TyrRegisters;
-
-     #[allow(non_upper_case_globals)]
-    pub(super) SectionFlags(u32) @ 0x0 {
+bitfield! {
+    pub(super) struct SectionFlags(u32) {
         0:0 read => bool;
         1:1 write => bool;
         2:2 exec => bool;
diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 0c419c4e1186..6f626957a010 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -986,6 +986,7 @@ pub(crate) mod mmu_control {
     /// This array contains 16 instances of the MMU_AS_CONTROL register page.
     pub(crate) mod mmu_as_control {
         use kernel::{
+            bitfield,
             num::Bounded,
             prelude::*,
             register, //
@@ -1130,14 +1131,12 @@ fn from(val: MemoryType) -> Self {
             }
         }
 
-        register! {
-            base: TyrRegisters;
-
+        bitfield! {
             /// Stage 1 memory attributes (8-bit bitfield).
             ///
-            /// This is not an actual register, but a bitfield definition used by the MEMATTR
-            /// register. Each of the 8 bytes in MEMATTR follows this layout.
-            MMU_MEMATTR_STAGE1(u8) @ 0x0 {
+            /// Each of the 8 bytes in MEMATTR follows this layout.
+            #[allow(non_camel_case_types)]
+            struct MMU_MEMATTR_STAGE1(u8) {
                 /// Inner cache write allocation policy.
                 0:0     alloc_w => bool;
                 /// Inner cache read allocation policy.

base-commit: 73e5616f3d197c1af5a04a481fe0f13aa3913bd1
-- 
2.54.0

