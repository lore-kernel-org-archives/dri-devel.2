Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48B9F53D7E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F336810E346;
	Mon, 16 Mar 2026 18:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WCpfyXzl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IP9/eLN+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0508F10E31A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:34:47 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GEg6q53295184
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=m1D9Dmm2J0D
 ng+TT2FMOHE2ImiFt99EXWPfgN08aVsw=; b=WCpfyXzlc58aLG+FocZN0DPY9kA
 vSTCyuMaRPP1Nn3odNy7odvc0OS5PSJ9+J6XGqyMcDftQtFNwQeiqN98uOPJlzT+
 J13fF5DGMJSgmMvlZROp9aHxKRXbJYPXt9N0VVw0Gnyz5v7nqXg4sbBoQOBGB6KA
 LZHTmwLS64FuIDKvJ0sefqZlztE1XG71y5C3vUZsMhnVCi8Ut3io5nbWLmL8kn8S
 10SLb3P8jrHetwqg2+FHEDHhkUCqMJnDcXNgetL9R8L0Il1V3+WYEQjQx8y7DAat
 s5FLZDru9jUcBh/9cc2ZYH+2QCHpzi8XVw8hdhvvtcc/0PuiGREMJlcgdTg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxkuy0txu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:34:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35641c14663so5528298a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773686086; x=1774290886;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1D9Dmm2J0Dng+TT2FMOHE2ImiFt99EXWPfgN08aVsw=;
 b=IP9/eLN+3Y4HlPsit1bklv6PN7pY0tQ3sTMsId3YxnNx0fg6XlckN1a1hWRZnhT9vr
 dW71eccuVq2mmIzcqECIlKXdHRkPO8v0xkJc/gyT53f4eZmIKprU7jQSLOrAKHH4kMzo
 JenH4CpFor/fvvg9sP3t7gxXvkawuoxMsZn0l1YGkioxqAQcRofDq2/ft0I7kdBgRfzZ
 OGK7VdQb6YB41vCpxlIwtXdCG3pAOzNBu6jjdz/b36+ovq7B+zrkMQkxJ1/6fNAxFlDs
 JoNsn6/+U+XIYu1CoOY2z0k1oV5apIcPjqny2xENVyBdJ9y1TONlcYjn1t5sbDrzPlME
 C0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773686086; x=1774290886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m1D9Dmm2J0Dng+TT2FMOHE2ImiFt99EXWPfgN08aVsw=;
 b=fTfejnCU15m81P/+SArYS/HoY9M/gQYWYcBdwHg8Tn1z7IwLtpsfiYvZvycTOm/314
 oT8cOnVgrsMAjxMaxjYylDxF92hED9KJN5eUU4OeLh8+QpVglzSltC/E5iz/EYbxOj1s
 UiGQIxjFwyq2HhvmNaBxCjyTctlXN5Fe3URMSAhBsUsWyyAUmSEEdZ5th1uVB73ksdRi
 zVkl3UoYhHA8vBE9WqUm08tU8U09grwBaG9dDcH2spWOrZTKWFyj9B1fNKvpoiW+J4A1
 PLTy9cQ/DeeQBoLaKrxok/vHVBTWDYASWG0OD+P3CyHeRzpJX6Gd2/zEVJyfeu5IARvI
 y9Ug==
X-Gm-Message-State: AOJu0Yw68YjVnl8gvwslePYgL9cuL0dXQrPS+lgGwHD9yNaEi0hZBlxy
 9VXgeqEdu6s5j9x44FRtQd6lAnBxdG524eFzzoP8Nk0cKbc10HzmLSm3ShQAu78ZL1XEHm+dG3E
 aSTwVQzVbVtzq1HmGpht2S55kM52ODYqntdIYORiJizHyRpq1Ok4YHTgzxvKDJQiSz6RbtD95t7
 57wug=
