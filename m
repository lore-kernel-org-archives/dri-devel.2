Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14601606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2+Zjchc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 302D710E02B;
	Sun,  1 Nov 2026 20:34:16 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04A110E02B
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 20:34:09 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so14836705e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 12:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793565248; x=1794170048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F89725KkjE+kUI5LXBxmdgLNt89Tfm7tC84mMjTHCkI=;
 b=A2+Zjchc+LRhCoGJ9HJ0V63Rsr+AAgoK1S4fiq1jEWH7uYKF8WxEKJNNArwcWnv3cd
 gd5RPbEIW0XFDiH1sDUeE8s0oH8ZGBoEtK9IYLBMXjSH6VjysCQQ3IPuFmWtDdYF/fRA
 ujGGdDBNdx5YXBhZNlZkDdijvqVZoGa/uCqtTVdA7V4qNyAzSPF0i0233jGJolEWRBiT
 wdtJqhwoR4DzgPFzBGQ6e5tzggHtkuwE4Poy7XWIPmKoLd82+HLcDVoEf2z7Mk5f2ndm
 dAWOsfmYJUhHjXyWBplrRvdTxZoxp60otHm6i6MS5sAAZlRmy9iHWPwuCluTLWnu9wIp
 X2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793565248; x=1794170048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F89725KkjE+kUI5LXBxmdgLNt89Tfm7tC84mMjTHCkI=;
 b=RiMxWJr6tEeqwNHlqhVcLoWxSmVIozEESdFr7wiJFwoi8h69/kg1q2WEgVAa2s4PL+
 PD6bJg0T25b9IAcwEls1UPird6nrsj4fwzQniSRUX2PfxWGocyANUEna1IXld+I/5IZe
 eERYE4/OFuOMIzoZo2w2S/Lj0+1oktCWwQGfIJOxo7hn/BeivJsbRr1D76ZUGtqe3NoF
 Iq0awV/uOzX2cCrUPM6RggsZoKWZNuWk7lFqbpvbyDgnhEsFJCndieq5UN4Ceov/Unnb
 rkywqNMGyQYFlmFp5KcKvM2+mJwWcomTa2zFqNTmu4CsD6rqI7kzVICWBlAsxKlCG31r
 XCAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzt1zo+u7Sd6RRe1JlY/HCx3htHcyO5HFmmkF/3gJawWLTjRslnb6eN1A1uWpecjnW/zjk3pfXBxsU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLfAPsvAgB9opUH5vKT+55xIT0WnhlGft966nR1ZQY3yKLIeidI
 kemu2WCR5oc3ORLoaxpRJAcThm+gv5eR3Vbotv4PJ7aIWtU4/7VDtg4j
X-Gm-Gg: AYBFou2yEjWiVq7nswS8muVR2nmgljPi7cSDcixtsdF0I2NQxZTdbFHP5YBdHneeJq9
 TTRanlk6XW7GFbf+jIQfCpOuStr825jyNblgpPICn3ce7l+T29ivLEfZbgttfmWYSij3QSUcJXj
 CU7fIPLloFzzF9B8i+ARNOV7CKKrCMrr5XYQJ6Bx3Phvlyg4yyclCQYrw8dOqloZNu4jQusq41k
 qY3t0NeQKiUoCD+zpYdgZsfuJeAtw+GWCLaBDvVT9++pTk4PSb4yO/DLs5M5n13mh3YMMhqC7ZP
 zs60KErbvQdDbp4FS/OXHTvgjPz2F83syqnm81Cz8qRGmZdvMDb05Wfnx2KrwMFqzbrmNDCa2sH
 WoSiQVEljrBFSns4G2g34Vxc5nXQI+g7ItXFMat93ZRep68pKexU6fhYE6sHETCzcSbepCnVMkQ
 IuIxeREa1Q/KA8s30AXQptP6YiUj1SuR2yptgvM8GKuMNZk8jNGjY4EB6lRYYisaZ2eqNGR79iE
 3mHPI85q/HHMeRi5nt+KNSiU/gKeEPhgDG/TsZZqE7d87zRhdVRZ1yOoJo2bujON7/Gr0y8T3It
 FnmCZdpAiTYsjdTVdQ66tEIRIBCsM8rdAe9bGnIWmJLPlveuV4YGB8gzPGrQcWeiWoNQ+5ArteJ
 QtjZgLpnwxBhbJLGhrTjLJr9cQZJ1fzLdOHjQdWsuzpg4/w==
