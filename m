Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8154C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3DAB10EBF3;
	Wed, 29 Jul 2026 12:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Ui+MbYjX";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B158410EBC9;
 Wed, 29 Jul 2026 12:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785327248; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GO+WqyV3TiqcYTXTLetnxhoQidGH1LelDtAWUkt+MJApgWpTVM9KLX0D04HRndvpc4BpbOExP4sJru34iuBRKprOokknvTGIxhmivJY/MsUj5ctY6HHMUCZwp4ETlzsO9ZW+ObIxjR0M8w53E4z2LTQ18frbOioeHvuJjBF4geI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785327248;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CRSeFdH687bspgZ7GKAMShWtWyXOmyuPnNcSg9yazig=; 
 b=VPQdY0sj4Wup5qqaoBe/nc79fU7SCFhTGJkvX9PLlM/dxk07kyX90H98uLIH+TxxZyS2kjxTCgiQks9FiHDsBTE68f7ovHlYIPlRZwevDQTCR/9cxZOiQi/tzZH+grbSOWV29mAW0iDDODm5xfTow6ClUDLbJHW9s48TiYqZ7l8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785327248; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=CRSeFdH687bspgZ7GKAMShWtWyXOmyuPnNcSg9yazig=;
 b=Ui+MbYjX4iZbjxkIXflW75g1CHzY0gxaNqaHneT7y/jb8dWdkx1NLLVsj9W18AhB
 Jt9ijFLi/JEW9K0cFAL1xDHcx0VE4W4EnhPI2N66qGcEN0ES70WRfcQ/X1ueBKrqywY
 +3IP0q/LnKOnq5lC/QZUBZD1MDoXKHZtzxZuX+HA=
Received: by mx.zohomail.com with SMTPS id 178532724602772.55987226640411;
 Wed, 29 Jul 2026 05:14:06 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 29 Jul 2026 14:13:27 +0200
Subject: [PATCH v2 1/2] drm/connector: Introduce "min bpc" connector property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-min-bpc-v2-1-7d0036ef437c@collabora.com>
References: <20260729-min-bpc-v2-0-7d0036ef437c@collabora.com>
In-Reply-To: <20260729-min-bpc-v2-0-7d0036ef437c@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Xaver Hugl <xaver.hugl@kde.org>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Mario Kleiner <mario.kleiner.de@gmail.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Marius Vlad <marius.vlad@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

Add a new KMS connector property called "min bpc". Its purpose is to
allow userspace to mandate that the output bit depth ends up greater
than or equal to a specified depth, or else have the commit fail. This
is useful for checking for output depth degradation in combination with
atomic test commits.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_atomic_helper.c |  4 ++
 drivers/gpu/drm/drm_atomic_uapi.c   |  4 ++
 drivers/gpu/drm/drm_connector.c     | 77 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h         | 13 +++++++
 4 files changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 285aac3554df..613a674ace87 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -739,6 +739,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 			    new_connector_state->max_requested_bpc)
 				new_crtc_state->connectors_changed = true;
 
