Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A347606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9ZQk/F6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 896031129F1;
	Fri, 20 Nov 2026 12:56:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41491129D4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:56:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEE56623FE;
 Fri, 20 Nov 2026 12:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710681F000C0;
 Fri, 20 Nov 2026 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179368;
 bh=0mrumazleeAkKYCYkn5SZAaE58xUxn0XKblrZOadZns=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=F9ZQk/F6wqngJgnwpIIZH0hc59gr1LBJ6afxd59gi7IILqZxu7ZkcXvazs1B7hO5m
 WjhknWPY8PzA8KiDUvsEU4O3eTC2M4Ps+ERTKNXhCPQN7lB39btCpbiRggTAEeoBsh
 5z9BmZRA3bJYuLzXpVHtY+LdGJRL+Y0SiMeMpLBnq5D8IZEJNe3ds8Av7ENKWT7A0G
 giLuh/9aIDrmNdMyQF+5SLdBAVvnYEg35wpdfP/XFyBPN/fu5bTxCt0WUWdmkN2mhm
 6y6iU1e/ZgzAzEC8ZFAk27GwTsduahkzhnmsuzlBt4eVKz2j583zCkZmsSbie3FOY9
 9jb2oRklSOHlA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:06 +0100
Subject: [PATCH v9 14/42] drm/atomic_sro: Create kernel parameter to force
 or disable readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-14-a67c2b45b8ec@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4583; i=mripard@kernel.org;
 h=from:subject:message-id; bh=OtAthzPmcY3r28ahWl6Yh+aROoSPfvDhdaEEHWBPgDc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzhoMBYV3bHsTfZj+xM/kOF+4Mv6i+/YP/9K2dDz9I
 FVay1fcMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDaEi1MAJvL8EWPD7G26Tgv+vFKsPn69
 a39A+F6PV39XSt+yX17F7X43rCzwwqzy8NwNytc+n5+dy+aoePE6Y539C74bdQkl61zurLH5one
 Ww91cXur5ttxPhRYic9e/XfI6YebJ2vj91xcbvFi+rO7e5TMA
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

The hardware state readout is useful, but might need to be disabled
in case of bugs, or its checks relaxed during development when not
all hooks are implemented yet.

Add a module parameter to control the readout behavior: it can be
disabled entirely, or the checks for missing compare or readout hooks
can be skipped independently.

Suggested-by: Simona Vetter <simona@ffwll.ch>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++
 drivers/gpu/drm/drm_atomic_state_readout.c      | 29 +++++++++++++++++++++++++
 include/drm/drm_atomic_state_readout.h          | 11 ++++++++++
 3 files changed, 52 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..59ff44c49f31 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1375,10 +1375,22 @@ Kernel parameters
 			the EDID name. Each connector may use a unique EDID
 			data set by separating the files with a comma. An EDID
 			data set with no connector name will be used for
 			any connectors not explicitly specified.
 
+	drm.atomic_readout=	[DRM]
+			Control the KMS atomic hardware state readout
+			(SRO), used to initialize the atomic state from
+			the state the firmware left the hardware in at
+			boot instead of programming a new one.
+			0: disable the state readout entirely,
+			1: enable it (default),
+			2: ignore the objects missing a comparison
+			   implementation,
+			3: ignore the objects missing a readout or
+			   comparison implementation.
+
 	dscc4.setup=	[NET]
 
 	dt_cpu_ftrs=	[PPC,EARLY]
 			Format: {"off" | "known"}
 			Control how the dt_cpu_ftrs device-tree binding is
diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm/drm_atomic_state_readout.c
index c00631800234..b8ca4cbbc5b2 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout.c
@@ -12,10 +12,39 @@
 #include <linux/sched/mm.h>
 
 #include "drm_internal.h"
 #include "drm_crtc_internal.h"
 
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
 
diff --git a/include/drm/drm_atomic_state_readout.h b/include/drm/drm_atomic_state_readout.h
index 5a9333a05796..65d45ca4be76 100644
--- a/include/drm/drm_atomic_state_readout.h
+++ b/include/drm/drm_atomic_state_readout.h
@@ -1,10 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #ifndef DRM_ATOMIC_SRO_H_
 #define DRM_ATOMIC_SRO_H_
 
+#include <linux/types.h>
+
 struct drm_atomic_sro_state;
 struct drm_connector;
 struct drm_connector_state;
 struct drm_crtc;
 struct drm_crtc_state;
@@ -13,10 +15,19 @@ struct drm_plane;
 struct drm_plane_state;
 struct drm_printer;
 struct drm_private_obj;
 struct drm_private_state;
 
+enum drm_atomic_readout_status {
+	DRM_ATOMIC_READOUT_DISABLED = 0,
+	DRM_ATOMIC_READOUT_ENABLED,
+	DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE,
+	DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT,
+};
+
+bool drm_atomic_sro_device_can_readout(struct drm_device *dev);
+
 struct drm_atomic_sro_state *drm_atomic_sro_state_alloc(struct drm_device *dev);
 void drm_atomic_sro_state_free(struct drm_atomic_sro_state *state);
 void drm_atomic_sro_state_print(const struct drm_atomic_sro_state *state,
 				struct drm_printer *p);
 

-- 
2.56.1

