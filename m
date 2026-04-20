Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D6FF5A8A2
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 23:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AAC310E7C4;
	Mon, 20 Apr 2026 23:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RB4BV8q3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TXOnYtDZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC6810E7C2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:33:47 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KMhmC61128065
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5tD1CybSiFSGx/tKPVz/twlIrgCEvULY+FLI3aHZuz4=; b=RB4BV8q3O/AK8c/I
 wqbOi+dm0jNKjPJp5nzPOaZvtHZ5ZmvUPq9DLpLI8nJUP8jMSptb3YwSuIttTvfA
 /IZbGJvawSSi2eJcUpTV4vLHFnAYthW0y+0Qv5SFi3080tz8thXMidNciWvV/TiE
 XpXWyqcQjrUD8pNgf8iYkfxe9A128v7HD5rbsE8GggRPulmaANH4lGWzKXbDQhgg
 ZqC+zR8rUJk0TrkkZnKiMfUzfJorKM6I+esRqK+cT6W3JF4nModNu8pea+CzS9gM
 XqXGwgmpAub4Uqrge1lAnegotOf4xQ5serTJwb6TTicaVQZ0kCSb2hN2Y4qfShs7
 CyTHNw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnw68r36w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:33:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d84b5f73bso131815241cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776728026; x=1777332826;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5tD1CybSiFSGx/tKPVz/twlIrgCEvULY+FLI3aHZuz4=;
 b=TXOnYtDZvzM03cMr9//nQZwSQDeMZfKH/0owMVZybv+ie7g/nEtdlLbr0V6DfZFaK4
 Ugjt5LrGzNzlvLcRVQDRl8H6oSkZwAkOhezW8vW1co/srRYuPNe1hWcSKnm7PdeDIhZ+
 0NB2hX/S/N/gT+a7sVb1nlcy1XuOO9MzF0eoX2XHHL9epfleoryKhZNDVlQnuU6pYp25
 iXIW3OCk9ZCeEPerJIT6Ma4UsEIoF3DmD9udEH1pGeEe91gCsuZqcmDV9rGb+SDD8Wqs
 7Zsr8EWgwRsf/jENPBbR1KCboFT/IbS6i4iHIMwUsTBXhdCz9GfyxcxmWciSk2hCaNJP
 PDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776728026; x=1777332826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5tD1CybSiFSGx/tKPVz/twlIrgCEvULY+FLI3aHZuz4=;
 b=dVJJ9DrzpFMhfNM+J96cDbojJsFxtyqurcja9mX9lyq8Ay4gw5W7G4Yd+6SbgodQHk
 HBzRK34Bc3XO6BT++9v2Uvdfk32lFqy1cP704xOuS5UWdHKECK/2CWDz0WO9TtNuBOBp
 Xm2OXivNh/TFPXgVT5Xurj1lxWEx4pgRbjdmDdV5F9nv2R2kU9Kb3cirzRqAxX2xmcoQ
 FWSvycjaPwjV5nC+8vgbDADdt0kCdeJ5g9Rza1G2tTC+XnG1AVs5C7LxCDvMfPqdQzR5
 DddHRN0/LMcYX1JvjrUfjURbfi+fz7g7i9NyWbkVsl8eo45ozVwV66diprdihj1Gvchv
 w3cg==
X-Gm-Message-State: AOJu0Yx8aYxiyTZdqNB4xYdvcDUdPzWNC8wO2u6a4tsnJU5eIsc/qO8T
 eASrfi7FeYRX22SfXP5F8hK3QQ0dJUxy00ULMOsgDIsfDZnjM9rAaVEC7paH488UKbhb/AumnHv
 6cA5MpcuCPTq3RL53CQi38RBAygSpjPDD+k3hFAWNdvf64A7SJ3y/i38yBzOps5WpTSUc+4Q=
