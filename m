Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A02F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F046010F040;
	Thu, 23 Apr 2026 10:07:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oxnAAFWo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D6210F04D
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:07:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B4D4D4337C;
 Thu, 23 Apr 2026 10:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3CBC2BCAF;
 Thu, 23 Apr 2026 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776938858;
 bh=O2jp6irC66I/YKsexCxHrYpHywSRWdtHqF1jtIfmIX4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oxnAAFWoaKiD0IdkUxTtUI6ZQGNGtrdv/iFpDePHaywyDi9IOXXuRVj2DNkyQ3uqS
 96FQtqNB4B4ROWib+9sWpqqAJoWk1kTBzZW05qNtHNL74hMH94dML0UzJjtlpd2xJY
 8nI38qqqvJnpSYy4ckd/sGUI+3bd24euYlvNsnx8tWojswNctnUGX/ilRUTfMrNQa8
 3yaCTWksEL4uv7rLH4tHdN02GYm2bDX3rGeEQtMp/sliObWcNSs0vcPvpkLuGNR9LI
 /XUaXNoMopaheME0zcs79HAPDy8Z4zy6ppFyfOVNCeM2QQZJDfXAELbhBUuDRdf2Dv
 0A//ky+bm657w==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:06:45 +0200
Subject: [PATCH v2 07/28] drm/bridge: Implement atomic_print_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-7-6cde1a9910ed@kernel.org>
References: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=mripard@kernel.org;
 h=from:subject:message-id; bh=O2jp6irC66I/YKsexCxHrYpHywSRWdtHqF1jtIfmIX4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkv33vK1/gzpgTyTOmX8nzb6DR97kW1vwsnX6zYpMYwN
 Y+xt3x/x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI9ifG+qCYU2vvC6+qNksP
 vZsXuOSY+97b6esN309PSNhS/C7sU4r7mpZ1C559NGTiD05Qkbimy1ine3fjBoEnM2eXzpiu1zz
 jky17WpqFzX7JpJMqr4+WlGyImjshn2dtYizXu71B4WfLlq8FAA==
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

Bridges have some fields in their state worth printing, but we don't
provide an atomic_print_state implementation to show those fields.

Provide one.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 5b8e171afbe5..fba440bddcb3 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -506,14 +506,35 @@ drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
 		return ERR_CAST(state);
 
 	return &state->base;
 }
 
+static void
+drm_bridge_atomic_print_priv_state(struct drm_printer *p,
+				   const struct drm_private_state *s)
+{
+	const struct drm_bridge_state *state = drm_priv_to_bridge_state(s);
+	struct drm_bridge *bridge = drm_priv_to_bridge(s->obj);
+
+	if (bridge->of_node)
+		drm_printf(p, "bridge: %ps (%pOFfc)\n", bridge->funcs, bridge->of_node);
+	else
+		drm_printf(p, "bridge: %ps\n", bridge->funcs);
+
+	drm_printf(p, "\tinput bus configuration:");
+	drm_printf(p, "\t\tcode: %04x", state->input_bus_cfg.format);
+	drm_printf(p, "\t\tflags: %08x", state->input_bus_cfg.flags);
+	drm_printf(p, "\toutput bus configuration:");
+	drm_printf(p, "\t\tcode: %04x", state->output_bus_cfg.format);
+	drm_printf(p, "\t\tflags: %08x", state->output_bus_cfg.flags);
+}
+
 static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_create_state = drm_bridge_atomic_create_priv_state,
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
+	.atomic_print_state = drm_bridge_atomic_print_priv_state,
 };
 
 /**
  * drm_private_obj_is_bridge - check if a private object backs a bridge
  * @obj: private object to check

-- 
2.53.0

