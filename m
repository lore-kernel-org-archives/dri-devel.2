Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EBF606A332
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFqsCfWS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE1610E56B;
	Fri, 27 Nov 2026 09:55:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8C8112931
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:54:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B07F611ED;
 Fri, 27 Nov 2026 09:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE7E1F0089B;
 Fri, 27 Nov 2026 09:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773291;
 bh=S0e7mgXuoEvDLgXm2gsjawSnNoBTMy7nwJtKyL2t3yA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HFqsCfWShbDQaw5TCQps1NKiQBfLE3maVkbddYFuMeA7UGTiUKn9bcZScLH/9aeWN
 0MK3G0Nawtxzo646s5UeG1Em4cwm10+vvsKLFs25uUzBY8Nvr90eYpIFAxW/ecf9ZV
 Ll3+tWk+q1hNN9mKJQSAzBg5tSDjOAha2W2EFT6+4uYgNmTdmMgtQF7owfCoClyJTw
 XilDEgN6PoPOS0foOTE3k2C4tYB2CHSGFqX+TVuucGpKvXnoIMMFG8u4Oam/qfRHnm
 2C7QajH2/+JYxzJJuIk/QSYqCcVFcfzC21iXwuJCeUXF9wAnheduPtnMpibbQSspNq
 JoVq40gW9bO5w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:09 +0100
Subject: [PATCH v10 27/36] drm/tidss: crtc: Implement hardware state
 readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-27-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6905; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BsIy4WjWP8Z0BM2iiL+x+S0AD32EIOIzLe84FVXdslE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwRxta+tXJR5rOngzrkdsJaM8x6flHRt75J6uX3jU8
 fyX33JLOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEZOUZ66zdDlw6u3NSUrZw
 5g55J59pbUJbax5NSNzxbu5vh7Ndt5K/r4x/ueRaz0muKcpB021j0hnrnYO8Dr+7KVO9RTZzn3a
 6QPc5x7Bll5r21TwIMD+7YrrfjYuLJdjCtFaqX9Y9I1TbvYADAA==
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

The firmware can leave a video port running when the driver probes, and
the KMS state of its CRTC should then reflect it instead of being
pristine, so that the first modeset can be skipped if it matches.

Implement the state readout hooks for the CRTCs.
tidss_crtc_readout_state() reports the CRTC as active when its video
port is enabled, and reads out its mode, bus flags and bus format. The
connectors and planes bound to the CRTC are filled by their own readout
hooks.

tidss_crtc_install_state() takes over the video port of an active CRTC
when its state is installed: it takes the runtime PM reference and the
video port clock that tidss_crtc_atomic_disable() later releases, flags
the video port as a DPI output, and turns the vblank reporting on. The
hook can't fail, so if one of those resources can't be acquired, the
CRTC is installed as inactive instead, and the next modeset fully
programs the video port.