X-Gm-Gg: AeBDievNyrTbUUjueSOvmEqsWZLG9wDovei8+UHrxFICLGiOqLCyX30R4R3iKBjM5o6
 L4dRTKikp8sp+6H8C1koTh0Ot/vfKmCwcHr0TmUNCFLwH9cxThmP70IBokUWl0bOjam+Uc7R6QG
 6sa+CY6CJNq/MVX+psMGZ1raSv9+GAjp3hvYa/GYeow6mQLbYYOB4SeTfx4H8JY2h6OnC7/hcKS
 eFckwKZ6pAjSi0nzutyGDzhqDkxda7Q1NH0sU/Gf8wh9I1jqKjCfAJrAzmYDcDNuev2vt+lhYmG
 GDFELic+eEM6C5pZ1Gh3zsBchKja09HET1lBkkYQJ+TwnTDXHKARjgnC55aiDbuiEKsYOwyqxFl
 gXZxohbomT+jrFHUeJS5ixS1yS4OKTRWXUU6Qg7NMMyZkjPSNCdY4gMcso9Mw+QkyrIrJV3NLkt
 1EDowoQwEuk6+urjn/2FpJSwvPHH5LvuvSBWvhLpmwh7lAFg==
X-Received: by 2002:a05:622a:4189:b0:50d:8b60:ff13 with SMTP id
 d75a77b69052e-50e3694038amr241879231cf.14.1776728025582; 
 Mon, 20 Apr 2026 16:33:45 -0700 (PDT)
X-Received: by 2002:a05:622a:4189:b0:50d:8b60:ff13 with SMTP id
 d75a77b69052e-50e3694038amr241878721cf.14.1776728025097; 
 Mon, 20 Apr 2026 16:33:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc627sm3320714e87.29.2026.04.20.16.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 16:33:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 02:33:32 +0300
Subject: [PATCH v3 2/6] drm/bridge: pass down IRQ_HPD to the drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-hpd-irq-events-v3-2-44d2bf40dfc2@oss.qualcomm.com>
References: <20260421-hpd-irq-events-v3-0-44d2bf40dfc2@oss.qualcomm.com>
In-Reply-To: <20260421-hpd-irq-events-v3-0-44d2bf40dfc2@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=13571;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=EFjBNNXY4LL2a3Oa83bwPsPhmfsi3WM3QfAbe0woSwI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp5rfNDQikV8lwyKF2AVpt7ypLGhQsI/b/8noNy
 qSMN9n8X7eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaea3zQAKCRCLPIo+Aiko
 1e7qB/kBn8DXRA/esEmQEGxZP/jHGsTszPNBp8UY1lrlw0xGE+yw8EDRn6/ojHARDWBZrUJzM5d
 lZYrNKy75rArqlLOHsqbMJ5zVW1OjSF4zO6tRzHyI23GBes4UOHy0zLHxJc4FX0VyqfCp+J7pK0
 PjVfvM0emPhE9uIfidyQXc26qXIuWX14YpdGgDIQMLm3OqJZ7Tg6tijjaHGmBsLaP+TeVJ/F6NH
 94B/LLi/IWKJs1YIl9d4uyV/eTrHSUPImcGdu7kygoOlV7Vw8heG/vmwZIYvqbSaXxbAq7H1uJW
 DSe7GsqcIJhEF2PmZelv3aKo7Trz9RHNlvCt47okrwh9qUdC
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: k27I2I-D8CArX1Z4Gbyce6eFY3lvIChF
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=69e6b7da cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=-CExsNOmisbVDtTgQd4A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIzMCBTYWx0ZWRfX7/Cv/t8KIBAs
 7SJN+dP+DtYgqCkJ9W9olPNht0uBZMBu8/SzFTt2HUTvATV9pa5nhfoZtajltOnMcapJ//BFyQZ
 WXgu3xBsjckkvlC6GOmdutCwj+Q7QnZQVV3oSi96KC5gK95/iZjwGr7Nd8MMQt+WT+cpKYjUVwi
 KROjSoBcbO7Q1+dzVgDfS9hnEj/i5w/+EEYyqpsKmTsjkal8uSEfyv/PiFCzR+6gWJTP2IjrBQL
 7e+xAxDTV+hLLQq9CSUIm24j0BrKnUzN7RwJCJH46KO3NDdcSKwK6jsWp3s/Oa4UwcwVTcKizBe
 PnHE2tlAWg7FTmfQPDP3We0TdkOOos74XPd2gHeDfJ79GT+7mVnhDUIiZkVonCXBClP7kHkHqyW
 axysfsryYYFHXh2LtRc9XU1U5JBliCYGPGPe949ng4A+68PkuAGtQmglfEbQfYxUy9auXEXIHpk
 2nXDXS8hcFKrdFwUFlg==
