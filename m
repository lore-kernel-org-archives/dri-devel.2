Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33664606A336
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=lJPBXJxQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CDB210FBED;
	Wed, 25 Nov 2026 11:50:09 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC8AE10FBEC;
 Wed, 25 Nov 2026 11:49:27 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AP7prcx1962352; Wed, 25 Nov 2026 11:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=6
 GeNEbq7r01eAzuO/o7ZHhKP8Tw4FobRuuX8tJiySOQ=; b=lJPBXJxQRSexMrKit
 vF9Z2nI6JLgKoJzXrrI0jmhGAineIqw3CcUQiVv//kvQHeOsJap751IXttselG8J
 ntC6+pbaUmNeQFfo7HP230X6jDuc2u3H0OrI9LXns7oi7PT9EZ6OeEtgyh//pUez
 pSjRAzRcqUsLwPCiqymXHzsuSp6qCCuM7YIxb3WjZLm5xk0UZbbxPfxcGEGXrQiJ
 hQrOiLeYj++UDg4y66BLSbGN9lstFqisEBcwY+3Md93H5uT3OJwyGojA5dQJIOxn
 cUwnYu1ixS0j8SZFxOy7khK3sRWKQE3NdkQKJ/gUpd8VIOxMlRGtc7+Uw00r4XgQ
 9FAtQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4j3491kdyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Wed, 25 Nov 2026 11:49:03 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.203) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 11:49:01 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 25 Nov 2026 13:48:32 +0200
Subject: [PATCH 4/6] drm/imagination: Release firmware after init
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261125-b4-commonize-fw-segment-loading-v1-4-69657fa52ac3@imgtec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795607333; l=15663;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=d8DElYq/Qo8pfnaM9PWAtbx99yMV0vHjo1S4Aixy8OI=;
 b=mWI6jdeCYJyi2HAEIvUEhV0i5c7ylhd016wD9+jYorbSBcSPnoPudmFBQY0LGOa0sdLkUZ7aQ
 HdWkztEbPowCMS7yyrpLkFc3PoX6pGkloV0Rdk+Tt55gXxIbvg9pyHC
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX5yTbctgGKFfk
 I2vqoPoYSRgNIvQbwwyw4I9zEmcFlqmRrdNqWjyY0AGKG7ixrG0BSW6TN1DG2d01p/B0UsRdcXc
 DxJy8JBtAq9LsQE1mg3Nm5LAhza1rYcA1W05QI+cUifO5/CgNPPYuBFmi6zi6Gt17EB4iqwA+OB
 0srNQnkhLcgA/8owiTRkMu8Yc6/tVA1PGGQDqZ4fQ35F8wQE1H8IjWxefMDmYi5aJW666cC3EZ6
 rmgtOrHPP9CbAer4kJOvp6H0U9seBZoMO+u7HgNA68FDpMa9k75sPH7pNXDSWkJ94Q/Muzu489N
 zi7eM5f2HAoRO6bLZ2sHWRfFanr53FsfcYS3lqNgaDW1vt/1SRZPWF5QduV+yre+mA9HTTVkfsm
 V9RGOvf73lGByIZN+OBIjaXXwHh9ZFGD6LPFloSAM7SsyNFATm5i4j1UqKUzx7GPeOvicZYlC0e
 jCx37ANs0fHIBGDY/Pw==
X-Authority-Analysis: v=2.4 cv=OaENnRTY c=1 sm=1 tr=0 ts=6b06cb30 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=4EFqt8Tv61wA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=3AcfmgCRP9rg5UOldR8A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX9zbQcQmSCJLX
 8PyjzDFPnqaq8y0Uka88EzvQXfjF5JKLT7nj5Tnq6HTXHFfF41g9e3o0ZlEYqBPwDNYQKWWwFKk
 Z3T8GEN/bjRBlQ+ITSFPAIq1XUNcT2M=
X-Proofpoint-GUID: Nb6S_sm0LJb9bRYmdvAJaSdQ6GpwuXNT
X-Proofpoint-ORIG-GUID: Nb6S_sm0LJb9bRYmdvAJaSdQ6GpwuXNT
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

