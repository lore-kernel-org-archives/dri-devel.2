Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA01810AB82F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3669C10EBBC;
	Fri, 27 Mar 2026 00:15:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MqJiphnG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fhyYtapk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1F910EBDA
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:37 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QNq9rJ789787
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6h1GbkcqRvODh/gp8Mx0/sRdMg7ZV4RUJ1froSrMVMQ=; b=MqJiphnGufhDbsoG
 QfoaEzBQWKI9MK74OIQ3ckZmrPNAuswI7Iy6CAzTfjs8vZbQ8qTT9yajw8U2RbE7
 e/KuxPrgMb+W6NTVrIsluasKYxXvXmj+l3uqO15KEres79bddGNXIteo//Q4Bobm
 41tRMi9EFHmV6pgHx7dhChMywN5fa63lcIqy7PD3iTGYTw0faulExiC1wws2d5zU
 aIrvhQ9eltOk2sN3RtCJep9Rk6RuftClu9rQNC3Rfwcds9I8/JxwDINnzjCB3ucq
 xwwOFFOKZDn2uzz6+x3dxgn0yMKL/ygUNV5vlYahhSy6solagOMvqJcSwYSNBF1M
 2Q5v5g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d53eqjhpq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35c1107da15so2341248a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570537; x=1775175337;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6h1GbkcqRvODh/gp8Mx0/sRdMg7ZV4RUJ1froSrMVMQ=;
 b=fhyYtapkFl3MUWj+Iu5cCt5+DYZyyVwkf5afxgukWe2Chx7JXn4Dd2x/4dlCE8cCvd
 dMRkXKRn3xeFfC5rF0AQpPMpg5U1DE+Wp+i2wR5tl5oUGRFVl4tQwebRfGzymjGMd5gE
 i52WncYzmuumIIksnNRFySwQNj0wQ0ggPBSxS731Nl+CJ9hCZIGNseQpSYoBtKDiimAp
 1qWgeDYLt+34cPZdEjlnaDkh3T84J+QA8LP8p4h51IjitiSEqCmnJSWp6hb/uxxMRWR8
 SMR2sgll27ztrLplsZ72p6TJ4JukTmyOn5zh27xNOvl2fLS6NDt/iVxwVgTcQ0xirXaQ
 MdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570537; x=1775175337;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6h1GbkcqRvODh/gp8Mx0/sRdMg7ZV4RUJ1froSrMVMQ=;
 b=aVHLLXCHE7KhHrKDaOaI42Yv22wmLGGzAnWEGtY4VfQ2a4n/ky0RXnLhIngPO6gpkP
 prqmVx/LHA/sYR2AJOnfts9FZhKEkHJY+8b5lzOAE6cEPjRKzzfmuppRJ2Nr84ph74Rz
 WJ13Sjw9fHBWLMzy5T1ef67VsOvpSb8zyoMxutN+1Z2ZX7SbOnoToinrWiYlTSLWsZSN
 IYamQHwx1AO6RPnBHA7VtESirzA7UWr4HBobOKkZ5WaFvxVTg5IXEuZTM97wRNgyiX4n
 MnpvRymm+Iq2A6MglRToNItjuK19uU0xc6M2dl0G7TIGhG2l3AbpEE0CKBjMjRzoaIoL
 F5pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIvWBrHQqbHthPcycytXsBKVWB4hgm2XVhbNmG/MIu4Lb6dgUD5rxqd60iZukv9/ihgPc4ZmGph5U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBxPz5f1SbvBWG5YqaplNEVCa6rTJfpTqpGAyWlYKm/Hehe5+r
 1pZ4fcfWhmxmox0/SMI5dZq6zA07MP/mveUEM0QumWThxXBp8dqSVl0Bshtr7DeNcs3QEDctYw/
 /wInF5IHHSlbQVPBb+VNp4rdXcCi9+41vlfsaexNT/hctGsmzpHawin7Vx3RaTVGWhOdNJqY=
