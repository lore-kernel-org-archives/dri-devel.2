Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CDBC44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CEA10F3E8;
	Thu,  9 Jul 2026 07:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="nyCIfRkC";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023117.outbound.protection.outlook.com
 [40.107.159.117])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5D310E470
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 08:47:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxyY6tS1T5aon+A8SA7sJc66UwJEJ1BWt7dCQqNnmgPHu96ZePMrE1kvOGfwzYcSRVgJ240DVTWUuYFgwDhJ7GXQt3T3hXLiuVFbcBWAtueiJ3CVb3ds5rVAPoWj1dLn4RnxujhGQg6tMPPhIENcA/L1XTcGNRkCCR5Zd0BGq/3lCQILtjyGo/UWeSKoBbEF1m66/NCxccDiEiaLFRDWkZIHZDq8l6nf4qLu3eiI9m0qnqj8skCZyjCXsPjzzTfheavnAvFdRUP3qTZL6VUDH+XyGHp8ukyge/L1UGVSM9qenSXU3gAVodop7+yf8SkFSXWjs/7LcFsUfBMFEyqGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm8xaAIvGzjAgKg3zb26ZDk006sav+NRXah1X0ftT4w=;
 b=CQDgZkFHP4UsMc5svrvmCo6plAHWAZcVQTrPGchizS3zN0ghsItt8Vde3d+JCxvgBpj36pIOjtqubhBWlFymoXMyibLwdItM/0p7bh4xBk/w2toQ/rAVPGgLk9kU6fmgFEI/3r2SPPkzblw1mJ3d0jbNp9DryPmhzpRxJ1BnBS0BBuMDQj7VcDpqAqiQ6K3jNkQk7KWHMAfJfv0mRz9wIAKUTvFIKNJiCvDblUqyQxdn1xJDpnK/59xM8LE0AJ8vP3RexKK7Eq56h2Jg9f1EAQU1yckuGIqSKVog4E36hPBsXLzCKWzM0FOlE6wklvkm1HAZG7ChfBOJEYk+IrR2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 109.94.150.189) smtp.rcpttodomain=intel.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm8xaAIvGzjAgKg3zb26ZDk006sav+NRXah1X0ftT4w=;
 b=nyCIfRkCn6arSYalfiDqHz8cfRXzmtuemc1T5SoDbpVAfeiftQQqu7EO/oTobxdy5pUxKIP25iiGov38jSh3U4dEcxnKCIrzU7o4wjpbIEyFYmspBYefh0XN8gG0FIiI8D/LAzZZBeyGbhRHQlBfzGqHsjaqRF/0wn1kRTOy7+k=
Received: from AS4P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::16)
 by AS1PR02MB8004.eurprd02.prod.outlook.com (2603:10a6:20b:4c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 08:47:00 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::a2) by AS4P190CA0027.outlook.office365.com
 (2603:10a6:20b:5d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 08:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 109.94.150.189)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 109.94.150.189 as permitted sender)
 receiver=protection.outlook.com; client-ip=109.94.150.189;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (109.94.150.189) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 08:46:59 +0000
Received: from EXCOP02.bk.prodrive.nl (10.1.0.91) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 7 Jul
 2026 10:46:58 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP02.bk.prodrive.nl (10.1.0.91) with Microsoft SMTP Server id 15.2.2562.43
 via Frontend Transport; Tue, 7 Jul 2026 10:46:58 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
 (envelope-from <paul.geurts@prodrive-technologies.com>)
 id 1wh1SE-009Giu-2f; Tue, 07 Jul 2026 10:46:58 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
 <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Paul Geurts <paul.geurts@prodrive-technologies.com>
Subject: [PATCH] drm/bridge: sn65dsi83: perform host_attach on attach instead
 of probe
