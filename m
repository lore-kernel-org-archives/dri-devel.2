Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F7606A69A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=v8wl9xox
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F41810FBEF;
	Wed, 25 Nov 2026 11:49:41 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8630110FBE3;
 Wed, 25 Nov 2026 11:49:27 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AP7RX6I1892955; Wed, 25 Nov 2026 11:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=E
 tX8ND9Meh/kUyFsRIoVM0OVMDt3XGQx3QJmKrca9lk=; b=v8wl9xoxo1imA3q1A
 z7XjkK4PwPKGnuUPdixwl7rcTlxaGbfuV9Xj+3cUCwlwLnmLbQYj5YreP5HTxNaW
 gNeDr+MZRlaqwi/OwmeN0FhGg1GS25S0I811eu10Wam/R1oPKeWsRStzhXZnyoGf
 Hs7cmUVNc5B+hPvfFAEsWAD4uwXtj8h4JSThz6if3KWCDQI0MEMviaWE2mFm4ItZ
 0cxH+nk0IdAV9+t6SIgt5pOtCaU/S2Sew+ftPKJGpb7a6V5epikHL7bmi+EaG4zt
 QKUNHE2VVAiPLb9Jd4hptsagWr0fvwyNCvUvp2wlQ9ri2SzCDmLxVjzMPZyuaDBc
 UpR8Q==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4j32ev31p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Wed, 25 Nov 2026 11:49:05 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.203) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 11:49:03 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 25 Nov 2026 13:48:33 +0200
Subject: [PATCH 5/6] drm/imagination: Generalize FW segment loading
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261125-b4-commonize-fw-segment-loading-v1-5-69657fa52ac3@imgtec.com>
References: <20261125-b4-commonize-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com>
In-Reply-To: <20261125-b4-commonize-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-hardening@vger.kernel.org>, Alexandru Dadu
 <alexandru.dadu@imgtec.com>, Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795607333; l=35170;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=crczCPbx8R1rAVta/uTYc0p86e+qtY17umLVtiIVqM0=;
 b=aV3OhELsRC4xuYWFROBH4wt3E7T+eSPf+WhvLwV95ltk7x7mzJ6p6PdwMtT3UJuZdEP3F1c7i
 dDpBgtTBwVgCVCFX5g1T7R3vcuooYmUVdNOTKEtXh0XyX6wBQYL6tsn
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX08Js4ERDa7sX
 NBW6cuk01Q/o3whJghLNDOqCLP8ti2kmJO1WzQZHSBkhd6KhwoIcMgsZShDdz0neyDi+b5Uwa7y
 jSKNHPrsGjzOQnDZQyc8jfNviZLENdU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX3FCOTPIrdA+x
 yyXN37bECnmBu96QagfF39xGIKv4YPj+pJQvpVd/gfGh5YU/+h4SwgqLOMKg6nPuVWpDqSo7x0+
 QKQkECmxthLU5js+RbBhRCLaGmhvrsbVoHW5CVGBgqjPuZypCLZjamdajvIF/Ms+WdXfSB5D/nd
 k5111IyvMJtPveV9xs0KOVLKp11qoFwBWz5a4mF/GlpzyUYGEMmDxh5vSrUTli3KGZ3EQi6SVtg
 S8Fp+8lMN+UqIciZR5gukAMJc4ezWj2jc4UEnrTuY157KuwLlrnEZSpJUnUnB5bySMoRLi9NwGX
 IlmeL+Bxdvy7I8sxzPpmBdQ3FjropFGNsu75pQIznTzvTj6BaFvYdvD1cffVHqsVmUwGu1fYwCE
 GTDBdmTWSbqohH9JtXDRUNVoHj6M6UE/KsimaS53Fv9UZcxr0jFecSRcG/cujNutQJZs/HdVEOp
 2iNJls2fYc9GhCGfRxA==
X-Authority-Analysis: v=2.4 cv=T7AZ3PKQ c=1 sm=1 tr=0 ts=6b06cb31 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=4EFqt8Tv61wA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=TiqXqhx0olkZ1tBPAPwA:9 a=5e2WyIOXw8PF6d9t:21
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 41dhQe25m753t1ZBNUqw58wDZcB-0IIN
X-Proofpoint-ORIG-GUID: 41dhQe25m753t1ZBNUqw58wDZcB-0IIN
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Matt Coster <matt.coster@imgtec.com>

There are currently (up to) four firmware segments loaded from the file,
mostly in the same way. To reduce duplication (and make it less
error-prone to add support for new segments), replace all that with a
descriptor table and iterate over the segments everywhere instead of
copy-pasting things every time.
Add id field to struct pvr_fw_segment.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw.c       | 329 +++++++++++------------------
 drivers/gpu/drm/imagination/pvr_fw.h       |  87 +++-----
 drivers/gpu/drm/imagination/pvr_fw_meta.c  |  58 +++--
 drivers/gpu/drm/imagination/pvr_fw_mips.c  |  23 +-
 drivers/gpu/drm/imagination/pvr_fw_riscv.c |  41 ++--
 drivers/gpu/drm/imagination/pvr_fw_util.c  |  17 +-
 6 files changed, 219 insertions(+), 336 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index 4e082f83cff0..fbd46231f580 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -60,35 +60,17 @@ layout_get_sizes(struct pvr_device *pvr_dev)
 {
 	struct pvr_fw_mem *fw_mem = &pvr_dev->fw_dev.mem;
 
-	fw_mem->code_alloc_size = 0;
-	fw_mem->data_alloc_size = 0;
-	fw_mem->core_code_alloc_size = 0;
-	fw_mem->core_data_alloc_size = 0;
+	for (int seg = 0; seg < PVR_FW_SEGMENT_COUNT; seg++)
+		fw_mem->segments[seg].size = 0;
 
 	/* Extract section sizes from FW layout table. */
-	pvr_for_each_fw_section_desc(pvr_dev->fw_dev.metadata, desc) {
-		switch (desc->segment) {
-		case PVR_FW_SEGMENT_CODE:
-			fw_mem->code_alloc_size += desc->size;
-			break;
-		case PVR_FW_SEGMENT_DATA:
-			fw_mem->data_alloc_size += desc->size;
-			break;
-		case PVR_FW_SEGMENT_CORE_CODE:
-			fw_mem->core_code_alloc_size += desc->size;
-			break;
-		case PVR_FW_SEGMENT_CORE_DATA:
-			fw_mem->core_data_alloc_size += desc->size;
-			break;
-		default:
-			break;
-		}
-	}
+	pvr_for_each_fw_section_desc(pvr_dev->fw_dev.metadata, desc)
+		fw_mem->segments[desc->segment].size += desc->size;
 }
 
 int
