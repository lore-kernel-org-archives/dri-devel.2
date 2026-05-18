Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B00CCD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D7610E8A5;
	Mon, 18 May 2026 19:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Xm1RRIvl";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E09B10E892
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1779133696; bh=4zO/JslR4dtpUare48IWPEh7zby/iEoySFzUlGPOX5Q=;
 b=Xm1RRIvlneLKo+MJPLt0y+1SHu9y2lZ38caWkROcsXT+ge3MPxeCmq6IKTxWk0QZhgY09cS3l
 mJd7Oylttqr3GyLxuYOCmpGrijiPj1lq4mopK1DViSf3Bf9CyU522qAQAaK+GzlzK/8ZbRube9e
 VFyuPnPffjxCv8Jd0swQB/e+nq3ZESj1Rds2xDfka/8N6SS6rdzY/X8sp3sGhMqsHEmPSHFsS6b
 frK+btL9otbYgWfnhFP/DM18NB+o8mZiob4yW1yI+bqEnb0aSANpTy0gnS+lkYTmQyae+jR+M0j
 l/vr/fO43NiXFpGZ2gNXwxaMqp6MNKuVpNMuiiEA7YsA==
X-Forward-Email-ID: 6a0b6cfdb74b0ebd362eeeab
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
Subject: [PATCH 05/13] drm/meson: encoder_hdmi: Use CEC phys addr from
 display_info
Date: Mon, 18 May 2026 19:47:33 +0000
Message-ID: <20260518194744.2483580-6-jonas@kwiboo.se>
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

The dw-hdmi bridge detect() func now updates EDID for the connector.
Something that ensures that display_info.source_physical_address has an
updated CEC phys addr when the hpd_notify() func is called.

Change to use display_info source_physical_address directly instead of
re-reading EDID to set the CEC phys addr at HPD interrupt.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 26 ++++------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 55c0601df3c6..1b9a1d9ed3d3 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -330,28 +330,10 @@ static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
 	if (!encoder_hdmi->cec_notifier)
 		return;
 
-	if (status == connector_status_connected) {
-		const struct drm_edid *drm_edid;
-		const struct edid *edid;
-
-		drm_edid = drm_bridge_edid_read(encoder_hdmi->bridge.next_bridge,
-						encoder_hdmi->connector);
-		if (!drm_edid)
-			return;
-
-		/*
-		 * FIXME: The CEC physical address should be set using
-		 * cec_notifier_set_phys_addr(encoder_hdmi->cec_notifier,
-		 * connector->display_info.source_physical_address) from a path
-		 * that has read the EDID and called
-		 * drm_edid_connector_update().
-		 */
-		edid = drm_edid_raw(drm_edid);
-
-		cec_notifier_set_phys_addr_from_edid(encoder_hdmi->cec_notifier, edid);
-
-		drm_edid_free(drm_edid);
-	} else
+	if (status == connector_status_connected)
+		cec_notifier_set_phys_addr(encoder_hdmi->cec_notifier,
+					   connector->display_info.source_physical_address);
+	else
 		cec_notifier_phys_addr_invalidate(encoder_hdmi->cec_notifier);
 }
 
-- 
2.54.0

