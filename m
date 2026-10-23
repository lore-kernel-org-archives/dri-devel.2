Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B8606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=eEAapmNn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1CD410E6DE;
	Fri, 23 Oct 2026 16:50:03 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3EA510E6B1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlkSPMzuT9vHsa8lAQjQK6FiU7u8wSEn3Neo5DM5npB12gmjbAaae1nRbhOisINru9j239pTyca9FfF/0mZYIrpZ2fq+l1VCbLJvKNAG4mGg74ANI727BoJ5UVG5ZD+D/QQXhr0JEHubJTiWIsW4+fh5pRoPgX7qDFc/4bWyEkb1zf6oqzgOkbw4bcq0Hiq55SCBGZYZEVwbgnc0YYUpvhNYWHdWV+NXNlSdEqup2zvc4Ef3m21s5z5OSFym9fD39wGQo15KNQnlI5+EfIAOOBoq3DQCc/HH/VKheV3pMXgtXvCRQn6GPpsIlFZMJbKLx/z7dqZGlLAKwHR1I9JvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhGuSKVMcMKBi4AISI8sPL8wEvFePa1sG4F9aur0j6Q=;
 b=UxdHTxvKAneGzzIICfRrDnnwDLW0+5pl8hKxCSui8bnmlwpSmyZ83ewjqqUvbui0ofeticlpO/9H2Q6BlBEevToXn5EHZBuiNnfxYfpV4hA0iW7Vq9+k+KzWXSH4ILsiiqPU+Kh7saSWdlUhs7sp9JQffuSmJU8Yc2/Zl6NW3Wo2KXZbLowhgWUy6E19PUoYg4vn5xoOUk6+O9T6Ee4Ace4dAHgV495QZpuyvYbg2mfATaHjCdPRltCotct/AldGZK8oXuTMaqn5ayrLm7KrglxNJua3Pw3LmbEKffgQMxNTsoifeU6hPqZFGwcyi8TCPNg9HYZErTqVL4tH3u7Xmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhGuSKVMcMKBi4AISI8sPL8wEvFePa1sG4F9aur0j6Q=;
 b=eEAapmNnzHPGJnxrfzHyWFr+UG58pvr6mdE+KK5/qYfzMCCzVFr16RdsaRowGN+VCSop9gJy7lW49Us7YITR50jmNqHptSI6cnFVDRF906cvz+/8JCXyB2cUh4Sqe5siAV+WCfgtGWh7Z/4bq4mWsWnJvvPs8p0dJDyRmEyZK24=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS3PR01MB9415.jpnprd01.prod.outlook.com (2603:1096:604:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 16:49:00 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 16:49:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v9 04/10] drm: renesas: rz-du: Reference the DRM device by
 pointer
