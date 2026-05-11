Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92099CD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E316F10E774;
	Mon, 11 May 2026 13:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZTE/cJlk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HAnpoElJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C9E410E783
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:24 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B9O81r018654
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z+T7DF6d3yj
 uRFH4Z9NZjry6qzE7sW/NwEF2nzuN/uA=; b=ZTE/cJlkGUMWT8JTi3P6DxFacnB
 NcnREzdc0Ao++brhko7CLUfyKct7/eVDquXtlHEzXr3K15YALEtu/LduylPgJUho
 XCcsMUZX7J+JUrZChI9/ICLCH2lkreQ8I0eu/BriVdsCRuPudxgpFW6oXr9u/bkb
 vOtbIUimhNCU6p29Piqu+eV/x6fc88DPsnhaN/N/2GaXOS97X2YPkww1wO35IIDe
 CoMQGerjYUHygyVMAm931+ETwa+LWGKq7OuQEoqBEQJmXO8gQovcnjqH9YpV1NAh
 kp1wnKp8t32ZFjdZ/AHfYk8bpnsA5Wt3+Z+JaubJAF5/OT8v4JX76uIpClw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xfsssy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f7bec24fdso2519324b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778504482; x=1779109282;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+T7DF6d3yjuRFH4Z9NZjry6qzE7sW/NwEF2nzuN/uA=;
 b=HAnpoElJQQsXXe5oigyAzVouEq3jCFDHo5uCbxCA14tT/kGS2fR3v9R3q5OEMMr7p3
 H7RmhJwUXWrJrOL3y6JYTz6aS9D90exz+bIo5yrs/fh60zXBc5eu7vZ0wpfAKjVEMWEe
 WoxVjwpkr7c1y76DZJoaAEAVu/yvgZBuABFcPGVNIJmoHavec3e/fcIgJsV6M7q1D/FV
 5L5NG6wGNCOWM+AcRz0frAlt5Haj5KhDBTzvPbOSzMvlY8vuYvTMryw6etVvxbkNEzV5
 uVT26SqO7PL8HbRnB1PvnKpCHGXZWXmubZRLi/GoM94A8H1XamQnWwWWLeRAYegPz/jV
 rX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504482; x=1779109282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z+T7DF6d3yjuRFH4Z9NZjry6qzE7sW/NwEF2nzuN/uA=;
 b=aNFN12/mXSOEOSCUGBcs/n/RHek2OV/p1LIQoWsZ9+I8otSYUUROSHgh9Bwl+PbyYi
 xJb/9VjNwBMh5DgmoUeHvcZeKHMD1CqbYRSd/5UhDw4TgGExxRv8gTNtSNdsXIbjRY9E
 ngZPUvt16KSMCt1N5U+TUJ5Vwx8OvbByfKmdwR6ymn5FXHks1eDgx+OhuziwSjCGNZ6U
 AX6ab/QN7acMTwrzuUR0+F5JSDhbIPrvUc6HxEZbIqbrxo73wBSMc1dxSX2xhDwWSgyg
 1JuDGEQCHvLWLkpMh5mbN/f7k1PKBnJiDLQ2vjKLYmFBflxZ3OK7Pb54jhCmLKBpXw6l
 xKcQ==
X-Gm-Message-State: AOJu0YxNC3RnZLCiyMIr9avQF0w+Fkvny7w0/Z62t38o1lbByWa9SFyE
 BIqLPn23Rm5WJHIvadRtReZTF04qixvTGDBySi3qqN/P/rLagoO6QXjS7WI/2f1rbp76tu6oo3L
 j24qtNfjL0RzmWXlEcyP6y8gGMW4Aip1vIvbmsGRlN2KRMKBmK1SZdZgjFIIpm2wMpSTQ3OHbkf
 07oHs=
X-Gm-Gg: Acq92OFfgRxCD59+WZyWw9GONAtrioSX4cuWXyAE4aNo3q186/simffzkdntSfDKbFl
 oUoQwqDxdH0Qa92+DzwdAWvigwLh1lrDjI1nuhqz680P6+G11d6+Z3nDN+FJudCxOGhf2ihO7eq
 MUD0qUvVlFgUe73ahgwxX2Y1HMqkYD1hC5qvTHvBDgxFFw1TFXb5p8rY2t8xHvXEJQtQzZbAh4W
 iDNeDvjsurySYEguWElMwT2UE/xZB9iZJ0SAvfAzXKVJfL+Hu03c5vBaU54OQ9hlcy7NWbjKr80
 w3HUGAo+BrG+fDYPCbIQUCJJt0Oj+g1J9Eau+kgBwrIgM2P8c50jpf6D0I9ZhfcOJTIbWtWZftY
 sdeQxkfWtwAm/aGlNxu827ESZq+LYySjxSuWR7k/sUZw=
X-Received: by 2002:a05:6a00:3e0d:b0:82c:dd31:b84a with SMTP id
 d2e1a72fcca58-83a5e24a2f1mr21966304b3a.43.1778504481947; 
 Mon, 11 May 2026 06:01:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e0d:b0:82c:dd31:b84a with SMTP id
 d2e1a72fcca58-83a5e24a2f1mr21966204b3a.43.1778504481124; 
 Mon, 11 May 2026 06:01:21 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965a3e3ecsm20908324b3a.19.2026.05.11.06.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:01:20 -0700 (PDT)
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
Subject: [PATCH v5 09/16] drm/msm: Add per-context perfcntr state
Date: Mon, 11 May 2026 05:59:22 -0700
Message-ID: <20260511130017.96867-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a01d323 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=OtV_UDYxk2hhjaRdRjwA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 7nGZYvQcjqDQLJhVimJzGqNZABwhzzdz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0NCBTYWx0ZWRfX/4cBt2ftCOeT
 YCMWtUl1EhQrOFNymi8sL/ZQHsMo/pF+QOihXoEHJFUrFQJwPi0niVpHhx4Yv5M52xGJijRMVQf
 qCh/VpTgJReIuo62Ir/0SOH/rRpYH9zodpcCM2aiMpsnGLcmS+z+SJ/ppLk9u3WqyyrCJNIFRzC
 jdXLKieEvzJYoGG7yxgq4UlErCvr/E99S0Hxe2+5UCnqm692B2ikIx61V8jAqU/Q61sngqcODkc
 D0yPUIg9d5Ey8g1IiEZpciiRrOwW0qY6oLrGzQEchG0+SV4D9qIVXZLECA75sSicPIxFUOqUdKP
 fNk/6qDioWwbLCgCfJ6QK0MrIExTMdAZwKl0Oug8mPFOVODua+aH1+O/ifeBAfYoPhUYAvsiwWZ
 mVR3FKgBZKJuQ5cXhPMxR4/ugQ0idZ9w8zRC0W0Cw/EOlnnwGA+4aEFHpItEPEw2Gkj4E/ly+6W
 cKvSOOR2/B2zlGhuG0Q==
X-Proofpoint-ORIG-GUID: 7nGZYvQcjqDQLJhVimJzGqNZABwhzzdz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110144
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

