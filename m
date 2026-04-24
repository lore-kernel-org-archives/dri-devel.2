Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A00FE5206
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8156910F4E2;
	Fri, 24 Apr 2026 11:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nNG6YF5a";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC9E10F4E2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/48vWC0a9rXmCmj/0FQra5oi6Z3OXZZQg6Hs2DyQdGaBQQ7HXl9JffF0xOv0U0JvdbIG9HxfEJ7KQI5pPku+sNvvm4RmWUxi4YFhl0CWWvc381lC8Gko1HHaS4561oOtrHfk9AXcbQL8zmBnrHFsDHCwx1vVxJTkWW3NeipeG1HbjuHWH1btHe4xc+/HWJG0T9H5eD36RB0t8soW/2OizJriHkYMnt0HklxHGkU1qzh1R2nZwtAlAxC7HENBQnJE0wnRMHo3lrIdI3OZJJcpI44HalL6EvLjJ+nnG2vlw8w5G7DOO10OQ7YrzU0sCNdf2HCzVCG2hzb+3/B4lUlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoGbHzhFf5l0L28y9QAlGMnK1kCos/dfaI3eY2jta7c=;
 b=ojFAKGGpwfIbRWyzFd8IVM3naYafOrI2s2Wz46OmjTDQDmuH0Ay6UXWGon/UQefwpr+mokYiWhK2iZQUayNmHoGlZwCG+rd3bZJdhZu0HxyJtGyln4XxXoQBcl+l7Ioka1gh4UfsgNEK2d/EnRF+znXcJWp0DHjWuocoOYqWu1MSfjP5WtAjatOVF/vX0GkqJUzh9trY9i/FNYeIV6p8LTTRBhfVF1OSd5lfDv9e9WkWRoQXsWfDLb5RdM8SlrLUCkLUt1e9WhaDJNXLg1wQBVunAHGwX1Qoz7uwikuW2aykzF9F/91HT3eo+KPh9vVKYxU45hxX9uSw63V393e2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoGbHzhFf5l0L28y9QAlGMnK1kCos/dfaI3eY2jta7c=;
 b=nNG6YF5ag8kYh5P+JQ//MrKx6n28vxBh91Wbp6kaovr0QBoPqFHhkOLklp3BTPqYwReJDzJIMb4q0Rlo5mKZOdUnzZ32YPxvr+nJvUjwd+2LVfSHTkrSyeZNn+qfBYpks3f2ZZO/JeJuiyyIUtHylaAOPP+4ufEiI12cegsLKvqOXsvsf09jeY2nJCkoVNIzx6GhwWGxYM3l9OMPcuPl5l35vFlSgSIhxkouYN0OPkGCVe+Vb9OOs7wMlSQTnPOlOxXhw0SN5MkO+cCl2MOQnIvsPv8yDlXhSpluaq+dcEYQJYUjms6uwUXQkaqP71mgaOOWGYindMjvudPoy/TCMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by PAXPR04MB9279.eurprd04.prod.outlook.com (2603:10a6:102:2b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:08:03 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 11:08:03 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ying Liu <victor.liu@nxp.com>
