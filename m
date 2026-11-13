Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D4B606A882
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=fvVLRonE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F74F112393;
	Fri, 13 Nov 2026 12:21:51 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010003.outbound.protection.outlook.com [52.101.229.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7288112489
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfwQ6ZxE2sSz3Tdf8mfZQ57cFYHGZpsfEcFw4Qg3urhb3TEEGtGNgdkMRbxr5Jv1bkZQ7hWUwkmHu/WxzafmJ41d2Xeh4zY5U9vNAShYkiVLPwVjwN4T0atOQf6knR3uwWOhu2eot+SO35lhSGEqq/YtAq2yb69X5WsXWFel15Qod8eE52z18HIICF7bp5d8mntkVqlfieI5BPlte6GhLffvUsfOYR8FfWm0/DEIVHVhgOtEEQy+KKKV8XJBUQLh+cFANhMHLGy3hQh0aYiErNcU0FdAo9cLWeU5ntKWCGsJl9tVWIAFXLuXNSWZEg4HlwiLmMY40wVO2WYE+6bnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvBvmxdq9FyTgaj7WvpxL6gIH/x6fQci5FYEdlN20JQ=;
 b=JMseBBibqZIUt89iOwGyGeLobAKhrISi71wELuKlmuxoEr8a5RQ6G6kmA4lX6dZUk8yYCF+xDCsWG0gRFEkp5zY6ZeQQaE+EYKKGrqzqAVocL3UmzilN+6YEvmpWElwhIk0p3FzPxGXpTP3cpDAGMmaHItePnaLul6IrI/1l80dX85Y74iFTYd26alZOE1X6E2B/ZgoXXHeFB/7AiQCHovo3JmyVEpA79wLbqdsOw23oYdh2ViXxeS7mnHawrz9ADlUUmMonHJ1yP2PwUv2CTJJwXuJM5ZfCDeK2TLQ2C5SKiTI+WzuWZ5z3UOxalOL3OZKOqzcD1CFzL6RDMgAV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvBvmxdq9FyTgaj7WvpxL6gIH/x6fQci5FYEdlN20JQ=;
 b=fvVLRonEuBSFwwwfvrSyHYZUbmbeg4baLjxNEAwoEjhn0alBS/DC7XT1c+EmI9Ynq/SGx87ZVpll87i0g9WWMWbg5wPOs/esRPJZSFx3MTbzeYBgDS/sHYBWqqlYGMs4rEZq7eLMMKBdjB1RmwnEAIWh6iBIBIaTQsAsDl3+Ceo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB14799.jpnprd01.prod.outlook.com
 (2603:1096:405:25e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:21:42 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:21:42 +0000
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
Subject: [PATCH v10 09/12] drm: renesas: rz-du: Move the DRM device
 initialization to helpers
Date: Fri, 13 Nov 2026 13:20:05 +0100
Message-ID: <8faecfe7bf81d2c597e8962ece1d43fdcf6b14f7.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0038.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::21) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB14799:EE_
X-MS-Office365-Filtering-Correlation-Id: 20833ce8-bdb0-413f-c247-08df4180acbf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|18002099003|22082099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|38350700014;
X-Microsoft-Antispam-Message-Info: HJ1tYFGEhYc/BVkvZKexKrS4aK+g31fPI70IAU0uI2r8k+bwIqNjUUe99yM7v6zfuYbxRMG98A75V/+pssW89FzGTL+X7/wlj1B+P++EtcYpW2E7I3uSXIw6jR/1G0TBKmg9/nBT3F+Syy2pmI3jXf2E8M0mgp45J3GHd3h5TnQU8E7RmeENDKt6dHaiwML2YZfkHCYEv/6QSAr2MWoeb9cFYtG/CKHQH1PMzEQhqv3R4E32lFmZgRGyq121pv0H6oGcl74Pv1RkTN5w4EPxqPHxYXouDg+FO2OLfNzSdmWGRTrAyi7iASWAtvX0/uZXM1Z69VfrUehNrvZurIWy/gMr3aWrvDtXmXG4ejH7ONJyp/6j6shMWxeQdQiDiG9CbSWxzMdtHRh0SjhnRyj3EgGccunCvBOWL2vQiXHGpkdJzTWLGfxh4GLqfnQ7a6ZdRlsbBsLNwipB/Y+HurreqcjSpLRBT/3uQMJqWAZ9ZqafSC1AY27Ys1b4re9Zb8Suw6Oe0kVTSoHuP7kcvpK+VtxG1HBPpMNoHi2AoOGGSZB9zRPlRr20Nl72kKsAVDaqyWjO3Pxum5J+tKPi5pP/j5fC1lqI2imlHGzK8waJEfwWk+mrQ3Rmw4+z/JQoAqvVbCMao63osrLqkHrIsfRo574o72L/dVAaErqKoXI6jIAgeHdVf07H9PuVgtiNLt2WacLsD+vem6nDFoa1ddFdG7tlSMlANl29fFmfdXPHuFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tSm1brj4eXeTtq0LblW7RqGZfaxNB+tTvBMk7bdIHtCJGI4i7rU3kcF2SXiO?=
 =?us-ascii?Q?IMuWg4VpxTUVafT8G6Nzg95D6BT2SucQnyZGA5AjUo+bZip68vSQE7YTZ/dY?=
 =?us-ascii?Q?Benw742gEPlTCJ3YnHZmSPvSW2n9aVbADKFTMjzw96Gv4AV5AqJD5xtJjEw1?=
 =?us-ascii?Q?R6RDwrXS8fkw90Ui3CLZv1LO6j+bw5pq51kgwd8DBXW8+mqLwvxK1lgh1yOX?=
 =?us-ascii?Q?02b4fVfyYc7apCnFqfqf9ol76Eb1RCFXM6dVYIPRtLaJ9ZJZ7uLAL5GkvI++?=
 =?us-ascii?Q?aqNUUhiHPtFPw6fFCRn5Dfh6GcwbeaaVIAx0isRYapxOejtDtPTcXmsT11mr?=
 =?us-ascii?Q?KPYkCEd+ysmEpFmKp35gdMQCUq8Ok7ZheJMgEPAcPnWW49UG5UauV9AXe+sm?=
 =?us-ascii?Q?9fcJU22A/fKegBZ1p9umjjn9CpH1Q5Nynx9U2itw3uekDdB5aH6VIDdnMhuM?=
 =?us-ascii?Q?sD86N/PfB7in5P8t6xlPTdE+NJQ/oNfcf6XAVi5sgTwHLK0ozgMsRPZkPNvJ?=
 =?us-ascii?Q?PY5zHDU2a0kpRzL85lttI0w0X1y7CeLpPXAX3YsH9DLSToKhuOJEBJLT+J5n?=
 =?us-ascii?Q?CxPz8KPC84SfYenaSbyWAZZFkKcG3kPqxQHi9YntB16iP6o33tVx25aNXD0z?=
 =?us-ascii?Q?EIUhclJNqJ3TtbvFPN36EH9DHNK5bURgm5ZQtXkMI2n+C6lm53RYE+pHD/fW?=
 =?us-ascii?Q?YOcWr38d5sQnNvm0aP8vW1xO9pAeaWQSSfDGDMQDs6zOtsazI1OMpNDzDnBb?=
 =?us-ascii?Q?3YB5Zo64ZLsFZNx2cM20JehBgawhDBQbXDfcWcwJtIze+WEYw4yma4pOApZf?=
 =?us-ascii?Q?jEOKEC4zewTbWizA2u/FhGIjwVka7A7REzA6SPJKdwtwQ8M+JIsy3RUgj0ra?=
 =?us-ascii?Q?uCHzyjWPL2w4N5XHcoqyQ2MFg5HobIEXmIwuZpqOoAXFTMXCIeb1BCLU2Pua?=
 =?us-ascii?Q?pz3wBrcWuuzWd3iTeeRHM+9ej/ZWIBS+t/mrkovW+5kmQTkyruQ31uiHPi61?=
 =?us-ascii?Q?t1p0Sk3UXiyyNG81K8jh0Q92CeY6Lm0CklVawjxITejFac9sfuG30TAxkuM5?=
 =?us-ascii?Q?WACbvCAlD/cSqt03JOaCTpBPAu6bUTm2wUR22RmA00FgL2STjKCijOzEbdk1?=
 =?us-ascii?Q?nDBSYZpdejOVnJypPiMD+XA6gVC9qIS3dDmRIKQsDRX7dJ1uw7ikFxnlkqsZ?=
 =?us-ascii?Q?8YBMKGPpUudpen65ROKv/BhSwvUOCjCIY4UWYrz6r/L6A18oJClswA/7iLYv?=
 =?us-ascii?Q?H086MCk6cvltv7KyW98X0q/RFxxquG2al2oRnDa9f8L/zHS1D7NGsvA8JXjs?=
 =?us-ascii?Q?DY+5Hply8mtoETdJ6jjGrZcSx5c308zSiOPAWUfyQ+MypA5XUe2o4zWGC6ks?=
 =?us-ascii?Q?IwSOkOOeDah24xTJTDvErTonD+dVoUr+Y1w0VbFNm1BUzw76sqXoQsoqeLZ0?=
 =?us-ascii?Q?2LJ3w6UQrbTTlVqu1QFfUDLDU2gg5q6fhAohQNtERNbxKQRofPSdliuPfAPO?=
 =?us-ascii?Q?V6y1Yahndf20TX6Qn2NrZ6QIpcJuMD9ZwP6yh80ib8bGYwA3SM+CccVRWiDs?=
 =?us-ascii?Q?FhgqS3LrKyWTsCwLZ6TpvHZ8AvQLuIhCwc47zm4an7/FuCUqBp8iOf/AcXZV?=
 =?us-ascii?Q?o9tQcnEm2klqYEvR6CXe4z5zLj2EcnizlR1tRhlhKFXPLv9NNwvEydLFuilb?=
 =?us-ascii?Q?hCiX4VFqhe5tSh1hlN1x9x838Wxm3CryTmYkyDQOZgr1Gqr3QBmzORePF9hS?=
 =?us-ascii?Q?Y1kslmL+iq47oyf4+/GOJ18dZY1YnDWe0Y8VjZ8yttXVmBzSH33Y?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20833ce8-bdb0-413f-c247-08df4180acbf
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:21:42.2724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzrPza4euub/JUklpwaiEQCVLOolE10S/DhlkjyXc7dubu2Wh38WI3yNXwYbt5uYw0kmt5qn+zpfs1OLehrME/p0Eb/T1BMY5p+6Iqd6kMTSISaUHoDAsaISUrMQzbE8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14799
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

On RZ/G3E the DRM device can be created and destroyed by the component
master bind/unbind. In preparation for it, move its initialization and
teardown from rzg2l_du_probe()/rzg2l_du_remove() to
rzg2l_du_drm_init()/rzg2l_du_drm_fini() helpers.

No functional change intended.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v9->v10:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 120 +++++++++++--------
 1 file changed, 69 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index d102876c07e1..93d59e2cf8a4 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -184,24 +184,87 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
 }
 
 /* -----------------------------------------------------------------------------
- * Platform driver
+ * DRM device
  */
 
 struct rzg2l_du_drm {
 	struct drm_device ddev;
 };
 
