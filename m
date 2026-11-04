Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C976071A08
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WBYKZVaP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7AB10FEE4;
	Wed,  4 Nov 2026 20:15:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4317010FEE9
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:15:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78DAA601F6;
 Wed,  4 Nov 2026 20:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D886C1F00919;
 Wed,  4 Nov 2026 20:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793823323;
 bh=8eg1cIndD3aXN6OORSZyUuLDRIXHT5eNJHq2G3r23dQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WBYKZVaPCd1ChHZ3f5hLFQwc9eEyQhyO/0YVJmbOEc8dsx2NzWdCy2k2VC4i5PAbB
 Ex7OE0hr6l2meeIQ1Kc7bdJVZha1Os0HMzghZ79kAA6pg/Nemi/I4olUnvzuNDVRPB
 QAA6H0niihaDSCOmkmnzTrgXLRNooAdTYCQM/v2TQ4n1IQTIP3cAN8CsRt1sG7x6BP
 zBCVzD59buvd1g6rDLGopr/wDrndGxvn9QkccgFa/YuYu84JtTt5OJv1FloefSVOVT
 HP6GAVTLrCHySTiETr0p4aBti10/jd26SVFO/yL86E0njxfwzxbk1cOUC8MhdNcZmq
 /mPK1j9fMqkww==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] ACPI: glue: Rename struct acpi_bus_type to
 acpi_dev_type
Date: Wed, 04 Nov 2026 21:11:23 +0100
Message-ID: <10966452.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <3471545.44csPzL39Z@rafael.j.wysocki>
References: <3471545.44csPzL39Z@rafael.j.wysocki>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The name of struct acpi_bus_type is misleading because that data type
is only used for ACPI companion lookup for specific types of devices
and it has nothing to do with buses in principle.  Moreover, it clashes
with the name of the acpi_bus_type variable (that is a const struct
bus_type) which increases the overall confusion.

For this reason, rename struct acpi_bus_type to struct acpi_dev_type and
rename the related functions and variables accordingly in all of the
code using it.

No intentional functional impact beyond messaging.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c         | 32 ++++++++++++++++----------------
 drivers/gpu/drm/drm_sysfs.c | 10 +++++-----
 drivers/thunderbolt/acpi.c  | 10 +++++-----
 drivers/usb/core/usb-acpi.c | 10 +++++-----
 include/acpi/acpi_bus.h     | 10 +++++-----
 5 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 0959f58cb77c..817123c968ba 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -23,52 +23,52 @@
 
 #include "internal.h"
 
-static LIST_HEAD(bus_type_list);
-static DECLARE_RWSEM(bus_type_sem);
+static LIST_HEAD(dev_type_list);
+static DECLARE_RWSEM(dev_type_sem);
 
 #define PHYSICAL_NODE_STRING "physical_node"
 #define PHYSICAL_NODE_NAME_SIZE (sizeof(PHYSICAL_NODE_STRING) + 10)
 
-int register_acpi_bus_type(struct acpi_bus_type *type)
+int register_acpi_dev_type(struct acpi_dev_type *type)
 {
 	if (acpi_disabled)
 		return -ENODEV;
 	if (type && type->match && type->find_companion) {
-		down_write(&bus_type_sem);
-		list_add_tail(&type->list, &bus_type_list);
-		up_write(&bus_type_sem);
-		pr_info("bus type %s registered\n", type->name);
+		down_write(&dev_type_sem);
+		list_add_tail(&type->list, &dev_type_list);
+		up_write(&dev_type_sem);
+		pr_info("device type %s registered\n", type->name);
 		return 0;
 	}
 	return -ENODEV;
 }
-EXPORT_SYMBOL_GPL(register_acpi_bus_type);
+EXPORT_SYMBOL_GPL(register_acpi_dev_type);
 
-int unregister_acpi_bus_type(struct acpi_bus_type *type)
+int unregister_acpi_dev_type(struct acpi_dev_type *type)
 {
 	if (acpi_disabled)
 		return 0;
 	if (type) {
-		down_write(&bus_type_sem);
+		down_write(&dev_type_sem);
 		list_del_init(&type->list);
-		up_write(&bus_type_sem);
-		pr_info("bus type %s unregistered\n", type->name);
+		up_write(&dev_type_sem);
+		pr_info("device type %s unregistered\n", type->name);
 		return 0;
 	}
 	return -ENODEV;
 }
