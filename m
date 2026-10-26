Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC3606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mq+DBAuF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 930E710F04C;
	Mon, 26 Oct 2026 16:42:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C39010F021
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:41:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C66FE44226;
 Mon, 26 Oct 2026 16:41:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793032876;
 b=hNDFmPyfkFnN7eIg9JeaidAw98h2LbJrEDZoX1grXPJeqzKf0FCf/qvSU/8Ilt8tJNLJ
 K7f3HXcbuhsV5SK8Qh6FX07jmhh2yDGGy55ifGV3Tj1SW7z8H675ElU6VBQCUDySanz+W
 URaVchl198zjB7lfKKHl6/S7Xq+zRkpmIk9M4dBwdubdcdhrtEx5OdpWazJE1EpPWOyl7
 nZfu9FprQDssyRE5XEpUsNXStOWpwAsjn6agxIEQYLETej9gboamB7wrw7rJ7j8vKWrw0
 y+3aOVm2jHCi4yLXFd5BqBrUhXZAu6uEOVNfQm5mTVqdEJG45/dSAE0+PEKF5Wxbh7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032876;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=KqRn1n5iORX+7EiqCp1P4Y8MwIEiz+RAzWKAWH8qI0I=;
 b=bgbtFepVEDqyUxIlf9MFePc2fai/v4PkBZnG4bRkE1Oc8HTKAOdtPUOALTqnCLJdPqJb
 fAjPRy9l41NAFcKOA6e/nKDVSwYk9r8SqOAlRadBHRZrlEqGrFtovO6sOxAT3p6OvGr24
 bd6oG8DwgsXv17XBDFgjJL8+lQ5lP0EP2gKnIO0sFTvo6lNtG+yhv8Jj2tNDOLYkI6JZ2
 JYZSJwsu5u/D/Vp5C0mcrqSJifSftNgQUPHdse1GA1LUOFuP22V5ZGz+h7c6s6MplMISi
 Pq3BGVxXEeX9PEMzVRkDlN74V2cBB/SD3iX7uR6nX6bMwmC+mFnR5d6jNLS5yjIZd6A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 89F7F1F01829;
 Mon, 26 Oct 2026 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793032876;
 bh=KqRn1n5iORX+7EiqCp1P4Y8MwIEiz+RAzWKAWH8qI0I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Mq+DBAuFHC2movOX44cyDWnxKYHE6nuk08H8k3tkI/S/zty/bolDieWFCGCFkJLR+
 2TAYTsJo9/hhYXjR2qCb0gfT6E6/00tYTqTnYtOYKSDRLLuIF4weZ9AVEDcu+5gJ1s
 JSu0eLRgy8tUaiZ2elwu9/ZiO0JE0o4CXOOjZrP6eE2mQdamfATu6PcfmjCGRnzD8m
 qeRj6HjRUW8Rs+JGcU3Wy1A3EVjw59qILFZWMT5MFcZ3ycQO9ue2m0Q47OwYCU8bzK
 /Nf+Rb+myxoHcFm6uq5c+/yz9M9mifRW/u+YtH/XG+Yqgc9unCUczzJcEAetW1W4jv
 gXb9sTetcKqNA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 9804F44DE1;
 Mon, 26 Oct 2026 16:41:12 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Tue, 27 Oct 2026 00:41:01 +0800
Subject: [PATCH v5 08/11] drm/tyr: add BO-related ioctls
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-tyr-ioctls-v5-8-59dfe98cb003@kylinos.cn>
References: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
In-Reply-To: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
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
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793032870; l=5835;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=pPJLhN0cYhR6VLbdNYY1nEjJlXnDPH5ZSxoTT9flAXo=;
 b=YyVN2+IIBdNWjG/nZnmPFIvV4QLm8ezDTgls0lXe89K2tuvDrlu7EXFoUO30IIZo0s51QdNDG
 CGRmA4Uicr9Ag57AwWRM6OyyUzTn5M/FYURrxvocBEeKwCm5sx6aLpT
X-Developer-Key: i=sunke@kylinos.cn; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for sunke@kylinos.cn/20260317 with auth_id=950
X-Original-From: Ke Sun <sunke@kylinos.cn>
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
Reply-To: sunke@kylinos.cn
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Sun <alvin.sun@linux.dev>

Implement BO_CREATE and BO_MMAP_OFFSET so userspace can allocate GPU
buffers and obtain a DRM mmap offset for the generic mmap path.
BO_CREATE page-aligns the requested size; BO_MMAP_OFFSET rejects
NO_MMAP objects, which must never be CPU-mapped.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/tyr/driver.rs |  2 ++
 drivers/gpu/drm/tyr/file.rs   | 73 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs    | 18 +++++++++--
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index c0f17bc4ce2c9..f4f31b24180b4 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -227,6 +227,8 @@ impl drm::Driver for TyrDrmDriver {
         (PANTHOR_VM_DESTROY, drm_panthor_vm_destroy, ioctl::RENDER_ALLOW, TyrDrmFileData::vm_destroy),
         (PANTHOR_VM_BIND, drm_panthor_vm_bind, ioctl::RENDER_ALLOW, TyrDrmFileData::vm_bind),
         (PANTHOR_VM_GET_STATE, drm_panthor_vm_get_state, ioctl::RENDER_ALLOW, TyrDrmFileData::vm_get_state),
+        (PANTHOR_BO_CREATE, drm_panthor_bo_create, ioctl::RENDER_ALLOW, TyrDrmFileData::bo_create),
+        (PANTHOR_BO_MMAP_OFFSET, drm_panthor_bo_mmap_offset, ioctl::RENDER_ALLOW, TyrDrmFileData::bo_mmap_offset),
     }
 }
 
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 22a74b4abf3de..9ffb42f0d8851 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -250,6 +250,79 @@ pub(crate) fn vm_get_state(
             Ok(0)
         })
     }
