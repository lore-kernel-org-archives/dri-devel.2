Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9DBCC6B01
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0234310F1D3;
	Mon, 12 Oct 2026 15:12:03 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDCEF10F1CE;
 Mon, 12 Oct 2026 15:11:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 87C564E411F7;
 Mon, 12 Oct 2026 15:11:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 573D0601A6;
 Mon, 12 Oct 2026 15:11:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 91EA711D70C58; 
 Mon, 12 Oct 2026 17:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791817908; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZIV73b7Q2+CYNt0jdwC6/FZgWEToXjGAMk/b8ZhcwZw=;
 b=DluiwoAp0TUr643sxOOPLZkVPfc9fojJ/BxODfB0f6kUQ0IpGVsY2sk3EDP4Pbs/PfsCKt
 jj8Zoa523Z3VsAXnbtzLHL6GAS0I1A5aXHqreHwdEY8n7qZ8M11t7yOVCAXKEufrRBARud
 lo7vBZfLMg2PSdgcbp4xsTxyCZnfxJqy5PMNlHsnxLHy9irQbXCvEbQDpxGjkxHLby8Z5X
 aU9YaSZU6acLlSgIZYuFBfj3ZsNBSMrxmjZrGXy+y/7HxGMrqYB4eVOMqoUlh8qXTl7JsE
 dVLWCimelUwPOFBpoomJdPTaFz6WfsXaHGrcSZC5BjhGgOdMxx32Qe5C4D89GA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 12 Oct 2026 17:10:58 +0200
Subject: [PATCH RFC v3 3/8] drm: Introduce DisplayPort link training
 capabilities and state helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-feat_link_cap-v3-3-7517f4aba0f3@bootlin.com>
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
In-Reply-To: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Daniel Stone <daniels@collabora.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 Manasi Navare <navaremanasi@google.com>, 
 Drew Davenport <ddavenport@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.16.1-dev-17221
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

Add helpers to expose link training capabilities and state to userspace
via sysfs attributes.

Link rates are passed by the driver in deca-kbps, following the DRM
convention, but exposed to sysfs userspace in kbps for clarity.

The aim of such development is to guide users to select the most suitable
DisplayPort connector for their needs. For example, if you have a USB-C
hub with lesser capabilities than your computer’s native DisplayPort
connector (such as HBR2 versus HBR3 support), the system could recommend
connecting high-resolution displays directly to the computer’s port
instead of through the hub to ensure optimal performance.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
If the needs arise we can add sysfs files for sink and source common
capabilities and hardware achievable capabilities. Let's begin with this
for now.

Changes in v3:
- Use drm_connector_dp struct for source caps, sync caps and current link
  information.
- Remove drmm_connector_dp_init and use an helper instead to report
  source capabilities.
- Report all sink link rates capabilities instead of only the max link
  rates.
- Expose sysfs attributes only if nlanes is set.
- Add a new mutex to protect sysfs read write access instead of using
  the global connection_mutex.
- Add documentation

Changes in v2:
- Remove voltage swing and pre-emphasis properties
- Expose link training state via sysfs dp_link/ group instead of
  connector properties
- Rename variables from link_train to link as they relate directly to
  the link capabilities
- Add comprehensive sysfs attributes for both source and sink capabilities
- Add separate helpers for managing sink capabilities and for current and
  maximum link parameters
---
 Documentation/ABI/testing/sysfs-class-drm-dp |  85 ++++++++
 drivers/gpu/drm/display/drm_dp_helper.c      | 304 +++++++++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c              |  11 +
 drivers/gpu/drm/drm_sysfs.c                  | 155 ++++++++++++++
 include/drm/display/drm_dp_helper.h          |  12 ++
 include/drm/drm_connector.h                  |  53 +++++
 include/drm/drm_sysfs.h                      |   1 +
 7 files changed, 621 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-drm-dp b/Documentation/ABI/testing/sysfs-class-drm-dp
