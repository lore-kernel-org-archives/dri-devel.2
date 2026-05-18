Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8203CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2CAD10E9B0;
	Mon, 18 May 2026 19:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AJZkPGKG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="frC17dH2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B85E10E924
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:22 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IJ6kdo2701040
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tpSYknoSjgu
 xLp2PhcNLzFD+hJIyTtn62dCNb7J3rZw=; b=AJZkPGKGiC8DJki6mgucSqNhEId
 RzGSP8+nUyNVlJprxIPm6Sez9DJRUFxtp+ltFxJ9q6V0U+TyE/VA1hcxpUpP+oF/
 jh1LN+LyYrTos6yxJFztAmWA24Cu3Gfi7mdPftcbdpVyo5+22wdhYpLLnTfz+Ykm
 GWIBJATj/Mw2Is2bR2Iwi8EEewidWqqhVdIf9AmRudwhqQGRN3gacW8Y5n60ixcm
 D0gWkQf678LxT+JfwSKFVM/Wm0WMH3LJoHVGcqO98LEzSHqECkeTL277A8Vsg3xv
 lNz0YBesEdPnyT8Zp8GCKSvn10av6b7/0/nGWuR8P29HKkixIVUrpcpPpbg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82mehjy0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2babbeff9e4so28634305ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779131300; x=1779736100;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tpSYknoSjguxLp2PhcNLzFD+hJIyTtn62dCNb7J3rZw=;
 b=frC17dH2gHXuojkwuSpaksR+VSMMCR8ifC2b0DXu7kuXZiUejU7ML9ly9iBYl1bMJP
 NN14RMnauaSakx9Lrhtylp2SaOALE93neazGN/kEQMM6lcSZTXzAuizIrwh1tB7XDCrn
 ChqKBI25fLT3MZtDSm7pqzYRFKMqrQ8v2Him+u6eaA+80IqiFelIeH0qx4XU5l7mimOK
 /5qE2G55axa5q8QEqmp/NSjQTDO91wRWS0gNr1rGchEyX0yVtOcBObsKKLeTMypnB4Fp
 fxz/znCm9F443W1852M5jk8BCmsljFbqr9iphuIY+m0Lq+wuJZ3X5Z5dPQEIH4J0l7Zr
 zecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779131300; x=1779736100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tpSYknoSjguxLp2PhcNLzFD+hJIyTtn62dCNb7J3rZw=;
 b=pMur9pll4HImi2UaYTKGGYZKaIuMXgbCl8QLitvcXRIcyYT5GBFg+3tUJpp5DCq4zs
 fNywsGsXznaTFnnpbo7w/FqEOH1CDfxnm/fIlXOTK8MJ4qFG/6zW8y8uOpiCtM2qf6v1
 7pmtyQ0jcZqDL8pCAcN9lqdDd4CjkGm/q7C6fInaENxqnX2zu/eowRI005QBueFC3P+m
 AuckRzFT6wt93hLbRsFTTFhvuCG2GZ6IbHuVYJkxDIfRdRb/VRoJ0BXTrMqjL4FRGeEM
 xKUMMNxa9hIotGwkjlIWR8PVFHD1wScNgsZICb51OfQng9rh9KPZSjifR5eBFz8JbdkI
 bxtw==
X-Gm-Message-State: AOJu0Yxnq3W+ERGrYLYRLrP44X+kVqufDHABqMs9SWO1grtLQ4wJR5S9
 yWDcwJerNb3K7tOzFpmmrj+IvcLtRHzq81CNbywTUCroHWMIEXDaTsSizPpuSxg56CnQECwFxys
 kDEDL63ct0a6YnZ0Udxkr/9snOQ0t/lrnel46dymoOKn04YLBRoSjop/GHx1Tre7btvy1Xmh7wZ
 qhBMA=
X-Gm-Gg: Acq92OGdYVPGdwJmZNA48EP9SN8HY1QkJVrwaTAx7awOwxCSpPrqv4No/OYlZxOIOiO
 Gnqb4FZ+E3baGNo2LBMlczAI4ovxCQSc65C70GIQDZbMUUG0OmQWFuamILcGWPEiLBEFsaEQs81
 0OcczZGzJIlXvid0xob8umtXQ/zev821YQcsFGY5ZVccqlmz3AcsgMKWM/naEWcKGovTv7PbMLH
 Yyh+uCKfP008Yw7GV8mGeH/9MU1QtAsdKpTFMVvGosprlefJFoFgtZLQ4LLz8NIWOsNNY8/FMyO
 A1EZ0CG8hWELqukuyeYtSLAYFMXWhaCIZI0MFtijsYNzTRuTHKuz42vjzbmui/Ne6l8FJrmo+pO
 nyJHNcVGCY9rnQL7pUlI8tyDbNJ532MTO
X-Received: by 2002:a17:903:1109:b0:2bd:d6f1:3388 with SMTP id
 d9443c01a7336-2bdd6f13874mr51444225ad.28.1779131300212; 
 Mon, 18 May 2026 12:08:20 -0700 (PDT)
X-Received: by 2002:a17:903:1109:b0:2bd:d6f1:3388 with SMTP id
 d9443c01a7336-2bdd6f13874mr51443945ad.28.1779131299706; 
 Mon, 18 May 2026 12:08:19 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb08d06csm14312968a12.14.2026.05.18.12.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:08:19 -0700 (PDT)
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
Subject: [PATCH v7 09/16] drm/msm: Add per-context perfcntr state
Date: Mon, 18 May 2026 12:06:36 -0700
Message-ID: <20260518190735.16236-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Tr7WQjXh c=1 sm=1 tr=0 ts=6a0b63a5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=OtV_UDYxk2hhjaRdRjwA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: p6TrKK3Tbqe_m2d3c0HJ81Mi2r9wPI_u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4OCBTYWx0ZWRfX+PR+PnCea2I/
 mfIVxpqv+I5kHkZZXTSDKRzO9kXixtKYPojpQn8xy9b3+OTx0uWVB7UbvrYHLlERZpgP3/jnq2L
 wVWfT9yGqLSWVBRZ1DgAyrdaMlFL/OeVl6uz0YenKOWF1j8sCZnR/EASF7uoIGAk5jdLUOrd8Y9
 rVUM4RcpG7i/pRhnr5HGVAuY2hEjsRKA0eHASGulqZrjr2e4P09b3wd0dJakGkOBPMqtLGymrpD
 phDjt2Zt9bF7hkRtuxPT9BcMaFTcMqGt6/0i66FNUmqBwoz61Fb0eLQ1Hui7xO3J2ePxq98oOWs
 ngsgcYbhboeRZ2iCZEnJ4QZQC6dFKOrUxrc4pGRrXU3uSlmtJ9Ux0eJcKW2J+aCkd0g/P3SQhzz
 sJQWockBZK6JX8q+KuZR+1e04uwk48vU2CvUu+RCrnvBCxhwEcvNcEUObWzfvtg9rJTnjOwPCEZ
 xKQSD0Ad1G9RPWC1g6w==
X-Proofpoint-ORIG-GUID: p6TrKK3Tbqe_m2d3c0HJ81Mi2r9wPI_u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180188
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

