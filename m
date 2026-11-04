Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64756071A08
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ty1hxZ/0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F3810FEEB;
	Wed,  4 Nov 2026 20:15:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B82F10FEEB
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:15:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DFF2E42EB7;
 Wed,  4 Nov 2026 20:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6BF1F000C1;
 Wed,  4 Nov 2026 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793823314;
 bh=8lSlQQ0eySOWPIi3f+Vi2MS1GtAaf8UmS47WUxgG3Uo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ty1hxZ/01RiO++N8fIKo3R7qjFmMwXCero4QLeTafahuTnUZXRGlRjswbEbdm49pI
 gumTFyLEnsnlsOfNVwkhax+cz9O219S7q2LZly497wtu96iSFTM0ejAempjs+BwKcN
 D1eXp0sjZdgGh9lMLx6/K++uYTEii8T5amItUU3gl+SB3uJLqiGCEy59WHcpKc7N/D
 kk4tC2ZIanOyjxwlgJX2DZPaPGm3wCEHc8GIgBm1eIKXm4g8DVs7fELmwYoU29scVZ
 +9VCQu2C02qfrWYE2QX9meun8Vin237wmGos1DixiQJhgFnNcxiBLYHQaJe8+aETFD
 KoCMnkirCDAnw==
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
Subject: [PATCH v1 3/3] ACPI: glue: Simplify struct acpi_dev_type and its usage
Date: Wed, 04 Nov 2026 21:14:57 +0100
Message-ID: <8036646.EvYhyI6sBW@rafael.j.wysocki>
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

All of the current users of struct acpi_dev_type match the device type
in their .match() callbacks and all of them use const device type
pointers for that which means that the structure can be simplified and
used in a more straightforward way.

Namely, modify struct acpi_dev_type to contain a const device type
pointer instead of the .match() callback and remove the name field
from it.  Next, update the users of struct acpi_dev_type to register
a separate object of that type for each device type that requires an
ACPI companion lookup.

Since the register_acpi_dev_type() and unregister_acpi_dev_type()
function bodies are rewiritten entirely anyway, make them use
guard(rwsem_write) instead of down_write()/up_write() pairs and
print the messages under the semaphore to ensure that the struct
acpi_dev_type objects they refer to will not be freed prematurely.

No intentional functional impact beyond messaging.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c         | 33 ++++++++++--------
 drivers/gpu/drm/drm_sysfs.c |  8 +----
 drivers/thunderbolt/acpi.c  | 69 +++++++++++++++++--------------------
 drivers/usb/core/usb-acpi.c | 47 ++++++++++---------------
 include/acpi/acpi_bus.h     |  4 +--
 5 files changed, 72 insertions(+), 89 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 51caaa73a43c..8b75a8c805a4 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -31,29 +31,32 @@ static DECLARE_RWSEM(dev_type_sem);
 
 void register_acpi_dev_type(struct acpi_dev_type *type)
 {
-	if (acpi_disabled)
+	if (acpi_disabled || !type)
 		return;
 
-	if (type && type->match && type->find_companion) {
-		down_write(&dev_type_sem);
-		list_add_tail(&type->list, &dev_type_list);
-		up_write(&dev_type_sem);
-		pr_info("device type %s registered\n", type->name);
-	}
+	INIT_LIST_HEAD(&type->list);
+
+	if (!type->dev_type || !type->find_companion)
+		return;
+
+	guard(rwsem_write)(&dev_type_sem);
+
+	list_add_tail(&type->list, &dev_type_list);
+
+	pr_info("Device type %s added to lookup list\n", type->dev_type->name);
 }
 EXPORT_SYMBOL_GPL(register_acpi_dev_type);
 
 void unregister_acpi_dev_type(struct acpi_dev_type *type)
 {
-	if (acpi_disabled)
+	if (acpi_disabled || !type || !type->dev_type || !type->find_companion)
 		return;
 
-	if (type) {
-		down_write(&dev_type_sem);
-		list_del_init(&type->list);
-		up_write(&dev_type_sem);
-		pr_info("device type %s unregistered\n", type->name);
-	}
+	guard(rwsem_write)(&dev_type_sem);
+
+	list_del(&type->list);
+
+	pr_info("Device type %s removed from lookup list\n", type->dev_type->name);
 }
 EXPORT_SYMBOL_GPL(unregister_acpi_dev_type);
 
