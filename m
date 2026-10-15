Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89192CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6E4112210;
	Thu, 15 Oct 2026 08:39:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE351121F8
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:39:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3xB5a1640485
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cK9XIjoJkCr9hVq/5NleYDwc98kzEkgjzgNbxN/oBho=; b=a+e8eLWnUNrT4+2V
 QV74KKIVMR3Q52obrwt9sH0ki7L8tY1BaW3QSaTajSoS2cyiaVvyfq0f0vfZ0p7v
 a8cDGafIuf0R8adE/SIVGsXCsekZjtsqF6NDZIXaSAQvDTZSol6akUleizrqiygz
 /s9hOCh0KK3XK5JPSOtgPDLorokOzoAJPpGXTas+iWLCsStNw696RjuuKjZYJQwR
 1XUjv2HwfaFjnAdwCDW4/Q+tfcr3Qf+XCLd9q1Kd0UEMqdLEpkLf2ZCwseIudj58
 IyeWk4a8UEOpdBRLEJZrbVJfSOFehwkM0evvmve6hT9edE3d6ziHv2ttIRKn6TEM
 Ae6WBg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhh2ht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:39:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-917a2de2cc1so16783146d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792053580; x=1792658380;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cK9XIjoJkCr9hVq/5NleYDwc98kzEkgjzgNbxN/oBho=;
 b=MB4tA4i+ZK+LBIt91KMxt80+lJ+a+7gejABq/xGYQmg9ZNW3U90009eV70oXqo+8oG
 uRBLRU5H/mPiZ+GLgq5Xy8fDgEGvJPFroYgr0aWbs4AJH+brUExvyBLxQapay2Y83YsL
 8B7qm6iiBp8krrzo5RTsWX0ntMJNFuNLZNY/m2kafwfTEsAl6+vpd8X1ACS42JJbc8fq
 toJzLQB6PbrxkNnlCsfjwVBexP0GUCGskehM4bYXQkWFHYReTshi624/7pE+CSCxSf3A
 mqWWuDu6Ho540jk/b7H2d69mDJpbsooNTjbTJMjpHVRbiDat0MPaXixlpXMrLngXQwOj
 Izng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792053580; x=1792658380;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cK9XIjoJkCr9hVq/5NleYDwc98kzEkgjzgNbxN/oBho=;
 b=KS+i2Mv1KRSHhmkFLwevfZhzkN25IIiCcFLUwd2BeuZ8Z0eb/UPLXS9Uuhoh7Y7yw2
 bztNUL53oTn5iUviLHbkhgD+jARrOgUeR3IRjLFCjwWlILvnbgb+hlE8EHyMOHWSdfaw
 Qunu9QKYs+ft5cmwgEgLBnktsw0uExEOzObnjNKuXNsQLRXfyL+Km1clGtNmHhxpwTGH
 gPmh5kVw1c4xZWzPi3PIEkA1cR2Sk2BeQaHAmIme6KGom21eLjr86USGFq74OD6bRlm5
 uVOJe0SP8JvXiLl8HouPQIZoYXHwlM9X6hdE5Tf6Pwh4AU3MDcBZ4q0DjfN4OUoeeKpe
 vtEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtPxkitDbfsO9Em4hKEo4dbf7JiTVLrZaNXkpKyDsVKopVUfnUI4dBmEFA8+xXA9o2W7Jk/ALeGCs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJZkohh9wLOPJ+I4JwGmVP7bKvriNYQ153CokWFmNSvkWsLEBti
 tNKS97hmyn/APcn6g/nTkKE5eJzQjyU2AKq8d79xJ7O8mPsUGmiwfgwszBQttrFJFh6rKqtL67f
 NNrgYVW0nqk2C6c68MTNeTBvIND43V2XbmqGYvOGrkbW7uk0AyyO1o85JlQuPr6kaWA7cfoU=
X-Gm-Gg: AYBFou09jexPMe60TUvYjFqc2oOdwfDQQbiL5kFQ3JFSjD/2WAsh2b6ZXBQ7M/ONNMm
 /G7BCwL9FQVxWdOlaFihiv5eLeMvKsvJfmWd2VaqCe1JIZOrsazQqPD9FnSes3lbW2YrIc9Upth
 YzwB5J3TBqMilAds9bh598hkaDgNpwWC3IuI/7bTMk0Q6sVkfgai1nlOY5AHjqCjxa3OZ2SR36T
 J4sIH53D0QnfSeI/oIxdbllnpuFtbfaNAu3og1kU9io2373D3kRnjhwiQm4+sunkeIYSUW1WTAK
 LjsfGDoPrjnBbIikerwXOJbfUZKJlWAimFZsec960DGmFDMV7oUti/LNrr2t8iVMaa3y7awYzZd
 enCPRayqRxg7aib/sp9XIFn2oRqD4PWA5enBy/ux8ZEpGAhPs3tCfsRfFF7GQxMhZw4b6D+MUEb
 twwkNiu5++41Ro
