Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736DBC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375FD10F616;
	Fri, 17 Jul 2026 20:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZLzJcICi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VBVtKxgK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77C7010F60D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:14 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtQ7c2990425
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ILFLFLBAWhy
 u3kdv15Hw22354Io0JE1gAt8uUSQ6n/Q=; b=ZLzJcICivawMYSWzPeMSvxIDZDx
 EiebTpbRrJdFU1JjhPHKqErJJCj+hIor1/yp+/hGxSZWbGxabRE79RI0kWYEccJD
 J0+2mm+hxlT53HhadW8P8nIMBkpFasbdzRuIWLEvWjWDGgZSjmQE/9JrU+yqwdlM
 ndaETGhw3bDT6VuPkezp858BdDjUWmqGN826rabwQoyNZLZPMRUcahGwBxVjvmHo
 PdQqbIAee1tFvsPVoloAnpEnRE9+WwD0YdBE9aN5yVtIhsOkoVHMglivelo6cMkQ
 +VmLujvFyZMbmo5qEHsmO/xxNVw/7g5Wvw7DjpEBLhYPoBLuf2eowHxdACw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffd3aus8b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:13 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8482b95574dso10458042b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321353; x=1784926153;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ILFLFLBAWhyu3kdv15Hw22354Io0JE1gAt8uUSQ6n/Q=;
 b=VBVtKxgKr9UPtKs6W23cp/DaBnN+nOI3cIUagaqtAYJXbwW6GG9CAdunZnRXnMOFRC
 82oUUfNlfZxmmCILb42lLtbLAop79Bp1HLYntSRmDpBLr+6h7l9XFl5SOWm4CFjWsVxE
 3IBYUx9xHXwFFWDuDhESEM8bBgIN6Ej7/tnLsGPcQ+IWsvDhmXzx6Lu6kZQBoNXACpHp
 qZQBUqMqan9ZLHebATEebuFU3oAeya1dVaqXrDLQwEjaYBs41FsmeTDG/Mmel3u8fLEG
 hxZw8ayx8ZvVxWbsliL5FT2661vq/3xkV1ZCoNioQqZK5avm3bLF0XL0SZrxgm1/0UK/
 HxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321353; x=1784926153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ILFLFLBAWhyu3kdv15Hw22354Io0JE1gAt8uUSQ6n/Q=;
 b=kimNZnsSqmQPuMz0G1S4WdDno+ONrcz7RTVwV5uklB3qyFhwmn2W8iECKh4i1Ig9cR
 dGzsZqa22lAMtRs7JGZVVw/7wuRl2YNsZiB3W19cSXEF2ravsl7yyN8idsJ9rTmj4+tr
 5W2M0Ev2yYPjM+GAL43ZbiqBSkFgbqa7L8RQlxpu71C4ZFpQZv4z4odYez4rGP4nN9MV
 kqAP6h5l9MWxGx6Eeeoc7s4PzOsltuU/zSvgBr8tWNmPPf2lb71gcsotfVDdebE+Xcs/
 P1RVERYB7fNJjq1FmuuAyaRZm0IrlJk7u27zqF9ax6Wxxh0iQcrp0peZYPHLX1mFopgd
 uL6Q==
X-Gm-Message-State: AOJu0Yw1MXCO1/4ri7ER4/y8vlHDSK2LXYcDsQhYcvKL9+FMzXL8Eskq
 xTnnQNRXI/Qlsx8jzDHiXnzP3mZsU7c6/gOOMr7PyKRsXF5m9KIoGn0ucpCXVq0e6GmnA9613gE
 /r7150e1sc99i3PsR8Qk3IYI6PNvrAkhVgQ+jfZ9byFC0jkN/+f3o1hkQeDUpDMQcq5Y/NfZKPE
 OxQNg=
