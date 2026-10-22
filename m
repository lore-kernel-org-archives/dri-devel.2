Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91434606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CZeVLEBj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Is60KP5d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D278411263C;
	Thu, 22 Oct 2026 13:28:48 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEAD11264C
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:28:28 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MD3as2271943
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Hdqxyn2F/krFbhfo7FhJaA24z9+SJBSeDt9UzhP3juo=; b=CZeVLEBjvIzXrdp6
 zNw2wVWiVgTpKCuap4rZ8nsMAD6kvXwxI6y7tAIpX9cFwskWJuBu4UADQJEcuFxR
 U1zWyh1NfibE0s5kX7xA/LMUmfeXap8Jz956NFBzEUUYH0lCbq7uuXxoL98J9SDQ
 ZSIA0q8ti6SVppbUHO5aXVjbt/eaTaZE6UISVh1jpCN2QCxaietQCgoCFD+6aAko
 Vc+bONyAw/zoLfxEvtSLaLo8sy+qqpLljUOSYKJYVa7OO8yKjaIgyfGXVleoC22p
 MZ1Q9OzwT4IlHXhVjGXqbpac21/MjbeSwpbD4Bu1999+rVbg1iLAyf0PXX4Ju0JN
 lF+8lw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93cbrmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:28:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so410510885a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792675707; x=1793280507;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hdqxyn2F/krFbhfo7FhJaA24z9+SJBSeDt9UzhP3juo=;
 b=Is60KP5dTaw5FxoibYI1TkBbbJudu8GckJiZYiUcldV5piX8ghgg3gqibdyRQse70B
 awmNVsLFxzTi1tysKoujNKa3ut+nENtoXZhdkltMGLh+BWMJobYGf15tHDt1dbx35Cnt
 MjAGOF2q1wR/CxhoDQl3t1T5x9PlKB2WoX0pG2AhrgG1qctxfISD7KHDCaTe0JZHzCgg
 oLWZw9az6dfnQGNCrasIisaM5LjpElNV6Sw64MusNuJ7Q8H3orUgo6X7fGG4ArS3qm01
 rP4z7HVkxhfxjSWDZMGdcNb35qIbS3OWPgjK4i6eh7FY9YwYjItdpAIkPQfczPTpy7zQ
 UdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675707; x=1793280507;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hdqxyn2F/krFbhfo7FhJaA24z9+SJBSeDt9UzhP3juo=;
 b=Q5ldyF7cC81S45zNnE9xz5c/j7zJsoNL2aWff5pO654eHYEbtDKMt+RPEgcpTUMFdu
 lnKtBwBu5exV6+C2n2vumf2BFFXkYvpenvZsVMJha9Z4PdhIy64yFUIR71iM5cMj5Iww
 Awl3ib5W2waPosi8NnP8neSTXRQdp6QTWlXVSYwG4TKEjxrGkr+s5abA012ffi0/hSu5
 lM011XPnm4JHG5mbq82BFOjtJ5L608vx5IVIPGtgC9Fla5ECB6+pg34oHyNDXN55HTFd
 /Y9/hiUECCLvB/0zQtoSrXE2maP28zRZWsSxWzX+y/o+QjoYsfGjLVjMY25bv3goY2j4
 XDdA==
X-Gm-Message-State: AFq9FYKoY1W8SPUhedgGKC0hIhUESA9mXS26+0aLP8vZMGlfknWtyNJw
 DlTawL0Y3jr9GgMX5HVmQ9qbF9pNlUcbqC78zcCzO4przWh9rCjZgwydRr51OT+L3/KSPpn0yQR
 bYsznttHM8/3C37ZM5Xwle4sjwWFwGugknmpqitQ+OjiU3o0/dW1M8JknYelBS/+7xiAeITzdBP
 M6VRg=
