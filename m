Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A83C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D6110E191;
	Tue,  4 Aug 2026 15:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="BUBhjhRH";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B2910E191
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:19:04 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674CWqhB3771746; Tue, 4 Aug 2026 16:18:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=f
 rR8TqrBXjEGIRStJ3PpHqQXpa6uSvnPnHUALa4tuzo=; b=BUBhjhRHnBGyVBVmO
 yMPuHXDGXoIA3Wr1ypSHnRdHRr6xqmeu5/mDkmMShExp0ozPurPmsbWrqizDL4wF
 ReIBW/20McmuVI8DREJQZK2R0ZO6FyVYOVguwXW7DqnsEaVlt4lrfZ5RHl0RkwGN
 qJwiHAKlr9dmghNsxst/LhqfvTIp/g9Y0D1ICWu8Il5NVGioHjCarWxUr+i2bXcl
 kGPBEU96d1jDoqX7wBNyHawoHdK2c4OL1Qzv6sRPSlhPhwm4RRZz1b1bj0uGQzEN
 kZacUABSG5UiVx+OoChMiGWhC58xpMTFMV/ExhW0N2Nilm0bXJDc9W/j0choEJwS
 DslvA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fs72pth1w-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:18:52 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.227) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 4 Aug
 2026 16:18:51 +0100
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Date: Tue, 4 Aug 2026 16:18:28 +0100
Subject: [PATCH v2 2/3] drm/imagination: Update Rogue heap comments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-staging-pvr-docs-fixes-v2-2-a5a9569a1c1d@imgtec.com>
References: <20260804-staging-pvr-docs-fixes-v2-0-a5a9569a1c1d@imgtec.com>
In-Reply-To: <20260804-staging-pvr-docs-fixes-v2-0-a5a9569a1c1d@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alessio Belle <alessio.belle@imgtec.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
CC: Alexandru Dadu <alexandru.dadu@imgtec.com>, Robert Mazur
 <Robert.Mazur@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785856730; l=2274;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=J438GCtU/rvgSbu0jaiKrEEf46S8UfZ7eOBXbZ6dLuo=;
 b=hHkwI6Fr3J2u8jEjm1zl83xG7jMAcIl1tnFPpQaGDjp9hHsQK4oDMVUyumPhTP6Om34n7f6c7
 +S0xHuyt7vGCP88d97yi/S+G4QfCgqkJcxVA1BKA9fAkKRUiF9ES58E
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Originating-IP: [172.25.4.227]
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyMyBTYWx0ZWRfX6d+yWoM9oCz9
 7C6sPWlVIudlNAQp6NyOId7aCejMswZuJho7otmhQ6U2jpHiUJbAuTN6oUVVDm8niphXJ2KN8uO
 HskPRqdkg0yTd/QIFP4NPHbew/8p5cg=
X-Proofpoint-ORIG-GUID: QKDFGvIBXRs-HvVu_ckNPneHw1Dr6an8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyMyBTYWx0ZWRfX5a2cUcHan/cI
 5cncAfTXffhBHbtOg5Il+v4s+xmX5GfN2dvaIGQPGCtZZKvRTU3dtWuh66vcUR1abs1ZkRZTuQV
 ORAySGRz4l3IeL3jwU9Ap9YNOk16zs4SfoFhP9sPXCkyuzbwOh8scb/D9JSSVX75qRfj8qfzeW6
 Wc3Wh5Egr5EpmAfDsz+V60VLJfsi9d1GZukcX1hgspVnZjVTOOzS/r0uMI8BVdoxIE8oAKZ+RCN
 6SnWC0ieRgFja3kpdlWDGoTeqL8JfllFtXtwyCZkIVXJjOfjlR8yjGU7LfMGV1GT4xgCdzde2js
 4luywOrQhQHhnz8eH6N0/A1Qhj/rcVNg17OJYJO+1BGQFkwW14q6PrvwPG/Phl1P2TijWTPlmuS
 osSsPWGQyLMyklUY76HbwjWQzRO1j6dLOGDyAn6lXwoDaUsq17CMkqU5y38ruX5xiifVhGPrJdt
 BGmlTP3KtRyqqqLi7kg==
X-Authority-Analysis: v=2.4 cv=auyCzyZV c=1 sm=1 tr=0 ts=6a7202dc cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=eoBRZU4O7WcA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=JD4wz_osbiijAFW_yLcA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: QKDFGvIBXRs-HvVu_ckNPneHw1Dr6an8
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

From: Alexandru Dadu <alexandru.dadu@imgtec.com>

Update Rogue heap memory comments to fix typos.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_rogue_heap_config.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_heap_config.h b/drivers/gpu/drm/imagination/pvr_rogue_heap_config.h
index 684766006703..5c33b342dda5 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_heap_config.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_heap_config.h
@@ -33,12 +33,12 @@
 /* 0 MiB to 4 MiB, size of 4 MiB : RESERVED */
 
 /* 0x00_0040_0000 - 0x7F_FFC0_0000 **/
-/* 4 MiB to 512 GiB, size of 512 GiB less 4 MiB : RESERVED **/
+/* 4 MiB to 512 GiB, size of 512 GiB less 4 MiB : RESERVED */
 
 /* 0x80_0000_0000 ************************************************************/
 
 /* 0x80_0000_0000 - 0x9F_FFFF_FFFF **/
-/* 512 GiB to 640 GiB, size of 128 GiB : GENERAL_HEAP **/
+/* 512 GiB to 640 GiB, size of 128 GiB : GENERAL_HEAP */
 #define ROGUE_GENERAL_HEAP_BASE 0x8000000000ull
 #define ROGUE_GENERAL_HEAP_SIZE SZ_128G
 
@@ -62,7 +62,7 @@
 #define ROGUE_PDSCODEDATA_HEAP_SIZE SZ_4G
 
 /* 0xDB_0000_0000 - 0xDB_FFFF_FFFF */
-/* 876 GiB to 880 GiB, size of 256 MiB (reserved 4GiB) : BRN **/
+/* 876 GiB to 880 GiB, size of 256 MiB (reserved 4GiB) : BRN */
 /*
  * The BRN63142 quirk workaround requires Region Header memory to be at the top
  * of a 16GiB aligned range. This is so when masked with 0x03FFFFFFFF the
@@ -82,7 +82,7 @@
 /* 0xE1_0000_0000 - 0xE1_BFFF_FFFF */
 /* 900 GiB to 903 GiB, size of 3 GiB : RESERVED */
 
-/* 0xE1_C000_000 - 0xE1_FFFF_FFFF */
+/* 0xE1_C000_0000 - 0xE1_FFFF_FFFF */
 /* 903 GiB to 904 GiB, reserved 1 GiB, : FIRMWARE_HEAP */
 #define ROGUE_FW_HEAP_BASE 0xE1C0000000ull
 
@@ -90,7 +90,7 @@
 /* 904 GiB to 912 GiB, size of 8 GiB : FREE */
 
 /* 0xE4_0000_0000 - 0xE7_FFFF_FFFF */
-/* 912 GiB to 968 GiB, size of 16 GiB : TRANSFER_FRAG */
+/* 912 GiB to 928 GiB, size of 16 GiB : TRANSFER_FRAG */
 #define ROGUE_TRANSFER_FRAG_HEAP_BASE 0xE400000000ull
 #define ROGUE_TRANSFER_FRAG_HEAP_SIZE SZ_16G
 

-- 
2.43.0

