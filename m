Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E714606A329
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cDwE67IG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0DD1123D7;
	Thu, 29 Oct 2026 15:29:44 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3D91123D3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:29:35 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c445c95d553so327576966b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793287773; x=1793892573; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5p+lvZSKx4OvMfgb3ZIACVMr3fIQoua1cT9i4xAtcVo=;
 b=cDwE67IGcEfNEqyG++cHe5UmacP6GPa4uzuNczFrEnpJYVx+wJpaBRAol1eVUlhS7k
 oF7SS0kQQFJtK/Socmut+yprAndL86SFvVEZs7CKGNgpjMCa6DH0BBWo9l08cbDDABgZ
 Cv0YEVcfgiXxONWK45FvKqob4Sjs5ykh4/1y8ZTRO5+NeYKlokD/sk4/8kseizZBURHt
 4a5DBnDTWO0/wEH+52/69/Bu2WpfPlEMgfxjaF/ChKI+Um5e+r9PXbSGPRK+PcEQP8c5
 Am1Uf0io8VSK9BT6FvcRKd143eX/OnGgcZV5FYzqRfIZU3/2XgQaVKE+xouiyXxautAa
 nkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287773; x=1793892573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5p+lvZSKx4OvMfgb3ZIACVMr3fIQoua1cT9i4xAtcVo=;
 b=s9uWHCOqmIVbvxWIyEL4hWLuuXacyeD3MCuy0pG9dXACybOnG7YkA1nd9DrDXusgzL
 6HO2U1ptPle2hbMbu4KTXKZf8Kp8eTkRP+8mDn7ZECWswzVod+V1Fd/OjOAi/AZE+rU0
 mmGYJU8O9sDfGPuv+TZ6XCVHtRfxGhGTFWtOvnOyloUg/j5OWmu6y/hVnfbU8VIDOm5P
 OAjJc0O039oqxCuETQRLj1qGkIMcYh0dqB1ZG3FfEk5ZIMPjm/9aS7dAykq9iCwXb4A2
 WDeH1jFEiU5mWilvWciIaYsK+RoiBMQP6iygwvFv2YPrxTS1HPYd8577w7c463DareCL
 /6bg==
X-Gm-Message-State: AFq9FYLdnrXT5gmGyO53Fpw3FVb3KDSr1SHH0YGH14zb/iUu1a6ZfV/H
 fvt0bAUDZ0a/QtAwlEpL+CLrVKKAAOOoRejZg5ILkzLGc0bxUUNF8CA0
X-Gm-Gg: AYBFou11BnnbmRR395+TXU1gZgaPWlRbAy3LRAV2EY/hD9gGXmbC4hkOOzl5LF6PP7H
 0zeZJ1IUDAcSo5W/zMkrZsV0XQ9nUeuJkD9MCyWmqA32B9PDGSLPD5drkhMab8t2PYEwBYqQ2NR
 5/gSiqbzokfuA+MJpOHwYeE+21NIixc7D5ADZtjEiDR+mPy1lm/CVLiRA0+xd8ibn6TN5qFBmAs
 R537zR+vjcB5T+RvIClhkm0qq8HjxC68utYoPoCTkaKcrwkeLjSWVqCUIQRL0rEPTpN0qwzKmgM
 yXDGX/z4c1f8j6eNFzQ/r7mPn6Jgpy8gEbgf6yj4xR6xdFLklpcSIRiD1Nbbad0wHL9PCN2saeH
 RU1OnY0VNZtF5XeBgWHNNAVypoaUUg+e4FkSttfBMhfeGiu2mKd/ujXBx60JYzy4cZX154WyFtq
 1iPYxG6Q158r0H0kmdfFXs1o1H+HWr/fThBsFWdIyTg4wcmFGml84aBDpFO4awjcFhbFXz1mZfI
 Y8OBhY0IDjVzwUMMGshvG+sLhqfBsaucNV8x4vnM9Z/1enqzAiJtqPflxstvadNT0HV0IRHp03a
 Lr9icJzzi6W7VtcnYILNxN5C8f0GpENRf/5F+7v6CSqBFQSEyw==
X-Received: by 2002:a17:907:1b15:b0:c37:c0dd:6642 with SMTP id
 a640c23a62f3a-c49bdf39b8emr489279566b.37.1793287773105; 
 Thu, 29 Oct 2026 08:29:33 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4ca27984f8sm1252166b.80.2026.10.29.08.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:29:32 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 01/11] drm: Add MIPI DBI bus support
