Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2836606A32C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=Du9JWc7z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C5D10FCE1;
	Wed,  4 Nov 2026 11:24:47 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E87510E845;
 Wed,  4 Nov 2026 11:24:40 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4B7qmi2267955; Wed, 4 Nov 2026 11:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=U
 d2fvXMjvGn7GOKpHqxPNfx3SXfQIYXPDOHzg5UyaIw=; b=Du9JWc7z6VZfznmSU
 M2Q4a1lK0Ujsjy/aCAcvZOYG+X5ySTbo1nk/SFhOvRTqUXCESkMwf0WSOI4Y95ZU
 HL5o8AdCl7yvdQ/XM5JYYHikCYO9Htx6/QR4VGSkMho4LIT8WN17xb75bUixCOMZ
 wYhojDRZczkmXw0KFnzLkU89/WIqDnbCF/20hq8ss7oJHbzOWFlf+GMOZG/yqmBs
 f3kVWFvhBzDE0bwU8i0rN5j3VVWgDyMvbBeH2HXcxSTYj3X0tqDbmJb1ewAqEk9u
 amFPeU9aY53+UZMvzeNASglQnBUSMy/X67zG2QQyQHzwIFVvzxy6UcNcvt+Pvotd
 ty1Hw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hr3j6r0e4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 11:24:32 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.190) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 11:24:31 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 4 Nov 2026 13:24:05 +0200
Subject: [PATCH v3 1/2] drm/imagination: Switch to kernel-style MMU defines
 and access
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-b4-include-mmu-defines-only-in-mmu-code-v3-1-f9925419b8bc@imgtec.com>
References: <20261104-b4-include-mmu-defines-only-in-mmu-code-v3-0-f9925419b8bc@imgtec.com>
In-Reply-To: <20261104-b4-include-mmu-defines-only-in-mmu-code-v3-0-f9925419b8bc@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793791470; l=21892;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=TtXzvt343GBo5bcLM/o+/qfRbI0YLWw7EythD/nKD3k=;
 b=Ekcd+ywRFF8oWspuasWfml5MTIo+5hb8xjumCvrWloW5lUCXTYDNW3n7RC0Od6V8tK3GUmzuF
 55q9nKnNrjeC5CweorZV+CO1OqBvpjvla/TTLszNTNRe+ltZHnpyCBn
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-GUID: ws7Lx1juipfZAxlMF42HeNnKvIcCwXej
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0NSBTYWx0ZWRfX8I+1bE8lDhMy
 hbwlLfkAmdt5jBMvfPKzCAC7UtF2zuq+qv2WwaRTaAHtbfbvK3wD3DtHE4CUs3bSu0QKv5Un/kJ
 PxbCWtTVPQ2jmSEwz/RL+PgIHOSE6zU=
X-Proofpoint-ORIG-GUID: ws7Lx1juipfZAxlMF42HeNnKvIcCwXej
X-Authority-Analysis: v=2.4 cv=DtnDa2/+ c=1 sm=1 tr=0 ts=6aeb15f0 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Y9E4qlbPYa4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=7GRYESCgb-oqm2kxLYMA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0NSBTYWx0ZWRfX/eUmjgHx9Trn
 NGqK0H76VSCdqs4aDbqOX49GRgKANViU3D4nZ6+92K3l4z/a76TVr8CaVfyxgQvMc5aJECpG55b
 vWQ1ehzJPEXzrsMdwlgBw0Ihl+VY0O7m3YKfzIs8ufg1QLU7K1EKLyHRAR4iJrjOnVn9EYrI/KC
 uqxUu2mn7LabwXWIWrGU+8FpD1aSY6rnoZa+izfHCD3/iMHJnfCeMsWFzgJ2Ga4ymP7EiuZmUpN
 xXr7pP6bXEpK2Ixdps2NDIbx2NMHoDRphwI9c/aBgiLkxHaBwl/Xkl6bYS3iQNucEaWHmXun3Gx
 w75Ixx6lfRrg4miDmDRmzMvNRBEu8cTQrOrnzcwUYMjGyVOdnAmEyzU14IhlGUHy0bbFQ0gQUNk
 Bs4/8mZnK5nG2XsXEBsh6G7GyZvk8NzvVlXcA0DC+G8uUwKWr7P2b6mxzfHP2ii1ZPtNg6YV45U
 Y7er5h/nNLnGobDE7VA==
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alessio Belle <alessio.belle@imgtec.com>

- Regenerate MMU defines to use GENMASK and BIT
- Use FIELD_PREP/GET to access page table entries and split virtual
  addresses in their components
- Remove macros which can be reimplemented by FIELD_PREP/GET
- Remove other unnecessary macros

This should make the code a bit easier to maintain.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_mmu.c            |  91 ++++-----
 drivers/gpu/drm/imagination/pvr_rogue_mmu_defs.h | 244 +++++++++++------------
 2 files changed, 156 insertions(+), 179 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 67e73d7d5d0e..b4b64eef4f6e 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -14,16 +14,15 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_print.h>
 #include <linux/atomic.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/dma-mapping.h>
 #include <linux/kmemleak.h>
 #include <linux/minmax.h>
 #include <linux/property.h>
 #include <linux/sizes.h>
 
