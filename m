Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D85FA1FD9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0725D10EEC8;
	Wed, 22 Apr 2026 16:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bpF+fRPu";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B93610EEC3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:49:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 324E7C5EF04;
 Wed, 22 Apr 2026 16:50:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4F6715FA8F;
 Wed, 22 Apr 2026 16:49:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 978B210460C11; 
 Wed, 22 Apr 2026 18:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776876584; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=1EpmXZp8KljYGbnE11bftzFwTFvtZSySxWnwqArSdB4=;
 b=bpF+fRPuD91/6XnqeD6Eh/NZohEFnlAfS2szLqUeD1E7PYD62ykgA6I3FSVGRQB4tZXnGJ
 H+AMHPkqaXZ1UcPywkdHQA8XVjltoe4+G4n1Ha8y8Nn4VJTtEQKSWZl0t6Eh6yacMxwruX
 3SdXRWSygWBAcJ2oczpyhtXuuSlM9F1jcaPogovL2g3gtUvGEZpzEHI96O1gvwX2NBqVyA
 E32bZDTJctQ2wbIeQMesmlGEpvfmceXKZ5lV/sZtty2RS9rXyZFXmgjFhBHMFgOyviatOZ
 yjGZzSPZjnHsjsacnTHaUmGsduwVaJeg6QbwYWvDqH8oJsVyjOHV01w3OZJyew==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 22 Apr 2026 18:48:17 +0200
Subject: [PATCH v4 20/37] drm/vkms: Introduce configfs for plane color
 range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-vkms-all-config-v4-20-dbb52e9aadc3@bootlin.com>
References: <20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com>
In-Reply-To: <20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>, 
 llvm@lists.linux.dev
X-Mailer: b4 0.16-dev
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
index 836169910884..97681108af1c 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -138,6 +138,21 @@ Description:
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
index 4b3dfbe4e13a..8ba0b0353376 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -87,7 +87,7 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
-Planes have 6 configurable attributes:
+Planes have 8 configurable attributes:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
@@ -99,10 +99,16 @@ Planes have 6 configurable attributes:
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
index a5174fc8321c..855b1d5f5d31 100644
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
 
@@ -470,6 +477,85 @@ static ssize_t plane_default_rotation_store(struct config_item *item,
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
@@ -554,6 +640,8 @@ CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, name);
 CONFIGFS_ATTR(plane_, supported_rotations);
 CONFIGFS_ATTR(plane_, default_rotation);
+CONFIGFS_ATTR(plane_, supported_color_ranges);
+CONFIGFS_ATTR(plane_, default_color_range);
 CONFIGFS_ATTR(plane_, supported_color_encodings);
 CONFIGFS_ATTR(plane_, default_color_encoding);
 
@@ -562,6 +650,8 @@ static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_name,
 	&plane_attr_supported_rotations,
 	&plane_attr_default_rotation,
+	&plane_attr_supported_color_ranges,
+	&plane_attr_default_color_range,
 	&plane_attr_supported_color_encodings,
 	&plane_attr_default_color_encoding,
 	NULL,

-- 
2.54.0

