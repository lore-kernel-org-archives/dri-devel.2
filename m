Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68940CD8CA7
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0B110E697;
	Sun,  7 Jun 2026 21:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EiVvTbWM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h/3Bda01";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FE710E4CB
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:33:40 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657EjnPx440155
 for <dri-devel@lists.freedesktop.org>; Sun, 7 Jun 2026 21:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3FB7VsGWBD03rpwArJX/noldaF7TiU950Nm2TSbfvyU=; b=EiVvTbWMNddLSWaX
 m3G9rugq0EFbtLfwWqsRQ3hFgDPCVYJysVU7USetWURk2Wuq306mU05XNloSioDW
 jcsrziM9VNVsqT8zM4nuiL99YeswMiGt/cBhD/5Ose//4pxfRa7cPiBA+2a1SyDN
 +q3U49r1JRYSaK875YDBzAylCpDWi+xrsj1jXbNdJS1i8JWKIUaNzNki86Ky4ahB
 BWtjMrua70BmHtF4shrL32VKmvGOviGHCrb+UuPkdZvshfA5ml2l0oCTfwBwuzgl
 Q+GZbCfbRiPXyolSgympyGUcISNKDocU+ul3Bdmzao2loCOm/mFaVhfiWhgxhjCF
 34NSUQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98cwaky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:33:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517878a92c5so85637851cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780868018; x=1781472818;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3FB7VsGWBD03rpwArJX/noldaF7TiU950Nm2TSbfvyU=;
 b=h/3Bda013EXMkZo64dqttzRUeiPaO3ikZj6N0yRXsxkv8xWE4ux+KsGEIV6w12fejC
 Sl6rd/h8nEkOUxr+/l0XPJR1PzRhmAzXYJATAAWPyOcp2kwG03jvEIZ0dU8lOf9K/iUp
 zSkAMz/05T4v2cRlLq/5gVQFJpwFxfQ0e4Xx4EAlWmW7JiGIAILI8Wpr4DnUl71hXILr
 9Fh9gRhVXVD/qOZHXDyNmanReLYKRhv+N+kuz1BNxtRWzvTSDer1vq/ZTew1WaMzls2u
 xSZoJP3K9goVgiBF56lYZqIB6axE4/RSZfS7ozLyGucT7ZrH0QXw+dK3ZdDPnxl2NB+f
 RccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780868018; x=1781472818;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3FB7VsGWBD03rpwArJX/noldaF7TiU950Nm2TSbfvyU=;
 b=GtHvYFeNIZIBFRBtwN1ydijuW1ANcI38Wt6bzidi6iUjVLXGxIpEot5B6iUgqPkXmz
 HUmHxzXlZr88C5dlqmiLhY2S/xb1+iVgNS4dOrd7ZLxwKj1y/HcdBI0YZ2S7WoIL/CjS
 7XPushO5WPr484T21HCY+FXkgzZn0KayWegE7Yf0MnxGBwkYOKcFzfQ4FDlLOG34HtVr
 4X1NGyZ+uBXflOJ6kITM5NhL0fksrwEgT7S+yP1xwpQ0uOgOocYWKFPlB8dm4t4F56KZ
 Y48ROAZ4sSXTXe4a7+84RopNIjr/fJabL9qDflDTvZXxRGsz2zWDaKIOddOXdO5/vnpa
 H2pQ==
X-Gm-Message-State: AOJu0YxAIaRunXbuO8vDZRVEaCTZ5ebooUSG8TY0nYGH55TXSUUGIbGm
 8BnmB+htCpGF/44fUDBWuDFbU4pO4VHBFF6zHwtCr8pSY+BmLF+KY78OL4X3vBhsEnXbrj2MBwK
 1APu0jlZFLSKez+oH7CsZSCW2QnKuMcSxrYtVaK1uBjhNhIf2h9c55BfDvTG8SqTD4l3Jvc4=
