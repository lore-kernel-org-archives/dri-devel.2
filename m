Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004ADCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 05:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF8D10EC56;
	Thu, 28 May 2026 05:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j5mwCnEj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DBF10EC56
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 05:50:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B636340D8A;
 Thu, 28 May 2026 05:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070051F000E9;
 Thu, 28 May 2026 05:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779947406;
 bh=aUt/D8mF57CRE5/o8Gq2uhBx98D3WcFnpCuF09ljtQg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j5mwCnEjxryCdHcSgh4YiFku6nbQacq3pc/c4q01tig9HvRg3hO0tlTK/Otw2x/9b
 3aWl2dxpjYx7BUitaBZO2ssbSPzk8EuJGSoTUSuIEwRV4WDdr2VwQNsnCLsISsfpNU
 jwk47ZRj+jZzYXR9bdEBuHt/YnqMWvt++lm9uLv1tfW/ulwzvdji/j83jOfJ5YHABB
 8RaS5rbLyQ5X2VVRLIab4YSv3UuuWp6tSrWwV2Z4p3R8alPvExbySkMGbG9rYMI5pI
 K5ljU/6bnKFg9HM2BAjUto4Af8xrGsjLoIEAnd8nnhsS4BLUynAWx2Wh9HO6eu19GY
 zNpDIZuO016eA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v4 3/9] drm: link connectors to backlight devices
Date: Thu, 28 May 2026 00:49:05 -0500
Message-ID: <20260528054911.1513208-4-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528054911.1513208-1-superm1@kernel.org>
References: <20260528054911.1513208-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This will show which connector in sysfs matches which backlight.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/Kconfig             |   1 +
 drivers/gpu/drm/Makefile            |   2 +
 drivers/gpu/drm/drm_atomic_helper.c |   8 +
 drivers/gpu/drm/drm_backlight.c     | 430 ++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c     |  12 +
 drivers/gpu/drm/drm_drv.c           |   8 +
 drivers/gpu/drm/drm_mode_config.c   |   7 +
 drivers/gpu/drm/drm_mode_object.c   |  66 ++++-
 drivers/gpu/drm/drm_sysfs.c         |  28 +-
 drivers/video/backlight/backlight.c |  17 ++
 include/drm/drm_backlight.h         |  46 +++
 include/drm/drm_connector.h         |   3 +
 include/drm/drm_mode_config.h       |   5 +
 include/linux/backlight.h           |  13 +
 14 files changed, 641 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_backlight.c
 create mode 100644 include/drm/drm_backlight.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 8f5a8d3012e4..8c00f534d50b 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -17,6 +17,7 @@ menuconfig DRM
 # device and dmabuf fd. Let's make sure that is available for our userspace.
 	select KCMP
 	select VIDEO
+	select BACKLIGHT_CLASS_DEVICE
 	help
 	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
 	  introduced in XFree86 4.0. If you say Y here, you need to select
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..9912306e9495 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -78,6 +78,8 @@ drm-$(CONFIG_DRM_CLIENT) += \
 	drm_client_event.o \
 	drm_client_modeset.o \
 	drm_client_sysrq.o
+drm-y += drm_backlight.o
+drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
 drm-$(CONFIG_COMPAT) += drm_ioc32.o
 drm-$(CONFIG_DRM_PANEL) += drm_panel.o
 drm-$(CONFIG_OF) += drm_of.o
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index a768398a1884..cb76291a9355 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1224,6 +1224,10 @@ drm_atomic_helper_commit_encoder_bridge_disable(struct drm_device *dev,
 		 * it away), so we won't call disable hooks twice.
 		 */
 		bridge = drm_bridge_chain_get_first_bridge(encoder);
+
+		if (connector->backlight)
+			drm_backlight_set_luminance(connector->backlight, 0);
+
 		drm_atomic_bridge_chain_disable(bridge, state);
 		drm_bridge_put(bridge);
 
