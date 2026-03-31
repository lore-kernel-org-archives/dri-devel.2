Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A34B109B492
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B0B10E967;
	Tue, 31 Mar 2026 15:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WeqgwOyk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QcVZDKAM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C4C10EB71
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VEKDTX2761401
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FkLmSLP69kjxpeOM6oO3fuI8XSWjhOpqQ75tZ0kttrg=; b=WeqgwOykyOexKNJh
 mYsFN1r2+BeSK39ey2hIuU71SPfRa9rLG7VkISsV7iBNrna+1Lz/p8wyFPpvZ/ee
 TkyJ3nrW0uk+QCyMBl2Obkfbr87Sa8n03pMMxRQkryY3t0Y5CkfFzA7WNjUrdD5D
 G1zxOTa0bvOT3cJz30pzH56B1MDxX2ilkc12hCz0FMEMNWua5ktDppjn2sov04HA
 40kjsH83EIgN/8Be2gb2k1EAcaKxpzN1QJFNvFxJp9GNfxc42yUJI3Cv/cbN8zLS
 pcAWpTeqQ+HrQE8Jje48Biv3e46EtT3RbMKaL2C6lg7OZgH+di41D1zbKNz5tLQX
 XmtodQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8b931u9h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b4ca7e7c2so151974181cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774971856; x=1775576656;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FkLmSLP69kjxpeOM6oO3fuI8XSWjhOpqQ75tZ0kttrg=;
 b=QcVZDKAMo/8gTQx6vxCwCczBpYxzvSsJ/o6KgykEY/MtZuhffmuBOvZTznHdKHcgk7
 oywC44WhefE8WyjDu90wZ4YIEUHkX79DrzE9RGAf+kB6CKCN4hvH4cUdHUSeSWo3+jQ9
 sv2zKojq2+iOdt5bL2dX5KT+vW05fRZjcKptuyi1WRcr/2YkV1iq8IyDzFuLI6ohg4oj
 x/QGNsP9LlH3qCDfTCGhSs9PuFHopv9lSuexnGmFwReUYbKCFUb5s4/9N8F7U903/h/G
 5kacZXDYtSG2aNSZxuIlPHuL46H4GkyUXRqN5Fb7FRc+PE2uRoZeAqEldJ1euT7vkTFs
 Vogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774971856; x=1775576656;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FkLmSLP69kjxpeOM6oO3fuI8XSWjhOpqQ75tZ0kttrg=;
 b=T7MkHmPlIsXszINejNPB8Md3l4KaRGxDVJ3xUY5bEzStNMOPKAcQ9NaD/ntr7MpAYH
 wZueyG17poM51emOXh9pALNnj3caFsRQUcLmqMd1WgL575dgW/Yr0M3yZrVAgm4UIX/z
 WWOlo4Ay+9TKELzlz3X4216w4aJ8Q0Euv2Ubk9j3+EcmuI6hBxBRroRZPWT8GsLlfUcH
 BknzxOZjaYDlfBDcaaLmX5u+8sDCzcZTrvH0WFC22kZ0pz0wJWxI+5eyIm4ux67RcAt8
 BIHL6Z7qZde5OWd80CS3T4MR8XKeP2x9O0HZJdpIficJnlZQ6G7xFdQtwUC1eFzhiwMz
 Z0oA==
X-Gm-Message-State: AOJu0YyC4Ycux8s6rsM1wPjCpfFraaVxO/jnD9bSnR9hkRXrNWxdEYUg
 xCzgr327aOZPYuWc5AISdYmshSZCoiTwzSMN1NHp33m17g7MEJwjYc/Jti3cu+a2OEIF7V0CrNq
 4+ZaSD2blYtF2DcBzU076YDVdUYODrl7+RzQH5+Ifx0FldLxddHsTnIvErgzP4py5UWRhY2Y=
