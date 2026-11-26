Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1C606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sPyr0C+D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA95112345;
	Thu, 26 Nov 2026 11:32:06 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35366112345
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:31:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 24F8DC2B9C7;
 Thu, 26 Nov 2026 11:31:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D272A60237;
 Thu, 26 Nov 2026 11:31:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DD5F911E6B36E; Thu, 26 Nov 2026 12:31:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692703; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=AxcWBdk1cfakkoP4QuBD3YRvKOY4li/mqNCIyrm0llY=;
 b=sPyr0C+DnzJWfvTHtUuiOh/rvC5g0FJlqGUr/UTT4p16S9thd9Gigsc4lrqKBwv4DV1r67
 pA83zm5NjBJFKgMo+COh/kTic0s/s4RosmOcC3yDaakBQ0W4DIkpoceNaha5kW2Y3LTib7
 fRrwe4ulQYzQfuz/z77Ynr8fEuvPMYjCJP+XuoIin9coLzWuuNGRPCVzHlnAaHcyaHlN1E
 SOwuxIn2dFFr34NCyFPApDCQfATnahWTMzuTXESVu7qbgUM7NHJM8WEjxSX61xKP5fBQxQ
 TwfJQmfbgJiXOP2nD1724E72X4WBSJzvxe+qjMLuOCQkCfuuJ5bIbPlYvddRhQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:07 +0100
Subject: [PATCH v7 24/43] drm/vkms: Introduce configfs for plane color
 range
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-24-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
In-Reply-To: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Lucas De Marchi <demarchi@kernel.org>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com, 
 victoria@system76.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.17-dev
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To allows the userspace to test many hardware configuration, introduce a
new interface to configure the available color ranges per planes. VKMS
supports multiple color ranges, so the userspace can choose any
combination.

The supported color ranges are configured by writing a color range bitmask
to the file `supported_color_ranges` and the default color range is
chosen by writing a color range bitmask to `default_color_range`.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms | 19 +++++++
 Documentation/gpu/vkms.rst              | 10 +++-
 drivers/gpu/drm/vkms/vkms_configfs.c    | 91 +++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index 592df5602065..16a44cc60e4a 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -145,6 +145,25 @@ Description:
 	must be a single bit: 1 - YCBCR_BT601, 2 - YCBCR_BT709,
 	4 - YCBCR_BT2020.
 
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/supported_color_ranges
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Available color ranges for the plane, as a bitmask:
+	0x1 - DRM_COLOR_YCBCR_LIMITED_RANGE,
+	0x2 - DRM_COLOR_YCBCR_FULL_RANGE. The value may be
+	written in decimal or hexadecimal (with a 0x prefix) and
+	is read back as a decimal number.
+
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/default_color_range
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Default color range presented to userspace. Value is a
+	decimal number with exactly one bit set: 1 -
+	DRM_COLOR_YCBCR_LIMITED_RANGE, 2 -
+	DRM_COLOR_YCBCR_FULL_RANGE.
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
index c6efc6db64c4..a746fb5e22a3 100644
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
 
@@ -410,6 +417,86 @@ static ssize_t plane_default_rotation_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_supported_color_ranges_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	unsigned int supported_color_ranges;
+
+	scoped_guard(mutex, &plane->dev->config->lock)
+		supported_color_ranges = vkms_config_plane_get_supported_color_ranges(plane->config);
+
+	return sprintf(page, "%u\n", supported_color_ranges);
+}
+
+static ssize_t plane_supported_color_ranges_store(struct config_item *item,
+						  const char *page, size_t count)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	int ret;
+	unsigned int val = 0;
+
+	ret = kstrtouint(page, 0, &val);
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
+	scoped_guard(mutex, &plane->dev->config->lock) {
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
+	scoped_guard(mutex, &plane->dev->config->lock)
+		default_color_range = vkms_config_plane_get_default_color_range(plane->config);
+
+	return sprintf(page, "%lu\n", BIT(default_color_range));
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
+	scoped_guard(mutex, &plane->dev->config->lock) {
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
@@ -492,6 +579,8 @@ static ssize_t plane_default_color_encoding_store(struct config_item *item,
 CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, supported_rotations);
 CONFIGFS_ATTR(plane_, default_rotation);
+CONFIGFS_ATTR(plane_, supported_color_ranges);
+CONFIGFS_ATTR(plane_, default_color_range);
 CONFIGFS_ATTR(plane_, supported_color_encodings);
 CONFIGFS_ATTR(plane_, default_color_encoding);
 
@@ -499,6 +588,8 @@ static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_type,
 	&plane_attr_supported_rotations,
 	&plane_attr_default_rotation,
+	&plane_attr_supported_color_ranges,
+	&plane_attr_default_color_range,
 	&plane_attr_supported_color_encodings,
 	&plane_attr_default_color_encoding,
 	NULL,

-- 
2.56.0

