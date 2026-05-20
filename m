Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43192CD5BAB
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A34910F0C5;
	Wed, 20 May 2026 14:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P7hMz+vA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cozOPz6L";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C296810F0C1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:58 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K8ui0u4115323
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JAOFJSnWiBy82M4+mbUAjlJ2kFgTEHkTViqywRBPv8Q=; b=P7hMz+vA3NCsGsCE
 4QC3v9I6qxT8sAHATMHWvOrvJMFnEWziB1H+yhPYMRUAOAqazWkM8rsKHtFtpX9P
 BG3/X1tvFnGkuG9W2meU7Tbb8GWh1SYI9eNUE2NWZkPpLbe788fPKp5K3LzUhk1a
 cjw2wiTNrLfMEtQx8Tjs7h7EpChyvprVJ1SHvLmmXpLR0Si3hZb3f3CE9obGQi99
 jY1+OjZPvPtcykUNCvNOrF1jg1bnnanQNClXQFm7NfUPMx+s1UNJ+9F1as9SwXrU
 GwENKOFp912pWhVVNEDobRd6GMrAwGNbBc9QpSjn98faSWh7mF+Al4RjfcdSpJIy
 A74D6A==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e99w0hb0g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:57 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-57525c1ed46so3944747e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288717; x=1779893517;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JAOFJSnWiBy82M4+mbUAjlJ2kFgTEHkTViqywRBPv8Q=;
 b=cozOPz6L+l2/n7UjbW05E7ucLLbKV8aRio2eiCA7+rSM15CXugpZtOxA0EnhsGDz2k
 n/nNGaG5VpjUNAwFdMQXy5brnRkzcD8KezIJOAA6CazSSrZEg+3ayRLn4rxcNssOfTAu
 C3C87UOvP9u2/4iYACH/OSqnk4vSLaAs04syQfc3411E5QvvdvneWlW3iH7kDdLIkLBD
 zWohY+zEtf5lpeXrVopxuerklN+YQm6SmSloWXK/HDblzCO4+C7Lahp6HR41Kw4tXciA
 U/Fd5Xa1jz8et/SsuCURwyCGTIEW2Rgbb9tLZtI3pFP5snouVfIu5PrWjMlwfsVEDS5P
 E02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288717; x=1779893517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JAOFJSnWiBy82M4+mbUAjlJ2kFgTEHkTViqywRBPv8Q=;
 b=LokjEZyLe7JW8SPFs1z2KQMRvsr4GQLShuSmxDDT0A8w0sHiz8bu9YCb19/M8XwYyC
 +CYcqnNo2Gtreg8+tNrLYxlu44cif/WEDMSJifv4BAjyQJMAQSfkwFGcV0ZR+ytX1PJI
 wvHRUovMaigVj7PJN0UMUsHgom5hbGhwYkTML0St/BlDiKuxc00B8J1v6zenhCNin4t5
 WqjOsMubH35vNQZmNHfaBAXayKw2Q3xM7SoSzwQxy4WNoChSPElAWh+0xq3n4iuhu+82
 oa0Ytql7qtZFWhkkS4r7t4wYN9xgFjHTOoDhMsQFluUWad5CK6CguZQ05WBmcHDyvaYJ
 FK3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qG9U9VkYes/MX0Dwsyzf9shDv/HEWITrj8iewHRNG9hItzOFzxJi3HdS2mS4FNtIUOXDyfGd7Hrk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtOsuFu8KR9RDNkviE6etWZynkKoWsmcXtL4TlRkPuYSzmoQwa
 t6Wr9Egx/R5ow1/R8q50S5682LLlV65Or+h1uGdWFKGr+kCgmF9rRd2mmx3Ahqye1024pSJqZR5
 p8bvbEuSkuR6nOA/pB5cuUqboJj78kM/5D50g2BxY/xybpUipkpB4/iz/wnljA22ITb/rRI0=
X-Gm-Gg: Acq92OFFK+ekkg1soXRp08pyazfaXzwwtYnrvxwRDLdsrdcjfUn17ZTZxSk+y0K4RSz
 el/WGY9PBkzFlkgHb1Kk+QxDEX5JNvn0gOODGrXcw1w4sJrNm0I4DzMdEyanzbar/lNP0khfvBi
 6CT+fCg4/+16wM0hDnQjc6uA6+2bazXRtoOqwsJYEfVDgmRwxQWpUr4u8rkW3+QY+yoXgI7avOl
 GAMclKHBsL/3V1oLOr8Z3K1hCPdpkpaAd+nMiu3390gupwUVNI+MqGtf48586P1X4SK09yXCIr7
 Ij/l9YVWkX6kETtekjW5zA5M+ZNn/uMqH/91fk0HoKnEs9937K2yACWwbqxsiW+nqQuBn7RZxVz
 J8A6nepuUuUpiqlsFVGfxMkpHklSXTiK4+SUajjG+Dpw71y09dcc9lboB5wE6Bw4PIYdA9YOfLD
 pIsF3LSR2+ldwwUjmPHYB8MaIkew/c5glDkNE=
