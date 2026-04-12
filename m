Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F9BE937EF
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 17:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786EE10E2CF;
	Sun, 12 Apr 2026 17:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kltAxaR+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVZxDHG6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A58C10E2CF
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:32:39 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CFeLnb633921
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FkLmSLP69kjxpeOM6oO3fuI8XSWjhOpqQ75tZ0kttrg=; b=kltAxaR+jvgsJ93N
 zeQaulNOJ0J4TvysYcjpT/c+ORSQpFfGNGCzuSRNp6Qh/ZZnZCHmXJX/aGjx5Svy
 SkuP+PGpPcx9EUy4i1T+PYphNLy+AWh3APIZFyL81/2dnhDHAKbD7I3mnIyyMswk
 81YmMXm0YjWkFS652BjGUnFLM66gqiKwjNfoTDQ9nDtRE1qgQruvYhw4NqCgl5wE
 bkTWC4IdbB69IXA+ohkaIlVpu5aXLyloDyuV+J8VwK7R9J7EJkt4tjbP1ZdqfnaZ
 t7UiJ3mfrMO/BKUxJsej1/iEVJlL3WAoUN8iyQD/hZMXi5phIcNHxO6rk3vmHvXC
 yPZH0w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtjrhs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:32:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d5d1c2289so28805431cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776015157; x=1776619957;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FkLmSLP69kjxpeOM6oO3fuI8XSWjhOpqQ75tZ0kttrg=;
 b=iVZxDHG6oLVT45JCXHx3jY/Ph1zaUpJluwp9YgF2xL0I3hC/Z+BwDlZXGV8/OCTtQf
 UyP5ifr4ePPoR8H/uA/h2zaVAViy6Gk/c09E9bfewl8Ak8/cTjJHp/VktJjrH2RRW936
 9yn6CLOkxA3Pjy5gqyP6MLLPqjI9njYG/enkGoo7ar1Fl3f1bNOWcP8MOXGk07S3yX7a
 f8fe99C1qWKtXWYrfIuGJhiMjJ1SrAShx3CeeGAmgbTpFMAulgkzjLeL3Xrw+BAHTB1s
 Vl4h4/dLqO66/SlCPXhNP3q7t7C9+Uojio4v5v9ve8tLwqe8raDeWGnZPhSAIla2bW3e
 MfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776015157; x=1776619957;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FkLmSLP69kjxpeOM6oO3fuI8XSWjhOpqQ75tZ0kttrg=;
 b=R02Yr5Sxy0VCxAdOGZoRJ934NgHOCEBNubjXS/SsFMhMCKpv6nmc/pV+3Rpd5RboJu
 yRnWm8PnqKIUZgSbQrt8tJdRtBHkKQv8Dm1+n4OYxZ2Ywjbuw8h5UZqrReQNf+UWv64M
 BoO2gtrOdHolG5zZnMON/1lIzVOvAc38TtHp69RzqU9F7GrFBNDCk+gi7F6DCKNqne+o
 VUSrv/ZIvOKt4vZaOOm0BqaVrJm8M1D0Xl0+qv2rHMIaTBilyOoBsbeJjWXa4ANuVsQW
 1cwZIRw8vRCsTq9dFQEM/ivnsvRyvjQ88G14ubgC+L3RxlciMiI8YTD3gQBZedikzKQu
 1PMA==
X-Gm-Message-State: AOJu0YyMr52WpquHcDBUAHcDrVKtb34859V8phXwoha7/H0Cb6zuizEa
 BFKj6niFWT2b1W0S44S9ruK29mwpa6yE5w2HBBiRWA0Bm/vYDeODcIK4lSs/lFM20MUKyusrCnb
 tCd0ksaG0BTh0QiRf/q9J2tBS5JNhDlMfiNNiceizfvaijbgLyi2bPm1IN/2MLW74chOl8Jh2Ue
 YzSLQ=
