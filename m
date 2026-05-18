Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E5FCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 752E510E892;
	Mon, 18 May 2026 19:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Y5G1HKQH";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DC910E84B
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1779133694; bh=FchV9glvh5UhWTEiURTz/glfciz9Vw2jj22qgC9Vt+M=;
 b=Y5G1HKQH6Uk7xEZaUKO8lp5jnNf7m0PcTbjKUI9+VnugjUIIpihK/NNPr0h2CF+qR+XT80s/1
 t90d9FeB4hRU7wvKimx2/o6wyMaBzcLysd9lSeUoBr+eGUGqEHE0k66JwvkKLqk0hOSEdHNetu+
 jwAehjih7+Ja94h/QpUCUh0EnAncbSKl4Ba7edcBrUUtQoKeBjSvwbxTGpPF1G52qprJP2jx6Kx
 PaxNjmWDlxeuv6Saq/gZ1XmmEHWtvO6U9Ix7xeqzOHw827ZudMsfPZF41cvpHl9reVj7SR4HS0u
 IGNoDDVXSkTNezjKkFV0+FPgQhNN0qa91BYiz1dYOptg==
X-Forward-Email-ID: 6a0b6cf9b74b0ebd362eee90
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org
Subject: [PATCH 04/13] drm/meson: dw-hdmi: Drop call to drm_bridge_hpd_notify()
Date: Mon, 18 May 2026 19:47:32 +0000
Message-ID: <20260518194744.2483580-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518194744.2483580-1-jonas@kwiboo.se>
References: <20260518194744.2483580-1-jonas@kwiboo.se>
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

Calls to both drm_helper_hpd_irq_event() and drm_bridge_hpd_notify() in
the IRQ handler causes multiple hotplug uevents and modesets during an
HPD interrupt.

Change to only call drm_helper_hpd_irq_event() in IRQ handler to ensure
only one hotplug uevent is triggered when the connection status or EDID
has changed.

The bridge connectors detect() func help ensure that any hpd_notify()
func is called for all bridges in the chain.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 9aafdc768f2b..30099bf71aad 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -521,17 +521,8 @@ static irqreturn_t dw_hdmi_top_thread_irq(int irq, void *dev_id)
 
 	/* HPD Events */
 	if (stat & (HDMITX_TOP_INTR_HPD_RISE | HDMITX_TOP_INTR_HPD_FALL) &&
-	    dw_hdmi->bridge) {
-		bool hpd_connected = false;
-
-		if (stat & HDMITX_TOP_INTR_HPD_RISE)
-			hpd_connected = true;
-
+	    dw_hdmi->bridge)
 		drm_helper_hpd_irq_event(dw_hdmi->bridge->dev);
-		drm_bridge_hpd_notify(dw_hdmi->bridge,
-				      hpd_connected ? connector_status_connected
-						    : connector_status_disconnected);
-	}
 
 	return IRQ_HANDLED;
 }
-- 
2.54.0

