Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1D0C44533
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD8210E6B1;
	Tue, 21 Jul 2026 07:21:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="pzsEZ+NP";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013070.outbound.protection.outlook.com
 [40.107.162.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52AF310E033
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIAMqcMnU7nb4P5QRE3IKusD0FQCP7gvh3pc/K/LCn6qpBrazhtLR40eI/Vtufe+z5kcfoJXAtiOBz65OkURPesO2HDMwW9kk43QiCySi5oFwqeBBu9PuKIsalave9Cm6b0fGGdKUVeW4NOHZnLkHodMBWu+93InOqTdJPGCYfh2uSPUDwrKGKTp22vZ1AdqkkY7pgp8j+Pawarey4g9ZZufE40Te8bx6U3DyJZfQ/HoWGFJhr8bcW+eX8Ljs0G/WA2aGoCFeURUWBUsBqnha6VoKdvZHs6w12hukN0Sz/BWF7OJTH+v4bM64/054apjOUMsATznfR/KxmsTkOn4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8r0X+naWHuk0OBZwI5XiEDRNAH3P8/H7EQAJwVLJhY=;
 b=on9Z2HHeZIWJeLpDlhGagWosuvgk3EE5WeJZ/oiYOuTOXV7phkxLVhwSIbt07CELMfYKFO/FpgEqJFIr4Qe0tl8ZeG107srYFaEo0j9wk7C9ARX00Q2U/QWjcSCCJO3kDV0EJUHB9NoO2FVKy3t8hURoU8ShkdMwj0B1T9Uu1lMq1YotcCE0VNDbCxR/10UH7l+aMcFe2bCrXH01hCqm0jOfS1qInPLTWZz0vyYo1ZFDIx5YjVpKRVJJH7W2esYYNIXqkwK6JvTWzbPGzew7VZIjTXtbpYCTRTQBi76eU12AREX3VHjgKg2SQKmMSV6KUC0bsB9ZQ7FgzOJ9PPSmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8r0X+naWHuk0OBZwI5XiEDRNAH3P8/H7EQAJwVLJhY=;
 b=pzsEZ+NPN79I2Gt7dw4EdQ3hMV17gu8lVwzmK8wFijNH82RrAU44z5fw6jyxM2YhgV1HW6eCwixm1+JVaQ3DHKKz5p3C8CLhfDwyc63YWm0rZkzAi0oDtaOxe0LLzYaD9YoMABkLZqkOGXxdPff1f154gwpmwg0BAz1sEX1Y9LxDS7DHqOTi6zTzqFUObiZ8o/F0j3KjykfvhehXdBR4jcbCXkooVNLNiG08ejS/YHuDn0e5kXYkzOq20MhcDl+Bo9RE5OsSmik6amKm2NKxTTnk0WDbJ24mKsVK/aOJcHWdnd5vUwJYrhtSjv3q1m9NbIP+KkpSIqE/D2gyV2JPGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV2PR03MB11523.eurprd03.prod.outlook.com (2603:10a6:150:320::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 07:13:08 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 07:13:08 +0000
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v6 0/3] drm/bridge: ti-sn65dsi83: Add reverse lvds lanes
 support
Date: Tue, 21 Jul 2026 09:12:47 +0200
Message-ID: <20260721071253.1098652-1-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::12) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV2PR03MB11523:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7e3a55-910f-47d1-20d9-08dee6f7846a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|19092799006|23010399003|18002099003|56012099006|3023799007|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: uiB4czyA1PP7QBva6SrckmsrUNyFbfPll8SkJLrrKSZMxRWR06KG5KxUv9UX/BjXQSZjqE6ttGlGIGOa1U5RDIXZqJ25pFPznXv30t1EwEqX5RJNQpvTqC/q5uiZ084s/msYhrP0FWqFmmMU86SFK7g6Ghtj+GB2TBXP4aj7msHeJrFPtivURVxmqdLwcfeZ0D+pMhUOHOBSC2Sf7Lu62pkMUDzwcE1MCq5PPQoR0L38ZkpZA90iFizVQ3AfQr10iZ5xrSCfZOJggJ0E1XuW/h4/euoIj07uaGsxlqOIbdmzHyk6YGBWIoQzu60TVT2nJosvde30fV8j6XjZ8YxaKwiVfgquAfq+VqzlcVoOpHjTrqY3PiOxRHHGOHT9VgLAJQHB1zga0B9e0QZBfLUaf88CQ3VvdV9GY5I3UYDc7hdlzVJsueYK6R4RXU6vgFbAeVX8yMxvsTb7cLiKKpAPem5rqjqrR17xTUbtdJ+Jg7A4vNbpPPQyuGT6m2OV+4Wq6Y4vLFdcQISq6E+3KhRrvmFhPLZDcOsKQ+VVCl9PNk2DSiWF5ZqheiIptWy0d4rW4fVsfJII0yf4kxrA1rbB5xPsia+RUP+3SLzhgDmSHWuYCJyUhxXYHfiMgpqH1V3OL16DKlawTJ64Aw3YLOeAMitHh9RS+sD10OZPvpUjQQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(23010399003)(18002099003)(56012099006)(3023799007)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wbVsF5dGUqXHy0bGyI7mjq7x0EaKQErwXSpDBCfBoh45S4ak7xj6PpUGECWr?=
 =?us-ascii?Q?LnLAlXVqao6eL6piqUWY8VhyrJauJ9OCnMzE9mC89Y31vJIlUsKsM4P/3xxw?=
 =?us-ascii?Q?VYcphp4W/dvqTyJoYIJQxIBsBttgLsOBWi760B4oKXixwXYBUSmXjwA8/263?=
 =?us-ascii?Q?cCnuhEique6MWs7Uy5zfbb4Cu9JUVoIQjC5YM4j7FuBAyur//VS8GlYqxZbd?=
 =?us-ascii?Q?oGq3G3ZEv+Ydu4klSkuUyH4fxzor9AuiRhSxPqRzdGZU6sHnTCxuL6i8IHAm?=
 =?us-ascii?Q?YLIbjXvwcJb11hIbd1S+KW0u3hq1Mr01oiEnG+HKkI52+aAlOb3Dh57KIjpU?=
 =?us-ascii?Q?y4Wqzw3fM/LTV809/2uXXBmkPFkiI3beYXUFQ9izgEYfywdflfoajSU2OTxX?=
 =?us-ascii?Q?RBEQbt4Tu3wp7xs2Dzqtn2uhRn2vLAf2OLUZSGBMI2TsHCSPtCX3H0yqaAEn?=
 =?us-ascii?Q?SGuLmelmrJV147Lo7/Sv5NGTFSeJ2EP5t7rFpJk/4ekej/6HjCd90dw5+iMx?=
 =?us-ascii?Q?e5FbgbCSdun2VxnBYvdbxfrme37YCxq4F/FhUMo3p1a5LFdnyDKPIA7uxhXO?=
 =?us-ascii?Q?rp2XNi8RZajlp6LKUELAwD9PFInjyuYgu968Ij8a+J2znI3wRpwS1jaqt5MF?=
 =?us-ascii?Q?ihwulGg7J1q3IGpsMcDtT0SwAqKqERmc5KvAI0uBV47vb5rCqtKoltW8plXN?=
 =?us-ascii?Q?9WoihTvCtEjLm8eQq9guc1yRS4IFJgbA+XhB/eguAtgWH1GxjHq9uDsL5PET?=
 =?us-ascii?Q?nkjyK3IBcOVlUb2pbTpvv47A9huSlo8/NLWhOk+pmRQCO8q5i/bOp3wueqE2?=
 =?us-ascii?Q?owQMtF7k8Njwv5PkAWrIqHNQbiJdMHqxdUfGzLWS2p9ElxvpBH4gVEsqyOwO?=
 =?us-ascii?Q?NJP9LePXoDfxsaRm6DtGnty+J8/f5SkE5p2YKGU/ODKGqcgYU3IaHwFj8NSN?=
 =?us-ascii?Q?5NDOj7uJdbJ05nErGSK7B50du2eYN3GAJJqDJo1OBfA4+9xoGQOslUsHt84z?=
 =?us-ascii?Q?SwMvByfF1YAFkGjY81rQsre6g+wdpw4tZECR+YaSOUSgnXMwE/JDq+sGCwNl?=
 =?us-ascii?Q?nmxdC4u4GMJp7RB+c/VHjm5WuJ5ylw0Rw8jBlEfWzAho41xVY6Wyx4duJOyK?=
 =?us-ascii?Q?fZ+hAnk77+6TLIifwEaxQ/QR9nfWpblEujl+ywj0LRfVHGbo4J7PPEigReaH?=
 =?us-ascii?Q?3dJd83QVO7X9iUObXLFU1FHA3+1+kF7CJzgCVejzNb6O2fLogrz1nVXnzs22?=
 =?us-ascii?Q?OCi4fhTLEyipry8fHVXx++PJpKBpdX9Qi4Awb0yQzkjnQR6gCJMoVmgPGbIb?=
 =?us-ascii?Q?QNyVyTVq/ZSw+DifcUqXdz9lKSKRFQIDlX88LtnkXfxSz2Mb/QabWAtCKCgq?=
 =?us-ascii?Q?hid6hlKk8TKFi6sxeeYNghGvHRiWqQF/qDZvFn3igcLhzAYLRtDffDNRajmF?=
 =?us-ascii?Q?sqk/UXfsMHZqvx/WUg00Vsw6rXtn3wHeYgDOMgeppT5RXk8G6kO3cB7pZAQO?=
 =?us-ascii?Q?LskCRUB7/2EcErEulS7U7QuryBxKyRDyWxmt3UhZULJCwXrbsn8MyKIgy1dc?=
 =?us-ascii?Q?9PYt6cWVt69sus9y6L59IIjV/CH5ay3Bmm6FaJHCRhgWaaySG5hCW6acPLg/?=
 =?us-ascii?Q?Ta3X/hYlxMIF9IBzXXyb9hnqT9VDStRwQlrD0N3z0nvf/WGmz4Sv7oLHttGT?=
 =?us-ascii?Q?GPXNXGJ08kydSJNH0XMQuuAnOAh0HhtTUJoE+nXCQVIG07Nq1WbbLOs0f+7O?=
 =?us-ascii?Q?uzr2BipUUA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7e3a55-910f-47d1-20d9-08dee6f7846a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 07:13:08.7576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/d1JbimuzXs/a/2pG1vSYjdcc6v5qY4gD01cf1pmSYwkwfwpc3pDwMzRwDboM88VYL3Ob88jFcgxzmNefgUFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB11523
