Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95008C44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E906810F3CF;
	Thu, 16 Jul 2026 20:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EtANqHvS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jpX+0HmJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758F410F3BB
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:56 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJoPrd3753245
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DUl9fsdKYPz
 3kO0o4cBY5wSMLk2mQuvR/wBV0AkKLB4=; b=EtANqHvSHD+Sxxh5FUM1BCiNiwe
 recgi0jWCToMWtkvkEVr8aEMn+D/iIzOx8vkBUGWhhTETduGlwIUaNYHYpT/7UaC
 jP4HOD3Dn4HJ2E7gV7mMi5fSzot/y5peZfcWGGpAzmXYrqYZrYZX+2SQ8zlvT0gJ
 aeD3Jqf82npHH88SOTpiycP1scNv1t063v53KNA5FcULiX8yrRcKqirKbbeKX08d
 jvD52Iv6aph/JKkYFagJHD2ALxIcZtSgh9GJWGAAxggil23fJFFQG7YP5xgLP/+M
 TgL6LbDn5rXvWurTG9D6O1A7yyRNcVIx6XnsRBV59oCg0RC2U1SV8U2vYag==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex35na-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8484f26852dso3736615b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784232954; x=1784837754;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DUl9fsdKYPz3kO0o4cBY5wSMLk2mQuvR/wBV0AkKLB4=;
 b=jpX+0HmJWGXQ0nUQEGxC6d9jRN3HELT5KWK/I/ZYHIOfHtEr4n1m735fBSJwiUz1t6
 hQZbt8/TWiGwc7IWvJ/tERMWPxO+JFAr+D6KqFOSDn7v9Ap7amPk68ejdeKwoxzzEvS3
 0AodEtD0/TbUFYJuIwYowvBDMbrudpxm7sZb9YIvfHM5+ftGKrUXUvEvAfb8BOJvbd+a
 A5MzjSl4PLkkCiTsbGaREsrwb9xa1Lf9xu+WuginMlcT3YwRyl6LEMrZJkcmDq+aMYBn
 6WROWrScwtLCOO1SJPfsqLD8y50e3yVTQFfiF/qRLc+IDRFZBXC77bX81owIKjsCCmPG
 mflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232954; x=1784837754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DUl9fsdKYPz3kO0o4cBY5wSMLk2mQuvR/wBV0AkKLB4=;
 b=qmIrj5ap8LZLHNVk9mwzlghc9IBSG/+nsWDoVAN0doT/B61H4Elfo9+CCCz0R1joAx
 LemnwUxDkpjXnhhZOzCwmYZtImfhdsSC2rQ9Z7D/Gk+2cqaennq/GDyYzG3ucgZdlGVE
 kGal9m6Oi9lxlrc2KxJFiUu4u+qTlSo0+PJrJdFIWmdaOWMzdtGhfHqZ28xrU3TX80Uf
 mcNl4tYVzso6m6SuHiWWjQE15Zv8l81WMGEvccbd2UXTSTXREA/T/6DracWiQYwS/Yvf
 B2/wYO6Cgxb8S8dBe9pA4HCHRReSdeTl66k6W888Ba4nkkCEE2pDIImgA8g4+IEcjlcZ
 q3SQ==
X-Gm-Message-State: AOJu0YxOgwrTsWdukeI7b+69NMgsGnwV7Kk1TNTaIa/LttgCV/v285U/
 SxjpIVkjDvAB+qn8BDdZlqazDNi8QpxXe1cPjkyqNTct683lXMlwXi9Ll3F3rfGRcL8NPv9XjIJ
 gG9klt/zhKVz7CdyXGtUdqyxyXIkQbAVRE1hpN5ml4y1rX/0P3cAYQxfmUVR/PDQaq4bnWUABq8
 gIVRQ=
