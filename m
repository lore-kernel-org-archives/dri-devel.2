Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BA7CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 697DF11220F;
	Thu, 15 Oct 2026 08:59:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FDD11220E
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:58 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3xmOg2739406
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U4zSLbAg/vbwlB+khcp4ptsONlZA9U1x5Jat1WlHBG8=; b=OM+bP6EVReFUco1F
 Kmu/RqgCuizgP5HA+X+h6sVifPNpBZ5iGlyFseUUg1gI8peNqCUoD+46aiNGLtyb
 lnrBUIrg1yCMq7XQYbxTYDCZWtTJ1iylSUUCU7kWWG+LG6DcfFDQuWk2i1MDO1bO
 o2AACIqsElbWSUgnX3+VbSzf3VBIOkGSrYH+OugJmahh5Qz2R7UhKXl2reqP07Ia
 b0QtV1g3K3c5Ofug5gAM5IW58eSaQ0K+Z1ravA8wYP8VdfmFq3Nz8FpQj2LeGpSm
 opCCLfz165btewNVWm846Yu7PS4mGUmVkiWuogvp2Izbf6xldvmV3x0wUugzYkSj
 aJ+jmA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds94gr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91786abb5abso16194076d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792054733; x=1792659533;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U4zSLbAg/vbwlB+khcp4ptsONlZA9U1x5Jat1WlHBG8=;
 b=S9S1baPsdxWGVbpmmpYnws+lk3nGHVUXMDqooDWr5bYRpLKL6vNjIjTM+/28Q7k3DY
 B1BXSAGQC4Nj3tYhh0l1pl/LbrwL5GQUNaSU9guToL+e6iaPvXZD0udrnETnJZTFgXdP
 Nn2UTI4HUsHK+5aL/6QDj18oUrTlhQC+9prl0O6ZIY0yGPnVIDpspPJ2oULUd3abgR56
 zLERAQn/f0n5rfUJV4DbcypWYkeX75IyRMFbRAvDXpUtNlOlYCeLh39feJQeRbpEyJBf
 wpJlsq21Dk2LZcYd/xmUmsMJtHqDxDssYI6rBuFNCwhDhl+RmMm9hXnOH5naab9cqXGx
 aPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054733; x=1792659533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U4zSLbAg/vbwlB+khcp4ptsONlZA9U1x5Jat1WlHBG8=;
 b=0nnf/HTT6s90W2WJ9ET3afBAC5opWQmw5rEIAy/4QaoyK9fZoXBRLqoERQBl83/yZn
 mts2HvOf1+qWukK2qeF6qmjwbnKlFEMhwo3HPj4KDtDaNOKbgJPlrgJN3NIQ2gxmvxOz
 lee1tUbcbBR9Fj9FxCFabqiJpmzqeSR0H4DGC+VRLYSniVOzFWF4MthAcMApRmZwdoMZ
 a1KEm3vbZqtF7pltHlZma5H/02W6QuRaJbdzRHOTGhmpbLrJbHERtdyG+7KM+rrEvWDb
 /Y7CAmXHRhiAxJtIDHn1tqur9L6dThd9hLVWYvYfLEwLOSFPgW2TnHnwrk2VXKl5BzaZ
 lvRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8OhrB/+p7A5GwNk/3kendg+Ze0+mRCnXV3FdsnPMNobpmKBE5483wnD0JMKAAzAihK0hqKLlwaRg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLZpS17TbAACHrImUaqpoLGFhhwGL+oKSHCOKBXUN9LOOjqh4is
 XoMVNYvbXG1dmAidp8EPOUVqvS1ENjNAPXH01SFQSxbJV3bitQxOyYBn0S4PIISb56QPp6WUcHw
 1g1ccl0HcbqG6MyVqu2ZqX7X5YJ1Ug3pX/ZqhjgWb39xqie9Z2VuBb3ZVMICzeoHvixTsZ2A=
X-Gm-Gg: AYBFou3VGMw0A5rAW6eIFs5fSLjEMRsgTMjEttLNkrbowqIHKUV/A6XZ4yTaIw3a7mk
 NYPB6BmA/aMkQsR8laAP8jUH8R619/ljulGVoihvCRE8qJyRfL99FZXo3Ol/3eqPdh9PWQDP+S9
 ZEfcq4owGn2bs3AcVwPAoJ+unxlmKCI/HG82p5jLFxULvfcPww3tRM/YE2iS66FfLMiirJO5YQY
 HH9TqKEnZKzQ24r1XOBSoj62k0lUymrpGAOh78Sk0RV/tGQp1WmhyaDzrzv22xXcOkJ5SAGgSEO
 kHgDaNTF0miLwYBXkbBjD1FX0XAqfUUSmAmV6OonlsOdXBnRcRjhfpsGjE+iILonrzJJ8wbEKRN
 lJ/0J2ZUo3JAtek/K+AqbZqwiVCUv2WFowgLGcEIRhBtG2G6lZNjsLGrtmYiNS+CABZoFDMVpG6
 OWs/wz22QNpIUz
X-Received: by 2002:a05:620a:29c4:b0:93e:fa30:f1dd with SMTP id
 af79cd13be357-93efa30f6a0mr1113601985a.70.1792054733443; 
 Thu, 15 Oct 2026 01:58:53 -0700 (PDT)