Finally, implement tidss_crtc_compare_state(), that checks the bus
format and bus flags on top of the generic CRTC comparison, unless both
states are inactive since the bus configuration isn't read out from a
disabled pipeline.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c | 132 +++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index d2664bda53a9..c72194e93bde 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -2,12 +2,16 @@
 /*
  * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
+#include <linux/clk.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout_helper.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 
@@ -370,10 +374,135 @@ static struct drm_crtc_state *tidss_crtc_create_state(struct drm_crtc *crtc)
 	__drm_atomic_helper_crtc_state_init(&tstate->base, crtc);
 
 	return &tstate->base;
 }
 
+static int tidss_crtc_readout_state(struct drm_crtc *crtc,
+				    struct drm_atomic_sro_state *state,
+				    struct drm_crtc_state *crtc_state)
+{
+	struct drm_device *ddev = crtc->dev;
+	struct tidss_device *tidss = to_tidss(ddev);
+	struct dispc_device *dispc = tidss->dispc;
+	struct tidss_crtc_state *tstate = to_tidss_crtc_state(crtc_state);
+	struct tidss_crtc *tcrtc =
+		to_tidss_crtc(crtc);
+	struct drm_display_mode mode = {};
+	int ret;
+
+	tidss_runtime_get(tidss);
+
+	if (!dispc_vp_is_enabled(dispc, tcrtc->hw_videoport))
+		goto out;
+
+	tstate->base.active = 1;
+	tstate->base.enable = 1;
+
+	ret = dispc_vp_readout_mode(dispc, tcrtc->hw_videoport, &mode);
+	if (ret)
+		goto err_runtime_put;
+
+	ret = drm_atomic_set_mode_for_crtc(&tstate->base, &mode);
+	if (WARN_ON(ret))
+		goto err_runtime_put;
+
+	drm_mode_copy(&tstate->base.adjusted_mode, &mode);
+
+	tstate->bus_flags = dispc_vp_get_bus_flags(dispc, tcrtc->hw_videoport);
+	ret = dispc_vp_get_bus_format(dispc, tcrtc->hw_videoport,
+				      &tstate->bus_format);
+	if (ret)
+		goto err_runtime_put;
+
+	/*
+	 * The active connectors and planes will be filled by their
+	 * respective readout callbacks.
+	 */
+
+out:
+	tidss_runtime_put(tidss);
+	return 0;
+
+err_runtime_put:
+	tidss_runtime_put(tidss);
+	return ret;
+}
+
+static void tidss_crtc_install_state(struct drm_crtc *crtc,
+				     struct drm_crtc_state *crtc_state)
+{
+	struct tidss_crtc *tcrtc = to_tidss_crtc(crtc);
+	struct drm_device *ddev = crtc->dev;
+	struct tidss_device *tidss = to_tidss(ddev);
+	int ret;
+
+	/*
+	 * The video port wasn't enabled in hardware: nothing to take
+	 * over for it, and enabling the clock and the vblank reporting
+	 * would leak their reference for a CRTC that no disable will
+	 * ever release.
+	 */
+	if (!crtc_state->active)
+		return;
+
+	ret = tidss_runtime_get(tidss);
+	if (ret < 0)
+		goto err_inactive;
+
+	ret = dispc_vp_enable_clk(tidss->dispc, tcrtc->hw_videoport);
+	if (ret != 0) {
+		tidss_runtime_put(tidss);
+		goto err_inactive;
+	}
+
+	/*
+	 * dispc_vp_unprepare() only clears DPIENABLE for video ports
+	 * that dispc_vp_setup() flagged as DPI outputs, which hasn't
+	 * run for a video port enabled before the driver probed.
+	 */
+	dispc_vp_set_dpi_output(tidss->dispc, tcrtc->hw_videoport,
+				tcrtc->dpi_output);
+
+	/* Turn vertical blanking interrupt reporting on. */
+	drm_crtc_vblank_on(crtc);
+
+	return;
+
+err_inactive:
+	/*
+	 * This hook can't fail. Without the references taken above, a
+	 * later tidss_crtc_atomic_disable() would release references
+	 * it doesn't hold, so install the CRTC as inactive instead:
+	 * the next modeset will fully program the video port.
+	 */
+	drm_warn(ddev, "[CRTC:%d:%s] Couldn't take over the video port: %d\n",
+		 crtc->base.id, crtc->name, ret);
+	crtc_state->active = false;
+}
+
+static bool tidss_crtc_compare_state(struct drm_crtc *crtc,
+				     struct drm_printer *p,
+				     struct drm_crtc_state *expected,
+				     struct drm_crtc_state *actual)
+{
+	struct tidss_crtc_state *t_expected = to_tidss_crtc_state(expected);
+	struct tidss_crtc_state *t_actual = to_tidss_crtc_state(actual);
+	bool ret = drm_atomic_helper_crtc_compare_state(crtc, p, expected, actual);
+
+	/*
+	 * Both inactive: the bus configuration wasn't read out from the
+	 * disabled pipeline, and the committed one is stale anyway.
+	 */
+	if (!expected->active && !actual->active)
+		return ret;
+
+	STATE_CHECK_U32_X(ret, p, crtc->name, t_expected, t_actual, bus_format);
+	STATE_CHECK_U32_X(ret, p, crtc->name, t_expected, t_actual, bus_flags);
+
+	return ret;
+}
+
 static struct drm_crtc_state *tidss_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct tidss_crtc_state *state, *current_state;
 
 	if (WARN_ON(!crtc->state))
@@ -415,10 +544,13 @@ static void tidss_crtc_atomic_print_state(struct drm_printer *p,
 static const struct drm_crtc_funcs tidss_crtc_funcs = {
 	.destroy = tidss_crtc_destroy,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_create_state = tidss_crtc_create_state,
+	.atomic_sro_readout_state = tidss_crtc_readout_state,
+	.atomic_sro_install_state = tidss_crtc_install_state,
+	.atomic_sro_compare_state = tidss_crtc_compare_state,
 	.atomic_duplicate_state = tidss_crtc_duplicate_state,
 	.atomic_destroy_state = tidss_crtc_destroy_state,
 	.atomic_print_state = tidss_crtc_atomic_print_state,
 	.enable_vblank = tidss_crtc_enable_vblank,
 	.disable_vblank = tidss_crtc_disable_vblank,

-- 
2.56.1

