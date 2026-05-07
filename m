Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E324DCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 522C810F0F9;
	Thu,  7 May 2026 13:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M4OlXS5A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NBjLD+si";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0F210F0F9
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:45 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647AYYpb026592
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oiUTlYZdmXRE6wHZobRlLY7t2S1s4URFF4b8EHPtYQc=; b=M4OlXS5ALFlhkFd9
 lGFCXfCT5Cy+fR723ysKYQoY5UdnPwAtBVPIW5wQmIHDnvaF57qvyLQTfeAvpO0Z
 U6IcGpJNiWhCDEtG967GB+Dif/ENmmJHmHnTD+7mHGkK5e+vKKV4YYG2jsVMrq4c
 PQJsWJB0mwEECqVMV7mx/Jz11pWg+bUhtMq6meOq1wGec+mNdHcnrzIAfJMtmbqb
 vC1045ULf9UyeBVHKVYjfHfOLSEF0jVhyQJF+u8BQvhfS9LVZD5vR8os9bVqLK37
 WP3qo4t16BpctT1z675jThbvyQraQ8nPU7fYiZruyWXxakOavZ5XpfIp40KTQvzO
 WtZZXg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t1yte-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2adef9d486bso8833825ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159024; x=1778763824;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oiUTlYZdmXRE6wHZobRlLY7t2S1s4URFF4b8EHPtYQc=;
 b=NBjLD+sirAmAlbEprLXN+lazRL07Ukeo3SiqK/rMF0377vN4VbAEMk6zRQgQmZuZjF
 DOaWE+toG4uWosAPnBrsTJQEt71hZtVDl/Sw03qDF44lO3XBJ+xlwwghVgLfsRHsqdWI
 dDs/cn5IS1bsjJOYbU4r90jjASUTr0f5J+GOyk4mOcW07lLCqpVl7xvAqFsJPrklpBjD
 qqTtED1DT6y5ZeRZ3ju7BSHfPlL/krmQHU6nqew6hc0B+iAa0f6lZZ7w+s6aFf0CL2Ca
 e+5qj9rpEEZeY4IrLo0CoPN78aXDHUKsHs5wUpnCHrTmcbwiJB7H/37PmKmhFVWuWN83
 I1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159024; x=1778763824;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oiUTlYZdmXRE6wHZobRlLY7t2S1s4URFF4b8EHPtYQc=;
 b=pg74pLv0xikWyq1GG5p/0abz4xATIpI40OM979zzZIKHRPcOo4ynHtihz3a6p3gAKx
 Cs3lan7rZOSHRETLo27yYdsDr/b10ulCjmvqokQM6kxvpLAw5hRC1G0ryAFeXUHWEFTI
 xXJDjb39IeHfknCEq5GwSzcn+qO14q6WRc3VH6hOuiGJW7ZjcEU2EeBoRokl4140yUp3
 sAqqfgY0OqMV8ImzdbFypEEh+w5y+kkd3Irpjjr8at87bfdoICi7Sq9H1TOyfhqq411y
 8qA/7el3BOGzLYZXt8oODeQFhQUbE04JvMaHTIQiApQpDdMFKxJBMy5DEY1JirOBZRa9
 bcUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/x7TcfK2ldjoFAgfSuunM2B1xFMcLoWajFdjNuxO6J1AHKJ8199VvvC4OWH8mwOQPBZpo5veFLvHM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMJUH+UUbw5Nd5iRn4PQ4HfH4XacHOvxFgpnEpXJ9GWc607Kae
 c9AWmbGn566DXyn5FUR4JhKURGcpK43c3BIhf/FTfw9Xun3xkkIshmNH416MfwCuDIRexzDGVip
 NZamJmZOz3TjaFg1JPByPaM4Uf0oRe0QOMyo8kKtDJvPibkl0fk2RR+1+SMHhuX8t3lxhpes=
