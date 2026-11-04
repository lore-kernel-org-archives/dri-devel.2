Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA836606B21C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=lcR56nFn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A7110E567;
	Wed,  4 Nov 2026 18:09:20 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE59010E184;
 Wed,  4 Nov 2026 18:09:13 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FobEp1657645; Wed, 4 Nov 2026 18:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=b
 RMQqQ+gO75XfZ6FTBdmAyQRUgX8xtHxueixNEIs1rg=; b=lcR56nFnyf1Fg+Gy1
 RI0t30OGuhYgMc0rGPZmhpu4H3YHE+VjlEr41GeysEx7bilYI+j2gygCdyANcE2b
 WO+liMsEucQ7bDnwdDj2Ohc9ZAaokm1O3AHwW5diz+UnzDB9+BOyPJ45kg0zqmgb
 rkrSLuj2NubYR1RwSRRnSqbN/NPeDznf28sslhVjVIb6hAJ+ihUY6RmCEJaDgvmz
 68/g0ccPyHz5jqQczujwzQ73dWID7+OtDtkG7nBFSVv2GeX8spq1o+KhiH61LDbR
 bNGCsFEyT20ttzajBxLwJRxFIYYWNuyppVG8E/VC3OX18IjUra6/M7uyu8IMgBpr
 Du7HQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hn99wkmed-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 18:09:04 +0000 (GMT)
Received: from [127.0.1.1] (172.25.6.177) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 18:09:03 +0000
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Date: Wed, 4 Nov 2026 18:08:14 +0000
Subject: [PATCH 1/2] drm/imagination: clamp stride of heaps and static
 areas for legacy UM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-ioctl-query-count-stride-fixes-v1-1-2bf86dd7cf29@imgtec.com>
References: <20261104-ioctl-query-count-stride-fixes-v1-0-2bf86dd7cf29@imgtec.com>
In-Reply-To: <20261104-ioctl-query-count-stride-fixes-v1-0-2bf86dd7cf29@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <frank.binns@imgtec.com>,
 <brajesh.gupta@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793815743; l=7089;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=bZuUzi6en9SJ/TVm4qKZkAEThQc4S7+BKxXdIhaaBhs=;
 b=C3e0X5d/cLU9ddzUEuGo364XeDsSHqRavREED4qIupcpnuxIo5ccEu8g7jwwLGawpd9mKXcVT
 V0zF+opDXfyC4QoxXvB8auIdnb9njknnxmwhRkGNO4I1SwMbwsVX1h+
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3MiBTYWx0ZWRfXy9gcvzoYW5fT
 kZf1Aar1CWM+zDExVRc2F5aq/rybFLrOY5SQB4S5t1Kdz/8c6KlN/1F43ETn4xYssOZdAGV6onv
 v9jwGMXCv48W3GfVX2bwdkKDJdlRm7K8B+Lci4/V7aqXPSIaD9lXzE3G9baxdSMOPZqN1GtJzkn
 Nnx0oYjBsSGHp5rD0A3csVP8I45yRZgP9ChQ42UaPb6BM+pb70t3AGJQTta0sw1udYoAtkdNr2/
 I4ZTxhtXsJnjPMc8xWi1qZq8t9zl+QR8Y2UIK1ZTiXLqfsa6yFl0Msn04XlSo/9bkILVoKDksuC
 DUlq8B+nvaXr1S5IF8F/0NEYLNQmhZDyqrmQSWsHhrPTlUdwJBIpc2irTMyHv+W5bF+WdpLSB9h
 eBQ4WNb5YLIFu/3eEyWwFE3NrB+yCSVMuv7INqNeQjkGJD73fx5QH5KzgVTn8zIRzC+wWqM8IcC
 8VdXvQ7aH3jxLCpBfdA==
