Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C6AFEEF54
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F7B810E42E;
	Tue,  7 Apr 2026 14:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ttEqSfue";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C7A10E42E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 14:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXuxvUIKN/CD/n6QJrKp+JyGFkkf5mjCfrBoSh2PAbiHgPeLlkq1EOQxHuphCTFdAjRirPfI9loJB6uLQxZdRaGe/0+u541rjjDhKE40yz62Dkod/bKf3xTYgT6HQUwaLOg2y3qrz3yN8Miam0qANYi0hE84wpra0J+TgjX4a4kJyJzwfEI1TToehOLkkBkAWE+dGKwSkYDOwhDK0MnwG9+15i9Ox7DwExP/MBYGHPR+JzXHVwqbtecDt3fVjxa0mxBPDQQJr5Q7R/AohFhOUBxt6fOMm3gBKr+YnrJ3ZE4XT653pTGFQ2+JIoZOSTE3dy2BEBVo6tovwTSO5uKQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGbzwP+wOdMI1PYWMOehoDKdS82pqpjhAslChTc53xk=;
 b=op6uYG1xUtYsjSKtfij8aZLsHKjSsZvpcL++y+Pv53URdgiGJI5Mo5jO1v4utRhRu1WBv4rteTF9k/XRY5onsId1YFT1gVzw7QBVmQ2ki0OAMFnTODT+zjsDn1qlw4n1Ic/pdSeAIicM9dqj+QDd5udEupuZUcaOm4rln2dDwoFK1U7mEssQjfnq4iBdVFQUeQaI3FhOAhLb0uBhWvT+Kl0pTNX4kEt7kfiOcwMG+zvz9NyaMwkNhPIJS5cbO4pKnIOOLGHJgJb1KX/u4P3CfSvfoa1KvyZjmhLyKDjWnrXy2rEY9gbfaDmcMcFb6de4isEMBWoCJg59D2qRtmSNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGbzwP+wOdMI1PYWMOehoDKdS82pqpjhAslChTc53xk=;
 b=ttEqSfueceLMW/+uaBVHzKHTGn3WFNhiTYD/E6Fl3CbfDBPRVf0WvHeeES+sNEaMuNn3vipzoSiD9pzb/VG0+76ahMwINnnnothPqBxBWFJYdUHtUQXeRhdsym9P9l71vi1teOwvtW8ADNhiGRmcdD8SzKpqAS0DslTcKYlwpVBIb+zHLq+OnW8FNl4C8t5A/Yjgu8/t325iIH570qfwzWeM373vi8EVF0BhlyT5/HsD+nM/tEouD7qI0/g2VvKttfL7iBuCkhNmqJZ3kAXAyEYlgSZQmAtv12004iFgROZP/iT52aWiBTwH6SX9c9Lpy8VDo9L7vbsv0PK76S5yaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AM7PR04MB6936.eurprd04.prod.outlook.com (2603:10a6:20b:106::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 14:32:16 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 14:32:16 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Ying Liu <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v21 3/8] dt-bindings: display: bridge: Add Cadence MHDP8501
