Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33150CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CDA010F2F8;
	Thu, 15 Oct 2026 15:10:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BDB710EF65
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:10:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F41AD6022B;
 Thu, 15 Oct 2026 15:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316741F000C4;
 Thu, 15 Oct 2026 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792077005;
 bh=VrnJfv+VVqd1oFkyVzgv4ptN5fpXMDOGz41KE1sHgL8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=aO0viE496vh2tsYDzs6DG0y710oBXHlYe9gy7bsktV+vqFHkOVEQBjQeuXEiDIOqz
 Kq4XAwTW62ZOoCfHo0+3P+SI/cKtiW/9We1g+/bGaocSxsWpb+oxSI1jnbcQ5Tkz3D
 g0tAAJBa5lNID01QnFBxLKGb95ZtCeXkEaGk74bbpVVc2oeCvRpf8EKQ7JzZi8+tp+
 UDtbWbCC9YxNY1RVjDRzSUopyC1iHFvwHjyBM9ED3UWHJ1nMi1uVee1ZAU3vxS6Rc/
 aqZPo6OyTVmXBl+ia1dnbhZ10QJF4gSo7UKVlRPU7aWoKsoyEHyj8PLZsQOKnZCOOW
 nRY/1qEZkNDZw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:09:06 +0200
Subject: [PATCH v6 14/28] drm/mode-config: Introduce hw_reset hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-14-6cc02cd10998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5080; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pF9aHP+XE5Q+eJ7OLUS086MCNZpBXNUMNWFQxyA4qLQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3kxgnfJK9tiSqukb/hYe3tczz/ojW+iMCRdOBxmaL
 WzpWf5rYcdUFgZhTgZZMUWWJzJhp5e3L65ysF/5A2YOKxPIEAYuTgGYiNpuxobPpsenvqiJv3c7
 VTDgs8/mJ5/meH149kGrwX/RXHfJEqds/a02y4Sy/s8qPHoi1Mr4Wjhjvduu4pJ++517vvRenTi
 v6ulMyxs5hsssFu34YdE4M73y3p+cRH/+yj+1E6dlbY7cyH7wMgA=
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

drm_mode_config_create_initial_state() tries to read out the current
hardware state to build the initial atomic state. If state readout is
disabled or fails, it falls back to creating pristine software state
using the objects' atomic_create_state callbacks.

However, creating pristine state without resetting the hardware leaves
the hardware and software states out of sync. The legacy
drm_mode_config_reset() handles this by calling per-object .reset
callbacks that both reset the hardware and allocate new state, but these
two concerns are intertwined and cannot be reused independently.

Introduce a new hw_reset hook in drm_mode_config_funcs that only
performs the hardware reset, without allocating any software state. Call
it in drm_mode_config_create_initial_state() after state readout fails,
right before falling back to drm_mode_config_create_state(). This
separates the hardware reset from state creation, allowing drivers that
implement state readout to share their reset logic with the fallback
path.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c | 14 ++++++++++----
 include/drm/drm_mode_config.h     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 13e7d7f40d0a..9277ec94d640 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -402,17 +402,18 @@ static int drm_mode_config_create_state(struct drm_device *dev)
  *
  * This functions creates the initial state for all the objects. Drivers
  * can use this in e.g. probe to initialize their state.
  *
  * It creates the initial state in several steps. It first tries to
- * read-out the initial state from the hardware for all objects if state
- * read-out is enabled and the driver supports it. Then, if state
- * read-out isn't supported or fails, it creates a new, pristine state
+ * read out the initial state from the hardware for all objects if state
+ * readout is enabled and the driver supports it. Then, if state
+ * readout isn't supported or fails, it resets the hardware using
+ * &drm_mode_config_funcs.hw_reset() and creates a new, pristine state
  * using the objects atomic_create_state callback.
  *
  * For historical reasons, drm_mode_config_reset() is similar, but
- * doesn't support state read-out, and will always reset the hardware.
+ * doesn't support state readout, and will always reset the hardware.
  * It will also ignore all &drm_private_obj.
  *
  * Returns: 0 on success, negative error value on failure.
  */
 int drm_mode_config_create_initial_state(struct drm_device *dev)
@@ -423,10 +424,15 @@ int drm_mode_config_create_initial_state(struct drm_device *dev)
 		ret = dev->mode_config.funcs->atomic_sro_readout_state(dev);
 		if (!ret)
 			return 0;
 	}
 
+	/* Reset the hardware first ... */
+	if (dev->mode_config.funcs->hw_reset)
+		dev->mode_config.funcs->hw_reset(dev);
+
+	/* ... then allocate a new pristine state */
 	return drm_mode_config_create_state(dev);
 }
 EXPORT_SYMBOL(drm_mode_config_create_initial_state);
 
 /*
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 94c0078179f8..ea2f4bacfce3 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -107,10 +107,42 @@ struct drm_mode_config_funcs {
 	 * should be checked in the .mode_valid() hook for each specific object.
 	 */
 	enum drm_mode_status (*mode_valid)(struct drm_device *dev,
 					   const struct drm_display_mode *mode);
 
+	/**
+	 * @hw_reset:
+	 *
+	 * Optional hook for device-specific hardware reset.
+	 *
+	 * Unlike drm_mode_config_reset(), which both resets hardware
+	 * and creates new software state through per-object .reset
+	 * callbacks, this hook only resets the hardware to a known good
+	 * state without touching the software state at all.
+	 *
+	 * This hook is called by
+	 * drm_mode_config_create_initial_state() when the hardware
+	 * state readout (atomic_sro_readout_state) is not supported
+	 * or fails. The call sequence is:
+	 *
+	 * 1. Try atomic_sro_readout_state() to read the hardware state
+	 * 2. If that fails, call hw_reset() to put the hardware in a
+	 *    known state
+	 * 3. Create pristine software state via atomic_create_state
+	 *    callbacks
+	 *
+	 * Drivers that implement state readout and need a hardware
+	 * reset on the fallback path should implement this hook.
+	 * Drivers that don't implement state readout at all can keep
+	 * using drm_mode_config_reset() instead.
+	 *
+	 * This hook is optional. If not provided, the fallback path
+	 * will create software state without resetting the hardware
+	 * first.
+	 */
+	void (*hw_reset)(struct drm_device *dev);
+
 	/**
 	 * @atomic_check:
 	 *
 	 * This is the only hook to validate an atomic modeset update. This
 	 * function must reject any modeset and state changes which the hardware

-- 
2.55.0