new file mode 100644
index 0000000000000..21c95a1b8dce0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-drm-dp
@@ -0,0 +1,85 @@
+What:		/sys/class/drm/card<X>-<connector>/dp_link/
+Date:		October 2026
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		Directory of DisplayPort link attributes. It exists for
+		DisplayPort and eDP connectors and is empty until the
+		driver reports the source and the sink capabilities.
+
+What:		/sys/class/drm/card<X>-<connector>/dp_link/source_link_caps_nlanes
+Date:		October 2026
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		Maximum number of DisplayPort lanes the source of this
+		connector can drive.
+
+		Valid values: 1, 2 or 4
+
+What:		/sys/class/drm/card<X>-<connector>/dp_link/source_link_caps_link_rates
+Date:		October 2026
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		Space-separated list of the DisplayPort link rates the
+		source of this connector can drive, in kbps, sorted in
+		ascending order.
+
+What:		/sys/class/drm/card<X>-<connector>/dp_link/source_link_caps_dsc
+Date:		October 2026
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		Indicates whether the source of this connector supports
+		Display Stream Compression (DSC).
+
+		Valid values: 0 (not supported), 1 (supported)
+
+What:		/sys/class/drm/card<X>-<connector>/dp_link/sink_link_caps_nlanes
+Date:		October 2026
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		Maximum number of DisplayPort lanes supported by the
+		connected sink, as reported by the sink capabilities.
+
+		Valid values: 1, 2 or 4
+
+What:		/sys/class/drm/card<X>-<connector>/dp_link/sink_link_caps_link_rates
+Date:		October 2026
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		Space-separated list of the DisplayPort link rates
+		supported by the connected sink, in kbps, sorted in
+		ascending order. The list is empty if the sink link
+		rates could not be read.
+
+What:		/sys/class/drm/card<X>-<connector>/dp_link/sink_link_caps_dsc
+Date:		October 2026
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		Indicates whether the connected sink supports Display
+		Stream Compression (DSC).
+
+		Valid values: 0 (not supported), 1 (supported)
+
+What:		/sys/class/drm/card<X>-<connector>/dp_link/cur_link_info_nlanes
+Date:		October 2026
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		Number of lanes used by the currently trained DisplayPort
+		link of this connector.
+
+		Valid values: 1, 2 or 4
+
+What:		/sys/class/drm/card<X>-<connector>/dp_link/cur_link_info_link_rate
+Date:		October 2026
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		Link rate of the currently trained DisplayPort link of
+		this connector, in kbps.
+
+What:		/sys/class/drm/card<X>-<connector>/dp_link/cur_link_info_dsc
+Date:		October 2026
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		Indicates whether Display Stream Compression (DSC) is
+		active on the currently trained DisplayPort link.
+
+		Valid values: 0 (disabled), 1 (enabled)
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 93cf43d166c6e..c37826ad4d5a8 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -40,6 +40,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_print.h>
+#include <drm/drm_sysfs.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_panel.h>
 
@@ -5118,6 +5119,30 @@ int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
 }
 EXPORT_SYMBOL_GPL(drm_dp_read_dpcd_sink_rates);
 
