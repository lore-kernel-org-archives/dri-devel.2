Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FBDCD4F3C
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 13:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D446C10F210;
	Thu, 14 May 2026 13:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cCqwSZDZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eisOBEEk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9729210F204
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:11 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeUiZ3061905
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=r626fk8GTYQ
 7mVDurnFWdbX+Kfuz+zSekrPETuLYfy4=; b=cCqwSZDZA/ZNXKBJmVr7z7Bktxx
 UVxsaLFxNfkUHMEgmLfDrTkhlkQAn1d8jSnNYEkqL+DnIdkZhebLnz/56GLpNrAD
 JQDkci1gMWs3NvdVMsAiAEDjbmA9sSsu0eUA+Ha1jDTMFlwyFDEp4N7CEK/GeXBd
 e1FzjkuHX2n06UoQqE9xx1Fw0LfN+R5uT2P8KUPQIqDs+OP1mnTrr665pUDQI4ZF
 +HQ4NXS9nPEn3VcF59xxp+kxzOLeDBvQQGOxsizT4SbiMWyaYyE96W8XgahQIWWl
 nsJWKBWKlNkUUcJ5r62dmrQSWruq5LPCqn3dxViJY/qrm3w/OrTdG+HMLDw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e554aa7u6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c828659ecd4so2783436a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778766850; x=1779371650;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r626fk8GTYQ7mVDurnFWdbX+Kfuz+zSekrPETuLYfy4=;
 b=eisOBEEkwOS964sp9uLTOWN+V48hcu7pYjnW9Vl7A0dgkOrxBLUIiSufrcHIJY47bp
 6nYwm6F1f4YW2o8kFEH/5UwcCmc5ZHZHBt5SYmht70+nADHOybqC6ri/w7h/pmL4zh4F
 7GWMx7/ahoCvdD+f6M5/U0I0/UdV8AxTL6qe9mo0xW9tYQLG6LTWT4xvj/fcCd48O4KR
 yiiRNYr0ni54W05klyjfbD8Et6HbIm5H/HdwB+Bk4Trz+p4O+pRHNAxZe4WLuSRlMfJi
 V7+FMLfyBqjEAPuTWRn7O8TP5hayn5ijPqAwb428NhhRPYoSt7+j/89RS7mvIiJmKpjs
 RAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778766850; x=1779371650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r626fk8GTYQ7mVDurnFWdbX+Kfuz+zSekrPETuLYfy4=;
 b=XlHQciA7CnomwTLAcNf8yvlcKAKk4VjAVhhzGePq1AfhynZLMhlPI/+kE2lglx9Imf
 fe5ri7CBMyTS6ARIQRy/epmjQISvwD5zL1F3XxOGua9HkmOW9EYIdr7D1w1wl9BP/BQ9
 AQMQuqtvqeiOym8ik3E1rOX+Mznwmv/5FaxRlnh/2HF68FjfqULHcfzF0VvPhNOjUjHC
 fjEs276tiLZD1H1YSCJK9uIrCrMYR4nJDIJDFYDn+cDzctPkU5pgGxmS7DCwDDKwECnq
 x9jNEjqtFczrsr5Az6dXVV7DqsaH8e7lYSYZbtF21Pm89rmMPgI/GRWXv4nV10YzQneZ
 /oWw==
X-Gm-Message-State: AOJu0YwJbYobxmVMNBTa+WVCGVV9xBhrz5s1L6Vakzb3cuvcsmS6vaLQ
 JnovBrcXGwTqjMEm1v/EfEf7xi74Os6BXsvHCFvMLrJqIyQWIbjCk8mzwNt3frTNplGmUYXPDpN
 DZMtWkxCXQupdl5xYQmJATRe4XGVIC0YLfexf8L+iC3mi0kRb7x3c+Qv6yok0nUCIVffOR2ipSj
 j59IE=
X-Gm-Gg: Acq92OEkAqm+bmbtEDiarzt1bKS8AqwbHf+9o5Uge0kr+3hljzBo2uI9slsS933Y7/E
 o4KcDNiNnBbgpQVeUDHFlWvROyFHi172C9G5YmaSny0KdmnUZ8zD/pzNwLb8G7Ozfjs7yqmvTZo
 RkZo/bDTkSMLveSidpKBbDTsO/Y19NTM4rTTBZXbobskix4NUacvaF9uXR4s7ZE8fuihkPhxIMj
 lBDYIgN0+5ga72DmMOD4rv2nT9pfDDXC8iLnMf5TRiokSm506Wp0E28MxAVV6xDYctVzCWegkrc
 M8u+S4l+3Ccx9Zuw9/WH3H0vllbojlzJPv3sUeOqWt1R7iCPUa6LEzIxOP60qLtfH5Eyc9vARp2
 Eg8wFv00dG3Y/24/P7cs5nsa4op13vcqZ
X-Received: by 2002:a05:6a20:7354:b0:3a2:f402:50e0 with SMTP id
 adf61e73a8af0-3afb0b13093mr8611813637.52.1778766850509; 
 Thu, 14 May 2026 06:54:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:7354:b0:3a2:f402:50e0 with SMTP id
 adf61e73a8af0-3afb0b13093mr8611753637.52.1778766849955; 
 Thu, 14 May 2026 06:54:09 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb07d2f2sm2417535a12.10.2026.05.14.06.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:54:09 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 02/16] drm/msm: Allow CAP_PERFMON for setting SYSPROF
Date: Thu, 14 May 2026 06:39:50 -0700
Message-ID: <20260514134052.361771-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
References: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: s9lcsPUtFTeZ6Jti_bXA4Q1bewSmT_1J
X-Authority-Analysis: v=2.4 cv=Wag8rUhX c=1 sm=1 tr=0 ts=6a05d403 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=ZRXlmS4ShPoOlOK7p90A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: s9lcsPUtFTeZ6Jti_bXA4Q1bewSmT_1J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0MCBTYWx0ZWRfX5Ji4PrIFQxnP
 YCBJ/CM4wnT0xKk0A9/uFkUYhvftA3RiCY4l9Z4qbeVB/8bXInO0fOmfNiDL0qkBKP1vcFLEjxn
 PILfxN5L0SK65brAqg52OqZbezSgQJ1Sf8D9FOu5tiDSgmY/8eCyzeifrY/u9QCbGRp3GCZ8wQD
 695DNRixljeO6gc/HJ8VZ81Ar2byLWLThzigPiPJ9tczZI+dS0KUI9Mvpu8stKs/xOwExPSlQG2
 ac6mejLk9azgvam0vF9rKPU3/G9hLhFHqJ9wPsq3/P/6nUtM0DQZoLAKy+3NH7w4j9E+CKM2clz
 6uSfFbS92eE6xXtBe4nkS2Gu3tmJChNQBdkOFD8s55WPAJU/QZafyXUpKcbGAdkJe+ALuETfgHD
 h9kysKV1SzUciNKdgMu34Cy37AkAM1DCijqFENo9d3Z3omqBhJhUJVaER0RstYUBelK9dE2jFGU
 POK5UqWNTN1cxXrVMag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140140
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

Use perfmon_capable() which checks both CAP_SYS_ADMIN and CAP_PERFMON.
This matches what i915 and xe do, and seems more appropriate.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 66f80f2d12f9..72b71e9e44f0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -494,7 +494,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		return 0;
 	}
 	case MSM_PARAM_SYSPROF:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!perfmon_capable())
 			return UERR(EPERM, drm, "invalid permissions");
 		return msm_context_set_sysprof(ctx, gpu, value);
 	case MSM_PARAM_EN_VM_BIND:
-- 
2.54.0

