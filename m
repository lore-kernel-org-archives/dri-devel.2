Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0631DC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF3B10E547;
	Mon, 24 Aug 2026 12:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=goldelico.com header.i=@goldelico.com header.b="KqgQmWoR";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="SJ45AIQ/";
	dkim-atps=neutral
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85E210E547
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 12:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787575208; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=IRNpNSk0eO2m3hypQV9UTeuVv3t0ElL2HieCvZTikbgbYtHY2EF7f5qQchPQKfylCn
 lT1Di2iKf1oNd5BT/2kTGGl/u3d0Flq+Sy0OrKwDE9cvZqScrLC3c6yi0Eoi43RFe8s2
 FAPutRDIAb3b6Rfcig+CBUcIf7EowWA/+13XiuMQ/9+p2UbC5up21gh03vBHRUBP/RFg
 8Ij7EMVxLxhwLt5Oj6tP0eH8owMNtQcZoDNar1uRFG9y0sLB9lWmEhNDPxnDfYEazNcN
 vrO9qJXw5dngzRfhvPbY4BH9qkEQJTCHO1EIjCIqGamCfCgpauQMobfvor204i3OLMpN
 j2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787575208;
 s=strato-dkim-0002; d=strato.com;
 h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=hdl5+vuoxUtreZDmE2u1Lsb93eEflKwu+QkhnmGOsRo=;
 b=ootRZ4Va27+9XOhkojOMbYQw38uSw1JP6+5+E1J61iM2VbMvsuLFGf5t2wHmIPGoAA
 C99mjyNUwvSnHaDopucaoJsnPl+o+qXV7O5E+hr7CZC17CPSIpy9pBVbwaldR/aFn8Lh
 hhVNA2PcPhtq85Req8eb5QmwHqDKXgdk+2YKLoKR539CCO6hEBVhKHVGKKBIY3oOMF7D
 g/7Vm78GLMivcs1J57BY31uhMpSThhyFZ6VYGqFjk5tUHlL2avIXEDfBPep/FudLRO2u
 IbaJyrJI+RUQjp6IDPSkoqxJXU6aTwCUl6uNdU4JQAZGatbWCQU1dCznk6h/FTq+erRf
 vtzw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787575208;
 s=strato-dkim-0002; d=goldelico.com;
 h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=hdl5+vuoxUtreZDmE2u1Lsb93eEflKwu+QkhnmGOsRo=;
 b=KqgQmWoRDt9PmsS2ug4Eg7BkIZRb0DmXcovm9m5EsKRhKXGqTk9x2H5qo6lFRFf6Yk
 plef576DlTNIFH6XAemNFC6+/HK8haWzEXh85XT+UMlgD4A4Jb5CJrysBOw7sV3o7fvK
 DuonmCaJ3rAFSPxuKemvQGffCzb+TyyEONsJtcu18/ydwQagmHDVOSGisuJfKCayGWom
 NiQ/MzXUFS0nALe8tq9uxViJ4cjK7CRUECXvnouObBhyXSifCaNtDVQawJixG89wVjnd
 NFJtLAXwLEPfZoYNGK3du8u7zbGFMoGjbNtyue4qloHmo8haMYSHeb4qIOpmtjoG6OvT
 VvLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787575208;
 s=strato-dkim-0003; d=goldelico.com;
 h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=hdl5+vuoxUtreZDmE2u1Lsb93eEflKwu+QkhnmGOsRo=;
 b=SJ45AIQ/zuG+8ASCxJUEaG4WRDC6RBoz1ocvCREXhdEBvgFQSbqphfDufWD8WtEDHv
 ckJqWa01DUUNoqhgSOBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQipoOy8iN9EQCaJvpc3APUCy9LxWOnfZGxS9c"
Received: from iMac.fritz.box by smtp.strato.de (RZmta 55.6.2 AUTH)
 with ESMTPSA id Qfefb327OCe7arf
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 24 Aug 2026 14:40:07 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Paul Cercueil <paul@crapouillou.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
 wbx@openadk.org, kernel@pyra-handheld.com,
 "H. Nikolaus Schaller" <hns@goldelico.com>, stable@vger.kernel.org
Subject: [PATCH v4] drm/ingenic: fix bridge allocation
Date: Mon, 24 Aug 2026 14:40:05 +0200
Message-ID: <1630a544a26fac0b87187885374ebe59fc92df3b.1787575203.git.hns@goldelico.com>
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

Notes:
    v4: remove setting interlaced mode (would be new feature and not a fix) as suggested by paul@crapouillou.net
    
    v3: fixed a malformed diff in v2
    
    v2: removed ib->bridge->ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT as suggested by Sashiko-reviews
        https://sashiko.dev/#/patchset/400ba2fe0d4f76484e929d2efaa32f67a940163a.1787477392.git.hns@goldelico.com?part=1

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 42c86f195c66b3..f3c6c823314688 100644
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
@@ -1314,10 +1314,23 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 
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

