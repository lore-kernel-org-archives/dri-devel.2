Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDCBCD37A7
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 23:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F51210F2C2;
	Thu,  7 May 2026 23:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="bLnOMmQF";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC5B10E5B1
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 23:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778196769; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=B0gKagO8Brbvh2dtH5CQYZF2oKOX1R9r00JZZXK0C/iTD1gP7WcdolnilHRz+nxsadSp3JLoGQ2mJUqSLAjTB3vgmwVNPU8Ld/3d5nBpZ/eEFCAWvZyTe64YmfahP4hF+5xh2T9wLE389CqEouzCmhabS/BLxzCsWyg2ByRc2iU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778196769;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vTqw3jc94opHT2uoxPiQwEHdp0J+oq/GgnCRmE7vr4k=; 
 b=Nw9RcZPiylbkyhrkkXx1dRyClrdga9qu4TyCwlawcXmmCnQRnVSK7f8bEM41UYcaVCcC7pz55Z68aHKix9vF0Z68bksprpkN2X/6f8JXXVTdusgU07FqwrphEhQvyNMTIP3NyiXev8Crl/XKkdkrCMlJaY49D4//sQSHLuoE3ng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778196769; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=vTqw3jc94opHT2uoxPiQwEHdp0J+oq/GgnCRmE7vr4k=;
 b=bLnOMmQF4ag3NVS7UO6/9eDpodF6H9woyCqEw7csrAXF8k9EjvauGMOcl61iA+5f
 xa79o6hQJ8k0sgn4VJl8ZQVugR1i1Wc8LjfnxQktMwz4bz9jQBb/70xOQJBbXAMLq46
 QFuTH9PRyGEdrFOJAt2+gpZMLN3209lJxN0iy27w=
Received: by mx.zohomail.com with SMTPS id 1778196766791583.476563743686;
 Thu, 7 May 2026 16:32:46 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Thu, 07 May 2026 16:32:41 -0700
Subject: [PATCH 3/7] drm/rust: add File::device() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-tyr-mmap-v1-3-eec048a23c25@collabora.com>
References: <20260507-tyr-mmap-v1-0-eec048a23c25@collabora.com>
In-Reply-To: <20260507-tyr-mmap-v1-0-eec048a23c25@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 boris.brezillon@collabora.com, beata.michalska@arm.com, lyude@redhat.com, 
 acourbot@nvidia.com, work@onurozkan.dev, alvin.sun@linux.dev, 
 Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=LS72whzBPfI8wJ5XGKSFg2YZwraPxlufzrfYFanpH6w=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl/FSXnnEoSj0v+Wfl/wVnruTPaf/gLX4m8/LJBe/f/a
 cYFOw6v6ShlYRDjYpAVU2Q5a2/UI1713kh3/v9mmDmsTCBDGLg4BWAitzwZGY6YKvGG9RQcXhii
 W3zB4vOz1xrsy18UJRiffv4+eadU+VlGhns2Zmv/hSrNiXAzEE1sdOJMLAlzOVi3hV1Gc975G0Y
 /+AE=
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

Add a helper to retrieve the DRM device associated with an open
`drm::file::File<T>`.

This wraps the common pattern of traversing `drm_file.minor->dev` and
returning the corresponding `drm::Device<T::Driver>`.

This is useful for DRM file operation callbacks that need access to the
owning DRM device from a `File<T>` reference, avoiding repeated open-coded
raw pointer traversal in drivers.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 rust/kernel/drm/file.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/drm/file.rs b/rust/kernel/drm/file.rs
index 10160601ce5a..5af28a9558e9 100644
--- a/rust/kernel/drm/file.rs
+++ b/rust/kernel/drm/file.rs
@@ -45,6 +45,18 @@ pub(super) fn as_raw(&self) -> *mut bindings::drm_file {
         self.0.get()
     }
 
+    /// Returns the DRM device associated with this open file.
+    pub fn device(&self) -> &drm::Device<T::Driver> {
+        // SAFETY: By the type invariant, `self.as_raw()` points to a valid open
+        // `struct drm_file`. DRM initializes `minor` for open DRM files, and
+        // `minor->dev` points to the registered DRM device associated with this
+        // file.
+        unsafe {
+            let minor = (*self.as_raw()).minor;
+            drm::Device::from_raw((*minor).dev)
+        }
+    }
+
     fn driver_priv(&self) -> *mut T {
         // SAFETY: By the type invariants of `Self`, `self.as_raw()` is always valid.
         unsafe { (*self.as_raw()).driver_priv }.cast()

-- 
2.53.0

