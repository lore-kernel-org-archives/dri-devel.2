Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A758CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1FEB10F0B2;
	Mon, 12 Oct 2026 13:00:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A493610F0A6
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:00:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0DD022F8;
 Mon, 12 Oct 2026 06:00:10 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0447C3F66F;
 Mon, 12 Oct 2026 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791810014; bh=BMIS0FP095oGN0RpoWacZRu0RNuTHjIHrs+5UcM7wG4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qVW+kxIdS6e6hotHQZZ6RDJAQaY6LF3JpCNSnS8GBldNZZJ8Z4IbWqXnk5lsEUJxb
 1hwsNRBfC5ddMsdeSOtW8Atgot1788AcPD9ZcJcJPnjafhyi0AOmScxWVKKjatNGr4
 gruifg3srtWZtqnB5QF06RpHGsMqusv83Xu7YpAg=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH v4 07/12] drm/panthor: Keep size and VA in FW section obj
Date: Mon, 12 Oct 2026 14:59:35 +0200
Message-ID: <20261012125940.3291951-8-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012125940.3291951-1-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Boris Brezillon <boris.brezillon@collabora.com>

Keep a copy of the FW section size and VA in the
panthor_fw_section object. We need this in the future when handling
late init of protected memory for FW sections of type
CSF_FW_BINARY_IFACE_ENTRY_PROT.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

---

v4:
- First version of this change as a separate commit
---
 drivers/gpu/drm/panthor/panthor_fw.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 7b8c90b19f4fe..fc07796fc9ef7 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -198,6 +198,12 @@ struct panthor_fw_section {
 		/** @size: Size of @buf in bytes. */
 		size_t size;
 	} data;
+
+	/** @size: Section size. */
+	size_t size;
+
+	/** @va: Section VA. */
+	u32 va;
 };
 
 #define CSF_MCU_SHARED_REGION_START		0x04000000ULL
@@ -669,18 +675,21 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 		section->name = name;
 	}
 
+	section->size = section_size;
+	section->va = hdr.va.start;
+
 	if (section_size) {
 		u32 vm_map_flags = section_vm_map_flags(section);
-		u64 va = hdr.va.start;
 
-		section->mem = panthor_kernel_bo_create(ptdev, panthor_fw_vm(ptdev),
-							section_size,
-							DRM_PANTHOR_BO_NO_MMAP,
-							vm_map_flags, va, "FW section");
+		section->mem = panthor_kernel_bo_create(
+			ptdev, panthor_fw_vm(ptdev), section->size,
+			DRM_PANTHOR_BO_NO_MMAP, vm_map_flags, section->va,
+			"FW section");
 		if (IS_ERR(section->mem))
 			return PTR_ERR(section->mem);
 
-		if (drm_WARN_ON(&ptdev->base, section->mem->va_node.start != hdr.va.start))
+		if (drm_WARN_ON(&ptdev->base,
+				section->mem->va_node.start != section->va))
 			return -EINVAL;
 
 		if (section->flags & CSF_FW_BINARY_IFACE_ENTRY_SHARED) {
-- 
2.43.0

