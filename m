Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EABC98315
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674C210F353;
	Thu, 24 Sep 2026 07:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Ep8xTlEc";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 241C810F353;
 Thu, 24 Sep 2026 07:30:12 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5dsQB1074426; Thu, 24 Sep 2026 08:30:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=l
 d6iMESVzmCunC64MEHW51O/ZBRb5xMBpkZMKA8HQ/o=; b=Ep8xTlEcVNnNHh6XD
 XlkU77M84DdGmpduM0LtCW2Sa0I7wXGbBLlYofnJtpkRkFwATLDwdYSFa/9gXw6p
 hWnQGVzZNpugCNPmbf263t3G4tjvwNGqC8Einry4gAk4UI2HB/cYuQTsrwCSt+vI
 9vX6ityEsD4c3x3TrQLSERrLXhacNyEcObBT4teeLYS19mVWyLuYlWpdQTxSpKQq
 fWMsGt+W4g35jCsHSNY5kW2Qs9vbmYpQ0UGmQ2x2vW4rQmsmeZ3gm6Ck2w2tBUfo
 KY/DGdT/WJ/ywlAwiYo9MiXLFtv6Zm1754Z0GofXWPrgKwZ6ebrSEQLGrjNR2wn7
 VipbQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gsgnq3w1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 08:30:04 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.18) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 24 Sep
 2026 08:30:03 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Thu, 24 Sep 2026 10:29:45 +0300
Subject: [PATCH v7 3/3] drm/imagination: Release pm references in case of error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-3-584796cb599d@imgtec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790234999; l=927;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=Tydr9mGwHtPEldWoz4cV1uuED8vM23Fb8MaGn1f3PxM=;
 b=sfIYYsQir2vcmf9Ic5sJyW6BGhE75JU2pPLg1IK5EspeG36d971bLYO6el7z2wNDWUX6kFVM2
 2n/dvyjdjqDDvL57uGrcgySOBRo7OPLgEE8e8VTf8hU10cDJl4DIIl2
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.18]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMSBTYWx0ZWRfX0PoLh3h05GCn
 EIWA0y/aDvqkHGrAbvSWkfzrxDqNxBeJLk/AFDKgFgO4MX3ERRUI1WGA+1aDtVGZ2yMANnHFeCX
 mCOCQCxfVLlwiZ2Z9QtuYy4x5bdkZOYwjlvxg1kextrkiwIDAg/1U3TcMfs5g2gP7fPtg3m2WkY
 eGjKS7lmXCHiauJkgb0rWLRmnx7Dp1coxJSawJqmhOSSqgIRWug20kEs/YHZpEi7Lq+BjhJiTjT
 80NVmAjBfl8jafBsSQ3QDJF0CmbTmBQZmB2h2KnDrPfbVQ5CWWWTKtYMp21P47aKHAK6tL4DVzk
 JUs/2rJinDVpx+dJ3LCJMizq+3blA5HabknIWB75oOm15DWOxUJ+G81Dq/TaeyZRvxCxnQ9BvzZ
 bVWuCski9YXmJDM9JS6IlxDNnvT3EKXH7OxF1KB87s98NmtYLe3lerHXiJsZW0ryoSc+IQvxksP
 52Ef6wrawKVC0539BPA==
X-Proofpoint-ORIG-GUID: tuB7dhp3-BDbyucFZZmi6SwttUSiBTrt
X-Authority-Analysis: v=2.4 cv=fYs4WEQF c=1 sm=1 tr=0 ts=6ab4d17c cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=sVS2Dey4ZWMA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=jKIV6DwP1_vLq_mzJWMA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: tuB7dhp3-BDbyucFZZmi6SwttUSiBTrt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMSBTYWx0ZWRfX204LDFFaZqZl
 GWCQFg3rpFLvDKThP5bh2FbXm6lL7qpKuK04qKMw0f0/xJ3fPIyJiQ8zuQK+igO/MkJs0oLtHQ3
 ww8pXX3w8jnqSO1pIRfj2kaqxjrZrSA=
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
 drivers/gpu/drm/imagination/pvr_queue.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index b58c0887cafe..c72f1d0b8bc0 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -820,6 +820,19 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 	if (WARN_ON(err))
 		goto err_release;
 
+	err = pvr_job_get_pm_ref(job);
+
+	if (WARN_ON(err))
+		goto err_release;
+
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

