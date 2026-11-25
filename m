Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81881606A69D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=TsxmZ+8W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C6DF10FBF0;
	Wed, 25 Nov 2026 11:49:41 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4FA510FBE3;
 Wed, 25 Nov 2026 11:49:21 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AP88eQE1969148; Wed, 25 Nov 2026 11:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=r
 0vExMNN/CGu8pWPMVlot/fl967CpMMaULQYFGuV/tE=; b=TsxmZ+8WrVz+/P9O5
 uFkmzO0ZKfDQc/fX8vbqmoIAJcFwaOP7BBPb4xr3XlIBXbcjBgPwql1/Encpjrkk
 uIP0lB5SsQoFtjiWIcGDrXovIhyDrXZaILoUO6Rkk3uba9+RhHuSUNzW8K/YHPSw
 K9gddp31gR6W+L2luxs+ZQoGflMF3alMmmj6a8rPSJ4ysJcFU8G1iht3TSJZ7tAE
 m4927HPn1Jj8XXffVo2blpm+/SHhfnadO8RSbg0xHA2tpkUlR5FI83K2iyX9pxhi
 Ncg2spvMxE7Rapk0Y91vBu3l38RZZkWiB72Sp42h4fFEx2qpze1lCzGHgjQMZ6Ld
 jedWw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4j32ev31p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Wed, 25 Nov 2026 11:49:01 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.203) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 11:48:59 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 25 Nov 2026 13:48:31 +0200
Subject: [PATCH 3/6] drm/imagination: Save metadata from firmware
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261125-b4-commonize-fw-segment-loading-v1-3-69657fa52ac3@imgtec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795607333; l=36533;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=YWin0XPhBerhXyJg+3278pC1HUW9PhisPfnXz1pwI2M=;
 b=KHfgBpYtjU/JBNM0+ghSHFtMMQN78BGobvfIa49BaVoB7YraZuEN6TShnVfPTW2B7IndayI/a
 QrsP/foBagICtm97PBy/hVkVWlYPzgWl5maQXAw88jMS8moRjoHQb1h
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX3pbD3tGfsnrQ
 YMYFioGVfA6fuRcuZRA2ngKi/nEDCzSAPYyspF1cuylbLg8eEZmdYySIqx4/GK835D16HcJlMCz
 xfwUeNaAxlDdYKSDGIML4wgrfy1QY+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX8OEPou7zkpeR
 aWYpRPenHcYyCvZSC58+yfttAE6U3H+z3XEDMyRplm19Sst1ymOSSwhHPo/mqeq0/poEbEvvoxr
 3GmqvrsaK3ZRfpWlDBjq0LHyU7R25k95PeB9tLOcTwdijiinhQoN7kUTG1VM+M/QBCARNKZ4FBQ
 qnrVJSrHEnOhEnc33u6Q1PTtySBYTQ90pRrTKehVPxbzJTzt2kVIwQaRYRNC4dG+Y+K13ig1i11
 UdCTZOHgwS7PyYkxKpYPvE+HqNoqHt2ceQEv890Bro24Xg/L319zLDQAvLU37CU/5Szd69pHvHU
 6JsX1KJ58DZ+ckXnMxLR1h9hSUqJml79nt8S9k95Oxi++YW90eRz8aoq32v6YxmY9DEqgk0Da8B
 Y37+id63VBw9YCibf8zDQ8lTTTH+z7m/HmdxrL1X5NQeFsyzK31S32NZJTbJsohxC2wLJi8uPQ1
 wK1IKh1GNtCjIyln2jQ==
X-Authority-Analysis: v=2.4 cv=T7AZ3PKQ c=1 sm=1 tr=0 ts=6b06cb2d cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=4EFqt8Tv61wA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=lq00ibsSrNVZE3nmIhkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: lndzApfnbBThyrKH_PjkjurfiSHtgvA1
X-Proofpoint-ORIG-GUID: lndzApfnbBThyrKH_PjkjurfiSHtgvA1
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

We only need a small amount of metadata from firmware files to stick
around (besides the actual loaded code and data segments). To prepare
for supporting multiple versions of the binary metadata format used in
the firmware headers, extract this information and store it in a
kernel-internal fashion.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/Makefile       |   1 +
 drivers/gpu/drm/imagination/pvr_device.c   |   5 +-
 drivers/gpu/drm/imagination/pvr_device.h   |  15 --
 drivers/gpu/drm/imagination/pvr_fw.c       | 228 +++----------------
 drivers/gpu/drm/imagination/pvr_fw.h       |  96 +++++++-
 drivers/gpu/drm/imagination/pvr_fw_info.c  | 338 +++++++++++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_fw_info.h  |   6 +
 drivers/gpu/drm/imagination/pvr_fw_meta.c  |  19 +-
 drivers/gpu/drm/imagination/pvr_fw_mips.c  |  26 +--
 drivers/gpu/drm/imagination/pvr_fw_riscv.c |   1 -
 10 files changed, 487 insertions(+), 248 deletions(-)

diff --git a/drivers/gpu/drm/imagination/Makefile b/drivers/gpu/drm/imagination/Makefile
index a5c5e386f16a..9ff9694b2235 100644
--- a/drivers/gpu/drm/imagination/Makefile
+++ b/drivers/gpu/drm/imagination/Makefile
@@ -11,6 +11,7 @@ powervr-y := \
 	pvr_dump.o \
 	pvr_free_list.o \
 	pvr_fw.o \
+	pvr_fw_info.o \
 	pvr_fw_meta.o \
 	pvr_fw_mips.o \
 	pvr_fw_riscv.o \
diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 992509d95d28..0c4832d2cce1 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -693,7 +693,7 @@ pvr_device_info_validate(struct pvr_device *pvr_dev)
  *  * 0 on success,
  *  * -%ENODEV if the GPU is not supported,
  *  * Any error returned by pvr_request_firmware(),
- *  * Any error returned by pvr_fw_validate_init_device_info(),
+ *  * Any error returned by pvr_fw_load_metadata_and_device_info(),
  *  * Any error returned by pvr_device_info_validate(),
  *  * Any error returned by pvr_set_dma_info(), or
  *  * Any error returned by pvr_fw_init().