X-Gm-Gg: AeBDiesIbH22T0kKKqAfWXRIru/Bv7tihZJ41/ja6tF8JvNSebqoZJZaPcDgy4GZfjf
 Hl2vOCXbeVwSRDSw1EWbZLEjpx353vO4hZY6xu642Xw+DY0L7oAFJGSLEqeZ1EBNaiKs3Ds383v
 fmnvGBm1vSKXuy9jWySQ0TcImD9xmeeSInbPir1V8DU0sGpZ4knn/2mTyBH0bfhc9sYdXZjoVck
 i48dXyl+UeQZBjuyS9ba1/T11KkwVv26PhAbcdjs2zB0JFP5eAsHbSJaN3Uzk5+Lrd8OIxGErGu
 xyUjoxESw4f7PayM6McraUKSALgq7FwLH6KP853UHKxYhP3ygxfU4Cn1GcYWjLWTClRzTxBkyUj
 KNlUnX5U5y/XFB1e/IPJdV+/IT+2p4ieF7IO//9s7wtq7TzsRAW1rSoGhYSGkmFTBP88C8E/QZu
 FEZJS0RFYbWy4ctvH+Bw/1z9+vIgc2ZbV4F0w/1nlMECa2SA==
X-Received: by 2002:a17:903:228c:b0:2b2:4194:9521 with SMTP id
 d9443c01a7336-2ba79287606mr83822595ad.25.1778159023372; 
 Thu, 07 May 2026 06:03:43 -0700 (PDT)
X-Received: by 2002:a17:903:228c:b0:2b2:4194:9521 with SMTP id
 d9443c01a7336-2ba79287606mr83821705ad.25.1778159022681; 
 Thu, 07 May 2026 06:03:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:08 +0300
Subject: [PATCH v4 12/29] drm/msm/mdss: use new helper to set UBWC bank
 spreading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-12-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=853;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=05LhYAKGVaBgZaN0qt9lOXQChuEy0ARdc0e/ucvP2Qw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2Fhhk+y1A/vA53ZjfHg0b1j3nZP1YRm9BP5
 KmCDexqGM2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhQAKCRCLPIo+Aiko
 1XleB/4yDRk+HvjFV1avro56hNN8IRnAnCgBilurLhhmm58AXYk2zSEzrvSs5Ybj6/NuMoAiSgr
 MouNFv9OqHDFlmAd/OuOLwiDpBe40kOWdY8B1itZnspKo6CI9ZCMPUucJg1smVMDZndAzMcVGib
 TKoIM/Pa6mjUtyhjHBS17piCGA0rbGij1NZH9WhhczUKI2WTn4qbBYYEWsecDT/YxCPIS8RG6Nu
 lzqkjTc2E3dLefeTMT50prp65Y5iDwD5SgXt9xEgY9WePG9AS750B345qCPe3tN+OCmmI7XGFI+
 1hA8ZRKnYfqkuQ/K2Z2rzdNgWxsyokiQ5PJBnJ+ub6xoGURM
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fc8db0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=vkIeKiNhsAXvYQN2DwYA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: htdRu_vGXUtQ6BSXtyQDf55Q61nfTrQG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX90SEnZQEhsCs
 KZ5Mk3H5eACDi1qu7gOw4woZ2vohYFxeUg7i73Dd/gFPRzBdn88dA6ZMwaSllN9ubKgHYNz/yy/
 YUK2nuLuxx6DT07AwUdJf6I1UNwf1oJ6g6/0jJFKlkzPxsdpZHM/AU3mhvYQNFxVXfj+wxD6sPP
 YYLGpHyPQqzNh5vzB8ZcfOFls/izfQ1fqb3UQLJcz1Cxspg0bQmRwdWCIUj4H6GKzDegoPuHoi9
 fP2Z3WhcgbcNyj2A78DuFwDyqG4uPweXYamWzSsAkD3Wa+Kl+pZ+F0QBbRYLvyKF0mjtOGV3tJJ
 w6pWoKfppdYB5/Of5tY7HDlEqClzww2uhH84+VYOxgpnP1oQ/gnj+J/UsyhfbguIiJEwCR1xab9
 rLTJld14ghXPUsgrz5nf2xEBHTBBx4gZq5liu8othI8XjGv9pHb6RwCiCnqALFxBcHeCXcM27Np
 5/86Y5fPDKa+44F4jmg==
X-Proofpoint-GUID: htdRu_vGXUtQ6BSXtyQDf55Q61nfTrQG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
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

Use freshly defined helper instead of hardcoding the checks in the
driver.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 2742d4bb2a4d..bf106d849dea 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -201,7 +201,7 @@ static void msm_mdss_6x_setup_ubwc(struct msm_mdss *msm_mdss)
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 	u32 prediction_mode;
 
-	if (data->ubwc_bank_spread)
+	if (qcom_ubwc_bank_spread(data))
 		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
 
 	if (qcom_ubwc_macrotile_mode(data))

-- 
2.47.3