+/**
+ * drm_dp_get_max_lane_count - Get the max lane count from DPCD and LTTPR
+ *			       capabilities
+ * @dpcd: DPCD receiver capabilities
+ * @lttpr_common_caps: LTTPR common capabilities (NULL if no LTTPR supported)
+ *
+ * Returns: Number of max lane count
+ */
+int drm_dp_get_max_lane_count(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
+			      const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE])
+{
+	int nlanes, lttpr_nlanes;
+
+	nlanes = dpcd[DP_MAX_LANE_COUNT] & DP_MAX_LANE_COUNT_MASK;
+	if (lttpr_common_caps) {
+		lttpr_nlanes = drm_dp_lttpr_max_lane_count(lttpr_common_caps);
+		if (lttpr_nlanes)
+			nlanes = min(nlanes, lttpr_nlanes);
+	}
+
+	return nlanes;
+}
+EXPORT_SYMBOL_GPL(drm_dp_get_max_lane_count);
+
 /**
  * drm_dp_read_edp_sink_rates() - read the sink rates from the eDP DPCD
  * @aux: DisplayPort AUX channel
@@ -5179,3 +5204,282 @@ int drm_dp_read_dsc_dpcd(struct drm_dp_aux *aux,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(drm_dp_read_dsc_dpcd);
+
+static int drm_dp_copy_caps(struct drm_connector_dp_link_caps *dest_caps,
+			    const struct drm_connector_dp_link_caps *src_caps)
+{
+	int *link_rates = NULL;
+	int nlink_rates = 0;
+
+	if (src_caps->link_rates && src_caps->nlink_rates > 0) {
+		link_rates = kmemdup_array(src_caps->link_rates,
+					   src_caps->nlink_rates,
+					   sizeof(*src_caps->link_rates),
+					   GFP_KERNEL);
+		if (!link_rates)
+			return -ENOMEM;
+
+		nlink_rates = src_caps->nlink_rates;
+	}
+
+	kfree(dest_caps->link_rates);
+
+	dest_caps->nlanes = src_caps->nlanes;
+	dest_caps->nlink_rates = nlink_rates;
+	dest_caps->link_rates = link_rates;
+	dest_caps->dsc = src_caps->dsc;
+
+	return 0;
+}
+
+/**
+ * drm_dp_source_set_caps - Set DisplayPort source capabilities
+ * @connector: DisplayPort connector
+ * @link_caps: DisplayPort link training capabilities. The link_rates pointer
+ *	       is not kept by the DRM core
+ *
+ * This function sets the DisplayPort source link training capabilities
+ * for the given connector. This function has to be called after
+ * drm_connector_init() and before drm_dev_register().
+ */
+int drm_dp_source_set_caps(struct drm_connector *connector,
+			   const struct drm_connector_dp_link_caps *link_caps)
+{
+	int ret;
+
+	if (!connector)
+		return -ENODEV;
+
+	if (!(connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
+	      connector->connector_type == DRM_MODE_CONNECTOR_eDP))
+		return -EINVAL;
+
+	WARN_ON(connector->dev->registered);
+
+	/* No need to take the dp mutex as the connector sysfs is not yet
+	 * created
+	 */
+	ret = drm_dp_copy_caps(&connector->dp.source_link_caps, link_caps);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drm_dp_source_set_caps);
+
+/**
+ * drm_dp_sink_set_caps - Set DisplayPort sink link capabilities
+ * @connector: DisplayPort connector
+ * @link_caps: DisplayPort link training capabilities. The link_rates pointer
+ *	       is not kept by the DRM core
+ *
+ * This function sets the DisplayPort sink (monitor) link training
+ * capabilities for the given connector. This function lets the controller
+ * driver read the DPCD on its own, to avoid too many read of the same
+ * DPCD data.
+ * This should be called when a sink is connected.
+ *
+ * Returns: 0 if the capabilities were set successfully, negative error code
+ * otherwise.
+ */
+int drm_dp_sink_set_caps(struct drm_connector *connector,
+			 const struct drm_connector_dp_link_caps *link_caps)
+{
+	int ret;
+
+	if (!connector)
+		return -ENODEV;
+
+	drm_modeset_lock_assert_held(&connector->dev->mode_config.connection_mutex);
+
+	scoped_guard(mutex, &connector->dp.mutex) {
+		ret = drm_dp_copy_caps(&connector->dp.sink_link_caps, link_caps);
+		if (ret)
+			return ret;
+
+		drm_sysfs_connector_dp_link_update(connector);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drm_dp_sink_set_caps);
+
+/**
+ * drm_dp_sink_sync_caps - Fetch and set DisplayPort sink link capabilities
+ * @connector: DisplayPort connector
+ * @aux: DisplayPort AUX channel
+ * @tunnel: Tunnel object (NULL if not supported)
+ *
+ * This function fetches the DisplayPort sink link capabilities from DPCD and
+ * sets them for the given connector.
+ * This should be called when a sink is connected.
+ *
+ * Returns: 0 if the capabilities were fetched and set successfully, negative
+ * error code otherwise.
+ */
+int drm_dp_sink_sync_caps(struct drm_connector *connector, struct drm_dp_aux *aux,
+			  const struct drm_dp_tunnel *tunnel)
+{
+	u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE] = {0};
+	struct drm_connector_dp_link_caps link_caps;
+	int sink_rates[DP_MAX_SUPPORTED_RATES] = {0};
+	u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE] = {0};
+	u8 dpcd_caps[DP_RECEIVER_CAP_SIZE] = {0};
+	struct drm_dp_desc desc = {0};
+	int num_sink_rates, ret;
+	u8 edp_dpcd_rev = 0;
+
+	if (!connector)
+		return -ENODEV;
+
+	drm_modeset_lock_assert_held(&connector->dev->mode_config.connection_mutex);
+
+	ret = drm_dp_read_dpcd_caps(aux, dpcd_caps);
+	if (ret < 0) {
+		drm_dbg_kms(aux->drm_dev, "%s: error reading DPCD capabilities (%d)\n",
+			    aux->name, ret);
+		return ret;
+	}
+
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		ret = drm_dp_dpcd_read_byte(aux, DP_EDP_DPCD_REV, &edp_dpcd_rev);
+		if (ret < 0)
+			drm_dbg_kms(aux->drm_dev, "%s: No DPCD eDP revision found\n",
+				    aux->name);
+	}
+
+	if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort &&
+	    dpcd_caps[DP_DPCD_REV] >= DP_DPCD_REV_13) {
+		ret = drm_dp_read_lttpr_common_caps(aux, dpcd_caps, lttpr_common_caps);
+		if (ret < 0) {
+			drm_dbg_kms(aux->drm_dev,
+				    "%s: error reading LTTPR caps, assuming no LTTPR (%d)\n",
+				    aux->name, ret);
+			/* LTTPR capabilities are read block by block. Clean the
+			 * entire capabilities if the read fails to avoid
+			 * partial garbage
+			 */
+			memset(lttpr_common_caps, 0, sizeof(lttpr_common_caps));
+		}
+	}
+
+	ret = drm_dp_read_desc(aux, &desc, drm_dp_is_branch(dpcd_caps));
+	if (ret)
+		drm_dbg_kms(aux->drm_dev, "%s: No DPCD descriptor found\n",
+			    aux->name);
+
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		num_sink_rates = drm_dp_read_edp_sink_rates(aux, edp_dpcd_rev,
+							    sink_rates);
+
+		/*
+		 * Use the rates of the DP_MAX_LINK_RATE and
+		 * DP_128B132B_SUPPORTED_LINK_RATES registers if the sink does
+		 * not support the DP_SUPPORTED_LINK_RATES register.
+		 */
+		if (num_sink_rates <= 0)
+			num_sink_rates = drm_dp_read_dpcd_sink_rates(aux, dpcd_caps,
+								     lttpr_common_caps,
+								     &desc,
+								     tunnel,
+								     sink_rates);
+	} else {
+		num_sink_rates = drm_dp_read_dpcd_sink_rates(aux, dpcd_caps,
+							     lttpr_common_caps,
+							     &desc,
+							     tunnel,
+							     sink_rates);
+	}
+
+	if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort &&
+	     dpcd_caps[DP_DPCD_REV] >= DP_DPCD_REV_14) ||
+	    (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
+	     edp_dpcd_rev >= DP_EDP_14)) {
+		ret = drm_dp_read_dsc_dpcd(aux, dsc_dpcd);
+		if (ret < 0)
+			drm_dbg_kms(aux->drm_dev,
+				    "%s: error reading DPCD DSC capabilities (%d)\n",
+				    aux->name, ret);
+	}
+
+	link_caps.nlanes = drm_dp_get_max_lane_count(dpcd_caps, lttpr_common_caps);
+	link_caps.nlink_rates = num_sink_rates;
+	link_caps.link_rates = sink_rates;
+	link_caps.dsc = drm_dp_sink_supports_dsc(dsc_dpcd);
+
+	return drm_dp_sink_set_caps(connector, &link_caps);
+}
+EXPORT_SYMBOL_GPL(drm_dp_sink_sync_caps);
+
+/**
+ * drm_dp_set_cur_link_params - Set current DisplayPort link parameters
+ * @connector: DisplayPort connector
+ * @link_rate: Current link rate in deca-kbps
+ * @lane_count: Current lane count
+ * @dsc_en: Display Stream Compression enabled
+ *
+ * This function sets the current active DisplayPort link parameters after
+ * link training has completed. These parameters represent the actual link
+ * configuration being used for display output.
+ */
+void drm_dp_set_cur_link_params(struct drm_connector *connector,
+				int link_rate, int lane_count, bool dsc_en)
+{
+	bool update = false;
+	int *_link_rates;
+
+	if (!connector)
+		return;
+
+	drm_modeset_lock_assert_held(&connector->dev->mode_config.connection_mutex);
+
+	scoped_guard(mutex, &connector->dp.mutex) {
+		if (!connector->dp.cur_link_info.nlanes || !lane_count)
+			update = true;
+
+		if (!connector->dp.cur_link_info.link_rates) {
+			_link_rates = kzalloc_obj(*_link_rates);
+			if (!_link_rates)
+				return;
+
+			connector->dp.cur_link_info.link_rates = _link_rates;
+			connector->dp.cur_link_info.nlink_rates = 1;
+		}
+
+		*connector->dp.cur_link_info.link_rates = link_rate;
+		connector->dp.cur_link_info.nlanes = lane_count;
+		connector->dp.cur_link_info.dsc = dsc_en;
+
+		if (update)
+			drm_sysfs_connector_dp_link_update(connector);
+	}
+}
+EXPORT_SYMBOL_GPL(drm_dp_set_cur_link_params);
+
+/**
+ * drm_dp_sink_reset_caps - Reset DisplayPort sink capabilities
+ * @connector: DisplayPort connector
+ *
+ * This function clears all DisplayPort sink link capabilities and parameters.
+ * This should be called when a sink is disconnected to clear stale
+ * capability information.
+ */
+void drm_dp_sink_reset_caps(struct drm_connector *connector)
+{
+	struct drm_connector_dp_link_caps zero_caps = {0};
+
+	if (!connector)
+		return;
+
+	drm_modeset_lock_assert_held(&connector->dev->mode_config.connection_mutex);
+
+	scoped_guard(mutex, &connector->dp.mutex) {
+		kfree(connector->dp.cur_link_info.link_rates);
+		memcpy(&connector->dp.cur_link_info, &zero_caps, sizeof(zero_caps));
+		kfree(connector->dp.sink_link_caps.link_rates);
+		memcpy(&connector->dp.sink_link_caps, &zero_caps, sizeof(zero_caps));
+
+		drm_sysfs_connector_dp_link_update(connector);
+	}
+}
+EXPORT_SYMBOL_GPL(drm_dp_sink_reset_caps);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 893716a9e4895..f9b780fb340b5 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -285,6 +285,7 @@ static int drm_connector_init_only(struct drm_device *dev,
 	mutex_init(&connector->edid_override_mutex);
 	mutex_init(&connector->hdmi.infoframes.lock);
 	mutex_init(&connector->hdmi_audio.lock);
+	mutex_init(&connector->dp.mutex);
 	connector->edid_blob_ptr = NULL;
 	connector->epoch_counter = 0;
 	connector->tile_blob_ptr = NULL;
@@ -941,6 +942,16 @@ void drm_connector_cleanup(struct drm_connector *connector)
 		connector->tile_group = NULL;
 	}
 
