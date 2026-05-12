Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8113ACD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 06:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F27910E594;
	Tue, 12 May 2026 06:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Q+4BVluQ";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC6810E594
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:47:44 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64C4K2Iw1827070; Tue, 12 May 2026 07:47:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=5
 1+05SUxwzoDgVZRI2vOoNdspHnUsqEwaRprdVhw03Q=; b=Q+4BVluQXwq0ZPlj9
 CfGSqsc9AAf5hJc1asQnMVca2xXqk+WU1KDZqYDv0Cs3sUS0Zl6D/uu3v9LxsCxM
 Q8KmcfR/BLNpvFDaX+N90I8xsnMOFWfqHGw12espYaYwr9/U3QG/9fTLcCoXsuwm
 qBGGeNanhWaU7JW+6enBigB31iF7ax2Gj626qBV3noDlYLpzVnZInyKnuP8er2mt
 ZauRrAUSuu/L1SiYAcPYspuOn4yI4zMk6sftd4odzQUoHLcbh2t8degBnU/AGcRD
 R8LhJ3T6dB7YJE+Ww1fh1TNEhFZSU7L6YjTY5g2YDCK60QjVhBUZv9bR6HQ2iZ8z
 IPQZQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e1w0t2c69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:47:34 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 07:47:30 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Tue, 12 May 2026 12:17:04 +0530
Subject: [PATCH 2/4] drm/imagination: Don't timeout job if its fence has
 been signaled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260512-b4-context_reset-v1-2-439bee96ed83@imgtec.com>
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
In-Reply-To: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778568444; l=1281;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=BSvnZUohnv0M/jZMltzU3heWRhHpz22DN5qqQIqyBB8=;
 b=m3UxzXF82CzkIkYwBaUY0tRE2bfSfhEDTXeGKXOZVqY3FL+91LpNocX0LZaDHDltjUPQ9dSJz
 57V3VtJf5JKBUzksBfJNx3C1JM0alhI+HR6ZdJ9gd0Y/5Y7VxnMq3qr
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Authority-Analysis: v=2.4 cv=b/6CJNGx c=1 sm=1 tr=0 ts=6a02cd06 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=HWs97GUntxIEKGcJwaQA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2NCBTYWx0ZWRfX1XORd0i82bLH
 F0D9Ip4MShKNXLTSz9oMkfLdFQ6Kz4E8JMSxWOaGMLI34QqzvEBdZgU0KrM8Mb73xxfP48Swg7D
 TQLk+iJ1pSwfJKBUKsZTqqMm/bCVq27uBI0swu+L77F9jmIyv6aPkE4yd2fAc3isB3PpXKhZwt1
 1SCrDV4+csFkP8rePXlGFfCO+K+ZNpeQyxSqfdyZhUfssLD7lmkr6pAr4nQscO3d11W/nMke96x
 ii0Dg+HcHbWjjisKJCLlqqZ1DWf8A5sDt+KZPpK5byuUYQHHVwvRjcXb56VlzsMNHDo3TfziOTv
 HmRO63qlnx9qLPcxalNzXih+7I6MzWVI6GHNOG+IRVfBU/Pk14Cx5gSAearWbzlNBjAiwpSBRur
 BhqdsQcJ/2AkS/e1OXNDDeqWrRT2d5CzKGItNd87Ls2DBcPsqmKbAGoxNAV9TDC11s3TJeFDOur
 AsGhTIFX/FsaLEFIJ3g==
X-Proofpoint-GUID: 4nkvIIL9NGiV16qAS7NpYBfefRByyDdy
X-Proofpoint-ORIG-GUID: 4nkvIIL9NGiV16qAS7NpYBfefRByyDdy
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

Check for job's fence in timedout handler and report NO HANG if its
is signaled

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_queue.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index d10a13173f0f..073478919b22 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -851,7 +851,8 @@ static void pvr_queue_start(struct pvr_queue *queue)
  * the scheduler, and re-assign parent fences in the middle.
  *
  * Return:
- *  * DRM_GPU_SCHED_STAT_RESET.
+ *  * Fence signaled : DRM_GPU_SCHED_STAT_NO_HANG
+ *  * otherwise      : DRM_GPU_SCHED_STAT_RESET
  */
 static enum drm_gpu_sched_stat
 pvr_queue_timedout_job(struct drm_sched_job *s_job)
@@ -862,6 +863,10 @@ pvr_queue_timedout_job(struct drm_sched_job *s_job)
 	struct pvr_job *job;
 	u32 job_count = 0;
 
+	/* If fence is already signaled then return no hang */
+	if (dma_fence_is_signaled(s_job->s_fence->parent))
+		return DRM_GPU_SCHED_STAT_NO_HANG;
+
 	dev_err(sched->dev, "Job timeout\n");
 
 	/* Before we stop the scheduler, make sure the queue is out of any list, so

-- 
2.43.0

