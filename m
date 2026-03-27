Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ACF10AB82F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2925710EC14;
	Fri, 27 Mar 2026 00:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LMx42Wk2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fQgyNmHs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 036B610EC14
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:49 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QF9lBv1658558
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VOQ4Y62EHYJ3YJ61bmCQpHn6cJNcJ8k7qwN5aLk8g5Y=; b=LMx42Wk2pkKhiLzu
 lURGMjsEMSkxjupkl5z+qhKnGBEyLb0Zy0MN+QbzndxHJpZNjQXwbULkaoRnXd4+
 qvEb4qslr7sArzuOS8CoE72WOh3RHJCCFZK6daVJ+P65oYLsntR902zvsbEMEAsL
 CU2mTRibpd5Q1Q3cheQyuCboYXdXS7Tzg6D7Urz7WWw4lVJa5KIMMRgAKxuoxg6M
 GsLl1CPrO8lx4+yjCnlGR3krYlLDjulsluZ3izdu6Kr+VKA3CVNGT8Gdda9AGEj7
 sIQG/kvpiN3bdMyH4G537pCmPa3DcOsfvIkdxUVvcwguaTKxo3QblwbXxK4bd2Rf
 tcWWsg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4w1qc0tw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35c0abf427aso2102123a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570549; x=1775175349;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VOQ4Y62EHYJ3YJ61bmCQpHn6cJNcJ8k7qwN5aLk8g5Y=;
 b=fQgyNmHsMRvwbal6jHsjhFZ8ckkO2hDD4FkSSZMMb5LBcOZjnXgvWoqMvggYjyc+nw
 MggmY7WkepyCFuXKJT6Y8Iq+DqLCeTbt+YL5nM1ZPfeNNu99PsQMquofG1UO7yho+HjG
 DQ1wHUaOnJYb5vD864bv39cBsJnKCfaKoNRA6fz5ZD6j7l2V7T9Djus+K7hMvfGLjwCO
 RSFQTqb1tig9KSfCivxT1mWlmxtq2k+8ZvrbxEYO6qXs42Vexpn68umkrI2GEldAKsZp
 9gRjRmrX2VfQl9tr2sBA9QuVCekx0NAQVm7ldhu610byWz1BhSUDgtGx0DkwO2nXHJHF
 B5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570549; x=1775175349;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VOQ4Y62EHYJ3YJ61bmCQpHn6cJNcJ8k7qwN5aLk8g5Y=;
 b=n6vb3Zvk1JdLT5AprJTj2ULt9QTetxqy+9CygRop7g+H/yvMyZj7TJcEZB55ggnUzk
 ge2WpEzRJUNKbwzHOGX+EnicRIi6qNVOPjcL5hWre1PfJf4dph55mau4dSh8d5eXhtNI
 HHu3Zgc5VTlUdQ4N4pi6FW+YoqdDgUXr6lOyrTbxmYB0hbe3aTOTHkeX7frFUvL7jn4J
 n6oq7+0OLXbIkn+kbnl+fV0CSqscseyJ7u/cBOlk/jZ+1stH9kNO6VuHBRdncTR8+NoO
 8jSF8hUI3w3e+41PttuuazBNt6wcPGKrWBD9kjXk59GPtg4zBoIf1BsCNUDiu8MRA5Mf
 zA3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUioZOUoJB7DysooytdIDX1ZOC99nRqhfU/qeIQbko+lqVB5Qk0BTjAkT2lLYa+q19EHlzQjxYcu0w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDsRVk1iypJqy4yp5hoiIFGrNhnI9SQnbs5XzCzoyy+NyUxkLQ
 ilaeuxAljJLH95iPnNsGmamlCZ0miG+R1Tl6+kQ1+8quuuDYggHZ9c8Hk3InTOn7LsSMXoCsstL
 fHh6tY7AdDP/tMgvndzrkVsl4XSQr05qCDWux7C7y9FMDFZk29NuZpRtjibb3tghVQCjEOj0=
