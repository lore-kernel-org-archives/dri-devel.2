Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126ABCD5BAB
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5A610F0E3;
	Wed, 20 May 2026 16:25:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pwO4ygww";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LwOqyjbp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D983F10F05F
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:34 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE6cXn119131
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zUQTW5zoVnU
 p4nHccZutj+SQwGrJIr4wWIwttwIdYe4=; b=pwO4ygwwIW3AkFObGV9ks9gjtcV
 4QnyFTUlChK/O4ZitILh0OaSP6BIx2S90/J/dFhVa6/q9zRxvCy/kjGvHrC3kNcv
 rwogK0sAdQw8sf13sSUEGZ4qa+N+pa+ucgkVOfSq3SzAYQH7X+o/xrBpxnKWk7P+
 63WlMttw6FK13SqvjwfFi+I7B8YakPqffES/ojycVkB/P3whQsOHQhvvuUBwn8LK
 Rv7w1FoGBpTqGJxkQEZYcGA5aG4SIn54+KKuZfRuzEoppsGN6ZdduVd+z5Xeavl0
 HTMbM1HEFKxxyB64oJGLh/G4MXbYGwdx/szpiykGP6NAskgWe6YxfWVqYrw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee88n6a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:34 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-841127f960fso586126b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779294334; x=1779899134;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUQTW5zoVnUp4nHccZutj+SQwGrJIr4wWIwttwIdYe4=;
 b=LwOqyjbpkN8iNpg9MN8THF07u5FCFhk/e7GMjcGPlM4pp8exFm5u05jF32OUnjcGtk
 s+DmjQckzYLV5dQtl7yaSIm7IDp/H1Wmk5mJzyRW+Y4Gvo+jAdDChR9ydow6P0zKNtXH
 9ZS/3tHMbDH+2pvEcVqc95udazmMOLPThOTKa1b9dp0VKC8+f/q8cnzT9Ti+6t25suQg
 9NtSQKfb//XlpbGeaPoSi4QsO7T5Nf4JJ3rGJUOi4QiGxjXFnt/4SErKDVCeomkTjoPw
 1ADX3QLxL1WNaZq/otpW63MjmtEa5O7il3LgqX7n88jxkkXHweakr7aVdL5TH7o0KRGG
 cdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294334; x=1779899134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zUQTW5zoVnUp4nHccZutj+SQwGrJIr4wWIwttwIdYe4=;
 b=pa02sbNOLNGkOo8TX/H8pgAeujDCgsm9i4UQ5NosZ5XfZlHGlpB7FXAErGRFZWAFkz
 cEy0Abt/9wNePGxlP7EsoqXz4PfbIJ5/Dbh1SjQr9GU1iqcEuTZhdUfUM1Pn4u1iEX5M
 hz46140tacNVn+M0DEpw01F+3LWFptLgQBW/fh41o9RJFWRKNs4vn8M39DVYluGR3g+w
 KEpVxpNST+AK8xGyLM3RuvWfmK/i8FCO+YAnaC0UY5vL0dDkX63UIJkq6/dPKfAXjhNq
 dumU34pr6G7UyRJmknUMz+GUhsrpNIvOfmqD2zFiFt+TTQn58YkZ7rZTSRf+/QbpqDCt
 27DA==
X-Gm-Message-State: AOJu0YwnH6QzzcF6HI+2U2lnDfypooFHgv9fqCPs61qswCSjY2JXuXVu
 nz2kg35q12h+JmDYIW0Umui6Md640q1NjeQnLPRHtYoe7AMAAbCCt0d6X7ZMCwUTQ0vSmu9R4yk
 NS7rxAzH8k9ZUoy4Pi7iaa74FZfuEG9y51NRWJyZzFpG/nNo5BqRWep6LGs5MxZUiVtYBjHpukv
 mgbf4=
X-Gm-Gg: Acq92OH5jnJJ/zMuJ49dV47FZ1CrD4xWFhCNlDINhkIizWfBSmpOjU8fGiwhd+b+mNC
 qfmOzYpyfasIkpcdYkGLnK9EKTcLzZ1rkdGx5ZEITq4oMF+tI6jyvOQo3QGTlji2ccTPrEQ3Yuw
 blR4e/hwyt+EZWFn8q8lqTFSxZJ39WT24LSRYwdfMrQeycbSdPy1QBtmT327IqBieJpHjh7LLnj
 6KTfWjihfW5NPfTthVngJDFrQMHi41ctEy3fZFNQe20IUacoMr8ve2Cg2FgBANC6krvzSlKnmzu
 FwLg0KgITN8o7Lx4tUwivD2+lnUzpTmdDFzYdW+XMyEnf1tIdrqjI/SIHgd/YZVJQZKWs4Yn/Pj
 mUarv2eAQa24T1KBLMrGvl9bl82peI04t
X-Received: by 2002:a05:6a00:18a9:b0:827:3b1b:43e6 with SMTP id
 d2e1a72fcca58-83f33d227c0mr24677355b3a.21.1779294333561; 
 Wed, 20 May 2026 09:25:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:18a9:b0:827:3b1b:43e6 with SMTP id
 d2e1a72fcca58-83f33d227c0mr24677314b3a.21.1779294333020; 
 Wed, 20 May 2026 09:25:33 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f1977c494sm20995960b3a.21.2026.05.20.09.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:25:32 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 09/16] drm/msm: Add per-context perfcntr state
Date: Wed, 20 May 2026 09:23:56 -0700
Message-ID: <20260520162454.18391-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
References: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tRSOi9hz6yX9f3EB9ka9OTl74jXXPR_N
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0de07e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=OtV_UDYxk2hhjaRdRjwA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1OSBTYWx0ZWRfX0tfgrD2kSVqV
 zcT+yFXrJjzar+e6/Bmjxz6RkI4kokBDQfoQiX/eHPBQ08535MAY3xr2d6t/Tqnu2KEn5HLOaoY
 YZBmtayk5oVZb8TpW/nwIRkgKhgXx90Z/qv+nCnQXrcHt8LKQesx7tLuyN1eYRdJpzwrc3wW71g
 0v/FPmCP11EJFKAj2OdtLjJ2i9IbfSvIuwzbnHyhbNer25/RSR7fvLyf+x60nOBN+n6+rzxBD9b
 YGWO+iVVlcEP3YHQRANR2/E8pLsRDWggYUgVr1fgHjOy+ynNT98Vy/FUA26eFU34nq+c5L8cyAf
 M9ZjMES5CMHg+wBR060HPiT9bb6LjXMz4nqx7T1FOYOF/Ni5KS5zwwR3U+O0D0ZIAdY4P4FFAgp
 zFVSfEF5pE4Zp28ew8gz7AEHUhZo6/Zs0VNON8oyhgm+VU3E2m0ErvN2DkhdLjKYGbwZi4qrL43
 kZNKYQxeI8GyAFzYcLw==
X-Proofpoint-GUID: tRSOi9hz6yX9f3EB9ka9OTl74jXXPR_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200159
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
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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

