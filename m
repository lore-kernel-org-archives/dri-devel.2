Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EA3F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0205E10F07B;
	Thu, 23 Apr 2026 10:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aHwuW3iM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E8010F07A
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:19:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EEAC40189;
 Thu, 23 Apr 2026 10:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF700C2BCAF;
 Thu, 23 Apr 2026 10:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939576;
 bh=DtbejoZC6kHnpLa4bta4bjDRktLOYJqY8pkgAwDp6dI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=aHwuW3iMDmYxr/k7TxjjA+CLx9VTcaB5w/QMsXHKAsrlLKvPmBN6Uz1C/qhf4poxU
 fOwDzwoWMS4YNmJRbJw0/pEdt2/1AZo5cwVYwwtL2+WeAzH3rkT5MROEFcP/teDVkO
 xubQkDMGeQ88koflCpRT2kKH8h2jjchq4yssnv43nW0Nh6UzZUVK+fW21SjbOJi99T
 wbStNrNgGCSrDJnupVf66Odr7yY2Hj+ZKnI3Zfmg5fqWlGE/RiSML5cONEkzNgPSNQ
 MBz1VZC/qcLhT1OKjxY2QSUvhy0bZCza9LNKekBIUO2G/OkB2FoXCTu3x+PTU0m7Xk
 vMI5ML99+Ne2A==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:36 +0200
Subject: [PATCH v2 23/28] drm/bridge: display-connector: Implement readout
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-23-8549f87cb978@kernel.org>
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2411; i=mripard@kernel.org;
 h=from:subject:message-id; bh=DtbejoZC6kHnpLa4bta4bjDRktLOYJqY8pkgAwDp6dI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP35MvZ51QdlSxE9BVN8qUPHXqhIzTv/enP+zHHzOr
 PCLm9DQMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACay7xhjw9lvKfN6V5WuV3NZ
 2FUceGaGvPZv85VnmflV7OyMFyVZP5rSbneYe1/Qnfw98w4HFBsHMzY8zrbnSpjD5zw1iSNDyiJ
 A59WKlxnFalfqGi4G32VcKH3t0Cp3Cd7/u+e79V0LkxZmlgUA
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
index 16c0631adeb1..94b645248368 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -12,10 +12,11 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_sro_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
 
 struct display_connector {
 	struct drm_bridge	bridge;
@@ -173,19 +174,33 @@ static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
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
 	.edid_read = display_connector_edid_read,
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
2.53.0

