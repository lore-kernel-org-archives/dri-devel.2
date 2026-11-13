Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0C606A882
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=PbbxNkNP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3828C1123EA;
	Fri, 13 Nov 2026 12:21:59 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010004.outbound.protection.outlook.com [52.101.229.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8063B1123CE
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:21:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDsJC59688uyUEaAnHq4MQAdMupmvLmfVeFGOTmdxHNCdo85K77OcTHFOzVdKdXIU8kUxZqnVd4sWuVP5GiOu9K2b3a2DOJflDUqzaS2W4DQVQsTVzfJFVsUVxgUuEWlZ7mlxscaMexjAzTSLl3fiRDT2nhii1MdcaZTMSABfVzuKOD9og2BLrgRQivNeuL7WmQxZK+4JY2cvPOSZTdYUdLBX7hRjp6hUDUvhQtgWnl3hNVyOPuoNlSii7cxwhlUCFxKFxB8sEX6tOp7uCEIbqEys6Q1uvid5FeN5v5TuV37OnU2YWbyXKpKkQZXzk3aGrWDGd1pJOJ3vgs/V5c37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EL4N60iUmm0/GnuwKaPNeqJPkagQFWPrZGlErq6uqrU=;
 b=ANn8F1ME9XhgNRAYTyFjvaLTK+FDHjYdJitxsid1nLgWlx5T3funa62kMMkI7XR7h6R3RpqPrIPighQ0talitXmYtELikQlWmcP89BsYDV5tgYh3N9UNEUveD+qqsn2tmqLnHoBY3+PICb3dASVxF6+bbYaMBuqgstQ4j/TpeOaDkEQYVVqAByUeJLBNHBBEauuGaqvjdkeGB59txjau4XG3nTDnXYHf7ylfVDplN1iD2VzSJivqt8KNQSbDvikdGf47049BfxNcTjmACGfqNOoU1Bwz5TVKAK+8TnNmaLD+YerTUsYVVAWczS+viuNhPOumhArG2nJw1T+4k5v7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL4N60iUmm0/GnuwKaPNeqJPkagQFWPrZGlErq6uqrU=;
 b=PbbxNkNPJxQLfj1R1ijLWCCc2ZQKMGQcMF0yqjXwU9qHmgqbnLPlKRfhGx3WRd9aw/cBqAXLfF5Y29hgzYO8MYMh5ALRfbjBQsqxJNXMGRIZvQxT7TtXbBcgWdWHcj1TqYwfoOMvZRO6EILNRllqJhH4M9qxia9JUy3mb6JVWXI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB14799.jpnprd01.prod.outlook.com
 (2603:1096:405:25e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:21:49 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:21:49 +0000
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
Subject: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU instances
 in one DRM device
Date: Fri, 13 Nov 2026 13:20:06 +0100
Message-ID: <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f80cce58-d29a-48bb-a5d0-08df4180b0f7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|18002099003|22082099003|261009220027099003|261009223027099003|261009221227099003|261009221727099003|261009223327099003|3023799007|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|38350700014;
X-Microsoft-Antispam-Message-Info: IwA/PgSAmcruYr6rigfjwVKCaLAQ6IU3nRZNtthJINWtcMfQQIEnRTc4iXze4cIMPka1yEQA0wNR5LRBJqv2R2WPAOG3l9E+7dyADt76Q/3EiQhymgA/g5PyA6YqJsR8QUtjDcF+R9lTUA9vTot9dGXcBMQ9ilmqpHMdTSCBaTF9A/SKrHRa9djcUEbO6tWfCjxSZQ33V6NRch4uus7X8tCrD2cof4chY8gMmj7dGqWeHAcFS4NjjTn/3gWGHQFllE5MWoiM/iwgs6/j7Xv3YsgAHDbWkNG4rn8JADqRPQtOQc3srIIGUPJBA68gS9GleBE2icadIzyfLMh3wwiuDS6N5lUc56ZQXy9o8mMfEUm0MC/IA/DrVTuOd2/8tIIhcx7OE3V/7zvOYBqgXFHtp3O1tkl6nNde8dXc9bL1Ruz5uoIh3/MzdsAfgLObja4s0XwuR+P2wzUNFhKk+RW+6QR54RoVJSzSTd8QY/x71k/Jj95DCT8LVhQ3XNyqpj43byQwth3ydq+SNo1+wmWN0cRm+J+UufeIowiVr+vAi1+hfsY/NKTOF4oOfWritLJsosEhDL8e+/KZl4Kk2x25Bx8HhW9ujfM1eiPU1fDAtRgEvAh0YLbdtpwNYz3F1FyaCkmxu3D9XXjpdTw3wkFyAl4dWCypxcYbGIGTVxePiaSlqXLcwcRfQmj8Wvqruzlu1vEjH6Xttg6QjW9YNoH+yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(18002099003)(22082099003)(261009220027099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009223327099003)(3023799007)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6093PVN8reX8oIB+IhbathTF8chjC1wKzLHoscMpqNeVKUzujkLDHDsL6h2e?=
 =?us-ascii?Q?BiUbsoZ4Fpg43+zUXXe0B2+Dx5ezy66M8w7KxTPVR6wS8t6E2okW39tCc9Wv?=
 =?us-ascii?Q?qhhNL1L7PGSBWQ+tnALmpqkau2qQfEAyOG5LfDQEMY4KhCKcwR4HGQSZkBGr?=
 =?us-ascii?Q?GNbk87vb9JFN2ggSLBBOqd4NqxXIt+leL+LZTQFnL9SktAbeh6rUryLwMZm+?=
 =?us-ascii?Q?SM5Qe1yghxKPd5v+j0s60udT3PF043C/NpXIDz806XeUrboBcSpp3b3a81Dk?=
 =?us-ascii?Q?QlQyz1jupXaEnYTwWZiBbP35jz+5gZUke3bRJmttz/ZrzXWTGH7xDUPbp9yl?=
 =?us-ascii?Q?yEusCv/Wv4R0eNbowJsy6mAqj8lwQT448k+X7bRmW5svYbgRn0Cl57+BX7fp?=
 =?us-ascii?Q?tNfLl8xhK9n3rXHRnVz3m8d5Bk6mwRSI7zTbAndGtyZoHe4DM0oHOJchkZyK?=
 =?us-ascii?Q?3l1kvHCgRYzS/bJcWbYaW2BsuqJ1+Eko+gFKMbsUIZ42OoqhL1WtSka6MS1l?=
 =?us-ascii?Q?Q9kVkgNT/5VuvqMuul9H1bUcq1sRBAH+SqS9SNKg3dZQlP2060F6U9sxQgg1?=
 =?us-ascii?Q?/1ndabPD1qE7o6mmCDZPPpCof3s1Y1wE7J4avJvsFvXdPLR61Vl8wI4yrzkN?=
 =?us-ascii?Q?+0Wdv+QVEQB5u2seFvaEBZC5pw5fY8zOOvAQ2idAB8d8gJrWJuvb4+wDd70B?=
 =?us-ascii?Q?4xHFdGq/ZsPrAhVEMXo1lJAVK2bESaUxpDm6YQjvovvJjHB8uSKQdfokyS6G?=
 =?us-ascii?Q?W70Uvi6vSXnJM9lp0+PcF5r7Z0t0Pswe2X3FhxG4i7DCGscAH6Y8r9/8pxUC?=
 =?us-ascii?Q?vjgaC/WCHR/8QWzGUXMsQfOwMeW0ii6j/tE8y3+/kPcQ79pePVCcDLE2HEJl?=
 =?us-ascii?Q?ygq5hG0S7VUemeUdoo11c64OZ+qIl31MWOfcIJbJFybusBox1dpHj32s2ugg?=
 =?us-ascii?Q?JzGCbZ04POWtJhA4qA++I3wE+iTnp3+uVFE3CQyzs+2FmlNBXtmWmmk8Nc5Z?=
 =?us-ascii?Q?YEHlak998HJAIhFU9i0uA6T3/+gGohoYU76+9xyQRTF8B4XMfVReB5Ze0yQG?=
 =?us-ascii?Q?0gAUv2T7/9lgiu3KDlPm5s+KxNlzwKEDtvEd+ED+gccKM9+plTGlDOFQuzH2?=
 =?us-ascii?Q?DSpnd+5g6LoQJ1mU/Nv1FUnAC79IeRkKiAdWMQL/z11xTHryCX8zQ8F0dvDO?=
 =?us-ascii?Q?wkkr43F5OtaSnR3G70has3DC+G3yZ8VBMPXhbvXSa049cx+zU63W02pWAC4/?=
 =?us-ascii?Q?NnAybSJD4jP0W20hOF8mY/fdY19eFMtIxTfc+ayhdCQBD37KDpcLTEarvN+W?=
 =?us-ascii?Q?uzIasJ7NB+081QedwgZsN2OkaOr+X2LbHIIfYt+Ay/DWsIAckOpNsS/WGW9G?=
 =?us-ascii?Q?hPPmAg6EI15F1nHa6BVtKxeMKJHGM+ufirutokqhWgPfzb569AyOsY4WK2p/?=
 =?us-ascii?Q?L31ZYM/omcn3OeOH/nqZ/bUOB+wT01qTrlKm7GWAMcZgHzq01ySkf13KS9Hq?=
 =?us-ascii?Q?sdQbUKoizIL8L0CnxQPLsvIK3DMkGdYaG4bdMHOsaVxGM8Epq93A9XBe9xB5?=
 =?us-ascii?Q?mcvnZOBgcUzEKtClnAjDw4ZvCcS2MN1QFPfYxcD7NeJWVVmW1L9nPYIfjeth?=
 =?us-ascii?Q?Uasm+6qyuDMnnOIsfV61LLWAdmPZpOWp+nnSMMWnMTYASFbxS2Gw44T4BjKo?=
 =?us-ascii?Q?JJ6ZTk2+xovzTDaypV6h2uP2j0AJF7j0HTLelP7riRYclLgcm43h5HeazCTX?=
 =?us-ascii?Q?+ndIhAZSKDkgMYue/XFtLKycGtbq6g9koEuB4vM50Ob6btQVHuEf?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80cce58-d29a-48bb-a5d0-08df4180b0f7
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:21:49.3221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oH/rImeaFyexLOZyftOL8c9UmlwZxV0ShAdHNMBZBofq+cnx0M7Y07dw3bkTcRAFV3mDvhYg8CYN14xCZe4oknFJtaxb+GSjq7jyzvo0Hd1cbL1wlItpCKkENIw8P/5z
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

RZ/G3E has two DU instances that share a single DRM device.

Add an RZG2L_DU_FEATURE_COMPONENT flag and use the component framework
for it. The first available DU instance is the master and creates the
DRM device, the other one binds to it as a component.

If only one DU instance is available, it creates the DRM device directly
at probe time, as on SoCs without the flag.

Set the index of each instance to the number of CRTCs already created.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v9->v10:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 ++++++++++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
 2 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 93d59e2cf8a4..873586f2ef28 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -7,6 +7,7 @@
  * Based on rcar_du_drv.c
  */
 
+#include <linux/component.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -14,10 +15,12 @@
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -170,6 +173,7 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
 				  struct drm_device *ddev)
 {
 	struct rzg2l_du_device *rcdu;
+	int ret;
 
 	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
 	if (!rcdu)
@@ -180,9 +184,28 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
 	rcdu->mmio = du->mmio;
 	rcdu->ddev = ddev;
 
-	return rzg2l_du_modeset_init_du(rcdu);
+	rcdu->index = ddev->mode_config.num_crtc;
+
+	ret = rzg2l_du_modeset_init_du(rcdu);
+	if (ret < 0)
+		return ret;
+
+	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) != rcdu->index))
+		return -EINVAL;
+
+	return 0;
 }
 