Date: Fri, 23 Oct 2026 18:47:37 +0200
Message-ID: <d5a97ddb346c5cb959b39fda45277afb1fa2ae16.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS3PR01MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: e103ce9d-ee09-4a2a-2fbb-08df31258997
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|23010399003|1800799024|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|56012099006|3023799007|18002099003|22082099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: /nI5eFF01Q5Ekt8H1kwmhFccwKbSIh29MRSHzPHlHyN5jeDTPczCbFwYbcB/jcRSSbT5jlKkStvdFJqNCONZF+I+GDJnQLC40j/yJmuqRRXWDRoHje7QLJQdAy6pM5j8AaPEloQFj/RnZi+mWHR1uPd915EH6BgbG9Mm6a65FNzkwWVbqY4VHvLGJy+Ib/vES/twc0Sdpdkf3Aj9dXHcb9NvnBGIJ7BbbiC+nekELNOiNoeKO65KIz/Utv3ZzBjcL6SvSHx5LW38EL6Ia4wDDxIlBktIr8z9ZL6KBm6V+C7Y+KG7rEsXH3lrr5weqVGrQNMTALRdE3w3SOHKs+veQEI0v5S9SDpkmrOmPVS0PgmDb6tjv7+Vofcb9PxSHFuW835XVN9y7cRqMBJRR3azQggUiSCCCBQWgieOrOzj8WtjHcSkdgyO2jC8z3iTZlPX04JdqBssh0We2ve3wJZQz9Eccw9GJpBfnG2dmRLMTqsO/bOjdTazhmQFO0OyHSJE8DV1Vo1wJC0h2hlxamEiRV1bPAeAgSzF9wk8pfwGp/NerLuQwrR+IBN1a0sj3Y3MtpRDR+QzoGHoDEIf5WWA/rBBSqiXDL/FmZq4QdDgka9xz185OfERopHz4CDXFXlXCtjbfFdAW4ValteVk8E2b+Hulu5GmiZLCQIUSBcyTXlskf3eX4VEOb0wT8eegnC0p6W2ZKEpZ0SKXwraySbB8RIQ1ksc56+XbYLCTAJPLl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WRtG3CDP6FWghWeDKpPhLwIRa8u9sswWkDO3PEQN9m0KxsWRizvGMw4N1Kz9?=
 =?us-ascii?Q?oiL3L7BeoKIbfqZs+Ndow4pnxHaq8phWwngk2+duS8oi6SOLjzjzNJIWX3+b?=
 =?us-ascii?Q?x1ZKQkmf9+6azoJ2B2bXOh6X9VBQNojBe9lDAuLaUBTc52nZDO91p34G5f6a?=
 =?us-ascii?Q?m0p6vlANfWfolMQFCdZRFrAc5GsaqYEGOtkQHB3WOIQBYMoMBuVMrFOCuUH8?=
 =?us-ascii?Q?t02/VVuQQXyCO4gWPMwuySmSlKfY1tFsljwARd6hQR7WjD3kDzctFTIxwskT?=
 =?us-ascii?Q?BafdLFao+XIyJZsh7y5RVskRD3ZEgorJBbaBCLhKs9RbMWSQ+KFlsMW1n/nP?=
 =?us-ascii?Q?TOmZR7YR2uKOSOezpcus8jeLFl1e6W8u5zbNCIUP9Ixxbm4o2BawEyytygGk?=
 =?us-ascii?Q?WcDCezAfD8wk8wQX8wHuxBSeUV24DYH7vH0+ZwNTMP8UzGRukwB7WOsTa9zl?=
 =?us-ascii?Q?ahTTAV3QDU3asZKg4//vFwpDfpqWHEckkJczH1BuP9i2ur48SWDF1pyXiAXV?=
 =?us-ascii?Q?Rl/Lw/i5U3l8M+AjG12K1ZNM1VOmy6TJOjvH2Q0WAmhET4f9rLgcYiGiEIzq?=
 =?us-ascii?Q?BwNtCaALd3GoftwzFMb8ksmFa4G9yBNumcp0gObDhKvqqiJd0BCtwHc5kXu1?=
 =?us-ascii?Q?5EuFigvnfT41RhpvQe6ccMJQmRUNDZRZhObIJ4Xpz2yYMsVkDtk6DXJRhyg5?=
 =?us-ascii?Q?xQfCfWbv0BhzeAvWYWM2Cx+aW0SlqihDSYeCRtXP1pLo2ylDaDbplbwbMP1S?=
 =?us-ascii?Q?bFbA3bwI1JThNt0otZJ9aWx0i96M1GDbW5IKitbDlC9CLnZhpdlyEj0cL4MY?=
 =?us-ascii?Q?nMZvD+9cNpNT9GxrBNY/FlQM/QPdXeIAw0fOjDthMq9a41Elq9xVJwSXoE+h?=
 =?us-ascii?Q?3yYMBMW2hl8jzX+MeT5t6yoOrio6daXFGtqQlmQ4CX8cheQGCd7V96ZfN0DE?=
 =?us-ascii?Q?iOdPJykDH37UQbEyHsBGQ2A6h7F5DDHAm7Rx77LUFfUvy2VBImnDDlJmn1AU?=
 =?us-ascii?Q?M9ybeXrLzTQPNtNzM+80KJyoqVT9K5nfJJTnDjgaDQIRE2m51AQ2+UawVLNh?=
 =?us-ascii?Q?8zMnXnAgWv1TaiDwaQWahLRrklJB9wm/QgCNmfCaK26sFCo7bgtnnlzMigkk?=
 =?us-ascii?Q?pxziTwy4FaIgccdo5iikHdyzceSPra85Qift8Pm8pzbTcZiOdBpLtMJKITNB?=
 =?us-ascii?Q?zjXex0pEAJ5yJwk4+hEBvVUvFvUNWH72VGkfzR0RczIXMBZ1jH07F/DYgHpS?=
 =?us-ascii?Q?oSJMnDCJO+LBR+fVn84E23QqLZLihryoDHt+0NqfPW54qOsJAg+cJ+JyfGHn?=
 =?us-ascii?Q?kmXAYE1+YhxKJtPbC5uXiHMCMKivhkLPXn/QzAUXuFA1VTd4KI+Qp+g7eUXR?=
 =?us-ascii?Q?ROMtEiHs9KaVCpn8EpaKgWQ7VaNPN0dWx8OjdKdFyzTBBUI3b9BAUBfg69ot?=
 =?us-ascii?Q?58pR3Sl69BWuI4z9HCs39yucR9PVxqZRuXrDOJy7pnswJViRdEPUO8p3sqGD?=
 =?us-ascii?Q?zVUH9Y/rXtl/2fwu6Rw0KbWolCj5/7TtTVd9Jz1oDS5wqTNyMYFTkAYomdTK?=
 =?us-ascii?Q?d1DyEVcWNcKadCQQYvgn0KAQ5iwLQZlUglmIgZhYNt189HZRZZFV2K++S2AT?=
 =?us-ascii?Q?vY0c9BrPC+/Wqm+8SrhFG9pYOSHyxAbbByVk1zbVBU0K68KgvbmYNyKGROsx?=
 =?us-ascii?Q?6BxYav23R3P8ShdyP/0t0gKHIY3NiEDBXv0E6qDnEKTCFJ/fQmE4lSeGxQL1?=
 =?us-ascii?Q?O4Zv78UWj8UymN5YmKEhAtESKXgv0+Mfcd8IXlLEopiSwlxjSTYV?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e103ce9d-ee09-4a2a-2fbb-08df31258997
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 16:49:00.3105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ozYr0a5S23NedMQ4kurVdI1hpLuXxrFYLHkdAInfuQzP69lWpMOWjNSkJANPlOyF5WNQzA2HCIOVc6cFGbSmHaU9iQEHZzL9//XXKmlu6wNPyj077qZJhF3MALlqXNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9415
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

