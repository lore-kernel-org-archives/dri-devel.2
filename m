Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03E6C5DF81
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D4110E4DC;
	Sun, 23 Aug 2026 09:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=goldelico.com header.i=@goldelico.com header.b="U0Z5a6PU";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="2EzpCXhj";
	dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78EE810E4DC
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 09:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787477398; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=m0bpjBXTbSVHO1hEMMSMtGbwHuvMNhU5pRR78iUumhS2wIcQqT6kEf0tI5KyZHJkp6
 SDd+bB+QjD+NcnCnze7DvJ1smopg7eKENu/dZyefLYsXaUfWuT2/D5/8AuRDMde7gi1i
 qR91TEB4/CYYFxl2M/l+w/pNzIZbUSze6qYAhJMmKs/zBG+SY9zhoMs1Xkbxn84PoBRp
 yqsEdDno9xx7RCCpKkX+UAQNMX6HmHdtVAgHeZD/lSAODEuv98flS6xtHPYNH6kr+g9L
 lxjs62p4YdMXI7DjY9LU8akz4ZrfCVtheBMkBE+9lWGg/Raj+IEHpYLSDRB8KH8DhNKt
 qc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787477398;
 s=strato-dkim-0002; d=strato.com;
 h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=GCILg7d45RMRE8YNTXah1jL4z2iDWGmWYyDATUxfxUM=;
 b=hQyDg8pk2Yte6uzBGT0YZrLlYQ79N5S9B+ZoWSyH2fbVuFFSrMUSq0QOUuGcN8zpSN
 qSRCHLBHS32IiEYE/7pOjiwo1T33K3ssBc9hOvc46OSIVrNu46L4mY7voaAj44NFq5wo
 xo/6etHIeHvuaRsPYkWKj2nxANXX1VAd+G9zvIUJ+gjQQoOwl4p0qeHGsJkAlPw7WF8Q
 H+hoFkOAypUYMCvoa1/IIdQ0DKaOIKaaA+pCzV8L3hV7xWsOy4DwDI9ki+JbSN7vCsMV
 DyxkplvYyrbf2capfl/Ln3KSI31jW0J4gPcERlXGO6qC11CWInJFi1eTz/dk2drBX1s7
 hi8w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787477398;
 s=strato-dkim-0002; d=goldelico.com;
 h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=GCILg7d45RMRE8YNTXah1jL4z2iDWGmWYyDATUxfxUM=;
 b=U0Z5a6PUJjxOBIgpA39Y3LAx7CtpughSEDUmCWg+A/4nojG4BDoZiS2LVGVTffy4AM
 Lm3sdXCInY69tGI3CSPAbhr/cBejLZj8SAX78aw5RLNprwKt8GPp3o7IHQmzNrgLNcdL
 wT814e2CAsZDRy2s9xbE9FwTUORIhVjAy4TFYAWjRDxEmbG+FfK1wXcbW5rwOlRueS++
 Fo392ObBkn3pfoOKnKGhyMTRPs6H9ofQudiPW0wAyBGRpeT1KRd9ySaYmz2MWNoR7Pex
 tY5ouKbwbUN/ZUaaFmtmitT0G2HqJOE4tYo7zRQzCW6+U1ZLoDvgpOckJvBndkVyS1Pn
 xeEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787477398;
 s=strato-dkim-0003; d=goldelico.com;
 h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=GCILg7d45RMRE8YNTXah1jL4z2iDWGmWYyDATUxfxUM=;
 b=2EzpCXhjEVVD0OalOGWZ1y2gHfTOkJvzzHQJ2tYb7GM1kFZ/MHHojZcthEwjhf048f
 zStus1B0UvHFlTwwPCDw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ25oKnciHHK5OAyYE8yLD5e6WBWpu+g6xSmk="
Received: from iMac.fritz.box by smtp.strato.de (RZmta 55.6.2 AUTH)
 with ESMTPSA id Qfefb327N9TvWi2
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sun, 23 Aug 2026 11:29:57 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Paul Cercueil <paul@crapouillou.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
 wbx@openadk.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/ingenic: fix bridge allocation
Date: Sun, 23 Aug 2026 11:29:52 +0200
Message-ID: <400ba2fe0d4f76484e929d2efaa32f67a940163a.1787477392.git.hns@goldelico.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
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

Bridge allocation API has changed and ingenic/drm was broken
leading to

[   54.997593] dw-hdmi-ingenic 10180000.hdmi: Detected HDMI \X controller v1.31a with HDCP (DWC HDMI 3D TX PHY)
[   55.491338] dw-hdmi-ingenic 10180000.hdmi: registered DesignWare HDMI I2C bus driver
[   55.899132] [drm] DRM bridge corrupted or not allocated by devm_drm_bridge_alloc()
[   55.904136] ------------[ cut here ]------------
[   55.908753] WARNING: lib/refcount.c:25 at drm_bridge_get+0x58/0x6c [drm], CPU#0: kworker/u4:2/36
[   55.917538] refcount_t: addition on 0; use-after-free.
...
[   56.354928] [<c04898b8>] drm_bridge_attach+0x80/0x208 [drm]
...

Fixes: 9347f2fbb0183b0 ("drm/bridge: add warning for bridges using neither devm_drm_bridge_alloc() nor drm_bridge_add()")
Tested-by: Waldemar Brodkorb <wbx@openadk.org> (on CI20 with HDMI)
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Waldemar Brodkorb <wbx@openadk.org>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 24 +++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 42c86f195c66b3..0a284502b0d3fe 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -122,7 +122,7 @@ struct ingenic_drm {
 
 struct ingenic_drm_bridge {
 	struct drm_encoder encoder;
-	struct drm_bridge bridge, *next_bridge;
+	struct drm_bridge *bridge, *next_bridge;
 
 	struct drm_bus_cfg bus_cfg;
 };
@@ -802,7 +802,7 @@ static int ingenic_drm_bridge_attach(struct drm_bridge *bridge,
 	struct ingenic_drm_bridge *ib = to_ingenic_drm_bridge(encoder);
 
 	return drm_bridge_attach(encoder, ib->next_bridge,
-				 &ib->bridge, flags);
+				 bridge, flags);
 }
 
 static int ingenic_drm_bridge_atomic_check(struct drm_bridge *bridge,
@@ -1314,10 +1314,26 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 
 		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
 
-		ib->bridge.funcs = &ingenic_drm_bridge_funcs;
+		ib->bridge = devm_drm_bridge_alloc(priv->dev, struct drm_bridge,
+						   base, &ingenic_drm_bridge_funcs);
+		if (IS_ERR(ib->bridge)) {
+			ret = PTR_ERR(ib->bridge);
+			goto err_drvdata;
+		}
+
+		ib->bridge->of_node = priv->dev->of_node;
 		ib->next_bridge = bridge;
 
-		ret = drm_bridge_attach(encoder, &ib->bridge, NULL,
+		ib->bridge->ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
+		ib->bridge->interlace_allowed = true;
+
+		ret = devm_drm_bridge_add(priv->dev, ib->bridge);
+		if (ret) {
+			dev_err(dev, "Failed to register DRM bridge: %d\n", ret);
+			goto err_drvdata;
+		}
+
+		ret = drm_bridge_attach(encoder, ib->bridge, NULL,
 					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret) {
 			dev_err(dev, "Unable to attach bridge\n");
-- 
2.55.0

