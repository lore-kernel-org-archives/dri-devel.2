Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CE5C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2790410F73F;
	Sat, 27 Jun 2026 03:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PlLyt4Ua";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 355C310E429
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:32:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0C11A1A0A32;
 Sat, 27 Jun 2026 03:32:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D33F460233;
 Sat, 27 Jun 2026 03:32:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 22FC0106F116F; 
 Sat, 27 Jun 2026 05:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531129; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nkH4VZETKvurYkdud9RJs/kvMCHV1czMfcDjQ4shGTs=;
 b=PlLyt4UaCuGMYxX4VurQd7WMTgrS9YcYORVjh+5FW3sTUUeb9cb9bYormUNm4GB3n1Wa9x
 8hBtMAzSw+nuXA96lCQzYjslkEhcwiWfZMXzEfV/YvYrfLgnWlquRJm/QQphGHpc2dyXc3
 V/5O2QLfmDoZN4v+Xf+KD11vsXRWKLd1kaqOGDqOeHLYXKUI7Gw7rmLwHll/Eq2bQuw1z/
 s9puuBnq17jNFftfOAJaLE2PlbftwxUu5UMZr2Xr+S4c0Rc5HlVToG6U67bVQAp9LP1Qf4
 95rQx/WN9qhxlBmSBcvk4OWCFEt1p/d0O58jus4looOYR3LGTyAjTM6duzeRBw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:50 +0200
Subject: [PATCH v5 33/38] drm/vkms: Introduce configfs for connector EDID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-vkms-all-config-v5-33-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
In-Reply-To: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, victoria@system76.com, 
 sebastian.wick@redhat.com, victoria@system76.com, airlied@gmail.com, 
 thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, llvm@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6405;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Ao6pZrb2nvH3LB0XUEbR940/GYWcqu6EeHzjUYxq1t0=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0PhFYKLJ3WtxrBwSnlAGdLXIjQsmuJ+Owegy
 TXGPa2YRACJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D4RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOJNiA//cBvFx97dPS2evltIlSPd6o7N2t/KEUl
 CMPkQ8mptRMC2F7mU3ay2vyHsgfJm8YwjjHcYE9a5lClPjEkj1DYrYLIrwnoLGrIPhL6MEqrmNc
 S9uosOzMhwTc9E0ZV1p7Au+nXGw+lMXJYwSOzzTt0VeqpCGZLQVSTxFfFePDpPP9EuC3/Elb2td
 /Ao5txboO7ZXqU0KlTyDnv5tOywa7ErmxNbPR9GmeZ1ZBJQty/8ErP2CvKuonvSl4Wy2a4C9t5z
 UGH3HUM2TW98D75SSeS1Mphc6Bx3dVI/3bTKaw5IRACMExMpYPOkW8xQ36VxmHIojV9281BDpa9
 5obf5bf9mz/o3gaQQfqmH7A+CJ7eHC5FD/eza0vSBCYpZm6UcTnN4RsAOdSiAnXJp0DZ+gbPeyS
 l3BTVjRywDNO+TZEH94e5OFW5/m7Wj9IgzO5OE80JkNrvwM2np/8Okf4mWGF39VY/UgD5ROlMag
 lAK3TnNWnnCNXLP2QaVG9Wks3LLtNDKz+mcUNKWzrVdi7KCr5areJBaGre0LR5vB2qoIORQmW1g
 SiMlciDUc6X68uVAllcA/aKrXJyfaen/lDZDWrZPB0xqt9oWhTvRUmBVcdSnm0GEnpp0Sb+CjJV
 y5Z1kfnjXRUze9Q2fsGz7HPF/Fm63fNC49TSoUTiJwIoVb+s0y3U=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

Introduce new attributes to configure EDID of a connector:
- edid_enable - chose if the connector will have an EDID or not
- edid - raw edid content

