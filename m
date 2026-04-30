Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0AACD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4753910E8E1;
	Thu, 30 Apr 2026 17:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="b/J5JlbZ";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021137.outbound.protection.outlook.com
 [52.101.65.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1544010F355
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 14:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRafwuduajxkB6LHgN4pEGxfH2RaDwaTpYjsJ4/5HIWGll3IPJnALBP70w6QvmIfas80PsZ3++pleWqfPj7e8b9LJHAooq1ho7pLUWqKRvrwXUvNxEHGm0y5B+8XNSJQDMyQjqa/RaPWAlJOFrWCr9+an25dpnDcJWZgRpxbCF53nLbIFLCv4EnpXax9VgO82c4LEc7jKvZURbPcVXygf7u/oc5Jv0PH3p+XtfxS+CnSr8B6+Y9oQMxG9k7MB8P6wH2KKpJCXDuduz6c5kIk7Wr3STi1mDvyMSwP2A9dW9td4uD0wY70U02CPjRV4han7n3Udi6o1ii+a9Y/8YTcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyqWG5o+IUD4QFpF7NY6d9K3XqkvqTQfgarfhYcXc+8=;
 b=AxM5d+KMgvP46ZGa/oOkDg9OX6HFyBWdGvOf7x0ub/pCXKjIFpsg3ba3BTa+xc+E1DsTRR2B06bT0IGzB44F2mUZm4jmes7X8zsLISOLs8+/tm5yZ7hOByJXvqn2RrkbfroTZk+EFqF17ymmCWEpyhoJK2VxqCpMfC8FNuN5tEWp7K+jv4wzQnOEcQGxZrplZsng3h0ell++1s3EnlxhJnm/WqVu0NPKho8VnKNuY5dYt9Er5iCu3KHpcDDBWEBkT5pmf/dXvs/gxh0iFqWy/ptEsfASFM6emcFqFZgHcAWtHhjeeygvY4Mxazzhl5fAaRsKdet09u94IVa7tqHixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.61.153.67) smtp.rcpttodomain=intel.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyqWG5o+IUD4QFpF7NY6d9K3XqkvqTQfgarfhYcXc+8=;
 b=b/J5JlbZNB+6raYfmrda9lpBAj78QfTa2QR6Z3yzcpg0mHODNuO5CtkqdunpF1YJ0AeqlEpcnpWnw30HbP1tp6lK2l/urierg7b7YZSSNn/Gq2gXDMEZqM38MOdI9uYsIDHlyTol3xPsiq7CpVHrYbEHR472vwxSOd0kCgFGbns=
Received: from DU6P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::12)
 by DU4PR02MB12227.eurprd02.prod.outlook.com (2603:10a6:10:631::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 14:35:45 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::c0) by DU6P191CA0012.outlook.office365.com
 (2603:10a6:10:540::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 14:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.61.153.67)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 212.61.153.67 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.61.153.67;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (212.61.153.67) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 14:35:45 +0000
