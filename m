Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30051106FD87
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC77F10EAF3;
	Fri, 13 Mar 2026 06:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="GKKNkpv9";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6463910EAF1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:39:45 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D5sO7d2322817; Fri, 13 Mar 2026 06:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=l
 zzGSERl0L8c9Jx0ZXBGNvttJTSYx1Hv8KHGUAtoAPY=; b=GKKNkpv96/Q0C9ujP
 MIhzI0To7a605u78vonmSJ9LT1KzEeyETZKMSpEcUbqUbFvVNeMAszeM6+1YynM7
 Atn+qY6xz+BuCjjFPtYYIED5Zd6crnx95sgZeNodjJ73QaVphJJ+p1ECnxkCZUqS
 5kb+JvJ47KX0SBsxggwHDGdTRsUYV90gtctg7zUt2srB+GzEuXDHOyU3TKMu/VtA
 Ka30NUK704g7YVePTYAAEwHZozi3J1QAbW3oXvECmmR2afndDB8km69quXWXi1q0
 Sul5wCMYxm1ZFXUGfTj0noFepGuVoRfsiEDp3vuqxqUzPpe+q1gPNQCqN9a1HsiC
 a+6SA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4ctxygj76x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 06:39:34 +0000 (GMT)
Received: from NP-G-BRAJESH.pu.imgtec.org (172.25.128.99) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:39:32 +0000
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Fri, 13 Mar 2026 06:38:25 +0000
Subject: [PATCH v2 2/2] drm/imagination: Skip 2nd thread DM association for
 non META Firmware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260313-b4-staging-layout_mars_base-v2-2-9e3c251d278e@imgtec.com>
References: <20260313-b4-staging-layout_mars_base-v2-0-9e3c251d278e@imgtec.com>
In-Reply-To: <20260313-b4-staging-layout_mars_base-v2-0-9e3c251d278e@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773383967; l=1619;
 i=brajesh.gupta@imgtec.com; s=20260107; h=from:subject:message-id;
 bh=DF40QuvaeShHL2JiFKo2KsxvJDvlGooMAxxPuQ2rLE8=;
 b=+w+9+xALusI6jUuyZy4N4uBd0T7WzeKq41hD9M+Opl4GO47hdmMo4BGAFclAKhAUDwMGgeOjN
 boOhk8tDqAACYFkZ3iIXPIurBOQl6FPXOBwBXC+X5FaIFPxR0P6qu9k
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=mxdDr22E/sHiu68U/bLe0W/SRYi3i848ZgoBuEyk21E=
X-Originating-IP: [172.25.128.99]
X-Proofpoint-ORIG-GUID: aFfXS0qeGkEjLGPtDpTMgI1azv1gFBvR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MiBTYWx0ZWRfXxvT+Ph7rnzxI
 gcHrNXAZXisQGFOTe9by+D+DSbAoIHqJPoCCWnB/6u9++vCmm99gF9XUIi4dqSSCp6LuQiJ5Y2i
 L05pINe2zzIbcJR5Hc+1pMMzEUeHwJd9zQK9eEm+YmE5N+E3wrD18MADv0sGjy0BjshGFC7Pnmv
 XfFD8h6v5V1LYJmhzkU0ympaHhyA8/nE7kt5TP3QrLlk+1A6fr3LU25pgq0qwk5ouooY2qfpC0J
 rOpfUwvA6+b+m9r08BjdSsKvP+yHGcrHyjGKUW6K1PGNi1XK74cMRcTu3VTZb4BL5eMtnFnBP7W
 AIs3Q0/2Xh8aCeEJIt/y7q3t1gVjMRGNcx2bFIBAWO7aPdMOsD/x9lpp/lX+WwhL77T6fQpbgpb
 qms3XDiiriXICQHnnRZ/dvhwZj/8E7x8zIKuYIXCZQFMcWhascHjsEMSvC/Gfs+ZLj6V7zseieY
 Hifaxc1StxWIlIk3w2g==
X-Proofpoint-GUID: aFfXS0qeGkEjLGPtDpTMgI1azv1gFBvR
X-Authority-Analysis: v=2.4 cv=NevrFmD4 c=1 sm=1 tr=0 ts=69b3b126 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1Ouegpa_-vYA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=EaV5GBJ_m_rbC6YcNDMA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

Only a META firmware can have two threads.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_startstop.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_startstop.c b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
index e47224ac0547..2f90bc1bf084 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_startstop.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
@@ -243,12 +243,15 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 	pvr_cr_write32(pvr_dev, ROGUE_CR_MTS_BGCTX_THREAD0_DM_ASSOC,
 		       ROGUE_CR_MTS_BGCTX_THREAD0_DM_ASSOC_MASKFULL &
 		       ROGUE_CR_MTS_BGCTX_THREAD0_DM_ASSOC_DM_ASSOC_CLRMSK);
-	pvr_cr_write32(pvr_dev, ROGUE_CR_MTS_INTCTX_THREAD1_DM_ASSOC,
-		       ROGUE_CR_MTS_INTCTX_THREAD1_DM_ASSOC_MASKFULL &
-		       ROGUE_CR_MTS_INTCTX_THREAD1_DM_ASSOC_DM_ASSOC_CLRMSK);
-	pvr_cr_write32(pvr_dev, ROGUE_CR_MTS_BGCTX_THREAD1_DM_ASSOC,
-		       ROGUE_CR_MTS_BGCTX_THREAD1_DM_ASSOC_MASKFULL &
-		       ROGUE_CR_MTS_BGCTX_THREAD1_DM_ASSOC_DM_ASSOC_CLRMSK);
+
+	if (meta_fw) {
+		pvr_cr_write32(pvr_dev, ROGUE_CR_MTS_INTCTX_THREAD1_DM_ASSOC,
+			   ROGUE_CR_MTS_INTCTX_THREAD1_DM_ASSOC_MASKFULL &
+			   ROGUE_CR_MTS_INTCTX_THREAD1_DM_ASSOC_DM_ASSOC_CLRMSK);
+		pvr_cr_write32(pvr_dev, ROGUE_CR_MTS_BGCTX_THREAD1_DM_ASSOC,
+			   ROGUE_CR_MTS_BGCTX_THREAD1_DM_ASSOC_MASKFULL &
+			   ROGUE_CR_MTS_BGCTX_THREAD1_DM_ASSOC_DM_ASSOC_CLRMSK);
+	}
 
 	/* Extra Idle checks. */
 	err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_BIF_STATUS_MMU, 0,

-- 
2.43.0

