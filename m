Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D37606A335
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=r87VV7ye
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9865210E26E;
	Thu,  5 Nov 2026 12:25:09 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B769210E26E;
 Thu,  5 Nov 2026 12:25:03 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59ucxq522533; Thu, 5 Nov 2026 12:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=Tv+AHQghVp6WS0kGDJXAni7
 BQSviv9lss6FaWUn8x9M=; b=r87VV7yeav7OzgfUP6zyDouNfP+JpnbLLm0wQgq
 KqEwe/QfkJccDdOB7I22oTc1Sx51dCN58GyGJlS2OhMfHtqqFsius0u+5y0nwYcV
 GzHXdgzaeuh2o4soObEgPDsR8a3BhWDNVHSM+M0ExyUtn4JIB2WGsmVK0FG/fmk6
 45Bh9saQMANK3j5lKzt2i+sfJzEy6+dkg5TbOZuk1ljPDG0r9IsaCICmQ46NZvum
 E09jjVD7MvwSeZHidqz5lnuCp7gq517iYwlYJEhGfs3pB3CEyZ0CE5TcbYUdcQFI
 ZNyeWQes1IeUD5+K8HmP+ZJ3U9lcU52Bc+T8NPn1JLzEd+A==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hr3j6rw22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2026 12:24:44 +0000 (GMT)
Received: from [127.0.1.1] (172.25.6.177) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 12:24:43 +0000
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Date: Thu, 5 Nov 2026 12:24:23 +0000
Subject: [PATCH] drm/imagination: improve DRM_PVR_DEV_QUERY_HEAP_INFO_GET
 documentation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-document-drm_pvr_dev_query_heap_info_get-v1-1-b899401606e4@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAHZ17GoC/yXNTQ6CMBBA4auQWdukBazBqxjTYDvAmNCW/kVDu
 LtVl9/mvR0iBsII12aHgIUiOVshTg3oZbQzMjLV0PJWCsHPzDidV7SJmbAqX4IyWNSWMbzVgqN
 XZCenZkxMStnjcBm6rudQcz7gRK/f6nb/O+bHE3X69uE4Plw991qMAAAA
X-Change-ID: 20261105-document-drm_pvr_dev_query_heap_info_get-6664e9793340
To: Alessio Belle <alessio.belle@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <frank.binns@imgtec.com>,
 <brajesh.gupta@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793881483; l=3455;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=C8+K3L2nsKBAFra+GN8oUHH2+EsKQUpWlDsEcy5mfkk=;
 b=J/Skituf9q4/DLGJTN7g7QhW5+2o0Yg4XeeXphSsUZdej9sb1Njs/gFI7XKkwj0ddP0ssUgpY
 2gx6AosmGLwDEnrhak8vLMMxCysPNJIykdCjsl/m9atDwFajroQ4AS2
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Proofpoint-GUID: v1ikj_VOCsMDsN3UF060SiHFjh5JlRzB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0OSBTYWx0ZWRfX64Tlp+ZqmmBO
 Yz5lf3/cB5ExheoSAGyD6P+qdfmt+a5+oTUelsg0bsirfEqV21CQOERAJYUA6CCHNDgnyqPryJl
 LRgIAuv1m4WazPnucf8/3bdiiZqUiUo=
X-Proofpoint-ORIG-GUID: v1ikj_VOCsMDsN3UF060SiHFjh5JlRzB
X-Authority-Analysis: v=2.4 cv=DtnDa2/+ c=1 sm=1 tr=0 ts=6aec758c cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=v4fapmwnaPr8F7IbrnYA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0OSBTYWx0ZWRfX+aZYqYmxpFXh
 KwsH+Kmpj81tYA0EZTp4cFxlTfBMaTlrh/lu3CnE2fQYglu9Q11V/2j4vxfJECgTHiemDxEPr78
 gaJugtN5BMsV+5iR8pbUlPm78FwF/q0dcjCMjR54E3minRQtEdfxkdVMDgvm3JWzoCjaSS4vbmn
 XfMYqwMCjcXTX67Psb2yv2Q1ekJJ1QRqy1y9Tjo+UBWQoMYcH7DT1FWCTIQf/iZxLUMlAdoxTMC
 kFMwT/iwGxwLhu6u5/VRCBoF0W1xXt6sN9Jln+WPVdRyt2tjUiQ5R/9HwkfbNYKhM+1A+12C6hq
 CWhS8AdjdhwPhOlqbWQYFhGjzlAMal8NexrcrsVI0LC7Ls/isU6CWAF2kvijf7iNmMn2Cyl7vZL
 foTAbNjBK0JV5Hq8zdq/+1z2jopJu5Tnwa3HQRR3b0yo0eaSOnp+acNTKqVK/UrqdK1OpM+mlX1
 SQ6oqv/u18hSoTcJi1A==
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

