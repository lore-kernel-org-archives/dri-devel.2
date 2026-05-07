Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71513CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A9210F0FA;
	Thu,  7 May 2026 13:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GClYmaxv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eITTi7tE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47AD10F0FA
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:04:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647BkQgu3924169
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f5dcXSbi9JJIK5ZZ3AWL3CvHDAq4EZmVMbYdJ9eR8Xw=; b=GClYmaxvB4n3Cc9M
 7PBRMQNPJ9uAe6+ZAP3+2zIBsVIp2hHhweod8Ham55regqQRwly/drh9VsvsVTy/
 4Q1gooVSf+IN6CgHq5yiSN/PpLN/V6F9yrkYaEmGZk4DLyCuP6xlBYFNsA5uglcg
 dTRNs7FSSrE84SWmWZeNy85s1/YUoeoXBwCvClSr9zvxMyzNkt9db/N8zK9kRTrq
 kKMV5JrF6MTAL7S+kODlEQDiGoKcop7K+PaMQ2iJpZP+UxVaweysgLDussI6sdw6
 30fMjyUo0YlHDxYXEspY8dEUpA8WkZvnJu9NTna1QPy3ogjmyB2mO9EDhviqiicy
 cHnfWA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0c88b5j5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:04:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba6fe41283so10304385ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159046; x=1778763846;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f5dcXSbi9JJIK5ZZ3AWL3CvHDAq4EZmVMbYdJ9eR8Xw=;
 b=eITTi7tEB3tza8eV50A36joxcLlnR6XIGCeLGU/0oxOd70rlrwgNAD7BQIKsCPf5MO
 H/S0eXGYefoVeh4yHJ5o3CDKbS0JZ6u7AexotS8Zu+BrwoUcpqitSU05eT9eHTQrX7Eo
 8RJJ3ogIeAjG5uSHloSSQxIdQt1wddrM42J6F8ofy7iqEhhf2LXoyBR14n1/qASoCdXS
 TvzgHrQ314N5r7ZRVQTbxaT2ex3alN0JaUBiCXSs1GHfPQ3+onBeTc3jpkU9zHLEEgW1
 uwoZDpisnmuKNoU/7/bDy2wYf1fAh8hqvYaNDSeHvgvMVsFIGCMUAT36sYA5ylp6hnU0
 qxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159046; x=1778763846;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f5dcXSbi9JJIK5ZZ3AWL3CvHDAq4EZmVMbYdJ9eR8Xw=;
 b=oe3RcyTVNmYai2yUiB7MPxFl9YFmrJOTvkmAd15lbs9Otlx0M4qMIpB+cDJVzTPNYP
 4Y8G/SAwGvdMB/4q0udfsB9ENpj17BTLJAjxnHkKIi190I7gwYTq/cdOMJbSOgzFAC7q
 7CxZDmHLxubE1VNsQpSWLN0m9U5/j0g5h2CwcFexfaiptIHNiZRDbeHw2/l/eHS+TDwn
 /GjuHhTz7K6VfsR5jitW/QoRAkulPTunNxduiAkipaTVEuBCLUdEtkqSv9WfNY1W21+L
 4RXCOeMTP67lbZNLEQw9F1OB7wLpCX1dx9uFKWTW4TjD9ChBwAz6GZlk0fW4JlmynUYA
 a5iQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fCpesuRxT6nvz23X9pKoqrxLS/t0XCrhFAXPvsXnv/8Bc12Xv3HawQSL8GBt11zppYEQow64DNak=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1Ih9SSE5us6kIO6ifpadQ0FBn9HSYB7KeWNtxULl2Pvh4LUqw
 v67SFtR7sK1SnSKXb6PsPJUDTQxTJuyyW1Xzgy6d63f/3SopaoXbL8Hs6edLuk0tW7usFHxkh77
 3O8oiRcenqbLcBZHpokFYYBPQM9KJfvivqWH03OHBQ/y7L/usX0hkKGcZJBEXWKgaPFdXlKA=
