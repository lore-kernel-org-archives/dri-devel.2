Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B760A261C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GlwAFrKP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06129112C7B;
	Fri, 20 Nov 2026 18:05:27 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42FD4112C79
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:05:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 066F94E41690;
 Fri, 20 Nov 2026 18:05:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CD6AD601B9;
 Fri, 20 Nov 2026 18:05:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B017F11BC0627; Fri, 20 Nov 2026 19:05:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197910; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=FCM/vqLrZfigpS0ex+X6PAS5HTF+pgT1YblPb+HTRCQ=;
 b=GlwAFrKP/DgAK4DzhlHQ+gQR58VomddKC4BIN2Ftdc1dRysiVd+oWGO+tdRPcNerq/D9PN
 5678iJffkBt8LwyrdBRUA2gAzzXy8PldOVxG+emVbjWCRrZyBrmciaHNtaJuad7jyuFCWT
 y4hhrIpRM1OIQTCiVrkrzg2p0tN3/C0uGgyCXn5ZLqBDQGqFlE4N3OccGjzjYmaTRwprQK
 0V82jB1MQe4nqnlOU5rp8z49VuFdbxKeUoW8+VRubkpy7daSbWCj8zzaQrVtiLrA2btE+3
 tyLVCCd/bpuFc9NF5oJ9fE6qz3ipiE22T8wzq3YT/Wx9yJyEtuPa/KkmKAgwOA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:59:12 +0100
Subject: [PATCH v6 30/43] drm/vkms: Introduce configfs for plane zpos property
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-30-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11096;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=UZJBr6qTWUA9ebdRhx5N/NeVkuHBBrI9WCank1ESZD8=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIsBF+MYjPsR9sCLmcp+po0UfsC6P8D/j9yfo
 ofBve0cRCqJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCLARsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOK1Ug//bY9v0dPhYoAd3B0LCLsDbbADWLt253L
 kJ2X86YAFi+PB917ramuSwH5/BIM9737oEaK5c3s3QyUgIYERpzSRBcuu+3XtRaOaCdtNJO5pTl
 ELVK6xFG7MKixaLayujNZ4OMPgf0/0Ka+q0XRr5g3F5u9fyDnJBpLX/m1m6aC47VKCP6kuiKy2M
 inZ0xrrEm2113LteoJISOF9r/pEShCxKJcYSwn0oU6GneQaSZC6Zo9IlWXCp4Omyq3PHNm/lRuR
 wXaiBsKQVPzuN/d0DFFu9SudAbcVQ33ShxX4BjQwoeAM7LM+Zly0uttmyhZwh9NcPjcOTUGHDkC
 vOVrbi/PEwdhjH+ZRwMSCH+6grtoeYwzlRgOiU1z3HZ1IsRwcGfB30/4TYP7Af6/av4aIrUX6d4
 QywI1lTLgJSIO13HEA64XUxYNQrXdxQyiKloz6a4AfWqQKjnyo4tOh33FQ7V0BLgOmIKjDtY+aX
 pUXBjAcULC91YYzVfVuHzIXJWpurZqfuG+hARlOb1OyXB1z2hfpkPILdmw4MJlzuIKSVNef4Ieo
 hbRpYsfm3TEbIdHXthwKLCwvJmoLpzRYKWjF2SG+TQndzwuD4Yzt2JHRpbOfTYiiAT0/TVxbPeR
 GPN3mXVF0TjNRaQLYvd5GMYE5l8cC6wib/KKeB8BSQgoGITb4Rjg=
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

Modern compositor rely on zpos management to offload some processing to
deticated hardware. In order to test multiple configurations, add zpos
configuration to configFS.

Introduce multiple attributes to configure zpos:
- zpos_enabled - Create or not the zpos property. If not created, the zpos
  is undefined.
- zpos_mutable - If the zpos property is created, allow or not the
  userspace to modify it
