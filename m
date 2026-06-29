Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC56C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2E010E756;
	Mon, 29 Jun 2026 08:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DHznonAk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 860E610E740
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:17:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 093A06001D;
 Mon, 29 Jun 2026 08:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3661F000E9;
 Mon, 29 Jun 2026 08:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721066;
 bh=xJ9YLAOi6cvhXhZjm2sovtV7w90aXE2ZF+4WAZnfUeU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DHznonAky+GZMqkamtbXYgB5CN5rKl4T5L4ezRLGKvQxFDXAwncFerDA4vlRx6B74
 XFjy6UloMBy2dkdU19U23cTauVQsJjFDSAIyRplKH21Y48PG8VQNDEBMEle+5vIARV
 1jYuCPBQV6Xbw7bdGVtf4bQtLJtn5ieaIeUyHL9LIYk2xxPBEQI3+qibjzv/kLwme7
 W2gAbQes22Zq01k/AwAKcQMHy/gLKjcyA2YwN1VsPDugl1foONbidjKu8ogL0G6VRW
 oyYTKYrs+JjBW2H/Nm6l62shYYJjX5bvw3eb1y+iU7PDefyjN4jBzEQYKFpynoAhgR
 JcIrimLWspJqA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:09 +0200
Subject: [PATCH v4 11/30] drm/atomic_sro: Create kernel parameter to force
 or disable readout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-11-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2924; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jIqrg8VEoNDWgJogPGgR92xvAgyoJDE9udAbdeWe5Ko=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWqzb+cMnu9Utnr9i6cwLTSfXde095VTy//CCtdsqg
 3j95V9d75jKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATKYxhbJg6/fEZ34O7Fd7N
 uSivmVW2U8TI8e4duX/XDI4XrbRh3h21YO471/aLBot7Fkt3TNNN0mOsd64uen5QYfuC70WzJ9S
 GaXcen33FdF7sj29MLE3n/X5wzbiwf7OjeO7aKysXvci0YRCcAAA=
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

The hardware state readout is useful, but might need to be disabled
in case of bugs, or its checks relaxed during development when not
all hooks are implemented yet.

Add a module parameter to control the readout behavior: it can be
disabled entirely, or the checks for missing compare or readout hooks
can be skipped independently.

Suggested-by: Simona Vetter <simona@ffwll.ch>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_sro.c | 36 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic_sro.h     |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
index 177b97d451f5..28beba4de0ce 100644
--- a/drivers/gpu/drm/drm_atomic_sro.c
+++ b/drivers/gpu/drm/drm_atomic_sro.c
@@ -11,10 +11,46 @@
 #include <linux/module.h>
 
 #include "drm_internal.h"
 #include "drm_crtc_internal.h"
 
+enum drm_atomic_readout_status {
+	DRM_ATOMIC_READOUT_DISABLED = 0,
+	DRM_ATOMIC_READOUT_ENABLED,
+	DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE,
+	DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT,
+};
+
+static unsigned int atomic_readout = DRM_ATOMIC_READOUT_ENABLED;
+module_param_unsafe(atomic_readout, uint, 0400);
+MODULE_PARM_DESC(atomic_readout,
+		 "Enable Hardware State Readout (0 = disabled, 1 = enabled, 2 = ignore missing compares, 3 = ignore missing readouts and compares, default = 1)");
+
+/**
+ * drm_atomic_sro_device_can_readout - check if a device supports hardware state readout
+ * @dev: DRM device to check
+ *
+ * Verifies that the device is an atomic driver, that readout is
+ * enabled, and that all KMS objects implement the relevant hooks.
+ *
+ * RETURNS:
+ *
+ * True if the device supports full hardware state readout, false
+ * otherwise.
+ */
+bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
+{
+	if (!drm_drv_uses_atomic_modeset(dev))
+		return false;
+
+	if (atomic_readout == DRM_ATOMIC_READOUT_DISABLED)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(drm_atomic_sro_device_can_readout);
+
 struct __drm_atomic_sro_plane {
 	struct drm_plane *ptr;
 	struct drm_plane_state *state;
 };
 
diff --git a/include/drm/drm_atomic_sro.h b/include/drm/drm_atomic_sro.h
index 5a9333a05796..6e5262384c71 100644
--- a/include/drm/drm_atomic_sro.h
+++ b/include/drm/drm_atomic_sro.h
@@ -13,10 +13,12 @@ struct drm_plane;
 struct drm_plane_state;
 struct drm_printer;
 struct drm_private_obj;
 struct drm_private_state;
 
+bool drm_atomic_sro_device_can_readout(struct drm_device *dev);
+
 struct drm_atomic_sro_state *drm_atomic_sro_state_alloc(struct drm_device *dev);
 void drm_atomic_sro_state_free(struct drm_atomic_sro_state *state);
 void drm_atomic_sro_state_print(const struct drm_atomic_sro_state *state,
 				struct drm_printer *p);
 

-- 
2.54.0