-#define PVR_SHIFT_FROM_SIZE(size_) (__builtin_ctzll(size_))
-#define PVR_MASK_FROM_SIZE(size_) (~((size_) - U64_C(1)))
-
 /*
  * The value of the device page size (%PVR_DEVICE_PAGE_SIZE) is currently
  * pegged to the host page size (%PAGE_SIZE). This chunk of macro goodness both
@@ -32,35 +31,31 @@
  */
 #if (PVR_DEVICE_PAGE_SIZE == SZ_4K)
 # define ROGUE_MMUCTRL_PAGE_SIZE_X ROGUE_MMUCTRL_PAGE_SIZE_4KB
-# define ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT ROGUE_MMUCTRL_PAGE_4KB_RANGE_SHIFT
-# define ROGUE_MMUCTRL_PAGE_X_RANGE_CLRMSK ROGUE_MMUCTRL_PAGE_4KB_RANGE_CLRMSK
+# define ROGUE_MMUCTRL_PAGE_X_RANGE_MASK ROGUE_MMUCTRL_PAGE_4KB_RANGE_MASK
 #elif (PVR_DEVICE_PAGE_SIZE == SZ_16K)
 # define ROGUE_MMUCTRL_PAGE_SIZE_X ROGUE_MMUCTRL_PAGE_SIZE_16KB
-# define ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT ROGUE_MMUCTRL_PAGE_16KB_RANGE_SHIFT
-# define ROGUE_MMUCTRL_PAGE_X_RANGE_CLRMSK ROGUE_MMUCTRL_PAGE_16KB_RANGE_CLRMSK
+# define ROGUE_MMUCTRL_PAGE_X_RANGE_MASK ROGUE_MMUCTRL_PAGE_16KB_RANGE_MASK
 #elif (PVR_DEVICE_PAGE_SIZE == SZ_64K)
 # define ROGUE_MMUCTRL_PAGE_SIZE_X ROGUE_MMUCTRL_PAGE_SIZE_64KB
-# define ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT ROGUE_MMUCTRL_PAGE_64KB_RANGE_SHIFT
-# define ROGUE_MMUCTRL_PAGE_X_RANGE_CLRMSK ROGUE_MMUCTRL_PAGE_64KB_RANGE_CLRMSK
+# define ROGUE_MMUCTRL_PAGE_X_RANGE_MASK ROGUE_MMUCTRL_PAGE_64KB_RANGE_MASK
 #elif (PVR_DEVICE_PAGE_SIZE == SZ_256K)
 # define ROGUE_MMUCTRL_PAGE_SIZE_X ROGUE_MMUCTRL_PAGE_SIZE_256KB
-# define ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT ROGUE_MMUCTRL_PAGE_256KB_RANGE_SHIFT
-# define ROGUE_MMUCTRL_PAGE_X_RANGE_CLRMSK ROGUE_MMUCTRL_PAGE_256KB_RANGE_CLRMSK
+# define ROGUE_MMUCTRL_PAGE_X_RANGE_MASK ROGUE_MMUCTRL_PAGE_256KB_RANGE_MASK
 #elif (PVR_DEVICE_PAGE_SIZE == SZ_1M)
 # define ROGUE_MMUCTRL_PAGE_SIZE_X ROGUE_MMUCTRL_PAGE_SIZE_1MB
-# define ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT ROGUE_MMUCTRL_PAGE_1MB_RANGE_SHIFT
-# define ROGUE_MMUCTRL_PAGE_X_RANGE_CLRMSK ROGUE_MMUCTRL_PAGE_1MB_RANGE_CLRMSK
+# define ROGUE_MMUCTRL_PAGE_X_RANGE_MASK ROGUE_MMUCTRL_PAGE_1MB_RANGE_MASK
 #elif (PVR_DEVICE_PAGE_SIZE == SZ_2M)
 # define ROGUE_MMUCTRL_PAGE_SIZE_X ROGUE_MMUCTRL_PAGE_SIZE_2MB
-# define ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT ROGUE_MMUCTRL_PAGE_2MB_RANGE_SHIFT
-# define ROGUE_MMUCTRL_PAGE_X_RANGE_CLRMSK ROGUE_MMUCTRL_PAGE_2MB_RANGE_CLRMSK
+# define ROGUE_MMUCTRL_PAGE_X_RANGE_MASK ROGUE_MMUCTRL_PAGE_2MB_RANGE_MASK
 #else
 # error Unsupported device page size PVR_DEVICE_PAGE_SIZE
 #endif
 