X-Gm-Gg: ATEYQzwaDbMe3z/P+BOEZp3KmjeCDG+NrCpnsoKYqZx/ZL25Wz8cQE0/Q0iD8OUe8IS
 Snxpn384e1jAckM7dMebDO5Q5izCefZPVs+CUCLTA31N+t662EHmGPR+vqy/ir5oRioVk+p7njn
 HG3I4iwivXK8c7THlbHjbxx0qOVwKr23Lucgwi6/mrtPnkALG5J9ifb8rParpb6jGJKMWmTjIek
 t3FwuraWZFIIKOc14dI3htSQ9DrqllOW0HMj4vyMRR/i5um9JBBKyrAWdh5tZSDUaOicuAZkIF2
 vE5oPhj0R+f4J7hofoOjIf6nvGlhDszfpajH1cAn2NENTc4D4EqhNCammQyIXOCTo6ypy6DpJhl
 GCUd6kY1LV0zkFBst/V65+gZNAyGpzoPuBvKaiwBq36fqtEjIZkXuhWwOyBmsCbvqbjf+KpaeZh
 0VOU3dTvIl4gZAvHDwmaqzs44Vkmhw6SWZbdM=
X-Received: by 2002:ac8:5d4a:0:b0:50b:3b54:d78c with SMTP id
 d75a77b69052e-50ba3948161mr234508501cf.52.1774971856344; 
 Tue, 31 Mar 2026 08:44:16 -0700 (PDT)
X-Received: by 2002:ac8:5d4a:0:b0:50b:3b54:d78c with SMTP id
 d75a77b69052e-50ba3948161mr234507661cf.52.1774971855860; 
 Tue, 31 Mar 2026 08:44:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c838931b9sm25387461fa.23.2026.03.31.08.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 08:44:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 18:44:11 +0300
Subject: [PATCH v2 2/4] drm/bridge: waveshare-dsi: support DSI LCD kits
 with LVDS panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-ws-lcd-v2-2-a1add63b6eb6@oss.qualcomm.com>
References: <20260331-ws-lcd-v2-0-a1add63b6eb6@oss.qualcomm.com>
In-Reply-To: <20260331-ws-lcd-v2-0-a1add63b6eb6@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpy+vKRzoSpdaY3DpnDjQmiteFmEKy1q1NVqnjd
 FqjB4Egz8KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacvrygAKCRCLPIo+Aiko
 1ZvOB/0Tm4fejfgLri664iDJ96c5+5vVgH2yrmYylCAus8f6TMXK/onUIiyhxR41Tqjg5VjBJFB
 TG85SWopMKCSv6q7udlQUHFLU0fsDgLh7JHWC2LzbtkJz0RBnavHoDDaAqxh22lJIcGJw04M9en
 ZczkTswl/U88Ei/3FUhQr1uRcuYUOh7rS9iGYB4ey3GIHttg7AfCG1qsfeaWJLpHvimX1S2E4Jq
 6Dv+kfw43sJOBiYKJtdqIf++DNx/eqqeBJMOiRhSAnctPPSM1KTD2GVU9JoAE3ZQq0TMiavjx95
 dteOHVmNtYNpGFhh2GxoBmHS9nJy60GRw5ruzYmfpZul1hXZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1MSBTYWx0ZWRfXwImfpWcUx/EN
 kF7+0Gclx1b1AiUY3YxL510Y45fJgrK0UhSm3gqjFuPVHyn1RC9Z5F4r7+avAK8mgjzXQ/ewagT
 CYtCChuHiG9CbOfE2RwLojvWE4R2tUafljD9Y8u8VoCU6k2Y1/aSbHbFaj++kq2w4wHFpfzMGxy
 HXPjQl5rcx5me0whHO7pQY0O/5Bqj1xSGcQ/mFJMLMcTIVz+nqs2CDSR4ST9IOi1tF2j9gAJcPa
 DIsYjytclzbg/fprmTJwhMvvxPbX14NIjfu3B/+ehVybZ8AZs0fDkfbHymUDGWo8ieaf5LGIiLm
 lH2qJu5LsbmWJoZQUAiKQX5ZKgOC07cf7dzcfgiF06My1n5PLvmZeNt3QE7d56Hv8uYe5jnL/jJ
 hy4k6vwzC6GtwSYhbBVmgW6+35QOuDtnKwxcoeP5xgqceWqf3izYN7fE7u+vSQUhRWmlC8zqEOC
 CHtOtzb6sALZywBH5KQ==
X-Proofpoint-ORIG-GUID: ODzqHrf0M3EdidGfIXryfJ221W6l9jVO
X-Proofpoint-GUID: ODzqHrf0M3EdidGfIXryfJ221W6l9jVO
X-Authority-Analysis: v=2.4 cv=NLjYOk6g c=1 sm=1 tr=0 ts=69cbebd1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=2ETHJKsuVJx8nypl5XUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310151
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

