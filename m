Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A235CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA972112227;
	Thu, 15 Oct 2026 08:59:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53CAF112208
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:58 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F8IAl0842056
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fu5asBWsdvZx56+/lcE1g2WUnCmTjVqkOuMEFTUOFaA=; b=X697Fs0IdN13Qryf
 ZNhc2bA8OX4BO3VAw1w5Te04sfP3+bIHx9kTu5yyBtwKRS2O0EYgGcEWzz1Ieo5w
 HpQaIiUUG/n0hYXrqCJQxgyQXFdmfDVnJmffumNjoSTpbkK3KbPJiaBZUxVcn1Vy
 WdFlHFHWrhq9KYX8W/M7gyZQE+CyKWkZ6R0EOxgvj3APXvlQOaY6Q7nIbGtBeqam
 KFK9F0k3HtS6FoZxvBQ++x2aFaxh2g35y2QZuaTTZ2OLO4ynr6Kvy0khiyI6CfRw
 0TMxcOaUWevEpNrDfbyJSHu4+EPCK2B7XT1ru6bsPcS9/Qs+po6JuBtqWTJISerJ
 yAF1pg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wu4pt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:57 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917a109c937so16684896d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792054736; x=1792659536;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fu5asBWsdvZx56+/lcE1g2WUnCmTjVqkOuMEFTUOFaA=;
 b=bC6PiDmRWRKT/3e3aQiIvUJSWTOUFQPZop4A0gxCu1aqUvI3lcBjeMMds9Ki9G1M7U
 TmBX0ESxE8qjSVXLdhKoEv21+uCVfTny43hfcGkifbrBtFEtZw3D+khQ7HSYiZZqF2le
 KErRS99ZYH/Qu4Kc0Qz/zn3VzFQ7rUB2Yh13SToKHy6z8sVVvOySrs13heCna4dYo936
 mTxOg1hw6+C/AzIm1yYWdnvtPq5JaDDUoTukcVs2LjFwyOyAQvfqgeycswvsBNp1xY5y
 5JPMDDI7FTAO8PihHwb+BrWioAop4L9vH1vXO9NQzOUBqxg1mFXnDemXNivnFTyV14P2
 k4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054736; x=1792659536;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fu5asBWsdvZx56+/lcE1g2WUnCmTjVqkOuMEFTUOFaA=;
 b=HEXmAZFdSpoPhFpQmIlABgntz6/Wm7Mrrpi16ACHCGy5YGepU30t3amTABr2+sDEqI
 uJ9ejZAwtpo6BeQxcGsOplW63M5qfmpewJZB26BQn3CWPaJuMnLgL6UQUYTSAVtCIYsu
 n7zxjWDKqve378X2G9ijAV5w4JfSjy4k8TQ6S68YOsTy58iEppXdJ9LxPyvcs1+AJ2mr
 1JTOLoT0AAkB1Y92kxcSmpKcS83DacVO1uIH+B1JGVD3dDF7aji2i6aYEAI847rOe4wc
 aLISim2MD59PoP5aHvOcwa5QyI4eOYWdXCeq6e/MH+Rt94mJuWcszSMQWIsb0SuquTPo
 WRVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzw9oKxvRcIyFsXncoLk3Wyd/3HWRqZelC+7OhrVG4cKygMsIJwUG7dAwgLW691S1/ijyiwOzVfAMY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL7gdehLbpNyf2o6A83p9THIyiXrUf61NhHRNOfgUZAPj2WHf1I
 UANkQsWHsEz74TH4vhoFEchFYJ0IZEfcKBpxjOfWyZuQbG2/LRmlArUvoD9iFc8yNvXyApAPbnH
 ur20HlRczQfUDAOx5iIuFIQyLVgArN7H2FvDDnO85DUawxaeULqqfVh+oCKoK/62r7OBMTDI=
X-Gm-Gg: AYBFou3n2qXd9CZCTeE1DrS5OdBNtGyoNL3ynXNraId335m5xw91XFtpa87/mPdDjfw
 YWekIBqFejPmtTySoxbMplVEvD3SkRt+NHikd1PYeZ9WAiJa8P0v33XkCMr6KevKlNGwqg/Uib3
 kHsv+rtN4YKWbae++YyoRv9UFbjGe1nRnGfsv9LEczNAq+qDNQ+3TRQbQSHnpaeN/bolkZrg2oI
 mb0/o4bwJ3a8F06dvIM3mJOruo9Cf2lbhNLRFDig41sNqGK4D24+ycVVnd4jz4/C7x/AvH7sT0S
 SUUfbMgY0Etv5Goje7W+92OCsFkBF2B74vpH/huXwTH4VvMIfW4fWC8Fgr86z1s0ov0YaLqmUYE
 onWJJKrH3saEIViHRnDLyqzZjvUI415j8N7MWoyV5MXNQIU21x6SRT3sIuAs0YK6ORR49GySb0w
 RbXv+fODq74eZ1
X-Received: by 2002:a05:620a:4515:b0:93c:aa75:71e with SMTP id
 af79cd13be357-93ebd27cc81mr2940668285a.55.1792054735519; 
 Thu, 15 Oct 2026 01:58:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:93c:aa75:71e with SMTP id
 af79cd13be357-93ebd27cc81mr2940665285a.55.1792054734983; 
 Thu, 15 Oct 2026 01:58:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:58:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:39 +0300
