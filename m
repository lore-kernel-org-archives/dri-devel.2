Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A768C98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C79610F34E;
	Thu, 24 Sep 2026 07:30:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="vSgVBxHi";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 206AB10F373;
 Thu, 24 Sep 2026 07:30:11 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5e24H1074552; Thu, 24 Sep 2026 08:30:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=w
 Y5QBrESUN0/XfKKkTM0Mt7rDLxNZiQqJ2r/kOUUbl0=; b=vSgVBxHin5NMDIxDL
 xeyaJXQUwkrPpIZ0LeJYsrAG11VTsdWijCq0T0bS7jcVPuCLo1yGguCaImemo7ad
 tuG04Bop+wVOInB3oZSsdWvvpHYnSJMNJbm7ly5koMbztnlG/CV3vvDwbWo0VUu1
 7B2YWGUrBNna4P23n+Q9rIXfPUHqKpJSMm9GpKKfuUeAtJ4OsoMCUJ/Ucxc9ECfV
 UN6nYMUbYbzBEPkGLhhp4JU0TXTHtTT5njHtI7OGHBJm8rhWYS3/T8sJ1IQyoz7B
 Zd2/g/66zuUQc/5YMb+EvfCV4zZTx7jlcgSL0uK6VlQ1UfOJeS5NBtpF+qxj/cqd
 21HLA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gsgnq3w1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 08:30:02 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.18) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 24 Sep
 2026 08:30:00 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Thu, 24 Sep 2026 10:29:43 +0300
Subject: [PATCH v7 1/3] drm/imagination: Release KCCB slot on error path in
 pvr_queue_run_job()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-1-584796cb599d@imgtec.com>
References: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-0-584796cb599d@imgtec.com>
In-Reply-To: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-0-584796cb599d@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790234999; l=1648;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=XQZaE5K7wELBkVpj5cyeE1NqTTZjP6LdzHGCCTMEDUs=;
 b=3HX2lf2OzTEsE75nrz8icr29gO5jQzARD4vpnqtKo63BhsdxOug4NOaQgIRxvca1RaSvNCbsS
 xOAUZRBWNE1C86KNfv8mgjWKRYZkRDqQBRqL5xE1Cq/qF+bkW2bOUCi
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.18]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMSBTYWx0ZWRfXxUo1Ok/X3MGX
 C6cmJrivraaoobvj7k+09uMnn6l2KHElCFUwjmopg2WlVk0mqpMpnGKrQ6+ttU67gYGKpwbtqLS
 EPuYAspwchXmQv8Vg2M8h7mppW2fXtPYRIDLtHZrQI/kLQBtep0LGLdhtOi/Ocj4nBkcdtTie3K
 dhhQhOIxXWgTjDoSXQiL1G7poidYqhyXGabFDQW9kUB0rMXbZaf8WIO4qXxXoVKI1WnM9DTObn+
 P0ihlQH/hlzcnzkop92GtmVz8hd5Q+MchibuA0EJwJwJUXa66pdorqNHIulF+nuznYqjg/3t/Vq
 zHORiCROtrfv4JI+LoUuV9Ub2/JT+5XfOQvnDlXecbARxM6gkiXXCyaKF3dtIkj1PCEDdwQl7Ul
 nUtCI3aKilF50hNSiGvPJx5xCEW2jgDzCHCrHelR0HzPbmfxmaeX5PQ+s4J43EDu8y0bl+VrDIS
 qc5pzfdBkqbe0/SLlgw==
X-Proofpoint-ORIG-GUID: 9OaJ0EH4VptLFBUtk8jbDgvl8H1xpRiT
X-Authority-Analysis: v=2.4 cv=fYs4WEQF c=1 sm=1 tr=0 ts=6ab4d17a cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=sVS2Dey4ZWMA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=zXiuvu5RTUsjFMotISsA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 9OaJ0EH4VptLFBUtk8jbDgvl8H1xpRiT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMSBTYWx0ZWRfX6x3JhQpqf4z6
 QW+yX2dlnZznDAMCk50uybNIZZozAV3qcj8zQtKWpa8U4xn+fKsCzvGuqeNEkH6auxpb59v7ivU
 dzb7jo6l5syZUje8Iqb0avGaXXZHGEc=
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

Add an error path to pvr_queue_run_job() instead of just a warning and
release the KCCB in that path.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_queue.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 24a8645aa913..8dd87192fabc 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -767,17 +767,19 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 		    (job->type != DRM_PVR_JOB_TYPE_GEOMETRY ||
 		     job->paired_job->type != DRM_PVR_JOB_TYPE_FRAGMENT ||
 		     job->hwrt != job->paired_job->hwrt ||
-		     job->ctx != job->paired_job->ctx)))
-		return ERR_PTR(-EINVAL);
+		     job->ctx != job->paired_job->ctx))) {
+		err = -EINVAL;
+		goto err_release;
+	}
 
 	err = pvr_job_get_pm_ref(job);
 	if (WARN_ON(err))
-		return ERR_PTR(err);
+		goto err_release;
 
 	if (job->paired_job) {
 		err = pvr_job_get_pm_ref(job->paired_job);
 		if (WARN_ON(err))
-			return ERR_PTR(err);
+			goto err_release;
 	}
 
 	/* Submit our job to the CCCB */
@@ -814,7 +816,14 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 		trace_pvr_job_submit_fw(job);
 	}
 
+	if (WARN_ON(err))
+		goto err_release;
+
 	return dma_fence_get(job->done_fence);
+
+err_release:
+	pvr_kccb_release_slot(pvr_dev);
+	return ERR_PTR(err);
 }
 
 static void pvr_queue_stop(struct pvr_queue *queue, struct pvr_job *bad_job)

-- 
2.43.0

