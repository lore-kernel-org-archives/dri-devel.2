Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F32CCD3427
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC2A10E805;
	Mon,  4 May 2026 19:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QdjsyUX9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zi3qmF82";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E385410E83C
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:08:38 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644FIU8b3409245
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 19:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z+T7DF6d3yj
 uRFH4Z9NZjry6qzE7sW/NwEF2nzuN/uA=; b=QdjsyUX9GNUH6JmqK45M7BjYJ7i
 dNlw/I5Fi9YvkjszHEJtSu1cYtFk/P5MID8cZWnvmTQxGEsA0tc/XGVzebZH9zhS
 aTCD27siMCqhzIRZIt6hXJz8zP0N0BuNy9kGnVwkl4CH0vcAYvA+95x+X66IKIyP
 DVQlsPjcQ9PyCPVq4BAO4HadB+utUtir9aBQjZv1XVbSu+TE0B4XJgBGfFopbMop
 hh/awpWEJWMOYSIXY0GUNoUdx/bXO7hR59YTFC2BP0h6o4+Iu+HCS9oK8UWdAM6q
 vyxnn5++z5q4bXLP9iQn7WxVMUOcpQ7af9kk9DVTS7/w3jTTR59f/wPJFeQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxx00rwtr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 19:08:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-358df8fbd1cso5372012a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 12:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777921717; x=1778526517;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+T7DF6d3yjuRFH4Z9NZjry6qzE7sW/NwEF2nzuN/uA=;
 b=Zi3qmF82iuzwJE8K7rZAwF06wBEqxTNNtGMYr3dU5PKmIlSjUf5KqkM/LKDhfuRazL
 FDrTtylwXz9KS3WqlodPLKcvVQtYNkkcucLpVBDVYnDvthJACgGl09+R0E2y7o1gRVAj
 Xos2B9/1Xmv/xTrzz6LETPVfqcqjRf2Pr2rg2UzntqiBdDMiZU88aazOzXe/PT5JLdhf
 BgVobR3h8PYhBnbXwngJJXfwNiCjrsfimW8ksUt3OAaHhLb7wsSzjH5Ngq+FQi0XmSJ3
 5vu6Ixzq7oq8kiLbBIOV8uVngbgUIdX/5liANJmdDQ/oauU6SAKi10wDbx8ErEWHUO6u
 EE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921717; x=1778526517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z+T7DF6d3yjuRFH4Z9NZjry6qzE7sW/NwEF2nzuN/uA=;
 b=rGnIkWNeeHCHGvwYgAur3UlMBljRTsld9vl+ak/pSxaOVIbS9PmNi8xtsmBXlFOC/u
 R8FsRQI9ZM0cjwc6/+Z462+8Zx8qoAY5hU6H8T5fFA6M8IVlBc/gPBT/D1sGXjRROqDw
 GsJJvolOmRlhMC+Rfr+FuMEyMtvGNxZ9249qFQQ7uMpn6H99IXk+gXDvsZDwa8V5dX32
 PtGFnM4jnaSGp4ryf3kv1DhJWlLmiamt+S4gaJ4gR4K86FNK11lfO8S/4B8394pElgEo
 ZhsZj0vAjBRYZaKK6I6oNPf48s2yAgP68CEqMpQMUrTd+Vi6SDw4CXXitr0GYH2RnB0Y
 K20w==
X-Gm-Message-State: AOJu0YykGihA9v1FhATRkLvmMWf8I1rYl8K8vUiayKyNgqcVQM/uTQqj
 NsGfl+exi2Bq9AaUwHRNwaqpW6A7WStE1hqpEqpLW4GrKr62GlPZG7ryy9D0umuzfEYphqyjca7
 8MG3PQJy2/t0/yvD4gNo71H8fFzA3Ly4t5S4FktcSl9ypa6C+624dcX36M/BWVJnjAs+DaIbHyJ
 7NPT4=
X-Gm-Gg: AeBDiettFPd1eCcUGh1DIKKqAFRSkgPDw+AgQkNUHxMeIrDuKnP5wGayLu/JwF7Irco
 XwuhmDiIDCQZ5QS86Lk0jFB4eS+NY8HNNPosmJZROnb3uCKyffDMPfqpf+A3Mfaiuu+1WkvjOnM
 RsN5FHDEJBjlHpOs4hEjzygPOFykJYvZ6fsZuCh2Kk0NmV4qjL01guOUMgqRvJwbDkQ5Ai6ohVx
 g+izc5Pz0ZMTsAZ68DsrTyiqYAIZ5qLnhdBnevEUVIhday57SPIauALPDNyXx7ifLRq1XiiZcKx
 swRVuM/ii3NFE7f2C5mFWqZErIlbrUabGnoLdjZGtglfD0MqBFh2JOwym0WIgLI9nfveB0pDYKR
 HbOk3GT5WcVT+qP7aLzDYo2qiqBLP2VmJCtTxcsjNL30=
X-Received: by 2002:a17:90b:33ca:b0:35f:b1f3:ac12 with SMTP id
 98e67ed59e1d1-3650cd08154mr10029716a91.4.1777921716640; 
 Mon, 04 May 2026 12:08:36 -0700 (PDT)
X-Received: by 2002:a17:90b:33ca:b0:35f:b1f3:ac12 with SMTP id
 98e67ed59e1d1-3650cd08154mr10029689a91.4.1777921716094; 
 Mon, 04 May 2026 12:08:36 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf2a71bsm15455932a91.1.2026.05.04.12.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 12:08:35 -0700 (PDT)
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
Subject: [PATCH v3 09/16] drm/msm: Add per-context perfcntr state
Date: Mon,  4 May 2026 12:06:52 -0700
Message-ID: <20260504190751.61052-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
References: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=APflyhIR c=1 sm=1 tr=0 ts=69f8eeb6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=OtV_UDYxk2hhjaRdRjwA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3NSBTYWx0ZWRfX9/pzQESwpWpb
 o21OtxBI+OXSxCe+bXHgi4OPE3qGw2SJcRvaD5FWEjXqcPGuMJuM+75BwrqFOYiJetOgxedohOa
 +FRcfg0l202S8YMy1Wl9C37BHiMRSu7PxNpeH+KR4xRDDa3/Hr+xww51rVw3XXdxiJFQ+qyCQDk
 lT5tD44Bj8pFrwU4lp1oZKxiXRQhrPvfdcVtM12CtyWczJddxMJVof397uaShpc9I4yeXSliOSh
 ZQJ7PrgPmttL2XJdM2EGUrnFW1LPg4tthSJR22dGW8paoMgcE/oC8IelQw7vBWNEljQshtxPup+
 uTF43TotTU877npdyBc1eHz/J1qD80dd+QGEa+JklOkotlJsymlnZa64quS5LPkeUHiKpBwOek+
 1TYEWrCX+jbaqqRYDGQazbJjAFwU7NfHYhl+LuCGfaRiVJr/m12nJAITKCoWaJr9o7TTTUBKxRA
 OD0yWuJMhBhSKgpB6bQ==
X-Proofpoint-GUID: cirV-hA_4q-eln0SExZa6BNZd2tmLzdY
X-Proofpoint-ORIG-GUID: cirV-hA_4q-eln0SExZa6BNZd2tmLzdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040175
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

