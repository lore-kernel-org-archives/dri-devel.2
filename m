Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F3110D14AC
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F2710E7A9;
	Mon, 30 Mar 2026 13:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kzI+4W5z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UyHFxV7K";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F203F10E7A7
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:26:00 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UCaDes303197
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FkLmSLP69kjxpeOM6oO3fuI8XSWjhOpqQ75tZ0kttrg=; b=kzI+4W5zG0i4XgG0
 PxOd/0wh8ZPR0lx9MybkCc8bnUeqQgkx6lsaByE+N0jjR09D7rmUTZPnkQ0hEfYT
 l3rq05wbFPu3abnRrdLN4d72AY5aHOqpZ8wskPaTi54AEAzVlgIj2wvLiaLSmzd3
 j26M0wyT1sQhJfzYrttZVkrwyVyjW83xu6zX5EhPft4AATFql1zGsymcTAXuaVJI
 c3UGLdgV0c4hQTGbdU3e90d1di4+8ABRHQATX9rBbWXlVvxWi0HtlnfVCQA+CUui
 cyzU0IcPLkTy2B+rLaENwhx6wqcF3h6xHM5+SSWuCzfDo7ZIyPvBKtsAdATSMvEq
 AGO6Pw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6wqem903-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:26:00 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6054a2563adso209698137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774877159; x=1775481959;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FkLmSLP69kjxpeOM6oO3fuI8XSWjhOpqQ75tZ0kttrg=;
 b=UyHFxV7KChFUjDDymJD7ayscBdUUV8ypH0VUXe/lNd+/QRTWax5dt2Zk/F4PUSwEt6
 nEZh+xycO/G4H5N7G2sE252F57EFUBTKP03QrMcygbSXGoldRULTtW6LO1EZAJ+JEmy2
 1nISbIJwaOtRcvLDp6fyVbZhQgF/59iyOwDaG+07JoiHUoL74jG7x5Dnnvho1JmOiehd
 1fvzBeI+fwYDnH+vpA/8rO6WF+UvXD+KOCR+TUpaH24m5VAObzJlkq99CaRB6BKy/krB
 uO8qtlimsQeyUT/6ClMM4dQIfSMItXYeRoRTt7wZKRJnOfFOB566KCTJGSSqkhao41Gv
 eu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774877159; x=1775481959;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FkLmSLP69kjxpeOM6oO3fuI8XSWjhOpqQ75tZ0kttrg=;
 b=GTVgio/5ERsMuQfPwze42WVMMJt8S94wL3A8ECJbIF9dQi47DO3dIrNZne+olPnLre
 JyLkyOc3Ezgssrh8AZZbpIySJy1nLygHrQvvTs/Aia+AJDPD7bVigLrEtKX5JjrsAi45
 8QqNuioES9l1/xBVhB15mCTR1Vu3o9QcFefeU2jhK6pi4tz0EeuqyjlxwqwA+0vvK7/v
 BGnQtGduOVNMGvN0wYIicekjveqp9douOcmBYkHvghFPJjGLB6ZAohC1wT0RcRGUDP3x
 Od8VnJCIPEofiEIBV955BAja42y0SOIBUf4OH5Oig8QUYHDVVxsVjuo95dX2Jv3V6wVk
 LCUQ==
X-Gm-Message-State: AOJu0YyWRUvIXzKX71DHpuAt66K4tETFNVtLNm9SQ/6LHKmnhkvkguFg
 yRMYrfWBZOD2kbkz0LcCACZPaPHdtpfC9kzcXVRyByGb4vtSFZScBz94mJlEW/kAvUeQKF28z9g
 ARKtG22RdlKdvmrHN0PgUR5kaQKxnCie3ETxoO2/qjIXpW0XxVtQ+H3fSs6ioYdTPvlflaliBxl
 8+EVg=
X-Gm-Gg: ATEYQzyBLaAKW+F0tynztK6Qe6gqOhZ3Q1Fi6S5YQKAN0W6Q3auhSdlvhY7F0UwdJHD
 FPBH47xfkWbO+eaKr6ni1aUGgljpajRuB61yJJGg5/TJpkeLGr/fXEr3kjPfyjKyH1jOcZe0Ku1
 0TETH4kZUQBqJr8WjEmufFXjYk8AaXB0K8Ig0q618nTA5Of3Bv04DHJhWS+V5MsDdGGxmeqk99K
 NMBMp+twclxPecZbMxrlU40ZIAGY5W0P1ailOE87LHZ7cCm81P2pb2TMT/3xsTv18IfsRyWUtpk
 SQ3wOtnN0OxZKCdtcRBbTr0eNLBWSTegYiKg49oajLOk/rATsTb1fZbnSjgK3I6nu5mhwFptDOM
 LyWzRIpWqSoGvHFTRH5QiknweAavndmm3t2vThAmoXhDgZPBkQhhf8QtAVJQy6Aq+gO6ijkTan+
 tT3WGcRn2Eh4BDJO+9dw8lOgrWdF/q/USfc4s=
