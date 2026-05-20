Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32976CD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 06:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E09B10E084;
	Wed, 20 May 2026 06:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KP0Oc6fO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GGxjHQ2y";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4E310E084
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:51:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K6b0A22143956
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JIaEBu2fXti
 OblnnO/rwwIoef8J83XO0Fyvu0X3nK9Q=; b=KP0Oc6fOQHckMwDl6aAK7+IENbO
 ipvK9YVfmudylkelSt3tGvElGMtCmLp9mievydU48ADgv0v/Dm0Cob3yv9Q0bTrT
 jdiZMckl3kyFLvFbuC1EyVPGIuP94a1yGFB/ByKkphYIo5yPURTR34kqTtIQOH7F
 TwQSAaScP2sP01UZxnjXnKtb3uXdLYAgURpGFO/j/SRlUqfeWwScnAMgVmtz2+rT
 Ynsrwmf7gIJ42966ZYFhRFFrCi9tF1aeYDrJpOkfbYHgDRfOqd1tI5j/vrKfQ5cr
 MlO+3DX9k+dBSI+gfNCpqnVWpmmzVk1LAr9id4OdBSwHK0MWirsnphgHnKg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3tkdav-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:51:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba115ab6bbso47682345ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779259862; x=1779864662;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIaEBu2fXtiOblnnO/rwwIoef8J83XO0Fyvu0X3nK9Q=;
 b=GGxjHQ2yDuGCh4Qnlc2P5qYo6KH52gY36MOCNhQiPUvy5IND6A8aigZg/MIgCGm7+b
 NVfOS6HoplsQ24m5yo0BQcFBUoql7LFbM1GrybplMlBQy0tUaY/6ZP2nWCqZj2f1LPBu
 uFISXl+vFJ4MVT15h041msodbC0aRNZobB5jN6uG+QhKhTWfNJtSCsj22FP9XyDYo+KJ
 UqOfWwlSmssdeoTM3MUoW5yl0QOk4lFtsjIxf9Oc2R6N0KJ/CxHtEh1ttQc9ft5MGxiA
 saNNikp5P33B134QuWukmwPDa9B9IEzU7/9EO9/EY5Suz2RH/Kr64cb+UvIhtA5crCir
 Uxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779259862; x=1779864662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JIaEBu2fXtiOblnnO/rwwIoef8J83XO0Fyvu0X3nK9Q=;
 b=hHlP1S2L5VYkeeMFTuHmbp1qMzMd5oXKmqnk7Bet5azp/CwiE/N32lExDFcC7OajVc
 Xc5jP2ePX8NvmkaBnU/H7QvkfOioHh3jO+hUCAFMlpkDqyz5PHda2QY4Yw6z2Qtxbw2P
 uYH6DITLY3ztH+8luGSw+M3GOg/NWq4Pj5W4MWGdN9WquPVI4rBRzlj9mq+776fH1kL/
 o6+0T6NiOc6IYUKjKri98uFCv8j60YrpwrWQcI2chr9E8hEHp3hdxPzoUbIwfErXt0jr
 EmaodEzZQ9Xiu9lZ//VxP+XGiXmpUlikqSZ7jYddIiGsQ/OeWjlD4aKBcaJj/CzGQcLp
 Ywww==
X-Forwarded-Encrypted: i=1;
 AFNElJ+G5CBVRS1fT1O/kdZX9hF3p/Dk2u8EMWcFycTIpqFHmczKXBVawshwI+NajM5mZe2ADa2p7Maq4cs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjMdAF1/QrB3f4R93PqWJt4nCI6qTjGXFje56lV9AgrTO3ysGu
 DrTrHXLbpMkDojAyiqswZ95fpaGaIlvpDGCJholnSIhQp+RIBbSCm3GkKeuUjkKiDuS1vw8PL46
 epZm7TQgyaWD5nvaEykGPNAKRzTayIIRVKT7eKsGAnpcFRHn9Ddrgjg7+VqWp8LsoFhPAur4=