- zpos_initial - Initial value for zpos property. Must be between zpos_min
  and zpos_max
- zpos_min - Minimum zpos value for this plane. Must be <= zpos_max
- zpos_max - Maximum zpos value for this plane. Must be >= zpos_min

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms |  36 +++++++
 Documentation/gpu/vkms.rst              |   9 +-
 drivers/gpu/drm/vkms/vkms_configfs.c    | 180 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c       |  19 ++--
 4 files changed, 237 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index 312631d12985..2db0c950adc4 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -174,6 +174,42 @@ Description:
 	the driver, '-*' to remove all. Reading returns the
 	supported formats, one fourcc code per line.
 
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/zpos_enabled
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Enable or disable the zpos property. Value: 1 - enabled,
+	0 - disabled.
+
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/zpos_mutable
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Create the zpos property as mutable or immutable.
+	Value: 1 - mutable, 0 - immutable. No effect if
+	zpos_enabled is not set.
+
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/zpos_initial
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Set the initial zpos value. Must be between zpos_min
+	and zpos_max. No effect if zpos_enabled is not set.
+
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/zpos_min
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Set the minimal zpos value. No effect if zpos_enabled
+	is not set.
+
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/zpos_max
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Set the maximal zpos value. No effect if zpos_enabled
+	is not set.
+
 What:		/sys/kernel/config/vkms/<device>/planes/<plane>/possible_crtcs
 Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index e5280a99eee8..b58e96a3c273 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -87,7 +87,7 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
-Planes have 8 configurable attributes:
+Planes have 13 configurable attributes:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
@@ -113,6 +113,13 @@ Planes have 8 configurable attributes:
   To remove a format, use a minus and its fourcc: -XR24
   To add all formats use +*
   To remove all formats, use -*
+- zpos_enabled: Enable or not the zpos property: 1 enable, 0 disable
+- zpos_mutable: Create the zpos property as a mutable or imutable property: 1 mutable,
+  0 immutable. No effect if zpos_enabled is not set.
+- zpos_initial: Set the initial zpos value. Must be between zpos_min and zpos_max. No
+  effect if zpos_enabled is not set.
+- zpos_min: Set the minimum zpos value. No effect if zpos_enabled is not set.
+- zpos_max: Set the maximum zpos value. No effect if zpos_enabled is not set.
 
 Continue by creating one or more CRTCs::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index c3ace145bbf4..e027bf565d4d 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -659,6 +659,176 @@ static ssize_t plane_supported_formats_store(struct config_item *item,
 	return (ssize_t)ret_count;
 }
 
