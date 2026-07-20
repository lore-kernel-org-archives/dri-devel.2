Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16A4C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA0810E8B6;
	Mon, 20 Jul 2026 11:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="fcWJ3Adb";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1974110E8B7;
 Mon, 20 Jul 2026 11:38:03 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAwUxa2673859; Mon, 20 Jul 2026 12:37:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=X
 b/D/txita9G4g+FRrCnFs+KGcm29v7OZmroEtFh4DM=; b=fcWJ3Adb0wrZSr2xQ
 pF64NcAYXE6KKhUymVtro7kqOx2DNZedetonTYqq0Ix5tXmxjPP/RJ/mjGNnztet
 sd1LroeRYCJaW4jgRHdEMEbCyceql1pvLa1w0aZTbhEdggArS22XTPr26jYkiIxv
 lpn/0NFF9hrKP4+uR0UqOM3jZzE8kL4Z1dDYQ9FXHVdSNoiNDAJ4MBXOtksn+9DX
 RUiB1zQPdFK8rbt3b/GnD9ip3z0JAdJKqazjH1AtPxswxe66lBVECG+iakn6KXSs
 u1+A5nfnE/qwMZWWd7ekjucBFDSf1HVdregMjNJUu/QA4Zk2LLoyzxjrfaLDTLid
 N5cxw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4ffyrq9hn7-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 12:37:50 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.138) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 20 Jul
 2026 12:37:49 +0100
From: Frank Binns <frank.binns@imgtec.com>
Date: Mon, 20 Jul 2026 12:37:13 +0100
Subject: [PATCH 2/2] drm/imagination: promote BXM-4-64 MC1 (36.52.104.182)
 to supported status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260720-promote-bxm-4-64-v1-2-39abcd1cf263@imgtec.com>
References: <20260720-promote-bxm-4-64-v1-0-39abcd1cf263@imgtec.com>
In-Reply-To: <20260720-promote-bxm-4-64-v1-0-39abcd1cf263@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Frank Binns <frank.binns@imgtec.com>
X-Mailer: b4 0.15.2
X-Originating-IP: [172.25.4.138]
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyOSBTYWx0ZWRfXxCuZPeMK9wRg
 U7dm2jCDP83lrj7Fs56hh9+wK8zV6yBl12K0W2EKfK67Paj6Dcbe8Iz5NeTrgP/ZDNP45TwiOMj
 EkKkxvv1JiFYiyIGyUKOHD5lKNJRddM=
X-Proofpoint-ORIG-GUID: IW3cSN9aOpcoeTKLp7uMnvj-370Q5r8S
X-Proofpoint-GUID: IW3cSN9aOpcoeTKLp7uMnvj-370Q5r8S
X-Authority-Analysis: v=2.4 cv=a7sAM0SF c=1 sm=1 tr=0 ts=6a5e088e cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=NzHnPcJToGcA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=p0WdMEafAAAA:8 a=r_1tXGB3AAAA:8 a=pG7CSXjEOt7wFpZSbEoA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyOSBTYWx0ZWRfX9O/fDNl1Pk2B
 vuAsBRPrqetXn/u6nKHnlZYUjl7S7wpignv/XoMNTp7lf31Zz5/hmem8WiZcFGY5Gz+rO08j3Im
 V9pzTYHsM4Jr6p0HmtxQihRZVM7ijYkwtaxGRz0+KTUSpYkB2TEiYYujWltsInVx1xRXaG9itVH
 f8OBLxmI0vplxtShXjTRIbhAU9rab5GX8G5HtX8PJtNyteRomQcBt2UxSfxQNV5X8H+CYV0Fkx0
 TqeDpU4w1kzF7k/6sandO+MtjwCJo2wXWhJ2sSkIFHdI30xVv0JITT8knp5GC0urWIgYGfw3B7P
 KVj/lOYIqPso1YSAy6eZk3V1JIpBqoBEcfBTNh86ZL5UXMuRShbdCCBPRypLRMrGkbi3cd58MM5
 58ZJB4/pRyfxlkm3xy9N0GX42ovW8QudYdSyf64RL+GMcGukE0fEFC+iNA2kusZT8cuRQ1iO6p7
 wr3XhzDt6wXSNlpr3JQ==
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

Support for this GPU is now in a very good state, with only a handful of
Vulkan CTS tests still failing when testing using CTS version 1.4.5.3 on
the BeagleV-Ahead SBC. With the firmware having been upstreamed [1], now
is the time to promote this GPU from experimental to supported.

[1] https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/1138

Signed-off-by: Frank Binns <frank.binns@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_device.c | 4 +---
 drivers/gpu/drm/imagination/pvr_drv.c    | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 2691ef9af0ca..54fe4180c73c 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -531,12 +531,10 @@ pvr_gpu_support_level(const struct pvr_gpu_id *gpu_id)
 {
 	switch (pvr_gpu_id_to_packed_bvnc(gpu_id)) {
 	case PVR_PACKED_BVNC(33, 15, 11, 3):
+	case PVR_PACKED_BVNC(36, 52, 104, 182):
 	case PVR_PACKED_BVNC(36, 53, 104, 796):
 		return PVR_GPU_SUPPORTED;
 
-	case PVR_PACKED_BVNC(36, 52, 104, 182):
-		return PVR_GPU_EXPERIMENTAL;
-
 	default:
 		return PVR_GPU_UNKNOWN;
 	}
diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index a22da0b911d5..5c965ef0274f 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -44,6 +44,7 @@
  * This driver supports the following PowerVR/IMG graphics cores from Imagination Technologies:
  *
  * * AXE-1-16M (33.15.11.3)
+ * * BXM-4-64 MC1 (36.52.104.182)
  * * BXS-4-64 MC1 (36.53.104.796)
  */
 

-- 
2.43.0