Date: Tue,  7 Apr 2026 14:31:27 +0000
Message-ID: <20260407-dcss-hdmi-upstreaming-v21-3-4681070ab82f@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260407-dcss-hdmi-upstreaming-v21-0-4681070ab82f@oss.nxp.com>
References: <20260407-dcss-hdmi-upstreaming-v21-0-4681070ab82f@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0016.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::18) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AM7PR04MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3c05c3-6505-4464-55ae-08de94b277a0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: mrbwZZJKTcjAbubzwOjyk9YUCXEpayIQu1RZqX8T+3m5G1iZmfISxY7NKzdSN/QaFXpjr/PNZ0r7OwVrLZqBxH7QFdw/rHhQtBAMl9xOu13lBb2pfjUVFBDZbxzKz0wojwVkIcmXzBQSVh4IV5W2ecAC9kXFvpLfjabd2N9c9z3mjVlf1XyTV6VRni7tsn10HDsWD9u+xG2OC37DUz1XviPASa0jNQ4CdKY1b2AdJIykgBfX6SxKn2wMDFgcHdvQcbhX/4M3Q5M2yCDvmQ2xVqk0c3553Vjt9ZtiE9RyhORvTExLi2r3AM4K4Wvn2ApgTDNMCJyzJqRy5nWt+sIig1+QB1CPCoi7KnAvxPzHVUR2RU74iyP6pyswrgN3hR799YyhpRktm3uRRMJBT97f27gkZLP5xO9Yhc9mQM08zZEkqYuCqAL9wMDletTw9cqtibOEm/SISg7A0DftMnsVVdAGBuWhfWsueStB2EvjmOn3Su3K8ykLtBWRTOQGw8VMis7zDvT/uoMf1B1qHC8sREvC+NeXSzTEc1TspFJs4TKDhtAr9yOLe8kj7gklCXFqpIVu7uAwegYeROs5ymJ+0tut4KiATH8kMmb4Qx9ICyHlFT8+Fd6huBQgmhw+OSrNzTWi+ffZ0/5VUYfek3XojsrjKSuIharxeyiGkPcxz+bKeLPHF124YOBRlO0U/ECtWXiDWDTkXotTd9oRA8L3Esddh0WeSfC9F4ocipwL+7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1JxMi9DMHBvWCtnc3ZQVWo1VC9nU050c001eW0xOUpuOXdCV3FVZXZxbHhJ?=
 =?utf-8?B?RHpsNEtURGF5bVJES01lZUIzZkNjdllINjAwT2M1VVpnM3ZxZFVOUDFTbEZq?=
 =?utf-8?B?KzJTS0NtWElEZU43TlpuT2dkL1kvQjVBTDYrQVNRVTYvT3VpOC9UQkFoT0JW?=
 =?utf-8?B?TFk5clNmdWpIbGp6T0xJR281OHc4ZlRVT2ZsRnpjSmlpTmlMY1ZsZzNzNTA1?=
 =?utf-8?B?Zno5Nm83NGNqaUYzbkJSNGVxTDdXSWxnVmZzK1RLQXJxRmZxZDk3WjlrR3ha?=
 =?utf-8?B?MzI5TGhEOGFoSU83WGdMR25MQ1hBWnhFazNCblBIYWdJU0VhRnhTK3F2NXpl?=
 =?utf-8?B?MCt4N3JrcHRyakEzaWNidERyME5FRzM0dVo2eWduZi95MzAzU254VUJiK29Z?=
 =?utf-8?B?TzQvdExNUXYxQ0kySFB2Zm10YUlzMlM3OW05c2R0M3lWNEwwVHdwcnNqQ3Bt?=
 =?utf-8?B?bExkamV5Q05OZzlQbHBFR0ZQNzh2ckdBTUxIRGRxZ0RyTWs3TnowYnlpbVlG?=
 =?utf-8?B?bXF1QzRmR0dhbUx4Ynp1RjBYdFoycHFlQ004cjNEM2ZhdEovdTViTy9xTU1u?=
 =?utf-8?B?dWVYd1hQKzgvcDRRNm9IMU9kTmc5dTQzb0dBYWMvRURjaE9PYUg4anNFYzdz?=
 =?utf-8?B?TjRWWDJybFJYcDgwVVdHdDRnamlGTkRZclVNWGk5SWNFZHc1aXJKSHo4bWMr?=
 =?utf-8?B?NG9JeUhSbnpkUTlEb2tpZjhrVEpxYi9mUi9sRDlqc1JGWGRaSVRKYlNkd3FI?=
 =?utf-8?B?ajlkbmV2bzdTRlJtU1dUVjVjb3pGSnFJUlBKa2NranlOYnJoVVJvejJjeWU0?=
 =?utf-8?B?aEEwUXVocXo5Q0hEU0pSbURhWjdUblp4NmFodXJEZE5JdElYVXBua29FcEg2?=
 =?utf-8?B?OGpiRWpQRmIyTEdzVC9VUUpwSFNIeEZjUHdKVXZmbGg4eDlNbWNxNWFMZzNU?=
 =?utf-8?B?UU1HQ0lwdElTR0ZxNjV4d05vTHRncUtGV3NTSGd5bU04S3hFcWR1ai95d3BZ?=
 =?utf-8?B?cjFQYlJRckxRWTNyZCs3UGxuTGFMdXJ3WDluRU5lVDRtMm9YNlpvS2M5NjNi?=
 =?utf-8?B?dXVEVUZHT3QyeDJXeHNCU3lCMFgvV052cGFYSzJ5aEkwVSthK1FoT1dCR2Nu?=
 =?utf-8?B?eCszL2FGQXpmTTZBam1BeUZtVUM1dHM3c01Id29PaVlqOWhwRFIrR0xNSFFO?=
 =?utf-8?B?WFVtS012aGZBUk1haUVoVWREVU1vUm1sMW9SY3hINVNSMzhtcHJ3NEUwc0Rv?=
 =?utf-8?B?cjc0YmM0Q1NUMUt3MzdhaWI5UlpmVjFDc21RbmF1K3cxdUxsMmhtNUdvSElU?=
 =?utf-8?B?NVp4L1F2V0YyYnFwcno1bVNWbE9hOUprT3hoUmRtQlRGZDVUWjdWaVdDNG5p?=
 =?utf-8?B?c29IUDVGVm5Ed1JkalBNOCt0azkyempCZUNQVDUvWmRRK2xLRGpkMmhZZmhG?=
 =?utf-8?B?djBiR1pDdGtUTzNId0tUSUFtbndzTmFzckJrVjVnb0djejRlbzFRd2svOFBQ?=
 =?utf-8?B?K0FqOURYNjVxbnN2N1ROMzlQT3BKcWFUQWN6MlpsRmRqQUtDUEs3TkdPdWdR?=
 =?utf-8?B?T1BVWG9Pd3ZGN2t0ZnRnaDdQQWlZUm1FVCtLeFRnL0JqdTJOTkF3a0lDZEZk?=
 =?utf-8?B?dXg3OWR1Q3hhcDl4UXpNT215WGI2U3ErMFdHKzdQeDMwODFIZHBMM2JadkJv?=
 =?utf-8?B?YWxVRzgwQ05iRm43LyswVXZZTmZYeTVCMTRha0x1ZDFKQXZ6Tk9WZFZJSk1m?=
 =?utf-8?B?TEtlTXgyUFExWlM3QTNySllSTGNQTUdJbzVBMm9iOXBYNUtZRHRIRkhyUith?=
 =?utf-8?B?R2RDTjlpb0NzUHJYMHZ2N3I0cUFPRDY1Qno0cW03MHgzZUF5cXM5N2c1VVUr?=
 =?utf-8?B?RE9yc0kydEd2ZXJSeE1JRUwycHpJWnIvOU1SNnBqczNiZHd5cG02ZDVjdnJO?=
 =?utf-8?B?dEUzV0t3RWsvVGxWSTU5Q3ZnVjFIOTFUYUpKUThQMmRuRGFMZHNMTlg0SXU4?=
 =?utf-8?B?WXF0ZXovZjU1eDU0M1drYUpRU0tUYnRqMTdCVFNVVld3ZmJJLzZnM20wYTU2?=
 =?utf-8?B?eGo5bmtwM3ROaloyN2RjZDA2eHAxdzczcExOT2l1TktMSUUzTzRkM3dDMnR2?=
 =?utf-8?B?QjJrVzZ2SWFrUGZOSFR2RFRMUG54Ukx5dkFtUVZiZ1lrSWZuNUZEOS9QanNY?=
 =?utf-8?B?NFhtWHloSUFXdWZHcmtMdGlyY0Y4eVhhZ2ZyNFdQalgvT2RoL1RmNGRWVEcr?=
 =?utf-8?B?cVIyV2VIOER1c21WTHVvSFJwc3FnQWlRUHY5aTRlNlNKUHpDaTVQb0hrc1Ry?=
 =?utf-8?B?c29qRytHRGFKK1NiOGVsajJIZXVvdHVpQStKamdHelNpTExOSW5LelQ2Y1lE?=
 =?utf-8?Q?0xIaRUlezdHQOsws=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3c05c3-6505-4464-55ae-08de94b277a0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:32:16.7043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPBB73fhTiAhjuqA1j9eXBGL2QDcTvR/NlcZMO8YYdVy0qYgkw9I6P0SwfGmVGWsyLm+YOZlkSTwp26R9feIRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6936
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
 .../bindings/display/bridge/cdns,mhdp8501.yaml     | 131 +++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
new file mode 100644
index 0000000000000..77e16ee9d855d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
@@ -0,0 +1,131 @@
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
+  cdns,bridge-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description: |
+      Type of bridge output:
+        0: DisplayPort
+        1: HDMI
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
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - interrupt-names
+  - phys
+  - ports
+  - cdns,bridge-type
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
+        phys = <&mdhp_phy>;
+        cdns,bridge-type = <0>;
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
+    };

-- 
2.51.0