X-Received: by 2002:a05:600c:1d07:b0:4a2:18d4:f9e0 with SMTP id
 5b1f17b1804b1-4ac18c735b3mr192334605e9.25.1793565247854; 
 Sun, 01 Nov 2026 12:34:07 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:849f:a468:4121:a85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab61d8b9f4sm263946675e9.12.2026.11.01.12.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 12:34:07 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: [PATCH] drm/sun4i: dsi: set the connector orientation from the panel
 node
Date: Sun,  1 Nov 2026 21:34:06 +0100
Message-ID: <20261101203406.1360656-1-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

sun6i_dsi_attach() only accepts the panel once the DRM device is
registered, and returns -EPROBE_DEFER until then. By that time the
connector can no longer get a "panel orientation" property: it has to be
attached before registration. The fbdev emulation is also set up from the
hotplug event of the attach, so it gets no rotation hint either.

As a result the rotation property of a DSI panel on these SoCs is ignored:
on the PocketGo S30 (A33, 320x480 panel mounted for landscape use,
rotation = <270>) the console and the boot splash stay in portrait.

The panel is a child node of the DSI host, so read its orientation from
the device tree when binding, before the device is registered, and set it
on the connector then.

Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
Notes:
- Testing: built with W=1 for arm (multi_v7_defconfig, DRM_SUN6I_DSI=y
  and =m) and arm64 (defconfig, =m), no warnings. Tested on a PocketGo
  S30 (A33, ILI9488 DSI panel, rotation = <270>): on 6.18.54 with the same
  change (6.18 still calls the helper of_drm_get_panel_orientation()) the
  console and plymouth come up in landscape, where they were in portrait;
  on 7.3.1 with this patch the DSI connector reports "panel orientation"
  = "Left Side Up".
  Not tested on other boards; boards without a rotation property keep the
  current behaviour (no property is attached).
- Tool disclosure: this patch was prepared with Claude Opus 5.5
  (Anthropic) as a coding assistant, in an interactive session where I
  asked it to fix the console orientation on the PocketGo S30. It traced
  why the connector never got the orientation, wrote the change and the
  message. I reviewed and understand it, and tested it as described.

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index d504ae5832..1eb8a4cde0 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -22,6 +22,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -1055,6 +1056,31 @@ static const struct regmap_config sun6i_dsi_regmap_config = {
 	.name		= "mipi-dsi",
 };
 
+/*
+ * The panel only attaches once the DRM device is registered, too late to
+ * give the connector its orientation (the property cannot be added after
+ * registration), so fbcon and the boot splash would not rotate. Read the
+ * orientation from the panel node, a child of the DSI node, at bind time.
+ */
+static void sun6i_dsi_set_panel_orientation(struct sun6i_dsi *dsi)
+{
+	enum drm_panel_orientation orientation;
+	struct device_node *np;
+
+	for_each_available_child_of_node(dsi->dev->of_node, np) {
+		if (of_node_name_eq(np, "port") || of_node_name_eq(np, "ports"))
+			continue;
+
+		if (!drm_of_get_panel_orientation(np, &orientation) &&
+		    orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN) {
+			drm_connector_set_panel_orientation(&dsi->connector,
+							    orientation);
+			of_node_put(np);
+			return;
+		}
+	}
+}
+
 static int sun6i_dsi_bind(struct device *dev, struct device *master,
 			 void *data)
 {
@@ -1085,6 +1111,8 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 
 	drm_connector_attach_encoder(&dsi->connector, &dsi->encoder);
 
+	sun6i_dsi_set_panel_orientation(dsi);
+
 	dsi->drm = drm;
 
 	return 0;

base-commit: a1e63ab695ad76850ab9787b9eb6aab695dc2965
-- 
2.43.0

