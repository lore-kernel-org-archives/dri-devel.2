Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B53CCF2D3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38F210EAE4;
	Mon, 19 Oct 2026 11:26:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D7510E98E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:25:53 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OuHm1168055
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6xC4OVordP6iIQiBzMB05d4qBQ+iHW7wsc04Plsjz2A=; b=UIFem/zoWNDHQCPl
 3DA7+TickshegyHDg59S4MZEFkAYyvMUDurzAA42UiqpF3CVDAcFIE2xvTZViT9M
 zjOSA0QE6Cfi/QqZmnkZKU7rn4dtlWxqBFw+lQzFTNxQViCoiaMVGkpmrzqCMPVy
 lScB0WeQLD+wGCNTIo5dx8X3RwleXaDu2NzM9W+uZX4+FAn6QZuNQIyvax2/AZTM
 2N9x9AVPj5IJO2Foclidry4TBDmRBNTNhd2FDQ9JZXvBb9FGH4Q7u/O62nTDEn8x
 q2V6yEKVRyO8jm48HDr+5wfL4IXnC2U2cBvPwfTRxmSyUfxKLYT0peLXpPO7a3uu
 rDgLkA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5c8tfp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:25:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f322ef7d3so322880685a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792409152; x=1793013952;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6xC4OVordP6iIQiBzMB05d4qBQ+iHW7wsc04Plsjz2A=;
 b=dpw0D1kFDghtsLaY1jaZWRcrUIOvd+npLeHWPUAd+YXK8RJpXefL2nOwi3Domjo65O
 P2nn24ST0FlK9IqYluzdXyPQRna133bcsmiB1L7/KV2clJGhD1YDf1oUf1o6+fw8Z4vJ
 O7Plz5l2X0vkcxHtGANkktMuOo5EVGDErXPEaXgj53ohkgEQ74kyxUDPRmh8/RvthbLq
 T6rVZVjraj6ld1EFMbilk1kdRtrD1vX9SavV/wyr0azkwMfeF4DhAJw1ccks/zzxoHkG
 8zuAkBgQCo9DUHdfdSGnIAgJNSX7jPdY4nBVQQKxr0Zdley1fkDmwb9X+9ZcS8YI5/61
 S0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792409152; x=1793013952;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6xC4OVordP6iIQiBzMB05d4qBQ+iHW7wsc04Plsjz2A=;
 b=n9c+JjJo9kTpRUo5QS/29fgW6fs7mNj/eaO0ldNzxL9hJICq7iUUKpM73/Dd9Bnau0
 SNVp7NagEnrJX8mhoUZNGgaMlDmuDNo8hHOgY2+Sy112vZVJDDVQMikQvKcIwMs93rIw
 hLf/x1rHN5Bs0uYaQR2oSTrfsJiom3htJ1/D1D1FTy6Ua324zmc0g6gb1Ct5sCtRggKr
 Qyg8iRd7NrOtJ7ZcVCi5Hw7gPKW1fAR3LJT4dcSRGFSxYNCK/aG9qbAVXbgVG2XQ1xnK
 9862Gap/UvaLWgJpdCxSqj0t2HN9jFqDGWoTmyJuRkjnFeeJ5M2gy+1CkRf7Pll960wO
 Wxgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzENiZpzBUBDAlvegVOyuIBkhFoyag7xeUeLxceXTGdCSh6GR9dn5kko6wbNZgepIkLtJv1r0NcUI0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJE1wGKvOZICXbgetPAdLQR8/QmClXI/dKx3S2Ok2rI+2cJihA1
 tx0fVa1zYAMpL1Wa7pdpuNLk1DFEAOl9/Cvsq+f3jGaYgon9uSSfQVHkE3mSNDva8S3ns30NhBw
 ilAF5sxczgyfOiV8vRMWC+rS8W13sGGvGljMnGCLTSvQ49H5Oi4hkPlHeNILl+Rz8PH2wm8M=
