Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908A6C43638
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B7310E441;
	Sat, 27 Jun 2026 03:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WaUmPBnw";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B3610E435
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:31:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 2E93BC5CD7E;
 Sat, 27 Jun 2026 03:31:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1F8A760233;
 Sat, 27 Jun 2026 03:31:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9CA79106F1178; 
 Sat, 27 Jun 2026 05:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531099; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Z7/GhxWuPHfZ+W2ec4f1aPqowYz5dofm49yRd+HfCf0=;
 b=WaUmPBnwgTPft8YtPvU7pMlzDWrbaovCoXOq0S24r0w5d/+U2ZjdoojzdCDUJjC2uVKfPX
 XEEf76VIjbTwg++VpBEkKft7Fv7GSw5CTsV1qz5GBxoFZ4djOiCNHrFrrij3x7FAdyIj8x
 54CdEDOEWzGRDjC2gGZUnOcH+O94Ym5OVF9SSXho/dqs3iOsdNKAyVgBBrg20jLu9zPaC5
 LYEMqUXymQpcivbeU5k5qPcPuNEWcWk1xnxSLQZQcQoEO6hcAm48YsjjSc2fLtwiKkCnmE
 DqggQqC8t+q603X7YqKjZiNxN41IuZdq+HbQMWBRK+ClCkQVYTWWb7Ro3OJuPw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:38 +0200
Subject: [PATCH v5 21/38] drm/vkms: Introduce configfs for plane color
 range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-vkms-all-config-v5-21-854aa0840926@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7267;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=zagsHqlP7cu1CD1HZJ/8w6YqkI/47gVjz6qtccSZpsk=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0PfIFq9zFBdsiHlT1idpm6Kz/dsXYIm3at9I
 TfkxCTNWyaJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D3xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOIlog//cQMKjveaaw2Knn4NNLDSkPz5LsKmkd5
 lZTaRXRKkRxXww9nwYbBdGdxk2Cf49P7MOIoN2ZryP9ykAzuP6VMUzf4Gt8UkbVKr+xjLnFbQzi
 UFA+NxuXpTiCQIw/gVmRqgcXggyFUIHLdKJK5iiWAUek5kYHcrn4MtxCav9eBwqHpnxNCU8181h
 bStBtR4axc2CY8af2TR8reS4GaDMB+BRbvwMYVWqtnJtLc/7vAwTgRQ9gA8cT6RS0enkjvNknhQ
 B7dIcPms+ZCK43XW/T4Wd2EVFFbqkH9Xf8GOMsPFPDWorkK49Tpu8RwHly2Xwt+qMxiKSAs1Cr7
 fZNlawwWjwu0aRU1QVtdn3HmoxRBwXoRv5toks8PAEAuu+ODIe+zqbKCYmo6f/1pN+39JoUHGF5
 qjIYemQg+JqtCaSFlpWgduOUERz8IR3OdEp1YyBRqzxtJS5yrUopJCDCvVdDB4EnxfKUwrCdOzd
 xC27HHRUArHmIIUEUpeC1QG7ivbhbWYgtpj9VoHlNIHjZzhKQrigxvHIhsusE5kq2wo5rXqdam6
 LezAWlrC+m8rwf66k0ZdSXQzzNdDIlCladsW/LurnLc/5UpL0ehqnNhES0zzHL8t6HmhhfC4Bf8
 d/PlCxjGQL5xciSKxAO2FH9xyLeqkgJD7lYZuMRurQT1VBsM3T4g=
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

To allows the userspace to test many hardware configuration, introduce a
new interface to configure the available color ranges per planes. VKMS
supports multiple color ranges, so the userspace can choose any
combination.

The supported color ranges are configured by writing a color range bitmask
to the file `supported_color_ranges` and the default color range is
chosen by writing a color encoding bitmask to `default_color_range`.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms | 15 ++++++
 Documentation/gpu/vkms.rst              | 10 +++-
 drivers/gpu/drm/vkms/vkms_configfs.c    | 90 +++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index a9ee05fe0c66..ef0c3da6b3ca 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -132,6 +132,21 @@ Description:
 	Default color encoding presented to userspace, same
 	values as supported_color_encoding.
 
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/supported_color_ranges
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Available color ranges for the plane, as a bitmask:
+	0x1 - DRM_COLOR_YCBCR_LIMITED_RANGE,
+	0x2 - DRM_COLOR_YCBCR_FULL_RANGE.
+
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/default_color_range
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Default color range presented to userspace, same
+	values as supported_color_ranges.
+
 What:		/sys/kernel/config/vkms/<device>/planes/<plane>/possible_crtcs
 Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 7206cd2b231a..7e8f4fe3b392 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -87,7 +87,7 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
