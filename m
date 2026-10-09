Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D7CCA601D
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0A110E9B8;
	Fri,  9 Oct 2026 11:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="pRUwS3sd";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4F410E9B8;
 Fri,  9 Oct 2026 11:05:01 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998IOtS2155485; Fri, 9 Oct 2026 12:04:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=/Br/6limmNvLqxhImifZgMH
 8e0JTjZxr1VAE2aX2EVU=; b=pRUwS3sd0A7qSZOdjA1PyljWH8kaQ3dmBFHtS+l
 H3DrYRiM9G/UMxeAWH4eg/IMFQYgzVgcXvNAEiDu81LVZLQpm/gFnGHkGWkO7yZB
 JbDAXMw96u0HgA/gcNxUA+ownjl4PALHD/PXso8OyCtVuwVBGBUG15mn4A3eDjuT
 zlrFGs9XBaCzEi/Lt9kp/Um4LcUu4d5fs0Z4dwfF6za3SWxyiOmsA5xOfcqKDsC1
 IEMAm/L1cwFgPpCegMwb4z3oRx4VYNB/dIlVFDTg0NZ2gDtSPUxbJ6t17NJMDfo3
 B1kDt4Wk18gfakuTsSgrh0yGhzjuYyRX6SXlin7y9eaBizg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4h6m49rb89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 12:04:44 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 12:04:42 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Fri, 9 Oct 2026 14:04:35 +0300
Subject: [PATCH v2] drm/imagination: Improve logging of unknown freelist
 IDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-b4-improve-logging-of-unknown-freelist-ids-v2-1-5e6c3f63370e@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAELKyGoC/52OQQ6CMBREr0K69htaTQFX3sOwoOVTvkpLWqgaw
 t0teAOXL5mZNwsL6AkDu2QL8xgpkLMJxCFjum+sQaA2MRO5kDzPJagz0DB6FxGezhiyBlwHs31
 Y97LQecQnhSm1ApSNrIqi6FrJkaXB0WNH7112q38cZnVHPW2GLdGnqvOf/U3kW+4vceTAoZKot
 OInocr8SoOZUB+1G1i9rusXwKh4mvcAAAA=
X-Change-ID: 20261006-b4-improve-logging-of-unknown-freelist-ids-8a69777fd61e
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791543882; l=2738;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=6hQb1VevjYBv3Tw8uZWL9ZLHBJXvAlYAwVjC5B0voiA=;
 b=xVm3kndH/G7cBamiQ02aZpWZWpr4YLeaQTqHUqE73WJ8pnfsvzc6KM7seUy24Jb4DU1QAS8jE
 wTsqoNe7ba6DzBMR4WN4+E1Y0dWtNVzNxZCeE3QOGtho0uOLwHWgjeZ
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MyBTYWx0ZWRfXyhgKxIPnvy+U
 iNoqFd8CUT+LwD6M+7jeWgVRPMbbqN0vKTihT3aSSqWLqdrGEz57QPLV3rQ98unDp+km3FJtjqM
 4TIX+mDpvGGn+HMxBczWR3MhXHrc1oYyz67IitLAEGsYVPZV/fD3xNH4FGJN+9mdtb/eF3um92/
 SWndS4xA5XvyGq/4UVAC/A5s56E8PRTuOSwr+7G9dMlSASWXLrtFndfb4qk6wSBarvPDmxzHek7
 oKTWqiMW748LcvSwngykEXPlluU50KTJ2tk2bev6vvhpSw0Txa+EKuoXwM+YK/uGHjsLoaJXz+g
 zPr6beU5TSZ7QPHsIfdJsJ4WqiQiBm7euy7/OtXXHrIQBcL6lyArWy0k/gg03UAMaC2dkSYAiUy
 OD40uF2WS2pS2qKhPasokansBRp0LWo38s+r+4AK8dSmdvOQMl4n5SvcvHWsikH7PSy/m+OHJc5
 1gM4BHpRizNN/rhM1Zg==
X-Proofpoint-GUID: 9QPs50kLpkyRXT1IVYs6Cvsl_X_clgOZ
X-Proofpoint-ORIG-GUID: 9QPs50kLpkyRXT1IVYs6Cvsl_X_clgOZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MyBTYWx0ZWRfX3wBGlO/KpDIM
 0quUi4+88xnKzNYBhDAJl4BRtum71wixlnHB0bPz0rOFYf3kvs25Moq5U+kHpncbR/+0Ctcs6Uf
 E0AfKqk7UgMJ5FkXNJ7MLROcVAigT+E=
X-Authority-Analysis: v=2.4 cv=O62sLx9W c=1 sm=1 tr=0 ts=6ac8ca4c cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=aErvwOJsbcN-9OlzexIA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
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

Log freelist IDs not recognised by the driver when processing freelist
grow or reconstruction requests from the firmware.

In the freelist grow request path, remove a WARN_ON() which is not
particularly useful since it is known where the request came from.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Changes in v2:
- Fixed an issue pointed by Sashiko by replacing drm_warn() with drm_warn_ratelimited().
- Link to v1: https://patch.msgid.link/20261006-b4-improve-logging-of-unknown-freelist-ids-v1-1-96ebcb132b80@imgtec.com

To: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/imagination/pvr_free_list.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_free_list.c b/drivers/gpu/drm/imagination/pvr_free_list.c
index e85cac83834c..ec02fbbe0168 100644
--- a/drivers/gpu/drm/imagination/pvr_free_list.c
+++ b/drivers/gpu/drm/imagination/pvr_free_list.c
@@ -8,6 +8,7 @@
 #include "pvr_vm.h"
 
 #include <drm/drm_gem.h>
+#include <drm/drm_print.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
 #include <uapi/drm/pvr_drm.h>
@@ -367,8 +368,12 @@ void pvr_free_list_process_grow_req(struct pvr_device *pvr_dev,
 	u32 grow_pages = 0;
 
 	/* If we don't have a freelist registered for this ID, we can't do much. */
-	if (WARN_ON(!free_list))
+	if (!free_list) {
+		drm_warn_ratelimited(from_pvr_device(pvr_dev),
+				     "Received freelist grow request for unknown ID 0x%x\n",
+				     req->freelist_id);
 		return;
+	}
 
 	/* Since the FW made the request, it has already consumed the ready pages,
 	 * update the host struct.
@@ -564,8 +569,12 @@ pvr_free_list_reconstruct(struct pvr_device *pvr_dev, u32 freelist_id)
 	struct rogue_fwif_freelist *fw_data;
 	struct pvr_hwrt_data *hwrt_data;
 
-	if (!free_list)
+	if (!free_list) {
+		drm_warn_ratelimited(from_pvr_device(pvr_dev),
+				     "Received freelist reconstruction request for unknown ID 0x%x\n",
+				     freelist_id);
 		return;
+	}
 
 	mutex_lock(&free_list->lock);
 

---
base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
change-id: 20261006-b4-improve-logging-of-unknown-freelist-ids-8a69777fd61e

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

