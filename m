Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646D5CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791CE10E840;
	Thu,  8 Oct 2026 13:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F5jFROzt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJMASGUO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C4610E840
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:15:04 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698BK7KU2116418
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 13:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sL0PcIsuT2lGq78xVWRMAbUxXJs+OS2DfhPwb0cXcfU=; b=F5jFROztkE8lXSuV
 2tKioY6sv3yWPr4xawjqi5G8tkn/BcaZnunodzBMtvXo0//4RptuVj7KdJvboRkB
 oroqZLl7Jzz6QpdPD4ccJ6l+8/G16/y6LpScULhQyCJq2GA3x/L78eo4OA/ktDI0
 2tbuDdIi2UmpaB9vau9hu+jX0vFWvZDczXSxkFFiWJIiOgZ4j/kFphf88kDwLPe5
 rq2IIoer70ueNRYS8rvxC+E/gdbSWxm9PQZ7RXW9GW4EuwwG88BYfy4ui5upm/SI
 7uaQue3Mn0f+tqtAiWQP/Lbr3abF5ReKMumhLiV2bTrPnVBVzxeBdrIcNs7dHA+I
 XICRWA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe531ca-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 13:15:04 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7be858243a6so978046137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791465303; x=1792070103;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sL0PcIsuT2lGq78xVWRMAbUxXJs+OS2DfhPwb0cXcfU=;
 b=RJMASGUOGASsd6kreLdIPooTfyL8encupztEBcUckwaeJbCxzOvBCNrpyhRJNAHB+A
 BmDOwMQzGE+uLgj1eZ+zfDOvtCSVXfjz5qYcNGPtwJiziG8l/CTYltKpYgvxP7X2MCsl
 JJgcR6/NDtVGGUjM5lEQCbYO8CTtlOzuIQUJ0TRipQIL2cd1ksWO4LFNl7ba175LMmpe
 VdNrw6f8AzXE5tjRui3sPGiUxvaZPcLBQjueUPk7jLYUzBrogMy/Li1sZso9Z9fkOEF+
 h/T+IHkaB4HrFdsq6PGCnOsin/xOpfr61gXtOtqky5/vTRKzleC7MkBpkLRJK2cyEcFP
 U+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465303; x=1792070103;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sL0PcIsuT2lGq78xVWRMAbUxXJs+OS2DfhPwb0cXcfU=;
 b=An2mmyre9RuHVq1+W5A1GoyrxKzjsFL1vtYojnX0gruhEY1nAky5EZLomCTeEynyDr
 vuFWkiybPj/Np7LMZyDY7QRwnXdwTjn+UIhDltjmyet6g0AS0rTtQEbwpoJfSQXAU2LW
 d5dVK4K4BpABNxqRKyAy08dsZzSMbq+f8iqefkl3siTLJSqsglRqdFQnhkSb+ux0ekrE
 7n31sjKoxmg+CfIji26dP2Iducczmffd9coQ7WjG/UUzz8xYQy2nOIcxmBEVurrswF/R
 VZ79uMKAYs4EiI6xQnUG8tpzF1pzgrPdsWJfcTqnhawPXQXs7uw4uxlDej+vUI9/6xPA
 CKkg==
X-Gm-Message-State: AFq9FYKm18ErB3OLfv2Y4FQbivSQ7d0h1HxIQRgVqYXa3UrbPwviivS+
 Okks8evlp0kYZ4wd3HUq99hO7CsMqdx1WViFPpY6AHrbdD5ZwRsvzKxEIC23yWCatU/LXlp2ocg
 roFRcUtQskqYaK7UhG0gamq5zAa8Qffb+8GR1lJfbJRewy3MN/wZboglrRpRLxehDIzdMNE0=
X-Gm-Gg: AYBFou1Nzh/84E07adg/OjkPvM7qd3H3agpuWrOyzjYRVenkm2qVlRmEgbCdLe8h2Nc
 lFmoVbrO/OM6zKjZAuxv3Zpn5B7Qyo6f0i/OzsH687DjUh7hA1WhUNirp6ixrzhiD2afW3hKs4g
 MA9hC5+3d3x9plXN5Z4KDFwaAkQ9kYKh5ha9KDL1jdCH3TXFX9moM5C3RTA4scTpp0uHLft+sS9
 EV9mDaTlvdTMzKtCGOodbjEa+oaBYFCdcaH6sPDxq4VNjS2pIyzuo/57gbLvCrOt5SD3gblH2A4
 czaX+UmvQwMybeDkjZrrOEYdjOjvTFp8NpLKLi3NrA6m2OBRQvg8Zyvj3mym/7eu7xEBAswFYC2
 SLlXI5HPLHtOwuYSMs21TgIlre4+OE1J3GShgbNchRCHI3P2LADg/nCYx5i+50j6HuEScnvMNZs
 V5sK5wR93o3G9V
X-Received: by 2002:a05:6102:dd1:b0:7c3:a6f0:99cb with SMTP id
 ada2fe7eead31-7ca38e1cb0bmr1393318137.33.1791465303316; 
 Thu, 08 Oct 2026 06:15:03 -0700 (PDT)
