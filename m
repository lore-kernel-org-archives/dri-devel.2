Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E4EF99362
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35C510F066;
	Thu, 23 Apr 2026 10:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WlowFePK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E77C10F068
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:18:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8678260120;
 Thu, 23 Apr 2026 10:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE446C2BCB6;
 Thu, 23 Apr 2026 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939530;
 bh=O2jp6irC66I/YKsexCxHrYpHywSRWdtHqF1jtIfmIX4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WlowFePK7t+bJe6d8YglFkf4eB3adOhoArZgR8Al+Qa3paOKlEmEGrWTxKKRO9p9t
 fMlZubCMmGPODtcCTbFev8EhWlRBcogQDAbOR5a8SbYCJlgXBjkIftB1dNpfJ7sQCX
 1XE+ich0FfgfkELrWYk/a5RFdHoOOPxeEIIHSG8Go3Ma0TRc4iBA308YyVuTFqChKs
 Hfzgn1a6XIShvzCRO0s0XXhLueWb6ZEJN1L1FDUWP9lcG3GbwFBTnEJMYK9dlusUOH
 xxodFt4LYpIqOnkx+CQbWLim5dftcaVl7yY0TEAVpaCjYEFO1br5t4YZYp8ua3I5tt
 RMgsYvebqNujA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:20 +0200
Subject: [PATCH v2 07/28] drm/bridge: Implement atomic_print_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-7-8549f87cb978@kernel.org>
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
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=mripard@kernel.org;
 h=from:subject:message-id; bh=O2jp6irC66I/YKsexCxHrYpHywSRWdtHqF1jtIfmIX4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP76apS/3tH/FVZZ7cgeKP0xu2sqZxsj2/V7j7Rcv1
 dU6BBkPdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJSAox1vC0337Wlab8jEfh
 tOeT2i08Sx9MnXpaWaruOEec3znhv3szu8+lqTp8SCnM9mVImr/3EmPDQt6Z3uZPC3ybojYzxP9
 ssYwQfG/8b5LTme3zHpy9UjVHLL04vHRS0Ane9JYpTlX7zp0EAA==
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

