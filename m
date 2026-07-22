Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B353C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A58B10E0CA;
	Wed, 22 Jul 2026 11:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="oo0bVt1M";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6617110E0CA;
 Wed, 22 Jul 2026 11:27:03 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M903qg3443431; Wed, 22 Jul 2026 12:26:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=pWpXer40vYq0sxg3exnyBDK
 pp/kqJuoPU9uwrT3v4vI=; b=oo0bVt1M60vxWH1mctj5NuPaWAdvDXFzQPOpPb1
 udq1wLuYWsYPNr7ti7+6AD2gVSSIN36utggRHPNrHjTt+nY/KQdIk4EdB/hrkuB+
 0WsJ1W7RA6GW7oOd+FxAsdC7u0doUQhEObVqyx8FDTEcY6DfuLy8a3Y9cPnRVUB2
 4n6buX8ygCwl2BBMnc1aiZtU9h2C9r81cBEbubSswCXvUnADCAtKdw99vpU2RQ7x
 moeos+hRHZF4iSiZXUUuUOvAbOlHFsns9Jak+89XSM83aO9itdgRLlzoXCqDXBOm
 1Dpy7fDRKvwNLmNWRm6/KVzDBBDcLbIwaQNOOGWsRU/qtFg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fhmy1hqmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2026 12:26:54 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 22 Jul
 2026 12:26:50 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Wed, 22 Jul 2026 16:55:24 +0530
Subject: [PATCH] drm/imagination: Update the trace point
 pvr_job_submit_fw()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260722-b4-tracepoint-fix-v1-1-f75747fa591a@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAKOoYGoC/x2MQQqAIBAAvyJ7bkG3KOor0cF0q72YqEQQ/T3pO
 AMzD2ROwhkm9UDiS7KcoYJpFLjDhp1RfGUgTb0eiHDtsCTrOJ4SCm5yo97c2Bs/aGo91C4mrvp
 /zsv7fgyfeU1jAAAA
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matt Coster <opensource@mtcoster.net>,
 Donald Robson <donald.robson@imgtec.com>, Alexandru Dadu
 <alexandru.dadu@imgtec.com>, Frank Binns <frank.binns@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Brajesh Gupta <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784719610; l=1997;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=Svlxwdjc9WGTLG1bXAPMylsnTSI1/i1Gh1bLMyPyUUM=;
 b=UiGIMnuPQTIwVuw09Dc8QmWgqTczl8q53mawlhNJ9eyBgWTBUkVgJzFtzKPb7dPHzj3J2T06k
 oTRDqVayCuwCPoFxgbrIFyXGkPh0oe83k3B7R+PozTC44xbNQvg4aoa
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.225]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExMCBTYWx0ZWRfX33HD2AJTIwzD
 ilLx1qvnjsqjbaTWnG8XieDin6ys2fczo83xFjAuoOormzHbId886GXl0KTzo05rzmzrHdbC5No
 YJQIXDt3qFHwfKGUVf9qC5GIMDqvGlbiByHaXiiDet93HM+FQU38ibxPnOuvMBIlgIciNXRHTzU
 VkIziu3M+uHHa0vKI1Xql23OWGqEo7mtlnc3PoZQ46wxsqdXjfUwqn/QBThd40JwckKYJ9+fgbf
 z+Lzid5n0uAl1H54njVoJ56I7KiLKbV7IeVza22FWFrEefNUXl9ck0oTdDkNL+ET2MxmnTnVZiG
 iGWyxVsSoztQAPYa/dc7gORFNK9r/Ljobn+by+uDhD8+Sd6ei5aGjT9/nbQ/wM4L1Tx9jauGyNy
 SEO9g0qg6b15+/zslsZc0NkvrGV1269+kqrOV0hVr9ZtAboEKAfld30T4M+XJVylMBrkkV3jXO/
 9QNYQ3Xmi8Q3IZU5gjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExMCBTYWx0ZWRfX88tVHmKRKZF7
 AZ3PE66LK1/YZl4P1e6mAAA44649X0yqWRFY8LBphTbO7oC3lYKp6vgoBCNL1PnpydAcnE0V4vq
 Y4onfN587X2Ewqcs+TLrNu8rdEiPcHs=
X-Proofpoint-GUID: RBvNLR1qqGHgdKnhEyYBSPBB8qcftXWo
X-Authority-Analysis: v=2.4 cv=YIevDxGx c=1 sm=1 tr=0 ts=6a60a8fe cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=YitDbm3_Z1hgSwur4ngA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: RBvNLR1qqGHgdKnhEyYBSPBB8qcftXWo
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