There's no need to keep a struct firmware instance around after the
initial firmware load, as we've already copied everything we need out of
there during processing.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_device.c   | 58 +++++++++++++++---------------
 drivers/gpu/drm/imagination/pvr_fw.c       | 11 +++---
 drivers/gpu/drm/imagination/pvr_fw.h       | 15 ++++----
 drivers/gpu/drm/imagination/pvr_fw_info.c  | 11 +++---
 drivers/gpu/drm/imagination/pvr_fw_meta.c  | 13 ++++---
 drivers/gpu/drm/imagination/pvr_fw_mips.c  |  5 +--
 drivers/gpu/drm/imagination/pvr_fw_riscv.c |  4 +--
 7 files changed, 63 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 0c4832d2cce1..210eeb91f4ec 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -350,14 +350,6 @@ pvr_build_firmware_filename(struct pvr_device *pvr_dev, const char *base,
 			 gpu_id->v, gpu_id->n, gpu_id->c, major);
 }
 
-static void
-pvr_release_firmware(void *data)
-{
-	struct pvr_device *pvr_dev = data;
-
-	release_firmware(pvr_dev->fw_dev.firmware);
-}
-
 /**
  * pvr_request_firmware() - Load firmware for a PowerVR device
  * @pvr_dev: Target PowerVR device.
@@ -365,11 +357,11 @@ pvr_release_firmware(void *data)
  * See pvr_build_firmware_filename() for details on firmware file naming.
  *
  * Return:
- *  * 0 on success,
+ *  * A pointer to the loaded firmware on success,
  *  * Any error returned by pvr_build_firmware_filename(), or
  *  * Any error returned by request_firmware().
  */
-static int
+static const struct firmware *
 pvr_request_firmware(struct pvr_device *pvr_dev)
 {
 	struct drm_device *drm_dev = &pvr_dev->base;
@@ -380,7 +372,7 @@ pvr_request_firmware(struct pvr_device *pvr_dev)
 	filename = pvr_build_firmware_filename(pvr_dev, "powervr/rogue",
 					       PVR_FW_VERSION_MAJOR);
 	if (!filename)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	/*
 	 * This function takes a copy of &filename, meaning we can free our
@@ -396,14 +388,12 @@ pvr_request_firmware(struct pvr_device *pvr_dev)
 	drm_info(drm_dev, "loaded firmware %s\n", filename);
 	kfree(filename);
 
-	pvr_dev->fw_dev.firmware = fw;
-
-	return devm_add_action_or_reset(drm_dev->dev, pvr_release_firmware, pvr_dev);
+	return fw;
 
 err_free_filename:
 	kfree(filename);
 
-	return err;
+	return ERR_PTR(err);
 }
 
 /**
@@ -701,40 +691,52 @@ pvr_device_info_validate(struct pvr_device *pvr_dev)
 static int
 pvr_device_gpu_init(struct pvr_device *pvr_dev)
 {
+	const struct firmware *firmware;
 	int err;
 
 	err = pvr_load_gpu_id(pvr_dev);
 	if (err)
 		return err;
 
-	err = pvr_request_firmware(pvr_dev);
-	if (err)
-		return err;
+	firmware = pvr_request_firmware(pvr_dev);
+	if (IS_ERR(firmware))
+		return PTR_ERR(firmware);
 
-	err = pvr_fw_load_metadata_and_device_info(pvr_dev);
+	err = pvr_fw_load_metadata_and_device_info(pvr_dev, firmware);
 	if (err)
-		return err;
+		goto out_release_firmware;
 
-	if (PVR_HAS_FEATURE(pvr_dev, meta))
+	if (PVR_HAS_FEATURE(pvr_dev, meta)) {
 		pvr_dev->fw_dev.processor_type = PVR_FW_PROCESSOR_TYPE_META;
-	else if (PVR_HAS_FEATURE(pvr_dev, mips))
+	} else if (PVR_HAS_FEATURE(pvr_dev, mips)) {
 		pvr_dev->fw_dev.processor_type = PVR_FW_PROCESSOR_TYPE_MIPS;
-	else if (PVR_HAS_FEATURE(pvr_dev, riscv_fw_processor))
+	} else if (PVR_HAS_FEATURE(pvr_dev, riscv_fw_processor)) {
 		pvr_dev->fw_dev.processor_type = PVR_FW_PROCESSOR_TYPE_RISCV;
-	else
-		return -EINVAL;
+	} else {
+		err = -EINVAL;
+		goto out_release_firmware;
+	}
 
 	err = pvr_device_info_validate(pvr_dev);
 	if (err)
-		return err;
+		goto out_release_firmware;
 
 	pvr_stream_create_musthave_masks(pvr_dev);
 
 	err = pvr_set_dma_info(pvr_dev);
 	if (err)
-		return err;
+		goto out_release_firmware;
 
-	return pvr_fw_init(pvr_dev);
+	err = pvr_fw_init(pvr_dev, firmware);
+	if (err)
+		goto out_release_firmware;
+
+	err = 0;
+
+out_release_firmware:
+	release_firmware(firmware);
+
+	return err;
 }
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index 2a5dcd9aeed7..4e082f83cff0 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -466,6 +466,7 @@ pvr_fw_destroy_structures(struct pvr_device *pvr_dev)
  * pvr_fw_process() - Process firmware image, allocate FW memory and create boot
  *                    arguments
  * @pvr_dev: Device pointer.
+ * @firmware: Firmware to process
  *
  * Returns:
  *  * 0 on success, or
@@ -473,11 +474,10 @@ pvr_fw_destroy_structures(struct pvr_device *pvr_dev)
  *  * Any error returned by pvr_fw_object_create_and_map().
  */
 static int
-pvr_fw_process(struct pvr_device *pvr_dev)
+pvr_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware)
 {
 	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
 	struct pvr_fw_mem *fw_mem = &pvr_dev->fw_dev.mem;
-	const u8 *fw = pvr_dev->fw_dev.firmware->data;
 	const struct pvr_fw_section_desc *private_data;
 	u8 *fw_code_ptr;
 	u8 *fw_data_ptr;
@@ -572,7 +572,7 @@ pvr_fw_process(struct pvr_device *pvr_dev)
 		goto err_free_kdata;
 	}
 