Subject: [PATCH v22 3/8] dt-bindings: display: bridge: Add Cadence MHDP8501
Date: Fri, 24 Apr 2026 11:07:16 +0000
Message-ID: <20260424-dcss-hdmi-upstreaming-v22-3-30a28f89298d@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|PAXPR04MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d5e3dd-077e-4659-2085-08dea1f1c12a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|19092799006|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: eo22r48cdt3A917hHxVvxFUQF+xlAr1NQG+D4P8uHlbwSxXh6/z1BqJYF+pviMlnqgPOnvOUhmxaORQPFd8UVBfXaQCSwwTupKzh2uZHQ4Deh11zkDhmCtZTdMWuzY3c4tv9GBs09sPltfTVv+UrMhddmPjt8MRnA2kCHkhEwBZPXegvrJthuVbgg9COqTskB9TJWB9LOMZaLLrJVrCYfN7BhT8rsMzlIa8HK69vCEjpyeM79gnsJj2jRyxj+xeo/pYtGADlBCvT2Na21HUsbqjtNXsTGTOVfCEJCQvhBADjKGFi9EKuk7Mb5T15x0VD+uMnbmskYrTvffq/GqvL1oGNAlZaAq39TudEtkqivnzy700x7lKHrKj4/jhyQnfmWMq/fcST8K+JztriOYfbgvxxujqvGWZQUgl71viqNVU+ZeQMpNCmVLjTW+bxNOXoeN47T1exULr8lAxINYH9yOvEFzEF7vfhg+jhtDSGZQKZ/Hncz6t5hbTVsWi+IYbU1ElHbxsX9S15QOJ/y4CAr6XTuNXEMNrQhbgFxjA/YlJl4g0RmRqvBaeOVJi7N/GiAAPi53bVKl+mp37/ItJ7HisTNMFg33GPNYwAFAprAdEcIz0apSaV6KLZf6L+F2oiv7rLOcqtlAiritCRff6UUW8QlgPD6H220Gin3463So8bZGuz8vvo2www6rE1mBxSg74jBE/Glyqjdmfe1hmH7VwUw4kPzdTYy3Jb5R1Evls=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3d3UzRXYlY3cjJEeElscWkzYXZlUlAxeGxmZXVpeGRFZmYwUWwwcFd4bEtl?=
 =?utf-8?B?a08wNGw0MENnQkI3bHlScTcrcEhZYXBJYmFtMExaWUo3SkdFNS92RWlWQTNq?=
 =?utf-8?B?bVc2aXJDZ1d6M2oxcmZ3Vzcra2d5TmtjdmlhdExvRWlmNExQSGNoREFScVZy?=
 =?utf-8?B?QWt3a0dFeFRUbmg2d1FpR0dkWEk5SGNEakFQb0tZc2tUY21oTVFUL052NC8z?=
 =?utf-8?B?TWtJRDF6MjJkZXZZVFNGRlRXMjRIOFpmcXZuSU5ZTTFheGFRdDQrd2h1UGNr?=
 =?utf-8?B?eEpaVnd1WmR1QUg5MG5tdWhKNTVwaDhQc0MwZUNyY0xXbWtwMjgwdGo3czh2?=
 =?utf-8?B?SUZkY2hqUkFQOVEvaDlrRFRZblRZbWQrUTUyQm1JQnRsc2VpNlN0cHhFSSsr?=
 =?utf-8?B?UFR2MThjeEZwWDVKQk96THc3ZzJ2MVJ2VHlYZVR0TGdYODlIYlZvVEgvdG14?=
 =?utf-8?B?QTRidnJNRTkxOGlwSi9vQW55VjdzQWIyTUJCNU5yM2xBVlN6ZFVPQnRMT0Q0?=
 =?utf-8?B?OUNIQ3R4WnpCTnVxeWRFWHo3V1VsZ21laWlnSnJDOTAySGlmR1J4V0xaak1y?=
 =?utf-8?B?VEY1S280bTJKUEZITFFaR0NSUC8xbkNtUFIyOEptU2dIVFpEL2Q4SEtOU2FD?=
 =?utf-8?B?UHVpTmpQYWFlYjB4NXVQaFMvSlNKcDRMdzAyRlJYVXpUbGNjblJPU0JZK0hk?=
 =?utf-8?B?NG9mdG9LbFhISmtkd25WRmJTejhCWTRJaXYxNURLcStKK0VHMnl4ajRyWDh2?=
 =?utf-8?B?cWZaV0JsZEYvU1VIRm53VDA4N3liVjJTNmNwYTJxeU0zK3ltOS8zWjYwZCtS?=
 =?utf-8?B?ODMzeEJQMjhKS3diMk41ZmdqUFZNMVZhclJEdCs4bUdObzFEekYxTFptaTA3?=
 =?utf-8?B?MzFQeVRlNTZhby8yNmJlOWh0K01PTVVnUklwMWRURkpqb2hrWkIzUlFPR2Jw?=
 =?utf-8?B?YWlNdHJaZWh1ZmM0Tm5FT1RmbVU2WlJ4QkYxUVpLN3l2TXNneW00TXZ3QnJR?=
 =?utf-8?B?Ty9aVU5QWFRjNlBwY3NuSkhjK1pnZ0xKeVdoTVRNcTJjczk0R3dIMmg3My9U?=
 =?utf-8?B?VXJDcS9Md011Q1prYUxucDNxc091VVJtNHpWek9DVUMvK1NqWTlHSXIwaWdE?=
 =?utf-8?B?Y1JiMjhRZU9nYmR3Rjg1bUJXRWFERUtseUdSaFBLVnhtVXg0bEdnSHZUYTFt?=
 =?utf-8?B?S0pBdWZqcE9IdzZydzFBSTRRY2ZuRStIc01rV25CZG9DSDVaQ0hKR1JhQmRl?=
 =?utf-8?B?aVZLL1BJZ0FDNDc5MTQxUkZMdEdaejh2KzdXNGpPcmQ2YUJ0cmNHbFNERWM0?=
 =?utf-8?B?azNYV3RYSGVPSmwyYSs2djZNdmZWSEhRd0JZd1VucUFaL1E1QS9QdTdMNmsy?=
 =?utf-8?B?eEI5MVVpTERnYXNDSWVJTWdDblpka05XcDJXUVplQnVSZWo0cDZVNXA2ZFJs?=
 =?utf-8?B?Y3dCcU9jN01qZ3h3UVJtbk5UOHhCR3pua2JLT0pMb1dQdnJERGo3TmJXREox?=
 =?utf-8?B?RzJvbnI5K05mS2M0WG5wREQ1RUlBanJxNHJiZmdNdW9kYVN4ekR1djV0am8z?=
 =?utf-8?B?QVllWnJkb1ppQ3Z3cXpnWFVoK2d2TVp0ZXBIdlp4YVhvNHRtT1JSN1NQUDZS?=
 =?utf-8?B?YXo5OVVxMEpBeDlRTllEUGo0OStOaEtoTzFWVTBPaG9QWjJZejUyWG9jeElZ?=
 =?utf-8?B?aE9yNnNlcGZ5bTdjQ056cUpHWEdtWWZ1Tnk5VkJJYjd5c09mbGVPeWt4RitZ?=
 =?utf-8?B?V3ZCTUs1T2VHRUVqbXBZUUZlL080K0dHOXkyRlVJVEtVMHdBaU1VQVp4QWc5?=
 =?utf-8?B?VzJ4UGJIVVJxTXA4MUhEV3hOeHdESkNicDRUTFA2OUo5Zi9FNklFUkVvUTVr?=
 =?utf-8?B?UllTd3Z0U3UzMnkxV09TMHRLNEVUQXo3YmJhaUtlNmorN0NHTkdna1EyYS90?=
 =?utf-8?B?OVpEeFVEMUJzYklESStzbGhLalBYYVZldmc1b1dQZ1QvWFAzWFBCajA5OTh5?=
 =?utf-8?B?OWU2SHp0K3pjY29qci9VMnNpS2hqYXN5NWxCc2NJczR5UkdFbURYdzlZN202?=
 =?utf-8?B?a1dXcDJtdHpncEhsVjRVRkdndmZQeEFiMDZwUTE0UnN0YjRuVXZLS1RrRVJz?=
 =?utf-8?B?QWFyQm1idEx5YnNCUS9nVit3TWcrckQxOXI4ZlJoR0lNSTR2RStPV0ZVdXJT?=
 =?utf-8?B?MzRvRnNKbjBCbXlFZW50bzNyTzVFMGd1TUUrbE02enpUWXpBUmUzZHZmV091?=
 =?utf-8?B?OUNrZFU0QlE0WUJ5R08yK09PT0VDRFhYYS9IVWV3Vy85ZURDT0doN0JoYXo3?=
 =?utf-8?B?a1RQSjFCTGRBeTQ0VU1XTysyT3FCakt2QVBERHNYN1dhQkVrUkZxcWo1Qldi?=
 =?utf-8?Q?3eF6YgGVlVTW2iCM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d5e3dd-077e-4659-2085-08dea1f1c12a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:08:03.4819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmFf44psiELsulWNByxr+qWMsAPNp+doPUFMV7A9YINPFNCV1kYSOfVMoClf+s4huV1rCdWI7w0d52hZXzi0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9279
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

