Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E0EC55181
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C2210F316;
	Fri, 31 Jul 2026 16:19:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IPvyMHq2";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDAA10F2FC
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514763;
 bh=CUcoRbmERGYIeO3Z961lPfNQR8EGzDg1msKbqGRYj2s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IPvyMHq2SUa2dC6Oc6b/P3NBBztmzXSQ/OxKtkYdzszJfrag3HPOu8EVb6tjH0vOB
 3+mrjfxjtxuBjKPFxwnHfsc6W3AJAlesJWrRlgDj7vyU+d+hGKmQBBEq9IUoBRRzIB
 lq5QJtf0jlyChJHs9J+G9dGHyva8/clwp7iRc7lGCXCBFxozyLGtJ9y97jnrxt7jVX
 a+I1GzGSTeraQm7E1YbznmlMPIU+DKbop/0EvHj+xu+yTs7ZNGq6vt1DHK1qgni31Y
 SdqA4+FxVAjVSs1aIqLgKkrUyqkMlHKUuQdLm3gZGp/xbloeFQg+kjiySmMF8PRKp9
 1uLCTDJ7wAWRg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6322517E092C;
 Fri, 31 Jul 2026 18:19:23 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:19:19 +0300
Subject: [PATCH v10 12/69] drm/bridge: Fix unlocked list_del in
 drm_bridge_add()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-12-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
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

When re-adding a bridge that was previously removed, drm_bridge_add()
drops it from bridge_lingering_list without holding bridge_lock.

Both bridge_list and bridge_lingering_list are protected by bridge_lock,
as they are concurrently modified by drm_bridge_remove() and
__drm_bridge_free(), and walked by the debugfs 'bridges' file.  Running
the list_empty() test and the list_del_init() outside of the lock may
therefore corrupt either list.

Perform both under bridge_lock.

Fixes: 17805a15d175 ("drm/bridge: add list of removed refcounted bridges")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260723015004.1F5711F000E9@smtp.kernel.org/
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_bridge.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index afaae272347c..8b8f71c3ccff 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -21,6 +21,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -454,8 +455,10 @@ void drm_bridge_add(struct drm_bridge *bridge)
 	 * in bridge_lingering_list. Remove it or bridge_lingering_list will be
 	 * corrupted when adding this bridge to bridge_list below.
 	 */
-	if (!list_empty(&bridge->list))
-		list_del_init(&bridge->list);
+	scoped_guard(mutex, &bridge_lock) {
+		if (!list_empty(&bridge->list))
+			list_del_init(&bridge->list);
+	}
 
 	mutex_init(&bridge->hpd_state_mutex);
 	mutex_init(&bridge->hpd_mutex);

-- 
2.55.0