X-Received: by 2002:a05:6102:dd1:b0:7c3:a6f0:99cb with SMTP id
 ada2fe7eead31-7ca38e1cb0bmr1393305137.33.1791465302799; 
 Thu, 08 Oct 2026 06:15:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9ae563df4sm8691441fa.30.2026.10.08.06.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:15:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 16:14:28 +0300
Subject: [PATCH RFC 6/9] drm/panel: factor out the panel follower notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-panel-atomic-state-v1-6-b157fddb8de1@oss.qualcomm.com>
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
In-Reply-To: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Val Packett <val@packett.cool>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5677;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WxoSDtesfPtJ1QyZHA2W6JfIGP8oLsOW8aCQdlTEVVM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqx5dGHeavSd/b4PpeyyXfUxEH1TIPxnfEh8B3G
 VlH8VwWUlqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaseXRgAKCRCLPIo+Aiko
 1WQ/B/0XM7HDpkJyCpbbBkf0e+jtRpKLvvFTv2bgnNgaj+DL5d/xqkhHfRb03L1mnZa22eK2LHb
 zpSXB8z6AAB/fPeolS2dv4ODFVAZBkaNRUalcHaVeyhDaqGuclgsMMLr8+PdRSL8w584jMdiiuO
 NzG/AJ6J07spCeaxZRXjlmtq8VaO/msGBK847NySXBrzOZVD7asb4OSV8hGf5YIOFImMpnUss3Z
 FPuYpd31xz/p3qcQjTdOLuW1PX79ySHamQ5Ro+f12Ctgj2WB0VSzo3gxPAuiUFg5yfaobmVDeQu
 J+TkjdEFVjMqzrLw5Ccha29LTTjMlN8EdMn+S1VcA2GoHWvV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: -td9vKbDXCLU8togbN8eHC7QsI2-oqjP
X-Authority-Analysis: v=2.4 cv=E4dYNqdl c=1 sm=1 tr=0 ts=6ac79758 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Ehp3mkkGfunlVMu3AX4A:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX6+6FqF1CkG5Z
 9YS8dZddcv/o0M3DhuEkGEauM47IY2tWEiwmJX0lEMd48WeFyz3ufAqrqdF1RTWf/hO2sctabIb
 EmHqNGGmn7j+tKCkIPY6ioHuPM8uX18=
X-Proofpoint-GUID: -td9vKbDXCLU8togbN8eHC7QsI2-oqjP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfXyUBrcA4vtm/1
 8xVsjW73ga9lrKHyQa1AyE0IJMoPY4m3k5mCxczdrcdmp2lAf9lkeNMvCDZjxocHrkhft1dH59Q
 YtESO1OcB0SDzFGcby/RudguCiTTxQO7wHe29ZQ0iBEPMMWIiv7D/YuNDIocAsywBEAqr1PZZAD
 FAnzG1PbGuYtzUDb6S/9ss408kSPtgCoXR+7u7qb1U4ykfKE23RksRFqRkYcNgyIkDV8wEZt0uA
 YU5ixysYBQDPYdI6hWvapeAZUWzscPDpfAZHsJwEk0WzUtMDL2WAcCUpexkBWnxkMcQPSqXV2t7
 8UfOqypmQVeqZbC47+zDd53E9xNDZX2zeR1BLpcW5j5ZHWEuJVHgMkIxZqsry8+dSg/ZeeYn0qE
 Jb3I7+zI6bEkFLV7QHV1/Zx3mEoXMDoZPQMD6HKpBz/QYsO2eA3yfgAwQ/scSQid8knEBWRw5Eb
 ddF3ux9C9UqcYzWs/Qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080052
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

drm_panel_prepare(), drm_panel_unprepare(), drm_panel_enable() and
drm_panel_disable() each open-code the loop notifying the panel
followers. The atomic variants of these functions are going to need the
same notifications, which would duplicate each of the loops.

Move the loops to helpers. No functional change.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_panel.c | 116 +++++++++++++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 3a154be128a0..ed0d16e04eae 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -84,6 +84,78 @@ struct panel_bridge {
 	u32 connector_type;
 };
 
