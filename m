Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A43606A327
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FjUBCXRG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020FC10E411;
	Wed, 25 Nov 2026 08:41:20 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011016.outbound.protection.outlook.com
 [40.107.130.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E60410E1D2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwK5seSP6S+4LmOSM8mXxRql/DDr0Q3LEPiUUEATQdAWKvBeOEo+SWL5i6zlLYFno0NJDGTEgYOtkhEYej605xqrrKUjOAh0KZnlUONpnydn2u960318DNSr5Uqb4cltqWZg/Nugp29d6OcUe+FmdCqtjtkhKiCq1Ldf2KfGzm6VqqC/yC3yLNZIlfhj1A3UM+yco0l9afwZgk8LzvDl7oh/ZgYbdDpWHAAx181vLVBcg3eG1w968zDCS5IcCjaJ+9CrYh5dKwZRzV052WHQxUSENWmyEs1CtNYW9oAVQfKIGZa0XBVrw7SPsL/XoKE/KV9s9kGxmHTZLAdXD8QjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGj7MsP+kvAGw8K+LSpXoDZ3H2o3ZklWIuFCHsap9f0=;
 b=eHmoGmE9eNOG8NvEckqnsiLnA0MFcn0lAyTpGjrWVamMBAK8hc7DoaA5uLMaqPDIfU8rrXTIMy2okU0fadPHIk2i+Oc2yA61tNIBYdELBfUXD5BjVhrrOJDWRJQuS25SCqjhA8wlrMm6eVy7Zny6yx1n4xgOFHnoluKv7nGpBeUZvMpgaY1BpOGEa7UgKoUIUhX1n/wGuCjp+ELnqhjMgv2YimQYq0ELlbAX7wXuLlxzoig5MJ5R2PY7HpLsIroUSbZuoshg0boj3UuIGYAZoMCj8Qw0RjS2IJXiFNhKce0yo/lse25qZJTgcglAOGExYo0B7D4g5embSOyhRZKSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGj7MsP+kvAGw8K+LSpXoDZ3H2o3ZklWIuFCHsap9f0=;
 b=FjUBCXRGoFYkJ/yHzlO7rwAaczifp1yar5TgLh1ZJwrtfCLh/XS6ssvTrqBCgU67XDsxz2ljSz/Ut5OjrIbuxhnU4eyh+70QKS6UbMkS9sUNC9looVoseCtzm1Rz3czX0qxbNGdD43WRnbPDZdnL1UisRzl2yZ/B3gEoFVqVlzndedqgtlsk0HTQOimUIK8CBYtGhtw9Js3FIxGKMVUMLrDQITj2e/6e6LOoRAPg3SJ5A0c8yjsVfQjiX3OfsrofpT9WE9IucmaRkQQFI6MqAeLGBQrvRchXfxAupZQ4D/IXHPkOqRpd/4hm9/BHYa8n4bZQF7is0oJVOGAcS27tcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by BR0PR04MB503013.eurprd04.prod.outlook.com (2603:10a6:2c8:4c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 07:55:07 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0639.010; Wed, 25 Nov 2026
 07:55:07 +0000
From: Stefan Ghetu <stefan.ghetu@nxp.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Fabio Estevam <festevam@gmail.com>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Robert Chiras <robert.chiras@nxp.com>, Robert Foss <rfoss@kernel.org>,
 Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Stefan Ghetu <stefan.ghetu@nxp.com>
Subject: [PATCH 2/2] drm/panel: raydium-rm68200: Set prepare_prev_first
Date: Wed, 25 Nov 2026 09:54:55 +0200
Message-ID: <20261125075455.772826-3-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125075455.772826-1-stefan.ghetu@nxp.com>
References: <20261125075455.772826-1-stefan.ghetu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::6) To AM6PR04MB4472.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_|BR0PR04MB503013:EE_
X-MS-Office365-Filtering-Correlation-Id: abfe6eaf-cc7e-4cd3-679a-08df4ac96c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|19092799006|23010399003|261009223027099003|18002099003|22082099003|3023799007|261026121527099003|56012099006|261021121427099003|261102123227099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: /+GCSZWdQ0KXocsdo9+nfAUJ5l6iNKW+Q2fRn6yIJ23IHeyQwNyqbutXV7nfJuUfiaTEo5ecrPafloYy4XWB0l/xfAZ+6HQ8Agl5yWoFp0Fnnp0a4gg6ZyHIwLsqCfdA3Wp7gF3Pg8geMRhbvOdcRia7Ekp7KFDjTyiF2T3sQv5rApXtA9pQgWElubu5O6+MNqQSJI3qUVcgaMFNZrD8TpMaii2mONrf9+GB90hVeDGFvMY5GtMfEiSOU3AOn1cVUFybtmm2NkFvbpdOO3yJu/MuKXYHaZk87Hpi1jKDESo/9Zdt1N/KeIiTpqj4SfxyvXHlqqIX/63N8GEsq/iJL/6jVJUCUW+gD9J4LONwZ4M+Q3BflYRjQtcFKacUDBvP/iXhKbZCjgN1Y2XX2JvLFTpzNjWrujFC6RoIWq5cSrQbpUPxRvVxJgj32TjpGOVo7OBml2qyz3x23dnUhlBuZN/B0k0l9rUcab29hUCYisKq3Tx77qGrrNKAOcWRIuGo6piufom/FjJN7t9QwrsxW3OHxpeTuOOYCSlXyGJ1+jMC8M3v3P0vkT3s50ZUSJJICaX/4lR+5ElWnEvkO3q9Jvi4UjjkX3OjwIERzMypGYDuBSCOHL4kyFjFGJmbxiwGfIAayu34x6vyS/8tGKl507HUr9IktmvkVD0cIWMeUuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB4472.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(23010399003)(261009223027099003)(18002099003)(22082099003)(3023799007)(261026121527099003)(56012099006)(261021121427099003)(261102123227099003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6oOwvFF2NZkgn9cyIquGIyylKKefMdxN208BRDnbN1erXVa7+ZxyU+sBufP?=
 =?us-ascii?Q?/VXxwCqU69dGEedf/DOffmEdtlEV0Jx3f9AP1/GmGjftLUN+K9TtqdYDlAIN?=
 =?us-ascii?Q?nyIKf8HumR4BHWmtHzbyDXCq/4w1T8K3VMWOQUQMVX+B050ZSOGFobhQc6vf?=
 =?us-ascii?Q?nHKrAO0vn3F0HXM3FV7au44ZftShIPTo8ZwmQfUX7i+F+cab1jL00XqgS1sn?=
 =?us-ascii?Q?KVwV+RY/1p7fEBNzk8E4XVafxc/kcNoda0sYsSKq+ZJL/zeLF5LPWVXj+Z9R?=
 =?us-ascii?Q?vnYmEbFO7I5BaDnGijJdAq1ZQd9tsX9pHIl8xDRgXUwPffmw8UAKxftu+TYV?=
 =?us-ascii?Q?URKS98hvRZhBc6wfGeVbBolyoYnvL7ldYD8NNd7NGr+1ujP1BqA25fQHfLqp?=
 =?us-ascii?Q?IHiKcJuAQz8VVAGlvmYxXHH2KnDTTpO9lEM2YpmlDryq0gqJq8NkmE7xHNJC?=
 =?us-ascii?Q?XX+YKJfr4lfCWAT1Bts0VE51dMrRLOv0CDu4BwSk2mnzcz4cFTjfmkju/Yv/?=
 =?us-ascii?Q?34HxKdKntG5AOSt5oR4ssiBeBZCH3UuFIWXXf01mT6p+S4+AHGRenMwRIzYz?=
 =?us-ascii?Q?8Vmf/jgRBaYbk0cEzF1Ua07c5ReQOs/+xiKXUYx8NkA/W9+nw2zfha8IEFnN?=
 =?us-ascii?Q?fz03vftGlp3BKV5Q7JFblHxtkXomdvSdYJ3TCpyD0cQezsm79LZbdfb7CIKP?=
 =?us-ascii?Q?NX1oC7vD1eV8Cv3uX72lrkCjUIC+EnPo7eeqDZbFkhe4fzUVDiSIYOtngkH5?=
 =?us-ascii?Q?gE5gBRKTxFhasas5iMoe40PunY03onh2GMLUJQSA8839qA2B3R+MLmlGOI4b?=
 =?us-ascii?Q?zhm4KWmUMMNOAO/S007WyiXjA1141l6dkr/8D1tmgBYZ7THH/nlflYYPm1QZ?=
 =?us-ascii?Q?th1yp0fdO5Eg3z2LiY2NT8VOL+2nN9Lg3QXuUW5s5+KHKLZ7URfP7aqZHKxL?=
 =?us-ascii?Q?mckcAajbyNVefwJT1ADOUMkpfrW6V622xjLVQxVlu5U/Oj8lXyNKFzSUVLLF?=
 =?us-ascii?Q?5UEOq4Z3JL0mkpob3nelZm1AEPunPLbMeXCWbSTk8V3WjrCMBWT6DNAE0dgv?=
 =?us-ascii?Q?psPPterQKqSW5RQwK5PXn1b9+oTUiS5ed6sDDhi6ZbB8yQl5z2mWfOYm/xLT?=
 =?us-ascii?Q?pNNPsQi1CbZylJKO0u2sZPrr6hDS2VWEATLdKdPuKZQJwVXFgsgctzVwQnca?=
 =?us-ascii?Q?6GIcIocqd1a/qRzkG+GG0IilSepujKgZUOLy4066RENtC+5OsI27eOKPZxr4?=
 =?us-ascii?Q?PZk2Q7RfTGRXXJGcwxRdo4SghW/mI/9UEXDwO6eVj33Uwyow56+Jkqc4RbUR?=
 =?us-ascii?Q?puNR6bR0biJFR08qcV3pYh/6wvK0WuL7tL9y+HxjFOkU4u0q/f6q2E/MV6C3?=
 =?us-ascii?Q?/dR3NTpNdgLc/ecQiVGTkb9+bVRuxONUnEgztnfgJVmEC8pEd/idVP5NmQ47?=
 =?us-ascii?Q?XlIPSJoO4CqJGAKQinMXnMF9NpvTguGTpLUTwq9XZn2b5HA73nOqQHShAdK7?=
 =?us-ascii?Q?hGmBuVQ8Kx4vkL7YTxsdxgeJ53xwiPmkqnc+Qr23P214cmZqYQZ7vPwd0eUO?=
 =?us-ascii?Q?FS0BhHMa6rLbSX/G6OrKOwuy3rZ8bslE+Df14Q969Xaz0/kstYiO8hH5/nQE?=
 =?us-ascii?Q?LX797mAo20vUQsripIK6dMcHApiJp5pOjHuEeNLIOy1J9dwbwiQTzllvCcet?=
 =?us-ascii?Q?zHLaL9Yf1hGLmF7IbgUGAuBhunZk3Sw4acJE8UBWPtn1oi7g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfe6eaf-cc7e-4cd3-679a-08df4ac96c09
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:55:07.2188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/uT2E9/YYLARm518HDo18NyZqJXisNftADHogE7lu6oVxfmfYoV24B9r6ktfxYoWO29sj69bX6DNY/7QB7FtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB503013
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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

rm68200_unprepare() sends MIPI_DCS_SET_DISPLAY_OFF and
MIPI_DCS_ENTER_SLEEP_MODE, and rm68200_prepare() sends the init
sequence followed by MIPI_DCS_EXIT_SLEEP_MODE and
MIPI_DCS_SET_DISPLAY_ON. All of these need a working DSI link.

By default, the panel bridge is prepared before the upstream DSI host
bridge's ->atomic_pre_enable() and unprepared after the DSI host
bridge's ->atomic_post_disable(). A DSI host that tears down the link
in ->atomic_post_disable() therefore does so before the panel has sent
its shutdown commands.

Set prepare_prev_first so the panel is prepared after, and unprepared
before, the DSI host bridge, which is what a panel driven by DCS
commands from its prepare/unprepare callbacks requires.

Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
---
 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index c535dc931903e..cc87f587ca78f 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -360,6 +360,8 @@ static int rm68200_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
+	ctx->panel.prepare_prev_first = true;
+
 	drm_panel_add(&ctx->panel);
 
 	ret = mipi_dsi_attach(dsi);
-- 
2.53.0

