Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADA5C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC3C10E2F7;
	Fri, 21 Aug 2026 14:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BN/hgGc7";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3C410E2F7
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787324127;
 bh=1NQCXjNbBWwickplrcTUufFSsIqB6xtRWIcoEJzcS/c=;
 h=From:Date:Subject:To:Cc:From;
 b=BN/hgGc7tJB5TOhqbH1VtlDpFPjq0Z/o1jiL//Vm4uzbjSaUY95N3M25kDlPQFDSU
 n4KADhUWh+TQUO3YwPY9QDHDGu0axorVn1ca56HXUTPqZ9MTGLv9XQHqkI+PJHresr
 j5+Rnwm6R+xPDWJGddvBXa4fI20SFDOFWH8x67tWb4ed+vJh7bdDg5b02Oz0+xj7s9
 FWBsQE7XzO9slQOJQfzIRmCZEl5P/aR/bBAewVwBme8s+E9d07Y6usHA2Gz0bM5jve
 CmLIngEseZ+rDYd7z6fqgZwzmNS/9XA/x6n9aWnhMCYnMGewrkXZQyxtu7P9Pqi4aE
 mpx9mDTUeKIGQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3212E17E07FC;
 Fri, 21 Aug 2026 16:55:27 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id DE7E3480029; Fri, 21 Aug 2026 16:55:26 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 21 Aug 2026 16:55:25 +0200
Subject: [PATCH] drm/connector: Cache out-of-band hotplug events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-connector-oob-hotplug-cache-v1-1-e92e146fdc7b@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBCF4auQWTsJLaFWr2JcwDDQGu2QKRgSw
 t2tuvwW7387ZNbIGa7VDsrvmKOkAnOqgEKXJsY4FIOtrau9NTjoC0lSYlpEUaTHIMv8XCekjgK
 jaRrv3Pky+tZCqczKY9x+D7f733ntH2X+zcJxfADhoKoMgwAAAA==
X-Change-ID: 20260821-drm-connector-oob-hotplug-cache-13386679f852
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>, 
 Igor Paunovic <royalnet026@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8127;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=1NQCXjNbBWwickplrcTUufFSsIqB6xtRWIcoEJzcS/c=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqIZt4ubM9D3a95wpwtPauhCcqBVhY12e2Iy
 4WVohUQYtf6DYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqiGbeAAoJENju1/PI
 O/qaM4oQAJLqYGr/dRsHKecUjFoHDbkSwLOS3splckwN6j7W/kNnfYZAlyaItktY9BFssum3Gp5
 eDhbScjxPc96yxeSOC9CbyK3PnFpyNz6phr4HygpskbJDl2NwQILyAEscnIrOY42BjxINCmU54k
 JtykrXzwEbAwtYyxfjTa8adMNxfF8Mte00eTM+vuUZVFc78r/RQeN/v+oD0z3M61B5PcMFm4zRr
 TrG/j5vdwb+BgQb8mxQCgaEx+7Cg8++N/uMSaxGBR0IX/92n1IvIDAEWPW0SivDsiaZqNa5Lo6f
 MpwK3tmATyy66PgkfJcShVCnpfyD5TwdUQcYj3Y+5a9B7WDKiH+JAHVW1V2U4hBhwUN29c2Koxo
 CZm03EpXn9zaZFOSjNVXBziusgGQmasmQJ6puj2XHBMxJus/nuYUq7tg0RgsIm4qtQQC4A5P1wZ
 /eE3pc38MEAHgRS0kEe53Rqld7f4NQLr0+Q7p1ASxFowUEfZKEvRoVV8crjv+W9qY5qSlwwN20L
 XztmdpVXjH3GZNF3tepcnRgXVksp//Gg6/F3DKMsMwNxRL0HCXa+4V4wu+QWdE5ZSRpCMnCSsId
 t4njpEAdN9CXglcJDnZzpE/x3QatCDdLCM6FXddalWhI39dQt32wCTMPwGtBjkr9pobRVaBqOL2
 DqjrwEkXqbmg6otZ/Nr4lcA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

