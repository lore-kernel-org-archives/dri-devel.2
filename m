Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A0CF5A8C9
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 22:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630F010E7A3;
	Mon, 20 Apr 2026 22:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y8iu8RNi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HWLlkX3o";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B80610E796
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:24 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KKBrCO3455276
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rq5x4mE8HI2
 hklAgPtBhAPSqh8qT0+8dU3DbvHigNyY=; b=Y8iu8RNia5hjN3o+tguSqlie9fn
 lxP93xQ3Mnv9577Rte3501C9klN42eBZphXPzfHDKoM9zpRQTTNTPrUUrW6EtPaA
 61+xffS42RIr35ElWfNKk8gY0pGF4dZmSJXfMDc7Z+nbh0+fJrUnN3Hx+deCyTBD
 VulGwZX/3/7YhbnxIOjsQJ+rQfVGX2pHrO+apa+Z3gCLoJxYaZwlBuQrl/HAOhzC
 GtHvuHy1nBf6Sq8z7XLaRrVyo8tEur1FK3WqmLH3x7bkcROabXJ+vBOcHw+pdLpz
 hM3w+xOMtqEet8rrf5D6YQRJjg6w15VnplrWpkpk+RmTg8brJup1D2+k7Nw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfvjub5w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c76c2bb3149so1614602a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776724042; x=1777328842;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rq5x4mE8HI2hklAgPtBhAPSqh8qT0+8dU3DbvHigNyY=;
 b=HWLlkX3omhgrPHD4JRwoVEZqpg9rpXXMdZxMTjU9LwmHiNcpDsjm5xMg/BMKtuQpSH
 XNOvaoosfKFS3XoZXVkcdzJCyTQcAqM0tT3fpOUTTKLHp9AJu1vEHYRtBbkCe79nA4Ga
 m23dyixa05oxAhvAUMECQfII39bAIXHOrkAu24jVK/eUN5lcaXk9uqXFq2JcoYcypXO4
 PDVkguvV7NPC8WgQduuysp6I+/Yblk6FdbDr/vlm8ATsNNsBrfeqFR0VeEKv4dmKJQw5
 zpMDA6e53QdjbpxpLGjVkzG0ncfINrfTjXLrcp3JVSABdYFYSQZZ2/shxPCpHLWERBGW
 sB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776724042; x=1777328842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rq5x4mE8HI2hklAgPtBhAPSqh8qT0+8dU3DbvHigNyY=;
 b=EcelR+Z5csxzpKyr4yeWAEaXeEUfLS8exmDk/GWASjdnBxHmwWe0sNIZfeOb/QsLs1
 GDGZzCdOnrr4YvWrLgMxmmIWRrMu6qAXj+cuKkaf+RYjCWR3TOz61uSCLUGhtBwLG/dM
 07fBSkJiNi39M2zINH5jFr1VN6Pa172s+km0ONiyIw91QYkwrbbupKhftD3BsS9LyZN4
 HzCD3LnVP8MIkYPPuOEZ2MpOBrP8nAe53KcoJ5mxftW+H688+U9JFZaCDzfO+M1IQYb2
 UziFsnvWsaxu7qQFk9SsQRG0McL6SQvM28evKxlWrwcfNxio/gmPflK3FdrCtvRo2OVa
 MPpw==
X-Gm-Message-State: AOJu0YwH12wF2fItCioU+yW9q7oMVe21eowgcJFzgXqYDvzugTm9Dc4P
 8SwgZi/gl89XL89/fe3KhOJfNsr+XUJ1xk+tho9mkZZ6Jb+/lu3d/lCNKyCCJJ+cP0TxxZnGQ/0
 WvvsypCORUJsE8eWsER7NGCKo6mDsCNEGGQCFNjEbg+5txUklhj0+ksmDu2k3+Z02hgdUUJPT+d
 NQ8/s=
X-Gm-Gg: AeBDiesoiKOUV28Ln6xwkUPIfXfuWCDFaARDtwKhmMdzeraSONZ3XFxH5HUeuF8DYur
 ZJmwURTqHvfizjv61aKvVuhHQ9QnvwTz2VlNxzf5GsPcTfYYzCQYcviEmtygijmuwJ9meIEqPE4
 MuwcwcqiuUB38uX4eRKZkcp0Q9t87NQR1RcjgI5+D93hGnethFCOveq51qHdzcpSo9EbCqlH7ff
 pPpF8grdtBuPtHwanAMqrbSUZtWypfhsRGxpMfsslnwVpQXqAE+xwfWDquSUwzqW9lrLLY1/Ta7
 GXmM07Xt+7wQOj2srTU7j1d1yc2prByPi54MRsNaeYmFAdeIupmTKzrVFFuYT2tlkT8DtREYYOd
 n0YLHcZ0u+BGq9kSKxOyNVh177A1Hb6KhGyOqqBDI55U=
X-Received: by 2002:a05:6a00:a16:b0:82f:6640:7221 with SMTP id
 d2e1a72fcca58-82f8b50774cmr11467180b3a.22.1776724041741; 
 Mon, 20 Apr 2026 15:27:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:a16:b0:82f:6640:7221 with SMTP id
 d2e1a72fcca58-82f8b50774cmr11467152b3a.22.1776724041240; 
 Mon, 20 Apr 2026 15:27:21 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ec06cbfsm13746470b3a.58.2026.04.20.15.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 15:27:20 -0700 (PDT)
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
Subject: [PATCH 09/13] drm/msm: Add per-context perfcntr state
Date: Mon, 20 Apr 2026 15:25:31 -0700
Message-ID: <20260420222621.417276-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: M-Yg3eJj_8TkHQIMUmDBRkYJhE5cfa5V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIyMCBTYWx0ZWRfX6Q2onpa3sQKR
 JNKZLfyXSL3aBD5QAP+ISI6FlVM+ZnU2bjalJmAb8mtwVFA2jKVFuOBE4xUjLnG9ZI6Luh/5R/B
 NT26UQ5E7iUceCxd1EWagFWa5UOJZefXY2cvPsorb8U1ZdllLE1Lyx+gJuYFoKQQ+aBo8MoZe+t
 eCMOWLk8oHGcD6n035cA2s87OkNvFIcf2Q67zv1Cbynr2XGfQz6VyNj0ik4W9ts5sRJKx+3homf
 2Zggl8Sh9NLA8OR0wDC0A+O54ZxoRN1vomlH8QDLOTjnxaz1iqNHl8RAJL57wtMzw0OHcI2XvuT
 z4mkPqsvLFqFMFjHupKZcJJEIO+Yn0D7m00m7y1RJ+K9OT/9VzSLwe74VpiyRmrj7CT3KpkrmCs
 qyP4biEQgBepH+VKGJ1JA594qvqrBAgj9La3srCfiY72Um8rCPHxi9CWpW8aemQjAkvt1Ln+uBv
 Q8yiB48faKDpr1UrVYw==
X-Authority-Analysis: v=2.4 cv=XNMAjwhE c=1 sm=1 tr=0 ts=69e6a84a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=OtV_UDYxk2hhjaRdRjwA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: M-Yg3eJj_8TkHQIMUmDBRkYJhE5cfa5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_04,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200220
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
 drivers/gpu/drm/msm/msm_perfcntr.h    | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/msm_submitqueue.c |  1 +
 3 files changed, 24 insertions(+)

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
index 64a5d29feba1..aa932df16cf1 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.h
+++ b/drivers/gpu/drm/msm/msm_perfcntr.h
@@ -35,6 +35,24 @@ struct msm_perfcntr_group {
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

