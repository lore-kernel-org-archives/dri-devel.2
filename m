Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1522FC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A43F10E84B;
	Mon, 10 Aug 2026 13:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="PKQQIRGP";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013048.outbound.protection.outlook.com
 [52.101.83.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 850A010E846;
 Mon, 10 Aug 2026 13:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlbeIAvGW+1TDqEpR74zdLcYUwrkhapgxiVXpfF2F39VFQjMUjfp1iMnrRuXTUnM5+PeIG6jyTTmF5Yu5uB6YZLyc30xvqLCiWbQlLAC30bt/8KX2y9fhbntmNzG41HeW3ZYPd6x1ZzZVwHDrdWvKvA1/VyiBRPr7u6KdNcAD8EMEH54Ufb0POzAw8hzWt33EHEbor4KYippwo9y9LTTh2EbZkipVLoIhEvw6d60mVFM9B6rMQQTtQy8Z19C09WSkpT/j1UVFMQ+o+0opI7iJGbPjv/wt5E7I6lqjK2OpGZ2oRw8/2zQwJx42+xcJzUq3xyav9I4X0y4Ca1S1H/jdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyC1pDdFT9Shp1cvPmu6ghYNHDBZqey+R1DDC9Z7h2Q=;
 b=Djl/FBoo0xiDEg+yjWur/jD3Zxw/EBkaa2Hi/W8X+gEW0U7qCutGiZOEvSYeODVAIgFscK2Io6ym3/VdHRONZ1sFMS6gQwmrmCzafXBSkUwwrifYTBeDbwqz4eSPTt8zUE3ccKoPbPZqJWbb+Im00izTF3bMBEoO2qcW1bomUrJOwNqScMm0B8D91Ry/IQT20KTz5Vq+c7ETBHxE58CXnMW3r7X5JYZPyejZRf0LHsw6qzCIYxK1toZ96VDSK0e0u6mkIKLjpbHmlHSyt13H0/OovbRPCNR0GM8x+emT/aLM0jvteoZqTyxgT97nRb2g6uqd/nyBJNPVXFx63PWIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyC1pDdFT9Shp1cvPmu6ghYNHDBZqey+R1DDC9Z7h2Q=;
 b=PKQQIRGPR/RZUhwPVWcdyJIcDDAVTPgOKN1NHp+mzNb7gWL+6lBJB44NMlvibFAwZ4cR76lvtOxJ8aC7cmoUhXwVnG4R48bGQREDSZkYZbuf8WX9xlhGekG8+RRIgoulpCvOH+FC+YO/nzUny0t4tzNZ1GHnDdhdm6O24FCG+628WImxnFtO2SxuyYcAC+vpPk/9M+aSUwFyUMJP24IhyD8sEhDiUQ7COe7sVgOv5cg7iKs+W8OJPKTEboHlwDBvW22QBuHjAZ/+eeXvDJx/TEuVmayUAcvnR9U/ePBdIL/rQXUxNyn9W5ttXLvJJl4brPzSx6S1XhiuQmxR99QXWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:13:19 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:13:19 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Inki Dae <inki.dae@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Subject: [PATCH v9 1/2] drm: add <linux/pm_runtime.h> where missing
Date: Mon, 10 Aug 2026 16:13:13 +0300
Message-Id: <20260810131314.452865-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810131314.452865-1-vladimir.oltean@nxp.com>
References: <20260810131314.452865-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM7PR04MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: db34864d-1262-477d-bbe7-08def6e12564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|7416014|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: hytCnns9zUrdARctKvmZlCCWdE5LHyEwZtvC/+OR9naDjPz2lN9fBRbBQcVTSwGqiiOd4LEMt/PYXvl3Ya9sccccKC+qckHG6mx1eW0FrUfKBIoTC7+Ca+hAATolFMIvgvhxR9I6W0YREPP94OQvQjovjUuX7LQw42Q5AbAediqVN/0xFigNXWOBPAOdQas9UP+CEcbgBb0TYfnzLKrYQIRdhYF0fX0uqQpa1IS42Gm+ND4qAhHNEjTFygFK81MxPbJdrX4spyaXoaTOi9ZqkDZI6jk7baWR42FoRuxJXoI9SzBA9l/vlCpj577eDHXB9lo32o7C0oj5StbOEYX8eqRZ4jRbsNceAVeM7ytTAN+JXImUy1GYB9LjABcaSVRY5nKCnfyJ88mv7Ei6yVpUS3Jj0oQOG2aMxW/n1fLQeGd9NpIvoUG5eclYwCI/ZKoIxbMrUHoU0r8m+RQ7XA+oghB4w6J3DBMdO8/7Wcy2oN7D+VAZoxvAZlYTCB94llMuZW27wC0OCr2oExwnKIWmcNdtuL+H2Gi7ZzhLmTmy8EKmFeQ+up7bb2ukxonRi3PdW51VTVnuTzTmBEJkCjjsuWX6lgNWkjS9cxMbvN+K8RKcvLvngreVrfwToYD10DlZBN34pTY/pAdiXv9CAZbRTHcVSEfHllAOCMIDycgGPBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?04AuVrQCmYz+KCZ/yED5MW5v8D61Ot6RkTijxy08tu4PUJEjHJYVmmPs1GRa?=
 =?us-ascii?Q?gdkTFhGIdprHbwZJHFauGfsJzU8FEBLzaMClXM8dxBHQZbbjzOgBrGTt6fb4?=
 =?us-ascii?Q?f9cRKHfZm2/Tykit/lnxix+HJPUHMQpD8zU7b9qAxIVTTw/eOj8lRxPSLuGU?=
 =?us-ascii?Q?chR+cr9PYSzmxmVP32N29k+0VbTWJVDhDWCpenp2U8iHoXQ+RLUrAHAb8+L+?=
 =?us-ascii?Q?nTAgYgB/BcDXRV/v5HJ+H6s/aFvFp0zSfWVsmLwXghyGEi3gOu2mIOic8XcC?=
 =?us-ascii?Q?ezDx7jvM3L+lHqhOSAqq3KrCAXfi3pMQt4X8S0uvuAXpemz0O6VCE+541Xuj?=
 =?us-ascii?Q?QKBz1zbiEaYdcy7SAJ4WK71FS/6cO+iShhDpeq4qM9nWzYNbFhj6E+/cbFbP?=
 =?us-ascii?Q?VDtzjMcv3Csm412St6HkyQGENFBlDvEORCAFHP4Ze3C/LKWi3f7cwiG9du4K?=
 =?us-ascii?Q?rZGHhaxFXdRc7Vdl3nkJQEjn2yEY63yCNDBa2MfIEz3ANgCADwVqJHSEtfb5?=
 =?us-ascii?Q?XLL0ElCG5vbAmwaD/nNsI94Z7bBINGdEMZRfJEE1jVrUqV1QiYZyX+H0yf7H?=
 =?us-ascii?Q?55Rk+T3EHCn4hpmGI6c9RZ6WYelnlOjmIwspVF9AV/Cb5zq+rkGeDdNaPYXs?=
 =?us-ascii?Q?3ogw8bklXRxPgX2/dVi5vpJSA+A9yap0uwl5nFGaHhh7orXE0byJ64aWadWn?=
 =?us-ascii?Q?PgvaK1OHOpCsBMwbd/a1Lc7CsI2mpdLJM9FT07TBuj7tXVz5oOnE0rcd2s8L?=
 =?us-ascii?Q?uqtvjjvoJf3xoXxVKbJx+39r6laFe1dpBb2JDXkf4kMcY37ZLI007IsVZDTJ?=
 =?us-ascii?Q?CdDBrAYHtNUfr5qHDK+HB+WSDMUyrd1Pbpn2iUSG27Zxur+yJVLKAqk14XLh?=
 =?us-ascii?Q?uUyY+CjKfJDxKXLSwPlDiCaADvtHQX9Q1E8kLM+7jXaUV/VDuIlldp8SAICU?=
 =?us-ascii?Q?p2jU6M2J2vxEtPC+rCe5eDWntcEq/CxLydKxqARxlfu2vpGjxMqgVQ72NkPn?=
 =?us-ascii?Q?sDGcZ9QnsHl3E0i3I0EXkLAFeaKPbTridLrOiL1KMJBaOXgh0WpeaxLczeBe?=
 =?us-ascii?Q?6E/rkCYmvlGTvTSNdUE016zBKAaJ0CLEcNn78C9elq4vZhR3gZrx41XIKE3p?=
 =?us-ascii?Q?zdCu3IDE2MqLk8sJW14m/9L0q68gpKRJRpo9Yy7x3j1sgKnEJPhkuSWMtRFH?=
 =?us-ascii?Q?7xIXQFIgQLWhkJeRaHx44UBEMmz6rIS1Ln999ME/xiyF3gnuTusMccIRNoe4?=
 =?us-ascii?Q?zC2LGCt7spk7qgrHmYjdLQ3efkOewrm/ClmWAwXhc6n9+ed5C7dGk3Oa3H+M?=
 =?us-ascii?Q?NrdT4rDOdS//XbZW1WQ6BMjR6P8hQ+o9AGAuKaY6miz3SKm4KpVbIzKOHLaG?=
 =?us-ascii?Q?tZrUvUKPZAcT2ecpDZMZ6L5FKKwYXVGdzOfdpkLmeqkSJx1fs2YVG6PzhOyR?=
 =?us-ascii?Q?qRGGZtREnbuRJGukxb+o3wRV2Ceenw/fWseK+sI3L1RqJHteu8DrdcMVtmPc?=
 =?us-ascii?Q?sj2KBlazvFgh0vEupB+c5itoSH9M8xvGRYgNaDNcFm9r58ZQCwynI01dUNj6?=
 =?us-ascii?Q?GSTyXZ7f6QJD+O1XyxZYXpt5cxn87b4e2ja4BeU1lJ4iKRJYEhYr+tnS0q74?=
 =?us-ascii?Q?1wDwy6Ei6cLItmpllJOUszf4tAUK6cNYw3WbrnAMq4UoZ3vLDvetsRCExKXA?=
 =?us-ascii?Q?jEVOnWt32MYMeDqRwutYu0EWf3tmpuQ+JR4g3lMDD4U4XSftk5o72dzffxYh?=
 =?us-ascii?Q?Tj0xPS34vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db34864d-1262-477d-bbe7-08def6e12564
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:13:18.9554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7cPfEqwXqNUR/n1QtY+94qDncsm5I8WfAIroEuCuTVv+e9vESLNN75VTGuqjamD7ourYL2VCaeP/tusYMeS4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6773
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Multiple DRM bridge drivers use runtime PM operations without
including the proper header, instead relying on transitive inclusion
by <linux/phy/phy.h>.

The PHY subsystem wants to get rid of headers it provides for no reason,
so modify these drivers to include what they need directly.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>

v1->v9: none
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c  | 1 +
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 1 +
 drivers/gpu/drm/bridge/nwl-dsi.c                    | 1 +
 drivers/gpu/drm/bridge/samsung-dsim.c               | 1 +
 drivers/gpu/drm/msm/dp/dp_aux.c                     | 1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c              | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 30c0c0b41d5a..06b427653d21 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/bridge/analogix_dp.h>
 #include <drm/display/drm_dp_aux_bus.h>
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 504a3186ebb3..c99151fdaf03 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -32,6 +32,7 @@
 #include <linux/phy/phy.h>
 #include <linux/phy/phy-dp.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 
diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 09992529f3d8..3d9d0bddcb31 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/sys_soc.h>
diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index e2fc69fc51b6..59eef9697a5e 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/units.h>
 
 #include <video/mipi_display.h>
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index 3825a2fb48e2..5ee22f88bd28 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
 #include <drm/drm_print.h>
 
 #include "dp_reg.h"
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 68aa66915e8a..a78de7eabd15 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -10,6 +10,7 @@
 #include <linux/firmware.h>
 #include <linux/mfd/syscon.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
-- 
2.34.1

