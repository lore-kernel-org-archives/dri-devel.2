Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB7DF4198B
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A9E10E208;
	Wed, 15 Apr 2026 11:25:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KGmANgAW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NSwzsDyA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F9610E208
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FAQu8N3126853
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TZq/rLCuYKP
 zZ+3bFaDBlw4HhmEskTpGrvorY5Ef4Mg=; b=KGmANgAWlCO1gEeQJ5VVozAh+zm
 sV+Ldiunp+1ulSTCnd98Qa/7mY/LRPY0O+3WpJEuCyD6sMRGIrRJDC8AP25bMX0i
 fu4X0S+3IHTdKjfbZAI1lFaZXMo4MbTD2BEjKM8DICr1nQZF5DKWl96zijCvTaMF
 AKD3MxKtzrsRDBdRhtvU9QeJo/ld6uvfEwZQmkWZjw7PaQ5iTANg15ezs5WnO+EJ
 niUnBiQDKzuXxejSMJsKVccgINvvdA2lm6r0GfIhAUo0apWLDi4QF5GFU8px/qQE
 XT+xA7pwvmcykC/3Nvm9CR+b30UKHCdoe8Ve9uS5nuJX5IJmLYUKLAahiRA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dht56u076-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2e6ee9444so42144755ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776252344; x=1776857144;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZq/rLCuYKPzZ+3bFaDBlw4HhmEskTpGrvorY5Ef4Mg=;
 b=NSwzsDyAlLUK583yAk5yWjXSOeR15cXfklpHNGKVNRl0egdK3azhxg+Xy+CxzRKxD0
 E66Vx20h6zo9Qm0TI+jjwwUMgMhQiKlXl5tJs7HEIR6L5WcqcoVVCTYgJETn5yb/p4zd
 q8mrVsEFuHcUJteAQMVbJJUwU+KdebosCm4ftGPC4F8JsExmWgfgnnYzsA+s8IpGf9/1
 EMQ4ETlYrrZuiyytTOp4LFttw7pl991Tw0+yX0zkx3Eae/6nLT5tbttCXwEG/p1sSEl6
 Xk6dXxO1AisWAsBVnAIpVHZbJs/pX8C6TWniVZslWQ4dv6xkybRnwlJKkk6yFxHnt2zJ
 ynUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776252344; x=1776857144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TZq/rLCuYKPzZ+3bFaDBlw4HhmEskTpGrvorY5Ef4Mg=;
 b=Cd6QXKEDIasYK/r+GYMXeExSXbVzXULCrLcZcPyPywUq0QML8qpDzbtuIQ7kgTSHjq
 4YuUhryZte/7fK9Orr2K1b+3O77VzeZ352wDQoiJs8qeTQS6YIXsStl1qMA08Y3P96TK
 LtEvv3BLZTDcy+Yg4biZDhnmh1howcGNmZ4FDGH+swFpY7E3bM9p4cnyM6085GuEEJg0
 gqfWQ6/Rqp9LNSmsUW4E9RiHLZx/N9Rfr2mNK33w7WEOO5x0RvsXxh54Nx7oDah/KA+i
 E47mw3Hpjd05EWL/DHFTy+xG2fFhSJslG6aEWEohp90irmT/X0Z8amGF6vsmy1uPkcym
 xM+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ejqycHIJM0ZCxyNqwkVBGj5al0b0U20ocJjSvHmux5sKKa6nsE8DKYn7L3vaakW25kMJtsvbiO3I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpxHAgb1GW19C2WYoGARQmbSHnW/oapk7FtdxcfpMsuVpcXGeg
 iMIm0JvZl5cWMapaQw4YYEAi9s/GgKCAglYhGjX6hCAgOjZpekg8SYUS/iKhxa9mdkUzkf+PXuR
 MSaGzMT7zvj3axcw+kqpE6ALe6h0y4kqaW4RXuFlTIlsuqV3cfmf2azpMHskErvJYm+uyLqQ=
X-Gm-Gg: AeBDieumN2bjHgs51j/h11SlO0YEi/7M0m49tXoOZsky+Zo8kPeI3h5yS9NYAhzhdIs
 r2envuNJ5gXP0UHe4t0vYL7aAVolavazrEGfiTco7TX86tCT0hZ2NrU2fWGjQY+iuYBVQ6DxijF
 HQuxGogxyr8+t0LGVqWsWXVH3h3W/kZ4XGTuhmRJlEXWEOWHn/VVxxl8NllTfTZ8Jsda1FFdbv0
 ay1zk4CFjZZEe0JCkYTR44bKEhdwrR1siWbceFMkSQKRQlEL2NgNBeB6WcA/Dju6DdjotQ3joVQ
 /cN3TzWdpgztgCYuf1OT8Y8wBlNgdKOByK3i7FKIj51rVZ7uQpZAaBFfDf27bhKw9ZeYxPj1nIi
 GLyhPvFbCL7b6pn5Quv7tKEdSfVVbnLJGGpQTtzGFqIkusQoK4pWRr2j2Bblo4REc
X-Received: by 2002:a17:903:38c4:b0:2b2:4f43:b49a with SMTP id
 d9443c01a7336-2b2d5d8ab1bmr197871825ad.22.1776252344517; 
 Wed, 15 Apr 2026 04:25:44 -0700 (PDT)
X-Received: by 2002:a17:903:38c4:b0:2b2:4f43:b49a with SMTP id
 d9443c01a7336-2b2d5d8ab1bmr197871535ad.22.1776252344070; 
 Wed, 15 Apr 2026 04:25:44 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782b6fd8sm26794325ad.73.2026.04.15.04.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 04:25:43 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 andersson@kernel.org
Subject: [PATCH v8 2/4] misc: fastrpc: Replace hardcoded ctxid mask with
 GENMASK
Date: Wed, 15 Apr 2026 16:55:28 +0530
Message-Id: <20260415112530.4083240-3-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
References: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LuiiDHdc c=1 sm=1 tr=0 ts=69df75b9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=HL6mAI18knL3XnPGOeUA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwNSBTYWx0ZWRfX92zBI32FS23D
 PgGaOq0JsKykaFzvwW4exBuWYMz5A4tegRBIvJqeDK0Sq9RmudMqsm5usleGhna1LqdOGQkzmf3
 wC0d68fqeiQOZe2yXkBCh6XXJIn2xeABoj45c1pbOndLlar1+DI2ATgebLVRfkhhdubtya5+peY
 Tq5mhfbxV4rmYvDjAxBqCxO0S3urXG5PWqeK3urOCKwr+UbBQVlQ/G+KJvlUnxJQ0WJhYE4WdsJ
 EGpgY9QZ/E2GLNNytAJb7sBFSRm2Hd1lh6YA38ISC4ophpPrHndkOtpOO0+flJhVTsxTimbltAm
 /nWQrEszb+NN+Tus71zvLYzyjOk3TI4V/gc1PRLUA3eOOCDJUVJ57hY4Lba2JqITJ0F9TlDK+A1
 xJqvuIcsgYCJ15kDT/tm7laNISmm1Y4zdTzOuku4S9y6LkjbEI+yPRfg0lxmn+/Wz/TCGuUZvQV
 7UckQ85WWzD27NTPmbQ==
X-Proofpoint-ORIG-GUID: ouFf75T8aVXjLC57B75qMhF0AfrW0-z4
X-Proofpoint-GUID: ouFf75T8aVXjLC57B75qMhF0AfrW0-z4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150105
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