From: Sandor Yu <Sandor.yu@nxp.com>

Add bindings for Cadence MHDP8501 DisplayPort/HDMI bridge.

Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 .../bindings/display/bridge/cdns,mhdp8501.yaml     | 135 +++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
new file mode 100644
index 0000000000000..de549471c6859
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp8501.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence MHDP8501 DP/HDMI bridge
+
+maintainers:
+  - Sandor Yu <Sandor.yu@nxp.com>
+
+description:
+  Cadence MHDP8501 DisplayPort/HDMI interface.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8mq-mhdp8501
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: MHDP8501 DP/HDMI APB clock.
+
+  phys:
+    maxItems: 1
+    description:
+      phandle to the DP/HDMI PHY
+
+  interrupts:
+    items:
+      - description: Hotplug cable plugin.
+      - description: Hotplug cable plugout.
+
+  interrupt-names:
+    items:
+      - const: plug_in
+      - const: plug_out
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Input port from display controller output.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Output port to DisplayPort or HDMI connector.
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                description: Lane reordering for HDMI or DisplayPort interface.
+                minItems: 4
+                maxItems: 4
+
+            required:
+              - data-lanes
+
+    required:
+      - port@0
+      - port@1
+
+  phy:
+    description:
+      Child node describing the Cadence HDP-TX DP/HDMI PHY, which shares
+      the same MMIO region as the bridge.
+    $ref: /schemas/phy/fsl,imx8mq-hdptx-phy.yaml#
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - interrupt-names
+  - phys
+  - ports
+  - phy
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mq-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mhdp: display-bridge@32c00000 {
+        compatible = "fsl,imx8mq-mhdp8501";
+        reg = <0x32c00000 0x100000>;
+        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "plug_in", "plug_out";
+        clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+        phys = <&mhdp_phy>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                mhdp_in: endpoint {
+                    remote-endpoint = <&dcss_out>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+
+                mhdp_out: endpoint {
+                    remote-endpoint = <&dp_connector>;
+                    data-lanes = <2 1 0 3>;
+                };
+            };
+        };
+
+        mhdp_phy: phy {
+            compatible = "fsl,imx8mq-hdptx-phy";
+            #phy-cells = <0>;
+            clocks = <&hdmi_phy_27m>, <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+            clock-names = "ref", "apb";
+        };
+    };

-- 
2.51.0
