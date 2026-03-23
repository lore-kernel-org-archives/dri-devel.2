Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7ABF483E3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2214210E0A0;
	Mon, 23 Mar 2026 18:32:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="QqrE9UJ2";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70AEB10E0A5
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 18:31:59 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHNTKu4033998; Mon, 23 Mar 2026 18:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=J
 P3Laua8fLA0hwdRkebskHrm9+6ilXPpi1MZ6HEGlfI=; b=QqrE9UJ2/wt5EqMqU
 fyLrePb62633nZ2Qv71zAsrA7Xn9zwKb19+pxEZrasrlwW82Nin8QCMMtyJPRcU0
 yUid/z/c0+a1UalTDgOIDWN56gMPsVSFOynFIQmdoueYYHsLezIqi6Hk8b1bdHbS
 kS6f65Fuv1epA8+a6oWj6oYGlsw8xaUoAPMIISFVbLCIRiyUU2mePSCR0/peH0LP
 VrEza8+HmnTRHYGok4SutVzspR1E1m9g3LHaExQGl15dzHpxlh2jfFTrvZdrRNVI
 kuN/CDxrRhLCYULdoct9JC36FJR9QcGgZjUQHvWzqXES8nkNff85aRQzAcB6SRpw
 Q/SUQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4d1jfqsrx2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 18:31:46 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.37) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 23 Mar
 2026 18:31:45 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 23 Mar 2026 20:31:29 +0200
Subject: [PATCH v3 2/3] drm/imagination: Switch reset_reason fields from
 enum to u32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260323-b4-firmware-context-reset-notification-handling-v3-2-1a66049a9a65@imgtec.com>
References: <20260323-b4-firmware-context-reset-notification-handling-v3-0-1a66049a9a65@imgtec.com>
In-Reply-To: <20260323-b4-firmware-context-reset-notification-handling-v3-0-1a66049a9a65@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Alessio Belle" <alessio.belle@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774290702; l=1947;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=Ihb0L4am1trLgBXhgc4SlYjCpJ8GxAvjtNHodvsZopk=;
 b=9BkyotY2Nu/DGdIwEm6cOA54mRZcNoR6x+NoKnzH/5flv2ch5WsgoJS6DthUBAQXdiZFqICVm
 Alv88vme56rDi7o2OtVC6tJ4qWnS4kyK099iGgXAHLoVsmk3DKJA2tP
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.37]
X-Proofpoint-ORIG-GUID: cikecqB_ZFmpeDOsGmOQE4w5zOwppA4K
X-Authority-Analysis: v=2.4 cv=HJjO14tv c=1 sm=1 tr=0 ts=69c18712 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=7IANbbwssFwA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=1QHZ_anrujvv2WxOvQkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: cikecqB_ZFmpeDOsGmOQE4w5zOwppA4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEzNiBTYWx0ZWRfX4Lr4/jwninbI
 hxSoZNb9Y1e4J5zYmf0vosvCuuNUpPBR2T83+0S0IuVLXAtQ/NnpoKLwkCsZnGn/BbkRfux/wyO
 UVYgHyx7C/lzH5/X8rD6bD8WVA/1N3XdiYBxuPudRdO5j3jIsk34ObkIS91lPp0u0AdhpQl8KvW
 94Io6CMRN5GtOBscEBFUpzcUuPNebmlUUX9ITBfg917D5OlF/9pYRb3I3tYdxZnPnVAqsYQayL8
 MJO+g1cBycvwm18FhWgB9vF5lDJptwDoGBg8qlQQMqpuFtmnFuCbPl6gOGH5EoLFCLcT21qBbfW
 gl41uapfHImM3FeupqRv+UUuOIR8sCyAxDzNMW68TNRNWMLNh7MeX7Ax0Yv3DfY9lWsjyDP2r+j
 bkl+2+2b1J6KOSK4a6tpG/LvEzBazPdwev5HV1h+rU57A3nSWl3eVsVKgzyqn36j4lLyOBjrt9b
 Zh1zZNFIzC4vIZMNY/Q==
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

Update the reset_reason fwif structure fields from enum to u32 to remove
any ambiguity from the interface (enum is not a fixed size thus is unfit
for the purpose of the data type).

Fixes: a26f067feac1f ("drm/imagination: Add FWIF headers")
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_rogue_fwif.h        | 8 ++++++--
 drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
index 172886be4c82..5d590c4c2566 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
@@ -1347,8 +1347,12 @@ struct rogue_fwif_fwccb_cmd_freelists_reconstruction_data {
 struct rogue_fwif_fwccb_cmd_context_reset_data {
 	/* Context affected by the reset */
 	u32 server_common_context_id;
-	/* Reason for reset */
-	enum rogue_context_reset_reason reset_reason;
+	/*
+	 * Reason for reset
+	 * The valid values for reset_reason are the ones from
+	 * enum rogue_context_reset_reason
+	 */
+	u32 reset_reason;
 	/* Data Master affected by the reset */
 	u32 dm;
 	/* Job ref running at the time of reset */
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h
index f622553cdc11..869d904e3649 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h
@@ -261,7 +261,11 @@ enum rogue_context_reset_reason {
 };
 
 struct rogue_context_reset_reason_data {
-	enum rogue_context_reset_reason reset_reason;
+	/*
+	 * The valid values for reset_reason are the ones from
+	 * enum rogue_context_reset_reason
+	 */
+	u32 reset_reason;
 	u32 reset_ext_job_ref;
 };
 

-- 
2.43.0

