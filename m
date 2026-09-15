Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031BDC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA63B10F340;
	Tue, 15 Sep 2026 08:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="v21lziyf";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD1710FAE3;
 Tue, 15 Sep 2026 08:04:18 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F6Yfbs2004317; Tue, 15 Sep 2026 09:04:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=g
 t8CFlTZ8f2cjImnjHsOKyv54nZJ16Xn11i4nyYU8co=; b=v21lziyfqbECbUlE6
 zEWVSm8defp2OGcwNrlLohwt+4vlktsZPMprjmLKxBk1jy3HZzj/+d66ch2TyZZS
 pIqeHSHDZh3XFCkEuPDLVHuddm9ojP2V40RKaL0l6SyG7AGz5qGv0gJ+B0+DH3Ij
 mGlUfASViVS2qbbzcMeWF487oVv0nhvo6G4hknNNRzfesvRhhVFYcJmSWYKNyxsU
 F5Nn9fwAk1c4Hf4slq8WflPRtOTTCFwOHzfTyFwhLV4Yvq3l61i6pYzkjvNk2VWI
 bd/ZBxf0/jCoh/V0pv9IY573JliZLfd7gFQI9LuD1madRm8tFXluFi6em9VtH5yG
 qv2Lg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtujca9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 09:04:06 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.88) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 15 Sep
 2026 09:04:04 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Tue, 15 Sep 2026 11:03:46 +0300
Subject: [PATCH 2/2] drm/imagination: Don't map FW interface structures
 unnecessarily
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260915-b4-do-not-map-if-structs-unnecessarily-v1-2-a0e2ccee154a@imgtec.com>
References: <20260915-b4-do-not-map-if-structs-unnecessarily-v1-0-a0e2ccee154a@imgtec.com>
In-Reply-To: <20260915-b4-do-not-map-if-structs-unnecessarily-v1-0-a0e2ccee154a@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789459442; l=8607;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=TSvRkcCjfXhus5FZdojub+lNae7bXbvLSXaDKaZJ+dg=;
 b=/dWD8nNleg0HdNBapX53iZ/J64UVcJV6W93uaVboxfUd5czpqtuQOvEeRrzxA/NqLzedHYpYp
 6Mdp9TvFud5BQkri3l03c6xGnIg/97x4MWbozSbBAgezCjrYbsTbmVm
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.88]
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aa8fbf6 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=YP7Kpn5otooA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=Z8F9gRzKEWkVkQCTrYAA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: SCXy-ITqIdzmh4r76-W9gU9OWU6OFAlB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDExNSBTYWx0ZWRfXyJ1z7twm4z8K
 KQ8Npue7cHZL5v1gIWE4XUQQ0PQcDj6Hk+UvQnwWHWWH2SY1tQ+GvTKeFBwe50CY5vsXaoI9Ps3
 arQiTHOp1bg3F5yj45d7g/cV9vrUOkxiEHyoI01URPstftVSdsAhZ0pLlpbID2FLrAYKCcExa6P
 qfRg/KTuFzlG43kLa8pwguL9oi3mwM7+xgW03U0ompiPyaYD0Wp/cla4ScxxWPISXnBcoWjzB9s
 vc8W41CVjsFzwAsx/YbyT8V20SZNCDlj9SR0EWc8miPQqHono+WxtR7Weu/VciNWbYivF3VVVe7
 ibB4FfO8azQQTf0h3PxGEVxOG9JTiQwK8JBTwrSL3/d0LnP+30z3f00+i7Jz6kA/cCRitaTyWk/
 gtFwKCrsgK34JAd2GDBWEiSFyPvaba8/aI3TJRxA3zvb0kFV3jEujliWT5eBiYKp5AH/VvwYAZR
 j69DRpWE8q/0g4VfKSQ==
X-Proofpoint-GUID: SCXy-ITqIdzmh4r76-W9gU9OWU6OFAlB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDExNSBTYWx0ZWRfX/sbpqAw61ING
 cmEcYlclFWi2OOMrFROxN0ulOBSS9hilfDV+hoFW+gbMLOKWbsgNCTw/hON3Ix5ApTgf3Up3xin
 Ks66F3ivRngR/3NcQtADYYuSgZo+uj0=
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

From: Alessio Belle <alessio.belle@imgtec.com>

Connection control, OS init and HWR info buffer structures are
currently not accessed by the driver during or after firmware
initialisation.
OS init is accessed during hard reset, but the common hard reset logic
already takes care of temporarily mapping it again.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw.c | 97 ++++++++++++++++++++++++------------
 drivers/gpu/drm/imagination/pvr_fw.h | 18 +++----
 2 files changed, 72 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index b2a5ea001474..ad5e8d68defe 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -428,19 +428,17 @@ pvr_fw_create_structures(struct pvr_device *pvr_dev)
 	struct pvr_fw_mem *fw_mem = &fw_dev->mem;
 	int err;
 
