Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EA7C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9D010E6CE;
	Tue, 14 Jul 2026 11:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="agqwkmL0";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21CD10E6CE
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 11:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784029489;
 bh=ydoTSNpvbYYrQu7+7L4wOkYZ6e235H5lyowps7msh+o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=agqwkmL0ZbtE/MF6tJ+RYet4e7DMhoyxhLJWbwJCrFR45hQOVv0jcvSD2PwPNglx7
 FR6RNYivoo6sVQ9+RoAyo6UUPoD60l+bgufTlxv5nryf2pN6bWfRrqGFbFV3O80NQi
 wqzBkVBnX9OeXuCpuUThnqon8Koo2b5p5raJlu2ZnZlI25zJ6gULig42tYXIJV0zDY
 xsdByrT3pSA+X/VB8oWSSlnTwj84dXyUAVAzMbxnHMX+zR3HkKLnsvEQJiDnvA0x0A
 khQWg75rckOUjQ0Oke7UtGmYgrLMxstrgGHclRLiJGiBP5jzA75/PvFJIQsLvezbB0
 KcHp4LHU6Fcvw==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C848817E0E6C;
 Tue, 14 Jul 2026 13:44:48 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com,
 jason-jh.lin@mediatek.com, kernel@collabora.com
Subject: [PATCH v2 16/46] drm/mediatek: mtk_hdmi_v2: Don't warn on RPM active
 during detach
Date: Tue, 14 Jul 2026 13:43:44 +0200
Message-ID: <20260714114414.184512-17-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
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

The Runtime PM may be active during bridge .detach() and this
happens especially at boot, when probe deferrals in the display
controller driver happen.

Even though it looks safe to assume that RPM has to be inactive
at that time, this happens to be true only if the DDC was to be
handled internally (like before .hpd_{en,dis}able() existed).

At this point in time, this driver uses HPD callbacks, and for
HPD to actually work it is necessary to raise the RPM refcount
to wake up the entire HDMI IP: since it's not granted that the
HPD or other children of the HDMI node are disabled during the
display controller probe sequence, the WARN at bridge .detach()
time may trigger (and will do that when mediatek-drm defers),
unnecessarily bloating the kernel log, as the RPM refcount will
be decreased anyway when removing the driver.

This is why the WARN(pm_runtime_active()) check during detach
is simply a development stage leftover: remove it!

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
index d9316d30fd5f..b4c09a70c427 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
@@ -995,8 +995,6 @@ static void mtk_hdmi_v2_bridge_detach(struct drm_bridge *bridge)
 {
 	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
 
-	WARN_ON(pm_runtime_active(hdmi->dev));
-
 	/* The controller is already powered off, just disable irq here */
 	disable_irq(hdmi->irq);
 }
-- 
2.54.0

