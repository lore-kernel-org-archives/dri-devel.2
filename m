Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECCD606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FyZkfPGv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D01310E0D0;
	Sat, 31 Oct 2026 22:59:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E5010E02E
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 22:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793487551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ms+e+r+XcjJUf10RLONsKRvaYJt9n/+LlWA/9aLUivk=;
 b=FyZkfPGvvmaVaBn9z+k63FzJ3Yi7OPrUJHUhRQ9EP8kejB2V1/dK7Fdl5Slvpalo9RDhRD
 Q/qfc2hZnF1btxw9M0SooonNF050O9ZbU6YR77D+slKAVi+bfiYiRMYB7V53L3YehdDlAJ
 P0XphiWRZm13RubCIsFTNruYaC6N2bw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-SQ_WZzg7M4Km9mRIaV5Fyg-1; Sat, 31 Oct 2026 18:59:08 -0400
X-MC-Unique: SQ_WZzg7M4Km9mRIaV5Fyg-1
X-Mimecast-MFC-AGG-ID: SQ_WZzg7M4Km9mRIaV5Fyg_1793487547
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1d1f26a63so16410015e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 15:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793487547; x=1794092347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ms+e+r+XcjJUf10RLONsKRvaYJt9n/+LlWA/9aLUivk=;
 b=mxvnHvqE/fuQ9sw1UYRN1UKLQUEyAttLElFQcNF6rvEPekUW49iVdv5sMFYwVQLAiW
 ccBEAPJswPgDip68dVGtSAAHZD4i62VWxpUv/1FWODMcfVNkQ5PniHxUYpHe2ODMq27G
 81NbknlpjUatvcXiKs7XVXOpOTS3e8hnX0WmNLuGMVsIqtyPkmBQkLB+jeJrwXOt7xvu
 FTMSICbVJXUOZg9qHdFEKIWi7oEGwPuogvcgx/7mSYbHJCv6cIF8gnVkABOCsdUdL013
 KK861ruODVl7J5qC3x5LXm9/HPY+bVj7pw4IUCEQnul7w3oZM8RcJuo8XqsJZKWHGxiC
 J4bQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwk7v+1j+4JWLR1RpB/Jw2qkQnuaimDYbatx+JCz/5JfRev0V9OCh3vaEpg+Mtygy+esZmRWhlm0HQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKV4GxfMeSo1jofrvFkWZHsLx7BhsjfRI3IXv8iKmqneggdoZom
 NSPqMG4mo1DaWy4A8dWAw295nsPVVvxQzgu0EQYM1gWtwpsmn+fKqF4Q/JsTaOjiZY6EIQmA+wd
 aTr88VpIJoj6eT6a4iJdj7yb5nrsEbK9wC4WBNF4aaahRTHHY7U9LWoCFmEMWz4hl8+hfmg==
X-Gm-Gg: AYBFou3kcDQ8LJFattc303Ssq3df3d3kKO6cTrTk3NC3pE4BPvav2KC+VuaYCH0e7N2
 lu4wmsaAiwQvNUDc/7T7dsn5hdAGP6KC7w62nw74lwGAnSryPSWaaESNjcYb4L9g3xqXqAqiDgD
 UioJeOh6ZVecBaKufHKvYd2hEcpdomtcu7qftNtKOFiNqvrQgve89Tqo0IDDH/9pgZsqD7PbJ3M
 SMnfNty9LIwuPxUXDGASaJHOP3d6lamEOxSbU5VQ9SAfEgDPIowWP7xPVvtR5vJYOe9n3BwmJQJ
 Fv+Dk/bhY3oq+3hCa3BV1kQqcLyGbHKOX0jjZbbfNPibG/4JMLvLnQC6cD0pt4M4acbhYsJc+f8
 DEQYmFWnvRqlbs2lbybDJ+DZ+D/7inFPb5u++od4CZsZPpBRk/wj+Iq0EOB2YrKIAqi9tcmE5Ix
 cr7YPa1dmAma/3XkVuirhj++37NNDFmCf1IyZyMT1+nPxuBhIexA==
X-Received: by 2002:a05:600c:524c:b0:4a1:e6c5:e44c with SMTP id
 5b1f17b1804b1-4ac17470f97mr144612705e9.10.1793487546917; 
 Sat, 31 Oct 2026 15:59:06 -0700 (PDT)
X-Received: by 2002:a05:600c:524c:b0:4a1:e6c5:e44c with SMTP id
 5b1f17b1804b1-4ac17470f97mr144612375e9.10.1793487546515; 
 Sat, 31 Oct 2026 15:59:06 -0700 (PDT)
