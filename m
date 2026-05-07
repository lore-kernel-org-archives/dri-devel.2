Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24379CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D61A10F0D9;
	Thu,  7 May 2026 13:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hfd3Aypl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MDr4fKxQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B9710F0E6
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:38 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647BGBt0682852
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xRxPggAxhmeUOtwPDQu0n6LredQeEbGzVxBFYRERYIc=; b=Hfd3AyplOqxpf1O6
 pt/A4xic84I7hHNXuVeSYTzQe7sOXnMgZ2qN5NP7/uaqyKwHliS3dbC4fopMw4k8
 9hreuWcgNzREW0p3vjMDrp2FSeJcpNCwn1iZT+U1aP3r8fcv+X4YN9nw/wuemR5x
 c26WLa208J/Dt1bzfJ4mUUg7yUHuqPGZ019ZL2cwAm5e23rh6migYn+6SKKddZ6B
 qh1NRQBJWp4BL5HYxAaunFIfEsg9WOEqeXgWyL49XvRy0Fyw+3LlMOvR8o2XJ1Vp
 p6AhZZq9IaGA8PpX6/OdCOFQ0F4M5l6/oNkwzw5jLTUttYTCr8uIkQvfNlAqB2bu
 19EDFQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhasmxg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2e8bba2e6so11174285ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159017; x=1778763817;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xRxPggAxhmeUOtwPDQu0n6LredQeEbGzVxBFYRERYIc=;
 b=MDr4fKxQnbCm7egp2OCGhL6PM9gi9297MyMDV1MpQmmT9du4O9E5sPv5SWWeHlI2RW
 R28RJClreW9PA1Si79rRYrzatgQ75qrPA4xhkRuAJhtrppWsnSOSvd9ANu8rHJ1peM+V
 Jes25+rMJasx37/8sKyH21OJqYewHSPM5e43KBT1ehjjgrkYYGjYO/nTfo1vR4IOZzEC
 3VzDElVa12FF00NjJjd9ci3KSQLC1PFlLUNaNWkpXBzJfJ+cxnZRt7ycAmoiIQhNUofS
 RZkUbVSIxLM9NE7Xw2w63VvAgmUfdWM8aTZDHP8LENhOFCIXgGm0Z5iLcUnauipM6Sg4
 W2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159017; x=1778763817;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xRxPggAxhmeUOtwPDQu0n6LredQeEbGzVxBFYRERYIc=;
 b=dfWycYaG96P/MhdDR7jHsh6ZTjdli8E9mVEc3RcgHGvgNsvv6fe2YgY/ajUzgwh8gY
 6GcrOA0jRZWSfbdz4IUPuHzTLDPHGPJt0wVeqHUih8UqWbsa33IeOu7jVl6hagUIOEdf
 nDaxiGixzVN2s8Uz/5zz2rxkb4vmvFbnDKx7i3795V1EM7xHN/WMZw3TRggMyQjzestx
 5MiS6//jNYF7trY9BivGvhNGz87aLgL/jPrX5LQRkcVu2oi/u/FPsN+ns7N7SwkSq2P1
 wY51z4TQFdzzJVATEWkRsyPzjzwMwXWwDi35dHdy8rYeF3SZSK5lmYuSbcQbt97O6AHL
 iLLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YoV41VEqejrEvjRU87g49/poGiz4m/Z16edZR6pCsJSBpj81NGhUyMV7Nf75h5kxb1mYrP/a0LnI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCQhjrBEtAircgHQ5yTEVmyYbhSf9thgsTHrIDjo+X2TfY+T0q
 7PigYTeIZ18y/RaWgb8HU2WMctjCje+6tUBIbttrm9KY+bXinWJ6y2062FbYWKcGfN756ALlpVv
 mYpRQkCe7BfifjB7OS4JMwc93+pyAbARVd0vz8W0Myxhta4vSjqZdYW/zcaWqNIgtc3JFVgM=
X-Gm-Gg: AeBDieviTGYf2TqDd+MUIKIjyyDMfAeN5gqeYL0N+hHzw5LJ71imbUTljqVeJGZBFUg
 0ofP8MAj+HMqjcHehDTGR2aPTP3hdJDy5A8byqhjgG9zsulrX5UtODx+OYkQuK+CA5IjAt8T352
 ikDr1aB/t6+DoTukEPmDanpjqxeSOeF64w99xTceLax4wWv5MmNHYAyOEHIfx+FQRUg2JcC0hKO
 Ciw1Jv9Wy+SpJwukUBd1Bt7mxbqGAsZjuH9tI7FMh1MPYldqBiJSfb8HZ+uo2h9seW5CJikuuNS
 W1QdjW8vZvTfPsXSjweJHf4rfn4MpcP7FsVljfbMOJpZ61sb8/QCF7wnByVIMM2N59xfOfgNRND
 twH7CqGB/cKwpbTisuknJRpmVP1hOXAQ13SqSFSZbUQgCwl4Uo9oA8gHpYuynXAPiXePS6BWqwi
 Fq6v3iRXkljLt1A+KnBnsW5B+pHFW6C8ywLj32Kj8G940d8A==
