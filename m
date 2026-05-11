Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF02FCD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 22:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C80610E082;
	Mon, 11 May 2026 22:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="eUk+ADWF";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C7F810E20F
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdLqdNv2hwZEuh3zbWD77Gz0S/Fymj+cjpUZEPBRV22nPGs2AuKIf+FtlSssHYdo2Cm8mFHEIE759C2cuG28Jm0UX9maDFJLeWsN26AsBujw2hjT8JdolS0YKdMj8bKvfWZOmojL8dYntkRz4x4x4Q8anBfOGxNHs411bk/bpmtk9bPYfosk/2jkbaZVTidFyZHkbltHDigDx4qR/htAG7QtgrB/MFCDRd2/uZLUg/jAfguZL8vE7TCkFcpqM0TZX9YODcmcB45ngtkYOEe6Oiar+0/zf0iBzVK3cigXFfuDDi9OYWlfkQBujYB13EdZosVcMW5sMSCx0nrdun1nNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekoRYnK4z55lFVyhTkG15nV4sfaeKTQNLBqvN0G2Z7Q=;
 b=StxamrdjCUmgnaxgBUbj6cfWoSzaU5yZEwe63CXrGJsqyNf2B6HpnOwkS4C6tVAfvVXMhWrsa/6mz22Ee1ZFwvRnH0OWJlyybsls2B+VlWXmoSRy+WQncTmk0pK7X5DSAsMiq22xq2GqPuaoaqBnnP+baEudrfeGeBuUZBTt4b95td9K28ujeSQ2ZinNKrV3gxFmzHUJyZ+cOEXHEEZRQiGmoE/zy1kYMWjFNB/Ff+mCE+zNPWMg93YVMsRC3lrly3zyPcxL3+05oRlPFfLQ27+CLAJRrNcfM+npRmY3Za59mD6f6pxUW8r5gx2jbwLu/0fgSZUIpqqR1pWwrP68Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekoRYnK4z55lFVyhTkG15nV4sfaeKTQNLBqvN0G2Z7Q=;
 b=eUk+ADWFiSA9ltxLI8umQBUFUhPi7wU4+U0KIkt0cs5MteKcMYhRCu7X05k85e0pt8JqK76DgMN2oLIUUIPqGGwf/+hbZpYCEj/MTAyJS+xKFOlc2+sJujbLlO1VntzsXm8h3T9rSc9lq6pOggf06Y6Q0hJRJO2/UR6sWLjTTNR81MfHTbkdmIN5yHb39e6Q0RX17b9lgmAfZQhZOadv0ibVzJ2NZTbPfXtfFs9kttRbXr4mS1mjyPsVZ2zrh53KvUl811zZnhkfB4KK1vnVHwv/qvWL22sHhuZqMuNVJdmx+pMYf3UDR57Zv8PK8pbxufVQ3v1g7EyfQ4dNqq5QKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8895.eurprd04.prod.outlook.com (2603:10a6:102:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 11 May
 2026 22:09:45 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 22:09:45 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE IMX 5/6), 
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS), 
 imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: display: imx: add deprecated property 'port'
 and 'display-timings'
