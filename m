Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4169C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A1410EE48;
	Thu, 17 Sep 2026 12:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sS9mxmH7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD31910EE2D;
 Thu, 17 Sep 2026 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=aKd7pCju4B8d/7p/PpXBZz6Zvw4V9MdgN77MOjhy1xY=; b=sS9mxmH7oaJJnPA1prFs58O5VG
 rX6RAfQ8rtYGdLMMJp6gU1OmUBHx9StWUhY/gQ5kQxBlpSXlfba5O+C7tqenUKBsUwU/1ETv4yLG/
 xUpvOZRpkVlP9aqxLBOWMhzYWdQT5kN9L/d5lGDbk8+b8WCKigkSv1DZb7yE94SvwLo6OdWNx+S/J
 9esBputejglVivJL1ld8DmqTYPNmrGOPFaMfj3XjotoNNPUKwaU35GZMbpXV372bfLSSgWxpHcoqu
 Izla8mXIkIJ4Zsc0hbxFRm8ZGIRue4z4QJvxZrO+kapqq7mUlKh3Lp4HE30TpzZ7GBqR/h1ykSs7S
 3/Ekbe6w==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x7Ar9-003NUM-4P; Thu, 17 Sep 2026 14:04:47 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Ludovico de Nittis <ludovico.denittis@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [RFC 1/2] drm: Allow drivers to report standardized memory stats
Date: Thu, 17 Sep 2026 13:04:43 +0100
Message-ID: <20260917120444.86471-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917120444.86471-1-tvrtko.ursulin@igalia.com>
References: <20260917120444.86471-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a DRM driver level vfunc which allows drivers to opt-in into
reporting standardized memory stats via sysfs.

Via the vfunc drivers can report a list of memory regions in a stable
order, with the names following the memory region names used for fdinfo
memory stats. The region names become directory names under the parent
'memstat' directory.

Each region reports the total size of the region and its current usage,
represented respectively in the total_mb and used_mb files present under
the aforementioned memory region named directories.

The card level 'memstat' directory is only created for drivers who report
at least one memory region.

Amdgpu example:

/sys/class/drm/card1/memstat/
├── gtt
│   ├── total_mb
│   └── used_mb
└── vram
    ├── total_mb
    └── used_mb

Or with concrete numbers:

$ grep -Hr . /sys/class/drm/card1/memstat/
/sys/class/drm/card1/memstat/vram/total_mb:1024
/sys/class/drm/card1/memstat/vram/used_mb:445
/sys/class/drm/card1/memstat/gtt/total_mb:7394
/sys/class/drm/card1/memstat/gtt/used_mb:71

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/drm_drv.c   |  10 +++
 drivers/gpu/drm/drm_sysfs.c | 123 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_device.h    |  19 ++++++
 include/drm/drm_drv.h       |   8 +++
 include/drm/drm_file.h      |   9 +++
 include/drm/drm_sysfs.h     |   4 ++
 6 files changed, 173 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 0cdc606af8d1..ab26cfd73002 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -54,6 +54,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_privacy_screen_machine.h>
 #include <drm/drm_ras_genl_family.h>
+#include <drm/drm_sysfs.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
@@ -197,10 +198,15 @@ static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 	if (ret)
 		goto err_debugfs;
 
+	ret = drm_sysfs_register_memstat(minor);
+	if (ret)
+		goto err_kdev;
+
 	/* replace NULL with @minor so lookups will succeed from now on */
 	entry = xa_store(drm_minor_get_xa(type), minor->index, minor, GFP_KERNEL);
 	if (xa_is_err(entry)) {
 		ret = xa_err(entry);
+		drm_sysfs_unregister_memstat(minor);
 		goto err_debugfs;
 	}
 	WARN_ON(entry);
@@ -208,6 +214,9 @@ static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 	DRM_DEBUG("new minor registered %d\n", minor->index);
 	return 0;
 
+err_kdev:
+	device_del(minor->kdev);
+
 err_debugfs:
 	drm_debugfs_unregister(minor);
 	return ret;
@@ -224,6 +233,7 @@ static void drm_minor_unregister(struct drm_device *dev, enum drm_minor_type typ
 	/* replace @minor with NULL so lookups will fail from now on */
 	xa_store(drm_minor_get_xa(type), minor->index, NULL, GFP_KERNEL);
 
+	drm_sysfs_unregister_memstat(minor);
 	device_del(minor->kdev);
 	dev_set_drvdata(minor->kdev, NULL); /* safety belt */
 	drm_debugfs_unregister(minor);
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 7b16d32b6ff6..4a8c5b0b458d 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -25,6 +25,7 @@
 #include <drm/drm_accel.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_print.h>
@@ -589,3 +590,125 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
 	put_device(kdev);
 	return ERR_PTR(r);
 }
