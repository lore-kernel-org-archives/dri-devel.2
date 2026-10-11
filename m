Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA92CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 14:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2C810E170;
	Sun, 11 Oct 2026 14:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=jan.claussen10@web.de header.b="m/qnXRDt";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B562110E170
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1791728868; x=1792333668; i=jan.claussen10@web.de;
 bh=TJDll0swAGnG9jPsI7wun+CDH2ZuY1KWvM766u157T0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=m/qnXRDt1wgV/ZisMjREBDe2Z/T1Y5R23UcBrbioWDocfENSy01h2KWayAPkHqrp
 HrA2vKC2oEykhihofYdBCVlEx91JM9iRUtxUDVf8BT2tX4o/w3RFf1odb5vrEujU4
 Glkeq7S2kinbVGqRAV4JCh/EmKhyGfvj2RH8JTOIRH2oiZpZ1Q2gY6qKwQCOLRlHS
 kddZXxfT8FpQD2VDyQvtwzX0/A5oDRVd4rUUGmi775JJ6QV4R3DUV7ZFhNeNzdEwV
 CZTicRfMesKGwyoX80WupwN+fGGVl82NH/6ZFcQ78QaU9yVVRmUFlluoPuNvZYAc5
 xOuc2j8mphPVPT2vhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QQD-1wasG647X3-010iS8; Sun, 11
 Oct 2026 16:27:48 +0200
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
Subject: [PATCH RFC v2] drm/bridge: connector: Support the colorspace property
 for HDMI
Date: Sun, 11 Oct 2026 14:27:32 +0000
Message-ID: <20261011142733.7806-1-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3k4pJrGcliLYe8IB6JM7WTuq3Pl0Igz6xYXpiwYcj5eRXUFxTof
 IJGHrBMp1v0LyItc3qmwysB013Nk466+5OJYReqB7xJcn9lPSuc5+kwyI3hkDb7IF88O576
 wylOTwtvlwBg/WvIEGbrxSYHbrzrJh7hr4Hx77lqYuGbC7j5qlWja7juwxq3BCc/wsTFAhw
 1KWvTTMG8TWbEMvRXbmjQ==
UI-OutboundReport: notjunk:1;M01:P0:DaSMtxPuP30=;YAVuQWEsyTeo+yGPgcxgvznORoy
 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
 Ru+Jed2g==
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

Bridge connectors for HDMI do not expose the colorspace property,
so userspace cannot signal the colorimetry (e.g. BT.2020 for HDR).
KWin requires the property before it offers the HDR toggle.

Attach the property for HDMI bridge connectors, next to the other HDMI
properties set up by drmm_connector_hdmi_init().

Force a modeset when the property changes so the new colorimetry
reaches the sink, as vc4 does in its connector atomic_check.

After toggling HDR on, modetest shows that the correct BT.2020 color
space is loaded. After toggling it off, it loads the default color space
again.

Tested in KDE Plasma 6.7.5 on a Radxa Rock 5B (RK3588) with an LG
OLED55B87LC.

Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 .../gpu/drm/display/drm_bridge_connector.c    | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/=
drm/display/drm_bridge_connector.c
index 81f3e26f6fdf..885094cc6ddf 100644
=2D-- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -414,11 +414,24 @@ static int drm_bridge_connector_atomic_check(struct =
drm_connector *connector,
 {
 	struct drm_bridge_connector *bridge_connector =3D
 		to_drm_bridge_connector(connector);
+	struct drm_connector_state *old_state =3D
+		drm_atomic_get_old_connector_state(state, connector);
+	struct drm_connector_state *new_state =3D
+		drm_atomic_get_new_connector_state(state, connector);
+	struct drm_crtc_state *crtc_state;
=20
-	if (bridge_connector->bridge_hdmi)
-		return drm_atomic_helper_connector_hdmi_check(connector, state);
+	if (!bridge_connector->bridge_hdmi)
+		return 0;
=20
-	return 0;
+	if (new_state->crtc && old_state->colorspace !=3D new_state->colorspace)=
 {
+		crtc_state =3D drm_atomic_get_crtc_state(state, new_state->crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+
+		crtc_state->mode_changed =3D true;
+	}
+
+	return drm_atomic_helper_connector_hdmi_check(connector, state);
 }
=20
 static const struct drm_connector_helper_funcs drm_bridge_connector_helpe=
r_funcs =3D {
@@ -1079,6 +1092,12 @@ struct drm_connector *drm_bridge_connector_init(str=
uct drm_device *drm,
 					       connector_type, ddc);
 		if (ret)
 			return ERR_PTR(ret);
+
+		ret =3D drm_mode_create_hdmi_colorspace_property(connector, 0);
+		if (ret)
+			return ERR_PTR(ret);
+
+		drm_connector_attach_colorspace_property(connector);
 	} else {
 		ret =3D drmm_connector_init(drm, connector,
 					  &drm_bridge_connector_funcs,
=2D-=20

Changes in v2:
* Only look up the CRTC state when the connector has a CRTC
* Only apply the check to HDMI bridge connectors
* Move declarations to the top of the function

v1: https://lore.kernel.org/all/20261011132024.2833-1-jan.claussen10@web.d=
e

2.56.0

