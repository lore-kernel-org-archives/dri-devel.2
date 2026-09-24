Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63040C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D12A10E711;
	Thu, 24 Sep 2026 06:20:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="ZLSz/DNe";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA2210E8EB;
 Thu, 24 Sep 2026 06:20:32 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5d9Mk4069889; Thu, 24 Sep 2026 07:20:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=a
 gFmwEAolzDylk3GNfaXivFSzDaf95+XuykgMI0qkC4=; b=ZLSz/DNe4W48kRnxB
 XRRfuqHTym8bNIMbkqwrKfinToC4Dx1peGoFBaxzqxJ7izPAFibYoifWIcmI4CEG
 xBfkok904xR0bzJXrfpjymd5dPliSsF/fTf7VF7uRU/fQzn1oM3odCm2y9ABxipR
 H9sEm9h122nlO594j7/x27QzHOWB34A5afIV5uVyMwW1qa8eUNjFXKXoNVA5qbXW
 jfhL4uhm0ZS4YrPwqC1KdTEmMtVzC0xGnSQL//S4UN8DzVBvS9OuTl0wBttGg5cv
 lIWtq04vEVZ8GpS48GCDqEl9CnAe2ZXa5PcbT5TJjq6xZvyKPGiYQ4FDXCKPl/PX
 Ucw5w==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gsjftm9vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 07:20:19 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.18) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 24 Sep
 2026 07:20:18 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Thu, 24 Sep 2026 09:19:51 +0300
Subject: [PATCH v6 3/3] drm/imagination: Release pm references in case of error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v6-3-d9d5375665ed@imgtec.com>
References: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v6-0-d9d5375665ed@imgtec.com>
In-Reply-To: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v6-0-d9d5375665ed@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790230815; l=920;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=cByg57c+ZiNGGtOS/HfykUAf4O4HN7h9mKZN2uVWCm4=;
 b=/n2CvSQds80cz0e6GwYVj+CfqHQ/R21RjKsBkCILrwr6zjpo3hMLZaSZ0hHgNlYcPkVi34j1u
 h8nG5MWNOgUD+ugUVEVi62DN1FFVrTxoD/bZ0dyDollcYQEu4OBNgC1
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.18]
X-Authority-Analysis: v=2.4 cv=GPKdgeNK c=1 sm=1 tr=0 ts=6ab4c123 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=sVS2Dey4ZWMA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=MguH0ROApdJ8RnWAcOUA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNiBTYWx0ZWRfX7GkZ1klCHctS
 QZv773aCBJJyYp/ANJStm+YAIrRo3kOJHvqNYMmHljSqLUX9EyT1gV/LSPfvsMwRsOiMILdHlrf
 aSw418FNQFFoGuROgbDYNJjImMPAWYJQwTaoTZaRq/UVWn744+WlBpaN5D9AikfUpg9WLG74W5v
 P34HeY7Dx04YgnfuTNL+cn+ZST61AU4D4Ee+sVH09AEYJiIaIAnxhPvrIRhlwmmVAdrlHSCdhrH
 x0OSEp7DATcRdU4f1XdwWIWTwv3G+opGchbWLVBhiQbSAxjCtmOQUOzlvyiwGIFs1wdekT5ayai
 acF5DQE3Wnjo7PcQOeFqvFTSEx9nx73hBiD6MCLF7i+r+l9xtlqeHm1caRhT9nOjc3UgP9fBSsD
 vxPgsy6gY4eUCAuPRZgQupOJZ7sqsWDtFYSubVx0ycX50gqz++xKr0IeMzvOByg2ZYqPE3DJvDy
 kbrEb5wRJgUdqzAuY0g==
X-Proofpoint-ORIG-GUID: USgOZ1Iij81aEMFYT94nxSK1vrMxt71H
X-Proofpoint-GUID: USgOZ1Iij81aEMFYT94nxSK1vrMxt71H
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNiBTYWx0ZWRfXwLhNr7fCCREI
 1iVDq5AhPZQ11cQGycN8JDfQBwaEPLVu6lYPogKUaFO03CdfJSC++yahs2sL2S6EPUpVd9nCVPS
 6pPG4zKKGIOWKeJW1PT8oZjSc7lz8cw=
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

Add early release of the power references in case of errors.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_queue.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index b58c0887cafe..1b013791897d 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -817,9 +817,19 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 		trace_pvr_job_submit_fw(job);
 	}
 
+	err = pvr_job_get_pm_ref(job);
+
 	if (WARN_ON(err))
 		goto err_release;
 
+	if (job->paired_job) {
+		err = pvr_job_get_pm_ref(job->paired_job);
+		if (WARN_ON(err)) {
+			pvr_job_release_pm_ref(job);
+			goto err_release;
+		}
+	}
+
 	return dma_fence_get(job->done_fence);
 
 err_release:

-- 
2.43.0

