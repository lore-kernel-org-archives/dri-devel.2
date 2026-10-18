Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D26CCA490
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1055210E614;
	Sun, 18 Oct 2026 12:37:41 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8684110E614
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 12:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792327053; x=1792931853; i=jan.claussen10@web.de;
 bh=G4nmuM+bqcOQtIPOY3msxgjT9MI21X16wTT14DXaYjs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iAGuQ0LjhRcY7tcboE3t8ti8lrzQGOO9+Tspfk9A8tAeU8Zy9HFNlWm80UjsbY0s
 XnJm8Y1UkSxQKCtRrBrwjbOYCrk0SeXj6PeehigbZIHgfx6MgV9XsrLeOCGFoeRqk
 MjfSvGKjR3In/BvJgUrf61Mlr4t8j/xeo4XnYyU04vqZRLofb/Bt4kksoITnmhM5L
 TMCV1h7+NFPzI/CG3cdtT1RrTxbHV6IQQeR/mPYaQPuWJ/GlNTcqeWaE6T4eMajWa
 OARRLtfrf2p0kVJt2P6O5WZCJiwAtCOwzXoZwei+5Tiwx9mzXbTpi6WZ2HfLBT+QW
 0AuIZ1/yKP3hQ8//kg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVJNd-1x9NVm2EHX-00SRZ7; Sun, 18
 Oct 2026 14:31:45 +0200
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] drm/bridge-connector: Pass supported colorspaces to
 the HDMI helpers
Date: Sun, 18 Oct 2026 14:30:14 +0200
Message-ID: <20261018123037.19560-5-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018123037.19560-1-jan.claussen10@web.de>
References: <20261018123037.19560-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rRMv3jNi4cbhj7PNEOZaWkHW8+2/NOX1/hB1Umtd8n6WDF01+uu
 jwWXTDgatj+kj66DvKjgUxUBtkSFlSdMmeyiu34zZARYtdxNHROagUVsWAnajriV0YV9ysi
 anBlwFxhxukZRd+kKRZ7+W7t5z7Rh57+NSCDJ6z7kxlKKYc7BDBny8gkLfhJJnd8p5r2mUD
 k6f+wjDfNUI1DUd/EH1sQ==
UI-OutboundReport: notjunk:1;M01:P0:n7ZOmdxYLQ0=;1rI+47iY8kAbJfCoX1pPiYvkIBC
 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
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

Add a supported_colorspaces field to struct drm_bridge so HDMI bridges
can declare the colorimetries they support, and pass it on to
drmm_connector_hdmi_init() so the colorspace property gets created.

Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++++
 include/drm/drm_bridge.h                       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/=
drm/display/drm_bridge_connector.c
index 81f3e26f6fdf..40f50304c46f 100644
=2D-- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -1042,6 +1042,10 @@ struct drm_connector *drm_bridge_connector_init(str=
uct drm_device *drm,
 			bridge_connector->hdmi_funcs.supported_formats =3D
 				bridge_connector->bridge_hdmi->supported_formats;
=20
+		if (bridge_connector->bridge_hdmi->supported_colorspaces)
+			bridge_connector->hdmi_funcs.supported_colorspaces =3D
+				bridge_connector->bridge_hdmi->supported_colorspaces;
+
 		if (!connector->ycbcr_420_allowed)
 			bridge_connector->hdmi_funcs.supported_formats &=3D
 				~BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 1981d24a700d..b46d34040024 100644
=2D-- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1129,6 +1129,13 @@ struct drm_bridge {
 	 */
 	unsigned int supported_formats;
=20
+	/**
+	 * @supported_colorspaces: Bitmask of &enum drm_colorspace listing
+	 * supported color spaces. This is only relevant if @DRM_BRIDGE_OP_HDMI
+	 * is set.
+	 */
+	unsigned int supported_colorspaces;
+
 	/**
 	 * @max_tmds_char_rate: Maximum TMDS character rate, in Hz, the HDMI
 	 * bridge supports. A value of 0 means the core should use the default
=2D-=20
2.56.0

