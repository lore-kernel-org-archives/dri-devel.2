Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340F606A330
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F8mxWKbL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C33341127BB;
	Thu, 19 Nov 2026 23:29:56 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E52911279F;
 Thu, 19 Nov 2026 23:29:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkQhS3WeKd+SuqZ1iW7gAp+6PovhC3fUsF5pG8vKC1zLObwMBxwwK5tAfG6vCJqN92M3VAKghwanwt+Uri+Y3yFeR1n4nPTXq/doby86Ixd3ikdIjXA09twJffjcOnay8mKfSi+ibhA1EsgOGEOrqKTosqQh84OStgyPioBjQjyadlTUKxzLlZ17SN5jVXOp/tkOKVlFgegGIEgtKHDPV8Be9YS2aaJK6zP94qCYpIfpr5hDNp9PH3VdfNXXDyATAjFiSceB6RgrM0inXkOMN8zqPmnJHH6NvVbSjGdd0c/HmKfGLu1xyLsl+kJ0HrokBziSFiPZ+Q32y6Px17IzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeMocPa7Lil9k6tv0y/oQ+AAmh2oTdJhlet1p19Jyw4=;
 b=fvw7a4UbKZCEVia4NXuhwmSAK2ibG55Bb7c6UYWIM5I7C26Q+TdfO8DS9HZDWUZOG0GYbQtVbhlv5yUH9BFko0GsbB2cm/5eyJiTI/IQdK9BPRgJQGzbCmAfm38ROMQtX5PYC2VPRdbyAlF1N6BUQ/IHq7xYYziDj+c8H4X/zSlM7W1E15xmvBInlKloujikPywraelOnlih1kA7cPdi/RRKyUDQSyfemwBOggtEqZzC1qJXn3rQGAownBBQvXaTzMZkNQOBpVPb67/1qDJlOAn89lCH1g68NNqn74HMymzRWKYPTTxgenFSgV7ANkTwd4utDDAlgjBkMAS97PKoSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeMocPa7Lil9k6tv0y/oQ+AAmh2oTdJhlet1p19Jyw4=;
 b=F8mxWKbL37nIirNYxEBxWHq+24V06tvRPTwfqPsAIoDFsxeDxphcFvHqIkKYpTDaphDx/0rtf/CUX/ob+EXwZs2ZFx8WYSBpEbWx0Ylr/domMLi92jQcI2nstx6OXK++3drzg3/jxBQs6d2r8cbHtaI3h5eqnM6LZDUSUO425TI=