X-Received: by 2002:a05:620a:8082:b0:93b:d7a2:dd2e with SMTP id
 af79cd13be357-93ebd28c77dmr2879347485a.62.1792053579542; 
 Thu, 15 Oct 2026 01:39:39 -0700 (PDT)
X-Received: by 2002:a05:620a:8082:b0:93b:d7a2:dd2e with SMTP id
 af79cd13be357-93ebd28c77dmr2879344385a.62.1792053578957; 
 Thu, 15 Oct 2026 01:39:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be33d702a5sm1175500e87.15.2026.10.15.01.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:39:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:39:10 +0300
Subject: [PATCH v4 3/5] dt-bindings: arm: qcom: add Qualcomm SDM845 HDK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sdm845-hdk-v4-3-b532b9f4029c@oss.qualcomm.com>
References: <20261015-sdm845-hdk-v4-0-b532b9f4029c@oss.qualcomm.com>
In-Reply-To: <20261015-sdm845-hdk-v4-0-b532b9f4029c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BF6415btVpAVudmuKDsPZH7SQiNfH+6JB5g0CaPUoN0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JE+UE7YxD5k/Q4vJWHJoJXyEzJelSlS/4YLN
 XbzqSTj9eiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCRPgAKCRCLPIo+Aiko
 1eV1B/4hKCj9iu/cD3weh9fVlRyrjQnZHnHtqQAuqn3ZDqCC6Td7Z6Hs0cpl7CC1Ro47a9/slbI
 nvIh52QHz+UX2j7qKjXnOfPS+x1nD32l7y57jRphcO17lIWx48x3SzNhCbBxTvBBBETGoEe/dfE
 Iu3lXPoO08mDAC8lgM6PvEQUUXSL3TZEMnXkEVpI6+gp9mlmLHu/nwt7nKCHD1AwJHA4hr08Jsp
 DK2TeowQOA/zZXMfAH4BCnhStOupCr3A2Ps3J89Nqa3yqqdHw5DzSbot+TAr9AZ52JfIJAii0MT
 XnwgqGnah0p4rwDtovARkKmY1eHH684LpYDbMOVOXhBJ/wkg
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNCBTYWx0ZWRfX7jDl2ACr4Q3U
 y8SYtPELbrDxZyPkSPS+b9NUgdMwAEE2waN664klSEKWyo0DUr6J/sDG29NI9evMyi8srgY+8Cp
 WC3JfdN8ADSpf5prCB1njuoRSFQDqRv+MIa3YY3h+qIqV7RxaYbmfm2K8Yt21OXHsbFfFX+/lci
 /kEBqJZIZfLYGZ5cvs+6AG/2S8zYGw9LMReFmQDlgOgDl2YA0jcSnJXwIfAb2M0vttHdWzojR0w
 29ohQZEVwLoo6/rF+Sj9R5lpPgQk9NxesQgNv4OxPz7AVjp1rR/q+TDqDNWg7o46lEz9AdnvKle
 Ujj4UOg5fAJHJgILgIX3h9YW0MSdjp9Y2HiWNLetS7fOWPTFz2R3PCD8ikMNTd+3fKQVnob/s6i
 bzX6TxkhCZbm3x95/2nqYrEUdSFcbJDntMKrDmdnZ3ZAYx90BFeSMfwOhbHWyTeob5PBBT37/SG
 FnYIrnELq1MwqWor/1A==
X-Proofpoint-GUID: IAGae4e4qLHqLGey82Ae55psr8g9wh07
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0914c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=9nMZPvWkDyzw5AdY2PIA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNCBTYWx0ZWRfX+/o+Cfa5zkPb
 nlmDoLmjeh1tmHZpIDsHitYQV+FZ/p9uzuL7k/NMXJ4UOTbnt8FvO6gzPaeTKNfcV1sKcDkAPUf
 dftx3nxJQlfn5tJBIDkTOaSj1MCo7Ik=
X-Proofpoint-ORIG-GUID: IAGae4e4qLHqLGey82Ae55psr8g9wh07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150034
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

Document the mobile HDK for the Qualcomm SDM845 platform.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1e..dec58f8818df 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1003,6 +1003,7 @@ properties:
               - lg,judyp
               - oneplus,enchilada
               - oneplus,fajita
+              - qcom,sdm845-hdk
               - qcom,sdm845-mtp
               - shift,axolotl
               - samsung,starqltechn

-- 
2.47.3

