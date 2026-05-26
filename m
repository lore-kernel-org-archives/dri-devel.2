Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C367CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B542B10E65B;
	Tue, 26 May 2026 14:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VI2S3K6n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RamN0txi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F3010E657
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:24 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QEYDlR4030433
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iwPf7oJ62+a
 JHGIAyfRJce0NdbfHJ0BsASuIH0Plg9o=; b=VI2S3K6nHKlEbs156SjW1/yMidc
 mg5tANLUmrcTsHCI0yU+8InXIOYzaqban5S8h466Oni6xFjUbf1GsYHq7HeYTetQ
 lZZJw+apzAKB/WfeWLIviTsqqYTzXz9ReMHUheG5ayVZYd5+jcKS62U4ttCJpUYK
 YsowBDDitXQFxnaf5WbZJgrG2nRCq6M5bFU8kJsql3mlirIi1eNmKn2ZghS3WW6c
 nzYFFhE0rPhFLM53O7+7S7sYXZ+3A2hFOZOJv5saMZ8x0HSsXaaR2+yM+A7DuoCn
 602+pWn9rZKApeNoepfsnsPIbC/kYVP0jqQXVoipFYn1BQgm//Qf9keWL3Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eddd7r3aw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-366344513a3so21433984a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779807264; x=1780412064;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwPf7oJ62+aJHGIAyfRJce0NdbfHJ0BsASuIH0Plg9o=;
 b=RamN0txiBj1jQq3+pZ3/OO21+xlnlFuh0SklqeH/3r22MhbvfLqkvSfzqWyfkikI11
 AS7WfhyYAFBHVRhHHGd7isO+OT++/ibX/Sjey3iz3427JLGJJnr0WR0gR900PcLPfXLN
 qIWeqopetYyZbJgLwEjQap6hzjzMitVk7uk1LeTK2fNJ57dV0BtyqGhMRwZypevs7v/n
 o3tGhQ9x5MsbejdR2orbVhiy60a6bHFEmUHxjEwNxBhou8PAKNjk9hLtqfMrDw5sV978
 iMCyBEx/pvc+Iy79/fVR847NL5XZUZLOgi0k6/osRXe2guGv2VajIfkW2rKLK9eUTkz4
 GUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807264; x=1780412064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iwPf7oJ62+aJHGIAyfRJce0NdbfHJ0BsASuIH0Plg9o=;
 b=TrpHjcBzgsNbr3VHSsRnSZAaNMkcCrUV1F1WyeN0QyEmt7qYwWXOP+YyZyLVQVdgBo
 tJe1Z6j6zaMQ39SMvAcxXJ/YIFyZr8y3JFiE1+YSEemfJv4CuE7a0CHjJcmPLHfEYAZK
 Q68BmR2kjz8QnMtTMgoTe3JGkJOi+gs5GMbfiLS9wyzds4l7yuzqFmgCj+IGW0zglX5U
 nLBmf1WzsKSU5BFtZwVg8UIuzBH3n1Ms0f6fSlySIPn9r4Mnk4twgV/9P+JAnxqMLH4j
 3QqqPh806yXDc0B9b8NptKGA0SrkhdXR04HwyVCwZZET9Bz2rR2fVEIGMWaTMT+HYYBV
 Az1Q==
X-Gm-Message-State: AOJu0YwYZZiwNxpbpSQU3tbnKXuZ0cm59ZMM2xPSe++zpWr5Mk7Ssmlo
 qAymzLTuC0PpgJLoSCxWuET3oddDGjdthNtND6tPiIj+ToqfwRrWJl2jHYh0xjA4t4eXpaBgtSe
 7F1qlluU8AS+1S+JD3L+iDWWDMURx47CfeIAJVvaOKYGMb8yAffrkyvgnsDuqavW5l7wwQnkZet
 Xllps=