X-Gm-Gg: ATEYQzx9Tewmz5/C0EPGkzcQbvIOyLSB8Mx9YsWTpPG5YafB5tPD1mItaqs0fWHpdjG
 hVIF0icl446v9INMdjxxDg0s5Zf5NC1PHUcklxdIDz4Nf2TiIxSTXXe7aLFexdoWW+bCDyi4hXG
 01qMwCPqnTCE+fPsNlAX8zx0MK7RQYnzVgO9ICCGrCK7xxGbSYBXtS1gKWEG2q+O1aiuOyVhr4Q
 UMSsN2vXcQHA/GLZkxBttWNiHY6MyiDiVYJG7Qj+XocGamiXcsu5RHbcMTCPKWcbZS5YGCuHyBu
 s2ZDkOypGK2HdO+L2+swiQaacZBOWq74OObZ7nx9Aopc35aQqtbGTDWKLIoc7Lk20kAQZKBISX4
 CEHq/uPy0+p75c0BvCOhm7fTNlLAlu6fuwstBIisuSk8Kqg==
X-Received: by 2002:a17:90b:3b4f:b0:35c:cba:3453 with SMTP id
 98e67ed59e1d1-35c30076fe2mr470135a91.22.1774570536922; 
 Thu, 26 Mar 2026 17:15:36 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4f:b0:35c:cba:3453 with SMTP id
 98e67ed59e1d1-35c30076fe2mr470108a91.22.1774570536479; 
 Thu, 26 Mar 2026 17:15:36 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:15:36 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:44:00 +0530
Subject: [PATCH v2 11/17] drm/msm/a8xx: Add SKU table for A840
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-11-2b53c38d2101@oss.qualcomm.com>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=805;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=H5UIoWKcwOAS+auMl89W13gGP8KyR+VgG/pl7Eqs3ww=;
 b=F4HSw5meUoi3jhfUWmmoDNcf7NbKh/4OwftlVELIMzRkTdituHgBBglo01cbB+1fOXlzRFHsZ
 IOnX2+H3sqlAwz/C/8ZLBfAK4UQbCcURatEBNtjiQaj8+wNYGaLpREi
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfXzqSypG3B1yQo
 jQog6X8sUS87g1xHaq/8UQKLhEX2e4/1IF8xvD2pZQuuNmPmMwQBfriVA5fcmSdxFnssr59IKX1
 JQ1zgL0JrBcJVDEXM5Wybk3nlYNQzu5tFc4xGSmOE3kDTy+KXAf4iW/TDt33LzpBAwwK5TpQ03g
 4eURt2gTzZ0edb0a8RAXUKApiUJrXQtsx6Lq1ub7SGCz1+sq9LwvetCeFuv43MYLZUtsPLWahcA
 lPFUsgnPDe5KCBeZKocI3F8RSWfR6f+X1q3pBK+UX6X9YSWv5FO1iPAow3U42YKC+2dTBU3N8sb
 Lt6lgy8BXzd+KHq9HwCWVMhaVyxPtVtmMfyXbiKWag86ZqEmu55s7dQunX/0CjSZiWs9jj6LZbn
 Tlzcd9TicXCSkrTmP/CsdpII2zeVFmOBcug8z9WfzSfe83Tw0ASzwt3C4KHQQzZM68JZSfJQXnE
 fxJ8+0g8MwIaP7I+iaw==
X-Proofpoint-GUID: G9HpYYh46Sy2J_hR4kjfgqGtdVTFogvd
X-Authority-Analysis: v=2.4 cv=S4bUAYsP c=1 sm=1 tr=0 ts=69c5cc29 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Ml_BBXNIZAQcZvYyiGwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: G9HpYYh46Sy2J_hR4kjfgqGtdVTFogvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270000
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

Add the SKU table in the catalog for A840 GPU. This data helps to pick
the correct bin from the OPP table based on the speed_bin fuse value.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 38561f26837e..f6b9792531a6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1954,6 +1954,12 @@ static const struct adreno_info a8xx_gpus[] = {
 			},
 		},
 		.preempt_record_size = 19708 * SZ_1K,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 273, 1 },
+			{ 252, 2 },
+			{ 221, 3 },
+		),
 	}
 };
 

-- 
2.51.0

