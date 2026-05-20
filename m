Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9614ACD5BAE
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D0510F0BE;
	Wed, 20 May 2026 14:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p5qpUd2C";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TsjYdWf1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A40A10F0B0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:48 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE6a7X119115
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uukH2Hr1fThFSWIyYnWWKO/3affNsowUSHW3Fd24TQE=; b=p5qpUd2C6y94tPDf
 6yxDvXjGefICxM6EJ+OHuPYcNkzkG+3Kte9NEyReBe1St8LG0AMtZaBZDhbGBM9U
 GBY7TdsJlC94gyskL6DRocxmIJBkV5DRVYBbNEFHtpe062bhomzmDxC04OfneM8Z
 +lgDxGvfIC322lTWwAOYTN9Fm9oglxloxoekFZ5/aghDYbZX4sXTg1Ml6et9TkMm
 ti2Lx6SZ9R/+hvPrpZLbWR0E28BHP9OsU0eU/kbV/nQ44rAHGReL0xY+8SJQsy47
 O85ojwzzRR2hfEMtEv3dPDaMhzlUAS8SYf/ilZBVn4lmkEzrPHjhFScNoRtgLZFt
 J5p5Fw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee886fm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:47 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-632ad092bc5so8997236137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288706; x=1779893506;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uukH2Hr1fThFSWIyYnWWKO/3affNsowUSHW3Fd24TQE=;
 b=TsjYdWf1E35cfe19ft+m+yUjBlGc6HaISWqWgr2VEFp5m65plsCyaSOli5LQgYjajS
 aed7CZIX5VtkSdtG6o8vN98HctuyMyT1OtXogFqhj/Oims2SqSvWf97XZLRhq42OtA+j
 9/a/kNSR0nqy7f8aIDn1EE9ctyR/2biWVNew7wR+eWtX3N2PvXPBeUHAaHFrFQCmQ18G
 MaAyIcE8MgO9fcLmc3ntHURkE8pI/nbNjRpoZvMu3UrnCxapMkgV39UsEFsoDakCAyUW
 FXMLDMcC9FXt2OWAaLXzd87L0ZMYS5W6g5iHZGSzB8yiIybjZMnXcupcHj8HbraTDzBT
 1PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288706; x=1779893506;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uukH2Hr1fThFSWIyYnWWKO/3affNsowUSHW3Fd24TQE=;
 b=ANQIlyUbUBV/xS/t+o5BbYgYsb8yF3m+8MCBHTRxMAyyDvVOTU1zK1RvbSy1W8Gpi4
 BxNLI8qY3mkTxTJ6UIH6bjq2mTPrVI5KIsiF4atpIc8r3gvDYv6eGuFTwa0mGTX5D8vI
 EEFtYfst1OdfItEhLbcuF01GwXRSnnNa7uqfvwGkt5/Hb894m9SxpZiCFI9Vkaphpavl
 zjsCG+LwAjjWzf/LRou1xV6Q7W0drvNYDVuwNr1xlAbPuCWZJrcTTrDafmt8SHCnv1+M
 yS+dcIORkNsAQlanWMknIldnRgNZoWasbNk5j0gy2YD20ETUsGH6u7T+gLYWLrMGiVZI
 N0+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ussfqujEHOdYuAMFMPdme2IGO0ARN0Y7tYZkAo1OaNaSbiLqyz7aTVWKNzP+hzcoYILSm1BU7L0o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbICaVEp6adch2RIP1s3Jn5ClYjiHYl6PuqPHIkxttrwV81HTU
 /UNOF1OdZ/UUzxThUNOI7MxNB93W7RET+C9+3L3lDqMhe/GOfT6VTHjjBlww9p1mMJY1dRCm9Db
 y1BkOramE33tCUB9dPG5YFb5g0MEoBxHvS4YXk5iEw+T3BIxZn50/hi1zixAgoUw/4F8d7lc=
X-Gm-Gg: Acq92OGEtsXJjAC+JdVlraEz2zbvPzW0Q7cdSHWHhCB99pXs2Kh2LdbuAjrcek1DCkn
 pHch6OVpjUGcdkO/DRjvlQ0rp+5RJHmOE0BsknFV1+G0ISgpny1P0M0bIcoswGXA8/NM7s6lryK
 KIXEnHrA215dfe3n9QdhTwkxY1wAKj9N2WxmMGyZj2AigRxc//Q3qe3Fo6VDE6EJPssCN4JfsAL
 WJyRjoLXKJ+pZiaJTSmBIY/mnY/zMZU0yH5li2WmpqqM1ktUyI9lhsxOsh8q2p9m8VtZ86z+ALz
 YHYhG/5p2ZdMCV03WXwXErSGlrtSQuvC9dEdfLh6w2cKQuSXp2k9l3DDXwl0H2bHIrCY22GDCBK
 F4EmBG5kZYrDceGj9IiiU4guOI/OLlKlnCXnHMjmPsr3sDbLFH6458gy+hnAMpeXrplOkbRQ96C
 WeTzwcr+4bUI4dMT4YAB9l6UdF1MRjPtDFD6A=
