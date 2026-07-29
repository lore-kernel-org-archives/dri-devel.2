Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A560C54F55
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C7110ECAE;
	Wed, 29 Jul 2026 15:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U5aytkWZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ALZkvEhp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8903610ECB6
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:04 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF3HHu3343459
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DUl9fsdKYPz
 3kO0o4cBY5wSMLk2mQuvR/wBV0AkKLB4=; b=U5aytkWZaz/fVU/LGUkZ3JhxZzd
 hwrJGvk28K4ajxjw08ae0sycf9kwpiW20q9XsjBbP5n9MJaMeUI2uL9KuIJxOTiD
 FpJFDtQVbY6wNuY6N5ydHZdyCkuPbQI6Kdo4f3ORKjcMj1luCuUxc+40vTjiBVvk
 PyXjR8yCqewem22EIg519WZyiWIM+U1PweuaK9AUxaC5sd1a4e8yiwevRUyKo1Fm
 AGUz7Ip7TavuxAMSweDi1qP4BXh89MY/OewBrZ94rfyei9Kx5RsF/pfewsAmKdyw
 axdJLFMc+efpQEeCjHDCiPdo5lrp89LG9yPzUG7mdQzLdiXbWRMbGin+95w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3ms6s0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8487ed7f7beso1212172b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340623; x=1785945423;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DUl9fsdKYPz3kO0o4cBY5wSMLk2mQuvR/wBV0AkKLB4=;
 b=ALZkvEhpfQn75r+D9Bl102SusoLBYyqToFHRJHDHR6KDkcic8AFFkOR6pPfJoCY0b/
 1CyuBq9vzqFzHnA+kWp+oiZda31rbcxVNgMtiiJ2pJ17pciLpHDcwYLW7hUnvapoRlf+
 iHDsncMsfDxWV+VgFM1ZzAX1oEwW07B+kxxiXf+YwGWi4yGLoou1RafmglP/fA9yXANH
 fUS4qjcOvm4PNGAmUwcloKa3sLJcAzEO6eNX1Ii0JptrS0RrcGD+wot5HB4rzKbl/vdT
 Ajl4h70Fo9Pb0k3/4C5AJfBO5RIlvP6AetlXT5lkXwzbNQBqjiIFZ+yg8E+ieNUP9am0
 YBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340623; x=1785945423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DUl9fsdKYPz3kO0o4cBY5wSMLk2mQuvR/wBV0AkKLB4=;
 b=g9dEM2Oc86OniMGYaY/YgQyl89Mgxp1Wa0WHCDbfeSBKRR0EvzpTzvynJ9cJkZ02Oe
 LCsqqc+rMXJGmmHcY7GQDbrC+xFZ4vtUG0fk2rcYjUkQAemqF3RECB7lxNqRhGsjGx0v
 P/BEKa5+K/5XZxzgiCHjtk1W6MePNymyT9UojvOz5mpznXD+382K+cqoSUDdUTomzcSj
 hDwEA5f4A+AQq+bfeHXA4B5bIPwbJnKMHMSVPpe32vUfOqLjTojBBBIfZgZkqRaovYjy
 e21zvzWodQ8zVyik3KkXIfcb5Hs2q56JrNwVk9gsrWDojaabLezZRIToy7IEe16L9xmW
 QpgA==
X-Gm-Message-State: AOJu0YywiDbqZEfr5zrwY2TjQwhfTFiukirnOcJECwmqSj3VcRIB75Bm
 jYBDp2VR+clmSQ85ndHQg0gNaXn18cn6KJz7clpjbby6cywB1qyIt+FpeciakyX0GNlTSeRh9te
 W1bFBYxJKEkumRr+Awp5kZ2zTD6ViZ+xby3ydNkO216pIe5y3inDU75LE/UtkFF2KK/0xs3XqKm
 YhoOg=
