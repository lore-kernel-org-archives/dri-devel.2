Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00023CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD4110E74F;
	Mon, 11 May 2026 13:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZH8LBy7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g3rd9mZS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D44D10E77C
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:35 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B7FJhY3332677
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=V4uUYe1yUyG
 7QRKd8WtYyuBLYfX08jPs1+jI/fe/6lw=; b=hZH8LBy7dN9wW4Iux9XXl9fg693
 /C+ay/IYnGRXaKJVQ2ncMsYu291YvWWjTzNHyz+jhOr9+mvQtMVJf0YyILq5337K
 tP9SpSQfiCrxA+d3KOCcrbTToExCPHc9BYg4To7JIi5ArGfEJQQZclzFXOLY+RRN
 HdGKD3oMh0q6le+b1NV+C9z7ItTZPcR1Hzx9Izx9ps+8FSJDi3wl9fPAo4MV5Zyz
 1jXmak/IDAXIf8ibzsdWNVwOxvVClTY9clZMDL/az1x5aUJlk5j2QpfFn9wpfilV
 KX8CQLu4czM8MhhgFmfgAHdfpxfWWMYBw0xKlONPLTA0luVOINv6Xmm0T4A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ajgs7gk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba054e0304so38821365ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778504493; x=1779109293;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4uUYe1yUyG7QRKd8WtYyuBLYfX08jPs1+jI/fe/6lw=;
 b=g3rd9mZSzpBcMw20pVoqg+kVAwOXF6bDfrok3dxX1v2K1wfILf+i4UdpOUV+Zzw9eO
 mftesK+YTsZuXeeXOYPHiPG45vcNc9P4hpYKMiBBf52kqrUmRTZtkYlYcxc3xoSmFudK
 vMSaBUpqYCfNR/4gcGkfQbSw3pSY17GhfiAFL6LxOXHUlt0wqbIsM9gSYHlZldq2g6p9
 87rxDfwg50wxsjhPFOnf2jXM45czi6C/L691glmt5fRkaGtuiO+7a+z9BD3XOG/iJPO8
 +iJrZGa/HoXMWsUV5HEWXRRygJrGqgVAnQ/dUP3sTWYh2S83igvBhI3RTr2AUtex+gkN
 J/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504493; x=1779109293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V4uUYe1yUyG7QRKd8WtYyuBLYfX08jPs1+jI/fe/6lw=;
 b=LvGiaKoCG5x8UEpa2hfIWyRFG54mfYwlFNJSqKUBjH8JCt42iMWpkAIrPG9GbfW8ZO
 h6zCbjleFa0Ko+aVu4Fu6MaC8R3JCpbzM9bHoUxLTJzWZgK23X3UD+xqMl2VrYeplFfb
 A+hDjUoum4aCRzhfouLiqe+jZjaNibMCwbapvsd3MNRz7Kz8iRRC2TkMx3tcaodR8KSH
 VWuMnaFKlL6nrv6Y+NrCvS4f6XlLKbqUM/iGtjk2VW5q6ctuPgu6p7/S0tDxfEv2I63B
 fUvoI06yUkjc6UCtluCjj1CdaXupUNiJErTIKhyjY9WTeLTyG4hPKfAWxkjjJojHqwZd
 CZtQ==
X-Gm-Message-State: AOJu0YyH/F7xUa2vUe2XfbOUSy5YJfLSw/hXQc/Kv+UkbS4uM9PL1508
 +bSedQ7buvDfUWSTiVTvMQBEbB1wtfl0cQyyY29kVYS8/02r8BIhhAdIVJ3blprnc8q6hLjHkhP
 28ytFSWV9av/F7W6aWqqSzM6M3UNAYmhwXEwYc060vSvOsXLsx5keFTsQ6mkpgbaZarDzk/yOEW
 5piIs=
