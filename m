Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D551FE51FC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD76B10F4A7;
	Fri, 24 Apr 2026 09:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FQ2e6FWR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PPUb7Q4V";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D8B110F4A7
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:59:20 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O9HKxq518371
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JIaEBu2fXti
 OblnnO/rwwIoef8J83XO0Fyvu0X3nK9Q=; b=FQ2e6FWRljlMUNbVPh4e9UcRVw2
 nb+bAB7ZnDazynDz1UA9VQLn4jewRB2iDOyqxkpIyJu/k8WKKn36Wtr/VdL1GV/+
 ZItwReRkaBA83DiIRFM1SZzHX6lBiL8qV+gNyqxHtfh8IwrXPSDAaKEN4hSlGq8t
 dzxl2fD4dRli9oTon7uHxVkwHPgWzbgQaS+k1GuQBxUv8vqSmdL74Qup7H3YO6RB
 npw+A2j9najKyOX6jSjPfwnm110QYUm7MY4p8MJwtR1Mp6s1d8+3Pk36+dmGZDwp
 mMElfAtvCagGnPmoWw+5BiEESyCg6kyVC1c8NEgNSpZDWTg73jxsdd+tdcg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr0fnhfq9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:59:20 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82fa7c6699fso7947964b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777024759; x=1777629559;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIaEBu2fXtiOblnnO/rwwIoef8J83XO0Fyvu0X3nK9Q=;
 b=PPUb7Q4VYpcoWSWXAeSzT4G8ymGyeSLTSSw4l4X3YC9yRWdaTAdW6fFSm84Ky27GJU
 5sU//1uJ1+7+5k1gt7J3B3oUsPcM9uIk7lgLiARr9/F3YodXZNpH+yGgjXqGCLIejrpG
 Yo9ays2xJ5/MnKAto+aDQXIX5FcyZq2qICdZD3cgmlxAMc8Ba9cmbzbRilI0WwJQGbzG
 HUlNd+JreXI1XinIPg9BazFGv1NaqBH4LqD6DIE7SCd9Xzf6IKUqw0z6c+/S/3Bh1IBj
 dL+PZsG529zhFFuSWbFhJ40r2h8162xGr66XKAWPjR6KRHN0Ee35+P1bXxk0atTyST01
 +RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777024759; x=1777629559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JIaEBu2fXtiOblnnO/rwwIoef8J83XO0Fyvu0X3nK9Q=;
 b=Fgp0lXvYuvrR046FzJs/gpqF8n8JHV4klN/5oN5dyOsQUV3rxhCPNVpRp5lkx8iZ6g
 cxeNQy65c7lhbs795Yq1HaF8iQPLits2tFNFAZfHScIa1ytbhIhMYDkgK5Lf7OA4kVVv
 tmuxyX4+RV5pCdzDenVn0+09gWvlQpnJS5Q2X6GUDUb8k+n352eO1UofEaazTcJQpOxX
 6HovrZWmsdiPB/64shzAiPlwwpabZCa+iAMt955rtB9e/jHWKzJA6yUXgm3jWbTOCyUI
 3TsxHm24uIl+we+BoeAlJsB5QWJysLKESmvpQFtxASxfKrezpt+rj9f5+fpP7lR+BQXP
 1Evg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OabQ3uQQfSKMawLkXvnN0ZHGws7xp4XICBNiQMtbnonvZRp/CZIhQq9DNhIag729DECULwD7b7BE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdILhUsPj+EvS2ss7ItPAJAxTnXHRmfeiVsXi+h1BXK9lgDgwf
 CdWFKhzAoMUu0o/gycxiNeoOSeDRtnYdxmijCZy7Wz0Dkoq8ed4obEgo+I6NVQru9oxzdrRY4KY
 J957JKigcH4bb9qs8KfiT1K0gIK2vpkcID2s7AIdnz70QBV4JzWTpukUmS2HQ/KcYWa+s6pE=
X-Gm-Gg: AeBDiesJLiiCkgbTX3xONyXICCbmDJOKXWzt+qFAYGyBeR4rxRgtJtFVU4V5pm8+SVz
 +99wDejs4DnPfwH6kh/Byj8OB+TwWTSYVbWK4xkaK70VGIzoYzlpuPbFQO200RdXDXQdEZ32nCv
 +9+eeFc7kUz9ly+nOtgq8tHzpGCGr4H1CsPsXKoEOoKVt1sFdIw2rySVubcAbKxRM3kTzShyU+r
 stnP6S9uCXImexuoM0mNsvcy62OL8w7UL+kPf4c9kmK07go1Rorvrxpxoaxa+ZABGfv1KnnQRmm
 s4Xj3EDLQAtrPmlDc+LBZTXc0/zoEr4yLDa/VLPfMl+4/UWsWIuY/8m9aamoT6hANlcmICLax5z
 aRax/jvuvgTKEeG4dXY9rAkWt3xVh3R277/BIJpkLOB/pUvZmGn06KGrst2Lc1RA/
X-Received: by 2002:a05:6a00:3498:b0:82f:4566:bbdf with SMTP id
 d2e1a72fcca58-82f8c862662mr32861534b3a.14.1777024759368; 
 Fri, 24 Apr 2026 02:59:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:3498:b0:82f:4566:bbdf with SMTP id
 d2e1a72fcca58-82f8c862662mr32861517b3a.14.1777024758896; 
 Fri, 24 Apr 2026 02:59:18 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9d35acsm23679702b3a.15.2026.04.24.02.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:59:18 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: [PATCH v10 2/4] misc: fastrpc: Replace hardcoded ctxid mask with
 GENMASK
Date: Fri, 24 Apr 2026 15:29:01 +0530
Message-Id: <20260424095903.1622565-3-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424095903.1622565-1-ekansh.gupta@oss.qualcomm.com>
References: <20260424095903.1622565-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LfYMLDfi c=1 sm=1 tr=0 ts=69eb3ef8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=HL6mAI18knL3XnPGOeUA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA5MyBTYWx0ZWRfX4vWX1dx+0jyN
 BFMsnvQWgTfGBdf7LM611747CuvX6a0qkSPndm9YTZluFTIsnJU5zeU3KjxTpZIEYLFZXUZmgY8
 tDWpvv6d4p+KeG3rxdPUxViSjwgHjl7WCQsNVq2bvCHKnqYAivk4keN9S9bgJqJUqWzVW+KrlTr
 7UuUUgj3j/kVwNlQTdQ8pMvPBhm3Dfr7YvfKDCGIp8NFCHCIn4YoiUd9CDMnKb2E4HwN2yStYPO
 yk/EzSoXzTNMsTQ0VViGT7PY/NVrnMHnOduDek7ByyZmtQBNLv777blrw+hDKEhIBnB64aJgDsS
 2Gu7LNw5DGLltx6La/BlT44cbwR1OdH1HyUw/LycNmfIRGWn/k8b18VSIJtgndnqjFwM8sT1Yfw
 LRWDnaqafHVr9wj790KAjNWinwlPY+tqAcy26WzM5iP9YCiyrSocHevfs4DNN8TE8YfHso1Yy/+
 /EQ1/dNuq+ux5xzVO5g==
X-Proofpoint-ORIG-GUID: jkjWcT4h9L75Z0QHR6iObite_D917e2j
X-Proofpoint-GUID: jkjWcT4h9L75Z0QHR6iObite_D917e2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240093
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