-EXPORT_SYMBOL_GPL(unregister_acpi_bus_type);
+EXPORT_SYMBOL_GPL(unregister_acpi_dev_type);
 
 static struct acpi_device *acpi_companion_lookup(struct device *dev)
 {
-	struct acpi_bus_type *type;
+	struct acpi_dev_type *type;
 
 	if (!dev->type)
 		return NULL;
 
-	guard(rwsem_read)(&bus_type_sem);
+	guard(rwsem_read)(&dev_type_sem);
 
-	list_for_each_entry(type, &bus_type_list, list) {
+	list_for_each_entry(type, &dev_type_list, list) {
 		struct acpi_device *adev;
 
 		if (!type->match(dev))
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 7b16d32b6ff6..585b26515d49 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -64,7 +64,7 @@ static struct device_type drm_sysfs_device_connector = {
 struct class *drm_class;
 
 #ifdef CONFIG_ACPI
-static bool drm_connector_acpi_bus_match(struct device *dev)
+static bool drm_connector_acpi_dev_type_match(struct device *dev)
 {
 	return dev->type == &drm_sysfs_device_connector;
 }
@@ -76,20 +76,20 @@ static struct acpi_device *drm_connector_acpi_find_companion(struct device *dev)
 	return to_acpi_device_node(connector->fwnode);
 }
 
-static struct acpi_bus_type drm_connector_acpi_bus = {
+static struct acpi_dev_type drm_connector_acpi_dev_type = {
 	.name = "drm_connector",
-	.match = drm_connector_acpi_bus_match,
+	.match = drm_connector_acpi_dev_type_match,
 	.find_companion = drm_connector_acpi_find_companion,
 };
 
 static void drm_sysfs_acpi_register(void)
 {
-	register_acpi_bus_type(&drm_connector_acpi_bus);
+	register_acpi_dev_type(&drm_connector_acpi_dev_type);
 }
 
 static void drm_sysfs_acpi_unregister(void)
 {
-	unregister_acpi_bus_type(&drm_connector_acpi_bus);
+	unregister_acpi_dev_type(&drm_connector_acpi_dev_type);
 }
 #else
 static void drm_sysfs_acpi_register(void) { }
diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index be91bc604900..958837e3736e 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -280,7 +280,7 @@ int tb_acpi_power_off_retimers(struct tb_port *port)
 	return tb_acpi_retimer_set_power(port, false);
 }
 
-static bool tb_acpi_bus_match(struct device *dev)
+static bool tb_acpi_dev_type_match(struct device *dev)
 {
 	return tb_is_switch(dev) || tb_is_usb4_port_device(dev);
 }
@@ -351,19 +351,19 @@ static void tb_acpi_setup(struct device *dev)
 		usb4->can_offline = true;
 }
 
-static struct acpi_bus_type tb_acpi_bus = {
+static struct acpi_dev_type tb_acpi_dev_type = {
 	.name = "thunderbolt",
-	.match = tb_acpi_bus_match,
+	.match = tb_acpi_dev_type_match,
 	.find_companion = tb_acpi_find_companion,
 	.setup = tb_acpi_setup,
 };
 
 int tb_acpi_init(void)
 {
-	return register_acpi_bus_type(&tb_acpi_bus);
+	return register_acpi_dev_type(&tb_acpi_dev_type);
 }
 
 void tb_acpi_exit(void)
 {
-	unregister_acpi_bus_type(&tb_acpi_bus);
+	unregister_acpi_dev_type(&tb_acpi_dev_type);
 }
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 489dbdc96f94..f00e8c72ebe6 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -364,23 +364,23 @@ static struct acpi_device *usb_acpi_find_companion(struct device *dev)
 	return NULL;
 }
 
-static bool usb_acpi_bus_match(struct device *dev)
+static bool usb_acpi_dev_type_match(struct device *dev)
 {
 	return is_usb_device(dev) || is_usb_port(dev);
 }
 
-static struct acpi_bus_type usb_acpi_bus = {
+static struct acpi_dev_type usb_acpi_dev_type = {
 	.name = "USB",
-	.match = usb_acpi_bus_match,
+	.match = usb_acpi_dev_type_match,
 	.find_companion = usb_acpi_find_companion,
 };
 
 int usb_acpi_register(void)
 {
-	return register_acpi_bus_type(&usb_acpi_bus);
+	return register_acpi_dev_type(&usb_acpi_dev_type);
 }
 
 void usb_acpi_unregister(void)
 {
-	unregister_acpi_bus_type(&usb_acpi_bus);
+	unregister_acpi_dev_type(&usb_acpi_dev_type);
 }
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f59b2de865e6..8524ceb52b24 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -659,15 +659,15 @@ static inline bool acpi_device_enumerated(struct acpi_device *adev)
 /*
  * Bind physical devices with ACPI devices
  */
-struct acpi_bus_type {
+struct acpi_dev_type {
 	struct list_head list;
 	const char *name;
 	bool (*match)(struct device *dev);
 	struct acpi_device * (*find_companion)(struct device *);
 	void (*setup)(struct device *);
 };
-int register_acpi_bus_type(struct acpi_bus_type *);
-int unregister_acpi_bus_type(struct acpi_bus_type *);
+int register_acpi_dev_type(struct acpi_dev_type *type);
+int unregister_acpi_dev_type(struct acpi_dev_type *type);
 int acpi_bind_one(struct device *dev, struct acpi_device *adev);
 void acpi_unbind_one(struct device *dev);
 
@@ -978,8 +978,8 @@ static inline struct device *acpi_bus_get_primary_device(struct acpi_device *ade
 	return NULL;
 }
 
-static inline int register_acpi_bus_type(void *bus) { return 0; }
-static inline int unregister_acpi_bus_type(void *bus) { return 0; }
+static inline int register_acpi_dev_type(void *type) { return 0; }
+static inline int unregister_acpi_dev_type(void *type) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
-- 
2.51.0




