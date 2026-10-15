Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6952CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D205310E916;
	Thu, 15 Oct 2026 15:09:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0975010E861
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:09:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A8B66022C;
 Thu, 15 Oct 2026 15:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A817C1F000C4;
 Thu, 15 Oct 2026 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792076966;
 bh=p2TyFfxeyyH+LPP3301I8AUEBoFPxR6ckZtcjZxIxVA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Q1kKkyrIiw1cBfXtx+GpNbM/pja005208sKHiFyGPh+UcSaDI9OuSlW8khzLUqZLM
 tVvWVgv9rtZT9OoPgNAW2L8vQFblnDhRj9DMPPJRiKZAAotESGmOiLpBr8O+5es7le
 fkhc8bqU9jk5fBN75xhMlLG4uiQWHcAS9Gm1MqZrcc56z55/wdiR6jynBkbFFNLn8c
 Vj7UlR0Hh9Az5skUxzQHq4FOBB7r6cjK3NEPZRIuWSdqIjOyaK4x0X3nIpw7Cv1P1T
 l1rTvNM/Dhx+maO7/I5h6Fw36JDFFEhvX7CtCFO26E3VGSuYcHc1pwhlPjKmUtUbZC
 r87lUqysaGo9A==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:08:55 +0200
Subject: [PATCH v6 03/28] drm/bridge: Switch print_state to use bridge name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-3-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=mripard@kernel.org;
 h=from:subject:message-id; bh=j8gEKSoUMbDBy2wf9x/IRD85NYZ4o0CnEXemIS9VtDs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3nS/937j7ugW6OE48Xae/y+NWbliR2W4NnRzcok/4
 1r+MpanYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEyktIqxPmDb/ncfEzxilVsL
 73GnsJ+wfFlnkul29uHKuVOcZvFe/vm85PPxlzPVZPdWlE7pnvLoE2PDosuGXx8uar5p4K2/2nP
 6LLdqz3crrVeuX5O81PXuXeH2yATGyJlmZvOW15y/UBG4iT8QAA==
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

drm_bridge_atomic_print_priv_state() currently identifies bridges by
printing the symbol name of bridge->funcs using the %ps format
specifier. This produces output like a raw function pointer name, which
is not particularly user-friendly for debugging.

Since bridges now carry a human-readable name, switch to printing
bridge->name instead. This makes the state readout output more
consistent and easier to interpret.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index d474d6020411..447fe6d333b3 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -561,13 +561,13 @@ drm_bridge_atomic_print_priv_state(struct drm_printer *p,
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
2.55.0

