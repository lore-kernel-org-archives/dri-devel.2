Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C2CFED3E2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911D510F5F0;
	Fri, 24 Apr 2026 15:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNiqVHra";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G4cZ41dO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC3410F24A
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:14 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OE2icC4012285
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=38TAuDgn/y0
 0OaDm7XX1LoDb33XqmHE1sUyo3NaO6Eg=; b=KNiqVHravKN1HO/jXLQ6E76BAbV
 YA+dtQR6blNm12Rr9GsvLlpYxjTzFpc22GutPwxOicW+phU46TMN6mV9fjChGKUh
 cHnM6tQVToQanytQXfh8WXtHODdqxAXEFPrQQI4iyv2NAbVwcXzfqERTVrV4XvDO
 HwIDw1mJiE+R1eJDZPE8qNvhLuvUOm0lrge0UtxYgTyWDDtQVASg0QjOCofO9uuX
 Gv67123NdqLdjyyy2UavK1PO0nkS5UvB3wW37UnwE2yx3FkYRs5O6rUCF5nNyWJ5
 53eKkftEAV4lgZeHliQ308bg/B7vxI1intVmstiOpgQoLXNl4QniYIfJ9Nw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqpq9w03s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so4710657a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777043532; x=1777648332;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38TAuDgn/y00OaDm7XX1LoDb33XqmHE1sUyo3NaO6Eg=;
 b=G4cZ41dOj6kfZoFcz7BFHaQOb8aanc6pwBs8WZwENHraDaAahb+XjDo2FC8tUoQ0Uq
 j82po2mPVPzyLTAOJgg0ZuAy3Hv7SkLOiml3q+kYW38/BZeh7eC1FZaJtrJCVx3i6z2h
 mRGcehp2cqfxN6mhmkBjJaEO5xDfvJNeVCUZLmVGrGnid98Ya7Z+HpZyXmMPg7vqAUXB
 sHjvEMYQHFz/ny6XE6TAqZPD1hhaHc3DeGvEPT4uwNoQYOvRv5+GZQ2PkqwifSgoG14v
 Lop/DkMQEcwG9nJdqxKE1Qdu8hSEe9In+FYhneJhHpkcWrlfZFhHv+n/BCgjoMTB21t/
 3bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043532; x=1777648332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=38TAuDgn/y00OaDm7XX1LoDb33XqmHE1sUyo3NaO6Eg=;
 b=UIspVPIoUtR1MqWOtXhTgzVV7egvLqiPGf+GXJNHPmtQSWsfwl5HJWXBsDGl4ooJl5
 K0+7V486AS/kWdFLIxlNCPRrBBkUCRJU9c9jT02FToq7sxr2Ut1/5lyNSNrbs494sPV4
 5YYX5LFT4jUpvdyOdcQeC6MGlepOqa6zoR5ecQR/Zddps8iTa8AmK0EWPIC41IedZaaR
 ZTJFdtwyML8iTC1viXchZMdBy1LXC5Mw3JdwoLuWPFhjP0Du1+uKktZCKLmp5y452r+I
 JaBUUvJvqj3P0/vA3MTblFZE+1sRb82UEAweA6XtxWX22cXZdWdIxVgQP2jsGInQCqOL
 cf3g==
X-Gm-Message-State: AOJu0YwRFENSZU/STB9lYgz/vF8RdDkPq9SW0Tr3RWAczpHMPsNH4fdj
 MvoTUWKN1OGTD9kN71mHdhPP/unJEL/lgQQOKX0huWOj1/T/3TjsVm3IzCGyQacPbVWnIW/bNN3
 MHE5f5NgzWYruy64VTT7F4m5lCa89WgLC4GuccZ/gei5g3maUrbEZYLvmhP02kei6UOcTPvFmXt
 Vmzmc=
X-Gm-Gg: AeBDievxCJVTzWPnGL/lLmUsPcU+4oNGzSjrNoBEkic+5yRtAkRx+ejwHR8Bmngsu22
 RtgwtZ2VXe8SYV/UwBVNtv6r4CAGjp5ZY9oF5Trqo/TuPb6XEMm0JI6xmIhaxTHKRxm6jK0oR34
 1kFdvE5ExicoTRQyMPYw/Ad5wb1u8MlLg3cUWiL8QdhPpC6uM/6GCMX+9l6mKCdUSc1FGc1h1Qj
 JGe2PfhdmlVo4X64R88B3pUCfZcGC7fqnKjfK4R+u+jeJgRpxhWyRlNqhWCcxVCgQwP4pFSLyzN
 U0ktKmTpClgjKRH88DkvgoXv5BtcDwfLz0+vql5/3+0MfRXLFkaAAKtiiI7Oi3WkLOCpHQAdrLS
 ZwjygylrOA/dLS4a087oSg7boaReQ2rg66bv7SKKPXGA=
X-Received: by 2002:a05:6a20:7d9c:b0:39b:f026:6f8d with SMTP id
 adf61e73a8af0-3a08d8e27f9mr36956105637.43.1777043531898; 
 Fri, 24 Apr 2026 08:12:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d9c:b0:39b:f026:6f8d with SMTP id
 adf61e73a8af0-3a08d8e27f9mr36956061637.43.1777043531369; 
 Fri, 24 Apr 2026 08:12:11 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f8f356sm18521903a12.4.2026.04.24.08.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 08:12:10 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 09/16] drm/msm: Add per-context perfcntr state
Date: Fri, 24 Apr 2026 08:10:44 -0700
Message-ID: <20260424151140.104093-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
References: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE0NyBTYWx0ZWRfX23pyM/5iUmDL
 lPoKeLkDFAewvV4G9DVF0xGkdPjAvR+KvuZBcsQixEXnVKBofuzUxUSJzOVITTM6ClxPPh3fkkj
 ixO1GWP3Hs0O3DdHaB8aUlNdQ5ERzltIhr++crV1qTpizvSLdGHzkKyr3eXpZgsLpF3drJ4dW5i
 n77XEc1PnFQ5eT/iSrivOiuLPoA6xhWvnUhYpwD7vbwwU+/eO6cenS7ahFhhCaafg+FsGht9DbE
 0sKAB8TrUmzxcplZ4G9s4Ep6mwYzwSkfXC4+7Bec0J+W1c4o7J8UOgPcKdWrlzjd+L4jGUTpuFq
 wBJupJavRVMQjbsaqzdWMTcWOLbu8tGCJhSUzqshIQzgSNEdsEHXgPTPE6QQI5FO8Fbmi2Q9HPR
 zm6/8bhJW3jWXxPPodGZsftu0AaHGFtPfP4zlsw5z4FoLsPafoXZXJ9Qoass5wcMigtmQHIYOhf
 dxlSnULOyEwkvCDffqA==
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=69eb884d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=OtV_UDYxk2hhjaRdRjwA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: bHCPM5Am3iS2locckrReVWsBLmgGQD-s
X-Proofpoint-ORIG-GUID: bHCPM5Am3iS2locckrReVWsBLmgGQD-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240147
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
2.53.0