X-Proofpoint-ORIG-GUID: IzcF1k8XCgINMOamPIdoMufNKnq2jdLE
X-Proofpoint-GUID: IzcF1k8XCgINMOamPIdoMufNKnq2jdLE
X-Authority-Analysis: v=2.4 cv=BZlNQbt2 c=1 sm=1 tr=0 ts=6aeb74c0 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=e5mUnYsNAAAA:8 a=r_1tXGB3AAAA:8 a=wk5KyH1tZOMvrzhs76oA:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3MiBTYWx0ZWRfX5hhDMGnRlcMR
 Kn/wuVar6Qf2MkQsYnA6BSqg9lMsKRxVGj6ciG2+6dFQ/8NQkLqiWRk3UJsenT+8Zfo49CDBP+8
 fIBhEwlGSa9C2n6puhrsujS7A1DLI6A=
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

Userspace before 4c18bbc6 in [1] failed to set the stride when doing the
DRM_PVR_DEV_QUERY_HEAP_INFO_GET and DRM_PVR_DEV_QUERY_STATIC_DATA_AREAS_GET
query ioctl calls. This isn't a problem as long as the kernel and userspace
use the same version of struct drm_pvr_heap and of drm_pvr_static_data_area
and at present this is the case. However, nothing prevents it to change in
the future, allowing userspace and kernel to run with a different version
of either of those structures.

In order to protect userspace before 4c18bbc6, change those ioctl calls now
future proofing the value of the stride that is returned by the kernel.
This means to take a snapshot of the size of struct drm_pvr_heap and of
drm_pvr_static_data_area as of today and return it to old UMDs. Since the
size has never changed so far, we may refer to this size in docs, code and
comments as version 1, first released version, legacy or minimum supported
version of the stride.

In order to be safe for userspace, make use of the following properties
that hold in UM code before 4c18bbc6:

  1. for both DRM_PVR_DEV_QUERY_{HEAP_INFO,STATIC_DATA_AREAS}_GET, it makes
     two ioctl calls
  2. it never sets struct drm_pvr_obj_array::stride in either ioctl calls
  3. it assumes the stride from the kernel to match the stride of userspace

In the second ioctl call the value of the stride is set to what the kernel
had set it to in the first. Therefore, special case what is returned to UM
in the first call, so that the value of the stride matches with the one
userspace uses before 4c18bbc6.

Although backwards compatible, this commit alters the semantics of how to
retrieve the non-legacy or maximum supported stride going forward. The new
pattern for interacting with the kernel is documented in the UAPI header.

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/44456

Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_drv.h | 21 +++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_vm.c  | 14 ++++++++++++--
 include/uapi/drm/pvr_drm.h            | 33 +++++++++++++++++++++++++++------
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.h b/drivers/gpu/drm/imagination/pvr_drv.h
index 7fa147312dd1..b9e0146c90b1 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.h
+++ b/drivers/gpu/drm/imagination/pvr_drv.h
@@ -70,6 +70,27 @@ int pvr_set_uobj_array(const struct drm_pvr_obj_array *out, u32 min_stride, u32
 	PVR_UOBJ_DECL(struct drm_pvr_dev_query_static_data_areas, static_data_areas) \
 	)
 