Subject: [PATCH 2/9] backlight: qcom-wled: fix string detection brightness
 on WLED5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-2-5c14928cef29@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=bW8kWuHi0rdhUiH2MmvmuegVaB0kaQIgT5fkySeoKIY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXD7igeeOEw9oAho9ES6xgeGbyBhJTixyVNF
 dpItUZlKseJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVwwAKCRCLPIo+Aiko
 1ZJ1B/43vXCy6gNpky6dmfGFc57JTgyIeKTZ3FvHMZZ+jRKMpJEx6YXigKvK8BjcF/iqVJ8KKb2
 xCLhzcKp78trBZwwKLDxXmTs/o8j5oaug1+UYmj0h1ikO2QOZVTpblxQlHlZ0tn8b9tgYBV5298
 Gv5UJm3+jcwLI31guZvzpqOkEn9ROAEwzdTKWuO6MdCagN0nkPmNaScX77F5USHl2x7Cf/0Bz7A
 4O+RJ8LJnplu7TKGJ6lz4C94YBrWIGgSuFyx6rHN7983t2CnRfRyJAv0CN8yK61m/1Gigl7DaCB
 Y/9SIXc7kwXBvbWeJh3ImoDIJiL45/yjrgCNhU2PQmGEoNYY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX1Flea9E8t7Uv
 st+AjpEBVqAEc7ASWcMRD3xJIdTDBh/t/3dTTw1P/1bC2YnMcIL8G/XXp8SIg9QV0AOX5uN7lxZ
 zqYQbVKZm3EnauBCcNNFeUhuKursZsE=
X-Proofpoint-ORIG-GUID: gixOwu1dDqkyYN4Tmer7QGHbR9VN7Oa9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX9ii4hDbcyFdI
 SRBgoKQR1Qlplz145wqQnUDp8ahJiSeU4deu0LVwLWqNeJZGIMxetP6YDorzm4nIJyReDx/3rxB
 kYwAUmpBVm7NRV5t15J1rFywcw4ywHOX7/YFv5D7y/mvem19OCN6Gl2dVHtnEbzm4u9zrZpX9BE
 sEUi3WycY6fMblAnClTbEfNYz8PUuj+rxaoFMigcjD7/mdKPOtktk31q6/Zc4NUXnlrfM+7MHEs
 QxuExELn5NH9iLJqwtnGPa0fnm4G9c+pbk5gPyuG9e8DVzXxU89f8iEIZvH+j+3nuogyXAUeyYK
 c4ND/nDlXAyAUI4OYYYuUQLZWPhU1xW7RQXp8wp1OflsUdnvbhPr40AE/aZebuy8hdu+mm/knmL
 y/Obhm5k0HOByWT26VcJsfWKW+8gxL2/ZgXynF2JhlmPLw5NRSQong3X7ogn1m6WLRCAfzchLpo
 SgwiD/rPwtMDm6MAn5Q==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad095d1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=DHE891H7Gske2VlohvUA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: gixOwu1dDqkyYN4Tmer7QGHbR9VN7Oa9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
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

The string detection sets the test brightness through
wled4_set_brightness(). On WLED5 that writes to unrelated registers and
the detection runs with whatever brightness has been programmed before.

Use the per-version callback and latch the new value on WLED5.

Fixes: 62a1d3f623ac ("backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L PMICs")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/video/backlight/qcom-wled.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index f2e0430cccbc..6fbac6a4c29b 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -577,6 +577,17 @@ static irqreturn_t wled_short_irq_handler(int irq, void *_wled)
 
 #define AUTO_DETECT_BRIGHTNESS		200
 
+static int wled_auto_detect_set_brightness(struct wled *wled, u16 brightness)
+{
+	int rc;
+
+	rc = wled->wled_set_brightness(wled, brightness);
+	if (rc < 0 || wled->version < 5)
+		return rc;
+
+	return wled5_mod_sync_toggle(wled);
+}
+
 static void wled_auto_string_detection(struct wled *wled)
 {
 	int rc = 0, i, j, delay_time_us;
@@ -603,7 +614,7 @@ static void wled_auto_string_detection(struct wled *wled)
 	}
 
 	/* Set low brightness across all sinks */
-	rc = wled4_set_brightness(wled, AUTO_DETECT_BRIGHTNESS);
+	rc = wled_auto_detect_set_brightness(wled, AUTO_DETECT_BRIGHTNESS);
 	if (rc < 0) {
 		dev_err(wled->dev, "Failed to set brightness for auto detection rc=%d\n",
 			rc);
@@ -743,7 +754,7 @@ static void wled_auto_string_detection(struct wled *wled)
 	}
 
 	/* Restore brightness */
-	rc = wled4_set_brightness(wled, wled->brightness);
+	rc = wled_auto_detect_set_brightness(wled, wled->brightness);
 	if (rc < 0) {
 		dev_err(wled->dev, "Failed to set brightness after auto detection rc=%d\n",
 			rc);

-- 
2.47.3

