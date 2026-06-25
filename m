Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD166CDE012
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F92910F3A7;
	Thu, 25 Jun 2026 22:27:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XGqmr+Yi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qea+T2qX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BA410F3A7
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:55 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFe6vj2192048
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7V7Err/Z+6B
 Igi6OReMeeTwMA3vE41djVqJiMjm/22I=; b=XGqmr+YiJ+zTTAcHdKlbYzM616P
 AE3DNAHx4DTCD3ko3CAaH7JuCLhUzkfA5ERX/K17VQSHnZApjpprQDX7ENS95w1z
 ShZSdTDmCSShKrqNagoL6ZSFTepFlqNgOhzFzM23d8kdz35uwP4j4JxC2hUoVdTB
 xqm6cmfuMup2UF9u/JVtAn105Iu7se32GwwEy25Ng9wXPRBnVjiEob0UmiWzFhUW
 BypZHzO+dIMOuM6A0xzRGXPy8PqEb60wgyGqCoB+R8WlaPfZ+CdKMfkF+Fkvlc28
 L5QS/EP1reV1lcOIJOV/cdtpEzLjxpdanm6nq0mZbYN7WZKmirrQKXdqQzA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uudmee7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-845ba254a4fso184201b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782426474; x=1783031274;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7V7Err/Z+6BIgi6OReMeeTwMA3vE41djVqJiMjm/22I=;
 b=Qea+T2qX8dENWkdMeuvTVA34O2zitr9zmV0GC+96q9FHyrkZ3J/lhnw6LCAkPZx0LD
 PZVrYiBa7ZEYDQ5z8GZS5oH7cPHYjEJbU+fyBuZZaitgoluulTPsRbx0H72XjOBfsOEQ
 lSr2dJHJkAOyd76+umULWc6npD2oNBGW+0jlBKTUEKInvuRl2y3gzEtdwsFQ9eRdF6nf
 DA28Y6HFJnJzg0qAqP/1zgifPcZaaM1qG83/Pwug2TeKfv5GaUkih8+z7invIWm3g8N9
 N6vtSJku5OI8bXw28AZhjO5FbFHg0NLTPdoHNm7djTmzSCoScmEbPkD6tmmtx9v2LIVj
 af8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426474; x=1783031274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7V7Err/Z+6BIgi6OReMeeTwMA3vE41djVqJiMjm/22I=;
 b=HYNAPSxTC4+RRSEAHu1aUBFz91gnocOCOSRkKVL2K1PhYnm5xwYrTMJ15z7hzgzMvX
 uiAnGdoRI6cyabfChGqVURtnHBVa7Ra3kXHYE8lrGE/eAFVxlIrqHZ7Z241KojPEMAJ+
 CE+tC0B/h3C/QgksCq0iaBomOT0bB74G+JKba8jBmS1C1DoDtZsTGp/zQBRd9xNxmOO2
 eGn0xEAX+xI9qyzqkC76Gl/6MHQ9opgCZu+22NLr3VpY1eyKWuQXjY1PGrQiTH//g6vT
 HGgOLEm8ANVohA/n+BD5KkcOBCnxpiJ4ossiSILz18276e1Olr0NPxZ1SPcX2ozlFeW8
 vMbQ==
X-Gm-Message-State: AOJu0YyO83Qn76MIlt4bIzNZtZQ+UrP4cz9Y2KGFwLZx7aYExBPH4gR+
 45wDJLI6qZtMao3euTUpRBZTEqxnCXAGXiucqpG3nD5nlZneCTSqT0vUvkwwTE5hBLDkRxCiY2r
 qFv+YHkYdWsSfWWWTPjgd+A9hEKSOpJk6ATMM1SE8g/z6G1I4q6QF4VMQ/QEMnYFgvLjDWZSiji
 j5zpc=
X-Gm-Gg: AfdE7cm1neRG3OBVJbzAKwCxZqkFvRTTc/fDF74/nA+OTtsh5zBNGl2fF1kNiwvjkUg
 ZbpkwHPZs2+QA6aKm5K3gGKoy74J6Qdg8Pb+IieTZi/PmYgOoKcdgezVPr4AzCBsVueTNyzFH9U
 hkVBuCvUu8zU0IEMN9tqSZDmibMNv2mIwnUhp+1PNRupySjjTHDFgt90aGswsIiTcAwubker7UH
 An1jT5pHfMWdeIojojRL8jRwpmnIJJl78c5l7ZZoYI8D7ggICN3phwEfDVY4gH7IhBpaldhwEQf
 agB32ysRkFtmfiL4tdf7eoOycI1H1S+xU4Y76dG8iCq5oJ9WRvnFL1eQKAbjrRyyDbaIJRUOJYo
 5geUIIJSEf6rdgmuntb3L/RCOue/Ebyu639tsfjP7j8CZebNCVfKJUJcWfg==
