Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3C60A263B
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EDoswsbS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87DC51127D0;
	Thu, 19 Nov 2026 23:28:10 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5D910E071;
 Thu, 19 Nov 2026 23:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSAIg/BOR5xkBxVdGtqmZTiEt8zTmDvpNqNyas7i/1+KmGZDRNjTOtvX/+0gbrmxGpPYPJ1gW9C9I3OkNwTHZl9R3o2CvnGK/JI6ySy8bk6J1z3kRajlv8+tX/qB90EDOjwjc7jUsAnWpXjFfDZbU8IjvHDvJ4q5pNpBwhY8vNeu8vb97YNIgUz9nZ/G7Z5BwTpy0OTDgtPcGeFszz3RC4LRoqKAbg2PdBrT83mq8+F3m8jWiWrC8dcsXrov+1Xz0k/habBVD4YkR6YYQzpQR8QAnw5UiJ8q3peCs0rXv2gcLsLKc/rf1NQUL7TsKTq+jp1w60qKhWFQh6+Iof16Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OYgJybG4FW3tJBnFrBkzQMca/Hpd3EtbC6Qsv+IUGg=;
 b=ewGeMkMW6xVHhJuUmFLri80W9RxfTFiP6Y1wYcJaV5ilJNC4kCuyz6feokzc5oZ92eN1zC5CkbKD0X7d4dnLebThXGouFy4uvKZFxoCw2rA1lJUsl07a0qnFdwYkTFVuCiJoJB4tJLC0tyefAAEh8ARA3xm3pvpFtZQwrpHBa2nz9+yzRHwFs2xA6o62SNhsSEoXSR6S2Z+kTJcvYrlHXGlf0NgBpItqWkIU5SyIFgp0v8Ms+NvlyQhTzbBTLoiDQy3S/uKaG8zkuX09mRpbH85AZT74bGkedbWhC580YeaDkhm4flfr2XImBzMGHlC92ULX+zq40/t6qnR/v4OK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OYgJybG4FW3tJBnFrBkzQMca/Hpd3EtbC6Qsv+IUGg=;
 b=EDoswsbSIWb5W8AfsxvQju/h4bSDCQZZb5KO+klhuvT884L9bNRcE04pU9XaIlk8jv6yQlCfuA1maxEJTRDVYK46a/16qILYHk2rYyRVKVx7VnjY0IzMmgWwGbUOrJRCOUZIuWl8dSiDHzfnavYHMTgEPyCgp7KbLHa/G4veGbc=