Date: Mon, 11 May 2026 18:09:24 -0400
Message-ID: <20260511220924.1905571-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:805:de::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bc014d-0e7e-4c34-9509-08deafaa026b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|19092799006|376014|7416014|38350700014|921020|11063799003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: g5wtLrhNE9nJ4BmIMsG4fmvjME3wFcB0wTSGRV85R6XfgEoCsuw+L3dTwZpHmmwXAEqkXV3ZX2DiEgAYwmdll2s+wF/rq4LZ25XIJ05IKlrjgZJxufF50jn38KZbfaT0I9OvxLYawkQu1NtF5TLTN8UICXg4ToYRNArEkypFJ6lmjOXSBq4U5M3rJ84/ZwsO+CCCrOJTqyOV4Zte2w0MBNLPB2+Q6h5zWSbKcJUWh4Rsuk5K0A6K0OLXbiSZeA++IWgGT6Et7o3SVwrAQndSwARdu6kHC3OLBOuxBo4qGvh5ys6AO2YEE1kQsdbM7mQULz+FyxeT+wapUHze6h5HCq66wcd8bC+yw250cSoNkMQw3OO1ZNdxUk9+ZrLwqE2ekFDiErJaYynZaeCXGvrClWqEMIuOrZaLqRpbltITOVQ+mRFFFCRTmQSpXCtZQberMhII5pMuu30SvlFKnu06UYZaXHDUVvgi5pHXVxKKbZnG8d/iJDfIEhCqZyEyREJTbv8fbx9szgPIOC00mJYil0BucAWbuJcDoDrfV3C6QpiZt1XAk8mbq21wIQ8Jwly5WioK4PMLZXzc6AUEWHtd9CDCWusx6ukNjV/XrDeQDqC3yGkYP2NbCEnGZAy9ysYz6arGxZwh/qjJQ0Sv3SlRHw4yAqdm/UgHxEPDBS4IoqbQh+iIXPK3/rG8+tiW5HE71F4QG6AiZJrykzlpapeDYLkt42ii/wVDb9cMkLRQiu96Mqe2EXmMQJBMX8i4aYHnDA9R+tdGzDuZlUinFQMF0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9366.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(19092799006)(376014)(7416014)(38350700014)(921020)(11063799003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qoaanQrChxkfJ2rnOuTgxea2ADzsj1X8ebIaGjdQzu7CApIABErvIv0iD9JD?=
 =?us-ascii?Q?soWx3Xjwjdg1kru/wILy8U3fc6VSStdID1pFCfFnuqLx9e29VLgw4TI6BFmK?=
 =?us-ascii?Q?Z6jYRwumHysc97Ltc/c5t4X0QYjDyuveHOA8unRJCrEQcaRMWeV+uynPAs7D?=
 =?us-ascii?Q?uXfrm1EhucvM+zYMEiSCF5GS3TQbjZ0dmncWVLWpIZzNRoukQRSWoosluyob?=
 =?us-ascii?Q?q3ThHc6CA6H56lE78g3e0ajdr7gM8QQlPqUg1gMJm/MmMNKKDr4jbNkrqC0O?=
 =?us-ascii?Q?7+vNAK53HJVN5h73ewNif3ipFUcgkcDt5GKwIwhQiCwSKGzVvpmAwBhjSrTQ?=
 =?us-ascii?Q?ynn/WuyOEFrcL3yVg/p9HpmOUUvX7ej434YTeNZ9KelG+es40zWHaOKzjGlR?=
 =?us-ascii?Q?uAqD8nDrBWKNGKiSEmDr3GnnfrYYX5Aqv/zJ2gdFxYrClYup9HnMRJ7h24wZ?=
 =?us-ascii?Q?kbLBAjCnvY5nFZEOJZNoWa9rmZ1M4zMyMaVPwNd6BiBeODyu5BKw+6MXT8A2?=
 =?us-ascii?Q?ihuGPmf1AzTz93PyPwnO1Em0lkpRJiAsFl+n2KND3YdQdpC+MGq7rmJKArWx?=
 =?us-ascii?Q?gZ11ZCprvHZklHLAfa9d0sH5ITgE/KAH6OTLsSBxR153POVCmKP6m9g5ntdE?=
 =?us-ascii?Q?OIL5SJFjc4hPqvovHxYuSwo/ojBg0/p1dZsqu+w3dQftj42WxPE5ymmc2AYs?=
 =?us-ascii?Q?Zh6bN7rNq2Js0f6rg0uJEETTZRjRfpD5JyoVTyhQl7lESwRnX9ObWTAWhR8X?=
 =?us-ascii?Q?MMPhVqqVzz1nfEJpPZjOyeqWy9c/5iYilhdgJt3gbKXE91WzS5nR4p6HMKMM?=
 =?us-ascii?Q?nk2RoV3SgKGzwZy55PO2zLJHlnZVJTUEF4pUjHW4tq8RbmiALy9uj4P9DDs8?=
 =?us-ascii?Q?366/+DnkfDHKuy+4JUw3usggH0xgo4IVFvt/jxbFz5kasMbUBTrEzuBwpkNZ?=
 =?us-ascii?Q?uAXk4aZrMY9FZI8NeQPnEOv1F26/wE6N8HZ3r/XQQxjqCveM+6us7oN48ELw?=
 =?us-ascii?Q?UFtDylEwb65eNvmVsr4+GY3kIcot5+C469EwY9o6oDySkTSKz01hCd+TJ0gV?=
 =?us-ascii?Q?AXLJT7f/jK/8qPll/XKE++bmcjW81NnRWIz2RdosmCsNuRWibdlzxwJAPHE8?=
 =?us-ascii?Q?MTzJejc/mFeKGC5QYBcE8cBWdTqa2v+M+PtcSIUTGAt0vyc+7x0jP6JZMiQV?=
 =?us-ascii?Q?JBC2X3zgOaPZ/PfpkXG0orOeyI7jgCvVnKqC/eOoB+WRq6WIIKH4IXddVwPN?=
 =?us-ascii?Q?yWJgk+mCcY4XmZqv0AZzzGe3s+aswTO/SN7M0Xs/NVLqfFOKlIBHHSiAd5/Y?=
 =?us-ascii?Q?rBT5De6Zd6aJKw+eqwSRr6gGCTVGmLpBta4m9qtDVYQQVyNLz/3tPn5aUMdH?=
 =?us-ascii?Q?2eRvbG4lBIJMaWB0247iMhzBmPTExC1WiRXbDoWMQXjyjQc4OImon0T5javi?=
 =?us-ascii?Q?DPOAmGB86/1FmxoOY6QtPPLgFpkRjy+yCOytrxsuS/VyNEnCiRKxxvk1xuJo?=
 =?us-ascii?Q?42353PXCjg78mwmpzR+i57OoxOg7tzl50sanBLvh/bciLEFHePjmHwg3+8v+?=
 =?us-ascii?Q?tXkSO2Ls4w54kV4on6E7/pIXkDIxt9GebtJgro8VLwItIERgv52H4zvNds5/?=
 =?us-ascii?Q?E1lzv6tQLIOJjQ0U4o5g/HFVMealXFSlJQF7KKNJpjjVavp3aFLxaQl6s5JN?=
 =?us-ascii?Q?faW8Y7sAEZuKP4SUhtjPw8O9r268wdYfv7V7KWKArCSq3amGahlspI4KxfgZ?=
 =?us-ascii?Q?evq3RI8ALA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bc014d-0e7e-4c34-9509-08deafaa026b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 22:09:45.5401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2if90W5BeexmJ162QWgB2/QvyRHxqnKrwyqq8lTss07LGjMlqWJShvpLY5a06jAFXe2KcCqXl+GHJusVmzuO0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8895
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

Add deprecated property 'port' and 'display-timings' for i.MX5 SoCs (over
15 years) to fix below CHECK_DTBS warnings:
  arm/boot/dts/nxp/imx/imx51-apf51dev.dtb: disp1 (fsl,imx-parallel-display): 'display-timings', 'port' do not match any of the regexes: '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/display/imx/fsl,imx-parallel-display.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../display/imx/fsl,imx-parallel-display.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-parallel-display.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx-parallel-display.yaml
index bbcfe7e2958b7..b0c5869771fae 100644
--- a/Documentation/devicetree/bindings/display/imx/fsl,imx-parallel-display.yaml
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-parallel-display.yaml
@@ -42,6 +42,17 @@ properties:
     unevaluatedProperties: false
     description: output port connected to a panel
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    unevaluatedProperties: false
+    deprecated: true
+    description: input port connected to the IPU display interface, see port@0
+
+  display-timings:
+    $ref: /schemas/display/panel/display-timings.yaml#
+    unevaluatedProperties: false
+    deprecated: true
+
 required:
   - compatible
 
-- 
2.43.0

