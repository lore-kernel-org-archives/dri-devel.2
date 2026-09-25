Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08553C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F7BE10E5F7;
	Fri, 25 Sep 2026 16:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O/iY6g3L";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445D410FB79
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxzjNNFdrGpoGzBd7HPSHvWfY6pFwxrHNcZE8wRSSIjJUh/HmVEysi2nH9wWCx0Ukks2qvrMgX3wj/FpFlY41O73bfoyM+dQGWlGpmSrJV34SzZEbNAilfiju+2SzoF6y0KWekiR9HGsBvK3hglu6f5o2ecaTLo1nB2xJXM3WiqNtZ7JoQ2Y4ikFF2JkutwUyS9Ei0WapxE/E/AWhfQp2Gjq5+uanN9o6Wj8BMgww0iPCMjAYGi4MDQ1X/LKXa6P4sO5oVGjlxOEpnlbUYRXSQvIevRKSGEnSuufYwGqhlKcMSIYP5vpcD6a7tkTj0xXjmfHyO2dufnHV5dL1LM6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Tp/z4jobCUlh7eaL12HByVc/F5cKn32i7q5vyXYyDo=;
 b=h2KqhkvNOFntWdqLrlak2GAW2FyZqr4nI3u1xNSqPI58AU9GY8iOR+Bw5LNEJ3VlS/jxpmrPsOAhVZT6BU0+N31ZH6fETbDynm+yyfsBWxUuy4jidbSz7PHRbLk3axUJUsR5NPh3+y550W4tmxgIlPJCTw7Bl91M2DUASl0Xll2mzz+EErA5czfuq6+CGrpBGsauWbJPVINRYAZInuBabOc8c08/yeMaKO49sD9dsJKeL+r2hAfwA3XA9XwKp2sFVCCWKnWHCQ9JZ0qeMy02a2xjbwc2R4OqAAQEpC0D1AcdQqaIKzXtSvn7+mwo6BiIfCRnMLMP4XEd/Wy3wtObtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tp/z4jobCUlh7eaL12HByVc/F5cKn32i7q5vyXYyDo=;
 b=O/iY6g3Lpy/DT5jHX9hq4bXP+UdaBt+NkTWjXJqBkTGPHiELkkaMQKeJzaif95ass71FbfWkhyrq4OmGHooPSUc15Zn4jZImudl3iqz4cHmT+uvf9+e7zUcTFVvjSaqhTWS5Zk26knLexA/g971m5AQC+u3tI8q7JMNBz3VfrJbLGgGWyJbn8td+FJsZzN+8scnLY21rX3cmj73Xrx8aYU6IKzhe7IXMHLE3vE11MREK/5Dyzr7NMbnQaLeXBipf7++sIn02C8/kIUbqOKtesp3Gx+SnlUnmdLtrTsSeCdPIFYmFmgpSwm3xeR/MXNih73V7zWm5atuuwB+V7Niq/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMDPR04MB075100.eurprd04.prod.outlook.com (2603:10a6:20b:749::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:38:09 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:38:09 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 25 Sep 2026 12:37:51 -0400
Subject: [PATCH 2/8] dt-bindings: embedded-controller: remove
 #address-cells and #size-cells from required
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-cleanup_dtb_warning-v1-2-f999fafbca60@nxp.com>
References: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
In-Reply-To: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Guido_G=C3=BAnther?= <agx@sigxcpu.org>, 
 Robert Chiras <robert.chiras@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790354274; l=883;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=n/F5g/gWMcntk+MCSk9T5fvJ26yl62qOe+fsH1DkFJU=;
 b=dXzYEKni56LTwTp2rrIMmLr1oUQfrUXhq4yr6+gqAYxBu6/zL5QAx+D4xbIMn7kBNL0RAPmAO
 ea1msJ9D2E7AunHZB9U9gK4ojw8EwaOK7K+wzVdNXkbkK4JkeCNPHXr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CYZPR19CA0018.namprd19.prod.outlook.com
 (2603:10b6:930:8e::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMDPR04MB075100:EE_
X-MS-Office365-Filtering-Correlation-Id: 90398292-c4de-45f1-a5a2-08df1b23621b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|921020|10067099003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: mlxWqU+BU3iKm5Ab/skwjSmvQusq8X25TzzV2otEN1odeAO1oR/EYCo0vVFn30l57RI5T+XxyRJA2w8HGf1ooEnqs1vMLDFRVFFKZVIoWR6S8wUM71kLO0x0HIjra5O6AoZLcw5tRXA5OXlbHicTsuCVSXLgPOMsD9X1aKoS/nmUb6+lApha4hMRAeF4TxlyPW36wUDvFSF9hDHdaK9uqRZsL9+VOAcy61xGEw2jMPblq64PoVszzpJmZKlRk+DtVroLlS6hLrpzLhf+iMhT8eUuc2Tq4aiu3FT67XQF+35Y62kYCf+TgCg39mbedPFTGEIFErL8BeyE0Pc+71DfX/dCj/LZgWBrFK/I4/H3OQQuY6BgGzOOMULhtoF+disLeaXEXSMaZYhX0ZYK2nJVBiEezEU+XCFqjLLNY4UfOMiLcY30Y/4E0ydryAi9Pll8bLVyQ1ETnzKVlibbVHuw1cQKLE+dAss6QEe9/0ytiaiq9D0XgPAsQlINS1dNb+F54sa5tlW/UXJoX7ZFFJQ4xOqsm1OCuwDQresAnB5gFkWC1MGRLlU2E/wbf8VaUGC6+Zn7bAdE1rvktGz4vFw7/X9zqrbuoKZ85OX6Qx5+yLRbdw6iGtTqsKl2ELCyLZmw9pXvhrlSZDcGHWFwSS/5PX8+jNRdpuG8ntqNVWcsZ2z+O1pNJWi8J316TrHi3/zRyQGDp+2tJ6iOmncstlY7cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(921020)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5XYnVUVlNSNWNiT2xhL3JUWXpVb2daNS9WZTNJcExvWncrejRvUVZMSjVY?=
 =?utf-8?B?YmxSVUFVZjlIUEtEbWRYK3RuYlFRUXZ0d3pqQWhjSkRtUTZmR21jS0FjeHoy?=
 =?utf-8?B?UWhGQlg0VTRFaWxBaDROQlFZdUNVdHVjUUh4NVg1TlBPVnNPNHVVMnBQUHNn?=
 =?utf-8?B?Z0lEbmxhY1JhYUMxdW5GdERpRXg5OHFaK216WTVNY0JwczNCcm9JTVM4c2s5?=
 =?utf-8?B?RGJpR0hWZ2ZJd1l4OEJDaWw5Wkx5RTg5MHBxT3RFRUZnRnFSNTI4NXVyOWsv?=
 =?utf-8?B?b1o5TnZnT0w2RW9rajU2MFBKaDhkcmRYcnpkeEc4ai9INUF1TUJSSUpGRTZ2?=
 =?utf-8?B?RXRrNEl2Uzhud1l6TU5tSHdxemJzNjJrRlR3QUFkL1BEYXp6NDFwZStoTmFy?=
 =?utf-8?B?QmVwaStocmY4cTBURUNObDNWd2duYjBOaG5YWSthNDBROWR2QWw3OG15dnBv?=
 =?utf-8?B?aXk5TUZoQ3dpMXBOcXB5OE45TmI5MzFGb1ZHNTNXWDF5NlE3V3R3ZDlRa0dO?=
 =?utf-8?B?MnpUT0J3Z004cjhnaDEzZ2t1eE1kbk9YVjdpbnFoYkxYUkJXWW1NZ2hqRGRp?=
 =?utf-8?B?NmtjWUt0TS90OVFFeUFRRm5MdktWVCtaclRjdjRRaTJhNmxYandMNzIxN3Ja?=
 =?utf-8?B?VVc4Wi9GYVlLc2psbmdjR0JnMUtMaCs3Sy9xbXIyekZlZ0JLUXRUR1Q5OGRu?=
 =?utf-8?B?NE9MSzc1Qm5WZzZLU0luYjk3aHB3QlJ1L0dySEM1aHh2YTY2UkZibnBJTGJ0?=
 =?utf-8?B?RTY5NWcxRFhIQ3ZBSHJEc0ZyYTZUSDdISE5XRUgwQlBXVHNmbHkxRHN0czF5?=
 =?utf-8?B?MHAxbDVFcXJ6dzFkeG9TVnVrWFFVeDJUdTYyblF5Uy9tV3p3T3FPVmtQN2xW?=
 =?utf-8?B?V0Y5Y0Z3bjRuNm1ESGJ1ZkNvNFUrR1JNa1A2blpWaGs1NU1ucXU4aW4wZmpl?=
 =?utf-8?B?SFFLSGVXbU9rZTdVcVlZeStFMld0RWREUmVSRXBHM203Qnp0ZTk3S0UvRC8w?=
 =?utf-8?B?U05XbTRyVkZBdWwrVDdaTlZQRmtDdGNCTUg2bXFzaXVaU3AwYUV2UXBiN3VG?=
 =?utf-8?B?dWthTGZZZjBhdHhsZVhtMUEwWXFtMlZUcno5cVcvdHhIaUZPc2lLdzZGeU1H?=
 =?utf-8?B?SFFtZmlDa0VWVStYWTJZZkVZRWNHN3Rnc2xIbEhIdFE0OEJ1VzNHTjMzb3BL?=
 =?utf-8?B?Y3lqRU0raXhYaGp3TVZHMldxZlY4VmlKTkVHcUdxMGN5cW5JV0wycEEwKzg0?=
 =?utf-8?B?VkttdWxodGRodHhPS01USE5qMXlCemFJY3NiQVFkQVdxMTBkdXdTdVVHZGZQ?=
 =?utf-8?B?aDR6djVJKzdQU21zN2J1bFR6eWdSQ2k4dHBWYkNzcm5USTNvNGUzLzY0ZG55?=
 =?utf-8?B?NVFnRktRN3ZqSG5jTjZ5R1VTaFRScnIxQWtIam1VSWliTmJqUFVuMVo2NWpU?=
 =?utf-8?B?THBqbERvZ2Z6TDgwWlNORWtFc0V2R1hjV1lLcnJoV1B1SThXd0xGR2xWaGY4?=
 =?utf-8?B?czBFVGVHZmkzU2kyTmtQVS9JZjBjV0Eva2RDczJWWU4yN2dWb2Q1ZzB1M2ZQ?=
 =?utf-8?B?ckRwQVVtQWp5emYzNlFUeHlhU1VLczFjL0txaHRBVDBzNm04WXFQUU40VlQ5?=
 =?utf-8?B?YWNpbXIzNHFQWWxXS2M0ajZNUXZxQk9PWFc3OWtCUWFOb0pwbDBnWlRkSlk1?=
 =?utf-8?B?Um1PaGh6eXBKaUZBMzZiUzhkcFpZZ1Rock5hSnZVYkF2amVMZWduU2FZZ0o2?=
 =?utf-8?B?MlFOMkxhTjArbUhXQXNEREJkR092TVJVQkFYZHB5QnQ5Rmc0dkNRcmFjUWp3?=
 =?utf-8?B?bTk1bW1YUTVZeHFtQjBTa1lQNnp0bU1Oc1pWL1FtSytrNGRCbW1Vbjh3S0ph?=
 =?utf-8?B?YzBJaUtTaVdPOUQxdlpaU0EwNE1sYnpHL1p1WVRId2NoYnNudUZZRWt2ZE5T?=
 =?utf-8?B?Nk9aMythM3lWcEg1V1lHdXFqNGlOSDYzaUVleGlPYWc3aW8vc3dqVW1YY1JT?=
 =?utf-8?B?UG40ZUdhZzUwblhQY1UzUE1LWkVOblVsM0NWaHBUTFJoWU5HYlJ3QmFvZ09N?=
 =?utf-8?B?REFDMmVOT3FvRElsbm0wZDduOFowVE95Y0hZbWNpOENUYThkcDNXNW9Cb3FI?=
 =?utf-8?B?dUpCb2xlMTRuQk40aXorZjhKTEpkQWd6R1ZtR1A0N1dnekMrczFZcWpNNGdH?=
 =?utf-8?B?YldBSzNmNHNPdFBSaWVqQzlQMGgwMkJReUUyaXNtZmN2bEQ2M2d0RDdXc1F2?=
 =?utf-8?B?QzNrZlRoOFo4b3ZLT1lISUdwZzVob2x4NUswTk8vQXVYcGdSRFdEWW1iWTRu?=
 =?utf-8?B?MWhHclNMRnphZHdBVGUvRmJZd1dDdEkwWUZaMzYrSFgxZE1zQy9RQlpEMU9H?=
 =?utf-8?Q?fSfOQgRGNWdSbu7fLYztmMMhS0fA0iPmCb2DM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90398292-c4de-45f1-a5a2-08df1b23621b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:38:09.6563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45HjibzYOCBedLQSAtUNC3MKF3f+niCu8O+G3fB8PBxy9L0qIll+qwb4LmEs6LvN92wFGOoRQiuHe0dUXYItF9pewwnarw8rgDLBXd4dCslpqY+IIFw0xpdzdWOrmEYp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB075100
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

The "^fan-controller@[0-9a-f]+$" child node is optional, so it is not
necessary to always have address-based child nodes. Remove '#address-cells'
and '#size-cells' from the required list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml b/Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
index 82d4b2dadbae4..99f685938e20a 100644
--- a/Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
@@ -136,8 +136,6 @@ required:
   - interrupts
   - interrupt-controller
   - "#interrupt-cells"
-  - "#address-cells"
-  - "#size-cells"
 
 additionalProperties: false
 

-- 
2.43.0

