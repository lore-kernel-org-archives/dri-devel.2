Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46460A260E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y9togQUw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C425D1127E2;
	Thu, 19 Nov 2026 23:28:21 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013057.outbound.protection.outlook.com
 [40.93.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412DF1127E0;
 Thu, 19 Nov 2026 23:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyzcJP0yZPxuHZavFxRMlortyntISLpWQ6dj+88Swbc1jCSaDZvI0nm88EiieaKuN9ctmhnlLeFlPFrn4X2SfkIKRvm+jp/NRZycqTTDASwTKMXQ25LV036kzV6TjBGu1P9b8soGfO84NTIA9rVio8l2fa5eXzzgtA+Qw3fOnNmHPTbB+fEIUWzXKzZKzbdaAeKei4j4Q3rFHfp8+P80KwPPWLl3xboy+rXwUpqeuyhDti+RzFTXmVjUbVvzAaqZLdrGnmU8O6pFfEpXAJl970qnOovkRv2cnzfEMRclvKGrS/rS/iH7WUCo0NwILeMBrkpEEwfxn9M96DEdRF4A0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/etXMW2SZRCTF7xkCHwFZD5F+46XxhRFmwIOCoV9aMM=;
 b=Qcvd1bBPgBGdbGcya4waVGGpMyUKwuaLnbS7RevqRKeJ2GvZgBphNVGMLTzFhUNlQrjfTRkhjrFVwoeqRhATjl8IlIYLfbpX9pdaVuFU3rDPojdQDnbVMjoIW9UBJen2ym0vT0T2h/brwQLxBsX+nsWydnwG/ZGtk7Me7bdIdaHDctrv3NsKk99sRqrwjmI/s++oDwwvNOKqxyMwz5PCA8q4E+7qT1lIXkIAZewUqsDDv2T0sBVQ83bfDGSFQWPA++P5JMRYr1k1G/uQ5Ds213HtAjB0SBmbcLDD9SQfZoWmIcjcvYiz5kXZB0tTyx7da041xFl/yoO9UNjivxmmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/etXMW2SZRCTF7xkCHwFZD5F+46XxhRFmwIOCoV9aMM=;
 b=Y9togQUwKgpy6PdYv5/bAvbi5HQXvZGSjyfEBrbNU4kTm7D3Fev4sSkWgOnZiT9LGEVgmHCkMIpUeaRNxGXHxaSxtdPyPYiVpZQlxQaqzFQAPku0eTNyOKlu5R2S6qNNG03AcZNLVqxj4euEwdxNV50heoAx87Z7NJ+/PMG0anU=
Received: from PH0PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:e::12)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 23:28:08 +0000
Received: from PH7PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::5c) by PH0PR07CA0037.outlook.office365.com
 (2603:10b6:510:e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 23:28:03 +0000
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
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:28:03 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:28:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 17:27:39 -0600
Subject: [PATCH v12 12/12] drm/solomon: add SSD130x connector luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-superm1-backlight-property-v12-12-89d5217d3618@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF00000009:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: cc35924a-dc87-4671-6db7-08df4694c226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|921020|261021123027099003|56012099006|261026121527099003|261022075727099003|261021121427099003|10067099003|11063799006|261102123227099003|22082099003|6133799003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 5ki9UoRvj/zThRzYsygFlmTW0bfDSsKjnijEVL4+IbxhGPg65qljI/7mToezr9YtQH/Xklz7Ff2Svx8zPQR1P2R7ifwOBawzFhcfn+zl2IFi5ibo7jyVLAdhe8UcWpqIy6ILBw4OKtmxezTjpQqD4Ur7v8EXOXUWs1LsjmLUYhdPVojAsFOian9Mds/ioTqK0cKDmELHJbeqINXHsWVn77loKYmPRF2x4mh97qKNdnqNqnOPmKMgwtJ4DoJKrb7BdJ8vTIB8sliP93ddyZ71aMPXYaGlxUYgNdZuly02fb7k0PdBgTV2NsxN/RIzihnj+ch/BZVIz33ewMaLUA5sWrqmLF03kndMFgmXYzTSgc1/zMzCjFQ6j/pl4bML2N+XEIwyHqZBvS1n5w5MIwlpjrwHgsxtTGalyZsHhNj9p++6hy8YzbvDsniY/UNKWTblU/YTybo6mMRlmroCfZHIOKBQmkg5mXJztL8p0rxndULqJwAUtnV3JWGSlbSeoHppyatTeHG0E5wSPYUuSybLc5ctqPpCrrB7f0b4HxNCOkWRTomui4oVSAXhwyUBsx42XXIV/TkWuj4kbWL+SM85TImKlxDOucdeijlLRwegAaC8nVO/8Dq1NWdxyAC5ErQ53JOtRkqFoBvKdJSYyGWbunuAxOukB5NtEJRDMxPJ4u+31IhhOBnMYYkcEfSptGQ9CAdjZCqHXtCEIGrbtHxhNqsQO3FkvzGLWgZGf1MiYmEe1YCMIuSTS4HMGW0UtoDa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(921020)(261021123027099003)(56012099006)(261026121527099003)(261022075727099003)(261021121427099003)(10067099003)(11063799006)(261102123227099003)(22082099003)(6133799003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 46mw553P40SqTrQXUC3lEgQSi1ppNzKzeJ+QqUSY/caqCPDmTq8vXjYspHrZ3lh9ssLmNdvNzrBfCx9HP3Z3/eINkjDJC5LKGFQ0dT/jKDg0Kj5fGRi8mV4awsXV+eY1o5t0zy5YHz+yVIjbZQIUPT+rXPu5DKyh3UduN2FVTZx324RO3gklIKzl3IosLyqCbCaMtChC24AGo+EwB8wXru561QPIfwoNCsIFP8UC9ThoX93VhAbzBU6vPfuUcJDZbk+jHMJsPFCENKqD99XNBHH0ORokz7GOkkfe30A97NVegYFDClaApWWPMKKl6qq7nO/G//HaWwHLe1y3KYpcxZVf03fFNDT5zyj9c3tmVVeciE/RyfUUE/M5t8dUPeYqebOCFibRA3WbPoGi4xm227BBkezkypGKDtyG2ZLH1oOrYP2XejhyR3IG62BUo8IB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:28:03.5602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc35924a-dc87-4671-6db7-08df4694c226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
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

Expose SSD130x contrast through the connector LUMINANCE property when
DRM_LUMINANCE is enabled. Program contrast directly and register the
backlight class device only when DRM_LUMINANCE is disabled, so contrast
has a single owner.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

---
v12:
 * Drop the enabled flag, the atomic helpers only call the luminance
   callbacks while the display pipeline is active (Javier)
 * Add tag
v11:
 * Keep selecting BACKLIGHT_CLASS_DEVICE and drop the guards (Sashiko)
 * Register the backlight device only without DRM_LUMINANCE (Sashiko)
 * Initialise the controller with the committed luminance and don't
   clobber the saved contrast on disable (Sashiko)
 * Skip contrast writes while the controller is powered down (Sashiko)
 * Unify contrast dispatch and backlight ops (Sashiko)
 * Drop Reviewed-by due to the rework
v10:
 * Guard the backlight operations and registration with
   BACKLIGHT_CLASS_DEVICE
 * Fix Kconfig recursive issue
 * Add the Reviewed-by tag
---
 drivers/gpu/drm/solomon/ssd130x.c | 138 +++++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index ee43cf0da8792..cd71aa3633709 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -627,7 +627,7 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
 static int ssd132x_init(struct ssd130x_device *ssd130x)
 {
 	const u8 cmds[] = {
-		2, SSD13XX_CONTRAST, 0x80,
+		2, SSD13XX_CONTRAST, ssd130x->contrast,
 		3, SSD132X_SET_COL_RANGE, 0x00, ssd130x->width / SSD132X_SEGMENT_WIDTH - 1,
 		3, SSD132X_SET_ROW_RANGE, 0x00, ssd130x->height - 1,
 		/*
@@ -696,6 +696,18 @@ static int ssd135x_set_contrast(struct ssd130x_device *ssd130x, u32 brightness)
 	return ssd130x_write_cmd(ssd130x, 4, SSD135X_SET_CONTRAST, a, b, c);
 }
 
+static int ssd130x_set_contrast(struct ssd130x_device *ssd130x, u32 contrast)
+{
+	switch (ssd130x->device_info->family_id) {
+	case SSD133X_FAMILY:
+		return ssd133x_set_contrast(ssd130x, contrast);
+	case SSD135X_FAMILY:
+		return ssd135x_set_contrast(ssd130x, contrast);
+	default:
+		return ssd130x_write_cmd(ssd130x, 2, SSD13XX_CONTRAST, contrast);
+	}
+}
+
 static int ssd133x_init(struct ssd130x_device *ssd130x)
 {
 	int ret;
@@ -1836,6 +1848,23 @@ static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
 	.atomic_destroy_state = ssd130x_crtc_destroy_state,
 };
 
+/*
+ * With DRM_LUMINANCE, initialize the controller with the committed connector
+ * luminance, which may have changed while the display was disabled.
+ */
+static void ssd130x_load_luminance(struct ssd130x_device *ssd130x,
+				   struct drm_atomic_commit *state)
+{
+	struct drm_connector_state *conn_state;
+
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE))
+		return;
+
+	conn_state = drm_atomic_get_new_connector_state(state, &ssd130x->connector);
+	if (conn_state)
+		ssd130x->contrast = conn_state->luminance;
+}
+
 static void ssd130x_encoder_atomic_enable(struct drm_encoder *encoder,
 					  struct drm_atomic_commit *state)
 {
@@ -1847,6 +1876,8 @@ static void ssd130x_encoder_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		return;
 
+	ssd130x_load_luminance(ssd130x, state);
+
 	ret = ssd130x_init(ssd130x);
 	if (ret)
 		goto power_off;
@@ -1873,6 +1904,8 @@ static void ssd132x_encoder_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		return;
 
+	ssd130x_load_luminance(ssd130x, state);
+
 	ret = ssd132x_init(ssd130x);
 	if (ret)
 		goto power_off;
@@ -1898,6 +1931,8 @@ static void ssd133x_encoder_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		return;
 
+	ssd130x_load_luminance(ssd130x, state);
+
 	ret = ssd133x_init(ssd130x);
 	if (ret)
 		goto power_off;
@@ -1923,6 +1958,8 @@ static void ssd135x_encoder_atomic_enable(struct drm_encoder *encoder,
 	if (ret)
 		return;
 
+	ssd130x_load_luminance(ssd130x, state);
+
 	ret = ssd135x_init(ssd130x);
 	if (ret)
 		goto power_off;
@@ -1980,8 +2017,33 @@ static int ssd130x_connector_get_modes(struct drm_connector *connector)
 	return drm_connector_helper_get_modes_fixed(connector, &ssd130x->mode);
 }
 
+static void ssd130x_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(conn_state->connector->dev);
+
+	/*
+	 * The encoder enable already initialized the controller with the
+	 * committed luminance.
+	 */
+	if (ssd130x->contrast == conn_state->luminance)
+		return;
+
+	ssd130x->contrast = conn_state->luminance;
+	ssd130x_set_contrast(ssd130x, ssd130x->contrast);
+}
+
+static void ssd130x_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(conn_state->connector->dev);
+
+	/* Keep ssd130x->contrast, it is restored when the encoder is enabled */
+	ssd130x_set_contrast(ssd130x, 0);
+}
+
 static const struct drm_connector_helper_funcs ssd130x_connector_helper_funcs = {
 	.get_modes = ssd130x_connector_get_modes,
+	.set_luminance = ssd130x_connector_set_luminance,
+	.disable_luminance = ssd130x_connector_disable_luminance,
 };
 
 static const struct drm_connector_funcs ssd130x_connector_funcs = {
@@ -2016,55 +2078,16 @@ static const struct drm_driver ssd130x_drm_driver = {
 };
 
 static int ssd130x_update_bl(struct backlight_device *bdev)
-{
-	struct ssd130x_device *ssd130x = bl_get_data(bdev);
-	int brightness = backlight_get_brightness(bdev);
-	int ret;
-
-	ssd130x->contrast = brightness;
-
-	ret = ssd130x_write_cmd(ssd130x, 1, SSD13XX_CONTRAST);
-	if (ret < 0)
-		return ret;
-
-	ret = ssd130x_write_cmd(ssd130x, 1, ssd130x->contrast);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int ssd133x_update_bl(struct backlight_device *bdev)
-{
-	struct ssd130x_device *ssd130x = bl_get_data(bdev);
-
-	ssd130x->contrast = backlight_get_brightness(bdev);
-
-	return ssd133x_set_contrast(ssd130x, ssd130x->contrast);
-}
-
-static int ssd135x_update_bl(struct backlight_device *bdev)
 {
 	struct ssd130x_device *ssd130x = bl_get_data(bdev);
 
 	ssd130x->contrast = backlight_get_brightness(bdev);
 
-	return ssd135x_set_contrast(ssd130x, ssd130x->contrast);
+	return ssd130x_set_contrast(ssd130x, ssd130x->contrast);
 }
 
-static const struct backlight_ops ssd130xfb_bl_ops[] = {
-	[SSD130X_FAMILY] = {
-		.update_status	= ssd130x_update_bl,
-	},
-	[SSD132X_FAMILY] = {
-		.update_status	= ssd130x_update_bl,
-	},
-	[SSD133X_FAMILY] = {
-		.update_status	= ssd133x_update_bl,
-	},
-	[SSD135X_FAMILY] = {
-		.update_status	= ssd135x_update_bl,
-	},
+static const struct backlight_ops ssd130xfb_bl_ops = {
+	.update_status	= ssd130x_update_bl,
 };
 
 static void ssd130x_parse_properties(struct ssd130x_device *ssd130x)
@@ -2213,6 +2236,13 @@ static int ssd130x_init_modeset(struct ssd130x_device *ssd130x)
 	}
 
 	drm_connector_helper_add(connector, &ssd130x_connector_helper_funcs);
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		ret = drm_connector_attach_luminance_property(connector, 0,
+							      MAX_CONTRAST,
+							      ssd130x->contrast);
+		if (ret)
+			return ret;
+	}
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret) {
@@ -2270,16 +2300,18 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 	if (ret)
 		return ERR_PTR(ret);
 
-	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
-					    &ssd130xfb_bl_ops[ssd130x->device_info->family_id],
-					    NULL);
-	if (IS_ERR(bl))
-		return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
-					     "Unable to register backlight device\n"));
-
-	bl->props.brightness = ssd130x->contrast;
-	bl->props.max_brightness = MAX_CONTRAST;
-	ssd130x->bl_dev = bl;
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		bl = devm_backlight_device_register(dev, dev_name(dev), dev,
+						    ssd130x, &ssd130xfb_bl_ops,
+						    NULL);
+		if (IS_ERR(bl))
+			return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
+						     "Unable to register backlight device\n"));
+
+		bl->props.brightness = ssd130x->contrast;
+		bl->props.max_brightness = MAX_CONTRAST;
+		ssd130x->bl_dev = bl;
+	}
 
 	ret = ssd130x_init_modeset(ssd130x);
 	if (ret)

-- 
2.43.0