X-Received: by 2002:a05:6122:6093:b0:572:36f3:e792 with SMTP id
 71dfb90a1353d-5760c099739mr13100949e0c.14.1779288717236; 
 Wed, 20 May 2026 07:51:57 -0700 (PDT)
X-Received: by 2002:a05:6122:6093:b0:572:36f3:e792 with SMTP id
 71dfb90a1353d-5760c099739mr13100753e0c.14.1779288715950; 
 Wed, 20 May 2026 07:51:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:27 +0300
Subject: [PATCH v5 20/28] drm/msm/dpu: drop ubwc_dec_version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-20-72f2749bc807@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=eWTJTWUL783ux158sDIK3D1pfEZ6TYiZyg3QZi3K7zQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcppsllJZkno/Skw+O4wXgaexZO7P5t6Q9FGk
 TeypT/FPneJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KaQAKCRCLPIo+Aiko
 1VKcB/9Hjas/KBnLvigl5vj5BzZ3aiHBgOxosDr6Q+pF6sULggHYWAQjWwib85XFMGQ2E+WC4Pz
 PM2oCjrVSvtZLyp92KZLMGkKifHVRVdSNea+ntU1JUbSOddLxu2skeykUmpY0m9Yo2MUMCFOIK8
 UpUEk/fYYWDhF5TurMBWGg/5uZwLZd+KDwaQyOW0wuJqg0vwhQEpuxcDOD1q60dsUDRKLb8kDl2
 p0iOuqIsOCYaKdWId9CPJeJlD43nMvuT0x7pvghYA0M5RyfhxWZC5xue04BtsokfvlZbfyQKha7
 7cLiAKeRAWuLlr0No17R0ODdBo3VEjJ3xRKlx6M20T1HKRvx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: LZ4mRyQs1OV_wbOLQED81ONCabriyTEn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfXzmNxP6uAWy49
 MGIe5sKix0bQvLip0eaVaTz39qcio4FpQSmbQdpUxVk0dScI9JZGH/8LGG+4I5XC2sLNPz9DjfI
 kJHdP3Se/tsCzuMHS6qby8E7aOSlUPh0r7eNxugEcmthThfT9RLTTEPhfc3PPHxKT/9h0QLccI6
 fEKFbBwBoT25WjQckG9DtbirjIQBfYyHcPQam2rjEYOYLcwdtQNttlHCgXP260f6+J8H2WdzSqt
 pu6vGXo4OavlpU3UBnNNYIryatrc2bgVcDbTxFsTHghjS2wb012I9G8LDzCiYhHzpASrWs6ep67
 zJZY7uATembRzrf32CA+R5i6ASRXiDwSvzuwWBnqhpO0hUPSG8wpCl8buseSdPZV9dK6XnIyCBL
 vfqoA6z2aKhq6029zrG+YjgjHqDzLdLHh/xHR2PL/6yfwhGvPgvQmx2nKh1c/H6k4ONf3+mjHI1
 IjNyfzK8bt9+wMugTug==
X-Authority-Analysis: v=2.4 cv=RZigzVtv c=1 sm=1 tr=0 ts=6a0dca8d cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=OFVxzADIxEWc22agC70A:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: LZ4mRyQs1OV_wbOLQED81ONCabriyTEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
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

Stop using ubwc_dec_version (the version of the UBWC block in the
display subsystem) for detecting the enablement of the UBWC. Use only
ubwc_enc_version, the version of the UBWC which we are setting up for.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 5642f3bc3568..7b92082d35a6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1781,8 +1781,7 @@ static bool dpu_plane_format_mod_supported(struct drm_plane *plane,
 		uint32_t format, uint64_t modifier)
 {
 	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
-	bool has_no_ubwc = (dpu_kms->mdss->ubwc_enc_version == 0) &&
-			   (dpu_kms->mdss->ubwc_dec_version == 0);
+	bool has_no_ubwc = (dpu_kms->mdss->ubwc_enc_version == 0);
 
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return true;

-- 
2.47.3