X-Gm-Gg: AfdE7cnD76b75IHpovsCIQakJQUvkbJ/5HvkK+IiWFKOKEgPC4Lasa0CGo92Y4g/9+d
 vevbj1U9qSIrwPhbotQrlHurHvYRL81qtmwdh+1g73zfPCVkMfARvx3V0V3XdY4au8JgxSJ8x57
 H4riE6Bgg1xzIUBQfDsBXa+yAR/ltkG6YQtydDtY505t/9aEcZ5iciau36+dRx9EvMenQ5sau9C
 VptbFMUiDTly0qCWG1EYOxD15qszLjTvsORO5HzQ4d+sor0Euv/+wmt8Qb64J38ZUtrvWunmXsJ
 hWlgpoEeori3ygrYKYXvzdwcpsjtcL4a2tBfrVgQlczCpjHmvWiOT75mT14C+K0hp7lbkYbb3F5
 jvbyBvw2OFs7i0zT7Sh3cJeh6V5B3fcHMCwMQ9arVAV5kkvI=
X-Received: by 2002:a05:6a00:ac83:b0:848:7fea:93aa with SMTP id
 d2e1a72fcca58-84c238c499amr731508b3a.21.1784232954284; 
 Thu, 16 Jul 2026 13:15:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:ac83:b0:848:7fea:93aa with SMTP id
 d2e1a72fcca58-84c238c499amr731468b3a.21.1784232953869; 
 Thu, 16 Jul 2026 13:15:53 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a5c699440sm4290243b3a.34.2026.07.16.13.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:15:53 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 04/10] drm/msm/a6xx: Access VM directly in submit path
Date: Thu, 16 Jul 2026 13:15:27 -0700
Message-ID: <20260716201538.365824-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a593bfb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=QS8Fz2UHHwPDOV3g--wA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: jhFEaZO1OZv6sN1Sv5XV8UMrZg5UbFIE
X-Proofpoint-GUID: jhFEaZO1OZv6sN1Sv5XV8UMrZg5UbFIE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfXxBKv0GFeAozR
 WojuIWNycpikLLUKe772W3XNcHY8ZWZDLKaOqvIpdOKCnHh5eEHZqDnkkLXL9jh6+SlqK1LjlJS
 I0svP/GAXCtE7gaqYNVILHr42WOKLIs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX/zr6Mn7g9eDD
 Fg5ImpXrNBM9dlE0IqrJoSVgC7snbHSDVmL8QF2TZ+hZOTTNa8DRzLABcLxzobmD4StHhIlaZHJ
 8b0LWF7sFWOjlbbfKaIG+64+H5A917teHxuLk54PH7WHTRMGR4Xk4Y8CDkexi8HCka1bYKA2Z/A
 iVzZbnXiFUWVHJ/BL7FnvDrmNnBABaaRZ5e6EffovbTZH3ckq5SrIFE/vtnDrjrSOpV9H/nKdgs
 3co/9OTCgiZ5UeMQp8h4yMNtNTPrj4pxEwNYOX1ALr2yzZfa2X/Hbibb2mmf9G5mNIgQ0IMZ0Z1
 ddAATJwrsO88unniYRPkeq0O1lZ+oE34pKXbcHzJcXfM2qORqUDsdBaHnhWZW8yBSOvFKx1qclZ
 rJmn0uBvi5dAyInbPR3dIIcYli5pirzqiiWtwLGqxCnruEcheD+CZ96s9fnfbOJkR33xa5DtqgJ
 5/YKqW9h6FplhAlA/aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160206
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

The GEM_SUBMIT ioctl has already ensured that the VM is created, so we
aren't expecting to lazily create the VM this deep into the ioctl.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 8b3bb2fd433b..7f1673163f67 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -229,7 +229,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 {
 	bool sysprof = msm_gpu_sysprof_no_perfcntr_zap(&a6xx_gpu->base.base);
 	struct msm_context *ctx = submit->queue->ctx;
-	struct drm_gpuvm *vm = msm_context_vm(submit->dev, ctx);
+	struct drm_gpuvm *vm = ctx->vm;
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	phys_addr_t ttbr;
 	u32 asid;
-- 
2.55.0