Received: from PH8P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::12)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 23:27:43 +0000
Received: from PH7PEPF00000007.namprd04.prod.outlook.com
 (2603:10b6:510:348:cafe::62) by PH8P220CA0026.outlook.office365.com
 (2603:10b6:510:348::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 23:27:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000007.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:27:43 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:27:40 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 17:27:28 -0600
Subject: [PATCH v12 01/12] drm: add connector LUMINANCE property
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-superm1-backlight-property-v12-1-89d5217d3618@amd.com>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
In-Reply-To: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
To: Maxime Ripard <mripard@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Harry
 Wentland" <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Rodrigo
 Siqueira" <siqueira@igalia.com>
CC: Mario Limonciello <superm1@kernel.org>, Xaver Hugl <xaver.hugl@gmail.com>, 
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000007:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 2355f40a-2e26-42e9-1995-08df4694b601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|7416014|376014|36860700016|1800799024|6133799003|22082099003|18002099003|3023799007|5023799004|11063799006|260925021311599003|260925022911599003|260925021911599003|921020|261022075727099003|261026140227099003|261022105027099003|261028144727099003|56012099006|10067099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261009221227099003|261102130727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: slutxArgM2gcXP3ZBqmbgHlLlVSILZnoGaZjZfuhWdxqpG2b6Kk+Ryhh+Z4f/Ur5a0th6ITgwtXyCojhkaej+AxQG5YouaBHvMJyss9hZMBYgHz02aMPF6EbC48HLiNid1kAyUNXi9Y4px+wu3Pf3wp0jE5IuZ9Fagq+4Isg3V4Xi+CP/GNqpMz32rZAFKY59HYD06fl6zEa3q6bRqdWoszlpwiqXJtAWdXWdd6b+En+tz6UiAuilequRgWSM1XkG9njD9B4yeSq8RLaNXA2sVh7JAlxosqGYiwPYAKBlzgzbtJcz6z/egNr6UWcuP2o8RO0qyxT9sEqHvOnSCAKQsTEMnTKSG/xkIv7IBQMnccPj0NCrbP/Qmrqgb7zoe98mWywyjupJecPS9WJUtFn9pE+CM0uBzps/VY3ZfRUTDUWzHG3aJftwZlnD/z4kuceVuuRRYl9KR+fvHiG0cag8L7oTj8ZxKWBhJr5iurWPp/cRmN07hoO/J1MV11nLAgJeK+QNFYJp+EAwdqPySNG2esHxHAL5jxtc4jKv1S5/tweErNJVWWuanrXflflC7xZATjDGBMHm1PWN6KnvfBoYH7Gs86a2kLWxYZWNcSW1ZqGn27SY6zi+B5IWDce+q47Rag26kE7c5LC5QQpdQhAFi03mw3NBssx9fcLz1K9ZZmaHkvFWWledXAzgMgLgbICEr7iLptf+Q+TZFYVayFDP9jopkX7149cn/b+t899zs1G40ccgNm5NQTePg9u+Ghc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(5023799004)(11063799006)(260925021311599003)(260925022911599003)(260925021911599003)(921020)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003)(261102130727099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KGWB2R/QxGsuhFAwAsUlnmoN8OHT4x/VUik0WuHbIDGClDz2DCpbfp/51B88ACN5MfM/dZ3OBvH2o9aJG4H4cIH9tsPDMKdq077Zt1WbPtQ1vDJFlcZBniUL+k5yJ4fmvrY5mOVnvQf2hVC3cF2EPU4LRWjeykXYB3MnuE4KY3duqHRPoCnKfeusA0wGwDnxHylXQWeWBKZUNg7bwtXzPVw+Y37kYnix/mZpJ+obEBt+x7vBvmrv+szZ5Xuo/V3yawZ98kiwUIg1g9jd5x9U5rVKF/aeS7JpPJ/v6Zqykgi7lpOz1tYPrN8Sj/ZB+u7GA7fCm1rI+CjMtbLKdxm5+DEsXVAFPR8azN3N8bkAvGpNcctQy3cN/dhC3eZ6FUr7iHA3YY4CuSOrkgiHpzzMOEl56DulK9AXAolOO+Op0mJrVX25CtxKSjqSaF90CC0y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:27:43.1306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2355f40a-2e26-42e9-1995-08df4694b601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000007.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Panel brightness is a property of a display, and thus of a DRM
connector. Add an atomic per-connector LUMINANCE range property so
compositors can manage relative panel luminance together with the rest
of the display state.

Keep the core backend-agnostic. Drivers create the property with their
hardware range and implement connector helper callbacks to set luminance
or disable panel emission. The atomic helpers sequence those callbacks
around pipeline enable and disable, including luminance-only commits.
The panel is left lit when the pipeline enters self refresh, and the
luminance is only reprogrammed when it changes or a modeset enables the
pipeline.

The stored property value is independent of display power. A commit made
while the connector is inactive is retained and applied on the next
enable; disabling the pipeline does not overwrite it.

LUMINANCE values are relative, driver-defined levels rather than
absolute luminance in cd/m^2. The interface supports emissive panels as
well as panels with a separate backlight.

Keep the interface behind a default-off DRM_LUMINANCE option. Migrated
drivers retain their legacy backlight class ABI unless the new interface
is explicitly selected, allowing the DRM UAPI and legacy compatibility
policy to remain separate.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11:
 * Don't call .disable_luminance when the CRTC enters self refresh (Sashiko)
 * Only call .set_luminance when the luminance changes or on a modeset
   that isn't a self refresh exit (Leo Li, Sashiko)
 * Fix the .set_luminance self refresh documentation
v10:
 * Add tag
---
 drivers/gpu/drm/Kconfig                    | 14 +++++
 drivers/gpu/drm/drm_atomic_helper.c        | 98 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/drm_atomic_state_helper.c  |  7 +++
 drivers/gpu/drm/drm_atomic_uapi.c          |  5 ++
 drivers/gpu/drm/drm_connector.c            | 57 +++++++++++++++++
 drivers/gpu/drm/tests/drm_connector_test.c | 28 +++++++++
 include/drm/drm_atomic_helper.h            |  3 +
 include/drm/drm_connector.h                | 16 +++++
 include/drm/drm_modeset_helper_vtables.h   | 28 +++++++++
 9 files changed, 255 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 61111d50b1c65..1bbe2c2d7c76f 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -33,6 +33,20 @@ endmenu
 
 if DRM
 
+config DRM_LUMINANCE
+	bool "DRM connector luminance support"
+	help
+	  Expose relative luminance as an atomic DRM connector property. Values
+	  are driver-defined levels rather than absolute luminance in cd/m^2.
+	  Drivers provide connector helper callbacks to program their hardware;
+	  the DRM core does not depend on a particular backend.
+
+	  Drivers migrated to this interface will use it instead of registering
+	  a legacy backlight class device. Leave this disabled to preserve the
+	  de-facto userspace ABI in /sys/class/backlight.
+
+	  If in doubt, say N.
+
 config DRM_MIPI_DBI
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 9d006f98413a5..856abc91ec53d 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1375,6 +1375,8 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_encoder_bridge_post_disable);
 static void
 disable_outputs(struct drm_device *dev, struct drm_atomic_commit *state)
 {
+	drm_atomic_helper_commit_luminance_disables(state);
+
 	drm_atomic_helper_commit_encoder_bridge_disable(dev, state);
 
 	drm_atomic_helper_commit_encoder_bridge_post_disable(dev, state);
@@ -1382,6 +1384,54 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_commit *state)
 	drm_atomic_helper_commit_crtc_disable(dev, state);
 }
 
