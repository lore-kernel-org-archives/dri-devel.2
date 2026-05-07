Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64105CD342C
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 01:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B156F10EF29;
	Thu,  7 May 2026 01:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XrQAkdoG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EnWIgyQG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13EE010EF27
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 01:10:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646HvjOW2581411
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 01:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Quz1+hYLS+IVpR4ioPDtziPJPuojhivjRtEFcR5Dsis=; b=XrQAkdoGV6aznQRb
 Zk7jL/AJot66c85Wk2j2diVCfJtT2+HoQDiuZP6FjWbPrStDJo1gzhvIDKI+QT0/
 WNZ5UfSYdaa5l3Ff4eRQPETOOUSgZZihF9CIPSQ7Mz6LihHTtnM1g7T42QWPVksA
 YZ/Xv+iOva1IBtLDJEWRToPJD2lbTb9ogfpoosPY1Q7IeIjii0KX5xLkUS7J/5gv
 S2uD0xbC6cq9E8eHN214dE+yQXV26QRjb0gE5NBnDi6aieTIVjTfJHNEE64EaN6b
 bwK3Qfxi87P9TeyHXjrhQm9LwL+yxA1gX4/Wujs7hD4ZAtRYtATb9dfw2UX9qj9x
 dio9lg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyyvw401w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 01:10:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8d6061bd722so69048085a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 18:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778116255; x=1778721055;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Quz1+hYLS+IVpR4ioPDtziPJPuojhivjRtEFcR5Dsis=;
 b=EnWIgyQGipsv6ZSyLTWUpvOfxc3Qwt1kVLqWtaPbvMwdkvNuIWub6BV6h7YRFEuD9w
 Tz+xBqVoLmRjDqRChRWJQX67ZNZbAk247DuAcIFdVdaI2CdyFlc1J8atl0FuK6maDeBu
 AtrZyxaXAT/r82KbXCjzJxXuxxyya+c6nq1D6lPxrjBHmPbnylrQ+Vb6nxxdVdaftQgT
 vMHK5uXQGqezRQmzmash8t9du4GY18UWel945hbHzH0Qkghtz9wXGJNUTY4PZygSHaFW
 KkoxD2CkmrhIWdySiTYUkcbwa12mIn0Gg3if6lISTq9t+ZrdsBF0H7hNBtQ2Us0vLcV6
 N3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778116255; x=1778721055;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Quz1+hYLS+IVpR4ioPDtziPJPuojhivjRtEFcR5Dsis=;
 b=ORV7CqLYx07QTQC+OUglljOmAeigTbpKl5E34Xu3v4FA7Dej/kkURlAvncbTnGJBMH
 7iX3bWzdv6D66JkA2X6wo0VPClAQLuNM0fv6w2gZAo6PHwVFR/PMxYgTo4QBZHCgXtKv
 RsMBNTBNlaMKGhFjT6n4Ct59VmMMO1ojKVmWtrnJX7ehwizk0nwZT1N/PCl1WMhy/HL1
 J3/TU3pvS7qxtEuaMfWJ11ZsOPOcCvJvJbZqnbvJj59X0uXgM89SegMO05ZXG8+cMk4J
 XZ1NLEcne3G9Obq51J+DGqaMroJrkOY08hPDNBvbq7Viknu+F4XhamdGYcohIJ3db/2i
 /Srw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GmLjXFeKZoKTBfPBaNaFY3kvI1FAP56zwN5wrZ56RP9oxTIJ9QmizmNPR1fmT/j/AreL+YWJ631A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YziiXKlUAMEAv4pWzpCiCO5qpssAOq+kP+tc6/zjtkEpeqsZ2Gj
 ATZGUsudTQE8Pj3Br2bYayokhRRHvMQ9cWInodZK+yOUIxv3EqqLB6LRpRCsYwtg3F929NrfCG6
 McdiLGGMAqiJpEpyo2CmKBLu+WbiV0Hs/COcVhn5TyH+Unuu+sV0mgUkViWCwbbGiv6v45SM=
X-Gm-Gg: AeBDiev9unsyUZiGIVeQd/XhnHsdYab5UQLVYE2xOGKpqYOyS2uHEiSZTxgKPVicRqq
 zYBYZAwI1e4253/MMbJfof6XYMbo1Ax9K9VUfHiaH1iqjaECwcVI5Bkd4y3+8SPDKIJcqXKFWmR
 0GUbQrvS8+8sHmDlMraoR0qd3OepVJqMwL5U0e/LnVxaS4JSzGxA1poG9KNYWRnzelSZ/J6pIgu
 vkZS3b7NAOlmXHQffM9BEVnerNgWHs9Vd5BQw0CwQ84re5Yll+DGROcdn5iI0dt1BdjZOE6xxPT
 I+zYF/1SNLK9NSj2TkyhlBSjjv4vmA8LVnrRzdNw7aemERh67z+HN7Sr69Q/4iZGzC4gQor8vsO
 cQVm29qRjmrTDoy3rsc2U8Gi7p2GigsVxBaxYpPu8eOJzWiQenuXzD/LPhTX0iQqsza7Jf1Q4hg
 vMzKAUYRgXgYgzemUWlQMM1DAX7NOEitcJN7cJv2A/LCSB8w==