+	scoped_guard(mutex, &connector->dp.mutex) {
+		kfree(connector->dp.source_link_caps.link_rates);
+		connector->dp.source_link_caps.link_rates = NULL;
+		kfree(connector->dp.sink_link_caps.link_rates);
+		connector->dp.sink_link_caps.link_rates = NULL;
+		kfree(connector->dp.cur_link_info.link_rates);
+		connector->dp.cur_link_info.link_rates = NULL;
+	}
+	mutex_destroy(&connector->dp.mutex);
+
 	list_for_each_entry_safe(mode, t, &connector->probed_modes, head)
 		drm_mode_remove(connector, mode);
 
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 7b16d32b6ff65..1949b46419c6d 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -340,6 +340,149 @@ static const struct attribute_group *connector_dev_groups[] = {
 	NULL
 };
 
+static ssize_t drm_link_rates_show(int num_link_rates, const int *link_rates, char *buf)
+{
+	ssize_t size = 0;
+
+	if (!num_link_rates)
+		return 0;
+
+	/* We are using deca-kbps in the kernel historically, due to
+	 * calculation over the link rates that could overflow 32 bits.
+	 * Report link rates in kbps to avoid confusing the user
+	 */
+	size += sysfs_emit_at(buf, size, "%d", link_rates[0] * 10);
+	for (int i = 1; i < num_link_rates; i++)
+		size += sysfs_emit_at(buf, size, " %d", link_rates[i] * 10);
+
+	size += sysfs_emit_at(buf, size, "\n");
+	return size;
+}
+
+#define DRM_CONNECTOR_DP_ATTR_SHOW_LINK_RATES_NESTED(_name)                    \
+static ssize_t _name##_link_rates_show(struct device *device,                  \
+			    struct device_attribute *attr,                     \
+			    char *buf)                                         \
+{                                                                              \
+	struct drm_connector *connector = to_drm_connector(device);            \
+	ssize_t size;                                                          \
+	scoped_guard(mutex, &connector->dp.mutex)			       \
+		size = drm_link_rates_show(connector->dp._name.nlink_rates,    \
+					   connector->dp._name.link_rates, buf); \
+	return size;                                                           \
+}
+
+#define DRM_CONNECTOR_DP_ATTR_SHOW_SIMPLE_NESTED(_name, _info)                 \
+static ssize_t _name##_##_info##_show(struct device *device,                   \
+				   struct device_attribute *attr,              \
+				   char *buf)                                  \
+{                                                                              \
+	struct drm_connector *connector = to_drm_connector(device);            \
+	ssize_t size;                                                          \
+	scoped_guard(mutex, &connector->dp.mutex)			       \
+		size = sysfs_emit(buf, "%d\n", connector->dp._name._info);     \
+	return size;                                                           \
+}
+
+static ssize_t cur_link_info_link_rate_show(struct device *device,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct drm_connector *connector = to_drm_connector(device);
+	ssize_t size;
+
+	scoped_guard(mutex, &connector->dp.mutex)
+		size = drm_link_rates_show(connector->dp.cur_link_info.nlink_rates,
+					   connector->dp.cur_link_info.link_rates, buf);
+	return size;
+}
+
+DRM_CONNECTOR_DP_ATTR_SHOW_SIMPLE_NESTED(source_link_caps, nlanes);
+DRM_CONNECTOR_DP_ATTR_SHOW_LINK_RATES_NESTED(source_link_caps);
+DRM_CONNECTOR_DP_ATTR_SHOW_SIMPLE_NESTED(source_link_caps, dsc);
+DRM_CONNECTOR_DP_ATTR_SHOW_SIMPLE_NESTED(sink_link_caps, nlanes);
+DRM_CONNECTOR_DP_ATTR_SHOW_LINK_RATES_NESTED(sink_link_caps);
+DRM_CONNECTOR_DP_ATTR_SHOW_SIMPLE_NESTED(sink_link_caps, dsc);
+DRM_CONNECTOR_DP_ATTR_SHOW_SIMPLE_NESTED(cur_link_info, nlanes);
+DRM_CONNECTOR_DP_ATTR_SHOW_SIMPLE_NESTED(cur_link_info, dsc);
+
+static DEVICE_ATTR_RO(source_link_caps_nlanes);
+static DEVICE_ATTR_RO(source_link_caps_link_rates);
+static DEVICE_ATTR_RO(source_link_caps_dsc);
+static DEVICE_ATTR_RO(sink_link_caps_nlanes);
+static DEVICE_ATTR_RO(sink_link_caps_link_rates);
+static DEVICE_ATTR_RO(sink_link_caps_dsc);
+static DEVICE_ATTR_RO(cur_link_info_nlanes);
+static DEVICE_ATTR_RO(cur_link_info_link_rate);
+static DEVICE_ATTR_RO(cur_link_info_dsc);
+
+static struct attribute *connector_dp_link_attrs[] = {
+	&dev_attr_source_link_caps_nlanes.attr,
+	&dev_attr_source_link_caps_link_rates.attr,
+	&dev_attr_source_link_caps_dsc.attr,
+	&dev_attr_sink_link_caps_nlanes.attr,
+	&dev_attr_sink_link_caps_link_rates.attr,
+	&dev_attr_sink_link_caps_dsc.attr,
+	&dev_attr_cur_link_info_nlanes.attr,
+	&dev_attr_cur_link_info_link_rate.attr,
+	&dev_attr_cur_link_info_dsc.attr,
+	NULL
+};
+
+static umode_t dp_link_attr_visible(struct kobject *kobj,
+				    struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_connector *connector = to_drm_connector(dev);
+	struct drm_connector_dp_link_caps *caps;
+
+	if (a == &dev_attr_source_link_caps_nlanes.attr ||
+	    a == &dev_attr_source_link_caps_link_rates.attr ||
+	    a == &dev_attr_source_link_caps_dsc.attr)
+		caps = &connector->dp.source_link_caps;
+	else if (a == &dev_attr_sink_link_caps_nlanes.attr ||
+		 a == &dev_attr_sink_link_caps_link_rates.attr ||
+		 a == &dev_attr_sink_link_caps_dsc.attr)
+		caps = &connector->dp.sink_link_caps;
+	else
+		caps = &connector->dp.cur_link_info;
+
+	/* Checking nlanes is enough to decide whether the attributes should
+	 * be exposed: without lanes there is no working DisplayPort link
+	 */
+	return caps->nlanes ? a->mode : 0;
+}
+
+static const struct attribute_group connector_dp_link_group = {
+	.name = "dp_link",
+	.attrs = connector_dp_link_attrs,
+	.is_visible = dp_link_attr_visible,
+};
+
+/**
+ * drm_sysfs_connector_dp_link_update - Update the visibility of the DP link
+ *                                      attributes
+ * @connector: DisplayPort connector
+ */
+void drm_sysfs_connector_dp_link_update(struct drm_connector *connector)
+{
+	int ret;
+
+	if (!connector->kdev)
+		return;
+
+	if (connector->connector_type != DRM_MODE_CONNECTOR_DisplayPort &&
+	    connector->connector_type != DRM_MODE_CONNECTOR_eDP)
+		return;
+
+	ret = sysfs_update_group(&connector->kdev->kobj,
+				 &connector_dp_link_group);
+	if (ret)
+		drm_err(connector->dev,
+			"failed to update DP link sysfs attributes: %d\n", ret);
+}
+EXPORT_SYMBOL_GPL(drm_sysfs_connector_dp_link_update);
+
 int drm_sysfs_connector_add(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
@@ -376,6 +519,15 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
 
 	connector->kdev = kdev;
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
+	    connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		r = sysfs_create_group(&connector->kdev->kobj, &connector_dp_link_group);
+		if (r) {
+			drm_err(dev, "failed to create DP connector sysfs: %d\n", r);
+			goto err_dp_sysfs;
+		}
+	}
+
 	if (dev_fwnode(kdev)) {
 		r = component_add(kdev, &typec_connector_ops);
 		if (r)
@@ -384,6 +536,9 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
 
 	return 0;
 
+err_dp_sysfs:
+	connector->kdev = NULL;
+	device_del(kdev);
 err_free:
 	put_device(kdev);
 	return r;
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 7bc3b36f38b82..ad899ac18bfd8 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -712,6 +712,8 @@ int drm_dp_read_dpcd_sink_rates(struct drm_dp_aux *aux,
 				int sink_rates[DP_MAX_SUPPORTED_RATES]);
 int drm_dp_read_edp_sink_rates(struct drm_dp_aux *aux, u8 edp_dpcd_rev,
 			       int sink_rates[DP_MAX_SUPPORTED_RATES]);
+int drm_dp_get_max_lane_count(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
+			      const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE]);
 
 int drm_dp_dpcd_read_link_status(struct drm_dp_aux *aux,
 				 u8 status[DP_LINK_STATUS_SIZE]);
