Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33821C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F23410E7F5;
	Mon,  7 Sep 2026 13:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XUZdxr7m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FOyQjXrB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A5A510E7F5
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:00:43 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AnA0B4064250
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oOCrMECTJmCrKwJs/AjWGhAhZLHRv6vQjyZ6M+guQ54=; b=XUZdxr7mZFNkNTFP
 sTtyHTKLw8amstQ/qeGkdGX4+b77Tm9hJ3Sz5K83eyFhOUkL8OfloU1cbZ7I1JXl
 9Y+gvlE3GnVNxTD0fWEzKNKFgnQMRvHAGDD2MLj9gqwjc8g+/DLAYcujXeJECs/I
 gGX+sDe0+ZzOk4F5Ke2khBAHhuwjmntx6quy2SgdPrTR0MoSTA8AyXUImFuiHRDZ
 F6aeobqnC7r9n57K56IluFmUbL82yHF/xdgpiZoITwtwLcIFCsrOhdDjy5thQNjM
 P9N7oHaDMO96AvT1haLipN67lUtSf43qiy7pWMmGYu0v2v/jSjQGwO0bWNjvNovG
 U4oARQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86s9gw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:00:42 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-737d2f02d2fso2761725137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786041; x=1789390841;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oOCrMECTJmCrKwJs/AjWGhAhZLHRv6vQjyZ6M+guQ54=;
 b=FOyQjXrBMHqHGeDqiaeOE+qM0Z9k/iaIUrTQ6Hb6P23iWVKVibB9SVLQU2NM+Ggs6t
 FpP3Fxt7enZy9O/OSlCad5Q2AcViCLu9csOVM8lwiqr5SezgfJNYRDXKEN4zomsZWuqn
 z1/d0HQg5SSg/BGzbaiUJeBMHB3ucvB6EyZ6ClJsbPSAJbjyhPL0Xg+AoA6bQe0LPlKW
 fjc2oJbmxJYnqevrJegW08UArcw9a3AldjCw+CDMvaij++qH40T6/9TvaNyP4JIQXkiG
 b0X4cmKaCPRni3XPg2YZgpH71QNYr+HnB0dk756O7yAyKjmTA7OBPI85LHWU1t8jcyBb
 +lZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786041; x=1789390841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oOCrMECTJmCrKwJs/AjWGhAhZLHRv6vQjyZ6M+guQ54=;
 b=pIR0x4Th6nhoksIQlI5JR2WUv/LyxCYdMwDgB7+qdVvgVo6fs5W8Ya/acZ8XRuZ417
 D0dUJ5s06CgBtlWZPiRkuYTd4Afssou+GSLx6MFASE84/WR2xoQ5L8/ESQEpbUTamK1q
 lZEF7a7ZWDZNt2jvQNzOrKenhq6q9DffKR0KSm58XYx17vRd6mfoOUQxPllXn/aKPeRB
 35z46yspCqXlHctW+VPlWHdf+2pWp7PQHvZpBqMYDL3Vqo8wDSmYNe2+XRqx7URNxKGf
 K4pesQPq8u+T3PddP9U6vCRi0hZ6r4VV0cT0hEXPpScNNQ3W+uH1ST/JVnlFALdusoMU
 E8Zg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkNA3V42hFVB/BYU+P8gTosf+lPbs3/Y4uCh5fjgyfcoIWQzGFmwM2Xx7FdoFqjBsFSHBUitvk07c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nSkpB4taXevFnnC5JQ79hAflegljDBIl605MPPCB6/hzhMUgve
 UV5/KH5KQsXO3B9kKDjbfsw1FXUWGj3rJvqbSE/2LoHX/zYj2W68p3gQmUnXxPyTbZSl8vNCLTe
 anMIlKBaxZK72eIU4FRNDwQW1PhOHbMta+VIHMh6RXgsjadytunK3AjqVEZUd0o9x5l5SYqQ=
X-Gm-Gg: AYBFou2PMOc6RidYWdMX3FhdRycqpMhGJpYx9aep0KiNwXz91HjioGUZRITsJ5E62HB
 Z6iL6YrLQzH3Q7MKoUKaIR+9McSjv5Gu0jAWXV5dZ/hlbPlmslveLq/EO0J6muE093gG9HC570X
 IHI/W7NhRmcJ8B2rR/65vbpsUpSzMkra4BVJVI+LQHyEF+Y0trXf+waiQM6KoqipaKRaFoGuJnz
 pWnzo7VvptYTqp1+08wuUekuD4g5+P9OnSCZZRONF02GYWj5DYgNP+Yb7AhBCfTX39qe4XC4iwB
 WQQQ/FLHGnvcHSBTMDQfGw3Bkd/k1rTK1SEn6W2BpN7ZdSfwMzuXliluWl05ZnH1j9uzkE8jBII
 HAIr5yKVw1aWG/v7nOsag0+A=
