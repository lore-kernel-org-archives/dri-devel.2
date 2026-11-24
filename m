Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F25F606A6AB
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF3C410F407;
	Tue, 24 Nov 2026 09:39:36 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023101.outbound.protection.outlook.com [52.101.127.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C650D10F400
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZQPZrcFhD2iwF/X7YX7YUEkImjS1jPEGMQq3d03GJ37sqUQvUVOZaMgDJ5qvYYhH5F7znMqeERlifaJTq+K8CMQexLQhJGSgeN/htl5ieuaN1UqwVxP19PWAnqeueb3+IRE0otj3wkf4KcpCPxykCInpJpJI0nfien/AtE8o7e6eQGUrN7Fm09haUKU8RzQDkEZ0un9Yeujuc5KAR9LwFIC0venYH1ApZeY2rwfxLxaNtm8hN2ZKLIA2xJuiSPukuTQJU3jXIV3ov8IZGa9wEXs2rJH0/qfVJoa1SNykMTEcK4HG6zsYpsfBeLg9zs/IHZSo22e/zT0XrzuZ95cSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5/ilYjNIdMzPVov6bsQbB0+i0Mj+E7hq2zbDupkePw=;
 b=xBJHyOJ4ehwpzmeU/Ys6j58ErFl2+P9X1U9YuWp2v6/TMYT3E1nSqWeBwQZXJHQbE0NEXLYU2JI+5ldgOjTicRt9z8JAWaIdMOj0K2YDVgsFkSuXAl677s6Lg7KgEEGxOpdaWo7QEPzp8jQ/ZfnF7wHLseQN5jsIn/i3cuMg8TsweJR/vKiwtGryJCo9QEYqDIAGVsfwU158JyJyZH9s0RG/rqOYTYA1zbHAYQs5+QMzRNiQcRpymZ5Mm/nYQLyNHyqlBnAnmZpkhydTRnkrUOlgT5U0NqVyJkVN79RQD/m29jgC29exEjru07oBMUbHjfx544Jzi1cvis/MhjDMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS3P301CA0005.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:21d::12)
 by SEZPR06MB7188.apcprd06.prod.outlook.com (2603:1096:101:233::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 09:39:30 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:604:21d:cafe::37) by OS3P301CA0005.outlook.office365.com
 (2603:1096:604:21d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 09:39:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 09:39:29 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 474AA40920E1;
 Tue, 24 Nov 2026 17:39:28 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Liviu Dudau <liviu.dudau@arm.com>,
 Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org
Cc: Ayan Halder <Ayan.Halder@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] drm/komeda: Use drmm_mode_config_init()
Date: Tue, 24 Nov 2026 17:39:26 +0800
Message-Id: <20261124093928.3220071-3-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261124093928.3220071-1-Luo.Liu@cixtech.com>
References: <20261124093928.3220071-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|SEZPR06MB7188:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6d5007b9-49db-450f-470d-08df4a0ed658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|42112799006|376014|36860700016|1800799024|7416014|18002099003|22082099003|6133799003|56012099006|261028144727099003|261009221727099003|261021123027099003|261026140227099003|261102123227099003|261026121527099003|261022075727099003|261009223027099003|261009221227099003|261009223327099003|261022105027099003|261021121427099003|261009220027099003|10067099003;
X-Microsoft-Antispam-Message-Info: i66o/a0BKqfwTfMHNUzQj2WfxYXZdf9JDk7/zH7e1n2fPFEpRBwZ9ESeIB54bPnM41wUQKZ+3AblSkjIyMSOYcwnV78/7mBOxNt2xOxfMQvY3Lc3mW7fFaZxhVGCYOVf+xwm1gkpXvS4RSw2XekkmH11ZVqi2mj2xmrhftcAqyh9ny67DjgQelN+66yRyb8CM7hVCVfV2Q/8pqeg31XkHCGIZurTD5UjTc7rkYuDNuzXL9xTs8pKjE/P5qGz4BYiFyEYSuBK1JR9XqwI+lrUknSdO9VmIAL0vg5mStWdqGNXHXARYfBlrllY8HTJJJ84HKLAo+njMPbmgp3VHQQdaY7gndQpxZZM+4zh0prieqOoe1IrMwh8RnzNjSW8Zkr5yQCd7/2RYDmRp6G1lWIlY4Y3g8HT1G+S2eE9PUw8nitulJa085kyJjj3tDRs8G/YWHxPMOoDitTNa3y8AcLysZq741ioSkZ3YgT7OJCiPJ5bdK8BuPvlrH65809nkTFdK/HrvBmbiEU8jRV8I3f0EGAHU5sALTz/jJMJTinaR6+z7/GHB0l+z6ATMGldg/3mjlnAsi1Si5DYpSJmkSNm5n9eoezH7Sl33dwue4tzLJ/WPuklb7P0Imh3HmqCYYonnToE2CYeumhEEOxaypW3r3oTAOcgKO5+ImaLIqUE3s4dCjEmgik845M2HKyWyRGPJm6O4cXnOGDRXtj1SdKNOA==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(42112799006)(376014)(36860700016)(1800799024)(7416014)(18002099003)(22082099003)(6133799003)(56012099006)(261028144727099003)(261009221727099003)(261021123027099003)(261026140227099003)(261102123227099003)(261026121527099003)(261022075727099003)(261009223027099003)(261009221227099003)(261009223327099003)(261022105027099003)(261021121427099003)(261009220027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mjKtjyxxiLOQS/zTz9S5jzszYQXzfG6BswNZkIjBAZxpZo1x7OyT39hPGNpgD5yNvhAgY3mIaT2ME2JI7iVvMHbioB2bjEFkg6DO2m5jkYRQ5uzKmPLkqplr0n3RlTBfCoe6IuCwJoVuq9KhGVhi1ifAKmGNVuKlpqmTU5U0xbuxlZ4NwIIm1takUT6kIlFGrqgE3nf18UGb5kaQG+5r+z+xrSTSyz/jUP0ZSzDBoy0g9DmOoSXVsPse8n0aY7Ckxg+qTONl+4Vpq81YY5NqH2zLreZx7itO3VcQUSQF145IYyf9CnHYnGLwmhA0xxv5zyuKjkJFjQzcDYzowGexFME6x4C+DS0Qo9GdIAV+ySAC8IVWpUT5qU31NkpOYwaYdYkXEGoaqogCFwsssujnyAyHu8BErriFVGbxVCYEhM1Snq7fA60eMOnc3S7MDMyE
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:39:29.1135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5007b9-49db-450f-470d-08df4a0ed658
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7188
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_bridge_connector_init() creates the connector with
drmm_connector_init(), which does not allow a ->destroy hook and registers
its own cleanup action instead. Calling drm_mode_config_cleanup()
explicitly drops the connector's last reference, so drm_connector_free()
ends up calling a NULL ->destroy pointer. That happens on the
komeda_kms_attach() error paths, and on unbind as soon as no other
component holds a connector reference.

Let DRM release the mode configuration: switch to drmm_mode_config_init()
and drop the explicit drm_mode_config_cleanup() calls. The managed cleanup
is registered before the connectors are created, so it runs after the
connector cleanup actions and finds an empty connector list.

The mode configuration teardown now happens after komeda_kms_detach() has
returned, so komeda can no longer rely on drm_mode_config_cleanup()
detaching the encoders' bridges before komeda_kms_cleanup_private_objs()
walks mode_config.privobj_list - the bridges are private objects there as
well, and finalizing them a second time when the encoders are cleaned up
would corrupt the list and free their state twice. Since the komeda
private objects belong to the pipeline components, finalize them by
walking the pipelines instead of the shared list.

Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
---
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 36 +++++++++++--------
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 +-
 .../arm/display/komeda/komeda_private_obj.c   | 23 +++++++++---
 3 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index faa8b041373a..37388d45b31f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -253,12 +253,15 @@ static const struct drm_mode_config_funcs komeda_mode_config_funcs = {
 	.atomic_commit		= drm_atomic_helper_commit,
 };
 
-static void komeda_kms_mode_config_init(struct komeda_kms_dev *kms,
-					struct komeda_dev *mdev)
+static int komeda_kms_mode_config_init(struct komeda_kms_dev *kms,
+				       struct komeda_dev *mdev)
 {
 	struct drm_mode_config *config = &kms->base.mode_config;
+	int err;
 
-	drm_mode_config_init(&kms->base);
+	err = drmm_mode_config_init(&kms->base);
+	if (err)
+		return err;
 
 	komeda_kms_setup_crtcs(kms, mdev);
 
@@ -270,6 +273,8 @@ static void komeda_kms_mode_config_init(struct komeda_kms_dev *kms,
 
 	config->funcs = &komeda_mode_config_funcs;
 	config->helper_private = &komeda_mode_config_helpers;
+
+	return 0;
 }
 
 struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
@@ -287,27 +292,29 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
 
 	drm->dev_private = mdev;
 
-	komeda_kms_mode_config_init(kms, mdev);
+	err = komeda_kms_mode_config_init(kms, mdev);
+	if (err)
+		return ERR_PTR(err);
 
 	err = komeda_kms_add_private_objs(kms, mdev);
 	if (err)
-		goto cleanup_mode_config;
+		goto cleanup_private_objs;
 
 	err = komeda_kms_add_planes(kms, mdev);
 	if (err)
-		goto cleanup_mode_config;
+		goto cleanup_private_objs;
 
 	err = drm_vblank_init(drm, kms->n_crtcs);
 	if (err)
-		goto cleanup_mode_config;
+		goto cleanup_private_objs;
 
 	err = komeda_kms_add_crtcs(kms, mdev);
 	if (err)
-		goto cleanup_mode_config;
+		goto cleanup_private_objs;
 
 	err = komeda_kms_add_wb_connectors(kms, mdev);
 	if (err)
-		goto cleanup_mode_config;
+		goto cleanup_private_objs;
 
 	drm_mode_config_reset(drm);
 
@@ -315,7 +322,7 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
 			       komeda_kms_irq_handler, IRQF_SHARED,
 			       drm->driver->name, drm);
 	if (err)
-		goto cleanup_mode_config;
+		goto cleanup_private_objs;
 
 	drm_kms_helper_poll_init(drm);
 
@@ -327,9 +334,8 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
 
 free_interrupts:
 	drm_kms_helper_poll_fini(drm);
-cleanup_mode_config:
-	drm_mode_config_cleanup(drm);
-	komeda_kms_cleanup_private_objs(kms);
+cleanup_private_objs:
+	komeda_kms_cleanup_private_objs(mdev);
 	drm->dev_private = NULL;
 	return ERR_PTR(err);
 }