Received: from toolbx.fritz.box
 (p200300c1df20b900aff65c27eee3dd92.dip0.t-ipconnect.de.
 [2003:c1:df20:b900:aff6:5c27:eee3:dd92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6e63e0esm204535345e9.12.2026.10.31.15.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 15:59:05 -0700 (PDT)
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Sebastian Wick <sebastian.wick@redhat.com>
Subject: [PATCH 1/2] drm/vkms: Add drm_dev_enter/exit guards for hot-removable
 paths
Date: Sat, 31 Oct 2026 23:58:58 +0100
Message-ID: <20261031225901.3200167-1-sebastian.wick@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OcBtzeFjqWb5R1osry3VxOQBiGRJfEl-wUoBv-r1-RM_1793487547
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In preparation for switching to drm_dev_unplug() for ConfigFS device
removal, add drm_dev_enter()/drm_dev_exit() guards to vkms callbacks
that can be reached while the device is being torn down.
drm_dev_unplug() relies on these SRCU guards to wait for in-flight
operations before proceeding with teardown. Without them,
synchronize_srcu() completes immediately and the teardown path can race
with in-flight operations.

Guard the following callbacks:

 - vkms_connector_detect() and vkms_conn_get_modes(): called from the
   MODE_GETCONNECTOR ioctl via fill_modes, which holds mode_config.mutex.
   Without the guard, an in-flight getconnector can hold locks that
   drm_atomic_helper_shutdown() needs.

 - vkms_wb_connector_get_modes(): same fill_modes path for the writeback
   connector.

 - vkms_set_crc_source(): called from the CRC debugfs release path. The
   debugfs proxy explicitly does not protect the release callback
   against removal races, so this needs its own guard.

Atomic commit callbacks are intentionally not guarded: they are
serialized against drm_atomic_helper_shutdown() via modeset ww_mutex
locks, and must remain functional after unplug so shutdown can disable
CRTCs.

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c  |  8 +++++++-
 drivers/gpu/drm/vkms/vkms_connector.c | 14 +++++++++++++-
 drivers/gpu/drm/vkms/vkms_writeback.c | 13 +++++++++++--
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 0fc915a954ba..e0576edd7168 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -5,6 +5,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_colorop.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_fixed.h>
@@ -731,11 +732,16 @@ int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 {
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
 	bool enabled = false;
-	int ret = 0;
+	int ret, idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return -ENODEV;
 
 	ret = vkms_crc_parse_source(src_name, &enabled);
 
 	vkms_set_composer(out, enabled);
 
+	drm_dev_exit(idx);
+
 	return ret;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index b0a6b212d3f4..81cd845cf84f 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
@@ -16,6 +17,10 @@ static enum drm_connector_status vkms_connector_detect(struct drm_connector *con
 	struct vkms_connector *vkms_connector;
 	enum drm_connector_status status;
 	struct vkms_config_connector *connector_cfg;
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return connector_status_disconnected;
 
 	vkms_connector = drm_connector_to_vkms_connector(connector);
 
@@ -31,6 +36,8 @@ static enum drm_connector_status vkms_connector_detect(struct drm_connector *con
 			status = vkms_config_connector_get_status(connector_cfg);
 	}
 
+	drm_dev_exit(idx);
+
 	return status;
 }
 
@@ -44,12 +51,17 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
 
 static int vkms_conn_get_modes(struct drm_connector *connector)
 {
-	int count;
+	int count, idx;
+
+	if (!drm_dev_enter(connector->dev, &idx))
+		return 0;
 
 	/* Use the default modes list from DRM */
 	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
 	drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
 
+	drm_dev_exit(idx);
+
 	return count;
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index ecf29a2c0c8e..e779ace7b383 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -3,6 +3,7 @@
 #include <linux/iosys-map.h>
 
 #include <drm/drm_atomic.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_writeback.h>
@@ -67,9 +68,17 @@ static int vkms_wb_atomic_check(struct drm_connector *connector,
 static int vkms_wb_connector_get_modes(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
+	int count, idx;
 
-	return drm_add_modes_noedid(connector, dev->mode_config.max_width,
-				    dev->mode_config.max_height);
+	if (!drm_dev_enter(dev, &idx))
+		return 0;
+
+	count = drm_add_modes_noedid(connector, dev->mode_config.max_width,
+				     dev->mode_config.max_height);
+
+	drm_dev_exit(idx);
+
+	return count;
 }
 
 static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_connector,
-- 
2.56.0

