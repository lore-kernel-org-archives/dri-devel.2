Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB37C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A78DD10E820;
	Mon,  7 Sep 2026 13:25:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VAashe1O";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843A410E820
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:25:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C044260A9C;
 Mon,  7 Sep 2026 13:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DF21F00A3A;
 Mon,  7 Sep 2026 13:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787543;
 bh=OTxV+cjTWGsqkYyQPJB/wOR/aY9ce6w78FaDUH6ZVZ4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VAashe1O35DbFxXj52RARl0LNMN1JaKfneRMtt0GmYJ7XHbpDQp8QmboVMWM3Gx20
 vUMokYBCnLAhG7zdYDqF87+ewPL4H2UFsHDFMUCK5DUKsFlHJq/LMHgnf6Qqj2Lapo
 kxVQLE1rZgFSUxyufBF+T8g4Us/Ecbu0alVWpRMLxH6DNcmmgSFlwhkemIz79rgo/D
 /Blh8cgjuPlrnUOwWSJCn8b1pC0TOv+aAmy9OkXlZ4mS1FdO4P6jP2axMWUls3THRG
 aNPURP/WIlHG8NKzlLbrbKc4yhrinRhc7d+rk5MaP+dnOmJiOpAna81yXNSi2fCnsL
 4yDoT4wzp4rcw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:24:03 +0200
Subject: [PATCH v5 27/33] drm/tidss: crtc: Add atomic_print_state
 implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-27-5fa1ac7a5148@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=mripard@kernel.org;
 h=from:subject:message-id; bh=57XDuXyIgYzRNmpGUNT1beXfTawbWQXeAahovowmf8U=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdr3c+vyRgKW75NKNC09863JhDm5U+jZx4+vPllofb
 UPsU4wjOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEFrxkrHfz5jzyK2q75/vF
 KRnXq77wWft5bkw0Y7YQ+XnyQCn/nz9XON4ZdOd2LL4gfqnVkfcWO2PDev/mBdrPp7QwzfkQLD4
 rj2Gyekclq+p+3iJvm2PO5RIrW3/xpP3RnDjhmlnVlp1/Dl0AAA==
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

