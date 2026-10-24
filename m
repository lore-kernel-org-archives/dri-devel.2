Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101E606A325
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ReuGjFdv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RMNsH26p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22586112D54;
	Sat, 24 Oct 2026 00:36:01 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568D1112D54
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 00:35:49 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvPlF4027107
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 00:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C+3I/2A1U+Gp7I1jsF91pZcgO5n0gv+qfSKmmUyDmWI=; b=ReuGjFdv0Hrpztut
 yxC1lHP6EzBYxoEDj8WxTxhKWi+GZQjDs06NSw7K8JyweibefUBuDm/kbdLLeMOM
 /Qi5I0jb3oFjHjtwpk9gme+XP17dfzNDGFJQ/dzY733W513O0iszC8wtJ0ihy53X
 MeOyOsbjtRTzEfnIERh/1WFU9ytPZ8dwrc88Bw85XCFj/yYqpxVL8rytc/oqHIFr
 M61gUjpgss2No/7pmZxU7qp0U+EP27TXYeJiVvwur3c9+IErKX0L3IiIntbSA/R0
 qjGK/Yvaa4zMTK44b/hc+iie1TUHquIk9MYBZwy7MjLwFnaa1LoWCLp0s33yuuWb
 pAkUmw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcs7h1yw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 00:35:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f6f4fe531so265303785a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 17:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792802148; x=1793406948;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C+3I/2A1U+Gp7I1jsF91pZcgO5n0gv+qfSKmmUyDmWI=;
 b=RMNsH26pwLhDBrC02TzGTExcPKUPJi0Gv6rnWfV55rRtSVqGS6AHuELvxQmsanKzlk
 SnGY3Cq7hamPQohzRGkpYNsGmhx76dtJaQCCHA/+2po2S312EqRF8nRmM/1ckKmAnnWL
 0T4SoiR1/cLRIaQhRUTA+WKtC/jWBgVgmm8oOk8hN275lnwHYXaMTjbbBL3m2evgJepg
 Np/iE92VTRWfIALShpT8tQAyTVZLkWtvlrGHWGogtNJ21EDiwUlpc9keflw887dEIUtX
 vdZI+kp0SFGf2WbgNdEtHliM+GetaU+xfzcz26p+BblxfNdiPoHBzn/9HJ/OFf7q4qtu
 oXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792802148; x=1793406948;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C+3I/2A1U+Gp7I1jsF91pZcgO5n0gv+qfSKmmUyDmWI=;
 b=XpYP9l7kTGxdL1ug5x+C34o/plIkeIQvrkY4flXmagp2zeaDWxEIucTUIDEKe7nlq8
 4eGdBk1IY0bNbipJ30ft1I+qhjVWth4KD8mL7MUkxyCuoWaFV/sy8u5KwdAlX0ZQy1E6
 x05v34xpGs30yexA3AbY9g4jn8XRj7M3xnxht9XmxDPHuBCwdnI6M7HjpXRoGJ5C+0ql
 xkva14xusWRxxtoin+cddP21XqWxGz2oa5E/nO9Ia6zKrNADJBsb4s4K1+I+ekeZetef
 f/ReTupHp5qeuoXa45yGuKqsT68ewTlzRMrWJJDnMYwoAMJyY+7gx3F+XkkoRPcbYkfI
 h1uA==
X-Gm-Message-State: AFq9FYKSUeaPtaU2flSgpiV2dRHdjOMgPznCpjq71qjdTNGWvPkSPQMW
 gU9enphRaW/EnzvMMlqVR5u5iP4xaZzEzCnBEdXRG4VqgZRQvwRk7AigpgWkGnxTa+EibGUMDru
 yVUvZcC67XwePUCwkfD/W2wBM/sUib+E1KuiOAdNfyObCbgzsCzelrZhsjP2SpV5RLpM4WbQ=