X-Received: by 2002:a05:6102:1481:b0:784:b9ec:9144 with SMTP id
 ada2fe7eead31-78a4a9c3a45mr9664125137.8.1788786041499; 
 Mon, 07 Sep 2026 06:00:41 -0700 (PDT)
X-Received: by 2002:a05:6102:1481:b0:784:b9ec:9144 with SMTP id
 ada2fe7eead31-78a4a9c3a45mr9664094137.8.1788786041073; 
 Mon, 07 Sep 2026 06:00:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff81c9b5sm198751205e9.4.2026.09.07.06.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:00:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 15:00:18 +0200
Subject: [PATCH v2 4/7] drm/msm/hdmi_bridge: Drop redundant initialization
 in msm_hdmi_bridge_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-4-b097cf1eac77@oss.qualcomm.com>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=lpPbeM6c8VvIV5J0fpRx6DMejGRPAycCbF+JSHgz2Hw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqnrVmM7LwsR9IfN8orQYy9CM5ColVQFdi2Uxw+
 R1SoJgAFDmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap61ZgAKCRDBN2bmhouD
 12GkD/42dhUM3tdTjVHlHyOQ7i4kV0Aan+nz0E+fR4TctoYft9l66IJD9FM+HWeUC89stXt/EIK
 6LpHTvJ+b36jnJGjNf8EHYsqmo1HoKt+khdlrHPyM5lEAzyPD7RynzOdKZsdz1zictBsgCJfjPD
 L+Wf3hSqhX1Fsr9opjEdDkhKyULS/OSKaQ+J55baoZQfoFKXXh2BAkhex+dABVJ7MSx2z+f5OTF
 0IElxMpwoqE1m+LkD54pBbkVnOHlqQrWWNKwDJl411Yq1oyGANl90ZabtI5OxaJcad6hh8u7EDm
 2vCklTdYoFl1zNsYVmBi5r9iLwcN4RRp0ueNuJ/km/BzJbR6Ad1hVMB4NxT3pfUOwBkLsUZRxiC
 ZbAdbqDZ0dpdKB78kUqhSG+xPxtACQxTSr4+oH1vrytIxyKdagXWHziIVUKYpklGFogWF39J048
 AnDV4+gqGjNWa7QHbaYrbNqdQnMghBzumeYKOrZpXQXIVz94wNn48563ddTHz3Pc+eaLRL4TBUn
 4DuWY7tOrno5IQdppx4UWBjkHsVObLKxPcLdnf78QMi3eKvVRjF7kf6ZaPfnbp2AtuxVTeDkBCq
 JGB2CVKzS4Hbk/vDl7kzLY23iJrEEbMpwvegL8yuBMOhXKa9U58zta4Ox0HVw5jv53/epe5b9LF
 qlKdMnieE0dCW3A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 9ehUdM5dbyCpInnyUFPCXRR601LvZnGD
X-Proofpoint-ORIG-GUID: 9ehUdM5dbyCpInnyUFPCXRR601LvZnGD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX9s3O6qCFuPXx
 O/RnmQrQiFfggPaD8zeyrTUPWKJF2HXd9oTF0HUDIq4UCpjkYih8sOMoJ75md56BSeN+bP6+e+9
 5k276mZKEB4aDhd729x50I6myK1sP6w=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9eb57a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=RZP3y24nY_lDZDhlvS4A:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX0VpCl3T8+kW1
 uT1/VmKK4P88ML+0xwR8TUXayYKVZAr0XQCx9/PqAsiLaGEiHmlDFGrlm1nk2vcv+U9Jujld622
 HdEzQDt1oGzD9XA8sPcjXaZq4n1Fk2rzGAKgSXYCbINJP2PusKfyIITfI2jasJpqHVBGbpev6Kt
 pcIBBYgOqRNfd41uEiYvzdnhoacAC1YWxif+UZs4/kfEsCfDtoX3bW3Dp0wVnFWLc6436d0P6Jw
 vhqmCEE2BWXiQLivt7tjmjRkmrpcf1npB7ZHWHNGL8sG7YJFh5pmOZrnO7Dy5gFexuE0DGjQDqV
 fglLQQ8o71onXpSJjoafpchd8ejHq9or4ojli83Hgi5s/rgIHjYOv3yKHNmGImJtFJiWIn6c+AH
 pWrM6IYH8NwJrxje+WxoC4tWg+8jPEyq0E1wdJotD0WB5UdM3NW/aCkARsOH93LFPOa05Amfyky
 9fGBrzgwqbvvTmfqdfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070143
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

Local 'struct drm_bridge *bridge' variable is assigned in ~13th line of
the function, before any first use, thus explicit NULL initialization is
not necessary.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 04c893062dbd..5400edd7507a 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -484,7 +484,7 @@ msm_hdmi_hotplug_work(struct work_struct *work)
 /* initialize bridge */
 int msm_hdmi_bridge_init(struct hdmi *hdmi)
 {
-	struct drm_bridge *bridge = NULL;
+	struct drm_bridge *bridge;
 	struct hdmi_bridge *hdmi_bridge;
 	int ret;
 

-- 
2.53.0

