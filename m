Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76067C5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A8B10E010;
	Mon,  3 Aug 2026 10:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="yBk513MP";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3163610E029
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 10:22:48 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673AElVH939482; Mon, 3 Aug 2026 11:22:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=k
 urOVtZC0Od1/elYOgaYoeY2jAZePEhk+OK8ygrj258=; b=yBk513MPMtVYQq1Fe
 TsChACkZPZJruLtZjWZQtgt5tHNpeR4Wp+amDU6ndDxSY9c9uBDmalYaPfsyh8Te
 deyv2Mdsr61Eeso0moSTfxk0rf+3qJ6b8Jaqozwmm369CeSqQSUniWwrKZRjyH7h
 ZHjN4Ejc0NIshgQAYCPVO1oRawL1LzCk4dvnFWcNYrzBbnpygHpSO757CMD8JswH
 moGG58CkV/K1FLQW5tBcs3r0jjYJJq8vKIlATgmYWRqdnFZPLUaMdCGWgmTE99Z8
 czvi6UR2lYw9G/nhHPxuwAYhxvlBF4CXORKgBiqzluuu7Pr9s6f76u65MhNP6f8H
 wNlwg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fs72psc8b-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:22:41 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.227) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 3 Aug
 2026 11:22:40 +0100
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Date: Mon, 3 Aug 2026 11:22:26 +0100
Subject: [PATCH 2/3] drm/imagination: Update Rogue heap comments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-staging-pvr-docs-fixes-v1-2-0d014c7b2671@imgtec.com>
References: <20260803-staging-pvr-docs-fixes-v1-0-0d014c7b2671@imgtec.com>
In-Reply-To: <20260803-staging-pvr-docs-fixes-v1-0-0d014c7b2671@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alessio Belle <alessio.belle@imgtec.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
CC: Alexandru Dadu <alexandru.dadu@imgtec.com>, Robert Mazur
 <Robert.Mazur@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785752559; l=2219;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=7vQDYaYoP5SbUrgUxml9jB15bz/E2/vZ+563xGdLMk4=;
 b=74rQ3karsl9BFUi5FyJRTFoJlNNGWemIvvoOCzrqQS+/RPz97iW8+dG2iqtgJFu8oYJh9fIYG
 6PIQSv2MLs8CQTmqVEqz2/YpX+g9N0wlJ+npCcurcrhdDlxPgoW7ryi
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Originating-IP: [172.25.4.227]
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5MiBTYWx0ZWRfX4hgE3vdjTLuz
 6FNwGNsrdqQ3oLNibhHcBzJMnw1OaB6z9FFmtER8/xc5SlwDR7DIH/4k5mbwVClWhpwjR1ORa73
 Tgv69VJZU+2LugA++DGUVCBMusOtC2A=
X-Proofpoint-ORIG-GUID: tFw3Aij93u104PyCkfTsFMrPPqQx9DHj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5MiBTYWx0ZWRfX/EKf5KWnBnXy
 qIIlQ52/nruXgiUuvuS0iC+UJRvb9lIosckt4yvj78KutisZtF4AkbKyi7RE1YYkIdyvd2pgE9W
 YoWxTiTaU89gVE7zmChp5wcRaweMslb61BWgywP1QI6eKu5DxwgE8lFJ+BHHKZw9SUY82RxDpn2
 XWS9sDCcdV4P0Gpsu3D94qt8s26NH+i5OWbifKTt6pRXl7mKyFu1BA7007fZD6Tydb+g4WRkgMI
 sMeml0HBJeizumlwmI81pG5sWbLKL7nQwlIGL5rt0FYRwNAIT8Zd5hznsjDwQ+x2rORobOUgQSp
 kd5rievjsu7i9ltCOVk6rhS+c6JjSOwMINdHw9fdXKM/n7OgViEWJEV/ROOQ69rdW2ZeDIezcQ0
 csSHoaFvyH88b/OuQ5uR3UW80BRxQZ8X3KrZ/SZuljQA15MC1eQ3Au5RuqdXIYx0DOYjFHsQvt+
 9LiidJCCl8mNjLpVMDw==
X-Authority-Analysis: v=2.4 cv=auyCzyZV c=1 sm=1 tr=0 ts=6a706bf1 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=eoBRZU4O7WcA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=JD4wz_osbiijAFW_yLcA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: tFw3Aij93u104PyCkfTsFMrPPqQx9DHj
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