X-Gm-Gg: AfdE7cmDvuNKX+PjOJCvMMKE6y+9v4icuxEhJPbNXdo9TOiwKxs7iCsDpFF+ptxUiOI
 FIgjIATxRUy9sHF2ApFo9yg1cfNovDWHZRxid5M8GUiC3QRP9K7xDYZB6RTYIvSz3YQ43b5c8az
 6mi8JcdhZd+1i8rDKmV3yYCeUeiaTzBHXmC6cW5Fv/SGqHtXbD6OV0creJWkSR8uykr4cdVJWgN
 cLLThhULvCUfpuY8ruqklrW5NDGJMs5Ff56GN1h7skPKcbVcaXUOOD8Asq2U+rftfPuRo5NXEys
 ZKdlgT5wzBLUTWYh66lW4hTJGqBNZcOdsF5HH9zdXUnEMGRMxsTKdlW7WIYG6Hw4kPe2zJ1YK14
 r0203hBWrr0CVH6/8vMP0P+6I1fxsOadSLtbQv+QXe27AUfY=
X-Received: by 2002:a05:6a00:1f0b:b0:848:700d:c950 with SMTP id
 d2e1a72fcca58-84c29505e3emr4501509b3a.37.1784321353255; 
 Fri, 17 Jul 2026 13:49:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:1f0b:b0:848:700d:c950 with SMTP id
 d2e1a72fcca58-84c29505e3emr4501472b3a.37.1784321352818; 
 Fri, 17 Jul 2026 13:49:12 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2e68e7b8sm1473968b3a.35.2026.07.17.13.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:49:12 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 15/16] drm/msm: Fix per-process-pgtables check
Date: Fri, 17 Jul 2026 13:48:31 -0700
Message-ID: <20260717204841.26120-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX0/j1KGswzl0Q
 LKX+aUzgHvJOWzFcL+zSQjicLu5XdAK6vdqf/d8Soahu3O0hC3M2hup8kqFTrrYSQ8J49uUZxIB
 2fkW8PGs778RW1FVUovpVkSk80hiqZo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX/t271BOU87sg
 YBMtEaPqJEZNOuOkc6pllSjKBgh3nC9TcdUd/6q1nqo4GEPiJh2Z57evJKI2XsflO/wy+X+Zcd2
 b6xT56Vs9pyf9yKD3LIBkt4hua0RXgIgN5h+rtgHbwdezu5dRQHOJyyGxaBfzbLr36KoR8ozIKJ
 aDY63JwToz6jO+SwtztArM4Prkh+gxn2PyAKV7sCJNhrLUEqZApun3p1Hr4q0Kvcpx9/A0D5zxr
 EVM1D5azEPAcAW22jParV8XzP9iynHz+Ob/xAjtDSMsphtvPIvMv7VyriaZLsmi8KMYOQdNbqdx
 Cm+lyvwA9yr8dzG587YpAiA6zy7kVd3zakQaGy3WLi/H23n8AVdAaxbELcsR2GrgowRTU147lkF
 6f7R5bXWVao26cZfSWn3Ol+fc/CZpP7+Ovl8WbgqyKPMW3b/6s0QCSX8hrdSb5zL0PsKiN0o6p2
 cSUIiXGDr27vKTfZeTQ==
X-Proofpoint-GUID: 9FQ30mu_KMYDVAZnwWpSjc0Zq3jZoshF
X-Proofpoint-ORIG-GUID: 9FQ30mu_KMYDVAZnwWpSjc0Zq3jZoshF
X-Authority-Analysis: v=2.4 cv=e/M2j6p/ c=1 sm=1 tr=0 ts=6a5a9549 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_1v2yp3k2DT7xr2y9HAA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170214
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

ctx->vm should not be inialized yet (or if it has, an error is returned
immediately following this check), so this isn't a valid way to check
for per-process-pgtable support.

Instead just check if create_private_vm() is supported.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 84101e534ebe..3370cd44382f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -513,7 +513,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		guard(rwsem_read)(&ctx->ctxlock);
 
 		/* We can only support VM_BIND with per-process pgtables: */
-		if (ctx->vm == gpu->vm)
+		if (!gpu->funcs->create_private_vm)
 			return UERR(EINVAL, drm, "requires per-process pgtables");
 
 		/*
-- 
2.55.0

