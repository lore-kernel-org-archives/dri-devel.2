Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108A606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 00:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=DBJaNnN0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F4610E2A5;
	Wed, 21 Oct 2026 00:07:12 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF4110E2A5
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 00:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792541212; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PhBeSy07WAmNjWA4OynPKIL0BawTBtdmvPV3KWlfcOKUzuYA7NJDfz4B5NiHvQTasN8LyHrdsIYsEKdDdFoHFk/Na3DT9Y+OxGSfZ/Ga+DfLJkpUHZ6U9ChmutNMye8Ma79RydzrC7txtpSjwpkPLErtcBRCLKa1V2iACGZC53Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792541212;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1zUR5GEK6BA5S7bCITK+tOcim+IiL0R8T8uB3uRypFw=; 
 b=ekfzL4yyN6JVoAJX5jHHmeryjsljDmmFa59sgLsJvzoBtggl+Rat/n5Vpuj4TALUv2HJQe95R6CChLdCnpiRdeii2DHfruOeyjntD047NssLNnGxACrA1nz7nw96N6BoEQi+c+hOoC368NAgFNJGtqsuQddnV+y6uNK8ptVgr08=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792541212; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=1zUR5GEK6BA5S7bCITK+tOcim+IiL0R8T8uB3uRypFw=;
 b=DBJaNnN0xwPmmWzktPGNzvjxbQglRv47/8iJ7FWqpBQOw4gHUmy7gIbQJhUU03lk
 RonFSD4Z1vcxW+YuMkqs2rphAy6U49uknah/CSOTlxyLW/EcTW2B29LRF+y9T/QRaTD
 jT9QnfSkQJIqo+ysgWF67Po7XGdSa7ilClojNbAE=
Received: by smtp.zohomail.com with SMTPS id 179254121012077.48844824785681;
 Tue, 20 Oct 2026 17:06:50 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 20 Oct 2026 17:06:47 -0700
Subject: [PATCH v4 3/3] drm/tyr: allow userspace buffers to be mismatched
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-b4-dev_query_fixes-v4-3-df66b4c98bc6@collabora.com>
References: <20261020-b4-dev_query_fixes-v4-0-df66b4c98bc6@collabora.com>
In-Reply-To: <20261020-b4-dev_query_fixes-v4-0-df66b4c98bc6@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=cw/gH4gJ7P+GmpjRc8el+UvRXUZRj4b9UKEbdATligI=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFk3mERnajzZ/E6LRUzhsr5DqkaYW2vLl7d7Vn3/3aBVr
 7BbRTSoo5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgImkBzMyfHR5s5GXZes+8dNe
 O948t0+dFbpNuejaheo73FVFlmVPtjAyHN3KwRSxYbPw8dUPxX7zFzBLdOZqBqceXNzKf+InV6E
 JGwA=
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 drivers/gpu/drm/tyr/file.rs | 49 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index ceadde976502..bf66238ea4c6 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -1,14 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
+use core::mem::offset_of;
+
 use kernel::{
     drm::{
         self,
         Registered, //
     },
+    num::casts::FromSafeCast,
     prelude::*,
     uaccess::UserSlice,
     uapi, //
 };
+use zerocopy::Immutable;
 
 use crate::driver::{
     TyrDrmDevice,
@@ -16,6 +20,37 @@
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
+fn set_uobj<T: IntoBytes + Immutable>(
+    usr_dst: u64,
+    size: u32,
+    min_size: usize,
+    src_obj: &T,
+) -> Result {
+    let size = usize::from_safe_cast(size);
+    if size < min_size {
+        return Err(EINVAL);
+    }
+
+    let mut writer = UserSlice::new(UserPtr::from_u64(usr_dst), size).writer();
+    writer.write_slice_partial(src_obj.as_bytes(), 0)?;
+    writer.clear()?;
+    Ok(())
+}
+
 #[pin_data]
 pub(crate) struct TyrDrmFileData {}
 
@@ -48,14 +83,12 @@ pub(crate) fn dev_query(
         } else {
             match devquery.type_ {
                 uapi::drm_panthor_dev_query_type_DRM_PANTHOR_DEV_QUERY_GPU_INFO => {
-                    let mut writer = UserSlice::new(
-                        UserPtr::from_addr(devquery.pointer as usize),
-                        devquery.size as usize,
-                    )
-                    .writer();
-
-                    writer.write_slice(reg_data.gpu_info.as_bytes())?;
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

