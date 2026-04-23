Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D93F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D96410F051;
	Thu, 23 Apr 2026 10:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G4PhSnBY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E8810F049
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:07:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A63560125;
 Thu, 23 Apr 2026 10:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6333AC2BCB2;
 Thu, 23 Apr 2026 10:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776938869;
 bh=ADtZpZy78j4RCd1BU3nmDL3mBvg/UC+2hCBfOt82lYc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=G4PhSnBYnjOON5oBIXEiB/ZYs2Rqofgdzxgd0/iavbdOTL07yb84pYVHIGnSlqmoT
 q66lg4Am4i9VAeGE1QeihfbQzcTTTrhp7FQYhXuliUBKjklQqdO0Kkw/LXxXWNhBZv
 Y2QY6Scexeggq46hxGG1+v4kD8aHgaSN0kVtYpXm8sk/oeM3tf1yPgjElJ0HQ0sP9i
 V9gJdByrfKDcTnPl6as/xtatYmznRSmaAUV/Fi3Yqzc/HgKonDA2Y5CVbUjRtYXgtd
 hnY6hAG1l4OHMdaCnb0Cvq/EoEoT7nC/dWDrURE75ParDs/DbFxHTYr+qO/76pIFVp
 WlxjuvTL+QAmg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:06:49 +0200
Subject: [PATCH v2 11/28] drm/atomic_sro: Create kernel parameter to force
 or disable readout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-11-6cde1a9910ed@kernel.org>
References: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ADtZpZy78j4RCd1BU3nmDL3mBvg/UC+2hCBfOt82lYc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkv33tvaro4h1fqWErclkvzVstbcM7cd8x+96EX94Oq/
 yed7FAp7JjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATmT+Xsd7hNVeZU8lKbfYN
 GdZndyqYJgqw/wnlFkj4YHFDMiDHZ9XVEN53PkK5L6JbL+WeqhOewFjNWqD0Zenr82WbJFfb5Dt
 eOP2C2enlybaHhx30ObmjzQ/Nmu7tuLDZtvuc2tY9JV/k9i8BAA==
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
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_sro.c | 36 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic_sro.h     |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
index 177b97d451f5..a46f06e75c4e 100644
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
+module_param_unsafe(atomic_readout, uint, 0);
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
+	if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
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
2.53.0