X-Gm-Gg: ATEYQzxeiv0oEOHMqx4YJ3xoWtb1s9NF239mPEz2DfsFwG1DGZgp8gBRmlO1lQrY4S8
 jUpwKYoauI25IWVI+4Q2jtqHZax8NzSesktvWtjhoKmglfFbUgNuzDiSgN+BOBW04dS6QnrzJwv
 vxtRupH597W8XfFfgMsgP6DVlnpTw7V1GpKtUUQFaluxkthUHR/4lsPBjbsHMbRGWNxxuGR7pKk
 g7dQwygh34s1+MrVehVAQbGt04i40JdcXfoXHyPXAXF84QmrWvofvl9yPpi4UpE4yas9Sd1f2Cg
 v4FLzu7JEfM8BgM1fQ1Ee000eBLq4OF2or4XyQD34Cvyb1Rn00YOakpITo+RvAQs+0WEeYjbVHP
 8FaiJzNrc5jHw9Mxlza/gl7lD7IF2u5NJz2bxnm/W9Aw+4Q==
X-Received: by 2002:a17:90b:35ce:b0:35b:945d:752a with SMTP id
 98e67ed59e1d1-35c30076feemr497465a91.17.1774570548649; 
 Thu, 26 Mar 2026 17:15:48 -0700 (PDT)
X-Received: by 2002:a17:90b:35ce:b0:35b:945d:752a with SMTP id
 98e67ed59e1d1-35c30076feemr497422a91.17.1774570548158; 
 Thu, 26 Mar 2026 17:15:48 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:15:47 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:44:02 +0530
Subject: [PATCH v2 13/17] drm/msm/a6xx: Add SKU detection support for X2-85
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-13-2b53c38d2101@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=1332;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=PUfJzyNArQI3h5XcBjXHQ1RFq+B5YaZxrCRhqSF83Jk=;
 b=P1B2RUowmqZGJeydikp1wJtnTK1U4dJUKCSowScytIyUjvaNcfYDMudWpXQ6wvb6M8KGzinjR
 hiEVcqoXKvHBueA8nPoIXm2FbdPGg8DFVwJUyrK6M7Ea1v57HJOATg+
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: HxgoJBypaW3Di4sNFnX1R3zTWKXhJR0o
X-Authority-Analysis: v=2.4 cv=HvV72kTS c=1 sm=1 tr=0 ts=69c5cc35 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=3_AEj1X5-8Kox2uyKc4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfX/ZOaNGTmd+3R
 i+PzlUGh2z0/wbhw0EgevIr+TKPkUFcXyOrcqVk97okymF7Om0bS4yeCqRWem/nWqBzAfLCmcUx
 Ps59ARc4qcGDs8OCCXSJha82EUmH74Ijy6Ni47UWcvAV8umhz3Kbab8LVXOjeTH8SJNNrckLHJi
 OB4KR0AGeKikSR8dN2dooWdlXtxgvPTbGTww0PZeFKTHpD8Z4WHciW7ZJFVYOdxxpDTn2KAffeU
 fAnB+gYhUVES36p9lcn+vAPLMGgwywD9hd6+17J9N1Ke9sGX3DvnIg7pM1h3xCJ1zOuYetMEVg/
 XoICvnCTQLCcftWi4cDQldchDAyX4oT5BtvZAacYf/OArHYQZLoK32KBsYGKf5Tjx9HwSv68Wa9
 6Wxa7QjsQw5RZZwNP1EvY8xIuxaCXS+LsUs+0ruKjvFFNWzvD/KzEvb4AC7q4dt/OXULCBwvRVB
 n4zFwCCGctR2TjBcmNg==
X-Proofpoint-GUID: HxgoJBypaW3Di4sNFnX1R3zTWKXhJR0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
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

Add the Speedbin table to the catalog to enable SKU detection support
for X2-85 GPU found in Glymur chipset. As this chipset support the SOFT
FUSE mechanism, enable the ADRENO_QUIRK_SOFTFUSE quirk too.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index f6b9792531a6..758bc7bd31f6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1902,7 +1902,8 @@ static const struct adreno_info a8xx_gpus[] = {
 		.gmem = 21 * SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV,
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_SOFTFUSE,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &x285_protect,
@@ -1922,6 +1923,12 @@ static const struct adreno_info a8xx_gpus[] = {
 				{ /* sentinel */ },
 			},
 		},
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 388, 1 },
+			{ 357, 2 },
+			{ 284, 3 },
+		),
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x44050a01),
 		.family = ADRENO_8XX_GEN2,

-- 
2.51.0