Date: Tue, 7 Jul 2026 10:46:55 +0200
Message-ID: <20260707084655.2206320-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|AS1PR02MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbcc51b-069c-432c-b5f5-08dedc044f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|30052699003|1800799024|36860700016|23010399003|376014|7416014|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: N0s74eoDDlna4GLTqfkKFNuSmAIYgY4IM+iQDUQ8KL8iFYjRkRw1vTL9xh44TtJa1OaKNcnY8UfK2iXlko9TBOngQe26H5nOjcONShHqh94dL7sCtImkrtsZECLI/PLF8i8v05B5uDtWXhA09bqDDArQQKmect0vNkwK5iOHXL8AmxE9qiVsynq7Gk2UGcNocKfXbESSPD3AZ/fIOEmm7Edt2/ZJmBdQAh9sJb5mfZ/UJ+nCjuM0SMU14A+m6KiTqYVhFYiV5MgPztHkq1ysaddC6QaUgLNJo9cONzvNsCTtCPayRXMG946GvlBZj7ApwhqYO1b+E7uMlCixl1wjLFfQFW++/nYbeWqH59Vi+PqOuE8UYXD+mLdv6wmo46DPl0/8v4dhAcOIMem/XUViMKGrpbzICtgVXjxDKOzWQCLDPORvEtLWFrWnN+Sg6NQM63HqaEz+p8RNSeUxFVpnpGUJdMFNSBrEWaDBBDN6a0Ut9faOCaHD2JPoOck1UQNXiOWwHnvGB/yiRqa5zwPzLzGWRJ0nNwTu5JNlvf3OZ5NdwSkQ+b1pLgV1n2GAlKud+bFJNxHIpwR0TZ5oRZwcMPNWzOejWUF8NqCQ09Db4ARdJNggBiJOwFs0OIBjigD6ZC4aHMPrxPYBsP9zXznCHdDvJKbTLVirOsJBrlEjr5I76jMgTo03V2qeZyKUbPI9T/hvZGEtF6i/F9gxD83cw274ideQNaCmbOkQ5JwC+mNV+mRpPMfq5hv00V6J3P4U
X-Forefront-Antispam-Report: CIP:109.94.150.189; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:webmail.prodrive.nl; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(30052699003)(1800799024)(36860700016)(23010399003)(376014)(7416014)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qBWW3oVg6SUcFJ2/HcUrJjTFaaZUbBZGJuxjBYDX/niUkhP8W6hcKjA41T5wW9mT20ANHPkNu93YL+oN4sGgfKJtttHT3/VLvMQ82DezWa/RdIA0/mcyfcuBzaIJxnFX31qxU84Bp6ij3cDVTCny2fiMfMna2/CXdzaXmiKHptmeoYBtRZmHKsj1PO4Qg32GwS7akck+2/7VWRY5B6bcddaOtZ1CD1Hb0RtIqoezF3dbgGNIPNBHFys3X3QYgrVH2/e0sQr6B3Yn8iWRw7d3BgNy+nsyiAHAShlaSyoe/geo7x17+HHpUl4M7ZaHXJgU70LK1UkPCjVQsKQzJ7v9nIW4retZ0yb9XekBknfpQw8K/fEQe3XiKTA1K0voTBEoOrz6VJNS7uXNc7Q8SyfzN94672cGUkR/yz1AVZIJiQok2iQNZ+IaGxlhbmVr6gA7
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:46:59.7573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbcc51b-069c-432c-b5f5-08dedc044f12
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60; Ip=[109.94.150.189];
 Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB8004
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

When connecting the sn65dsi83 device to the Samsung MIPI DSI host
controller found in i.MX8M Mini, probing the host and device
infinitely defers, waiting for each other to appear. on probe of the
host, it tries to attach to the device, which has not been probed yet.
It therefore does not register the host, and defers. When the sn65dsi83
probes, it tries to attach to the host, which is not registered as it is
deferred, and thereofore it defers as well, without registering. This
means the two drivers are infinetely waiting for each other to appear.
This is the case on the Samsung MIPI DSI host controller, but might be
the case with other host controllers as well.

Only register the sn65dsi83 on probe, and attach to the host later. This
means the host has a bridge to attache to in probe. When the host
attaches to the bridge, the bridge can attach to the host, breaking the
infinite defer.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
Fixes: 6ef7ee48765f ("drm/bridge: sn65dsi83: Register and attach our DSI device at probe")
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 2d0e767a23b6..d114db8f5307 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -288,6 +288,8 @@ static const int lvds_vod_swing_clock_table[2][4][2] = {
 	},
 };
 
+static int sn65dsi83_host_attach(struct sn65dsi83 *ctx);
+
 static struct sn65dsi83 *bridge_to_sn65dsi83(struct drm_bridge *bridge)
 {
 	return container_of(bridge, struct sn65dsi83, bridge);
@@ -298,6 +300,13 @@ static int sn65dsi83_attach(struct drm_bridge *bridge,
 			    enum drm_bridge_attach_flags flags)
 {
 	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
+	int ret = 0;
+
+	ret = sn65dsi83_host_attach(ctx);
+	if (ret) {
+		dev_err(ctx->dev, "Failed to attach DSI host %d\n", ret);
+		return ret;
+	}
 
 	return drm_bridge_attach(encoder, ctx->panel_bridge,
 				 &ctx->bridge, flags);
@@ -1051,17 +1060,7 @@ static int sn65dsi83_probe(struct i2c_client *client)
 	ctx->bridge.type = DRM_MODE_CONNECTOR_LVDS;
 	drm_bridge_add(&ctx->bridge);
 
-	ret = sn65dsi83_host_attach(ctx);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to attach DSI host\n");
-		goto err_remove_bridge;
-	}
-
 	return 0;
-
-err_remove_bridge:
-	drm_bridge_remove(&ctx->bridge);
-	return ret;
 }
 
 static void sn65dsi83_remove(struct i2c_client *client)
-- 
2.39.2

