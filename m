Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82BBCD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD7C10EE52;
	Wed,  6 May 2026 17:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fGYgwlgH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hI7xFa8l";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D3F010EE50
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:12:05 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646EJYQg2427920
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 17:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z+T7DF6d3yj
 uRFH4Z9NZjry6qzE7sW/NwEF2nzuN/uA=; b=fGYgwlgHu8M6zy37qKRjo7HNpRk
 aHr4OyhlJBEgpMbEvAZG2O3D9ECWnIhJ5LOgQBhcde3MFYtrV6VcpNPnyjnedE6Z
 F721tO1VaaF4aUHASVSmuZ+c8FaJ1CEaaiIG+mbI0gCsWQey+C/nprsfpsncJs6m
 9tUjp7FpJWwpQGTlN7ByoW4KxQgwxg0ersdqdPwboe4wS06KBlXWW4B4J7ebVrPY
 AHij2hWX6EWhw+77jrmYhXdCTwopMJO0MEdaVTc6YDC8/UZ97GdgvoxF1lTv2oeU
 OZDJ66bxwu2+8DogI3sMrX1uvLRXz7i8Vq6LSC+xNh+glRaPhf0ABnQ9TVA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e01ph25ve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:12:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c81086bf930so622986a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778087523; x=1778692323;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+T7DF6d3yjuRFH4Z9NZjry6qzE7sW/NwEF2nzuN/uA=;
 b=hI7xFa8lOLwSv9pVRgTEccLB2Sdyl1WxpWPXQpkfcdlHDBtowsnKSTfGXQ9DWg+KBR
 3KQ2uKuBdttG6pTznEuu6yB21n0ML2nh03mi1iSG06COgd0KPH2RI9/KPNJIkrgmSkjq
 8Ik0iYay0kQBBC0PLVzVV1oidYO9XPG3/6PSbbI1WAcZYHQpTNTHN7n2epgGZttbWkyZ
 oXnx0MavkJpIWgBM54ks2qUNApEWmLJeS/zlkH+vQJWtSPqmCoId2Sgvz1cfdHaGKWtT
 E25i0tNA2ysh7jVanCLCApX7a/nksjHOa+ry1LybgQrHhxwlcrvt1uRhnXpuZN8T+Vn6
 sD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087523; x=1778692323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z+T7DF6d3yjuRFH4Z9NZjry6qzE7sW/NwEF2nzuN/uA=;
 b=LgrP6qFx/cKbhwzN5tKxCng9bL4C18r6hwtignz6pv77g2lQZZDF3ADH7NLMNHkK9d
 PenrIAMJB+MMJFWasX3vAaIFFX2M473mBFI92KnZwLiN/G6VdT0C7hDcRJU3wohucR1r
 AFTImKt5KjZCdhaHE+vEpe/PlcTpOI7cItu3QK2gz5c4DPRnGW1LgOmxicuTks2l9pSi
 uEXyEbs4r1uzsLFvkgNyw5mRUA0KIZ7JmRZx7bMJ1aiIeMF+9RyiuOu7G/t7JQ2SUdU7
 sr0UzNSptmMVdo+1VyXQz1dGJZ5joeUQPFkyjGBF2fhpevufx9Lp9FzcUT1zqjSHYjgL
 2msg==
X-Gm-Message-State: AOJu0YyPv01EUcwrm4qq/UWT8Iwc/1uqRjtGUYIcRJADzr6cOT9Ff5e/
 nP17KeDytMguyb/s0ELCt4kC5JHOrKFXK3Suuc5pGOyyubbh8M2JlphEXG2jTNFqPBdGzxkSFnS
 bvlUDorkuvPjz4HNsBb7kM5eHAuKMfb1ZknF9DzUMPfCoARddluFMyCEFsDroGFZ4ufTE33xazF
 OzQgs=
X-Gm-Gg: AeBDieuI7POHF/GxpgjYm/haE0ap1Qa41KnHSzottYhnwgoZzXCjShcPEuseMCQRVFF
 l3kDRfDHHWNSMaGH7/PchJvnhpjW2KSy6YDb2yAV/w97LXbK6zh6/HIXhx3H/IbdjGlpHIu4Q6M
 nhUBRXPsyZT3li2w13QsLwrKfgKU97RaUlMMCHbnV+KJIbTReNT+yU9J/GmZDojch/XXUT9Lxfl
 fzxxiUcgcApvI8F9dnSU3jIEz+znCN0FCOSdo/YILBqnU7UOSkqXDJ/R9m0auPLcwnUJCN3AJCb
 kAyBRMIfxCvPwXFwzDUKWCL5uROgyStjUvdQ/LMx7z69bvp+Aibuy8Ky3Fr5PyOHKOuznYwXgFj
 fc/2MLtkk/Wn4W08CgC+P/XONXRO+r2dUG8JiGkY8wug=
X-Received: by 2002:a05:6a20:2588:b0:3a2:e26b:295c with SMTP id
 adf61e73a8af0-3aa5a1eef35mr3888839637.18.1778087523247; 
 Wed, 06 May 2026 10:12:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:2588:b0:3a2:e26b:295c with SMTP id
 adf61e73a8af0-3aa5a1eef35mr3888795637.18.1778087522709; 
 Wed, 06 May 2026 10:12:02 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8396563f11csm7592511b3a.3.2026.05.06.10.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:12:02 -0700 (PDT)
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
Subject: [PATCH v4 09/16] drm/msm: Add per-context perfcntr state
Date: Wed,  6 May 2026 10:10:33 -0700
Message-ID: <20260506171127.133572-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
References: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OCBTYWx0ZWRfX1TU47DLzyo+r
 Wcjl6Fh8XE8KM8QUN+jBM49POzG4bzuiMkBRqjWb9lA2Yp6EfjwUADzyBmjp7/U1jOCLDlDd/16
 8LIM1KW9E2N0IgF4/KHROEFsUVJYz4UrlSvM5qCJiSV7dveSFmPWixcxrHAGdzSmQ5V2mGP2GXe
 zTjCMrQMwnlePDcGm/eE0WZSYQ3QjNS+w9Ln56WTxK90iB2sNTecr7eIJTFk26OUKzIAU3chUJ6
 Katd3Isndf0M8rGFkpAvVRu8+vozn9EVUeUec/FXtASnzzoFHoc4SyoISSY3jEJpcRdOa2kYLWS
 v7qPp0jFL0aRUQhxxrnqJusNVCFnURa9BbZHeASenR5XzCoHSmhmjDdtvgFNPdme63mnm6cwC0X
 /uSDadCErd+BbDF5CTE8jXqIswv0Hsj1l7iDRxSLbgWNNove9fSTndPZpgLkIPe+dIIJCLlbm4m
 AYN+7zFH4vgcloqaHoQ==
X-Proofpoint-GUID: Y-4_aMw8PWTP0eLkirqa0xCSqsAen9md
X-Proofpoint-ORIG-GUID: Y-4_aMw8PWTP0eLkirqa0xCSqsAen9md
X-Authority-Analysis: v=2.4 cv=MYhcfZ/f c=1 sm=1 tr=0 ts=69fb7664 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=OtV_UDYxk2hhjaRdRjwA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060168
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
2.54.0

