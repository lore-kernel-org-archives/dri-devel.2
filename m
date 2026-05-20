Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DA9CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BE010F0B0;
	Wed, 20 May 2026 14:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RcCYMzXD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gqy0fFuw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D340710F0AE
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:49 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE2Kat826517
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xWNkreogDgXnJx39ZIn/sBhL4UymnLJVUI15wuXrdQo=; b=RcCYMzXDXCroQXtv
 CPT1j7M7x3kAbWnIPSPw30K9Nh8G4g5W4yl6SNkmb7qFAhoKBVlQuffR25hq+Pnf
 SOpx/4IFJuK4zVeMFtEr4nyxG+8bkCaOTgeu2xKXw0Ey9jHFWiL7yo6b2u2+dl7h
 VVqFzvlCeOsJEQPtAHEf+K7SbX4qnyslScjXWLjeQGmZnA4HTTjVCJ+rGvVsy59C
 niopaU2bNyWWyW0gL9ZAnGUBrKNV0CqrWR0XxdGL5WjzWdepZJiPaW+8ibHmRudz
 ccGCFizVvjSYF6BFy6gODhN+T6mRq7ZgcqvD4bGOYwEpZ53LDFvtpAmZvKsWPjS1
 yZQzDA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ecag6fq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:49 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6314daf0053so2608222137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288708; x=1779893508;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xWNkreogDgXnJx39ZIn/sBhL4UymnLJVUI15wuXrdQo=;
 b=gqy0fFuwaYjMxYCag70D2XnJUEID0pRyAMF4e/hKlEREVzZfnGTmxhBot8Q8YCshQ/
 oCOPaQ4Az30pkGPfHOQwOMIpg3iZeFMvUWVjLV85K3qX6/fspSC3ZuRDSp5fXbftdNdy
 qxQK8cvVi+xpDQOrVibM7eOyZW8+3v6iq6tQq9PB3X+qvehTptY3n++ADpYvhw48/QCc
 681vDvcJ4Sb2HbSqYx9GIjHa6R9ZyA8siOEfZ9v1A8/dGPDIiAMA7AHFkGTHSPnmX9Rk
 je3ueHq0oqe6NCRjUa2MNnkFVrdQyPpiw7e9l1qW5SCONKw1F0EcO4xI0d87FHQf61vT
 cNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288708; x=1779893508;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xWNkreogDgXnJx39ZIn/sBhL4UymnLJVUI15wuXrdQo=;
 b=sRFEPgd6zXUQmnNfKukG70Uer9W7Llb8vR5WGUI6A/yCSLqaMvL7LegzRocPu6v6hk
 YLWsZ4hKBVHpDhI+eGJOZRuLGjReIHMtmBqfGrYExBLSXIWJoDI7F8x7mF5jwE6877+H
 EqINirYTzMCnFWofXV4K7Mc70JhdwXI/hf9H6gwFIko8+8ksfQoifaHooKpapQlwS0/4
 hWA1T8FEvxZmZ5LwLDi9SIY9/+iNibU1+aCNTl0PggoPshSkAzCtQXboGh0PQRx/Lp9w
 waT09fjFQQa5GTy39yCC213FjeCGaDXQ1GS8w8b0q71KDB7Ftg7SfFl/jEabUk9Vv/8f
 GjBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ87m/5pqgipmTw1h7mvJMWS1eHjzttde2H41lHsU0fqF29IIVm37mYZoXwIWE9mN2Wx8UhoUoKJ15k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHA/Xz008jGlFepxzyo1SHrUehiT/QYsF163RP6rO8/u2OKtBG
 NeTEqcegedq2JkNBjFcWFRB7ysn03PZ9rW9RC7WCqRDAj/5/JmgpNpRxwYY/hXfIQK6Bi4ZJGMo
 xabhPbdtgGw3ZvTBkkjpw1usdMZ6CmLLhUchpdFuyOQlm4BTLuYQyZfZvjqS0bGmA9mseB4o=
X-Gm-Gg: Acq92OHF0fE/A0T5lqUvewUlHIk79Ugq0lMVOqLJxRkOzR04ILcyVnc8MxP1Y/3OaAq
 RCzE8/V7Ia958Yuk/sJok7EuLn3y3fyX6qXGnmLaYMbk6g/O/NZqjMNSEIqYXVLwN4jdjbqxJN2
 YFK5/fHVs3VjFRLr2P2qWUH15Pd8ANE584ISJ04bPvkuWG0SwltWE2EOzlPlgf8f1wpa+nMJ52r
 hHZfGm9UdoUQjESjuMfryIlbitfo0myU2YVJFPn8UmkMjTsOY/Lb5Dlk1Oeo3sz4UzutPX6G3br
 yxNaJjmlxNpZQtW4z8aoF/EI8Da3WOgJk5smxOJ/S/CRVrXMuBSJXx+7o8TcWPy0RIt/d+RXv73
 05sPiiA79YSB1QGj1rv80nhwnbVa2HIEjIc1THpthykORMVRLAKrWLBIjUfGMWcHpAfBhNqyxxP
 QMio2/lM4e30cNA6Hgv8ByJv3M3nyD88Hz70c=
