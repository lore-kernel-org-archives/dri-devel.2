Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA394606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=UJRWyZmD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2515110FF91;
	Thu, 29 Oct 2026 06:30:17 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE7110FF8A;
 Thu, 29 Oct 2026 06:30:04 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5GIhQ1829611; Thu, 29 Oct 2026 06:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=P
 ZllIWeHsqBp4MAjcIgn670kTwuCocp2MlL9zVvSzVk=; b=UJRWyZmDSQ7swLjqw
 TwQ7+y1PsnT8uFzOOCb6MTcSG9vGY00EtF1akpuWmIU5Wh7dmxZqHpClfGwhPgau
 MF1+Zco9/w2y04FdRFRBR6Yu3kI6g8+tfUZQcPETGriQjkUnal9OjPo17or4cP9+
 ocDOFtwep4n8k4YgsdTXkeSF1r5op4xQgUNptj3cPz24afmc0HFxWPAd7tyzVq/Y
 ibHk8Ospt69pd0mIzIbaQT7nazQK4QKwG4sBwWCNItNUg5KpeTLHGk+5+fvffQ7f
 MUiJHvGXAgpmk9Fshj3gdDgMq7mkUw8ykFkHGaQp30XrcAbQ3/ovIYDbHlDq2AuH
 NAkbA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hkvbj85aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 06:29:49 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 06:29:47 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Thu, 29 Oct 2026 08:29:26 +0200
Subject: [PATCH v2 5/5] drm/imagination: Make the META firmware header
 arch-independent
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261029-prep-meta-fw-arch-independent-v2-5-b9f5d69b7a52@imgtec.com>
References: <20261029-prep-meta-fw-arch-independent-v2-0-b9f5d69b7a52@imgtec.com>
In-Reply-To: <20261029-prep-meta-fw-arch-independent-v2-0-b9f5d69b7a52@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>,
 Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793255381; l=23673;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=RpR9mNh4TAlQQ+ZkntzHABimoQRn3vm6AHlACQcRymc=;
 b=ZAfAOKl2FVccns125maoau8NEBSAgkLmMf6RhWacreswveoVdruLl7rsynoaDuKah8q4Sj7ym
 8RGcEd6SZIxCI8drcxwMOXEr8p8GdihX33HJ9xELhPxLIpVNQs7VuqW
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-ORIG-GUID: 3wm5HJPl3hnAw-E8hiflN3rHKrGqRFbr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfX8rXNHsrdMkFu
 exA0+2rXZLA+rAMJEyy2heY6UXETTyMWxr3idfzaD1GsY9eN8JLuiBy+DUR77mggvXnvYHD3zZ6
 UQlFig/A8DtS5TVQZ7ISha2pdq/j9u+wlbf586tpuYNcCmzS2tzGmDhhVALbgwywPACaRzZ6c9l
 aVB2tYysKlSJqHv1eQehsB2QxEjHQcorYjjIEXOREX/8mIS8tFtoYLRHEcvnXXkIUNTtRIdKtIT
 QTpzQtTAfH6/qY5ze/wpIAyIGOGL0Obso2pDdAvu52IPEIqCTwrOQSZQPm8oDhhEe0rV0dR+ilU
 PT9KhWTW1sz5PMXxyTr5WL31CegJIO97mCIJnnMm8nuPh0HB+weCbHu47QQi5BKDCK1Volza6gO
 73MspI5q5hE629I86xFmeyMQUPatb7N89ywL3PH6hBOaRZcNfpeVMyyCqOx9cS4uXI6twKwfMsn
 osZU0A6kq7ihXYfdLXw==
X-Proofpoint-GUID: 3wm5HJPl3hnAw-E8hiflN3rHKrGqRFbr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfX7RJlV4KU58Qw
 ZMeSTfx9Ec2LVi22dgkvm0XUCcEUrlFSB2Oifw/JCTcP+UrscZ9AmqK4OGBii/z9GlByyfYq/B8
 q03PsPXVzszIqtKDNNVQURFAMPH5upg=
X-Authority-Analysis: v=2.4 cv=NvdE4MdJ c=1 sm=1 tr=0 ts=6ae2e7dd cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=u48y8eQ1_G8oleAFrj0A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

From: Alessio Belle <alessio.belle@imgtec.com>

This header file contains definitions common to all PowerVR
architectures starting from Rogue, so rename both the file and its
contents to reflect this.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_meta.c          |  82 +++++-----
 ...ogue_meta_internal.h => pvr_fw_meta_internal.h} | 173 +++++++++++----------
 2 files changed, 127 insertions(+), 128 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index f451f97a4f2f..7f48b23b5c75 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -5,10 +5,10 @@
 #include "pvr_fw.h"
 #include "pvr_fw_info.h"
 #include "pvr_gem.h"
