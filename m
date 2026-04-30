Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B661FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54E610F2A0;
	Thu, 30 Apr 2026 08:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Qr0oDWFb";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BEA210F2A0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:53:58 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 802561F9C9;
 Thu, 30 Apr 2026 10:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1777539237;
 bh=mSpKrJuNs0Eacdj1sbb1Hdc61jJMh4Y5swZU+YKDLDI=; h=From:To:Subject;
 b=Qr0oDWFb/frwXYDKKmOCtZcMVmKUQzTcnP32P4zSSLMmzltZ9VEv7i5k1sCC7g0ep
 kNfLq2oQkawi1fPiuINzsyompyN/3m2QDYJKVo3w4x++ZNrDcyBPf740+zRItyMm0E
 zG23YBfFL07ukgLunxdiNymxfsEViTK7wQnxWi+BgGF3esnwXy1fyGAybYWa29GT4q
 0M4NWuPtCUBaDUOnhtKzWt9QT3DGnXbmkoNNapUsLcPE+e4vLLkqw2tjavQH9iTtOw
 qUCEoNIDi0DTpWgyml41KddwPMsm+CYAQPGscTzC3B3R/hlww88kOVcftbFrUBA7tO
 YA8wfY/8TC/Ow==
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH] MAINTAINERS: Update maintainer for LT8912B DRM HDMI bridge
Date: Thu, 30 Apr 2026 10:53:42 +0200
Message-ID: <20260430085344.34271-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Update the maintainer from Adrien to Francesco.  Adrien is not
interested in maintaining this driver anymore, Francesco has access to
various hardware devices using this component and the vendor
documentation.

Cc: Adrien Grassein <adrien.grassein@gmail.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..bcfb13b612bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15019,7 +15019,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
 F:	drivers/hid/hid-lg-g15.c
 
 LONTIUM LT8912B MIPI TO HDMI BRIDGE
-M:	Adrien Grassein <adrien.grassein@gmail.com>
+M:	Francesco Dolcini <francesco@dolcini.it>
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
 F:	drivers/gpu/drm/bridge/lontium-lt8912b.c
-- 
2.47.3

