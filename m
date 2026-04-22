Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3374CF9B5F6
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 922C010E996;
	Wed, 22 Apr 2026 09:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+1nmx6A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XBw2cpjD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D728E10E996
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:24:26 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M96EcB664100
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TZq/rLCuYKP
 zZ+3bFaDBlw4HhmEskTpGrvorY5Ef4Mg=; b=g+1nmx6A68Kw61XVmfG9ABrU1W8
 rp7KU2ny4le52S59Qf2jKYO62ceWjGzm8r79c1h1bfzQ6JEtX71qjyYEIjtaF0KN
 2RPaO02LOc4on1B4n2ZVTc/kNiKpJMBXkmuyU2Slcjg06wDWNfCjHi5tBJyB8sQR
 aV4mePJhFj0M5eolaaK1dGs3TYhxVt6E5jPJciDa3n7Ferkyc7SfneC+0gOr3TM2
 I1+hR7uZdFnVEVfGGVBVKyrdmgnqFeNj5cQ1Q+ojGqf4e9iruPkPAEVNf1+GNTrd
 rGTwhQhY0/cDBWCHBRKhaVuvHDvW1H2vbD7aMkxzTLgwlSHyGLqW9uIUsLA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpudgr349-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:24:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c76bfd7b9cdso2128044a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776849866; x=1777454666;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZq/rLCuYKPzZ+3bFaDBlw4HhmEskTpGrvorY5Ef4Mg=;
 b=XBw2cpjD1uKN3c+6pket1ZSGssuaWt47s1xnRPmPV3ROpadtwMIVyOu4sX7aRU8u4z
 b76c3B+7pllW4mB+Hz5HbH6Me77Wr6bbFYmnd/ht76TyqpLrLLtfBXE0/XLQ5b/vfJO7
 D3LWAakVrCcFJsTZi89cgsTICpP4qrRNcaveiWST7J/kn+mUMYjG1rDGXLeiuC5JRNCF
 yPSUbUBCmY8NQ5sp8StTigRyofG1S/Yw44pA1mC/UgQiKHm0LqqvRNPutTWx+976Jxf5
 DfEAx8ErlhHzngHYURHnkcuvwFQ0Qt2C68ApdklTH/4ARW+0pErPcUdUCwJN4H0BIwhN
 XNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776849866; x=1777454666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TZq/rLCuYKPzZ+3bFaDBlw4HhmEskTpGrvorY5Ef4Mg=;
 b=erRqppjxaam/kyKtwfe8qVns2NdVuGAQG3tFL4vinF8zSLzwbuna1fI5na67Mythxi
 kokjERw2MXS6GPte1WDrxX+T+CU9BFKQToBXqrpvShl+ojUuRecBajgFiYNSJfEbeunO
 5xd3+1/FEyXq/+Fe7JGETpaVv6JtH0jMdG9PGoc4JcjR1Ps1lx/I74iIo72T59UA0jBR
 r+FegTimAMYgIV4I02wBx95y9uUT9jnR2S8P1TQfHTH9xOtIXbNOcEhumPiV9oYPbokc
 /N37yjCjFKtVuCu1GYoKYqFCZpxHw8a2BYUG4hmQ3M+Py0/txoZqVrlokkFfrAInrO6g
 ZD/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ98bs4OSUozaOakbP3MIDl2Pc/lA7EObAampMrUux/G1gmde6Rs4D8weSUYTXZlTbglyxdFbawcYcw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8aPU9mx2wXhPyToflyTSTSaKl+O9KLurDb48GY/zI0yaSUqQp
 Uk7jE+r1MxtbVHbjO8cyT394sZmzH5uOHn7ZoL9ESlaB5qrkG+dNuP8qHl6dKhd/oDXQbpXY1PN
 0RZKl73ytrSA5KkWQy0hLopEiCeo5AQMmIy3n3GV2GW1hGqLH/eT+k6RMEmHdP4cW2v/Mxds=
X-Gm-Gg: AeBDieurEztuEZuKe0dG3Z0amBMve4AoJltYzBCYOcMcxZ9daInP5W0LJn+hSeE8iSS
 2v7of/F5g9DfK79OKVzHWIkj0juV3IFD3uucLT2vBq4MJhpXdSeErcNPocBd5Hes41SMdknDAk1
 NDY/GH4qfA0BW7VleRRFRAsnKWYhx+YRQcYBeHPIihpmn3abSipgSwIM4XAXNui4W1j/aT5xOPv
 FImWlUuLmP7A4w55irZB/622Y1/6UotidXWHlQwupijwaOtuxs3QRGXQUsPetdpsIBUb8WOziCc
 Fj8lNir8iiRZzXqfTfZ/YyYOTHGnMmFP8+ZCZqgjhmwm194TGQKYQQqvf/rcU2yjGKLVRwstcgw
 gNnXEWU6nL7pZRYlxQrzGdUCAGDyxBYUKYrXmNwjfHjxALfQ0l8uCSDlXKvSZNTU5
X-Received: by 2002:a05:6300:218a:b0:398:7357:bb81 with SMTP id
 adf61e73a8af0-3a08d748eb8mr23344912637.15.1776849865609; 
 Wed, 22 Apr 2026 02:24:25 -0700 (PDT)
X-Received: by 2002:a05:6300:218a:b0:398:7357:bb81 with SMTP id
 adf61e73a8af0-3a08d748eb8mr23344874637.15.1776849865055; 
 Wed, 22 Apr 2026 02:24:25 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebb38ddsm15778576b3a.34.2026.04.22.02.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 02:24:24 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: [PATCH v9 2/4] misc: fastrpc: Replace hardcoded ctxid mask with
 GENMASK
Date: Wed, 22 Apr 2026 14:54:07 +0530
Message-Id: <20260422092409.4107093-3-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com>
References: <20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fu3Ox3tFepirj7biORI9FU-OVZS0D70B
X-Authority-Analysis: v=2.4 cv=c5ibhx9l c=1 sm=1 tr=0 ts=69e893ca cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=HL6mAI18knL3XnPGOeUA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: fu3Ox3tFepirj7biORI9FU-OVZS0D70B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA4NCBTYWx0ZWRfX3DrM19xyuRCl
 17YXDnp+j+XN9JNZLcmWhZnApIKQPRK3Dcb5lqwB12HdQD6usoZsPYMRBaVS0fbCO3L5YoGjEF2
 LlfaeXHPj6UZljpXrVo1+VlW3q8SWHcGj6/q/7cEVUGO1OZ79irhNGBN2huqWfzss4Em3Yr1gFU
 AfQ0uU580SuY4a+BepZMDyy58g/RXAwexP2ngPLgDkZD+C8aHADpPRpMiZoVHfIHoMXWlDd3jDW
 eDVnr7EsLsYMpaT9duHmziHzLK4id4cfUScAKy6xyTC6uMzovD09kbyPUoDg2N6dp+uxLXmdYJc
 gzk4KCKlfF+SGk1bIwJUsf2baS7ChKcwdOscshllXwzPehlGXMcBsysPaJHvoX++Fzru15HgvHk
 piqw/Y0ZEPs6sKkgJaj3GkY88irbKSIZQNlmJ+b4mhviSO5LH6oM4mg/EcT+RZReLueiby/UGj6
 iQHf80PGF7oDNS9Jfng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220084
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