+
+    pub(crate) fn bo_create(
+        ddev: &TyrDrmDevice<Registered>,
+        _reg_data: &TyrDrmRegistrationData<'_>,
+        bocreate: &mut uapi::drm_panthor_bo_create,
+        file: &TyrDrmFile,
+    ) -> Result<u32> {
+        if bocreate.size == 0
+            || bocreate.pad != 0
+            || bocreate.flags & !uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMAP != 0
+        {
+            dev_dbg!(
+                ddev.as_ref(),
+                "Invalid BO_CREATE params: size={}, pad={}, flags={:#x}\n",
+                bocreate.size,
+                bocreate.pad,
+                bocreate.flags
+            );
+            return Err(EINVAL);
+        }
+
+        if bocreate.exclusive_vm_id != 0 {
+            dev_dbg!(ddev.as_ref(), "BO_CREATE: exclusive_vm_id not supported\n");
+            return Err(EINVAL);
+        }
+
+        let size = usize::try_from(bocreate.size).map_err(|_| {
+            dev_dbg!(
+                ddev.as_ref(),
+                "BO_CREATE size {:#x} too large\n",
+                bocreate.size
+            );
+            EINVAL
+        })?;
+        let bo = crate::gem::new_object(ddev, size, bocreate.flags)?;
+        bocreate.handle = bo.create_handle(file)?;
+        bocreate.size = bo.size() as u64;
+
+        Ok(0)
+    }
+
+    pub(crate) fn bo_mmap_offset(
+        ddev: &TyrDrmDevice<Registered>,
+        _reg_data: &TyrDrmRegistrationData<'_>,
+        bommap: &mut uapi::drm_panthor_bo_mmap_offset,
+        file: &TyrDrmFile,
+    ) -> Result<u32> {
+        if bommap.pad != 0 {
+            dev_dbg!(
+                ddev.as_ref(),
+                "BO mmap offset pad not zero: {}\n",
+                bommap.pad
+            );
+            return Err(EINVAL);
+        }
+
+        let bo = crate::gem::lookup_handle(file, bommap.handle).inspect_err(|_| {
+            dev_dbg!(ddev.as_ref(), "Invalid BO mmap handle: {}\n", bommap.handle);
+        })?;
+        if bo.flags() & uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMAP != 0 {
+            dev_dbg!(ddev.as_ref(), "BO mmap offset on NO_MMAP object\n");
+            return Err(EPERM);
+        }
+        bommap.offset = bo.create_mmap_offset().inspect_err(|_| {
+            dev_err!(
+                ddev.as_ref(),
+                "Failed to create mmap offset for handle {}\n",
+                bommap.handle
+            );
+        })?;
+
+        Ok(0)
+    }
 }
 
 fn vm_bind_exec_op(vm: &Vm<'_>, file: &TyrDrmFile, op: &VmBindOp) -> Result {
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 60f6363995a5a..14f3e182b98e2 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -38,6 +38,13 @@ pub(crate) struct BoData {
     flags: u32,
 }
 
+impl BoData {
+    /// Returns the flags the BO was created with.
+    pub(crate) fn flags(&self) -> u32 {
+        self.flags
+    }
+}
+
 /// Provides a way to pass arguments when creating BoData
 /// as required by the gem::DriverObject trait.
 pub(crate) struct BoCreateArgs {
@@ -57,7 +64,6 @@ fn new(_dev: &TyrDrmDevice, _size: usize, args: BoCreateArgs) -> impl PinInit<Se
 pub(crate) type Bo = gem::shmem::Object<BoData>;
 
 /// Create a new GEM buffer object.
-#[expect(dead_code)]
 pub(crate) fn new_object(ddev: &TyrDrmDevice, size: usize, flags: u32) -> Result<ARef<Bo>> {
     if size == 0 {
         return Err(EINVAL);
@@ -65,7 +71,7 @@ pub(crate) fn new_object(ddev: &TyrDrmDevice, size: usize, flags: u32) -> Result
 
     let aligned_size = size.checked_next_multiple_of(PAGE_SIZE).ok_or(EINVAL)?;
 
-    Bo::new(
+    let bo = Bo::new(
         ddev,
         aligned_size,
         shmem::ObjectConfig {
@@ -73,7 +79,13 @@ pub(crate) fn new_object(ddev: &TyrDrmDevice, size: usize, flags: u32) -> Result
             parent_resv_obj: None,
         },
         BoCreateArgs { flags },
-    )
+    )?;
+
+    // SAFETY: `ddev` is bound for the duration of this call.
+    let dev = unsafe { ddev.as_ref().as_ref().as_bound() };
+    bo.sg_table(dev)?;
+
+    Ok(bo)
 }
 
 /// Look up a GEM object by handle for a DRM file.

-- 
2.43.0