X-Received: by 2002:a05:6a00:94d6:b0:842:66af:5bf2 with SMTP id
 d2e1a72fcca58-845b3ae5703mr4586736b3a.38.1782426474198; 
 Thu, 25 Jun 2026 15:27:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:94d6:b0:842:66af:5bf2 with SMTP id
 d2e1a72fcca58-845b3ae5703mr4586706b3a.38.1782426473642; 
 Thu, 25 Jun 2026 15:27:53 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845c104113esm866863b3a.57.2026.06.25.15.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:27:53 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/4] drm/msm: Validate lazy VM is created in GEM_SUBMIT
Date: Thu, 25 Jun 2026 15:27:41 -0700
Message-ID: <20260625222744.22254-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625222744.22254-1-robin.clark@oss.qualcomm.com>
References: <20260625222744.22254-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfXzORPHuzuKOyw
 6/a6Iu5rajsHcPckVVpbGUE2Yq7bGBFzgyjhT6ObHQ3FXrYOQ/rMG1+jCTfC6kvCNOud96NfFuB
 t3DQFVjSIsHsbNCSxsHTQVapj//j27I=
X-Proofpoint-ORIG-GUID: na2MwJogVgSU7rpnyhcPsK-oseEiByUp
X-Proofpoint-GUID: na2MwJogVgSU7rpnyhcPsK-oseEiByUp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfXzDQT8URi0JvJ
 qkSHt+EOn5o2w6y0HTT2Q33fBT+DJg/TiuV+0bVCbRSfJEq2Uc6Vdr4t3vY2nVYbF5egKLAvHjY
 qPLvIn6S/CZv6Gg6pLF9V/nDHJ3vcQ74Icmpw72s41Z/qPqcwLSzOwEm6msThh5RbzCEdgXVIN/
 aWIGcGM5p7SKQYNjgai7i/0OqlzcT8Jr8zzANTJlWA84iGPAzWg+1rqDYZClhgv2fD2tUI84LRj
 8uXyTFBdWFig7mldfXoNC5YBJgvtgzKV2gTH3jCRNS/hg4q/gjOo4tvgfngai3GI/mUg3oXy/yI
 Qz7pLQ917xyl976V6UpYDbKXore4DbWRrb7X6Idew1G1MrQaVEUc6+WJJuCJE8BvX591/tcIVcq
 z10QYxUL3zpkObD0Z0MW54Co03R6d8ull3QZBBtFwBgzOZ71J1TDESdS47x/fS6dNIc26aSpMPO
 f4x3TTo7yNi5H9kLv4A==
X-Authority-Analysis: v=2.4 cv=HdckiCE8 c=1 sm=1 tr=0 ts=6a3dab6a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZH_LIYEqPuu6AAuj7cUA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250193
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

Otherwise a GEM_SUBMIT ioctl before any BOs are mapped could cause a
NPE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 6a4d287a1ae6 ("drm/msm: Mark VM as unusable on GPU hangs")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 3c6bc90c3d48..56929e821200 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -30,7 +30,7 @@
  */
 
 static struct msm_gem_submit *submit_create(struct drm_device *dev,
-		struct msm_gpu *gpu,
+		struct msm_gpu *gpu, struct drm_gpuvm *vm,
 		struct msm_gpu_submitqueue *queue, uint32_t nr_bos,
 		uint32_t nr_cmds, u64 drm_client_id)
 {
@@ -66,7 +66,7 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 
 	kref_init(&submit->ref);
 	submit->dev = dev;
-	submit->vm = msm_context_vm(dev, queue->ctx);
+	submit->vm = vm;
 	submit->gpu = gpu;
 	submit->cmd = (void *)&submit->bos[nr_bos];
 	submit->queue = queue;
@@ -554,6 +554,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_msm_gem_submit *args = data;
 	struct msm_context *ctx = file->driver_priv;
+	struct drm_gpuvm *vm = msm_context_vm(dev, ctx);
 	struct msm_gem_submit *submit = NULL;
 	struct msm_gpu *gpu = priv->gpu;
 	struct msm_gpu_submitqueue *queue;
@@ -572,7 +573,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if (args->pad)
 		return -EINVAL;
 
-	if (to_msm_vm(ctx->vm)->unusable)
+	if (vm && to_msm_vm(vm)->unusable)
 		return UERR(EPIPE, dev, "context is unusable");
 
 	/* for now, we just have 3d pipe.. eventually this would need to
@@ -609,7 +610,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		}
 	}
 
-	submit = submit_create(dev, gpu, queue, args->nr_bos, args->nr_cmds,
+	submit = submit_create(dev, gpu, vm, queue, args->nr_bos, args->nr_cmds,
 			       file->client_id);
 	if (IS_ERR(submit)) {
 		ret = PTR_ERR(submit);
-- 
2.54.0

