Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D2606A329
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=E/DKcIhK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0926410FFF8;
	Wed, 25 Nov 2026 22:48:17 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED84210E525
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795646857; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SRj58EkMKTHr7v1Dbg+ylCtFleNp0Ha87AXPY6Lc4d1VjxeKghJGiVFnY0Ztjul6qmq+s9NRVnVtw/ZMgli46M1ok9yfVUN/QtsXOO6OAIeOJK3wgkboeqYZXLsSDAdQFdC5PFsBmS8inmwHrsVLehqg+z2zfJ5HyBJAX92T+fc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795646857;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HZGAJYpwTB/v4VHmxVqDeHNbyDXVR7TGeBAEavECqGs=; 
 b=IlMyhm9+ppN/vzQoTuCA0hnDT4yFx+8on5M8z2e2EAFdojsdHzEYTnUbZE+K81spWEWMP6YrK0un4QTIF2Xy91ODJVjlcJ3oqSzrD+5aQYFdYYwEalpK2MHSQp4g1q50ZEj/kNpvK3UgJZq+9Y8CbDeHm3+ECEPjOQ374XH/jvU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=E/DKcIhKXipsWboPnR+r9s/A5bgKJiAqruMJuTKhOr/jRsFYWktQFe6cPUJIKG2S9a1jOBMBWxffsIZ9te5J22bCvQO2QYuIfcY+s7H/GOxBmk5KaprwMRt3x5Tyw/7DeleHJGa2GyTfR50ammjKzMy4aOqG8B7Gt5o2KT/bE5s=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=HZGAJYpwTB/v4VHmxVqDeHNbyDXVR7TGeBAEavECqGs=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795646856604270.62478483278574; 
 Wed, 25 Nov 2026 14:47:36 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 25 Nov 2026 19:46:57 -0300
Subject: [PATCH 06/13] drm/tyr: replace lossless `as` casts with From and
 FromSafeCast
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-b4-tyr-as-casts-v1-6-2b2f53164d86@collabora.com>
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An `as` cast silently drops the bits that do not fit the target type,
and nothing at the cast shows whether that can happen. As part of a
larger effort to reduce the number of `as` casts in Tyr, replace the
casts from `usize` to `u64`, from `u32` to `usize` and from a
`Bounded<u64, 8>` to `u8` with conversions that cannot lose bits:

    mapped as u64            ->  u64::from_safe_cast(mapped)
    fw_header.size as usize  ->  usize::from_safe_cast(fw_header.size)
    val.get() as u8          ->  u8::from(val)

`FromSafeCast` is only implemented where no value is lost on any
architecture, and `From` for a `Bounded` only where all its bits fit.

No functional change intended.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/fw.rs        |  9 ++++++---
 drivers/gpu/drm/tyr/fw/parser.rs | 11 +++++++----
 drivers/gpu/drm/tyr/regs.rs      |  2 +-
 drivers/gpu/drm/tyr/vm.rs        |  9 +++++----
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index aea151ff1f93..14cfe2884d5a 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -26,7 +26,10 @@
         poll,
         Io, //
     },
-    num::Bounded,
+    num::{
+        casts::FromSafeCast,
+        Bounded, //
+    },
     prelude::*,
     str::CString,
     sync::{
@@ -238,8 +241,8 @@ pub(crate) fn new(
                     parsed.vm_map_flags,
                 )?;
 
-                let section_start = parsed.data_range.start as usize;
-                let section_end = parsed.data_range.end as usize;
+                let section_start = usize::from_safe_cast(parsed.data_range.start);
+                let section_end = usize::from_safe_cast(parsed.data_range.end);
                 let mut data = KVec::new();
 
                 // Ensure that the firmware slice is not out of bounds.
diff --git a/drivers/gpu/drm/tyr/fw/parser.rs b/drivers/gpu/drm/tyr/fw/parser.rs
index 6ff681aa78d1..6576bc870982 100644
--- a/drivers/gpu/drm/tyr/fw/parser.rs
+++ b/drivers/gpu/drm/tyr/fw/parser.rs
@@ -18,7 +18,10 @@
 use kernel::{
     bitfield,
     device::Device,
-    num::Bounded,
+    num::{
+        casts::FromSafeCast,
+        Bounded, //
+    },
     prelude::*,
     sizes::SizeConstants, //
 };
@@ -182,7 +185,7 @@ pub(super) fn new(dev: &'a Device, data: &'a [u8]) -> Self {
     /// in the binary, extracting section information needed for loading.
     pub(super) fn parse(&mut self) -> Result<KVec<ParsedSection>> {
         let fw_header = self.parse_fw_header()?;
-        let header_end = fw_header.size as usize;
+        let header_end = usize::from_safe_cast(fw_header.size);
 
         let mut parsed_sections = KVec::new();
         while self.cursor.pos() < header_end {
@@ -210,7 +213,7 @@ fn parse_fw_header(&mut self) -> Result<FirmwareHeader> {
             }
         };
 
-        if fw_header.size as usize > self.cursor.len() {
+        if usize::from_safe_cast(fw_header.size) > self.cursor.len() {
             dev_err!(self.cursor.dev, "Firmware image is truncated");
             return Err(EINVAL);
         }
@@ -323,7 +326,7 @@ fn parse_section_entry(
             return Err(EINVAL);
         }
 
-        if section_hdr.data.end as usize > firmware_size {
+        if usize::from_safe_cast(section_hdr.data.end) > firmware_size {
             dev_err!(
                 entry_cursor.dev,
                 "Firmware data range {:#x}..{:#x} exceeds firmware size {:#x}",
diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 69c901afb28f..603a9052c439 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -1154,7 +1154,7 @@ impl TryFrom<Bounded<u64, 8>> for MMU_MEMATTR_STAGE1 {
             type Error = Error;
 
             fn try_from(val: Bounded<u64, 8>) -> Result<Self, Self::Error> {
-                Ok(Self::from_raw(val.get() as u8))
+                Ok(Self::from_raw(u8::from(val)))
             }
         }
 
diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 72c8593c489e..d15db120352b 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -41,6 +41,7 @@
         ARM64LPAES1, //
     },
     new_mutex,
+    num::casts::FromSafeCast,
     prelude::*,
     sizes::SizeConstants,
     sync::{
@@ -616,7 +617,7 @@ fn sm_step_map<'op>(
         // end of the GEM buffer itself.
         let gem_range_end = op.gem_offset().checked_add(op.length()).ok_or(EINVAL)?;
 
-        if gem_range_end > op.obj().size() as u64 {
+        if gem_range_end > u64::from_safe_cast(op.obj().size()) {
             dev_err!(
                 context.dev,
                 "Requested GEM range ends at {} which is beyond the GEM buffer size {}",
@@ -891,7 +892,7 @@ fn pt_map(
             return Err(ENOMEM);
         }
 
-        segment_mapped += mapped as u64;
+        segment_mapped += u64::from_safe_cast(mapped);
     }
 
     Ok(segment_mapped)
@@ -937,8 +938,8 @@ fn pt_unmap(dev: &Device, pt: &IoPageTable<'_, ARM64LPAES1>, range: Range<u64>)
             return Err(EINVAL);
         }
 
-        bytes_left_to_unmap -= unmapped as u64;
-        iova += unmapped as u64;
+        bytes_left_to_unmap -= u64::from_safe_cast(unmapped);
+        iova += u64::from_safe_cast(unmapped);
     }
 
     Ok(())

-- 
2.56.0