-	err = pvr_dev->fw_dev.defs->fw_process(pvr_dev, fw,
+	err = pvr_dev->fw_dev.defs->fw_process(pvr_dev, firmware,
 					       fw_mem->code, fw_mem->data, fw_mem->core_code,
 					       fw_mem->core_data, fw_mem->core_code_alloc_size);
 
@@ -743,6 +743,7 @@ pvr_fw_heap_info_init(struct pvr_device *pvr_dev, u32 log2_size, u32 reserved_si
 /**
  * pvr_fw_init() - Initialise and boot firmware
  * @pvr_dev: Target PowerVR device
+ * @firmware: Firmware to load
  *
  * On successful completion of the function the PowerVR device will be
  * initialised and ready to use.
@@ -754,7 +755,7 @@ pvr_fw_heap_info_init(struct pvr_device *pvr_dev, u32 log2_size, u32 reserved_si
  *  * -%ETIMEDOUT if firmware processor fails to boot or on register poll timeout.
  */
 int
-pvr_fw_init(struct pvr_device *pvr_dev)
+pvr_fw_init(struct pvr_device *pvr_dev, const struct firmware *firmware)
 {
 	static const struct pvr_fw_defs *fw_defs[PVR_FW_PROCESSOR_TYPE_COUNT] = {
 		[PVR_FW_PROCESSOR_TYPE_META] = &pvr_fw_defs_meta,
@@ -783,7 +784,7 @@ pvr_fw_init(struct pvr_device *pvr_dev)
 	if (err)
 		goto err_mm_takedown;
 
-	err = pvr_fw_process(pvr_dev);
+	err = pvr_fw_process(pvr_dev, firmware);
 	if (err)
 		goto err_mm_takedown;
 
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index 51acefde73ee..45b38d9072a1 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -18,6 +18,9 @@ struct pvr_file;
 /* Forward declaration from "pvr_vm.h". */
 struct pvr_vm_context;
 
+/* Forward declaration from <linux/firmware.h> */
+struct firmware;
+
 #define ROGUE_FWIF_FWCCB_NUMCMDS_LOG2 5
 
 #define ROGUE_FWIF_KCCB_NUMCMDS_LOG2_DEFAULT 7
@@ -169,7 +172,7 @@ struct pvr_fw_defs {
 	 *
 	 * Load and process firmware image.
 	 * @pvr_dev: Target PowerVR device.
-	 * @fw: Pointer to firmware image.
+	 * @firmware: Pointer to firmware image.
 	 * @fw_code_ptr: Pointer to firmware code section.
 	 * @fw_data_ptr: Pointer to firmware data section.
 	 * @fw_core_code_ptr: Pointer to firmware core code section. May be %NULL.
@@ -182,7 +185,7 @@ struct pvr_fw_defs {
 	 *  * 0 on success, or
 	 *  * Any appropriate error on failure.
 	 */
-	int (*fw_process)(struct pvr_device *pvr_dev, const u8 *fw,
+	int (*fw_process)(struct pvr_device *pvr_dev, const struct firmware *firmware,
 			  u8 *fw_code_ptr, u8 *fw_data_ptr, u8 *fw_core_code_ptr,
 			  u8 *fw_core_data_ptr, u32 core_code_alloc_size);
 
@@ -357,9 +360,6 @@ struct pvr_fw_mem {
 };
 
 struct pvr_fw_device {
-	/** @firmware: Handle to the firmware loaded into the device. */
-	const struct firmware *firmware;
-
 	/** @metadata: Metadata loaded from firmware headers. */
 	const struct pvr_fw_metadata *metadata;
 
@@ -456,7 +456,7 @@ extern const struct pvr_fw_defs pvr_fw_defs_meta;
 extern const struct pvr_fw_defs pvr_fw_defs_mips;
 extern const struct pvr_fw_defs pvr_fw_defs_riscv;
 
-int pvr_fw_init(struct pvr_device *pvr_dev);
+int pvr_fw_init(struct pvr_device *pvr_dev, const struct firmware *firmware);
 void pvr_fw_fini(struct pvr_device *pvr_dev);
 
 int pvr_wait_for_fw_boot(struct pvr_device *pvr_dev);
@@ -560,7 +560,8 @@ pvr_fw_obj_get_object_size(struct pvr_fw_object *fw_obj)
  * between the types defined above (and in pvr_device_info.h) and the ABI types
  * defined in pvr_fw_info.h.
  */
-int pvr_fw_load_metadata_and_device_info(struct pvr_device *pvr_dev);
+int pvr_fw_load_metadata_and_device_info(struct pvr_device *pvr_dev,
+					 const struct firmware *firmware);
 void pvr_fw_free_metadata_and_device_info(struct pvr_device *pvr_dev);
 
 /* Util functions defined in pvr_fw_util.c. These are intended for use in pvr_fw_<arch>.c files. */
diff --git a/drivers/gpu/drm/imagination/pvr_fw_info.c b/drivers/gpu/drm/imagination/pvr_fw_info.c
index 2e7e9fb291b3..2964952c19c4 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_info.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_info.c
@@ -229,9 +229,9 @@ pvr_fw_info_header_validate(struct pvr_device *pvr_dev,
 }
 
 static const struct pvr_fw_metadata *
-pvr_fw_load_metadata(struct pvr_device *pvr_dev, ptrdiff_t *device_info_offset_out)
+pvr_fw_load_metadata(struct pvr_device *pvr_dev, const struct firmware *firmware,
+		     ptrdiff_t *device_info_offset_out)
 {
-	const struct firmware *firmware = pvr_dev->fw_dev.firmware;
 	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
 	const struct pvr_fw_layout_entry *layout_entries;
 	const struct pvr_fw_info_header *header;
@@ -307,6 +307,7 @@ pvr_fw_get_device_info(struct pvr_device *pvr_dev, const void *device_info_ptr)
  * pvr_fw_load_metadata_and_device_info() - Load firmware metadata and
  * initialise device information
  * @pvr_dev: Target PowerVR device.
+ * @firmware: Firmware to load from.
  *
  * This function must be called before querying device information.
  *
@@ -315,13 +316,13 @@ pvr_fw_get_device_info(struct pvr_device *pvr_dev, const void *device_info_ptr)
  *  * -%EINVAL if firmware validation fails.
  */
 int
-pvr_fw_load_metadata_and_device_info(struct pvr_device *pvr_dev)
+pvr_fw_load_metadata_and_device_info(struct pvr_device *pvr_dev,
+				     const struct firmware *firmware)
 {
-	const struct firmware *firmware = pvr_dev->fw_dev.firmware;
 	const struct pvr_fw_metadata *metadata;
 	ptrdiff_t device_info_offset = 0;
 
-	metadata = pvr_fw_load_metadata(pvr_dev, &device_info_offset);
+	metadata = pvr_fw_load_metadata(pvr_dev, firmware, &device_info_offset);
 	if (IS_ERR(metadata))
 		return PTR_ERR(metadata);
 
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 9cbeb226527a..8b231df27a60 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -239,7 +239,7 @@ meta_ldr_cmd_config(struct drm_device *drm_dev, const u8 *fw,
  * process_ldr_command_stream() - Process LDR firmware image and populate
  *                                firmware sections
  * @pvr_dev: Device pointer.
- * @fw: Pointer to firmware image.
+ * @firmware: Pointer to firmware image.
  * @fw_code_ptr: Pointer to FW code section.
  * @fw_data_ptr: Pointer to FW data section.
  * @fw_core_code_ptr: Pointer to FW coremem code section.
@@ -251,16 +251,18 @@ meta_ldr_cmd_config(struct drm_device *drm_dev, const u8 *fw,
  *  * -EINVAL on any error in LDR command stream.
  */
 static int
-process_ldr_command_stream(struct pvr_device *pvr_dev, const u8 *fw, u8 *fw_code_ptr,
+process_ldr_command_stream(struct pvr_device *pvr_dev,
+			   const struct firmware *firmware, u8 *fw_code_ptr,
 			   u8 *fw_data_ptr, u8 *fw_core_code_ptr,
 			   u8 *fw_core_data_ptr, u32 **boot_conf_ptr)
 {
 	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
+	const u8 *fw = firmware->data;
 	struct rogue_meta_ldr_block_hdr *ldr_header =
 		(struct rogue_meta_ldr_block_hdr *)fw;
 	struct rogue_meta_ldr_l1_data_blk *l1_data =
 		(struct rogue_meta_ldr_l1_data_blk *)(fw + ldr_header->sl_data);
-	const u32 fw_size = pvr_dev->fw_dev.firmware->size;
+	const u32 fw_size = firmware->size;
 	int err;
 
 	u32 *boot_conf = boot_conf_ptr ? *boot_conf_ptr : NULL;
@@ -438,7 +440,7 @@ configure_meta_caches(u32 **boot_conf_ptr)
 }
 
 static int
-pvr_meta_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
+pvr_meta_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware,
 		    u8 *fw_code_ptr, u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr,
 		    u32 core_code_alloc_size)
 {
@@ -455,7 +457,8 @@ pvr_meta_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 	configure_seg_mmu(pvr_dev, &boot_conf);
 
 	/* Populate FW sections from LDR image. */
-	err = process_ldr_command_stream(pvr_dev, fw, fw_code_ptr, fw_data_ptr, fw_core_code_ptr,
+	err = process_ldr_command_stream(pvr_dev, firmware, fw_code_ptr,
+					 fw_data_ptr, fw_core_code_ptr,
 					 fw_core_data_ptr, &boot_conf);
 	if (err)
 		return err;
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.c b/drivers/gpu/drm/imagination/pvr_fw_mips.c
index 619bc844447b..db89a9bc50a9 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips.c
@@ -9,6 +9,7 @@
 #include "pvr_vm_mips.h"
 
 #include <linux/err.h>
+#include <linux/firmware.h>
 #include <linux/types.h>
 
 #define ROGUE_FW_HEAP_MIPS_BASE 0xC0000000
@@ -30,7 +31,7 @@ pvr_mips_fini(struct pvr_device *pvr_dev)
 }
 
 static int
-pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
+pvr_mips_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware,
 		    u8 *fw_code_ptr, u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr,
 		    u32 core_code_alloc_size)
 {
@@ -44,7 +45,7 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 	dma_addr_t dma_addr;
 	int err;
 
-	err = pvr_fw_process_elf_command_stream(pvr_dev, fw, fw_code_ptr, fw_data_ptr,
+	err = pvr_fw_process_elf_command_stream(pvr_dev, firmware->data, fw_code_ptr, fw_data_ptr,
 						fw_core_code_ptr, fw_core_data_ptr);
 	if (err)
 		return err;
diff --git a/drivers/gpu/drm/imagination/pvr_fw_riscv.c b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
index c59716870677..a88a2b87f61e 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_riscv.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
@@ -69,7 +69,7 @@ struct rogue_riscv_fw_boot_data {
 };
 
 static int
-pvr_riscv_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
+pvr_riscv_fw_process(struct pvr_device *pvr_dev, const struct firmware *firmware,
 		     u8 *fw_code_ptr, u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr,
 		     u32 core_code_alloc_size)
 {
@@ -78,7 +78,7 @@ pvr_riscv_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 	struct rogue_riscv_fw_boot_data *boot_data;
 	int err;
 
-	err = pvr_fw_process_elf_command_stream(pvr_dev, fw, fw_code_ptr, fw_data_ptr,
+	err = pvr_fw_process_elf_command_stream(pvr_dev, firmware->data, fw_code_ptr, fw_data_ptr,
 						fw_core_code_ptr, fw_core_data_ptr);
 	if (err)
 		goto err_out;

-- 
2.43.0

