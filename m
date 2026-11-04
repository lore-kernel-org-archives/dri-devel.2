Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6BA606A33D
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=yV/kxVnE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA51510E184;
	Wed,  4 Nov 2026 18:09:19 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED2F10E5CC;
 Wed,  4 Nov 2026 18:09:13 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FobEq1657645; Wed, 4 Nov 2026 18:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=y
 T0EqPueRaLj5pdjXZu736/ZgO/5SMZbRCh4FkI+ywc=; b=yV/kxVnEyifTyEds4
 GalJe+tWwb0NMphE33BDENkW/n2FVp9kgZ/mPhLp/M6YS3kxRvjWqHyKcyQ4i5hk
 Vw+b6aP6xJo5d13mdqCEFaMtbt88nntopB9bwgZNHG3kpP6SIMKF8k56kXo36DSP
 7amapoScaGi4GWAgfeHrYFPgKudJo9KzbCUZBn16AZGELZGGIA2PHERHuV/VXvm6
 uSnqTEnvFNEwjW5KK0Z6izZ8JFi6jBRAqxHFd7LQ07wSERfbSx/XxElpjeiaYb9Q
 cr32Xk08y9nksydgPldWuSXdNgI8oU3kur545goXrpbKJxnZ+WTcg/duKaiBpw8Z
 NaCVg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hn99wkmed-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 18:09:05 +0000 (GMT)
Received: from [127.0.1.1] (172.25.6.177) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 18:09:04 +0000
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Date: Wed, 4 Nov 2026 18:08:15 +0000
Subject: [PATCH 2/2] drm/imagination: clamp count of heaps and static areas
 for legacy UM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-ioctl-query-count-stride-fixes-v1-2-2bf86dd7cf29@imgtec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793815743; l=7582;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=GasSrjLlRKwF3VwnQr4ES3BEvWG3gXf/DSfBYJdel90=;
 b=uSlDFW1F3tXML0R86Fg56nvfP73hx1g+wRn8Qs5RJLhJyZIC2N/owl5eRfJYx5nIEo+e/QTse
 ygAzoARGeVVCPiouk582pUztLSB4Ujem76Vb9mMLLcMQTSxQwZMO9Ja
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3MiBTYWx0ZWRfXxOdxyLx9ipzv
 KyV6c9DnY/p19SJIb0Oc+2fsz5QFXvO6qjaW4l1YrmWu9zPK1kkZO7pHGQaQUHEqiNxdSTcdeJF
 Pil5ldzV1qf2F7DvI6ZH8DtFoRrdmN1vjt5uROPLRWkhNXgT9jTAI7ny/LUNuQR3ixK6MAETegG
 RJ0GUOwqq2RkQs783MC/1EhanElP0aIpL2PJW2SRM2c62yFZ7rihpdOcy6K+dAfHn3sjHJwtHUT
 aJZTXKWSDMasqbbdmKUzQhhvLzRv/nLowb4orJ90dbVRAKb0xR0AMa4kg4a/cfsbm9tSHJZvMll
 pPQvnfG1NJ6P17G59h79MLJr4pf8DMCcfmc//4ZktVWSvDWPDPh+CJrfDy/WAJBc0REs1N7iT0B
 NQuJBxQ9Zj3wD5bdv2LxR4sN/w9Sqi5jygvf0F43IRfQswgQDd/4TSa9fAkC7IwmLHMeMbAfHDB
 KrpdTZwW7PoX9bvamHw==
X-Proofpoint-ORIG-GUID: RJXM0EcTCoz5OKkQ7KZWZP4WXpCE1aur
X-Proofpoint-GUID: RJXM0EcTCoz5OKkQ7KZWZP4WXpCE1aur
X-Authority-Analysis: v=2.4 cv=BZlNQbt2 c=1 sm=1 tr=0 ts=6aeb74c1 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=e5mUnYsNAAAA:8 a=r_1tXGB3AAAA:8 a=NjuOHxGiqyyvwl9FGpwA:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3MiBTYWx0ZWRfX9uM6NC0+qibs
 EWftxBuDx1qdM+K8IgBLahJY0ebQYrsZSK/1A8pgjEl5dteHswm3v4tulravExmOao/HDqbzw1l
 yufmEFudOk+tT+pJYvoh7DyD+9A0brs=
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