+#define PVR_FW_META_INTERNAL_H_EXPLICIT_INCLUDE
+#include "pvr_fw_meta_internal.h"
+#undef PVR_FW_META_INTERNAL_H_EXPLICIT_INCLUDE
 #include "pvr_rogue_cr_defs.h"
-#define PVR_ROGUE_META_INTERNAL_H_EXPLICIT_INCLUDE
-#include "pvr_rogue_meta_internal.h"
-#undef PVR_ROGUE_META_INTERNAL_H_EXPLICIT_INCLUDE
 #include "pvr_vm.h"
 
 #include <linux/compiler.h>
@@ -91,7 +91,7 @@ pvr_meta_wrapper_init(struct pvr_device *pvr_dev)
 		<< ROGUE_CR_MTS_GARTEN_WRAPPER_CONFIG_FENCE_PC_BASE_SHIFT;
 
 	/* Set SLC DM=META. */
-	garten_config |= ((u64)ROGUE_FW_SEGMMU_META_BIFDM_ID)
+	garten_config |= ((u64)PVR_FW_SEGMMU_META_BIFDM_ID)
 			 << ROGUE_CR_MTS_GARTEN_WRAPPER_CONFIG_FENCE_DM_SHIFT;
 
 	pvr_cr_write64(pvr_dev, ROGUE_CR_MTS_GARTEN_WRAPPER_CONFIG, garten_config);
