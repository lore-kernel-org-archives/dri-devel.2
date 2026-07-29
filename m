Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73C9C54FCD
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD91610EC5F;
	Wed, 29 Jul 2026 14:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="cENGeIXn";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7513B10EC60;
 Wed, 29 Jul 2026 14:57:37 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TEL64J1014198; Wed, 29 Jul 2026 15:57:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=nkB+8PhCDTepddBtcj/x0b1
 LNJA1Z1bQb/MnbhQJDwY=; b=cENGeIXn3yBNT/Th+KKKXiVsTNrpj76JUIzm2pO
 UUU3PnzNc0Yy5Y5oriaLmGJL/sZZzBVMsq73mL68DY31xnw6vSpKgKTbiuTrBGVs
 CcVDCjZSeqOXHN7FGFnWvq2JcFv4YIdSbzB6736KiOneFpcifXn1W5TmGSmucse3
 yplb7JPfsRlGg9SPdyltNcwBT5QL5lcBh0Fii7qPzgUg8aAtWHAWbCdIWaLfXCFv
 L4PjruNDIWJIm41XBE0n2BlzpF2iszybafXWhMQg69xQLU1+PQuSJPXFDlVXP4Wr
 j0rXcyEXfZpKJCXISxQYkEx6ShRgYJt+2gvgcx/Zo97kMRQ==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fq8kr0hvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 15:57:28 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.151) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:57:27 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
Subject: [PATCH 0/2] drm/imagination: Tidy-up firmware interface checks
Date: Wed, 29 Jul 2026 15:57:05 +0100
Message-ID: <20260729-fwif-checks-updates-v1-0-af65e9606a7e@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMEUamoC/x3MSQqAMAxA0atI1ga00DpcRVyUNtUgqDROULy7x
 eVb/J9AKDIJ9EWCSBcLb2tGXRbgZrtOhOyzQVXKVI3qMNwc0M3kFsFz9/YgQa2sD63Rjak15HK
 PFPj5r8P4vh8l9i/mZQAAAA==
X-Change-ID: 20260729-fwif-checks-updates-52adf8657615
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <imagination@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Alessio Belle <alessio.belle@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138;
 i=alessio.belle@imgtec.com; s=20260628; h=from:subject:message-id;
 bh=Vo/4Ts7Xj+yuyOmmuB0f2dhejS1nx+5STSM/DmwpNwM=;
 b=owGbwMvMwCUm4nVW5aiD4lnG02pJDFlZIteyPt651dt5Z2K3oMARr/+8jrtyXrraTMxvMNty9
 rvXjDVTOkpZGMS4GGTFFFk+7Nv431bvQ60Uw/aLMHNYmUCGMHBxCsBEIvwZ/jvf/TSZaZI9i0Vb
 YFyaaOJyI5NN56SZuqWWKaq+SP4RPJOR4WrHi/ZUybjjwpni/SG+Pw+ksRY7vPPu+v6FLfBwcwc
 DFwA=
X-Developer-Key: i=alessio.belle@imgtec.com; a=openpgp;
 fpr=F0BEB1FF3D2EF07D1A00B7D1144ACD24C54021CD
X-Originating-IP: [172.25.4.151]
X-Proofpoint-GUID: Wj9RAn_O2S1AEy6oWS0Oklv7V9nM1kP9
X-Authority-Analysis: v=2.4 cv=It4utr/g c=1 sm=1 tr=0 ts=6a6a14d8 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=XqWWZq4ChBYA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=a31eimTOKK-w3O9IxzoA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfXyQfJx5Y0dCZv
 WgP45lpf71rPETk0G3vkhh6b1898zz3BkcZJ4M3ip3qNx6TDSIpQYcM99NDVJZj3wwcCyGkGC+l
 /gfD1997CkYoQl+qpWcvqKpuXve86S6PtWVlcTjneCh4fNqxaSFgrVlzTiHZuAFuOUdEZWopMJ3
 v3sVuTimx47AfUIbbcw57EdQ4T1/PnPXdjj0WjdrcCFZbRNRG8YaafLCIOOZ5Gp5PrBwVcypyCj
 XeW5qfEdEX18pxvSTvaLtd5msowczynQ+81jWYJNn4f0FxLBJfYLLTxuIZrqK1NFIk5SNJxJs7d
 /tfxaMErAgdPJBUbYJydmckqWY3//D3RT/unZWRcmQfCbvslpISDBZd5XYnumLxmsy7AjojdR6S
 bQsniZWY+Kj8dAsomGhElxe9AtXLYCLl4hWQCzRFZqs9V6CEEsJWHiSmCqjhfQEY4U2GZqHB6M7
 QUsQQ+7gmCFaQf5YfVQ==
X-Proofpoint-ORIG-GUID: Wj9RAn_O2S1AEy6oWS0Oklv7V9nM1kP9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX9wYcNgDC1kzA
 79XaFRDablbq5n60Mogy6oSmIuqxyQLMpLTb9Y37rKT1ROLabznzzk69YIxfxVxh2V7VwDlxyZ9
 wm0Tc14H/CMOfLiCkp4Jq/PfhwQnwyY=
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

The same macros were repeated in multiple header files, and another
header that could have used them, didn't.
Move things around to to sort out these minor issues.

Strict checkpatch reports "Macro argument reuse 'member' - possible
side-effects?" for FLEX_ARRAY_CHECK() but that's not a problem here.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
---
Alessio Belle (1):
      drm/imagination: Reuse layout check macros for MIPS FW structures

Alexandru Dadu (1):
      drm/imagination: Move all FW interface check macros to pvr_checks.h

 drivers/gpu/drm/imagination/pvr_check.h            | 36 +++++++++++
 drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h | 26 +-------
 .../drm/imagination/pvr_rogue_fwif_client_check.h  |  9 +--
 .../drm/imagination/pvr_rogue_fwif_shared_check.h  |  9 +--
 drivers/gpu/drm/imagination/pvr_rogue_mips_check.h | 71 ++++++++--------------
 5 files changed, 63 insertions(+), 88 deletions(-)
---
base-commit: e55fead22ff9ee047ab9f1903860c4b43043514e
change-id: 20260729-fwif-checks-updates-52adf8657615

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

