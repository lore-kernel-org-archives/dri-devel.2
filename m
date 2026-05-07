Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18E5CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB2110F0E6;
	Thu,  7 May 2026 13:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WG97G3mC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="amBlUIKx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989EA10F0E6
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647BxhKH2734318
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SHppxJbIcnxAbn5e5BxkZY1HBroOaNwMncF5FMMJzNI=; b=WG97G3mChs0n7L+C
 uYBGbXBnuMYE+vX3krc/qcdPiptP+zAHzZeZ05GGSAf8F6sLNG+qdnzu/DbxIuCK
 WNBs8i6/BFfw3wMlJ2gW2N+08V4JLLGyhqKvN7N4nr4d0LUSFR515S551IpZk0NC
 cxtDT7xfStbQmxINu02RRfN9YcdNAxghMLa81xyTcnOqsW1zDfxuFjowbU4x7glS
 K0imK5pxzJuo7dSWHoyTGvIpN0pcTiIU5/nCFYB0oiIO4QMYOkOA1ZcRTmep29Br
 OPcsmipSaNmM5oLFApsfBOOWdCRo59YGw/ZSm4vB6bQyIngX+Yfd4WaspUayfxXr
 RdJuHw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tbqr711-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2d83e7461so15763895ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159020; x=1778763820;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SHppxJbIcnxAbn5e5BxkZY1HBroOaNwMncF5FMMJzNI=;
 b=amBlUIKxkkQbogWwqVQ31kVRsQJMY2oAdZaYSodVnlkmHjVr339JjEHYq2706ksjR7
 G23RgPuKOLLacdkh5NlBs9eZY44/wqeBV+KI37+6IroW13DjO0MWrfqAqX6Lkk1SM0f+
 D+XLe0AcFHjMlqeOnseQuyvjb8tY+RcaejD55Rqlf4EENAjT1PbVy9E6LkJVrslGbCTs
 SHV1jeQfWebn9qLT6Wtj/2qKhvkaDXA6Q3hLsUk3i9UtjwEkeR6WozMcUkPKx0od5V2M
 PEiZyS7d8N5TFPKCDL+yQ9WbSL2Iq6hiPbQ6/A+7jWGsOxKfBKOK0pI5zkN8HD3SpgLX
 4UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159020; x=1778763820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SHppxJbIcnxAbn5e5BxkZY1HBroOaNwMncF5FMMJzNI=;
 b=fE2IGkU4Gm5F2DjE5W7aJdReE5G8WYDXn5jY5xyUwl8GQyx1BmaX0yAUP8mGou0iP3
 0OTSYyxaa+NJtLrfnxzZj7lNK9uEqZEtWWnZFpDj7KPlehMeH4HJxwGJ2qlcDdwswe+c
 pD4uv5/FlAQZAM8HBCv52Ujlf7V3PwU4fGw98ylC7IPGzm00nOCWQi0cf4EPXngLQfhP
 KtaFuazhW7eM1oEDBycyJJkF54QqoK3KNl354kNcuPXLLTHSU8+IXFu/2ju72xsWEVxe
 X927ew83WsXrKUmSH/O8XDj12z26IcCIu0ltJ/O9I7QO+Qgan682h9aP8k0tjcXuDlKG
 8EuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DIL6hIgYrKi5mqQ/kzFmjRkdrJ4sqLMluYIhzdAQror/QQHbMUBOrKhUV88kIy29gy/L060AxLK0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+w4/SoNooQ7JcvRpsbZWUlxM3ae5gHoNc8SPbxL5pFmDVohug
 1MY59XiIoHF2WVG5+8txFvjTW6S6KlJqm1sRjZKXf3k44TmsWGn3iD/N0D1Hc4KwCeIhxEjkmVD
 eNRiouk+AYWG2bei7QhUV4vCYlure1RQrhVU1gsAP4D7ddRBmrJlWGbwmDmcyO71Dx83ZLqc=
X-Gm-Gg: AeBDiesb017UjW7pM5J2mDON1SXnvlQ9xv0BsJ3MGZXTfAXpF9iDDKE2ojXJD/qwvzU
 HiM3SahtkQYDEBMMpVo4C+IlZk90WGZ4Jl+N+cg3e2t+2fOUjL5uIly0mo8fS7rJlF0MTVUAKYv
 C5unzBG0Z63kEsQ6ZHJvn0VGiD6SPAWYDEiZxA4sYyiO6kOs6O3pNlaNopsci+2XvsQX3EroYcA
 ahWVi0PZ0XMB+lbwLxJBlfNPdzoKb4B0tk815EvJrlj+SgmZbyC5xumq5y9IG9s0nRe5sdvyGj7
 tplQZsinpuEEqCVVVtcIBnfmhsT6AOa3d9QVW+xnjmTGhnteK4BadD9dR5k50hN1chMd53PYTHD
 HHjwO16wm3CguhsrPWIg8xlskRZbOqKTPJsJB43Mn0Ti+hrw16Xa1XbsGftEJCqUGNSejDPJ3cq
 iduCVPNVstvuOBJlMmxzLiIhPEcpJqQHibmNyf/GItYf5dlQ==
