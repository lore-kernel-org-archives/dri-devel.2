Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A394CCA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60C810E252;
	Tue,  6 Oct 2026 12:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AAuIti66";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A8810E153
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBskiadXv7FR/MRZg/G4WSHo4TRKHTifO8L9/Z3vdEq8xGpIf9BL7wDYhHLx38SSfbgLDAz0/j+ZnS7TaPqaunnVpTfSI00d54rJvxYITVh95NmFqrPs//28NHzFuVmJuBc/FteAA6s1mnqrg2UTSFHrwqCbm2wTi3qQOJaASAQGk9feSV0l5YAQR1VV3PWGJpLd+XlzEm0a/fVo0eqoTEATgBBaUdGWUWt9YSAyYx1I9pbUAaqmNLbYTpYzS0HaHCStf7OMc16ZvkP8JwhHNaTWeKE2MlAOAoksNNQu7p7EKvJngjhV0WOcI4Ux6g1/7yURARniDxZ0kWSCuOk60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9E2e2pK1rduOxFzOxq5ag07EOx0kX3VEs4QtH3xD51A=;
 b=df9x/V2MBehTrIHaob3I6ilRVpff1IvK4Wk0qMXw/svio1fi/qemlg0IVPJfXBnBZBYkqHoq9gsTZwxD9IyjrVfy5tLdPhBSq3TKWJRBUODgUsK4Yh4X5ozpBE2x7Fx/es50N7GsCuKxfgoDuefyTZOazwU+Scvoaof+JfJNg120S4IlCeCcqvHZgujyiEKkOUICve8pNAjrIkiQRRfJV04j4lWmpte3vctjGzUiO/1H3Biw5NGoGPANobTQosQwilqMWIL0Zjh9lsDwPU0N2fX+xbeZkkzwfItNulxAJIpQuRMITULwrcJ6+aju5sFyCa4ORqOaKTSHWUvpt3oqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9E2e2pK1rduOxFzOxq5ag07EOx0kX3VEs4QtH3xD51A=;
 b=AAuIti665qFuvz8Vc+z315Rfi3fWbb6I1FOErvHpa4bU7dWXZ7JO+aoG5UdKUG+FZHftEqmYyyuh//caZMWovN3/tjdBCn4IAyiPLY85P3jQQqAzkTE/G64t7OdbE8PL3HUh23TMnu6HDakyVD/w9u38FBQE/4OYgbBXKqERf39lPPE4IDPHgO4HMYXYIvzzolaEmbjJvruTz3AppjOpWzzeGN7pfU61tjiKRZzqxZLhwsNj9A1mMeJt/gqLaAulBea4sazsHqWvRo8xjY8D8jsxSzkFFb4hB3WAltoxQUkfgfS74tQTW5+Gl7qOpNlq1ygDOy8iVhvAjvEAgjyhFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU4PR04MB10742.eurprd04.prod.outlook.com
 (2603:10a6:10:58c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:23:12 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 12:23:12 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v10 1/9] dt-bindings: display: fsl,ldb: Add i.MX94 LDB