-	fw_dev->fwif_connection_ctl =
-		pvr_fw_object_create_and_map_offset(pvr_dev,
-						    fw_dev->fw_heap_info.config_offset +
-						    PVR_ROGUE_FWIF_CONNECTION_CTL_OFFSET,
-						    sizeof(*fw_dev->fwif_connection_ctl),
-						    PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
-						    NULL, NULL,
-						    &fw_mem->fwif_connection_ctl_obj);
-
-	if (IS_ERR(fw_dev->fwif_connection_ctl)) {
+	err = pvr_fw_object_create_offset(pvr_dev,
+					  fw_dev->fw_heap_info.config_offset +
+					  PVR_ROGUE_FWIF_CONNECTION_CTL_OFFSET,
+					  sizeof(struct rogue_fwif_connection_ctl),
+					  PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
+					  NULL, NULL,
+					  &fw_mem->fwif_connection_ctl_obj);
+	if (err) {
 		drm_err(drm_dev,
 			"Unable to allocate FWIF connection control memory\n");
-		return PTR_ERR(fw_dev->fwif_connection_ctl);
+		return err;
 	}
 
 	fw_dev->power_sync = pvr_fw_object_create_and_map(pvr_dev, sizeof(*fw_dev->power_sync),
@@ -452,13 +450,12 @@ pvr_fw_create_structures(struct pvr_device *pvr_dev)
 		goto err_release_connection_ctl;
 	}
 
-	fw_dev->hwrinfobuf = pvr_fw_object_create_and_map(pvr_dev, sizeof(*fw_dev->hwrinfobuf),
-							  PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
-							  NULL, NULL, &fw_mem->hwrinfobuf_obj);
-	if (IS_ERR(fw_dev->hwrinfobuf)) {
+	err = pvr_fw_object_create(pvr_dev, sizeof(struct rogue_fwif_hwrinfobuf),
+				   PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
+				   NULL, NULL, &fw_mem->hwrinfobuf_obj);
+	if (err) {
 		drm_err(drm_dev,
 			"Unable to allocate FW hwrinfobuf structure\n");
-		err = PTR_ERR(fw_dev->hwrinfobuf);
 		goto err_release_power_sync;
 	}
 
@@ -521,16 +518,14 @@ pvr_fw_create_structures(struct pvr_device *pvr_dev)
 		goto err_fw_trace_fini;
 	}
 
-	fw_dev->fwif_osinit =
-		pvr_fw_object_create_and_map_offset(pvr_dev,
-						    fw_dev->fw_heap_info.config_offset +
-						    PVR_ROGUE_FWIF_OSINIT_OFFSET,
-						    sizeof(*fw_dev->fwif_osinit),
-						    PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
-						    fw_osinit_init, pvr_dev, &fw_mem->osinit_obj);
-	if (IS_ERR(fw_dev->fwif_osinit)) {
+	err = pvr_fw_object_create_offset(pvr_dev,
+					  fw_dev->fw_heap_info.config_offset +
+					  PVR_ROGUE_FWIF_OSINIT_OFFSET,
+					  sizeof(struct rogue_fwif_osinit),
+					  PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
+					  fw_osinit_init, pvr_dev, &fw_mem->osinit_obj);
+	if (err) {
 		drm_err(drm_dev, "Unable to allocate FW OSINIT structure\n");
-		err = PTR_ERR(fw_dev->fwif_osinit);
 		goto err_release_osdata;
 	}
 
@@ -550,7 +545,7 @@ pvr_fw_create_structures(struct pvr_device *pvr_dev)
 	return 0;
 
 err_release_osinit:
-	pvr_fw_object_unmap_and_destroy(fw_mem->osinit_obj);
+	pvr_fw_object_destroy(fw_mem->osinit_obj);
 
 err_release_osdata:
 	pvr_fw_object_unmap_and_destroy(fw_mem->osdata_obj);
@@ -574,13 +569,13 @@ pvr_fw_create_structures(struct pvr_device *pvr_dev)
 	pvr_fw_object_destroy(fw_mem->mmucache_sync_obj);
 
 err_release_hwrinfobuf:
-	pvr_fw_object_unmap_and_destroy(fw_mem->hwrinfobuf_obj);
+	pvr_fw_object_destroy(fw_mem->hwrinfobuf_obj);
 
 err_release_power_sync:
 	pvr_fw_object_unmap_and_destroy(fw_mem->power_sync_obj);
 
 err_release_connection_ctl:
-	pvr_fw_object_unmap_and_destroy(fw_mem->fwif_connection_ctl_obj);
+	pvr_fw_object_destroy(fw_mem->fwif_connection_ctl_obj);
 
 	return err;
 }
@@ -599,11 +594,11 @@ pvr_fw_destroy_structures(struct pvr_device *pvr_dev)
 	pvr_fw_object_unmap_and_destroy(fw_mem->sysinit_obj);
 
 	pvr_fw_object_destroy(fw_mem->mmucache_sync_obj);
-	pvr_fw_object_unmap_and_destroy(fw_mem->hwrinfobuf_obj);
+	pvr_fw_object_destroy(fw_mem->hwrinfobuf_obj);
 	pvr_fw_object_unmap_and_destroy(fw_mem->power_sync_obj);
 	pvr_fw_object_unmap_and_destroy(fw_mem->osdata_obj);
-	pvr_fw_object_unmap_and_destroy(fw_mem->osinit_obj);
-	pvr_fw_object_unmap_and_destroy(fw_mem->fwif_connection_ctl_obj);
+	pvr_fw_object_destroy(fw_mem->osinit_obj);
+	pvr_fw_object_destroy(fw_mem->fwif_connection_ctl_obj);
 }
 
 /**
@@ -1402,6 +1397,46 @@ pvr_fw_object_create_and_map_offset(struct pvr_device *pvr_dev,
 						   fw_obj_out);
 }
 
+/**
+ * pvr_fw_object_create_offset() - Create a FW object and map to firmware
+ * at the provided offset.
+ * @pvr_dev: PowerVR device pointer.
+ * @fw_addr: Base address of desired FW mapping, offset from start of FW heap.
+ *           If a specific FW address is not required, pass %U32_MAX.
+ * @size: Size of object, in bytes.
+ * @flags: Options which affect both this operation and future mapping
+ * operations performed on the returned object. Must be a combination of
+ * DRM_PVR_BO_* and/or PVR_BO_* flags.
+ * @init: Initialisation callback.
+ * @init_priv: Private pointer to pass to initialisation callback.
+ * @fw_obj_out: Pointer to location to store created object pointer.
+ *
+ * %DRM_PVR_BO_DEVICE_PM_FW_PROTECT is implied for all FW objects. Consequently,
+ * this function will fail if @flags has %DRM_PVR_BO_CPU_ALLOW_USERSPACE_ACCESS
+ * set.
+ *
+ * Returns:
+ *  * 0 on success, or
+ *  * Any error returned by pvr_fw_object_create_and_map().
+ */
+int
+pvr_fw_object_create_offset(struct pvr_device *pvr_dev, u32 fw_addr,
+			    size_t size, u64 flags,
+			    void (*init)(void *cpu_ptr, void *priv),
+			    void *init_priv, struct pvr_fw_object **fw_obj_out)
+{
+	void *cpu_ptr;
+
+	cpu_ptr = pvr_fw_object_create_and_map_offset(pvr_dev, fw_addr, size, flags,
+						      init, init_priv, fw_obj_out);
+	if (IS_ERR(cpu_ptr))
+		return PTR_ERR(cpu_ptr);
+
+	pvr_fw_object_vunmap(*fw_obj_out);
+
+	return 0;
+}
+
 /**
  * pvr_fw_object_destroy() - Destroy a pvr_fw_object
  * @fw_obj: Pointer to object to destroy.
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index 3390c84e4fd3..67d1e63669f1 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -349,30 +349,18 @@ struct pvr_fw_device {
 	/** @fw_mm_base: Base address of address space managed by @fw_mm. */
 	u64 fw_mm_base;
 
