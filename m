Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06CEC43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F34E610F621;
	Fri, 26 Jun 2026 13:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SOyy/pjD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CF610F618
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:57:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 816FB600C8;
 Fri, 26 Jun 2026 13:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4E71F000E9;
 Fri, 26 Jun 2026 13:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782482263;
 bh=j99cdnVISgJsHxpnr1RivSWJmnHt/Q5ccfIOzoVqcbo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SOyy/pjDlJi69LXw3OJGujtK7HaiNMm4TnuW/g4WhfNLvVMHA3LmdGydT1bSmUJRk
 onpCZCDj/T5xqzOs7JMHacrBON4HxCqkjDFEs7TdLMEwMdp4S7+jlb9vWXGChcXenm
 OU/mYlF6koC/cHy/0YjXiof1cy0eK/rO++KhQEAvtnkF0Ks/ILnog6pp265WLL6TDF
 RcTleMrYkx8JHKsgmYxF0RP2JAX3PPK+nVWdNhbB7e6FFcGOhuRd9HZOm0rzGaJCAs
 SlBtQPNLXYij6k+Vk7Jwwa9ooQ1EhMtT9ZPt/dcbTIOj1q8zaQZ4WRNEN+sqZp6gHL
 1mZqWqET4X9QA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 26 Jun 2026 15:57:08 +0200
Subject: [PATCH v3 07/30] drm/bridge: Implement atomic_print_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-drm-state-readout-v3-7-d5825e3299a8@kernel.org>
References: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
In-Reply-To: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=mripard@kernel.org;
 h=from:subject:message-id; bh=D4A2g2LA6oJb1p7XMJW9QwCJcKV5GOXFM9h5rqQ9a0g=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl2rSYZyqddbgQJbOj++NNjSeuCBAnmGTGPnn/ijlh4V
 qrUd2Jvx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjI7H+MtcLzlrT/E1ive6Pd
 InyjRcwsXTG7iQsXqFw3cMoL+1i0ZaX7nLKswDPHl1wVuNSzZOJVMcb6JEutxbv+Fjz72jjz4yP
 BxQWxx89zbSp0Mjglzf1WcveEGL/8wK1rd8yXPDhP92rgEtmrAA==
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
index b7b0ec7c2d4b..e6f1174be62a 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -548,14 +548,35 @@ drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
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
+	drm_printf_indent(p, 1, "input bus configuration:");
+	drm_printf_indent(p, 2, "code: %04x", state->input_bus_cfg.format);
+	drm_printf_indent(p, 2, "flags: %08x", state->input_bus_cfg.flags);
+	drm_printf_indent(p, 1, "output bus configuration:");
+	drm_printf_indent(p, 2, "code: %04x", state->output_bus_cfg.format);
+	drm_printf_indent(p, 2, "flags: %08x", state->output_bus_cfg.flags);
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
2.54.0

