Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FBB606A337
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=od0F0G+7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA12B11291B;
	Fri, 27 Nov 2026 09:53:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492ED10E6BD
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:53:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33334415DC;
 Fri, 27 Nov 2026 09:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533311F0089B;
 Fri, 27 Nov 2026 09:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773223;
 bh=diCU/ktHvDbBpy17ZF4dSPbCVYuDO0JoafcFza/2TiM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=od0F0G+7/tH8WQbeJn0YwfcLJ/mrNbpXgCsZiOlqfvZqtPobLBnInp40qLySlPHCT
 Ga5vb7BiQtJPMTt+oH4zxZFiGx8jmbUG+2Ydx22iczuNm0lClu5jYuKPEcsK0HLT/A
 waZf1d4dBAgd/+ImUjyFC6ERi8FvqnAfYxxFjIamEeYV4ktn8mVsp78VNPhD/6iSWC
 qcrf5sQmkq/udihkLyBpTH6YGM3hb8l+cTzHLOCXMGIrunxOamtXU6vyn04h58S6Bq
 ZlOJlDI2LzHScesPXjXepM969m187YuiYHiYvcnVq8NhXh4LJRFVKNnJa6FncA/9If
 0ZEeEenSsG0vQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:52:49 +0100
Subject: [PATCH v10 07/36] drm/atomic_sro: Create kernel parameter to force
 or disable readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-7-0259582d45a8@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4691; i=mripard@kernel.org;
 h=from:subject:message-id; bh=4dIAOph3F48K8q6bwiTqWMDmGfVAqhkI9awfwiD3aT8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcQf8V5m4u/XyPk+fHh1v/qt5z3l1x+rt/nMQ9DaZX0
 wRUQivKOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBENs1nbFgXXHlt0oorhyQn
 aTKrnfT+H7pzunjcCZVZQUc+Ku5pVskWKf5hXRSnOXn/oe37lZ8aLmKsFX51dNM7z8dM20NPr5z
 Bzhv/5KpdzkqOwFv7pj3d0s5bIRjF6M/g9ODemxg/ZYHeL20KAA==
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
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++
 drivers/gpu/drm/drm_atomic_state_readout.c      | 31 +++++++++++++++++++++++++
 include/drm/drm_atomic_state_readout.h          | 13 +++++++++++
 3 files changed, 56 insertions(+)

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
index dc9e1cbfe0d8..dab47fef6672 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout.c
@@ -12,10 +12,41 @@
 #include <linux/sched/mm.h>
 
 #include "drm_internal.h"
 #include "drm_crtc_internal.h"
 
+unsigned int drm_atomic_sro_status = DRM_ATOMIC_SRO_ENABLED;
+EXPORT_SYMBOL(drm_atomic_sro_status);
+
+module_param_named_unsafe(atomic_readout, drm_atomic_sro_status, uint, 0400);
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
+	if (drm_atomic_sro_status == DRM_ATOMIC_SRO_DISABLED)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(drm_atomic_sro_device_can_readout);
+
 static unsigned int max_connector_index(struct drm_device *dev)
 {
 	struct drm_connector_list_iter conn_iter;
 	struct drm_connector *connector;
 	unsigned int max = 0;
diff --git a/include/drm/drm_atomic_state_readout.h b/include/drm/drm_atomic_state_readout.h
index 4b1a92291cc1..bbed8e8dccf0 100644
--- a/include/drm/drm_atomic_state_readout.h
+++ b/include/drm/drm_atomic_state_readout.h
@@ -1,10 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #ifndef DRM_ATOMIC_SRO_H_
 #define DRM_ATOMIC_SRO_H_
 
+#include <linux/types.h>
+
 struct drm_connector;
 struct drm_connector_state;
 struct drm_crtc;
 struct drm_crtc_state;
 struct drm_device;
@@ -12,10 +14,21 @@ struct drm_plane;
 struct drm_plane_state;
 struct drm_printer;
 struct drm_private_obj;
 struct drm_private_state;
 
+enum drm_atomic_sro_status_values {
+	DRM_ATOMIC_SRO_DISABLED = 0,
+	DRM_ATOMIC_SRO_ENABLED,
+	DRM_ATOMIC_SRO_SKIP_MISSING_COMPARE,
+	DRM_ATOMIC_SRO_SKIP_MISSING_READOUT,
+};
+
+extern unsigned int drm_atomic_sro_status;
+
+bool drm_atomic_sro_device_can_readout(struct drm_device *dev);
+
 /**
  * struct __drm_atomic_sro_plane - plane entry of a &struct drm_atomic_sro_state
  */
 struct __drm_atomic_sro_plane {
 	/**

-- 
2.56.1

