Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E194BCD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE5D10EB42;
	Tue, 19 May 2026 08:25:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="TQdU00n4";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311F110EB3D
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:25:49 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J5DYGW3727708; Tue, 19 May 2026 09:25:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=a
 dJBtrhB7O8D6yWrni7KtO28YqnGdWU8HPuanGUznb0=; b=TQdU00n4n851r/XHB
 wJmqIzr3K61WFcTTdTBjDnPTKVWvsK86SmxGVYSXStl45zxd0ic9yXy2YsRFlrd4
 mMxzGouvWCTKNnGoqD7YIEiMJe2qQp4Ej4quy8DS8o82wCFwvc0FqRMAokMXIeHo
 zrUFcuGUYB2vWkNrCny7BtzYFhraWUNKXVTHH6WkUqJObVED/OFL0i/RoYLNABiU
 50AOJD73SokrYNsQBRNguURbBb0DFdVpOXeBc/bG9s41JyKSxB1SJhhBxml4oeeR
 rhpKbuK314I7GbwgUyG3HRy/BOJVQQHcWJ4LDxC8zLQ71FsX4Jduwz7It8AFyVDU
 hwkOQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4e6eup26qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 09:25:41 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:25:38 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Tue, 19 May 2026 13:55:27 +0530
Subject: [PATCH v2 2/4] drm/imagination: Don't timeout job if its fence has
 been signaled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260519-b4-context_reset-v2-2-931018a7131d@imgtec.com>
References: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
In-Reply-To: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779179132; l=1290;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=0W5NM2F7QokbI92GrDe1GeyxFrMDba8fpUfHohTzVbk=;
 b=3L1MTE0OamRjQ8kjy4BWzuhlpvkrMD2d1dmsWOXXA/X5uZv/3e+AtX2UHDM0udPmmfWJ162eD
 nMZotgdQH32B6jEnVntURIFWUJz7OQmXHn3FhctclNNHXpGTD6Jw0F/
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Proofpoint-GUID: oNSYWXx-ZAmJzNvcFwtY5tlx2NR8puMH
X-Proofpoint-ORIG-GUID: oNSYWXx-ZAmJzNvcFwtY5tlx2NR8puMH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4MiBTYWx0ZWRfX+APoWTwD+NgO
 aQ6oUTlqw6GIJRFkmSvA50MR2SwQKFTetLrvmEz++PcZHcuvrFrXaqclEd82uhFGBa8Mu5KOyEF
 e/Zp+TBnwngCWLewYyQf+9Ij9ro1T3im6JBgtwPZidCPUL7BkrXT5QD8fTco1WISeO8B+EodcIM
 sfeXBfQUQIr5po7pturgQjjL8+oUb1jxpSiU8sQYQTJZiUTGf1b2pXO+o1URqpmLBjAfqO/4bkb
 zso5jMRq8uYwtCunsx7CEviZGdIgi2DyO2SeFdWOf3MjYLq95FnbNwF/LOsB86SZbsze6BWMTcd
 iZCz7rLkbnkouq/QG39i6yhTEPAAWFW57nQau1vCj8VDM9BGQQy/gePP4dyN4TYhsmulE1IuQQb
 zFOpTqggQcefE7F3nFThPZveTVPxEah31CJyWYBT9goNprtAD0TYV7GD1IInEN1sKSEF3bIYQih
 nBXzfVrXmp0nhn45bQQ==
X-Authority-Analysis: v=2.4 cv=BIiDalQG c=1 sm=1 tr=0 ts=6a0c1e85 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=HWs97GUntxIEKGcJwaQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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

Verify the job’s fence in the timeout handler; if the firmware has since
signaled completion, then report NO HANG.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_queue.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index d10a13173f0f..822e6259674f 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -851,7 +851,9 @@ static void pvr_queue_start(struct pvr_queue *queue)
  * the scheduler, and re-assign parent fences in the middle.
  *
  * Return:
- *  * DRM_GPU_SCHED_STAT_RESET.
+ *  *%DRM_GPU_SCHED_STAT_NO_HANG if the job fence has already been
+ *   signaled, or
+ *  *%DRM_GPU_SCHED_STAT_RESET otherwise.
  */
 static enum drm_gpu_sched_stat
 pvr_queue_timedout_job(struct drm_sched_job *s_job)
@@ -862,6 +864,9 @@ pvr_queue_timedout_job(struct drm_sched_job *s_job)
 	struct pvr_job *job;
 	u32 job_count = 0;
 
+	if (dma_fence_is_signaled(s_job->s_fence->parent))
+		return DRM_GPU_SCHED_STAT_NO_HANG;
+
 	dev_err(sched->dev, "Job timeout\n");
 
 	/* Before we stop the scheduler, make sure the queue is out of any list, so

-- 
2.43.0

