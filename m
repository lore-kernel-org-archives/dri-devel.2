Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99A7606A336
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zg3PiU9q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KLrYBgFe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48011112B63;
	Fri, 23 Oct 2026 13:40:38 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4344B112B3E
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:40:18 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAkgf981044
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C+3I/2A1U+Gp7I1jsF91pZcgO5n0gv+qfSKmmUyDmWI=; b=Zg3PiU9qK0tppPun
 NsspjomwNbA7Q3M2FEW8bViXiyhEwTBhewpJU1QOtdz/9Vq6N/xGDk179SBHhGYd
 z2b7OXKyxKFr9eY6lud2eagqwV7Pyq0x8dsik6CzOszsefGpWji4GLyWZgKJRJV+
 KisIhC+SwX63a/RXDx8Y2wdc06OSUXRopsrK5KdjEjtMBXIcojsdDwayUhphPCj1
 7Rp/YEUHPVgMXRxH/HoXb/RnRewYY31lJnnoUm7N6C2n3evmS+7VZ+K0BORCjalS
 VLG+hirHdGSM7O56TQcyyk7zdj6WSM0NLNPJ0qkux8AYn6kGpQZVVS+ZNvyJPext
 rUYD4Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmaubnu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:40:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb6391e89so195112885a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792762817; x=1793367617;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C+3I/2A1U+Gp7I1jsF91pZcgO5n0gv+qfSKmmUyDmWI=;
 b=KLrYBgFeSok2RK1Z4S8f4RJwivL2LnSEIngoRGDpUPwIQQ56sZcSeAuNoLlGRhv9+L
 iPRssS19peOqW4VolIPGtl954Vl3rvhr8GGO6jK2cPgEYe3ugW1IH0Co/hSsDMZKvjvX
 45wglDovp1kLM9bqx92dpZdPaTbV/8INIFm4wgHp0QqWaZKpwmu4vb48iJVoHIy5O8az
 tSHrRc3EiCZC4fH44Uvr2/+jdbbQ3yhZHPTWxgPZDroPDwLVJFWr1X6XHyXiiv8oP57Q
 Dc17XvsGmVlYDb7sxtPg+zOsp+ivLjfdAxn7yQEYvFFb4IJbVNvNkwy/GSIY3PC4trNk
 ADSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792762817; x=1793367617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C+3I/2A1U+Gp7I1jsF91pZcgO5n0gv+qfSKmmUyDmWI=;
 b=OBYpkY99tLq3lUBF3HIaisZk+6JoFvPH2zw2C8VatxClKyZ21Nz6xRJHm+nYw5Ltir
 5JS7FwsvNYTLeVoSu1vpSOUs+SRqJtiSiMQZ1Z0iw4BNCPAdTiiQ2v1A6cbHRSrz9+gL
 PtQyzPNzxKNyJAkB2oauMOylwOc4E5NgHzPsaSAIZIp425MMedP6ATsEUsND7hClUVwC
 HROygdToK3gwPMz/Da3Y0+PFlpuPldWAHETiDBoR0PTz79Voeza+nB9Bu0wrQw4q2V7c
 UhW+yOyvgNQ0TYcWDxJGBgEVnubeU4RM9oFmB/1e6fV9m6XYreZkhnI01AcAI9xKMBoJ
 sMWQ==
X-Gm-Message-State: AFq9FYILKsimkXsIGd0AhwjyTi2+RnARrg7xiJk4AIvc5K+rl5zWlt8s
 UtM7u9ymOsZnk/JHAtUtyLTUPwNcFgS3+6hli745LT/yjipUnAMWvCogk5XXqi4owGaSe+rbhyO
 huqXvBfLqdwsqIuzyXSEVS6Vfp3im1+DmbMe2CDW/9sMen626IixdqLMIJYB9c6mmj3oStJM=
