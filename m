Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01FCCCF2C4
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1D51129D6;
	Fri, 16 Oct 2026 20:44:41 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 164F41129D7
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 20:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792183467; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YtluJYwd2SiDJff0AYA+5N+IaNVU47LVYbLLXkKTphXBWmmSsVShlaFxr2UYBj44XMfL9KyOZV7IhF95NSYkHbr07Y+YzH2h2ZAvlXE2tsMD6BcRNZqmtNhGT3UKO3Z8TjqX8Qbru8znohlQmOwTOZKUgrsFkqi9yhh3MQwJMpY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792183467;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YFWuwQ82SXg61dDkbwdbkUuQLM9wcDmkAmkU3QVjnXc=; 
 b=Y7EhOGe6BHbx70AojhVgm4Ew8yE08zXCYJ/LSketKdVmwbhs3qDxFKWDjKR+m/h1Vt0kpuwt3uj8r28AwOTUO9zaCggudWeMBZwriV94krtV9sFMZWW3bZZevW4UrYrPzSi4b7eGvQCLHPWbBfYKiYEM3wPLK1ESMb0eJ0uxlAU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792183467; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=YFWuwQ82SXg61dDkbwdbkUuQLM9wcDmkAmkU3QVjnXc=;
 b=aVBRcQPrd09jACOsH+GFIO0LWlCp2gRDz+I9rf/Xmb6zQxizy5xyZH+QreUjo10u
 5bL5eEDeLELcZGm/5WMRl1ywAdhZv/tgOQfcOtD3OeJz5Kcwm8JwrcR8N1lPiv7Ixoe
 n7WDH8Iwu0HSugFsESk1VUzrDP3m0zrKOS95UhTo=
Received: by smtp.zohomail.com with SMTPS id 1792183466173479.0295726917317;
 Fri, 16 Oct 2026 13:44:26 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 16 Oct 2026 13:44:21 -0700
Subject: [PATCH v3 2/2] drm/tyr: allow userspace buffers to be mismatched
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-dev_query_fixes-v3-2-f8071cda3515@collabora.com>
References: <20261016-b4-dev_query_fixes-v3-0-f8071cda3515@collabora.com>
In-Reply-To: <20261016-b4-dev_query_fixes-v3-0-f8071cda3515@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3005;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=hcV4Wqg23xWFRLxU/xygMPJocBDXJ5DHDaaHMkCXKfU=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFmXepZdKHn3aw5Lz8cCG8/Z8t/8pfuXtRYHbnDYzP3v8
 yX+GA7LjlIWBjEuBlkxRZaz9kY94lXvjXTn/2+GmcPKBDKEgYtTACbypoOR4W+d10uxJYV/7MVt
 ReocWoR9Xi+MnLF+Fdcx67jrquIn3zIydNoucPjsWjDxtoxvx65vK7grnWzOLSqZo11YFPJ7jVI
 PCwA=
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
 drivers/gpu/drm/tyr/file.rs | 47 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 9f60a90d4948..a153aa453ed1 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -1,11 +1,18 @@
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
+    num::casts::u32_as_usize,
     prelude::*,
+    transmute::AsBytes,
     uaccess::UserSlice,
     uapi, //
 };
@@ -16,6 +23,32 @@
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
+    let size = u32_as_usize(size);
+    if size < min_size {
+        return Err(EINVAL);
+    }
+
+    let mut writer = UserSlice::new(UserPtr::from_addr(usr_dst as usize), size).writer();
+    writer.write_truncated(src_obj)?;
+    writer.clear()?;
+    Ok(())
+}
+
 #[pin_data]
 pub(crate) struct TyrDrmFileData {}
 
@@ -48,14 +81,12 @@ pub(crate) fn dev_query(
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