X-Gm-Gg: AYBFou0A3HA//+4g3SxhQC1FI1nUztC1sXAMmAobbJXUVI0uLPiKkQa/29ogdVsgXjI
 VWcw+/zc36N68QmSUKbqCqtI7fF3zxQQWsK7TzNUPbyv7/qVr4FErAButoC+bGPJYBebCR8chFY
 r2/5h/93kY+NZHpSEBeh6vA4pkYML4Clw5p9f8ZEVeEG2nDTBVjOsnXPlLcsv42KF7fv5bgEXID
 2pfAidEVWHHynNk6dNFMLnGOAIVZP/2McvOYTNUhxrlM+uE31q/aqn0M21b1BnIdnkDlsAuVj+A
 xjRACWRecqg1hrzEjXH3wvX6xImzBBHyAFFNfjlw1mlO3WRgZu4tu59di+jhwjw+mkOyTw8zieV
 ZG3l8Iu3IAJSYxRQ5+1MiT0cUpqfiQsJPfTZlATyEOPvRJVzgtaPyEOyItt97G6z3ZbqkstYGjs
 6mZWeq7Vh2CL9J
X-Received: by 2002:a05:620a:4589:b0:939:1222:b9f1 with SMTP id
 af79cd13be357-93f29a04e12mr1226298185a.0.1792409151700; 
 Mon, 19 Oct 2026 04:25:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4589:b0:939:1222:b9f1 with SMTP id
 af79cd13be357-93f29a04e12mr1226295185a.0.1792409151143; 
 Mon, 19 Oct 2026 04:25:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:25:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:37 +0300
Subject: [PATCH v2 1/8] backlight: qcom-wled: fix string detection
 brightness on WLED5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-1-86c05068efc5@oss.qualcomm.com>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
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
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4040;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3nXXqhpzf8K/+hXUe7l+H8MG2OcKbb9smch8ETujRsw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f44JBbEvJI7ao/F7pVDoA9QA3FdEnuTWMXG1
 9mEYCtrJkSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OAAKCRCLPIo+Aiko
 1eB6B/9XXxaG1spzShZks/wIC8Z0XwqpE6aoNNn8zhK4sg7GP5JCjXeYh/h1U+9QR/GK6j7xTto
 QFOmZ/kLOfZXMqlVlposw0b8AuIu6Z1WOyWcfLDbnl2vxLekiVTxa3V9TRPKm7IbUGzY7j4ansr
 Ru2MOcMUt+lPMfvMHUCOOusAb8sbx7zFrec5PgQf3+TWLmM9jMj/TWFLKhLt6ZMwDcc9jfC2VF+
 VdJ31VYpQxu0SDoP1qGKN26HhsTuujZYrCgkHwkj3oV7N9+g9BzgNuQzkBdMXoQ1Hkpy/PZp9zc
 EjQKQZk2dTjqHc319u+F5r2KaBsXFiNcuAv5fPvLH5GkHDas
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX0pXKElP+WWpY
 vjmsoy3wPvc4tIKKk0BX9ukVIJBdDvR3pcrDXqRlWHKij/8kt1EXplmeD6Fgvq1j1R/IJgZz1fs
 TSRFHhrACgIrrp8DTmeV2ty/ULy+0J8=
X-Proofpoint-ORIG-GUID: cm37SdoyDck5nr1X8m12geQbCO05SR88
X-Proofpoint-GUID: cm37SdoyDck5nr1X8m12geQbCO05SR88
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX/Zq71TFJIyfb
 RKUrOXsCV2V/ySFVNKyRde8dMT7sGhWDBoukfKKtW/fGbp9b9zc3W274fPGGuJKAZMHqeuh9TM/
 cIaQloTQJtIE3ND+P3kCzQmwmzN9sWl5ikbScNz9me16XBmlhIWYxKkla41lyQeFeIDB8Ic+3eo
 pDMIn3Q4E17BKd+kCrqvm6Z4B3Q/wcK1BJJyjBh74GgQaxmXJ71N9Ne47qIXFLdy7z7wq0UcdJL
 Vf64wfOXxgZbv4GiCxjhCiKrFAFDTGmpo3YYw43LCCAjKhLkNKDLtaxe0crVWYSpMs28vvTiico
 OtbFiPmQGJxyyKTp/PDfKC3jENBIsOigWy4c15AlxPDVg6Va0CnbcQs3nn0EwEx4Gp17zwkjVFC
 DedVKKxQ3BHAJQmX0tSIWgMawaD3P02HIOrUu7yBZryqiKREiFGZCIG4+DCjw8+0iYnNnwknhL0
 sFq7owOEOJc1vZOVbAQ==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad5fe40 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=GhjHCLKht-b4gqHrCnQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190045
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

