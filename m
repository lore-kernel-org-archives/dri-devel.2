Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF6F606A33B
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OsIvW0IT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F3B112343;
	Thu, 26 Nov 2026 11:31:34 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6883A11233B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:31:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 34DEB1A1807;
 Thu, 26 Nov 2026 11:31:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0257060237;
 Thu, 26 Nov 2026 11:31:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4C2EC11E6B302; Thu, 26 Nov 2026 12:31:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692676; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bXZ2p/XgbHcBOJKuIE4qtM2nPpzX2bLBPSbSu8Rvx2M=;
 b=OsIvW0ITF++k1YHE9HvE5Ze9eTtvJnNmfRb7ZOPl+2wgbgdyJkMOPF/KXC3Q2dAEGeKXJ2
 uoD83DG+lsBcQVJKvloHDU1ZtKyNNbDn7k8OYsQEY+5ZGAM6MeHlZlyB8n9TpJmDzeTxW9
 q5Y+ytLyfI9WDu//VLSg1vv1paaO3MnJLWtcf2gI15Zt/vBBicETNbjnHNuEaA3dP4biyN
 PspKl7euaonRRGhEnB95CPLxG7QgJn6/M1Td5tmO5Ee/TNvtAxsZkLEMnquS4RK7uADk2F
 wMOwDF7LLI7hxCiuPyWgwsmkmLQ5vhEzH8a4huQK19eYCOqQWWY1g78nENre8Q==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:03 +0100
Subject: [PATCH v7 20/43] drm/vkms: Introduce configfs for plane rotation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-vkms-all-config-v7-20-21194cda2468@bootlin.com>
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

To allows the userspace to test many hardware configurations, introduce a
new interface to configure the available rotation per planes. VKMS
supports any rotation and reflection, so the userspace can choose any
combination.

The supported rotations are configured by writing a rotation bitmask to
the file `supported_rotations` and the default rotation is chosen by
writing a rotation bitmask to `default_rotation`.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms | 19 ++++++++
 Documentation/gpu/vkms.rst              |  7 ++-
 drivers/gpu/drm/vkms/vkms_configfs.c    | 84 +++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index 55e4183046ec..07ebb797617d 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -108,6 +108,25 @@ Description:
 	Plane type. Possible values: 0 - overlay, 1 - primary,
 	2 - cursor.
 
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/supported_rotations
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Available rotations for the plane, as a bitmask:
+	0x01 - no rotation, 0x02 - rotate 90°, 0x04 - rotate 180°,
+	0x08 - rotate 270°, 0x10 - reflect x, 0x20 - reflect y.
+	The value may be written in decimal or hexadecimal (with
+	a 0x prefix) and is read back as a decimal number.
+
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/default_rotation
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Default rotation presented to userspace, using the same
+	bit values as supported_rotations. The value must contain
+	exactly one rotation bit; reflection bits may be set in
+	addition.
+
 What:		/sys/kernel/config/vkms/<device>/planes/<plane>/possible_crtcs
 Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 1e79e62a6bc4..610305483716 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -87,10 +87,15 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
-Planes have 1 configurable attribute:
+Planes have 3 configurable attributes:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
+- supported_rotations: Available rotation for a plane, as a bitmask: 0x01 no rotation,
+  0x02 rotate 90°, 0x04 rotate 180°, 0x08 rotate 270°, 0x10 reflect x, 0x20 reflect y
+  (same values as those exposed by the "rotation" property of a plane)
+- default_rotation: Default rotation presented to the userspace, same values as
+  supported_rotations.
 
 Continue by creating one or more CRTCs::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index bbfc0c8a922c..5c62797627c1 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -322,10 +322,94 @@ static ssize_t plane_type_store(struct config_item *item, const char *page,
 	return (ssize_t)count;
 }
 
+static ssize_t plane_supported_rotations_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	unsigned int plane_supported_rotations;
+
+	scoped_guard(mutex, &plane->dev->config->lock)
+		plane_supported_rotations = vkms_config_plane_get_supported_rotations(plane->config);
+
+	return sprintf(page, "%u\n", plane_supported_rotations);
+}
+
+static ssize_t plane_supported_rotations_store(struct config_item *item,
+					       const char *page, size_t count)
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
+	if (val & ~(DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK))
+		return -EINVAL;
+	/* Should at least provide one rotation */
+	if (!(val & DRM_MODE_ROTATE_MASK))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->config->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_supported_rotations(plane->config, val);
+	}
+
+	return count;
+}
+
+static ssize_t plane_default_rotation_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	unsigned int plane_default_rotation;
+
+	scoped_guard(mutex, &plane->dev->config->lock) {
+		plane_default_rotation = vkms_config_plane_get_default_rotation(plane->config);
+	}
+
+	return sprintf(page, "%u\n", plane_default_rotation);
+}
+
+static ssize_t plane_default_rotation_store(struct config_item *item,
+					    const char *page, size_t count)
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
+	if (val & ~(DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK))
+		return -EINVAL;
+
+	/* Should contain exactly one rotation */
+	if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->config->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_default_rotation(plane->config, val);
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(plane_, type);
+CONFIGFS_ATTR(plane_, supported_rotations);
+CONFIGFS_ATTR(plane_, default_rotation);
 
 static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_type,
+	&plane_attr_supported_rotations,
+	&plane_attr_default_rotation,
 	NULL,
 };
 

-- 
2.56.0

