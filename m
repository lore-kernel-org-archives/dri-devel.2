Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97937CD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA2610E359;
	Sun,  7 Jun 2026 21:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lgf/vqiQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UPGM/M63";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5896710E5C5
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:33:18 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657HKI2j707678
 for <dri-devel@lists.freedesktop.org>; Sun, 7 Jun 2026 21:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SCoT97Q5hVm4j6zlVv2MwuqAb+a0wwmxj8TjVN/oHI8=; b=lgf/vqiQvwidXX+J
 H3u0Hg+bm/YbqD90L3k8SZI/n3ibPQNlDNkNDvBLEr64+i6fWp/V5U5XpRMpQR2F
 odM24vycGfIYPw3s60L2/A+/3QKHA6fxU9wgzMQfRsitxyYxItsY2UySoJr2DnPU
 03QHC9EGoT8XIVoRj+k+Pg3hPud+QIt/ZW02lwQ1AAGV1uJLosZiP6kWv2qoaeCh
 De5+wRgj7FIMkfONdSCG6cls9Bsftkis27VLuwXgZ4gqr8+rI2CwFz+UzeSTkLGR
 DHHlFLjopbK8nfjbWPgBBvJKRiGuSEkT7lePsMNWxQIuoIv7E40uRIoTHGccEJCT
 P/HFdA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagrd40v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:33:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5178bcab15bso79086691cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780867997; x=1781472797;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SCoT97Q5hVm4j6zlVv2MwuqAb+a0wwmxj8TjVN/oHI8=;
 b=UPGM/M63BnHLuaVYJspyHDnqikr7BpaImK3p1bDFendPKPDy8+jP5siS0EoQnx7lD0
 ziEB1Zd81n62g/EFzAVtNjbmrH02+UYhZWzVDLLmIvBg4RbGdfM4RPcIBui/vfPVjI79
 8rMB+VzKaZxdp6tc5lQWgVozTgse0/ErV4I7yfl7WdOvkxc/Hc6oB3TJ5z0b8tIO13Mr
 t+nGrhJTSMKPfX2zSvgFpH2vgfC6PBV58hByjXTLAxhfmFeexBQF+6jCXSZ3dt/Fb+K1
 XsVr+hQW3Rv7rV7ARCjHkgM67IgESMqFkoVLNxv09Z6HLlkkvgsEc/tQaLjz+zD/knF8
 L9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780867997; x=1781472797;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SCoT97Q5hVm4j6zlVv2MwuqAb+a0wwmxj8TjVN/oHI8=;
 b=ZkpuXdGWTdpOhBkc3H1r1jVe8e1WIf10UT0TWXliSwtSHxOeVkvLyJWg4/UJKl4kYg
 yNHZEVtcx1sh5r4UhC1tpEBmOxqNZv9zVkzusEk7OzjvBDbFAFOyfJVNsbm+tRg/Lscw
 Q+woWBB5uuAKJ/JJlBNonZXmoZCaK7tAxMLmHaJY9QqBTMBVDLSuoxcKOAJgN0Kx2RA7
 H2jhwoUN6GvKGp+chvufASF9kercDQAdTNrPgZ8p+mtkXNMViTjUbM2KHOrql87o0uLm
 dFn8qjIKRhYoe6zCqLnyNDk6Mc0j0xhdWUsswLmYOr4sE3yt6OVLNwhl/0obK0cDMjuQ
 WU/g==
X-Gm-Message-State: AOJu0YzmjkJv+DlFy++uO25BJ/jALREIKWPpY7C6EArqyfnuHlzh9bpT
 b8DvUsRe18MCeU+uRyA3jmOYaqI8G8YlQ3VEVVzopsjw3ok9Es9WaXFIVpn84DFJV6119BnYHfa
 lIwbrkefGaN0akKgAc6nIgp6N6kwJH7dNmyVNLyTJySzA9739JmtnkrkPNhVtuV7VmHpJ4Dk=
X-Gm-Gg: Acq92OFzuYSFGAbhoxwYAH8v0CQgIWelXL2m24qwySC6RO/YbbcfYi99YrWSF6XY8gH
 q1w0GN38nVQyVcimpEcdScr4zs8WYnCjsNCylAKFHPD/8o1aFOD6tm8PvlF8vsuHdTnDjlyN6Fw
 EoSkV8dFCSQDW1Pjv+8ZEo2ejliMeKGZn241iL2+yq2iMxebuKYckrJO3SlW6dRJGrP9I+w+SIa
 H4IBNtR9tvKFfI55qRrd9wohISX1MT56q4bnJfENRR9qMY3nknVQPbmzXePV7cQE+5tKltxMltc
 5/U3ovKoSwhExlkGWq8QIjsuGnVvC4/8lgHQjBuKgWduRW368c5ebO4VZ9AZFMhWGfLswNyIIhb
 qmj9+hSB3NjKBbQEzNKxzuVH0c8RxL51EuC5c2sDAoSqlOcxxxe6w4ZN3cVZtMcioDx7O+mbMTf
 fIARqpbSv/2fZ4CmHc1IXCHknZDimPlj4I8AEDr9cA8mRu9Q==
X-Received: by 2002:ac8:6109:0:b0:517:8a19:a461 with SMTP id
 d75a77b69052e-51795c56d21mr173338641cf.42.1780867996760; 
 Sun, 07 Jun 2026 14:33:16 -0700 (PDT)
X-Received: by 2002:ac8:6109:0:b0:517:8a19:a461 with SMTP id
 d75a77b69052e-51795c56d21mr173338131cf.42.1780867996264; 
 Sun, 07 Jun 2026 14:33:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2d5ea9sm40374041fa.32.2026.06.07.14.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 14:33:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 00:33:03 +0300
