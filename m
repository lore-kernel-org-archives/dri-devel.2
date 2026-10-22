Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56C606A338
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M5DcHFsD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c+6fe3Fk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907CA112658;
	Thu, 22 Oct 2026 13:28:36 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C884112638
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:28:21 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MAhpAq4102394
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C+3I/2A1U+Gp7I1jsF91pZcgO5n0gv+qfSKmmUyDmWI=; b=M5DcHFsDC+EL8Mkb
 k164l2UnqbYDeXD7sYFe3zZ1ZFexpDf4Kehgy8W1M7DowBtZHzqbQxiu480Df5Sr
 58G46/R9IeHvJl1xCQDw+lQEFSiFaBCWrZGOjjcFn7/5pQ2ihn0c8UReV6pqO2iA
 x2H3g1abdamEIN3kuDeOA1qZCqXJXIYC1rFrtDeXW3n2VMFAugKkF9I43I4MyQpE
 CJSxnmjwGLppgYdiFV9Zwf7JTeBgr8AO5Spg7GGlHd6xRXQ1yumdqUXugaHKhkis
 KtYypKgRDBTKLIkifLi2dUaYLJ7gTuaeQa3V1xwpUi39udR/DonlWwrjpe6a9ToA
 NS/aTA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93cbrjg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:28:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934956beec8so405299885a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 06:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792675700; x=1793280500;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C+3I/2A1U+Gp7I1jsF91pZcgO5n0gv+qfSKmmUyDmWI=;
 b=c+6fe3FkrCYgMCXUhMjkvJLO8S9PeHPzK7b/6xSgDTtETLJSESw+Ksh5ExOSMAWIWz
 zj1UgLBHjA2b9AGMz2qO5ZgmIbBfTJiUvUDpt2gUs9DFQs8uQgf/NobZhDPNxAmhpBfn
 dtRZ33YIbcoNY1JruVJ+NOb6B+LNL+d03s1/DuSREcp8g5gFQn/V1WsTctPQ7RKGlXC+
 cx2HUsb37wP8AakWfAxJKijI0c8QsAg0Bmn44XkdgT+cTYaJ4c0arFDfCA5B9/vY7d0Q
 hXw4wQNKawPIRQvfMaWko69GtlHnHmN/J+BhaUx+Qrjz5oC2d2CJ7nyt0pQpUb6qds5E
 WjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675700; x=1793280500;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C+3I/2A1U+Gp7I1jsF91pZcgO5n0gv+qfSKmmUyDmWI=;
 b=1nODWvoDnDsmRy4UiPGCW7C2Gfep8xLAQisw1Qzx84SJXdED3zbYb+AK92tifVWunZ
 KjDT0R1ZQbzJtCoRGhwgyiaIgxYumIdq01ej9XHbA7ai9ZuFARmaEHSkUUjpFRVQnUB5
 +j42UkjA4x10ZHYi6vL6WpIfCc6qW7itP5FQFLhmLW/CihYF9tu9MoGZ10B1OGuhDylG
 ZgbBLUjmJho0KvUruarn30ecEpe1oIuejs+w6myPYkkU/cWCLO882xbXy1e5H/co/dp2
 R8TZM3KZVgWlswQgV2TNJm6SLaU9zCCFYv0485nD2Dux3EYBY8iQjj0kSEsa4yyMTIIp
 /+CA==
X-Gm-Message-State: AFq9FYLu0I5DQIcCDSLUSfhsKWkWilkQvjbK1PPKU2DIsZwierJavSyl
 /CS21V1iB471sC540gEK2brLznj6bRkWLIFlXNHJQlRXrWr8+2K7CbPJdySRY6cTCbged0zOvw2
 MTihAz46hVU3xYZCqp2kmG/xRQN2HP52A+apsY+bzq5OF70EpRv4QFZPryfrTvPgRSd6tahk=