X-Gm-Gg: ATEYQzxMg1IrcmPdW1WakJNKaoTIegVyTkkZFtUDLyMZkLxJ/FX4iYS8IIM4vF/g9yR
 +Ku9FuJ6znwW1dnGVPp9iPU9NH2QABmOD7x/hw16+g0HWXGK7yHbjIiUbkH+1A7wreU8LZ5ARLz
 igVoslZ9kupegXTmAlIp3KfBpWkxMHGCuYRrjglZVzDnVLvwVW/dcs+Jn9ZzGWpce8bTreWzVi9
 Plu2UBxbnpIYhkBc7ec2DpkRjYj3SGM25dQK3nEuCeZIUnej13MOPA/BGhjkBSAbIRrQJgF84Z/
 sFp/UuqtgoeIBM8M4io7RKQDh9E5f7pMXn8QDMUGgSjcdZBr9ibc1DBkXcrlf+A26ZwKq2sQd92
 3wkYoOPGM56vFJm1auhCyRRkSxtDaEHJ+
X-Received: by 2002:a17:90b:2687:b0:35b:9ab6:1d51 with SMTP id
 98e67ed59e1d1-35b9ab61f3emr4284402a91.24.1773686085968; 
 Mon, 16 Mar 2026 11:34:45 -0700 (PDT)
X-Received: by 2002:a17:90b:2687:b0:35b:9ab6:1d51 with SMTP id
 98e67ed59e1d1-35b9ab61f3emr4284382a91.24.1773686085496; 
 Mon, 16 Mar 2026 11:34:45 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73eb996257sm9671910a12.9.2026.03.16.11.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:34:44 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm/a8xx: Update GPU name with slice_mask
Date: Mon, 16 Mar 2026 11:34:34 -0700
Message-ID: <20260316183436.671482-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316183436.671482-1-robin.clark@oss.qualcomm.com>
References: <20260316183436.671482-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=br1BxUai c=1 sm=1 tr=0 ts=69b84d47 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=8lTVeMJbxB4f0FvlbnAA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE0NyBTYWx0ZWRfX/juRKy1WEP+h
 gLpCDk/SwlEhwHj4wsAMA7Tczh0W7731tA87ctaUoh3o3KypZx3SM/G3/1PoU9yW/wZQzeS/5Fn
 d/E7uW54XSg//NgYOv01MuhzmOtIsnppE4zvASvYpYRYbFbvuSyNH3rVbRPquaMlvRmy3OmHTKu
 hEG6ibZuKCFLgDLdqxDRUZFkAtIQnO8/TowBm8MApAPPCvi7Qwo3Jqis5xyNWmYUGIULR9efDW7
 oNJyfQttqowMKzjfXW7Bn1UBAP9zXAjkv/A5P3rLSDcGjSCAEWglWh692a0p8Flt03azYjkPaRk
 8rLO5I7iOSCQynohPUyGLJjh1wz7L8ZOstj/saY0Rtdjr0kXZ4i0EuUtGvCA8zXpJ1t6XoINnaJ
 Smi48vT/g5Aa1A9fHS39kvPLvMnfSmD3A9dcS8DnkGtHfwEDcmzYP7K+vwcmH3r8YOqZdSgvsl3
 4HKxc2hw0fK8+vomobg==
X-Proofpoint-ORIG-GUID: MQE9bhppzRiza_cDeuVMoD_3w1Jaauhn
X-Proofpoint-GUID: MQE9bhppzRiza_cDeuVMoD_3w1Jaauhn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160147
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

Once we've updated the chip_id after reading the slice_mask, also update
the GPU name so it matches.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 5a320f5bde41..fb1d92095db7 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -87,6 +87,7 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	const struct a6xx_info *info = adreno_gpu->info->a6xx;
+	struct device *dev = &gpu->pdev->dev;
 	u32 slice_mask;
 
 	if (adreno_gpu->info->family < ADRENO_8XX_GEN1)
@@ -110,6 +111,15 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
 
 	/* Chip ID depends on the number of slices available. So update it */
 	adreno_gpu->chip_id |= FIELD_PREP(GENMASK(7, 4), hweight32(slice_mask));
+
+	/* Update the gpu-name to reflect the slice config: */
+	const char *name = devm_kasprintf(dev, GFP_KERNEL,
+			"%"ADRENO_CHIPID_FMT,
+			ADRENO_CHIPID_ARGS(adreno_gpu->chip_id));
+	if (name) {
+		devm_kfree(dev, adreno_gpu->base.name);
+		adreno_gpu->base.name = name;
+	}
 }
 
 static u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
-- 
2.53.0

