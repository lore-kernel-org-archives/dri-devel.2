Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91731C98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967A010E9AC;
	Thu, 24 Sep 2026 06:20:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="sBdMOkvp";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E166F10E711;
 Thu, 24 Sep 2026 06:20:31 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5dimJ4070823; Thu, 24 Sep 2026 07:20:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=w
 Y5QBrESUN0/XfKKkTM0Mt7rDLxNZiQqJ2r/kOUUbl0=; b=sBdMOkvp3exmvpOEX
 uc+K0XMIBYsRgJeCmG8n0I0DsdTkaUg5ze5607SAFOf1CbDVQTULCqxjmGpMS53i
 FuAfoMaLASNtOFwnKadxMUtapP9QwHebngI6a+KHSeZtKkyo2sgkJkhZfZXgKDPw
 RVtyOKGpPy0vefrC+lqEBhaZdydLQkEDnFCRR/iryhsvAqRZNQMOXSQl7MRxLDDD
 5txxhFl9J1XPZkbLlqve/bqT0vNvEXOfrE4nGRlf7fd9aoSdLKhWdvbyjpwfNFhf
 wgKgO0wHNOrK9o1EaQ7bdSFUXqUGvfEdzBBc3cYXtMMm17LK6V7Za8w9zzU9gpu5
 1uJJA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gsjftm9vu-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 07:20:17 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.18) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 24 Sep
 2026 07:20:16 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Thu, 24 Sep 2026 09:19:49 +0300
Subject: [PATCH v6 1/3] drm/imagination: Release KCCB slot on error path in
 pvr_queue_run_job()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v6-1-d9d5375665ed@imgtec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790230815; l=1648;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=XQZaE5K7wELBkVpj5cyeE1NqTTZjP6LdzHGCCTMEDUs=;
 b=shE/zWGPcrnoIDFE9MSsfCR37/XopfrcHac9Uv1XepMbxA7bEBhrvYxkWBqjIJu3c4+sBIBmi
 t0izDfazDCoB02HVvMfOc9kMIpvmxrFTYfZfbLYpdO2pS/dDEO+CrR3
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.18]
X-Authority-Analysis: v=2.4 cv=GPKdgeNK c=1 sm=1 tr=0 ts=6ab4c121 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=sVS2Dey4ZWMA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=zXiuvu5RTUsjFMotISsA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNiBTYWx0ZWRfX0tJF4zHt+kZT
 9e0HSrHoba0+QSEEY5YPxtKxpvXbLvDBsUzXYOJ2r5dzFV/hwfrGPmcJOK8GMCnhY9U0yQlpJz+
 rK4RPi9sXm59cXoPb2p81r2q6LwkTelg96VvUMklJgvnj2g5sIzWp+lWAsSoBRKN1dd8+fNz6RI
 wEI+3OpuDr8OenSFW+84PR4shKCAZ2RSxM5oNPwPZV28/sx2Zjasfr9w0hVnbWXzZG+7rLQ+NAL
 XSNlRFAMRFsXNc/sgAMTnFc/iiSq5S66AfWsv2XzCfbpRqM/kGGPQgEcYYdBHo6uoUX70tGMBIf
 n0AyzaPIrCBs7eVI4Wgkpzyn2dqLMvrbCfl8LraJtmnWhxI7XNpjWiNlo9e7DUXVj53rMXXS4du
 WuC8zFsw0rt63d1Kd9ZbXQr54kGIhTnxfrTrY/RSkw1RHBR0A+SfzmLFTgjKKRLSZ9cGmHcVpRw
 MytVne5jty/Ap3ak/ag==
X-Proofpoint-ORIG-GUID: bnuIFKFMlRT0OIb-_E-z-quNZVpX9VNG
X-Proofpoint-GUID: bnuIFKFMlRT0OIb-_E-z-quNZVpX9VNG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNiBTYWx0ZWRfX8PUNSvyavG4g
 hFXdLinN/ESaD97p7/u7YKxZ8aP4Vh9P8REH3hbY0O5di2dsnRKjxfdSNCtC+BgLa5XIhvdjiXu
 JXEoiDGA3eRmPQ1LtBaRqwmvneOu3Pc=
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