+
+static ssize_t total_mb_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *buf)
+{
+	struct drm_memstat_attr *mattr = container_of(kobj, typeof(*mattr), kobj);
+	struct drm_device *drm = mattr->drm;
+	const struct drm_memory_info *info;
+
+	if (drm->driver->get_memory_info) {
+		info = drm->driver->get_memory_info(drm);
+		if (info)
+			return sysfs_emit(buf, "%u\n",
+					  info->region[mattr->region].total_mb);
+	}
+
+	return 0;
+}
+
+static ssize_t used_mb_show(struct kobject *kobj, struct kobj_attribute *attr,
+			    char *buf)
+{
+	struct drm_memstat_attr *mattr = container_of(kobj, typeof(*mattr), kobj);
+	struct drm_device *drm = mattr->drm;
+	const struct drm_memory_info *info;
+
+	if (drm->driver->get_memory_info) {
+		info = drm->driver->get_memory_info(drm);
+		if (info)
+			return sysfs_emit(buf, "%u\n",
+					  info->region[mattr->region].used_mb);
+	}
+
+	return 0;
+}
+
+static struct kobj_attribute total_attr = __ATTR_RO(total_mb);
+static struct kobj_attribute used_attr = __ATTR_RO(used_mb);
+
+static struct attribute *memstat_attrs[] = {
+	&total_attr.attr,
+	&used_attr.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(memstat);
+
+static void kobj_memstat_release(struct kobject *kobj)
+{
+}
+
+static const struct kobj_type memstat_ktype = {
+	.release = kobj_memstat_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = memstat_groups,
+};
+
+int drm_sysfs_register_memstat(struct drm_minor *minor)
+{
+	const struct drm_memory_info *info = NULL;
+	struct drm_device *drm = minor->dev;
+	struct drm_memstat_attr *regions;
+	struct kobject *root;
+	int i, ret = -ENOMEM;
+
+	if (drm->driver->get_memory_info)
+		info = drm->driver->get_memory_info(drm);
+
+	if (!info || !info->num_regions)
+		return 0;
+
+	regions = kmalloc_objs(*regions, info->num_regions + 1);
+	if (!regions)
+		return -ENOMEM;
+
+	root = kobject_create_and_add("memstat", &minor->kdev->kobj);
+	if (!root)
+		goto err_root;
+
+	for (i = 0; i < info->num_regions; i++) {
+		regions[i].region = i;
+		regions[i].drm = drm;
+		ret = kobject_init_and_add(&regions[i].kobj, &memstat_ktype,
+					   root, "%s", info->region[i].name);
+		if (ret)
+			goto err_regions;
+	}
+
+	minor->sysfs_memstat = root;
+	minor->sysfs_memstat_regions = regions;
+
+	return 0;
+
+err_regions:
+	while (i-- > 0) {
+		kobject_del(&regions[i].kobj);
+		kobject_put(&regions[i].kobj);
+	}
+
+	kobject_del(root);
+	kobject_put(root);
+
+err_root:
+	kfree(regions);
+
+	return ret;
+}
+
+void drm_sysfs_unregister_memstat(struct drm_minor *minor)
+{
+	struct drm_memstat_attr *region = minor->sysfs_memstat_regions;
+
+	while (region && region->kobj.state_initialized) {
+		kobject_del(&region->kobj);
+		kobject_put(&region->kobj);
+		region++;
+	}
+
+	kfree(minor->sysfs_memstat_regions);
+
+	kobject_del(minor->sysfs_memstat);
+	kobject_put(minor->sysfs_memstat);
+}
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 75f030d027ee..0c9260c85b30 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -67,6 +67,25 @@ enum switch_power_state {
 	DRM_SWITCH_POWER_DYNAMIC_OFF = 3,
 };
 
+/**
+ * struct drm_memory_region_info - Memory name and stats for a region
+ * @name: Name of the memory region
+ * @total_mb: Total available memory in mebibytes
+ * @used_mb: Used memory in mebibytes
+ */
+struct drm_memory_region_info {
+	char	name[24];
+
+	u32	total_mb;
+	u32	used_mb;
+};
+
+struct drm_memory_info {
+	unsigned int num_regions;
+
+	struct drm_memory_region_info region[];
+};
+
 /**
  * struct drm_device - DRM device structure
  *
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index b23830494ed4..a3f1906961ac 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -45,6 +45,7 @@ struct drm_minor;
 struct dma_buf;
 struct dma_buf_attachment;
 struct drm_display_mode;
+struct drm_device_memory_info;
 struct drm_mode_create_dumb;
 struct drm_printer;
 struct sg_table;
@@ -387,6 +388,13 @@ struct drm_driver {
 	 */
 	void (*show_fdinfo)(struct drm_printer *p, struct drm_file *f);
 
+	/**
+	 * @get_memory_info:
+	 *
+	 * Get device specific memory info.  See Documentation/gpu/drm-memory-info.rst.
+	 */
+	const struct drm_memory_info * (*get_memory_info)(struct drm_device *dev);
+
 	/** @major: driver major number */
 	int major;
 	/** @minor: driver minor number */
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 6ee70ad65e1f..ebb227a91f60 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -66,6 +66,12 @@ enum drm_minor_type {
 	DRM_MINOR_ACCEL = 32,
 };
 
+struct drm_memstat_attr {
+	struct kobject kobj;
+	unsigned int region;
+	struct drm_device *drm;
+};
+
 /**
  * struct drm_minor - DRM device minor structure
  *
@@ -82,6 +88,9 @@ struct drm_minor {
 	struct device *kdev;		/* Linux device */
 	struct drm_device *dev;
 
+	struct kobject	*sysfs_memstat;
+	struct drm_memstat_attr  *sysfs_memstat_regions;
+
 	struct dentry *debugfs_symlink;
 	struct dentry *debugfs_root;
 };
diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
index 7695873a9456..10ed468965b0 100644
--- a/include/drm/drm_sysfs.h
+++ b/include/drm/drm_sysfs.h
@@ -4,10 +4,14 @@
 
 struct drm_device;
 struct drm_connector;
+struct drm_minor;
 struct drm_property;
 
 void drm_sysfs_hotplug_event(struct drm_device *dev);
 void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
 void drm_sysfs_connector_property_event(struct drm_connector *connector,
 					struct drm_property *property);
+
+int drm_sysfs_register_memstat(struct drm_minor *minor);
+void drm_sysfs_unregister_memstat(struct drm_minor *minor);
 #endif
-- 
2.55.0

