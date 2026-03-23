Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03FAF483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619CE10E43B;
	Mon, 23 Mar 2026 20:13:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hXeIWAQp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BqPmyrrf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4ADE10E43B
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqcAl2831909
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6h1GbkcqRvODh/gp8Mx0/sRdMg7ZV4RUJ1froSrMVMQ=; b=hXeIWAQp4tXKWM45
 T/jZ4fs65SZJXFX59Y8kgasgcFUANVPeq2RnqxokWA4XW73kug81gwq3n4waBDI9
 fcS/RTvsjHljE0uTXT4UVZYVR7mAd9LxJ+SpNkQOpvfsgJBUkG0xBQuAARWhNUD2
 XVguUzRv/AvZ9eC8LzYS6Sn37EjcvpotP9sChM1U5IMs/HuQN9fsr3s/njNXwNFm
 XoKgnKz3ZYV0gb51jk9sDSzuEc7jRLgGLqyQT2vSZ7Y0zFPKiHfa1vwazoG0Di8H
 Kr9KiMctN5vWpAX16KfZHUqqm5YA7MMN2eO6sXJKsFgRKXEsOy246l4Dyb+ZgIK3
 pji7pQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d364jsgp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:43 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82a88a2704fso2151121b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296823; x=1774901623;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6h1GbkcqRvODh/gp8Mx0/sRdMg7ZV4RUJ1froSrMVMQ=;
 b=BqPmyrrfCIxkFQJD35wBpjBP11jGbTRB+yG9Z5SpHQXCLqeVRHMhMpYkIOPBbdMuYE
 6WtE8rgZ+voqXZV97ONcRM9G7ZVbOjTZzwvIjkgKDQW0oJJiJAbNcGE8vB4w7/5t2maF
 AE2d6NmrP5YYpaXoBcGsatyG92sUDHSsGj3toZ7y+7OwWTIdrtYvB3qhFcF30JA17E7/
 4uhKJOtY8kGi7RHwvjap2cPPPL9nK+3pqQyvHm8wyyP/TWZ2vJ+OINCyU6I+Pdh+JEWc
 WIwcJhZtkWPs5KURUx0SdU8yPT35I7LDhY/OAwMn1T8skpDOdMAvLs5MwZVhZBmdgejy
 95Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296823; x=1774901623;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6h1GbkcqRvODh/gp8Mx0/sRdMg7ZV4RUJ1froSrMVMQ=;
 b=UcAfktEDzkO9/JPTptpgnXJfKnNiCqBPmcii3hmGGI17s3dz0g64jwSTqix33TBB1J
 1lus+M3va5SBxzk3QWo/S6BxwDeBdyjL/yzVLzwfxeySYtmc+gLwZTlea1kAXhtun7le
 jMe1DexAUyQqnJqi0lZY5zVd/HNRb8SdFz2XL2GGKgbZ/JzP6TxSe4MRc0mEJ+S1yOO6
 IhZJ2t/e28gazOAkeNK9+Vi5Bz9wm2JdZ6AI6C4mGIWZJP2Roegj74mwRF5v8ChHhSxJ
 hj038qJkeWDUvoC4kbrQuRnrZbyshTaTFFppO7S465cHzEuh3SS655gLL1uXp09gjKsC
 33EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn/M2B3XNtjELiXob0iGauglUy63tBJC7QBWMgoaZUaE3DLPPliw66g9HS0B9NfJTDZ2QkccctyIQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyp+v9VE1qCMB+gMSCIttQ1mv+TkFbMJ3SUfDMJ4CW13QbWOJXu
 1cufsF0VGjG+9MC/S7635D4g7mrnWhZh3sJTUZcsnvVJxdHgZwWJkxnAPuqvEuocjktXBOW5ifE
 6GngnbkXfbCsYbEMmqeaq2SzWjbBUkX3OBaZIZW+iTKHVIXPiRkMID/YeeoDK2Ab2DmGhYi8=
X-Gm-Gg: ATEYQzxaYsLCGVJtRnybJGDIzrtLbVUquJjaDvZXRLgZ8Sh+Zei4gPvj/XtX3EL4Ond
 caKmLZM8v7TMU80RGEt1sDBKYnR92C6UcyaJ2+X9ObRyB35DfVmjGbXpdM9C2E3xI6n81t3wnnu
 wSpc8vzEi99Nu+/f2hyucoRFhmIOGRPi8Q+PAxu/30mDz5vEo5c8opwN4dwxIYrPU43lmoULos+
 aTlFHBrMlRqSQayzOA6gR/jbcJRInEYJrYY8O8DN8ai34XVgbaWbcBRXlqyz+vCV2GhBh5+NOaz
 4zasTEHe9CHGcw0iL70awqEOuDNjVMeNvMN/AcCzCBh7OebGaeCBc77dTEWWf8dc9pUch0g/vhP
 KNlNdaboEXO/QDZ8JQB37bkQHijvgzZwDBo9A3g4U42JTag==
X-Received: by 2002:a05:6a00:4205:b0:82a:14db:68d1 with SMTP id
 d2e1a72fcca58-82c5bf3fa3fmr615581b3a.33.1774296822493; 
 Mon, 23 Mar 2026 13:13:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:4205:b0:82a:14db:68d1 with SMTP id
 d2e1a72fcca58-82c5bf3fa3fmr615561b3a.33.1774296822025; 
 Mon, 23 Mar 2026 13:13:42 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:13:41 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:23 +0530
Subject: [PATCH 11/16] drm/msm/a8xx: Add SKU table for A840
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-11-fc95b8d9c017@oss.qualcomm.com>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=805;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=H5UIoWKcwOAS+auMl89W13gGP8KyR+VgG/pl7Eqs3ww=;
 b=TKJvi6RCo2aYUyZ3p7K/BZECCtS+cIhE1EkWZuqvmVpyQUApl/uOvQm2q6V3bOBVRiZsKkED9
 4uyowwPNQsMBemb25MWQI6R5es8SS8bmXShzUHHmHzoc9KqllrbrMt9
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: eedBHUbrpIc_gRIXkwT2GSPC8IsMFzVd
X-Proofpoint-ORIG-GUID: eedBHUbrpIc_gRIXkwT2GSPC8IsMFzVd
X-Authority-Analysis: v=2.4 cv=JcaxbEKV c=1 sm=1 tr=0 ts=69c19ef7 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Ml_BBXNIZAQcZvYyiGwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX6rvh8XbpOF9l
 h27OksxWtkJdfmTyUXkwxzWZyUkvBWLg5OOFW22t63BUD1nWNWvTuZ4L5U0FOQMkRBgUQquzbgD
 oExhYJLwwStaGFsq3lCVdL2xL1ftA8O+cDfa4PBHOj3YA422444ZRLoTlqkKaF9z3EZk2rf3wbg
 UXf+936sHNiqzQ/6B9fyqolPlCY/jdi4EUm4y4W7YLWaymUsjeosA8eSGX9eggGWyZ5EtUrlWVC
 YxBjDYHXIwNZlQFeDZSMCa/iadWmX2fA5UXFkO8Li2mH1obRsktCRWwtCa78ek1mLGMNzH5NJEx
 BsEPchL8YB8TTRE7Sf3NkhqYNcSfIInfUCb1B34SzTVr5a7tr3sLelmY2khCtx2fUPONNHzwiDo
 p9/cIy/Qqs0w1wZWZ2UB9+xo+MQOA6gkLopYeOcNPR4tFSEX4366k4i9KCzkBWHbpU21CB50qs2
 B5gmopd49KFgWT7YOBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230149
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