Add more information about how the array of drm_pvr_heap is filled in and
set expectations for when userspace and kernel run with a mismatched UAPI
header.

Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
---
 include/uapi/drm/pvr_drm.h | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
index ccf6c2112468..cd85ac257cdb 100644
--- a/include/uapi/drm/pvr_drm.h
+++ b/include/uapi/drm/pvr_drm.h
@@ -258,9 +258,22 @@ struct drm_pvr_dev_query_enhancements {
  * enum drm_pvr_heap_id - Array index for heap info data returned by
  * %DRM_PVR_DEV_QUERY_HEAP_INFO_GET.
  *
- * For compatibility reasons all indices will be present in the returned array,
- * however some heaps may not be present. These are indicated where
- * &struct drm_pvr_heap.size is set to zero.
+ * Userspace and the kernel may have different values for @DRM_PVR_HEAP_COUNT.
+ * In this case:
+ *
+ *  - If KMD(@DRM_PVR_HEAP_COUNT) > UMD(@DRM_PVR_HEAP_COUNT), then userspace
+ *    should either:
+ *
+ *    a. explicitly request a number of heaps by specifying a value less than
+ *       or equal to UMD(@DRM_PVR_HEAP_COUNT) heaps, and the kernel must
+ *       ignore heaps whose ID is greater than or equal to this value, or
+ *    b. ignore heap IDs greater than or equal to UMD(@DRM_PVR_HEAP_COUNT) by,
+ *       e.g. capping the value returned by the kernel.
+ *
+ *  - If KMD(@DRM_PVR_HEAP_COUNT) < UMD(@DRM_PVR_HEAP_COUNT), then the maximum
+ *    number of heaps is capped by the kernel at KMD(@DRM_PVR_HEAP_COUNT) and
+ *    userspace must ignore heaps whose ID is greater than or equal to
+ *    KMD(@DRM_PVR_HEAP_COUNT).
  */
 enum drm_pvr_heap_id {
 	/** @DRM_PVR_HEAP_GENERAL: General purpose heap. */
@@ -269,7 +282,7 @@ enum drm_pvr_heap_id {
 	DRM_PVR_HEAP_PDS_CODE_DATA,
 	/** @DRM_PVR_HEAP_USC_CODE: USC code heap. */
 	DRM_PVR_HEAP_USC_CODE,
-	/** @DRM_PVR_HEAP_RGNHDR: Region header heap. Only used if GPU has BRN63142. */
+	/** @DRM_PVR_HEAP_RGNHDR: Region header heap (optional). Only used if GPU has BRN63142. */
 	DRM_PVR_HEAP_RGNHDR,
 	/** @DRM_PVR_HEAP_VIS_TEST: Visibility test heap. */
 	DRM_PVR_HEAP_VIS_TEST,
@@ -310,9 +323,13 @@ struct drm_pvr_heap {
  * struct drm_pvr_dev_query_heap_info - Container used to fetch information
  * about heaps supported by the device driver.
  *
- * Please note all driver-supported heaps will be returned up to &heaps.count.
- * Some heaps will not be present in all devices, which will be indicated by
- * &struct drm_pvr_heap.size being set to zero.
+ * Please note that drivers may not need all the heaps that are returned up to
+ * &heaps.count in &heaps.array. Unlike for required heaps, optional heaps are
+ * used on some GPU cores only. The kernel indicates when optional heaps are not
+ * needed by setting &struct drm_pvr_heap.size to zero.
+ *
+ * The kernel copies all requested heaps into &heaps.array matching the order
+ * of heap indices as they are listed in &enum drm_pvr_heap_id.
  *
  * When fetching this type &struct drm_pvr_ioctl_dev_query_args.type must be set
  * to %DRM_PVR_DEV_QUERY_HEAP_INFO_GET.

---
base-commit: 33ed26235db93162935d1719bc6f538c384a2fd8
change-id: 20261105-document-drm_pvr_dev_query_heap_info_get-6664e9793340

Best regards,
--  
Luigi Santivetti <luigi.santivetti@imgtec.com>