Date: Thu, 29 Oct 2026 17:28:59 +0200
Message-ID: <20261029152909.234584-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029152909.234584-1-clamor95@gmail.com>
References: <20261029152909.234584-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mikko Perttunen <mperttunen@nvidia.com>

The MIPI DBI bus allows modeling DBI hosts and peripherals using the Linux
driver model. DBI hosts are registered by their respective drivers. During
registration, DBI peripherals are created from the device tree nodes
provided by the host.

DBI hosts expose operations that can be used by peripheral drivers to
access associated devices.

The original code was authored by Mikko Perttunen; I have aligned it with
the existing MIPI DSI implementation.

Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/Makefile           |   2 +-
 drivers/gpu/drm/drm_mipi_dbi_bus.c | 232 +++++++++++++++++++++++++++++
 include/drm/drm_mipi_dbi_bus.h     | 103 +++++++++++++
 3 files changed, 336 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/drm_mipi_dbi_bus.c
 create mode 100644 include/drm/drm_mipi_dbi_bus.h

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c6bc093a923a..880f0dc930b85 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -166,7 +166,7 @@ obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 
 obj-y			+= tests/
 
-obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
+obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o drm_mipi_dbi_bus.o
 obj-$(CONFIG_DRM_MIPI_DSI) += drm_mipi_dsi.o
 obj-y			+= arm/
 obj-y			+= clients/
