Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0141C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCBF10F3EF;
	Thu,  9 Jul 2026 07:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="tPuSxnXK";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011012.outbound.protection.outlook.com
 [40.107.130.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A8210E45E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dw/m6a4h4XPBvpu2LmwBU7B4/NsSBPikvHw9lExzBc3SFlK0kU5bIITojfnI4n6GhR9E9N9y2K1V81zrmNGn+EqfHsBXjw8liT/u4n+cgrMcuxGp4k657qZ/cNk+4GcD7/Bg/2U/twASC1YvUQNZtRVSXMa7ouvrurBNXxJ92nCcBmodkxfh4FlXCRF/YY6wiblSOu6j4CZtuRqDn1Czw5oMGEkSHcl4RkOFpDdWO27yPZoJ8pnsM9ySxtQInb9wXWEw3N93PnNlC8k2RRgY0fPTWxw3guwV+uLt9bqDNNNYzOxUOI5XojbMp9KFOwndhNDx8dPeebz6yOJB7jlIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQaD+cCkMx3wzyo1sRu5+sT+CCxjZrCocT9Ksj2MPZ8=;
 b=ofjV3N40nsDoMX30ZKUFvjfGyJTeN6lTK+n6Npq/p7IilIg/QY8KpuQHg2CfTbYKVxh1nCi50TBy+HKg+6BGjsLVmGCkAi8p6Qjut2pfeojzqOeuBeYc7zaTT3QWkgxH3O+66hRq4GGWQ6CWPsUA2bo08dmd4gGBkIFzk7W/VQlD8cHT+9pzzq5uvVes3h1kvxPORLEnRJeQmNLRu+LJSgs8b7TrxhF3xX8ObTCmYCVkSEh0eyXrtrMFsNzR9XCB9j7DG6PQCHhRm0fJk6UUuwxgwxoa5vZdfu5vUL4+RD9fzou+iwPaX41QfnI/m+O73zh8hyOQUN7WBTYMew3wPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQaD+cCkMx3wzyo1sRu5+sT+CCxjZrCocT9Ksj2MPZ8=;
 b=tPuSxnXKYXpjoh9Lcm8qqEIkD8aY4HMO/rEHw6cWvNcX04TSFRuOVUFgbAASBR4/AlOuUBK0vVXZ+n/XAcqJVrIo05T8QBebz+qePSbd8YpXxtt/OFfmvCfpQfR2g/kMXtFRGwoR5mRSiJSh/XDvQw8CgT39TodyULlnccrLAPw/QHVNCIzJFUSqHqlXWnWcI52dFyM+tNLhE4nEG9HTuxWvoKgrAAogcLr76hDtbz1PtjGFB5C8IDCZWPy5wqJJhCOwK//dRw2Z2a+VRvE0Wm+z3koUm6mgYVM4ks2RUXd2guPbtd1XZTYhrYggYrgBfb5KH5PM3cqswbFGzVE6Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PA6PR03MB10450.eurprd03.prod.outlook.com (2603:10a6:102:3d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 07:02:52 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:02:51 +0000
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: sn65dsi83: Add reverse lanes
 property
Date: Tue,  7 Jul 2026 09:02:42 +0200
Message-ID: <20260707070244.230546-2-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707070244.230546-1-wojciech.dubowik@mt.com>
References: <20260707070244.230546-1-wojciech.dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::14) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PA6PR03MB10450:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d951d42-8215-42ee-3d55-08dedbf5c2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|366016|376014|7416014|23010399003|1800799024|38350700014|56012099006|6133799003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: Xu8yyeF7AMs8Mt79FZbz+JU7W4fHaVc91FGVq33WnzW0RmTNvGGINTfd9t1VGdIkO9ZmpB6eZRoxVhDfeNpjU1wtAThTwHRJ/HzXey1e40QfV3r+OfF0B8aM67r4QDNT4MJKdT+LG0OjWJ6EyumNcIWngr4rc2N2EBfxNg0TDhfRMaYRF31Uwl3J31EeiNypxbMRzG9QDkZpOiIpgN4VhTrk2pY3YA0Pu7uUYIo9+MbCor2kyE/s1EbVSbVKdqk8234U6uYcP1HhAmR31YHfiWQinWRPR7FC/gROYVtXU/OvM5Ah6KrSSQMmJqGnI3ZbGobjFdzosTBGkn6DRDDAFbve/x/62ffxSMyLSTsEKSvHCEEVSHX+GfLCIE41CuJW5+L0ixTiaDBZ9S89ZXoB55Gb5n5aGy9rqmMCp674RjEHAkO227EqF+Se8Mgg8hd/ZUBET1C9kENd1x4dCyMlnY4/BZGzn8eZs2SSGFaFvjNjGOqLOADAsSERUOCJ5ANsYE+Vkj8RA666scUNfwzpcR4C8pQ4NCS8Vc73aVmWqjGCuoabZ++rZl4SZ84Ghi5ohz8JD5sDYNcCCSbOEF+UUd14n8XAqfk2weCus+4GO7xc/UZ9w8lkRPq9tscIVIVGRjxCry9dq1mzKvr54FPcmKvD60RxPq88DufXfale7vY6oKHqUU2wyU7faarYYnF0v66LvyY3uiJs9FanFFF1i8h98AwjKENMMeTDBWJmf0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(38350700014)(56012099006)(6133799003)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fqpKpU8k6r4GUljwcplzdFRk4biCqNBPtEitm4kDNKREKTdNKhSGkhv7iiOJ?=
 =?us-ascii?Q?E3+sTCweXd+LWkj32jiR2Umf0XXDKgw9CYZgXXsTHNrmFVsuMhpw7gqFXEDn?=
 =?us-ascii?Q?QnG9CKetjoZHxgRWdOgC3XC7biWzv4cR7qqrc8g+PlpCkFHFL+fMfw8iWL4M?=
 =?us-ascii?Q?PZckGfQuqQlbYGCMvoAsF0l1MNAF0GyEkWmL94n+NR2tYHULTSL1KHIOMAZ9?=
 =?us-ascii?Q?kZxnuDY68GTVk9SkOzbI6WUftJhvZ3htdYmhY5s4RJdKSW8JaXQwUlKeHZ8V?=
 =?us-ascii?Q?fpdAIkgY4TCFiJb/ghfT0DYPMUHu88FoX3JWoMoyNff1dey+BLEydrEV07fx?=
 =?us-ascii?Q?SWeUZl8fm9pUSeznQVeN8TWk47bQJsqt2xPraVtzxfLzUjoyAptd8zjCIHsZ?=
 =?us-ascii?Q?wDu6U/GubMVv1RDe/9YW0n0hyL7mYEQzYmUrsc5JocoM2dunPPR5b17+kkeU?=
 =?us-ascii?Q?oCs3YgvLyL4fMPALXKGYxw/3jwpHsmY6WWVEsJ+9YTEU5+WyrGV8rGsfeids?=
 =?us-ascii?Q?F60polPX3azoc+3YniiQ2yQxqc0jtA9hFDdZH95O0Jp5gPJUpPnevP+Pyqdl?=
 =?us-ascii?Q?ckul6zV3BAcmuP2sjWc4sN93fHVRlzwNXhdchaUVUd15kixwv60YiPUPi+1L?=
 =?us-ascii?Q?YAn0Ev4bmED5/Y8QutdFiktQj3sMuFT3UnQzg0+kEnBIEbSLNmTfcdTtQPC1?=
 =?us-ascii?Q?HixcgjAmNvcAJpo8IP4Xs8ONEqMsi805iRcUEPGm9s+1qAFiZYxk1+ffDtmi?=
 =?us-ascii?Q?aEjcrM1SDeS95kaK5EfP96smYfkL6vnC/UgfEHFNnNfzhdiGz2sDxpEKqKuU?=
 =?us-ascii?Q?u0SYjg+asru92ar/z+5JjvS+T/mIKCOW+iZP29JvGFRT/G0iTQkVqxcy3dNV?=
 =?us-ascii?Q?9hpKxA38hH+CVOq/6eTD5QANXvaAFyWcTOrFFHeTV7eufwUvnpUvldmdgHMn?=
 =?us-ascii?Q?cQL/8nEQpleBMF9mg8WgLU257TsdaTkf1s03Wp08rh1SsvFQLC2gUKZhkjep?=
 =?us-ascii?Q?QTjwwTkASWO1OjCl5jwPNakPMiKFP81awoP1VjCH4hoNiujWUoO8cBenwbKZ?=
 =?us-ascii?Q?qAdo6FBjOim6uwsrpDLFyQu7/Ob7OBeX0YP9aCoBFrXP8RUYduAPYMKhu9XW?=
 =?us-ascii?Q?K/y2VqAiS2PBLH61Mayeivo9bKcCRnZERNdnStK8bD30Y54WuWwllACgowqj?=
 =?us-ascii?Q?Pf/vM7ivj0Src9RXhd7Tbub1HdvLQkXAGxqJ6TC5ILRYJxsTP8FRJ31t0Mdg?=
 =?us-ascii?Q?Zczpx3zOnsyLU9kCGOmmQjkVcF+5flyXwKFaNCvGkWhD3+Ta3wgWmLIbWvQ2?=
 =?us-ascii?Q?Tgu6EgQ303Mpq4cDCPiqp7N2B1N+68o92tHPo/OYrESlpQ9U+dBhXgn8bVhy?=
 =?us-ascii?Q?3fnG0vp7se6fN07tbnbnOw6vs9O3hqOkTT5d803qnA6lQqR6wXBsS5beIdLQ?=
 =?us-ascii?Q?73ZNJBb3dmZdp9rUKl3upUVwV32AxuO43HS90mmVCnjo/NusvORvCp2o99UM?=
 =?us-ascii?Q?lGFLtgjCeiKtliyFOjDWtWHgXSNtCddfpOGEfGRIHUMMsC6Ks8C8gxflSJhb?=
 =?us-ascii?Q?7jq06sV28hD9czrsidmyyncum/1VmfoUAytn+jktqC3JSWCamkDYQilTXVvT?=
 =?us-ascii?Q?x4e4a/Rxx16lcFme1Sn1AaVWrfMoBSxsxslPlX2Q9mgrSOAbi76J9Fch0XP0?=
 =?us-ascii?Q?ldwy0pMQk5SdJS+IP31ru11wEfQ69DfAvXNitBni3D0AoAVmEL7uJH9p+ji1?=
 =?us-ascii?Q?VqrTj9IXNA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d951d42-8215-42ee-3d55-08dedbf5c2bc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:02:51.6606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNHW9iNEy+oSJ6+DCxVPXLrzWlXDJJyoKSuI69Op1qk9wUrVuvx0sW6d5z69Bc4jNuO9Wcgl8JlOKAH+AxhKmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10450
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

From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

Add reverse lvds lanes property for endpoints. It reverses
the data-lanes order i.e. <4 3 2 1> instead of default
<1 2 3 4>.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 .../devicetree/bindings/display/bridge/ti,sn65dsi83.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
index e69b6343a8eb..44483e808af9 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
@@ -115,6 +115,10 @@ $defs:
             enum: [100, 200]
             default: 200
 
+          ti,lvds-reverse-lanes:
+            description: Reverse the order of LVDS lanes.
+            type: boolean
+
           ti,lvds-vod-swing-clock-microvolt:
             description: LVDS diferential output voltage <min max> for clock
               lanes in microvolts.
-- 
2.47.3