Use the per-version callback. A WLED5 brightness write also only takes
effect once the module sync bit is toggled, which so far was done by
wled_update_status() alone. Toggle it in wled5_set_brightness() instead,
so that every caller of the callback gets the new value.

Fixes: 62a1d3f623ac ("backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L PMICs")
Assisted-by: LLM
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/video/backlight/qcom-wled.c | 56 ++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index ca350f320e17..c5243a6d547e 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -269,6 +269,24 @@ static int wled4_set_brightness(struct wled *wled, u16 brightness)
 	return 0;
 }
 
+static int wled5_mod_sync_toggle(struct wled *wled)
+{
+	int rc;
+	u8 val;
+
+	rc = regmap_update_bits(wled->regmap,
+				wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
+				WLED5_SINK_REG_SYNC_MASK, 0);
+	if (rc < 0)
+		return rc;
+
+	val = (wled->cfg.mod_sel == MOD_A) ? WLED5_SINK_REG_SYNC_MOD_A_BIT :
+					     WLED5_SINK_REG_SYNC_MOD_B_BIT;
+	return regmap_update_bits(wled->regmap,
+				  wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
+				  WLED5_SINK_REG_SYNC_MASK, val);
+}
+
 static int wled5_set_brightness(struct wled *wled, u16 brightness)
 {
 	int rc, offset;
@@ -287,7 +305,10 @@ static int wled5_set_brightness(struct wled *wled, u16 brightness)
 
 	rc = regmap_bulk_write(wled->regmap, wled->sink_addr + offset,
 			       &v, sizeof(v));
-	return rc;
+	if (rc < 0)
+		return rc;
+
+	return wled5_mod_sync_toggle(wled);
 }
 
 static int wled_read_brightness(struct wled *wled)
@@ -391,24 +412,6 @@ static int wled3_sync_toggle(struct wled *wled)
 	return rc;
 }
 
-static int wled5_mod_sync_toggle(struct wled *wled)
-{
-	int rc;
-	u8 val;
-
-	rc = regmap_update_bits(wled->regmap,
-				wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
-				WLED5_SINK_REG_SYNC_MASK, 0);
-	if (rc < 0)
-		return rc;
-
-	val = (wled->cfg.mod_sel == MOD_A) ? WLED5_SINK_REG_SYNC_MOD_A_BIT :
-					     WLED5_SINK_REG_SYNC_MOD_B_BIT;
-	return regmap_update_bits(wled->regmap,
-				  wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
-				  WLED5_SINK_REG_SYNC_MASK, val);
-}
-
 static int wled_ovp_fault_status(struct wled *wled, bool *fault_set)
 {
 	int rc;
@@ -494,17 +497,6 @@ static int wled_update_status(struct backlight_device *bl)
 				dev_err(wled->dev, "wled sync failed rc:%d\n", rc);
 				goto unlock_mutex;
 			}
-		} else {
-			/*
-			 * For WLED5 toggling the MOD_SYNC_BIT updates the
-			 * brightness
-			 */
-			rc = wled5_mod_sync_toggle(wled);
-			if (rc < 0) {
-				dev_err(wled->dev, "wled mod sync failed rc:%d\n",
-					rc);
-				goto unlock_mutex;
-			}
 		}
 	}
 
@@ -651,7 +643,7 @@ static void wled_auto_string_detection(struct wled *wled)
 	}
 
 	/* Set low brightness across all sinks */
-	rc = wled4_set_brightness(wled, AUTO_DETECT_BRIGHTNESS);
+	rc = wled->wled_set_brightness(wled, AUTO_DETECT_BRIGHTNESS);
 	if (rc < 0) {
 		dev_err(wled->dev, "Failed to set brightness for auto detection rc=%d\n",
 			rc);
@@ -791,7 +783,7 @@ static void wled_auto_string_detection(struct wled *wled)
 	}
 
 	/* Restore brightness */
-	rc = wled4_set_brightness(wled, wled->brightness);
+	rc = wled->wled_set_brightness(wled, wled->brightness);
 	if (rc < 0) {
 		dev_err(wled->dev, "Failed to set brightness after auto detection rc=%d\n",
 			rc);

-- 
2.47.3