+			if (old_connector_state->min_requested_bpc !=
+			    new_connector_state->min_requested_bpc)
+				new_crtc_state->connectors_changed = true;
+
 			if (old_connector_state->color_format !=
 			    new_connector_state->color_format)
 				new_crtc_state->connectors_changed = true;
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1050dddadb17..0440cb63f786 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -956,6 +956,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 						   fence_ptr);
 	} else if (property == connector->max_bpc_property) {
 		state->max_requested_bpc = val;
+	} else if (property == connector->min_bpc_property) {
+		state->min_requested_bpc = val;
 	} else if (property == connector->privacy_screen_sw_state_property) {
 		state->privacy_screen_sw_state = val;
 	} else if (property == connector->broadcast_rgb_property) {
@@ -1043,6 +1045,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = 0;
 	} else if (property == connector->max_bpc_property) {
 		*val = state->max_requested_bpc;
+	} else if (property == connector->min_bpc_property) {
+		*val = state->min_requested_bpc;
 	} else if (property == connector->privacy_screen_sw_state_property) {
 		*val = state->privacy_screen_sw_state;
 	} else if (property == connector->broadcast_rgb_property) {
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 8b4baed060f3..3ecc079404a1 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1739,6 +1739,46 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
  *	drm_connector_attach_max_bpc_property() to create and attach the
  *	property to the connector during initialization.
  *
+ * min bpc:
+ *	This range property is used by userspace to set a minimum bit depth that
+ *	the driver must reach on the connector for a given atomic state. If it
+ *	cannot do so, the atomic commit fails.
+ *
+ *	The precise definition of minimum bit depth used for the "min bpc"
+ *	property must align with the definition a given driver uses for the
+ *	"max bpc" property, such that when "min bpc" and "max bpc" are set to
+ *	the same value, the allowable range of bit depths is a single set point.
+ *
+ *	Drivers should ideally use a definition of bit depth that refers to a
+ *	perceptual optical bit depth, meaning it is equivalent to an
+ *	uncompressed optical bit depth for a variety of content to the median
+ *	human eyeball in a variety of viewing environments. The display link's
+ *	actual optical bit depth to represent the data on the wire may be lower
+ *	due to compression techniques, or even higher due to padding. In
+ *	concrete terms, userspace should not need to know how to implement DSC
+ *	compression in order to set a minimum bit depth to the appropriate
+ *	value, and should not need to perform display-protocol-specific
+ *	calculations to set the right on-the-wire format.
+ *
+ *	Userspace may use the "min bpc" property in combination with performing
+ *	atomic test commits in order to enumerate the possible output bit depths
+ *	for a given configuration. This way, userspace compositors can make
+ *	use-case and content-specific tradeoffs to reach a desired output bit
+ *	depth, such as by using chroma subsampling, or by choosing a lower
+ *	refresh rate mode.
+ *
+ *	Userspace may use the "min bpc" property in combination with the
+ *	"max bpc" property to know what output bit depth a successful atomic
+ *	commit is using. By setting "min bpc" and "max bpc" to the same value,
+ *	a successful commit will be using an output bit depth of said value.
+ *
+ *	When "min bpc" is set to a non-zero value, any bit depth degradation
+ *	logic below "min bpc" must be implemented by userspace (through lowering
+ *	"min bpc"), rather than by kernel drivers. For a driver to degrade to an
+ *	uncompressed optical output bit depth below "min bpc" is always a bug no
+ *	matter how good the intentions are, since it renders the property
+ *	useless as an oracle.
+ *
  * Connectors also have one standardized atomic property:
  *
  * CRTC_ID:
@@ -2893,6 +2933,43 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
 
+/**
+ * drm_connector_attach_min_bpc_property - attach "min bpc" property
+ * @connector: connector to attach min bpc property on.
+ * @max: The maximum bit depth supported by the connector.
+ *
+ * Create and attach the "min bpc" connector property, which is used by
+ * userspace to require that a certain minimum bit depth is reached by the
+ * connector on atomic commit.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_min_bpc_property(struct drm_connector *connector,
+					  unsigned int max)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+
+	if (max > U8_MAX)
+		return -ERANGE;
+
+	prop = connector->min_bpc_property;
+	if (!prop) {
+		prop = drm_property_create_range(dev, 0, "min bpc", 0, max);
+		if (!prop)
+			return -ENOMEM;
+
+		connector->min_bpc_property = prop;
+	}
+
+	drm_object_attach_property(&connector->base, prop, 0);
+	connector->state->min_requested_bpc = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_min_bpc_property);
+
 /**
  * drm_connector_attach_hdr_output_metadata_property - attach "HDR_OUTPUT_METADATA" property
  * @connector: connector to attach the property on.
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index a0cf0268de48..35f395d46f6b 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1267,6 +1267,11 @@ struct drm_connector_state {
 	 */
 	u8 max_requested_bpc;
 
+	/**
+	 * @min_requested_bpc: Minimum output bit depth requested by userspace
+	 */
+	u8 min_requested_bpc;
+
 	/**
 	 * @max_bpc: Connector max_bpc based on the requested max_bpc property
 	 * and the connector bpc limitations obtained from edid.
@@ -2297,6 +2302,12 @@ struct drm_connector {
 	 */
 	struct drm_property *max_bpc_property;
 
+	/**
+	 * @min_bpc_property: Default connector property for the minimum bit
+	 * depth for the output to reach, or the commit to fail otherwise.
+	 */
+	struct drm_property *min_bpc_property;
+
 	/** @privacy_screen: drm_privacy_screen for this connector, or NULL. */
 	struct drm_privacy_screen *privacy_screen;
 
@@ -2706,6 +2717,8 @@ int drm_connector_set_orientation_from_panel(
 	struct drm_panel *panel);
 int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 					  int min, int max);
+int drm_connector_attach_min_bpc_property(struct drm_connector *connector,
+					  unsigned int max);
 void drm_connector_create_privacy_screen_properties(struct drm_connector *conn);
 void drm_connector_attach_privacy_screen_properties(struct drm_connector *conn);
 void drm_connector_attach_privacy_screen_provider(

-- 
2.55.0

