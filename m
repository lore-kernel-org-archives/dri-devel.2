Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C646CD4F57
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA49210E8C9;
	Mon, 18 May 2026 19:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fVOt15Be";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C87010E8C9
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1779133729; bh=P1OIqjzoD97WJDMvkcHJxKFh2vpQep87U1vwwejFjdw=;
 b=fVOt15BeTWyTPIU2qQfZ6QRyqwW0EiB9CMAkNgnY3DbjtAfYCyCp8DhJ8KvaGOXYoW461GUd7
 xH9RsHbGX0ilnzCMKGrlFWH25E1d/xmRETq8x/8bvFSNMTgf9Urn7yMTZvdKClvvdEwMvlkKX3o
 zNld1lspSzw97TtjqwV8PBMLpNtQqrI1trupptwicuWSXj82CnKrMKObKINSpsnNyDgdWd10H3O
 UQoSGJDwlo3n25vjYZIQesL3EBzA1KlZ9Br8RHtjaYdWvUpan//4X8NS2WQHR9JlkS4u62QztJt
 BJfQ3fCAsZyW5Ba+NJO6zTR7WZ5ZIjZsGwNi11wotujg==
X-Forward-Email-ID: 6a0b6d1cb74b0ebd362eef6a
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
Subject: [PATCH 12/13] drm/meson: dw-hdmi: Use dw_hdmi_schedule_hpd_work()
 helper
Date: Mon, 18 May 2026 19:47:40 +0000
Message-ID: <20260518194744.2483580-13-jonas@kwiboo.se>
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

Change to use the dw-hdmi HPD delayed work to handle HPD events.

Also merge top and bottom half IRQ handlers to simplify IRQ handling now
that HPD event is handled using a delayed work.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 1dd59196ff7f..7b465e216759 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -145,7 +145,6 @@ struct meson_dw_hdmi {
 	struct reset_control *hdmitx_apb;
 	struct reset_control *hdmitx_ctrl;
 	struct reset_control *hdmitx_phy;
-	u32 irq_stat;
 	struct dw_hdmi *hdmi;
 	struct drm_bridge *bridge;
 };
@@ -498,10 +497,10 @@ static irqreturn_t dw_hdmi_top_irq(int irq, void *dev_id)
 	stat = dw_hdmi->data->top_read(dw_hdmi, HDMITX_TOP_INTR_STAT);
 	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_INTR_STAT_CLR, stat);
 
-	/* HPD Events, handle in the threaded interrupt handler */
+	/* HPD Events, handle in delayed work */
 	if (stat & (HDMITX_TOP_INTR_HPD_RISE | HDMITX_TOP_INTR_HPD_FALL)) {
-		dw_hdmi->irq_stat = stat;
-		return IRQ_WAKE_THREAD;
+		dw_hdmi_schedule_hpd_work(dw_hdmi->hdmi);
+		return IRQ_HANDLED;
 	}
 
 	/* HDMI Controller Interrupt */
@@ -513,20 +512,6 @@ static irqreturn_t dw_hdmi_top_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/* Threaded interrupt handler to manage HPD events */
-static irqreturn_t dw_hdmi_top_thread_irq(int irq, void *dev_id)
-{
-	struct meson_dw_hdmi *dw_hdmi = dev_id;
-	u32 stat = dw_hdmi->irq_stat;
-
-	/* HPD Events */
-	if (stat & (HDMITX_TOP_INTR_HPD_RISE | HDMITX_TOP_INTR_HPD_FALL) &&
-	    dw_hdmi->bridge)
-		drm_helper_hpd_irq_event(dw_hdmi->bridge->dev);
-
-	return IRQ_HANDLED;
-}
-
 /* DW HDMI Regmap */
 
 static int meson_dw_hdmi_reg_read(void *context, unsigned int reg,
@@ -715,9 +700,8 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_top_irq,
-					dw_hdmi_top_thread_irq, IRQF_SHARED,
-					"dw_hdmi_top_irq", meson_dw_hdmi);
+	ret = devm_request_irq(dev, irq, dw_hdmi_top_irq, IRQF_SHARED,
+			       "dw_hdmi_top_irq", meson_dw_hdmi);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to request hdmi top irq\n");
-- 
2.54.0

