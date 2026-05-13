Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE70CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DDB10F00D;
	Wed, 13 May 2026 18:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xs5+o8is";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A3IDU65Z";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B895610F011
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:24:05 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DC9OJm3324677
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 li1QTXDLKUg9Sb2Wzb5S3vgbZrLxrrKq59N8rWxZa0g=; b=Xs5+o8is26i9TDoz
 y3y7X36LjlcrVNTHGo46xIwoGiWfsMdLrS54s/66GDd4akyYZMGQR05NxojrB/R+
 x/9om5EnZ9cPMwmqjxdXO1GVzf+uLhKU5CcYtgZP3w1wETTy2UpkHnSCy0lTgFNF
 ha1pCTN8J/of06OBBF50O1zZWQNiYO0LjxltuBQ4cad3lD3n9Lbl5sffy0vcEfCL
 IoOHFVq8f5zOfv2bTths8NCpQ2GK04suj0VD8Xy6mhDvF5bNx4+W9zSZqTgl2C2M
 hBBxbdFwO6cc+uphD7iBz/MXTLPdYOgJZa1BHoEcpYdI1axmH16oOGw+BayBf7hp
 B5Hjqw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4kvdavd2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:24:04 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-63302aca17aso2256581137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778696644; x=1779301444;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=li1QTXDLKUg9Sb2Wzb5S3vgbZrLxrrKq59N8rWxZa0g=;
 b=A3IDU65ZkFjhTpDBTRsZrKppNHoMJpN6R5JdELUFIMk0BZS/GOLbU9ycu+uXlPntaJ
 hop2DtnobTBsmia8FhmxKzX9uMJUvcZzUc781f5moKlnlWWlIQMma0KSNwAwPyG49RZd
 ih4mPkou+TYCGGiOk7mAm81kdhVAfMAf8FBAOPpgMnOOgl5dG3Pu872kEMfwjx1A08IZ
 GSEnNs4g5MXT2/htHn7GXvq8oClx1sA2Y/jgt6K+r7S8RRTeTzpt+SM1MuTS+F7qNaC9
 nRkr16wOXSc9ZKX+W2J5n7qjvY5sU8QGQJwEhrZXM4XCEkShym+jxDdqrcGcQM15vGF2
 reUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696644; x=1779301444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=li1QTXDLKUg9Sb2Wzb5S3vgbZrLxrrKq59N8rWxZa0g=;
 b=ZC/q9MhGOidDIkaOB2y28F/ZKDG4tpOjauZ0R+w4P8mHLTTDwycufL2HbHf5dbFaC1
 YvguHFFqO70E+cyo+tKx6nL4K3x+iXn/b5cLm7giPO3AAcRyeommrs4ri6q2fRS+rr9q
 LkHMhgZXg3hx7u4/OdfJFgPz7z5s7JDbGczOOFeHP/LnKh2rnAwR25mZ/PalQ0La4Sec
 9zkGbdPVTQUfXplIDlgs09LHL4fxACNiD4yyFs/BhLlnvc0IYJyJlk5uPJoDk2E0HY+E
 eqiOJjKtE/LH8GBW7eLr8F+yI04AqMPgzC6K27x+j1qKyOADhCADfxYqL/63J6bNYIqi
 EFQA==
X-Gm-Message-State: AOJu0Yx/bhYCDzjgSnLdH9Vw6a4J236GYmGleLjbvTH6k15Hw4b5VJ3x
 TZObG2UKJz/v/BZT0ZHI6Z33flwR29Cdop3zhVeridqiZM2EUta9KEA8RJLt0bZhXVldCtcfXlg
 n+p+GyVS+NHyBauRxELErGaLGbw4LfL1t2yoaAmQK5EqEVbP6Z35ByrBa1DycA9yvzSM2qXM=
X-Gm-Gg: Acq92OEbhNiB4bZbn2FNLGBuvoQjmLjbcEh2bCJpLctwhJirGlnRWsb78Q915oh5Y8L
 8v2M6648+69MmGnpIqu7bu9JlCCidClBoqPEF8iVNuknbnSfGob8UwBhcoEm5/lL5W9+a6bhHvE
 BeO82853Inc3yCgtnxxWzhiq0tWYLBU5J1rNs2WJ1tfeeOAl5VbtDKs8zZL1Tg7WFeFkXitnSA5
 D8lbT5Sw181N13gKwlMCvuVdh4aus6m/Du0b4Y0SLlyD5eAxdEhGk9LICa4/upME2C1s4ui00FE
 fBukBM7R2SQBpwTULEOSqOFnR8tz8BsTXiULEBblRpar1QGLufC4ojC2ol2cqHaxGcEMSBuGorY
 ZCxrXHPnwRPkQe1hbgDu0VL47p3Oy6xLhAJKG++UTwgp/DJNoqriPgHS52Tp8DpyQxKPPuQGNyp
 bTih1mBojjFXFNxZa0F6YZkRr3KX3R1aU9KlquC/SGtPw6sA==
