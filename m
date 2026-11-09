Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C806606A320
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEjyTINN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE4F10E661;
	Mon,  9 Nov 2026 00:37:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8B2710E0A4
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 00:37:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7090C450CB;
 Mon,  9 Nov 2026 00:37:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794184626;
 b=dW92tXnHOuNgueHgG6pQ/btIdONYKpm8Q3KWa73ux89H/Ninli60FFatAFZI67hHmVKC
 Kc8uyio5OJH3R75zLEl189n+CnkN0+TZBhi9Ltx9s8YnYObSzLrUYWGnMLN4ukv8zGbY5
 XJk3wPTyesK9rw8Fswn518b3dSkYnG601cXT3GBPgapHcQk3SPr3M0rCpekzJr/PYQkGO
 QptxPXwbdn3l8PWEC3lkWx2L3iSEDEf9XZKfPm1hM17azYUwQ589Gyx8iiiHsHUD+O6xk
 QzsiRj1IAs9T/a+ejJipNU7f8d8WlIqh3FA70V20en/HrVYQ1k9vzFKnd59H2ZgLDjw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794184626;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=IBlFpfumjtD0Zg1coyqBv6Babf6wyQmCwZDLKYgf71A=;
 b=LCzzGwT3yKxj3SB+zDtrb0C2i69/Z0SmISAwpmQO6sIAZmhe4KjevBQZfszNEuvWmSRb
 bY3C2POYDJSOfvxnr7D4yVQo4qjSzhZI+ngJQZqf2JclLdLFvajCvcK2vyUN+Lul4iLHp
 RFfOOI2RCyLk6dIzJ5pltbWod5akSGh8jD4pmhQcL+O8x/EdTqPIQiBHKrzJMOr99Vg0d
 Uy0FCJVYwKEUFuwYSTyC+P7t5VnSlfCVCCMik56mJBvEPxTkL2RM9Xb/Q0WTjSeSv9njr
 bQODpJTNHnRjsmjhzo58nBB1iDbf9Ph0CUP97usmiaYiiBQEI8AWxpUX9RCfEKjTDnA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 89BFC1F008A6;
 Mon,  9 Nov 2026 00:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794184626;
 bh=IBlFpfumjtD0Zg1coyqBv6Babf6wyQmCwZDLKYgf71A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=EEjyTINNXkgvO4lybEJPayI2BhG91s/h7Iyt+95si3VUMAs450ZIuDQvuDvmJ7Bx/
 SkF2DplVbeg1X8LOxOhdfOCdIQF2kxr/3VIE8MUnkc/IG74vXTkWlYM8qErD9e4mIv
 uH0q9VINj7ygRuH5iezhs2pehzDH8Olvtox5PodjLU7xRAQYSKLNHzkAlcyWlStlz5
 je46+8UbwPFBUw3goPWLeJWFZH2xXcIh2O7zVIT+dsgEAs3c9Vi0GE15JbZIv1Vf5g
 bgA+vs/0QaspVMahxJkuXkc8Qp3A0aC+1Ulkp+IB5WxsgIstGZnHMFLpm8U56IZnEJ
 KAWuA26x78GmA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id ACDD2481C8;
 Mon,  9 Nov 2026 00:37:02 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Mon, 09 Nov 2026 08:36:53 +0800
Subject: [PATCH v6 10/10] drm/tyr: add BO-related ioctls
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-tyr-ioctls-v6-10-b2896bf2b3c9@kylinos.cn>
References: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
In-Reply-To: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184620; l=5762;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=N2yXC7mHsGjQmcLK9nwxkMu+MQF7HgRnplVlBwq7BBE=;
 b=nB4NJ7KcU2Mg0kC+7vV/UXiCEZGub3Rm6NO69MjaLCaf3Nq1okwgFO7PquzG1QFU4WjiH1Rqy
 h3e/B13lf0TDt7rMVvWkZ+iWb5r8QcVnK3KvE1UAMFCAS5Lyz/T1Wou
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Sun <alvin.sun@linux.dev>

