Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A1AF483E1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8EF210E0A5;
	Mon, 23 Mar 2026 18:32:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="E5rvNsIt";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3520910E055
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 18:31:59 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHNTKt4033998; Mon, 23 Mar 2026 18:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=5
 9NIm1tWo9yqmZyF6DxcM3QD8JsCLwy3486NS3N2+sE=; b=E5rvNsItamgrQObHk
 myczZt7lwrPUXknfTVsR99fNf4qP5w0xORn6/sxszLQS5XfqzlJmV9PRT/qLmGmP
 FPkESGFvGZICRX5Jq4Ir1hZ0i8sTOJ4NMidUFadkNiRhpPttdJnQbn2RJuhYrzEi
 fGaUhzKMxbeAz5ydf7nbnkoYQDwzwt3K6NMcovvlbadDiQhHJLeROIeJv6LRhDWs
 LHCBMlk68ONBuf4UIigjE8d1jbwrwLGVIbqmW0O+InplLb6LYThdgpq3wfbpJwk6
 OJlClIpzqwBnIg9tGlIFMyUFz075m8Sc+bgzY328O47F0kNWe91lHasl2YSSS8+p
 xGIJQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4d1jfqsrwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 18:31:45 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.37) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 23 Mar
 2026 18:31:43 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 23 Mar 2026 20:31:28 +0200
Subject: [PATCH v3 1/3] drm/imagination: Add missing rogue context reset
 reasons
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260323-b4-firmware-context-reset-notification-handling-v3-1-1a66049a9a65@imgtec.com>
References: <20260323-b4-firmware-context-reset-notification-handling-v3-0-1a66049a9a65@imgtec.com>
In-Reply-To: <20260323-b4-firmware-context-reset-notification-handling-v3-0-1a66049a9a65@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Alessio Belle" <alessio.belle@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Sarah Walker <sarah.walker@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774290702; l=1797;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=bFO4CQSh85sIz/tlIYgpEC//+928JbxvOua/abYgPII=;
 b=2ZIdG9FGXBlpFgqcw+j4W4LK9D+P8/4ewoCAN8RwvzmahjbEnnGVYo0yBtuj6oB2irSTTMCqG
 5hCfptHInp9Aml08ONro0gW2RPGoO8zjEFrISqqSM5BNF9GgrAQVH+K
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.37]
X-Proofpoint-ORIG-GUID: 7RjkeajuN4KyUhaAoX7upgeN1yY69hlK
X-Authority-Analysis: v=2.4 cv=HJjO14tv c=1 sm=1 tr=0 ts=69c18711 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=7IANbbwssFwA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=lDk76OInDpq-OS2Ox4QA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 7RjkeajuN4KyUhaAoX7upgeN1yY69hlK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEzNiBTYWx0ZWRfX3XtuZHCaw8Zu
 X+ZuIzXufZKE7vYK296kR4wZ+rdPQl1E8/351Jd2WKyYm5/MHaOj9ftZwEX04ZuIi6saDsAI0tn
 JAFpw8tbcBt2QuYZKXLAcxiH4xv8z3H6nCAWU438j39fgw8+dkxKLBhMOW6NDDsOrywS81Sdm5J
 AmhYouS3DWks51Y9OpXiv3wlFEShpqQg9mLQXUwIvIDned5tlRI3QD43Cs8figvmfc6LEzsGmcX
 Kzzm0gvYfTH//tTi91hKjMcOVKeHj/CWIBdFflf6IbeXDH21W+PzvVkSVEE1yds8eW3+a3GKhLV
 mHB1sdGd9DoWmIeefk6rMG/DQRmbmqdWgHhBBXBPCmQPfXTlybGjam3Hfu6cuKXREkEHw69/Yok
 /HBreT5KrMBM0f/Wj9wDT1RcrqYRQoyjks/t1+RiSIl34BrUpL3Heyp0yzV77mdkT6Zz4vGR0at
 75SxEmN8rYQQb+GDWgw==
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

Update the context reset reason enum with the missing reset reasons in
the 6-11 value gap:
 - CDM Mission/safety checksum mismatch;
 - TRP checksum mismatch;
 - GPU ECC error (corrected, OK);
 - GPU ECC error (uncorrected, HWR);
 - FW ECC error (corrected, OK);
 - FW ECC error (uncorrected, ERR);

Co-developed-by: Sarah Walker <sarah.walker@imgtec.com>
Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h
index 6c09c15bf9bd..f622553cdc11 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h
@@ -236,6 +236,18 @@ enum rogue_context_reset_reason {
 	ROGUE_CONTEXT_RESET_REASON_INNOCENT_OVERRUNING = 4,
 	/* Forced reset to ensure scheduling requirements */
 	ROGUE_CONTEXT_RESET_REASON_HARD_CONTEXT_SWITCH = 5,
+	/* CDM Mission/safety checksum mismatch */
+	ROGUE_CONTEXT_RESET_REASON_WGP_CHECKSUM = 6,
+	/* TRP checksum mismatch */
+	ROGUE_CONTEXT_RESET_REASON_TRP_CHECKSUM = 7,
+	/* GPU ECC error (corrected, OK) */
+	ROGUE_CONTEXT_RESET_REASON_GPU_ECC_OK = 8,
+	/* GPU ECC error (uncorrected, HWR) */
+	ROGUE_CONTEXT_RESET_REASON_GPU_ECC_HWR = 9,
+	/* FW ECC error (corrected, OK) */
+	ROGUE_CONTEXT_RESET_REASON_FW_ECC_OK = 10,
+	/* FW ECC error (uncorrected, ERR) */
+	ROGUE_CONTEXT_RESET_REASON_FW_ECC_ERR = 11,
 	/* FW Safety watchdog triggered */
 	ROGUE_CONTEXT_RESET_REASON_FW_WATCHDOG = 12,
 	/* FW page fault (no HWR) */

-- 
2.43.0