Received: from EXCOP02.bk.prodrive.nl (10.1.0.91) by EXCOP02.bk.prodrive.nl
 (10.1.0.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 30 Apr
 2026 16:35:44 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP02.bk.prodrive.nl (10.1.0.91) with Microsoft SMTP Server id 15.2.1748.39
 via Frontend Transport; Thu, 30 Apr 2026 16:35:44 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
 (envelope-from <paul.geurts@prodrive-technologies.com>)
 id 1wISUS-009ZEG-0a; Thu, 30 Apr 2026 16:35:44 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
 <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <frieder.schrempf@kontron.de>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Paul Geurts <paul.geurts@prodrive-technologies.com>
Subject: [PATCH] drm/bridge: ti-sn65dsi83: Move PLL initialization to
 atomic_enable
Date: Thu, 30 Apr 2026 16:35:42 +0200
Message-ID: <20260430143542.2279584-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D09:EE_|DU4PR02MB12227:EE_
X-MS-Office365-Filtering-Correlation-Id: f64f82d5-3d71-4a4b-2513-08dea6c5c397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|30052699003|7416014|1800799024|36860700016|376014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: qBOB0Bi1QKgcKsgcP+vD/nUyTGZqhy3QnKoFL+k2nRZlCd7r73uTHyxVrfwHVC4TFChCNQgsVqnBS9uX7RVmnP+QS5jSqX81TGiO9b9LzVCaYNg0IpSdUe/V2MdUTU25fqj6pDX9H+u9AE2cpOVvnht1khLRaO/RxVJW9qGOfQWo20QxIR643f0xRYwu3aQ8QSY+aYvORn/p6X7dkBTpuXRhcLJYf6SHZBYqGrb0/0+FM0YLfkHl2E547D5RE4lKWuqtvEQR2XkQC6U4lss4GZWj1f6Bu8SqopmPRgxmzASWxacA76ZHJPWG7UlQIVU7HOa5Q6NU88Czucc/W0iaFDJKRsWtFnO4jVUdfeOMoYjwUklOWnmcUR5zQkbWRMS3XDXz12tLEIT9gY4WkkpGSDQo5GACFQd3zophR0nW+B7Id8tX6oeAjGRhvriBLiewS6dPgoLx5BkihCHMsNGpSAgQbYbWL3oC7DbL2M1X49846f1bMY6AXsnj9etQZRgRkpbxEcQtx5nZiuuYMZK/RU0asre9XfEV5/J0HnxvNt8Tm8gbH/8ih2OEb70mjqzGi8nuzOJ/a5Fd/XzI0SPYY8c7ffAMo7QT0Q9AOKgEwJtCSj/zv1+oGfeLHLFTBDdLR58Dz8s9vtOKlAn1c8oUxSY8F6/FYEuhSnCMqb9KWKnVx3qWQcMHOBbfm1eXsbEWFThXfADui5t1b/DVNEZPA5OoaW/Vzb1bBI8bxVgbc5Kaw4fycOQP9Jg12zlQNg6X4Yu/dJPJldmoxH4gAuRV5pkpJAtY+LkiYmf1/AlHT7kOokIc28XiXLoIdnnh2TOb
X-Forefront-Antispam-Report: CIP:212.61.153.67; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:webmail.prodrive.nl; PTR:mail.prodrive-technologies.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(30052699003)(7416014)(1800799024)(36860700016)(376014)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F88Tji8Z+Gysz2RHiahGAsxXt6+HVBYXDEpzM7xagHIDOKa6tPyxcA/v8J4laoIr6xES5OweWRz9FJKb//hkjxNTJljZqPgAUl7s27Eq6pgvjfrcxiWekfqWiSmfpBFvpZY+bj0v9WRkQQtAS9AWlTMvaGC6nVwUXNtNvYKxa4QkB8SBUFyJvZ2EIUCF9sW2dNNUKBKLuC+uQuI2Osk54iC/R1sAVtl/yyJK0AOHQnTt31a/T8rcyoU9TRw0jKMFEl04JM2IeH/cXB+nFmJCF+BBftb+rYThcFs1mESDzWPIagOqlD2SjH+b6vminC2rphT4P9zotO34LlKavyd4ku4IX+sW5em5zFcwg3pMG7+AFmfYLw4uydr4SB0AQwCoz2v92/ydZXY7lKt88QmT8Yoo20es5FR3ujmvXEl1A+bTaF/VXPDIonqszzEZUEs5
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 14:35:45.2799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f64f82d5-3d71-4a4b-2513-08dea6c5c397
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60; Ip=[212.61.153.67];
 Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR02MB12227
X-Mailman-Approved-At: Thu, 30 Apr 2026 17:06:40 +0000
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

Some MIPI DSI encoder drivers, like the Samsung DSI controller found in
i.MX8M Mini, enable the DSI clock on encoder enable. The sn65dsi83
pre_enable is executed before the DSIM encoder enable. As the DSI input
clock is the PLL input clock, the PLL cannot be locked in pre_enable.

Enable and lock the PLL in enable instead of pre_enable, to make sure
the input clock is available.

Fixes: dd9e329af723 ("drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet spec")
Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 35 +++++++++++++--------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 17a885244e1e..018e524c473c 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -525,7 +525,6 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 	struct drm_crtc *crtc;
 	bool lvds_format_24bpp;
 	bool lvds_format_jeida;
-	unsigned int pval;
 	__le16 le16val;
 	u16 val;
 	int ret;
@@ -670,6 +669,21 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 		     mode->vsync_start - mode->vdisplay);
 	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN, 0x00);
 
+	devm_add_action(ctx->dev, sn65dsi83_release_resources, ctx);
+err_exit:
+	drm_bridge_exit(idx);
+}
+
+static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
+				    struct drm_atomic_state *state)
+{
+	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
+	unsigned int pval;
+	int idx, ret;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
+
 	/* Enable PLL */
 	regmap_write(ctx->regmap, REG_RC_PLL_EN, REG_RC_PLL_EN_PLL_EN);
 	usleep_range(3000, 4000);
@@ -680,7 +694,7 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 		dev_err(ctx->dev, "failed to lock PLL, ret=%i\n", ret);
 		/* On failure, disable PLL again and exit. */
 		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
-		goto err_add_action;
+		goto out;
 	}
 
 	/* Trigger reset after CSR register update. */
@@ -689,22 +703,6 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 	/* Wait for 10ms after soft reset as specified in datasheet */
 	usleep_range(10000, 12000);
 
-err_add_action:
-	devm_add_action(ctx->dev, sn65dsi83_release_resources, ctx);
-err_exit:
-	drm_bridge_exit(idx);
-}
-
-static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
-				    struct drm_atomic_state *state)
-{
-	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
-	unsigned int pval;
-	int idx;
-
-	if (!drm_bridge_enter(bridge, &idx))
-		return;
-
 	/* Clear all errors that got asserted during initialization. */
 	regmap_read(ctx->regmap, REG_IRQ_STAT, &pval);
 	regmap_write(ctx->regmap, REG_IRQ_STAT, pval);
@@ -724,6 +722,7 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
 		sn65dsi83_monitor_start(ctx);
 	}
 
+out:
 	drm_bridge_exit(idx);
 }
 
-- 
2.39.2

