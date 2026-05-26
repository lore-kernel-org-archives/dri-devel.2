Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0260CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E1F710E6C1;
	Tue, 26 May 2026 14:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZvnzSAmC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XW7jXuZ0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9786D10E6DF
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:15 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QCsW6E2496588
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eGbs2wuIzx4
 oRW315cfu7taJ31oBbt57nbm+n+nx9q8=; b=ZvnzSAmCvS9f1iVT1P+Yu9uIfh4
 R/9ljsXmBH+9d5QcRlel38W6uDA+k7kPJKfJTR5gsOBMR6wv3cSG7x9NbnSahi2u
 Wb/1EaPlGppMBKkQYkU4kbzg7JOXsG4Pojr60M0NwrEYlI+DQev1X4a76rNzXXwN
 cObj7IKn+V1UWhhjc8xa0gHeps7Aqr4ojHq86cXZnRVrnY9GAr+q9dJ3qi4Bs1Wn
 DAfn4ieSuRuTKFu5zaGwFoSsPZ8Ge1SgcHxoXdK/bmp1RPdxF1UxFfjf/fOrTisq
 y3BFyqcfHWYqwbO2kdyqw6EEittXYIk6Wq8Uiyns7944epFy8QmUFdI9sug==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpyqmyc1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ba115ab6bbso116555525ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779807254; x=1780412054;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGbs2wuIzx4oRW315cfu7taJ31oBbt57nbm+n+nx9q8=;
 b=XW7jXuZ0DrEDrdQBtJu9Tf6FT9xfME5cs2Z551FhqfhRlIi+l2otcA8C/YdU7dEgc6
 YHBnrl1QEINz3u+6a97vl82MMYjHYLH8W3mtAC8HUMUc8ATScb/zmyskE2XWRUEHQ34R
 gxFX0H7SxYkRsPMcwZzAQb3lwhtdJD9gTup0H1yMZmTY5MswveqSIGZOYEjkti8TXjxQ
 kJXEyM3Q0aym4hY52/+kIRFQUZHpTYoxzr+L3YGCb7s/E5JkWZFHyedjGjHaxbChg6mY
 MfZH8cWUqvGvXr3Nia8EkDmn4AI9zosv0DksP7hE9oAV2heTD8bpJdoPokr77ZX8Ltf1
 JCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807254; x=1780412054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eGbs2wuIzx4oRW315cfu7taJ31oBbt57nbm+n+nx9q8=;
 b=gHOnGDG9Kvm69hUOT7VzZicjcRMWtTGaUnUJEzzSQSpdY0HKb+yH6zeSKtJwkDmbq3
 JDR10eQjUB3iu6ZkYVGqw5Sz08Ogm7sF64tvfN1IACA0Qp1EqTHVdJY28B/aPWve/ogI
 PhNkknQFXzX7IDXWqtCAjjIikk6lRCYhoQf0BG83pqWJ5Cu+dkIBNq50yT39F1XN9eaZ
 0nZyccaIVMnBi2qpJBOjyDP2Epg76Kj4mK8XoudqQqagNDYfFKyFPfenyYWskv5Y6Nfc
 9OHB8vENlpcIlaxG7Cpm4u7JgTha1qp7fe5lKInbV4YYVbKkYAf+hJiyCSJ6dGhWeB8Q
 KGtA==
X-Gm-Message-State: AOJu0Yyl5bVb0XTegNCJKkInG+fOU2TSgAAf9bg6Hy2Zlm5gFJ2Trrkd
 nP2oMUljEFM0Af83EbYhXWNRZdSF5iUCVkBrcGJmYmnFd/3Fi1bXPOg748tTORgXfM3al8JLp5d
 Go00EhrRSmsS+iw/dKHSmpiuY3NG1kUHk81MX3Rh6fjM81+2Qea1cMSl06tXuNVqMBrdCSPOuY0
 n4tls=
X-Gm-Gg: Acq92OEWCvyvvs1MV6qQJKYyY0va6keEPrqrAwDm0293n2xgdC1vuYR9uKbKRgQdhYV
 YzGj4T+8a89UaAQj68JVXIOfTMMWRH4n3YZ+ezfzI5+qfvrFX62Yxp4VBPg1AiWie20Yk3DtBtX
 ajnDzpHkKGPzE8td6oD/SeNfjqZRi36LWkfgmgdZPRa4GXyzNK9xGHwbLAsk9xgsn4A4/9CjFq2
 3w89xh5F/0xCCW3yaMGSOz+y89EJaRReFiHbN75Td1wsiSIdbkI5vx3oGVJwpDtIw/UGcHwSRyK
 thvuIdkJbiQfM+8VPQjZ5E5p0a6ktvWSi0jjGzeo3VA+DYBtULRxRwmrSSQCy39I/7ebNEXr0Rb
 VOCqxFW3nxPWaNoMkFpZ8jA6PVhgGKvdR
X-Received: by 2002:a17:903:1a70:b0:2ba:73c4:4a77 with SMTP id
 d9443c01a7336-2beb06bdce0mr214471255ad.9.1779807254358; 
 Tue, 26 May 2026 07:54:14 -0700 (PDT)
X-Received: by 2002:a17:903:1a70:b0:2ba:73c4:4a77 with SMTP id
 d9443c01a7336-2beb06bdce0mr214470685ad.9.1779807253823; 
 Tue, 26 May 2026 07:54:13 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695b83sm117891735ad.9.2026.05.26.07.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:54:13 -0700 (PDT)
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
Subject: [PATCH v10 09/16] drm/msm: Add per-context perfcntr state
Date: Tue, 26 May 2026 07:50:43 -0700
Message-ID: <20260526145137.160554-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
References: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a15b417 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=OtV_UDYxk2hhjaRdRjwA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: jYdGonxGaD3ciCAN4cOA5FM1J7gIkr3X
X-Proofpoint-ORIG-GUID: jYdGonxGaD3ciCAN4cOA5FM1J7gIkr3X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfX4o5YS+nD4XPw
 HEiHX4aCdmdRmMkrVVKo/PtxHm1Typf7R8L1QzRBPk6hhNIiM51n4bKRd93nq4IHYS/G3bNvdWr
 XbW2i+YwO2/xhmQh9N6JzbhIpMW9NRO4T08cD2V9D+HZ9J0zH2LowmRjfMfT/E9g6mLoRx76qLK
 chI+zg1L9PUOCvIHWSpgVxsz6wIEApgD5MxqAyl0DZzsK9oANLSP1ehdMNuXTK3EogQQReuzeyW
 XLJekZoG37sCdmR/8q5VmILjgdyDKeTCcxBRZTTxh9RHgw02KeLcqJwUHDB+U+ysKEt/GhH1btF
 LDj/+UCbvQ45+tkVM9wNE4V0+4OkK6S2l/PT1SGsdZ7iQeKPQFtP3TvxjJNPz1n189ILIRjG4v9
 gEcRNaXe3hWUO67+qPlYyLBHafrakYaxY91v+OJUIYWTy7J0/F3PDmp1MCCqYkYM2mAT/aTzOzx
 diByfEqrVJksoYa0uLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260127
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
index 8b0d627b2779..d73f1ad9039d 100644
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

