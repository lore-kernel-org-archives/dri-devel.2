Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90110CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C895410FE10;
	Fri,  9 Oct 2026 03:18:14 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB79910FE10;
 Fri,  9 Oct 2026 03:18:11 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515834tf0417f50
X-QQ-Originating-IP: EuPfVQdQ7C/DcphIeULq/TvnkWsIwm0C4Knbx2+F2nw=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8697921741928776439
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:15:55 +0800
Subject: [PATCH v2 03/20] drm/bridge-connector: Attach max bpc for non-HDMI
 bridges
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-3-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
In-Reply-To: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3357; i=sophon@radxa.com;
 h=from:subject:message-id; bh=y8Hk7pwSF01X//hlbGuKeI//kPSXq5QtzgIxRDu/UNE=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlZ8jeQ8yyZ+66e3jMCWDdv2fKs7Zex8UUWxMKvws
 3KzrkJORykLgxgXg6yYIotCPMNc9srca0/FSvVg5rAygQxh4OIUgIkcOMnIcPXJ64nvDWvMZL58
 scnVvV/ptecT87WDX5137uVsvvhpcgjDX5kTk1U8N8oe3HA+0KBdpXsNs6RraVb75L7665cDNly
 XYQUA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M7r/zttrUmlkFTN2XrU5vmuMFMgJLiiXfgn0xAvgaT17DsWOf5jccVwm
 Z3Rqn8S8LrjXYfqvf4oPxHarrYfAsNS3PXel2NlFBAvwSPERgF8KklbaXcGiOcbQCLqopIZ
 nk2uUMGi5bIK2t+OlGesHiYE19EcVgKI62EximuEFGCwVD6FCWSa2aHBUTT8akg4ERcnk8e
 IIXsFSpbMuSst7g9HxLm7WAp+2Xeh/MBe0jCkjX67ISlJeSGEItnU4P2naSwBNQg3l81hj6
 oTw2geDZkOpAtb8Wdv4ReXfUMbmXGn8iTiOOInKxt0OcVbXthhCPnMNHt/wgxGqdLDqXWGW
 4YprvOeWPDs+IvnAo/lvd0tigKhrvXWzSXBTE+ILpTFnqNDgs4P/uy1Y0NCdFVm9Eu1A9yX
 31AcjxBGDh4cwUoVic8XRDtr6w1St0gC4HWe7zcV2u7LHABPPE73+RMJrQ9ao+s2yJv2uuy
 ePtwFtM57MRQw5DxdpTKXCHARvZFwXlgnA6rffJvDRp1JaVhQVRuAsQ0jNL4BmkyDVNKVAJ
 xWFW5jZWYFgMoTzc2+HOJ6eVGYzLY8XT8RtfpGGinvNPr8/3jLAaOBdi8Y8m3b5XNjUczfi
 kmQM7+UI/c86v1eWxAXu/DbyK9Voze3W3OZMaDUCeTNyy+shWmjs+VtAFap/Top2xd8rUM6
 w+Ekb7zm33i3N7lzqtISEaYyYbC8586Oq1DzX6B7Ei0LU/QImxKXXTkyQc37vdcayuL/KTg
 JyOIERP78xn60+wTFb3hn8vezmE4dp4xYXZjCEUucBP4b8tLBvpzCGrhrsTlMpjea9aBr5x
 AHgJ5FTToo7bbxojLQeieLY9qSzTPe02/6FXsgCo3IhC9k4jXqDAJyhkteuPATQWPavqCNl
 J2sAjhAntMP6oA8JpgnyXXob1wYkYZ3pCU/a4xbrzp2zStH1vZjNaFBygtuKpCU2CazqH1W
 bxX+G0ruAhSC8wIMb0NmBO755vDoM1l/u21W4HsNqSzoMtBgMQUIOYqiXQptH2Z/nr6ADCm
 dh89CzqN/XG3LbGl3PsOoZUscooZmynByI2mxvGFEzj0g3I5Kw
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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

Allow non-HDMI bridges to advertise their output bit-depth limit through
max_bpc. Attach the max bpc property when the lowest reported limit in the
chain exceeds 8, ignoring bridges that do not report a limit. This lets
DP drivers expose deep-color support without attaching the property in
their connector initialization code.

Use a lower bound of 6 for DP and eDP, which support 6 bpc RGB output, and
8 for other connector types. Keep the existing HDMI registration path.
The property can be attached before connector state allocation; the
atomic state helper initializes its default when state is created.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 18 ++++++++++++++++++
 include/drm/drm_bridge.h                       | 11 ++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 8b54069fa53a..be2e08a3694a 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -825,6 +825,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	struct drm_bridge *panel_bridge __free(drm_bridge_put) = NULL;
 	unsigned int supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
 	unsigned int max_bpc = 8;
+	unsigned int chain_max_bpc = 0;
 	bool support_hdcp = false;
 	int connector_type;
 	int ret;
@@ -985,6 +986,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			panel_bridge = drm_bridge_get(bridge);
 		}
 
+		if (bridge->max_bpc)
+			chain_max_bpc = chain_max_bpc ?
+				min(chain_max_bpc, bridge->max_bpc) : bridge->max_bpc;
+
 		if (bridge->support_hdcp)
 			support_hdcp = true;
 	}
@@ -1026,6 +1031,19 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 					  connector_type, ddc);
 		if (ret)
 			return ERR_PTR(ret);
+
+		if (chain_max_bpc > 8) {
+			unsigned int min_bpc = 8;
+
+			if (connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
+			    connector_type == DRM_MODE_CONNECTOR_eDP)
+				min_bpc = 6;
+
+			ret = drm_connector_attach_max_bpc_property(connector, min_bpc,
+								    chain_max_bpc);
+			if (ret)
+				return ERR_PTR(ret);
+		}
 	}
 
 	if (bridge_connector->bridge_hdmi_audio ||
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 58fff047f43b..01ad1878149e 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1089,9 +1089,14 @@ struct drm_bridge {
 	unsigned int supported_formats;
 
 	/**
-	 * @max_bpc: Maximum bits per char the HDMI bridge supports. Allowed
-	 * values are 8, 10 and 12. This is only relevant if
-	 * @DRM_BRIDGE_OP_HDMI is set.
+	 * @max_bpc: Maximum bits per color component the bridge supports.
+	 * Zero means that the bridge does not report a limit. For HDMI bridges
+	 * with @DRM_BRIDGE_OP_HDMI set, allowed values are 8, 10 and 12.
+	 *
+	 * For non-HDMI connectors, drm_bridge_connector_init() attaches the
+	 * max bpc property when the lowest nonzero limit in the bridge chain
+	 * exceeds 8. Bridges remain responsible for validating configurations
+	 * against any limits not reported here.
 	 */
 	unsigned int max_bpc;
 

-- 
2.56.0

