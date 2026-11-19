Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C3060A2610
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=a2Ibs7bC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB7F1127A1;
	Thu, 19 Nov 2026 23:28:16 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B571127B0;
 Thu, 19 Nov 2026 23:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGPvBTpiaY/ZvlcZOALdPHe5aTtuJiVZSHagI98a5zyPP68OsefnniPIXkDp36MwRXyI0uV8af3wNr3NcGHLNw9ErrfXDueFxeaNRnmIwirZRE3nM/pkyXW5Q4p8MDhaUbDcI2FctpM0VPEtiXO5vi4ImZpXqUZXldKrMN26tFpX4SJCA0qHDo2Id2RI4u569wC/erBCTAV7dcCK4E7zM8npnPyOLnnFPStC8x/4S99p7mEJ9z23t4yRTlIha0DyBteXkOyiaJHsqUlR07bNBZRB7TeFtJaGF2ixlzkhQRKQftaT75+39rRn3nIYNEOJWOVXbEqPyhrWm+XEwuGc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmALSz1tQg45Bc8RLLs4T3tVtjMmHUN0F91rav6jkiQ=;
 b=hXoBs+Q9/qARIjzwZ6TsXz0jz9e17G7IUG/yhdzzRxySqKEcVWJWwc5J3KVZu6T3KTFm/2/fQaiDNvyTdQPoI139pQgW58ukt5Q1fZuoliKAj7y/BAhDubTWBSu1ZCHuJ2/zLQw57ylcrjon+yH+cSl6J0kKus01AZz+Mlr28XwnXmhFPQg6dW5iZXTLdHYcVb14uZZsJWrmcoxMGXeOvwUBcMKlDHmKBX3f0bXDhaHFS++eNKEtSrPNBq3S+iRrDAcYfZWxnRo8u6Sr80uUvlv6QKmGz6+bFdCvfmH1zf4H2LtzgIF5j5lldP+U2bIt5Ty9m9B9G2Tgb4evscp2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmALSz1tQg45Bc8RLLs4T3tVtjMmHUN0F91rav6jkiQ=;
 b=a2Ibs7bCFhp0fHScMYxZhY+tE+F7w6+9cL22aqswiEgFrJ4eRXCE+ND0PLcwgCgVB7eG2ntaDkoEMaYYPFzYou0peFpOJReOk1JobcEVv6W4huifBB7gWH5e+eubVF4tUcgUmNJvtpQbeuG4ME9VAj87NY0erGi945z8fnpCXDA=