+static int rzg2l_du_instance_bind(struct device *dev, struct device *master,
+				  void *data)
+{
+	return rzg2l_du_instance_init(dev_get_drvdata(dev), data);
+}
+
+static const struct component_ops rzg2l_du_instance_ops = {
+	.bind = rzg2l_du_instance_bind,
+};
+
 /* -----------------------------------------------------------------------------
  * DRM device
  */
@@ -191,7 +214,7 @@ struct rzg2l_du_drm {
 	struct drm_device ddev;
 };
 
-static int rzg2l_du_drm_init(struct device *dev)
+static int rzg2l_du_drm_init(struct device *dev, bool has_components)
 {
 	struct rzg2l_du_device *du = dev_get_drvdata(dev);
 	struct rzg2l_du_drm *rzgdrm;
@@ -213,6 +236,12 @@ static int rzg2l_du_drm_init(struct device *dev)
 	if (ret < 0)
 		goto error;
 
+	if (has_components) {
+		ret = component_bind_all(dev, ddev);
+		if (ret < 0)
+			goto error;
+	}
+
 	ret = rzg2l_du_modeset_init_finish(ddev);
 	if (ret < 0)
 		goto error_fini;
@@ -235,6 +264,8 @@ static int rzg2l_du_drm_init(struct device *dev)
 
 error_fini:
 	drm_kms_helper_poll_fini(ddev);
+	if (has_components)
+		component_unbind_all(dev, ddev);
 error:
 	/*
 	 * Don't use dev_err_probe(), as it would overwrite the probe deferral
@@ -246,7 +277,7 @@ static int rzg2l_du_drm_init(struct device *dev)
 	return ret;
 }
 
-static void rzg2l_du_drm_fini(struct device *dev)
+static void rzg2l_du_drm_fini(struct device *dev, bool has_components)
 {
 	struct rzg2l_du_device *du = dev_get_drvdata(dev);
 	struct drm_device *ddev = du->ddev;
@@ -254,6 +285,83 @@ static void rzg2l_du_drm_fini(struct device *dev)
 	drm_dev_unregister(ddev);
 	drm_atomic_helper_shutdown(ddev);
 	drm_kms_helper_poll_fini(ddev);
+
+	if (has_components)
+		component_unbind_all(dev, ddev);
+
+	du->ddev = NULL;
+}
+
+/* -----------------------------------------------------------------------------
+ * Component master
+ */
+
+static int rzg2l_du_master_bind(struct device *dev)
+{
+	return rzg2l_du_drm_init(dev, true);
+}
+
+static void rzg2l_du_master_unbind(struct device *dev)
+{
+	rzg2l_du_drm_fini(dev, true);
+}
+
+static const struct component_master_ops rzg2l_du_master_ops = {
+	.bind = rzg2l_du_master_bind,
+	.unbind = rzg2l_du_master_unbind,
+};
+
+static int rzg2l_du_instance_probe(struct rzg2l_du_device *du)
+{
+	struct component_match *match = NULL;
+	const struct of_device_id *of_id;
+	struct device *dev = du->dev;
+
+	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
+		return rzg2l_du_drm_init(dev, false);
+
+	for_each_available_child_of_node_scoped(dev->of_node->parent, np) {
+		of_id = of_match_node(dev->driver->of_match_table, np);
+		if (!of_id || of_id->data != du->info)
+			continue;
+
+		/* The first available DU instance is the component master. */
+		if (!du->is_master) {
+			if (np != dev->of_node)
+				return component_add(dev, &rzg2l_du_instance_ops);
+
+			du->is_master = true;
+			continue;
+		}
+
+		drm_of_component_match_add(dev, &match, component_compare_of, np);
+	}
+
+	if (IS_ERR(match))
+		return PTR_ERR(match);
+
+	if (!match)
+		return rzg2l_du_drm_init(dev, false);
+
+	return component_master_add_with_match(dev, &rzg2l_du_master_ops, match);
+}
+
+static void rzg2l_du_instance_remove(struct rzg2l_du_device *du)
+{
+	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT)) {
+		rzg2l_du_drm_fini(du->dev, false);
+		return;
+	}
+
+	if (!du->is_master) {
+		component_del(du->dev, &rzg2l_du_instance_ops);
+		return;
+	}
+
+	component_master_del(du->dev, &rzg2l_du_master_ops);
+
+	if (du->ddev)
+		rzg2l_du_drm_fini(du->dev, false);
 }
 
 /* -----------------------------------------------------------------------------
@@ -262,7 +370,7 @@ static void rzg2l_du_drm_fini(struct device *dev)
 
 static void rzg2l_du_remove(struct platform_device *pdev)
 {
-	rzg2l_du_drm_fini(&pdev->dev);
+	rzg2l_du_instance_remove(platform_get_drvdata(pdev));
 }
 
 static void rzg2l_du_shutdown(struct platform_device *pdev)
@@ -304,7 +412,7 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 	rcdu->info = info;
 	rcdu->mmio = mmio;
 
-	return rzg2l_du_drm_init(&pdev->dev);
+	return rzg2l_du_instance_probe(rcdu);
 }
 
 static struct platform_driver rzg2l_du_platform_driver = {
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index 2952c9d7348b..4c2e12206d83 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -21,6 +21,7 @@ struct device;
 struct drm_property;
 
 #define RZG2L_DU_FEATURE_DPIO_OE	BIT(0)	/* Has DPIO output enable control */
+#define RZG2L_DU_FEATURE_COMPONENT	BIT(1)	/* Has several DU instances in one DRM device */
 
 enum rzg2l_du_output {
 	RZG2L_DU_OUTPUT_DSI0,
@@ -71,6 +72,7 @@ struct rzg2l_du_device {
 
 	struct drm_device *ddev;
 	unsigned int index;
+	bool is_master;
 
 	struct rzg2l_du_crtc crtcs[RZG2L_DU_MAX_CRTCS];
 	unsigned int num_crtcs;
-- 
2.54.0