X-Gm-Gg: AYBFou2xQM1QRvKFsV8Z2NVnPJMZSziB+xScLczHq0odT+EylaBnY7hQ4CC62zxIgK4
 JpI7PA7YIp3YfdOfe8sSJm+vPPATUn+weocX7gcPnhZl3Kcz2xNER3+ai4YnaKsUSqDNdAdakxj
 hy7FB/TMW+lE+/RgG7s/PTHPX2Q0xReiDacBhelyswrKfUHMpGn6zbIGMW8AQegYlh04RU5Gmjt
 1iMizn5bvvxCAvpgXiUL1mKZsi4Em5qnT6V6IKoDWeY1gmGi/nIFMgI8P7MbBTBo6lQt9OopUzQ
 m6MyA7CmY7kf1POvE2B/4z2TEL/Llhw/YYAm3X/R5qS5DJzcoXpeMfrQJG+9ZHuTHyM1u5b9/Te
 /DLJ02hOlJxXPi7U5sAM+fira3rjgQQioCPiPxK9q4QDUN3XqmgIYP2I4m5qOYll+krrI5/INmB
 WYQJgq0ArUPujs
X-Received: by 2002:a05:620a:1b86:b0:939:b099:d52f with SMTP id
 af79cd13be357-93f57fa0c2bmr964764885a.20.1792675707167; 
 Thu, 22 Oct 2026 06:28:27 -0700 (PDT)
X-Received: by 2002:a05:620a:1b86:b0:939:b099:d52f with SMTP id
 af79cd13be357-93f57fa0c2bmr964757285a.20.1792675706572; 
 Thu, 22 Oct 2026 06:28:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac4f6683edsm8762201fa.22.2026.10.22.06.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:28:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 16:28:00 +0300
Subject: [PATCH v6 5/9] drm/bridge: aux-hpd: let drivers pass IRQ_HPD
 events
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-hpd-irq-events-v6-5-337ea3ddaa62@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4192;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BIcHzWfG5902z+M7u42M0vyUpcn4l5zulhIbCsx30p0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2g9mw1u0Qd3LxnGa4XtQ4wMod6I5wyqNjSx7t
 HCKz5kq/4WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatoPZgAKCRCLPIo+Aiko
 1VRBCACUkpGMPsojQ3/lvQ8NRygF2i1lg6dnHEaRu8EQVPRRVWIa53q0uMadWWOGZqz0KqyGsi4
 e3ui4UA02KecreOJWaWscbiD1o//uWQlzFOv/6TEua08RyqDy5I5/1sefYM3Fr3LRPl/qXmA1Dw
 qNsQZyPGy+bei7bgQKZoVGTa1qbtAAfLFqQy4lLrjdsma70Dtowl+OmBmq7NdNH1SsFzQUosJ7J
 77O4afqIMKLgcq03RDbuMOdMltfXZRflGuGUM1jRUYO4qMY/BkpberJF0/5UheSZaZQJ9ZMBVj8
 tIbuROk2cB61iFAkifJ9LQeJdEnnEOVv/pbf6WMLnnRXao5B
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1MyBTYWx0ZWRfXyKfUvbiziTAz
 Sp/1R8LRGT8hhClhqQaSIkITqiw9UtQXuC9Ng1uEoimoZTgTNJboQ0RgDlfRGoC/J3zCxqE85Br
 lLJB44WGj7bob953wQGz/A3diF6fRCI=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ada0f7c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=8Y3P-FUPaDH5FmT9qQkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 9NEBtkTHWKNV4EXqhLaDWqprEtN8wOLx
X-Proofpoint-ORIG-GUID: 9NEBtkTHWKNV4EXqhLaDWqprEtN8wOLx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1MyBTYWx0ZWRfX2/Yq03KddrVK
 J6RSuk96xMvME/JjizkDKvX2lXKMW+DglYgIrwGbI2xteSzj/AVv+F28JLfM2gfpqNstDb061IC
 eSfLpRJGMlyeWC2H+nRgUHXJGqGgKMTPMEV/fdmGbfUPxxsxugxJ10c9OSuR3vOF6g6RXxEHRiY
 JPdd4GmiZezhDnyvNUTyxfFJVwe7JuekwZcPns/nNHkRYxtu1hPINgdpPT9BIJ4EME6VUeG/VHe
 l7/Zbcqr79x+AS3I4EtFGof6izDYOZrgHNpDJx+MkbaQor3bJcJsIHtgW32IGwqyx68rHtUsT7a
 Q7t0xzbwdrNd8oxPiwCWE1WitDHF3DeZolttTOFRhtzEz6tCQMtKOmimRbPkmOSRGOGaJtRwi9r
 D4E9/+48vb0U7fbqT626CruToXbN5w==
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