+/*
+ * Minimum supported values that are fetched by DRM_PVR_DEV_QUERY_HEAP_INFO_GET
+ * and DRM_PVR_DEV_QUERY_STATIC_DATA_AREAS_GET ioctl calls from userspace.
+ *
+ * These values may depend on the GPU hardware and they must not change for
+ * cores that are already supported. However, new cores (and architectures)
+ * may have different minimum values and they should be introduced
+ * respecting the semantics described in the UAPI for Rogue.
+ */
+
+/* Size of the first released version of struct drm_pvr_heap for Rogue cores. */
+#define DRM_PVR_HEAP_STRIDE_MIN_SUPPORTED \
+	PVR_UOBJ_MIN_SIZE_INTERNAL(struct drm_pvr_heap, page_size_log2)
+
+/*
+ * Size of the first released version of struct drm_pvr_static_data_area for
+ * Rogue cores.
+ */
+#define DRM_PVR_STATIC_DATA_AREA_STRIDE_MIN_SUPPORTED \
+	PVR_UOBJ_MIN_SIZE_INTERNAL(struct drm_pvr_static_data_area, offset)
+
 /**
  * PVR_UOBJ_GET() - Copies from _src_usr_ptr to &_dest_obj.
  * @_dest_obj: The destination container object in kernel space.
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 304d0743c5aa..a369d73c6969 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -984,8 +984,14 @@ pvr_static_data_areas_get(const struct pvr_device *pvr_dev,
 		return err;
 
 	if (!query.static_data_areas.array) {
+		u32 *stride = &query.static_data_areas.stride;
+
+		if (!query.static_data_areas.stride)
+			*stride = DRM_PVR_STATIC_DATA_AREA_STRIDE_MIN_SUPPORTED;
+		else
+			*stride = sizeof(struct drm_pvr_static_data_area);
+
 		query.static_data_areas.count = ARRAY_SIZE(static_data_areas);
-		query.static_data_areas.stride = sizeof(struct drm_pvr_static_data_area);
 		goto copy_out;
 	}
 
@@ -1024,8 +1030,12 @@ pvr_heap_info_get(const struct pvr_device *pvr_dev,
 		return err;
 
 	if (!query.heaps.array) {
+		if (!query.heaps.stride)
+			query.heaps.stride = DRM_PVR_HEAP_STRIDE_MIN_SUPPORTED;
+		else
+			query.heaps.stride = sizeof(struct drm_pvr_heap);
+
 		query.heaps.count = ARRAY_SIZE(pvr_heaps);
-		query.heaps.stride = sizeof(struct drm_pvr_heap);
 		goto copy_out;
 	}
 
diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
index ccf6c2112468..fd7cf9e230c3 100644
--- a/include/uapi/drm/pvr_drm.h
+++ b/include/uapi/drm/pvr_drm.h
@@ -319,9 +319,19 @@ struct drm_pvr_heap {
  */
 struct drm_pvr_dev_query_heap_info {
 	/**
-	 * @heaps: Array of &struct drm_pvr_heap. If pointer is NULL, the count
-	 * and stride will be updated with those known to the driver version, to
-	 * facilitate allocation by the caller.
+	 * @heaps: Array of &struct drm_pvr_heap. To facilitate allocation by
+	 * the caller:
+	 *
+	 * - if &heaps.array is NULL, the count will be updated with the count
+	 *   of heaps known to the kernel driver.
+	 *
+	 * - If &heaps.array is NULL and &heaps.stride is set by the caller, the
+	 *   stride will be updated to the size of &struct drm_pvr_heap known to
+	 *   the kernel driver.
+	 *
+	 * - If &heaps.array is NULL and &heaps.stride is zero, the stride will
+	 *   be updated with a value that is the minimum supported by the kernel
+	 *   and this may differ based on the GPU ID.
 	 */
 	struct drm_pvr_obj_array heaps;
 };
@@ -427,9 +437,20 @@ struct drm_pvr_static_data_area {
  */
 struct drm_pvr_dev_query_static_data_areas {
 	/**
-	 * @static_data_areas: Array of &struct drm_pvr_static_data_area. If
-	 * pointer is NULL, the count and stride will be updated with those
-	 * known to the driver version, to facilitate allocation by the caller.
+	 * @static_data_areas: Array of &struct drm_pvr_static_data_area. To
+	 * facilitate allocation by the caller:
+	 *
+	 * - if &static_data_areas.array is NULL, the count will be updated with
+	 *   the count of static areas known to the kernel driver.
+	 *
+	 * - If &static_data_areas.array is NULL and &static_data_areas.stride
+	 *   is set by the caller, the stride will be updated to the size of
+	 *   &struct drm_pvr_static_data_area known to the kernel driver.
+	 *
+	 * - If &static_data_areas.array is NULL and &static_data_areas.stride
+	 *   is zero, the stride will be updated with a value that is the
+	 *   minimum supported by the kernel and this may differ based on the
+	 *   GPU ID.
 	 */
 	struct drm_pvr_obj_array static_data_areas;
 };

-- 
2.43.0

