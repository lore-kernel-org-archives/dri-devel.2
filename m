Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D43CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E37F10F145;
	Thu, 25 Jun 2026 07:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="WPjih2wn";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazolkn19010022.outbound.protection.outlook.com
 [52.103.32.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C27D510E135
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 21:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRPBL/1ogUEt/SL05sA/hDTC6doJyTnl3bArENb9vzYy6jPgMo2d1pEil+Wh1LefAF9RxSxK+DCt28eRelVkcHNsEeIs7SohFm6pOXzF30ZgX/JG70u5j3jaIC91aecATY8+thPtqQkvdEeR0st/cpMS+bJCtn8vOMLdY8NHtqvJ1jnBFT4IcKDcIyq3Gj0e2sSgNKpO8Tkf8fsgb70+zEaa/Q+SVUg+RehJWaaIPKOnRqgEIpTCKiHEyagPJTKMoIiUROvZVr1IS41xSF3hGZoNp4IKdefgSqHV/diK681YO8TgKcGSc4wBlqOqpviJjw9t3tFW6t5W3h9LgLDXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAe5ZE+nKgNN81K1MHBgU8UNFmICNMYwBivEJpghyV0=;
 b=OJVgvsudIkC37Cc5fZKtQR67CjqN01LrSx/gNdG5ZpTT0PVP9VwUUrFcxSb6VpxbyQ4QdLIjjWM1EE79/eKyDV4erQl8OUbqjiGWs0HwZCN22g8Q/GV5k89cwi3PcYyFs9zGUae0Ynyav7lqEhiUefIQohfyQaJepPOw3ISR1AvpWTUbMZ0Fcjeg5EJYtZTZUpkkpsn2JyNDaKNTkUcscQQjHGSOvqoGrDeK9cSU3MFKCW7sJINo5oTufPJOdBh06G1BhoeUn6fZ0D431C5kgdy1g1JMSihW9Jh9jLRLPgq4I152XCqGQwRJbPsaxiBG5LnnC3L5QYUGxC9ZCh8hbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAe5ZE+nKgNN81K1MHBgU8UNFmICNMYwBivEJpghyV0=;
 b=WPjih2wncdhoIjXvwBh/qgP8BvLrbZATHrVXTOj+xiV9ovOdrWVRJAuwUBSVGUwwCimKSHqYmj769dSeTHkD2xwgsCGfxLe/qs2woX3bP585k9XxUzJWTt0E1OB+CU3is9H51q6NxFgCNv+kgNmPk5KXlgiIYToQFdZePbnUkAPWvE45qhOaFfdZ7+Hr0XyQaD8Ga5vsjQUgf5gNbaMV7VrGHEJj709QwTI1KbO3/gIbxQ4DodsMLXg+Lu10oHlgZW2hyotIjYgkd6BaN1zV4EiIwBIMbEN+5JqlrcupRf+cVDIkZl0UIkMTw4kEXOUd5Lphvi0r6mCwKyRLTM4nNQ==
Received: from VI1PR05MB6992.eurprd05.prod.outlook.com (2603:10a6:800:188::10)
 by PAVPR05MB10428.eurprd05.prod.outlook.com (2603:10a6:102:2fb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 24 Jun
 2026 21:36:02 +0000
Received: from VI1PR05MB6992.eurprd05.prod.outlook.com
 ([fe80::aded:1de5:5441:2313]) by VI1PR05MB6992.eurprd05.prod.outlook.com
 ([fe80::aded:1de5:5441:2313%6]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 21:36:01 +0000
From: Gabriel Carvalho <gabriel-n-carvalho@outlook.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julian Braha <julianbraha@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Gabriel Carvalho <gabriel-n-carvalho@outlook.com>
Subject: [PATCH] drm/meson: cleanup unnecessary condition in kconfig
Date: Wed, 24 Jun 2026 22:35:33 +0100
Message-ID: <VI1PR05MB699278F5D7FD140310C6EED9C8ED2@VI1PR05MB6992.eurprd05.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::7) To VI1PR05MB6992.eurprd05.prod.outlook.com
 (2603:10a6:800:188::10)
X-Microsoft-Original-Message-ID: <20260624213533.148075-1-gabriel-n-carvalho@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR05MB6992:EE_|PAVPR05MB10428:EE_
X-MS-Office365-Filtering-Correlation-Id: e209ea60-ff20-409e-c672-08ded2389612
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|22121099003|19110799012|5062599005|37011999003|23021999003|25010399006|15080799012|8060799015|39105399006|4140399003|19101099003|5072599009|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/iPz9kYzVfwIDHY4Pny9lg+E3Uw9nTfQRSX+2ebMY2yJbL0s75xTVX33l7CM?=
 =?us-ascii?Q?vVpX4x+oNkY08BtbfoXor15B/lsF9OpFXKpMDcxU9re6Xr39Jq+SW4cyFgnC?=
 =?us-ascii?Q?kvSz7ccCiPR1MTnB0rWD6VFHdGaRuixFJQL+WZz+1FMVJ5bWwhsamn11j0lX?=
 =?us-ascii?Q?Hbr+Tvz+QRqlgYP0o6QiNqN7/TJUBTGSQeMpcKnoNlHE2hE9qwAyZ/Z0kkv9?=
 =?us-ascii?Q?dB3amT0oF/gdino/rdt2xRVtERhnV45AYaig9GAx476KJuhpK2M6FY7Ac7r+?=
 =?us-ascii?Q?Qzu4ivUV0xPmLH8XwJO22qO6V7wvFSbjWdxC1loXebVx5yiQYIJU3MAezw/V?=
 =?us-ascii?Q?PdXBGcbve7jRlmKQIxGjHVIJHKJ6UEE1Xhu91Ge8T2wmerzOdSlWOnJ3K+4a?=
 =?us-ascii?Q?q1jZHSkC04pJH6aVwzhqpAkYZue7FKy5XEd5a7qJ5mZ5Bt6c1ZX7nKgVKva9?=
 =?us-ascii?Q?98Jb3GTXEpa290qvYOAbkVamRxRIwAHYk2UMXrIQaLrCOeOy7X4y97nKnWFh?=
 =?us-ascii?Q?cgqdakJKsQkOR8ij6Cnp0y9cv8aTxDgXaU2A7J/fhfSeqem3G7KGo+Yg72bX?=
 =?us-ascii?Q?J9RBhW0XRDqLNlMClEYjEPW9zWwNs1wB9e6UdK6m1XyfA3kOQ0HS6w2YV1M1?=
 =?us-ascii?Q?vrCGvC9ozc4BRSnQUGiet9RCyWAFhqNFsre/OqD+8J/XNnNFbQnjiIRvee3I?=
 =?us-ascii?Q?5lMR6OpNfmbGvXrUh1oAXfJ2fjM+KlNZFRPbpl4oUEqiRHFQi6meYUSzbXYy?=
 =?us-ascii?Q?LprGeK5nIGZzeKR8UdUPI3jSiQSXn0OpQfNs2dZFoWypQTkM7yupSXBccJqV?=
 =?us-ascii?Q?io8xJe16Aspvb3iZsZ2pK457perMAIGhIOeN3nL/r8PTwtdUQ5Q3fjMAypnU?=
 =?us-ascii?Q?u9Jzs/9FZ7lrnAA1pJb0wba06PJowHuh4+22F5dtMETEgggXipTadcDa9xe5?=
 =?us-ascii?Q?U4PD8pAxDQm47JOBdN69rx1OG9rqBbhcEE7eVwU//j45z4K07tn9XdDZ9Iek?=
 =?us-ascii?Q?YrMRqPJr49eG5/u93qNRjjOemjBuazRr6aciy9bhyhXnPbJf7l78+j1T5EY8?=
 =?us-ascii?Q?iZd0GdXq?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XN+l1zC96d3LErD509jxubVGvFIMERQ6ab+Rd4tV8fje0cvLgSYcrgxJALNg?=
 =?us-ascii?Q?r/HILOKaBV0C7Tf87IiGufEJLF9EOcXJdetd1No27/5OVNE6ZfHZ9ebBO0p7?=
 =?us-ascii?Q?B65dQcAC3Fjz5BbCwurWkOuZEUEjVN0dYLG5Zo1HJarHCs3cuY9N+cXt/0Dc?=
 =?us-ascii?Q?i90DxVGFVNkm+Y1eR/0G+lm0RWAhWJFe0bNiPnGJoHiJddT++NZTxkJro5hy?=
 =?us-ascii?Q?n9bsJTM9ifMBJfZZkPpMHSnlRjJx6SbGf/+aZvQfIQX8OEFDmxk9r7Qa8fSv?=
 =?us-ascii?Q?KOFFxumU2TMyUBuFiKJzsiIF8u0WVRdVE6TMV3N6dPjBA07mD0FtR3xN4pfF?=
 =?us-ascii?Q?aS7WXkmLhZQeDcXswJnNnfas3ggRftk5zWXO68wjtd+sIX2BzhryHyEavJD4?=
 =?us-ascii?Q?WFfXfGLj+CpnNcJ+OOuYrn4m8PkyQB1+CjQHaeF6UmbmIz7UUHWurAgWwIqq?=
 =?us-ascii?Q?SmR89G1WvF0fkrBBQ23XIAuhbCrcfdw5DHiomV3WZnhEMJihDXGV8OrMAOb9?=
 =?us-ascii?Q?lPV9JKj0lzC9cbGExJlwxzr4V9yLPDx2jJR0Z4FtWEWbV3yZZfN/KToee9Qf?=
 =?us-ascii?Q?nQAnqsYMif0mxlXQupA3JvGqgbUOhA6tc908io0vHZatTPpsOSN68xvczA2B?=
 =?us-ascii?Q?vsyF7O93h1gNzE4TXVC8NpRRhWkclxe0AXeuFz1mDWH6NHFfsBOGxj56tAUo?=
 =?us-ascii?Q?ff6yi4JCctIvEtg9nFU9KXtKAl2vs/Aq5alvVVqNEM5c83sIEOskIFhk18mw?=
 =?us-ascii?Q?xUKTDQJaujtWUTyh04iHfT/bBdYVCD4QyPlz1szYIEFHfwgVHZYn5EMTVh4+?=
 =?us-ascii?Q?UW3hHXmcbAUiv/xRPzz2OrsafquibbJM/mhJ5HHZxM/Iq6hTdKDhWUvwgomQ?=
 =?us-ascii?Q?pGaqj23TzoXZS6RFutTduchdPySzjfSCKvVJtUGyI0rjHTriEMpTnsGAlfVu?=
 =?us-ascii?Q?3ZTEDKc3/6/VKMrRlUODu/MlUPXb6tNdDJ+fzHyC9/2ldqrwyzrtxKA2vuZH?=
 =?us-ascii?Q?bo4a6haT+h916InYCu3bawBmZJxmvw7/RxrRdaefWoNfJYfGPRS8H/UpIV9J?=
 =?us-ascii?Q?VLpm3OsX5rJsnv3KxDPFfm1cl8QD0YAnDuPlPjx1bXg5AhCCqMQO3Z8ZiWLX?=
 =?us-ascii?Q?/uYDkx43sp0QpO1UgeYcO85cEJJ3VUFRdZ4CftwXxpkCj5lHnZRHyPVkR42w?=
 =?us-ascii?Q?aJKe3ihwY/zP1qBVyASOCoaIPy1q35JN+J26NqRLcjtpaBoj2mrAOc6wQPum?=
 =?us-ascii?Q?s+COp7JRPB0jynBH6msJRTddfEjj71+CtLUvOEBycykE0Bpg2XQo7RS1Z6P8?=
 =?us-ascii?Q?078kpAEuzLfaJbf4FtDK3wj4nS5A6RUn5sdtAhuXkF2zOjkm3K9v3o9JClZJ?=
 =?us-ascii?Q?qE7RuZpuO29sC6X8MKKX47rjPBHOKoAJb+wxcgV+m/lU0fE4gg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e209ea60-ff20-409e-c672-08ded2389612
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB6992.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 21:36:01.9159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR05MB10428
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

DRM_MESON_DW_HDMI and DRM_MESON_DW_MIPI_DSI both already depend on
DRM_MESON, so the "if DRM_MESON" on their "default y" lines is
redundant.

This redundant condition was found by kconfirm, a static analysis tool
for Kconfig.

Signed-off-by: Gabriel Carvalho <gabriel-n-carvalho@outlook.com>
Reviewed-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/gpu/drm/meson/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/Kconfig b/drivers/gpu/drm/meson/Kconfig
index 417f79829cf8..c3800825ac15 100644
--- a/drivers/gpu/drm/meson/Kconfig
+++ b/drivers/gpu/drm/meson/Kconfig
@@ -17,13 +17,13 @@ config DRM_MESON
 config DRM_MESON_DW_HDMI
 	tristate "HDMI Synopsys Controller support for Amlogic Meson Display"
 	depends on DRM_MESON
-	default y if DRM_MESON
+	default y
 	select DRM_DW_HDMI
 	imply DRM_DW_HDMI_I2S_AUDIO
 
 config DRM_MESON_DW_MIPI_DSI
 	tristate "MIPI DSI Synopsys Controller support for Amlogic Meson Display"
 	depends on DRM_MESON
-	default y if DRM_MESON
+	default y
 	select DRM_DW_MIPI_DSI
 	select GENERIC_PHY_MIPI_DPHY

base-commit: cdeb2ccd993ed8647adbbda2c3b103aa717fd6f7
-- 
2.53.0