X-Received: by 2002:a05:6102:8083:b0:633:e67f:b7f with SMTP id
 ada2fe7eead31-63a3fb9d0d6mr10696864137.25.1779288708318; 
 Wed, 20 May 2026 07:51:48 -0700 (PDT)
X-Received: by 2002:a05:6102:8083:b0:633:e67f:b7f with SMTP id
 ada2fe7eead31-63a3fb9d0d6mr10696847137.25.1779288707816; 
 Wed, 20 May 2026 07:51:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:22 +0300
Subject: [PATCH v5 15/28] drm/msm/adreno: write reserved UBWC-related bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-15-72f2749bc807@oss.qualcomm.com>
References: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
In-Reply-To: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=968;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=0CsJEQgFxj0TwGdynRcKHH8T3xjv2c9Vfkj1PubtikM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQxbvqYxadaG5io5X525UXejLoOa/hZE1rVbiauLq3teu2
 r197Pc7GY1ZGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjCRl+3sfwUiNkhGfZW9nvC1
 4WhJ6uVtV50CWXpqXrAufiz85Z+y6vn04AmqL1slToXnOry7mOa59FiizJT93rvNn6Yk3fda2JV
 dITtb8HOWxbclH2Y/mN9SGWOql61gsS2Iqf9NzunvnKcPh1SctBR16/U0Pfqo9bSC7w2NyVbL0s
 X2WC7OZ7IXFXhpfspFOa5BYVrgzInxTxbwxVrsSl/ycgaj5QbZW+tOmDCvE/D5ecft7nrXBUdzs
 6JSnIJ4fu+RvuyycdO/U5ozbaOs6xn6axazqbZfl9sVK2fkuNK6kDftrTBPpGLiLHWBVys3u9m8
 2rbWcerRy+eC2G/mbp1slPKdffmH1r6Wpx6qMd/NyuQ1AA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: YJWSvmXmlLkk8XyXcBmyTh_zgKnCW7-m
X-Authority-Analysis: v=2.4 cv=WqMb99fv c=1 sm=1 tr=0 ts=6a0dca85 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=jQZLqUlzLjo5U5EXcnwA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX++X7JstQlS5X
 wlHB1keZTZT4DMjRpz7zWmaPAEV1JWke3ERPr1Cs6AeRAYqArY9fMPxzeSy1rxD+Jdz/+dV7rET
 JyyKeYkyD+Rnl3iP3xcHhwOwAUuNoV6v0RroDqn/BPTBRqSjLI9VHHVNWPH/Hev0rtXtAs24keo
 Mae5/uApE6xBUyAH4sJIXOYlAcKGu5SqHhS64eW2UvyhY3kScH+RNLzrC0GSChQiXVqPabNeNsZ
 Fqcpk8HRi9Lo8D0wI3kVwTdCpHFWBKiO83Y7Ae1i+39crng3wTEJ2pWe+/ECT8fjI3oylTTCagf
 8Dcp0OYyZGz1KgRCWMF1quI72oeFm+21EAusAr/7a1gNyXcYf/vf6W81TlqH91GqPRYi9JOd+qA
 VbuyvhyshZsjCggHGDzCjs5sWa5ygH/1rfUDSALHmb7T9L4mMywZHbZuBsF1i0YLyEdvPGyW83k
 FE9iZu1rrPgWN8VFuHQ==
X-Proofpoint-ORIG-GUID: YJWSvmXmlLkk8XyXcBmyTh_zgKnCW7-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200145
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

On the latest A8xx Adreno chips several of the bits in the UBWC-related
registers are now hardwired to 1. Currently the driver doesn't write
them because there is no side-effect. In the preparation for the
refactoring in the next patch, write '1' to those bits anyway.

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 53def136e0fc..7a6223ddd8cf 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -288,6 +288,8 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 	switch (ubwc_version) {
 	case UBWC_6_0:
 		yuvnotcomptofc = true;
+		amsbc = true;
+		rgb565_predicator = true;
 		break;
 	case UBWC_5_0:
 		amsbc = true;

-- 
2.47.3

