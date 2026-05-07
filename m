Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2CBCD37AD
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 23:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A22D610F2C6;
	Thu,  7 May 2026 23:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="TXkUciE/";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FCD10F2B7
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 23:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778196769; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QBQGgnzSiXMZRek/wVE5S4DwcwZhlyUc607ZZuhr9U9a0Mr7rIYQeXY1TcBf+x+tIby3dX7O2LdnTZJmJpMIx9hvhGob9cIcNOlVESEy0ZoK74JTzsnpkUejKjeGl7XrA+uhrvVtxZLa4hopwDTVmJRtNHslI5cpAjm8w0Bc09g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778196769;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=oCMt4Wqtp340hUTxlyZxiVOiVlULGTbK7i1z5h8C21U=; 
 b=Wbreo7nBgKEmHWiQADc9Wu+HdVBBGtfl6kBsl4W3fAYzWvNRdZZ8sfFH+qCk1S9wo696r9i6T5850UWf/J7gSf3x9yS58rcPq+4CwAmnJ6uns5XPfRY3D8t+K8ofdqWB3cCPNw/DLohouaOZGfnAkmAMSYnAKd1sPY2Q6Mo7vKc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778196769; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=oCMt4Wqtp340hUTxlyZxiVOiVlULGTbK7i1z5h8C21U=;
 b=TXkUciE/cJKYDXsmS5Oe9NPWvT9tdlEtg/c64LaikWuN8aDow1v4IXdLT9fQdiEG
 PZZ9qUbhMa6xj+/qu4r+/levKLwnmHM/r6VNmXcqPfNviynQWu8YS83xs0QLVs2Gkep
 4bn1fri7SbgufExEbMGbbsCZW5DmeyxxFhmIA2Es=
Received: by mx.zohomail.com with SMTPS id 1778196767897434.22785911951655;
 Thu, 7 May 2026 16:32:47 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Thu, 07 May 2026 16:32:42 -0700
Subject: [PATCH 4/7] drm/rust: allow drivers to override file operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-tyr-mmap-v1-4-eec048a23c25@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2654;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=snKSqFTk/LCWniRtE2VzwTiY0L106zF+84qJmJfsNZI=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl/FSUjbJZszlCUvRzy/8xh163PDNgnH5E02fXkyvXlv
 BKVqdN2dJSyMIhxMciKKbKctTfqEa96b6Q7/38zzBxWJpAhDFycAjCRCxsZGY5xTLm8847Lppvf
 eBsSLq9JuakwcQXDHp7HK0qL63Qu+p5g+B/tbXzSdzv/vxUSyu7uL7WWarULa5kyzM8vceRaOtv
 iFSsA
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

Add a Driver::FOPS associated constant so Rust DRM drivers can override
or extend the default file operations table.

Use the driver's FOPS in drm::Device instead of always constructing the
default GEM file operations internally.

Also make drm::gem::create_fops() public so drivers can build on top of
the default GEM handlers while overriding selected operations such as
mmap.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 rust/kernel/drm/device.rs  | 4 ++--
 rust/kernel/drm/driver.rs  | 6 ++++++
 rust/kernel/drm/gem/mod.rs | 3 ++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index adbafe8db54d..82760a9a426e 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -108,10 +108,10 @@ impl<T: drm::Driver> Device<T> {
         driver_features: drm::driver::FEAT_GEM,
         ioctls: T::IOCTLS.as_ptr(),
         num_ioctls: T::IOCTLS.len() as i32,
-        fops: &Self::GEM_FOPS,
+        fops: &Self::FOPS,
     };
 
-    const GEM_FOPS: bindings::file_operations = drm::gem::create_fops();
+    const FOPS: bindings::file_operations = T::FOPS;
 
     /// Create a new `drm::Device` for a `drm::Driver`.
     pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<ARef<Self>> {
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 5233bdebc9fc..79218c482fce 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -115,6 +115,12 @@ pub trait Driver {
 
     /// IOCTL list. See `kernel::drm::ioctl::declare_drm_ioctls!{}`.
     const IOCTLS: &'static [drm::ioctl::DrmIoctlDescriptor];
+
+    /// File operations for this driver.
+    ///
+    /// Override to replace or extend the default GEM file operations. The default
+    /// provides the standard GEM mmap handler via [`drm::gem::create_fops`].
+    const FOPS: bindings::file_operations = drm::gem::create_fops();
 }
 
 /// The registration type of a `drm::Device`.
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 75acda7ba500..de7222ee0542 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -348,7 +348,8 @@ impl<T: DriverObject> AllocImpl for Object<T> {
     };
 }
 
-pub(super) const fn create_fops() -> bindings::file_operations {
+/// Returns the default GEM [`bindings::file_operations`] for a DRM driver.
+pub const fn create_fops() -> bindings::file_operations {
     let mut fops: bindings::file_operations = pin_init::zeroed();
 
     fops.owner = core::ptr::null_mut();

-- 
2.53.0

