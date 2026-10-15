Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0038CC6B30
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 01:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5B211202D;
	Thu, 15 Oct 2026 01:02:46 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CA011202D
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792026147; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Febg1nRec7LCHMHWDS623EASGjw+wkr+jRFl2yoFlSNdU2tZ6zpBych9nEb1lNc9dDdyICON1PgGpqR7FgvZnR6MqnnVWNxyXwvRX0C5RvBvgvut9+nbDEGxT1GchwFfAhgVPafl0SePs6T0Siwl3IPXgyIEPu+boj4LdldK4qI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792026147;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aOl9HYAMP+xIUtEbrHhZ5BIVz5fa8NNn1UoE6CftTww=; 
 b=JZ1QhGU78chIzrQjBXVGOYcgzqgGelybSiyYQCm+uCkrH6UGfG6rqZf1Df9S2cmFkPmmP1+ugJJoZ3G9rR7HhPW3qWcb3Vuf4+4Cnyi46wWOx/WKYyslUFvBMi3g4dAT8ByVZt0aOiEMmmyx4Kp/l5arabShBvEOwuzICv3cg0s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792026147; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=aOl9HYAMP+xIUtEbrHhZ5BIVz5fa8NNn1UoE6CftTww=;
 b=ewhV2FQyFAkkVvtKBgrNW22/ACYFWhfYI0B6qtez01ovx7eQKgBTZZWoM842B2Yf
 YwjMrn63ug/LQJ5x/Hel2DaaT9LEx5VEDxBXWOUjrx0oY1KS8kAcrkz70ez3vcN8VhT
 d91UW8DNwzUbMYsd8M71naGKVGMqAGV4PrE1ge8k=
Received: by smtp.zohomail.com with SMTPS id 1792026145037698.080929055006;
 Wed, 14 Oct 2026 18:02:25 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Wed, 14 Oct 2026 18:02:04 -0700
Subject: [PATCH 2/2] drm/tyr: allow userspace buffers to be mismatched
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-dev_query_fixes-v1-2-92043100b472@collabora.com>
References: <20261014-b4-dev_query_fixes-v1-0-92043100b472@collabora.com>
In-Reply-To: <20261014-b4-dev_query_fixes-v1-0-92043100b472@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2956;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=DZJfnAvV8EkhjjnaSIlrPYjTDs0ij0UF+Ko5HqgCFVw=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkX1GRyNjv2T9ebk/hU36z3YUv5JqNfSSe4rsbeeVpYG
 sJz89fDjlIWBjEuBlkxRZaz9kY94lXvjXTn/2+GmcPKBDKEgYtTACbCoM3wV56/Y6u5UlD1nsyX
 B6eFGUavdzWa2nJa8sftzTzaFs9PPGVkuDXRfpthDFfhtsPy3F8cmVzLt0vNzfDZ/8/Ru+hAa9x
 nRgA=
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

Allow userspace to provide a buffer that is smaller or larger than the
object that the kernel expects to write into it.

Set a minimum buffer size to match those in PANTHOR_UOBJ_MIN_SIZE. If
userspace provides at least the minimum buffer size, then simply write
until the buffer is full.

If userspace provides a larger buffer than necessary, then zero out the
remaining buffer.

This ensures UAPI compatibility with Panthor.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/file.rs | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 9f60a90d4948..a5f96abe4d2e 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -1,11 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
+use core::mem::{
+    offset_of,
+    size_of_val, //
+};
+
 use kernel::{
     drm::{
         self,
         Registered, //
     },
     prelude::*,
+    transmute::AsBytes,
     uaccess::UserSlice,
     uapi, //
 };
@@ -16,6 +22,31 @@
     TyrDrmRegistrationData, //
 };
 
+trait UobjMinSize {
+    fn min_size(&self) -> usize;
+}
+
+impl UobjMinSize for uapi::drm_panthor_gpu_info {
+    fn min_size(&self) -> usize {
+        offset_of!(Self, tiler_present) + size_of_val(&self.tiler_present)
+    }
+}
+
+// If the user buffer is at least the minimum required size, then
+// copy as much of the kernel object as will fit into the user buffer.
+// Don't fail if the user buffer is smaller than the kernel object.
+// If the user buffer is bigger than needed, zero out the remainder.
+fn set_uobj<T: AsBytes>(usr_dst: u64, size: u32, min_size: usize, src_obj: &T) -> Result {
+    if (size as usize) < min_size {
+        return Err(EINVAL);
+    }
+
+    let mut writer = UserSlice::new(UserPtr::from_addr(usr_dst as usize), size as usize).writer();
+    writer.write_truncated(src_obj)?;
+    writer.clear()?;
+    Ok(())
+}
+
 #[pin_data]
 pub(crate) struct TyrDrmFileData {}
 
@@ -48,14 +79,12 @@ pub(crate) fn dev_query(
         } else {
             match devquery.type_ {
                 uapi::drm_panthor_dev_query_type_DRM_PANTHOR_DEV_QUERY_GPU_INFO => {
-                    let mut writer = UserSlice::new(
-                        UserPtr::from_addr(devquery.pointer as usize),
-                        devquery.size as usize,
-                    )
-                    .writer();
-
-                    writer.write(&reg_data.gpu_info)?;
-
+                    set_uobj(
+                        devquery.pointer,
+                        devquery.size,
+                        reg_data.gpu_info.min_size(),
+                        &reg_data.gpu_info,
+                    )?;
                     Ok(0)
                 }
                 _ => Err(EINVAL),

-- 
2.56.0

