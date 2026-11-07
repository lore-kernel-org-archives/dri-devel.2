Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDD0606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtsN0cY7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E1F910EB0C;
	Sat,  7 Nov 2026 02:20:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF8F10E520
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 02:20:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43241402C0;
 Sat,  7 Nov 2026 02:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FA21F008A3;
 Sat,  7 Nov 2026 02:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794018051;
 bh=FKeMRXeqHw6CdH7k75CLvsUizGdPnnCl4iNshA3tHH0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RtsN0cY7bHAvaczRNPCZfJAkt8MZHF09YwkjVzOen9aeI8o/n3ybHVaO49VqXiASH
 SkNVb3b1BKWIEOvh690Xzh5uBfHzSg/BzExaNJydaxBbxKvP9Wx4k0TJ/hJjpsJ66E
 IBTfWaU86lqY6bm/KuoYtF/yz6orCcx6QYo+E6mvavBp01h2vghiaRi8Urs8bTCr8m
 LsHk/mvVA+6FW4xUl71onyf5WPMNtdiL9zDjXzwUGyQncPoLUjHzEVr3YiqeF/h3L7
 OowfSGLnMmJpXFOTm/lAo9Gb5PmKjbgbWRLkhJeSbcJUGi6Uw5NoWfAHTORCXlKkiL
 orrj38PDf+99A==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 work@onurozkan.dev, brauner@kernel.org, lyude@redhat.com, j@jananu.net,
 alvin.sun@linux.dev, deborah.brouwer@collabora.com,
 laura.nao@collabora.com, beata.michalska@arm.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] rust: drm: return impl PinInit from DriverFile::open()
Date: Sat,  7 Nov 2026 03:03:24 +0100
Message-ID: <20261107021427.2105374-7-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107021427.2105374-1-dakr@kernel.org>
References: <20261107021427.2105374-1-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Change DriverFile::open() to return impl PinInit<Self, Error> instead of
Result<Pin<KBox<Self>>>, consistent with how bus device private data
works.

Drivers no longer need to allocate a Pin<KBox<_>> themselves; they just
return an initializer and the subsystem takes care of the allocation.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/file.rs | 5 ++---
 drivers/gpu/drm/tyr/file.rs  | 4 ++--
 rust/kernel/drm/file.rs      | 5 +++--
 rust/kernel/drm/gem/shmem.rs | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index a05264917a0b..13642f83289d 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -7,7 +7,6 @@
 };
 use crate::gem::NovaObject;
 use kernel::{
-    alloc::flags::*,
     drm::{
         self,
         gem::BaseObject,
@@ -103,8 +102,8 @@ fn write_info<T: AsBytes>(info: &mut uapi::drm_nova_info, value: T) -> Result {
 impl drm::file::DriverFile for File {
     type Driver = NovaDriver;
 
-    fn open(_dev: &NovaDevice) -> Result<Pin<KBox<Self>>> {
-        Ok(KBox::new(Self, GFP_KERNEL)?.into())
+    fn open(_dev: &NovaDevice) -> impl PinInit<Self, Error> {
+        Ok(Self)
     }
 }
 
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 9f60a90d4948..6850708cfcdd 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -25,8 +25,8 @@ pub(crate) struct TyrDrmFileData {}
 impl drm::file::DriverFile for TyrDrmFileData {
     type Driver = TyrDrmDriver;
 
-    fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
-        KBox::try_pin_init(try_pin_init!(Self {}), GFP_KERNEL)
+    fn open(_dev: &drm::Device<Self::Driver>) -> impl PinInit<Self, Error> {
+        Ok(Self {})
     }
 }
 
diff --git a/rust/kernel/drm/file.rs b/rust/kernel/drm/file.rs
index 10160601ce5a..bd5e4ca2977f 100644
--- a/rust/kernel/drm/file.rs
+++ b/rust/kernel/drm/file.rs
@@ -18,7 +18,7 @@ pub trait DriverFile {
     type Driver: drm::Driver;
 
     /// Open a new file (called when a client opens the DRM device).
-    fn open(device: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>>;
+    fn open(device: &drm::Device<Self::Driver>) -> impl PinInit<Self, Error>;
 }
 
 /// An open DRM File.
@@ -70,7 +70,8 @@ pub(crate) extern "C" fn open_callback(
         // SAFETY: `raw_file` is a valid pointer to a `struct drm_file`.
         let file = unsafe { File::<T>::from_raw(raw_file) };
 
-        let inner = match T::open(drm) {
+        let init = T::open(drm);
+        let inner = match KBox::try_pin_init(init, GFP_KERNEL) {
             Err(e) => {
                 return e.to_errno();
             }
diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 24cb5343e0db..1a4f81e3b5b5 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -604,8 +604,8 @@ struct KunitObject {}
     impl drm::file::DriverFile for KunitFile {
         type Driver = KunitDriver;
 
-        fn open(_dev: &drm::Device<KunitDriver>) -> Result<Pin<KBox<Self>>> {
-            Ok(KBox::new(Self, GFP_KERNEL)?.into())
+        fn open(_dev: &drm::Device<KunitDriver>) -> impl PinInit<Self, Error> {
+            Ok(Self)
         }
     }
 
-- 
2.56.0