diff --git a/drivers/gpu/drm/drm_mipi_dbi_bus.c b/drivers/gpu/drm/drm_mipi_dbi_bus.c
new file mode 100644
index 0000000000000..afad1f1508064
--- /dev/null
+++ b/drivers/gpu/drm/drm_mipi_dbi_bus.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MIPI DBI devices with command transport through parallel interface
+ *
+ * Copyright 2026 Mikko Perttunen <mperttunen@nvidia.com>
+ * Copyright 2026 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include <drm/drm_mipi_dbi.h>
+#include <drm/drm_mipi_dbi_bus.h>
+
+static int mipi_dbi_match(struct device *dev, const struct device_driver *driver)
+{
+	return of_driver_match_device(dev, driver);
+}
+
+static int mipi_dbi_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	return of_device_uevent_modalias(dev, env);
+}
+
+static const struct dev_pm_ops mipi_dbi_device_pm_ops = {
+	.runtime_suspend = pm_generic_runtime_suspend,
+	.runtime_resume = pm_generic_runtime_resume,
+	.suspend = pm_generic_suspend,
+	.resume = pm_generic_resume,
+	.freeze = pm_generic_freeze,
+	.thaw = pm_generic_thaw,
+	.poweroff = pm_generic_poweroff,
+	.restore = pm_generic_restore,
+};
+
+static const struct bus_type mipi_dbi_bus_type = {
+	.name = "mipi-dbi",
+	.match = mipi_dbi_match,
+	.uevent = mipi_dbi_uevent,
+	.pm = &mipi_dbi_device_pm_ops,
+};
+
+static void mipi_dbi_device_release(struct device *dev)
+{
+	of_node_put(dev->of_node);
+	kfree(to_mipi_dbi_device(dev));
+}
+
+static void mipi_dbi_device_unregister(void *data)
+{
+	struct device *dev = data;
+
+	of_node_clear_flag(dev->of_node, OF_POPULATED);
+	device_unregister(dev);
+}
+
+/**
+ * devm_mipi_dbi_device_register() - create a managed MIPI DBI device
+ * @dev: device to tie the MIPI-DBI device lifetime to
+ * @host: DBI host to which this device is connected
+ * @np: device tree node associated with the panel MIPI DBI device
+ *
+ * This function is called by DBI host driver to create panel device.
+ * It automatically calls mipi_dbi_device_unregister() when @dev is
+ * unbound. It does not automatically free passed device node pointer,
+ * it must be put manually.
+ *
+ * Returns:
+ * A pointer to the newly created MIPI DBI device, or, a pointer encoded
+ * with an error.
+ */
+struct mipi_dbi_device *
+devm_mipi_dbi_device_register(struct device *dev, struct mipi_dbi_host *host,
+			      struct device_node *np)
+{
+	struct mipi_dbi_device *dbidev;
+	int ret;
+
+	if (!host || !host->dev || !host->dbi || !host->dbi->command ||
+	    !host->ops || !host->ops->attach || !host->ops->detach || !np)
+		return ERR_PTR(-EINVAL);
+
+	if (!of_device_is_available(np))
+		return ERR_PTR(-ENODEV);
+
+	dbidev = kzalloc_obj(*dbidev);
+	if (!dbidev)
+		return ERR_PTR(-ENOMEM);
+
+	if (of_node_test_and_set_flag(np, OF_POPULATED)) {
+		kfree(dbidev);
+		return ERR_PTR(-EBUSY);
+	}
+
+	dbidev->host = host;
+	dbidev->dbi = host->dbi;
+	device_initialize(&dbidev->dev);
+	dbidev->dev.parent = host->dev;
+	dbidev->dev.bus = &mipi_dbi_bus_type;
+	dbidev->dev.release = mipi_dbi_device_release;
+	device_set_node(&dbidev->dev, of_fwnode_handle(of_node_get(np)));
+
+	ret = dev_set_name(&dbidev->dev, "%s:%s", dev_name(host->dev), np->full_name);
+	if (ret)
+		goto put_device;
+
+	ret = device_add(&dbidev->dev);
+	if (ret)
+		goto put_device;
+
+	ret = devm_add_action_or_reset(dev, mipi_dbi_device_unregister,
+				       &dbidev->dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return dbidev;
+
+put_device:
+	of_node_clear_flag(np, OF_POPULATED);
+	put_device(&dbidev->dev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(devm_mipi_dbi_device_register);
+
+static void mipi_dbi_detach(void *data)
+{
+	struct mipi_dbi_device *dbidev = data;
+
+	dbidev->host->ops->detach(dbidev->host, dbidev);
+	dbidev->attached = false;
+}
+
+/**
+ * devm_mipi_dbi_attach() - managed attach of DBI device to its DBI host
+ * @dev: device to tie the MIPI-DBI device lifetime to
+ * @dbidev: DBI peripheral
+ */
+int devm_mipi_dbi_attach(struct device *dev, struct mipi_dbi_device *dbidev)
+{
+	int ret;
+
+	if (dbidev->attached)
+		return -EBUSY;
+
+	ret = dbidev->host->ops->attach(dbidev->host, dbidev);
+	if (ret)
+		return ret;
+
+	dbidev->attached = true;
+	return devm_add_action_or_reset(dev, mipi_dbi_detach, dbidev);
+}
+EXPORT_SYMBOL_GPL(devm_mipi_dbi_attach);
+
+static int mipi_dbi_drv_probe(struct device *dev)
+{
+	struct mipi_dbi_driver *drv = to_mipi_dbi_driver(dev->driver);
+	struct mipi_dbi_device *dbidev = to_mipi_dbi_device(dev);
+
+	return drv->probe(dbidev);
+}
+
+static int mipi_dbi_drv_remove(struct device *dev)
+{
+	struct mipi_dbi_driver *drv = to_mipi_dbi_driver(dev->driver);
+	struct mipi_dbi_device *dbidev = to_mipi_dbi_device(dev);
+
+	drv->remove(dbidev);
+
+	return 0;
+}
+
+static void mipi_dbi_drv_shutdown(struct device *dev)
+{
+	struct mipi_dbi_driver *drv = to_mipi_dbi_driver(dev->driver);
+	struct mipi_dbi_device *dbidev = to_mipi_dbi_device(dev);
+
+	drv->shutdown(dbidev);
+}
+
+/**
+ * __mipi_dbi_driver_register() - register a driver for DBI devices
+ * @drv: DBI driver structure
+ * @owner: owner module
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int __mipi_dbi_driver_register(struct mipi_dbi_driver *drv, struct module *owner)
+{
+	drv->driver.bus = &mipi_dbi_bus_type;
+	drv->driver.owner = owner;
+
+	if (drv->probe)
+		drv->driver.probe = mipi_dbi_drv_probe;
+	if (drv->remove)
+		drv->driver.remove = mipi_dbi_drv_remove;
+	if (drv->shutdown)
+		drv->driver.shutdown = mipi_dbi_drv_shutdown;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(__mipi_dbi_driver_register);
+
+/**
+ * mipi_dbi_driver_unregister() - unregister a driver for DBI devices
+ * @drv: DBI driver structure
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+void mipi_dbi_driver_unregister(struct mipi_dbi_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(mipi_dbi_driver_unregister);
+
+static int __init mipi_dbi_bus_init(void)
+{
+	return bus_register(&mipi_dbi_bus_type);
+}
+subsys_initcall(mipi_dbi_bus_init);
+
+static void __exit mipi_dbi_bus_exit(void)
+{
+	bus_unregister(&mipi_dbi_bus_type);
+}
+module_exit(mipi_dbi_bus_exit);
+
+MODULE_DESCRIPTION("MIPI DBI devices with command transport through parallel interface");
+MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_mipi_dbi_bus.h b/include/drm/drm_mipi_dbi_bus.h
new file mode 100644
index 0000000000000..2b8b59bffd0b8
--- /dev/null
+++ b/include/drm/drm_mipi_dbi_bus.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * MIPI DBI devices with command transport through parallel interface
+ *
+ * Copyright 2026 Mikko Perttunen <mperttunen@nvidia.com>
+ * Copyright 2026 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef __DRM_MIPI_DBI_BUS_H__
+#define __DRM_MIPI_DBI_BUS_H__
+
+#include <linux/device.h>
+#include <linux/module.h>
+
+struct device_node;
+struct mipi_dbi;
+struct mipi_dbi_device;
+struct mipi_dbi_host;
+
+/**
+ * struct mipi_dbi_host_ops - DBI bus operations
+ * @attach: attach DBI device to DBI host
+ * @detach: detach DBI device from DBI host
+ */
+struct mipi_dbi_host_ops {
+	int (*attach)(struct mipi_dbi_host *host, struct mipi_dbi_device *dev);
+	void (*detach)(struct mipi_dbi_host *host, struct mipi_dbi_device *dev);
+};
+
+/**
+ * struct mipi_dbi_host - DBI host device
+ * @dev: driver model device node for this DBI host
+ * @dbi: MIPI DBI interface
+ * @ops: DBI host operations
+ */
+struct mipi_dbi_host {
+	struct device *dev;
+	struct mipi_dbi *dbi;
+	const struct mipi_dbi_host_ops *ops;
+};
+
+/**
+ * struct mipi_dbi_device - DBI peripheral device
+ * @dev: driver model device node for this peripheral
+ * @dbi: MIPI DBI interface
+ * @host: DBI host for this peripheral
+ * @attached: the DBI device has been successfully attached
+ */
+struct mipi_dbi_device {
+	struct device dev;
+	struct mipi_dbi *dbi;
+	struct mipi_dbi_host *host;
+	bool attached;
+};
+
+#define to_mipi_dbi_device(__dev)	container_of_const(__dev, struct mipi_dbi_device, dev)
+
+struct mipi_dbi_device *
+devm_mipi_dbi_device_register(struct device *dev, struct mipi_dbi_host *host,
+			      struct device_node *np);
+int devm_mipi_dbi_attach(struct device *dev, struct mipi_dbi_device *dbidev);
+
+/**
+ * struct mipi_dbi_driver - DBI driver
+ * @driver: device driver model driver
+ * @probe: callback for device binding
+ * @remove: callback for device unbinding
+ * @shutdown: called at shutdown time to quiesce the device
+ */
+struct mipi_dbi_driver {
+	struct device_driver driver;
+	int (*probe)(struct mipi_dbi_device *dbi);
+	void (*remove)(struct mipi_dbi_device *dbi);
+	void (*shutdown)(struct mipi_dbi_device *dbi);
+};
+
+static inline struct mipi_dbi_driver *
+to_mipi_dbi_driver(struct device_driver *driver)
+{
+	return container_of(driver, struct mipi_dbi_driver, driver);
+}
+
+static inline void *mipi_dbi_get_drvdata(const struct mipi_dbi_device *dbi)
+{
+	return dev_get_drvdata(&dbi->dev);
+}
+
+static inline void mipi_dbi_set_drvdata(struct mipi_dbi_device *dbi, void *data)
+{
+	dev_set_drvdata(&dbi->dev, data);
+}
+
+int __mipi_dbi_driver_register(struct mipi_dbi_driver *drv, struct module *owner);
+void mipi_dbi_driver_unregister(struct mipi_dbi_driver *drv);
+
+#define mipi_dbi_driver_register(driver) \
+	__mipi_dbi_driver_register(driver, THIS_MODULE)
+
+#define module_mipi_dbi_driver(__mipi_dbi_driver) \
+	module_driver(__mipi_dbi_driver, mipi_dbi_driver_register, \
+			mipi_dbi_driver_unregister)
+
+#endif /* __DRM_MIPI_DBI_BUS__ */
-- 
2.53.0

