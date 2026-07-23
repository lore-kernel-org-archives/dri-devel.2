Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADFCC531D1
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7353710F10F;
	Thu, 23 Jul 2026 13:26:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="h+0WtQ9l";
	dkim-atps=neutral
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012044.outbound.protection.outlook.com [40.107.75.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8582E10E594
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwOC+0PV9E6jqJzV1cKta73ua8K8fhV36qYl5aS/YPO/kjlZ535HJCiF8X7hO/t+z2drltyggDe2nRGsV/wIrN3EFwIqX1QN0m6pixykxDSHdsMPq8W4CHa/6yYLOTnLGAyR8eUTEBZz5ZckMNO+17LN86RsVgwV8bscvevt54ZZTsJ272F91/l8lkqgolB3gDMSxdN/sBInELY2K8qjsymtXYV/kW/Td6mQAFoKDSELOhF2BwyOoBPa220mEr7D6LB8gZNTDGpVU0sma5dhLGlJMqCsC80zfrs7daVjXvUDEYDkZaTrGtAtxCNwLKJ7VHWEgiZDfk0Fg/YDDmEyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiiz6KA3+eKGkItcoE7cUpLX2bHDJByeONO4yjySnWY=;
 b=DK8913eQMBINrDUUZKSo0zMxnb+QQGC9H9Bj5Fx5NBvaT/RluVq89cmlZF2bmiKF/jv6PSyM/uE5DaAZE4CeIRTRWHohkk7WroZUCYW+0QShxbJALQNmaqmQBpoTriULJzQqXF+acY5nx6IWZvRYJGxrlwoH1e3ACyYnfmc3xm8n0TJPdtGALcz3orfY/9tnVb6h45LDOP6WSBqJtgtPqA3dGIU1UJ1VdXeE6siBF1BO84l8mopB5kBlMrpsv1XPOZKnA9C36+emy34hXiEjL/ZW/8WzCKHPlzYuY3Fl0D08tQzStuYCLSI0StPm8gnJgbG2qfOA2mb/YWVAXW7OIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiiz6KA3+eKGkItcoE7cUpLX2bHDJByeONO4yjySnWY=;
 b=h+0WtQ9lY6gpc8VGRTrshss02m4efyTKHVl0yaj4FA6y7Sou3o5VcV6dSFpNqh9o5xtYyY8/lULDyj/1I81G9XyQMB4QEZ0lIQO05KlP2d1EuuWO6nbeaDhu6SewAtoK7Q2KLefflz+oy0RURBea6MB41omiYcTikb8j4FB4tTiN0rZ9Gt4HLsm6cOs7TsELhhFo/Zg1kQyuOSNNPjCFpPcHHqvQSUn9hcFB4e7tvj7B6w7VEQq/rUBrYqQZVrLfUqtI0QM2owMJFyqdAFVSO1w6vlZreHQQyE4KWv7pq+mDZUY94FRQoL9k8knYqWz0e9FMGVRfXFyxXW2Ntgl11g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8724.apcprd06.prod.outlook.com (2603:1096:d10:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:17:15 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:17:15 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 04/10] drm/bridge: samsung-dsim: Remove redundant dev_err()
Date: Thu, 23 Jul 2026 21:16:36 +0800
Message-Id: <20260723131649.134127-5-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723131649.134127-1-panchuang@vivo.com>
References: <20260723131649.134127-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUYPR06MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca429bf-a560-4d42-3ecb-08dee8bcb6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|38350700014|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zFbxhCOL5Ol8pP8/cPAa8Q8BuaMPUiHPJtSuLJz8bhCzXAC33CBi5zA0NGMkJ/zRGUfv9FhXvcDbTKpqjcI8ggDbC5T6smo+G09isuCvuf+43k9KPPsw573oEJgWoyJc9+HJtL0hvwDBFGWtaawxtCf5QItZFsuD2jfzLlnR1YGF66TL7n+ejP3aUIqSEvHyIWncSzrzNczjBrPuGabYyzcCRbuZH6Kc52MumWgREEQQooievN3iP7m9yGxIqxeEiEpChOMKJJVcGfKg5OLdsJtFJdEPEP3Dc9CjJU0GnOX/xEsvA7wE/CsQtqBSfV4ZisJZFC+LGu8MTiodNGaWHzzWobxkwehjEvLUbSeKp49/LIhjiUovljC6JFdzpn87KESEfH6WP8t9dS2gcVSYiQLewbZ5JTOHbSfWYyg+OXRBhdpyp6l76roaHc8oYcz8KhbH/58AFxXfcnLFXQY0DWV4AvqK0RZRfKlkPrYY3USxSk8oj86MfWg0d8P5N3u7a2f3u9b7WLpppi+GX1dAWKNityrxm6Tn2fOlkIrmR3RnGNBtEBhd5CGaddJOHPtpUr8jhd8/y4kgP1gn+zrJvDtaVyApxnw+mfzUZ+AeR1ryt1UQviFNh9J4YkxgA3Xw7HvypxSmlAm+4g003OGPkFqbGgJXYGMmaMeXzlfHSSZXpxqc47X+idAOWnnEOjlmhsMqZHhUyZ3TSDDPviwbCD78I2AcR0nNFjGzSxlSRPBRNSti5NZfNrMgB8tDw/WB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QHG3nGS/8Z8bQF09vG54EU+hgO7/fSiUEtVJJJhK5jz2wUh7mZr21HlzvxUw?=
 =?us-ascii?Q?4TG4w74oVsRDMSBypDKOm9H69F05rRV8nnB1wTJJfLzTqwiXxYTeaNLl0oSh?=
 =?us-ascii?Q?uLSzUdKoDy/4TYjgSGdr1V0YJWNDOykZmuK0dXnkF0OXvLmXnb34fg9VJPSe?=
 =?us-ascii?Q?QwmkFywbBMZMGAe2u9B/tpEKTCkuOFJZunIXKjorIHSfdCfD7FYs3/0MDYgx?=
 =?us-ascii?Q?J+sXiwEFz8h0CrMItwHBJSdwTKxy2rvw2KW/3b2h59dZyqdRGsyZpA1TOBZV?=
 =?us-ascii?Q?0FE9eGkfG2rkPaCXvB/cPbMDBr5mfiHsWoTRZsqxfmdRx3QopmYJYUbmvJtj?=
 =?us-ascii?Q?odRfM/ivwq0TvH1dNP1oG7IzZsFmR/F1kNWVjwr8HfDQttmvx3PCRuK3Zyo1?=
 =?us-ascii?Q?zsGA3RdVhVUBwWJXsvF3zw/IIBA81Rv2XoaO3ZvUPtUqfyXtmQtT1trNxnTE?=
 =?us-ascii?Q?Vp6Rv+15qAzKrbicKMX6/hGSDcSjFXhxdeNh4QkykA6hjbo1DNKuckISQBbu?=
 =?us-ascii?Q?Q5vDnlLg+Pukwb07DLkqxpG5DVRF9fN7+aaTkU6RxZ1KFApNu0vRyBHt7FuM?=
 =?us-ascii?Q?3JhHdp+IIRTTxpBlAXBQNHaJk9S/KANVXABeXq0hA+A+Z3LCBKC187Uz6c8n?=
 =?us-ascii?Q?JuTYUfpq63gxSrh4t8AhIKOTBSsXDT75Khe7t1BPESdAzoH2eqg0b974uc1W?=
 =?us-ascii?Q?cyHKWfz5Jx1Ue6j1j5PmarKdGOKaJ/xHayS9Ny9sBkv2JfPMT/n0IV2WlBtx?=
 =?us-ascii?Q?M1AOCcRrUc5IRYNHTiBCKYQE24/+Czj+f2ZubrLxNB32b99+9SIMeRJ5DWNC?=
 =?us-ascii?Q?B/wIBAEa+V4ZAhS/TBinTopLK1uFyyY4aqHwIR6AiIn6gki5Cr51QiFnW/1Y?=
 =?us-ascii?Q?vhwyKbSnaTdHyC2de/2rdASUzBRCI/Yla/bME959N5hBzZka/yR8naUHQo0/?=
 =?us-ascii?Q?nM7x84s2S2tuVpwPk5luqGdJgiS7MqJo5yH7TDPjQN97T6ElWALmyABI5pet?=
 =?us-ascii?Q?8FbW8HD3YWizQrL4XXUMWFB3QjfMKckKa0n85pLwbnQCXpoeA6G2XYbU3IwX?=
 =?us-ascii?Q?gAlBW40a0bX4j2mqzaHGo8PfVXLKsUJySLqyUtvvXWujq/nFF8NOZE/fIO1B?=
 =?us-ascii?Q?rfGwijLJbMfdveje/dLQhylNvsN5M2WZ7b4SQb0+ypAFgfED/HDbh9w6wYeo?=
 =?us-ascii?Q?H7DPpGrlFmAZPYY/wuKJoEVfb3Ql0DCN5+IPxDc9tko7BP5ReotJiAkpYQaR?=
 =?us-ascii?Q?YMf6OdXpEaFX7xeFGR8TTo/f5sm1bo720ki64yAsx7M/ziWQDEYkCcrQ5AIf?=
 =?us-ascii?Q?59vkuv4ayGF8imDEOwZxfjZ4OVvrzlztDAJwD/w9qcQS50vF8k5OzWRS/E1O?=
 =?us-ascii?Q?fojsa2D24/XVz2wO7Q/15NKJBXVYWwF1/liDW8bfjPnPWhDT5Cdfd9oiw/Rn?=
 =?us-ascii?Q?GJoudTlQ/Y7IeKB8iIoXK+B2QDsN/wgk3Pj4WkAxC2QnxeqMQlp3NF6426nf?=
 =?us-ascii?Q?Khr3jKl+XmAlT7CMyJWJsa4D5o0pGItjXtuz9c0ohY2UvQORxZMVd53yo4R0?=
 =?us-ascii?Q?gWPdNvcBkk3bvTTkApiDHQAydXHvyNr+Y7QHapldm94WAMLL9P22stRdKifY?=
 =?us-ascii?Q?4ozDGr7Aa4Z6Sf0wIJtAE/iegwPQWmDEUz57gUb0DFnedev6yUC5ymmh6Q2h?=
 =?us-ascii?Q?CkLEZ/1TwwlOlVrRSR28N+CzHkCvVixbCym2xmtyT2UTouAoIcFTj/G4W9nq?=
 =?us-ascii?Q?Ig8SJ37TFA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca429bf-a560-4d42-3ecb-08dee8bcb6fa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:17:15.6486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvMSyHizC7S5lrTf8plezeDNidGV9jyVfzhr3+erPAjvdwaYahwbQlVSOwHE/U+PurhApZrGz9ZPQKcxnSCcig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8724
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:26:48 +0000
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

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_threaded_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 25ab475309e8..991d370daea1 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -2183,10 +2183,8 @@ int samsung_dsim_probe(struct platform_device *pdev)
 					samsung_dsim_irq,
 					IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					dev_name(dev), dsi);
-	if (ret) {
-		dev_err(dev, "failed to request dsi irq\n");
+	if (ret)
 		return ret;
-	}
 
 	ret = samsung_dsim_parse_dt(dsi);
 	if (ret)
-- 
2.34.1

