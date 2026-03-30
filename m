Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C008AFB3CE0
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF44B10E4FA;
	Mon, 30 Mar 2026 09:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=axis.com header.i=@axis.com header.b="j/AeolFv";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2495410E3C1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tA1VJy/Yh7tSeXXf+DS84ip2WmD4LpGj6sqEeB7m3rvo0vsfDNFt+aoxkKNLrruhRIAbF11s0eB8ab2g0kHaO/45Oyc+mTp2qHUr0X7N57IF1WcX5WeoB4K3UO9KeOSzjnXSQqgakkKi/jS9O1hkNGf4GSqBEgI7w88BZc8enf3XZNguIFPlELzAF1oY4v2B+H/xJPpCjlkYV3xAzXhzrgutHpyiTPRJrLBWEiKL7YLoueBPxmkt73u74TlfuW1UXywNF7Wwho/behidVJNUIpB2lAj0qdcnOLp7ajqavtSPThH0AuIYBbboaTM0GelaysVbCJW9JgYauCuVag69sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCu3gjKeiE0fqeVwJuiS1jFx4PaIzKW1OG4qxDjshE4=;
 b=QxmHEEGAowoB0PxZ4/d0V++nWTEFoRMI7jtmUQ1qgkakT7n9Cky26mwl2IZlVSnPPJk+iMh5k6Y4t3iGWmiqfLoW244NDFNckrzENQKj/4ahmUAk0w7VgAL6iInNT3SIM+YUis+BZyUoypVtS0+pBGKzioMVIRAA1KB2E2GTb33y16fV8Fu3rZwvCqdDTe75SCt03Q8EvrkKOvvbvAt7cwlCdTPoLoOMm9Zz6I7JZp0hctNl4gvvANwPLfZC9wc7X/+yf6w/TehzsBoI2lqQEJEYqzPWesnIrajdEIiek0l1oIH6VtG8bdkXoUuFaTKSV21SH8h/ckAnIaPx0Icqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=baylibre.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCu3gjKeiE0fqeVwJuiS1jFx4PaIzKW1OG4qxDjshE4=;
 b=j/AeolFvonYkl4L20/PsuG65U7zayUwc6e0VOIKJekKyUc8U5D57azqya/DiyDMogFhpA+5lLpF/0axnIGZLpYWPo41dld6/8UgW10rw9dWg0e7VS90haV5OKyatJtpyiHJnAtMeXbg2psBDZJNAeVQPQSciRzMCeWP8FJvAS6g=
