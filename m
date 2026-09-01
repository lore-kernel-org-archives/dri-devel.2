Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9187C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5F610F3EC;
	Thu,  3 Sep 2026 07:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=axis.com header.i=@axis.com header.b="DFzhhL90";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D285D10ECA4
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQ6Kk8c8+cTPME5vrCWyNl+Shdo4JRJxZsKr41yAp2zgKSQtDCo3NOhonqaTiDG6J0U3cCqFqIPmq4QYjQK19l55/2EITfyhl4/iDpb6baz+BsT4l8nPodwQvxR3XWd7lG4R6jsRZ2D4S6VWGvhLJZEsTN7loyLucLRXJ5vk0TAgvvfrXN8Wxw00my/k4M1U6r/AK+7TEsOyxWzO4svD6lx18sRhX4aTS5EdsgeOpEcOM7gEUKJMK9ozXrBNwKZwUigN9McMB4kBQcP7CJnJ3wRJwiTnNxe7Z/D0qnZ2AIAxQoU+Os04K58HWwWA23dlYvD8yUyKgTV/hvxHJAPn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ0fcQFSvjb3CR+FT4pD182w1AJSezVIuW9/rtuW+Fw=;
 b=UdLkHujU5+GyEjvOTU0ohJ0fFFAXxVqD1Hq6J/F2Hs8KZaqb7I/w9ErVVO70E0tm3zUZrE4sB5aTNdjb9x16fIPI6BNyGyu0IgE9mivj8nMwLqI/Uy8Nm0TC1390UHuse65qDuzJBnZWji6aHqTUax7kwGjqSPNskKPCVzEgzHeiveoTVRqW2ODd1bZ76fvrP1gPA+IW6VuWmfO7SA+qK6B2I2Rm1I3Pnwq7ZA5bZVi/Jlmxmuc+wbxQdGO/9VpjQD7srHfzQLkfZnEoDfkA5WW02CzUosHWIHbG1DTFBzEESv/x7Ty+5aX0EInk1r8D4/VLjYqSkL2l4x38bDhE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=baylibre.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ0fcQFSvjb3CR+FT4pD182w1AJSezVIuW9/rtuW+Fw=;
 b=DFzhhL90mqpQi7SOFMWICF6yXgyWkVAp9DvHjYcfNU1xdfzvatah0uPxyy9ijM7urr5hh8mtolzIe+P6wP5s/FAdlpvlFoXVBjxEhmgMfPraP/1jCOxIut3qJ45YW3r3jix9XVcyWIdEkURW+u8Q3Sah9x8d4UUI8ynrqfhDC3U=
