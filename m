Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283E606B12C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YiFrbOeW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4977A112C72;
	Fri, 20 Nov 2026 18:04:51 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE8A4112C70
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:04:41 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id AF7554E41693;
 Fri, 20 Nov 2026 18:04:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7E43E601B9;
 Fri, 20 Nov 2026 18:04:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C9AAC11BC08D7; Fri, 20 Nov 2026 19:04:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197878; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=SjAc1oSEAzWsja9XBp/kbX/A5uvnvqjw8HhN/YBqrgM=;
 b=YiFrbOeWcJODXDTmmZuh15LXGE7+WG86SLA9MP4bIBn8P7baFKBVonC08OMLK3ZYj5OSs6
 PVd1inC+lvnNpiU4Etg887n5ZQmKBJT26j4eMxskWa6DRk/GyClYj5CI0rPPuQsvcHSd3Q
 sjb6YxgygIKODpUz05B7WyOPZMvs2SGynp9sbIiXPfEMl8tHvkWtoXss2qfgbtnUzujN5a
 B0lAE7Rkg4sEVMrKWrRW9R9bLweHYsU76soZZkUU/oGZr8orxOnCu3Rs6LOR7KOKl1rKpL
 utEn586pr+ujoTf25QzQKPRKAV2VTaT4uKB3zvwnl75zGHRiUHA69tkjVvTpZg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:59:05 +0100
Subject: [PATCH v6 23/43] drm/vkms: Introduce configfs for plane color encoding
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-23-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
In-Reply-To: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
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
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
 llvm@lists.linux.dev
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6761;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=aoPhDMj03w36BulehUNOqf7Cg4NJmw9rjfZvLfzCWiE=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIsAswj2wFN4WwsCUwZiENMxVzT7l+bEvYFER
 fhEf6RXnbGJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCLABsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOI5nhAAvvz/Um9xkiIXG+1scB13DUVm8g7heNS
 vnbU8ZhC1lAPbjeh+7GWn3AhiBQ4UVwCnDi9TBybyKzb4b3B1+w5mggmryUdolUhMgI9FCkYK37
 /CGuKV7RT5HvsgXmLbgCOHI5sSrb+QAGSyeXRfUPvAhQ3jqsJtYlRlKRiX7atx1lJuL7LxYl7dg
 GQ6KoaNfsBrkttpEVE1j1aW8mtMnJKiERZwZcdIa4AdLS+J2m31ZsH5ayfEhDZGP4ke6as76kFd
 Tzvo/7yY9ZeABtUvg89dpDDHtbo2X19UKuhIZXhYsjjTfAAx0KjvhqI0YH1ESqq+WzgaORrTEaD
 imbjOoYm0Lquahl6vj3JYUd32Y6f1I/DT8ACv3hiU1WXOG+VMSB5WPdCYYfLGgcRs6Gp6luoQHz
 ZHwtoD4R91fBovtWi9aC0O40bIvq+EeXUCqJ+XUJ2bS1y5unOe9NiTj4JdWuDIx3SUDHwLko1eW
 PvUr/zJa7iYnVjw6QCJHpwkpwAEDRe9HGHLCBkM++tHNwcYpCujVGJns+C/ZC9w9sfwEnzY21Bb
 tiellFdBSImmt+6nmV/+mBDwI5uysyFoSDCcnvC6MBn3sp57FnlErEQEBeF59Hz8g6tlNmUkkQw
 X14FjpG9Zpv1THeAI+AsexJHuAUmry6gmWOmp5cW68KScl32Vgu8=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
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
new interface to configure the available color encoding per planes. VKMS
supports multiple color encoding, so the userspace can choose any
combination.

The supported color encoding are configured by writing a color encoding
bitmask to the file `supported_color_encoding` and the default color
encoding is chosen by writing a color encoding bitmask to
`default_color_encoding`.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms | 18 +++++++
 Documentation/gpu/vkms.rst              |  8 ++-
 drivers/gpu/drm/vkms/vkms_configfs.c    | 91 +++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index 07ebb797617d..592df5602065 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -127,6 +127,24 @@ Description:
 	exactly one rotation bit; reflection bits may be set in
 	addition.
 
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/supported_color_encodings
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Available color encodings for the plane, as a bitmask:
+	0x01 - YCBCR_BT601, 0x02 - YCBCR_BT709, 0x04 - YCBCR_BT2020.
+	The value may be written in decimal or hexadecimal (with
+	a 0x prefix) and is read back as a decimal number.
+
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/default_color_encoding
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Default color encoding presented to userspace, using the
+	same bit values as supported_color_encodings. The value
+	must be a single bit: 1 - YCBCR_BT601, 2 - YCBCR_BT709,
+	4 - YCBCR_BT2020.
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
index 61e668f90112..809daec90ecf 100644
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
 
@@ -402,14 +410,97 @@ static ssize_t plane_default_rotation_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_supported_color_encodings_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	unsigned int supported_color_encodings;
+
+	scoped_guard(mutex, &plane->dev->config->lock)
+		supported_color_encodings = vkms_config_plane_get_supported_color_encodings(plane->config);
+
+	return sprintf(page, "%u\n", supported_color_encodings);
+}
+
+static ssize_t plane_supported_color_encodings_store(struct config_item *item,
+						     const char *page, size_t count)
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
+	if (val & ~(VKMS_SUPPORTED_COLOR_ENCODINGS))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->config->lock) {
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
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	unsigned int default_color_encoding;
+
+	scoped_guard(mutex, &plane->dev->config->lock)
+		default_color_encoding = BIT(vkms_config_plane_get_default_color_encoding(plane->config));
+
+	return sprintf(page, "%u\n", default_color_encoding);
+}
+
+static ssize_t plane_default_color_encoding_store(struct config_item *item,
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
+	scoped_guard(mutex, &plane->dev->config->lock) {
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
2.56.0

