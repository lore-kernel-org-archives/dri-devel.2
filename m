Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584EBCD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 13:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B9B10F237;
	Thu, 14 May 2026 13:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RalYZEG2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U3P6ziwu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA18010F214
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeSxj2554520
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tpSYknoSjgu
 xLp2PhcNLzFD+hJIyTtn62dCNb7J3rZw=; b=RalYZEG2911GXWtZbTlXU6jzXRs
 l/jppPX9UF0nTeLvSgLDbRpapxeQqwDTBheiR4AvtHmQZd//sYhIx0vNTuIMudVv
 p+PGX0qChFg5kL4W+5XWs5mufQnMcSwjj8XOEAlJAFK/MtPFoswJ3pDlrLX3UKJS
 35lZB1MeLxy7+32mWqFuciKqaY9jyVTJuZW2jYm5tlku5hZiyZSnlYlN2kNmIfud
 BvMlJ/6BrJ7eeCcMrvfSxNyiMm2tlkz90SggOOvVTKocQgdaPr7H25lbPt3mGL5v
 vXQtklkprHu6nx54Shhpz+rANFII2Yl2GBD4hRWMsEmDsmdofLIvFweFLrw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5b0bs1jg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c827adbf00cso2860476a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778766871; x=1779371671;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tpSYknoSjguxLp2PhcNLzFD+hJIyTtn62dCNb7J3rZw=;
 b=U3P6ziwunaZkjqHJoiXj+YQcVF6kcYu6UrNa44xMO7XC879BeSFoHTJOnfwULwg1/+
 BIA7eKkLnJj5rPgocmEFS0Jkdi2Oe+4anJjJQg9u6mNF0tDMzJvJXMWkOzn+t6zB0Q4S
 nK3UQJmq+v1WevfZOSJg3nQ+PkyV61f+op2v0FGKc8/7PjZm8lqB5MUTgoQrvX0c9+Hz
 GGbbgDWk8TNVG8GXG2AzwJR2muDQPlaS6JjJWyeRqi+Vj5EmF3U2CAWWAp9Kf+TuCGnG
 NS8RHr6kmgDmxMlZcRbUlPqhz/urb0m20sxpH9IuHnFYcZC4MrkbHjPqdovK5m19nV1s
 goeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778766871; x=1779371671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tpSYknoSjguxLp2PhcNLzFD+hJIyTtn62dCNb7J3rZw=;
 b=MXYLvXHsRCTfLnKqbSqIx48N9uOjol9cts3BsuIqgSAUPfSs7ZPuupeTqZkPw2hsRC
 2qcgv27GyFx3VMM9dD5gMabHXQPQy7GEyR8oYotHoJJGS2cVM61neR3WudquIMGv9PEo
 ETrsAgCkzPslv40x5MWYs8x5zCIDJ0RCuKHvfsoZHcH+x2tqxJCtf8zzWPyweq0rG1mT
 +LOUH4C93aFzc8YVAhASu7EfuMpWsLiU3bUasPrnvv7F1JdKSpQWHYTtdgmcgai/YUNA
 wf0iciCpLszV9S6c4Up+wBAz+8Gc+tVLPTmOPV/BxSKFPTs5Vk/qHWLzBaPZXmilyFF2
 YeNA==
X-Gm-Message-State: AOJu0YzAjaq32Z9WyuKRVaDvnzyb9LFIyg+7nGUDm+X9iIs8h7H6t1MB
 7qIf6WNOR5hhAbPMizXdgGIG3hjhRujYcTDUtqU9KrCYnnE7wiQo5y+VH57tORidAXbAefTF7BJ
 5SO8N6kuaNCOR/OYSM4MVOi4wesV00tDNbb1TzENDTwvNU28mCwwNxgx3xJNpjTyMxKR+tfXxNY
 aT82E=
X-Gm-Gg: Acq92OGHRHEytj2hHi51bbtKGeqL50ghO4VShAj+F1rfTNxoK9lNxwizXxvMsFCn1Fe
 Rsj8HobZSVlwaQ71hm0C7I2q22BVKK86NFZXpiYqPBudBAp3b2Trn+PyvvpUsy06VIfcnfT2/Tu
 hoGSDMXzP0TS3F2BwWazT1i9v0/978aJsSRPUQhqmrPORX8wdnohmWPRmHcINnEwmkjIhBq7CIz
 jfSy33hGGYhwP4uImBgcf3GQOiU3EOatNCwBLd+ZZJD388bspHLE9a80a/isqwvLTZCap77ZqAR
 bF7BHjs4/6IuqFYfdMfArzH1cER/FqDE/W0dqTBwplDTQxejthDlQ5PDFx0BON6rMZOv1T8RHBB
 H9S63kXUUiU9BxlYG9DKjsnzwmzzsQmkV