When the USB-C state machine finished negotiating DP AltMode before the
DRM device has been probed, the out-of-band hotplug events fired to
early and are lost. Without replugging the display or reloading the
USB-C driver, the DRM driver assumes nothing is plugged.

Reproducing this race condition at boot time depends on kernel
configuration and exact USB-C equipment due to timing, but it can easily
be reproduced by reloading the DRM driver consuming the out-of-band
hotplug events without reloading the USB-C driver.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
This has been tested together with the patch series adding USB-C DP
AltMode support for Rockchip RK3588/RK3576. This is mostly independent
and should also affect other platforms, so I'm sending it separately.

I ran into this during development via the module reload path, but it
seems Heiko [0] and Igor [1] managed to hit the race condition with a
normal boot.

[0] https://lore.kernel.org/dri-devel/20767137.geO5KgaWL5@diego/
[1] https://lore.kernel.org/dri-devel/20260811211534.8618-1-royalnet026@gmail.com/
---
 drivers/gpu/drm/drm_connector.c     | 106 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_crtc_internal.h |   1 +
 drivers/gpu/drm/drm_drv.c           |   1 +
 3 files changed, 108 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 8b4baed060f3..b69e3776b153 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -33,6 +33,7 @@
 #include <drm/drm_sysfs.h>
 #include <drm/drm_utils.h>
 
+#include <linux/cleanup.h>
 #include <linux/export.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -81,6 +82,22 @@
 static DEFINE_MUTEX(connector_list_lock);
 static LIST_HEAD(connector_list);
 
+/*
+ * List of connector fwnodes with their last out-of-band hotplug status
+ * required to forward them to a connector on registration. This ensures
+ * the connector sees a HPD event, if the event arrived before the DRM
+ * driver was probed (either due to module reload, or because of bad
+ * timing during bootup).
+ */
+struct drm_oob_hotplug_state {
+	struct list_head head;
+	struct fwnode_handle *fwnode;
+	enum drm_connector_status status;
+};
+
+static DEFINE_MUTEX(oob_hotplug_list_lock);
+static LIST_HEAD(oob_hotplug_list);
+
 struct drm_conn_prop_enum_list {
 	int type;
 	const char *name;
@@ -130,6 +147,19 @@ void drm_connector_ida_destroy(void)
 		ida_destroy(&drm_connector_enum_list[i].ida);
 }
 
+void drm_connector_oob_hotplug_cleanup(void)
+{
+	struct drm_oob_hotplug_state *e, *tmp;
+
+	scoped_guard(mutex, &oob_hotplug_list_lock) {
+		list_for_each_entry_safe(e, tmp, &oob_hotplug_list, head) {
+			list_del(&e->head);
+			fwnode_handle_put(e->fwnode);
+			kfree(e);
+		}
+	}
+}
+
 /**
  * drm_get_connector_type_name - return a string for connector type
  * @type: The connector type (DRM_MODE_CONNECTOR_*)
@@ -829,6 +859,36 @@ void drm_connector_cleanup(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_connector_cleanup);
 
+/**
+ * drm_connector_replay_oob_hotplug_event - send cached OOB HPD event
+ * @connector: the connector that should receive the event
+ *
+ * Send the cached out-of-band hotplug as a new out-of-band hotplug event.
+ */
+static void drm_connector_replay_oob_hotplug_event(struct drm_connector *connector)
+{
+	struct fwnode_handle *fwnode = connector->fwnode;
+	enum drm_connector_status status;
+	struct drm_oob_hotplug_state *e;
+	bool found = false;
+
+	if (!fwnode || !connector->funcs->oob_hotplug_event)
+		return;
+
+	scoped_guard(mutex, &oob_hotplug_list_lock) {
+		list_for_each_entry(e, &oob_hotplug_list, head) {
+			if (e->fwnode == fwnode || fwnode->secondary == e->fwnode) {
+				status = e->status;
+				found = true;
+				break;
+			}
+		}
+	}
+
+	if (found)
+		connector->funcs->oob_hotplug_event(connector, status);
+}
+
 /**
  * drm_connector_register - register a connector
  * @connector: the connector to register
@@ -849,6 +909,7 @@ EXPORT_SYMBOL(drm_connector_cleanup);
  */
 int drm_connector_register(struct drm_connector *connector)
 {
+	bool replay_oob_hotplug = false;
 	int ret = 0;
 
 	if (!connector->dev->registered)
@@ -888,6 +949,7 @@ int drm_connector_register(struct drm_connector *connector)
 	mutex_lock(&connector_list_lock);
 	list_add_tail(&connector->global_connector_list_entry, &connector_list);
 	mutex_unlock(&connector_list_lock);
+	replay_oob_hotplug = true;
 	goto unlock;
 
 err_late_register:
@@ -898,6 +960,10 @@ int drm_connector_register(struct drm_connector *connector)
 	drm_sysfs_connector_remove(connector);
 unlock:
 	mutex_unlock(&connector->mutex);
+
+	if (replay_oob_hotplug)
+		drm_connector_replay_oob_hotplug_event(connector);
+
 	return ret;
 }
 EXPORT_SYMBOL(drm_connector_register);
