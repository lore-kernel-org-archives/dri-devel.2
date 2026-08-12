Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC86DC5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 11:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0593710E2FD;
	Wed, 12 Aug 2026 11:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="I6LK++dL";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BDF110E2FD;
 Wed, 12 Aug 2026 11:47:14 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB3Px23179683; Wed, 12 Aug 2026 12:46:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=cpb74TTTMbtHGcztYHTfmAo
 u6grPgYQAdKdlZq+DKDs=; b=I6LK++dLsCht6K8JW3ADFFO8/Qlf9iCLelhAyxu
 gDmN2WgIvD9gKjFmEJcQyZYYCtReRyHGe87/ZDbCq+LmgBhhnplEOcOachICIbVS
 lfWrFATvH6HLXGL2BYZPJMkNofaEUQWO9XiV8C4QrSiMizWT790Q+CodDpGbNzd0
 yOce2MyVoA5I9HHcIeUC3cpoqpb6oDCBNIAhJe90Pj3v2FiChY090uJ1fKEqMwOG
 gTI2jTOzL5muyOKx63p8E6VnPd1atakRjrmDzEPjHfOQSIxnjur9YXn7oiQQ0GvY
 hHsoKewhJ+/vlcraRVuxKIlRSCjqssVOFjuvtnFnpN6Ll2w==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fysk3hg30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 12:46:59 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 12:46:57 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 12 Aug 2026 14:46:48 +0300
Subject: [PATCH] drm/imagination: Fix NULL pointer dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260812-fix-null-pointer-dereference-v1-1-f69b2ffe9520@imgtec.com>
X-B4-Tracking: v=1; b=H4sIACddfGoC/yXMwQrCQAyE4VcpORvoBpGtryIedHeqkZKW3VYKp
 e9u1MMcPgb+jSqKotK52ajgrVVHc4RDQ+l5swdYs5uklVMbg3CvK9syDDyNajMKZxT0PktgSbE
 L4Si5i5E8Mfml6y9/uf5dl/sLaf42ad8/UDRuj4AAAAA=
X-Change-ID: 20260812-fix-null-pointer-dereference-2c891142d988
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786535217; l=1943;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=lIPNx1UoS/uuznRxVcW/U6w6rgCt55U9k4LBVKP/9dM=;
 b=5ru3cL4yrtDYn654dIw1YeUBcxMHb80rqG4k5zY5aUDAZbRzWYPPCPL3esPOknGKpNKoeRAuu
 6vExA0cEpc6B/GUmbWQWhVSMIi5SlTKk0JBrLfVF4YDaKy26ebWI2RZ
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Authority-Analysis: v=2.4 cv=DcwnbPtW c=1 sm=1 tr=0 ts=6a7c5d33 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=mTYf-tJyuyeqU9PAA0gA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5NSBTYWx0ZWRfX9WXf3lfk2J+A
 qzq4znqFcTwmY4hXJ6cRkEpHAyemK8kbPMkkJAyuhK9WEqVU4C4590MhGq8gHNF1LVrTQHsCGhu
 ZvIsTs5NClsCXKMIQrXohApkSRQ7bPUL+6XX1w5857BJ9e+c/YOv4M2IJngPlfdAfrQqhn49ngZ
 JCo0QAHsjq1/P95lupShcR9dVL28NSXpy0AlEwo3DdLBOs6FCSwiWOK5ghS0+sZ2LA8H2LQ80oD
 NWyyIds7O1bE/TAjpEqe/6cdsveF9CRZ3g/SGDrxnFzGKjIOLZIvG0a3dzI7V9GTYlBFpbWnw7t
 PREtoPZ3ZnNiDK+OmzDTFSmHh6FJ91ih63ZnjzAEUl89zkh2+6GwZ5gH3RuxgWQJte0CbvClRMD
 ZK1DfgJFgUtz19ZuUbZZ67v4HOfXj7+H0mcxpGvCgyO0qhEfjs+8JKOgDJRacpzRIAmHm3gLW7N
 XNr2MgUuMHVclq46/Pw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5NSBTYWx0ZWRfXz69xyA7MFJe5
 abJwGd3QI/x5sz9RWloz+7YdQ/M9cxpZKfh51ym5jRmT0qgxxIVMRu7MqVjXLdaTffIlKIQHiFs
 wEC7RKm3l1d6ixgSImjeQ/ghl+PJASQ=
X-Proofpoint-GUID: I-gLHxjMVoikDARHpAgyV6q4f_EHyEGG
X-Proofpoint-ORIG-GUID: I-gLHxjMVoikDARHpAgyV6q4f_EHyEGG
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

Fix the NULL pointer dereference from pvr_fw_object_destroy() when
handling allocation failures.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index 850a3ec8e775..88f11fb01304 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -1425,22 +1425,26 @@ pvr_fw_object_create_and_map_offset(struct pvr_device *pvr_dev,
  */
 void pvr_fw_object_destroy(struct pvr_fw_object *fw_obj)
 {
-	struct pvr_gem_object *pvr_obj = fw_obj->gem;
-	struct drm_gem_object *gem_obj = gem_from_pvr_gem(pvr_obj);
-	struct pvr_device *pvr_dev = to_pvr_device(gem_obj->dev);
+	if (!fw_obj)
+		return;
 
-	mutex_lock(&pvr_dev->fw_dev.fw_objs.lock);
-	list_del(&fw_obj->node);
-	mutex_unlock(&pvr_dev->fw_dev.fw_objs.lock);
+	if (fw_obj->gem) {
+		struct pvr_gem_object *pvr_obj = fw_obj->gem;
+		struct drm_gem_object *gem_obj = gem_from_pvr_gem(pvr_obj);
+		struct pvr_device *pvr_dev = to_pvr_device(gem_obj->dev);
 
-	if (drm_mm_node_allocated(&fw_obj->fw_mm_node)) {
-		/* If we can't unmap, leak the memory. */
-		if (WARN_ON(pvr_fw_object_fw_unmap(fw_obj)))
-			return;
-	}
+		mutex_lock(&pvr_dev->fw_dev.fw_objs.lock);
+		list_del(&fw_obj->node);
+		mutex_unlock(&pvr_dev->fw_dev.fw_objs.lock);
+
+		if (drm_mm_node_allocated(&fw_obj->fw_mm_node)) {
+			/* If we can't unmap, leak the memory. */
+			if (WARN_ON(pvr_fw_object_fw_unmap(fw_obj)))
+				return;
+		}
 
-	if (fw_obj->gem)
 		pvr_gem_object_put(fw_obj->gem);
+	}
 
 	kfree(fw_obj);
 }

---
base-commit: e55fead22ff9ee047ab9f1903860c4b43043514e
change-id: 20260812-fix-null-pointer-dereference-2c891142d988

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