X-Proofpoint-GUID: k27I2I-D8CArX1Z4Gbyce6eFY3lvIChF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_04,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200230
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

Pass down the notifications about the IRQ_HPD events down to the
individual drivers, letting them handle those as required.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/chrontel-ch7033.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt8912b.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
 drivers/gpu/drm/bridge/ti-tfp410.c             |  4 ++--
 drivers/gpu/drm/display/drm_bridge_connector.c | 22 +++++++++++++---------
 drivers/gpu/drm/drm_bridge.c                   |  5 +++--
 drivers/gpu/drm/drm_connector.c                |  2 +-
 drivers/gpu/drm/i915/display/intel_dp.c        |  3 ++-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.c            |  3 ++-
 drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
 include/drm/drm_bridge.h                       |  9 ++++++---
 include/drm/drm_connector.h                    |  3 ++-
 14 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index 54d49d4882c8..04e6b4c00a28 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -259,7 +259,8 @@ static const struct drm_connector_helper_funcs ch7033_connector_helper_funcs = {
 	.best_encoder = ch7033_connector_best_encoder,
 };
 
-static void ch7033_hpd_event(void *arg, enum drm_connector_status status)
+static void ch7033_hpd_event(void *arg, enum drm_connector_status status,
+			     enum drm_connector_status_extra extra_status)
 {
 	struct ch7033_priv *priv = arg;
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 8a0b48efca58..b404f0cbf60d 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -504,7 +504,8 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 	return 0;
 }
 
