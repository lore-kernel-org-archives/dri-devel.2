Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98641606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FzrGkwjZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D301127CD;
	Thu, 19 Nov 2026 23:29:25 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011031.outbound.protection.outlook.com
 [40.93.194.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 012B910E365;
 Thu, 19 Nov 2026 23:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFHS4ymhFoCzngUwqtTzP94UpSxb5yvktYgWIt53Fc9H/8x500/9gMNTrTA8kM1JQS1JNcXf6T3UJGLvMPN4Vn9zEyPFZVFav56WvYYdrGLZx6x0LhFYKJa6rlzShcjP72my//nOywruDh95/VcXgfD4HRRd4sQ8yrGYcRrgBFFy6+lF/25+Ojpn+m21gi/vlonAug6xIPbrES9QU0jkKwuVa+f2oT9YjqVFIV1S4v/IRKbOwYLRNTRa0P4r1jfkou//UXTTSfvLf4usQ44+MoZUNYzkx6WVBeaKmOab/qtlmBw5/TvniWSDhDlkM8INuZfBess99OnRFM0wERrG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyp459148SrYm4Ux1/X504RzMz8LokT3Tx/dOCZxtOo=;
 b=hSkkjB0wX/cHQ3XxyER8hVmQ+OV0CyiHDAXodF2CCQU6yUebHhKZLMXnGcpDYMdZ08QHjmmhXB63gLZMB/iEowLilQFO3rxhhvXebBztw75y3OKtJMTjNevanqOAlwjueWqfzm3AwEYuRcV62sraarFjfyGM1fnUSxHprNjhtlV2xnrg51ygv6V3cqaODCLzG9OhbExYda+b5yO474oaLtU9Yru/VUtQ46DI43c/LAs6Jg49TDmxvAlEo/9V/nYOZT2AJeGFkEAjOHp15jOYSIEe7iszZmHchXvnra9PsIFtS6GiCunQkAT6LfASI2pVd/ZHpwtQoll/xzzApVF8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyp459148SrYm4Ux1/X504RzMz8LokT3Tx/dOCZxtOo=;
 b=FzrGkwjZXazNz7X7pLF8V1LcKOHsdzkkcZcuuSO20+mISg2ymt1aa15zDC2WPlThGG+0lTpe44BxoNPXXqWkFM/tr9USazWTAB8sRKsvg1D5jP0VTEsjKFTlmCTwgHWqZDSfsKTSFQ1z2hZHcrcEFnZFNC3SPPL5X1iS/mue6tM=
Received: from PH0PR07CA0057.namprd07.prod.outlook.com (2603:10b6:510:e::32)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 23:28:00 +0000
Received: from PH7PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::3c) by PH0PR07CA0057.outlook.office365.com
 (2603:10b6:510:e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 23:28:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000009.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:28:00 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:27:56 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 17:27:37 -0600
Subject: [PATCH v12 10/12] drm/gud: add connector luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-superm1-backlight-property-v12-10-89d5217d3618@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF00000009:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1f6e5e-a86f-4d1c-848f-08df4694c05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|18002099003|6133799003|261009223027099003|22082099003|3023799007|921020|11063799006|56012099006|261021123027099003|261102123227099003|261022105027099003|261026140227099003|261022115727099003|261022075727099003|261026121527099003|261021121427099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: vy2cncClWMdkwVaxP1Al4uQCmOrIOl856jGkesWbwhY5hozNWlTehCVjjKsiIsTnMprfoUaNzYqhIX8P5RNjpzYFZL1aDgfGO+LL0Rd8RRN65rHpyZmU7MOVSfwEOO06YuzlfWlXIFHfPtdLmdFJ8bbpuKezy3XrlDl2/TMnedZP9pbBo5ye6H50cCtfsUWezz53n0NuI4Cli+3zOXxuG3FMLZf98JHwGLLC9FdvDwcFjkY3YDR5D86jugeArPZYaW074v2WoWZUTGTL4nfnio9P9i4IOiseU4xzimdj8xJL/wyGJr39SiHGwKLrrfS46LPnPDlsOWymsXz1T8I/NJUfHARM5BysSzwGTHzzHZ8axYLy5A5hY5Uqo4ZKiL1gs8t5MqoeQgFOTiA7rt0Evp6P1PMbolBD349UqJrhalg9tn95SUna+FERS+7+Gseqhxzod4W7J7BMNgdvK6a3xKVSy4VW9VEk0kNs325c00RhR07YBuKv4Cnm+DGvuBAY+GU0pSPfn58t0dPNU4DZ8knRmCKDmJUsVFmPPBzUnS5gqlg8tPuCGcZ+gLHESLLzRNzR9ysmYxQ+epoVY/HF6kgCb/h3mhEJcjWI5AKZaZoocHJlp5kq9E4PGbBeJTKkhiFJ+uxFbwmHMeXXjPruiX/R6XWwmKp//a6lRp7sosJazZ92NAhj+hTxIm/EHNJjgSjIpEl7SpCixOMAvs9QMiJqILUrNHz3K5QWfiRbWJuxDUoOUB1O8flH+67EbIyg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(18002099003)(6133799003)(261009223027099003)(22082099003)(3023799007)(921020)(11063799006)(56012099006)(261021123027099003)(261102123227099003)(261022105027099003)(261026140227099003)(261022115727099003)(261022075727099003)(261026121527099003)(261021121427099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6VqpEbVq+ael8LXeRjN9Ukm3YZ1NIxHAjbvZqCdHY2A4QSOCjaXlRnLn2NMPQ46eJwunsYEV6DsqsPYWlJepsV4PVzNsRmHUO1pU5G9GrxVmNlquDlOuNUXpU0MRYMjuwKkoy5eZRo9qpMirbeXkXV9GjDm9IOkuODflDNkNH+d7F+PdzzWN8OkhhSSrvuuQQ6iPC4+3HSqK/ndce7oeMbJwffX3PNPS/cypupB5jAcE3oCqj7IkyEiWEvqWmjCnrgGlU4mmJTIoPY1GHMhYk8sYUFXGREW1EefGupd+6qHsZt4BrTcVR4AJyQFo3rrgcmuqJ7Z5jRGQu6eccHQj6JmSEwQtlg3zEpHzFy1b398yIRPK4wguNr1juQrNEEEZRn5DEL1sYLk2wm5Wl11kBg9/i0kt1anGeTGHI+ZlifMpT7zbejETLn5g8P/KbTC6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:28:00.5178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1f6e5e-a86f-4d1c-848f-08df4694c05d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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

Expose GUD display brightness through the connector LUMINANCE property
when DRM_LUMINANCE is enabled.

The device receives brightness as part of its display state and the
protocol has no dedicated brightness request. The backlight class device
works around that with a full modeset, which userspace can't rely on for a
connector property since commits without DRM_MODE_ATOMIC_ALLOW_MODESET
would be rejected. Send the committed luminance with the state check
during a modeset, and for a luminance-only commit resend the current
configuration with the new value and apply it with a state commit.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v12:
 * Resend the display state with the new luminance from .set_luminance
   and apply it, instead of mirroring LUMINANCE into tv.brightness in
   atomic check which forced a modeset and rejected commits without
   DRM_MODE_ATOMIC_ALLOW_MODESET (Sashiko)
v11:
 * Apply LUMINANCE in the atomic commit instead of a worker, fixing an
   endless commit loop, a use-after-free on disconnect and brightness
   being clobbered on DPMS off (Sashiko)
 * Attach the property at connector init (Sashiko)
 * Keep selecting BACKLIGHT_CLASS_DEVICE (Sashiko)
---
 drivers/gpu/drm/gud/gud_connector.c |  61 ++++++++++++++--
 drivers/gpu/drm/gud/gud_internal.h  |   5 +-
 drivers/gpu/drm/gud/gud_pipe.c      | 136 ++++++++++++++++++++----------------
 3 files changed, 134 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index ddbf3b3ebbca8..f00272f030c1c 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -13,6 +13,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -314,17 +315,52 @@ static int gud_connector_atomic_check(struct drm_connector *connector,
 	return 0;
 }
 
+/*
+ * The device receives brightness as part of its display state, there is no
+ * dedicated request. Resend the current configuration with the new luminance
+ * and apply it, so that a luminance change doesn't need a modeset.
+ */
+static void gud_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_connector *connector = conn_state->connector;
+	struct gud_device *gdrm = to_gud_device(connector->dev);
+	struct drm_crtc_state *crtc_state = conn_state->crtc->state;
+	struct drm_plane_state *plane_state = gdrm->plane.state;
+	int idx, ret;
+
+	/*
+	 * gud_plane_atomic_check() sent the committed luminance with
+	 * GUD_REQ_SET_STATE_CHECK for these changes and gud_crtc_atomic_enable()
+	 * applied it. A modeset that only changed the active state didn't.
+	 */
+	if (crtc_state->mode_changed || crtc_state->connectors_changed)
+		return;
+
+	if (drm_WARN_ON_ONCE(connector->dev, !plane_state->fb))
+		return;
+
+	ret = gud_state_check(gdrm, &crtc_state->mode, plane_state->fb->format,
+			      plane_state->rotation, conn_state);
+	if (!ret && drm_dev_enter(connector->dev, &idx)) {
+		ret = gud_usb_set(gdrm, GUD_REQ_SET_STATE_COMMIT, 0, NULL, 0);
+		drm_dev_exit(idx);
+	}
+	if (ret)
+		gud_conn_err(connector, "Failed to set luminance", ret);
+}
+
 static const struct drm_connector_helper_funcs gud_connector_helper_funcs = {
 	.detect_ctx = gud_connector_detect,
 	.get_modes = gud_connector_get_modes,
 	.atomic_check = gud_connector_atomic_check,
+	.set_luminance = gud_connector_set_luminance,
 };
 
 static int gud_connector_late_register(struct drm_connector *connector)
 {
 	struct gud_connector *gconn = to_gud_connector(connector);
 
-	if (gconn->initial_brightness < 0)
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE) || gconn->initial_brightness < 0)
 		return 0;
 
 	return gud_connector_backlight_register(gconn);
