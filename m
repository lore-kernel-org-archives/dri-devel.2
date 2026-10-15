Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05F0CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA51710F469;
	Thu, 15 Oct 2026 15:10:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC2710F080
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:10:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E57F460200;
 Thu, 15 Oct 2026 15:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200551F000C6;
 Thu, 15 Oct 2026 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792077038;
 bh=OTxV+cjTWGsqkYyQPJB/wOR/aY9ce6w78FaDUH6ZVZ4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jSu9yQWDD9jTqNx/Kwi5nKfZGJ4A8/K+eRZcreGpqhdIwyO2hx7VVVKj+RAPjYD3v
 5PpaAC0/mY15v8jBqfuZ8JxD0IMbPEtQLkvoqMasLrJWgyxzIUupnKe6R7T5rXe162
 060fH159xGRwB7FtIH0SXY4QQQXVC50WnTsB1dlEXPBWam6/L90Iyw/1ThDy2t+Qps
 mKXQYmusJHmpN1hZyi05aHCE1qDP78nLVuBYLlf/BVQ6CiBBjAm30f8GD4yzD4xUX8
 oE72FYzFJvrGYzNwV0jYEJiBSYaGAkq6EJkfaazRUTkx12iY3tCkq71q1Xf/RYpI0k
 XE7mwO9J0GFNA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:09:15 +0200
Subject: [PATCH v6 23/28] drm/tidss: crtc: Add atomic_print_state
 implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-23-6cc02cd10998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=mripard@kernel.org;
 h=from:subject:message-id; bh=57XDuXyIgYzRNmpGUNT1beXfTawbWQXeAahovowmf8U=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3kzJrNbduMBD9tyNZTdXBF3/vrh7Do/RW6u95fsDZ
 ti8Mqq60DGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmEpnO2LC0pWiaU3eIidnU
 L+s4n0f1rW2tuvEiOOTactkvPzffPZ98QzQrXZHR/GGBSr7/tS8xXoz1UUtq16/UeLJIPvPKwbp
 tW2x2u/q8/PH39T+hTOdb32v6Ok7+FBEyPC26MTHVIqf2gPFBAA==
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

The tidss CRTC subclasses drm_crtc_state with bus_format and bus_flags
fields that are set during atomic check and state readout. These fields
are not visible in the standard atomic state dumps, making it harder to
debug bus format negotiation issues.

Add an atomic_print_state hook to expose them in debugfs and kernel log
state dumps.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index 400329aa2200..3da49f77fa08 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -399,17 +399,27 @@ static void tidss_crtc_destroy(struct drm_crtc *crtc)
 
 	drm_crtc_cleanup(crtc);
 	kfree(tcrtc);
 }
 
+static void tidss_crtc_atomic_print_state(struct drm_printer *p,
+					  const struct drm_crtc_state *state)
+{
+	const struct tidss_crtc_state *tstate = to_tidss_crtc_state(state);
+
+	drm_printf_indent(p, 1, "bus_format=0x%08x\n", tstate->bus_format);
+	drm_printf_indent(p, 1, "bus_flags=0x%08x\n", tstate->bus_flags);
+}
+
 static const struct drm_crtc_funcs tidss_crtc_funcs = {
 	.destroy = tidss_crtc_destroy,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_create_state = tidss_crtc_create_state,
 	.atomic_duplicate_state = tidss_crtc_duplicate_state,
 	.atomic_destroy_state = tidss_crtc_destroy_state,
+	.atomic_print_state = tidss_crtc_atomic_print_state,
 	.enable_vblank = tidss_crtc_enable_vblank,
 	.disable_vblank = tidss_crtc_disable_vblank,
 };
 
 struct tidss_crtc *tidss_crtc_create(struct tidss_device *tidss,

-- 
2.55.0