@@ -1738,6 +1742,10 @@ drm_atomic_helper_commit_encoder_bridge_enable(struct drm_device *dev, struct dr
 
 		drm_atomic_bridge_chain_enable(bridge, state);
 		drm_bridge_put(bridge);
+
+		if (connector->backlight && connector->state)
+			drm_backlight_set_luminance(connector->backlight,
+						    connector->state->luminance);
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_encoder_bridge_enable);
diff --git a/drivers/gpu/drm/drm_backlight.c b/drivers/gpu/drm/drm_backlight.c
new file mode 100644
index 000000000000..a54629749ce4
--- /dev/null
+++ b/drivers/gpu/drm/drm_backlight.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: MIT
+/*
+ * DRM Backlight Helpers
+ * Copyright (c) 2014 David Herrmann
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/backlight.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <drm/drm_backlight.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_device.h>
+#include <drm/drm_mode_config.h>
+
+/**
+ * DOC: Backlight Devices
+ *
+ * Backlight devices have always been managed as a separate subsystem,
+ * independent of DRM. They are usually controlled via separate hardware
+ * interfaces than the display controller, so the split works out fine.
+ * However, backlight brightness is a property of a display, and thus a
+ * property of a DRM connector. We already manage DPMS states via connector
+ * properties, so it is natural to keep brightness control at the same place.
+ *
+ * This DRM backlight interface implements generic backlight properties on
+ * connectors. It does not handle any hardware backends but simply forwards
+ * the requests to a linked backlight device. The links between connectors and
+ * backlight devices are established by DRM drivers; user-space cannot create
+ * or modify these links. A 'change' uevent is sent whenever the brightness is
+ * updated.
+ *
+ * Drivers have to call drm_backlight_alloc() after allocating a connector via
+ * drm_connector_init(). This will automatically add a backlight device to the
+ * given connector. Drivers must then link a hardware backlight by calling
+ * drm_backlight_link() with the registered backlight_device. If no link is
+ * established, the DRM backlight property reports an empty range and
+ * brightness changes are no-ops.
+ */
+
+struct drm_backlight {
+	struct list_head list;
+	struct drm_connector *connector;
+	struct backlight_device *link;
+	struct work_struct work;
+	unsigned int set_value;
+	bool changed : 1;
+};
+
+static LIST_HEAD(drm_backlight_list);
+static DEFINE_SPINLOCK(drm_backlight_lock);
+
+/* caller must hold @drm_backlight_lock */
+static bool __drm_backlight_is_registered(struct drm_backlight *b)
+{
+	lockdep_assert_held(&drm_backlight_lock);
+	/* a device is live if it is linked to @drm_backlight_list */
+	return !list_empty(&b->list);
+}
+
+/* caller must hold @drm_backlight_lock */
+static void __drm_backlight_schedule(struct drm_backlight *b)
+{
+	lockdep_assert_held(&drm_backlight_lock);
+	if (__drm_backlight_is_registered(b))
+		schedule_work(&b->work);
+}
+
+static void __drm_backlight_worker(struct work_struct *w)
+{
+	struct drm_backlight *b = container_of(w, struct drm_backlight, work);
+	static const char * const ep[] = { "BACKLIGHT=1", NULL };
+	struct backlight_device *bd;
+	bool send_uevent;
+	unsigned int v;
+
+	scoped_guard(spinlock, &drm_backlight_lock) {
+		send_uevent = b->changed;
+		b->changed = false;
+		v = b->set_value;
+		bd = b->link;
+		backlight_device_ref(bd);
+	}
+
+	if (bd) {
+		int rc = backlight_set_brightness(bd, v, BACKLIGHT_UPDATE_DRM);
+
+		WARN_ON(rc);
+		if (rc)
+			backlight_set_brightness(bd, U16_MAX, BACKLIGHT_UPDATE_DRM);
+		backlight_device_unref(bd);
+	}
+
+	if (send_uevent)
+		kobject_uevent_env(&b->connector->kdev->kobj, KOBJ_CHANGE, ep);
+}
+
+/* caller must hold @drm_backlight_lock */
+static void __drm_backlight_prop_changed(struct drm_backlight *b, unsigned int v)
+{
+	unsigned int max;
+
+	lockdep_assert_held(&drm_backlight_lock);
+
+	if (!b || !b->link)
+		return;
+
+	max = b->link->props.max_brightness;
+	if (max == 0)
+		return;
+
+	/* Clamp to max brightness */
+	b->set_value = min(v, max);
+	__drm_backlight_schedule(b);
+}
+
+/* caller must hold @drm_backlight_lock */
+static void __drm_backlight_real_changed(struct drm_backlight *b, uint64_t v)
+{
+	lockdep_assert_held(&drm_backlight_lock);
+
+	/* Atomic state update of the luminance property is wired up by a
+	 * follow-up patch that introduces the connector_state field.
+	 */
+}
+
+/**
+ * __drm_backlight_update_prop_range - update the luminance property range
+ * @b: backlight device
+ *
+ * Updates the luminance property range based on the linked backlight device's
+ * max_brightness. If no device is linked, sets range to 0-0 to indicate
+ * unavailability.
+ */
+static void __drm_backlight_update_prop_range(struct drm_backlight *b)
+{
+	struct drm_device *dev = b->connector->dev;
+	struct drm_property *prop = dev->mode_config.luminance_property;
+	unsigned int max = 0;
+
+	lockdep_assert_held(&drm_backlight_lock);
+
+	if (b->link && b->link->props.max_brightness > 0)
+		max = b->link->props.max_brightness;
+
+	/* Update property range to match hardware capabilities.
+	 * Range of 0-0 indicates no backing device.
+	 */
+	if (prop->values[1] != max) {
+		prop->values[0] = 0;
+		prop->values[1] = max;
+		/* Send uevent to notify userspace of range change */
+		b->changed = true;
+	}
+}
+
+/* caller must hold @drm_backlight_lock */
+static void __drm_backlight_link(struct drm_backlight *b,
+				 struct backlight_device *bd)
+{
+	if (bd == b->link)
+		return;
+
+	backlight_device_unref(b->link);
+	b->link = bd;
+	backlight_device_ref(b->link);
+	if (bd)
+		__drm_backlight_real_changed(b, bd->props.brightness);
+	__drm_backlight_update_prop_range(b);
+	b->changed = true;
+	__drm_backlight_schedule(b);
+}
+
+/**
+ * drm_backlight_alloc - add backlight capability to a connector
+ * @connector: connector to add backlight to
+ *
+ * This allocates a new DRM-backlight device and attaches it to @connector.
+ * This *must* be called before registering the connector. The backlight
+ * device will be automatically registered in sync with the connector. It will
+ * also get removed once the connector is removed.
+ *
+ * No hardware backlight is linked by default. Drivers must call
+ * drm_backlight_link() to associate a registered backlight_device with the
+ * connector. User-space cannot create or modify this link.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int drm_backlight_alloc(struct drm_connector *connector)
+{
+	struct drm_mode_config *config = &connector->dev->mode_config;
+	struct drm_backlight *b;
+
+	b = kzalloc_obj(*b, GFP_KERNEL);
+	if (!b)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&b->list);
+	INIT_WORK(&b->work, __drm_backlight_worker);
+	b->connector = connector;
+	connector->backlight = b;
+
+	drm_object_attach_property(&connector->base,
+				   config->luminance_property, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_backlight_alloc);
+
+void drm_backlight_free(struct drm_connector *connector)
+{
+	struct drm_backlight *b = connector->backlight;
+
+	if (!b)
+		return;
+
+	WARN_ON(__drm_backlight_is_registered(b));
+	WARN_ON(b->link);
+
+	kfree(b);
+	connector->backlight = NULL;
+}
+EXPORT_SYMBOL(drm_backlight_free);
+
+void drm_backlight_register(struct drm_backlight *b)
+{
+	if (!b)
+		return;
+
+	WARN_ON(__drm_backlight_is_registered(b));
+
+	guard(spinlock)(&drm_backlight_lock);
+	list_add(&b->list, &drm_backlight_list);
+}
+EXPORT_SYMBOL(drm_backlight_register);
+
+void drm_backlight_unregister(struct drm_backlight *b)
+{
+	if (!b)
+		return;
+
+	WARN_ON(!__drm_backlight_is_registered(b));
+
+	scoped_guard(spinlock, &drm_backlight_lock) {
+		list_del_init(&b->list);
+		__drm_backlight_link(b, NULL);
+	}
+
+	cancel_work_sync(&b->work);
+}
+EXPORT_SYMBOL(drm_backlight_unregister);
+
+/**
+ * drm_backlight_link - link a backlight device to a DRM backlight
+ * @b: DRM backlight to modify
+ * @bd: backlight device to link, or NULL to unlink
+ *
+ * Establish the link between a DRM connector's backlight property and a
+ * registered backlight_device. Drivers must call this with the
+ * backlight_device they registered for the connector. Passing NULL unlinks
+ * any previously linked device.
+ *
+ * The caller is responsible for ensuring @bd remains valid until either it
+ * is unlinked via drm_backlight_link(b, NULL) or the connector is
+ * unregistered.
+ *
+ * Whenever a hardware backlight is linked or unlinked, a uevent with
+ * "BACKLIGHT=1" is generated on the connector.
+ */
+void drm_backlight_link(struct drm_backlight *b, struct backlight_device *bd)
+{
+	if (!b)
+		return;
+
+	guard(spinlock)(&drm_backlight_lock);
+	__drm_backlight_link(b, bd);
+}
+EXPORT_SYMBOL(drm_backlight_link);
+
+/**
+ * drm_backlight_get_device - get the backlight_device linked to a DRM backlight
+ * @b: DRM backlight
+ *
+ * Returns the &backlight_device linked to @b, or NULL if no device is linked
+ * or @b is NULL. The caller must hold the appropriate lock to prevent the
+ * link from changing while the pointer is in use.
+ */
+struct backlight_device *drm_backlight_get_device(struct drm_backlight *b)
+{
+	if (!b)
+		return NULL;
+
+	guard(spinlock)(&drm_backlight_lock);
+	return b->link;
+}
+EXPORT_SYMBOL(drm_backlight_get_device);
+
+/**
+ * drm_backlight_inhibit_legacy - disable legacy sysfs control of the linked bd
+ * @b: DRM backlight to inhibit
+ *
+ * Record that one more luminance-aware DRM client has taken over @b. While
+ * any clients are recorded, writes to the linked backlight_device's legacy
+ * ``brightness`` sysfs attribute return ``-EBUSY``. The takeover follows
+ * @b->link if the link changes.
+ *
+ * Calls must be balanced with drm_backlight_uninhibit_legacy().
+ */
+void drm_backlight_inhibit_legacy(struct drm_backlight *b)
+{
+	if (!b)
+		return;
+
+	guard(spinlock)(&drm_backlight_lock);
+	b->luminance_clients++;
+	if (b->link)
+		atomic_inc(&b->link->drm_takeover);
+}
+EXPORT_SYMBOL(drm_backlight_inhibit_legacy);
+
+/**
+ * drm_backlight_uninhibit_legacy - re-enable legacy sysfs control
+ * @b: DRM backlight to uninhibit
+ *
+ * Balances a previous drm_backlight_inhibit_legacy() call. When the last
+ * luminance-aware client goes away, legacy sysfs writes are allowed again.
+ */
+void drm_backlight_uninhibit_legacy(struct drm_backlight *b)
+{
+	if (!b)
+		return;
+
+	guard(spinlock)(&drm_backlight_lock);
+	if (WARN_ON(b->luminance_clients == 0))
+		return;
+	b->luminance_clients--;
+	if (b->link)
+		atomic_dec(&b->link->drm_takeover);
+}
+EXPORT_SYMBOL(drm_backlight_uninhibit_legacy);
+
+/**
+ * drm_backlight_inhibit_legacy_all - inhibit legacy sysfs on every connector
+ * @dev: DRM device whose connectors should be inhibited
+ *
+ * Walks all connectors on @dev and calls drm_backlight_inhibit_legacy() on
+ * each connector that has a DRM backlight attached. Used when a client
+ * declares it is luminance-aware via DRM_CLIENT_CAP_LUMINANCE.
+ */
+void drm_backlight_inhibit_legacy_all(struct drm_device *dev)
+{
+	struct drm_connector_list_iter iter;
+	struct drm_connector *connector;
+
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter)
+		drm_backlight_inhibit_legacy(connector->backlight);
+	drm_connector_list_iter_end(&iter);
+}
+EXPORT_SYMBOL(drm_backlight_inhibit_legacy_all);
+
+/**
+ * drm_backlight_uninhibit_legacy_all - reverse drm_backlight_inhibit_legacy_all()
+ * @dev: DRM device whose connectors should be uninhibited
+ */
+void drm_backlight_uninhibit_legacy_all(struct drm_device *dev)
+{
+	struct drm_connector_list_iter iter;
+	struct drm_connector *connector;
+
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter)
+		drm_backlight_uninhibit_legacy(connector->backlight);
+	drm_connector_list_iter_end(&iter);
+}
+EXPORT_SYMBOL(drm_backlight_uninhibit_legacy_all);
+
+void drm_backlight_set_luminance(struct drm_backlight *b, unsigned int value)
+{
+	guard(spinlock)(&drm_backlight_lock);
+	__drm_backlight_prop_changed(b, value);
+}
+EXPORT_SYMBOL(drm_backlight_set_luminance);
+
+static int drm_backlight_notify(struct notifier_block *self,
+				unsigned long event, void *data)
+{
+	struct backlight_device *bd = data;
+	struct drm_backlight *b;
+
+	guard(spinlock)(&drm_backlight_lock);
+
+	switch (event) {
+	case BACKLIGHT_UNREGISTERED:
+		list_for_each_entry(b, &drm_backlight_list, list)
+			if (b->link == bd)
+				__drm_backlight_link(b, NULL);
+
+		break;
+	case BACKLIGHT_BRIGHTNESS_CHANGED:
+		/* Update DRM property value when hardware backlight changes */
+		list_for_each_entry(b, &drm_backlight_list, list)
+			if (b->link == bd)
+				__drm_backlight_real_changed(b, bd->props.brightness);
+
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block drm_backlight_notifier = {
+	.notifier_call = drm_backlight_notify,
+};
+
+int drm_backlight_init(void)
+{
+	return backlight_register_notifier(&drm_backlight_notifier);
+}
+
+void drm_backlight_exit(void)
+{
+	backlight_unregister_notifier(&drm_backlight_notifier);
+}
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 47dc53c4a738..09bb790782f1 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -21,6 +21,7 @@
  */
 
 #include <drm/drm_auth.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
@@ -760,6 +761,7 @@ void drm_connector_cleanup(struct drm_connector *connector)
 	struct drm_device *dev = connector->dev;
 	struct drm_display_mode *mode, *t;
 
+	drm_backlight_free(connector);
 	/* The connector should have been removed from userspace long before
 	 * it is finally destroyed.
 	 */
@@ -845,6 +847,8 @@ int drm_connector_register(struct drm_connector *connector)
 	if (connector->registration_state != DRM_CONNECTOR_INITIALIZING)
 		goto unlock;
 
+	drm_backlight_register(connector->backlight);
+
 	ret = drm_sysfs_connector_add(connector);
 	if (ret)
 		goto unlock;
@@ -931,6 +935,8 @@ EXPORT_SYMBOL(drm_connector_dynamic_register);
 void drm_connector_unregister(struct drm_connector *connector)
 {
 	mutex_lock(&connector->mutex);
+	drm_backlight_unregister(connector->backlight);
+
 	if (connector->registration_state != DRM_CONNECTOR_REGISTERED) {
 		mutex_unlock(&connector->mutex);
 		return;
@@ -3257,10 +3263,16 @@ int drm_connector_set_obj_prop(struct drm_mode_object *obj,
 {
 	int ret = -EINVAL;
 	struct drm_connector *connector = obj_to_connector(obj);
+	struct drm_mode_config *config = &connector->dev->mode_config;
 
 	/* Do DPMS ourselves */
 	if (property == connector->dev->mode_config.dpms_property) {
 		ret = (*connector->funcs->dpms)(connector, (int)value);
+	} else if (property == config->luminance_property) {
+		if (connector->backlight && connector->dpms == DRM_MODE_DPMS_ON)
+			drm_backlight_set_luminance(connector->backlight,
+						    value);
+		ret = 0;
 	} else if (connector->funcs->set_property)
 		ret = connector->funcs->set_property(connector, property, value);
 
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 675675480da4..5bf402197867 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -42,6 +42,7 @@
 #include <linux/xarray.h>
 
 #include <drm/drm_accel.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_cache.h>
 #include <drm/drm_client_event.h>
@@ -1230,6 +1231,7 @@ static void drm_core_exit(void)
 	drm_privacy_screen_lookup_exit();
 	drm_panic_exit();
 	accel_core_exit();
+	drm_backlight_exit();
 	unregister_chrdev(DRM_MAJOR, "drm");
 	drm_debugfs_remove_root();
 	drm_sysfs_destroy();
@@ -1253,6 +1255,12 @@ static int __init drm_core_init(void)
 	drm_debugfs_init_root();
 	drm_debugfs_bridge_params();
 
+	ret = drm_backlight_init();
+	if (ret < 0) {
+		DRM_ERROR("Cannot initialize backlight interface\n");
+		goto error;
+	}
+
 	ret = register_chrdev(DRM_MAJOR, "drm", &drm_stub_fops);
 	if (ret < 0)
 		goto error;
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 66f7dc37b597..25c5d2969462 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -32,6 +32,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_colorop.h>
 #include <linux/dma-resv.h>
+#include <drm/drm_backlight.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
@@ -407,6 +408,12 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
 		return -ENOMEM;
 	dev->mode_config.size_hints_property = prop;
 
+	prop = drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
+					 "LUMINANCE", 0, 0);
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.luminance_property = prop;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 2d943a610b88..e6f0027d70cb 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -30,6 +30,7 @@
 #include <drm/drm_mode_object.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
+#include <drm/drm_backlight.h>
 
 #include "drm_crtc_internal.h"
 
@@ -287,11 +288,72 @@ int drm_object_property_set_value(struct drm_mode_object *obj,
 {
 	int i;
 
-	WARN_ON(drm_drv_uses_atomic_modeset(property->dev) &&
-		!(property->flags & DRM_MODE_PROP_IMMUTABLE));
+	/* Exempt dpms and luminance properties from the atomic warning, as these
+	 * have special interdependencies managed internally in this function
+	 */
+	if (obj->type == DRM_MODE_OBJECT_CONNECTOR) {
+		struct drm_connector *connector = obj_to_connector(obj);
+		struct drm_mode_config *config = &connector->dev->mode_config;
+
+		if (property != config->dpms_property &&
+		    property != config->luminance_property) {
+			WARN_ON(drm_drv_uses_atomic_modeset(property->dev) &&
+				!(property->flags & DRM_MODE_PROP_IMMUTABLE));
+		}
+	} else {
+		WARN_ON(drm_drv_uses_atomic_modeset(property->dev) &&
+			!(property->flags & DRM_MODE_PROP_IMMUTABLE));
+	}
 
 	for (i = 0; i < obj->properties->count; i++) {
+		/* If properties depends on each other
+		 * this is where to resolve that issue
+		 */
 		if (obj->properties->properties[i] == property) {
+			/* Connector-specific property interdependencies */
+			if (obj->type == DRM_MODE_OBJECT_CONNECTOR) {
+				struct drm_connector *connector = obj_to_connector(obj);
+				struct drm_property *dpms_property =
+					connector->dev->mode_config.dpms_property;
+				struct drm_property *luminance_property =
+					connector->dev->mode_config.luminance_property;
+
+				if (property == dpms_property) {
+					/* When DPMS goes from ON -> OFF,
+					 * set the brightness to the minimum possible
+					 * to save power.
+					 */
+					if (obj->properties->values[i] !=
+					    DRM_MODE_DPMS_OFF &&
+					    val == DRM_MODE_DPMS_OFF)
+						drm_backlight_set_luminance(
+							connector->backlight, 0);
+					/* When DPMS OFF -> ON, reset the brightness
+					 * to the original level
+					 */
+					else if (obj->properties->values[i] ==
+						 DRM_MODE_DPMS_OFF &&
+						 val != DRM_MODE_DPMS_OFF) {
+						uint64_t value;
+
+						drm_object_property_get_value(
+							obj, luminance_property,
+							&value);
+						drm_backlight_set_luminance(
+							connector->backlight, value);
+					}
+				} else if (property == luminance_property) {
+					/* Always update the property value to remember
+					 * the user's desired brightness, but only update
+					 * hardware when DPMS is ON.
+					 */
+					obj->properties->values[i] = val;
+					if (connector->dpms == DRM_MODE_DPMS_ON)
+						drm_backlight_set_luminance(
+							connector->backlight, val);
+					return 0;
+				}
+			}
 			obj->properties->values[i] = val;
 			return 0;
 		}
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index ef4e923a8728..8609e1660f21 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/backlight.h>
 #include <linux/component.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -27,6 +28,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_print.h>
 #include <drm/drm_property.h>
 #include <drm/drm_sysfs.h>
@@ -391,15 +393,35 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
 
 int drm_sysfs_connector_add_late(struct drm_connector *connector)
 {
-	if (connector->ddc)
-		return sysfs_create_link(&connector->kdev->kobj,
-					 &connector->ddc->dev.kobj, "ddc");
+	if (connector->ddc) {
+		int ret = sysfs_create_link(&connector->kdev->kobj,
+					    &connector->ddc->dev.kobj, "ddc");
+		if (ret)
+			return ret;
+	}
+
+	if (connector->backlight) {
+		struct backlight_device *bd = drm_backlight_get_device(connector->backlight);
+
+		if (bd) {
+			int ret = sysfs_create_link(&connector->kdev->kobj,
+						    &bd->dev.kobj, "backlight");
+			if (ret) {
+				if (connector->ddc)
+					sysfs_remove_link(&connector->kdev->kobj, "ddc");
+				return ret;
+			}
+		}
+	}
 
 	return 0;
 }
 
 void drm_sysfs_connector_remove_early(struct drm_connector *connector)
 {
+	if (connector->backlight && drm_backlight_get_device(connector->backlight))
+		sysfs_remove_link(&connector->kdev->kobj, "backlight");
+
 	if (connector->ddc)
 		sysfs_remove_link(&connector->kdev->kobj, "ddc");
 }
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 661243afc877..68e472d8f3fd 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -126,6 +126,9 @@ static void backlight_generate_event(struct backlight_device *bd,
 	case BACKLIGHT_UPDATE_HOTKEY:
 		envp[0] = "SOURCE=hotkey";
 		break;
+	case BACKLIGHT_UPDATE_DRM:
+		envp[0] = "SOURCE=drm";
+		break;
 	default:
 		envp[0] = "SOURCE=unknown";
 		break;
@@ -581,6 +584,20 @@ int backlight_unregister_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(backlight_unregister_notifier);
 
+/**
+ * backlight_notify_brightness - notify brightness change to listeners
+ * @bd: backlight device that changed
+ *
+ * Notify registered listeners that the backlight brightness has changed.
+ * This is called automatically after successful brightness updates.
+ */
+void backlight_notify_brightness(struct backlight_device *bd)
+{
+	blocking_notifier_call_chain(&backlight_notifier,
+				     BACKLIGHT_BRIGHTNESS_CHANGED, bd);
+}
+EXPORT_SYMBOL(backlight_notify_brightness);
+
 /**
  * devm_backlight_device_register - register a new backlight device
  * @dev: the device to register
diff --git a/include/drm/drm_backlight.h b/include/drm/drm_backlight.h
new file mode 100644
index 000000000000..c35345664a5d
--- /dev/null
+++ b/include/drm/drm_backlight.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: MIT */
+#ifndef __DRM_BACKLIGHT_H__
+#define __DRM_BACKLIGHT_H__
+
+/*
+ * Copyright (c) 2014 David Herrmann <dh.herrmann at gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+struct backlight_device;
+struct drm_backlight;
+struct drm_connector;
+struct drm_mode_object;
+
+int drm_backlight_init(void);
+void drm_backlight_exit(void);
+
+int drm_backlight_alloc(struct drm_connector *connector);
+void drm_backlight_free(struct drm_connector *connector);
+void drm_backlight_register(struct drm_backlight *b);
+void drm_backlight_unregister(struct drm_backlight *b);
+
+void drm_backlight_link(struct drm_backlight *b, struct backlight_device *bd);
+struct backlight_device *drm_backlight_get_device(struct drm_backlight *b);
+void drm_backlight_set_luminance(struct drm_backlight *b, unsigned int value);
+#endif /* __DRM_BACKLIGHT_H__ */
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f83f28cae207..10daf088b8f1 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2410,6 +2410,9 @@ struct drm_connector {
 	 * @cec: CEC-related data.
 	 */
 	struct drm_connector_cec cec;
+
+	/* backlight link */
+	struct drm_backlight *backlight;
 };
 
 #define obj_to_connector(x) container_of(x, struct drm_connector, base)
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 687c0ee163d2..b340dc93f814 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -852,6 +852,11 @@ struct drm_mode_config {
 	 * the position of the output on the host's screen.
 	 */
 	struct drm_property *suggested_y_property;
+	/**
+	 * @luminance_property: Default connector property to control the
+	 * connector's backlight luminance.
+	 */
+	struct drm_property *luminance_property;
 
 	/**
 	 * @non_desktop_property: Optional connector property with a hint
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 204eea9256fd..26a7281d179c 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -29,6 +29,7 @@ enum backlight_update_reason {
 	 * @BACKLIGHT_UPDATE_SYSFS: The backlight was updated using sysfs.
 	 */
 	BACKLIGHT_UPDATE_SYSFS,
+	BACKLIGHT_UPDATE_DRM,
 };
 
 /**
@@ -80,6 +81,11 @@ enum backlight_notification {
 	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
 	 */
 	BACKLIGHT_UNREGISTERED,
+
+	/**
+	 * @BACKLIGHT_BRIGHTNESS_CHANGED: The backlight brightness has changed.
+	 */
+	BACKLIGHT_BRIGHTNESS_CHANGED,
 };
 
 /** enum backlight_scale - the type of scale used for brightness values
@@ -310,6 +316,9 @@ struct backlight_device {
 	int use_count;
 };
 
+/* Forward declaration for backlight_update_status */
+void backlight_notify_brightness(struct backlight_device *bd);
+
 /**
  * backlight_update_status - force an update of the backlight device status
  * @bd: the backlight device
@@ -323,6 +332,10 @@ static inline int backlight_update_status(struct backlight_device *bd)
 		ret = bd->ops->update_status(bd);
 	mutex_unlock(&bd->update_lock);
 
+	/* Notify DRM and other listeners that brightness changed */
+	if (ret == 0)
+		backlight_notify_brightness(bd);
+
 	return ret;
 }
 
-- 
2.54.0