X-Received: by 2002:a05:6102:3a12:b0:631:23b4:8dce with SMTP id
 ada2fe7eead31-63a3da4cf2cmr13976389137.13.1779288706507; 
 Wed, 20 May 2026 07:51:46 -0700 (PDT)
X-Received: by 2002:a05:6102:3a12:b0:631:23b4:8dce with SMTP id
 ada2fe7eead31-63a3da4cf2cmr13976359137.13.1779288705989; 
 Wed, 20 May 2026 07:51:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:21 +0300
Subject: [PATCH v5 14/28] drm/msm/mdss: use new helper to set ubwc_swizzle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-14-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6iZnedW4RBQxA96XKjwsTUc9JsPI83to3JJHc5dyQQ4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpo45jCHKUU8FKL8yZzfRFsDWZ3RYW8Il5rr
 8DUbrPGtGOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KaAAKCRCLPIo+Aiko
 1S8jB/9BSiBZy04IfOOx6TAbeE1bNrsn3MwfEjorlEXRkkPZ9YrstTV2eRftuW5zWooGw9m5axV
 J0A91K6H24edalCcuU7o3MQL98+I8X+/4v7jIv7Nhu6qFTuXyvHRJCkm9223gR5P60wXESSEAnC
 cHTUjHzxzEOPO8ODKs41WwKOxiLwgYg/PlXA7u0L7sq6ptHMMRSeftn2GxD6Gx9OwlNmkbd2rIQ
 AEyp7oIyThZcDH3AEkBAHtyQnCxKZ4Wg0onYsI32Vrg9AtRvK5Lr0uDkly6v/1LpaS012KoXOef
 i0S+oG4k0lPxs8XYcLb6bBJWkZTnmRmIpfb+dMQtsxJodmaN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: b3mGbzssdimY0eH_TnDsdtEn22X-kI6W
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0dca83 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=crYPmtHWi7n-_IQ59sQA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfXyxFJQbXgMKcU
 lJNNhzMsuileCFh4OaFdSDv1/6a8JlYeXm/vponsLZJzjX2zlTrB7Giv6ptSy3mDHUGOmv7u9Lx
 GGarmG9gDBcGWIDD0EjvZIOJzlhojbNcjjWdLK7IyaF+zUD+qCige4jL0hbgFNFRmm0d+jLZdim
 2N7yfp1kuoxPYuT9b0CW7YhgNsC1yFrS18QkfRd+9NnQup9g61XHkpjamZ3cKte46aofqJzNe5K
 MjYArphXtb9z8eloEJn64maWLoKZoyZ3bE1NR/nME4l/2GE0Wb3pLDUnetKxLUUZX46KnJlN0aB
 JXZMIeWAYXGEWjVF8xsCetDBqezoTIWhDryDUMQIjitKMzWFrgyAEkg0D1zsDRsrS3AflYLlxVb
 G4MRwlLZ2yc2sbhhojidm20nFtySN4gBkR4N/gRAA/91rWbcFhw38PZnNNDDPtPOx+XN31cQ4XY
 1ZUgYvwJCKDjl31aAGg==
X-Proofpoint-GUID: b3mGbzssdimY0eH_TnDsdtEn22X-kI6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
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

Use freshly defined helper instead of using the raw value from the
database.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index bf106d849dea..3c1f04f12c3d 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -169,7 +169,8 @@ static int _msm_mdss_irq_domain_add(struct msm_mdss *msm_mdss)
 static void msm_mdss_4x_setup_ubwc(struct msm_mdss *msm_mdss)
 {
 	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
-	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle & 0x1) |
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(qcom_ubwc_swizzle(data) &
+						  UBWC_SWIZZLE_ENABLE_LVL1) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 
 	value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(qcom_ubwc_min_acc_length_64b(data));
@@ -180,7 +181,8 @@ static void msm_mdss_4x_setup_ubwc(struct msm_mdss *msm_mdss)
 static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
 {
 	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
-	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle & 0x1) |
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(qcom_ubwc_swizzle(data) &
+						  UBWC_SWIZZLE_ENABLE_LVL1) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 
 	if (qcom_ubwc_macrotile_mode(data))
@@ -197,7 +199,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
 static void msm_mdss_6x_setup_ubwc(struct msm_mdss *msm_mdss)
 {
 	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
-	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(qcom_ubwc_swizzle(data)) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 	u32 prediction_mode;
 

-- 
2.47.3