Received: from PH0PR07CA0057.namprd07.prod.outlook.com (2603:10b6:510:e::32)
 by CC6PR12MB259526.namprd12.prod.outlook.com (2603:10b6:170:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 23:28:01 +0000
Received: from PH7PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::22) by PH0PR07CA0057.outlook.office365.com
 (2603:10b6:510:e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 23:28:01 +0000
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
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:28:01 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:27:58 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 17:27:38 -0600
Subject: [PATCH v12 11/12] drm/bridge: add PS8622 connector luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-superm1-backlight-property-v12-11-89d5217d3618@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF00000009:EE_|CC6PR12MB259526:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a6c6ce-dabe-43aa-bcea-08df4694c0d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|7416014|376014|36860700016|1800799024|6133799003|22082099003|18002099003|11063799006|921020|261022075727099003|261026140227099003|261022105027099003|261028144727099003|56012099006|10067099003|261009220027099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261009221227099003|261009221727099003|261102123227099003|261009223327099003;
X-Microsoft-Antispam-Message-Info: d/RWodFP89n1PQPy/DjbYuFHOakENC4BHoDvxznKM062vX+uwd/p36YzNHsSQoSr7RbqVFEZO5Gzn5iWfhOnRVLHgYDdIRYSz0Af65MoCC4AByI4AQTAaYJk6zgN54TwiyNJTMFY9Ov7qz/FJ8I7EZ1y7svZfkj6sOleAtn148XhHrrVRGgUnkQ2dA53xZ0VmmTNhHcy7otcub/oUeFpAc23p0ysEVZnvTZERD8tiBaNPcEWC97zmJnCXwR5LlMkCUnCXdtkwhfSCWWMTdHzCCuzZEfKyghkosYwX6risAAw/xclQ/j/BleV17+SAoTSd+QBiTimFJzYUWocbSc/IXdXFhxFVhuUfjJUd7JVFP1bV2sCWkvTXrjLiBxiqmse7VZOxs8/5qNUIGx0gwW+kFsbKuuwinPe0Q85SkvIW8SJ+YNbXUOBstEjyS8LWLcMEOFZgGUmuY8zMHVAC3nu5V3B43FG32Lh95kNEoY90z7ms0Qh26gH1ejmD6CWZkinddsuuyOGFeR4YYR091ozVdNwEeY49z3HsXW5KJjr7OP2qH+7ZlQKeJO0fzjcCRRyXYv+F0L4vq2ddmft4lM/lJDSFP6WmSxT7BHc9kPDjns4pmQA0xA3Upui1SuIkCxZEmDdq5JpN+b57TH038ilZTjCGbc9X22auIIXJIPB4QeFBsvinneSFL8IKAqsVlRbT4ytfiACHcrOKKziIHetaK682dampeX/9zyU6oBHbjaE9QbuUtWKowA3kM3+BXbV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(921020)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(261009220027099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003)(261009221727099003)(261102123227099003)(261009223327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6cnDeRlPBETB0SwEERzzPHr+ss7U+Vo5f8yig8hUIoejoCCoXz0joK9dBFt3H74i1RqCnEjMEuekHA+rRfgqhkn4w9QBjM4xo+zLRwGX9Ovp5S3zjA6duX3trodMNs38KHlLH1SyStuD7omNyZdAPqZChDeo0EgkbM5tHo1OhCD2Tv/c7Fz2WzxLPmApN5b04xk/1nY5k8a9LzukV/Aws2tBEhOBPfTPWW+/rJFQbHFG0ckso6Tjw+H6c4uvHyEp8Ok/cOe7FlHewCINYMjeyymj5clrDZIfZmeJV8ZP5z7hua8SnAKrQZKf9wiJWakmVtO3VD1nom0piJPMAfdzDTwfG0ZWIyiEBet29ay3C4qTuzcc+3Oz94lAUgGTAvLYyvZQZYiR0uh58gtSFpr7j36iXwkbucSzkxeMLL2gukX2gQy3+lFDgR05WJ8GUhGJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:28:01.3206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a6c6ce-dabe-43aa-bcea-08df4694c0d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR12MB259526
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

Expose PS8622 brightness through bridge luminance operations when
DRM_LUMINANCE is enabled. Keep registering the backlight class device
otherwise.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

---
v12:
 * Keep restoring the backlight class device brightness from its
   properties, a blanked backlight clobbered the cached level while the
   bridge was disabled (Sashiko)
 * Add tag
v11:
 * Track internal PWM mode explicitly so it is still configured with
   LUMINANCE (Sashiko)
 * Don't access I2C while the bridge is powered down (Sashiko)
 * Keep selecting BACKLIGHT_CLASS_DEVICE (Sashiko)
 * Program the committed luminance in pre_enable
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 66 +++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 3a2ec482037df..02ef66c9044f6 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -45,6 +45,9 @@ struct ps8622_bridge {
 	struct drm_bridge *panel_bridge;
 	struct regulator *v12;
 	struct backlight_device *bl;
+	/* Committed luminance, only used without a backlight class device */
+	u8 brightness;
+	bool internal_pwm;
 
 	struct gpio_desc *gpio_slp;
 	struct gpio_desc *gpio_rst;
@@ -268,7 +271,7 @@ static int ps8622_send_config(struct ps8622_bridge *ps8622)
 		goto error;
 
 
-	if (ps8622->bl) {
+	if (ps8622->internal_pwm) {
 		/* DPCD720, internal PWM */
 		err = ps8622_set(cl, 0x01, 0xa5, 0xa0);
 		if (err)
@@ -276,7 +279,8 @@ static int ps8622_send_config(struct ps8622_bridge *ps8622)
 
 		/* FFh for 100% brightness, 0h for 0% brightness */
 		err = ps8622_set(cl, 0x01, 0xa7,
-				ps8622->bl->props.brightness);
+				ps8622->bl ? ps8622->bl->props.brightness :
+					     ps8622->brightness);
 		if (err)
 			goto error;
 	} else {
@@ -332,6 +336,20 @@ static int ps8622_backlight_update(struct backlight_device *bl)
 	return ret;
 }
 
+static void ps8622_set_luminance(struct drm_bridge *bridge,
+				 unsigned int luminance)
+{
+	struct ps8622_bridge *ps8622 = bridge_to_ps8622(bridge);
+
+	ps8622->brightness = luminance;
+
+	/* Applied by ps8622_send_config() on the next pre_enable */
+	if (!ps8622->enabled)
+		return;
+
+	ps8622_set(ps8622->client, 0x01, 0xa7, luminance);
+}
+
 static const struct backlight_ops ps8622_backlight_ops = {
 	.update_status	= ps8622_backlight_update,
 };
@@ -340,11 +358,22 @@ static void ps8622_pre_enable(struct drm_bridge *bridge,
 			      struct drm_atomic_commit *commit)
 {
 	struct ps8622_bridge *ps8622 = bridge_to_ps8622(bridge);
+	struct drm_connector *connector;
 	int ret;
 
 	if (ps8622->enabled)
 		return;
 
+	/* Program the committed luminance from ps8622_send_config() */
+	connector = drm_atomic_get_new_connector_for_encoder(commit, bridge->encoder);
+	if (connector && connector->luminance_property) {
+		const struct drm_connector_state *conn_state =
+			drm_atomic_get_new_connector_state(commit, connector);
+
+		if (conn_state)
+			ps8622->brightness = conn_state->luminance;
+	}
+
 	gpiod_set_value(ps8622->gpio_rst, 0);
 
 	if (ps8622->v12) {
@@ -438,6 +467,7 @@ static const struct drm_bridge_funcs ps8622_bridge_funcs = {
 	.atomic_disable = ps8622_disable,
 	.atomic_post_disable = ps8622_post_disable,
 	.attach = ps8622_attach,
+	.set_luminance = ps8622_set_luminance,
 };
 
 static const struct of_device_id ps8622_devices[] = {
@@ -502,18 +532,28 @@ static int ps8622_probe(struct i2c_client *client)
 		ps8622->lane_count = ps8622->max_lane_count;
 	}
 
-	if (!of_property_read_bool(dev->of_node, "use-external-pwm")) {
-		ps8622->bl = backlight_device_register("ps8622-backlight",
-				dev, ps8622, &ps8622_backlight_ops,
-				NULL);
-		if (IS_ERR(ps8622->bl)) {
-			DRM_ERROR("failed to register backlight\n");
-			ret = PTR_ERR(ps8622->bl);
-			ps8622->bl = NULL;
-			return ret;
+	ps8622->brightness = PS8622_MAX_BRIGHTNESS;
+	ps8622->internal_pwm = !of_property_read_bool(dev->of_node,
+						      "use-external-pwm");
+	if (ps8622->internal_pwm) {
+		if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+			ps8622->bridge.ops |= DRM_BRIDGE_OP_LUMINANCE;
+			ps8622->bridge.luminance_max = PS8622_MAX_BRIGHTNESS;
+			ps8622->bridge.luminance = ps8622->brightness;
+		} else {
+			ps8622->bl = backlight_device_register("ps8622-backlight",
+							       dev, ps8622,
+							       &ps8622_backlight_ops,
+							       NULL);
+			if (IS_ERR(ps8622->bl)) {
+				DRM_ERROR("failed to register backlight\n");
+				ret = PTR_ERR(ps8622->bl);
+				ps8622->bl = NULL;
+				return ret;
+			}
+			ps8622->bl->props.max_brightness = PS8622_MAX_BRIGHTNESS;
+			ps8622->bl->props.brightness = ps8622->brightness;
 		}
-		ps8622->bl->props.max_brightness = PS8622_MAX_BRIGHTNESS;
-		ps8622->bl->props.brightness = PS8622_MAX_BRIGHTNESS;
 	}
 
 	ps8622->bridge.type = DRM_MODE_CONNECTOR_LVDS;

-- 
2.43.0