X-Gm-Gg: AYBFou0aJDI2uGlyErgpYb8iUYTySaWqWAl7AVdVVwptCrco7Vjd9eFk8WuWSZv9/sT
 z2FAYCiZ7Auigyb3Nt4lk/Et+kk/bQ7m/jAtQOK5F0kcmRT/ZSFmHfFP/46exYfpOmNCBSeZgxw
 RiabqBMhVZQax2idFy9y8ajYmfhrSACVROkrJKnXwkqxOwEXgEAXosWlM/PincrKiL24qwll4oX
 6FcULMdfr2vKiXbKfxC61nZoL54l6VjFdzC4AYJgHINZ5SXxSswDcjn5JM6zvIvoMfnq6kplHW4
 Ya4F0BZlcQMB0OaUCibaBQjDRmEM0JeTx86Y0FNmCTRpi7z0iSYRmXZPS/t8xp7LxYfsjBtNiSL
 yzgae4UJfV59hQvh3raDHQHHRueLnWHG4xVXbN3I9yp8+ZHeVaUNbkaOLDVuyTY6plqg0PanpQi
 P+czlO4WX7CZky
X-Received: by 2002:a05:620a:6408:b0:939:6de9:4cff with SMTP id
 af79cd13be357-93f57f3d80amr951087285a.45.1792675700419; 
 Thu, 22 Oct 2026 06:28:20 -0700 (PDT)
X-Received: by 2002:a05:620a:6408:b0:939:6de9:4cff with SMTP id
 af79cd13be357-93f57f3d80amr951079285a.45.1792675699899; 
 Thu, 22 Oct 2026 06:28:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac4f6683edsm8762201fa.22.2026.10.22.06.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:28:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 16:27:57 +0300
Subject: [PATCH v6 2/9] drm/connector: pass down IRQ_HPD to the drivers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-hpd-irq-events-v6-2-337ea3ddaa62@oss.qualcomm.com>
References: <20261022-hpd-irq-events-v6-0-337ea3ddaa62@oss.qualcomm.com>
In-Reply-To: <20261022-hpd-irq-events-v6-0-337ea3ddaa62@oss.qualcomm.com>
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
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9Yt/hSzFpHE6ev+vJn//9zUP0H8ontkeSIVJ4sXfporv
 CZgVUNcJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmwl3K/j+ENcuEteD7on9S
 j+81h/AWqFyzznIP3uBqN8nG8EjUrlnhk+bZ5s6ecU3jb3Xqp89vU2+yrGk3K19kb6LJIJ7qFcK
 idd0sL7tImefD4i8ybw8Lx+tqPv9YfTVsLZ9+0/TTprn7U4oLfyxKTyi+sdJlVb219rJXGus3nL
 kps1T8hEfTnPtWE03tv9pp5VzwZcnRbVvZN11mv3nJXUb+6+ue3eT/xpleUxq2l2ERc+vNrLqno
 uq+Mjyr9yguaLWZvYNZ/YxHQT6nkbtX2esXB9nNxB0POd0qb9Q5vvi9jKKO5/JNLkHf9p896G7N
 Uc3NbtyY/8v/sWnA3kNTv/FtXCX32+Kq1/tjn+wbdVRjAQ==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1MyBTYWx0ZWRfX6BmVBJ7tOCTl
 idaMLz5tVfcDVfhaZVowxxpUgpVssmCqo3kGQKuWhaFDH0mXfymZJp5v2t7z1GLUj36D+Tl6y1b
 m3XLzvhhG6hDGcrMioFyb87grXuA3LU=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ada0f75 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=DclysrjFOTLD0Guyi30A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: yMUqavJt58zf_WAZsZBbIOW9UWQEfZVY
X-Proofpoint-ORIG-GUID: yMUqavJt58zf_WAZsZBbIOW9UWQEfZVY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1MyBTYWx0ZWRfXzwoHTsGp0+s9
 6SfLjebDRqOgcqXbA3lv7SfE4o8adhczao9uhjt/2PTJC6Ma8+zZxoI9jqEvQvgoDBI+NRUxqa+
 /HyPiJjtYv8IfFNKYgkmVJ7s0Qq1uw/OUDMM4lyHItpwQN4weWQGKR+aVOKWGkq48qZ1oAOxvme
 Cvpand5UGzVMRc7PJ3Dax0pZa9a2nvdSF/s+2GTG17dbsYzLx2VbEpqvKrcI7l+PEy+mPtIPGoA
 BbR9bXkZW20nPvs2AkenmjO5MNwwDwjmb+BtBip98h0oiy9uPciNzqF4sHntQdI0efZgfKQ9S6U
 IJqNeRXJ4gI+T/XiHg5BpvrpxLpW/h7eF3oflbPdB+24wdOCaYGIoYk2BaWRfX9VGQrFrUKE5Hf
 n3Nv69TKzuHHX5juU5ywuZ4FSAszRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220053
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

