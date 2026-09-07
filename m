Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BDCC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E027C10E519;
	Mon,  7 Sep 2026 13:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OaseIYjO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A42D10E519
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:24:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0324342E19;
 Mon,  7 Sep 2026 13:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551191F00A3A;
 Mon,  7 Sep 2026 13:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787463;
 bh=qxtiPmXvl0hDlbr/2+Q2I7B/id4qHbenQA9vnhvepYQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OaseIYjOhUMub2FA1cC8ms5L5bqgLpkZdOhELzWuvPfSnKxRjEf1mgB1kQDggi3Z1
 OA/kITld7euparalLIU8C0bixoMJMfEmDR63aK9C+gJdpuFaO6KakdStuQ2m5TXLPW
 7E/sQS+u8AeZCNHS52XQ7ZiYTaFwooBDb4qGdDWwjqg1ip8xYHXuCGQB6RoZRhlW3R
 lQeicsinEOfCCM9Ww8pZAmQhYsNdSUc7wxI6F/PojmgFZAXRqTqO6lC6MAXDHuk3km
 Uk1w5ogks/o4wph2ZEBMNtP09AdXzixhPHytgU++M3q3ESJIZk2uVG6aqF1SqAkqPF
 xp241bkqB/JoQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:23:42 +0200
Subject: [PATCH v5 06/33] drm/bridge: Implement atomic_print_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-6-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
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
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BBn6PKaEJiUn5Mx6IMfVyXrA99VGlWjtWAqM/8+jfck=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdj1gvyt2ZO3xC2Knsz0+y+8oS/mkvXrHp8goPcfVD
 /6r3He42jGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmsu8DY8Pz841zVTIjN/7Z
 tVH4rJZwkrfJhe77OgH/7ost/JrfUJbzNGqVX2P9ET5H49Os301M7RjrPUJ3qnvsO18+g+V/ZL2
 ehKr9/mqr2fLz5gvn7pgu+mXfG/WDNx8wZD+7sUnlU8mbP5MWAgA=
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
index 186a4c14faef..177f018dd3ff 100644
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
2.55.0