@@ -3671,6 +3737,41 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
 	return found;
 }
 
+/**
+ * drm_connector_record_oob_hotplug_status - Cache OOB hotplug status
+ * @fwnode - fwnode for the DRM connector
+ * @status - out-of-band status info
+ *
+ * Cache the latest out-of-band hotplug status for a fwnode so it can be
+ * (re)played from when the DRM device is (re)registered after this event
+ * arrived.
+ */
+static void drm_connector_record_oob_hotplug_status(struct fwnode_handle *fwnode,
+						    enum drm_connector_status status)
+{
+	struct drm_oob_hotplug_state *e;
+
+	if (!fwnode)
+		return;
+
+	guard(mutex)(&oob_hotplug_list_lock);
+
+	list_for_each_entry(e, &oob_hotplug_list, head) {
+		if (e->fwnode == fwnode) {
+			e->status = status;
+			return;
+		}
+	}
+
+	e = kzalloc(sizeof(*e), GFP_KERNEL);
+	if (!e)
+		return;
+
+	e->fwnode = fwnode_handle_get(fwnode);
+	e->status = status;
+	list_add_tail(&e->head, &oob_hotplug_list);
+}
+
 /**
  * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
  * @connector_fwnode: fwnode_handle to report the event on
@@ -3683,12 +3784,17 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
  *
  * This function can be used to report these out-of-band events after obtaining
  * a drm_connector reference through calling drm_connector_find_by_fwnode().
+ *
+ * The last status for each fwnode is cached and replayed when a matching DRM
+ * connector device is (re)registered.
  */
 void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
 				     enum drm_connector_status status)
 {
 	struct drm_connector *connector;
 
+	drm_connector_record_oob_hotplug_status(connector_fwnode, status);
+
 	connector = drm_connector_find_by_fwnode(connector_fwnode);
 	if (IS_ERR(connector))
 		return;
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 83146ffef00c..c2714ea256a7 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -188,6 +188,7 @@ int drm_mode_getencoder(struct drm_device *dev,
 /* drm_connector.c */
 void drm_connector_ida_init(void);
 void drm_connector_ida_destroy(void);
+void drm_connector_oob_hotplug_cleanup(void);
 void drm_connector_unregister_all(struct drm_device *dev);
 int drm_connector_register_all(struct drm_device *dev);
 int drm_connector_set_obj_prop(struct drm_mode_object *obj,
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 3c570f9393b9..c1aeab297ff9 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1239,6 +1239,7 @@ static void drm_core_exit(void)
 	drm_sysfs_destroy();
 	WARN_ON(!xa_empty(&drm_minors_xa));
 	drm_connector_ida_destroy();
+	drm_connector_oob_hotplug_cleanup();
 }
 
 static int __init drm_core_init(void)

---
base-commit: d3d1e0c4343385fb343a552e4f3b6b97d5762fc2
change-id: 20260821-drm-connector-oob-hotplug-cache-13386679f852

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

