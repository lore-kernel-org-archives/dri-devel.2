Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA940CD4F51
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4E010E6D5;
	Mon, 18 May 2026 07:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aqF7+XlB";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A498510E38F
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 19:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4THiuUw3H8Ps0LQ3t2awwKIfndzEtCASKnnWdvPbJu9+3HpGD+Cy4fUbOPFDmrp3LTX1KqJrXLmyl2MaW/V52rSC5D4k7vNsM/XOJVwcm9cSeCfN592ChzBiFmbrKoAQGYtQ6mbfkdHtcVdAq80H3HVgSiv8tRi4EnPKdRA1wBIfAhPW+ZJewhkXnGiUGhP8NFzxaNiUAgM5YqSYd9pVHXxWYAnrR07KDhD+oo4Bb3QEGbm9XSo3EgCyjAWK93bZIKelCxGLXyqC8S7WJ3XzpAKNmDONtjvJWbv5BnjjHAyRODkRXLuf4NUj+ftAThlcfm6s8eXg2sn8N8uSncciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBr9qbX5SogYIZzu+43ahYK60O3zqrj7XPcZCiO7onI=;
 b=iMJAbSc9uDGUg+iFsxWGrBeLA0fqD7TFKTUXMuqyU5PG3P3EyKPc6x4F+DpMETXE6vNevEE0MY47MyrTyblrpTnzJmqajhGlsF33dnnLwtKV6MUI7v/VkkPZdLpgItm+9sfAFyjYfG7ktfLHasru35XSe/lzil50s21aSGVvJ4uZt+txq9cnN5nD21Mn+ZvPEKMHOZ7zRdm2Mha/Zl4Oe7AgssOsYpB9nL8vmbCD6ngriD6TOcrkR3SgU4QKXM4oJXZXNumAE26Fv4pOjYmwc9v6boNNJt5oQ4FJYyEjipM9RHKEglb0zPV5Nr7di/iWJOnXgrm2EMhn44EffdzaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBr9qbX5SogYIZzu+43ahYK60O3zqrj7XPcZCiO7onI=;
 b=aqF7+XlB4OvWBLTfk3SU1wjiVz9HJ68pFyZSd2uo9TGZS7J28UaYpqq9pinpiUtHn99FtRUqizUqqdDYe5bENqR6LXOQNL4WebDp3+3gMJHiptdp4JhPbAdwBN829NmwZo7AGsQkMsiqsZ3fRaX+YME39gj4dTFA91zXc2i8iqgevlRBW+zOZe4rE1kXXTsxSfj7wuhcNpxxr/qdiQMd3Wz9eePiWp11BT6hBRKRWCtWIoJMG1nttFWFXZiirCDrrHl3NaAhd1diwJDPiZdgmruWvPkzle25xRo+eqyihkO7NYZTswloptRJ5hntbjgi/lu+nB+oBBHe8QOWwH6g0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB10353.eurprd04.prod.outlook.com (2603:10a6:150:1d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 19:59:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 19:59:42 +0000
From: Frank.Li@oss.nxp.com
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org (open list:DRM PANEL DRIVERS),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] dt-bindings: display: simple: add avic,tm097tdh02 panel
Date: Fri, 15 May 2026 15:59:34 -0400
Message-ID: <20260515195935.2415466-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB10353:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e98fe8-c847-47d6-dbe4-08deb2bc80dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|19092799006|18002099003|56012099003|921020|11063799003;
X-Microsoft-Antispam-Message-Info: 5w+HT/F1+mpRzv7Uyxh3koLBxgpumf84rG95CjwxzoV9+TYCp5g+yLpdRQsmtEPtJLk2nvKOuKSjQKblbidAZVpxyeAMmY22ZWxr8hUTa3K0NccYLYgphsLjo5dvrSQy/UombH2w55S62WrjpyDWa+eqxjCYrvpLYXHfeuG0l9S8a+reVpROt+Cx4aE2s4IVR6j3IuESQPmoMrreRTPVyxC9s4oZReeeJY5xSIn6RDWu2OZpQF/7eizMwfO8ovcR5Eapc55loygDegVUiSdl/oMZrQAZ4nb55iLhz/0CP8P0heZlWXL6BBAleLXasIpPDVCASpfX4/NflcHI1GNUNlUkVFpWRkmlx4Ni7kZSEUa5/2Q+9NxGuD+HfUzYsiizwLTSUbavlxjpDU4b5I63t2zI2ie68nNs9odnlecXTFbVt/buBjbtfPwYI1H1su1S3G57zuO9SyWcfB7qLBwV/chs7b/HqtqwSE02O5mpBRaLG5cIxHbelI/18sFOKAm29rs6frhygiWGY/wDMkyU7wmRjaqxuTNd4gO6pEW20IfLhRHSTMQTwvA9fCG4wtZqu18Av5BEIexX1QaHqeqdB+dC477BhDEzdYirm3QsYxghu1DexQ0wBSfRaCt0WADRjs3IH4nBGk5CLSoiPSM+TXVt+OOv1cZt5xwGfwnbw16yMWh9VB1iDmgQBnDb9v/PGfbz6VbCsMy7F4tVCszrozvwG1oR4PAnbDHWvtW8y0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(18002099003)(56012099003)(921020)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iiEWydohmiEjv2HhBeVcX1xFA2n6dVrs1wo9pT735WAVhMs7AyOY/o7L2vQd?=
 =?us-ascii?Q?Cf0UkkRW/HYl0Ptc6vXz16ufB7nnXellciRATl7SWy7RVVuagsiJ5SI+uGbZ?=
 =?us-ascii?Q?MgkZ0HiCjgX5G6JhZZnOuxbxd6A1hge/sPXeJiqygHT2gA9c0/TcIjoij3Gx?=
 =?us-ascii?Q?xsXbvOJQxCKoDFpo9I6I5FaX5u6FHN3MUvLt2iR1y9uPpVBdm4M2GS/S3PNG?=
 =?us-ascii?Q?hKwPBByaG1sbrYpP516KDFAj4P7TK3N5M8qUuWjEJ4My6KT092ri8kSFKrfs?=
 =?us-ascii?Q?26nxEnYn9fKYo+JzG2D1TfqzUdFKtuZuZrQkRwqzdehsI0/1VO+AM+64zN7e?=
 =?us-ascii?Q?+/WBTk4Z1la/r4+BrWbUe7huOOaiDqJZvnHAKP5Q7LDA8uAJICLncLvFPDXy?=
 =?us-ascii?Q?w90QZHJbnnYz4Z8353M3r7OBPNO0OiWnk07/DclUIRBKS+FGobIyMHQp+8yO?=
 =?us-ascii?Q?fmGzbZyyoz5odMaaAeYuwBGurzb6Bo8aji8FrQ3ZRhwcLtxPOIyyLiPltpMW?=
 =?us-ascii?Q?W1NMGQ7KxYd7iPNAT+Rr8ECFTQ7AWr7nSdTgZxpFwhCUm2obDbRryWImdTtV?=
 =?us-ascii?Q?n4b2TiGHDYoFGJ9hknYBFPHQNVoioKdW0k9xQsqiB4ksiO9bVcNmxji4UNMK?=
 =?us-ascii?Q?AUOV6i/cNv4VmddWKuxXNRhX8C7aBez5fMQNwC8YkeqJwIxpKHxI+/6/14Cv?=
 =?us-ascii?Q?Vx6Kwv3sMVNMLLChYGx7VLCVTJLqnOK6ufvLSpAQaENpblEGP34zYdhJxu5Y?=
 =?us-ascii?Q?VK2O5QaYV1TytjWy+8Rs0/3FG3HtCLm6g8EqA0vnKikkfWT2uDo5iJvftK9v?=
 =?us-ascii?Q?46FYULi9dgEyem8uu9uX42NDUzE87YJbHlmjBqt+J4pIYDhXKEbyaOxIDrWZ?=
 =?us-ascii?Q?gFIFh8tOxv8qyU0lmWK9VA0upxonnRXwsQLMFlpHuFxptvWXTSScVRFnsVMI?=
 =?us-ascii?Q?q6YfLpqoVndeThYXWkyKhXfgc+Rw7PxqhwYDLKX02b8hk5v/swATFh+KKeCK?=
 =?us-ascii?Q?VNfcqeIhuHlBXGXm47u56cap9nDDBYmWYgZpfeVpkfV641g6CtcOPZ6sxaSs?=
 =?us-ascii?Q?oBfAOLUFDnmhZEfqLgM7KHFEbZcdPzVV6d3yOqJoV22o6wLEnYmQJOuZlLSK?=
 =?us-ascii?Q?apIMZuYu1HMCrYZXMC2jicS6QsMtLPBuntx8HeemBxY4LmesPLTHdNvQiGws?=
 =?us-ascii?Q?ePcEWNI7IafLWfb927vJa7J45OzPAcVuFgwltSscD4395VNNXZLEN6H6xYrn?=
 =?us-ascii?Q?F3YPwLPL96s8DsNlS9hCr4gjMgVX44PctD/7gSMX+b4wjGdpZTs9jxhk254v?=
 =?us-ascii?Q?6Lt2DsrNpAHsj+etrXYGYemNkt6C3MwFznF5sXqp7Fgi3tuQdv9DR9iuHLHU?=
 =?us-ascii?Q?soiL8E2nQtPTd/hqFjVPBq0TZ38NWSdq7snRs/Vj3Ug8737luJHlo2sxOUFQ?=
 =?us-ascii?Q?6qktXAuy43m7kJ2A+HEjVl+J8o7XM9T0UPl6LEcL0wwq9Rl7BEsRsOLOnRWU?=
 =?us-ascii?Q?nbE1x0HXziWVR3oB1Vc8CWeQuCdKYdaIeh2aq7ohw+7YJDXMQNqGRzXrxmcl?=
 =?us-ascii?Q?N+Dot0nskppBcfBFmjRkHXHXpOTrTOVBwQ8J/IqKl8yW78X92bGH3wPvknTd?=
 =?us-ascii?Q?4AFceiYi80IAEKbek+Z4J87sL882WQaEhB5HXuwiCdHyB6eOJZm4wkqPo0ty?=
 =?us-ascii?Q?l9RZvsfnEMr7Uj4/5XRvCHJUlbsqbQbOBD4s7Gd66vhmlQa0BsBeNO4+OHI8?=
 =?us-ascii?Q?jbOdEIWxTn1cq0deX/nvRpoj5JNZ2RYdWH38wxF6qzzZkwBsRYeV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e98fe8-c847-47d6-dbe4-08deb2bc80dd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 19:59:42.1370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltR0ee0ddgifxZPq0UP2DvQ44LgdtpFa1UpogPtaBcVhkbMqOofK+o8Vc2/RCGG9p70FeGfAq/2amTiod1e+hbRiqg6uiHdIiAwKnk16KARVLkKtYZe9s+P5rfO32ceB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10353
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

From: Frank Li <Frank.Li@nxp.com>

Add compatilbe string avic,tm097tdh02 for AVIC Optoelectronics 9.7".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index fdf522a15d2ea..a8f057208e23d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -63,6 +63,8 @@ properties:
       - auo,p320hvn03
         # Shanghai AVIC Optoelectronics 7" 1024x600 color TFT-LCD panel
       - avic,tm070ddh03
+        # Shanghai AVIC Optoelectronics 9.7" 1024x600 color TFT-LCD panel
+      - avic,tm097tdh02
         # BOE AV101HDT-a10 10.1" 1280x720 LVDS panel
       - boe,av101hdt-a10
         # BOE BP082WX1-100 8.2" WXGA (1280x800) LVDS panel
-- 
2.43.0

