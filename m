Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AC9CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 621F310F120;
	Thu,  7 May 2026 13:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZRcq+4ot";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QaA8inlq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B68FD10F0FA
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647AVYgm151029
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AeVRvHRKAYbWbJMpPrGT8xN78iC1aUQpOFXz3bq+KTg=; b=ZRcq+4otWaGHZqh1
 bxnrlJIGhp0MaQq2+CAOumilZ4LzHZdZoJW+BDJwe6YXL+9o++IOgbY8w3Vd8+yP
 czeYPXSQqXMcEd4CRvNSjXG9LNv4y8PnCoCGf7uYglr/F9pZXFeA/541d5JMudaN
 1HKkKcG0FonEzA6uWR6BB1zBGDGStvZcFl6QE41fbCC/jLXPAwwwaRc6Qb5WYoLK
 Zwu9tas/1BXUq0cqXN1rzOjRYN9l+GA/4qRFOIcUli/4dRPolJXdqA83bl5J43up
 FSZEpwjLzHWvSXGVwnrdwlfUwcUtdexExZa7cFrHDcf3fT2bj7uV0D/JZixuXIf0
 5zAv3A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kctsw0y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba115ab6bbso8417465ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159038; x=1778763838;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AeVRvHRKAYbWbJMpPrGT8xN78iC1aUQpOFXz3bq+KTg=;
 b=QaA8inlqedpyUZZ9emEGhYZ8r3l+gDldEOFpIyLRhb8cqBD9B1JbItgXSaOdSjI4w5
 gRKv1XR5qvtYrX1+pnzaEyFJUTjs4UVz3T9ovsYQ4W/B6eLthClml6AGluOeyfTblF5r
 uAGqJGmyibHC9TNxPNQJ02YPM2yQMnECnkFAqTOcKMX9t9Rt9Oe7XaD0siWYrsvmdvNs
 2Ovtk4LLLZkKPiXr8rqpJQrkfvP4tMbQwmRa89ijLRDCeBTHbpOUzM3ztFQV5b9YXBDp
 7LinfEnP6FLwXt+dj4XdiWfc6/xEZN27AqYEfNC8EUnXE2ZVFm2gdav5B/WRx4V0Bwfu
 /iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159038; x=1778763838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AeVRvHRKAYbWbJMpPrGT8xN78iC1aUQpOFXz3bq+KTg=;
 b=h8lK9TBsie/J4iKmG+lftqMKpHUzkTtp5nEHYWT0eCQFUAoYSdJnb2rZjasBdmjvvs
 Ap4phP/b7QmyyOamlDOs2Kadv3EXIxVcZb5OHoPMAMnfz+mbk7YKk9W6RdGH1+VBD8lc
 RYjpJg3RR+hwG5q6F1pMZw5ORbZbz94S/k5ZKdc6BCB1WYdDqY+RkF6OcTkRaxc5fdN0
 I9ERowZnp4wq8opgHiqrNkJyciCQOUiEaY/yUY6J5+qbnIesmDS1DVc/JfKPR7HgiKpB
 YiJFPTzcP2T2xydHXAaMU2JTVubyZn2X2eIhV1xHYy6DxfQolMd3isk5lIDgcoAselrM
 7cew==
X-Forwarded-Encrypted: i=1;
 AFNElJ9x8mweNdbnpZQacUgpL6ovJiefERyWWQq4KnEn6bD1GEoRzV00j/5EVeNA53icPEQdwxEQdZqVacc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywy4Z6bZAIfGsL7G8k+TrnLmbBj5cnNouGWs3qLZRCIZwGwZG20
 4A8FNLtWGwjFob36a1FgbjB/Rnyom5yHu5yEcEsc4q1D5gjcpZ6P6HzJjgTCIAWRKWJYXGt6ZA6
 /bnSlXxXJEk60w89Zdq3nMAMOa2FpppvNEIHF3mdcylLsknhzOrwm5LMOMeIuViOt2yXDtZA=