X-Received: by 2002:a05:620a:29c4:b0:93e:fa30:f1dd with SMTP id
 af79cd13be357-93efa30f6a0mr1113598785a.70.1792054732995; 
 Thu, 15 Oct 2026 01:58:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:58:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:38 +0300
Subject: [PATCH 1/9] backlight: qcom-wled: fix unbalanced OVP interrupt enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-1-5c14928cef29@oss.qualcomm.com>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2HxbKMgISR36NuY4C8FsImVcbMBzlwdgTiNeWWNsGmk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXD/8HOB5jgW25p8UZfYUn2vV689TVBeZYT0
 2pF2AhOLU6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVwwAKCRCLPIo+Aiko
 1QLXB/9omQO3ECKe1kevnZE9IomUsynXXe/Ko4ChnIc74C/EK4IpBaNiWg0LR1I9CwDMqQii9A2
 d5OL6Iu+9yZ8C8dlZiRmIo9ddGFbbRrysmLmCuiVBaa3h6CudVIwJD7lp9YaBF0nvAL3S1KrHBb
 ngZ/mMBJzFdjlnmjOmDIWxK3OFKPUZiGPpJSUDBmkDpL+O/00+7S9znMttdIpuS867FN0PENPQx
 PHZ9hKxuDjnpRU5jkO08PLq9dbHnA4kfYwjDy5h7hIAb0huK+rqWXPaoRTCkI8H3cxcXkTl2WSG
 wuf6arG2YJeEc8OcrWagwZHqRd2G48OahbualL6t3bavfhdr
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: LelDVwbN4MQ3gA5_fouWpvCPfMT4JRR8
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad095d1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ov7LMV1X4ZCViyyWaGMA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfXx3T44EjcQ1sZ
 1IlLpS+nj6cY97YXp2dfTl0FX1YWTFfrAIlT9Xo9QLxJSZb81zPm4K23NGbTrsnLJgkVdHgX6qw
 iTZef2uehJl5QenGqrF3Y1t8GRgfvida+sl0Q6yxeO8BwE4mFb2CJSPsaTTCyjXCqk4u5CtAIRO
 sxlIJ+h829QZLFejrbL/R6EPELZv6PlgPVOjAHXhGkreKr4Ym9qOXDoBjhirNEX+u2a7uh57iCO
 RZAW399WQTTHXX2znE+tRdPikac8DSZSg/4Qr6vcCOqjufeUoYw9TPdg/BMV5vVfIENN4dCEFIX
 QuPDsqhvv8o/s/Ukh7KyPnNXhVxqd93gMwlcKYZCVgh/jSg8CCuKYoI+97cJrCqehtP2SiGhVcF
 uhg7JqjETmnyVw2LU4IPLwLaiCkAK1hZ4NjzhbAX840Zkdj0bGKpCnStmdjlQdfTxxtykqS2n5s
 FXP7gPIbVeQi+zZDz8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX03bXoBHcC/EC
 bd+rZ4nHsFAkV91hR8kO7o7NHvbu6UFL2C2pj+2krtZAxWZrDtbDvhrzIrd7g57w1xNPrhBfi8Z
 VufqyMAw298o8GTOb84UTtDCdbbkacc=
X-Proofpoint-GUID: LelDVwbN4MQ3gA5_fouWpvCPfMT4JRR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150035
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

If the bootloader leaves the WLED module enabled, the OVP interrupt is
left enabled at probe time. The first brightness update then schedules
wled_ovp_work(), which enables the interrupt for a second time and
triggers the "Unbalanced enable for IRQ" warning.

Track whether the driver has disabled the interrupt and only enable it
back in that case.

Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/video/backlight/qcom-wled.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 650dd95f06ef..f2e0430cccbc 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -199,6 +199,7 @@ struct wled {
 	bool cabc_disabled;
 	int short_irq;
 	int ovp_irq;
+	bool ovp_irq_disabled;
 
 	struct wled_config cfg;
 	struct delayed_work ovp_work;
@@ -294,7 +295,11 @@ static void wled_ovp_work(struct work_struct *work)
 {
 	struct wled *wled = container_of(work,
 					 struct wled, ovp_work.work);
-	enable_irq(wled->ovp_irq);
+
+	if (wled->ovp_irq_disabled) {
+		enable_irq(wled->ovp_irq);
+		wled->ovp_irq_disabled = false;
+	}
 }
 
 static int wled_module_enable(struct wled *wled, int val)
@@ -321,8 +326,11 @@ static int wled_module_enable(struct wled *wled, int val)
 			 */
 			schedule_delayed_work(&wled->ovp_work, HZ / 100);
 		} else {
-			if (!cancel_delayed_work_sync(&wled->ovp_work))
+			cancel_delayed_work_sync(&wled->ovp_work);
+			if (!wled->ovp_irq_disabled) {
 				disable_irq(wled->ovp_irq);
+				wled->ovp_irq_disabled = true;
+			}
 		}
 	}
 
@@ -1649,8 +1657,10 @@ static int wled_configure_ovp_irq(struct wled *wled,
 		return rc;
 
 	/* Keep OVP irq disabled until module is enabled */
-	if (!(val & WLED3_CTRL_REG_MOD_EN_MASK))
+	if (!(val & WLED3_CTRL_REG_MOD_EN_MASK)) {
 		disable_irq(wled->ovp_irq);
+		wled->ovp_irq_disabled = true;
+	}
 
 	return 0;
 }

-- 
2.47.3