X-Mailman-Approved-At: Tue, 21 Jul 2026 07:21:13 +0000
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

Add support for reversed lvds output lanes. With an optional
data-lanes property one can support default layout <1 2 3 4>
or reversed layout <4 3 2 1>. The property is optional and when
not set it keeps the default output layout.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
Changes iv v6:
- Fix wrong size in memcmp reported by shashiko-reviews
- Add missing Reviewed-by Krzysztof in dt-bindings
Changes in v5:
- Add an extra patch to simplify error handling in lvds DT parsing
  suggested by Luca
- Fix formatting and description in dt-bindings - Krzysztof
- Make naming consistent for lane mappings constants - Luca
- Simplify parsing of data-lanes - Luca
Changes in v4:
- Fix data-lanes bindings to be under endpoint subnode and not in
  the node itself, discovered by shashiko-reviews
Changes in v3:
- Add optional data-lanes bindings for output nodes
Changes in v2:
- Parse existing data-lanes property instead of ading new DT
  bindings
---
Wojciech Dubowik (3):
  drm/bridge: ti-sn65dsi83: Simplify error condition logic
  dt-bindings: display: sn65dsi83: Add output data-lanes property
  drm/bridge: ti-sn65dsi83: Add reversed lvds lanes support

 .../bindings/display/bridge/ti,sn65dsi83.yaml | 44 ++++++++++++
 drivers/gpu/drm/bridge/ti-sn65dsi83.c         | 72 +++++++++++--------
 2 files changed, 87 insertions(+), 29 deletions(-)

-- 
2.47.3