X-Gm-Gg: AeBDieu5DXtGHKuPPeZGqY9ACsJF10hq0HijcULOOJYgzlBhulqnye4gFebeTqQOgyP
 xpqrpPDNjEr8mYQyhlfOhcC6FjuVp/nDekwZPxt5y5sadJr8pGvTwFik5bUWQ8phj8h7jCax8qp
 xZSvMIh7al9vYtlDPyCOUxIHNWNNhKIlIUyTMHj+KNABFkWrJC++cwIzDPwTBwjucl3OVGroYzd
 VFI3594Z0td9xWsjNorsrUXrfuvtyGBaUaKjHPKmyIk3bgZIW72RNfRO6KSE7YOCLY9yvizJ/s7
 NPxeSZMAxRbb0aDSw3xqo9UMC/npj8ORKSgN1MjqkjE5U1Dw2ku4y0ivGFQtTtiCcbte4qu8Mg5
 lELFTdfJ+F8GaNH7cXV7iifoP6x5VJTSae3Q20vuaabzgyqR7MtdIn1UbFI8A3CuNuOL3izWnEC
 qSK7xhTeVRJv8VT1HYz2XfIWA9BE0ipIuclYJ7OWruKI03ZQ==
X-Received: by 2002:a17:903:144f:b0:2ba:359a:9b8e with SMTP id
 d9443c01a7336-2ba793bfacbmr84139285ad.10.1778159037684; 
 Thu, 07 May 2026 06:03:57 -0700 (PDT)
X-Received: by 2002:a17:903:144f:b0:2ba:359a:9b8e with SMTP id
 d9443c01a7336-2ba793bfacbmr84138475ad.10.1778159037036; 
 Thu, 07 May 2026 06:03:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:13 +0300
Subject: [PATCH v4 17/29] drm/msm/adreno: set fp16compoptdis for UBWC 3.0
 formats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-17-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=745;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=b5oeFZM8UPd7zv2z1rm1o1ivK8BBOWD5ytqdmxE1CA0=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+af3rYX3FZbNBPE/r1uK7Y3d54lX2gczJ+Vaf7267U5n
 t92OLR2MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAihn/Z/9fwbwq7r+NVLptm
 uzfQtVBrxV/F/+L9Lzu1ZkofDpj25ei/X7xbnvidPeRyxnDJ3neZokdyj8vwb+XRu6DqmTdpsnK
 YL2d33tcjWu358zrDFhxnuZ4rZXSvfM/KZ28cf0upTt2oJVbuEXAo/rHBoWJH7ZrSP20Lghuqn/
 UEXQm5fOiR23w9pboFHxekGd/NOmQbcEKavfq5RnbGhYgQ489cXQfbOO67ums9OutidPdPdgNPh
 /n+LX/3MlX3qO1u4F75TT3IRzP98Uk3V9umG3m6HhHlq9X9V/3bdLXm6rWIy/py3dVN5/V2L52S
 wFB+ZAO7SJHV3hV3Q4KaBNnDUkWvij1LW3758uoFj+NtAQ==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=XsPK/1F9 c=1 sm=1 tr=0 ts=69fc8dbe cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=CoZj-JnWnDGe1ZqNdgAA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 0zOonoxhBc3zlzZ-kBhACsFC8pjm2lAl
X-Proofpoint-ORIG-GUID: 0zOonoxhBc3zlzZ-kBhACsFC8pjm2lAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX5VOVT+uSnKo2
 tez1s7RfvTuzfa2A4QSZlB+f4xn4/kHqct3IflxzC1zaB0fQ90dpSegKQ146Ak2UVNS/ojWu/g1
 c5nHbOf2drFoWFD2aBOaFJb8Bw0Y65b+IaL2YP5LUst29D3e4dqrbYm4mowu3PL0uSBXD2XFFSp
 OhE4RF4PgdWFbiNn5syyVAAHZpC2UEZL7094X6KBTidBANz0snjXJSvbzThmksASfrJG8gZOwDA
 dclg6aD7s+Z4MtcZ0DoNC3Sd0VRxRCPNCRXq9R/fEYfyDUp8yRvym1pypCOkX+Mrr/qWGx69Zyu
 SYF/G/SYRAh6Ih8vcXLklsdHO+f8qoEOiy3gFm9DVmueguEc0mvLH5S4PZ1xY13AvOrXRGO2OZ7
 b930XfYZHhkpeGVvDJKRNKNSuj/V3vhba1BNLEgqYegsTIww6+8I15RwoSnnVOPXmPn77P3JLDY
 XwSsiaxIAIORkng6hEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
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

The fp16compoptdis bit should be set if the system targets UBWC 3.0
format in addition to UBWC 4.0.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 7a6223ddd8cf..867c7d05f670 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -303,6 +303,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 		break;
 	case UBWC_3_0:
 		amsbc = true;
+		fp16compoptdis = true;
 		break;
 	default:
 		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);

-- 
2.47.3

