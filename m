Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296DAC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FCB10ED64;
	Wed, 19 Aug 2026 08:24:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="BVTHsW5M";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F4110E0E0;
 Wed, 19 Aug 2026 08:24:03 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J77YfP1033968; Wed, 19 Aug 2026 09:23:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=Jlz/NXxSHZ8qCISJLrx9utF
 kWBjV4Tc67+D3Fk2nj88=; b=BVTHsW5Mxy2gxHvITAtjRrDGjA7BFGXMXzVJWuW
 zTAoDNuUEcxrh4DUDCkSns1UdCy/HGJEccNXHCadLxe6pVTjTaUbVbQxq/QSDenm
 O1gfOPZmLR1g7aWNbj4V37pFQlX5svmLgSSMkkkKw09aFPgbesa0oT0rztU7u3Xi
 GtjKtjnmpBcMJ9c9k5pM/TJX7sliy0AK7grPkqjcxKi6YeMKlpLjZq45F1yzraYT
 GDc31uQ3eQS/OwbJHD/uzWnWmTgSLWnZfPXHx7/D6f7UdC2UtMrtmE89mcOa2fSj
 PtXKYj69AX6cdim6Zld5Wc/g+ZbT+NMT/l0nsNh3KSfTkNw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4g452fhfha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 09:23:48 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 09:23:44 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Wed, 19 Aug 2026 13:53:32 +0530
Subject: [PATCH] drm/imagination: Add job type info to pvr_job_submit_fw
 trace event
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260819-b4-submitjob_tracepoint-v1-1-f817b222bf6a@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAANohWoC/x3MTQqAIBBA4avErBOs7PcqEZE21QRpqEUQ3j1p+
 S3ee8GhJXTQJS9YvMmR0RFZmoDaJr0iozkacp5XvMlaJgVzlzzI70aO3k4KT0Pas7moxcKrshA
 lQqxPiws9/7kfQvgASLNjNWkAAAA=
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Brajesh Gupta <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787127824; l=1674;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=v5nLIoFXAWZwLZedIs4Zx0mKU5TyLtRFaMhJbSwrMwU=;
 b=Dqgt5owS7jO1DhfsY2orzw6PAp+R7X96Nbxept8c9zl5OWqIvCN/ZHZKilYXMIwUi9cq8r/cc
 Dju7MtPYby2CoA3Xwl4o4J1UO+rTuUaPTbwv4jSjXCaWLzAJo/G5s1b
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.225]
X-Proofpoint-GUID: w72T9GffDCPufSxYP83OG5Tx2ebDpDPo
X-Proofpoint-ORIG-GUID: w72T9GffDCPufSxYP83OG5Tx2ebDpDPo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2MiBTYWx0ZWRfXxo2vZuNTchV4
 lBGETjumy0HFwgJfUyMT7tqOFbEZtFMybwbYJbyA1U4RAI3760df87CfWKw64//NxiTek7/uexu
 oyNOgdSYGBUwN/CZIdPjEWgx6KJwaHM=
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a856814 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=8hSRHtm8Qhmt5jkuxhYA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2MiBTYWx0ZWRfX4byIxAtLtwD5
 cQp+KUZgOtuZAFsrMiEvreYAZn14jBzyP2Whm1vn0SuFlYzRuoAGViSwtazZT1O4xyjgzdDizDx
 6KrT3+Vi0ht5CThdOxXylmUsYEnAVD2rRQA5JrJ9rA+zU1GcHqCqJAg2YYwnKZBHUYF2Sv+cyuL
 ABBuxDh7xsRjpga4PGopQDdvqScVDxgQ2QxGaKv0PTJXHTnuSRw/3qPFOb9KMlMFHcBgzdzCKeP
 7XquDNcAsGU0zrqmq5KG2Hvzlupo1uRlvB6IFDl9gg23rE00D+e+Xcsu39EeLu1WMOUJkP6ojHL
 9qjf7CSnEq9+H/uKaABK2EQquNRc8APUsIZNt6hU1pm0Se8WCNKAC7k3jJhNDk5Oo2Nia497uGT
 2juQpUgJxqnsRx34BHQrRuuXtR3TBYNmH5lZDT1RdK4tgjMiA0UpwsP7C+X+Kz9uxiEcrgdc86f
 kAMbGWUMIrHD7rGyx0g==
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

Update trace event pvr_job_submit_fw to additionally capture and display
type of the submitted job to easily map events as per type.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_trace.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_trace.h b/drivers/gpu/drm/imagination/pvr_trace.h
index ffbbde3b2bcc..1b449a64a6ac 100644
--- a/drivers/gpu/drm/imagination/pvr_trace.h
+++ b/drivers/gpu/drm/imagination/pvr_trace.h
@@ -81,20 +81,23 @@ TRACE_EVENT(pvr_job_create,
 		      __entry->sync_op_count)
 );
 
-#undef PVR_JOB_TYPE_TO_STR
-
 TRACE_EVENT(pvr_job_submit_fw,
 	    TP_PROTO(struct pvr_job *job),
 	    TP_ARGS(job),
 	    TP_STRUCT__entry(__field(struct pvr_job *, job)
-			     __field(u32, done_seqno)),
+			     __field(u32, done_seqno)
+			     __field(enum drm_pvr_job_type, job_type)),
 	    TP_fast_assign(__entry->job = job;
-			   __entry->done_seqno = job->done_fence->seqno;),
-	    TP_printk("job=%p done_seqno=%u",
+			   __entry->done_seqno = job->done_fence->seqno;
+			   __entry->job_type = job->type;),
+	    TP_printk("job=%p done_seqno=%u job_type=%s",
 		      __entry->job,
-		      __entry->done_seqno)
+		      __entry->done_seqno,
+		      PVR_JOB_TYPE_TO_STR(__entry->job_type))
 );
 
+#undef PVR_JOB_TYPE_TO_STR
+
 TRACE_EVENT(pvr_job_done,
 	    TP_PROTO(struct pvr_job *job),
 	    TP_ARGS(job),

---
base-commit: e55fead22ff9ee047ab9f1903860c4b43043514e
change-id: 20260819-b4-submitjob_tracepoint-d374f065345e

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