@@ -1051,4 +1053,14 @@ ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc, struct dp_sdp *sdp
 int drm_dp_link_symbol_cycles(int lane_count, int pixels, int dsc_slice_count,
 			      int bpp_x16, int symbol_size, bool is_mst);
 
+int drm_dp_source_set_caps(struct drm_connector *connector,
+			   const struct drm_connector_dp_link_caps *link_caps);
+int drm_dp_sink_sync_caps(struct drm_connector *connector, struct drm_dp_aux *aux,
+			  const struct drm_dp_tunnel *tunnel);
+int drm_dp_sink_set_caps(struct drm_connector *connector,
+			 const struct drm_connector_dp_link_caps *link_caps);
+void drm_dp_sink_reset_caps(struct drm_connector *connector);
+void drm_dp_set_cur_link_params(struct drm_connector *connector, int link_rate,
+				int lane_count, bool dsc_en);
+
 #endif /* _DRM_DP_HELPER_H_ */
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aae..415fa5652d3c4 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2282,6 +2282,54 @@ struct drm_connector_cec {
 	void *data;
 };
 
+/**
+ * struct drm_connector_dp_link_caps - DRM DisplayPort link capabilities
+ */
+struct drm_connector_dp_link_caps {
+	/**
+	 * @nlanes: Maximum number of lanes number supported
+	 */
+	int nlanes;
+
+	/**
+	 * @nlink_rates: Number of link rates supported
+	 */
+	int nlink_rates;
+
+	/**
+	 * @link_rates: Array listing the supported link rates in deca-kbps
+	 */
+	int *link_rates;
+
+	/**
+	 * @dsc: Display Stream Compression supported
+	 */
+	bool dsc;
+};
+
+/**
+ * struct drm_connector_dp - DRM Connector DisplayPort-related structure
+ */
+struct drm_connector_dp {
+	/**
+	 * @source_link_caps: Source link capabilities
+	 */
+	struct drm_connector_dp_link_caps source_link_caps;
+	/**
+	 * @sink_link_caps: Sink link capabilities
+	 */
+	struct drm_connector_dp_link_caps sink_link_caps;
+	/**
+	 * @cur_link_info: Current negotiated link information
+	 */
+	struct drm_connector_dp_link_caps cur_link_info;
+
+	/**
+	 * @mutex: Lock to protect read write access
+	 */
+	struct mutex mutex;
+};
+
 /**
  * struct drm_connector - central DRM connector control structure
  *
@@ -2714,6 +2762,11 @@ struct drm_connector {
 	 * @cec: CEC-related data.
 	 */
 	struct drm_connector_cec cec;
+
+	/**
+	 * @dp: DisplayPort-related variable and properties.
+	 */
+	struct drm_connector_dp dp;
 };
 
 #define obj_to_connector(x) container_of(x, struct drm_connector, base)
diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
index 7695873a94565..366a02e27f366 100644
--- a/include/drm/drm_sysfs.h
+++ b/include/drm/drm_sysfs.h
@@ -10,4 +10,5 @@ void drm_sysfs_hotplug_event(struct drm_device *dev);
 void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
 void drm_sysfs_connector_property_event(struct drm_connector *connector,
 					struct drm_property *property);
+void drm_sysfs_connector_dp_link_update(struct drm_connector *connector);
 #endif

-- 
2.43.0