@@ -711,7 +711,7 @@ pvr_device_gpu_init(struct pvr_device *pvr_dev)
 	if (err)
 		return err;
 
-	err = pvr_fw_validate_init_device_info(pvr_dev);
+	err = pvr_fw_load_metadata_and_device_info(pvr_dev);
 	if (err)
 		return err;
 
@@ -745,6 +745,7 @@ static void
 pvr_device_gpu_fini(struct pvr_device *pvr_dev)
 {
 	pvr_fw_fini(pvr_dev);
+	pvr_fw_free_metadata_and_device_info(pvr_dev);
 }
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index c246122b4caf..30b101bb0a49 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -33,9 +33,6 @@
 /* Forward declaration from <linux/clk.h>. */
 struct clk;
 
-/* Forward declaration from <linux/firmware.h>. */
-struct firmware;
-
 /* Forward declaration from <linux/pwrseq/consumer.h> */
 struct pwrseq_desc;
 
@@ -53,15 +50,6 @@ struct pvr_gpu_id {
 	u16 b, v, n, c;
 };
 
-/**
- * struct pvr_fw_version - Firmware version information
- * @major: Major version number.
- * @minor: Minor version number.
- */
-struct pvr_fw_version {
-	u16 major, minor;
-};
-
 /**
  * struct pvr_device_data - Platform specific data associated with a compatible string.
  * @pwr_ops: Pointer to a structure with platform-specific power functions.
@@ -108,9 +96,6 @@ struct pvr_device {
 	 */
 	struct pvr_device_enhancements enhancements;
 
-	/** @fw_version: Firmware version detected at runtime. */
-	struct pvr_fw_version fw_version;
-
 	/** @device_data: Pointer to platform-specific data. */
 	const struct pvr_device_data *device_data;
 
diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index cbde54c7291c..2a5dcd9aeed7 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -3,10 +3,8 @@
 
 #include "pvr_ccb.h"
 #include "pvr_device.h"
-#include "pvr_device_info.h"
 #include "pvr_drv.h"
 #include "pvr_fw.h"
-#include "pvr_fw_info.h"
 #include "pvr_fw_startstop.h"
 #include "pvr_fw_trace.h"
 #include "pvr_gem.h"
@@ -23,10 +21,9 @@
 #include <linux/firmware.h>
 #include <linux/math.h>
 #include <linux/minmax.h>
+#include <linux/overflow.h>
 #include <linux/sizes.h>
 
-#define FW_MAX_SUPPORTED_MAJOR_VERSION 1
-
 #define FW_BOOT_TIMEOUT_USEC 5000000
 
 /* Config heap occupies top 192k of the firmware heap. */
@@ -47,153 +44,20 @@
 
 #define PVR_SYNC_OBJ_SIZE sizeof(u32)
 