-static void rzg2l_du_remove(struct platform_device *pdev)
+static int rzg2l_du_drm_init(struct device *dev)
 {
-	struct rzg2l_du_device *rcdu = platform_get_drvdata(pdev);
-	struct drm_device *ddev = rcdu->ddev;
+	struct rzg2l_du_device *du = dev_get_drvdata(dev);
+	struct rzg2l_du_drm *rzgdrm;
+	struct drm_device *ddev;
+	int ret;
+
+	rzgdrm = devm_drm_dev_alloc(dev, &rzg2l_du_driver,
+				    struct rzg2l_du_drm, ddev);
+	if (IS_ERR(rzgdrm))
+		return PTR_ERR(rzgdrm);
+
+	ddev = &rzgdrm->ddev;
+
+	ret = rzg2l_du_modeset_init_drm(ddev);
+	if (ret < 0)
+		goto error;
+
+	ret = rzg2l_du_instance_init(du, ddev);
+	if (ret < 0)
+		goto error;
+
+	ret = rzg2l_du_modeset_init_finish(ddev);
+	if (ret < 0)
+		goto error_fini;
+
+	/*
+	 * Register the DRM device with the core and the connectors with
+	 * sysfs.
+	 */
+	ret = drm_dev_register(ddev, 0);
+	if (ret)
+		goto error_fini;
+
+	du->ddev = ddev;
+
+	drm_info(ddev, "Device %s probed\n", dev_name(dev));
+
+	drm_client_setup(ddev, NULL);
+
+	return 0;
+
+error_fini:
+	drm_kms_helper_poll_fini(ddev);
+error:
+	/*
+	 * Don't use dev_err_probe(), as it would overwrite the probe deferral
+	 * reason recorded while initializing the DRM/KMS objects.
+	 */
+	if (ret != -EPROBE_DEFER)
+		dev_err(dev, "failed to initialize DRM/KMS (%d)\n", ret);
+
+	return ret;
+}
+
+static void rzg2l_du_drm_fini(struct device *dev)
+{
+	struct rzg2l_du_device *du = dev_get_drvdata(dev);
+	struct drm_device *ddev = du->ddev;
 
 	drm_dev_unregister(ddev);
 	drm_atomic_helper_shutdown(ddev);
-
 	drm_kms_helper_poll_fini(ddev);
 }
 
