Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CAEC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3017E10E158;
	Tue,  4 Aug 2026 13:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Mq1xS84L";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E5210E158;
 Tue,  4 Aug 2026 13:45:37 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674CWlTh3702901; Tue, 4 Aug 2026 14:45:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=RYLFTl1DGM85kMXnCePjrdu
 7Z5iB9AcVp/HX6FDQOk0=; b=Mq1xS84LZk7v+T///HmwbYNKKTegLDn/T6yzwM/
 VQe7ZHhkHkQ5715FbxjDfdEWuUA4nHr55RgWNxsXIuN7fq+83Aso+AmuUuIxgDPH
 NWYCDlVfqNnT0Bv6qx1XnIpRvUG6Brl23+OzQ8N5OxeiN/IVVt8Yrc8Xub0iaTun
 8/d7ExOOuHxmu03iOEKCOYwbhcOB8Bxg8GJ9XUQioP+IEmn87N23REroD+vq3VX4
 WdNwQVXMrimHgeZPbfrLAv3/DwI24GDZoQD5VLgyqQrL1bCYuurWPtrYi5GlQH+T
 64ShcTxLTCJJ2K9zZhSAfBJ2SeTS12td+yE5pKWuPiCPB7g==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fs8vttrt7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 14:45:27 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.47) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 4 Aug
 2026 14:45:24 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Tue, 4 Aug 2026 16:45:04 +0300
Subject: [PATCH] drm/imagination: Explicitly set CACHED flag on META FW
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-b4-cached-flag-on-meta-fw-v1-1-333bccf10d3a@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAN/scWoC/x3MTQqEMAxA4atI1gZq6fh3FXGR1lQDWqUVHRDvP
 mWW3+K9BxJH4QR98UDkS5LsIaMqC3ALhZlRpmzQSteqVQatQUdu4Qn9SjPuATc+Cf2NVnmrP21
 nqdGQ+yOyl+//PYzv+wN4sjv4awAAAA==
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Matt Coster <opensource@mtcoster.net>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Matt Coster
 <opensource@mtcoster.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785851124; l=1493;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=aBcrOPlE91O4pvHKvdOwFFp/N9zkjaWAgioEhllmshs=;
 b=7i0fhj8kCEQd6em3XQKqckQAKG6ilBEC6XZBIfjNyPcwLka2x5S4pjS0hzm1NGTRXjlBkQXyj
 jxiKfinM9UGDwkiFrx5a/+KO2NXsI1uBApmyS1iro9okPEtwrgOHYqA
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.47]
X-Proofpoint-ORIG-GUID: dAXDPUZS1Q7rgsCuipcSaubnDF687BvR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX4E0u6CaemMav
 P7FI6ValIfbykG1qX8WBnUWrBnTVK9pgCq/6pCFnHt8i8GcWJuyJ2VyykvqMl1tXO/jXfIORmQH
 ptO6urRJjtppI1dPR/NkDxz1loGIxvQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX/1dxdt2k2wfL
 wt4c65k5lTuw78BNrBrEwpyxHOdlPDfltWf5kd2MnFfKl/5y9IOjbBrMBSbBjph8fxJna8z6jOx
 GUs8EkPeiNC3j6qW6tod+RUAJOkFEGPnGzRwEdHV1y7ZsJSnApMd7tS3+30zQQHqjArRmUBb4B6
 NanLARHlYoxmJkOwDTr3yjU10hDrbKy2u+xtK3je5zFDg9W3KKW1ybSR/bMxew1FeI4UZJEj5C2
 4zNoV3NXGl2bw3XjjqGVyhQ6hdL38qlNEYYL+eDJRHfR7wwqHzg3h9e+5XmfPESHEdhfzWkrz6u
 gWYQsGiDpCYwRZCY1CDRDR+TUt7IClNmomyyCkHXarDcKRzyqluy3jzWHcYOoXtGm27bw9YGx6i
 p//uEm48TAJJruffPaaPy/MMtRz2BuLfCJCtPUO52RDQywwr4InqSdtPgt2ZmfQpLEhakjp1SFJ
 0UEJjSFPc7jxuPNdBEg==
X-Proofpoint-GUID: dAXDPUZS1Q7rgsCuipcSaubnDF687BvR
X-Authority-Analysis: v=2.4 cv=D7V37PRj c=1 sm=1 tr=0 ts=6a71ecf7 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ft80G52YQMEA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=iB0s77fEAAAA:8 a=r_1tXGB3AAAA:8 a=DMDJWULzLjs8hIaqJQgA:9 a=QEXdDO2ut3YA:10
 a=HyUCkmmLtCL0fD60kmUx:22 a=t8nPyN_e6usw4ciXM-Pk:22
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

From: Matt Coster <opensource@mtcoster.net>

For completeness, OR in the CACHED flags when we're not ORing in the
UNCACHED counterparts. One of these is probably zero, but (a) it isn't
evident just by reading these lines, and (b) the compiler will make it
disappear in that case.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_meta.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 9ff03bc60a08..b5837ba56e33 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -509,9 +509,13 @@ pvr_meta_get_fw_addr_with_offset(struct pvr_fw_object *fw_obj, u32 offset)
 	u32 fw_addr = fw_obj->fw_addr_offset + offset + ROGUE_FW_SEGMMU_DATA_BASE_ADDRESS;
 
 	/* META cacheability is determined by address. */
-	if (fw_obj->gem->flags & PVR_BO_FW_FLAGS_DEVICE_UNCACHED)
+	if (fw_obj->gem->flags & PVR_BO_FW_FLAGS_DEVICE_UNCACHED) {
 		fw_addr |= ROGUE_FW_SEGMMU_DATA_META_UNCACHED |
 			   ROGUE_FW_SEGMMU_DATA_VIVT_SLC_UNCACHED;
+	} else {
+		fw_addr |= ROGUE_FW_SEGMMU_DATA_META_CACHED |
+			   ROGUE_FW_SEGMMU_DATA_VIVT_SLC_CACHED;
+	}
 
 	return fw_addr;
 }

---
base-commit: e55fead22ff9ee047ab9f1903860c4b43043514e
change-id: 20260804-b4-cached-flag-on-meta-fw-b0fb2589ba72

Best regards,
-- 
Alexandru Dadu <alexandru.dadu@imgtec.com>

