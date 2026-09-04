Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BADC61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9922310FA2F;
	Fri,  4 Sep 2026 10:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E1IJbec/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4155010FA2F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 10:17:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2853D6020A;
 Fri,  4 Sep 2026 10:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7AF7C2BCC7;
 Fri,  4 Sep 2026 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788517041;
 bh=vXy3dTG8NU1XKB5YaVHYVFYOlsItcROkxlpr8aDEbhQ=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=E1IJbec/pSXWAwq86b7ICBeXZft4k62I+SwenIroshzCPGVoHYZp405CnB3+Ql7sv
 Fvz/ZYigkaC487jcTesGK62C1govSgdDa4VkBwuSKSt8BdFXYMoDtMmYFzfa1fDwqN
 4Nrf4f/lUYYWum81Jdfo0xRxVA9fquSrJiduuZTnW3BnkwCXbbc8iO1FUXUBtUYfq+
 jIUf8WdHdxlZ8lZ/XiiD3tj/VXBQysXVla6n11X7i2I9RiuioLbB2vcIqhEDc5Q8s1
 pAPwejT1fe2l2g6cDVs88AzO/HuG85/VoX7hN3iBRcsQYfiI2ZodnmTBzlRxQxb1JV
 Kj9stjPMvSekw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A3082C61DD6;
 Fri,  4 Sep 2026 10:17:21 +0000 (UTC)
From: Johan Jonker via B4 Relay <devnull+jbx6244.gmail.com@kernel.org>
Date: Fri, 04 Sep 2026 12:17:19 +0200
Subject: [PATCH v3] drm/rockchip: rk3066_hdmi: convert to
 devm_drm_bridge_alloc() API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-drm-v3-1-5b36532a3b72@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK6ammoC/x2MSwqFMAwAryJZv0Kx/q/ycBHbqFlYJRERxLtbX
 Q4zzAVKwqTQZRcIHay8xgTul4GfMU5kOCSG3OaVbW1hgiymDXXjSu8chgpSOaCSGQSjn992Qd1
 JXrEJjXx++39/3w/ouI4PbgAAAA==
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?H=C3=BCseyin_BIYIK?= <boogiepop@gmx.com>, 
 Johan Jonker <jbx6244@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788517040; l=1613;
 i=jbx6244@gmail.com; s=20260824; h=from:subject:message-id;
 bh=qWT53GXoOigdQ+erxp3d408shOqYOF+aDMQefkq/Jcs=;
 b=IGdDcQbuWqvrHDkGDHwvL4L5TmWy9kQdIO4Ze6skcvw1cYPzJMVH8k/kHGr0/8asjWG9BamhJ
 SAP9yAsgbn2AWzCty0wEJWmCHyyJubNkEO7HMxCWnoIbvNrG3T8Lzmh
X-Developer-Key: i=jbx6244@gmail.com; a=ed25519;
 pk=MK5Flx1ndjAF0uwXdNm8VvvoghD4KWCNd2hQE8QGyl0=
X-Endpoint-Received: by B4 Relay for jbx6244@gmail.com/20260824 with
 auth_id=971
X-Original-From: Johan Jonker <jbx6244@gmail.com>
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
Reply-To: jbx6244@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Hüseyin BIYIK <boogiepop@gmx.com>

The function devm_drm_bridge_alloc() is the new API for allocating DRM bridges.
This conversion was missed during the initial conversion of all bridges to
the new API.

Signed-off-by: Hüseyin BIYIK <boogiepop@gmx.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V3:
rebase
remove driver_private
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index f28d6a883e09..05dbbcc6f7b0 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -702,8 +702,6 @@ rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
 	drm_encoder_init(drm, encoder, &rk3066_hdmi_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
-	hdmi->bridge.driver_private = hdmi;
-	hdmi->bridge.funcs = &rk3066_hdmi_bridge_funcs;
 	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT |
 			   DRM_BRIDGE_OP_EDID |
 			   DRM_BRIDGE_OP_HDMI |
@@ -747,9 +745,10 @@ static int rk3066_hdmi_bind(struct device *dev, struct device *master,
 	int irq;
 	int ret;
 
-	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
-	if (!hdmi)
-		return -ENOMEM;
+	hdmi = devm_drm_bridge_alloc(dev, struct rk3066_hdmi, bridge,
+				     &rk3066_hdmi_bridge_funcs);
+	if (IS_ERR(hdmi))
+		return PTR_ERR(hdmi);
 
 	hdmi->dev = dev;
 	hdmi->drm_dev = drm;

---
base-commit: 9d80aa4617b32f5054c5aa471d06b66704854935
change-id: 20260904-drm-9d7835c33ad6

Best regards,
-- 
Johan Jonker <jbx6244@gmail.com>