-static void lt8912_bridge_hpd_cb(void *data, enum drm_connector_status status)
+static void lt8912_bridge_hpd_cb(void *data, enum drm_connector_status status,
+				 enum drm_connector_status_extra extra_status)
 {
 	struct lt8912 *lt = data;
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 11aab07d88df..ca41ebe9f26f 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -430,7 +430,8 @@ static const struct drm_edid *lt9611uxc_bridge_edid_read(struct drm_bridge *brid
 
 static void lt9611uxc_bridge_hpd_notify(struct drm_bridge *bridge,
 					struct drm_connector *connector,
-					enum drm_connector_status status)
+					enum drm_connector_status status,
+					enum drm_connector_status_extra extra_status)
 {
 	const struct drm_edid *drm_edid;
 
diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 3b6b0e92cf89..199916662895 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -39,7 +39,6 @@ drm_bridge_to_tfp410(struct drm_bridge *bridge)
 {
 	return container_of(bridge, struct tfp410, bridge);
 }
-
 static inline struct tfp410 *
 drm_connector_to_tfp410(struct drm_connector *connector)
 {
@@ -110,7 +109,8 @@ static void tfp410_hpd_work_func(struct work_struct *work)
 		drm_helper_hpd_irq_event(dvi->bridge.dev);
 }
 
-static void tfp410_hpd_callback(void *arg, enum drm_connector_status status)
+static void tfp410_hpd_callback(void *arg, enum drm_connector_status status,
+				enum drm_connector_status_extra extra_status)
 {
 	struct tfp410 *dvi = arg;
 
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 39cc18f78eda..5fdb1a231cec 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -141,7 +141,8 @@ struct drm_bridge_connector {
  */
 
 static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
-					    enum drm_connector_status status)
+					    enum drm_connector_status status,
+					    enum drm_connector_status_extra extra_status)
 {
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
@@ -149,12 +150,13 @@ static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
 	/* Notify all bridges in the pipeline of hotplug events. */
 	drm_for_each_bridge_in_chain_scoped(bridge_connector->encoder, bridge) {
 		if (bridge->funcs->hpd_notify)
-			bridge->funcs->hpd_notify(bridge, connector, status);
+			bridge->funcs->hpd_notify(bridge, connector, status, extra_status);
 	}
 }
 
 static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bridge_connector,
-					    enum drm_connector_status status)
+					    enum drm_connector_status status,
+					    enum drm_connector_status_extra extra_status)
 {
 	struct drm_connector *connector = &drm_bridge_connector->base;
 	struct drm_device *dev = connector->dev;
@@ -163,24 +165,26 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
 	connector->status = status;
 	mutex_unlock(&dev->mode_config.mutex);
 
-	drm_bridge_connector_hpd_notify(connector, status);
+	drm_bridge_connector_hpd_notify(connector, status, extra_status);
 
 	drm_kms_helper_connector_hotplug_event(connector);
 }
 
 static void drm_bridge_connector_hpd_cb(void *cb_data,
-					enum drm_connector_status status)
+					enum drm_connector_status status,
+					enum drm_connector_status_extra extra_status)
 {
-	drm_bridge_connector_handle_hpd(cb_data, status);
+	drm_bridge_connector_handle_hpd(cb_data, status, extra_status);
 }
 
 static void drm_bridge_connector_oob_hotplug_event(struct drm_connector *connector,
-						   enum drm_connector_status status)
+						   enum drm_connector_status status,
+						   enum drm_connector_status_extra extra_status)
 {
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
 
-	drm_bridge_connector_handle_hpd(bridge_connector, status);
+	drm_bridge_connector_handle_hpd(bridge_connector, status, extra_status);
 }
 
 static void drm_bridge_connector_enable_hpd(struct drm_connector *connector)
@@ -223,7 +227,7 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
 		if (hdmi)
 			drm_atomic_helper_connector_hdmi_hotplug(connector, status);
 