@@ -593,10 +629,12 @@ static int gud_connector_add_properties(struct gud_device *gdrm, struct gud_conn
 	return ret;
 }
 
-int gud_connector_fill_properties(struct drm_connector_state *connector_state,
+int gud_connector_fill_properties(const struct drm_connector_state *connector_state,
 				  struct gud_property_req *properties)
 {
-	struct gud_connector *gconn = to_gud_connector(connector_state->connector);
+	struct drm_connector *connector = connector_state->connector;
+	struct gud_connector *gconn = to_gud_connector(connector);
+	struct drm_tv_connector_state tv = connector_state->tv;
 	unsigned int i;
 
 	for (i = 0; i < gconn->num_properties; i++) {
@@ -604,12 +642,16 @@ int gud_connector_fill_properties(struct drm_connector_state *connector_state,
 		u64 val;
 
 		if (prop == GUD_PROPERTY_BACKLIGHT_BRIGHTNESS) {
-			val = connector_state->tv.brightness;
+			/* The backlight device reuses tv.brightness to avoid subclassing */
+			if (connector->luminance_property)
+				val = connector_state->luminance;
+			else
+				val = tv.brightness;
 		} else {
 			unsigned int *state_val;
 
-			state_val = gud_connector_tv_state_val(prop, &connector_state->tv);
-			if (drm_WARN_ON_ONCE(connector_state->connector->dev, IS_ERR(state_val)))
+			state_val = gud_connector_tv_state_val(prop, &tv);
+			if (drm_WARN_ON_ONCE(connector->dev, IS_ERR(state_val)))
 				return PTR_ERR(state_val);
 
 			val = *state_val;
@@ -699,6 +741,13 @@ static int gud_connector_create(struct gud_device *gdrm, unsigned int index,
 		return ret;
 	}
 
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE) && gconn->initial_brightness >= 0) {
+		ret = drm_connector_attach_luminance_property(connector, 0, 100,
+							      gconn->initial_brightness);
+		if (ret)
+			return ret;
+	}
+
 	gconn->encoder.possible_crtcs = drm_crtc_mask(&gdrm->crtc);
 	ret = drm_encoder_init(drm, &gconn->encoder, &gud_drm_simple_encoder_funcs_cleanup,
 			       DRM_MODE_ENCODER_NONE, NULL);
diff --git a/drivers/gpu/drm/gud/gud_internal.h b/drivers/gpu/drm/gud/gud_internal.h
index 95744b0b6c727..5b1430f93f555 100644
--- a/drivers/gpu/drm/gud/gud_internal.h
+++ b/drivers/gpu/drm/gud/gud_internal.h
@@ -70,7 +70,10 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 			   struct drm_atomic_commit *state);
 void gud_plane_atomic_update(struct drm_plane *plane,
 			     struct drm_atomic_commit *atomic_state);
-int gud_connector_fill_properties(struct drm_connector_state *connector_state,
+int gud_state_check(struct gud_device *gdrm, const struct drm_display_mode *mode,
+		    const struct drm_format_info *format, unsigned int rotation,
+		    const struct drm_connector_state *connector_state);
+int gud_connector_fill_properties(const struct drm_connector_state *connector_state,
 				  struct gud_property_req *properties);
 int gud_get_connectors(struct gud_device *gdrm);
 
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 5aa5ac2f37274..638b94f55733b 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -450,6 +450,77 @@ static void gud_fb_handle_damage(struct gud_device *gdrm, struct drm_framebuffer
 	gud_flush_damage(gdrm, fb, src, !drm_gem_is_imported(fb->obj[0]), damage);
 }
 
+/*
+ * Send the display configuration to the device with GUD_REQ_SET_STATE_CHECK,
+ * a following GUD_REQ_SET_STATE_COMMIT applies it.
+ */
+int gud_state_check(struct gud_device *gdrm, const struct drm_display_mode *mode,
+		    const struct drm_format_info *format, unsigned int rotation,
+		    const struct drm_connector_state *connector_state)
+{
+	struct drm_device *drm = &gdrm->drm;
+	unsigned int i, num_properties;
+	struct gud_state_req *req;
+	int idx, ret;
+	size_t len;
+
+	if (format->format == DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulation_format)
+		format = gdrm->xrgb8888_emulation_format;
+
+	len = struct_size(req, properties,
+			  size_add(GUD_PROPERTIES_MAX_NUM, GUD_CONNECTOR_PROPERTIES_MAX_NUM));
+	req = kzalloc(len, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	gud_from_display_mode(&req->mode, mode);
+
+	req->format = gud_from_fourcc(format->format);
+	if (drm_WARN_ON_ONCE(drm, !req->format)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	req->connector = drm_connector_index(connector_state->connector);
+
+	ret = gud_connector_fill_properties(connector_state, req->properties);
+	if (ret < 0)
+		goto out;
+
+	num_properties = ret;
+	for (i = 0; i < gdrm->num_properties; i++) {
+		u16 prop = gdrm->properties[i];
+		u64 val;
+
+		switch (prop) {
+		case GUD_PROPERTY_ROTATION:
+			/* DRM UAPI matches the protocol so use value directly */
+			val = rotation;
+			break;
+		default:
+			drm_WARN_ON_ONCE(drm, 1);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		req->properties[num_properties].prop = cpu_to_le16(prop);
+		req->properties[num_properties].val = cpu_to_le64(val);
+		num_properties++;
+	}
+
+	if (drm_dev_enter(drm, &idx)) {
+		len = struct_size(req, properties, num_properties);
+		ret = gud_usb_set(gdrm, GUD_REQ_SET_STATE_CHECK, 0, req, len);
+		drm_dev_exit(idx);
+	} else {
+		ret = -ENODEV;
+	}
+out:
+	kfree(req);
+
+	return ret;
+}
+
 int gud_plane_atomic_check(struct drm_plane *plane,
 			   struct drm_atomic_commit *state)
 {
@@ -458,16 +529,13 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_crtc *crtc = new_plane_state->crtc;
 	struct drm_crtc_state *crtc_state = NULL;
-	const struct drm_display_mode *mode;
 	struct drm_framebuffer *old_fb = old_plane_state->fb;
 	struct drm_connector_state *connector_state = NULL;
 	struct drm_framebuffer *fb = new_plane_state->fb;
 	const struct drm_format_info *format;
 	struct drm_connector *connector;
-	unsigned int i, num_properties;
-	struct gud_state_req *req;
-	int idx, ret;
-	size_t len;
+	unsigned int i;
+	int ret;
 
 	if (crtc)
 		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
@@ -488,7 +556,6 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	if (old_plane_state->rotation != new_plane_state->rotation)
 		crtc_state->mode_changed = true;
 
-	mode = &crtc_state->mode;
 	format = fb->format;
 
 	if (old_fb && old_fb->format != format)
@@ -501,9 +568,6 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	if (hweight32(crtc_state->connector_mask) != 1)
 		return -EINVAL;
 
-	if (format->format == DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulation_format)
-		format = gdrm->xrgb8888_emulation_format;
-
 	for_each_new_connector_in_state(state, connector, connector_state, i) {
 		if (connector_state->crtc)
 			break;
@@ -530,58 +594,8 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	if (drm_WARN_ON_ONCE(plane->dev, !connector_state))
 		return -ENOENT;
 
-	len = struct_size(req, properties,
-			  size_add(GUD_PROPERTIES_MAX_NUM, GUD_CONNECTOR_PROPERTIES_MAX_NUM));
-	req = kzalloc(len, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	gud_from_display_mode(&req->mode, mode);
-
-	req->format = gud_from_fourcc(format->format);
-	if (drm_WARN_ON_ONCE(plane->dev, !req->format)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	req->connector = drm_connector_index(connector_state->connector);
-
-	ret = gud_connector_fill_properties(connector_state, req->properties);
-	if (ret < 0)
-		goto out;
-
-	num_properties = ret;
-	for (i = 0; i < gdrm->num_properties; i++) {
-		u16 prop = gdrm->properties[i];
-		u64 val;
-
-		switch (prop) {
-		case GUD_PROPERTY_ROTATION:
-			/* DRM UAPI matches the protocol so use value directly */
-			val = new_plane_state->rotation;
-			break;
-		default:
-			drm_WARN_ON_ONCE(plane->dev, 1);
-			ret = -EINVAL;
-			goto out;
-		}
-
-		req->properties[num_properties].prop = cpu_to_le16(prop);
-		req->properties[num_properties].val = cpu_to_le64(val);
-		num_properties++;
-	}
-
-	if (drm_dev_enter(fb->dev, &idx)) {
-		len = struct_size(req, properties, num_properties);
-		ret = gud_usb_set(gdrm, GUD_REQ_SET_STATE_CHECK, 0, req, len);
-		drm_dev_exit(idx);
-	}  else {
-		ret = -ENODEV;
-	}
-out:
-	kfree(req);
-
-	return ret;
+	return gud_state_check(gdrm, &crtc_state->mode, format, new_plane_state->rotation,
+			       connector_state);
 }
 
 void gud_crtc_atomic_enable(struct drm_crtc *crtc,

-- 
2.43.0