X-Gm-Gg: Acq92OEmE1K6JzwA5i3Ad2cvRAFWiqgV0d2MzwnugKhhHKx122M1Bzj0bar7Vsvz10X
 hPqsCVMMLk0c+nY64YOrpw0ZLzrawj4Q8Hb8O0MUlHtKMoIHCTFGjsjUYoQ6QFxlqYhBtKVOydH
 n0LEZbD4mjP3rZEY4WblWyBcLxtj6yhpR49hTklpe/Fa85KKma+hD4ZvFSWUda8wzgassqwCZEC
 2b67seNVOypjt6+M9hzJJKBN+kTcgLsvD8Oyr3XsnPne07mRWF1A7pqfNXOxfm16myc61lXgVAs
 gD+ILVpNN+AcLffmhaD39+e5aaqlwT1eaI9+Qrdq+VsxTJ0RgPQqsNY82UoFmVeml4FL1eJQhQS
 FofJlS0NN/VDDDz7k2etnm2HCRNpOPahiEknaxkMsKho/rqBv71gcd9qlmCE8YFRuio8/gmGD/p
 0tl7ElG2zBUb58Ma1WAEuTaaIhRtjkDOOOhJh+b0aNfGUzVQ==
X-Received: by 2002:a05:622a:7d92:b0:517:b68a:8d8f with SMTP id
 d75a77b69052e-517b699d7d4mr24581091cf.19.1780868018454; 
 Sun, 07 Jun 2026 14:33:38 -0700 (PDT)
X-Received: by 2002:a05:622a:7d92:b0:517:b68a:8d8f with SMTP id
 d75a77b69052e-517b699d7d4mr24580671cf.19.1780868017994; 
 Sun, 07 Jun 2026 14:33:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2d5ea9sm40374041fa.32.2026.06.07.14.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 14:33:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 00:33:09 +0300
Subject: [PATCH v4 8/8] usb: typec: ucsi: huawei-gaokun: pass down HPD_IRQ
 events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-hpd-irq-events-v4-8-30b62b335487@oss.qualcomm.com>
References: <20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com>
In-Reply-To: <20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Francesco Dolcini <francesco@dolcini.it>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3SjZ31inNFNocQI2RmpCu4Tw/qg0rtSCt0SZ5oE3dI8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJeOQ0bhQoOsJj857BdAUiqH5pox278y0oAyGy
 RFMbu1dyjqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiXjkAAKCRCLPIo+Aiko
 1adXB/9gLuR7QGRjAk+HXqf2b8R0PyE0WvdRPYlehmbvDdwTKUxzBuDzzuiV0kTay/bmwkqLoYP
 eSEgECp1mqSpjvxIbCTbpUNLT81GFFEDtjKOgp0EizyaOAmRWZF431B/LHJEqBNRywGDAMR6g28
 XBko5Ih990ex9CIhpqFhfLNy8a/OK0J8+WGQPmWoxwIt9PsO976mFy3iFyD5v4yPJ19GDBS9g1L
 mBGAh4TQw1r6fDBZ0z7VjlgWvcKT0EJs+3W6Mwh/6R/5YhL3raA9bpt8HLs1yUxKd/64FRiW39e
 4xRBwvcrgMfsxCVs47NwyImiptqBmFZy7rW5+/2YVxJAwuCc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxNyBTYWx0ZWRfX9U3kpqMwqpO4
 1WZWvIWDAC+QiVwvKc2YhvObwrZc/lWCoIPMLKJobzYq3JIxpFUyQhqoX9OacNXRclkIB6hRq+A
 0kxFkFUdCxgHltEvOKNBWHYglSbQ8pwk4YUEeM2VrOg/iVf3kSOJhmpcc7M7x+6uXy5oaX1edGd
 6cLExEpbc4q+WqtzwPcgNC7PX+XpevYyEy4lTPs1L73bYzqtcLXpfHiPXeuW5aE4P5oXZhZr9m5
 jNeLkzZIdx5x4LVAZN14NbC7PPZYuOqevHk68bVbu8RkHEzaFvbXc+l0mdKWN/XsJQz4PfpowOD
 2aESKilJZmzwolvrfVnYRVCqWaG+6kwwuRjUO0FMDyu4Pul+sYmuDEmQAQfwXm2sXKAtINmy+Gq
 1Na20+7cyIw4+5ttwLVVBlGyGCyJcSJEGDQBnRmDFWcXC5U+e1cnk4ojTTqOdslR6vxt1kDKMrm
 aXtTt6OrwkcNvMml+xQ==
X-Proofpoint-ORIG-GUID: lbc8R4N2klSZVHWEgbveCrm62rRtaknl
X-Proofpoint-GUID: lbc8R4N2klSZVHWEgbveCrm62rRtaknl
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a25e3b3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=HJ0TMOZLSqZlwYNULgAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070217
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

The DisplayPort standard defines a special kind of HPD events called
IRQ_HPD. These events are used to notify DP Source about the events on
the Sink side.

Pass IRQ_HPD events from the EC to the HPD bridge, letting those
to be delivered to the DisplayPort driver.

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

