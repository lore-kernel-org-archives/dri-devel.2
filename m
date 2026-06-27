Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B4CC43327
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F5B10F74D;
	Sat, 27 Jun 2026 03:33:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GMn7YBPa";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FF610E429
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:32:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E6AAA4E40A01;
 Sat, 27 Jun 2026 03:32:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BAEA060233;
 Sat, 27 Jun 2026 03:32:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5CBBC106F116D; 
 Sat, 27 Jun 2026 05:32:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531124; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=u++HXNyFChQpUGESKUXwZFPSKeCBVxotGGVn26TBxU4=;
 b=GMn7YBPae2B7/vEB+n958+SmEA5T3CP2q1ushfjIDMXHCzM0gDuT3Lu6KrwI0gt/cCu16o
 viczLNMZfFuamiLwpRj1cfFdRvU04rlFYGqYQkWLQ391yzHGXpp4Jhq0rxznLLUDlmR3Fz
 a6xRN93iRBtQJ/DmRsVqXa29AuV9RzNxQHqPF9nbWRkgP18YMZKKVWpUBQzE136hFE7OCU
 6b9lZV1sXAWRN+RUmhuy83Rmv+rMzK8uicf5aqEZ15vNaP0yiKgUdqUN/WcxwY0Qc6hsb2
 7DjMU8GDwo9JdLK3j30Q4OyLP5m2bJuxfajNKGIkGKKLdW1glq8gkcoZ1hyDBQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:48 +0200
Subject: [PATCH v5 31/38] drm/vkms: Introduce configfs for connector
 supported colorspace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-vkms-all-config-v5-31-854aa0840926@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4119;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=4H1fytMYKlfKM5s/cdqJHSkWSFludjgedqgHfpUgeh4=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0Phg+/2iMU6vUr5Ix+pfmVu+W2FW69eWzhR9
 1894U71CXeJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D4RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLEqQ//YIALEHi6J13XnFUiMoSNDEI6yWanMd0
 BsYQk6TZ8uSdKA9xEUUtMbZyhujKNlRlV5yK3Y/oih4++hLZpW+yxNgaSg5Qe492kKmtrHIVv+Z
 zYTJAaEQoLTFURxpmCqjQp6y+ah58ZnnjEhQUBiGBOiunuS0cwgDGpa1BH0Hg6FZbOxgjzSvd6P
 vNujRbCIyOBOuswI3cx+ksnRbS4Gwm8ltAO8uj4Y+gIfoa5KShEGduDsE9cpfkyGbKezkqp/rAH
 8Db/1mmTZo49VBC/uXX/X5zpGgJJ0lu/nczR2eoTo7KPouOl0cWJZpB1U9itqaTt3g4sENaqvzH
 jlRIwGWbmNatFH99tXb6O03MkZNDNY11Bxv5rK6Duoxn1BLkUSQiXCcaflMGEYILW9qi0H+hnsI
 sOYIFPjuAnN/2hayUra6PGy/tLjKEjAL8gP68k8JR285WOzrvlIifLtbrxG9FrJfyiGsqTmlyAX
 TNCDjVgSH9WI1Z+Va02XzaLTJ1A2+OYXxLL1ayk4BeCgZfszgJaiMUMaz0Sw/b5Sgtg5UCnMQru
 BXRbQbvi6SZisXchTfvzIHH+JhSTptspP1QgE4Xbu6hVSya1QzGK79q9VdlXwBerGPGi7YgAv10
 BhX8ctfPxNohH50wy1bdzyxdDI14KQqal78aa2psM62ldXV6oh60=
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

Add the attribute supported_colorspaces to configure the supported
colorspace of a connector. It will allows emulating some HDR features of
displays. This feature is only supported for HDMI, DP and eDP connectors.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms |  8 +++++++
 Documentation/gpu/vkms.rst              |  7 +++++-
 drivers/gpu/drm/vkms/vkms_configfs.c    | 40 +++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index 0e588a1145ff..86f5f0beec8d 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -40,6 +40,14 @@ Description:
 	Type of the connector. Possible values match those
 	exposed by the "type" field in drm_connector.
 
+What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/supported_colorspaces
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Supported colorspaces for HDMI, DP, and eDP connectors.
+	Value is a bitfield, where 0x1 = NO_DATA, 0x2 = SMPTE_170M_YCC,
+	etc. See enum drm_colorspace for full list.
+
 What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/possible_encoders
 Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index f2622b3fd8af..11058b6e6250 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -137,11 +137,16 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
-Connectors have 2 configurable attribute:
+Connectors have 3 configurable attribute:
 
 - status: Connection status: 1 connected, 2 disconnected, 3 unknown (same values
   as those exposed by the "status" property of a connector)
 - type: Type of connector. Same values as exposed by the "type" field in drm_connector.
+- supported_colorspaces: Supported colorspaces values for HDMI, DP and eDP connectors.
+  If supported_colorspaces is not 0, the HDR_OUTPUT_METADATA will also be created.
+  Value is a bitfield, 0x1 = NO_DATA, 0x2 = SMPTE_170M_YCC... see enum drm_colorspace
+  for full list.
+
 
 To finish the configuration, link the different pipeline items::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 8b414f1950e8..e1f6e7817f97 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1180,12 +1180,52 @@ static ssize_t connector_type_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t connector_supported_colorspaces_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	int colorspaces;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+	colorspaces = vkms_config_connector_get_supported_colorspaces(connector->config);
+
+	return sprintf(page, "%u", colorspaces);
+}
+
+static ssize_t connector_supported_colorspaces_store(struct config_item *item,
+						     const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	int val, ret;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	if ((val & -BIT(DRM_MODE_COLORIMETRY_COUNT)) != 0)
+		return -EINVAL;
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		if (connector->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_connector_set_supported_colorspaces(connector->config, val);
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(connector_, status);
 CONFIGFS_ATTR(connector_, type);
+CONFIGFS_ATTR(connector_, supported_colorspaces);
 
 static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_status,
 	&connector_attr_type,
+	&connector_attr_supported_colorspaces,
 	NULL,
 };
 

-- 
2.54.0