Subject: [PATCH v4 2/8] drm/connector: pass down IRQ_HPD to the drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-hpd-irq-events-v4-2-30b62b335487@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5290;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=A2PPAf8RIZIumN5Va/to+GsP1RDHctHNlwnN5DWn79k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJeOPllDTwWwMp1vESqk1j4UB0AHP5j7B5bL5X
 uq2IPLISouJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiXjjwAKCRCLPIo+Aiko
 1VlqB/sGaQ+sksjZm1e69F9eT9jxsXnLzH5/YZqYUPV74YSWdt5FApSzNf7tmIphhpE0fUE4LWH
 YozHAGahdOxwneinArqneGoOTQvp1aS5h+di+zQZRzeWHqayX0N7EXOGpaohwBQ4lC+hoBv/c8U
 YLVwGvblsq7oFWaEfoE8yeFhSDBDDkIGhIPAeyPRq5ZThVvChLMwD6AbWU6i+EtF/dr6t42Lvhz
 mHngSlPxsh/S1AoVsH3HstphanM+aA+WlDkXPZdW7t2CKF4cAZX7QfbWK3QPNP/frLMhRl0ND6W
 xAWtiViB82XxNOvQFNCDI+lH9MaGzXCY3tiEVgH4V2bJFjLa
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxNyBTYWx0ZWRfX9mqIad0mVAL9
 6g/pdjPYIBXMlOSHppI2EUy75hh4jfWqkw/+opstUAoVuD4UVxu21ksvcGhVbomM6h2IBxTmdC/
 +2/ylcm2069rRPWR4cQifD6qQN3WnwCfAwxUa+R4c9o9ykJNEl28r44vz6mqBq0uXJG6AjWGsL1
 kB7WR01WnvqIcZytFt79HgVnNcnmjdm6eevX8QCW5pIt8W4AdQVhH7KHyVOwJea9bAo8//4d1ms
 Cc3H4M9x4t7cUn7br3ng0GYMNROe2dd3/sJw83kdIGGxSvKTzU00wwPPN3IZVPRyIt+84iuDqvw
 FsxrIkM0uwJ+UMsV8bajMqtf3scYZQnQ+fyGxGAgNB6POLxK0P32GItD2k0d0aGXppKkzmp7j7h
 hktH0T1cC2BjikaTJtjUZkCYAkaqy3HWHSmsYTQJFAzTyOCzQytBo2LRT6415jzcvY+MP8WMAjy
 K9o85foUdll+ruTiyhw==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a25e39d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Uld_eVi5zExU9UbbJsYA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: ac69LBK1SEpkv8dm25T8ZuBO8rGYVMjJ
X-Proofpoint-GUID: ac69LBK1SEpkv8dm25T8ZuBO8rGYVMjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Extend drm_connector_funcs::oob_hotplug_event() to pass the
notifications about the IRQ_HPD events down to the individual drivers,
letting them handle those as required.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 17 ++++++++++-------
 drivers/gpu/drm/drm_connector.c                |  2 +-
 drivers/gpu/drm/i915/display/intel_dp.c        |  3 ++-
 include/drm/drm_connector.h                    |  3 ++-
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 649969fca141..046efd913064 100644
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
@@ -154,7 +155,8 @@ static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
 }
 
 static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bridge_connector,
-					    enum drm_connector_status status)
+					    enum drm_connector_status status,
+					    enum drm_connector_status_extra extra_status)
 {
 	struct drm_connector *connector = &drm_bridge_connector->base;
 	struct drm_device *dev = connector->dev;
@@ -163,7 +165,7 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
 	connector->status = status;
 	mutex_unlock(&dev->mode_config.mutex);
 
-	drm_bridge_connector_hpd_notify(connector, status);
+	drm_bridge_connector_hpd_notify(connector, status, extra_status);
 
 	drm_kms_helper_connector_hotplug_event(connector);
 }
@@ -171,16 +173,17 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
 static void drm_bridge_connector_hpd_cb(void *cb_data,
 					enum drm_connector_status status)
 {
-	drm_bridge_connector_handle_hpd(cb_data, status);
+	drm_bridge_connector_handle_hpd(cb_data, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
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
@@ -223,7 +226,7 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
 		if (hdmi)
 			drm_atomic_helper_connector_hdmi_hotplug(connector, status);
 
-		drm_bridge_connector_hpd_notify(connector, status);
+		drm_bridge_connector_hpd_notify(connector, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
 	} else {
 		switch (connector->connector_type) {
 		case DRM_MODE_CONNECTOR_DPI:
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index bb128dd0263a..d99019fdea9c 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3528,7 +3528,7 @@ void drm_connector_dp_oob_status(struct fwnode_handle *connector_fwnode,
 		return;
 
 	if (connector->funcs->oob_hotplug_event)
-		connector->funcs->oob_hotplug_event(connector, status);
+		connector->funcs->oob_hotplug_event(connector, status, extra_status);
 
 	drm_connector_put(connector);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 85d3aa3b9894..31acb3129723 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6990,7 +6990,8 @@ static int intel_dp_connector_atomic_check(struct drm_connector *_connector,
 }
 
 static void intel_dp_oob_hotplug_event(struct drm_connector *_connector,
-				       enum drm_connector_status hpd_state)
+				       enum drm_connector_status hpd_state,
+				       enum drm_connector_status_extra extra_status)
 {
 	struct intel_connector *connector = to_intel_connector(_connector);
 	struct intel_display *display = to_intel_display(connector);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 105da7c94910..5784bb9c4021 100644
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