Received: from SJ0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:a03:333::7)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 23:27:53 +0000
Received: from PH7PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::3b) by SJ0PR03CA0092.outlook.office365.com
 (2603:10b6:a03:333::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 19
 Nov 2026 23:27:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF0000000B.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:27:53 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:27:51 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 17:27:34 -0600
Subject: [PATCH v12 07/12] drm/panel: add connector luminance forwarding
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-superm1-backlight-property-v12-7-89d5217d3618@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000B:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6123ea-4c93-4a9e-4217-08df4694bc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|7416014|82310400026|376014|921020|10067099003|11063799006|56012099006|261026121527099003|261028144727099003|261026140227099003|261022075727099003|261021121427099003|261102123227099003|261022105027099003|261102130727099003|261009223027099003|261009221227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: cFbd1MZXz97cJzgxBz6SPrlJaFeOVdcIKkKHs54WMyyVB3gr3FqEwcmDoKii09xpGCjmqlcHXI85kNMgUCPQqoS8rKCGChXh3qsRqzYCmHFkny5d9IoZAwDFOL/Iz4NOdr+9qP+lcx6IiZIjedh2g8l4pewVezEZQ2jJidrqiB7U3UpPLiuHUBa9YnriTlPwNYA4BOo3Kk9hB28zSQHvYjJSapexraH+FzhRvFuKveM9qh0SMEv8NRpF7KpsBgVotavtzPlC+2Y73vHJGsui4hDdcya0p4yliXJaubsr2SDojj4va+duyeVtRO8GqBfFrbywkPnOZFvOrDvti/IYK2fWXZeTMjTxkZnJ6zDzdvsryrZEv6awlXBOExbbQKO6Km8675e+cIxzY/Kfe4P3iuuEUufQdaHrMT4LPK1mOxq/Tsl9knQE5ZaPxhj4JgdWlycnWNC5gJ6kSVdC3BGXnN8KrTZjRfI4sYzX8yVfaVbi4z2X8DzKVsahaRbacdd2RbuBX+J/Prldtq07iAYehFXJvawcHvPCY4pd4JNrggNhe5YJWUrVHJuQ0/3JoPAstZ/H3wlMUhU3/Aknjr996dIOc8oaHy/Y3+l70oQw3x0gIIhNquF7ukT+YlmPj4Od1ZQoXgM+6ui1RmEd7SUjWHDWyUrpTEsh3i+1GX/1ylr9MNprYciwhd5jHSEyogleDPhn3Kfx8Aq4xFfhqdfYsp1XEvCBC1uNwmEr9WGUumdPan0MkU9wKW00VXSh3vlL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(7416014)(82310400026)(376014)(921020)(10067099003)(11063799006)(56012099006)(261026121527099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021121427099003)(261102123227099003)(261022105027099003)(261102130727099003)(261009223027099003)(261009221227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8P+/hTXZjwMR02KvPUndHCwpvfeDCTqsgAXXRNpZ3Lho734GoAFfEwlL53kuisK4HYV/+XpOjIm99ytosEPcWEqnS7axsTkJA3Ys7zUfupMRrVlTV+3l0TSlsGCAujSaL1mtYO/3yAn3rjvgEZtqqTTl7wFYPlkr6xrwA+90MxO3SBvwQQKRgR4gklPxLUWgJgSAPvPVRpQKCFwYy+VH7VQ/g35sAbBwQVs21C48c+XOdVa8zvYJ27h/MzCc472XzYYCGYiT9f61H8+wP3VtnQJJugyKtsKHH4LFMSK5opFLUZUBxPvSRQBSIWr0zHY3i0dOZnNbgKVenkZqalF6BJtd7P84u59rtPXay9HHdi/8vAi7LAmXTkMpGQiZkYO9tXwHoNaxaRJhR0Y4J4iLbzJrs6v9s3g+BvHjy6uVLst9/f4jkkavxkVH1GDdkI+r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:27:53.4838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6123ea-4c93-4a9e-4217-08df4694bc2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705
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

Add helpers that expose a panel backlight through the connector
LUMINANCE property and forward connector updates to the backlight
backend.

Hook the helpers into panel bridges that create their own connector.
Panels consumed directly, or by a panel bridge attached with
DRM_BRIDGE_ATTACH_NO_CONNECTOR, remain unchanged. Turning the backlight
on and off is left to drm_panel_enable() and drm_panel_disable(), which
already honour self refresh.

The panel backlight remains the hardware backend and keeps its
/sys/class/backlight device, which is owned by the backlight driver.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

---
v12:
 * Only store the brightness while the panel is disabled, leaving the
   hardware update to backlight_enable() in drm_panel_enable(), and skip
   the update when the brightness is unchanged (Sashiko)
 * Clamp the initial brightness to the maximum before attaching the
   property
 * Add tag
v11:
 * Don't remove drm_panel.h stubs (rebase artifact, Sashiko)
 * Use drm_connector_to_panel() rather than an invalid panel_bridge
   container_of() (Sashiko)
 * Clean up the connector if attaching the property fails (Sashiko)
 * Drop .disable_luminance and program the committed level before
   drm_panel_enable() (Sashiko)
 * Don't attach the property when the panel bridge is attached after the
   device is registered, which would WARN
 * Update brightness under the backlight ops_lock
v10:
 * Split panel support out of the combined panel and bridge patch
 * Limit integration to panel bridges that own their connector
---
 drivers/gpu/drm/drm_panel.c | 98 +++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_panel.h     |  4 ++
 2 files changed, 102 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 74c96da45b7a5..1a08351b2ef77 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -64,9 +64,18 @@ static int panel_bridge_connector_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(panel, connector);
 }
 
+static void
+panel_bridge_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_panel *panel = drm_connector_to_panel(conn_state->connector);
+
+	drm_panel_set_luminance(panel, conn_state->luminance);
+}
+
 static const struct drm_connector_helper_funcs
 panel_bridge_connector_helper_funcs = {
 	.get_modes = panel_bridge_connector_get_modes,
+	.set_luminance = panel_bridge_connector_set_luminance,
 };
 
 static const struct drm_connector_funcs panel_bridge_connector_funcs = {
@@ -101,6 +110,12 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 
 	drm_panel_bridge_set_orientation(connector, bridge);
 
+	ret = drm_panel_attach_luminance_property(panel, connector);
+	if (ret) {
+		drm_connector_cleanup(connector);
+		return ret;
+	}
+
 	drm_connector_attach_encoder(connector, encoder);
 
 	if (bridge->dev->registered) {
@@ -169,6 +184,19 @@ static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (old_crtc_state && old_crtc_state->self_refresh_active)
 		return;
 
+	/*
+	 * Store the committed luminance before drm_panel_enable() turns the
+	 * backlight on, so the panel does not light up at a stale level.
+	 */
+	if (panel->connector.luminance_property) {
+		const struct drm_connector_state *conn_state =
+			drm_atomic_get_new_connector_state(atomic_state,
+							   &panel->connector);
+
+		if (conn_state)
+			drm_panel_set_luminance(panel, conn_state->luminance);
+	}
+
 	drm_panel_enable(panel);
 }
 
@@ -873,6 +901,76 @@ void drm_panel_disable(struct drm_panel *panel)
 }
 EXPORT_SYMBOL(drm_panel_disable);
 