-Planes have 5 configurable attributes:
+Planes have 7 configurable attributes:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
@@ -98,10 +98,16 @@ Planes have 5 configurable attributes:
   supported_rotations.
 - supported_color_encodings: Available encodings for a plane, as a bitmask:
   0x01 YCBCR_BT601, 0x02 YCBCR_BT709, 0x04 YCBCR_BT2020 (same values as those exposed
-  by the COLOR_ENCODING property of a plane). If set, supported_color_range
+  by the COLOR_ENCODING property of a plane). If set, supported_color_ranges
   must be set too.
 - default_color_encoding: Default color encoding presented to the userspace, same
   values as supported_color_encodings
+- supported_color_ranges: Available color range for a plane, as a bitmask:
+  0x1 DRM_COLOR_YCBCR_LIMITED_RANGE, 0x2 DRM_COLOR_YCBCR_FULL_RANGE (same values as
+  those exposed by the COLOR_RANGE property of a plane). If set, supported_color_encoding
+  must be set too.
+- default_color_range: Default color range presented to the userspace, same
+  values as supported_color_ranges
 
 Continue by creating one or more CRTCs::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index c1d1841b2c5a..56a0c542a143 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -17,6 +17,13 @@
 	BIT(DRM_COLOR_YCBCR_BT709) |		\
 	BIT(DRM_COLOR_YCBCR_BT2020))
 
+/**
+ * VKMS_SUPPORTED_COLOR_RANGES - Bitmask of all supported color ranges in VKMS
+ */
+#define VKMS_SUPPORTED_COLOR_RANGES (		\
+	BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |	\
+	BIT(DRM_COLOR_YCBCR_FULL_RANGE))
+
 /* To avoid registering configfs more than once or unregistering on error */
 static bool is_configfs_registered;
 
@@ -410,6 +417,85 @@ static ssize_t plane_default_rotation_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_supported_color_ranges_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	unsigned int supported_color_ranges;
+
+	scoped_guard(mutex, &plane->dev->lock)
+		supported_color_ranges = vkms_config_plane_get_supported_color_ranges(plane->config);
+
+	return sprintf(page, "%u", supported_color_ranges);
+}
+
+static ssize_t plane_supported_color_ranges_store(struct config_item *item,
+						  const char *page, size_t count)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	int ret, val = 0;
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	/* Should be a supported value */
+	if (val & ~VKMS_SUPPORTED_COLOR_RANGES)
+		return -EINVAL;
+	/* Should at least provide one color range */
+	if ((val & VKMS_SUPPORTED_COLOR_RANGES) == 0)
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_supported_color_ranges(plane->config, val);
+	}
+
+	return count;
+}
+
+static ssize_t plane_default_color_range_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	unsigned int default_color_range;
+
+	scoped_guard(mutex, &plane->dev->lock)
+		default_color_range = vkms_config_plane_get_default_color_range(plane->config);
+
+	return sprintf(page, "%lu", BIT(default_color_range));
+}
+
+static ssize_t plane_default_color_range_store(struct config_item *item,
+					       const char *page, size_t count)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	int ret, val = 0;
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	/* Should be a supported value */
+	if (val & ~VKMS_SUPPORTED_COLOR_RANGES)
+		return -EINVAL;
+
+	if (!is_power_of_2(val))
+		return -EINVAL;
+
+	/* Convert bit position to the proper enum value */
+	val = ffs(val) + DRM_COLOR_YCBCR_LIMITED_RANGE - 1;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_default_color_range(plane->config, val);
+	}
+
+	return count;
+}
+
 static ssize_t plane_supported_color_encodings_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
@@ -493,6 +579,8 @@ static ssize_t plane_default_color_encoding_store(struct config_item *item,
 CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, supported_rotations);
 CONFIGFS_ATTR(plane_, default_rotation);
+CONFIGFS_ATTR(plane_, supported_color_ranges);
+CONFIGFS_ATTR(plane_, default_color_range);
 CONFIGFS_ATTR(plane_, supported_color_encodings);
 CONFIGFS_ATTR(plane_, default_color_encoding);
 
@@ -500,6 +588,8 @@ static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_type,
 	&plane_attr_supported_rotations,
 	&plane_attr_default_rotation,
+	&plane_attr_supported_color_ranges,
+	&plane_attr_default_color_range,
 	&plane_attr_supported_color_encodings,
 	&plane_attr_default_color_encoding,
 	NULL,

-- 
2.54.0