X-Gm-Gg: Acq92OHqV7smNyQbzy4w5IZsz7nzENxk0mls98xt0MQZow/tuyWgOAdlacYlbWFQePq
 s1JNkmnPD/i86GnSaUG3nD71+7OMTDPOsMu4f4+3rHA0kf5NRfm6Wpna8c8WF85VeIW+q1zOWsC
 ehHW6YKM/9v7VJJwPBfpEiNAnAvKvhGK5ZbhfUeP63rEH98vORQZJW3Bxt9/NIjHuYeytgKH+bv
 GFnMBb1uSn7/N0qiy3IPWo2er4jtyNpNBGcD9BicpaVxf+3nDRT0gheFuBP9yDaWG+MmeHD18vD
 +RpRzKntkJ6SlRC7KZ2i+RhgqR4ydKP8JxaFIhtyfVIE2euOZzW/MzAKpX7FNHzgeXYWG5UqfBb
 S4bBoXMWC+PKAQFGnMgdbWKnXljAgi3xh
X-Received: by 2002:a17:902:8492:b0:2b4:68c9:302a with SMTP id
 d9443c01a7336-2babd4a48dcmr113994875ad.17.1778504493300; 
 Mon, 11 May 2026 06:01:33 -0700 (PDT)
X-Received: by 2002:a17:902:8492:b0:2b4:68c9:302a with SMTP id
 d9443c01a7336-2babd4a48dcmr113994545ad.17.1778504492563; 
 Mon, 11 May 2026 06:01:32 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ebd0ddsm103278845ad.75.2026.05.11.06.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:01:32 -0700 (PDT)
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
Subject: [PATCH v5 14/16] drm/msm/a6xx: Increase pwrup_reglist size
Date: Mon, 11 May 2026 05:59:27 -0700
Message-ID: <20260511130017.96867-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GfgnWwXL c=1 sm=1 tr=0 ts=6a01d32e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=8lTVeMJbxB4f0FvlbnAA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: AcWn4s1lyO03ThNykuO3HNr7U30DRGeV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0NCBTYWx0ZWRfX3sfPfpz6zV+D
 qIfGT+253PXizZpp5sR6xbKT+p1rLqp7ISF0Ome6CfDHFo/kueABvw85bgJZ/+CTWp48scN+RNn
 TVucFSy/b9PANeindOwXrInx8psNFlC6KmPTubxqmsUtZ4H6+WDFilA5d1AV4EqUKJoknSjY2aF
 sQr2gKkpKwT8g1rEE3jxF/lE65FNAOyv2MEQMhSThNQuc+edteMZvIV2FtCvfkIMw15496rV3Pk
 1JV72hsKtTPji5O5cDFeZ9cBOA5lqB3kJSm29aeAfatKPbN9MHppzz1sZ1FWRfenq6qUnEueAse
 Xg55EHzpMK2oVB4JEFwcw4y1/KUOVPMnUp7ERWcbM5ua86BTj9xyXOcLYZ/CV4l5gWe9mxWXDoX
 oZV7VyVSmOsgF6UX8VedWK1t1lhkykFeytsPPxPfjfc55ESNNUd0avMH4OVllzZEjCJvIULBcuZ
 lzL+pRZjIPnzzWe3OSA==
X-Proofpoint-ORIG-GUID: AcWn4s1lyO03ThNykuO3HNr7U30DRGeV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110144
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

To make room for appending SEL reg programming.  Without increasing the
size, we would overflow the pwrup_reglist at ~190 counters on gen8.
Or possibly fewer, considering that some gen8 counter groups also have
separate slice vs unslice SELectors.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a329d20033d7..61c6b0e781ce 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1183,7 +1183,7 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
 		msm_gem_object_set_name(a6xx_gpu->shadow_bo, "shadow");
 	}
 
-	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, PAGE_SIZE,
+	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, 2 * PAGE_SIZE,
 							 MSM_BO_WC  | MSM_BO_MAP_PRIV,
 							 gpu->vm, &a6xx_gpu->pwrup_reglist_bo,
 							 &a6xx_gpu->pwrup_reglist_iova);
-- 
2.54.0