X-Gm-Gg: AeBDiesHBUKxknVtOOV8Yd+MfKZRTHR8YpyKoojdjhvQs5kCwR8ZsULmhvNanduOVJG
 0Pu2IWtTsM99mWM6jSYAqGAZwtK8QHOHmZU/uN4ZS7LTNxjzStfgL3Ey78Gazx76fUpArV1gLta
 zu+RpIgV0jwoQ4yj2p4qMesu3WrEcnmBsxwW3LR+xP8MjOnOS/rZZiIbvCCeD/nfaAs33+azgFN
 QfzzJnf4OPFdPcrTe7Ty4O68z4lQUNVkIaD601gCmxb282T75LQdpQX0X5kE92jjgdYdPUSRNKA
 1vghB0G3P3gSrTM3FxsfUkfay6O69VIsMHsaojB+Mr9iTq15LL5gaYGriKPQ17V8pUx5j/IGnio
 qRC9uKCSskhUnpus9HNBtTCR3XS/KANr5bYs+fWRNrK1nq4gMjSYimHFZOESu1voNVnsdIzxK4d
 LuyJRXLeg8ON/mHkCsFDSxYaCOkK2lxW/oPlY=
X-Received: by 2002:a05:622a:1b86:b0:50d:8b5a:1334 with SMTP id
 d75a77b69052e-50dd5aac1dcmr162492001cf.3.1776015157231; 
 Sun, 12 Apr 2026 10:32:37 -0700 (PDT)
X-Received: by 2002:a05:622a:1b86:b0:50d:8b5a:1334 with SMTP id
 d75a77b69052e-50dd5aac1dcmr162491421cf.3.1776015156728; 
 Sun, 12 Apr 2026 10:32:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49a4a6f9sm17585231fa.31.2026.04.12.10.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 10:32:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 12 Apr 2026 20:32:25 +0300
Subject: [PATCH v3 2/2] drm/bridge: waveshare-dsi: support DSI LCD kits
 with LVDS panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ws-lcd-v3-2-db22c2631828@oss.qualcomm.com>
References: <20260412-ws-lcd-v3-0-db22c2631828@oss.qualcomm.com>
In-Reply-To: <20260412-ws-lcd-v3-0-db22c2631828@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp29ctJSuiWpXukJqvY5iz557wAENv7P3NkHIJX
 4L5Jns7/taJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadvXLQAKCRCLPIo+Aiko
 1WwXB/0WGN63L8Ed3N3zdQJZQn3kajS/9NVSjSPgFKCFaaprxNCcR45US6Vgz9VZM4SjwykdC5q
 BXND90csjOwaiB4c3UYhYtLXk2lcP4gWbKtAQSOPauHv2S7/4uPwKZRQlo9nNeffmwttxFBgtzi
 2XR+zrSWghC64E0P5ABBwN/lfS2lK7Ek2UrRtYlDPR2uSKBoHEm6Bjtu21Iqxz3s1agdrDCrBSm
 QaCmux3Ivi0uOvyCsEJOhc1vPp91h5cnEmFnxXSIHVWuIPKWOU0+vJwJ2/hkMsHFRWzFKfnusg/
 cRe+7pgi4jFBFZZDsc4FOCkaGADAFnCyXE72Y0rTD00+Rrje
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69dbd736 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=2ETHJKsuVJx8nypl5XUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: n--hA9zdEoPyNVFE6Yo4TCM9qZP2qkP0
X-Proofpoint-ORIG-GUID: n--hA9zdEoPyNVFE6Yo4TCM9qZP2qkP0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDE3MSBTYWx0ZWRfXzVw7GY41xXo9
 qb7m3faZO5KV9YMPO3sOZbROgk9KIeGpPol6D0fPj0t98Rkt2MtZ/DrR6oxv10ZulsoXW7bVT7D
 UjeKBI/N9x5l/wcGOlISDE+QYPfEdLp8AOoVmoRcxdEmS5pfbRFiWbSlcx9RAIskGf0I0nTY4AO
 Cv+tess4p8rAXeoCOjJVeGmsZFjQLK7iELqwduR6d3rMPiqG3d1Jx9SWkh04tfaDQaGlUNj0TVd
 6vbUJcpjo9wdVWZaochEH4m08vysQdcnVfTmOxLP9NmxTa5ZK5Pbqc/MCTcfMj42p1IQ3NZXlpk
 r1gX5B+nMDDz0sp2lRDnkuh5q/VdKbed9HVDMUU3g1z46TQGi3LTgJs6eIDuuwv3mInOVtCbgSs
 EXdu88kXPiVXwbbpBjGRB90Obw5jDM8HAGA5f6DNEhm2amaoWYeiUjQ4g445EKkLFFUucFg3RIp
 e2D1F1NG/lnoTEqQtYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604120171
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

