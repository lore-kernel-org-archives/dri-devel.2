Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48080CD5BB4
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 17:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088DB10F6F7;
	Fri, 22 May 2026 17:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QnQGSMjr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HoVSAerJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B971610F6E1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MC1ubX779268
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zUQTW5zoVnU
 p4nHccZutj+SQwGrJIr4wWIwttwIdYe4=; b=QnQGSMjr7L+VN214WZP6OnmkLWm
 KN73OQYNju3bGyQueFhrZrJ343ivwCF544ftjoOlvHDVC9cTqKBbFEOIwUdwtFp0
 DgFNngDqFixIdhx0CXR4FCoZ5a70PgP44K/z4V71+U2qKoX0Dou02dlzRnt/mOQe
 kEQMqy6fvDXfwswRgJqAUPRUEm9HxiUzzXGBl9nRfORcBpjNRNo46/T/Cn24lSgw
 oRzVRgbWLW7ab6jnurCP/YsisnuTMWC/O0yUaXUw1ETxljlKuN2B4BM+H5AJeu69
 Qi88ArG2EXh1x76B4Htd27osWPjWl833gf6wfvS2NanvVnoMyuiiA3fjI0w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7auy11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8281d4cef8so3522467a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779471292; x=1780076092;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUQTW5zoVnUp4nHccZutj+SQwGrJIr4wWIwttwIdYe4=;
 b=HoVSAerJ2lubPBnnW7AI4sSBQ2DIzVlOBHRTV9ZBQf91EPs0GPQnHP58xWBCA5ML4h
 84vcb6Vpa7pDJJkK4vjyaW+WChB1urfMkdOQjRLqFS51ixYmUDvWXx/z3u5qxtE1J/o7
 5WrsTRJfCYUUNPrrSjrNQDRUpG9mUt4CuJeWPOR2ciaHIXl0288JgKdRa9QZWCzmNuwi
 dBvfIo8q+q0ll7UKCZx9WPLOPKnKild4muFVn7rQRdB3WQSGKT+X8zBxL7sW6ZRq0S+G
 l6RjGWT0oVe/p0b/d2XWrxtupi+tWk2ll1yiNKMx8hwZjComwLjKYQ0NwliVlFbygeuH
 qYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779471292; x=1780076092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zUQTW5zoVnUp4nHccZutj+SQwGrJIr4wWIwttwIdYe4=;
 b=Gb+tii3Ct3I8fZAFdBeP2Zld7uisO4XWmzJZgMKFrXIkTSptOIKttABRyIURtO16a2
 1iRd9glUQbSjydt3PP18TT28hirjVOAkT/wM/DMUC23ltAcasfUM08Lu7Dp8ylUSAs9K
 KtMyq3nxA1ylmwa1tR/7JUQapm//48+VcH6m5tjHMqiHkiuvGED1EQpRcNYXK/lwjf74
 Te2A1+WsdL7d8pcNUUnsgR7Ha9ODvy3EA6+8YhMZZorysEUbsjHDEzTqw3LSz5UPlo1I
 kB+yy+2XfbIocIKG3IDVmAyfRMIM1AQcg7L+/bExbrGaibKz1b9REq3IdAx2SUL86Dx6
 +qfg==
X-Gm-Message-State: AOJu0YykazUxI2dINs4Dvu+3ubud+5Y5cbXmS083ugrQmNo8f3DMJiFM
 6gpQk16ZNYX//+UXb6mSp9vKKjKgRKBTnyc/Nr4YpyvkZSMoy23DaBBN17tmPhoT6z4s3b6kbC8
 ht/OoCfP2/SYLzqBmqaCFeFf9a3/GLO6n9evWsq0KMdN9+cKldUCIGT9Jfm6HikWQ+JuG8tKVqp
 eZh6o=
X-Gm-Gg: Acq92OGEY3BRsCHJDO7fc1zEiW1wshF/S01p1TWvawnpr0Wv0MPAkEEjoCRp+LiIaOX
 wU3hm0SRT97f9SV4NLu3rliRID8U7HuNgHAESjBaNrz/lI9Bz/85bi+9z3thHtX92crSHEWgCCV
 FK+SAkFvFQnZAG7zLaXBexwqg2JJrdvuVkMeP13oO8JNxu1A/Jokl869ZncJsgW/5tWcMgCFVIH
 e5LCKPRAM6sRVqJdMBSXnXwvIo42sF1loG2Ugik4LgA+XjbBlDdVJioeMDItq+qTDKOfLGVlWtf
 dA0GfB6BYSpDQS6m+bTAM8Xf/JjH05OUojl+iXJJ8ucLRL/ojYlZEBilXyVn9VzIAnmnXpStUmk
 KHNoXYZCL2zFCBr6c3ScxcOUhqK1FwcvYdLvMCLAaR9s=
X-Received: by 2002:a05:6a21:a97:b0:3b3:258f:7a1 with SMTP id
 adf61e73a8af0-3b328ca420dmr4892475637.15.1779471292399; 
 Fri, 22 May 2026 10:34:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:a97:b0:3b3:258f:7a1 with SMTP id
 adf61e73a8af0-3b328ca420dmr4892438637.15.1779471291794; 
 Fri, 22 May 2026 10:34:51 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c852056dfb1sm1973705a12.28.2026.05.22.10.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:34:51 -0700 (PDT)
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
Subject: [PATCH v9 09/16] drm/msm: Add per-context perfcntr state
Date: Fri, 22 May 2026 10:32:55 -0700
Message-ID: <20260522173349.55491-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
References: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 55vE448lnxgOBZnDvVsJGrTCr3HzoCQK
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a1093bd cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=OtV_UDYxk2hhjaRdRjwA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 55vE448lnxgOBZnDvVsJGrTCr3HzoCQK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NSBTYWx0ZWRfXxnfe2DNoWgIa
 CB8lvPnu6CNlL6b34AwBgC2EYqhvnp0XDY/moaQgKMAs12Oo49z6toLcOpuETfTqDNnuSSmjRd0
 bam2dt2vRs/9/hwTJWU/T/iM3onktAxpvvQGbxWD52bTPe9kGGOoFIAY/QFcWBRA57I2OO8JsFp
 /K06x4lUEnQ5gVLXeSh4FRyOj0HNH3fXYk4L5umMsFLJE7JI63u3YhAuOKXrHfKO0rxykgKsjZC
 lEpwhwcS8KzOYvkHmJQnD6Tt6n9ThoYDYacWmZWyX02syJFBXjCTW4If4YSmne2GXzFkPlX7i6g
 pHS9b4dHpTgP+BxH13V9rUo7jaWi35W+ghCWR9y0m8zQL3RXdUG2Ogi4WNXItes7FOkw8AFfFA3
 wcFpucgh5XKWiYme7ndFp8DILhSwUZDbK4NB93XQERveHG5aL7tA8omgyf2eO6/sztoTsczROt5
 PizXqXzLPv2kO/d34RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220175
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