+/**
+ * drm_atomic_helper_commit_luminance_disables - disable panel emission
+ * @state: atomic state object being committed
+ *
+ * Invokes each connector driver's luminance disable callback before a
+ * display pipeline is disabled. The callback is not invoked when the pipeline
+ * enters self refresh, since the panel keeps displaying the last frame. The
+ * connector property's stored value is left untouched so it can be restored
+ * when the pipeline is enabled again.
+ */
+void drm_atomic_helper_commit_luminance_disables(struct drm_atomic_commit *state)
+{
+	struct drm_connector_state *old_conn_state, *new_conn_state;
+	struct drm_connector *connector;
+	int i;
+
+	for_each_oldnew_connector_in_state(state, connector, old_conn_state,
+					   new_conn_state, i) {
+		const struct drm_connector_helper_funcs *funcs;
+		struct drm_crtc_state *old_crtc_state, *new_crtc_state = NULL;
+
+		if (!connector->luminance_property || !old_conn_state->crtc)
+			continue;
+
+		old_crtc_state =
+			drm_atomic_get_old_crtc_state(state, old_conn_state->crtc);
+		if (new_conn_state->crtc)
+			new_crtc_state =
+				drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
+
+		if (!crtc_needs_disable(old_crtc_state, new_crtc_state) ||
+		    !drm_atomic_crtc_needs_modeset(old_conn_state->crtc->state))
+			continue;
+
+		/*
+		 * Keep the panel lit while entering self refresh, matching the
+		 * panel bridge which also leaves the panel enabled.
+		 */
+		if (new_crtc_state && new_crtc_state->self_refresh_active)
+			continue;
+
+		funcs = connector->helper_private;
+		if (funcs && funcs->disable_luminance)
+			funcs->disable_luminance(old_conn_state);
+	}
+}
+EXPORT_SYMBOL(drm_atomic_helper_commit_luminance_disables);
+
 /**
  * drm_atomic_helper_update_legacy_modeset_state - update legacy modeset state
  * @dev: DRM device
@@ -1771,10 +1821,57 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 
 	drm_atomic_helper_commit_encoder_bridge_enable(dev, state);
 
+	drm_atomic_helper_commit_luminance_enables(state);
+
 	drm_atomic_helper_commit_writebacks(dev, state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
 
+/**
+ * drm_atomic_helper_commit_luminance_enables - apply luminance
+ * @state: atomic state object being committed
+ *
+ * Invokes each connector driver's luminance callback after the display
+ * pipeline has been enabled by a modeset, and for commits changing the
+ * luminance while the connector remains active. Commits that don't change
+ * the luminance only invoke the callback for a modeset other than a self
+ * refresh exit, since the panel is kept lit during self refresh. Changes
+ * committed while the connector is inactive remain stored in atomic state
+ * until a later enable.
+ */
+void drm_atomic_helper_commit_luminance_enables(struct drm_atomic_commit *state)
+{
+	struct drm_connector_state *old_conn_state, *new_conn_state;
+	struct drm_connector *connector;
+	int i;
+
+	for_each_oldnew_connector_in_state(state, connector, old_conn_state,
+					   new_conn_state, i) {
+		const struct drm_connector_helper_funcs *funcs;
+		struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+
+		if (!connector->luminance_property || !new_conn_state->crtc)
+			continue;
+
+		old_crtc_state =
+			drm_atomic_get_old_crtc_state(state, new_conn_state->crtc);
+		new_crtc_state =
+			drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
+		if (!new_crtc_state->active)
+			continue;
+
+		if (old_conn_state->luminance == new_conn_state->luminance &&
+		    (!drm_atomic_crtc_needs_modeset(new_crtc_state) ||
+		     old_crtc_state->self_refresh_active))
+			continue;
+
+		funcs = connector->helper_private;
+		if (funcs && funcs->set_luminance)
+			funcs->set_luminance(new_conn_state);
+	}
+}
+EXPORT_SYMBOL(drm_atomic_helper_commit_luminance_enables);
+
 /*
  * For atomic updates which touch just a single CRTC, calculate the time of the
  * next vblank, and inform all the fences of the deadline.
@@ -4187,4 +4284,3 @@ drm_atomic_helper_bridge_get_hdmi_output_bus_fmts(struct drm_bridge *bridge,
 	return out_fmts;
 }
 EXPORT_SYMBOL(drm_atomic_helper_bridge_get_hdmi_output_bus_fmts);
-
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 3534925636d54..bc26683db52c3 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -408,7 +408,14 @@ void
 __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
 					 struct drm_connector *connector)
 {
+	u64 value;
+
 	conn_state->connector = connector;
+	if (connector->luminance_property &&
+	    !drm_object_property_get_default_value(&connector->base,
+						   connector->luminance_property,
+						   &value))
+		conn_state->luminance = value;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_connector_state_init);
 
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eebcf6f5e05b..dffc51cd8d13c 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -30,6 +30,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
@@ -969,6 +970,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->hdmi.broadcast_rgb = val;
 	} else if (property == connector->color_format_property) {
 		state->color_format = val;
+	} else if (property == connector->luminance_property) {
+		state->luminance = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -1056,6 +1059,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->hdmi.broadcast_rgb;
 	} else if (property == connector->color_format_property) {
 		*val = state->color_format;
+	} else if (property == connector->luminance_property) {
+		*val = state->luminance;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 893716a9e4895..ab75e8bd9991a 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -810,6 +810,47 @@ void drm_connector_attach_edid_property(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_connector_attach_edid_property);
 
+/**
+ * drm_connector_attach_luminance_property - attach luminance property
+ * @connector: connector to attach the property to
+ * @min: minimum supported relative brightness
+ * @max: maximum supported relative brightness
+ * @value: initial relative brightness
+ *
+ * Creates the atomic ``LUMINANCE`` range property for @connector.
+ * Drivers should call this during connector initialization. The property's
+ * units are driver-defined; they do not represent absolute luminance.
+ *
+ * Returns:
+ * Zero on success, a negative errno otherwise.
+ */
+int drm_connector_attach_luminance_property(struct drm_connector *connector,
+					    unsigned int min,
+					    unsigned int max,
+					    unsigned int value)
+{
+	struct drm_property *property;
+
+	if (drm_WARN_ON(connector->dev, min > max || value < min || value > max))
+		return -EINVAL;
+
+	if (connector->luminance_property)
+		return 0;
+
+	property = drm_property_create_range(connector->dev, DRM_MODE_PROP_ATOMIC,
+					     "LUMINANCE", min, max);
+	if (!property)
+		return -ENOMEM;
+
+	connector->luminance_property = property;
+	drm_object_attach_property(&connector->base, property, value);
+	if (connector->state)
+		connector->state->luminance = value;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_luminance_property);
+
 /**
  * drm_connector_attach_encoder - attach a connector to an encoder
  * @connector: connector to attach
@@ -1681,6 +1722,22 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
  * 	Summarizing: Only set "DPMS" when the connector is known to be enabled,
  * 	assume that a successful SETCONFIG call also sets "DPMS" to on, and
  * 	never read back the value of "DPMS" because it can be incorrect.
+ * LUMINANCE:
+ *     Atomic range property for controlling a panel's relative luminance.
+ *     The unit and range are driver-defined and do not represent an absolute
+ *     luminance in cd/m^2. This name therefore also applies to emissive panels
+ *     that do not contain a separate backlight.
+ *
+ *     The property is independent of the connector's display-power state.
+ *     Changing it while the connector is inactive stores the new value without
+ *     turning the display on. The atomic helpers apply the stored value after
+ *     the display pipeline is enabled and invoke a separate driver callback
+ *     before disabling the pipeline; neither action changes the property value.
+ *
+ *     Drivers create the property with
+ *     drm_connector_attach_luminance_property() and implement the
+ *     corresponding &drm_connector_helper_funcs callbacks. Connectors that do
+ *     not support luminance control do not expose the property.
  * panel_type:
  * 	Immutable enum property to indicate the type of connected panel.
  * 	Possible values are "unknown" (default), "OLED", and "LCD".
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 3368aedd4e669..e43692d38ebb8 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -137,6 +137,33 @@ static void drm_test_drmm_connector_init_null_ddc(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
+static void drm_test_connector_attach_luminance_property(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	struct drm_connector *connector = &priv->connector;
+	struct drm_property *property;
+	u64 value;
+	int ret;
+
+	ret = drmm_connector_init(&priv->drm, connector, &dummy_funcs,
+				  DRM_MODE_CONNECTOR_eDP, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NULL(test, connector->state);
+
+	ret = drm_connector_attach_luminance_property(connector, 10, 100, 50);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	property = connector->luminance_property;
+	KUNIT_ASSERT_NOT_NULL(test, property);
+
+	ret = drm_object_property_get_default_value(&connector->base, property, &value);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, value, (u64)50);
+
+	drm_atomic_helper_connector_reset(connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	KUNIT_EXPECT_EQ(test, connector->state->luminance, 50u);
+}
+
 /*
  * Test that the registration of a connector succeeds for all possible
  * connector types.
@@ -190,6 +217,7 @@ KUNIT_ARRAY_PARAM(drm_connector_init_type_valid,
 static struct kunit_case drmm_connector_init_tests[] = {
 	KUNIT_CASE(drm_test_drmm_connector_init),
 	KUNIT_CASE(drm_test_drmm_connector_init_null_ddc),
+	KUNIT_CASE(drm_test_connector_attach_luminance_property),
 	KUNIT_CASE_PARAM(drm_test_drmm_connector_init_type_valid,
 			 drm_connector_init_type_valid_gen_params),
 	{ }
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 4cfeec70d648a..3084dd5cd6a1f 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -116,6 +116,9 @@ void drm_atomic_helper_commit_encoder_bridge_enable(struct drm_device *dev,
 void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 					  struct drm_atomic_commit *old_state);
 
+void drm_atomic_helper_commit_luminance_disables(struct drm_atomic_commit *state);
+void drm_atomic_helper_commit_luminance_enables(struct drm_atomic_commit *state);
+
 int drm_atomic_helper_prepare_planes(struct drm_device *dev,
 				     struct drm_atomic_commit *state);
 void drm_atomic_helper_unprepare_planes(struct drm_device *dev,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aae..7f7d115b65f9f 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1369,6 +1369,11 @@ struct drm_connector_state {
 	 * @drm_atomic_helper_connector_hdmi_check().
 	 */
 	struct drm_connector_hdmi_state hdmi;