+/**
+ * drm_panel_attach_luminance_property - expose a panel backlight through DRM
+ * @panel: panel whose backlight is controlled
+ * @connector: connector on which to expose the property
+ *
+ * The backlight class device remains the internal hardware backend. When the
+ * luminance UAPI is enabled, userspace controls that backend through the DRM
+ * connector property instead.
+ *
+ * Return: 0 on success or a negative error code
+ */
+int drm_panel_attach_luminance_property(struct drm_panel *panel,
+					struct drm_connector *connector)
+{
+	struct backlight_device *backlight;
+
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE) || !panel)
+		return 0;
+
+	backlight = panel->backlight;
+	if (!backlight)
+		return 0;
+
+	/* Properties can't be created once the device is visible to userspace */
+	if (connector->dev->registered) {
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] registered, not exposing luminance\n",
+			    connector->base.id, connector->name);
+		return 0;
+	}
+
+	/* The backlight core doesn't clamp a driver seeded brightness */
+	return drm_connector_attach_luminance_property(connector, 0,
+					backlight->props.max_brightness,
+					min(backlight->props.brightness,
+					    backlight->props.max_brightness));
+}
+EXPORT_SYMBOL(drm_panel_attach_luminance_property);
+
+/**
+ * drm_panel_set_luminance - set a panel backlight's relative luminance
+ * @panel: panel whose backlight is controlled
+ * @luminance: relative luminance level
+ *
+ * Updates the backlight brightness without changing its power state, under
+ * the same lock as brightness changes made through sysfs. Turning
+ * the backlight on and off is left to drm_panel_enable() and
+ * drm_panel_disable(). While the panel is disabled only the brightness is
+ * stored, so the hardware is not touched before the panel's enable sequence
+ * has completed, and the level is applied when the panel is enabled again.
+ */
+void drm_panel_set_luminance(struct drm_panel *panel, unsigned int luminance)
+{
+	struct backlight_device *backlight;
+
+	if (!panel || !panel->backlight)
+		return;
+
+	backlight = panel->backlight;
+	guard(mutex)(&backlight->ops_lock);
+	if (!backlight->ops || luminance > backlight->props.max_brightness ||
+	    backlight->props.brightness == luminance)
+		return;
+
+	backlight->props.brightness = luminance;
+	if (panel->enabled)
+		backlight_update_status(backlight);
+}
+EXPORT_SYMBOL(drm_panel_set_luminance);
+
 /**
  * drm_panel_get_modes - probe the available display modes of a panel
  * @panel: DRM panel
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 58113ea7d63a0..233d30dd2e182 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -342,6 +342,10 @@ void drm_panel_unprepare(struct drm_panel *panel);
 void drm_panel_enable(struct drm_panel *panel);
 void drm_panel_disable(struct drm_panel *panel);
 
+int drm_panel_attach_luminance_property(struct drm_panel *panel,
+					struct drm_connector *connector);
+void drm_panel_set_luminance(struct drm_panel *panel, unsigned int luminance);
+
 int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector);
 
 #if defined(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL)

-- 
2.43.0

