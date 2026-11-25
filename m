Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2F606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Djz2WANC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE3510F9EE;
	Wed, 25 Nov 2026 08:41:25 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011016.outbound.protection.outlook.com
 [40.107.130.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C871B10E1D2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOyGjAQvNQb2bjR0aUXueHpLKclgbDeF2hLv0E4ltGjgrTL53PJtbQDX0RwFPbAcnXzE1Sx6rDATiEs06WTNtl8NLZVzI7HbRtpc9aSuC3wSuwrpsJmqOw/vnhz+o5p5ECyw80VMTWmjaAQIdJ78y6TpVwns9hcRIxvRa7+eZ0/YPmXrWqWQiRkkofSU8611fnNgDm6M2B0xM2BErTaNUQK07/iRvUbdy0YFe1MyDXgMtqQ6sDipKvU+u6NxKfUBwuvuBMCZizfGkYfybnr+OMjqxjM7/nNOcKmtQr286PsAismRkbmqpcFVE3GGCMSU+2/nptyYFPLEuiJAPR/ETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdPYH/njZ6agywqcT+6bb3gwyYfCXqKA8yIzRa3s1Vo=;
 b=BjwV+PEeOlEn/bkCn/8CayaMuZMe6pztN0MuK6ZTiy82HIic2Dm1woSUDbnQOURvscMXri7trujKwmk50VF/4GSJCQrmlbX8sNczX7Gnk0o8yYFY/tIhQjwTE6JkxU5cV/qd2v3gDVzOPTav6DfUJpratfN/TY/uHWSrFWSVD9oBty06trpCIbMOJBA91QKvCKTZ4X5sieSRSoHgYyEYC+vwDViN72/ayeeWNIJQYQ3YWCZDrpr4yBv0Z6gVBGN3rzBm9KojWsQTbilBMTj0VmcjOTa9wrYwDHN25VGuuV3QE8F+CGiBBnJ44asKubUDwkU40ew6QPbUfBrwv3KVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdPYH/njZ6agywqcT+6bb3gwyYfCXqKA8yIzRa3s1Vo=;
 b=Djz2WANCGzS4kkypQDf4q4exJfhS5Ub3WD9Fym480V/GRQ1BulyStLYkQRKq6ebgS1peKgcRZzywdV1y5+3fTYUo8mtYFEi6PdNLbaHX3hhzY69dqBCGyPvQiD7GDNEkfaJsLHcoM9cE0Z/hdJ+4y09FDp40JfhnNnKNsu8Xr0fouGN01sgQWtzdbzKCldIaLfy4d6PnAv9LkWm2UnoNQ0/OwosUmYQryBG0DfwdtZdLsQDO2h26Q5d+rNlKK3PXtYXLembxUNiOLhf/zaSs4SBsRzavrjePpRo5gv+S7CAkYQjJSFhZvtI8aDO+g4Y9XWtNtaXlsxLYsQqyFlza0A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by BR0PR04MB503013.eurprd04.prod.outlook.com (2603:10a6:2c8:4c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 07:55:04 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0639.010; Wed, 25 Nov 2026
 07:55:04 +0000
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
 Yannick Fertre <yannick.fertre@foss.st.com>, Liu Ying <victor.liu@nxp.com>,
 Stefan Ghetu <stefan.ghetu@nxp.com>
Subject: [PATCH 1/2] drm/bridge: nwl-dsi: Move DSI host disablement to
 ->atomic_post_disable()
Date: Wed, 25 Nov 2026 09:54:54 +0200
Message-ID: <20261125075455.772826-2-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125075455.772826-1-stefan.ghetu@nxp.com>
References: <20261125075455.772826-1-stefan.ghetu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To AM6PR04MB4472.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_|BR0PR04MB503013:EE_
X-MS-Office365-Filtering-Correlation-Id: a4599d9a-5f98-4183-bf59-08df4ac96a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|19092799006|23010399003|261009223027099003|261009221227099003|18002099003|22082099003|3023799007|261026121527099003|56012099006|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|10067099003|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info: TrLqj9Q1Ye+Zih+23k6lSFseeVpJnYbdfVoEUpgs+xfxFTU9NytJRXwQqw1sR+nmTJuhn6iQRYV97Ghfv8Ule+jNRy5gOXG0rdaryTfPJoGhWcYpZhAlMcNtL4L3J9OS9iRkUGLT9UM48iflnV1K6uIhDBXGh/G7NQx+H2UU6OmWT48HyxsFe0pRwUAQtnbdcJ/knkggKMCTErtw23L/GyjS/qnDnL36rSgpXYw0rVyzzSbdQUsMK/hZKLkcOnRzRedtnQ5zjhIlk87tFImP82vLrhYNzwkKd2DFGUlVt01ZIqXD9PRHFrkgc6X1EiRX4EFi2qzIqM0t12tz3moCMEaDXY5Rk58tXohddDHdrmMTK9fFjjAEdZieL2pW98OItewz9/NhsD7sAdAxZwvjOGJKBvt6MO1HaLGWykFFFk5cpKvRCPlEtGDEzSwW9j02Gcp95luJnbvTgSUhw3fkhK9SxWcvIecaL+2WOpTaRFUwHw6VEctO5cExqcLEhnGxXwlb3b0WVufb0QqRCQblurRC2UcLp+wJ17YehDmyNjqs3m80Kc+ZHep3OcSQ5UfEXKy0d+hb1mf4pbPIYw2YH2xoXxU6r+Azsii28QqGHg8jwkcVhyB2yIdpYkxvphtjYB6AG/G75c0UBiAtW0Bj4jpYQq3NJmd2MKVeilKeoKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB4472.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(23010399003)(261009223027099003)(261009221227099003)(18002099003)(22082099003)(3023799007)(261026121527099003)(56012099006)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(10067099003)(261026140227099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Djzgpf3j2b86V/DGDLkbd8p1tD2UbEk7PojDgoYcd8y1h1JyVk457qKkD25y?=
 =?us-ascii?Q?F51+VtJyEx00ITOlvhC+HHFXgyvmPvSVAGTMZN8exhohNM5+SX81bQ6H1yII?=
 =?us-ascii?Q?DtMIfptZ8o1fGdGdI1y+5z8gURzM60tIxJ2A7vsRWTJoZc/Jr7U8G2QyGxfH?=
 =?us-ascii?Q?/zkb2+aWA++u6Z3MXaJVD6B+8YyQJm2SKX0gzDqwd/9F0edFs8tO9e8MphkF?=
 =?us-ascii?Q?PRVMm20h81CIop5tTAgCXaaF3E/hFwTQgv2RtElI9qA+djOnhSJwKCe8lHl/?=
 =?us-ascii?Q?rhIslE9TIKvZ9a0pl5xuWJ5RjohutkwF47uWj1olj2TxV2ER/KvPWCWVlN4R?=
 =?us-ascii?Q?yq7dL1763/F0wt8yju0VBapo4ADF4ATJRPsNBpjMBIDG59Zbdc+eDVNW0GIa?=
 =?us-ascii?Q?W/d7/muJmVrf1SG3ll2PrINTRoJr4WLvQraPORz2Y+BlvkF9k3KasCKcyvPN?=
 =?us-ascii?Q?Pw+6LIOtOWPY49Eg10FuxlxiKieGeiVXW4/NIGUYJXoRsNtXGpM4ybPLiLjw?=
 =?us-ascii?Q?zncBfykP+ALtm9dqbEdZPbm1yktcfK2xMTYHYCoGLzKYLjdnt9kbbHiEUYU/?=
 =?us-ascii?Q?7g8NrSHMXG/vABJYSYKdvQh+PxvPj92W7qVk8TCMlP4ZKham1d7LCoJpe1t1?=
 =?us-ascii?Q?Z7xJCEnI/fqU7kbMn1ZtJtlKC3YbGXHChCRcpNvoKMXt8IzqjeHJmyBHTDwQ?=
 =?us-ascii?Q?xlaqThWjUKRZzeJiOJfMasM6ujuUQrTSceMOIAgfOItiAK9EseY+aX6OZKM/?=
 =?us-ascii?Q?Cg+8zOokQ9URcgKd10y2O6xPxXRWd4roT5jY0rHPVOWfFceP7Zk41S4YoBL1?=
 =?us-ascii?Q?gSa+YO/JDiXqWQuXOYb407jl1/2IByNNNraPFouU61NXUR29Q2qQez/enzg6?=
 =?us-ascii?Q?hd+IYgAmXq5PcGkBcaD6yigXAB33YFEMnvbAMtMxnLWuHecz1ap00xmwX6M1?=
 =?us-ascii?Q?zU2nz4YuG2ochztvVgn3OC9ZvOfO2KEefw1YSrlmzCncR652of8bg4lOf3VT?=
 =?us-ascii?Q?OJ/C8mDkHy/LbIIBRUucVpUoaIWSPJ1Vet6OMAc/kuPkBeRWOFMN8aHIsEYy?=
 =?us-ascii?Q?T1njIYnXq8mAlg3YJt/5ELxmwhENHBaS/R0ghTwjUBu1zCN8zIMruIngNwXr?=
 =?us-ascii?Q?n9GoOpoNECmR3paemirC/s0DvcabvDRYqsit3BWniIzt+7m4/2Nf8ctT1rZF?=
 =?us-ascii?Q?2QyVbrLcSbh4mqkIdNNfikE0SnWVf58ZY1jK5/aG+TWIE5xg1YPFaAPvyW23?=
 =?us-ascii?Q?7WJ8tsICFiWTRKsMf/XdfJl/hB6xwZGdrL4gexYojFIdx7VZraFrVO+qTgPP?=
 =?us-ascii?Q?fKAn5zcic2ML2/SfBTJURE8w4qy1t18FDSpzStZNoQKMag6lMunUvjrMrx20?=
 =?us-ascii?Q?vYZOzlETtGOtQFgvxBEplltMnoy3YxFo8llh/YdHvGJR0lcU63BxJNnfi375?=
 =?us-ascii?Q?JZaySkHfu3QjQSxz724XSiAB3w+bzvuuQevLlONIGuW73ftWFqNhyChyOw9A?=
 =?us-ascii?Q?HBE9bAOnzXSRfWvyHm9A4my5K0T29mz7GuuCnaYTsh+gANLU6UzogWK8zWHh?=
 =?us-ascii?Q?MWKs+/5bKXFS8gdVY8SIL5Kw7eVAKuAulMoJab7f2tVb1aO13fDiO/wnOUPX?=
 =?us-ascii?Q?oup7q5Sc6Xs9lUBW/Y7tSqhk6pOinDTuyk3dA5IqAU6yWWmcq/EFQY7x6HbM?=
 =?us-ascii?Q?D4DsS4o1qYXlXnytkOXHEyrYEf7YqNlpIacuGk3HQVD4JYOT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4599d9a-5f98-4183-bf59-08df4ac96a4d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:55:04.3266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21o9NFCAcu2DJnyVwd7wbKeaK+mis1b5BjKYc58G8tM8zddeXkUUsVQsbWmPYeMHSGFrXr4hguF19r8ZXbjpRQ==
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

From: Liu Ying <victor.liu@nxp.com>

Some MIPI DSI panels, like the Raydium RM68200, send DCS commands such
as MIPI_DCS_SET_DISPLAY_OFF and MIPI_DCS_ENTER_SLEEP_MODE from their
drm_panel_funcs::unprepare() callback. For those commands to reach the
panel, the DSI host controller and its PHY must still be running.

The panel bridge calls drm_panel_unprepare() from its post_disable
hook, while nwl-dsi currently shuts down the controller, the PHY and
the clocks from ->atomic_disable(). Since all ->atomic_disable() hooks
in a bridge chain run before any ->atomic_post_disable() hook, the DSI
link is already down by the time the panel tries to talk to it.

Move the disablement to ->atomic_post_disable(), so that a downstream
panel bridge that sets pre_enable_prev_first gets a chance to send its
shutdown commands first. The enable side is unaffected: the controller
is brought out of reset in ->mode_set(), which runs before any
pre_enable hook.

Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller support")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 09992529f3d85..5c82f0986eabb 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -736,8 +736,8 @@ static int nwl_dsi_disable(struct nwl_dsi *dsi)
 	return 0;
 }
 
-static void nwl_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
-					  struct drm_atomic_commit *state)
+static void nwl_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
+					       struct drm_atomic_commit *state)
 {
 	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
 	int ret;
@@ -963,7 +963,7 @@ static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
 	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 	.atomic_check		= nwl_dsi_bridge_atomic_check,
 	.atomic_enable		= nwl_dsi_bridge_atomic_enable,
-	.atomic_disable		= nwl_dsi_bridge_atomic_disable,
+	.atomic_post_disable	= nwl_dsi_bridge_atomic_post_disable,
 	.atomic_get_input_bus_fmts = nwl_bridge_atomic_get_input_bus_fmts,
 	.mode_set		= nwl_dsi_bridge_mode_set,
 	.mode_valid		= nwl_dsi_bridge_mode_valid,
-- 
2.53.0

