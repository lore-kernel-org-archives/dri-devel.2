Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2D606A334
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=tVzjNwCj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D88810F50C;
	Mon,  9 Nov 2026 20:36:27 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3795A10F509;
 Mon,  9 Nov 2026 20:36:15 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6A9Jxrvn3422877; Mon, 9 Nov 2026 20:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=s
 knmdDkQTO5Ldr11UDZTsw2bKwiyFyyJ90PVXDuF9BI=; b=tVzjNwCjp//szmtu0
 1Vfxtba1jt6ehYlHfOZc17aebltk/Mh0XJ0SZpc4UD85/xUCXJtCMZvDy+1mxfPw
 skDxEYdyK/pmZ+LWrcHsINB+qVkS25SLX5Muylk5g1hcY0h458JxueU+ycZAKFeh
 u+ceuYa9NVKn/0dU2Zuenejm4V2fQgzCrzHwjeVSHmv3DXe+yfh7P4F/eIjFAjcC
 hrJyBAIN7MJuRnKYgBlL3hwGizX/UnKmIqvQepmT06IMpUVcs889LVK0+BGSdJbV
 TkhHB3FZIzbukL8uQv0pWLRY0VbGsGiZy1+MQqZSIVmFXeDqi2AxZF1sTjfbSLNo
 r9b2w==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hsvxx1tk3-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Mon, 09 Nov 2026 20:36:06 +0000 (GMT)
Received: from [127.0.1.1] (172.25.6.177) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 20:36:05 +0000
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Date: Mon, 9 Nov 2026 20:35:21 +0000
Subject: [PATCH v2 1/2] drm/imagination: clamp stride of heaps and static
 areas for legacy UM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261109-ioctl-query-count-stride-fixes-v2-1-228ea0e28dc3@imgtec.com>
References: <20261109-ioctl-query-count-stride-fixes-v2-0-228ea0e28dc3@imgtec.com>
In-Reply-To: <20261109-ioctl-query-count-stride-fixes-v2-0-228ea0e28dc3@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <frank.binns@imgtec.com>,
 <brajesh.gupta@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794256564; l=7072;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=BtQCl/jQqu9IlaT2VJeUrDoOjvX4lBlJNJkGp+dN7yk=;
 b=7ju1YjK1/3lcSqTeOj2iw0gNgWOYNsvw++Kql/nRFdhL7/qszrm21gXJ1QiwFPkdWJDgP7uet
 BLwHu89k5aJAg+YCFCp18RJpk8hJ0If0xWfLmrcAo+wn3QR3jsOK0Qx
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX5uiXmvM+giJf
 4UoT0zHYicpes2rB4YsP7xdn9OIG/iLatWxd4TV5ydhj/EAH2iQmLK8zDzLCva3nrMs8NaKXJjS
 aodmGnHzEswOODrpWzpNdAJglA/7ND0=
X-Proofpoint-ORIG-GUID: yY1bslqMTcTB9JpwFrUUJ3KFGfemKeTy
X-Authority-Analysis: v=2.4 cv=H+JOUOYi c=1 sm=1 tr=0 ts=6af22eb6 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=e5mUnYsNAAAA:8 a=r_1tXGB3AAAA:8 a=wk5KyH1tZOMvrzhs76oA:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX2L6O+tfBrm/Y
 Nb6JUNI7D6y+w3XAW18PwRMszLr/ImpdNRoHp5Y9mwKKyjuD9jjXr8Lex6LJ9mk5zdLGqEfwAo/
 yo13BFiJ3odtl7rF+QGw10IFJKJnwG0gLri5vbVwTbaoWnl3bb0gKcnP/vZWvMhH8Yf6CIXO202
 E+qhq0oOBK4uf6ysIeiGyEraaqFR/dbh5rUg/0UOfdn3s0b3rchhHikU7gduJH+hcqUVllAAXxU
 vMwLrf0yAggzGYmzyF3zbnKeELDPQHUQVh0XwE02PLuNoUN37KBLzTLemdXrQky3L8cRygRXfeo
 HDDQsi/83HvSBUDo52Wr730eZknZ5WGwucshUqPHtjK9z7xoLZ3ZLcf9p6O1BhTRdDQqmq14wK0
 J3khUj5QpF8OVLty8+GkKxXJoKKJyuMGbWoZP/GLgjvmvm4ppq7+tskcVk8DgeZvNpbn8ptggrs
 tv3RlvDmMqVCeEWPOUg==
X-Proofpoint-GUID: yY1bslqMTcTB9JpwFrUUJ3KFGfemKeTy
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
index 4e058a6fdd5c..db3ffe55af29 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.h
+++ b/drivers/gpu/drm/imagination/pvr_drv.h
@@ -72,6 +72,27 @@ int pvr_set_uobj_array(const struct drm_pvr_obj_array *out, u32 min_stride, u32
 	PVR_UOBJ_DECL(struct drm_pvr_dev_query_fw_info, _padding_4) \
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
index a4d2f4e273f9..6d11b85e5ec5 100644
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
index 1179c1e7d92d..9e432f3ad7b4 100644
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