X-Received: by 2002:a05:620a:2a0d:b0:8eb:425:2ac6 with SMTP id
 af79cd13be357-904d4b59704mr841981085a.22.1778116255486; 
 Wed, 06 May 2026 18:10:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0d:b0:8eb:425:2ac6 with SMTP id
 af79cd13be357-904d4b59704mr841976785a.22.1778116255030; 
 Wed, 06 May 2026 18:10:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230e00sm5221967e87.29.2026.05.06.18.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 18:10:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 04:10:42 +0300
Subject: [PATCH v5 3/7] media: iris: don't specify highest_bank_bit in the
 source code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-iris-ubwc-v5-3-e9a3aee53c49@oss.qualcomm.com>
References: <20260507-iris-ubwc-v5-0-e9a3aee53c49@oss.qualcomm.com>
In-Reply-To: <20260507-iris-ubwc-v5-0-e9a3aee53c49@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Wangao Wang <wangao.wang@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2440;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=1QlP7Ht2G4UJJw6JsObuL9FKuIo3jLuJ5rs2/0xHro8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp++aUhWXHJTdo70XvRKwJ6GRjpbcVSdIC2fJrd
 xPBFijrFsmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafvmlAAKCRCLPIo+Aiko
 1Uh1B/96m2qYOJuCsfVHLH0lul9CSxOjG2U4PRerFqmH8bb8xlJmk8iTl8H3b3z2W0kaUR/9v3C
 zcoTd+betfJO2GY0WJGeV8Qly8uQrOxAi+0s0gXC4WM4FG+F0nG+1qOxfVvxFuiD/Jaulm/OqQG
 BWdTVw+mMiwTOm4/BZYG7dT646CakPD2PjUdj5zde0R237T3ZGpJIK5KFf9Z1DSMfgruoscN1Sw
 lJrmBulZW4clIk5vSofy96LHfkXwhc6dyawR+7+jzviYgs7uCrzSeyQRy4HWn9NkVAnUr7C7yE0
 qchBripLPUCRVsgJsue9hwn9CegoLN6ii/15viWl9ip5FtWH
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=YYCNIQRf c=1 sm=1 tr=0 ts=69fbe6a0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=2VIzI6ABkMI1kr12n-IA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAwOSBTYWx0ZWRfXxoDBKaJ1k7gU
 VJ9BWAA9CV49ZPjWvJYjSWgfIa16FNOCHo+uYurbXU3lINbb7CWMNb3LQkM/z4WwsyPWzpoh26G
 lu2c2THXb2sXwZ2/dgN4wOq0Rjw935MlWq4MJXmEE5neKZxsDepTJlgeJsQhO+0aDUFMw+BAdfC
 Nq/HmM4pqeftQr2uwSVtt1biy7XcVPZquKdXmZ1PZ5o4Qt9ve1b0bbl+yV1Rz2Ml6vwFl/7addt
 /aLKUlmT1laeLHXGc/ITMAlnhhBK/d677IGBZxXGfnyetrO6ha315xiis6sCfl3WQxANokpLS+q
 SojDH1rUc+b/iCJfYH43ifOLer6ANmpMx2hKddAj35hRCDTmUzXWxw0SVrq0wVmhp8jantjtfRV
 oDbdOaMijzDC4unpkZ5RQtFlk7sWhmF7vG/yFNhN54bSiLCY2d3uxPGu3qg4DGLoK3DAO/Us4oV
 /1k/9weqLt1l7mc9EKg==
X-Proofpoint-ORIG-GUID: y4JmxdXS-MYR9Mm7vC491G8RnFhRqZF-
X-Proofpoint-GUID: y4JmxdXS-MYR9Mm7vC491G8RnFhRqZF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070009
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

The highest_bank_bit param is specified both in the Iris driver and in
the platform UBWC config. Use the platform UBWC configuration instead of
specifying it directly in the source.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Tested-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c | 2 +-
 drivers/media/platform/qcom/iris/iris_platform_common.h | 1 -
 drivers/media/platform/qcom/iris/iris_platform_gen2.c   | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
index aa4520b27739..6dc0cbaa9c19 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
@@ -160,7 +160,7 @@ void iris_hfi_gen2_packet_sys_init(struct iris_core *core, struct iris_hfi_heade
 				    &payload,
 				    sizeof(u32));
 
-	payload = core->iris_platform_data->ubwc_config->highest_bank_bit;
+	payload = ubwc->highest_bank_bit;
 	iris_hfi_gen2_create_packet(hdr,
 				    HFI_PROP_UBWC_HBB,
 				    HFI_HOST_FLAGS_NONE,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 08a9529e599b..5639eb5a75b6 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -77,7 +77,6 @@ struct tz_cp_config {
 
 struct ubwc_config_data {
 	u32	max_channels;
-	u32	highest_bank_bit;
 	u32	bank_swzl_level;
 	u32	bank_swz2_level;
 	u32	bank_swz3_level;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 01c6ffa7e084..bdeb92e0b7bc 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -792,7 +792,6 @@ static const char * const sm8550_opp_clk_table[] = {
 
 static struct ubwc_config_data ubwc_config_sm8550 = {
 	.max_channels = 8,
-	.highest_bank_bit = 16,
 	.bank_swzl_level = 0,
 	.bank_swz2_level = 1,
 	.bank_swz3_level = 1,

-- 
2.47.3