+/* -----------------------------------------------------------------------------
+ * Platform driver
+ */
+
+static void rzg2l_du_remove(struct platform_device *pdev)
+{
+	rzg2l_du_drm_fini(&pdev->dev);
+}
+
 static void rzg2l_du_shutdown(struct platform_device *pdev)
 {
 	struct rzg2l_du_device *rcdu = platform_get_drvdata(pdev);
@@ -213,7 +276,6 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 {
 	const struct rzg2l_du_device_info *info;
 	struct rzg2l_du_device *rcdu;
-	struct rzg2l_du_drm *rzgdrm;
 	void __iomem *mmio;
 	int ret;
 
@@ -242,51 +304,7 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 	rcdu->info = info;
 	rcdu->mmio = mmio;
 
-	rzgdrm = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
-				    struct rzg2l_du_drm, ddev);
-	if (IS_ERR(rzgdrm))
-		return PTR_ERR(rzgdrm);
-
-	/* DRM/KMS objects */
-	ret = rzg2l_du_modeset_init_drm(&rzgdrm->ddev);
-	if (ret < 0)
-		goto error;
-
-	ret = rzg2l_du_instance_init(rcdu, &rzgdrm->ddev);
-	if (ret < 0)
-		goto error;
-
-	ret = rzg2l_du_modeset_init_finish(&rzgdrm->ddev);
-	if (ret < 0)
-		goto error_fini;
-
-	/*
-	 * Register the DRM device with the core and the connectors with
-	 * sysfs.
-	 */
-	ret = drm_dev_register(&rzgdrm->ddev, 0);
-	if (ret)
-		goto error_fini;
-
-	rcdu->ddev = &rzgdrm->ddev;
-
-	drm_info(&rzgdrm->ddev, "Device %s probed\n", dev_name(&pdev->dev));
-
-	drm_client_setup(&rzgdrm->ddev, NULL);
-
-	return 0;
-
-error_fini:
-	drm_kms_helper_poll_fini(&rzgdrm->ddev);
-error:
-	/*
-	 * Don't use dev_err_probe(), as it would overwrite the probe deferral
-	 * reason recorded while initializing the DRM/KMS objects.
-	 */
-	if (ret != -EPROBE_DEFER)
-		dev_err(&pdev->dev, "failed to initialize DRM/KMS (%d)\n", ret);
-
-	return ret;
+	return rzg2l_du_drm_init(&pdev->dev);
 }
 
 static struct platform_driver rzg2l_du_platform_driver = {
-- 
2.54.0