X-Gm-Gg: AeBDietzLM9+cxB1dVO173OIIq14BmP7jNhn6Pj2cfteq4OBHWaQcOUhWy5dJ2bHslW
 ds0t7OmEhGNcbb+NrVG4fKYmcFNXyTbAvXfeuwSlIwBrZ382veX6I6Sw60MTZeyGsEHMOFSyGUN
 79uX88+Mjb4KiSlwQ4paYfrEMHJ4FuvESlfmG3NgFpCdASbsaMO4SEHJyG7RCYkW2bNKib0hzJY
 oBsr1KPDnBTOfFDYly+P3fjDYPDn6PzqNF2F+qL38G4yMj24wqxYYH3dP+dd9/4pxeFPIS4Aki2
 rokXpYjBZ6Sn48s9dXzL08CA23ug1W0aI97fsiYDZE9FDI9pR9W0f3NeHcVLr4+sgHcjK9O/VN7
 WazpVtJE6+T3shrXTg5zXGqREfknav+r/ew8Qzf0cAJr5sA6t3nN8fpku7OirqlMgtd48fc1ZXF
 dPQkdrTnI18DQouEA1mhXUwWJXDUKCiLjEAv7pH6YFzRskbQ==
X-Received: by 2002:a17:903:1c8:b0:2b4:65d8:6a20 with SMTP id
 d9443c01a7336-2ba78f50177mr85900375ad.2.1778159045757; 
 Thu, 07 May 2026 06:04:05 -0700 (PDT)
X-Received: by 2002:a17:903:1c8:b0:2b4:65d8:6a20 with SMTP id
 d9443c01a7336-2ba78f50177mr85899735ad.2.1778159045163; 
 Thu, 07 May 2026 06:04:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:04:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:16 +0300
Subject: [PATCH v4 20/29] drm/msm/mdss: use new helper to set amsbc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-20-c19593d20c1d@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
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
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=831;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=jfFUw3n+8zI8Hc5dMR/bUWCyARr7q9urbKP+Znc56fo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2H23kJy7WAVP5J8TYyfq/seV09GYmAtHwLB
 TfF7tgvuiGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhwAKCRCLPIo+Aiko
 1Z+/B/9YnnwfpTigLvDcMWqXAicQLyW8JNZL3jAPE38t8gxHTptbUXSyn1EruOdI26Oumc0FaKz
 OmG5G3g441XroiM0xzBL9ikRilCBz7p2FrzDzoOfaTfiyQcoJS2+SVqK27zYFtT8/cwcDHvvFYo
 OHqrr7zv8aLh70PdDsmKCCfGisvU/3AHDDa/ALduhg8VvkyemtpZMx30FD9wM7TTBmqsqXUhU4j
 1cug+tEOBk830LRoaPdGXtDG9HPQQ+7sC3/d3Voulv2OH+5BhW+GplNPc8xjYS/AY2WgQT7YUGN
 pqbqHfYD1ReeCwpq6Qj1s7olxq5cgBQsgQPJpGYuDxExVF2e
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: -7IJ8bFBwCnRv3-qdGBaHVPU29O5fo5q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX6L7b00LJKh+g
 shaq+LC5s4s8I23DVdrZnss5QDFqBBc+367lJayHhBjSJuxkeXT+YdHImdngngjGWl2xg1TyI2m
 tywEnW5vPtRCxv6rGKC1GzVH5ymqLJayZtxLoUNU/0nDbgYNgnblSw1P/hNNdGUFEClQJR1+Z59
 kaKz5kzpekTKyMexuplDFg7K1xBgymGoNHRjtRWfYWR4OPlLrY2qDidS1mGJj68/DegH8Ex2/nm
 CSmVc4l6ANeZJ5oGOTSXq54otYSV2ibSiY00mmtr7q2NXh1oH9IVEwSMKpBFmw7pys4lpwSYm2b
 Y6i3d8ycIF9qGzBHaBmQDAP3iaHXBGiQKjgPNzrJ4ixYDc2z0h60kJngiBqezyk4KQEmD5OX+hu
 IFLzzsscKPomDXX9uIYvxAX2SyTKBr44Y0JxQP6GVzBagtQxLCohA/Bl+9AU02R4Ul12629mZ0k
 sMys/5b1Pt86ks5Zk6w==
X-Proofpoint-GUID: -7IJ8bFBwCnRv3-qdGBaHVPU29O5fo5q
X-Authority-Analysis: v=2.4 cv=X8Zi7mTe c=1 sm=1 tr=0 ts=69fc8dc6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=o_KNKqYLTMeQBHdYLnoA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070130
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

Use freshly defined helper instead of checking the UBWC version
directly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 3c1f04f12c3d..4b230868ed90 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -188,7 +188,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
 	if (qcom_ubwc_macrotile_mode(data))
 		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
 
-	if (data->ubwc_enc_version == UBWC_3_0)
+	if (qcom_ubwc_enable_amsbc(data))
 		value |= MDSS_UBWC_STATIC_UBWC_AMSBC;
 
 	value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(qcom_ubwc_min_acc_length_64b(data));

-- 
2.47.3

