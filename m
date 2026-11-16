Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3821606AB56
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oYR3Q17V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC5910EF73;
	Mon, 16 Nov 2026 11:26:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4E18910E3A2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:26:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF8A21713;
 Mon, 16 Nov 2026 03:26:45 -0800 (PST)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F14F3F9A2;
 Mon, 16 Nov 2026 03:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794828408; bh=BMIS0FP095oGN0RpoWacZRu0RNuTHjIHrs+5UcM7wG4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oYR3Q17V14rrhzf3ig0YHnB9UJGFD67vMrogJ9zu9Y7HTKGaDPc19Cqf78EpNhXNt
 p4+OmgNk1FTsp7it8kfzQ9gxSbkjbbXku200c4tZhbqbkUQ835x+ee+C802wmFPilt
 84iKfIXQsFLmIs7x7FBSUBHuPdD0ub3JnqNGlTOI=
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
Subject: [PATCH v5 07/13] drm/panthor: Keep size and VA in FW section obj
Date: Mon, 16 Nov 2026 12:25:55 +0100
Message-ID: <20261116112601.3483649-8-ketil.johnsen@arm.com>
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