struct rzg2l_du_device embeds the DRM device, which makes a DU instance
and the DRM device one and the same. RZ/G3E has two instances that have
to share a single DRM device.

In preparation of supporting it, reference the DRM device by pointer and
give it a container of its own. The instance is allocated with the DRM
device rather than with the platform device, as the CRTC and VSP cleanup
handlers point into it and run once the DRM device is released.

No functional change intended.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v8->v9:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |  2 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 39 ++++++++++++-------
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  7 +---
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  8 ++--
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.h  |  1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  |  2 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  |  4 +-
 7 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index c57884ab5b9b..398532933013 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -411,7 +411,7 @@ int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
 
 	primary = &rcrtc->vsp->planes[rcrtc->vsp_pipe]->plane;
 
-	ret = drmm_crtc_init_with_planes(&rcdu->ddev, crtc, primary, NULL,
+	ret = drmm_crtc_init_with_planes(rcdu->ddev, crtc, primary, NULL,
 					 &crtc_funcs_rz, NULL);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 6c2dc86abc7d..84da5a2df8f6 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -17,6 +17,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -144,10 +145,14 @@ static const struct drm_driver rzg2l_du_driver = {
  * Platform driver
  */
 
+struct rzg2l_du_drm {
+	struct drm_device ddev;
+};
+
 static void rzg2l_du_remove(struct platform_device *pdev)
 {
-	struct rzg2l_du_device *rcdu = platform_get_drvdata(pdev);
-	struct drm_device *ddev = &rcdu->ddev;
+	struct rzg2l_du_drm *rzgdrm = platform_get_drvdata(pdev);
+	struct drm_device *ddev = &rzgdrm->ddev;
 
 	drm_dev_unregister(ddev);
 	drm_atomic_helper_shutdown(ddev);
@@ -157,29 +162,35 @@ static void rzg2l_du_remove(struct platform_device *pdev)
 
 static void rzg2l_du_shutdown(struct platform_device *pdev)
 {
-	struct rzg2l_du_device *rcdu = platform_get_drvdata(pdev);
+	struct rzg2l_du_drm *rzgdrm = platform_get_drvdata(pdev);
 
-	drm_atomic_helper_shutdown(&rcdu->ddev);
+	drm_atomic_helper_shutdown(&rzgdrm->ddev);
 }
 
 static int rzg2l_du_probe(struct platform_device *pdev)
 {
 	struct rzg2l_du_device *rcdu;
+	struct rzg2l_du_drm *rzgdrm;
 	int ret;
 
 	if (drm_firmware_drivers_only())
 		return -ENODEV;
 
 	/* Allocate and initialize the RZ/G2L device structure. */
-	rcdu = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
-				  struct rzg2l_du_device, ddev);
-	if (IS_ERR(rcdu))
-		return PTR_ERR(rcdu);
+	rzgdrm = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
+				    struct rzg2l_du_drm, ddev);
+	if (IS_ERR(rzgdrm))
+		return PTR_ERR(rzgdrm);
+
+	platform_set_drvdata(pdev, rzgdrm);
+
+	rcdu = drmm_kzalloc(&rzgdrm->ddev, sizeof(*rcdu), GFP_KERNEL);
+	if (!rcdu)
+		return -ENOMEM;
 
 	rcdu->dev = &pdev->dev;
 	rcdu->info = of_device_get_match_data(rcdu->dev);
-
-	platform_set_drvdata(pdev, rcdu);
+	rcdu->ddev = &rzgdrm->ddev;
 
 	/* I/O resources */
 	rcdu->mmio = devm_platform_ioremap_resource(pdev, 0);
@@ -207,18 +218,18 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 	 * Register the DRM device with the core and the connectors with
 	 * sysfs.
 	 */
-	ret = drm_dev_register(&rcdu->ddev, 0);
+	ret = drm_dev_register(&rzgdrm->ddev, 0);
 	if (ret)
 		goto error;
 
-	drm_info(&rcdu->ddev, "Device %s probed\n", dev_name(&pdev->dev));
+	drm_info(&rzgdrm->ddev, "Device %s probed\n", dev_name(&pdev->dev));
 
-	drm_client_setup(&rcdu->ddev, NULL);
+	drm_client_setup(&rzgdrm->ddev, NULL);
 
 	return 0;
 
 error:
-	drm_kms_helper_poll_fini(&rcdu->ddev);
+	drm_kms_helper_poll_fini(&rzgdrm->ddev);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index e9626ef37cde..47ceaf892339 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -69,7 +69,7 @@ struct rzg2l_du_device {
 
 	void __iomem *mmio;
 
-	struct drm_device ddev;
+	struct drm_device *ddev;
 
 	struct rzg2l_du_crtc crtcs[RZG2L_DU_MAX_CRTCS];
 	unsigned int num_crtcs;
@@ -77,11 +77,6 @@ struct rzg2l_du_device {
 	struct rzg2l_du_vsp vsps[RZG2L_DU_MAX_VSPS];
 };
 
-static inline struct rzg2l_du_device *to_rzg2l_du_device(struct drm_device *dev)
-{
-	return container_of(dev, struct rzg2l_du_device, ddev);
-}
-
 static inline bool rzg2l_du_has(struct rzg2l_du_device *rcdu,
 				unsigned int feature)
 {
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
index a1b48973aa8e..5c21c5f9fbaf 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -52,8 +52,7 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
-	struct rzg2l_du_device *rcdu = to_rzg2l_du_device(renc->base.dev);
-	const struct rzg2l_du_device_info *info = rcdu->info;
+	const struct rzg2l_du_device_info *info = renc->dev->info;
 
 	if (renc->output != RZG2L_DU_OUTPUT_DPAD0)
 		return MODE_OK;
@@ -133,12 +132,13 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
 	dev_dbg(rcdu->dev, "initializing encoder %pOF for output %s\n",
 		enc_node, rzg2l_du_output_name(output));
 
-	renc = drmm_encoder_alloc(&rcdu->ddev, struct rzg2l_du_encoder, base,
+	renc = drmm_encoder_alloc(rcdu->ddev, struct rzg2l_du_encoder, base,
 				  &rzg2l_du_encoder_funcs, DRM_MODE_ENCODER_NONE,
 				  NULL);
 	if (IS_ERR(renc))
 		return PTR_ERR(renc);
 
+	renc->dev = rcdu;
 	renc->output = output;
 	drm_encoder_helper_add(&renc->base, &rzg2l_du_encoder_helper_funcs);
 
@@ -153,7 +153,7 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
 	}
 
 	/* Create the connector for the chain of bridges. */
-	connector = drm_bridge_connector_init(&rcdu->ddev, &renc->base);
+	connector = drm_bridge_connector_init(rcdu->ddev, &renc->base);
 	if (IS_ERR(connector)) {
 		dev_err(rcdu->dev,
 			"failed to created connector for output %s (%ld)\n",
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
index 3e430c1f6132..dfffcc14e0a3 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
@@ -17,6 +17,7 @@ struct rzg2l_du_device;
 
 struct rzg2l_du_encoder {
 	struct drm_encoder base;
+	struct rzg2l_du_device *dev;
 	enum rzg2l_du_output output;
 };
 
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index 87f171145a23..13d14ecacba9 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -402,7 +402,7 @@ static int rzg2l_du_vsps_init(struct rzg2l_du_device *rcdu)
 
 int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 {
-	struct drm_device *dev = &rcdu->ddev;
+	struct drm_device *dev = rcdu->ddev;
 	struct drm_encoder *encoder;
 	unsigned int num_encoders;
 	int ret;
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
index 12fe35740c62..4df4f0ff0ed5 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
@@ -298,7 +298,7 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 
 	vsp->vsp = &pdev->dev;
 
-	ret = drmm_add_action_or_reset(&rcdu->ddev, rzg2l_du_vsp_cleanup, vsp);
+	ret = drmm_add_action_or_reset(rcdu->ddev, rzg2l_du_vsp_cleanup, vsp);
 	if (ret < 0)
 		return ret;
 
@@ -324,7 +324,7 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 					 : DRM_PLANE_TYPE_OVERLAY;
 		struct rzg2l_du_vsp_plane *plane;
 
-		plane = drmm_universal_plane_alloc(&rcdu->ddev, struct rzg2l_du_vsp_plane,
+		plane = drmm_universal_plane_alloc(rcdu->ddev, struct rzg2l_du_vsp_plane,
 						   plane, crtcs, &rzg2l_du_vsp_plane_funcs,
 						   rzg2l_du_vsp_formats,
 						   ARRAY_SIZE(rzg2l_du_vsp_formats),
-- 
2.54.0

