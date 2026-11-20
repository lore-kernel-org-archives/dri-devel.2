Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A361606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XX7M7eGp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3324E1129E3;
	Fri, 20 Nov 2026 12:56:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5FAF1129D4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:55:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9E511407D5;
 Fri, 20 Nov 2026 12:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21161F000D0;
 Fri, 20 Nov 2026 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179347;
 bh=aHyKLaotYrta9dHe6os3oFUYWolkJVCwpauJUL0qeEw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XX7M7eGpp1qb4OfISizhbnLeaZ0W3CxTucona3OOpoKvlmQvryJ+txHrP9P5trFiY
 AXa79/Ar03DD75wv8cK/MLoX8cX+ZRiQhDHhO/xlUkKCXMajwfdTsOCmGYBOxwtek5
 GMFjTiY8PnUF/g3Vc1Hoxsf+1f0yLvmuPFtgsn8OGuasRseI6Uxyd2pnGGi9kQs+rL
 u+vvb52CK9TDyPtH7tAoYg38sGq8SqT6wnkswJ6XL/aJjjMKvAANwXUvmbQtDpC9kq
 U4u0Cnpox9NsnoggCdK1DWPbQBEf5c8nRcq9A6mEo8Naj/f7QClNuycuMH8RMB7C8y
 9Oi8ngeLrNzpA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:00 +0100
Subject: [PATCH v9 08/42] drm/bridge: Switch print_state to use bridge name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-8-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=mripard@kernel.org;
 h=from:subject:message-id; bh=RzbvfFKgraky1EOikPtR99h+tOMXUdm2gU+y4PHwurU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzmrHWs6vOp//0b/OliFlTsv7v0U+p8Tl+o9IXfjcP
 CGWd3ppx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiI9HrGGu7uP/O9Jh3a7ygb
 FNIzZ4vo1aMsX31MfpQK9YXpJX0Ol86fZnfHLkF15sWf9k6KRmrrGeuDdiV4n1nXkHSoovRRXou
 vWc/Xlqkxe3jfXi0uqJ6j3XaEwSwva9at52/3PovvD/meHQkA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_bridge_atomic_print_priv_state() currently identifies bridges by
printing the symbol name of bridge->funcs using the %ps format
specifier. This produces output like a raw function pointer name, which
is not particularly user-friendly for debugging.

Since bridges now carry a human-readable name, switch to printing
bridge->name instead. This makes the state readout output more
consistent and easier to interpret.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 11aaa4ae5102..aed3fcf0e180 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -570,13 +570,13 @@ drm_bridge_atomic_print_priv_state(struct drm_printer *p,
 {
 	const struct drm_bridge_state *state = drm_priv_to_bridge_state(s);
 	struct drm_bridge *bridge = drm_priv_to_bridge(s->obj);
 
 	if (bridge->of_node)
-		drm_printf(p, "bridge: %ps (%pOFfc)\n", bridge->funcs, bridge->of_node);
+		drm_printf(p, "bridge: %s (%pOFfc)\n", bridge->name, bridge->of_node);
 	else
-		drm_printf(p, "bridge: %ps\n", bridge->funcs);
+		drm_printf(p, "bridge: %s\n", bridge->name);
 
 	drm_printf_indent(p, 1, "input bus configuration:");
 	drm_printf_indent(p, 2, "code: %04x", state->input_bus_cfg.format);
 	drm_printf_indent(p, 2, "flags: %08x", state->input_bus_cfg.flags);
 	drm_printf_indent(p, 1, "output bus configuration:");

-- 
2.56.1

