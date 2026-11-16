Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F365606A88B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o5wjWgm0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35FCA10EF86;
	Mon, 16 Nov 2026 11:29:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 857C310EF70
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:26:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 238731A25;
 Mon, 16 Nov 2026 03:26:42 -0800 (PST)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B78B63F632;
 Mon, 16 Nov 2026 03:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794828405; bh=4hjyLdYHsFbuQQjoim7LNjBF3zXbFAzH1oulIvFyJSI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o5wjWgm0rvO61HfPA2uZ3ZMW7wHTmp3nyODb5BewfKlQAvPkXFAtjWXHLWXLOH2ti
 nmUoyp9CMKY7s5kAhz14KyIkkhWpWXaI2aRk9fIs4fnrNcIiofg2jf+Z3EupOpWsmP
 IlXjtb4X/SDoeMQNHq2V/PIQG0abdY93CvHfFx4E=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH v5 06/13] drm/panthor: New function for FW section map flags
Date: Mon, 16 Nov 2026 12:25:54 +0100
Message-ID: <20261116112601.3483649-7-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116112601.3483649-1-ketil.johnsen@arm.com>
References: <20261116112601.3483649-1-ketil.johnsen@arm.com>
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Boris Brezillon <boris.brezillon@collabora.com>

This refactors the VM map flags for FW sections into a new function
called section_vm_map_flags().
This comes in handly for future handling of protected FW sections
(type CSF_FW_BINARY_IFACE_ENTRY_PROT).

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

---

v4:
- First version of this change as a separate commit
---
 drivers/gpu/drm/panthor/panthor_fw.c | 44 ++++++++++++++++------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index e639ffeac7a32..7b8c90b19f4fe 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -543,6 +543,31 @@ panthor_fw_alloc_suspend_buf_mem(struct panthor_device *ptdev, size_t size)
 					"FW suspend buffer");
 }
 
+static u32 section_vm_map_flags(const struct panthor_fw_section *section)
+{
+	u32 cache_mode = section->flags &
+			 CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_MASK;
+	u32 vm_map_flags = 0;
+
+	if (!(section->flags & CSF_FW_BINARY_IFACE_ENTRY_WR))
+		vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_READONLY;
+
+	if (!(section->flags & CSF_FW_BINARY_IFACE_ENTRY_EX))
+		vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC;
+
+	/* TODO: CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_*_COHERENT are mapped to
+	 * non-cacheable for now. We might want to introduce a new
+	 * IOMMU_xxx flag (or abuse IOMMU_MMIO, which maps to device
+	 * memory and is currently not used by our driver) for
+	 * AS_MEMATTR_AARCH64_SHARED memory, so we can take benefit
+	 * of IO-coherent systems.
+	 */
+	if (cache_mode != CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_CACHED)
+		vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED;
+
+	return vm_map_flags;
+}
+
 static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 					 const struct firmware *fw,
 					 struct panthor_fw_binary_iter *iter,
@@ -645,26 +670,9 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 	}
 
 	if (section_size) {
-		u32 cache_mode = hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_MASK;
-		u32 vm_map_flags = 0;
+		u32 vm_map_flags = section_vm_map_flags(section);
 		u64 va = hdr.va.start;
 
-		if (!(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_WR))
-			vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_READONLY;
-
-		if (!(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_EX))
-			vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC;
-
-		/* TODO: CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_*_COHERENT are mapped to
-		 * non-cacheable for now. We might want to introduce a new
-		 * IOMMU_xxx flag (or abuse IOMMU_MMIO, which maps to device
-		 * memory and is currently not used by our driver) for
-		 * AS_MEMATTR_AARCH64_SHARED memory, so we can take benefit
-		 * of IO-coherent systems.
-		 */
-		if (cache_mode != CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_CACHED)
-			vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED;
-
 		section->mem = panthor_kernel_bo_create(ptdev, panthor_fw_vm(ptdev),
 							section_size,
 							DRM_PANTHOR_BO_NO_MMAP,
-- 
2.43.0