Let users of aux-hpd, the UCSI and PMIC GLINK drivers pass the IRQ_HPD
events to the DisplayPort drivers.

The drm_aux_hpd_bridge_notify() is kept to ease merging of the series,
preventing extra cross-tree merges. It will be removed once all
drivers are converted. The drm_bridge_hpd_notify() function is kept for
the drivers which only care about the connector status and will always
pass DRM_CONNECTOR_NO_EXTRA_STATUS as the extra status.

Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/aux-hpd-bridge.c | 11 +++++++----
 include/drm/bridge/aux-bridge.h         | 13 +++++++++++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
index a2e525aa5788..930a03496ac5 100644
--- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
@@ -137,16 +137,19 @@ struct device *drm_dp_hpd_bridge_register(struct device *parent, struct device_n
 EXPORT_SYMBOL_GPL(drm_dp_hpd_bridge_register);
 
 /**
- * drm_aux_hpd_bridge_notify - notify hot plug detection events
+ * drm_aux_hpd_bridge_notify_extra - notify hot plug detection events
  * @dev: device created for the HPD bridge
  * @status: output connection status
+ * @event: extra status bits like DRM_CONNECTOR_DP_IRQ_HPD
  *
  * A wrapper around drm_bridge_hpd_notify() that is used to report hot plug
  * detection events for bridges created via drm_dp_hpd_bridge_register().
  *
  * This function shall be called in a context that can sleep.
  */
-void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status status)
+void drm_aux_hpd_bridge_notify_extra(struct device *dev,
+				     enum drm_connector_status status,
+				     enum drm_connector_dp_event event)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
 	struct drm_aux_hpd_bridge_data *data = auxiliary_get_drvdata(adev);
@@ -154,9 +157,9 @@ void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status sta
 	if (!data)
 		return;
 
-	drm_bridge_hpd_notify(&data->bridge, status);
+	drm_bridge_hpd_notify_extra(&data->bridge, status, event);
 }
-EXPORT_SYMBOL_GPL(drm_aux_hpd_bridge_notify);
+EXPORT_SYMBOL_GPL(drm_aux_hpd_bridge_notify_extra);
 
 static int drm_aux_hpd_bridge_attach(struct drm_bridge *bridge,
 				     struct drm_encoder *encoder,
diff --git a/include/drm/bridge/aux-bridge.h b/include/drm/bridge/aux-bridge.h
index c2f5a855512f..233ca885736f 100644
--- a/include/drm/bridge/aux-bridge.h
+++ b/include/drm/bridge/aux-bridge.h
@@ -25,7 +25,9 @@ struct auxiliary_device *devm_drm_dp_hpd_bridge_alloc(struct device *parent, str
 int devm_drm_dp_hpd_bridge_add(struct device *dev, struct auxiliary_device *adev);
 struct device *drm_dp_hpd_bridge_register(struct device *parent,
 					  struct device_node *np);
-void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status status);
+void drm_aux_hpd_bridge_notify_extra(struct device *dev,
+				     enum drm_connector_status status,
+				     enum drm_connector_dp_event event);
 #else
 static inline struct auxiliary_device *devm_drm_dp_hpd_bridge_alloc(struct device *parent,
 								    struct device_node *np)
@@ -44,9 +46,16 @@ static inline struct device *drm_dp_hpd_bridge_register(struct device *parent,
 	return NULL;
 }
 
-static inline void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status status)
+static inline void drm_aux_hpd_bridge_notify_extra(struct device *dev,
+						   enum drm_connector_status status,
+						   enum drm_connector_dp_event event)
 {
 }
 #endif
 
+static inline void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status status)
+{
+	drm_aux_hpd_bridge_notify_extra(dev, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
+}
+
 #endif

-- 
2.47.3

