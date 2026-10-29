Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652CC606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CZ4FsQGE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BFlfFvxH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43FF11251C;
	Thu, 29 Oct 2026 20:18:53 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E08A112537
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:33 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjXpn2102809
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QK2V0ULW7LP
 9ugrR40QAJ25MXENJhXs4M1ySCOtIhX0=; b=CZ4FsQGEN+P6F1229Rha5XiM/C4
 dp5HvPnCQThF0buZ9fZlDGWhTANiNDt2RZpnJAnpsAuIjmYMjxMlBICy4f+w4+uz
 mpElpmjJEtgBHP1gd0SaM6wa+kjZUlYWt4gjkzWcRgZXBjLILh0DpWa6banTSgdE
 VKsukQeJbTOeNDFtyIzpFMmChSRhH4RkClka+yTsd2cTFbAka3mV8OGZLEZy374f
 l09Jc0XpPCzhkx4BckMrzpY+ysGZrNjjz7ypFHewgoxXlUjfJl9A/lzPlg5dQPo3
 g2yREVd6+26cV41a2wyASfI2+Rzb75O4RcLvb3wk7D5moeIdv39DDLpacHA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44qamxu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e60770381cso273865ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305112; x=1793909912;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QK2V0ULW7LP9ugrR40QAJ25MXENJhXs4M1ySCOtIhX0=;
 b=BFlfFvxHeDAHQusaedokjW5FaMg7tEtd8wEyi0QtXqmbgIxiHruOczQqH0FbZc2YsE
 9nYdE4xGHMkxTrX86wakj5wrgZK7SU27N2xT0q0QU1TZdaSPmymOl5QYJUv1Kumu1zEw
 CfXo8FjkrWaCDQ+wOHU0r2k9gYOVuVJpv+qT+eqgejvg16Pj7C95qbB9mzNPwXx9XZcy
 KJB44xbRX6wmx7m8SQugFw0/dkUurel1hItUyQ21sytjEKakq7QwfGIM5dK2F+PVWfZk
 h28iGXB09sriuuHb7ayoRdb6/120fVvb3BRmjusZlF1VXCrPCF8nkSXDAVdfhE8KFwA7
 5y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305112; x=1793909912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QK2V0ULW7LP9ugrR40QAJ25MXENJhXs4M1ySCOtIhX0=;
 b=aRaZJTlpJuWFhFlchIE30WMU9+CnUbWdAOjkenABBv760BGbf5zM06VQ1ASruLCNBe
 +rrEPJ4PVbiXWSmDLI3ggDy+gOHNWXlkyiYAUipLBl/Da0Zd6i9zUJaBATJpNN9ivsww
 uca46i1IIoZDbmIpxE8yRzp7SubAN3lGXZhlyhgweT0fizYE51+dYl09WaT8SVYKkgyU
 Jcf1iRko1jfguZGtOY5RKYCqsh685cW0eTAne5yep6FU8aftHzpfeB5hxlBwn24XrRUl
 7re2mWY3GzhJgmUrHByvfHOp66TveegE+CPqpv8kga0A98+w9yUpWqXYAqaijoFXUjUs
 3v5A==
X-Gm-Message-State: AFq9FYJY0nu4KJdiWMUU6FXRjGUIr95dji0GoGt/GboiaWwgeaNzQs1+
 MsAm780xcDpNtyn4DFntdF3jcOwxLvZTTLTE7WDcXg1dygoymKUkMO1H5lyaksK4vwUsyKH1TL4
 4MK40jfpkdjU5WeLMlLh6z81HOd3jeBBRYEgtjr71iZnVAIBSYTAV99Kd736NGep0WxM+z+Lkm2
 ty3UQ=
X-Gm-Gg: AYBFou2+Yig1N3d+a1B6tK1PRcmxtow3Y2ccZjMJEdqgZwTNLyeYwZatkfR5PAfXmDC
 tATd0yEb2fBox4XQo6Q4QtHysRZYPnHrGIOwBbWnlftB7b4Us/bGdzFIRhBULe3GKr88eJao/qi
 Gs7tfnbl+8WRKOQ0HhigRlw+sBiiC2OqcenrEtKXR7vOnDiw59oRd1coIyn6y1TtPoDIbMYilec
 VQ84zlMjIcICLpZF2yX/Nj8z5mfVT0fm3j7/RBxqCEMJoCtMah/f0g0qUeQ/H5e2k7xOVZlzUvp
 G+8pLvqSjggVJAV6xocRyxexiMIabVssExZRL6E1Latcq7EEMoelm3W2dX7CbgfCY3kJcrW6h6y
 FDmW1byQe0JQQ6y8ntqGVG8Nef7b4vJpzoG2j5PcgffEI3VSFLdfkcwJg7p1Niir8QnabXQwvC3
 bJ9x0k3pRepSFfBuLLyQDGbg==
X-Received: by 2002:a17:903:1b25:b0:2e9:6972:54d2 with SMTP id
 d9443c01a7336-2eb3649bc17mr4538145ad.12.1793305112544; 
 Thu, 29 Oct 2026 13:18:32 -0700 (PDT)
X-Received: by 2002:a17:903:1b25:b0:2e9:6972:54d2 with SMTP id
 d9443c01a7336-2eb3649bc17mr4537925ad.12.1793305112136; 
 Thu, 29 Oct 2026 13:18:32 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb369304efsm555475ad.29.2026.10.29.13.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:18:31 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 16/16] drm/msm/adreno: Remove temporary __maybe_unused
Date: Thu, 29 Oct 2026 13:16:26 -0700
Message-ID: <20261029201730.151754-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX5ouB4IpW5uQT
 i0fvUHnoBVQiM5HiGB8LfbF+FXoeRwdsIpfsfEN7dhRMYtwMjX3xlgp9OTtZisIKPxjJMw6n86J
 5mzbjOI4jLs7fgk7u8oAgY7XaVKbyoA=
X-Proofpoint-ORIG-GUID: AnPcmRyGwcFBwiyKRdDpA-Pq1drVuRzY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX200Wkp4d5zUq
 nKaf4aDjvR8KWxhUXjbxnub+7d2S194rRloncFhxOdrgNqfBoapJJoXmrdbXu47VXF1h/srNZEV
 umHYpuVrnfbfRM64F0i9ks3Zkxk+UNUH82TGRvojS6u26nAmw0UrTCjJ27b1Orzy2Y7d46xofPh
 gtDmwJ1d3A5li+D9ZETL8ZG13eRt7ANBBhpOYjIUyYTVUeqh05+A7yR8S5xCylmqw/VL2KvGeOR
 A8bzWWQr4WqU1NO2I6UFe8d7UNaWUmdHK5iL8oXRWtksAYNJu3pp4XXWWTz9+1e/B2zfMgYlU5D
 Xuae75ShMPMa/6XqB9aR4wf4SZhD0HNpwwmbnIs4sVvE1iRB8y66q+KnMSeUPlKTei4hHp822r5
 9WTbSoR6rdrBndgT/xTaJZ4HeMYg0UO8nRHmulngmD6CrIfz5kYf12n3iFr97KUw9V93oJw7qr6
 C2jBxO84MVYpSFoT54w==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae3aa19 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: AnPcmRyGwcFBwiyKRdDpA-Pq1drVuRzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290079
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that is unneeded.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index ed83dd927b54..3ef3ac2d86f9 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -170,7 +170,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name __maybe_unused = {		\
+static const struct adreno_protect name = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