X-Gm-Gg: Acq92OFcnunTX3zCpRadUsyTs5eF9PrMyI/gDj0y/XXUY/gQ3Uo5bpgpfFLguLHeEYI
 RIJ8KTiAZQuzRtlcmdpMsUtxkRHYv+mms+qLiXqFPzVtRYe+9FjRi7cw/sVpr1M2dpAk6xYuGys
 wHJcw/KfLmJVHEwD4LuZRbtNhNBs2bNjaDh37ORFVOAJcO8WkVod4iqFlSbS5vL9sN8KrFaXxbD
 D2e0bGW1i5uZYio3ns3+AafRxCL4/S5rlUOFmzUf6txhzlU5Unzw8IIugE5KXlWXIy1iu8bkICH
 t6pUuNAy1hA0hKXA9AJgB+XGKx33uLgb4vPB7jlpVl2ki2thHxS/g2XHSSHEpZQrGKQzPfIVqfU
 PeB/vYGh0LzGEuyxWD/qonCz+pBCzRDwo5XYk/PQoCs2JKtunTOgU6A==
X-Received: by 2002:a17:903:3c6b:b0:2ae:825b:49a5 with SMTP id
 d9443c01a7336-2bd7e415675mr232877135ad.0.1779259862409; 
 Tue, 19 May 2026 23:51:02 -0700 (PDT)
X-Received: by 2002:a17:903:3c6b:b0:2ae:825b:49a5 with SMTP id
 d9443c01a7336-2bd7e415675mr232876855ad.0.1779259861917; 
 Tue, 19 May 2026 23:51:01 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5fe51sm206410165ad.2.2026.05.19.23.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 23:51:01 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v11 2/4] misc: fastrpc: Replace hardcoded ctxid mask with
 GENMASK
Date: Wed, 20 May 2026 12:20:45 +0530
Message-Id: <20260520065047.3415790-3-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520065047.3415790-1-ekansh.gupta@oss.qualcomm.com>
References: <20260520065047.3415790-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=feCdDUQF c=1 sm=1 tr=0 ts=6a0d59d7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=HL6mAI18knL3XnPGOeUA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: osP8FA3tTjybInittpRUICpq2Vqn0uJ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2MyBTYWx0ZWRfX15WAVTondry/
 ZbQNvlc+nzTV38QPZzxXl5RFkaunsnD2wYy7G5fQFLEZK1D6uUNd9JQkt0nm/EMJ1zeg0tc4gnM
 Fajr1nuInFvJLqFqiun7ei0fPosoCJeUhOY886+GdfEblO3ccOKCMiCUrxN4oEbdHc9RFAACV4r
 MgLLz+y6MS7wvLkFtXL2Roxa4GSKI9xiHIdcjK0xAfWcT/jxsRFp8bn5Dg6s3Kg1OTXmtzTOsfJ
 q4xfdPx+V0glusShUwveqXPEjpdJTOqdc72DREN2htfAPfWf0WanXx2OzzR1hqP5fwkuAPifish
 ouQbcq/80VyP0W5Vj1PZ5/uS1oP1VHEY94rfexC5+J5YzQIxV0hII4t3A/7tWpXQtnxCfP4Z7yX
 dITTM02liJx05d6DHk9S92IauXFrzTUHUpsoEUmYIiQcK6BzaHpFgzkbYwS1PUImPHTxeJgUrKV
 BJeHI1ORAkrRb+yILIg==
X-Proofpoint-GUID: osP8FA3tTjybInittpRUICpq2Vqn0uJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200063
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

Replace the hardcoded context ID mask (0xFF0) with GENMASK(11, 4) to
improve readability and follow kernel bitfield conventions. Use
FIELD_PREP and FIELD_GET instead of manual shifts for setting and
extracting ctxid values.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a9f507a88c67..3f5d5d73be5a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -23,6 +23,7 @@
 #include <uapi/misc/fastrpc.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/bits.h>
+#include <linux/bitops.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -37,7 +38,7 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
-#define FASTRPC_CTXID_MASK (0xFF0)
+#define FASTRPC_CTXID_MASK GENMASK(11, 4)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
@@ -515,7 +516,7 @@ static void fastrpc_context_free(struct kref *ref)
 		fastrpc_buf_free(ctx->buf);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
+	idr_remove(&cctx->ctx_idr, FIELD_GET(FASTRPC_CTXID_MASK, ctx->ctxid));
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kfree(ctx->maps);
@@ -649,7 +650,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 		spin_unlock_irqrestore(&cctx->lock, flags);
 		goto err_idr;
 	}
-	ctx->ctxid = ret << 4;
+	ctx->ctxid = FIELD_PREP(FASTRPC_CTXID_MASK, ret);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kref_init(&ctx->refcount);
@@ -2508,7 +2509,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
-	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
+	ctxid = FIELD_GET(FASTRPC_CTXID_MASK, rsp->ctx);
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	ctx = idr_find(&cctx->ctx_idr, ctxid);
-- 
2.34.1