+#define ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT __bf_shf(ROGUE_MMUCTRL_PAGE_X_RANGE_MASK)
+
 #define ROGUE_MMUCTRL_ENTRIES_PT_VALUE_X   \
 	(ROGUE_MMUCTRL_ENTRIES_PT_VALUE >> \
-	 (PVR_DEVICE_PAGE_SHIFT - PVR_SHIFT_FROM_SIZE(SZ_4K)))
+	 (PVR_DEVICE_PAGE_SHIFT - __builtin_ctzll(SZ_4K)))
 
 enum pvr_mmu_sync_level {
 	PVR_MMU_SYNC_LEVEL_NONE = -1,
@@ -379,19 +374,6 @@ pvr_mmu_backing_page_sync(struct pvr_mmu_backing_page *page, u32 flags)
  * DOC: Raw page tables
  */
 
-#define PVR_PAGE_TABLE_TYPEOF_ENTRY(level_) \
-	typeof_member(struct pvr_page_table_l##level_##_entry_raw, val)
-
-#define PVR_PAGE_TABLE_FIELD_GET(level_, name_, field_, entry_)           \
-	(((entry_).val &                                           \
-	  ~ROGUE_MMUCTRL_##name_##_DATA_##field_##_CLRMSK) >> \
-	 ROGUE_MMUCTRL_##name_##_DATA_##field_##_SHIFT)
-
-#define PVR_PAGE_TABLE_FIELD_PREP(level_, name_, field_, val_)            \
-	((((PVR_PAGE_TABLE_TYPEOF_ENTRY(level_))(val_))            \
-	  << ROGUE_MMUCTRL_##name_##_DATA_##field_##_SHIFT) & \
-	 ~ROGUE_MMUCTRL_##name_##_DATA_##field_##_CLRMSK)
-
 /**
  * struct pvr_page_table_l2_entry_raw - A single entry in a level 2 page table.
  * @val: The raw value of this entry.
@@ -432,7 +414,7 @@ static_assert(sizeof(struct pvr_page_table_l2_entry_raw) * 8 ==
 static bool
 pvr_page_table_l2_entry_raw_is_valid(struct pvr_page_table_l2_entry_raw entry)
 {
-	return PVR_PAGE_TABLE_FIELD_GET(2, PC, VALID, entry);
+	return FIELD_GET(ROGUE_MMUCTRL_PC_DATA_VALID, entry.val);
 }
 
 /**
@@ -443,18 +425,18 @@ pvr_page_table_l2_entry_raw_is_valid(struct pvr_page_table_l2_entry_raw entry)
  *                        associated with @entry.
  *
  * When calling this function, @child_table_dma_addr must be a valid DMA
- * address and a multiple of %ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGNSIZE.
+ * address and a multiple of 1 << %ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGN (4 KiB).
  */
 static void
 pvr_page_table_l2_entry_raw_set(struct pvr_page_table_l2_entry_raw *entry,
 				dma_addr_t child_table_dma_addr)
 {
-	child_table_dma_addr >>= ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGNSHIFT;
+	child_table_dma_addr >>= ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGN;
 
 	WRITE_ONCE(entry->val,
-		   PVR_PAGE_TABLE_FIELD_PREP(2, PC, VALID, true) |
-		   PVR_PAGE_TABLE_FIELD_PREP(2, PC, ENTRY_PENDING, false) |
-		   PVR_PAGE_TABLE_FIELD_PREP(2, PC, PD_BASE, child_table_dma_addr));
+		   FIELD_PREP(ROGUE_MMUCTRL_PC_DATA_VALID, true) |
+		   FIELD_PREP(ROGUE_MMUCTRL_PC_DATA_ENTRY_PENDING, false) |
+		   FIELD_PREP(ROGUE_MMUCTRL_PC_DATA_PD_BASE_MASK, child_table_dma_addr));
 }
 
 static void
@@ -555,7 +537,7 @@ static_assert(sizeof(struct pvr_page_table_l1_entry_raw) * 8 ==
 static bool
 pvr_page_table_l1_entry_raw_is_valid(struct pvr_page_table_l1_entry_raw entry)
 {
-	return PVR_PAGE_TABLE_FIELD_GET(1, PD, VALID, entry);
+	return FIELD_GET(ROGUE_MMUCTRL_PD_DATA_VALID, entry.val);
 }
 
 /**
@@ -573,9 +555,9 @@ pvr_page_table_l1_entry_raw_set(struct pvr_page_table_l1_entry_raw *entry,
 				dma_addr_t child_table_dma_addr)
 {
 	WRITE_ONCE(entry->val,
-		   PVR_PAGE_TABLE_FIELD_PREP(1, PD, VALID, true) |
-		   PVR_PAGE_TABLE_FIELD_PREP(1, PD, ENTRY_PENDING, false) |
-		   PVR_PAGE_TABLE_FIELD_PREP(1, PD, PAGE_SIZE, ROGUE_MMUCTRL_PAGE_SIZE_X) |
+		   FIELD_PREP(ROGUE_MMUCTRL_PD_DATA_VALID, true) |
+		   FIELD_PREP(ROGUE_MMUCTRL_PD_DATA_ENTRY_PENDING, false) |
+		   FIELD_PREP(ROGUE_MMUCTRL_PD_DATA_PAGE_SIZE_MASK, ROGUE_MMUCTRL_PAGE_SIZE_X) |
 		   /*
 		    * The use of a 4K-specific macro here is correct. It is
 		    * a future optimization to allocate sub-host-page-sized
@@ -583,7 +565,7 @@ pvr_page_table_l1_entry_raw_set(struct pvr_page_table_l1_entry_raw *entry,
 		    * page table address is aligned to the size of the
 		    * largest (a 4KB) table currently holds.
 		    */
-		   (child_table_dma_addr & ~ROGUE_MMUCTRL_PT_BASE_4KB_RANGE_CLRMSK));
+		   (child_table_dma_addr & ROGUE_MMUCTRL_PT_BASE_4KB_RANGE_MASK));
 }
 
 static void
@@ -715,7 +697,7 @@ static_assert(sizeof(struct pvr_page_flags_raw) ==
 static bool
 pvr_page_table_l0_entry_raw_is_valid(struct pvr_page_table_l0_entry_raw entry)
 {
-	return PVR_PAGE_TABLE_FIELD_GET(0, PT, VALID, entry);
+	return FIELD_GET(ROGUE_MMUCTRL_PT_DATA_VALID, entry.val);
 }
 
 /**
@@ -737,10 +719,11 @@ pvr_page_table_l0_entry_raw_set(struct pvr_page_table_l0_entry_raw *entry,
 				dma_addr_t dma_addr,
 				struct pvr_page_flags_raw flags)
 {
-	WRITE_ONCE(entry->val, PVR_PAGE_TABLE_FIELD_PREP(0, PT, VALID, true) |
-			       PVR_PAGE_TABLE_FIELD_PREP(0, PT, ENTRY_PENDING, false) |
-			       (dma_addr & ~ROGUE_MMUCTRL_PAGE_X_RANGE_CLRMSK) |
-			       flags.val.val);
+	WRITE_ONCE(entry->val,
+		   FIELD_PREP(ROGUE_MMUCTRL_PT_DATA_VALID, true) |
+		   FIELD_PREP(ROGUE_MMUCTRL_PT_DATA_ENTRY_PENDING, false) |
+		   (dma_addr & ROGUE_MMUCTRL_PAGE_X_RANGE_MASK) |
+		   flags.val.val);
 }
 
 static void
@@ -773,10 +756,10 @@ pvr_page_flags_raw_create(bool read_only, bool cache_coherent, bool slc_bypass,
 	struct pvr_page_flags_raw flags;
 
 	flags.val.val =
-		PVR_PAGE_TABLE_FIELD_PREP(0, PT, READ_ONLY, read_only) |
-		PVR_PAGE_TABLE_FIELD_PREP(0, PT, CC, cache_coherent) |
-		PVR_PAGE_TABLE_FIELD_PREP(0, PT, SLC_BYPASS_CTRL, slc_bypass) |
-		PVR_PAGE_TABLE_FIELD_PREP(0, PT, PM_META_PROTECT, pm_fw_protect);
+		FIELD_PREP(ROGUE_MMUCTRL_PT_DATA_READ_ONLY, read_only) |
+		FIELD_PREP(ROGUE_MMUCTRL_PT_DATA_CC, cache_coherent) |
+		FIELD_PREP(ROGUE_MMUCTRL_PT_DATA_SLC_BYPASS_CTRL, slc_bypass) |
+		FIELD_PREP(ROGUE_MMUCTRL_PT_DATA_PM_META_PROTECT, pm_fw_protect);
 
 	return flags;
 }
@@ -1672,8 +1655,7 @@ pvr_page_table_l0_remove(struct pvr_mmu_op_context *op_ctx)
 static u16
 pvr_page_table_l2_idx(u64 device_addr)
 {
-	return (device_addr & ~ROGUE_MMUCTRL_VADDR_PC_INDEX_CLRMSK) >>
-	       ROGUE_MMUCTRL_VADDR_PC_INDEX_SHIFT;
+	return FIELD_GET(ROGUE_MMUCTRL_VADDR_PC_INDEX_MASK, device_addr);
 }
 
 /**
@@ -1691,8 +1673,7 @@ pvr_page_table_l2_idx(u64 device_addr)
 static u16
 pvr_page_table_l1_idx(u64 device_addr)
 {
-	return (device_addr & ~ROGUE_MMUCTRL_VADDR_PD_INDEX_CLRMSK) >>
-	       ROGUE_MMUCTRL_VADDR_PD_INDEX_SHIFT;
+	return FIELD_GET(ROGUE_MMUCTRL_VADDR_PD_INDEX_MASK, device_addr);
 }
 
 /**
@@ -1710,8 +1691,8 @@ pvr_page_table_l1_idx(u64 device_addr)
 static u16
 pvr_page_table_l0_idx(u64 device_addr)
 {
-	return (device_addr & ~ROGUE_MMUCTRL_VADDR_PT_INDEX_CLRMSK) >>
-	       ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT;
+	return (device_addr & ROGUE_MMUCTRL_VADDR_PT_INDEX_MASK)
+		>> ROGUE_MMUCTRL_PAGE_X_RANGE_SHIFT;
 }
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_mmu_defs.h b/drivers/gpu/drm/imagination/pvr_rogue_mmu_defs.h
index f361ccdd5405..f34bbe41ef46 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_mmu_defs.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_mmu_defs.h
@@ -8,129 +8,125 @@
 
 #define ROGUE_MMU_DEFS_REVISION 0
 
-#define ROGUE_BIF_DM_ENCODING_VERTEX (0x00000000U)
-#define ROGUE_BIF_DM_ENCODING_PIXEL (0x00000001U)
-#define ROGUE_BIF_DM_ENCODING_COMPUTE (0x00000002U)
-#define ROGUE_BIF_DM_ENCODING_TLA (0x00000003U)
-#define ROGUE_BIF_DM_ENCODING_PB_VCE (0x00000004U)
-#define ROGUE_BIF_DM_ENCODING_PB_TE (0x00000005U)
-#define ROGUE_BIF_DM_ENCODING_META (0x00000007U)
-#define ROGUE_BIF_DM_ENCODING_HOST (0x00000008U)
-#define ROGUE_BIF_DM_ENCODING_PM_ALIST (0x00000009U)
-
-#define ROGUE_MMUCTRL_VADDR_PC_INDEX_SHIFT (30U)
-#define ROGUE_MMUCTRL_VADDR_PC_INDEX_CLRMSK (0xFFFFFF003FFFFFFFULL)
-#define ROGUE_MMUCTRL_VADDR_PD_INDEX_SHIFT (21U)
-#define ROGUE_MMUCTRL_VADDR_PD_INDEX_CLRMSK (0xFFFFFFFFC01FFFFFULL)
-#define ROGUE_MMUCTRL_VADDR_PT_INDEX_SHIFT (12U)
-#define ROGUE_MMUCTRL_VADDR_PT_INDEX_CLRMSK (0xFFFFFFFFFFE00FFFULL)
-
-#define ROGUE_MMUCTRL_ENTRIES_PC_VALUE (0x00000400U)
-#define ROGUE_MMUCTRL_ENTRIES_PD_VALUE (0x00000200U)
-#define ROGUE_MMUCTRL_ENTRIES_PT_VALUE (0x00000200U)
-
-#define ROGUE_MMUCTRL_ENTRY_SIZE_PC_VALUE (0x00000020U)
-#define ROGUE_MMUCTRL_ENTRY_SIZE_PD_VALUE (0x00000040U)
-#define ROGUE_MMUCTRL_ENTRY_SIZE_PT_VALUE (0x00000040U)
-
-#define ROGUE_MMUCTRL_PAGE_SIZE_MASK (0x00000007U)
-#define ROGUE_MMUCTRL_PAGE_SIZE_4KB (0x00000000U)
-#define ROGUE_MMUCTRL_PAGE_SIZE_16KB (0x00000001U)
-#define ROGUE_MMUCTRL_PAGE_SIZE_64KB (0x00000002U)
-#define ROGUE_MMUCTRL_PAGE_SIZE_256KB (0x00000003U)
-#define ROGUE_MMUCTRL_PAGE_SIZE_1MB (0x00000004U)
-#define ROGUE_MMUCTRL_PAGE_SIZE_2MB (0x00000005U)
-
-#define ROGUE_MMUCTRL_PAGE_4KB_RANGE_SHIFT (12U)
-#define ROGUE_MMUCTRL_PAGE_4KB_RANGE_CLRMSK (0xFFFFFF0000000FFFULL)
-
-#define ROGUE_MMUCTRL_PAGE_16KB_RANGE_SHIFT (14U)
-#define ROGUE_MMUCTRL_PAGE_16KB_RANGE_CLRMSK (0xFFFFFF0000003FFFULL)
-
-#define ROGUE_MMUCTRL_PAGE_64KB_RANGE_SHIFT (16U)
-#define ROGUE_MMUCTRL_PAGE_64KB_RANGE_CLRMSK (0xFFFFFF000000FFFFULL)
-
-#define ROGUE_MMUCTRL_PAGE_256KB_RANGE_SHIFT (18U)
-#define ROGUE_MMUCTRL_PAGE_256KB_RANGE_CLRMSK (0xFFFFFF000003FFFFULL)
-
-#define ROGUE_MMUCTRL_PAGE_1MB_RANGE_SHIFT (20U)
-#define ROGUE_MMUCTRL_PAGE_1MB_RANGE_CLRMSK (0xFFFFFF00000FFFFFULL)
-
-#define ROGUE_MMUCTRL_PAGE_2MB_RANGE_SHIFT (21U)
-#define ROGUE_MMUCTRL_PAGE_2MB_RANGE_CLRMSK (0xFFFFFF00001FFFFFULL)
-
-#define ROGUE_MMUCTRL_PT_BASE_4KB_RANGE_SHIFT (12U)
-#define ROGUE_MMUCTRL_PT_BASE_4KB_RANGE_CLRMSK (0xFFFFFF0000000FFFULL)
-
-#define ROGUE_MMUCTRL_PT_BASE_16KB_RANGE_SHIFT (10U)
-#define ROGUE_MMUCTRL_PT_BASE_16KB_RANGE_CLRMSK (0xFFFFFF00000003FFULL)
-
-#define ROGUE_MMUCTRL_PT_BASE_64KB_RANGE_SHIFT (8U)
-#define ROGUE_MMUCTRL_PT_BASE_64KB_RANGE_CLRMSK (0xFFFFFF00000000FFULL)
-
-#define ROGUE_MMUCTRL_PT_BASE_256KB_RANGE_SHIFT (6U)
-#define ROGUE_MMUCTRL_PT_BASE_256KB_RANGE_CLRMSK (0xFFFFFF000000003FULL)
-
-#define ROGUE_MMUCTRL_PT_BASE_1MB_RANGE_SHIFT (5U)
-#define ROGUE_MMUCTRL_PT_BASE_1MB_RANGE_CLRMSK (0xFFFFFF000000001FULL)
-
-#define ROGUE_MMUCTRL_PT_BASE_2MB_RANGE_SHIFT (5U)
-#define ROGUE_MMUCTRL_PT_BASE_2MB_RANGE_CLRMSK (0xFFFFFF000000001FULL)
-
-#define ROGUE_MMUCTRL_PT_DATA_PM_META_PROTECT_SHIFT (62U)
-#define ROGUE_MMUCTRL_PT_DATA_PM_META_PROTECT_CLRMSK (0xBFFFFFFFFFFFFFFFULL)
-#define ROGUE_MMUCTRL_PT_DATA_PM_META_PROTECT_EN (0x4000000000000000ULL)
-#define ROGUE_MMUCTRL_PT_DATA_VP_PAGE_HI_SHIFT (40U)
-#define ROGUE_MMUCTRL_PT_DATA_VP_PAGE_HI_CLRMSK (0xC00000FFFFFFFFFFULL)
-#define ROGUE_MMUCTRL_PT_DATA_PAGE_SHIFT (12U)
-#define ROGUE_MMUCTRL_PT_DATA_PAGE_CLRMSK (0xFFFFFF0000000FFFULL)
-#define ROGUE_MMUCTRL_PT_DATA_VP_PAGE_LO_SHIFT (6U)
-#define ROGUE_MMUCTRL_PT_DATA_VP_PAGE_LO_CLRMSK (0xFFFFFFFFFFFFF03FULL)
-#define ROGUE_MMUCTRL_PT_DATA_ENTRY_PENDING_SHIFT (5U)
-#define ROGUE_MMUCTRL_PT_DATA_ENTRY_PENDING_CLRMSK (0xFFFFFFFFFFFFFFDFULL)
-#define ROGUE_MMUCTRL_PT_DATA_ENTRY_PENDING_EN (0x0000000000000020ULL)
-#define ROGUE_MMUCTRL_PT_DATA_PM_SRC_SHIFT (4U)
-#define ROGUE_MMUCTRL_PT_DATA_PM_SRC_CLRMSK (0xFFFFFFFFFFFFFFEFULL)
-#define ROGUE_MMUCTRL_PT_DATA_PM_SRC_EN (0x0000000000000010ULL)
-#define ROGUE_MMUCTRL_PT_DATA_SLC_BYPASS_CTRL_SHIFT (3U)
-#define ROGUE_MMUCTRL_PT_DATA_SLC_BYPASS_CTRL_CLRMSK (0xFFFFFFFFFFFFFFF7ULL)
-#define ROGUE_MMUCTRL_PT_DATA_SLC_BYPASS_CTRL_EN (0x0000000000000008ULL)
-#define ROGUE_MMUCTRL_PT_DATA_CC_SHIFT (2U)
-#define ROGUE_MMUCTRL_PT_DATA_CC_CLRMSK (0xFFFFFFFFFFFFFFFBULL)
-#define ROGUE_MMUCTRL_PT_DATA_CC_EN (0x0000000000000004ULL)
-#define ROGUE_MMUCTRL_PT_DATA_READ_ONLY_SHIFT (1U)
-#define ROGUE_MMUCTRL_PT_DATA_READ_ONLY_CLRMSK (0xFFFFFFFFFFFFFFFDULL)
-#define ROGUE_MMUCTRL_PT_DATA_READ_ONLY_EN (0x0000000000000002ULL)
-#define ROGUE_MMUCTRL_PT_DATA_VALID_SHIFT (0U)
-#define ROGUE_MMUCTRL_PT_DATA_VALID_CLRMSK (0xFFFFFFFFFFFFFFFEULL)
-#define ROGUE_MMUCTRL_PT_DATA_VALID_EN (0x0000000000000001ULL)
-
-#define ROGUE_MMUCTRL_PD_DATA_ENTRY_PENDING_SHIFT (40U)
-#define ROGUE_MMUCTRL_PD_DATA_ENTRY_PENDING_CLRMSK (0xFFFFFEFFFFFFFFFFULL)
-#define ROGUE_MMUCTRL_PD_DATA_ENTRY_PENDING_EN (0x0000010000000000ULL)
-#define ROGUE_MMUCTRL_PD_DATA_PT_BASE_SHIFT (5U)
-#define ROGUE_MMUCTRL_PD_DATA_PT_BASE_CLRMSK (0xFFFFFF000000001FULL)
-#define ROGUE_MMUCTRL_PD_DATA_PAGE_SIZE_SHIFT (1U)
-#define ROGUE_MMUCTRL_PD_DATA_PAGE_SIZE_CLRMSK (0xFFFFFFFFFFFFFFF1ULL)
-#define ROGUE_MMUCTRL_PD_DATA_PAGE_SIZE_4KB (0x0000000000000000ULL)
-#define ROGUE_MMUCTRL_PD_DATA_PAGE_SIZE_16KB (0x0000000000000002ULL)
-#define ROGUE_MMUCTRL_PD_DATA_PAGE_SIZE_64KB (0x0000000000000004ULL)
-#define ROGUE_MMUCTRL_PD_DATA_PAGE_SIZE_256KB (0x0000000000000006ULL)
-#define ROGUE_MMUCTRL_PD_DATA_PAGE_SIZE_1MB (0x0000000000000008ULL)
-#define ROGUE_MMUCTRL_PD_DATA_PAGE_SIZE_2MB (0x000000000000000aULL)
-#define ROGUE_MMUCTRL_PD_DATA_VALID_SHIFT (0U)
-#define ROGUE_MMUCTRL_PD_DATA_VALID_CLRMSK (0xFFFFFFFFFFFFFFFEULL)
-#define ROGUE_MMUCTRL_PD_DATA_VALID_EN (0x0000000000000001ULL)
-
-#define ROGUE_MMUCTRL_PC_DATA_PD_BASE_SHIFT (4U)
-#define ROGUE_MMUCTRL_PC_DATA_PD_BASE_CLRMSK (0x0000000FU)
-#define ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGNSHIFT (12U)
-#define ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGNSIZE (4096U)
-#define ROGUE_MMUCTRL_PC_DATA_ENTRY_PENDING_SHIFT (1U)
-#define ROGUE_MMUCTRL_PC_DATA_ENTRY_PENDING_CLRMSK (0xFFFFFFFDU)
-#define ROGUE_MMUCTRL_PC_DATA_ENTRY_PENDING_EN (0x00000002U)
-#define ROGUE_MMUCTRL_PC_DATA_VALID_SHIFT (0U)
-#define ROGUE_MMUCTRL_PC_DATA_VALID_CLRMSK (0xFFFFFFFEU)
-#define ROGUE_MMUCTRL_PC_DATA_VALID_EN (0x00000001U)
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+
+/*
+ * ROGUE_MMUCTRL - Rogue MMU Data Format
+ */
+
+/* Labelling of fields within virtual address */
+#define ROGUE_MMUCTRL_VADDR_PC_INDEX_MASK GENMASK_U64(39, 30)
+#define ROGUE_MMUCTRL_VADDR_PD_INDEX_MASK GENMASK_U64(29, 21)
+#define ROGUE_MMUCTRL_VADDR_PT_INDEX_MASK GENMASK_U64(20, 12)
+
+#define ROGUE_MMUCTRL_VADDR_PC_INDEX_SHIFT __bf_shf(ROGUE_MMUCTRL_VADDR_PC_INDEX_MASK)
+#define ROGUE_MMUCTRL_VADDR_PD_INDEX_SHIFT __bf_shf(ROGUE_MMUCTRL_VADDR_PD_INDEX_MASK)
+#define ROGUE_MMUCTRL_VADDR_PT_INDEX_SHIFT __bf_shf(ROGUE_MMUCTRL_VADDR_PT_INDEX_MASK)
+
+/* Number of entries in a PC */
+#define ROGUE_MMUCTRL_ENTRIES_PC_VALUE 1024
+
+/* Number of entries in a PD */
+#define ROGUE_MMUCTRL_ENTRIES_PD_VALUE 512
+
+/* Number of entries in a PT */
+#define ROGUE_MMUCTRL_ENTRIES_PT_VALUE 512
+
+/* Size in bits of the PC entries in memory */
+#define ROGUE_MMUCTRL_ENTRY_SIZE_PC_VALUE 32
+
+/* Size in bits of the PD entries in memory */
+#define ROGUE_MMUCTRL_ENTRY_SIZE_PD_VALUE 64
+
+/* Size in bits of the PT entries in memory */
+#define ROGUE_MMUCTRL_ENTRY_SIZE_PT_VALUE 64
+
+/* Encoding of page size field */
+enum ROGUE_MMUCTRL_PAGE_SIZE {
+	ROGUE_MMUCTRL_PAGE_SIZE_4KB = 0x0,
+	ROGUE_MMUCTRL_PAGE_SIZE_16KB = 0x1,
+	ROGUE_MMUCTRL_PAGE_SIZE_64KB = 0x2,
+	ROGUE_MMUCTRL_PAGE_SIZE_256KB = 0x3,
+	ROGUE_MMUCTRL_PAGE_SIZE_1MB = 0x4,
+	ROGUE_MMUCTRL_PAGE_SIZE_2MB = 0x5,
+};
+
+/* Range of bits used for 4KB Physical Page */
+#define ROGUE_MMUCTRL_PAGE_4KB_RANGE_MASK GENMASK_U64(39, 12)
+
+/* Range of bits used for 16KB Physical Page */
+#define ROGUE_MMUCTRL_PAGE_16KB_RANGE_MASK GENMASK_U64(39, 14)
+
+/* Range of bits used for 64KB Physical Page */
+#define ROGUE_MMUCTRL_PAGE_64KB_RANGE_MASK GENMASK_U64(39, 16)
+
+/* Range of bits used for 256KB Physical Page */
+#define ROGUE_MMUCTRL_PAGE_256KB_RANGE_MASK GENMASK_U64(39, 18)
+
+/* Range of bits used for 1MB Physical Page */
+#define ROGUE_MMUCTRL_PAGE_1MB_RANGE_MASK GENMASK_U64(39, 20)
+
+/* Range of bits used for 2MB Physical Page */
+#define ROGUE_MMUCTRL_PAGE_2MB_RANGE_MASK GENMASK_U64(39, 21)
+
+/* Range of bits used for PT Base Address for 4KB Physical Page */
+#define ROGUE_MMUCTRL_PT_BASE_4KB_RANGE_MASK GENMASK_U64(39, 12)
+
+/* Range of bits used for PT Base Address for 16KB Physical Page */
+#define ROGUE_MMUCTRL_PT_BASE_16KB_RANGE_MASK GENMASK_U64(39, 10)
+
+/* Range of bits used for PT Base Address for 64KB Physical Page */
+#define ROGUE_MMUCTRL_PT_BASE_64KB_RANGE_MASK GENMASK_U64(39, 8)
+
+/* Range of bits used for PT Base Address for 256KB Physical Page */
+#define ROGUE_MMUCTRL_PT_BASE_256KB_RANGE_MASK GENMASK_U64(39, 6)
+
+/* Range of bits used for PT Base Address for 1MB Physical Page */
+#define ROGUE_MMUCTRL_PT_BASE_1MB_RANGE_MASK GENMASK_U64(39, 5)
+
+/* Range of bits used for PT Base Address for 2MB Physical Page */
+#define ROGUE_MMUCTRL_PT_BASE_2MB_RANGE_MASK GENMASK_U64(39, 5)
+
+/* Format of Page Table data */
+#define ROGUE_MMUCTRL_PT_DATA_PM_META_PROTECT BIT_U64(62)
+#define ROGUE_MMUCTRL_PT_DATA_VP_PAGE_HI_MASK GENMASK_U64(61, 40)
+#define ROGUE_MMUCTRL_PT_DATA_PAGE_MASK GENMASK_U64(39, 12)
+#define ROGUE_MMUCTRL_PT_DATA_VP_PAGE_LO_MASK GENMASK_U64(11, 6)
+#define ROGUE_MMUCTRL_PT_DATA_ENTRY_PENDING BIT_U64(5)
+#define ROGUE_MMUCTRL_PT_DATA_PM_SRC BIT_U64(4)
+#define ROGUE_MMUCTRL_PT_DATA_SLC_BYPASS_CTRL BIT_U64(3)
+#define ROGUE_MMUCTRL_PT_DATA_CC BIT_U64(2)
+#define ROGUE_MMUCTRL_PT_DATA_READ_ONLY BIT_U64(1)
+#define ROGUE_MMUCTRL_PT_DATA_VALID BIT_U64(0)
+
+/* Format of Page Directory data */
+#define ROGUE_MMUCTRL_PD_DATA_ENTRY_PENDING BIT_U64(40)
+#define ROGUE_MMUCTRL_PD_DATA_PT_BASE_MASK GENMASK_U64(39, 5)
+#define ROGUE_MMUCTRL_PD_DATA_PAGE_SIZE_MASK GENMASK_U64(3, 1)
+#define ROGUE_MMUCTRL_PD_DATA_VALID BIT_U64(0)
+
+/* Format of Page Catalogue data */
+#define ROGUE_MMUCTRL_PC_DATA_PD_BASE_MASK GENMASK_U32(31, 4)
+#define ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGN 12
+#define ROGUE_MMUCTRL_PC_DATA_ENTRY_PENDING BIT_U32(1)
+#define ROGUE_MMUCTRL_PC_DATA_VALID BIT_U32(0)
+
+/*
+ * ROGUE_BIF_DM - Rogue BIF Datamaster Encoding
+ */
+
+/* Encoding of DM (note value 0x6 not used) */
+enum ROGUE_BIF_DM_ENCODING {
+	ROGUE_BIF_DM_ENCODING_VERTEX = 0x0,
+	ROGUE_BIF_DM_ENCODING_PIXEL = 0x1,
+	ROGUE_BIF_DM_ENCODING_COMPUTE = 0x2,
+	ROGUE_BIF_DM_ENCODING_TLA = 0x3,
+	ROGUE_BIF_DM_ENCODING_PB_VCE = 0x4,
+	ROGUE_BIF_DM_ENCODING_PB_TE = 0x5,
+	ROGUE_BIF_DM_ENCODING_META = 0x7,
+	ROGUE_BIF_DM_ENCODING_HOST = 0x8,
+	ROGUE_BIF_DM_ENCODING_PM_ALIST = 0x9,
+};
 
 #endif /* PVR_ROGUE_MMU_DEFS_H */

-- 
2.43.0

