Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4015CCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7A610EF58;
	Wed, 20 May 2026 16:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="e5vmkpD3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xx5FdsAx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B9110E7B8
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:15 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KEFZsB963711
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uZWxbq16V5d
 ge8U1KgQgWh7So4/tb8nUVOkQSVzqIs4=; b=e5vmkpD3ip1sUgb70a2Le9d6llb
 VQUA6OScKKmhdyq69OzkO9ba8UoJMBakH2J7V1kbk4g5dbWNUstKfq0RvtsKbuux
 wmffrNMGIm2ncR8iQ7S2/KKuy6DPFbT8e830RHXthlhALeywM0asQgNOZ/0FlfLl
 kW1+0m7POayTK3TzRBFGBWdOU183QbXDAKAO3uJPtm5RUnMU8mvjp8f3G3oUTNx+
 yELyTAyqt/uw+AyblFYZLtAa4HfVE69dG6bkT9/6lLlcvijhETgwQofZwQWD26wB
 CXPRFC0+vWLNPoWVGS+859a84Fi5izsu/kNKlCBilHsboMawPF3k6V/wRgg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ejh0jnu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b9b8137828so52462805ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779294314; x=1779899114;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZWxbq16V5dge8U1KgQgWh7So4/tb8nUVOkQSVzqIs4=;
 b=Xx5FdsAxUvy2EyHPxiscggQCI+hDo9StL+xlgplyj5kIkQEzZuIVNAVC7PoBGaMJ1S
 LoyvNn4FeNGhjN86SW1SLQFr3ujX0Vv/2xIKPbWy8cX51Gq7A5doPO+YqBdx2imR4WeR
 UqLptNuDP+OanmfC0aIgwj/25RxxZ/pjy2WWtoD1DZN9ikVb3epRkERhbyIPlFc5e91T
 wj7d0aEYCxpfb4UBscdYh7NTebDd7DNF7hry+K/DERE79NK6fUSgGu033sjySYrpvjAB
 41/zHL85CyNpLZubP+CISBj6UBvXU13kTh2SH2ReZpVJ2EZvg6AeumLRrJSQNt0X02mS
 rF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294314; x=1779899114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uZWxbq16V5dge8U1KgQgWh7So4/tb8nUVOkQSVzqIs4=;
 b=VGHpNABFBfhnukWJnTwoSNR8o90k7nasuVbsMT1t/xfV9eOVQjwSBTdTJ4heWSyEDp
 2mFUpeqi6GKPSkFfwhxXPxXQV7//qChKdFPBOY2Tw0pDj/CBpLFFuPuTL/NgtaFFwHYM
 qJAbJ6UQXc9oZNIrYq/T8Ze6BVZfTbsvzH+GXs3JhV9ShEkhZ0BUQgaUldVkWT6Rfbz3
 LjAsVvGCapKBLwXz8cCT2gUH5ZJqlIslMTuXGcgsdrjI8OuSc1NY9UOh5K/bxhIiYTgC
 1Sul8/qRjKLBc81C1kVh2TIhvyO+7clqo5h0t4dNl79uLgppu5ICRPrPYbSKo8zhzuxC
 d0Ww==
X-Gm-Message-State: AOJu0YxU9aXvIFfyOm2MSqhrSLWkwM9npkvIJvcMWgDsUfOqExHY/juk
 XGh9e4HM6t8Rpnd456U5PDp3bNGw/PXeTAh/+EORfzTpzhE5ogK4A4zb1p+SPlKIwbOof7r4Srm
 PIK0jU7EuM8IgD/ha/JFv9YmGjSXQvr32CTl06FZtF7vIKZ15XFw0Kx69q4yX6KV4O1huToZfq8
 F+99s=
X-Gm-Gg: Acq92OEB+pDi/uq2FbpXMfrbIZq4NOeFFmm0cLskHuiJg1mUBTj3AevahgpwAGnVh1w
 MjdhiFyMO0FcLYS51yXjnSb4ReB6wi5/e/KIsc7Wzs9KKJkjV0NXYNoSzz/d5Irb6j8GfYY62GE
 TXrLoc+yPhCn09xw+fEODJ1QQfPydWqveXUbdoRuJyCE1iqXWWiEemsHqh3en8XDeSsQalPRdgP
 qArhD2+xwZhciRi1suAcFUtUh526XE8M1mQnlh4k9w2TgkWzwv13eAREwWA6mMmU+Aufs6A0WFo
 3TXAbNJEztYm2vxIlVSYvk6mJ3893qDSwj2aVEZ1uN8F21+B/Vo9aGUsb4Z2ebQ9C70skYl5hz6
 4DU9Wrl124opCqDeu3WYgBITpl9xTSEmQ
X-Received: by 2002:a17:903:1b45:b0:2bc:ffe1:c380 with SMTP id
 d9443c01a7336-2bd7e86c179mr244499025ad.8.1779294314132; 
 Wed, 20 May 2026 09:25:14 -0700 (PDT)
X-Received: by 2002:a17:903:1b45:b0:2bc:ffe1:c380 with SMTP id
 d9443c01a7336-2bd7e86c179mr244498675ad.8.1779294313543; 
 Wed, 20 May 2026 09:25:13 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d0fcb10sm223508635ad.60.2026.05.20.09.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:25:13 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 02/16] drm/msm: Allow CAP_PERFMON for setting SYSPROF
Date: Wed, 20 May 2026 09:23:49 -0700
Message-ID: <20260520162454.18391-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
References: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QptuG1yd c=1 sm=1 tr=0 ts=6a0de06b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=RIk3oTIWcAeXYnX0VHsA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1OSBTYWx0ZWRfX1LfkbS96Uq9Z
 X9GXsLYgLIM6uMweq9PR7+V9MIwhFbWlwDjahJ/oeOekTnMQ12VqyscxdSfigy4MpXku/k1OpUi
 lrbNGTQQVlZ9bVApk+wTnbv6if3ozLVaD9jrmkKH/qbNxFyf5xz82JkX8J7JPCpOrgfmpmXXztD
 0kJQ72WWBWLTwnUC6EeKbKIkj9HI7IQF978JAJEXcoBIlXkDqk6oS6FCE2Di3jBUfbs3OgOtmxI
 urk4D3Tdx6RLO0cLnmDZwZTKSQ2XBty1EjpK8sNaD6V9h0QS9x9Mwf9vu7UcATv4/iOk1zM6KCk
 D9d4T93VetkbYp2QY8YsMhbtMnszLZxH31Em15l1nZ8Ytvwpsqx6tsv8hp3MmOXCfWnqybkHrei
 5773vHeKG1AxXeRBvjQTvD7jLLaLIePSFvYHDYBSGIKD80UO3b0/7hmRc7UryRyYwT5ve212AAT
 ztYlb5MOBm8lis5+sKQ==
X-Proofpoint-GUID: oRsKojnzGyeJJ_iVF7nTup70VI_cC-at
X-Proofpoint-ORIG-GUID: oRsKojnzGyeJJ_iVF7nTup70VI_cC-at
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200159
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
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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

