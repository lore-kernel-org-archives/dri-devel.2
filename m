Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8E0CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B9C10E635;
	Sun, 18 Oct 2026 14:32:55 +0000 (UTC)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762F110E635
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792333959; x=1792938759; i=jan.claussen10@web.de;
 bh=G4nmuM+bqcOQtIPOY3msxgjT9MI21X16wTT14DXaYjs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gCJZ8V4HemKSVRGHxsnv6CkQuKZuwB3l5NTy1SY1EpIz0Ni0TwEsEMg6UuJs8UjA
 yX7hWRWj76G6Yz+T/wriHHu0PrmVqfAzHGlizof8PmN1rlVvDv2xQUmpm7Pb/NOSD
 gcKBd4jlbgZ89ZhKNPrceSDs629Vvfd2e1Y7VKn1Io2mv56vkCaylZspeTPtXYH4z
 3nkYyyHop0xiGnSpJR7L261XkAMAtetZLX/HZILHuq5wlml+ID9GE5q9Gs6tf7tJL
 EIzRcjQn7gbmzNAD+vDNJUwqq48cDCj+9QI1x/QOH3TjBo6ACu2MqCJAjEQADEfRO
 g7ghTm8E0IzzAq7qAw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MECCd-1xQSpO2ptN-00AEoD; Sun, 18
 Oct 2026 16:32:39 +0200
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
Subject: [PATCH v4 4/7] drm/bridge-connector: Pass supported colorspaces to
 the HDMI helpers
Date: Sun, 18 Oct 2026 16:31:10 +0200
Message-ID: <20261018143135.5745-5-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018143135.5745-1-jan.claussen10@web.de>
References: <20261018143135.5745-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UF1WgQ2DU4H+JjnJ6LvvkPRmVY9QVZ48938kG6EqU9C6TdrDthg
 q9o8nCF7/+KPVNO0wu+iGceUso7Uw83UTRhvDPVg1lF8uqPC633riGtfooJ/8hCtbsiQZtc
 Jv/nuIoKxGO5vlmPcaV7yBaDyviKwOUBFrADyBJumRF5HX0mfW86C/ryFGMym9lo+iG0I+Y
 nQjzqeyXZ2mI3X67jnA2w==
UI-OutboundReport: notjunk:1;M01:P0:Ydrw3d2cWM8=;xrN3e3s1oWpkdycaDtZ31AmsAFV
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

