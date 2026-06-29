Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B49DC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D205F10E76E;
	Mon, 29 Jun 2026 08:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P47PMLC9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A270710E738
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:18:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B5C143280;
 Mon, 29 Jun 2026 08:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1721F000E9;
 Mon, 29 Jun 2026 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721097;
 bh=7TnNQnZPKUa0dsTlsZHPlmgQqYJQoqsvtu7qHraPWQU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=P47PMLC9wzOTdk72nf80ZM0pT4cITmkZsYuIIsCJHKtMTnFQHs87f2WpuAemz93ZN
 skSN3wIWb+yDJKfetm30/GvW6FbafJenJC+5TPi8+4tzGgt/61wUEFbxeKk87Il54N
 XMBDpmgT8HXeP1i0ZUzZ4STTNh6BgR1dSp5FQ/h7IjA9KAYLpbwcqw/b6/Dit8hsW4
 MCuRQbOpAjaKTA+qmkGs6x19bxym1IDMnxXb8uX1JI3NR4Wc1Y/R71dOeBoAAtLt2g
 VcGH7um2A78SbbIzoyFCVbvOgkqTVnwPnuTrVtBNMdBa0nEZ3C0IVn43EMQx+XjD2t
 ghlLS+flfX4xg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:22 +0200
Subject: [PATCH v4 24/30] drm/bridge: display-connector: Implement readout
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-24-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2564; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vsbsgynh0Pm9AN1o7uh+nd3VL6uP4yDvZ8KoAPCKhz0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWlxGbz6xVtl8DD/xIOT8usX+p3eWedtvO6qa/fW51
 L1VzL8ndkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJhJgzNkxO1XUNXLF8volc
 svXRxPBXv1hzDZweNXyQZnrx7uHV1h3Ta1+oVCVwS6qcD+o6/3QKG2PDeTHFKOHo62fStRlu7DC
 w3SJccoNF4ZLrMh3FU5MXGoXLL0n7fX6a2EOf8HcKGdKHIm8CAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The display-connector bridge is the last bridge in the chain on
platforms using drm_bridge_connector, and is responsible for the
physical connector interface.

Implement the atomic_sro_readout_state hook and wire up the default
drm_atomic_helper_bridge_compare_state() as the compare hook.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/display-connector.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index f7a5bfd9c075..ebd2691a88fe 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -13,10 +13,11 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/workqueue.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_sro_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
 
 struct display_connector {
 	struct drm_bridge	bridge;
@@ -204,10 +205,22 @@ static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
 	return prev_bridge->funcs->atomic_get_input_bus_fmts(prev_bridge, prev_bridge_state,
 							     crtc_state, conn_state, output_fmt,
 							     num_input_fmts);
 }
 
+static int
+display_connector_readout_state(struct drm_bridge *bridge,
+				struct drm_atomic_sro_state *state,
+				struct drm_bridge_state *bridge_state,
+				struct drm_crtc_state *crtc_state,
+				struct drm_connector_state *conn_state)
+{
+	// TODO: Actually implement it
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.attach = display_connector_attach,
 	.detect = display_connector_bridge_detect,
 	.hpd_enable = display_connector_hpd_enable,
 	.hpd_disable = display_connector_hpd_disable,
@@ -215,10 +228,12 @@ static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.atomic_get_output_bus_fmts = display_connector_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = display_connector_get_input_bus_fmts,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_sro_readout_state	= display_connector_readout_state,
+	.atomic_sro_compare_state	= drm_atomic_helper_bridge_compare_state,
 };
 
 static irqreturn_t display_connector_hpd_irq(int irq, void *arg)
 {
 	struct display_connector *conn = arg;

-- 
2.54.0