@@ -337,12 +343,12 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
 void komeda_kms_detach(struct komeda_kms_dev *kms)
 {
 	struct drm_device *drm = &kms->base;
+	struct komeda_dev *mdev = drm->dev_private;
 
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
 	drm_atomic_helper_shutdown(drm);
-	drm_mode_config_cleanup(drm);
-	komeda_kms_cleanup_private_objs(kms);
+	komeda_kms_cleanup_private_objs(mdev);
 	drm->dev_private = NULL;
 }
 
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
index 83e61c4080c2..6f1e6c1773f0 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -181,7 +181,7 @@ int komeda_kms_add_private_objs(struct komeda_kms_dev *kms,
 				struct komeda_dev *mdev);
 int komeda_kms_add_wb_connectors(struct komeda_kms_dev *kms,
 				 struct komeda_dev *mdev);
-void komeda_kms_cleanup_private_objs(struct komeda_kms_dev *kms);
+void komeda_kms_cleanup_private_objs(struct komeda_dev *mdev);
 
 void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
 			      struct komeda_events *evts);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
index 77b3f361091f..51be98ab570e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
@@ -502,11 +502,24 @@ int komeda_kms_add_private_objs(struct komeda_kms_dev *kms,
 	return 0;
 }
 
-void komeda_kms_cleanup_private_objs(struct komeda_kms_dev *kms)
+void komeda_kms_cleanup_private_objs(struct komeda_dev *mdev)
 {
-	struct drm_mode_config *config = &kms->base.mode_config;
-	struct drm_private_obj *obj, *next;
+	struct komeda_component *c;
+	struct komeda_pipeline *pipe;
+	unsigned long avail_comps;
+	int i, id;
+
+	for (i = 0; i < mdev->n_pipelines; i++) {
+		pipe = mdev->pipelines[i];
 
-	list_for_each_entry_safe(obj, next, &config->privobj_list, head)
-		drm_atomic_private_obj_fini(obj);
+		if (pipe->obj.funcs)
+			drm_atomic_private_obj_fini(&pipe->obj);
+
+		avail_comps = pipe->avail_comps;
+		for_each_set_bit(id, &avail_comps, 32) {
+			c = komeda_pipeline_get_component(pipe, id);
+			if (c && c->obj.funcs)
+				drm_atomic_private_obj_fini(&c->obj);
+		}
+	}
 }
-- 
2.25.1