-		drm_bridge_connector_hpd_notify(connector, status);
+		drm_bridge_connector_hpd_notify(connector, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
 	} else {
 		switch (connector->connector_type) {
 		case DRM_MODE_CONNECTOR_DPI:
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index d6f512b73389..c8c3301cd936 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1444,7 +1444,8 @@ EXPORT_SYMBOL_GPL(drm_bridge_edid_read);
  */
 void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 			   void (*cb)(void *data,
-				      enum drm_connector_status status),
+				      enum drm_connector_status status,
+				      enum drm_connector_status_extra extra_status),
 			   void *data)
 {
 	if (!(bridge->ops & DRM_BRIDGE_OP_HPD))
@@ -1509,7 +1510,7 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 {
 	mutex_lock(&bridge->hpd_mutex);
 	if (bridge->hpd_cb)
-		bridge->hpd_cb(bridge->hpd_data, status);
+		bridge->hpd_cb(bridge->hpd_data, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
 	mutex_unlock(&bridge->hpd_mutex);
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index edee9daccd51..415eb834808c 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3532,7 +3532,7 @@ void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
 		return;
 
 	if (connector->funcs->oob_hotplug_event)
-		connector->funcs->oob_hotplug_event(connector, status);
+		connector->funcs->oob_hotplug_event(connector, status, extra_status);
 
 	drm_connector_put(connector);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 4955bd8b11d7..98bbcab2067b 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6779,7 +6779,8 @@ static int intel_dp_connector_atomic_check(struct drm_connector *_connector,
 }
 
 static void intel_dp_oob_hotplug_event(struct drm_connector *_connector,
-				       enum drm_connector_status hpd_state)
+				       enum drm_connector_status hpd_state,
+				       enum drm_connector_status_extra extra_status)
 {
 	struct intel_connector *connector = to_intel_connector(_connector);
 	struct intel_display *display = to_intel_display(connector);
diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 1abb0572bb5f..691b9996c8a4 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -323,7 +323,8 @@ static int meson_encoder_hdmi_atomic_check(struct drm_bridge *bridge,
 
 static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
 					  struct drm_connector *connector,
-					  enum drm_connector_status status)
+					  enum drm_connector_status status,
+					  enum drm_connector_status_extra extra_status)
 {
 	struct meson_encoder_hdmi *encoder_hdmi = bridge_to_meson_encoder_hdmi(bridge);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d2124d625485..7a0623fdbd8e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1785,7 +1785,8 @@ void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge)
 
 void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			      struct drm_connector *connector,
-			      enum drm_connector_status status)
+			      enum drm_connector_status status,
+			      enum drm_connector_status_extra extra_status)
 {
 	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
 	struct msm_dp *msm_dp_display = msm_dp_bridge->msm_dp_display;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index 9eb3431dd93a..74da3ef6b625 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -41,6 +41,7 @@ void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			      struct drm_connector *connector,
-			      enum drm_connector_status status);
+			      enum drm_connector_status status,
+			      enum drm_connector_status_extra extra_status);
 
 #endif /* _DP_DRM_H_ */
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index 29b2dfb90b5f..a7288791b2a5 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -429,7 +429,8 @@ static void hdmi4_bridge_disable(struct drm_bridge *bridge,
 
 static void hdmi4_bridge_hpd_notify(struct drm_bridge *bridge,
 				    struct drm_connector *connector,
-				    enum drm_connector_status status)
+				    enum drm_connector_status status,
+				    enum drm_connector_status_extra extra_status)
 {
 	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index a8d67bd9ee50..3e4672fbd7a8 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -615,7 +615,8 @@ struct drm_bridge_funcs {
 	 */
 	void (*hpd_notify)(struct drm_bridge *bridge,
 			   struct drm_connector *connector,
-			   enum drm_connector_status status);
+			   enum drm_connector_status status,
+			   enum drm_connector_status_extra extra_status);
 
 	/**
 	 * @hpd_enable:
@@ -1260,7 +1261,8 @@ struct drm_bridge {
 	 * @hpd_cb: Hot plug detection callback, registered with
 	 * drm_bridge_hpd_enable().
 	 */
-	void (*hpd_cb)(void *data, enum drm_connector_status status);
+	void (*hpd_cb)(void *data, enum drm_connector_status status,
+		       enum drm_connector_status_extra extra_status);
 	/**
 	 * @hpd_data: Private data passed to the Hot plug detection callback
 	 * @hpd_cb.
@@ -1550,7 +1552,8 @@ const struct drm_edid *drm_bridge_edid_read(struct drm_bridge *bridge,
 					    struct drm_connector *connector);
 void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 			   void (*cb)(void *data,
-				      enum drm_connector_status status),
+				      enum drm_connector_status status,
+				      enum drm_connector_status_extra extra_status),
 			   void *data);
 void drm_bridge_hpd_disable(struct drm_bridge *bridge);
 void drm_bridge_hpd_notify(struct drm_bridge *bridge,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index e05197e970d3..5ac5a64f83d9 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1720,7 +1720,8 @@ struct drm_connector_funcs {
 	 * has been received from a source outside the display driver / device.
 	 */
 	void (*oob_hotplug_event)(struct drm_connector *connector,
-				  enum drm_connector_status status);
+				  enum drm_connector_status status,
+				  enum drm_connector_status_extra extra_status);
 
 	/**
 	 * @debugfs_init:

-- 
2.47.3