Implement BO_CREATE and BO_MMAP_OFFSET so userspace can allocate GPU
buffers and obtain a DRM mmap offset for the generic mmap path.
BO_CREATE page-aligns the requested size and accepts NO_MMAP or WB_MMAP,
which are mutually exclusive; an exclusive VM returns EOPNOTSUPP.
BO_MMAP_OFFSET rejects NO_MMAP objects, which must never be CPU-mapped.

Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/tyr/driver.rs |  2 +
 drivers/gpu/drm/tyr/file.rs   | 94 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs    |  2 -
 3 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 6869ab345d8fd..8632e6e820c97 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -237,6 +237,8 @@ impl drm::Driver for TyrDrmDriver {
         (PANTHOR_VM_DESTROY, drm_panthor_vm_destroy, ioctl::RENDER_ALLOW, TyrDrmFileData::vm_destroy),
         (PANTHOR_VM_BIND, drm_panthor_vm_bind, ioctl::RENDER_ALLOW, TyrDrmFileData::vm_bind),
         (PANTHOR_VM_GET_STATE, drm_panthor_vm_get_state, ioctl::RENDER_ALLOW, TyrDrmFileData::vm_get_state),
+        (PANTHOR_BO_CREATE, drm_panthor_bo_create, ioctl::RENDER_ALLOW, TyrDrmFileData::bo_create),
+        (PANTHOR_BO_MMAP_OFFSET, drm_panthor_bo_mmap_offset, ioctl::RENDER_ALLOW, TyrDrmFileData::bo_mmap_offset),
     }
 }
 
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index b982e8db2c4c1..f99bb2992d87a 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -242,6 +242,100 @@ pub(crate) fn vm_get_state(
             Ok(0)
         })
     }
+
+    pub(crate) fn bo_create(
+        ddev: &TyrDrmDevice<Registered>,
+        reg_data: &TyrDrmRegistrationData<'_>,
+        bocreate: &mut uapi::drm_panthor_bo_create,
+        file: &TyrDrmFile,
+    ) -> Result<u32> {
+        if bocreate.size == 0 || bocreate.pad != 0 {
+            dev_dbg!(
+                ddev.as_ref(),
+                "Invalid BO_CREATE params: size={}, pad={}\n",
+                bocreate.size,
+                bocreate.pad
+            );
+            return Err(EINVAL);
+        }
+
+        let no_mmap = uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMAP;
+        let wb_mmap = uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_WB_MMAP;
+        let valid_flags = no_mmap | wb_mmap;
+
+        if bocreate.flags & !valid_flags != 0 {
+            dev_dbg!(
+                ddev.as_ref(),
+                "Invalid BO_CREATE flags: {:#x}\n",
+                bocreate.flags
+            );
+            return Err(EINVAL);
+        }
+        if bocreate.flags & no_mmap != 0 && bocreate.flags & wb_mmap != 0 {
+            dev_dbg!(ddev.as_ref(), "BO_CREATE: NO_MMAP conflicts with WB_MMAP\n");
+            return Err(EINVAL);
+        }
+
+        if bocreate.exclusive_vm_id != 0 {
+            dev_dbg!(ddev.as_ref(), "BO_CREATE: exclusive_vm_id not supported\n");
+            return Err(EOPNOTSUPP);
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
+        let bo = file.inner_with(|pfile| {
+            crate::gem::new_object(
+                ddev,
+                pfile.reg.pdev.as_ref(),
+                size,
+                bocreate.flags,
+                reg_data.coherent,
+            )
+        })?;
+        bocreate.handle = bo.create_handle(file)?;
+        bocreate.size = u64::from_safe_cast(bo.size());
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
index 55e2d67b96d98..d2ef121c8b1b6 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -45,7 +45,6 @@ pub(crate) struct BoData {
 
 impl BoData {
     /// Returns the flags the BO was created with.
-    #[expect(dead_code)]
     pub(crate) fn flags(&self) -> u32 {
         self.flags
     }
@@ -83,7 +82,6 @@ pub(crate) fn should_map_wc(coherent: bool, flags: u32) -> bool {
 }
 
 /// Create a new GEM buffer object.
-#[expect(dead_code)]
 pub(crate) fn new_object(
     ddev: &TyrDrmDevice,
     pdev: &Device<Bound>,

-- 
2.43.0


