Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF68C5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A6210E5A1;
	Mon,  3 Aug 2026 10:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="L6p0dkzV";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 377B510E5A1
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 10:22:48 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673AElVG939482; Mon, 3 Aug 2026 11:22:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=w
 cXX1YAkZmwtjMUuqag8BVD1dAqZOHnkvQ887CiKJ4c=; b=L6p0dkzVTAiUaZLpe
 abhwQi8XPmR82eo1hWrAgZnC+GkDmpgiduASXtgLBz4GvMhO2ZyPLIK76E21+O2t
 tzftSUVshj1KTdW9ZOr6TFlyReKGxXJou5j5opKFvQ2S+BKdA5029UTJB9yrnqGG
 KIDTtGtIz9JlWO11ndcVvh7cFE6Icufx4rwZ8U0o/0NaXE57ReVdAhClLlz90gYU
 0XNyvtOsd8UPRrDnZoGgvE8TyCSeJ/W0L96CDMR3dWuAIDmLFPOWx2gsHeb8SGCU
 CUag9R351DGX4bKCbf4brVQbH2gfGnCrlMVxiVPlHEbkBW2GxYKks1ejTNedAto2
 c9jdw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fs72psc8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:22:41 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.227) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 3 Aug
 2026 11:22:40 +0100
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Date: Mon, 3 Aug 2026 11:22:25 +0100
Subject: [PATCH 1/3] drm/imagination: fixup some docs in pvr_gem.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-staging-pvr-docs-fixes-v1-1-0d014c7b2671@imgtec.com>
References: <20260803-staging-pvr-docs-fixes-v1-0-0d014c7b2671@imgtec.com>
In-Reply-To: <20260803-staging-pvr-docs-fixes-v1-0-0d014c7b2671@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alessio Belle <alessio.belle@imgtec.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
CC: Alexandru Dadu <alexandru.dadu@imgtec.com>, Robert Mazur
 <Robert.Mazur@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785752559; l=1443;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=o6i36DuWKfttOEshBK01quc3Cd8jhTEsPbR0QThczjI=;
 b=vQ94sXU3TatCVTkOrNGIm+ni59/DdrT9CKou+/ppWb6kkajkyU82qL4lgE7wNhdaxNwFkofsv
 EONqRRP7es2D85DIBg4vCjUcpMtDROFdIgAm2OBnK8zt8HOOYJzyUxe
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Originating-IP: [172.25.4.227]
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5MiBTYWx0ZWRfX/WgJE30oAdtK
 mXGSdV8yiPxcVCiP78ZQ+/8am2VjX9GBZlsGfDDZcLhybqQ3b0kNuICsdHj396uMmtuTWRDIlnC
 saHRpTDbbNa9Nssu+o4XvHADD7K4ctY=
X-Proofpoint-ORIG-GUID: 1Z7WGFkYaKHLs8UfsASFs4SzjGwWv2We
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5MiBTYWx0ZWRfX9T9RTTV8FcBA
 NlDut08xBylOMJVkWSOPFIKXMgRXdbV2pgvNtX8rw+zY/DBNgVZkTHGD/h2u6eYZ4WUeSN53QvU
 ZHmr30MYjohkirQx4iy6DnjzJMLLbbghVygr+Tg+P5TkS2gh/L1j1xln7jqP56LRYLXUYPqo0je
 anAhPaErQz2hNlYwdNT/GEXdQu2Bz6NQi29Bhbi2P0T37CesveFJnZms+BEgBN21F332Y0aWvj3
 L9boQx+V5WqgCiVzY8It8aNy67ye3114izI2KQoC6cWwSS+YEPGGNRniEhnB6uRYHdFxDyPlISY
 CzQL++Gws5xMFm20AGW9mHzMxr9XJH6zHVPCVSfZTmY+enWrd2SQAWnxUXo1GcDhfEB13uFZbsw
 sIPubGTdVWmV232bXxryMu5yWdMuzOC/RJ0O80CAetuy+/9xmDVOu2b2KJGxNhg0efyJRfJrA6P
 RqiY1JCEQjBwGSeteJg==
X-Authority-Analysis: v=2.4 cv=auyCzyZV c=1 sm=1 tr=0 ts=6a706bf1 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=eoBRZU4O7WcA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=ooUk36yzADL0IjFuPhkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 1Z7WGFkYaKHLs8UfsASFs4SzjGwWv2We
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

From: Matt Coster <matt.coster@imgtec.com>

Update and remove some old comment in the PVR gem documentation.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_gem.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_gem.h b/drivers/gpu/drm/imagination/pvr_gem.h
index c99f30cc6208..c57b0834b7ae 100644
--- a/drivers/gpu/drm/imagination/pvr_gem.h
+++ b/drivers/gpu/drm/imagination/pvr_gem.h
@@ -81,11 +81,12 @@ struct pvr_file;
  * struct pvr_gem_object - powervr-specific wrapper for &struct drm_gem_object
  */
 struct pvr_gem_object {
-	/**
-	 * @base: The underlying &struct drm_gem_shmem_object.
+	/** @base: The underlying &struct drm_gem_shmem_object.
+	 *
+	 * .. note::
 	 *
-	 * Do not access this member directly, instead call
-	 * shem_gem_from_pvr_gem().
+	 *    This member should not be accessed directly, but instead by
+	 *    calling shmem_gem_from_pvr_gem().
 	 */
 	struct drm_gem_shmem_object base;
 
@@ -97,12 +98,6 @@ struct pvr_gem_object {
 	 * changed after creation.
 	 *
 	 * Must be a combination of DRM_PVR_BO_* and/or PVR_BO_* flags.
-	 *
-	 * .. note::
-	 *
-	 *    This member is declared const to indicate that none of these
-	 *    options may change or be changed throughout the object's
-	 *    lifetime.
 	 */
 	u64 flags;
 

-- 
2.43.0