Userspace mishandled the count of DRM PVR heaps returned by the kernel in
the DRM_PVR_DEV_QUERY_HEAP_INFO_GET ioctl call. In particular not taking
into account that the value of count returned by the kernel can be larger
than the count defined in userspace. This issue hasn't manifested itself
so far because no new DRM PVR heap has ever been introduced, however new
heaps are expected to be added in the future.

Userspace fixed this problem with 2a983a3a in [1]. For the kernel, it is
possible to be safe with respect to those versions of userspace predating
the fix and at the same time to preserve backwards compatibility.

After this change, future versions of userspace can keep using the ioctl in
the exact same way they do now and, in addition, they _can_ use the newly
introduced pattern for querying the minimum and the maximum value of
supported heaps by following the documentation that is available in the
UAPI header.

DRM_PVR_STATIC_DATA_AREA_COUNT_MIN_SUPPORTED was added in order to keep the
DRM_PVR_DEV_QUERY_HEAP_INFO_GET and DRM_PVR_DEV_QUERY_STATIC_DATA_AREAS_GET
ioctls consistent with each other, but there is no known mishandling in the
latter from userspace.

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/44456

Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_drv.h | 12 ++++++++++++
 drivers/gpu/drm/imagination/pvr_vm.c  | 18 ++++++++++++++++--
 include/uapi/drm/pvr_drm.h            | 28 ++++++++++++++++++++++++----
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.h b/drivers/gpu/drm/imagination/pvr_drv.h
index b9e0146c90b1..200208fda0a3 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.h
+++ b/drivers/gpu/drm/imagination/pvr_drv.h
@@ -91,6 +91,18 @@ int pvr_set_uobj_array(const struct drm_pvr_obj_array *out, u32 min_stride, u32
 #define DRM_PVR_STATIC_DATA_AREA_STRIDE_MIN_SUPPORTED \
 	PVR_UOBJ_MIN_SIZE_INTERNAL(struct drm_pvr_static_data_area, offset)
 
+/*
+ * Value of DRM_PVR_HEAP_COUNT in the first released version of enum
+ * drm_pvr_heap_id for Rogue cores.
+ */
+#define DRM_PVR_HEAP_COUNT_MIN_SUPPORTED (DRM_PVR_HEAP_TRANSFER_FRAG + 1)
+
+/*
+ * Count of static areas in the first released version of struct
+ * drm_pvr_static_data_area static_data_areas[] for Rogue cores.
+ */
+#define DRM_PVR_STATIC_DATA_AREA_COUNT_MIN_SUPPORTED 5U
+
 /**
  * PVR_UOBJ_GET() - Copies from _src_usr_ptr to &_dest_obj.
  * @_dest_obj: The destination container object in kernel space.
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index a369d73c6969..c51c162cd969 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -927,6 +927,9 @@ static const struct drm_pvr_static_data_area static_data_areas[] = {
 /*
  * The values given to GET_RESERVED_SIZE() are taken from the last entry in the corresponding
  * static data area for each heap.
+ *
+ * The pvr_heaps array **must** initialize **all** heaps that are enumerated in the UAPI with
+ * enum drm_pvr_heap_id.
  */
 static const struct drm_pvr_heap pvr_heaps[] = {
 	[DRM_PVR_HEAP_GENERAL] = {
@@ -967,6 +970,8 @@ static const struct drm_pvr_heap pvr_heaps[] = {
 	},
 };
 
+static_assert(ARRAY_SIZE(pvr_heaps) == DRM_PVR_HEAP_COUNT, "Invalid number of PVR heaps");
+
 int
 pvr_static_data_areas_get(const struct pvr_device *pvr_dev,
 			  struct drm_pvr_ioctl_dev_query_args *args)
@@ -985,13 +990,18 @@ pvr_static_data_areas_get(const struct pvr_device *pvr_dev,
 
 	if (!query.static_data_areas.array) {
 		u32 *stride = &query.static_data_areas.stride;
+		u32 *count = &query.static_data_areas.count;
 
 		if (!query.static_data_areas.stride)
 			*stride = DRM_PVR_STATIC_DATA_AREA_STRIDE_MIN_SUPPORTED;
 		else
 			*stride = sizeof(struct drm_pvr_static_data_area);
 
-		query.static_data_areas.count = ARRAY_SIZE(static_data_areas);
+		if (!query.static_data_areas.count)
+			*count = DRM_PVR_STATIC_DATA_AREA_COUNT_MIN_SUPPORTED;
+		else
+			*count = ARRAY_SIZE(static_data_areas);
+
 		goto copy_out;
 	}
 
@@ -1035,7 +1045,11 @@ pvr_heap_info_get(const struct pvr_device *pvr_dev,
 		else
 			query.heaps.stride = sizeof(struct drm_pvr_heap);
 
-		query.heaps.count = ARRAY_SIZE(pvr_heaps);
+		if (!query.heaps.count)
+			query.heaps.count = DRM_PVR_HEAP_COUNT_MIN_SUPPORTED;
+		else
+			query.heaps.count = ARRAY_SIZE(pvr_heaps);
+
 		goto copy_out;
 	}
 
diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
index fd7cf9e230c3..66a2af192db3 100644
--- a/include/uapi/drm/pvr_drm.h
+++ b/include/uapi/drm/pvr_drm.h
@@ -322,8 +322,13 @@ struct drm_pvr_dev_query_heap_info {
 	 * @heaps: Array of &struct drm_pvr_heap. To facilitate allocation by
 	 * the caller:
 	 *
-	 * - if &heaps.array is NULL, the count will be updated with the count
-	 *   of heaps known to the kernel driver.
+	 * - if &heaps.array is NULL and &heaps.count is set by the caller, the
+	 *   count will be updated with the value of @DRM_PVR_HEAP_COUNT that
+	 *   is known to the kernel driver.
+	 *
+	 * - if &heaps.array is NULL and &heaps.count is zero, the count will
+	 *   be updated with a value that is the minimum supported by the kernel
+	 *   and this may differ based on the GPU ID.
 	 *
 	 * - If &heaps.array is NULL and &heaps.stride is set by the caller, the
 	 *   stride will be updated to the size of &struct drm_pvr_heap known to
@@ -332,6 +337,11 @@ struct drm_pvr_dev_query_heap_info {
 	 * - If &heaps.array is NULL and &heaps.stride is zero, the stride will
 	 *   be updated with a value that is the minimum supported by the kernel
 	 *   and this may differ based on the GPU ID.
+	 *
+	 * - If &heaps.array, &heaps.stride and &heaps.count are set by the
+	 *   caller, then the kernel will try to honor the value of count and
+	 *   this may be clamped to the value of @DRM_PVR_HEAP_COUNT known by
+	 *   the kernel.
 	 */
 	struct drm_pvr_obj_array heaps;
 };
@@ -440,8 +450,13 @@ struct drm_pvr_dev_query_static_data_areas {
 	 * @static_data_areas: Array of &struct drm_pvr_static_data_area. To
 	 * facilitate allocation by the caller:
 	 *
-	 * - if &static_data_areas.array is NULL, the count will be updated with
-	 *   the count of static areas known to the kernel driver.
+	 * - if &static_data_areas.array is NULL and &static_data_areas.count is
+	 *   set by the caller, the count will be updated with the maximum count
+	 *   that is known to the kernel driver.
+	 *
+	 * - If &static_data_areas.array is NULL and &static_data_areas.count is
+	 *   zero, the count will be updated with a value that is the minimum
+	 *   supported by the kernel and this may differ based on the GPU ID.
 	 *
 	 * - If &static_data_areas.array is NULL and &static_data_areas.stride
 	 *   is set by the caller, the stride will be updated to the size of
@@ -451,6 +466,11 @@ struct drm_pvr_dev_query_static_data_areas {
 	 *   is zero, the stride will be updated with a value that is the
 	 *   minimum supported by the kernel and this may differ based on the
 	 *   GPU ID.
+	 *
+	 * - If &static_data_areas.array, &static_data_areas.stride and
+	 *   &static_data_areas.count are set by the caller, then the kernel
+	 *   will try to honor the value of count and this may be clamped to the
+	 *   maximum supported by the kernel.
 	 */
 	struct drm_pvr_obj_array static_data_areas;
 };

-- 
2.43.0