+static void drm_panel_followers_prepared(struct drm_panel *panel)
+{
+	struct drm_panel_follower *follower;
+	int ret;
+
+	lockdep_assert_held(&panel->follower_lock);
+
+	list_for_each_entry(follower, &panel->followers, list) {
+		if (!follower->funcs->panel_prepared)
+			continue;
+
+		ret = follower->funcs->panel_prepared(follower);
+		if (ret < 0)
+			dev_info(panel->dev, "%ps failed: %d\n",
+				 follower->funcs->panel_prepared, ret);
+	}
+}
+
+static void drm_panel_followers_unpreparing(struct drm_panel *panel)
+{
+	struct drm_panel_follower *follower;
+	int ret;
+
+	lockdep_assert_held(&panel->follower_lock);
+
+	list_for_each_entry(follower, &panel->followers, list) {
+		if (!follower->funcs->panel_unpreparing)
+			continue;
+
+		ret = follower->funcs->panel_unpreparing(follower);
+		if (ret < 0)
+			dev_info(panel->dev, "%ps failed: %d\n",
+				 follower->funcs->panel_unpreparing, ret);
+	}
+}
+
+static void drm_panel_followers_enabled(struct drm_panel *panel)
+{
+	struct drm_panel_follower *follower;
+	int ret;
+
+	lockdep_assert_held(&panel->follower_lock);
+
+	list_for_each_entry(follower, &panel->followers, list) {
+		if (!follower->funcs->panel_enabled)
+			continue;
+
+		ret = follower->funcs->panel_enabled(follower);
+		if (ret < 0)
+			dev_info(panel->dev, "%ps failed: %d\n",
+				 follower->funcs->panel_enabled, ret);
+	}
+}
+
+static void drm_panel_followers_disabling(struct drm_panel *panel)
+{
+	struct drm_panel_follower *follower;
+	int ret;
+
+	lockdep_assert_held(&panel->follower_lock);
+
+	list_for_each_entry(follower, &panel->followers, list) {
+		if (!follower->funcs->panel_disabling)
+			continue;
+
+		ret = follower->funcs->panel_disabling(follower);
+		if (ret < 0)
+			dev_info(panel->dev, "%ps failed: %d\n",
+				 follower->funcs->panel_disabling, ret);
+	}
+}
+
 static int panel_bridge_connector_get_modes(struct drm_connector *connector)
 {
 	struct drm_panel *panel = drm_connector_to_panel(connector);
@@ -758,7 +830,6 @@ EXPORT_SYMBOL(devm_drm_panel_add);
  */
 void drm_panel_prepare(struct drm_panel *panel)
 {
-	struct drm_panel_follower *follower;
 	int ret;
 
 	if (!panel)
@@ -782,15 +853,7 @@ void drm_panel_prepare(struct drm_panel *panel)
 	}
 	panel->prepared = true;
 
-	list_for_each_entry(follower, &panel->followers, list) {
-		if (!follower->funcs->panel_prepared)
-			continue;
-
-		ret = follower->funcs->panel_prepared(follower);
-		if (ret < 0)
-			dev_info(panel->dev, "%ps failed: %d\n",
-				 follower->funcs->panel_prepared, ret);
-	}
+	drm_panel_followers_prepared(panel);
 
 exit:
 	mutex_unlock(&panel->follower_lock);
@@ -811,7 +874,6 @@ EXPORT_SYMBOL(drm_panel_prepare);
  */
 void drm_panel_unprepare(struct drm_panel *panel)
 {
-	struct drm_panel_follower *follower;
 	int ret;
 
 	if (!panel)
@@ -837,15 +899,7 @@ void drm_panel_unprepare(struct drm_panel *panel)
 
 	mutex_lock(&panel->follower_lock);
 
-	list_for_each_entry(follower, &panel->followers, list) {
-		if (!follower->funcs->panel_unpreparing)
-			continue;
-
-		ret = follower->funcs->panel_unpreparing(follower);
-		if (ret < 0)
-			dev_info(panel->dev, "%ps failed: %d\n",
-				 follower->funcs->panel_unpreparing, ret);
-	}
+	drm_panel_followers_unpreparing(panel);
 
 	if (panel->funcs && panel->funcs->unprepare) {
 		ret = panel->funcs->unprepare(panel);
@@ -874,7 +928,6 @@ EXPORT_SYMBOL(drm_panel_unprepare);
  */
 void drm_panel_enable(struct drm_panel *panel)
 {
-	struct drm_panel_follower *follower;
 	int ret;
 
 	if (!panel)
@@ -903,15 +956,7 @@ void drm_panel_enable(struct drm_panel *panel)
 		DRM_DEV_INFO(panel->dev, "failed to enable backlight: %d\n",
 			     ret);
 
-	list_for_each_entry(follower, &panel->followers, list) {
-		if (!follower->funcs->panel_enabled)
-			continue;
-
-		ret = follower->funcs->panel_enabled(follower);
-		if (ret < 0)
-			dev_info(panel->dev, "%ps failed: %d\n",
-				 follower->funcs->panel_enabled, ret);
-	}
+	drm_panel_followers_enabled(panel);
 
 exit:
 	mutex_unlock(&panel->follower_lock);
@@ -931,7 +976,6 @@ EXPORT_SYMBOL(drm_panel_enable);
  */
 void drm_panel_disable(struct drm_panel *panel)
 {
-	struct drm_panel_follower *follower;
 	int ret;
 
 	if (!panel)
@@ -957,15 +1001,7 @@ void drm_panel_disable(struct drm_panel *panel)
 
 	mutex_lock(&panel->follower_lock);
 
-	list_for_each_entry(follower, &panel->followers, list) {
-		if (!follower->funcs->panel_disabling)
-			continue;
-
-		ret = follower->funcs->panel_disabling(follower);
-		if (ret < 0)
-			dev_info(panel->dev, "%ps failed: %d\n",
-				 follower->funcs->panel_disabling, ret);
-	}
+	drm_panel_followers_disabling(panel);
 
 	ret = backlight_disable(panel->backlight);
 	if (ret < 0)

-- 
2.47.3