+
+	/**
+	 * @luminance: Relative panel luminance requested by userspace.
+	 */
+	unsigned int luminance;
 };
 
 struct drm_connector_hdmi_audio_funcs {
@@ -2714,6 +2719,13 @@ struct drm_connector {
 	 * @cec: CEC-related data.
 	 */
 	struct drm_connector_cec cec;
+
+	/**
+	 * @luminance_property: Optional atomic range property for relative panel
+	 * luminance. Drivers create it with
+	 * drm_connector_attach_luminance_property().
+	 */
+	struct drm_property *luminance_property;
 };
 
 #define obj_to_connector(x) container_of(x, struct drm_connector, base)
@@ -2980,6 +2992,10 @@ const char *drm_get_colorspace_name(enum drm_colorspace colorspace);
 
 int drm_connector_attach_color_format_property(struct drm_connector *connector,
 					       unsigned long supported_color_formats);
+int drm_connector_attach_luminance_property(struct drm_connector *connector,
+					    unsigned int min,
+					    unsigned int max,
+					    unsigned int value);
 
 /**
  * drm_for_each_connector_iter - connector_list iterator macro
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 60b30cc269404..1c614f44de7ca 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1147,6 +1147,34 @@ struct drm_connector_helper_funcs {
 	void (*atomic_commit)(struct drm_connector *connector,
 			      struct drm_atomic_commit *state);
 
+	/**
+	 * @set_luminance:
+	 *
+	 * Apply &drm_connector_state.luminance to an active panel. The
+	 * atomic helpers call this after a modeset enabled the display
+	 * pipeline, and for commits changing the luminance while the connector
+	 * remains active. It is not called when the luminance is unchanged,
+	 * unless a modeset other than a self refresh exit happened.
+	 *
+	 * This callback is optional and is only used by connectors exposing the
+	 * ``LUMINANCE`` property.
+	 */
+	void (*set_luminance)(const struct drm_connector_state *new_state);
+
+	/**
+	 * @disable_luminance:
+	 *
+	 * Turn panel light emission off before disabling the display pipeline.
+	 * It is not called when the pipeline enters self refresh.
+	 * This callback does not change the ``LUMINANCE`` property; the
+	 * stored value is restored through @set_luminance when the panel
+	 * is enabled again.
+	 *
+	 * This callback is optional and is only used by connectors exposing the
+	 * ``LUMINANCE`` property.
+	 */
+	void (*disable_luminance)(const struct drm_connector_state *old_state);
+
 	/**
 	 * @prepare_writeback_job:
 	 *

-- 
2.43.0