X-Received: by 2002:a17:903:13c8:b0:2b9:8d39:5e87 with SMTP id
 d9443c01a7336-2ba78f4589bmr83667905ad.10.1778159020248; 
 Thu, 07 May 2026 06:03:40 -0700 (PDT)
X-Received: by 2002:a17:903:13c8:b0:2b9:8d39:5e87 with SMTP id
 d9443c01a7336-2ba78f4589bmr83667265ad.10.1778159019676; 
 Thu, 07 May 2026 06:03:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:07 +0300
Subject: [PATCH v4 11/29] drm/msm/mdss: use new helper to set
 macrotile_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-11-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gBDFjN7fs9zNZK1OT0Rge6uEp5iYTQNKw6PU4vljOxU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2FDjnXbOAYSF90E+svp/o2+lKtGcJoJmH00
 LRHRwi/y4KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhQAKCRCLPIo+Aiko
 1U7hB/4i8c2pLL/nU9G0mLQ7DZ4dWx9a4EZUS1RvCPKfdbug8mvb57g/dFuRVTTHpaSNEj+DTgK
 zOu4qIDormIXsdrNMG7fzPcZLodw+eYU5eGdH+sZHxw6cS1V41KxATtpk+BCLk8LB/nrfgVVVjL
 517NcV/E2zf3ty6TNPoZ2Gxr6Bn0GOUX8cdKDUS8Bc0K4Oe8s44bU2vO4m6euxFwSAXhOqq8orR
 0SUZ/wUoWLnIUBM4BHtYJ/YKUjhc0rmKfY0pUa9/+5dSplJxpHedAVSxvSy0RmIs0ul/cYT4e49
 p6SdltpAfOF1V2Q3+Isc5Uws7rE4wgT4F0fSaxnE4uF61x3d
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: mNMAeiwZNW1IosDfojv2YCU63NPXTCAZ
X-Authority-Analysis: v=2.4 cv=SJVykuvH c=1 sm=1 tr=0 ts=69fc8dad cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ujCctoy6CNRHcyqwK_8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: mNMAeiwZNW1IosDfojv2YCU63NPXTCAZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX9cauBx9RpbKq
 jrQHmyP6Nqb192U4skzP22O1wzcE0IoWn0yOrAYBTbOk8ezDM8f39MrlO14q+zqS0I7kwy43+XL
 3f2oEVxaDp6qcvZ/E1gbJMhDtv8o9ITXl/kg3a62xP/YDySlI3Qg53rbQTvqG7EiiExOnoqIBsV
 THKbwSEzIWPVYP1KAGyKMi0SBV1BrZ0g7qgIc0FqhJbgqEcbZAufa6YHE/rAswl9XBfvp/Kdp5S
 TniZIsM6EP2o+qg1e5L/5o8PCGa4GAVeTzNh9KPSRNlaNyqkFnuONn/wPY4Hbwho2iU+p2qFKuQ
 j6CSCvkQEnXNVKcaKzNvS9LAhf95O1lUIo6iZoJvlC/O286OiSPMilupH3O5A1v1iHSPqBd0ouT
 SHyVq/4XFWGRunmqIMJPIaJpWubloOV3Jsd9dMV+gtMURzEPDqqTtdzC2hAr17bYHYtL9PYT4/5
 nrTOTX9bAsqWsGXW9bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
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
 drivers/gpu/drm/msm/msm_mdss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9f2b366d45fc..2742d4bb2a4d 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -183,7 +183,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
 	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle & 0x1) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 
-	if (data->macrotile_mode)
+	if (qcom_ubwc_macrotile_mode(data))
 		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
 
 	if (data->ubwc_enc_version == UBWC_3_0)
@@ -204,7 +204,7 @@ static void msm_mdss_6x_setup_ubwc(struct msm_mdss *msm_mdss)
 	if (data->ubwc_bank_spread)
 		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
 
-	if (data->macrotile_mode)
+	if (qcom_ubwc_macrotile_mode(data))
 		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
 
 	value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(qcom_ubwc_min_acc_length_64b(data));

-- 
2.47.3

