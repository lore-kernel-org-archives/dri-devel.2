Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EECC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 04:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA4110E1D7;
	Wed, 29 Jul 2026 04:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="t4lpvm3Q";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C3310E9C5;
 Wed, 29 Jul 2026 04:19:45 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T498NV4181473; Wed, 29 Jul 2026 05:19:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=miR0E78ZjiqCMhBU4fcQk7R
 Efbg4WbxJDOm5SW9fTuE=; b=t4lpvm3Q3YLE+AdSiamVFdt6nOWGL7r0HuQcUkx
 OI8mXSyDjP/A1pEeDKVJt5KSWjFFE+YgoWtLU6d44HRa8S3P83zkuE5Vrndp3KWk
 eLyCoj4HlU4lgRt4e7EKPetHCd3lGSfBZBArTc/kuPOm3zXEmpcqwjQybaogwZFk
 vP96qGcnCcm8MZMM4TQw8DPrkek4kuIOwtbEZTkFYtGsDH6YxMsAqRMw4Lj4W8m5
 SZHyppJLlq9R8AI1OqYrvCfaJ8XWAyHBQ659qLw7K+RSI0IkxPP84Pbvbqb4Gu3h
 aTFd8Qn22STf0Df78Q1qT9uGiatMNCR8Uyfh57Q2VtD0U8w==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fq8s1r1jc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 05:19:30 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 29 Jul
 2026 05:19:27 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Wed, 29 Jul 2026 09:49:08 +0530
Subject: [PATCH] drm/imagination: Set scheduler timeout period higher than
 Firmware timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260729-sched_timeout-v1-1-4adc801b1997@imgtec.com>
X-B4-Tracking: v=1; b=H4sIADt/aWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNL3eLkjNSU+JLM3NT80hLdZEsLwzRjU5NUC1NjJaCegqLUtMwKsHn
 RsbW1AJGZyDtfAAAA
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Brajesh Gupta <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785298767; l=1402;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=OgIBO83ASg+fX+Mi3nuVooAnb4OgxQnMSGJJ6/coiQg=;
 b=YS3qBGfJNrR+1sQcVWz2kzEWI/cO6F9rkSb3yF1+t31LdSs0BXXLPhFDgnEXF1ewaA4zUfU6W
 disBRo34capAtWFLCcBpJ8amQXvx+GTgxF7Rz0aMU18DYizKB6+1aEY
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.225]
X-Authority-Analysis: v=2.4 cv=NrjhtcdJ c=1 sm=1 tr=0 ts=6a697f52 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=NH_CmkS_wl5flyWpymsA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAzMSBTYWx0ZWRfX8FfwneVXcO0n
 mXKEYnBE3wHsJwMGSxrR0AmFnC8r0AGQcfTcz8Agi+X19mbIXcJ9BE0bbWGH7QGq3T/7qZZPWfe
 0vyJk15o3P9ivguscF2SNwyEIenLWhhrx3V2Th3X+XYRMv88hAcBvZRgLnVDn/2gblgmFktmbR1
 5B+aOGqDuXjDT9RhJKDyZ1ePKBfmrQKFFdVy552PQnbcJA6MaGQYG48niWoFSESoujAvia5Sprn
 gewA+QiuXRuCdCjZ2sSTNhhEwRIe+dp7gPys/2wo5Dv0ZbTOnuM/LYpT0uotf2b1cFt+V6EYZai
 x3irUwagH4Pys7Fv6/W37nwldn+lUCMfI5tjDkk4U7JOsx49Z/qVI9EPGJSVvJmoOO4C+BcnL5U
 SxeTzioK7K2hiljtv4430AUnwJa+UlrdUYIVTLNVsS97oS0/7oUaVPSmwCKQ0kQqXSXXIGwFXpz
 Z47JOhb+5ErxbsflscQ==
X-Proofpoint-ORIG-GUID: R10WKmLM0S19H5QV-Jag9krWFr3YhCpo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAzMSBTYWx0ZWRfXy0eWdzfh8Dla
 VuRXemy0VManUnOdjC2qqHhVq8OSgMJSE3rUMfGyGgk88JfQH7T0/vVK5bX3ETqye9WfPEBsvGg
 L4icpEbAxBnbIR3Dwsd4zpkICTBEwow=
X-Proofpoint-GUID: R10WKmLM0S19H5QV-Jag9krWFr3YhCpo
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

Firmware schedule workloads on the GPU and tracks progress.
It is also responsible for detecting any lockup and triggering recovery.

Update the GPU scheduler timeout to a resonalbly high value to avoid
premature timeout at the GPU scheduler end.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_queue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 54e88b4208d7..09993e858df8 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -17,6 +17,7 @@
 #include "pvr_rogue_fwif_client.h"
 
 #define MAX_DEADLINE_MS 30000
+#define SCHED_TIMEOUT_PERIOD (2 * MAX_DEADLINE_MS)
 
 #define CTX_COMPUTE_CCCB_SIZE_LOG2 15
 #define CTX_FRAG_CCCB_SIZE_LOG2 15
@@ -1283,7 +1284,7 @@ struct pvr_queue *pvr_queue_create(struct pvr_context *ctx,
 		.submit_wq = pvr_dev->sched_wq,
 		.credit_limit = 64 * 1024,
 		.hang_limit = 1,
-		.timeout = msecs_to_jiffies(500),
+		.timeout = msecs_to_jiffies(SCHED_TIMEOUT_PERIOD),
 		.timeout_wq = pvr_dev->sched_wq,
 		.name = "pvr-queue",
 		.dev = pvr_dev->base.dev,

---
base-commit: e55fead22ff9ee047ab9f1903860c4b43043514e
change-id: 20260729-sched_timeout-c981f354e853

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