-pvr_fw_find_mmu_segment(struct pvr_device *pvr_dev, u32 addr, u32 size, void *fw_code_ptr,
-			void *fw_data_ptr, void *fw_core_code_ptr, void *fw_core_data_ptr,
+pvr_fw_find_mmu_segment(struct pvr_device *pvr_dev, u32 addr, u32 size,
+			const struct pvr_fw_segment segments[static PVR_FW_SEGMENT_COUNT],
 			void **host_addr_out)
 {
 	u32 end_addr;
@@ -103,26 +85,8 @@ pvr_fw_find_mmu_segment(struct pvr_device *pvr_dev, u32 addr, u32 size, void *fw
 
 		if (addr >= entry_start_addr && addr < entry_end_addr &&
 		    end_addr > entry_start_addr && end_addr <= entry_end_addr) {
-			switch (desc->segment) {
-			case PVR_FW_SEGMENT_CODE:
-				*host_addr_out = fw_code_ptr;
-				break;
-
-			case PVR_FW_SEGMENT_DATA:
-				*host_addr_out = fw_data_ptr;
-				break;
-
-			case PVR_FW_SEGMENT_CORE_CODE:
-				*host_addr_out = fw_core_code_ptr;
-				break;
+			*host_addr_out = segments[desc->segment].host_copy;
 
-			case PVR_FW_SEGMENT_CORE_DATA:
-				*host_addr_out = fw_core_data_ptr;
-				break;
-
-			default:
-				return -EINVAL;
-			}
 			/* Direct Mem write to mapped memory */
 			addr -= desc->base_addr;
 			addr += desc->alloc_offset;
@@ -211,8 +175,8 @@ fw_sysinit_init(void *cpu_ptr, void *priv)
 	pvr_fw_object_get_fw_addr(fw_mem->sysdata_obj, &fwif_sysinit->fw_sys_data_fw_addr);
 	pvr_fw_object_get_fw_addr(fw_mem->gpu_util_fwcb_obj,
 				  &fwif_sysinit->gpu_util_fw_cb_ctl_fw_addr);
-	if (fw_mem->core_data_obj) {
-		pvr_fw_object_get_fw_addr(fw_mem->core_data_obj,
+	if (fw_mem->segments[PVR_FW_SEGMENT_CORE_DATA].obj) {
+		pvr_fw_object_get_fw_addr(fw_mem->segments[PVR_FW_SEGMENT_CORE_DATA].obj,
 					  &fwif_sysinit->coremem_data_store.fw_addr);
 	}
 
@@ -462,6 +426,76 @@ pvr_fw_destroy_structures(struct pvr_device *pvr_dev)
 	pvr_fw_object_destroy(fw_mem->fwif_connection_ctl_obj);
 }
 
+static void *
+pvr_fw_segment_map_standard(struct pvr_device *pvr_dev, struct pvr_fw_segment *segment,
+			    __always_unused u32 fixed_data_addr)
+{
+	return pvr_fw_object_create_and_map(pvr_dev, segment->size,
+					    PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
+					    NULL, NULL,
+					    &segment->obj);
+}
+
+static void *
+pvr_fw_segment_map_code(struct pvr_device *pvr_dev, struct pvr_fw_segment *segment,
+			__always_unused u32 fixed_data_addr)
+{
+	/*
+	 * Code allocation must be at the start of the firmware heap, otherwise
+	 * firmware processor will be unable to boot.
+	 *
+	 * This has the useful side-effect that for every other object in the
+	 * driver, a firmware address of 0 is invalid.
+	 */
+	return pvr_fw_object_create_and_map_offset(pvr_dev, 0, segment->size,
+						   PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
+						   NULL, NULL,
+						   &segment->obj);
+}
+
+static void *
+pvr_fw_segment_map_data(struct pvr_device *pvr_dev, struct pvr_fw_segment *segment,
+			u32 fixed_data_addr)
+{
+	if (pvr_dev->fw_dev.defs->has_fixed_data_addr) {
+		u32 base_addr = fixed_data_addr & pvr_dev->fw_dev.fw_heap_info.offset_mask;
+
+		return pvr_fw_object_create_and_map_offset(pvr_dev, base_addr,
+							   segment->size,
+							   PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
+							   NULL, NULL,
+							   &segment->obj);
+	}
+
+	return pvr_fw_segment_map_standard(pvr_dev, segment, fixed_data_addr);
+}
+
+const struct pvr_fw_segment_desc pvr_fw_segment_descs[PVR_FW_SEGMENT_COUNT] = {
+	[PVR_FW_SEGMENT_CODE] = { .name = "code", .required = true,
+				  .create_and_map = pvr_fw_segment_map_code },
+	[PVR_FW_SEGMENT_DATA] = { .name = "data", .required = true,
+				  .create_and_map = pvr_fw_segment_map_data },
+	[PVR_FW_SEGMENT_CORE_CODE] = { .name = "core_code", .required = false,
+				       .create_and_map = pvr_fw_segment_map_standard },
+	[PVR_FW_SEGMENT_CORE_DATA] = { .name = "core_data", .required = false,
+				       .create_and_map = pvr_fw_segment_map_standard },
+};
+
+static void
+pvr_fw_destroy_segments(struct pvr_fw_segment segments[static PVR_FW_SEGMENT_COUNT])
+{
+	for (int i = PVR_FW_SEGMENT_COUNT - 1; i >= 0; i--) {
+		struct pvr_fw_segment *segment = &segments[i];
+
+		if (segment->obj)
+			pvr_fw_object_destroy(segment->obj);
+		segment->obj = NULL;
+
+		kfree(segment->host_copy);
+		segment->host_copy = NULL;
+	}
+}
+
 /**
  * pvr_fw_process() - Process firmware image, allocate FW memory and create boot
  *                    arguments
@@ -478,13 +512,13 @@ pvr_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware)
 {
 	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
 	struct pvr_fw_mem *fw_mem = &pvr_dev->fw_dev.mem;
+	void *host_ptrs[PVR_FW_SEGMENT_COUNT] = { NULL };
 	const struct pvr_fw_section_desc *private_data;
-	u8 *fw_code_ptr;
-	u8 *fw_data_ptr;
-	u8 *fw_core_code_ptr;
-	u8 *fw_core_data_ptr;
 	int err;
 
+	for (int seg = 0; seg < PVR_FW_SEGMENT_COUNT; seg++)
+		fw_mem->segments[seg].id = seg;
+
 	layout_get_sizes(pvr_dev);
 
 	private_data = pvr_fw_get_section_desc(pvr_dev, PVR_FW_SECTION_PRIVATE_DATA);
@@ -492,142 +526,58 @@ pvr_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware)
 		return -EINVAL;
 
 	/* Allocate and map memory for firmware sections. */
+	for (int seg = 0; seg < PVR_FW_SEGMENT_COUNT; seg++) {
+		const struct pvr_fw_segment_desc *desc = &pvr_fw_segment_descs[seg];
+		struct pvr_fw_segment *segment = &fw_mem->segments[seg];
+		void *host_ptr;
+
+		if (!segment->size) {
+			if (desc->required) {
+				drm_err(drm_dev, "Required FW segment '%s' is empty\n", desc->name);
+				err = -EINVAL;
+				goto err_out;
+			}
 
-	/*
-	 * Code allocation must be at the start of the firmware heap, otherwise
-	 * firmware processor will be unable to boot.
-	 *
-	 * This has the useful side-effect that for every other object in the
-	 * driver, a firmware address of 0 is invalid.
-	 */
-	fw_code_ptr = pvr_fw_object_create_and_map_offset(pvr_dev, 0, fw_mem->code_alloc_size,
-							  PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
-							  NULL, NULL, &fw_mem->code_obj);
-	if (IS_ERR(fw_code_ptr)) {
-		drm_err(drm_dev, "Unable to allocate FW code memory\n");
-		return PTR_ERR(fw_code_ptr);
-	}
-
-	if (pvr_dev->fw_dev.defs->has_fixed_data_addr) {
-		u32 base_addr = private_data->base_addr & pvr_dev->fw_dev.fw_heap_info.offset_mask;
-
-		fw_data_ptr =
-			pvr_fw_object_create_and_map_offset(pvr_dev, base_addr,
-							    fw_mem->data_alloc_size,
-							    PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
-							    NULL, NULL, &fw_mem->data_obj);
-	} else {
-		fw_data_ptr = pvr_fw_object_create_and_map(pvr_dev, fw_mem->data_alloc_size,
-							   PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
-							   NULL, NULL, &fw_mem->data_obj);
-	}
-	if (IS_ERR(fw_data_ptr)) {
-		drm_err(drm_dev, "Unable to allocate FW data memory\n");
-		err = PTR_ERR(fw_data_ptr);
-		goto err_free_fw_code_obj;
-	}
+			continue;
+		}
 
-	/* Core code and data sections are optional. */
-	if (fw_mem->core_code_alloc_size) {
-		fw_core_code_ptr =
-			pvr_fw_object_create_and_map(pvr_dev, fw_mem->core_code_alloc_size,
-						     PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
-						     NULL, NULL, &fw_mem->core_code_obj);
-		if (IS_ERR(fw_core_code_ptr)) {
-			drm_err(drm_dev,
-				"Unable to allocate FW core code memory\n");
-			err = PTR_ERR(fw_core_code_ptr);
-			goto err_free_fw_data_obj;
+		segment->host_copy = kzalloc(segment->size, GFP_KERNEL);
+		if (!segment->host_copy) {
+			err = -ENOMEM;
+			goto err_out;
 		}
-	} else {
-		fw_core_code_ptr = NULL;
-	}
 
-	if (fw_mem->core_data_alloc_size) {
-		fw_core_data_ptr =
-			pvr_fw_object_create_and_map(pvr_dev, fw_mem->core_data_alloc_size,
-						     PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
-						     NULL, NULL, &fw_mem->core_data_obj);
-		if (IS_ERR(fw_core_data_ptr)) {
-			drm_err(drm_dev,
-				"Unable to allocate FW core data memory\n");
-			err = PTR_ERR(fw_core_data_ptr);
-			goto err_free_fw_core_code_obj;
+		host_ptr = desc->create_and_map(pvr_dev, segment, private_data->base_addr);
+		if (IS_ERR(host_ptr)) {
+			drm_err(drm_dev, "Failed to allocate FW memory for segment '%s'\n",
+				desc->name);
+			err = PTR_ERR(host_ptr);
+			goto err_out;
 		}
-	} else {
-		fw_core_data_ptr = NULL;
-	}
 
-	fw_mem->code = kzalloc(fw_mem->code_alloc_size, GFP_KERNEL);
-	fw_mem->data = kzalloc(fw_mem->data_alloc_size, GFP_KERNEL);
-	if (fw_mem->core_code_alloc_size)
-		fw_mem->core_code = kzalloc(fw_mem->core_code_alloc_size, GFP_KERNEL);
-	if (fw_mem->core_data_alloc_size)
-		fw_mem->core_data = kzalloc(fw_mem->core_data_alloc_size, GFP_KERNEL);
-
-	if (!fw_mem->code || !fw_mem->data ||
-	    (!fw_mem->core_code && fw_mem->core_code_alloc_size) ||
-	    (!fw_mem->core_data && fw_mem->core_data_alloc_size)) {
-		err = -ENOMEM;
-		goto err_free_kdata;
+		host_ptrs[seg] = host_ptr;
 	}
 
-	err = pvr_dev->fw_dev.defs->fw_process(pvr_dev, firmware,
-					       fw_mem->code, fw_mem->data, fw_mem->core_code,
-					       fw_mem->core_data, fw_mem->core_code_alloc_size);
-
+	err = pvr_dev->fw_dev.defs->fw_process(pvr_dev, firmware, fw_mem->segments);
 	if (err)
-		goto err_free_kdata;
-
-	memcpy(fw_code_ptr, fw_mem->code, fw_mem->code_alloc_size);
-	memcpy(fw_data_ptr, fw_mem->data, fw_mem->data_alloc_size);
-	if (fw_mem->core_code)
-		memcpy(fw_core_code_ptr, fw_mem->core_code, fw_mem->core_code_alloc_size);
-	if (fw_mem->core_data)
-		memcpy(fw_core_data_ptr, fw_mem->core_data, fw_mem->core_data_alloc_size);
-
-	/* We're finished with the firmware section memory on the CPU, unmap. */
-	if (fw_core_data_ptr) {
-		pvr_fw_object_vunmap(fw_mem->core_data_obj);
-		fw_core_data_ptr = NULL;
-	}
-	if (fw_core_code_ptr) {
-		pvr_fw_object_vunmap(fw_mem->core_code_obj);
-		fw_core_code_ptr = NULL;
+		goto err_out;
+
+	for (int seg = 0; seg < PVR_FW_SEGMENT_COUNT; seg++) {
+		const struct pvr_fw_segment *segment = &fw_mem->segments[seg];
+
+		if (!segment->obj)
+			continue;
+
+		memcpy(host_ptrs[seg], segment->host_copy, segment->size);
+
+		host_ptrs[seg] = NULL;
+		pvr_fw_object_vunmap(segment->obj);
 	}
-	pvr_fw_object_vunmap(fw_mem->data_obj);
-	fw_data_ptr = NULL;
-	pvr_fw_object_vunmap(fw_mem->code_obj);
-	fw_code_ptr = NULL;
 
 	return 0;
 
-err_free_kdata:
-	kfree(fw_mem->core_data);
-	kfree(fw_mem->core_code);
-	kfree(fw_mem->data);
-	kfree(fw_mem->code);
-
-	if (fw_core_data_ptr)
-		pvr_fw_object_vunmap(fw_mem->core_data_obj);
-	if (fw_mem->core_data_obj)
-		pvr_fw_object_destroy(fw_mem->core_data_obj);
-
-err_free_fw_core_code_obj:
-	if (fw_core_code_ptr)
-		pvr_fw_object_vunmap(fw_mem->core_code_obj);
-	if (fw_mem->core_code_obj)
-		pvr_fw_object_destroy(fw_mem->core_code_obj);
-
-err_free_fw_data_obj:
-	if (fw_data_ptr)
-		pvr_fw_object_vunmap(fw_mem->data_obj);
-	pvr_fw_object_destroy(fw_mem->data_obj);
-
-err_free_fw_code_obj:
-	if (fw_code_ptr)
-		pvr_fw_object_vunmap(fw_mem->code_obj);
-	pvr_fw_object_destroy(fw_mem->code_obj);
+err_out:
+	pvr_fw_destroy_segments(fw_mem->segments);
 
 	return err;
 }
@@ -653,24 +603,13 @@ pvr_fw_reinit_code_data(struct pvr_device *pvr_dev)
 	struct pvr_fw_mem *fw_mem = &pvr_dev->fw_dev.mem;
 	int err;
 
-	err = pvr_copy_to_fw(fw_mem->code_obj, fw_mem->code, fw_mem->code_alloc_size);
-	if (err)
-		return err;
+	for (int seg = 0; seg < PVR_FW_SEGMENT_COUNT; seg++) {
+		auto segment = &fw_mem->segments[seg];
 
-	err = pvr_copy_to_fw(fw_mem->data_obj, fw_mem->data, fw_mem->data_alloc_size);
-	if (err)
-		return err;
+		if (!segment->obj)
+			continue;
 
-	if (fw_mem->core_code) {
-		err = pvr_copy_to_fw(fw_mem->core_code_obj, fw_mem->core_code,
-				     fw_mem->core_code_alloc_size);
-		if (err)
-			return err;
-	}
-
-	if (fw_mem->core_data) {
-		err = pvr_copy_to_fw(fw_mem->core_data_obj, fw_mem->core_data,
-				     fw_mem->core_data_alloc_size);
+		err = pvr_copy_to_fw(segment->obj, segment->host_copy, segment->size);
 		if (err)
 			return err;
 	}
@@ -681,19 +620,7 @@ pvr_fw_reinit_code_data(struct pvr_device *pvr_dev)
 static void
 pvr_fw_cleanup(struct pvr_device *pvr_dev)
 {
-	struct pvr_fw_mem *fw_mem = &pvr_dev->fw_dev.mem;
-
-	kfree(fw_mem->core_data);
-	kfree(fw_mem->core_code);
-	kfree(fw_mem->data);
-	kfree(fw_mem->code);
-
-	if (fw_mem->core_code_obj)
-		pvr_fw_object_destroy(fw_mem->core_code_obj);
-	if (fw_mem->core_data_obj)
-		pvr_fw_object_destroy(fw_mem->core_data_obj);
-	pvr_fw_object_destroy(fw_mem->code_obj);
-	pvr_fw_object_destroy(fw_mem->data_obj);
+	pvr_fw_destroy_segments(pvr_dev->fw_dev.mem.segments);
 }
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index 45b38d9072a1..15e0cbe71a34 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -9,6 +9,7 @@
 
 #include <drm/drm_mm.h>
 
+#include <linux/array_size.h>
 #include <linux/types.h>
 
 /* Forward declarations from "pvr_device.h". */
@@ -136,6 +137,23 @@ struct pvr_fw_metadata {
 	struct pvr_fw_section_desc sections[] __counted_by(num_sections);
 };
 
+struct pvr_fw_segment {
+	enum pvr_fw_segment_name id;
+	u32 size;
+	struct pvr_fw_object *obj;
+	void *host_copy;
+};
+
+struct pvr_fw_segment_desc {
+	const char *name;
+	bool required;
+	void *(*create_and_map)(struct pvr_device *pvr_dev,
+				struct pvr_fw_segment *segment,
+				u32 fixed_data_addr);
+};
+
+extern const struct pvr_fw_segment_desc pvr_fw_segment_descs[PVR_FW_SEGMENT_COUNT];
+
 /**
  * struct pvr_fw_defs - FW processor function table and static definitions
  */
@@ -173,11 +191,8 @@ struct pvr_fw_defs {
 	 * Load and process firmware image.
 	 * @pvr_dev: Target PowerVR device.
 	 * @firmware: Pointer to firmware image.
-	 * @fw_code_ptr: Pointer to firmware code section.
-	 * @fw_data_ptr: Pointer to firmware data section.
-	 * @fw_core_code_ptr: Pointer to firmware core code section. May be %NULL.
-	 * @fw_core_data_ptr: Pointer to firmware core data section. May be %NULL.
-	 * @core_code_alloc_size: Total allocation size of core code section.
+	 * @segments: Firmware segments, includes host pointers for populating
+	 * and firmware objects for reference.
 	 *
 	 * This function is mandatory.
 	 *
@@ -186,8 +201,7 @@ struct pvr_fw_defs {
 	 *  * Any appropriate error on failure.
 	 */
 	int (*fw_process)(struct pvr_device *pvr_dev, const struct firmware *firmware,
-			  u8 *fw_code_ptr, u8 *fw_data_ptr, u8 *fw_core_code_ptr,
-			  u8 *fw_core_data_ptr, u32 core_code_alloc_size);
+			  const struct pvr_fw_segment segments[static PVR_FW_SEGMENT_COUNT]);
 
 	/**
 	 * @vm_map:
@@ -274,53 +288,8 @@ struct pvr_fw_defs {
  * struct pvr_fw_mem - FW memory allocations
  */
 struct pvr_fw_mem {
-	/** @code_obj: Object representing firmware code. */
-	struct pvr_fw_object *code_obj;
-
-	/** @data_obj: Object representing firmware data. */
-	struct pvr_fw_object *data_obj;
-
-	/**
-	 * @core_code_obj: Object representing firmware core code. May be
-	 *                 %NULL if firmware does not contain this section.
-	 */
-	struct pvr_fw_object *core_code_obj;
-
-	/**
-	 * @core_data_obj: Object representing firmware core data. May be
-	 *                 %NULL if firmware does not contain this section.
-	 */
-	struct pvr_fw_object *core_data_obj;
-
-	/** @code: Driver-side copy of firmware code. */
-	u8 *code;
-
-	/** @data: Driver-side copy of firmware data. */
-	u8 *data;
-
-	/**
-	 * @core_code: Driver-side copy of firmware core code. May be %NULL if firmware does not
-	 *             contain this section.
-	 */
-	u8 *core_code;
-
-	/**
-	 * @core_data: Driver-side copy of firmware core data. May be %NULL if firmware does not
-	 *             contain this section.
-	 */
-	u8 *core_data;
-
-	/** @code_alloc_size: Allocation size of firmware code section. */
-	u32 code_alloc_size;
-
-	/** @data_alloc_size: Allocation size of firmware data section. */
-	u32 data_alloc_size;
-
-	/** @core_code_alloc_size: Allocation size of firmware core code section. */
-	u32 core_code_alloc_size;
-
-	/** @core_data_alloc_size: Allocation size of firmware core data section. */
-	u32 core_data_alloc_size;
+	/** @segments: Firmware segments loaded from file. */
+	struct pvr_fw_segment segments[PVR_FW_SEGMENT_COUNT];
 
 	/**
 	 * @fwif_connection_ctl_obj: Object representing FWIF connection control
@@ -472,8 +441,8 @@ pvr_fw_heap_info_init(struct pvr_device *pvr_dev, u32 log2_size, u32 reserved_si
 const struct pvr_fw_section_desc *
 pvr_fw_get_section_desc(struct pvr_device *pvr_dev, enum pvr_fw_section_name section);
 int
-pvr_fw_find_mmu_segment(struct pvr_device *pvr_dev, u32 addr, u32 size, void *fw_code_ptr,
-			void *fw_data_ptr, void *fw_core_code_ptr, void *fw_core_data_ptr,
+pvr_fw_find_mmu_segment(struct pvr_device *pvr_dev, u32 addr, u32 size,
+			const struct pvr_fw_segment segments[static PVR_FW_SEGMENT_COUNT],
 			void **host_addr_out);
 
 int
@@ -565,9 +534,9 @@ int pvr_fw_load_metadata_and_device_info(struct pvr_device *pvr_dev,
 void pvr_fw_free_metadata_and_device_info(struct pvr_device *pvr_dev);
 
 /* Util functions defined in pvr_fw_util.c. These are intended for use in pvr_fw_<arch>.c files. */
-int
-pvr_fw_process_elf_command_stream(struct pvr_device *pvr_dev, const u8 *fw, u8 *fw_code_ptr,
-				  u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr);
+int pvr_fw_process_elf_command_stream(
+	struct pvr_device *pvr_dev, const u8 *fw,
+	const struct pvr_fw_segment segments[static PVR_FW_SEGMENT_COUNT]);
 
 int
 pvr_fw_info_get(const struct pvr_device *pvr_dev, struct drm_pvr_ioctl_dev_query_args *args);
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 8b231df27a60..53143a6ad2ca 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -105,8 +105,9 @@ add_boot_arg(u32 **boot_conf, u32 param, u32 data)
 
 static int
 meta_ldr_cmd_loadmem(struct drm_device *drm_dev, const u8 *fw,
-		     struct rogue_meta_ldr_l1_data_blk *l1_data, u32 coremem_size, u8 *fw_code_ptr,
-		     u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr, const u32 fw_size)
+		     struct rogue_meta_ldr_l1_data_blk *l1_data, u32 coremem_size,
+		     const struct pvr_fw_segment segments[static PVR_FW_SEGMENT_COUNT],
+		     const u32 fw_size)
 {
 	struct rogue_meta_ldr_l2_data_blk *l2_block =
 		(struct rogue_meta_ldr_l2_data_blk *)(fw +
@@ -134,8 +135,7 @@ meta_ldr_cmd_loadmem(struct drm_device *drm_dev, const u8 *fw,
 		offset &= ~META_MEM_GLOBAL_RANGE_BIT;
 	}
 
-	err = pvr_fw_find_mmu_segment(pvr_dev, offset, data_size, fw_code_ptr, fw_data_ptr,
-				      fw_core_code_ptr, fw_core_data_ptr, &write_addr);
+	err = pvr_fw_find_mmu_segment(pvr_dev, offset, data_size, segments, &write_addr);
 	if (err) {
 		drm_err(drm_dev,
 			"Addr 0x%x (size: %d) not found in any firmware segment",
@@ -151,7 +151,7 @@ meta_ldr_cmd_loadmem(struct drm_device *drm_dev, const u8 *fw,
 static int
 meta_ldr_cmd_zeromem(struct drm_device *drm_dev,
 		     struct rogue_meta_ldr_l1_data_blk *l1_data, u32 coremem_size,
-		     u8 *fw_code_ptr, u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr)
+		     const struct pvr_fw_segment segments[static PVR_FW_SEGMENT_COUNT])
 {
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
 	u32 offset = l1_data->cmd_data[0];
@@ -167,8 +167,7 @@ meta_ldr_cmd_zeromem(struct drm_device *drm_dev,
 	/* Global range is aliased to local range */
 	offset &= ~META_MEM_GLOBAL_RANGE_BIT;
 
-	err = pvr_fw_find_mmu_segment(pvr_dev, offset, byte_count, fw_code_ptr, fw_data_ptr,
-				      fw_core_code_ptr, fw_core_data_ptr, &write_addr);
+	err = pvr_fw_find_mmu_segment(pvr_dev, offset, byte_count, segments, &write_addr);
 	if (err) {
 		drm_err(drm_dev,
 			"Addr 0x%x (size: %d) not found in any firmware segment",
@@ -240,10 +239,8 @@ meta_ldr_cmd_config(struct drm_device *drm_dev, const u8 *fw,
  *                                firmware sections
  * @pvr_dev: Device pointer.
  * @firmware: Pointer to firmware image.
- * @fw_code_ptr: Pointer to FW code section.
- * @fw_data_ptr: Pointer to FW data section.
- * @fw_core_code_ptr: Pointer to FW coremem code section.
- * @fw_core_data_ptr: Pointer to FW coremem data section.
+ * @segments: Firmware segments, includes host pointers for populating and
+ * firmware objects for reference.
  * @boot_conf_ptr: Pointer to boot config argument pointer.
  *
  * Returns :
@@ -252,9 +249,9 @@ meta_ldr_cmd_config(struct drm_device *drm_dev, const u8 *fw,
  */
 static int
 process_ldr_command_stream(struct pvr_device *pvr_dev,
-			   const struct firmware *firmware, u8 *fw_code_ptr,
-			   u8 *fw_data_ptr, u8 *fw_core_code_ptr,
-			   u8 *fw_core_data_ptr, u32 **boot_conf_ptr)
+			   const struct firmware *firmware,
+			   const struct pvr_fw_segment segments[static PVR_FW_SEGMENT_COUNT],
+			   u32 **boot_conf_ptr)
 {
 	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
 	const u8 *fw = firmware->data;
@@ -287,10 +284,8 @@ process_ldr_command_stream(struct pvr_device *pvr_dev,
 		switch (l1_data->cmd & ROGUE_META_LDR_CMD_MASK)
 		case ROGUE_META_LDR_CMD_LOADMEM: {
 			err = meta_ldr_cmd_loadmem(drm_dev, fw, l1_data,
-						   coremem_size,
-						   fw_code_ptr, fw_data_ptr,
-						   fw_core_code_ptr,
-						   fw_core_data_ptr, fw_size);
+						   coremem_size, segments,
+						   fw_size);
 			if (err)
 				return err;
 			break;
@@ -301,10 +296,7 @@ process_ldr_command_stream(struct pvr_device *pvr_dev,
 
 		case ROGUE_META_LDR_CMD_ZEROMEM:
 			err = meta_ldr_cmd_zeromem(drm_dev, l1_data,
-						   coremem_size,
-						   fw_code_ptr, fw_data_ptr,
-						   fw_core_code_ptr,
-						   fw_core_data_ptr);
+						   coremem_size, segments);
 			if (err)
 				return err;
 			break;
@@ -361,6 +353,8 @@ configure_seg_id(u64 seg_out_addr, u32 seg_base, u32 seg_limit, u32 seg_id,
 static void
 configure_seg_mmu(struct pvr_device *pvr_dev, u32 **boot_conf_ptr)
 {
+	u64 data_seg_gpu_addr =
+		pvr_fw_obj_get_gpu_addr(pvr_dev->fw_dev.mem.segments[PVR_FW_SEGMENT_DATA].obj);
 	u64 seg_out_addr_top =
 		ROGUE_FW_SEGMMU_OUTADDR_TOP_SLC(MMU_CONTEXT_MAPPING_FWPRIV,
 						ROGUE_FW_SEGMMU_META_BIFDM_ID);
@@ -373,7 +367,7 @@ configure_seg_mmu(struct pvr_device *pvr_dev, u32 **boot_conf_ptr)
 		 */
 		if (desc->segment == PVR_FW_SEGMENT_DATA) {
 			u32 seg_id = ROGUE_FW_SEGMMU_DATA_ID;
-			u64 seg_out_addr = pvr_fw_obj_get_gpu_addr(pvr_dev->fw_dev.mem.data_obj);
+			u64 seg_out_addr = data_seg_gpu_addr;
 
 			seg_out_addr += desc->alloc_offset;
 			seg_out_addr |= seg_out_addr_top;
@@ -441,14 +435,13 @@ configure_meta_caches(u32 **boot_conf_ptr)
 
 static int
 pvr_meta_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware,
-		    u8 *fw_code_ptr, u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr,
-		    u32 core_code_alloc_size)
+		    const struct pvr_fw_segment segments[static PVR_FW_SEGMENT_COUNT])
 {
-	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
+	const struct pvr_fw_segment *core_code_seg;
 	u32 *boot_conf;
 	int err;
 
-	boot_conf = ((u32 *)fw_code_ptr) + ROGUE_FW_BOOTLDR_CONF_OFFSET;
+	boot_conf = (u32 *)segments[PVR_FW_SEGMENT_CODE].host_copy + ROGUE_FW_BOOTLDR_CONF_OFFSET;
 
 	/* Slave port and JTAG accesses are privileged. */
 	add_boot_arg(&boot_conf, META_CR_SYSC_JTAG_THREAD,
@@ -457,9 +450,7 @@ pvr_meta_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware,
 	configure_seg_mmu(pvr_dev, &boot_conf);
 
 	/* Populate FW sections from LDR image. */
-	err = process_ldr_command_stream(pvr_dev, firmware, fw_code_ptr,
-					 fw_data_ptr, fw_core_code_ptr,
-					 fw_core_data_ptr, &boot_conf);
+	err = process_ldr_command_stream(pvr_dev, firmware, segments, &boot_conf);
 	if (err)
 		return err;
 
@@ -468,11 +459,12 @@ pvr_meta_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware,
 	/* End argument list. */
 	add_boot_arg(&boot_conf, 0, 0);
 
-	if (fw_dev->mem.core_code_obj) {
+	core_code_seg = &segments[PVR_FW_SEGMENT_CORE_CODE];
+	if (core_code_seg->obj) {
 		u32 core_code_fw_addr;
 
-		pvr_fw_object_get_fw_addr(fw_dev->mem.core_code_obj, &core_code_fw_addr);
-		add_boot_arg(&boot_conf, core_code_fw_addr, core_code_alloc_size);
+		pvr_fw_object_get_fw_addr(core_code_seg->obj, &core_code_fw_addr);
+		add_boot_arg(&boot_conf, core_code_fw_addr, core_code_seg->size);
 	} else {
 		add_boot_arg(&boot_conf, 0, 0);
 	}
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.c b/drivers/gpu/drm/imagination/pvr_fw_mips.c
index db89a9bc50a9..a7ae45db5515 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips.c
@@ -32,11 +32,11 @@ pvr_mips_fini(struct pvr_device *pvr_dev)
 
 static int
 pvr_mips_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware,
-		    u8 *fw_code_ptr, u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr,
-		    u32 core_code_alloc_size)
+		    const struct pvr_fw_segment segments[static PVR_FW_SEGMENT_COUNT])
 {
-	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
-	struct pvr_fw_mips_data *fw_data = fw_dev->processor_data.mips_data;
+	struct pvr_fw_mips_data *fw_data = pvr_dev->fw_dev.processor_data.mips_data;
+	struct pvr_fw_object *code_obj = segments[PVR_FW_SEGMENT_CODE].obj;
+	struct pvr_fw_object *data_obj = segments[PVR_FW_SEGMENT_DATA].obj;
 	const struct pvr_fw_section_desc *boot_code_entry;
 	const struct pvr_fw_section_desc *boot_data_entry;
 	const struct pvr_fw_section_desc *exception_code_entry;
@@ -45,8 +45,7 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware,
 	dma_addr_t dma_addr;
 	int err;
 
-	err = pvr_fw_process_elf_command_stream(pvr_dev, firmware->data, fw_code_ptr, fw_data_ptr,
-						fw_core_code_ptr, fw_core_data_ptr);
+	err = pvr_fw_process_elf_command_stream(pvr_dev, firmware->data, segments);
 	if (err)
 		return err;
 
@@ -56,22 +55,22 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware,
 	if (!boot_code_entry || !boot_data_entry || !exception_code_entry)
 		return -EINVAL;
 
-	WARN_ON(pvr_gem_get_dma_addr(fw_dev->mem.code_obj->gem, boot_code_entry->alloc_offset,
+	WARN_ON(pvr_gem_get_dma_addr(code_obj->gem, boot_code_entry->alloc_offset,
 				     &fw_data->boot_code_dma_addr));
-	WARN_ON(pvr_gem_get_dma_addr(fw_dev->mem.data_obj->gem, boot_data_entry->alloc_offset,
+	WARN_ON(pvr_gem_get_dma_addr(data_obj->gem, boot_data_entry->alloc_offset,
 				     &fw_data->boot_data_dma_addr));
-	WARN_ON(pvr_gem_get_dma_addr(fw_dev->mem.code_obj->gem,
-				     exception_code_entry->alloc_offset,
+	WARN_ON(pvr_gem_get_dma_addr(code_obj->gem, exception_code_entry->alloc_offset,
 				     &fw_data->exception_code_dma_addr));
 
 	stack_entry = pvr_fw_get_section_desc(pvr_dev, PVR_FW_SECTION_STACK);
 	if (!stack_entry)
 		return -EINVAL;
 
-	boot_data = (struct rogue_mipsfw_boot_data *)(fw_data_ptr + boot_data_entry->alloc_offset +
+	boot_data = (struct rogue_mipsfw_boot_data *)(segments[PVR_FW_SEGMENT_DATA].host_copy +
+						      boot_data_entry->alloc_offset +
 						      ROGUE_MIPSFW_BOOTLDR_CONF_OFFSET);
 
-	WARN_ON(pvr_fw_object_get_dma_addr(fw_dev->mem.data_obj, stack_entry->alloc_offset,
+	WARN_ON(pvr_fw_object_get_dma_addr(data_obj, stack_entry->alloc_offset,
 					   &dma_addr));
 	boot_data->stack_phys_addr = dma_addr;
 
diff --git a/drivers/gpu/drm/imagination/pvr_fw_riscv.c b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
index a88a2b87f61e..c983c9d8a24f 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_riscv.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
@@ -21,6 +21,8 @@
 static int
 pvr_riscv_wrapper_init(struct pvr_device *pvr_dev)
 {
+	struct pvr_fw_mem *fw_mem = &pvr_dev->fw_dev.mem;
+
 	const u64 common_opts =
 		((u64)(ROGUE_FW_HEAP_RISCV_SIZE
 		       >> ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_SIZE_ALIGNSHIFT)
@@ -28,8 +30,8 @@ pvr_riscv_wrapper_init(struct pvr_device *pvr_dev)
 		((u64)MMU_CONTEXT_MAPPING_FWPRIV
 		 << ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_CBASE_SHIFT);
 
-	u64 code_addr = pvr_fw_obj_get_gpu_addr(pvr_dev->fw_dev.mem.code_obj);
-	u64 data_addr = pvr_fw_obj_get_gpu_addr(pvr_dev->fw_dev.mem.data_obj);
+	u64 code_addr = pvr_fw_obj_get_gpu_addr(fw_mem->segments[PVR_FW_SEGMENT_CODE].obj);
+	u64 data_addr = pvr_fw_obj_get_gpu_addr(fw_mem->segments[PVR_FW_SEGMENT_DATA].obj);
 
 	/* This condition allows us to OR the addresses into the register directly. */
 	static_assert(ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_DEVVADDR_SHIFT ==
@@ -70,37 +72,34 @@ struct rogue_riscv_fw_boot_data {
 
 static int
 pvr_riscv_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware,
-		     u8 *fw_code_ptr, u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr,
-		     u32 core_code_alloc_size)
+		     const struct pvr_fw_segment segments[static PVR_FW_SEGMENT_COUNT])
 {
-	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
-	struct pvr_fw_mem *fw_mem = &fw_dev->mem;
 	struct rogue_riscv_fw_boot_data *boot_data;
+	struct pvr_fw_object *core_code_obj;
+	struct pvr_fw_object *core_data_obj;
 	int err;
 
-	err = pvr_fw_process_elf_command_stream(pvr_dev, firmware->data, fw_code_ptr, fw_data_ptr,
-						fw_core_code_ptr, fw_core_data_ptr);
+	err = pvr_fw_process_elf_command_stream(pvr_dev, firmware->data, segments);
 	if (err)
-		goto err_out;
+		return err;
 
-	boot_data = (struct rogue_riscv_fw_boot_data *)fw_data_ptr;
+	boot_data = segments[PVR_FW_SEGMENT_DATA].host_copy;
 
-	if (fw_mem->core_code_obj) {
-		boot_data->coremem_code_dev_vaddr = pvr_fw_obj_get_gpu_addr(fw_mem->core_code_obj);
-		pvr_fw_object_get_fw_addr(fw_mem->core_code_obj, &boot_data->coremem_code_fw_addr);
-		boot_data->coremem_code_size = pvr_fw_obj_get_object_size(fw_mem->core_code_obj);
+	core_code_obj = segments[PVR_FW_SEGMENT_CORE_CODE].obj;
+	if (core_code_obj) {
+		boot_data->coremem_code_dev_vaddr = pvr_fw_obj_get_gpu_addr(core_code_obj);
+		pvr_fw_object_get_fw_addr(core_code_obj, &boot_data->coremem_code_fw_addr);
+		boot_data->coremem_code_size = pvr_fw_obj_get_object_size(core_code_obj);
 	}
 
-	if (fw_mem->core_data_obj) {
-		boot_data->coremem_data_dev_vaddr = pvr_fw_obj_get_gpu_addr(fw_mem->core_data_obj);
-		pvr_fw_object_get_fw_addr(fw_mem->core_data_obj, &boot_data->coremem_data_fw_addr);
-		boot_data->coremem_data_size = pvr_fw_obj_get_object_size(fw_mem->core_data_obj);
+	core_data_obj = segments[PVR_FW_SEGMENT_CORE_DATA].obj;
+	if (core_data_obj) {
+		boot_data->coremem_data_dev_vaddr = pvr_fw_obj_get_gpu_addr(core_data_obj);
+		pvr_fw_object_get_fw_addr(core_data_obj, &boot_data->coremem_data_fw_addr);
+		boot_data->coremem_data_size = pvr_fw_obj_get_object_size(core_data_obj);
 	}
 
 	return 0;
-
-err_out:
-	return err;
 }
 
 static int
diff --git a/drivers/gpu/drm/imagination/pvr_fw_util.c b/drivers/gpu/drm/imagination/pvr_fw_util.c
index 377fe72d86b8..0396b2aa111f 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_util.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_util.c
@@ -16,19 +16,16 @@
  *                                       firmware sections
  * @pvr_dev: Device pointer.
  * @fw: Pointer to firmware image.
- * @fw_code_ptr: Pointer to FW code section.
- * @fw_data_ptr: Pointer to FW data section.
- * @fw_core_code_ptr: Pointer to FW coremem code section.
- * @fw_core_data_ptr: Pointer to FW coremem data section.
+ * @segments: Firmware segments, includes host pointers for populating and
+ * firmware objects for reference.
  *
- * Returns :
+ * Returns:
  *  * 0 on success, or
- *  * -EINVAL on any error in ELF command stream.
+ *  * -%EINVAL on any error in ELF command stream.
  */
 int
 pvr_fw_process_elf_command_stream(struct pvr_device *pvr_dev, const u8 *fw,
-				  u8 *fw_code_ptr, u8 *fw_data_ptr,
-				  u8 *fw_core_code_ptr, u8 *fw_core_data_ptr)
+				  const struct pvr_fw_segment segments[static PVR_FW_SEGMENT_COUNT])
 {
 	struct elf32_hdr *header = (struct elf32_hdr *)fw;
 	struct elf32_phdr *program_header = (struct elf32_phdr *)(fw + header->e_phoff);
@@ -43,8 +40,8 @@ pvr_fw_process_elf_command_stream(struct pvr_device *pvr_dev, const u8 *fw,
 			continue;
 
 		err = pvr_fw_find_mmu_segment(pvr_dev, program_header->p_vaddr,
-					      program_header->p_memsz, fw_code_ptr, fw_data_ptr,
-					      fw_core_code_ptr, fw_core_data_ptr, &write_addr);
+					      program_header->p_memsz, segments,
+					      &write_addr);
 		if (err) {
 			drm_err(drm_dev,
 				"Addr 0x%x (size: %d) not found in any firmware segment",

-- 
2.43.0

