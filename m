Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8F8C44500
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E9110E42F;
	Sat, 27 Jun 2026 03:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="U3DOTmap";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DFFE10E429
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:31:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4CAAE4E409F8;
 Sat, 27 Jun 2026 03:31:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1EB5760233;
 Sat, 27 Jun 2026 03:31:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AA4E7106F1175; 
 Sat, 27 Jun 2026 05:31:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531094; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=N6E5ww/MPyZisEPU9Lijrr/bZjYPcXQmEGjHBhPPG/k=;
 b=U3DOTmap7x5rAyWQ0bkMXMsvWxjuKGwhSSjgFbfiV2bW2xdS4qfdTcWGm4PYgSKHlTdLZ7
 BmVK2Ue8YOsW3j1GiI6sNtlPYId9II8iHvF2EzGq3nEYn5AAzADXfQpVZsAgv+hnfgG9OF
 AIjwDtqv9wVks4YDcO+0HrLnY4TDB9Eyhk2YRAhuP4GETQWYt3EOItUG76FPj40sT/97bI
 3VbIM9sibR2kJ13dDnclZk2BGuWsJawhrpf57dN7zOWykqoZSfe1qFnKicJ8pLw8TLvdAZ
 SPq07lQphEdFoi+nbpMMquxPuDKtfrt4qlEi+qAS9B+u9d8SSSnEdInlxI1e6g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:36 +0200
Subject: [PATCH v5 19/38] drm/vkms: Introduce configfs for plane color encoding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-vkms-all-config-v5-19-854aa0840926@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6618;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=QxtkbLtOuqD/8Tr9XrtQOv7lZ9IVnfRDzZjEd1wrhR8=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0PfxIU7vU/mxQGaEPtzGeOqN0taXxVWCGWdE
 hOte8ebSdaJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D3xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLXIQ/+NNl56DYvWjlElng/LAs1mIOF7jgZ5xw
 CTbm+oSkOmk+/BP0fHDt/bX8dE5jySdDQwtf9kkwMyXKfZmiwn1rgRtt8bR4fnCl3sOBEHWeOVB
 t5cgbbAKq3w2Tzn4m45FOOCo/Pq89SlHq3RVo2oGpgeRB3WWWojL/Mr+NOUXv9d/R8YDNojWSmd
 gvDHgzXvSbAW9ejJRW004BNWs0TQFQzHjhhz84UVmP3f1zrsNDNWPKvWRx/839s75fQFH5Xv1mP
 GxbsIWRZ9HpoOBiJjDPfHYTMLn9ec9wrWQnh+9vK/HylJN1F+VAi257MsYNudHrLh9XSIHyg2WE
 QiKcWjvAt4TzdSf3PrV8Birmu1sR/GPSaRoHC2EwEr3WXZEP4NGBMovEQrUL6tombS3Yo8xKHBz
 LhG6X18BMRogAMc6JNw8LTsYCloIQfHuswk7GapUflyChACUB0XPLOHwPoZdXQ9cok5Cyfg8p6l
 5U7p/3JJD69mQZV4jPkPRW+hwYfv35FQrcQw/Zm6CY0F3S6Q8fdM0zol70rOQALfcuPku1xw6yE
 69UB2Mc7n1+QEXbrVCp55NbpYhhV4hQV9bsd07iUQTZWaQoK079u+9z1XBeKMarbJJppgZH87Yd
 /RgCuBIuks8tAPnCND1pqbQHhaeM3sLyWlkXORe2rYJ76wqbNWZA=
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
new interface to configure the available color encoding per planes. VKMS
supports multiple color encoding, so the userspace can choose any
combination.

The supported color encoding are configured by writing a color encoding
bitmask to the file `supported_color_encoding` and the default color
encoding is chosen by writing a color encoding bitmask to
`default_color_encoding`.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms | 14 +++++
 Documentation/gpu/vkms.rst              |  8 ++-
 drivers/gpu/drm/vkms/vkms_configfs.c    | 92 +++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index 7820da8505ef..a9ee05fe0c66 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -118,6 +118,20 @@ Description:
 	Default rotation presented to userspace, same values as
 	possible_rotations.
 
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/supported_color_encodings
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Available color encodings for the plane, as a bitmask:
+	0x01 - YCBCR_BT601, 0x02 - YCBCR_BT709, 0x04 - YCBCR_BT2020.
+
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/default_color_encoding
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Default color encoding presented to userspace, same
+	values as supported_color_encoding.
+
 What:		/sys/kernel/config/vkms/<device>/planes/<plane>/possible_crtcs
 Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 610305483716..7206cd2b231a 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -87,7 +87,7 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