-	/**
-	 * @fwif_connection_ctl: Pointer to CPU mapping of FWIF connection
-	 *                       control structure.
-	 */
-	struct rogue_fwif_connection_ctl *fwif_connection_ctl;
-
 	/** @fwif_sysinit: Pointer to CPU mapping of FW SYSINIT structure. */
 	struct rogue_fwif_sysinit *fwif_sysinit;
 
 	/** @fwif_sysdata: Pointer to CPU mapping of FW SYSDATA structure. */
 	struct rogue_fwif_sysdata *fwif_sysdata;
 
-	/** @fwif_osinit: Pointer to CPU mapping of FW OSINIT structure. */
-	struct rogue_fwif_osinit *fwif_osinit;
-
 	/** @fwif_osdata: Pointer to CPU mapping of FW OSDATA structure. */
 	struct rogue_fwif_osdata *fwif_osdata;
 
 	/** @power_sync: Pointer to CPU mapping of power sync state. */
 	u32 *power_sync;
 
-	/** @hwrinfobuf: Pointer to CPU mapping of FW HWR info buffer. */
-	struct rogue_fwif_hwrinfobuf *hwrinfobuf;
-
 	/** @fw_trace: Device firmware trace buffer state. */
 	struct pvr_fw_trace fw_trace;
 
@@ -430,6 +418,12 @@ void *pvr_fw_object_create_and_map(struct pvr_device *pvr_dev, size_t size, u64
 				   void (*init)(void *cpu_ptr, void *priv),
 				   void *init_priv, struct pvr_fw_object **pvr_obj_out);
 
+int
+pvr_fw_object_create_offset(struct pvr_device *pvr_dev, u32 fw_addr,
+			    size_t size, u64 flags,
+			    void (*init)(void *cpu_ptr, void *priv),
+			    void *init_priv, struct pvr_fw_object **pvr_obj_out);
+
 void *
 pvr_fw_object_create_and_map_offset(struct pvr_device *pvr_dev, u32 dev_offset, size_t size,
 				    u64 flags, void (*init)(void *cpu_ptr, void *priv),

-- 
2.43.0