Received: from DU2PR04CA0296.eurprd04.prod.outlook.com (2603:10a6:10:28c::31)
 by VI0PR02MB10773.eurprd02.prod.outlook.com (2603:10a6:800:208::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 11:54:27 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::5d) by DU2PR04CA0296.outlook.office365.com
 (2603:10a6:10:28c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 11:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 1 Sep 2026 11:54:26 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 13:54:26 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 1 Sep 2026 13:54:26 +0200
Received: from pc63130-2524.se.axis.com (pc63130-2524.se.axis.com
 [10.92.173.61])
 by se-intmail01x.se.axis.com (Postfix) with ESMTP id 32600203D;
 Tue,  1 Sep 2026 13:54:26 +0200 (CEST)
Received: by pc63130-2524.se.axis.com (Postfix, from userid 18369)
 id 2EFD160867DA; Tue,  1 Sep 2026 13:54:26 +0200 (CEST)
From: Tobias Johansson <tobias.johansson@axis.com>
Date: Tue, 1 Sep 2026 13:53:24 +0200
Subject: [PATCH RESEND 2/2] drm/tiny: sharp-memory: avoid transmitting
 stale TX buffer data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-flickering-v1-2-eaf7bbf9c000@axis.com>
References: <20260901-flickering-v1-0-eaf7bbf9c000@axis.com>
In-Reply-To: <20260901-flickering-v1-0-eaf7bbf9c000@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039232:EE_|VI0PR02MB10773:EE_
X-MS-Office365-Filtering-Correlation-Id: f694fe29-c9b6-4572-8537-08df081fc606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|7416014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5vJvxwsvDgjmExjuA5jfsKpdpZPfBNl8Y21UEoHFDi6dV/rOgtRMl0xmyDkHS78zV0jxj1URcljQzkq2wqWOTO8yq7hXOI0vom071JOluPlE2NJPv1oy5RLdlZAnxTMeaLtq3kOmxHsaWZF+aM52pfiDJOkV4GPTrBA3PdXDWJseWlEhoC4N/8o3pvPy2ZDIZgAGjokCYupr1PecsynCdcc3+WkIzS52rk+PQdOr8K0nSY3Q3bMeyk9DIW5YcxFkCrmXKKRaKOKuf9NulUy179pHGa3wokHNS6f/QFtE+INYSA0OdBVgLGcjiraAdNCKG6UkbxvBJiac+bjl6Ek5fivVlTaopHEdq/EbDs9joVrCUNDmoy55y1kUgQFL3EYXRLKf86Vg9GggQXu69JmNpoNa/Jb/xtstySay6a2V1bk5gu8JOqtf2SJRVSQAftA//LLtQZmmZQqEZ6VyvuVOENKCLO8yir1taIDAUxcL7y/pcBxwoZb+U2LU56RjDgIj7FA1iG+3xc8I2zoVJEPWCDpsjoXA6AhbiYnvQ241anqQPAKWePd2feiek8b2hfUAFlMNaWpW4XFyzu+1MiJwAUTicueYEeUe2hnYDuQk8sQoM0f91O50Z/RZk1yZTY58W1TJf3PNStI210Pq+sbBXbkRQdUZK332kbUt0rT+c/Uj9t6swI7VIXtzP5UouvZy3hgyYBFPUFfRHWmC+ejKSQ==
X-Forefront-Antispam-Report: CIP:195.60.68.100; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.axis.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(7416014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FEJnpZ2/2crpeS4FQNbeGfUpt/kui3yYf/ZzQ23bI8zg4HnPxVXVoNxvvYgz9H6yU05CYcF1vG6gapVu/Ef4NGFALkZnqnyfWKui4mumXE1HAqaMEMCMofvXxrTW/x1aiMTIU9uqA5/cp4MGmiMyHfPBzE4Ja/9Q17HhuxYuxE5j90nh4/Usf5q7RGLzGT1bBumpeUMj27Iz5UXXDKBH6tYa0P58spU6C5YovyWwaKBsQqmnw0gAEDTaxCRqYui1ZUIfo3k/JS8u2VQrhzjapcXSbSPmcDpT282fuS9/1HnGCSmTjianXwchcOvXEtR3vWm61yYDlci2m/Ua7Zh1RVEBBInbGJRSms2uaiP1BNCjmav5lsoTIkJsgE5AInIgPinos+aLyIWyvUUKjGAZ//Na9u2yEngp3CBH2ISiDTjvJwkMHrLw0u7oi46gFDWz
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:54:26.8604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f694fe29-c9b6-4572-8537-08df081fc606
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af; Ip=[195.60.68.100];
 Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10773
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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
panel contains stale line data from previous updates, resulting
in visible flickering on the display.

sharp_memory_update_display() transmits the entire TX buffer
regardless of how many lines were updated. Entries written by a
previous larger update linger in the buffer and
are retransmitted on every subsequent smaller update, overwriting
the newly written data with stale content.

Fix sharp_memory_update_display() to transmit only the buffer
entries populated by the current update.

Fixes: b8f9f21716fec ("drm/tiny: Add driver for Sharp Memory LCD")
Signed-off-by: Tobias Johansson <tobias.johansson@axis.com>
---
 drivers/gpu/drm/tiny/sharp-memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 595926ed660e..e7521fc6a010 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -155,7 +155,7 @@ static int sharp_memory_update_display(struct sharp_memory_device *smd,
 	u32 pitch = smd->pitch;
 	u8 vcom = smd->vcom;
 	u8 *tx_buffer = smd->tx_buffer;
-	u32 tx_buffer_size = smd->tx_buffer_size;
+	u32 tx_len = 1 + (drm_rect_height(&clip) * pitch);
 
 	mutex_lock(&smd->tx_mutex);
 
@@ -165,7 +165,7 @@ static int sharp_memory_update_display(struct sharp_memory_device *smd,
 	sharp_memory_set_tx_buffer_addresses(&tx_buffer[1], clip, pitch);
 	sharp_memory_set_tx_buffer_data(&tx_buffer[2], fb, vmap, clip, pitch, fmtcnv_state);
 
-	ret = sharp_memory_spi_write(smd->spi, tx_buffer, tx_buffer_size);
+	ret = sharp_memory_spi_write(smd->spi, tx_buffer, tx_len);
 
 	mutex_unlock(&smd->tx_mutex);
 

-- 
2.43.0