-Planes have 3 configurable attributes:
+Planes have 5 configurable attributes:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
@@ -96,6 +96,12 @@ Planes have 3 configurable attributes:
   (same values as those exposed by the "rotation" property of a plane)
 - default_rotation: Default rotation presented to the userspace, same values as
   supported_rotations.
+- supported_color_encodings: Available encodings for a plane, as a bitmask:
+  0x01 YCBCR_BT601, 0x02 YCBCR_BT709, 0x04 YCBCR_BT2020 (same values as those exposed
+  by the COLOR_ENCODING property of a plane). If set, supported_color_range
+  must be set too.
+- default_color_encoding: Default color encoding presented to the userspace, same
+  values as supported_color_encodings
 
 Continue by creating one or more CRTCs::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 47b3a4aeee8d..c1d1841b2c5a 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -9,6 +9,14 @@
 #include "vkms_configfs.h"
 #include "vkms_connector.h"
 
+/**
+ * VKMS_SUPPORTED_COLOR_ENCODINGS - Bitmask of all supported color encodings in VKMS
+ */
+#define VKMS_SUPPORTED_COLOR_ENCODINGS (	\
+	BIT(DRM_COLOR_YCBCR_BT601) |		\
+	BIT(DRM_COLOR_YCBCR_BT709) |		\
+	BIT(DRM_COLOR_YCBCR_BT2020))
+
 /* To avoid registering configfs more than once or unregistering on error */
 static bool is_configfs_registered;
 
@@ -402,14 +410,98 @@ static ssize_t plane_default_rotation_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_supported_color_encodings_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	unsigned int supported_color_encodings;
+
+	scoped_guard(mutex, &plane->dev->lock)
+		supported_color_encodings = vkms_config_plane_get_supported_color_encodings(plane->config);
+
+	return sprintf(page, "%u", supported_color_encodings);
+}
+
+static ssize_t plane_supported_color_encodings_store(struct config_item *item,
+						     const char *page, size_t count)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	int ret, val = 0;
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	/* Should be a supported value */
+	if (val & ~(VKMS_SUPPORTED_COLOR_ENCODINGS))
+		return -EINVAL;
+	/* Should at least provide one color encoding */
+	if ((val & (VKMS_SUPPORTED_COLOR_ENCODINGS)) == 0)
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_supported_color_encodings(plane->config, val);
+	}
+
+	return count;
+}
+
+static ssize_t plane_default_color_encoding_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane = plane = plane_item_to_vkms_configfs_plane(item);
+	unsigned int default_color_encoding;
+
+	scoped_guard(mutex, &plane->dev->lock)
+		default_color_encoding = BIT(vkms_config_plane_get_default_color_encoding(plane->config));
+
+	return sprintf(page, "%u", default_color_encoding);
+}
+
+static ssize_t plane_default_color_encoding_store(struct config_item *item,
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
+	if (val & ~VKMS_SUPPORTED_COLOR_ENCODINGS)
+		return -EINVAL;
+
+	/* Ensure val is a single bit set */
+	if (!is_power_of_2(val))
+		return -EINVAL;
+
+	/* Convert bit position to the proper enum value */
+	val = __ffs(val) + DRM_COLOR_YCBCR_BT601;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_default_color_encoding(plane->config, val);
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, supported_rotations);
 CONFIGFS_ATTR(plane_, default_rotation);
+CONFIGFS_ATTR(plane_, supported_color_encodings);
+CONFIGFS_ATTR(plane_, default_color_encoding);
 
 static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_type,
 	&plane_attr_supported_rotations,
 	&plane_attr_default_rotation,
+	&plane_attr_supported_color_encodings,
+	&plane_attr_default_color_encoding,
 	NULL,
 };
 

-- 
2.54.0