X-Received: by 2002:a17:902:cec8:b0:2b5:ef7f:a47b with SMTP id
 d9443c01a7336-2ba794b7182mr81696505ad.21.1778159016801; 
 Thu, 07 May 2026 06:03:36 -0700 (PDT)
X-Received: by 2002:a17:902:cec8:b0:2b5:ef7f:a47b with SMTP id
 d9443c01a7336-2ba794b7182mr81695595ad.21.1778159015915; 
 Thu, 07 May 2026 06:03:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:06 +0300
Subject: [PATCH v4 10/29] drm/msm/adreno: use new helper to set macrotile_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-10-c19593d20c1d@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=c1cCr4HKFXH740TdXo8Awqf1bvuZNKoQdiwEy4u3ZaE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2FAtOQQGHPCnd1jqarD8Ij7km1H1j8RLXpO
 UMff3OT1oWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhQAKCRCLPIo+Aiko
 1ZVGB/45u1nMr5GHedlGzeF8o4xph7Gamk5/dijvOiVYTd3HbJfEQIOWzmKep659zT411oY6GoG
 r7s258/K49+Q9tysIud4POpc8GlQ0U0ox4WpNNAE0Qe1lpkcswSP11ccggQrkMeuDSW4nkws0FX
 ogufqZ7XBKT6nQgF4JJLqn9SSK5dRy3GKyAKbP8PYWi0bNkwckeA3HFtyPhULq6LxeK0Lb0NFfH
 Y5b7W7b4w3EAcH2EA0nv47rJtIUahZKXHPihttdvxP/FlH5SBVILFp92iLQDN9YNQVX3GyLz1CS
 WE+UOWMaS1PG4sqmNh9OExRBu1F4i161dox4/aVGNjwfjf0b
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX2BqzHYAS/Eac
 ZEbLg8lusCSEfX7vVDr11rVuelX6uu997Tu17YinkQJ78viJj6QLMT7u5U0eqCtij1QPxCo7vjH
 IKxokDMNFsEd8e2mW/qN6k5qWUBL8Gdg8YlkIqX3ncUh4MpgP9S7/d29Do4VKLcBeDbAEqXD1LX
 O3/2+fBEvyptmxqBhsALh4k+tzhu9VzJNNRSRs8wPPv/eIWj0kSs9VxI1NCZjVllUSThuM/5+s/
 8Si7K6pyEWv1w+oyMGaJNQnpYq3c7tETPW7bK2JW6M2N1fR5j4Ce3A7uYQWlR+X2T/SpedWDfVt
 7mM+e4qU3og8UaD2AYur6cXx3yFFlOIKFeUAZn65ENtkmrbhwV4eWpZS9uU+BXEGk7xm/9KK7Km
 TqY0lgVU2Dqz50vmDfVAa8yvPANxfi/piw2ghYM3CNb/E2ZzDB3K7+0lA1fW9J0c1Fz5nLmffoR
 P83AiTea+2xVEaIr3fQ==
X-Proofpoint-ORIG-GUID: NYv9Iv7Nve2k0SJn4KwjmLNuYzOUXtuj
X-Proofpoint-GUID: NYv9Iv7Nve2k0SJn4KwjmLNuYzOUXtuj
X-Authority-Analysis: v=2.4 cv=ReWgzVtv c=1 sm=1 tr=0 ts=69fc8da9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=8BxV0iZMnHvn5dZpj2MA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070130
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

Use freshly defined helper instead of using the raw value from the
database.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 812bb95e8011..76c681614416 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -791,7 +791,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 		  min_acc_len_64b << 23 | hbb_lo << 21);
 
 	gpu_write(gpu, REG_A6XX_RBBM_NC_MODE_CNTL,
-		  cfg->macrotile_mode);
+		  qcom_ubwc_macrotile_mode(cfg));
 }
 
 static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 66f80f2d12f9..bf1572156b0b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -433,7 +433,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = adreno_gpu->ubwc_config->ubwc_swizzle;
 		return 0;
 	case MSM_PARAM_MACROTILE_MODE:
-		*value = adreno_gpu->ubwc_config->macrotile_mode;
+		*value = qcom_ubwc_macrotile_mode(adreno_gpu->ubwc_config);
 		return 0;
 	case MSM_PARAM_UCHE_TRAP_BASE:
 		*value = adreno_gpu->uche_trap_base;

-- 
2.47.3