-const struct pvr_fw_layout_entry *
-pvr_fw_find_layout_entry(struct pvr_device *pvr_dev, enum pvr_fw_section_id id)
+const struct pvr_fw_section_desc *
+pvr_fw_get_section_desc(struct pvr_device *pvr_dev, enum pvr_fw_section_name section)
 {
-	const struct pvr_fw_layout_entry *layout_entries = pvr_dev->fw_dev.layout_entries;
-	u32 num_layout_entries = pvr_dev->fw_dev.header->layout_entry_num;
-
-	for (u32 entry = 0; entry < num_layout_entries; entry++) {
-		if (layout_entries[entry].id == id)
-			return &layout_entries[entry];
+	pvr_for_each_fw_section_desc(pvr_dev->fw_dev.metadata, desc) {
+		if (desc->name == section)
+			return desc;
 	}
 
 	return NULL;
 }
 
-static const struct pvr_fw_layout_entry *
-pvr_fw_find_private_data(struct pvr_device *pvr_dev)
-{
-	const struct pvr_fw_layout_entry *layout_entries = pvr_dev->fw_dev.layout_entries;
-	u32 num_layout_entries = pvr_dev->fw_dev.header->layout_entry_num;
-
-	for (u32 entry = 0; entry < num_layout_entries; entry++) {
-		if (layout_entries[entry].id == META_PRIVATE_DATA ||
-		    layout_entries[entry].id == MIPS_PRIVATE_DATA ||
-		    layout_entries[entry].id == RISCV_PRIVATE_DATA)
-			return &layout_entries[entry];
-	}
-
-	return NULL;
-}
-
-#define DEV_INFO_MASK_SIZE(x) DIV_ROUND_UP(x, 64)
-
-/**
- * pvr_fw_validate() - Parse firmware header and check compatibility
- * @pvr_dev: Device pointer.
- *
- * Returns:
- *  * 0 on success, or
- *  * -EINVAL if firmware is incompatible.
- */
-static int
-pvr_fw_validate(struct pvr_device *pvr_dev)
-{
-	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
-	const struct firmware *firmware = pvr_dev->fw_dev.firmware;
-	const struct pvr_fw_layout_entry *layout_entries;
-	const struct pvr_fw_info_header *header;
-	const u8 *fw = firmware->data;
-	u32 fw_offset = firmware->size - SZ_4K;
-	u32 layout_table_size;
-
-	if (firmware->size < SZ_4K || (firmware->size % FW_BLOCK_SIZE))
-		return -EINVAL;
-
-	header = (const struct pvr_fw_info_header *)&fw[fw_offset];
-
-	if (header->info_version != PVR_FW_INFO_VERSION) {
-		drm_err(drm_dev, "Unsupported fw info version %u\n",
-			header->info_version);
-		return -EINVAL;
-	}
-
-	if (header->header_len != sizeof(struct pvr_fw_info_header) ||
-	    header->layout_entry_size != sizeof(struct pvr_fw_layout_entry) ||
-	    header->layout_entry_num > PVR_FW_INFO_MAX_NUM_ENTRIES) {
-		drm_err(drm_dev, "FW info format mismatch\n");
-		return -EINVAL;
-	}
-
-	if (!(header->flags & PVR_FW_FLAGS_OPEN_SOURCE) ||
-	    header->fw_version_major > FW_MAX_SUPPORTED_MAJOR_VERSION ||
-	    header->fw_version_major == 0) {
-		drm_err(drm_dev, "Unsupported FW version %u.%u (build: %u%s)\n",
-			header->fw_version_major, header->fw_version_minor,
-			header->fw_version_build,
-			(header->flags & PVR_FW_FLAGS_OPEN_SOURCE) ? " OS" : "");
-		return -EINVAL;
-	}
-
-	if (pvr_gpu_id_to_packed_bvnc(&pvr_dev->gpu_id) != header->bvnc) {
-		struct pvr_gpu_id fw_gpu_id;
-
-		packed_bvnc_to_pvr_gpu_id(header->bvnc, &fw_gpu_id);
-		drm_err(drm_dev, "FW built for incorrect GPU ID %i.%i.%i.%i (expected %i.%i.%i.%i)\n",
-			fw_gpu_id.b, fw_gpu_id.v, fw_gpu_id.n, fw_gpu_id.c,
-			pvr_dev->gpu_id.b, pvr_dev->gpu_id.v, pvr_dev->gpu_id.n, pvr_dev->gpu_id.c);
-		return -EINVAL;
-	}
-
-	fw_offset += header->header_len;
-	layout_table_size =
-		header->layout_entry_size * header->layout_entry_num;
-	if ((fw_offset + layout_table_size) > firmware->size)
-		return -EINVAL;
-
-	layout_entries = (const struct pvr_fw_layout_entry *)&fw[fw_offset];
-	for (u32 entry = 0; entry < header->layout_entry_num; entry++) {
-		u32 start_addr = layout_entries[entry].base_addr;
-		u32 end_addr = start_addr + layout_entries[entry].alloc_size;
-
-		if (start_addr >= end_addr)
-			return -EINVAL;
-	}
-
-	fw_offset = (firmware->size - SZ_4K) - header->device_info_size;
-
-	drm_info(drm_dev, "FW version v%u.%u (build %u OS)\n", header->fw_version_major,
-		 header->fw_version_minor, header->fw_version_build);
-
-	pvr_dev->fw_version.major = header->fw_version_major;
-	pvr_dev->fw_version.minor = header->fw_version_minor;
-
-	pvr_dev->fw_dev.header = header;
-	pvr_dev->fw_dev.layout_entries = layout_entries;
-
-	return 0;
-}
-
-static int
-pvr_fw_get_device_info(struct pvr_device *pvr_dev)
-{
-	const struct firmware *firmware = pvr_dev->fw_dev.firmware;
-	struct pvr_fw_device_info_header *header;
-	const u8 *fw = firmware->data;
-	const u64 *dev_info;
-	u32 fw_offset;
-
-	fw_offset = (firmware->size - SZ_4K) - pvr_dev->fw_dev.header->device_info_size;
-
-	header = (struct pvr_fw_device_info_header *)&fw[fw_offset];
-	dev_info = (u64 *)(header + 1);
-
-	pvr_device_info_set_quirks(pvr_dev, dev_info, header->brn_mask_size);
-	dev_info += header->brn_mask_size;
-
-	pvr_device_info_set_enhancements(pvr_dev, dev_info, header->ern_mask_size);
-	dev_info += header->ern_mask_size;
-
-	return pvr_device_info_set_features(pvr_dev, dev_info, header->feature_mask_size,
-					    header->feature_param_size);
-}
-
 static void
 layout_get_sizes(struct pvr_device *pvr_dev)
 {
-	const struct pvr_fw_layout_entry *layout_entries = pvr_dev->fw_dev.layout_entries;
-	u32 num_layout_entries = pvr_dev->fw_dev.header->layout_entry_num;
 	struct pvr_fw_mem *fw_mem = &pvr_dev->fw_dev.mem;
 
 	fw_mem->code_alloc_size = 0;
@@ -202,23 +66,21 @@ layout_get_sizes(struct pvr_device *pvr_dev)
 	fw_mem->core_data_alloc_size = 0;
 
 	/* Extract section sizes from FW layout table. */
-	for (u32 entry = 0; entry < num_layout_entries; entry++) {
-		switch (layout_entries[entry].type) {
-		case FW_CODE:
-			fw_mem->code_alloc_size += layout_entries[entry].alloc_size;
+	pvr_for_each_fw_section_desc(pvr_dev->fw_dev.metadata, desc) {
+		switch (desc->segment) {
+		case PVR_FW_SEGMENT_CODE:
+			fw_mem->code_alloc_size += desc->size;
 			break;
-		case FW_DATA:
-			fw_mem->data_alloc_size += layout_entries[entry].alloc_size;
+		case PVR_FW_SEGMENT_DATA:
+			fw_mem->data_alloc_size += desc->size;
 			break;
-		case FW_COREMEM_CODE:
-			fw_mem->core_code_alloc_size +=
-				layout_entries[entry].alloc_size;
+		case PVR_FW_SEGMENT_CORE_CODE:
+			fw_mem->core_code_alloc_size += desc->size;
 			break;
-		case FW_COREMEM_DATA:
-			fw_mem->core_data_alloc_size +=
-				layout_entries[entry].alloc_size;
+		case PVR_FW_SEGMENT_CORE_DATA:
+			fw_mem->core_data_alloc_size += desc->size;
 			break;
-		case NONE:
+		default:
 			break;
 		}
 	}
@@ -229,34 +91,32 @@ pvr_fw_find_mmu_segment(struct pvr_device *pvr_dev, u32 addr, u32 size, void *fw
 			void *fw_data_ptr, void *fw_core_code_ptr, void *fw_core_data_ptr,
 			void **host_addr_out)
 {
-	const struct pvr_fw_layout_entry *layout_entries = pvr_dev->fw_dev.layout_entries;
-	u32 num_layout_entries = pvr_dev->fw_dev.header->layout_entry_num;
-	u32 end_addr = addr + size;
+	u32 end_addr;
 
 	/* Ensure requested range is not zero, and size is not causing addr to overflow. */
-	if (end_addr <= addr)
+	if (!size || check_add_overflow(addr, size, &end_addr))
 		return -EINVAL;
 
-	for (int entry = 0; entry < num_layout_entries; entry++) {
-		u32 entry_start_addr = layout_entries[entry].base_addr;
-		u32 entry_end_addr = entry_start_addr + layout_entries[entry].alloc_size;
+	pvr_for_each_fw_section_desc(pvr_dev->fw_dev.metadata, desc) {
+		u32 entry_start_addr = desc->base_addr;
+		u32 entry_end_addr = entry_start_addr + desc->size;
 
 		if (addr >= entry_start_addr && addr < entry_end_addr &&
 		    end_addr > entry_start_addr && end_addr <= entry_end_addr) {
-			switch (layout_entries[entry].type) {
-			case FW_CODE:
+			switch (desc->segment) {
+			case PVR_FW_SEGMENT_CODE:
 				*host_addr_out = fw_code_ptr;
 				break;
 
-			case FW_DATA:
+			case PVR_FW_SEGMENT_DATA:
 				*host_addr_out = fw_data_ptr;
 				break;
 
-			case FW_COREMEM_CODE:
+			case PVR_FW_SEGMENT_CORE_CODE:
 				*host_addr_out = fw_core_code_ptr;
 				break;
 
-			case FW_COREMEM_DATA:
+			case PVR_FW_SEGMENT_CORE_DATA:
 				*host_addr_out = fw_core_data_ptr;
 				break;
 
@@ -264,8 +124,8 @@ pvr_fw_find_mmu_segment(struct pvr_device *pvr_dev, u32 addr, u32 size, void *fw
 				return -EINVAL;
 			}
 			/* Direct Mem write to mapped memory */
-			addr -= layout_entries[entry].base_addr;
-			addr += layout_entries[entry].alloc_offset;
+			addr -= desc->base_addr;
+			addr += desc->alloc_offset;
 
 			/*
 			 * Add offset to pointer to FW allocation only if that
@@ -618,7 +478,7 @@ pvr_fw_process(struct pvr_device *pvr_dev)
 	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
 	struct pvr_fw_mem *fw_mem = &pvr_dev->fw_dev.mem;
 	const u8 *fw = pvr_dev->fw_dev.firmware->data;
-	const struct pvr_fw_layout_entry *private_data;
+	const struct pvr_fw_section_desc *private_data;
 	u8 *fw_code_ptr;
 	u8 *fw_data_ptr;
 	u8 *fw_core_code_ptr;
@@ -627,7 +487,7 @@ pvr_fw_process(struct pvr_device *pvr_dev)
 
 	layout_get_sizes(pvr_dev);
 
-	private_data = pvr_fw_find_private_data(pvr_dev);
+	private_data = pvr_fw_get_section_desc(pvr_dev, PVR_FW_SECTION_PRIVATE_DATA);
 	if (!private_data)
 		return -EINVAL;
 
@@ -880,28 +740,6 @@ pvr_fw_heap_info_init(struct pvr_device *pvr_dev, u32 log2_size, u32 reserved_si
 				    (PVR_ROGUE_FW_CONFIG_HEAP_SIZE + reserved_size);
 }
 
-/**
- * pvr_fw_validate_init_device_info() - Validate firmware and initialise device information
- * @pvr_dev: Target PowerVR device.
- *
- * This function must be called before querying device information.
- *
- * Returns:
- *  * 0 on success, or
- *  * -%EINVAL if firmware validation fails.
- */
-int
-pvr_fw_validate_init_device_info(struct pvr_device *pvr_dev)
-{
-	int err;
-
-	err = pvr_fw_validate(pvr_dev);
-	if (err)
-		return err;
-
-	return pvr_fw_get_device_info(pvr_dev);
-}
-
 /**
  * pvr_fw_init() - Initialise and boot firmware
  * @pvr_dev: Target PowerVR device
@@ -1549,8 +1387,8 @@ pvr_fw_info_get(const struct pvr_device *pvr_dev,
 	if (fw_info._padding_4)
 		return -EINVAL;
 
-	fw_info.major_version = pvr_dev->fw_version.major;
-	fw_info.minor_version = pvr_dev->fw_version.minor;
+	fw_info.major_version = pvr_dev->fw_dev.metadata->version.major;
+	fw_info.minor_version = pvr_dev->fw_dev.metadata->version.minor;
 
 	err = PVR_UOBJ_SET(args->pointer, args->size, fw_info);
 	if (err < 0)
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index dab8292a8479..51acefde73ee 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -4,7 +4,6 @@
 #ifndef PVR_FW_H
 #define PVR_FW_H
 
-#include "pvr_fw_info.h"
 #include "pvr_fw_trace.h"
 #include "pvr_gem.h"
 
@@ -23,6 +22,30 @@ struct pvr_vm_context;
 
 #define ROGUE_FWIF_KCCB_NUMCMDS_LOG2_DEFAULT 7
 
+extern bool pvr_exp_fw_support;
+
+/**
+ * struct pvr_fw_version - Firmware version information
+ * @major: Major version number.
+ * @minor: Minor version number.
+ * @build: Build number. This is informative only.
+ * @open_source: Whether this firmware was built with open-source driver
+ *               compatibility enabled.
+ */
+struct pvr_fw_version {
+	u16 major;
+	u16 minor;
+	u32 build;
+	bool open_source;
+};
+
+#define PVR_FW_VERSION_FMT "v%u.%u (build %u%s)"
+#define PVR_FW_VERSION_FMT_ARGS(fw_version) \
+	(fw_version)->major, (fw_version)->minor, (fw_version)->build, \
+	(fw_version)->open_source ? " OS" : ""
+
+#define PVR_FW_MAX_SUPPORTED_MAJOR_VERSION 1
+
 /**
  * struct pvr_fw_object - container for firmware memory allocations
  */
@@ -59,6 +82,57 @@ struct pvr_fw_object {
 	struct list_head node;
 };
 
+enum pvr_fw_section_name {
+	PVR_FW_SECTION_CODE = 0,
+	PVR_FW_SECTION_PRIVATE_DATA,
+	PVR_FW_SECTION_RODATA,
+	PVR_FW_SECTION_COREMEM_CODE,
+	PVR_FW_SECTION_COREMEM_DATA,
+	PVR_FW_SECTION_EXCEPTIONS_CODE,
+	PVR_FW_SECTION_BOOT_CODE,
+	PVR_FW_SECTION_BOOT_DATA,
+	PVR_FW_SECTION_STACK,
+	PVR_FW_SECTION_UNCACHED_CODE,
+	PVR_FW_SECTION_CACHED_CODE,
+
+	PVR_FW_SECTION_COUNT,
+	PVR_FW_SECTION_INVALID = -1,
+};
+
+enum pvr_fw_segment_name {
+	PVR_FW_SEGMENT_CODE = 0,
+	PVR_FW_SEGMENT_DATA,
+	PVR_FW_SEGMENT_CORE_CODE,
+	PVR_FW_SEGMENT_CORE_DATA,
+
+	PVR_FW_SEGMENT_COUNT,
+	PVR_FW_SEGMENT_INVALID = -1,
+};
+
+struct pvr_fw_section_desc {
+	enum pvr_fw_section_name name;
+	enum pvr_fw_segment_name segment;
+	u32 base_addr;
+	u32 size;
+	u32 alloc_offset;
+};
+
+#define pvr_for_each_fw_section_desc(fw_metadata, name) \
+	for (const struct pvr_fw_section_desc *name = (fw_metadata)->sections; \
+	     name < (fw_metadata)->sections + (fw_metadata)->num_sections; \
+	     name++)
+
+struct pvr_fw_metadata {
+	/** @version: Version of the loaded firmware file. */
+	struct pvr_fw_version version;
+
+	/** @num_sections: Number of section descriptors in @sections. */
+	u32 num_sections;
+
+	/** @sections: Section descriptors loaded from firmware header. */
+	struct pvr_fw_section_desc sections[] __counted_by(num_sections);
+};
+
 /**
  * struct pvr_fw_defs - FW processor function table and static definitions
  */
@@ -286,11 +360,8 @@ struct pvr_fw_device {
 	/** @firmware: Handle to the firmware loaded into the device. */
 	const struct firmware *firmware;
 
-	/** @header: Pointer to firmware header. */
-	const struct pvr_fw_info_header *header;
-
-	/** @layout_entries: Pointer to firmware layout. */
-	const struct pvr_fw_layout_entry *layout_entries;
+	/** @metadata: Metadata loaded from firmware headers. */
+	const struct pvr_fw_metadata *metadata;
 
 	/** @mem: Structure containing objects representing firmware memory allocations. */
 	struct pvr_fw_mem mem;
@@ -385,7 +456,6 @@ extern const struct pvr_fw_defs pvr_fw_defs_meta;
 extern const struct pvr_fw_defs pvr_fw_defs_mips;
 extern const struct pvr_fw_defs pvr_fw_defs_riscv;
 
-int pvr_fw_validate_init_device_info(struct pvr_device *pvr_dev);
 int pvr_fw_init(struct pvr_device *pvr_dev);
 void pvr_fw_fini(struct pvr_device *pvr_dev);
 
@@ -399,8 +469,8 @@ void pvr_fw_mts_schedule(struct pvr_device *pvr_dev, u32 val);
 void
 pvr_fw_heap_info_init(struct pvr_device *pvr_dev, u32 log2_size, u32 reserved_size);
 
-const struct pvr_fw_layout_entry *
-pvr_fw_find_layout_entry(struct pvr_device *pvr_dev, enum pvr_fw_section_id id);
+const struct pvr_fw_section_desc *
+pvr_fw_get_section_desc(struct pvr_device *pvr_dev, enum pvr_fw_section_name section);
 int
 pvr_fw_find_mmu_segment(struct pvr_device *pvr_dev, u32 addr, u32 size, void *fw_code_ptr,
 			void *fw_data_ptr, void *fw_core_code_ptr, void *fw_core_data_ptr,
@@ -485,6 +555,14 @@ pvr_fw_obj_get_object_size(struct pvr_fw_object *fw_obj)
 	return pvr_gem_object_size(fw_obj->gem);
 }
 
+/*
+ * Declared in pvr_fw_info.c, these functions represent the entire bridge
+ * between the types defined above (and in pvr_device_info.h) and the ABI types
+ * defined in pvr_fw_info.h.
+ */
+int pvr_fw_load_metadata_and_device_info(struct pvr_device *pvr_dev);
+void pvr_fw_free_metadata_and_device_info(struct pvr_device *pvr_dev);
+
 /* Util functions defined in pvr_fw_util.c. These are intended for use in pvr_fw_<arch>.c files. */
 int
 pvr_fw_process_elf_command_stream(struct pvr_device *pvr_dev, const u8 *fw, u8 *fw_code_ptr,
diff --git a/drivers/gpu/drm/imagination/pvr_fw_info.c b/drivers/gpu/drm/imagination/pvr_fw_info.c
new file mode 100644
index 000000000000..2e7e9fb291b3
--- /dev/null
+++ b/drivers/gpu/drm/imagination/pvr_fw_info.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/* Copyright (c) 2026 Imagination Technologies Ltd. */
+
+#include "pvr_device.h"
+#include "pvr_device_info.h"
+#include "pvr_fw.h"
+#include "pvr_fw_info.h"
+
+#include <drm/drm_print.h>
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/firmware.h>
+#include <linux/overflow.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+/* Forward declaration from <drm/drm_device.h> */
+struct drm_device;
+
+static enum pvr_fw_section_name
+pvr_fw_section_for_section_id(enum pvr_fw_section_id section_id)
+{
+	switch (section_id) {
+	case META_CODE:
+	case MIPS_CODE:
+		return PVR_FW_SECTION_CODE;
+	case META_PRIVATE_DATA:
+	case MIPS_PRIVATE_DATA:
+	case RISCV_PRIVATE_DATA:
+		return PVR_FW_SECTION_PRIVATE_DATA;
+	case META_COREMEM_CODE:
+	case RISCV_COREMEM_CODE:
+		return PVR_FW_SECTION_COREMEM_CODE;
+	case META_COREMEM_DATA:
+	case RISCV_COREMEM_DATA:
+		return PVR_FW_SECTION_COREMEM_DATA;
+	case MIPS_EXCEPTIONS_CODE:
+		return PVR_FW_SECTION_EXCEPTIONS_CODE;
+	case MIPS_BOOT_CODE:
+		return PVR_FW_SECTION_BOOT_CODE;
+	case MIPS_BOOT_DATA:
+		return PVR_FW_SECTION_BOOT_DATA;
+	case MIPS_STACK:
+		return PVR_FW_SECTION_STACK;
+	case RISCV_UNCACHED_CODE:
+		return PVR_FW_SECTION_UNCACHED_CODE;
+	case RISCV_CACHED_CODE:
+		return PVR_FW_SECTION_CACHED_CODE;
+	default:
+		return PVR_FW_SECTION_INVALID;
+	}
+}
+
+static enum pvr_fw_segment_name
+pvr_fw_segment_for_section_type(enum pvr_fw_section_type section_type)
+{
+	switch (section_type) {
+	case FW_CODE:
+		return PVR_FW_SEGMENT_CODE;
+	case FW_DATA:
+		return PVR_FW_SEGMENT_DATA;
+	case FW_COREMEM_CODE:
+		return PVR_FW_SEGMENT_CORE_CODE;
+	case FW_COREMEM_DATA:
+		return PVR_FW_SEGMENT_CORE_DATA;
+	default:
+		return PVR_FW_SEGMENT_INVALID;
+	}
+}
+
+static int
+pvr_fw_section_desc_for_layout_entry(struct pvr_device *pvr_dev,
+				     const struct pvr_fw_layout_entry *entry,
+				     struct pvr_fw_section_desc *section_out)
+{
+	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
+	enum pvr_fw_segment_name segment;
+	enum pvr_fw_section_name name;
+	bool invalid = false;
+	u32 end_addr;
+
+	name = pvr_fw_section_for_section_id(entry->id);
+	if (name == PVR_FW_SECTION_INVALID) {
+		drm_err(drm_dev, "Firmware section with unknown id (%u)\n",
+			entry->id);
+		invalid = true;
+	}
+
+	segment = pvr_fw_segment_for_section_type(entry->type);
+	if (segment == PVR_FW_SEGMENT_INVALID) {
+		drm_err(drm_dev, "Firmware section with unknown type (%u)\n",
+			entry->type);
+		invalid = true;
+	}
+
+	if (entry->alloc_size == 0) {
+		drm_err(drm_dev, "Firmware section is empty\n");
+		invalid = true;
+	}
+
+	if (entry->max_size < entry->alloc_size) {
+		drm_err(drm_dev, "Firmware section size mismatch (max=0x%x < alloc=0x%x)\n",
+			entry->max_size, entry->alloc_size);
+		invalid = true;
+	}
+
+	if (check_add_overflow(entry->base_addr, entry->alloc_size, &end_addr)) {
+		drm_err(drm_dev, "Firmware section size overflow (end would be 0x%llx)\n",
+			(u64)entry->base_addr + (u64)entry->alloc_size);
+		invalid = true;
+	}
+
+	if (invalid)
+		return -EINVAL;
+
+	*section_out = (struct pvr_fw_section_desc){
+		.name = name,
+		.segment = segment,
+		.base_addr = entry->base_addr,
+		.size = entry->alloc_size,
+		.alloc_offset = entry->alloc_offset,
+	};
+
+	return 0;
+}
+
+static bool
+pvr_fw_load_version(struct pvr_device *pvr_dev,
+		    const struct pvr_fw_info_header *header,
+		    struct pvr_fw_version *version_out)
+{
+	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
+	bool invalid = false;
+
+	struct pvr_fw_version version = {
+		.major = header->fw_version_major,
+		.minor = header->fw_version_minor,
+		.build = header->fw_version_build,
+		.open_source = header->flags & PVR_FW_FLAGS_OPEN_SOURCE,
+	};
+
+	if (!version.open_source) {
+		drm_err(drm_dev, "Firmware is not open-source compatible (found version " PVR_FW_VERSION_FMT ")\n",
+			PVR_FW_VERSION_FMT_ARGS(&version));
+		invalid = true;
+	}
+
+	if (version.major == 0 ||
+	    (version.major > PVR_FW_MAX_SUPPORTED_MAJOR_VERSION && !pvr_exp_fw_support) ||
+	    (version.major != PVR_FW_MAX_SUPPORTED_MAJOR_VERSION && pvr_exp_fw_support)) {
+		drm_err(drm_dev, "Firmware version is unsupported (known range is 1..%u inclusive, found "
+				 PVR_FW_VERSION_FMT ")\n",
+			PVR_FW_MAX_SUPPORTED_MAJOR_VERSION,
+			PVR_FW_VERSION_FMT_ARGS(&version));
+		invalid = true;
+	}
+
+	if (invalid)
+		return false;
+
+	*version_out = version;
+	return true;
+}
+
+static int
+pvr_fw_info_header_validate(struct pvr_device *pvr_dev,
+			    const struct pvr_fw_info_header *header,
+			    struct pvr_fw_version *fw_version_out)
+{
+	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
+	bool invalid = false;
+
+	if (header->info_version != PVR_FW_INFO_VERSION) {
+		drm_err(drm_dev,
+			"Firmware version is unsupported (known version is %u, found %u)\n",
+			PVR_FW_INFO_VERSION, header->info_version);
+		return -EINVAL;
+	}
+
+	if (header->header_len != sizeof(struct pvr_fw_info_header)) {
+		drm_err(drm_dev, "Firmware header size mismatch (found=%u, expected=%zu)\n)",
+			header->header_len, sizeof(struct pvr_fw_info_header));
+		return -EINVAL;
+	}
+
+	if (!header->layout_entry_num || !header->layout_entry_size) {
+		drm_err(drm_dev, "Firmware layout table missing\n");
+		invalid = true;
+	} else if (header->layout_entry_size != sizeof(struct pvr_fw_layout_entry)) {
+		drm_err(drm_dev,
+			"Firmware layout table entry size mismatch (found=%u, expected=%zu)\n)",
+			header->layout_entry_size, sizeof(struct pvr_fw_layout_entry));
+		invalid = true;
+	} else if (header->layout_entry_num > PVR_FW_INFO_MAX_NUM_ENTRIES) {
+		drm_err(drm_dev, "Firmware layout table is too large (found=%u, max=%u)\n)",
+			header->layout_entry_num, PVR_FW_INFO_MAX_NUM_ENTRIES);
+		invalid = true;
+	} else if (header->layout_entry_size * header->layout_entry_num >
+		   FW_BLOCK_SIZE - header->header_len) {
+		drm_err(drm_dev, "Firmware layout table is too large (computed=0x%x, max=0x%x)\n",
+			header->layout_entry_size * header->layout_entry_num,
+			FW_BLOCK_SIZE - header->header_len);
+		invalid = true;
+	}
+
+	if (pvr_gpu_id_to_packed_bvnc(&pvr_dev->gpu_id) != header->bvnc) {
+		drm_err(drm_dev,
+			"Firmware built for incorrect GPU ID " PVR_GPU_ID_FORMAT
+			" (expected " PVR_GPU_ID_FORMAT ")\n",
+			(u16)(header->bvnc >> PVR_GPU_ID_ARG_B),
+			(u16)(header->bvnc >> PVR_GPU_ID_ARG_V),
+			(u16)(header->bvnc >> PVR_GPU_ID_ARG_N),
+			(u16)(header->bvnc >> PVR_GPU_ID_ARG_C),
+			pvr_dev->gpu_id.b,
+			pvr_dev->gpu_id.v,
+			pvr_dev->gpu_id.n,
+			pvr_dev->gpu_id.c);
+		invalid = true;
+	}
+
+	if (!pvr_fw_load_version(pvr_dev, header, fw_version_out))
+		invalid = true;
+
+	if (invalid)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct pvr_fw_metadata *
+pvr_fw_load_metadata(struct pvr_device *pvr_dev, ptrdiff_t *device_info_offset_out)
+{
+	const struct firmware *firmware = pvr_dev->fw_dev.firmware;
+	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
+	const struct pvr_fw_layout_entry *layout_entries;
+	const struct pvr_fw_info_header *header;
+	struct pvr_fw_version fw_version;
+	const void *fw = firmware->data;
+	struct pvr_fw_metadata *meta;
+	ptrdiff_t header_offset;
+	int err;
+
+	if (check_sub_overflow(firmware->size, FW_BLOCK_SIZE, &header_offset)) {
+		drm_err(drm_dev, "Firmware is smaller than one block\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (firmware->size % FW_BLOCK_SIZE) {
+		drm_err(drm_dev, "Firmware size is not block-aligned\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	header = fw + header_offset;
+
+	err = pvr_fw_info_header_validate(pvr_dev, header, &fw_version);
+	if (err)
+		return ERR_PTR(err);
+
+	layout_entries = fw + header_offset + header->header_len;
+
+	meta = kzalloc_flex(*meta, sections, header->layout_entry_num);
+	if (!meta)
+		return ERR_PTR(-ENOMEM);
+
+	meta->version = fw_version;
+	meta->num_sections = header->layout_entry_num;
+
+	for (int i = 0; i < header->layout_entry_num; i++) {
+		err = pvr_fw_section_desc_for_layout_entry(pvr_dev,
+							   &layout_entries[i],
+							   &meta->sections[i]);
+		if (err)
+			goto err_free_meta;
+	}
+
+	*device_info_offset_out = header_offset - header->device_info_size;
+
+	drm_info(drm_dev, "Loaded firmware " PVR_FW_VERSION_FMT "\n",
+		 PVR_FW_VERSION_FMT_ARGS(&meta->version));
+
+	return meta;
+
+err_free_meta:
+	kfree(meta);
+
+	return ERR_PTR(err);
+}
+
+static int
+pvr_fw_get_device_info(struct pvr_device *pvr_dev, const void *device_info_ptr)
+{
+	const struct pvr_fw_device_info_header *header = device_info_ptr;
+	const u64 *dev_info = (u64 *)(header + 1);
+
+	pvr_device_info_set_quirks(pvr_dev, dev_info, header->brn_mask_size);
+	dev_info += header->brn_mask_size;
+
+	pvr_device_info_set_enhancements(pvr_dev, dev_info, header->ern_mask_size);
+	dev_info += header->ern_mask_size;
+
+	return pvr_device_info_set_features(pvr_dev, dev_info, header->feature_mask_size,
+					    header->feature_param_size);
+}
+
+/**
+ * pvr_fw_load_metadata_and_device_info() - Load firmware metadata and
+ * initialise device information
+ * @pvr_dev: Target PowerVR device.
+ *
+ * This function must be called before querying device information.
+ *
+ * Returns:
+ *  * 0 on success, or
+ *  * -%EINVAL if firmware validation fails.
+ */
+int
+pvr_fw_load_metadata_and_device_info(struct pvr_device *pvr_dev)
+{
+	const struct firmware *firmware = pvr_dev->fw_dev.firmware;
+	const struct pvr_fw_metadata *metadata;
+	ptrdiff_t device_info_offset = 0;
+
+	metadata = pvr_fw_load_metadata(pvr_dev, &device_info_offset);
+	if (IS_ERR(metadata))
+		return PTR_ERR(metadata);
+
+	pvr_dev->fw_dev.metadata = metadata;
+
+	return pvr_fw_get_device_info(pvr_dev, firmware->data + device_info_offset);
+}
+
+void
+pvr_fw_free_metadata_and_device_info(struct pvr_device *pvr_dev)
+{
+	kfree(pvr_dev->fw_dev.metadata);
+	pvr_dev->fw_dev.metadata = NULL;
+}
diff --git a/drivers/gpu/drm/imagination/pvr_fw_info.h b/drivers/gpu/drm/imagination/pvr_fw_info.h
index 3ad79c59d5b1..10c5abc840f8 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_info.h
+++ b/drivers/gpu/drm/imagination/pvr_fw_info.h
@@ -17,6 +17,12 @@
 /* Maximum number of entries in firmware layout table. */
 #define PVR_FW_INFO_MAX_NUM_ENTRIES 8
 
+#define PVR_GPU_ID_FORMAT "%u.%u.%u.%u"
+#define PVR_GPU_ID_ARG_B 48
+#define PVR_GPU_ID_ARG_V 32
+#define PVR_GPU_ID_ARG_N 16
+#define PVR_GPU_ID_ARG_C 0
+
 enum pvr_fw_section_id {
 	META_CODE = 0,
 	META_PRIVATE_DATA,
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 74a0e4d255c3..9cbeb226527a 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -3,7 +3,6 @@
 
 #include "pvr_device.h"
 #include "pvr_fw.h"
-#include "pvr_fw_info.h"
 #include "pvr_fw_meta.h"
 #include "pvr_gem.h"
 #include "pvr_rogue_cr_defs.h"
@@ -360,32 +359,26 @@ configure_seg_id(u64 seg_out_addr, u32 seg_base, u32 seg_limit, u32 seg_id,
 static void
 configure_seg_mmu(struct pvr_device *pvr_dev, u32 **boot_conf_ptr)
 {
-	const struct pvr_fw_layout_entry *layout_entries = pvr_dev->fw_dev.layout_entries;
-	u32 num_layout_entries = pvr_dev->fw_dev.header->layout_entry_num;
-	u64 seg_out_addr_top;
-
-	seg_out_addr_top =
+	u64 seg_out_addr_top =
 		ROGUE_FW_SEGMMU_OUTADDR_TOP_SLC(MMU_CONTEXT_MAPPING_FWPRIV,
 						ROGUE_FW_SEGMMU_META_BIFDM_ID);
 
-	for (u32 i = 0; i < num_layout_entries; i++) {
+	pvr_for_each_fw_section_desc(pvr_dev->fw_dev.metadata, desc) {
 		/*
 		 * FW code is using the bootloader segment which is already
 		 * configured on boot. FW coremem code and data don't use the
 		 * segment MMU. Only the FW data segment needs to be configured.
 		 */
-		if (layout_entries[i].type == FW_DATA) {
+		if (desc->segment == PVR_FW_SEGMENT_DATA) {
 			u32 seg_id = ROGUE_FW_SEGMMU_DATA_ID;
 			u64 seg_out_addr = pvr_fw_obj_get_gpu_addr(pvr_dev->fw_dev.mem.data_obj);
 
-			seg_out_addr += layout_entries[i].alloc_offset;
+			seg_out_addr += desc->alloc_offset;
 			seg_out_addr |= seg_out_addr_top;
 
 			/* Write the sequence to the bootldr. */
-			configure_seg_id(seg_out_addr,
-					 layout_entries[i].base_addr,
-					 layout_entries[i].alloc_size, seg_id,
-					 boot_conf_ptr);
+			configure_seg_id(seg_out_addr, desc->base_addr,
+					 desc->size, seg_id, boot_conf_ptr);
 
 			break;
 		}
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.c b/drivers/gpu/drm/imagination/pvr_fw_mips.c
index 6914fc46db50..619bc844447b 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips.c
@@ -35,11 +35,11 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 		    u32 core_code_alloc_size)
 {
 	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
-	struct pvr_fw_mips_data *mips_data = fw_dev->processor_data.mips_data;
-	const struct pvr_fw_layout_entry *boot_code_entry;
-	const struct pvr_fw_layout_entry *boot_data_entry;
-	const struct pvr_fw_layout_entry *exception_code_entry;
-	const struct pvr_fw_layout_entry *stack_entry;
+	struct pvr_fw_mips_data *fw_data = fw_dev->processor_data.mips_data;
+	const struct pvr_fw_section_desc *boot_code_entry;
+	const struct pvr_fw_section_desc *boot_data_entry;
+	const struct pvr_fw_section_desc *exception_code_entry;
+	const struct pvr_fw_section_desc *stack_entry;
 	struct rogue_mipsfw_boot_data *boot_data;
 	dma_addr_t dma_addr;
 	int err;
@@ -49,21 +49,21 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 	if (err)
 		return err;
 
-	boot_code_entry = pvr_fw_find_layout_entry(pvr_dev, MIPS_BOOT_CODE);
-	boot_data_entry = pvr_fw_find_layout_entry(pvr_dev, MIPS_BOOT_DATA);
-	exception_code_entry = pvr_fw_find_layout_entry(pvr_dev, MIPS_EXCEPTIONS_CODE);
+	boot_code_entry = pvr_fw_get_section_desc(pvr_dev, PVR_FW_SECTION_BOOT_CODE);
+	boot_data_entry = pvr_fw_get_section_desc(pvr_dev, PVR_FW_SECTION_BOOT_DATA);
+	exception_code_entry = pvr_fw_get_section_desc(pvr_dev, PVR_FW_SECTION_EXCEPTIONS_CODE);
 	if (!boot_code_entry || !boot_data_entry || !exception_code_entry)
 		return -EINVAL;
 
 	WARN_ON(pvr_gem_get_dma_addr(fw_dev->mem.code_obj->gem, boot_code_entry->alloc_offset,
-				     &mips_data->boot_code_dma_addr));
+				     &fw_data->boot_code_dma_addr));
 	WARN_ON(pvr_gem_get_dma_addr(fw_dev->mem.data_obj->gem, boot_data_entry->alloc_offset,
-				     &mips_data->boot_data_dma_addr));
+				     &fw_data->boot_data_dma_addr));
 	WARN_ON(pvr_gem_get_dma_addr(fw_dev->mem.code_obj->gem,
 				     exception_code_entry->alloc_offset,
-				     &mips_data->exception_code_dma_addr));
+				     &fw_data->exception_code_dma_addr));
 
-	stack_entry = pvr_fw_find_layout_entry(pvr_dev, MIPS_STACK);
+	stack_entry = pvr_fw_get_section_desc(pvr_dev, PVR_FW_SECTION_STACK);
 	if (!stack_entry)
 		return -EINVAL;
 
@@ -81,7 +81,7 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 		u32 src_page_nr = (page_nr * ROGUE_MIPSFW_PAGE_SIZE_4K) >> PAGE_SHIFT;
 		u32 page_offset = (page_nr * ROGUE_MIPSFW_PAGE_SIZE_4K) & ~PAGE_MASK;
 
-		boot_data->pt_phys_addr[page_nr] = mips_data->pt_dma_addr[src_page_nr] +
+		boot_data->pt_phys_addr[page_nr] = fw_data->pt_dma_addr[src_page_nr] +
 						   page_offset;
 	}
 
diff --git a/drivers/gpu/drm/imagination/pvr_fw_riscv.c b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
index cd84635bb88d..c59716870677 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_riscv.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
@@ -3,7 +3,6 @@
 
 #include "pvr_device.h"
 #include "pvr_fw.h"
-#include "pvr_fw_info.h"
 #include "pvr_fw_mips.h"
 #include "pvr_gem.h"
 #include "pvr_rogue_cr_defs.h"

-- 
2.43.0

