Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF796FF4958
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 07:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC1910E3EA;
	Mon, 30 Mar 2026 07:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="qcRyE5kF";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C435210E3EA
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:57:25 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U5HJTm174202; Mon, 30 Mar 2026 08:57:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=/
 8FiZRrrQ/O+Rf5kOsCDAWuTUsDDkKsfFbvZz4NC9po=; b=qcRyE5kF9iQ1avMmt
 nH1fDHUusK7FSJ5LO/93IJHb2M2LeuFB67un+nJ0ETmVdeqChRl8nDHoqXEJ5LbX
 N+8mxjSCtIrn1ow2RAfUMTtueZty7ifFO1BfIgYo/5PTFdIsDTqmN/eITA73araw
 2i8WWJhuhu/gsWuVEIRITS9IsSbpR+uaM1CV5pGud22S261NyGo72nlAxoMZvqKS
 sEd7hpKRkmhjyLxJz3zzcv4lzOl7qk+tii8XL1SIpyezmDywLAdLRjXCE3seOzX/
 CDXgkjlPh6dnlAU2A3dtgr47KnB60XFN9VSA37IkNA24wZaKuXHudjIKZcbnh+6Z
 dF9LQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4d67xusfkv-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Mar 2026 08:57:02 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.6.106) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 08:57:00 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
Date: Mon, 30 Mar 2026 08:56:41 +0100
Subject: [PATCH 6/8] drm/imagination: Move repeated job fence check to its
 own function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260330-job-submission-fixes-cleanup-v1-6-7de8c09cef8c@imgtec.com>
References: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
In-Reply-To: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>, "Alessio
 Belle" <alessio.belle@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774857418; l=1816;
 i=alessio.belle@imgtec.com; s=20251208; h=from:subject:message-id;
 bh=Jud123WWRsFViT++lGJXkizulPVbeyW2ltbMqISSRbY=;
 b=Us8Uqg2bcIei5LQeqV5+A3+PeVxiODs7azGrw4HFJvCPdodnoBN9XaRjosJv9U3EBmzjuJWrE
 wMTYRH4ofcNDWIcj5jOmJfWGTAyXXhqmoQ8Y11jl8NSM3fRo8OlmIy1
X-Developer-Key: i=alessio.belle@imgtec.com; a=ed25519;
 pk=2Vtuk+GKBRjwMqIHpKk+Gx6zl7cgtq0joszcOc0zF4g=
X-Originating-IP: [172.25.6.106]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2MSBTYWx0ZWRfX3LbZ7G18Zoin
 YFA4KSKSmaBVaJMwkomSPR16kvSZcBU9TKLTl9KWzSE03/iHGkLDlvN6y2YSgz+jlzZD4u8mB2T
 lOMD8YdBoKCfnwQ0PiNYXuMKm2gXRrnPRTTskFkxfTDQg5t54fqcHYKSXu9YX+iDzTVDqka3kqS
 saWPiWuYWvVZzzyxiHj25XPlZaiWTo6XeS3LpSDtR/Kx2I+VJdecJ8hCn6AL8p44OTBfjZVqwTJ
 93Ue1u+sL6A3rD6UJ6raAPIkdNaMF6JFd9dhpGYP+vzVlhztK/B+s8uSZ34EZeyouUI6I8163xt
 MQbOr2U30RYP5v7E6KNFvdo1ISjs5gK42ZnhuizRnmkjmJ/3VDtmJ4+pJlPP+/AZlQcu+ip8rq7
 JU5SypaLRZEs02emRGnilz7WkpDMqOXC/Pmig1n6MLqzd1fQ3LOkjlnfUIpNuwdFjkLgiXd31kA
 r7YRCbf/OePJozP631w==
X-Authority-Analysis: v=2.4 cv=QO9lhwLL c=1 sm=1 tr=0 ts=69ca2cce cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=txNhvCuK94MA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=qN8rWf0lohQvQRdMElYA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: tYoNvPJFFQmVQXx88G-m8Pt_uuTJnAhj
X-Proofpoint-ORIG-GUID: tYoNvPJFFQmVQXx88G-m8Pt_uuTJnAhj
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

This should make the code slightly clearer.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_queue.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index df0a110ed96f..4a49d954562e 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -177,6 +177,24 @@ static const struct dma_fence_ops pvr_queue_job_fence_ops = {
 	.release = pvr_queue_fence_release,
 };
 
+/**
+ * pvr_queue_fence_is_ufo_backed() - Check if a dma_fence is backed by a UFO.
+ * @f: The dma_fence to check.
+ *
+ * Return:
+ * * true if the dma_fence is backed by a UFO, or
+ * * false otherwise.
+ */
+static inline bool
+pvr_queue_fence_is_ufo_backed(struct dma_fence *f)
+{
+	/*
+	 * Currently the only dma_fence backed by a UFO object is the job fence,
+	 * e.g. pvr_job::done_fence, wrapped by a pvr_queue_fence object.
+	 */
+	return f && f->ops == &pvr_queue_job_fence_ops;
+}
+
 /**
  * to_pvr_queue_job_fence() - Return a pvr_queue_fence object if the fence is
  * already backed by a UFO.
@@ -194,7 +212,7 @@ to_pvr_queue_job_fence(struct dma_fence *f)
 	if (sched_fence)
 		f = sched_fence->parent;
 
-	if (f && f->ops == &pvr_queue_job_fence_ops)
+	if (pvr_queue_fence_is_ufo_backed(f))
 		return container_of(f, struct pvr_queue_fence, base);
 
 	return NULL;
@@ -915,10 +933,7 @@ bool pvr_queue_fence_is_native(struct dma_fence *f)
 	    sched_fence->sched->ops == &pvr_queue_sched_ops)
 		return true;
 
-	if (f && f->ops == &pvr_queue_job_fence_ops)
-		return true;
-
-	return false;
+	return pvr_queue_fence_is_ufo_backed(f);
 }
 
 /**

-- 
2.43.0

