Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FF0CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2734F10E1D3;
	Thu, 15 Oct 2026 18:35:42 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9BA10E1D3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 18:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792089331; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JTKir0wWoyOUlyrGDsjuJthIrocwMLvMIOxvKlSViBNOs/4tC++uWxn7uCU48OChsto7OBGmRlUQOLPDzpPt1dgPWqGqdG4g1j+XGR1tZqVDVYBr0GgULW1qx6fYnw4pv/CBwucN+Ghl6ga8RsConYqFzdyPB0NoG/PjKmnO2Rw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792089331;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iih9xPBNnnJLDskp43dgX+2eXZajDQnQevePJrRcsA8=; 
 b=axoDtagnsjJvlf+RYYdnIDQmtLJvDwPb2NvS/0zN0tBhjArhj2Sd8Um40l3i+4018C05e3mdigr+6DlXguAki2dPq9Uhe2TnMVBR/kE82V2ljJlBw7gFzt0MdpTNzhDG87EMY3nEqeHujPH+xNvvsN6SKoTnI3yyCaTL+kqLloU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792089331; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=iih9xPBNnnJLDskp43dgX+2eXZajDQnQevePJrRcsA8=;
 b=OUiKFCMRaSsq/MF0vSncMX4RhtG0NCIrtvYmAa52Kf6A8+/bG+JClVpcvBeXbACg
 CQSmi05EkeLdmdfFmYp/aUB7HqmIBtBjZejKMY7dbHn7aZbbzAo+64/Y8AjO0rLM6qg
 pTo+Qy3Pj6yfI9p7iIf67PQlU/1de/ZYWNK1lW7M=
Received: by smtp.zohomail.com with SMTPS id 1792089330488961.5839121729349;
 Thu, 15 Oct 2026 11:35:30 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Thu, 15 Oct 2026 11:35:20 -0700
Subject: [PATCH v2 1/2] rust: uaccess: add UserSliceWriter::clear()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-b4-dev_query_fixes-v2-1-e3e6d25050cb@collabora.com>
References: <20261015-b4-dev_query_fixes-v2-0-e3e6d25050cb@collabora.com>
In-Reply-To: <20261015-b4-dev_query_fixes-v2-0-e3e6d25050cb@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2433;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=hYDch1u6JEQvhaBu2Dh0SadSLCQSA1fv8tX/aw2U3vo=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkXZd5tDJnP2Jxd+aBP9eXOl1FTXnp4NWouO5e/pHf2n
 cdS66s3dZSyMIhxMciKKbKctTfqEa96b6Q7/38zzBxWJpAhDFycAjARjceMDB1/97+N3LFZw+qR
 fpCPl/u6ENVpT1ZavDVoLV5SImqj3cfI8G+71oyOdWlPG64WMvRbzfBx+5mn+fnUrOgDhd8C7gf
 a8gIA
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

Add a method to zero the remaining bytes in a UserSliceWriter.

If userspace provides a buffer that is larger than necessary, provide
a method to zero out the remaining UserSliceWriter buffer. This avoids
userspace consuming potentially uninitialized memory and/or mistaking it
for data intentionally provided by the kernel.

Use the #[inline] annotation to make this clear() method available for
inlining outside of the kernel crate.

Since clear_user() is architecturally defined and may be a macro or inline
function, add a rust helper to make clear_user() callable from rust.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 rust/helpers/uaccess.c |  6 ++++++
 rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
index 6e59cc9c665c..e799d9ac9804 100644
--- a/rust/helpers/uaccess.c
+++ b/rust/helpers/uaccess.c
@@ -27,3 +27,9 @@ unsigned long rust_helper__copy_to_user(void __user *to, const void *from, unsig
 	return _inline_copy_to_user(to, from, n);
 }
 #endif
+
+__rust_helper unsigned long
+rust_helper_clear_user(void __user *to, unsigned long n)
+{
+	return clear_user(to, n);
+}
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index f1aecda7a90c..8e18285ec44b 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -638,6 +638,30 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
     pub fn write_truncated<T: AsBytes>(&mut self, value: &T) -> Result<usize> {
         self.write_slice_partial(value.as_bytes(), 0)
     }
+
+    /// Zeros remaining bytes in the userspace buffer.
+    ///
+    /// Fails with [`EFAULT`] if the userspace memory cannot be cleared.
+    #[inline]
+    pub fn clear(&mut self) -> Result {
+        let len = self.length;
+
+        if len == 0 {
+            return Ok(());
+        }
+        // SAFETY: `clear_user` checks the userspace address and range and handles
+        // faults when accessing userspace memory
+        let res = unsafe { bindings::clear_user(self.ptr.as_mut_ptr(), len) };
+
+        if res != 0 {
+            return Err(EFAULT);
+        }
+
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length = 0;
+
+        Ok(())
+    }
 }
 
 /// Reads a nul-terminated string into `dst` and returns the length.

-- 
2.56.0

