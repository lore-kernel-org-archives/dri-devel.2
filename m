Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385D3CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBE210E608;
	Mon, 12 Oct 2026 07:32:19 +0000 (UTC)
X-Greylist: delayed 334 seconds by postgrey-1.36 at gabe;
 Sun, 11 Oct 2026 13:26:35 UTC
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4125910E043
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 13:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1791725193; x=1792329993; i=jan.claussen10@web.de;
 bh=OsfRzlfLd2pab3xVhjWOrZ//msUrGzfPbFTml90VrYQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=vuQ36PgnE5MwvvpHVAhyFTdvyH6Oht8JuXsMHLusHjpEknJVV3P51KDjsFAP9mhA
 l8NHcxd/A3+Lp3UVHfTy8ARay+iBBaUCH1TKWRTHcXBqgGNyCqSZWWDfYaawxuDZn
 jV3htl+aY1cRe2PqR/Oxu6PAk6Imlmr3FEbCSSSeefRy5MYsHbx/YbQ10TwsyAKhE
 i5vkoKuZitqWKGQ7MRX63trbVAkr8st4VmqGGmrO2zHt4U8P4aiaIrz4lKAQGBi8d
 6Z/N03vEPBDFmWlXuEWXrdo4DCyeRw92OHpObgiKioVOcty8LjvkuxVkN3iCWOaPv
 WaD/pzN+7ou1x1J7GQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIJA-1x4zOP1XC4-00VDHC; Sun, 11
 Oct 2026 15:20:37 +0200
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
Subject: [PATCH RFC] drm/bridge: connector: Support the colorspace property
 for HDMI
Date: Sun, 11 Oct 2026 13:20:22 +0000
Message-ID: <20261011132024.2833-1-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qgBdaHqb99/+JiPkKvAXfwVsuVg8XSM1syfn6gD4yKQYAtX3itW
 FiftAzPPVPsPlkPLgloKUS3IFRW3b+6u7yaeBsFSj7GBO+1cZCv0+cxx7OxJGpgEpJBQMQQ
 VG0AwUwuvY0lxs96c1jBCXEp6v54zFvD8Ex6XKPoRciHho8Cm0fADVCoW15CooLFbY+o0TI
 OJcQeeiG21LIhaoRlK7gw==
UI-OutboundReport: notjunk:1;M01:P0:rJseUcadFRA=;nGMkCaq3+cUETyzscuzNj0vik2h
 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
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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
so userspace cannot signal the colorimetry e.g. BT.2020 for HDR.
KWin requires the property before it offers the HDR toggle.

Attach the property for HDMI bridge connectors, next to the other HDMI
properties set up by drmm_connector_hdmi_init().

Force a modeset when the property changes so the new colorimetry
reaches the sink, as vc4 does in its connector atomic_check.

After toggling HDR on, modetest shows that the correct BT.2020 color
space is loaded. After toggling it off, it loads the default color space
again.

Tested in Plasma 6.7.5 on a Radxa Rock 5B (RK3588) with an LG OLED55B87LC.

Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 .../gpu/drm/display/drm_bridge_connector.c    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/=
drm/display/drm_bridge_connector.c
index 81f3e26f6fdf..0639fe094b10 100644
=2D-- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -412,6 +412,20 @@ drm_bridge_connector_mode_valid(struct drm_connector =
*connector,
 static int drm_bridge_connector_atomic_check(struct drm_connector *connec=
tor,
 					     struct drm_atomic_commit *state)
 {
+	struct drm_connector_state *old_state =3D
+		drm_atomic_get_old_connector_state(state, connector);
+	struct drm_connector_state *new_state =3D
+		drm_atomic_get_new_connector_state(state, connector);
+	struct drm_crtc_state *crtc_state;
+
+	if (old_state->colorspace !=3D new_state->colorspace) {
+		crtc_state =3D drm_atomic_get_crtc_state(state, new_state->crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+
+		crtc_state->mode_changed =3D true;
+	}
+
 	struct drm_bridge_connector *bridge_connector =3D
 		to_drm_bridge_connector(connector);
=20
@@ -1079,6 +1093,12 @@ struct drm_connector *drm_bridge_connector_init(str=
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

Hi,

after testing the patch in the link below,

https://patchew.org/linux/20260805153416.8459-1-royalnet026@gmail.com/

which attaches the bridge connector inside the bind function of the
Rockchip QP driver glue code, I realized that the colors looked washed out=
,
when the HDR mode was enabled in KDE Plasma. I found a supposed solution,
which was comparing the old and new colorspace enums of the connector stat=
e
in the drm_atomic_helper_connector_hdmi_check().

Before hastily sending the patch, I consulted maintainers in the #dri-deve=
l
channel and Javier pointed out that the attachment of the colorspace shoul=
d
not be done in the glue code of the Rockchip driver since it merely uses t=
he
DRM bridge framework. Furthermore he said the modeset force should not be =
done
drm_atomic_helper_connector_hdmi_check(), since it was meant to only check
conn_state->hdmi, which the colorspace doesn't belong to. He suggested to
rather implement them in the drm_bridge_connector_atomic_check() and
drm_bridge_connector_init() respectively. This is what patch does.

This is my first patch to the upstream kernel, so I am sending it as RFC.
I found the solution with the assistance of AI tools, but I do have a basi=
c
understanding of the kernel's driver model and API. While I made sure to
carefully read the rules on how to do this correctly, I probably still
haven't done everything right. I am happy to make further changes if neces=
sary.=20

If this is however done correctly, it should probably supersede the patch
mentioned above.

Best regards,
Jan

2.56.0