X-Gm-Gg: Acq92OFLgB1RzuLGeu5NizHS7fzq12FOYztOzD4rO6cm5HOW1XtcIWo0his8HNvAWoi
 rr/X4cb0JLNbjBxTigMD6w+SjRyq5Kd1m68gnoYknN/lurAC3fjzDbVbizthePwNhVcjS4D0ghM
 xlos671DB4iai2POqf5s2fbfb7HiEiHq8IUrRWeJGs4MalQ65+MLfkU7dl3/jAroV99lkh9+l+d
 /5a8ZiY/zw+CfgwYS9uHZyrjYGVJrmqaC2j8eLusgXpg489ZKifK53rISF+DVnSKEb8jErX0Jht
 vmSzD4i1RUb5MkVHwQ1B8yAcA/x4zE5AL2DOA4g9vtponShauWmBL+mderkkW6n2cXeZ0jCBFEx
 WoxKsfM68PNa4V4uDLl9E46cQQNgHRhIa
X-Received: by 2002:a17:90b:224e:b0:368:b917:79b9 with SMTP id
 98e67ed59e1d1-36a67658122mr19483166a91.25.1779807263681; 
 Tue, 26 May 2026 07:54:23 -0700 (PDT)
X-Received: by 2002:a17:90b:224e:b0:368:b917:79b9 with SMTP id
 98e67ed59e1d1-36a67658122mr19483139a91.25.1779807263222; 
 Tue, 26 May 2026 07:54:23 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6d810772sm5764136a91.8.2026.05.26.07.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:54:22 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 14/16] drm/msm/a6xx: Increase pwrup_reglist size
Date: Tue, 26 May 2026 07:50:48 -0700
Message-ID: <20260526145137.160554-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
References: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfX60pOIelYcj1G
 sg4oTuoFPCUenr6uVWtOuT0MW7kk9RfvHUWU2XyZxSl/PWEPcFaBXQgwgjy0WbguowtXeLiRp74
 cwMALxRofSVQk3qQ9v7pTmZoyhG78EpOKWksC6YPCDFOtQx4CAA76d6KWdCCLetqLXrAkD5zhO0
 0pc6mb2cJ1M1A7DPYSwBGZv7bHdvXYdjAlzBurdW2ImboQRoF9MpnAwsjvZ54p8521f0KJK3c+p
 5m6Iql0JPC+ruAbJydhnos6Jq5pj5LnZD2wMgmSHrKVejvnBA0jFar+mDmdDX+5mVyWWzPhuhpn
 RgEx5Di822h768XxJFUlPjbqvOjCqRJDbnl9Czms8CsT1cgoaejdv7yn5PnJTK3935AYvmcPXvC
 1w5wMZnBz1RSOwDz8PkZ2gzX/8RRbCh27qe/5jkLZ9qjjyXmqF3cU7P+InN4yCC0DE3bbBbUyS6
 bn5N46psrsej7Oq6juQ==
X-Proofpoint-GUID: OOLKW_hSGmGYKQf-iEZYKpNxKfxF7M4b
X-Authority-Analysis: v=2.4 cv=fKsJG5ae c=1 sm=1 tr=0 ts=6a15b420 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=QVKJPBlc5dbYwvk_-wwA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: OOLKW_hSGmGYKQf-iEZYKpNxKfxF7M4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260127
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
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a329d20033d7..e6c362c55dee 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1183,7 +1183,7 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
 		msm_gem_object_set_name(a6xx_gpu->shadow_bo, "shadow");
 	}
 
-	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, PAGE_SIZE,
+	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, PWRUP_REGLIST_SIZE,
 							 MSM_BO_WC  | MSM_BO_MAP_PRIV,
 							 gpu->vm, &a6xx_gpu->pwrup_reglist_bo,
 							 &a6xx_gpu->pwrup_reglist_iova);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 3491a24a9320..d3f0b40787db 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -96,6 +96,7 @@ struct a6xx_gpu {
 	uint32_t *shadow;
 
 	struct drm_gem_object *pwrup_reglist_bo;
+#define PWRUP_REGLIST_SIZE (2 * PAGE_SIZE)
 	void *pwrup_reglist_ptr;
 	uint64_t pwrup_reglist_iova;
 	bool pwrup_reglist_emitted;
-- 
2.54.0