X-Gm-Gg: AYBFou3KsO23PSAdC3JbTUljrpuYOU1mdHTSjIut6KH0TavjfXLb5aDKzYzhI+NxjfQ
 uWGeFdojtf/38WFDaQZ47NH9gfk0ttyRnyx+iGyJ6il1M8nWD9NXbGYeB6esL+3NfQdiDzSDq6f
 6kAE5ppvss2YzDzT23rDOye1V3ZnQ3Uc4BQnhVJAA00ovgdpIaBRR1fHJDYTRtfxHyfxlvnynUU
 hRBCPK04xoHCSynHUMt6Kh5qzXqRfx5O9u/PB32k03LoEpuUbeFOUuFfA0S/B2zLuRHhKGN60VT
 FJmEwNBmpKbt2D6/DFUCbpKaB/tOKqp5Y1HvA2gDUH7edLIeBIvDKsourL5RXImvTBU8rwyKQQu
 dm8pvwwusKeYvngnGLOsAhtwxR2ezFHkAsW1o6rLczrBQEJnQO+WzzBsRDGKoaJ/TbqGYaJpxwl
 xMC7ue6lyxVa2W
X-Received: by 2002:a05:620a:470a:b0:93f:2d10:ea49 with SMTP id
 af79cd13be357-93f6f8151d0mr410841985a.45.1792762816443; 
 Fri, 23 Oct 2026 06:40:16 -0700 (PDT)
X-Received: by 2002:a05:620a:470a:b0:93f:2d10:ea49 with SMTP id
 af79cd13be357-93f6f8151d0mr410834785a.45.1792762815720; 
 Fri, 23 Oct 2026 06:40:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac65ce14fcsm5309701fa.7.2026.10.23.06.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:40:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:39:42 +0300
Subject: [PATCH v7 2/9] drm/connector: pass down IRQ_HPD to the drivers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-hpd-irq-events-v7-2-57a3aea3f09e@oss.qualcomm.com>
References: <20261023-hpd-irq-events-v7-0-57a3aea3f09e@oss.qualcomm.com>
In-Reply-To: <20261023-hpd-irq-events-v7-0-57a3aea3f09e@oss.qualcomm.com>
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Francesco Dolcini <francesco@dolcini.it>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5315;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=EorsOQHW0H0nqzv28S1rGKOICW2UJpSufyghXnThB60=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq22Om//UNyL0fPhmHrD6nuKbi2vX3GDx0s1bTr
 hXsC6vJjfqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCattjpgAKCRCLPIo+Aiko
 1ZdYCACfUyt4MtbHR6/ige4IwYp4trmZXbGoAwMtHMMD/UUH5j+5B7lEYrOMjoRsyPM/XHGlOKd
 KrJ66djgMsBcMB7IPANZGY3FqaAwnvTYLklmj7WnOPSgu3roa0DyVJDTf9hG0yTfv5GKiDbQ8Pl
 KmhArrUvjAOC6NlZmE37M1IGxwF02butanpr3L5qsTjcuO3s71a6a/npS6k80fLUVrGMEYea2QV
 NWGFdXw/NUM92MRh8HK3KyD860qCSA+GJ+WtCnFR6Hy2D4nls1AdzWrq+d9Ww6UPkZMgFO7FyA3
 3SVzSOu0HVBdTqlWc59ycZoxM9LHd/p4JO2Ovjobd6LGAZ3h
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb63c1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=DclysrjFOTLD0Guyi30A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfXxdtmI4jzuycO
 ykTXmPR78MetiWbP+G5ldEq+T3308Jk1u6Qi7yAs4MLrCpozKOz7eyDgRkBUuT/f+mMk3TK/Y7o
 +uZT308ENvsv4wgzNlYCBblqb7FJICQ=
X-Proofpoint-GUID: Bm-jHKSG1pim77bqHNHEvJOzCuvYgCso
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfXwIHsWERNshdB
 QMuTbmi3frDzbnyQCguPPel+WtdgafDg7uRPz5BB1/pDA+gNSpZ2iASfiOKwVI4HHkUlW9Gd7/b
 MnedatDRkZUEmqq4uAjWeM4XgtwuSXYye1bi1DyxvMUK46bqPlAM9gMtjMNywnq4LnZKynK8PWR
 bUhCJPlmmuCagJcowMxgv/hgRdrNiEsaplvyvTUFqKtBVGdPq7Wg2Fq+G3LY1xGWxgpH5xFkLHs
 lJLb6ttxh8yodXs/xUjmHnittRM812BzATeDabf29ey06LGRMGr2b0Rupxqpsqz+i3iv32/Uwx4
 IXIqbdjoZSjeyVoWEwdm6fwsl8VQGik+VeUlPnypt5mVHF8qkDFr9a4xOXcx8QrBTVJSOhrXxr2
 opyv/EfqjoMJ8vA8pps49qxK3DDUeTpyOGzGZHp7H9Fb8KauxZkn87OAMrd1BEcWizN6gLllw2u
 HYR5tuZQT8H1JKpCXmQ==
