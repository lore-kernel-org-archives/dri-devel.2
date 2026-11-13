Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF9606A883
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=R+AVPhqg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE25810E0FD;
	Fri, 13 Nov 2026 12:21:44 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010003.outbound.protection.outlook.com [52.101.229.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A257A10E7C4
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsQEJQf1Zye4UpwEcW7DLGmW5muLBZY7++h8ZJxkA4mmhEnoQw0HEEMkQhw3BYb2vO9xe6UbsB3E7O3ly+IH8N64hCVP12lGXM0iai4gnnXJpTZG6icR+PSV2JV83ENRzLwVLWNhdyM775Tqgqw6kFGfA5qh6/ns2uieuknLpOLfPOK9tLimDrmmsSxNsUg/p32momsMGGl+8i0TzJ/3uif/1o8NtWH/ZtwQA9Zz12Ewc3eE9UEwDDkH01+5rHnEECBaEY9ULF6stBzh8g6ZC7tjadPugHPunWYtbRPPNare0sPw6mL3HOL3BQIdf42nHmlD3BJzUP3FSKAFi8wfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXD/8eoK5ljlefrRfz7qoiZkyc5GLDZT2W640zTIlm8=;
 b=tC7L2grw80mqbn6GUtc6QYfQQC176z3yRIuDyOHweCd8FG65o7IoZqUYEU1EeGUeagaSy4TWbyITFw+VnEnq9VdOxBB6gBqLS6r0UVlo/u3C+6b4In39yzE4XYRLbitRcPCk5L5jp4CsE5AvJ4m3N5Ymu1WUZhKYMUY9Ig8rto1r3pvZrOJNT7hMSrvhsQXDOQAkAcOgpZw9wXz/WApEPZAiKnYc95TGdGYYGOA/YcFpc4K+QbtsipgHK3cXxehEdipxMHQ5iiiStKKMVOTMVfqxGKnZO+WJLJeOwBGkYB/6gjWITGg/4SBPq4BO71pUkNWGfoSHTFas+VP1q/b6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXD/8eoK5ljlefrRfz7qoiZkyc5GLDZT2W640zTIlm8=;
 b=R+AVPhqg6LL1vqwfaCR7+xrs4VG3PglnEpQY5Vgv9dgDu93FpTWETt3a+8cw02XqJ42K2ZdJbSNzn+unSjylVNMP0NrNW6J+WzmY+blT/vvxYrno8urfLa1tDZZx/igA3qAdCef0kc+LNluifKxveHoELXKZ+Q28qmz0gJAdheI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB14799.jpnprd01.prod.outlook.com
 (2603:1096:405:25e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:21:35 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:21:35 +0000
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
Subject: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance from
 the DRM device
Date: Fri, 13 Nov 2026 13:20:04 +0100
Message-ID: <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: d79df4f5-a981-4d84-3686-08df4180a89d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|38350700014;
X-Microsoft-Antispam-Message-Info: Vv2BgMiA0cynZtTtUjwsclTtDNAoJTQH1mXFwFHaccIlEJCeJBbaVA/1HPMb7A1Cp7Gu5W//J/eHjSbMx/Dq+WDpTJGKzV2sEIJGwRQtoq16qvAUyGug2kziEZIUwnh9zmdhrRB7HUenQ4mL8Oef939vrm/g7M6fYleTc+DbzNBh6wkB7D+XqgoTYl1PUnmv387r6fiuTn/SfksEkLYKuPTY/8kZHcdpPSFBOmCLfKmp/ATR4yV7V2KBNpxJr0iTugvVCKVP8v8I5Gnj0ZqI1C4trYbOVW9XEb+JQaTlXETgyfoyLNcnzOa8TjGSFvlPkVf5VNYuTdaBMYrJFSJQyoJS5ficVX16g4/BFTJHqOe/VbfBfqxb1Xxg0pwiGtEeFS8jeD89+HrzlyZDqcFKRuXmtRYXNdwfCcmsSEP9nJpOpdTXLRb6IttmX0eFfCWS6ych2t0UHS098jHQGlYAojaf7Ko2DuxdQOmS76ZuLTAibqaeELR/ZN9mhN8dqR63c8TSoCRSWRIH7DLwIo4Pkpfb4Dp6q0SpKuYX98c6OS3rvdcOUAkryPl1tgIVXSUtXqFGJpoz6cUlBc6hHGPhvmzcJjoIYrwfivAtbCgzVG9nUJfKXq5LX56Ue1FP27AKcPuKkmdAgjWwL1LTeEYicTATzRXIMj4Dsun/d5mhHK9qwiMGchwwzk7oONbIOy3q9CGVOf7i05Ji97fuJQjt39ideOOXk2FsyuIZQ5wdfAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kDKG/bmyNeurCXHh0ThN2Q+9cFCmRl3bNEJ22DDxU79gBPvCrxXMUYWw8vNO?=
 =?us-ascii?Q?pip/x4zR90m4Vwh2aKLh9MBZ0BO/omhFrehWHfGgazM+b3uDqEJTakkFQTr3?=
 =?us-ascii?Q?Cv+YLKLXpHqq1V4Piutl2dLIYn1RI8SvLjy0WwAjP7ui+jg6xiHE/OOjitAW?=
 =?us-ascii?Q?1xlfyCaBoLQSfmdFjNt6226svabpd98YIHD7x8g/JIm3dNM2r76NSl2mkxsQ?=
 =?us-ascii?Q?vjWC/JYdBtP8J9GUHjy7yo5D5/Ub7bkFTygcDxfFE2c/w+3vnJQ4PlS82XEk?=
 =?us-ascii?Q?F8rQP5z2hLJ57b9pQqNbmXGTMBYj6IgPRCv/LRdmS85zK6QIxfX55b5xBwMH?=
 =?us-ascii?Q?ZMCbtv17EueKG23yacdSaZgd0MAg9vUsKdpOb989A9y/7xv3W63H0v+F+3YG?=
 =?us-ascii?Q?wLgWkkhrBB0nLJ12MEbAPn9kaw+img+EvOsDLUC0ozI28+WFwCW1yvfhsE+0?=
 =?us-ascii?Q?jOHbapQJD2MLqbRqmY8zpUdTghQRn5Zqfr/5TRqW0epA6kXHsjbccd1uZarg?=
 =?us-ascii?Q?YGH7ZJ+5AN0+6WlQHHaHdGLBdcO7fe04Bx+8plRQU80lhY/wkBIKfuyyFI6K?=
 =?us-ascii?Q?Z+Zn6KkzV+M10Gir/H8qpwbOuHegdskariLj6ZHL4soUs5/EpG4EHduyRMNd?=
 =?us-ascii?Q?A8vpfFomP79C1Ee3I7mbkpO8asNOKG8cd8UcVxOxRiZCj/KOnbEGtrJLKenP?=
 =?us-ascii?Q?Eu1/WwXjyXLHQBmYFuQxM+ztK0bOXGJO9ZML8hhrUuXsWoreKcpFBoFlpg0+?=
 =?us-ascii?Q?WRl1eNlxUnoADxIbvIBiL063AzHj9PJMzgksb371f7njAFVZNaCqhLrH5BWn?=
 =?us-ascii?Q?xevAWStsOBQ8RLaAP9b/975XcbVVL496mgVH1FC2MSY09JQbRZfIAvFkx0SO?=
 =?us-ascii?Q?NvqN1nQ3zmFky7mDdDMNGn11pZtfTUsobXJP/zcLSdDLMSITu+/Ae0NNEk0H?=
 =?us-ascii?Q?aTe8MewQLvYo0uXeuAxav4SEDzQ7VWzDnMIZ4lgyPDmbe6FCSGBy5dQck2SG?=
 =?us-ascii?Q?TFc3J/yMJ2nHWltpbwpZcQG6JYsgj+iFGHF6WcxhtFK3MwVBYKJoL8i6lerB?=
 =?us-ascii?Q?CAv9zEvv1yK2ZNJp30v+aQP3M+HwU0nW2jj0A+ZDwIuTMIEZ/VvFeWUPS+Ot?=
 =?us-ascii?Q?opeA8J92wq7sRJstdySCwPXqMkyTOYLlr1dCNWr70NDcmT0ofiZuiCFEvIYs?=
 =?us-ascii?Q?SBOieAFak/Om38PTxM4ofV3dk59SbiO02CSLl4cqIuyXszW2zzbVmsghJp0n?=
 =?us-ascii?Q?E/1+9lLlGRAB+uNUuGqMzrMKFGgIb6oAxehyzmfvyVCt7leexklnNV1IWF3X?=
 =?us-ascii?Q?uelaD2e/eadx10Ps9aq1PzooRPW7j8osdyP0sITm4ehnAQ9e/LFJnHedJotN?=
 =?us-ascii?Q?2u0huSjTA5JX3V+fSgNkDQlG3OpYA5+JDGKJiiRHvIza3D0gNVbLQxKy6HWl?=
 =?us-ascii?Q?cCtpC698OYjQue12pCTJLCeGSwk6S3b/t9Fix5VvMuHSYL40t9mTo3XQ+PBT?=
 =?us-ascii?Q?UwM/S7nSZwJNerH3K02Mf3mCajJ2V8xDeNDdEUBWq1p3kU4gfcRkMun0O/z4?=
 =?us-ascii?Q?5/g/nvD0aPIOZN8vrjO5DXfCjzfL+X0WkNgEbl36/fFQXd6z/oC0bIha6loc?=
 =?us-ascii?Q?eIclqalD/0mxZlsAp8zag7AvvtbbxDfMQz4Iue7S9KQLjVSRzCXwOuqae0Ww?=
 =?us-ascii?Q?76OpLafxp6M/envCnbg8T1dpV1WenQeOHBo1bVDdxOo+67EunlHlZVxV9nCo?=
 =?us-ascii?Q?TxYpuPphpmC2FAv/TN+IGRWl4hdnxixS8aSCimTNc4TfEhkjNPHG?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79df4f5-a981-4d84-3686-08df4180a89d
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:21:35.3353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gr1+mdctKuthVUP8c5AacUUpwCtqDsEGVHDz7Xqwl5U/DImtL8MqoMpv+bmsw/2ioD2rkk7eLEFcsPpBYZdqC1Oh/4OMrLKMIc2PzAPePMqmUUHmLv+F1Q2IKA+Q+w5/
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

On RZ/G3E two DU instances share a DRM device, which can only be
created once both instances have been probed.

Split the DU device structure: keep the match data and the registers in
a structure allocated with the platform device, and allocate the KMS
objects with the DRM device in a new rzg2l_du_instance_init() helper,
as they are released with it.

No functional change intended.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v9->v10:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 61 ++++++++++++++------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index d3cccbdf9012..d102876c07e1 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -162,6 +162,27 @@ static int rzg2l_du_pm_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
 				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
 
+/* -----------------------------------------------------------------------------
+ * DU instance
+ */
+
+static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
+				  struct drm_device *ddev)
+{
+	struct rzg2l_du_device *rcdu;
+
+	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
+	if (!rcdu)
+		return -ENOMEM;
+
+	rcdu->dev = du->dev;
+	rcdu->info = du->info;
+	rcdu->mmio = du->mmio;
+	rcdu->ddev = ddev;
+
+	return rzg2l_du_modeset_init_du(rcdu);
+}
+
 /* -----------------------------------------------------------------------------
  * Platform driver
  */
@@ -190,44 +211,48 @@ static void rzg2l_du_shutdown(struct platform_device *pdev)
 
 static int rzg2l_du_probe(struct platform_device *pdev)
 {
+	const struct rzg2l_du_device_info *info;
 	struct rzg2l_du_device *rcdu;
 	struct rzg2l_du_drm *rzgdrm;
+	void __iomem *mmio;
 	int ret;
 
 	if (drm_firmware_drivers_only())
 		return -ENODEV;
 
-	/* Allocate and initialize the RZ/G2L device structure. */
-	rzgdrm = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
-				    struct rzg2l_du_drm, ddev);
-	if (IS_ERR(rzgdrm))
-		return PTR_ERR(rzgdrm);
+	info = of_device_get_match_data(&pdev->dev);
+
+	/* I/O resources */
+	mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
+
+	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
 
-	rcdu = drmm_kzalloc(&rzgdrm->ddev, sizeof(*rcdu), GFP_KERNEL);
+	/* Allocate and initialize the RZ/G2L device structure. */
+	rcdu = devm_kzalloc(&pdev->dev, sizeof(*rcdu), GFP_KERNEL);
 	if (!rcdu)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, rcdu);
 
 	rcdu->dev = &pdev->dev;
-	rcdu->info = of_device_get_match_data(rcdu->dev);
-	rcdu->ddev = &rzgdrm->ddev;
-
-	/* I/O resources */
-	rcdu->mmio = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(rcdu->mmio))
-		return PTR_ERR(rcdu->mmio);
+	rcdu->info = info;
+	rcdu->mmio = mmio;
 
-	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
+	rzgdrm = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
+				    struct rzg2l_du_drm, ddev);
+	if (IS_ERR(rzgdrm))
+		return PTR_ERR(rzgdrm);
 
 	/* DRM/KMS objects */
 	ret = rzg2l_du_modeset_init_drm(&rzgdrm->ddev);
 	if (ret < 0)
 		goto error;
 
-	ret = rzg2l_du_modeset_init_du(rcdu);
+	ret = rzg2l_du_instance_init(rcdu, &rzgdrm->ddev);
 	if (ret < 0)
 		goto error;
 
@@ -243,6 +268,8 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_fini;
 
+	rcdu->ddev = &rzgdrm->ddev;
+
 	drm_info(&rzgdrm->ddev, "Device %s probed\n", dev_name(&pdev->dev));
 
 	drm_client_setup(&rzgdrm->ddev, NULL);
-- 
2.54.0