X-Gm-Gg: AYBFou1r2fEuMk/R2ydFrUtqDfUWWMYWZfuSOQt3Dz0vTO+LnO9QZ4WzLb7gRicQWdB
 sIyIaGuEyg1xmBiwHZSoOaQ02G30ydj8Cb2ezHiEWQN8PdF4nL6Vp2VTIScOnBHF+ggyQHr+jms
 zVGsaoZ8Ywz9DwqqEV67UT3B8xPhz/KQWU61yFtxB1/sNCeBLHhlGQUaOoTfMYf3J8yc5D9BPFO
 liwa2M+ZFwGenXn/lfZZZd7pAJqjJWCA1gyJoiRNBgBd4A4m+bTLpthl7xzN562wFbx7KOScvST
 3qVZ0Vo5TlvAHwoQG5iFjidfNfwzp0QhQyctf5RL+L0WuB+9w7UXSKw9N2rIa3YL0PqdMSFVDsf
 BSSeyx4Ib4KOOLsIlskMs5wI/jzqkuCRUik9CvcmdDr0glZqh6xslgQDbWVgTgFCXctdGygM5lb
 8/NYkKuFT2h2jO
X-Received: by 2002:a05:620a:370b:b0:93f:19fe:e6ca with SMTP id
 af79cd13be357-940ef939794mr102379685a.43.1792802147639; 
 Fri, 23 Oct 2026 17:35:47 -0700 (PDT)
X-Received: by 2002:a05:620a:370b:b0:93f:19fe:e6ca with SMTP id
 af79cd13be357-940ef939794mr102375885a.43.1792802147137; 
 Fri, 23 Oct 2026 17:35:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709d1cf7sm1126651fa.15.2026.10.23.17.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 17:35:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 03:35:18 +0300
Subject: [PATCH v8 2/9] drm/connector: pass down IRQ_HPD to the drivers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-hpd-irq-events-v8-2-6ee949e7a384@oss.qualcomm.com>
References: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
In-Reply-To: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2/1PEfQawOxcIPeQkTw3Ahbduv3n8MRID0UAN
 lY/P0w9/IGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatv9TwAKCRCLPIo+Aiko
 1YUHB/9tSxiaO49rIuYE1/it1nSy3oti+R7AeMvMDMfZiv9ikIhv8pNAkhXiSvwEmMMJW5yoa6e
 87vDylIusweUO7ajtlFct5rMYJSrD3u0Vnh6AuDNX3x4tGsdS2HThrv3QyLQtusxuYuxB2WjThM
 oYb4kRN6dAtPuCKl5vWij7/JN/dtpvYS3/ZBySxOrpLeiCKvS+cyMuR2OUSmpCpTEhobFS93XEx
 AWo/gjkuBAX0MzwDP/2sVdtWgioQaJpOTdngvcc7eva2QQuFTa9mdXj/LwgN0/GLBjbR/odeImX
 ZxMNtOaYpIkKbt/F6UWjooDUjgSW9nsHStYerCxrW8LV5yIj
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwMSBTYWx0ZWRfX6ANONfMhshui
 z0mI78fBGLyQiuwRKvciXcUxQxH3vN0eHP4dUO8m7++qtBU9ancQe7FHvpbC1w/GHDeKO/fkGa8
 tmk/YQ77K2q4GZA0AMbQuZHvpkhF38Y=
X-Authority-Analysis: v=2.4 cv=XJCl2ghE c=1 sm=1 tr=0 ts=6adbfd64 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=DclysrjFOTLD0Guyi30A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwMSBTYWx0ZWRfXwhoDUiA4QYas
 dYPhduj1bFKW6z0Nio4yuNNB1+m4EkCMpz/WxUhSnar6BSU/ks8qeEF9+F8umE0KPVmiHZ8VTQO
 is+PoGoU8Zyx0otyoaLiF34jayTifEjfTc3DobVvttIzFHUl75KFRK0I9vq/B1O1QypOgF3qaj5
 rL5GETL6nnEVCIeJy7KQQsNibyiXab6VqTPknsu3liI6k6eEp1X1+fuiDPVC2iQ9a0r5ewgiFGK
 dlmNktDpd/9ekt3m9Ju3bFpuLVAt4ksEFpa2OC5LeKUG39y7aT+xGI1DqpkDAd50yjWvMfcKtiH
 BHENOa1MX1fLdd/Yr6jDieMtEZhdTyIAQzSYdy61fhjKojJOSVayfIiavzPhOp6Tn9WB08/UQtA
 cUdbcZUs6PwiptyAx/QnXrOiWvd+sgW6zeuIeIXdDS0Yf0fSuIUftv8T+V4/AMWuCAbayvs79wV
 eQQ7n4tq12atpy9r28Q==
X-Proofpoint-GUID: fULt8kZvFeTHDLq76b006GsoGdieV72Y
X-Proofpoint-ORIG-GUID: fULt8kZvFeTHDLq76b006GsoGdieV72Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240001
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