X-Received: by 2002:a05:6102:3e13:b0:605:218d:ae0f with SMTP id
 ada2fe7eead31-605218dbbd0mr2312301137.18.1774877159183; 
 Mon, 30 Mar 2026 06:25:59 -0700 (PDT)
X-Received: by 2002:a05:6102:3e13:b0:605:218d:ae0f with SMTP id
 ada2fe7eead31-605218dbbd0mr2312278137.18.1774877158734; 
 Mon, 30 Mar 2026 06:25:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13fd035sm1698928e87.18.2026.03.30.06.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 06:25:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 16:25:51 +0300
Subject: [PATCH 2/4] drm/bridge: waveshare-dsi: support DSI LCD kits with
 LVDS panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-ws-lcd-v1-2-309834a435c0@oss.qualcomm.com>
References: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
In-Reply-To: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=meceOlV150x0P9d/dYupXFReU+UI7nyTwt8EPwSQZRU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpynnhq9AsFpxr9DIE5JwZcFpH/66RQUMPsVrqo
 6/tGrsw6o+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacp54QAKCRCLPIo+Aiko
 1ZS+B/0fVMmfd14zWGRlG0KQxSXBE8RKxXQgN2rSh6rowdrSMYK6MDMxB8habiOcY34NVYxrh9Z
 LOshYatSLBX7BlFJITdGjBGdw40K8qmJA7Tu9pCqcuweS/FXtrdjlRUJe0mgVviENvpxjkg+AFk
 2xqZwgDmEhnNllqQ05zdtbYEuqUQ+NKFajXkYXnmIarqjgXfLsLY5yHW+DwhC7vGP52YYXIvH+0
 WP4lSLFhJG/NmZr7Jw9OjSDxLyNIW50nfWTXSL+dVUPQxOGt7PGo/jrMBi8pxsnh/loCBXvd5jB
 u4SPHSuvYIDuFt3apNIPj69btx+C0PWR7Tuu1Q7o4PImNCIJ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Jo78bc4C c=1 sm=1 tr=0 ts=69ca79e8 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=2ETHJKsuVJx8nypl5XUA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: p5deCiGG3IjHDAMVL_OGxGFAhqgfNWD7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwNSBTYWx0ZWRfX8LH/HpVoFGEZ
 XNElTYwFJjAhheKNaWqRnyU2NcQrtKah6HBZFW4s1NrvVKyO9XKe2Iexlr6+Vad2cV7MhUxmiNF
 5woNNRfcVjhkET8/UY6g5ELEvTUREymruM22GNN0DogNjmjfypsBXMxibKtz3NTmzK+b1vpzp5X
 jc622JDuThc/h4gfwV5M/zOAnGoprmgC9dMD/vVLjaoOyYAksSCSbM6SDqIbpczf6TI2lp9ljxX
 aWsy5PzrCUUiDHR5/8UBNin0iq5oz/poi4JaFf+MtDWzFuR+3TKoGeZDUuziXcfhJY8/Ak2H5r7
 MJGTe8yX5IDK7+M8Sci0mm0NmCHAVJz/Vqr1CBaLhZYTVq7hQT3RQkL7lo1aB+lScyjG2PWsfGK
 /rsuyGM4qNj6ssixLWFGI/Lz24q79GUEcrzDGnXDgol5H73kbj9ta0NV/cRJIgpxM5yvNJKUaEq
 G3/HLy0eVgBAbRaHO7g==
X-Proofpoint-ORIG-GUID: p5deCiGG3IjHDAMVL_OGxGFAhqgfNWD7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300105
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

Several Waveshare DSI LCD kits use LVDS panels and the ICN6202 DSI2LVDS
bridge. Support that setup by handling waveshare,dsi2lvds compatible.
The only difference with the existing waveshare,dsi2dpi is the bridge's
output type (LVDS vs DPI).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/waveshare-dsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/waveshare-dsi.c b/drivers/gpu/drm/bridge/waveshare-dsi.c
index 32d40414adb9..ded57f298d64 100644
--- a/drivers/gpu/drm/bridge/waveshare-dsi.c
+++ b/drivers/gpu/drm/bridge/waveshare-dsi.c
@@ -177,7 +177,7 @@ static int ws_bridge_probe(struct i2c_client *i2c)
 	regmap_write(ws->reg_map, 0xc2, 0x01);
 	regmap_write(ws->reg_map, 0xac, 0x01);
 
-	ws->bridge.type = DRM_MODE_CONNECTOR_DPI;
+	ws->bridge.type = (uintptr_t)i2c_get_match_data(i2c);
 	ws->bridge.of_node = dev->of_node;
 	devm_drm_bridge_add(dev, &ws->bridge);
 
@@ -185,7 +185,8 @@ static int ws_bridge_probe(struct i2c_client *i2c)
 }
 
 static const struct of_device_id ws_bridge_of_ids[] = {
-	{.compatible = "waveshare,dsi2dpi",},
+	{.compatible = "waveshare,dsi2dpi", .data = (void *)DRM_MODE_CONNECTOR_DPI, },
+	{.compatible = "waveshare,dsi2lvds", .data = (void *)DRM_MODE_CONNECTOR_LVDS, },
 	{ }
 };
 

-- 
2.47.3