@@ -108,11 +108,11 @@ add_boot_arg(u32 **boot_conf, u32 param, u32 data)
 
 static int
 meta_ldr_cmd_loadmem(struct drm_device *drm_dev, const u8 *fw,
-		     struct rogue_meta_ldr_l1_data_blk *l1_data, u32 coremem_size, u8 *fw_code_ptr,
+		     struct pvr_meta_ldr_l1_data_blk *l1_data, u32 coremem_size, u8 *fw_code_ptr,
 		     u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr, const u32 fw_size)
 {
-	struct rogue_meta_ldr_l2_data_blk *l2_block =
-		(struct rogue_meta_ldr_l2_data_blk *)(fw +
+	struct pvr_meta_ldr_l2_data_blk *l2_block =
+		(struct pvr_meta_ldr_l2_data_blk *)(fw +
 						      l1_data->cmd_data[1]);
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
 	u32 offset = l1_data->cmd_data[0];
@@ -131,8 +131,8 @@ meta_ldr_cmd_loadmem(struct drm_device *drm_dev, const u8 *fw,
 	    ((((u8 *)l2_block->block_data) + data_size) - fw) >= fw_size)
 		return -EINVAL;
 
-	if (!ROGUE_META_IS_COREMEM_CODE(offset, coremem_size) &&
-	    !ROGUE_META_IS_COREMEM_DATA(offset, coremem_size)) {
+	if (!PVR_META_IS_COREMEM_CODE(offset, coremem_size) &&
+	    !PVR_META_IS_COREMEM_DATA(offset, coremem_size)) {
 		/* Global range is aliased to local range */
 		offset &= ~META_MEM_GLOBAL_RANGE_BIT;
 	}
@@ -153,7 +153,7 @@ meta_ldr_cmd_loadmem(struct drm_device *drm_dev, const u8 *fw,
 
 static int
 meta_ldr_cmd_zeromem(struct drm_device *drm_dev,
-		     struct rogue_meta_ldr_l1_data_blk *l1_data, u32 coremem_size,
+		     struct pvr_meta_ldr_l1_data_blk *l1_data, u32 coremem_size,
 		     u8 *fw_code_ptr, u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr)
 {
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
@@ -162,7 +162,7 @@ meta_ldr_cmd_zeromem(struct drm_device *drm_dev,
 	void *write_addr;
 	int err;
 
-	if (ROGUE_META_IS_COREMEM_DATA(offset, coremem_size)) {
+	if (PVR_META_IS_COREMEM_DATA(offset, coremem_size)) {
 		/* cannot zero coremem directly */
 		return 0;
 	}
@@ -186,13 +186,12 @@ meta_ldr_cmd_zeromem(struct drm_device *drm_dev,
 
 static int
 meta_ldr_cmd_config(struct drm_device *drm_dev, const u8 *fw,
-		    struct rogue_meta_ldr_l1_data_blk *l1_data,
+		    struct pvr_meta_ldr_l1_data_blk *l1_data,
 		    const u32 fw_size, u32 **boot_conf_ptr)
 {
-	struct rogue_meta_ldr_l2_data_blk *l2_block =
-		(struct rogue_meta_ldr_l2_data_blk *)(fw +
-						      l1_data->cmd_data[0]);
-	struct rogue_meta_ldr_cfg_blk *config_command;
+	struct pvr_meta_ldr_l2_data_blk *l2_block =
+		(struct pvr_meta_ldr_l2_data_blk *)(fw + l1_data->cmd_data[0]);
+	struct pvr_meta_ldr_cfg_blk *config_command;
 	u32 l2_block_size;
 	u32 curr_block_size = 0;
 	u32 *boot_conf = boot_conf_ptr ? *boot_conf_ptr : NULL;
@@ -202,14 +201,14 @@ meta_ldr_cmd_config(struct drm_device *drm_dev, const u8 *fw,
 		return -EINVAL;
 
 	l2_block_size = l2_block->length - 6 /* L2 Tag length and checksum */;
-	config_command = (struct rogue_meta_ldr_cfg_blk *)l2_block->block_data;
+	config_command = (struct pvr_meta_ldr_cfg_blk *)l2_block->block_data;
 
 	if (((u8 *)config_command - fw) >= fw_size ||
 	    ((((u8 *)config_command) + l2_block_size) - fw) >= fw_size)
 		return -EINVAL;
 
 	while (l2_block_size >= 12) {
-		if (config_command->type != ROGUE_META_LDR_CFG_WRITE)
+		if (config_command->type != PVR_META_LDR_CFG_WRITE)
 			return -EINVAL;
 
 		/*
@@ -227,7 +226,7 @@ meta_ldr_cmd_config(struct drm_device *drm_dev, const u8 *fw,
 
 		curr_block_size = 12;
 		l2_block_size -= curr_block_size;
-		config_command = (struct rogue_meta_ldr_cfg_blk
+		config_command = (struct pvr_meta_ldr_cfg_blk
 					  *)((uintptr_t)config_command +
 					     curr_block_size);
 	}
@@ -259,10 +258,10 @@ process_ldr_command_stream(struct pvr_device *pvr_dev, const u8 *fw, u8 *fw_code
 			   u8 *fw_core_data_ptr, u32 **boot_conf_ptr)
 {
 	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
-	struct rogue_meta_ldr_block_hdr *ldr_header =
-		(struct rogue_meta_ldr_block_hdr *)fw;
-	struct rogue_meta_ldr_l1_data_blk *l1_data =
-		(struct rogue_meta_ldr_l1_data_blk *)(fw + ldr_header->sl_data);
+	struct pvr_meta_ldr_block_hdr *ldr_header =
+		(struct pvr_meta_ldr_block_hdr *)fw;
+	struct pvr_meta_ldr_l1_data_blk *l1_data =
+		(struct pvr_meta_ldr_l1_data_blk *)(fw + ldr_header->sl_data);
 	const u32 fw_size = pvr_dev->fw_dev.firmware->size;
 	int err;
 
@@ -280,13 +279,13 @@ process_ldr_command_stream(struct pvr_device *pvr_dev, const u8 *fw, u8 *fw_code
 		if (((u8 *)l1_data - fw) >= fw_size || ((u8 *)(l1_data + 1) - fw) >= fw_size)
 			return -EINVAL;
 
-		if (ROGUE_META_LDR_BLK_IS_COMMENT(l1_data->cmd)) {
+		if (PVR_META_LDR_BLK_IS_COMMENT(l1_data->cmd)) {
 			/* Don't process comment blocks */
 			goto next_block;
 		}
 
-		switch (l1_data->cmd & ROGUE_META_LDR_CMD_MASK)
-		case ROGUE_META_LDR_CMD_LOADMEM: {
+		switch (l1_data->cmd & PVR_META_LDR_CMD_MASK)
+		case PVR_META_LDR_CMD_LOADMEM: {
 			err = meta_ldr_cmd_loadmem(drm_dev, fw, l1_data,
 						   coremem_size,
 						   fw_code_ptr, fw_data_ptr,
@@ -296,11 +295,11 @@ process_ldr_command_stream(struct pvr_device *pvr_dev, const u8 *fw, u8 *fw_code
 				return err;
 			break;
 
-		case ROGUE_META_LDR_CMD_START_THREADS:
+		case PVR_META_LDR_CMD_START_THREADS:
 			/* Don't process this block */
 			break;
 
-		case ROGUE_META_LDR_CMD_ZEROMEM:
+		case PVR_META_LDR_CMD_ZEROMEM:
 			err = meta_ldr_cmd_zeromem(drm_dev, l1_data,
 						   coremem_size,
 						   fw_code_ptr, fw_data_ptr,
@@ -310,7 +309,7 @@ process_ldr_command_stream(struct pvr_device *pvr_dev, const u8 *fw, u8 *fw_code
 				return err;
 			break;
 
-		case ROGUE_META_LDR_CMD_CONFIG:
+		case PVR_META_LDR_CMD_CONFIG:
 			err = meta_ldr_cmd_config(drm_dev, fw, l1_data, fw_size,
 						  &boot_conf);
 			if (err)
@@ -325,8 +324,7 @@ process_ldr_command_stream(struct pvr_device *pvr_dev, const u8 *fw, u8 *fw_code
 		if (l1_data->next == 0xFFFFFFFF)
 			break;
 
-		l1_data = (struct rogue_meta_ldr_l1_data_blk *)(fw +
-								l1_data->next);
+		l1_data = (struct pvr_meta_ldr_l1_data_blk *)(fw + l1_data->next);
 	}
 
 	if (boot_conf_ptr)
@@ -344,12 +342,12 @@ configure_seg_id(u64 seg_out_addr, u32 seg_base, u32 seg_limit, u32 seg_id,
 	u32 *boot_conf = *boot_conf_ptr;
 
 	/* META segments have a minimum size. */
-	u32 limit_off = max(seg_limit, ROGUE_FW_SEGMMU_ALIGN);
+	u32 limit_off = max(seg_limit, PVR_FW_SEGMMU_ALIGN);
 
 	/* The limit is an offset, therefore off = size - 1. */
 	limit_off -= 1;
 
-	seg_base |= ROGUE_FW_SEGMMU_ALLTHRS_WRITEABLE;
+	seg_base |= PVR_FW_SEGMMU_ALLTHRS_WRITEABLE;
 
 	add_boot_arg(&boot_conf, META_CR_MMCU_SEGMENT_N_BASE(seg_id), seg_base);
 	add_boot_arg(&boot_conf, META_CR_MMCU_SEGMENT_N_LIMIT(seg_id), limit_off);
@@ -375,8 +373,8 @@ configure_seg_mmu(struct pvr_device *pvr_dev, u32 **boot_conf_ptr)
 	u64 seg_out_addr_top;
 
 	seg_out_addr_top =
-		ROGUE_FW_SEGMMU_OUTADDR_TOP_SLC(MMU_CONTEXT_MAPPING_FWPRIV,
-						ROGUE_FW_SEGMMU_META_BIFDM_ID);
+		PVR_FW_SEGMMU_OUTADDR_TOP_SLC(MMU_CONTEXT_MAPPING_FWPRIV,
+					      PVR_FW_SEGMMU_META_BIFDM_ID);
 
 	for (u32 i = 0; i < num_layout_entries; i++) {
 		/*
@@ -385,7 +383,7 @@ configure_seg_mmu(struct pvr_device *pvr_dev, u32 **boot_conf_ptr)
 		 * segment MMU. Only the FW data segment needs to be configured.
 		 */
 		if (layout_entries[i].type == FW_DATA) {
-			u32 seg_id = ROGUE_FW_SEGMMU_DATA_ID;
+			u32 seg_id = PVR_FW_SEGMMU_DATA_ID;
 			u64 seg_out_addr = get_fw_obj_gpu_addr(pvr_dev->fw_dev.mem.data_obj);
 
 			seg_out_addr += layout_entries[i].alloc_offset;
@@ -463,7 +461,7 @@ pvr_meta_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 	u32 *boot_conf;
 	int err;
 
-	boot_conf = ((u32 *)fw_code_ptr) + ROGUE_FW_BOOTLDR_CONF_OFFSET;
+	boot_conf = ((u32 *)fw_code_ptr) + PVR_FW_BOOTLDR_CONF_OFFSET;
 
 	/* Slave port and JTAG accesses are privileged. */
 	add_boot_arg(&boot_conf, META_CR_SYSC_JTAG_THREAD,
@@ -518,15 +516,15 @@ pvr_meta_fini(struct pvr_device *pvr_dev)
 static u32
 pvr_meta_get_fw_addr_with_offset(struct pvr_fw_object *fw_obj, u32 offset)
 {
-	u32 fw_addr = fw_obj->fw_addr_offset + offset + ROGUE_FW_SEGMMU_DATA_BASE_ADDRESS;
+	u32 fw_addr = fw_obj->fw_addr_offset + offset + PVR_FW_SEGMMU_DATA_BASE_ADDRESS;
 
 	/* META cacheability is determined by address. */
 	if (fw_obj->gem->flags & PVR_BO_FW_FLAGS_DEVICE_UNCACHED) {
-		fw_addr |= ROGUE_FW_SEGMMU_DATA_META_UNCACHED |
-			   ROGUE_FW_SEGMMU_DATA_VIVT_SLC_UNCACHED;
+		fw_addr |= PVR_FW_SEGMMU_DATA_META_UNCACHED |
+			   PVR_FW_SEGMMU_DATA_VIVT_SLC_UNCACHED;
 	} else {
-		fw_addr |= ROGUE_FW_SEGMMU_DATA_META_CACHED |
-			   ROGUE_FW_SEGMMU_DATA_VIVT_SLC_CACHED;
+		fw_addr |= PVR_FW_SEGMMU_DATA_META_CACHED |
+			   PVR_FW_SEGMMU_DATA_VIVT_SLC_CACHED;
 	}
 
 	return fw_addr;
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_meta_internal.h b/drivers/gpu/drm/imagination/pvr_fw_meta_internal.h
similarity index 69%
rename from drivers/gpu/drm/imagination/pvr_rogue_meta_internal.h
rename to drivers/gpu/drm/imagination/pvr_fw_meta_internal.h
index dd978988ed40..7d288a377bbb 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_meta_internal.h
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta_internal.h
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR MIT */
 /* Copyright (c) 2023 Imagination Technologies Ltd. */
 
-#ifndef PVR_ROGUE_META_INTERNAL_H
-#define PVR_ROGUE_META_INTERNAL_H
+#ifndef PVR_FW_META_INTERNAL_H
+#define PVR_FW_META_INTERNAL_H
 
-#ifndef PVR_ROGUE_META_INTERNAL_H_EXPLICIT_INCLUDE
+#ifndef PVR_FW_META_INTERNAL_H_EXPLICIT_INCLUDE
 #error This file may only be included if explicitly defined
 #endif
 
@@ -45,7 +45,7 @@
 #define META_CR_PERF_ICORE1 (0x0480FFD8)
 #define META_CR_PERF_ICORE_DCACHEMISS (0x8)
 
-#define META_CR_PERF_COUNT(ctrl, thr)                                        \
+#define META_CR_PERF_COUNT(ctrl, thr) \
 	((META_CR_PERF_COUNT_CTRL_##ctrl << META_CR_PERF_COUNT_CTRL_SHIFT) | \
 	 ((thr) << META_CR_PERF_COUNT_THR_SHIFT))
 
@@ -74,8 +74,8 @@
 #define META_CR_TXUPC_ID (0x5)
 
 /* Macros to calculate register access values. */
-#define META_CR_CORE_REG(thr, reg_num, unit)          \
-	(((u32)(thr) << META_CR_TXUXXRXRQ_TX_S) |     \
+#define META_CR_CORE_REG(thr, reg_num, unit) \
+	(((u32)(thr) << META_CR_TXUXXRXRQ_TX_S) | \
 	 ((u32)(reg_num) << META_CR_TXUXXRXRQ_RX_S) | \
 	 ((u32)(unit) << META_CR_TXUXXRXRQ_UXX_S))
 
@@ -140,7 +140,7 @@
  ******************************************************************************
  */
 /* Block header structure. */
-struct rogue_meta_ldr_block_hdr {
+struct pvr_meta_ldr_block_hdr {
 	u32 dev_id;
 	u32 sl_code;
 	u32 sl_data;
@@ -149,7 +149,7 @@ struct rogue_meta_ldr_block_hdr {
 };
 
 /* High level data stream block structure. */
-struct rogue_meta_ldr_l1_data_blk {
+struct pvr_meta_ldr_l1_data_blk {
 	u16 cmd;
 	u16 length;
 	u32 next;
@@ -157,21 +157,21 @@ struct rogue_meta_ldr_l1_data_blk {
 };
 
 /* High level data stream block structure. */
-struct rogue_meta_ldr_l2_data_blk {
+struct pvr_meta_ldr_l2_data_blk {
 	u16 tag;
 	u16 length;
 	u32 block_data[4];
 };
 
 /* Config command structure. */
-struct rogue_meta_ldr_cfg_blk {
+struct pvr_meta_ldr_cfg_blk {
 	u32 type;
 	u32 block_data[4];
 };
 
 /* Block type definitions */
-#define ROGUE_META_LDR_COMMENT_TYPE_MASK (0x0010U)
-#define ROGUE_META_LDR_BLK_IS_COMMENT(x) (((x) & ROGUE_META_LDR_COMMENT_TYPE_MASK) != 0U)
+#define PVR_META_LDR_COMMENT_TYPE_MASK (0x0010U)
+#define PVR_META_LDR_BLK_IS_COMMENT(x) (((x) & PVR_META_LDR_COMMENT_TYPE_MASK) != 0U)
 
 /*
  * Command definitions
@@ -183,14 +183,14 @@ struct rogue_meta_ldr_cfg_blk {
  *  4       ZeroMem         Zeros a memory region.
  *  5       Config          Perform a configuration command.
  */
-#define ROGUE_META_LDR_CMD_MASK (0x000FU)
+#define PVR_META_LDR_CMD_MASK (0x000FU)
 
-#define ROGUE_META_LDR_CMD_LOADMEM (0x0000U)
-#define ROGUE_META_LDR_CMD_LOADCORE (0x0001U)
-#define ROGUE_META_LDR_CMD_LOADMMREG (0x0002U)
-#define ROGUE_META_LDR_CMD_START_THREADS (0x0003U)
-#define ROGUE_META_LDR_CMD_ZEROMEM (0x0004U)
-#define ROGUE_META_LDR_CMD_CONFIG (0x0005U)
+#define PVR_META_LDR_CMD_LOADMEM (0x0000U)
+#define PVR_META_LDR_CMD_LOADCORE (0x0001U)
+#define PVR_META_LDR_CMD_LOADMMREG (0x0002U)
+#define PVR_META_LDR_CMD_START_THREADS (0x0003U)
+#define PVR_META_LDR_CMD_ZEROMEM (0x0004U)
+#define PVR_META_LDR_CMD_CONFIG (0x0005U)
 
 /*
  * Config Command definitions
@@ -202,61 +202,61 @@ struct rogue_meta_ldr_cfg_blk {
  *  3       MemSet      Set mem to value
  *  4       MemCheck    check mem for specific value.
  */
-#define ROGUE_META_LDR_CFG_PAUSE (0x0000)
-#define ROGUE_META_LDR_CFG_READ (0x0001)
-#define ROGUE_META_LDR_CFG_WRITE (0x0002)
-#define ROGUE_META_LDR_CFG_MEMSET (0x0003)
-#define ROGUE_META_LDR_CFG_MEMCHECK (0x0004)
+#define PVR_META_LDR_CFG_PAUSE (0x0000)
+#define PVR_META_LDR_CFG_READ (0x0001)
+#define PVR_META_LDR_CFG_WRITE (0x0002)
+#define PVR_META_LDR_CFG_MEMSET (0x0003)
+#define PVR_META_LDR_CFG_MEMCHECK (0x0004)
 
 /*
  ******************************************************************************
- * ROGUE FW segmented MMU definitions
+ * META segmented MMU definitions
  ******************************************************************************
  */
 /* All threads can access the segment. */
-#define ROGUE_FW_SEGMMU_ALLTHRS (0xf << 8U)
+#define PVR_FW_SEGMMU_ALLTHRS (0xf << 8U)
 /* Writable. */
-#define ROGUE_FW_SEGMMU_WRITEABLE (0x1U << 1U)
+#define PVR_FW_SEGMMU_WRITEABLE (0x1U << 1U)
 /* All threads can access and writable. */
-#define ROGUE_FW_SEGMMU_ALLTHRS_WRITEABLE \
-	(ROGUE_FW_SEGMMU_ALLTHRS | ROGUE_FW_SEGMMU_WRITEABLE)
+#define PVR_FW_SEGMMU_ALLTHRS_WRITEABLE \
+	(PVR_FW_SEGMMU_ALLTHRS | PVR_FW_SEGMMU_WRITEABLE)
 
 /* Direct map region 10 used for mapping GPU memory - max 8MB. */
-#define ROGUE_FW_SEGMMU_DMAP_GPU_ID (10U)
-#define ROGUE_FW_SEGMMU_DMAP_GPU_ADDR_START (0x07000000U)
-#define ROGUE_FW_SEGMMU_DMAP_GPU_MAX_SIZE (0x00800000U)
+#define PVR_FW_SEGMMU_DMAP_GPU_ID (10U)
+#define PVR_FW_SEGMMU_DMAP_GPU_ADDR_START (0x07000000U)
+#define PVR_FW_SEGMMU_DMAP_GPU_MAX_SIZE (0x00800000U)
 
 /* Segment IDs. */
-#define ROGUE_FW_SEGMMU_DATA_ID (1U)
-#define ROGUE_FW_SEGMMU_BOOTLDR_ID (2U)
-#define ROGUE_FW_SEGMMU_TEXT_ID (ROGUE_FW_SEGMMU_BOOTLDR_ID)
+#define PVR_FW_SEGMMU_DATA_ID (1U)
+#define PVR_FW_SEGMMU_BOOTLDR_ID (2U)
+#define PVR_FW_SEGMMU_TEXT_ID (PVR_FW_SEGMMU_BOOTLDR_ID)
 
 /*
  * SLC caching strategy in S7 and volcanic is emitted through the segment MMU.
- * All the segments configured through the macro ROGUE_FW_SEGMMU_OUTADDR_TOP are
+ * All the segments configured through the macro PVR_FW_SEGMMU_OUTADDR_TOP are
  * CACHED in the SLC.
  * The interface has been kept the same to simplify the code changes.
  * The bifdm argument is ignored (no longer relevant) in S7 and volcanic.
  */
-#define ROGUE_FW_SEGMMU_OUTADDR_TOP_VIVT_SLC(pers, slc_policy, mmu_ctx)  \
+#define PVR_FW_SEGMMU_OUTADDR_TOP_VIVT_SLC(pers, slc_policy, mmu_ctx)  \
 	((((u64)((pers) & 0x3)) << 52) | (((u64)((mmu_ctx) & 0xFF)) << 44) | \
 	 (((u64)((slc_policy) & 0x1)) << 40))
-#define ROGUE_FW_SEGMMU_OUTADDR_TOP_VIVT_SLC_CACHED(mmu_ctx) \
-	ROGUE_FW_SEGMMU_OUTADDR_TOP_VIVT_SLC(0x3, 0x0, mmu_ctx)
-#define ROGUE_FW_SEGMMU_OUTADDR_TOP_VIVT_SLC_UNCACHED(mmu_ctx) \
-	ROGUE_FW_SEGMMU_OUTADDR_TOP_VIVT_SLC(0x0, 0x1, mmu_ctx)
+#define PVR_FW_SEGMMU_OUTADDR_TOP_VIVT_SLC_CACHED(mmu_ctx) \
+	PVR_FW_SEGMMU_OUTADDR_TOP_VIVT_SLC(0x3, 0x0, mmu_ctx)
+#define PVR_FW_SEGMMU_OUTADDR_TOP_VIVT_SLC_UNCACHED(mmu_ctx) \
+	PVR_FW_SEGMMU_OUTADDR_TOP_VIVT_SLC(0x0, 0x1, mmu_ctx)
 
 /*
  * To configure the Page Catalog and BIF-DM fed into the BIF for Garten
  * accesses through this segment.
  */
-#define ROGUE_FW_SEGMMU_OUTADDR_TOP_SLC(pc, bifdm) \
+#define PVR_FW_SEGMMU_OUTADDR_TOP_SLC(pc, bifdm) \
 	(((u64)((u64)(pc) & 0xFU) << 44U) | ((u64)((u64)(bifdm) & 0xFU) << 40U))
 
-#define ROGUE_FW_SEGMMU_META_BIFDM_ID (0x7U)
+#define PVR_FW_SEGMMU_META_BIFDM_ID (0x7U)
 
 /* META segments have 4kB minimum size. */
-#define ROGUE_FW_SEGMMU_ALIGN (0x1000U)
+#define PVR_FW_SEGMMU_ALIGN (0x1000U)
 
 /* Segmented MMU registers (n = segment id). */
 #define META_CR_MMCU_SEGMENT_N_BASE(n) (0x04850000U + ((n) * 0x10U))
@@ -273,72 +273,73 @@ struct rogue_meta_ldr_cfg_blk {
  * - SLC cached,   META cached,   FW base address 0x10000000
  * - SLC cached,   META uncached, FW base address 0x90000000
  */
-#define ROGUE_FW_SEGMMU_DATA_BASE_ADDRESS (0x10000000U)
-#define ROGUE_FW_SEGMMU_DATA_META_CACHED (0x0U)
-#define ROGUE_FW_SEGMMU_DATA_META_UNCACHED (META_MEM_GLOBAL_RANGE_BIT)
-#define ROGUE_FW_SEGMMU_DATA_META_CACHE_MASK (META_MEM_GLOBAL_RANGE_BIT)
+#define PVR_FW_SEGMMU_DATA_BASE_ADDRESS (0x10000000U)
+#define PVR_FW_SEGMMU_DATA_META_CACHED (0x0U)
+#define PVR_FW_SEGMMU_DATA_META_UNCACHED (META_MEM_GLOBAL_RANGE_BIT)
+#define PVR_FW_SEGMMU_DATA_META_CACHE_MASK (META_MEM_GLOBAL_RANGE_BIT)
 /*
  * For non-VIVT SLCs the cacheability of the FW data in the SLC is selected in
  * the PTEs for the FW data, not in the Meta Segment MMU, which means these
  * defines have no real effect in those cases.
  */
-#define ROGUE_FW_SEGMMU_DATA_VIVT_SLC_CACHED (0x0U)
-#define ROGUE_FW_SEGMMU_DATA_VIVT_SLC_UNCACHED (0x60000000U)
-#define ROGUE_FW_SEGMMU_DATA_VIVT_SLC_CACHE_MASK (0x60000000U)
+#define PVR_FW_SEGMMU_DATA_VIVT_SLC_CACHED (0x0U)
+#define PVR_FW_SEGMMU_DATA_VIVT_SLC_UNCACHED (0x60000000U)
+#define PVR_FW_SEGMMU_DATA_VIVT_SLC_CACHE_MASK (0x60000000U)
 
 /*
  ******************************************************************************
- * ROGUE FW Bootloader defaults
+ * META Bootloader defaults
  ******************************************************************************
  */
-#define ROGUE_FW_BOOTLDR_META_ADDR (0x40000000U)
-#define ROGUE_FW_BOOTLDR_DEVV_ADDR_0 (0xC0000000U)
-#define ROGUE_FW_BOOTLDR_DEVV_ADDR_1 (0x000000E1)
-#define ROGUE_FW_BOOTLDR_DEVV_ADDR                     \
-	((((u64)ROGUE_FW_BOOTLDR_DEVV_ADDR_1) << 32) | \
-	 ROGUE_FW_BOOTLDR_DEVV_ADDR_0)
-#define ROGUE_FW_BOOTLDR_LIMIT (0x1FFFF000)
-#define ROGUE_FW_MAX_BOOTLDR_OFFSET (0x1000)
+#define PVR_FW_BOOTLDR_META_ADDR (0x40000000U)
+#define PVR_FW_BOOTLDR_DEVV_ADDR_0 (0xC0000000U)
+#define PVR_FW_BOOTLDR_DEVV_ADDR_1 (0x000000E1)
+#define PVR_FW_BOOTLDR_DEVV_ADDR \
+	((((u64)PVR_FW_BOOTLDR_DEVV_ADDR_1) << 32) | \
+	 PVR_FW_BOOTLDR_DEVV_ADDR_0)
+#define PVR_FW_BOOTLDR_LIMIT (0x1FFFF000)
+#define PVR_FW_MAX_BOOTLDR_OFFSET (0x1000)
 
 /* Bootloader configuration offset is in dwords (512 bytes) */
-#define ROGUE_FW_BOOTLDR_CONF_OFFSET (0x80)
+#define PVR_FW_BOOTLDR_CONF_OFFSET (0x80)
 
 /*
  ******************************************************************************
- * ROGUE META Stack
+ * META Stack
  ******************************************************************************
  */
-#define ROGUE_META_STACK_SIZE (0x1000U)
+#define PVR_META_STACK_SIZE (0x1000U)
 
 /*
  ******************************************************************************
- * ROGUE META Core memory
+ * META Core memory
  ******************************************************************************
  */
 /* Code and data both map to the same physical memory. */
-#define ROGUE_META_COREMEM_CODE_ADDR (0x80000000U)
-#define ROGUE_META_COREMEM_DATA_ADDR (0x82000000U)
-#define ROGUE_META_COREMEM_OFFSET_MASK (0x01ffffffU)
-
-#define ROGUE_META_IS_COREMEM_CODE(a, b)                                \
-	({                                                              \
-		u32 _a = (a), _b = (b);                                 \
-		((_a) >= ROGUE_META_COREMEM_CODE_ADDR) &&               \
-			((_a) < (ROGUE_META_COREMEM_CODE_ADDR + (_b))); \
+#define PVR_META_COREMEM_CODE_ADDR (0x80000000U)
+#define PVR_META_COREMEM_DATA_ADDR (0x82000000U)
+#define PVR_META_COREMEM_OFFSET_MASK (0x01ffffffU)
+
+#define PVR_META_IS_COREMEM_CODE(a, b) \
+	({ \
+		u32 _a = (a), _b = (b); \
+		((_a) >= PVR_META_COREMEM_CODE_ADDR) && \
+			((_a) < (PVR_META_COREMEM_CODE_ADDR + (_b))); \
 	})
-#define ROGUE_META_IS_COREMEM_DATA(a, b)                                \
-	({                                                              \
-		u32 _a = (a), _b = (b);                                 \
-		((_a) >= ROGUE_META_COREMEM_DATA_ADDR) &&               \
-			((_a) < (ROGUE_META_COREMEM_DATA_ADDR + (_b))); \
+#define PVR_META_IS_COREMEM_DATA(a, b) \
+	({ \
+		u32 _a = (a), _b = (b); \
+		((_a) >= PVR_META_COREMEM_DATA_ADDR) && \
+			((_a) < (PVR_META_COREMEM_DATA_ADDR + (_b))); \
 	})
+
 /*
  ******************************************************************************
  * 2nd thread
  ******************************************************************************
  */
-#define ROGUE_FW_THR1_PC (0x18930000)
-#define ROGUE_FW_THR1_SP (0x78890000)
+#define PVR_FW_THR1_PC (0x18930000)
+#define PVR_FW_THR1_SP (0x78890000)
 
 /*
  ******************************************************************************
@@ -350,11 +351,11 @@ struct rogue_meta_ldr_cfg_blk {
 #define META_CR_CORE_ID_VER_SHIFT (16U)
 #define META_CR_CORE_ID_VER_CLRMSK (0XFF00FFFFU)
 
-#define ROGUE_CR_META_MTP218_CORE_ID_VALUE 0x19
-#define ROGUE_CR_META_MTP219_CORE_ID_VALUE 0x1E
-#define ROGUE_CR_META_LTP218_CORE_ID_VALUE 0x1C
-#define ROGUE_CR_META_LTP217_CORE_ID_VALUE 0x1F
+#define PVR_CR_META_MTP218_CORE_ID_VALUE 0x19
+#define PVR_CR_META_MTP219_CORE_ID_VALUE 0x1E
+#define PVR_CR_META_LTP218_CORE_ID_VALUE 0x1C
+#define PVR_CR_META_LTP217_CORE_ID_VALUE 0x1F
 
-#define ROGUE_FW_PROCESSOR_META "META"
+#define PVR_FW_PROCESSOR_META "META"
 
-#endif /* PVR_ROGUE_META_INTERNAL_H */
+#endif /* PVR_FW_META_INTERNAL_H */

-- 
2.43.0

