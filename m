Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BFACD343F
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 05:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA2D10F1F1;
	Thu, 21 May 2026 05:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZfwPBGFz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SQdHSiK4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD1E10F1F1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:45:54 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KLe7pH1798325
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JIaEBu2fXti
 OblnnO/rwwIoef8J83XO0Fyvu0X3nK9Q=; b=ZfwPBGFzxho5X5ZszEUmmAM3mJG
 3nZGqVTg2yNReTyiPavbYj3iuf3xS4B7wur88ig2Hg/uKKmTVJYdk/bpMdUNIG6W
 lZTP3XntY2wIrIFI1IzNesbI6HEbJVXTjxq4RSLrE0acS7RRUWEzr0L5WMj4PBSS
 Bglm7/FWPBjSY2WDvLuEwT37DOm2xnZPSUT8OQV2z4E6a8qYzwEqc7s4EY0mg2Ak
 yF3ixCQIPtMs5DNVBE7YYFIMLiRGk7Kvg+5JE+1YPfcOEZ/QMt8XbT+BY3DrgfR6
 bXP7Ho+6N8110kQquJiOa4s1qybiV6EM3j4sdTSyDpNRN/+47LVAGuPAm8w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu3ba0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:45:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-368b68a33adso8934762a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 22:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779342353; x=1779947153;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIaEBu2fXtiOblnnO/rwwIoef8J83XO0Fyvu0X3nK9Q=;
 b=SQdHSiK4aVJ5NsPTaPZRSt8RumhgB4VM8Lz8dvSFx0MTITOWRQNVEYCoC9mtFgNP1Q
 zTUIhnjqSF4DkKME1P7TVsHJp/E+aw73cAWfwOw3zFVk6KQoiEbXdGwRgQnJ9SM7eFHp
 +F9OZTe4r7ZM3q+pjvdeDIu4NGA24FhYIwatcCfE1Gt3rJ5Eb77TlGzEQlTtwS/VwYfn
 Udxwg+Gzzs/+bjuy91iRKSotmSLokHwqXCUL+yM+TjadQSJvSkNUH4C2+qE2GtEMyOzq
 DVqUvSa/+tb7TsxufUGx+WX/VXhYoChXeUcgIlOq69hK3rv/w7/+uVxNZjvssBlPsCcT
 az5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779342353; x=1779947153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JIaEBu2fXtiOblnnO/rwwIoef8J83XO0Fyvu0X3nK9Q=;
 b=FIiCgQ48FddT41X8gBd2BFJWas0w5vIbtBPNraSA8nkxxLgnM//tcsd2halhWPrgsE
 5Fp7EdUhy6vhq3PuKxYhm/N7nGTgd5xCN6y65e6Sfb3I0l1z8a2IzFLHHzppzl2CZq8K
 jj3HHTIvmNlcMA/CFulDJEGdFbwx3cpxA5fn6QvaMe6FbVT57eMeHdWyhXCZZk+KzCxK
 y3U8ZaiufrH1QfvV+deODaPlmLUCSWoJEPXcT0qxbWt82sVCBZDBVCqlEvP/cpsk5JU5
 lf3M1OxbLcNK3crWn/opPHR29855lQ0wPV42w+Cm4cTaGNKOSpc8i3kP3cRmkLXPVbys
 uUiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WfMdQ+HHw6rrcUu7qgOfLVsaoNRt0w0760B7hhd0ad8X58xiq+8J1fkiM1qw2axv8mhfzvKxr7IU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtF96SPF+stA/950OulWI4m9MsTWLoQWKglM9TcQ7XQv5WWhxU
 uHC3TufE0RJtir5v+B2Vd7/MciVD038gmwD6BxDwhopAow/uaflz+q1wyKfeCWtu4t0roz5PbRK
 wX8puRvPkGl2nvqoOCSyL2NTEyjTJSpyEP53VP5pDUGbH+2xij3zKrCxeXQh6/kYs+tiu404=
X-Gm-Gg: Acq92OHNKgsM4ImHornFIxPQNUcJQq78ssehVjS9KQQ812yiCRv/iQyruMYmUO4zcRF
 Pp4o4vsow1kxfmJfB+LDwmsvK5tzXtfRKm+iddEjant0Gv7yEE2iiVkDtWlZX5GM+XzI6ALYSfV
 7pPOayvmXSG8uBZyzAC5dJic4zIK5RE/i73UxVB0ltaHpOurBPzIkYGXlFIt/XoGrtS424UPtYL
 ZxI8Vtusc+1jYzthJRa7TGb1Ze5keXCRrZl8b6770okLBA37JEhB1eUQGQ/3LtvuS50eiX3zR+V
 8npaTNJBH8bnOM1bJmjTHHJA9YKDXKY27vCGP8j5XN6QgRTryrd1F6aSd+HJHRGlQE25O9O0+TR
 SxhCcZpV1m1G4pCxNVTwfwlaKIe4jTOo5O4DCBxYqixlqZ4ioK/4+lA==
X-Received: by 2002:a17:90b:2f43:b0:35e:3e86:e2d1 with SMTP id
 98e67ed59e1d1-36a451488fbmr1504408a91.7.1779342352876; 
 Wed, 20 May 2026 22:45:52 -0700 (PDT)
X-Received: by 2002:a17:90b:2f43:b0:35e:3e86:e2d1 with SMTP id
 98e67ed59e1d1-36a451488fbmr1504375a91.7.1779342352434; 
 Wed, 20 May 2026 22:45:52 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3cb323e3sm1474847a91.4.2026.05.20.22.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 22:45:52 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v12 2/4] misc: fastrpc: Replace hardcoded ctxid mask with
 GENMASK
Date: Thu, 21 May 2026 11:15:37 +0530
Message-Id: <20260521054539.128651-3-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521054539.128651-1-ekansh.gupta@oss.qualcomm.com>
References: <20260521054539.128651-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA1MiBTYWx0ZWRfX4mb9Q50GdInd
 w4wTJOeaOUEzUOPT2WZFW9ZeSnmzxFX4/A4QsUHoVAI4d21yW39QztM5JozQoNkhkbA7CzAmM/s
 XcNx84ugJHI3WiPSE05IHhmOmmqiIlDE8cGvxDE2+k4Q1VcWm0WdD5668XxXOowtnQigEkiEk0c
 1RKY8dcuFSTAHy/v4eV+VXiZdbFrwthCh3Cz8wh8ESj71k2+frsOWYkVIcTLS18hJxn1UFmOi03
 LW40TLTXYP2k8WFJHs7PGmXa6W1MGVmc4OZRPLvLBmWaGOnrkYDJoJsWcOCk9bpMoEvfa/rmjrw
 my3xI93SxqCuxRNNgGHVw+64+XR5KGprMRSt/oDAlPLMt2NikNC4k4EgCsh7T6M8bIZQyBjlcLk
 YKROekgyEMoP5tmEXa2NiuJwJJziaV4InsEZwlCvD+OuPDrsx/gDMIDtgcrwQP+VjmDvNGlRxHA
 je1iW0MRfCQiAQIDTuw==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0e9c11 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=HL6mAI18knL3XnPGOeUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: GQD0rFJ6aG66aV7Rm89syVELLjPiSHjO
X-Proofpoint-ORIG-GUID: GQD0rFJ6aG66aV7Rm89syVELLjPiSHjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210052
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

