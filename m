Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928BEC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA8FD10E8CB;
	Tue, 28 Jul 2026 13:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="quQppPH6";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B9B610E450
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 12:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejMr78JH1JUExtd3dyX61w3xY3hpOgWGE55NRPXvwRnp9l1M9pngphDsj1S3V1Xv3JKEc0WL5lGSZnC0XtUBlysXUMXBp0d3JY1AcFPY5eQjREqalj9DlvWUjjy+OgRUzxFEkVF9MTvZEX25YUbfgWiqq1G4IM3Ab0yUOGSXa9UUr5FtWktZMrlhq88ai6NCOrGC6EW51JZkTEpx5VRH47PvuATb97pqrgLQiWZLTQx8MctyRsZ4DVMmkZwltiK+UCo0u2sJBlL36AQadQCTvSm0MOekaGYJxGXg9FXfECCjtwsdStzYAA7h34l3wB7e57THAk2iTL4C+uvjlSdrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d25AIFuqzErVn7LstllqwZuK0E5hnI3B/xiCd1j6+Tc=;
 b=ur2OeJ8vt54tVSK0OKCsuW1dRdpQAGN1fwaeoXH698mV5vMq93/MvHGxT5cGnRRaMkJRnZ7mLUC/Ovwibx3sCoybsPc7rJ75qcWCEtj7SUVGuv9sOKNNZhQFfOxwm2Hk1vm2qHeNt6bZun/THIeJmseDJODvYHktKpiwGH77h/qFuyiKAGNscKAsXQaTsazsJeFF/p+c3GpoACqrDsiE/PraKrjop3N5G9Vs2ixqR5cBqh0K5INlsl62j9BiG6Y3iI8i6xxGu1+xLfXQfgpD4JckPT30Ga3WZ0LbHQhGa4nFEk6LDwE+1jZfBdg0wzKJDMuiqXiLbR1yzY+DCrmnQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d25AIFuqzErVn7LstllqwZuK0E5hnI3B/xiCd1j6+Tc=;
 b=quQppPH6EKDHLZQi9yt5zgp9ObG6XDL2XAzNxCU4iqalqZCudEpJKeUIIGO7ql/skhAOLD6XyfIyd95ap3fjv2lAeR9Z+imWwTatIwien+Y9vH0D3KAUd7guCdWJJeMlhjKzyPkJd61tjuuDlGY66WRKVp2m1fEJEgFDjxvhtQo8gjPoEPCq656kzLQOjgXM3RQsX1g5Iwab+ZKytuoax94fy0uH8GmySSBqFkViJ6OTaWFtYWn4s5SRuI/TZjyELGDgcy+Pj9vyUtDPMSAkjtMk5rOJ8Mci09tDPJyiBKQy37hW7gJR2r3ZqnRzKHzQFZjvl/sAz0zoJnCboGn4ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AM9PR03MB7993.eurprd03.prod.outlook.com (2603:10a6:20b:43c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 12:20:47 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 12:20:47 +0000
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
Subject: [PATCH v7 2/3] dt-bindings: display: sn65dsi83: Add output data-lanes
 property
Date: Tue, 28 Jul 2026 14:20:30 +0200
Message-ID: <20260728122032.692482-3-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728122032.692482-1-wojciech.dubowik@mt.com>
References: <20260728122032.692482-1-wojciech.dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::18) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AM9PR03MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: dadcd531-3215-4101-a68d-08deeca2a778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|366016|376014|7416014|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TedyA+9PaWL7TD2bujA3+5Es+Pcr6YN35SYmlWf4nHJsramldfDMoA/qI7aYQ/WyAhGskVNesfOsDdLD31NJNg+8XtDeOYOz0XGLxuPfyEtD/BEBTXMd2aMsY/ixX2bbP29QCjI0juHjWg3C+LpLkkHqIQekZM8LCE3w1aZ6EkcoFiBoYhdvRTpl69kheRoFVhJyc9j2cPfcxrXdGqrCqfTRG4pUKJwZIX4vXONZsc3baWC5UBlLsuD7O2f6p5UhFznhfPz19HgdjA4rDmac3i7ez6ld8OSCNcrJCz/IijvPjH6DkGX320ub9peHyTKKJWU7kdJySoXaZiwE4zjrHPGUuV3/MI0+sJorYiOxtKPZ5jO7LCIRqTrQMfetkXpgnf8XMVvVubp/NfuRCjIA4yWKT/7OyetFt+nu/Pw8eH92GkixyCc5auv2JooJ74i1CcDWH173XUirZjRzAf4D2BwHNcQTLCbc/mXdqAaNOXMoWd/3LIq/T52s/vesYv4jkCQjLsGbtQJ24tlzXn19j9slb1Ui5XfXEIWzp/S9GRjkU/X/QOjpMalAL0fXqL6lvELI65ZR8D1cEoC/5isaiZSnM82BNbT3zxTuwR0hE9X3HqqXM7CLCAEGP/McUjYQtRkPfgddd9zPPYgkhokhEYmRL0/vDp/ImRGfJB8g+q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(366016)(376014)(7416014)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eTFoZDbmpZnWTil7eVAk6n+0uoLgrYAeXf+IGPX54ay1iQKHqPTtXa1ognhq?=
 =?us-ascii?Q?bRKtLjcmI9IHxk0EsO3oP7CvOjGfzbSPel5kFKCZ7KxcSLxibr/W+43T6GHg?=
 =?us-ascii?Q?AWqm1O3/eFEQMQOunu1BsDSxLUF8iFg6GJFef0I6ooB97LZeOlBwvypQ4ouk?=
 =?us-ascii?Q?RMDD17dgx4fSksoLIPYbZjijCqibjkGd65/JxSGvNS7DBZA7xe/l6TEg2F+H?=
 =?us-ascii?Q?YSgcjs7hEOjn9d9kh4GaRkU+GT/RgVrhFhxJCKPv6ph1Dyo1OsKfbM3pAy7P?=
 =?us-ascii?Q?+p8zWXRqF3Z4OssSaOT1vY2YHeF6RACdFDVnxoHkNvS7Yigk/UmKcXrRuDvd?=
 =?us-ascii?Q?bOy6ynb3xsyUCyMEV6th4hxzuCVhXbg38WxRdMDeTP3/mHjIZARQCxLvYQCX?=
 =?us-ascii?Q?sOYCjbijlhn1KoG+4b6SxRf8awrI4IRU1knqaNmZOW9ljm3S8nsjYC7Ffgm+?=
 =?us-ascii?Q?Xem4Ap9j2kY/CCq6dQW5ZFizwCSEnmeBF2IDl0EQIZufZffRiHT6Lp1eLlgK?=
 =?us-ascii?Q?vc9Jb6iCMOwA5qVwkN26ZJUagr/JL5l40z2C5DlKRYoChwW6h6ehobAYmEdK?=
 =?us-ascii?Q?/LRmqGFUlvIRNY0GEUHkc0YXqDn10ZFieZw7MWZArCh7bL6vqWTpl29+4gup?=
 =?us-ascii?Q?i8oG1ASab/7WmnygeODYi3EqK+avwKKc/2EmgTi5NLPj4O8ZQz/OYgRGXn/O?=
 =?us-ascii?Q?/OAWfsn5RgPd0MX3FVyzUzBw0BIURIwfuaP8jUJ4+VemHWZVRRKlwey6yQhL?=
 =?us-ascii?Q?h3jNJv29ml4CXDiw1Coq90v54cUd83LiBOM491BpJbsBhfLbjX2CdHAb+vdo?=
 =?us-ascii?Q?7qN8xmUH/nBQbKcvX67mQEWlb/2HPnf+2eE3qvZwL+q/MDUptMqcLInjKHHS?=
 =?us-ascii?Q?THFFGNVHdlTyNQDsX1va/ojYsOOhLdyqxy53B6bIoGl5fszinltancvGQu50?=
 =?us-ascii?Q?3Pgxd1b9raoSMZRX5FFrY8NigSQrxcEYu5Ra/PTtSudGnz03Zhl5OQcBglUs?=
 =?us-ascii?Q?4ePDKv/9AQb1xru4IE9RiwIzyv7+EkuSxNSByXcdWsQaS9+CgW3I+E5tQrzc?=
 =?us-ascii?Q?St3f1UdhBz2O57FzcSj8U8rqhZ2Z+f89dC6GQy2+rqF6hEaK6gDUoPucyE5d?=
 =?us-ascii?Q?O5l3aq3rHo+JHg6dL2RZYxCloRoHF7sl7Z8N+ks59Uk1jaLGRCalXPCQHaaV?=
 =?us-ascii?Q?lseMNHY5aPqQfpxiXFrNuDxkhAWGLdZ+E8iLKNmvx+ETI3pd0hKoDBfhILKA?=
 =?us-ascii?Q?X1h1hFeD81qPKvtyNm1ircfeaLEOXuAwzTDgbIpjLqMoeWExsFxs9ouIjMio?=
 =?us-ascii?Q?6AhNiJfrwIETaZNbxVNgU4Hv4SLA2z2i8778WmNCKyCK8K91eeZr3qI2sSOx?=
 =?us-ascii?Q?gk0y3vliUaJvkJmltu8dW0jWUfVTpQFq48kUvZhz4IL4mycTy8MiL9uVTcHR?=
 =?us-ascii?Q?qO+s2ZxAsszmdupjxH2W4XZnhwbw7lEiWsWxZLnNhOLxf3eERPDRnSzzeJCa?=
 =?us-ascii?Q?hz+iZbXQE8N0r2zRPWsbHIcpaiicDq3VSuucqiuDzm+uGU3sjuRU6NhkSedz?=
 =?us-ascii?Q?u5zT/9JLNXKJyEZtUtMdaAUk2axoMUgQIKRaF7I98/HzH6Qz2G+9Vouy+j08?=
 =?us-ascii?Q?5rshOQS15utD9Jlna3qxtAKxSkqFQK0w4xIYbKEZvdMeSCBpbKNOvkuOKWc0?=
 =?us-ascii?Q?3DcvXQXi0kO2BNBei34v7RqfBigROtySMj4gDwc7Hrhk9Xwycc7QfLb/P8/A?=
 =?us-ascii?Q?c6O5wMvjeA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadcd531-3215-4101-a68d-08deeca2a778
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 12:20:47.3161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eSp2FS9E9ZfrkihLND75ghukg0Ox2R8YoAdammfS+Z6yEOIVEnZRXCUf+3efIIrXystrNdq9xJybC0zJ1g2Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7993
X-Mailman-Approved-At: Tue, 28 Jul 2026 13:00:37 +0000
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

Add an optional output lvds data lanes property with two allowed values
for default and reversed layout.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 .../bindings/display/bridge/ti,sn65dsi83.yaml     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
index e69b6343a8eb..0eb3913acc9d 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
@@ -125,6 +125,21 @@ $defs:
               lanes in microvolts.
             maxItems: 2
 
+          data-lanes:
+            description:
+              Array of physical LVDS data lane indexes
+            oneOf:
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
+              - items:
+                  - const: 4
+                  - const: 3
+                  - const: 2
+                  - const: 1
+
 allOf:
   - if:
       properties:
-- 
2.47.3