Received: from DUZPR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::8) by DB9PR02MB8910.eurprd02.prod.outlook.com
 (2603:10a6:10:3da::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 07:20:34 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::a0) by DUZPR01CA0002.outlook.office365.com
 (2603:10a6:10:3c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 07:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 30 Mar 2026 07:20:34 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Mon, 30 Mar
 2026 09:20:33 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 30 Mar
 2026 09:20:32 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 30 Mar 2026 09:20:32 +0200
Received: from pc63130-2524.se.axis.com (pc63130-2524.se.axis.com
 [10.92.173.61])
 by se-intmail02x.se.axis.com (Postfix) with ESMTP id DD3872A48;
 Mon, 30 Mar 2026 09:20:32 +0200 (CEST)
Received: by pc63130-2524.se.axis.com (Postfix, from userid 18369)
 id D9450602F3D3; Mon, 30 Mar 2026 09:20:32 +0200 (CEST)
From: Tobias Johansson <tobias.johansson@axis.com>
Date: Mon, 30 Mar 2026 09:20:16 +0200
Subject: [PATCH 1/2] drm/tiny: sharp-memory: fix line address assignment on
 partial update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260330-flickering-v1-1-5a192bf4b93d@axis.com>
References: <20260330-flickering-v1-0-5a192bf4b93d@axis.com>
In-Reply-To: <20260330-flickering-v1-0-5a192bf4b93d@axis.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, "Mehdi
 Djait" <mehdi.djait@bootlin.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Tobias
 Johansson" <tobias.johansson@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|DB9PR02MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 4feaccaf-9a1c-48b7-c882-08de8e2cd5bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: dQMhzpji0ViXqTdEDBY9O2Oeznbeb1JxuU2omLbJxom9Fjv79vJbq9fvM1VrWNMmsmvCSb0V1XDOwhYk9PP3WJm4lPMaIBWRzNsfksQRfeNHUCbr6KCoGOjibiVM80lF2+jiTbbNgvqCScASfNQ6SpytxmORyLmkCPyprTkiXalMdY+S0g2PfExumnacIfdHE8mw/N2YiNXFfRR9rSHAUgcUUiBypZGzKpyRGPQjJXLDdF55CY6MJWbCoQtb/WSWTjPlp9LbyezTctziWN4K/b2DSKeI7o5q0p5dQC4IgasoRKNoFytyXv/GqJUO8FuIWM9e0O0gQ2pW0n6qLGOCex6x2VfkFhGOwreMSAyEm/qQFWDKK9JAQsgEZvZU41Brx1hFxirDU4dqOMm2M+G974oBpjcumNTVRk94spnBwEvr7SKOJVu+1FAuEE7pylsgJAPvEq7ULJElJzcuWlQPhofZ8bIBI7v7LYPOQ/kH4Fxgl9qFsNRwtu4bu2WXzD9DJnZuKgZQF+wrYRmR4QRD+dKE9fjmVjT3iZ+IGwE6UQt0sXr5HkAWMZfLAdeZ+0dUsGP8p4IZBBNVWdJPGs191EhybCPeZbnT1Basd+lbj7U0K2O4XHG9Ll/LyM0alHRj478uWB1pCINraOSw5IJHXyPA1YF8ZIELSCj+MavR1zSeUjdA5lAhzZTvFDvmQkdff46GVO1jkThHpj0rqiAqhv0FqA2y8cULtkgtqsbiN/mZ4UrsEaN47IPG0UInWy9KeINoBX0RbzOcA+grViWsUQ==
X-Forefront-Antispam-Report: CIP:195.60.68.100; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.axis.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mKKprRYtT+uGB00C1bq/a0k6KTY62z6roV6mGTHmymRg2dOUd1tWYaAJFJILWB5LLEOUAMUm9gbY9KmkFdcvzoH2QncJnbDacj99Bis7BX1FNPXzkXU45EqY9sIkafXUqDYlMcmiEsFRapAeIVDYmtwHlmmnV3weUK6wLQhlnBpXiShTuJiuMNKYa5fJ1hWWbd3l2fJrrNShU/Dm1FIrBcPMTzIhfsguyjMy+CrsPFBzYJ5GSSULjTisNx12BNcfvDMleOh9DGVz/ejqCNoTwSOY+39eyhMQlfxL5MAMdFjzhKUROFAcQeQ51ydPFBDTEmY6igahiiac2wQSwIxQWFqNLnBqPDhJqjEE/XCYu/8INl/nogHUzjqBySgSAwejiuEZj2XovCtn6W8xP50pBvl8oEdNZp+aMTjG201XL02PpOQYh2YTymn20/jNh9yu
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 07:20:34.8396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feaccaf-9a1c-48b7-c882-08de8e2cd5bd
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af; Ip=[195.60.68.100];
 Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8910
X-Mailman-Approved-At: Mon, 30 Mar 2026 09:06:21 +0000
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

When only a subset of lines is dirty, the TX buffer sent to the
panel contains incorrect line addresses, resulting in visible
flickering on the display.

sharp_memory_set_tx_buffer_addresses() iterates from line 0 to the
last damaged line, assigning addresses sequentially from 1. When
only lines 10-20 are dirty, line 10's pixel data is written to the
slot with address 1 instead of address 11, corrupting the address-
to-data mapping.

Fix sharp_memory_set_tx_buffer_addresses() to iterate over only the
damaged line count and offset assigned addresses by the clip start,
so that addresses match the pixel data that follows.

Fixes: b8f9f21716fec ("drm/tiny: Add driver for Sharp Memory LCD")
Signed-off-by: Tobias Johansson <tobias.johansson@axis.com>
---
 drivers/gpu/drm/tiny/sharp-memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index cbf69460ebf3..595926ed660e 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -120,8 +120,8 @@ static inline void sharp_memory_set_tx_buffer_addresses(u8 *buffer,
 							struct drm_rect clip,
 							u32 pitch)
 {
-	for (u32 line = 0; line < clip.y2; ++line)
-		buffer[line * pitch] = line + 1;
+	for (u32 line = 0; line < drm_rect_height(&clip); ++line)
+		buffer[line * pitch] = clip.y1 + line + 1;
 }
 
 static void sharp_memory_set_tx_buffer_data(u8 *buffer,

-- 
2.43.0

