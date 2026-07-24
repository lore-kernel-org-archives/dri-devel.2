Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AD0C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A2F10F3DF;
	Fri, 24 Jul 2026 14:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="nYWbogC5";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F36A810F3DF;
 Fri, 24 Jul 2026 14:42:43 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ODbMS2673068; Fri, 24 Jul 2026 15:42:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=J+uDwHmFgPX2hB6XIi8+xEJ
 mKjxuh68/SDxeqMyzHGw=; b=nYWbogC5BTokF018go1bX/9CM0451/Kd/I7MszY
 LOWSlApAp0SpFBDDOaI8o/IPzHFxiKPZbkOVyB3oo+F41GIi44vpW/7H6xK/PQ0W
 gbBrAVQtZaVvzJlLyBsqE7uQhRGx3RQ26DIWHkurtDDs0Dk+8PyOzyeV63LPBE4o
 TO2jf28ta9aplH6n0WR8I4t5AsmAwGBV3TXYnKSksW2sRn2BMLNqNLoy07dCyXJu
 5dgXhAfr8q2WeSnWhWzGBcYu/xkFZcmvXppoEwOJpl5JQgrpP71TiwyeKOiOnDib
 iMuR9EcgXjL9oBi/Nn3GjBtkFtT465csRkD8sqMWJaD4byQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fhq52bstc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 15:42:33 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 24 Jul
 2026 15:42:27 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Fri, 24 Jul 2026 20:12:12 +0530
Subject: [PATCH v3] drm/imagination: Update the trace point pvr_job_submit_fw()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260724-b4-tracepoint-fix-v3-1-8f8e5e8179d3@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAMN5Y2oC/33NTQ6CMBCG4auQrq3pHxRceQ/jopYpzAJK2qbRE
 O5uYaWJcfl+yTyzkggBIZJLtZIAGSP6uYQ8VcSOZh6AYl+aCCYapoWgD0VTMBYWj3OiDp+UOds
 1vNdMyJ6UuyVAmQ/zdi89Ykw+vI4Xme/rPy1zyqnTtVbambrj5orTkMCerZ/IzmXxSahfhCgEN
 KblRqpWduqL2LbtDVMRWLD2AAAA
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matt Coster <opensource@mtcoster.net>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Frank Binns
 <frank.binns@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Brajesh Gupta <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784904147; l=2729;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=nHIpt78TJSHP/AfTrbsjhzfUBkMaH8UCb1o55oDb600=;
 b=coZ4ZkoATX2jfMOdQcAkHPrE7K7RiOmA1JVLxvGQD8gDHnr69JpznHYGrFM544DGPH2nrKyeA
 Oe5WZuE8rErAfAHID5m120G0H8Lcx/CFTbJ9VnEOkn5YMA6KPFI/PeI
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.225]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzMyBTYWx0ZWRfX875huRyrg/NB
 LuO8XjP1OmkW4lu/DfZIlUCBXAGR0B+51HgW6qLHrlo1dHbEC/r+UEhjGSjpF48oDlOHc5enCKl
 rzNDAeNn0gcymc90ToWF7U8nzavQR0oddu7li4oC+TqbUs8uFQ0/XkE47RnULItZSrlG1o+Zfed
 wuconu5i0/U1w3VxFYz3uZapuG418EdhbOne6d7yvzc/Ekoa6sFhrU8xsgFA+WJL271m1/PRkf2
 KIKB/nJKgs5N+VFA/vhFptKZaMTRwUkI5Yx5Mhu7HopKd8dl4PPauV80zu+tHGnOIsqLSMfSj9M
 yAoi6HGzTMVAgisD96LbFgi3raNXoVn6+Vcfb+vKC9f9cZVaOftkqFK8I8kFmfZafwAuuLASZNq
 PtUk6RU3YtKbft5G0LaWbLviQbfL4VvYtHtagljWOF0swg9Qpi0hSjpvKG6Ydvl5VApwK8ZEYVO
 tCxmWlv4LnrGbpdGOUg==
X-Authority-Analysis: v=2.4 cv=B5+JFutM c=1 sm=1 tr=0 ts=6a6379d9 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=yWxx2l9es2RvQy5cUQQA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: dpOy4eFo4QUyml8rjmkr5Lp_lskaBwUf
X-Proofpoint-ORIG-GUID: dpOy4eFo4QUyml8rjmkr5Lp_lskaBwUf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzMyBTYWx0ZWRfX0nRb/LvDWTzw
 aFKQXIUzURHIB78SksFvM35ZU80wtHYyyv98GkcK5q6r6hyRy7pDVFZEJeBtYxa4hFsuDthKpiQ
 wJZs0kpA4IrqPkjpXQquhmKBUXsu9+A=
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

Trace point pvr_job_submit_fw() is used to trace job submission to
the FW. Currently it is recorded when a command is written to the Client
circular buffer.

Move trace recording after writing command to the Kernel circular buffer to
better represent command submission to the FW.

Fixes: c1079aebb4de ("drm/imagination: Add support for trace points")
Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Changes in v3:
- Reverted back to v1 version as per issue flagged by AI-bot.
- v1 version is proper as mentioned in v2 update and correctly mark
the submission of job to the Firmware.
- Link to v2: https://lore.kernel.org/r/20260724-b4-tracepoint-fix-v2-1-e6a81a348394@imgtec.com

Changes in v2:
- Updated safer trace point recording for fragment job to handle
Sashiko-bot reported possible use-after-free case.
- Due to depenedency between grometry and fragment jobs, fragment job
will not be scheduled till geometry is scheduled so even V1 solution is safe.
- Link to v1: https://lore.kernel.org/r/20260722-b4-tracepoint-fix-v1-1-f75747fa591a@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_queue.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 941c017399fc..d13726401d92 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -726,8 +726,6 @@ static void pvr_queue_submit_job_to_cccb(struct pvr_job *job)
 		cmd->partial_render_geom_frag_fence.value = job->done_fence->seqno - 1;
 	}
 
-	trace_pvr_job_submit_fw(job);
-
 	/* Submit job to FW */
 	pvr_cccb_write_command_with_header(cccb, job->fw_ccb_cmd_type, job->cmd_len, job->cmd,
 					   job->id, job->id);
@@ -802,6 +800,9 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 						 job->hwrt,
 						 frag_job->fw_ccb_cmd_type ==
 						 ROGUE_FWIF_CCB_CMD_TYPE_FRAG_PR);
+
+		trace_pvr_job_submit_fw(geom_job);
+		trace_pvr_job_submit_fw(frag_job);
 	} else {
 		struct pvr_queue *queue = container_of(job->base.sched,
 						       struct pvr_queue, scheduler);
@@ -809,6 +810,8 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 		pvr_cccb_send_kccb_kick(pvr_dev, &queue->cccb,
 					pvr_context_get_fw_addr(job->ctx) + queue->ctx_offset,
 					job->hwrt);
+
+		trace_pvr_job_submit_fw(job);
 	}
 
 	return dma_fence_get(job->done_fence);

---
base-commit: e5320be8a585a9286f231305d0d443d59c24e46c
change-id: 20260722-b4-tracepoint-fix-0fc961d7023d

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