Due to limitation of ConfigFS, the max len of EDID is PAGE_SIZE (4kB on
x86), it should be sufficient for many tests. One possible evolution is
using a ConfigFS blob to allow bigger EDID.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms | 14 ++++++
 Documentation/gpu/vkms.rst              |  5 ++-
 drivers/gpu/drm/vkms/vkms_configfs.c    | 80 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c   |  3 ++
 4 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index 86f5f0beec8d..04e2f89e3129 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -48,6 +48,20 @@ Description:
 	Value is a bitfield, where 0x1 = NO_DATA, 0x2 = SMPTE_170M_YCC,
 	etc. See enum drm_colorspace for full list.
 
+What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/edid_enabled
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Enable or disable EDID for this connector. Value:
+	1 - enabled, 0 - disabled.
+
+What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/edid
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Content of the EDID for this connector. Ignored if
+	edid_enabled is not set.
+
 What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/possible_encoders
 Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 11058b6e6250..2a3e175bf67b 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -137,7 +137,7 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
-Connectors have 3 configurable attribute:
+Connectors have 5 configurable attribute:
 
 - status: Connection status: 1 connected, 2 disconnected, 3 unknown (same values
   as those exposed by the "status" property of a connector)
@@ -146,6 +146,9 @@ Connectors have 3 configurable attribute:
   If supported_colorspaces is not 0, the HDR_OUTPUT_METADATA will also be created.
   Value is a bitfield, 0x1 = NO_DATA, 0x2 = SMPTE_170M_YCC... see enum drm_colorspace
   for full list.
+- edid_enabled: Enable or not EDID for this connector. Some connectors may not have an
+  EDID but just a list of modes, this attribute allows to disable EDID property.
+- edid: Content of the EDID. Ignored if edid_enabled is not set
 
 
 To finish the configuration, link the different pipeline items::
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index e1f6e7817f97..f79a796c2017 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1218,14 +1218,94 @@ static ssize_t connector_supported_colorspaces_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t connector_edid_enabled_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	bool enabled;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+		enabled = vkms_config_connector_get_edid_enabled(connector->config);
+
+	return sprintf(page, "%d\n", enabled);
+}
+
+static ssize_t connector_edid_enabled_store(struct config_item *item,
+					    const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
+	bool enabled;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+	connector_cfg = connector->config;
+
+	if (kstrtobool(page, &enabled))
+		return -EINVAL;
+
+	scoped_guard(mutex, &connector->dev->lock)
+	{
+		vkms_config_connector_set_edid_enabled(connector_cfg, enabled);
+
+		if (connector->dev->enabled &&
+		    vkms_config_connector_get_status(connector_cfg) !=
+		    connector_status_disconnected)
+			vkms_trigger_connector_hotplug(connector->dev->config->dev);
+	}
+	return count;
+}
+
+static ssize_t connector_edid_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+	{
+		unsigned int len = 0;
+		const u8 *edid = vkms_config_connector_get_edid(connector->config, &len);
+
+		memcpy(page, edid, min(len, PAGE_SIZE));
+		return min(len, PAGE_SIZE);
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t connector_edid_store(struct config_item *item,
+				    const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+	{
+		vkms_config_connector_set_edid(connector->config, page, count);
+
+		if (connector->dev->enabled &&
+		    vkms_config_connector_get_status(connector->config) !=
+		    connector_status_disconnected)
+			vkms_trigger_connector_hotplug(connector->dev->config->dev);
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(connector_, status);
 CONFIGFS_ATTR(connector_, type);
 CONFIGFS_ATTR(connector_, supported_colorspaces);
+CONFIGFS_ATTR(connector_, edid_enabled);
+CONFIGFS_ATTR(connector_, edid);
 
 static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_status,
 	&connector_attr_type,
 	&connector_attr_supported_colorspaces,
+	&connector_attr_edid_enabled,
+	&connector_attr_edid,
 	NULL,
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index fe42ab2ba7b1..f726c7995524 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -175,6 +175,9 @@ struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
 
 	drm_connector_helper_add(&connector->base, &vkms_conn_helper_funcs);
 
+	if (vkms_config_connector_get_edid_enabled(connector_cfg))
+		drm_connector_attach_edid_property(&connector->base);
+
 	return connector;
 }
 

-- 
2.54.0