X-Received: by 2002:a05:6a00:1acb:b0:83e:e03a:f926 with SMTP id
 d2e1a72fcca58-83f03e910e2mr7999709b3a.9.1778766870651; 
 Thu, 14 May 2026 06:54:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:1acb:b0:83e:e03a:f926 with SMTP id
 d2e1a72fcca58-83f03e910e2mr7999647b3a.9.1778766870087; 
 Thu, 14 May 2026 06:54:30 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c78844sm2721847b3a.47.2026.05.14.06.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:54:29 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 09/16] drm/msm: Add per-context perfcntr state
Date: Thu, 14 May 2026 06:39:57 -0700
Message-ID: <20260514134052.361771-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
References: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0MCBTYWx0ZWRfX+r7yo+a1N2Hc
 7B+C/tnmaAJqpWTrOZzX98ViI8Loli1jurzbU4aRz2I3kBgu0cSTQJT9Nn0PreVeGfFlIKOSsSa
 tVfI4JK1edJkG15++B1yuXq6wblh9oeUxYN/2fF2GYwLBIYRldPNlpZ9sy4YHQF9gnIV7AO7EoB
 AZid+xJkupeFo3YjoWG9oYDSS8qT8pHEexp6xbyPb1HE59w70XGkIOfedn3G0MukpIpfZcsquG2
 h8N+8PwdwMO7K4OdukZ2EqO2cVwbo09hDLoiJ2RS24uPLvIch6zJvEB86Nd5OhvPzlHWHp+ibiO
 wGxKRXQg+uK1xXxIIBu4si8hfMG3rcHHgIQNNTtoazz1I1RDepy8l8uqregE4V5r9ACk78Lw2kU
 UmMw/2lKSBH/Ptqjpc6tsApiVWRrpO2tHQQgD1767VzQzIMCXtjVzpOFKvZCkM4czVADZRr5N80
 5h4YFKEE7fsDCNtsg2Q==
X-Authority-Analysis: v=2.4 cv=b+2CJNGx c=1 sm=1 tr=0 ts=6a05d418 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=OtV_UDYxk2hhjaRdRjwA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: ScCSOK9BSLvEyOSxxOgx7UbEMkrfG1yC
X-Proofpoint-ORIG-GUID: ScCSOK9BSLvEyOSxxOgx7UbEMkrfG1yC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140140
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

The upcoming PERFCNTR_CONFIG ioctl will allow for both global counter
collection, and per-context counter reservation for local (ie. within
a single GEM_SUBMIT ioctl) counter collection.

Any number of contexts can reserve the same counters, but we will need
to ensure that counters reserved for local counter collection do not
conflict with counters used for global counter collection.

So add tracking for per-context local counter reservations.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/msm_gpu.h         |  5 +++++
 drivers/gpu/drm/msm/msm_perfcntr.h    | 21 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_submitqueue.c |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 9e5c753437c2..19484774f369 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -434,6 +434,11 @@ struct msm_context {
 	 * this context.
 	 */
 	atomic64_t ctx_mem;
+
+	/**
+	 * @perfcntrs: Per-context reserved perfcntrs state
+	 */
+	struct msm_perfcntr_context_state *perfctx;
 };
 
 struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx);
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.h b/drivers/gpu/drm/msm/msm_perfcntr.h
index 64a5d29feba1..7f0654182496 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.h
+++ b/drivers/gpu/drm/msm/msm_perfcntr.h
@@ -35,6 +35,27 @@ struct msm_perfcntr_group {
    const struct msm_perfcntr_counter *counters;
 };
 
+/**
+ * struct msm_perfcntr_context_state - per-msm_context counter state
+ *
+ * A given counter can either be unused, reserved for global counter
+ * collection exclusively, or reserved for local per-context counter
+ * collection inclusively.  Multiple contexts can reserve the same
+ * counter, since SEL reg programming and counter begin/end sampling
+ * happen locally (within a single GEM_SUBMIT ioctl).
+ */
+struct msm_perfcntr_context_state {
+	/** @dummy: Some compilers dislike structs with only a flex array */
+	unsigned dummy;
+
+	/**
+	 * @reserved_counters:
+	 *
+	 * The number of reserved counters indexed by perfcntr group.
+	 */
+	unsigned reserved_counters[];
+};
+
 extern const struct msm_perfcntr_group a6xx_perfcntr_groups[];
 extern const unsigned a6xx_num_perfcntr_groups;
 
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 2598d674a99d..a58fe41602c6 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -66,6 +66,7 @@ void __msm_context_destroy(struct kref *kref)
 	drm_gpuvm_put(ctx->vm);
 	kfree(ctx->comm);
 	kfree(ctx->cmdline);
+	kfree(ctx->perfctx);
 	kfree(ctx);
 }
 
-- 
2.54.0