X-Received: by 2002:a05:6102:4a95:b0:631:2a80:e492 with SMTP id
 ada2fe7eead31-63774777cf0mr2754218137.30.1778696644195; 
 Wed, 13 May 2026 11:24:04 -0700 (PDT)
X-Received: by 2002:a05:6102:4a95:b0:631:2a80:e492 with SMTP id
 ada2fe7eead31-63774777cf0mr2754191137.30.1778696643647; 
 Wed, 13 May 2026 11:24:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a951d1f6sm4212851e87.23.2026.05.13.11.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:24:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 13 May 2026 21:23:26 +0300
Subject: [PATCH RESEND v3 6/6] usb: typec: ucsi: huawei-gaokun: pass down
 HPD_IRQ events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-hpd-irq-events-v3-6-086857017f16@oss.qualcomm.com>
References: <20260513-hpd-irq-events-v3-0-086857017f16@oss.qualcomm.com>
In-Reply-To: <20260513-hpd-irq-events-v3-0-086857017f16@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mxGolAt7ROQ681cKNciUMVefMdiRDsSwC5zox5THv9w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqBMG0hilhJ2gGkZQQxe/0GBPH0fFPTqqZlimMt
 5EPtgQGMWaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagTBtAAKCRCLPIo+Aiko
 1UfqB/sEB1F2WFxCMTR2F1PIB/yP08QefwUon51gJHLQXhYRVsVZgMzGsE56RR40iDFtt0PCNNR
 e8/bhQUFNOGrzI8yy7h2fUumtwY6WquWhqqhJdrMaos/EEi0wqo92efWacjzI8ohK4UFbJt5bjN
 ffYm9hQw7mZu7rzFKn0nk5m4neMOewWtG2qMy4tDxV+FcYWNWYNdbOIiroBSVTXPvibDr1zfc6B
 lWhGMFxqUSjlgv/QMEhFapwgacJOv8N956Zein+/YYHUDvNrrMCD25WxF9YwwoRqVq6nRJacaJq
 0UUW8vbtRRRMty0+1dZCHZVxEpa+Qw3X4pIkBQ/WmrrFhFvO
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: OjTXlUUyvFvKairhuZCLYmK68itzqJbk
X-Proofpoint-ORIG-GUID: OjTXlUUyvFvKairhuZCLYmK68itzqJbk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4MyBTYWx0ZWRfXx1qLEq6EtAmt
 Ylqat38qfugH4N9BWpeOTcAqBpli7HZIKt40B3b9qM3kJ8EqF0Jf/vExz/SJr/L8Z6W91I8TaXw
 U96iQ9uz0Ls55R1YI9sg1vAF3/WXyG84avMgDpbw8HQH9FISTlsFgOVddEJ18VjhrPTKweVDbCi
 N/co2zKwIdoZNpystpwxHumFDnnEtSWCUMnnps4c+yIq96ql7MOsYZq2kdhO1eX3jJG2lJ2zTwM
 oFYf00BaW1DCbQcxJUnp/8bF+fkJ8CWXIRZ6TqqHNH/tpcv+T0OK5SyieTghItz++KrDBrKAMOh
 SruGEnEefugRhgCrTvs7/8hvvuicZYprRxt1cUGBCj4OjmRAjyaShZjvDkrNsPB4sUrqfr7KRv5
 EXCcj3pQhCAp04WvaoDRcyMKZruxcpdhUTep/yhTo76oXCJk0sc3vOXwIQW1SX8EeA5Icr3gJjf
 auxR1PjZfja6U8Af2/g==
X-Authority-Analysis: v=2.4 cv=Iu0utr/g c=1 sm=1 tr=0 ts=6a04c1c4 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=xNxaoOyMFJLcTYWjjPMA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130183
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

Pass IRQ_HPD events to the HPD bridge, letting those to be delivered to
the DisplayPort driver.

Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
index ca749fde49bd..5e3f887ecbd8 100644
--- a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
+++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
@@ -299,10 +299,13 @@ static void gaokun_ucsi_handle_altmode(struct gaokun_ucsi_port *port)
 
 	/* UCSI callback .connector_status() have set orientation */
 	if (port->bridge)
-		drm_aux_hpd_bridge_notify(&port->bridge->dev,
-					  port->hpd_state ?
-					  connector_status_connected :
-					  connector_status_disconnected);
+		drm_aux_hpd_bridge_notify_extra(&port->bridge->dev,
+						port->hpd_state ?
+						connector_status_connected :
+						connector_status_disconnected,
+						port->hpd_irq ?
+						DRM_CONNECTOR_DP_IRQ_HPD :
+						DRM_CONNECTOR_NO_EXTRA_STATUS);
 
 	gaokun_ec_ucsi_pan_ack(uec->ec, port->idx);
 }

-- 
2.47.3