Date: Tue,  6 Oct 2026 12:21:56 +0000
Message-ID: <20261006-dcif-upstreaming-v10-1-bcfb28de0aae@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::12) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU4PR04MB10742:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e0fc17-9ac6-4ac5-d6b4-08df23a4969d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|366016|7416014|376014|18002099003|22082099003|921020|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: u+ISgSQ5vbAWSDooY6q9QG76AQKBmBdkdUci7mQ48LhDyMf6/pk14HPJXSC4QKGQNctsya2NIw+YTjD0U/1eE2gzdoM9bpPVqW/DGklsHPL7CVA0KAntCEdziE7fsxC6lP8fcegTJomoouZ0IZ07lOcDF8V5HWEYTTKHboobnDdzONiZwzo28kvSXiLHzT1P30lJX3yBRMXPVE7i690JliDY8UjhCIvtmnJ77dci4Oo8IhNzafnI4AszCE+Yn9SeWR4RjRzyWTJhQ7h3sN3IBDf477dBucS+as8sdY31zgxkttdESZdbp80n47O4Rn1lDPRecSiufk+2zCKoLB7NWvKJbXS9enXxqnQQXDqOwhYLUdOu5jC+45IjpBCiQZe4UuxUaBqL7L16wQWhQisPxyGcqMBRoTiw8mxHdxWt1bKZoola5SRVd5/ZiAekUOJi4BUquhXOevI2MR+7YJjiDoP+Qq68Ip8FQAJmuljbx9n3PbObYrp/7euFdBEjOz/vqopPeAXfIDcYFNhqSFGHS8RxBUi92Hu1IQiWgfHsLWypl0qQYCDPVmBdDk8ttAb7L/BHZeyHxW3DmuAKirtrcw18f4VXRw9VsTq8e3oNoLQo88TNjdxtvbhFFbgt7Sm3UHKGigbiUz6QkbdYGiAegE23/TK7ge7w65giyTc9uBmX2tW5hjPXPHr238GHjNndNyJZftUTosv+cH5udda/Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(366016)(7416014)(376014)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTk4Zi91eGh3cTRnVjhQdWlJR0xLVWQ2dDZicTFZWmdYZmd5bFk2bURsTkY3?=
 =?utf-8?B?b0xyTytVRFNSYWVYb2docENKdERPYmpUR25MOXl2eUJuUy85UGY0UW1EUXh2?=
 =?utf-8?B?S0svUnFOMkFFK3RxMlU3clNhdlhWRHROUjFKTWZoVDhSV0FXWFJIK3NBUDE3?=
 =?utf-8?B?bWtpZjNGZzBxS2U2YTZ3WEpBNHFJZXpPZ1JPUitkOHMxdVJVMUhSMGlqcnkw?=
 =?utf-8?B?U2xLR1RmWXpNV0NZemwvMWM3SjFCYVpEK3hqaWpQd0lkUE9mMXBQRHlXaEhz?=
 =?utf-8?B?QUhKcURCbEYxYWJwQXk5c1g0cEV0UnlDSzBRNkR4Qk5wQ1RzYy83ZmNmYTRt?=
 =?utf-8?B?bTlBWkVOMm9WYnF1S0lJanlaZnVtMWRRSVd4Sm50QVdTbFFXR01uTGoyeW8z?=
 =?utf-8?B?dnd2cmlXdmMveFFCWjErUjZyb051ZkVqdUFEcGQ4YWtjems5eVRGVEo5Yjlo?=
 =?utf-8?B?R3BoRUZGWFBvanJKS0tsd0V5dEpQUC9yUzMrdmpCNjI2RzBFbjdGNXhFaHFz?=
 =?utf-8?B?ekl4N0w5Z2gzZVQybG9XYTVSVFo4dUcrcHFNdmhrM0dmcXJ3NnZ4c0V2eDBR?=
 =?utf-8?B?YmJBSmd0NEpsYStRcy9rSVdhVmp6VExha2lrdnFCRTc5MHRjRG9xL3JJRDRR?=
 =?utf-8?B?QS9vRWozamhXWnlzYVRxeG1QUXJaUnVPWmh6aXJoVDVmMWh2a2oxd2JIYzF2?=
 =?utf-8?B?c1Z5dmxENkVSS0dvVjRYN3BoWm1nOW1FL0ZnTG1BVkRFVUFvS0xtRnpFT1Bl?=
 =?utf-8?B?TG5jc0JYZzlGWW9WS1lOdDhTUUpSVUtGOG4xaU1VajFHMmwyVldib0FBZVJr?=
 =?utf-8?B?akVuK1JLUEE2SUZOU2NYSjgzMHJwdFNiRDJwMDJTY2VwaENCaEFsV3BTOCtl?=
 =?utf-8?B?eGh6d1ltL0gxdUJMdk9KeENTUE1VNzNiZGh1SURvODlJL1l4TVBKVWxoZEhp?=
 =?utf-8?B?SjR5NFpUWlRGUkJOTnpmU3VxN21mRnczYTc2MTk2OWw2anJhdmk4dVhnbWRQ?=
 =?utf-8?B?NGU3YnNUVHFOdnB5cWs3eE44NkE5RGROZEZwN0ZCTE8rMytMVVB5MVE2OG51?=
 =?utf-8?B?ZnY0eTBFSENqbEFrTy9UVW1WWDI4dE50Z1VjYTV4b2F4bjhJOWJtcmVoUDNj?=
 =?utf-8?B?cmVmRWpxVGVkVnoyK2pGRDk3TkhVa1dqNzQ0enVGV0lHY1JBWllnM3VGNkQr?=
 =?utf-8?B?UEpGU0pKRisrVjBRS0hTVnM4bnZ4VVgrbDVnbEd2SW1lR2FMWmR5blNJMmNh?=
 =?utf-8?B?TFl2NG1JclhjUUZubmt2eWdrVjJIamg1Y0VCNnN4L0JRRHBBZWNkVDFOcys4?=
 =?utf-8?B?UVcxeGloSmdHRkxCNFpkdzlib1VqMlJsT05UM1ZDSXZnZUV5NUdSSEh2YzZa?=
 =?utf-8?B?YTcyZVZGbnhEWEc4Vm9KdE5BUkQ2RHFTNm1ya25rTXdVZmdjWE5SSE13MGEx?=
 =?utf-8?B?T3JQVDQ0NmNqRitDMENSS3NNakx4ajRWWklCb24wR0IwRmdkYmRCTlhCQUJq?=
 =?utf-8?B?WTVmWWVkZzI3OFBKNkt0TWZlc2FpUTlxMmo1ckF2enZudUlOakFHTzlPbGkz?=
 =?utf-8?B?MFRZSnU1THZGcmFDUjVyOTBXd2ZBZWJacC9yN0ovb21IaXVZSy9scFZwMHQ2?=
 =?utf-8?B?cXU0MXVlejRySDIrWG1KbDJvWVpDbnd3Z3lWQTYybnowTk85aWNla0Q2QlJI?=
 =?utf-8?B?K2YrMW9TZEhuT2Y4LzBrQmQxZC9kTlViQkJEejVDSjdVRUNaTDZwOVBDNnhC?=
 =?utf-8?B?OEZyb3JkRzVXcHQ0MmZnQXUzUlRxTytDc0hTOHdwT1hRWkNreHhma0tBQ3pP?=
 =?utf-8?B?SlRPRlBUVFE2c0hPYU02MkJDWjZTQkhOVVB2akFZZlZTNWcvYWFpSXh4RWc0?=
 =?utf-8?B?UnBkL1A0eGFZd1lWUDNNSk9uSTFYS3BXbjVXeS9WWDRHd3hzUlFEK3hlVU1T?=
 =?utf-8?B?QWkvVXREeUtCWDRORDBzalFjTm4zZzAvM1U3Q2V5T2ZrYzQxY3JwM2l4K1hj?=
 =?utf-8?B?OGV6L25teUxYdVhRck5wYjZ6L1hOUmRJQk4vd0oxRktFZnUwSzRYcTVuNmpQ?=
 =?utf-8?B?V0hvMlBHOS95cWZtQWxCTEwrcWg1ZVVYTHduVnV6K1NiZk9yL1UxTThVeWNI?=
 =?utf-8?B?RWhGSnRiUGtKSFMrV01vekt6U1p3NUFDN1hkK3pCMG1Ccml3TTIvM3RkSXB3?=
 =?utf-8?B?MDNhL0w0QXRkaGpiSDU3UnhYR3pxSXBXdXJYR2RSQzJQQlVKV21oRllsRDlJ?=
 =?utf-8?B?VjdYd2ZZeW45VkxYT0l3ZGFSM3JyTEl0TDlZQm9sWUFxYnZQSmFtblduNGJl?=
 =?utf-8?B?OVpzbE5RaDJrT1hYNWxpeGo0TzIxblMwdDN3QVFWU0VFOE1DaVZZUUhvRWJn?=
 =?utf-8?Q?GFEFvR3fwdCuBGMU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e0fc17-9ac6-4ac5-d6b4-08df23a4969d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:23:11.9871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEEw1iEWytjj1afloeqCtZD+AkY6ZbCN+ic5XWGGt7wHcn3yphzc4BMphJJ3hXspriMrmF8BoazE3a0yUvbkrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10742
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

i.MX94 has a single LVDS port and share similar LDB and LVDS control
registers as i.MX8MP and i.MX93.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
index e5a8870bb76a6..87208ba724ca7 100644
--- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
@@ -20,6 +20,7 @@ properties:
       - fsl,imx6sx-ldb
       - fsl,imx8mp-ldb
       - fsl,imx93-ldb
+      - fsl,imx94-ldb
 
   clocks:
     maxItems: 1
@@ -80,6 +81,7 @@ allOf:
             enum:
               - fsl,imx6sx-ldb
               - fsl,imx93-ldb
+              - fsl,imx94-ldb
     then:
       properties:
         ports:

-- 
2.53.0