X-Proofpoint-ORIG-GUID: Bm-jHKSG1pim77bqHNHEvJOzCuvYgCso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230053
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DisplayPort standard defines a special kind of HPD events called
IRQ_HPD. These events are used to notify DP Source about the events on
the Sink side.

Extend drm_connector_funcs::oob_hotplug_event() to pass the
notifications about the IRQ_HPD events down to the individual drivers,
letting them handle those as required. Bridge core is converted in the
next step.

Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 17 ++++++++++-------
 drivers/gpu/drm/drm_connector.c                |  2 +-
 drivers/gpu/drm/i915/display/intel_dp.c        |  3 ++-
 include/drm/drm_connector.h                    |  3 ++-
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 81f3e26f6fdf..898273f60cf6 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -142,7 +142,8 @@ struct drm_bridge_connector {
  */
 
 static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
-					    enum drm_connector_status status)
+					    enum drm_connector_status status,
+					    enum drm_connector_dp_event event)
 {
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
@@ -155,7 +156,8 @@ static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
 }
 
 static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bridge_connector,
-					    enum drm_connector_status status)
+					    enum drm_connector_status status,
+					    enum drm_connector_dp_event event)
 {
 	struct drm_connector *connector = &drm_bridge_connector->base;
 	struct drm_device *dev = connector->dev;
@@ -164,7 +166,7 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
 	connector->status = status;
 	mutex_unlock(&dev->mode_config.mutex);
 
-	drm_bridge_connector_hpd_notify(connector, status);
+	drm_bridge_connector_hpd_notify(connector, status, event);
 
 	drm_kms_helper_connector_hotplug_event(connector);
 }
@@ -172,16 +174,17 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
 static void drm_bridge_connector_hpd_cb(void *cb_data,
 					enum drm_connector_status status)
 {
-	drm_bridge_connector_handle_hpd(cb_data, status);
+	drm_bridge_connector_handle_hpd(cb_data, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
 }
 
 static void drm_bridge_connector_oob_hotplug_event(struct drm_connector *connector,
-						   enum drm_connector_status status)
+						   enum drm_connector_status status,
+						   enum drm_connector_dp_event event)
 {
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
 
-	drm_bridge_connector_handle_hpd(bridge_connector, status);
+	drm_bridge_connector_handle_hpd(bridge_connector, status, event);
 }
 
 static void drm_bridge_connector_enable_hpd(struct drm_connector *connector)
@@ -301,7 +304,7 @@ static int drm_bridge_connector_detect_ctx(struct drm_connector *connector,
 				return ret;
 		}
 
-		drm_bridge_connector_hpd_notify(connector, status);
+		drm_bridge_connector_hpd_notify(connector, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
 	} else {
 		switch (connector->connector_type) {
 		case DRM_MODE_CONNECTOR_DPI:
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index e3c8181df6bd..90e27d0b165c 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3847,7 +3847,7 @@ void drm_connector_dp_oob_status(struct fwnode_handle *connector_fwnode,
 		return;
 
 	if (connector->funcs->oob_hotplug_event)
-		connector->funcs->oob_hotplug_event(connector, status);
+		connector->funcs->oob_hotplug_event(connector, status, event);
 
 	drm_connector_put(connector);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 0cd5e6b5034c..911c3b269279 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6760,7 +6760,8 @@ static int intel_dp_connector_atomic_check(struct drm_connector *_connector,
 }
 
 static void intel_dp_oob_hotplug_event(struct drm_connector *_connector,
-				       enum drm_connector_status hpd_state)
+				       enum drm_connector_status hpd_state,
+				       enum drm_connector_dp_event event)
 {
 	struct intel_connector *connector = to_intel_connector(_connector);
 	struct intel_display *display = to_intel_display(connector);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 4f65c97a89ae..39814f10fcd4 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1974,7 +1974,8 @@ struct drm_connector_funcs {
 	 * has been received from a source outside the display driver / device.
 	 */
 	void (*oob_hotplug_event)(struct drm_connector *connector,
-				  enum drm_connector_status status);
+				  enum drm_connector_status status,
+				  enum drm_connector_dp_event event);
 
 	/**
 	 * @debugfs_init:

-- 
2.47.3

