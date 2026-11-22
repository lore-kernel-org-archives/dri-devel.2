Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50CE606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=lbBfVE70
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DE810E7B6;
	Sun, 22 Nov 2026 13:03:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309D710E611
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 13:02:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E412744FE2;
 Sun, 22 Nov 2026 13:02:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795352576;
 b=aP1nTBRjJJK423+ExS3LuYFyTzgKoKMjMHm670LucGEapp60zmeAznrAwaaTbjnajCUG
 nosR+rZyZHhoTLXgUI5GQLb68MxaVl7mCnP7109IaUbjscmJZaaVkJcxM9lpbAFukwIo0
 IWJoBi4x+mG/IID/QSVLz2a/xQ10H68xm3O/w7htwcNgxhoEVxiyZ60MF6Tb2edrp95Ob
 hYdaA4vFYCwdZmdcGv+JYOmxZPev77RNHqHTQ7YJn3BvO6aOAMtt2Ep7AXVmIVJ0xNCIA
 qNjtJkvCSRT8UVpPJXjNpyFHTMVfFvitSko7tyAXYRl7vz275NksoLMKCCfe9GgwfmQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795352576;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
 bh=NoOWHdaGEluUbDRkukjEjbKRKM8TUtrgLl1NRqyAbrI=;
 b=OUBqjFvDFWpPz40f1MP4HK7UrUMvEgR9BQW1IXSBAwu2iQWKZrAQlHwowqsGLfVrTbLt
 LKK/+WP9OqfZMfQMnjGEQrz188Y+rvPmlbwucnQnO1xoMUdDcbvPd6YN6bbon6bKGKDq7
 Uh9NFmQF53IeofAn8Bf34dG3Q2acubEyvSJpm6IQIxU2cjk//bt7xKsqnezOnmGbWa+pS
 JTe39Md3nmOySq2czhaA7XOxI52J2iv5unrV081s8IT/0TtDeOl+usM/qPqRG7lli0mgC
 saOYJZyuXRCF5pcXMN9ot2DdIybH8qKJ8wYqh879gh1gEodZjy25GgHx1AHKvWevf6w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 504221F000D4;
 Sun, 22 Nov 2026 13:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
 t=1795352576; bh=NoOWHdaGEluUbDRkukjEjbKRKM8TUtrgLl1NRqyAbrI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lbBfVE70JIm6yKPDfyZUsBT4VcPeDzuE0nGtDV0P/y5RqWX9PWEx3uNhUtkVcZ4lh
 kdHdye2K76KAzk6lBeZBjkMFF8cRrg7U4KfkHNKG15brTPpoiVfc7yg/+f7TKgtDxv
 7cP/uQ7Q2yKM+y1Ee/WpGkSGtI6ysS7hAW7h96J8=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4F3634C063;
 Sun, 22 Nov 2026 13:02:34 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Sun, 22 Nov 2026 20:50:25 +0800
Subject: [PATCH v7 06/10] drm/tyr: add BO creation and lookup helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-tyr-ioctls-v7-6-3a2af624b992@linux.dev>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
In-Reply-To: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
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
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795352551; l=2048;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=NWIPbx+eohkv3FNLcTsYqaXCTEHpzUO212X/sd33Vuo=;
 b=rVsp8LsarTYLUQnbwabWjT1vlXXdryHF7kLwQPKuCkX6AJ8l/rBx1+aAEqzCDTY3pN8g6Y43+
 P6WCKtCcBElBkSuUu7aneKezy6GS+ax/Q+KjJRHqX2N5KjTlFvCmVUb
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
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

Add helpers for the BO ioctls: new_object() creates a GEM object with
the size aligned up to PAGE_SIZE, and lookup_handle() resolves a handle
for a DRM file.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/gem.rs | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 3bf3787f5c3fd..0e0989a48678f 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -9,8 +9,10 @@
 use kernel::{
     drm::gem::{
         self,
-        shmem, //
+        shmem,
+        BaseObject, //
     },
+    page::PAGE_SIZE,
     prelude::*,
     sync::{
         aref::ARef,
@@ -23,6 +25,7 @@
         TyrDrmDevice,
         TyrDrmDriver, //
     },
+    file::TyrDrmFile,
     vm::{
         Vm,
         VmMapFlags, //
@@ -53,6 +56,32 @@ fn new(_dev: &TyrDrmDevice, _size: usize, args: BoCreateArgs) -> impl PinInit<Se
 /// Type alias for Tyr GEM buffer objects.
 pub(crate) type Bo = gem::shmem::Object<BoData>;
 
+/// Create a new GEM buffer object.
+#[expect(dead_code)]
+pub(crate) fn new_object(ddev: &TyrDrmDevice, size: usize, flags: u32) -> Result<ARef<Bo>> {
+    if size == 0 {
+        return Err(EINVAL);
+    }
+
+    let aligned_size = size.checked_next_multiple_of(PAGE_SIZE).ok_or(EINVAL)?;
+
+    Bo::new(
+        ddev,
+        aligned_size,
+        shmem::ObjectConfig {
+            map_wc: true,
+            parent_resv_obj: None,
+        },
+        BoCreateArgs { flags },
+    )
+}
+
+/// Look up a GEM object by handle for a DRM file.
+#[expect(dead_code)]
+pub(crate) fn lookup_handle(file: &TyrDrmFile, handle: u32) -> Result<ARef<Bo>> {
+    Bo::lookup_handle(file, handle)
+}
+
 /// Creates a dummy GEM object to serve as the root of a GPUVM.
 pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) -> Result<ARef<Bo>> {
     let bo = Bo::new(

-- 
2.43.0