@@ -69,7 +72,7 @@ static struct acpi_device *acpi_companion_lookup(struct device *dev)
 	list_for_each_entry(type, &dev_type_list, list) {
 		struct acpi_device *adev;
 
-		if (!type->match(dev))
+		if (type->dev_type != dev->type)
 			continue;
 
 		adev = type->find_companion(dev);
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 585b26515d49..63e0b07e9926 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -64,11 +64,6 @@ static struct device_type drm_sysfs_device_connector = {
 struct class *drm_class;
 
 #ifdef CONFIG_ACPI
-static bool drm_connector_acpi_dev_type_match(struct device *dev)
-{
-	return dev->type == &drm_sysfs_device_connector;
-}
-
 static struct acpi_device *drm_connector_acpi_find_companion(struct device *dev)
 {
 	struct drm_connector *connector = to_drm_connector(dev);
@@ -77,8 +72,7 @@ static struct acpi_device *drm_connector_acpi_find_companion(struct device *dev)
 }
 
 static struct acpi_dev_type drm_connector_acpi_dev_type = {
-	.name = "drm_connector",
-	.match = drm_connector_acpi_dev_type_match,
+	.dev_type = &drm_sysfs_device_connector,
 	.find_companion = drm_connector_acpi_find_companion,
 };
 
diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index 209419e3844f..05cc823a26bb 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -280,13 +280,9 @@ int tb_acpi_power_off_retimers(struct tb_port *port)
 	return tb_acpi_retimer_set_power(port, false);
 }
 
-static bool tb_acpi_dev_type_match(struct device *dev)
-{
-	return tb_is_switch(dev) || tb_is_usb4_port_device(dev);
-}
-
-static struct acpi_device *tb_acpi_switch_find_companion(struct tb_switch *sw)
+static struct acpi_device *tb_acpi_switch_find_companion(struct device *dev)
 {
+	struct tb_switch *sw = tb_to_switch(dev);
 	struct tb_switch *parent_sw = tb_switch_parent(sw);
 	struct acpi_device *adev = NULL;
 
@@ -314,56 +310,55 @@ static struct acpi_device *tb_acpi_switch_find_companion(struct tb_switch *sw)
 	return adev;
 }
 
-static struct acpi_device *tb_acpi_find_companion(struct device *dev)
+static struct acpi_device *tb_acpi_usb4_port_find_companion(struct device *dev)
 {
-	/*
-	 * The Thunderbolt/USB4 hierarchy looks like following:
-	 *
-	 * Device (NHI)
-	 *   Device (HR)		// Host router _ADR == 0
-	 *      Device (DFP0)		// Downstream port _ADR == lane 0 adapter
-	 *        Device (DR)		// Device router _ADR == 0
-	 *          Device (UFP)	// Upstream port _ADR == lane 0 adapter
-	 *      Device (DFP1)		// Downstream port _ADR == lane 0 adapter number
-	 *
-	 * At the moment we bind the host router to the corresponding
-	 * Linux device.
-	 */
-	if (tb_is_switch(dev))
-		return tb_acpi_switch_find_companion(tb_to_switch(dev));
-	if (tb_is_usb4_port_device(dev))
-		return acpi_find_child_by_adr(ACPI_COMPANION(dev->parent),
-					      tb_to_usb4_port_device(dev)->port->port);
-	return NULL;
+	return acpi_find_child_by_adr(ACPI_COMPANION(dev->parent),
+				      tb_to_usb4_port_device(dev)->port->port);
 }
 
-static void tb_acpi_setup(struct device *dev)
+static void tb_acpi_usb4_port_setup(struct device *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct usb4_port *usb4 = tb_to_usb4_port_device(dev);
 
-	if (!adev || !usb4)
-		return;
-
 	if (acpi_check_dsm(adev->handle, &retimer_dsm_guid, 1,
 			   BIT(RETIMER_DSM_QUERY_ONLINE_STATE) |
 			   BIT(RETIMER_DSM_SET_ONLINE_STATE)))
 		usb4->can_offline = true;
 }
 
-static struct acpi_dev_type tb_acpi_dev_type = {
-	.name = "thunderbolt",
-	.match = tb_acpi_dev_type_match,
-	.find_companion = tb_acpi_find_companion,
-	.setup = tb_acpi_setup,
+/*
+ * The Thunderbolt/USB4 hierarchy looks like following:
+ *
+ * Device (NHI)
+ *   Device (HR)		// Host router _ADR == 0
+ *      Device (DFP0)		// Downstream port _ADR == lane 0 adapter
+ *        Device (DR)		// Device router _ADR == 0
+ *          Device (UFP)	// Upstream port _ADR == lane 0 adapter
+ *      Device (DFP1)		// Downstream port _ADR == lane 0 adapter number
+ *
+ * At the moment we bind the host router to the corresponding
+ * Linux device.
+ */
+static struct acpi_dev_type tb_switch_acpi_dev_type = {
+	.dev_type = &tb_switch_type,
+	.find_companion = tb_acpi_switch_find_companion,
+};
+
+static struct acpi_dev_type tb_usb4_port_acpi_dev_type = {
+	.dev_type = &usb4_port_device_type,
+	.find_companion = tb_acpi_usb4_port_find_companion,
+	.setup = tb_acpi_usb4_port_setup,
 };
 
 void tb_acpi_init(void)
 {
-	register_acpi_dev_type(&tb_acpi_dev_type);
+	register_acpi_dev_type(&tb_switch_acpi_dev_type);
+	register_acpi_dev_type(&tb_usb4_port_acpi_dev_type);
 }
 
 void tb_acpi_exit(void)
 {
-	unregister_acpi_dev_type(&tb_acpi_dev_type);
+	unregister_acpi_dev_type(&tb_usb4_port_acpi_dev_type);
+	unregister_acpi_dev_type(&tb_switch_acpi_dev_type);
 }
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 05881260a4b7..d12eda176034 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -278,9 +278,9 @@ usb_acpi_get_companion_for_port(struct usb_port *port_dev)
 	return acpi_find_child_by_adr(adev, port1);
 }
 
-static struct acpi_device *
-usb_acpi_find_companion_for_port(struct usb_port *port_dev)
+static struct acpi_device *usb_acpi_find_companion_for_port(struct device *dev)
 {
+	struct usb_port *port_dev = to_usb_port(dev);
 	struct acpi_device *adev;
 
 	adev = usb_acpi_get_companion_for_port(port_dev);
@@ -292,9 +292,9 @@ usb_acpi_find_companion_for_port(struct usb_port *port_dev)
 	return adev;
 }
 
-static struct acpi_device *
-usb_acpi_find_companion_for_device(struct usb_device *udev)
+static struct acpi_device *usb_acpi_find_companion_for_device(struct device *dev)
 {
+	struct usb_device *udev = to_usb_device(dev);
 	struct acpi_device *adev;
 	struct usb_port *port_dev;
 	struct usb_hub *hub;
@@ -326,7 +326,17 @@ usb_acpi_find_companion_for_device(struct usb_device *udev)
 	return usb_acpi_get_companion_for_port(port_dev);
 }
 
-static struct acpi_device *usb_acpi_find_companion(struct device *dev)
+static struct acpi_dev_type usb_dev_acpi_dev_type = {
+	.dev_type = &usb_device_type,
+	.find_companion = usb_acpi_find_companion_for_device,
+};
+
+static struct acpi_dev_type usb_port_acpi_dev_type = {
+	.dev_type = &usb_port_device_type,
+	.find_companion = usb_acpi_find_companion_for_port,
+};
+
+void usb_acpi_register(void)
 {
 	/*
 	 * The USB hierarchy like following:
@@ -356,31 +366,12 @@ static struct acpi_device *usb_acpi_find_companion(struct device *dev)
 	 * devices yet, for that we would need to assign companions to
 	 * devices corresponding to USB interfaces.
 	 */
-	if (is_usb_device(dev))
-		return usb_acpi_find_companion_for_device(to_usb_device(dev));
-	else if (is_usb_port(dev))
-		return usb_acpi_find_companion_for_port(to_usb_port(dev));
-
-	return NULL;
-}
-
-static bool usb_acpi_dev_type_match(struct device *dev)
-{
-	return is_usb_device(dev) || is_usb_port(dev);
-}
-
-static struct acpi_dev_type usb_acpi_dev_type = {
-	.name = "USB",
-	.match = usb_acpi_dev_type_match,
-	.find_companion = usb_acpi_find_companion,
-};
-
-void usb_acpi_register(void)
-{
-	register_acpi_dev_type(&usb_acpi_dev_type);
+	register_acpi_dev_type(&usb_dev_acpi_dev_type);
+	register_acpi_dev_type(&usb_port_acpi_dev_type);
 }
 
 void usb_acpi_unregister(void)
 {
-	unregister_acpi_dev_type(&usb_acpi_dev_type);
+	unregister_acpi_dev_type(&usb_port_acpi_dev_type);
+	unregister_acpi_dev_type(&usb_dev_acpi_dev_type);
 }
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index da2262d220e0..8edf82b46157 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -661,11 +661,11 @@ static inline bool acpi_device_enumerated(struct acpi_device *adev)
  */
 struct acpi_dev_type {
 	struct list_head list;
-	const char *name;
-	bool (*match)(struct device *dev);
+	const struct device_type *dev_type;
 	struct acpi_device * (*find_companion)(struct device *);
 	void (*setup)(struct device *);
 };
+
 void register_acpi_dev_type(struct acpi_dev_type *type);
 void unregister_acpi_dev_type(struct acpi_dev_type *type);
 int acpi_bind_one(struct device *dev, struct acpi_device *adev);
-- 
2.51.0