+static ssize_t plane_zpos_enabled_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	bool enabled;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->config->lock)
+		enabled = vkms_config_plane_get_zpos_enabled(plane->config);
+
+	return sprintf(page, "%d\n", enabled);
+}
+
+static ssize_t plane_zpos_enabled_store(struct config_item *item, const char *page,
+					size_t count)
+{
+	struct vkms_configfs_plane *plane;
+	bool enabled;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	if (kstrtobool(page, &enabled))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->config->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_zpos_enabled(plane->config, enabled);
+	}
+
+	return (ssize_t)count;
+}
+
+static ssize_t plane_zpos_mutable_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	bool mutable;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->config->lock)
+		mutable = vkms_config_plane_get_zpos_mutable(plane->config);
+
+	return sprintf(page, "%d\n", mutable);
+}
+
+static ssize_t plane_zpos_mutable_store(struct config_item *item, const char *page,
+					size_t count)
+{
+	struct vkms_configfs_plane *plane;
+	bool mutable;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	if (kstrtobool(page, &mutable))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->config->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_zpos_mutable(plane->config, mutable);
+	}
+
+	return (ssize_t)count;
+}
+
+static ssize_t plane_zpos_initial_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int initial;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->config->lock)
+		initial = vkms_config_plane_get_zpos_initial(plane->config);
+
+	return sprintf(page, "%u\n", initial);
+}
+
+static ssize_t plane_zpos_initial_store(struct config_item *item, const char *page,
+					size_t count)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int initial;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	if (kstrtouint(page, 10, &initial))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->config->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_zpos_initial(plane->config, initial);
+	}
+
+	return (ssize_t)count;
+}
+
+static ssize_t plane_zpos_min_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int min;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->config->lock)
+		min = vkms_config_plane_get_zpos_min(plane->config);
+
+	return sprintf(page, "%u\n", min);
+}
+
+static ssize_t plane_zpos_min_store(struct config_item *item, const char *page,
+				    size_t count)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int min;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	if (kstrtouint(page, 10, &min))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->config->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_zpos_min(plane->config, min);
+	}
+
+	return (ssize_t)count;
+}
+
+static ssize_t plane_zpos_max_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int max;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->config->lock)
+		max = vkms_config_plane_get_zpos_max(plane->config);
+
+	return sprintf(page, "%u\n", max);
+}
+
+static ssize_t plane_zpos_max_store(struct config_item *item, const char *page,
+				    size_t count)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int max;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	if (kstrtouint(page, 10, &max))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->config->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_zpos_max(plane->config, max);
+	}
+
+	return (ssize_t)count;
+}
+
 CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, supported_rotations);
 CONFIGFS_ATTR(plane_, default_rotation);
@@ -667,6 +837,11 @@ CONFIGFS_ATTR(plane_, default_color_range);
 CONFIGFS_ATTR(plane_, supported_color_encodings);
 CONFIGFS_ATTR(plane_, default_color_encoding);
 CONFIGFS_ATTR(plane_, supported_formats);
+CONFIGFS_ATTR(plane_, zpos_enabled);
+CONFIGFS_ATTR(plane_, zpos_mutable);
+CONFIGFS_ATTR(plane_, zpos_initial);
+CONFIGFS_ATTR(plane_, zpos_min);
+CONFIGFS_ATTR(plane_, zpos_max);
 
 static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_type,
@@ -677,6 +852,11 @@ static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_supported_color_encodings,
 	&plane_attr_default_color_encoding,
 	&plane_attr_supported_formats,
+	&plane_attr_zpos_enabled,
+	&plane_attr_zpos_mutable,
+	&plane_attr_zpos_initial,
+	&plane_attr_zpos_min,
+	&plane_attr_zpos_max,
 	NULL,
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index acff64be12b0..254c18f6bb61 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -225,6 +225,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_plane *plane;
+	int ret;
 
 	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
 					   &vkms_plane_funcs,
@@ -253,13 +254,19 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 		vkms_initialize_colorops(&plane->base);
 	if (vkms_config_plane_get_zpos_enabled(plane_cfg)) {
 		if (vkms_config_plane_get_zpos_mutable(plane_cfg)) {
-			drm_plane_create_zpos_property(&plane->base,
-						       vkms_config_plane_get_zpos_initial(plane_cfg),
-						       vkms_config_plane_get_zpos_min(plane_cfg),
-						       vkms_config_plane_get_zpos_max(plane_cfg));
+			ret = drm_plane_create_zpos_property(
+				&plane->base,
+				vkms_config_plane_get_zpos_initial(plane_cfg),
+				vkms_config_plane_get_zpos_min(plane_cfg),
+				vkms_config_plane_get_zpos_max(plane_cfg));
+			if (ret)
+				return ERR_PTR(ret);
 		} else {
-			drm_plane_create_zpos_immutable_property(&plane->base,
-								 vkms_config_plane_get_zpos_initial(plane_cfg));
+			ret = drm_plane_create_zpos_immutable_property(
+				&plane->base,
+				vkms_config_plane_get_zpos_initial(plane_cfg));
+			if (ret)
+				return ERR_PTR(ret);
 		}
 	}
 

-- 
2.56.0