X-Gm-Gg: AR+sD10h60kARfOnBNOlBLQlnYOEGimarJIzOWrNNRxURx075wMtL9sSnxfLkGXO9n8
 4JJJouBxZnwubESvV19N25NocZnjA3x6gP38qLmGZqHx4paM74I+HzPADNz08sx6OMkwadUYYcl
 xGs01uGbgxjyYyM81rqhDo/ikrmd4KXwzmNwZXI309YCALVxKE8RZ9hhrjFoM3Vjsz+wY4oeB8m
 7OhXS8UqNIOQOLMd57IdzQResk8PmtRkvYov70OaGSm4zMvt46LJAiBsgmrfDx7HxxxzRT/AST4
 btPi+fVyV+Z6FkM5zxkHK/UuyUoJmlYpS3uBmKweusZWbiwrDSMgFKAN4pB2eAfu2PFsNe1KoLN
 YWx8Rq5kSBMUS7QpZPGR5wvYMlFzBjFtRn6XxbHKHzKfQKTo=
X-Received: by 2002:a05:6a00:2e24:b0:848:438d:3665 with SMTP id
 d2e1a72fcca58-84e933e8291mr7776135b3a.41.1785340622795; 
 Wed, 29 Jul 2026 08:57:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e24:b0:848:438d:3665 with SMTP id
 d2e1a72fcca58-84e933e8291mr7776094b3a.41.1785340622268; 
 Wed, 29 Jul 2026 08:57:02 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea0375639sm1609836b3a.44.2026.07.29.08.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:57:01 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 07/17] drm/msm/a6xx: Access VM directly in submit path
Date: Wed, 29 Jul 2026 08:55:44 -0700
Message-ID: <20260729155609.20190-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX5+GZPB8XiOmA
 WPAbxX25cN4mfvv4H9I+264ib2VHskB19cklLcl2Wt28TjqXYwq9lub8w2oTtw7irJ2LNos6fed
 19PK5AHFS6H8RpQDRZhiGfqfhr56Ia/CEN2M7nlIe0HpygY6KJ+BC2oQKkbkIWHUCFFT0eonA2a
 a9F/A7vPvr6LqzEY9eINynYX6RjkuwCdrQjJL1ka1O1aLlP/gMS1WUas5y08+Bo8eitYM8wJNR4
 2KCedNH3pce7wshjyxxdAjgLsmBaGBvHjerh9bJldezKtP6A3jApwxJCnC9Mo5heBwEMAK+YPbC
 7m8kR+L8bHBX/h9wVDRhQNpoAE3LdiaNFTZxB40saLdXmAmzFGATmBFTI2JUNXFMyTaYyilWJ5Z
 /8rrb8Y4qVOkm5FuR/G8sejosLzMNNGzkyXWVwKV4/qnJES4Rycb2QiCgOtR3y3r3w2cLQzDxOc
 2nRl8P1ETL8wY7mBy2g==
X-Authority-Analysis: v=2.4 cv=F49nsKhN c=1 sm=1 tr=0 ts=6a6a22cf cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=QS8Fz2UHHwPDOV3g--wA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: tRYFytPtuiH_9J-2dcR0z_dhFNvTfSVg
X-Proofpoint-ORIG-GUID: tRYFytPtuiH_9J-2dcR0z_dhFNvTfSVg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfXzAEZCbn/BnRh
 pXLjK+WbeeoFvmkQJKhhT2/vZBTnbBf/joQ92KhzBI5wuRmoiIIRUEOyno8K7zQOHijcjHqxB+T
 s6bf9/JT5lnNhiiS/jPB/GZ0kNHwgPs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290127
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

The GEM_SUBMIT ioctl has already ensured that the VM is created, so we
aren't expecting to lazily create the VM this deep into the ioctl.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 8b3bb2fd433b..7f1673163f67 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -229,7 +229,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 {
 	bool sysprof = msm_gpu_sysprof_no_perfcntr_zap(&a6xx_gpu->base.base);
 	struct msm_context *ctx = submit->queue->ctx;
-	struct drm_gpuvm *vm = msm_context_vm(submit->dev, ctx);
+	struct drm_gpuvm *vm = ctx->vm;
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	phys_addr_t ttbr;
 	u32 asid;
-- 
2.55.0

