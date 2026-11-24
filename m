Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40529606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A25A310EA9B;
	Tue, 24 Nov 2026 06:54:59 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022080.outbound.protection.outlook.com [40.107.75.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CAA10EA9B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIzX5cuNvkG1JwyvPSzNaEJvLffsD/t2wQyhjLc5FKZThQLrs2XB/Dd0IoiV+1T1fntKrBRV3wCWA3ZY5mL2YVAXrwygaX0ggBbWJrZIfqh4YaDYDNXPKo03d3GbMQoINaDazdrhiZ0dJITp7sPGZ7JEJ2MIXW4RV0k2c6j+YaUFLOIZbq9zV92kdo6M/790G7uWRpGfS/iR473kBmcUo1gpe5pCQBwvhmqoLdIYIyLE4Lvr3jbRrTejO8obXJA8u6sYIhzifgF3XiRkiWL1H7GaAYg6SyJBlmQnO9csEZD2/COhuNx5W1kL8MIyzYp9/Zh6IPw/woeAPZlOj5ZyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5/ilYjNIdMzPVov6bsQbB0+i0Mj+E7hq2zbDupkePw=;
 b=EngjlDY63JvWWs3XrB91NZj7b48y/8Dx6osRi5rCa6I6pj8GzsDYk8yc4cN1QBEIMUOEJeiSltGCjc1dUm8EgWbnsOuL2syMEJCN1W8hRS/+UPNrfUQ2CVZ/U4n3bqgP0pCcLrUcCdbaVUpmBz7HoxTl9a/LtgC+wELELkIQQnUp5GqqcwOGXdjTx/dV4UTMP5pgr6bpSgA/72ZfLrBfuz15s/PWYep7U469dmNgByfh1FtBfYJ07kTtkBSwCYaUQ7ocEH77MPloK1UduSI8+wMpwjkK0r2zODoedzK4r48ddWIVSyxgEYMXgFVZWhumqui4DAQDehOtIv2IUbNQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from JH0PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:990:7::17) by TYZPR06MB6306.apcprd06.prod.outlook.com
 (2603:1096:400:41e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 06:54:48 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:990:7:cafe::3d) by JH0PR01CA0152.outlook.office365.com
 (2603:1096:990:7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 06:54:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 06:54:47 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 7460940920E1;
 Tue, 24 Nov 2026 14:54:46 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 cix-kernel-upstream@cixtech.com
Cc: airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Wuyi.Shen@cixtech.com
Subject: [PATCH 2/2] drm/komeda: Use drmm_mode_config_init()
Date: Tue, 24 Nov 2026 14:54:46 +0800
Message-Id: <20261124065446.3107248-3-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261124065446.3107248-1-Luo.Liu@cixtech.com>
References: <20261124065446.3107248-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|TYZPR06MB6306:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1869dc51-1604-41ca-48b3-08df49f7d445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|42112799006|36860700016|23010399003|261009223327099003|261009223027099003|261009221227099003|261009221727099003|261009220027099003|6133799003|18002099003|22082099003|261028144727099003|261022075727099003|261022105027099003|261021123027099003|261102123227099003|261026140227099003|261021121427099003|261026121527099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9OIZ9v0c0GoJGVI8oAW0Rb6erxqsptlypkAPGr+f37VdsMU+tIatpwYnMjCRpIfOiZpzX7dPENE32kSkN/YuqMpX46t7n+GjuP7rGdt3SkWbwuUzLavPclDxSyCq3Y+rywZebv+h8/QX2CzSXjIrquycTLlFIsRHQfai+jKTlq5JEoNZZqcnJmhPtd6RPnDM97Y5a+perLlqTNaORDWwpUKAQ7+yXCASqkh7X19YezfdwcA4J4jyQeg5DoUAiHduOWaVOCcgcyacJ4fBb+Wdyztkikf/SCOESb4CJMy9bRBG9DGjcPBPU5pkFqK+EHYlFCS/iKOduqUWJV4li6zS8Oy4220+VgMSdj8xp24XrT52kPiKCXdhDN07qL8BXuPDXZkGMbJVcF02UIk7+jn988hNg7FdlhKZg6a750rMbn1LJCbrhH70PW1XuPxRFghX2NbVsDZm3uwlrx5rLotQx1TdTka8L3SaKU7LYpSF3pLlF1IvgPABkV8r7+72FYzASftRPwXGCCzAFmYoqhqz44C/7ZnyvgjZkunGpdhMFDsur+mfGYd7QPgD7zNTJQvObRLXLa/IxgHF/ymUAy9zVPWZDQMp86pqc7kzaRRHQqo6anGxlbZTut4xE3GWo9IJyJdPePgUxB8t/puDdoYUWiNx/mjtBntX1IS+Al8ZfvslIFMj/I9YfH2ca700ucq68OQ5Yw7na3bfhv6p2FwEXw==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(42112799006)(36860700016)(23010399003)(261009223327099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009220027099003)(6133799003)(18002099003)(22082099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261102123227099003)(261026140227099003)(261021121427099003)(261026121527099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lhCP6UBRhjY8VOQUn/ITdNZZ17rmAJCfAWufIWbI+ITFJIAhTYVvP5M0gd+AOpSQIdhQlfonIZSyAqbSKEe14P/XUVQ8Tyeb+fUQbUy/9eeexJTShDe9ya74efgw9MP0XZN0viOy8N+zIutRow41SKPeM555VPU3zU2z3WiRtuvBPKY7Hhvg1oTKU5hl/S9n6LEqU9aIYcVOk6lIYABC9azKm5ZV3R4ttaIcbuWGqU6BfWqOK++MoRS/1DS9+CMADKsbVsn9dIQn9nniew26vWc5PeAtvNEp0ZdX+UVw9idemkORs20sinKp50ebxdpI0dhBhMnMFgZUbMZ0yS6TS+NuSQvVHjV/n9Ykf+UVhT3U33fxQCkFsNCOHbrgCL/ARlMVzDHYrzhTC3PUROJuKfogNhbDp5cPF0CdYlEu7ITxlH7S74PgdJwQWmPRizvC
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:54:47.4347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1869dc51-1604-41ca-48b3-08df49f7d445
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6306
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

