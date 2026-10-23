Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF44606A322
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FwewvLV1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F34112CF4;
	Fri, 23 Oct 2026 19:45:42 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013009.outbound.protection.outlook.com
 [40.107.162.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B234410E68B
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 19:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqFcnNHuzSLJHP+UlpRB/pHr2ANYyf5pm+LiWnpoXrffC0WRkaRJbi1Aw7cKcj8bOy0uzjq/de51i0I7Ko0hw0d09NTjjoBckg3oCOxU1LRWmnuP8LX0ZZirjxNsGA1MFUP/aruklbI5u0xzYTqSoP/W3Z/qBjUIwvvlK3jgA1p6xdf99/yUogObg5yCuiqXA6UwFQzZXc9QQlw1Ul3oBQ8DpfBSchOcyW23xcIw0pkk96Kzjw+lbnfEZg3MSMxOU8FsIwNeTE5g7MNjQEfd9btEvUGeX575bnKX46a7l7zbyQVKVHLo85gy0lkgCpZDaHeShfsYkkT+UcLBXGckzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jmI74TMNFMvL5HpJo60QA1fnvGN2f5mV83xv3rEzJk=;
 b=VZusDaBJ+4oLsI505eRsW/8NU5oaqFTrLjG4N5XGPzwj6Uc3jvZBfAXf0G1qWTHg4/E0OpoxKofMGLFxjj/e2op7G0ScLDkUY7pgen6oPtvNC/iPJGbs+U6dQp3aeL0V85CiEph+iAnx9B5/C4JqU3qIluhavttIqs7FU2igXuufyQr66C8pxOxNrMrfq8Sg4DRB3UPmQ9ATFsDsWTP8MWZLTBczoUKD46r/z3M6cSDrg+gH7G5zdMYcSrLIcavlXK0up2HMl5IbWg7xQw9qXzxihoWVPtv9bL3oCY3UnE4ZN3pBphRDKQmwJsqec4VuVNPIXe8G/HIqGQ4A7UmkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jmI74TMNFMvL5HpJo60QA1fnvGN2f5mV83xv3rEzJk=;
 b=FwewvLV1WB7lEEvJT2XQSC2uHFNwtHfPUu3SVjh4VJzfnsh2ftWgSHusDCb6qljNNF0SKoJrFo944pDjYHr703fB/JQKyL0ldTPsMSG+D1TZfkgSXPzMUY+/CCiEchyxOgotb9R/3vNWDPvT/LD3EtRdy5/YTyCk7QVDI/4Tiea0Zynqh72+wBTvb4yeJ7Zjl3pfND4knxmvxoTn/lNSn7n3z+mcQRVGteAG6LUWRFrJwHRC8iC/Blw5ySVtQOoPjFUVdYXP8OT5wTqxVRWRQnkeCek6T8YpxLLR9E8b0MLQwctRjYx3nvqriRrevf2vAoCZXjxAvZhwNm1G+3hz1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 19:45:27 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 19:45:27 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 23 Oct 2026 15:45:10 -0400
Subject: [PATCH v4 2/7] dt-bindings: display: simple: Add waiken,101wx001-wct
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261023-dxl_lcdif-v4-2-4ae8395a4b23@nxp.com>
References: <20261023-dxl_lcdif-v4-0-4ae8395a4b23@nxp.com>
In-Reply-To: <20261023-dxl_lcdif-v4-0-4ae8395a4b23@nxp.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792784713; l=1899;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WUsqNqBjRt6aPv8QXjes/MidqJ3zB3KMiNkTOAiAWz0=;
 b=1oYLs/3rgX1FE6rjlfB7R+zmMh3SYek1PTwwvncZnMnjH6d6XdQIaFZsrekMj9WW5+rHTjqg3
 zj6DqaUDK69CAoCmtYlL5TxmhqNWE3kJKRzBsvAoKxoURMSCXX7BMDz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DS7P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::9)
 To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efedcb0-5363-4151-e41c-08df313e2fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|11063799006|921020|56012099006|18002099003|22082099003|10067099003|261021121427099003|261009223027099003|261022113327099003|261022105027099003|261022075727099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: UJAdFLe9OnpeIrYY54zfYGKNA4gSDgnz31s9WXBl5MxLUwe+Bc2cEurncxOIilRhZq5IGvxYW/oUfvUo1yKh1L4XBOCuG5gliT36jTbncRV7nCzQ2lGneDtIdN/0oX/OMGwotOIw+dyp9TFpE/oN24f2xEulbiKWOlQw7eSd5w/RlkIGx0IVOEqBbk6LkxToYyoZmVspgNBD2Pw6urnOUDGWraQcXOC+lTjQzw1FxYSlCSSUCufjHK61iG+ndl/ao0w376PEbecFgpfPkbSbqB/j0akqjiXRKVpL04Bt4ve20xvzDw77hMnlJaoYShBPoHtnzL8ZvptiI9NAUq3wDDAeKdN6vY5YyZoEtSVp9JCV4EkuNsOsoUm9t9q6npZtUEtwL0Vei4qkP3OHms9m/z8RUqb+RK/h1hXtn1xF0copYBqxAP+h/bwuAoxeWLmxLLIKECGsuARvrz1Y6rVn1DrQa/fEY1fzGi+F+42/8vbP2DowylOLDM435abLlEYwA72MrJwKQ2eKppSDGGBd/Ji0JG8JcKph0YE8pZGNeS/NFPq8ihscJUjU6fDtON0SWatDDi5Mys+GeXyw8usBjWhRKr0wXJWtGgFBxH+BYvKJkJBkNUw9OZ4WOusKPjgGYXlzyLKohTksBvt8jeyztRFexPojLDGqlhWgBZUbO8EHllqASqn2c0AykZTM8aDjoECFKo55Wa8DxGKE12vr+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(11063799006)(921020)(56012099006)(18002099003)(22082099003)(10067099003)(261021121427099003)(261009223027099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anA4L0R4TEJ1cEQ5M0tyaE5FWGdrOFJjbVB2aVBmaTFjR0szWWVEbzJCeFov?=
 =?utf-8?B?TEIyWll3VFB4ZDJTS3NMUnpiUWttNGRkc1Nlalp6OFNqSVc3TDlIdkNsNFRl?=
 =?utf-8?B?ODM4VXBwbDRaOER5bGFMTVErcys5TENnNW1SbDRjY0w4dFRLWVlUQ3JUUVpY?=
 =?utf-8?B?NXhCQVlkUE9kelJOTWRWaE92Ylo3RHBROTFMUFZ0QW5QeWFwUllxSzhXV3A0?=
 =?utf-8?B?N1psNDNPeElUMGpINXRYVWg3V3NGSVF3aURBNGt2RVp0bnZjK0s4MlBrbGE0?=
 =?utf-8?B?OWZIYTFvWFV6SCtVajcxSGxFZ2tSd1dLaGYzbG1rcForYnlNYXFZcjRNQ3hv?=
 =?utf-8?B?QWJQTGErWC9Bb3Y4VnRnbDYxSTB1NEdrMWMyZXJTWnp2eTcweXN1ZlRrSjY0?=
 =?utf-8?B?QjBFQm0xNU9TQ0R4aW5HTFNheElPRnRJa3Qybi9ObzR2SjJpM0drS0dWVTZl?=
 =?utf-8?B?NEF2cWxJZEdOYzhSeWNhUE5xa01vSUhJWkQzVVFnU0RnSk1oTVRmcnVsbGx3?=
 =?utf-8?B?NW5DUEptQW9PRStROG9zaFpMVnRCVERTN1BPQ2h5bEY3R0UvNGt2dStqZktR?=
 =?utf-8?B?aTdZWmh6VWxteWJCZmN3b3grQlJhWWNOZ3Z6dzJEd1B5aFIrUWt5dXVnSENl?=
 =?utf-8?B?dVY2bk9CbUxYbDIxcEovM2ZYUzN1VlRjclpLZkNGTTFwRFArUjdtRWN0ZzNh?=
 =?utf-8?B?UXQrQTdQN2FORkN0cTNQaGVnQ3BKdDhyaUpkblpieUdpREVuMXJvQ2thM2VV?=
 =?utf-8?B?bElzVm93U3ZMSjJuWEVFMGtmaE5DSEhyQWpGOHBhMjJEVUlsME1XdFE5Ulhm?=
 =?utf-8?B?ZVgvemwvUFdNZFFxSEFYWmlSL1pHeTIrS1dTeUloVkZmU2crb092VEZQUDYx?=
 =?utf-8?B?bUFNdkc5STF1bHA5YjJUKzJxT3ovZ0FvaUtDZ3Bna2Z6MklncmZodkhHQUpJ?=
 =?utf-8?B?OWZ1b0VVMlFvR3FleDIxaC8vQzlmV1dIYTgyWllyZXIzRC9yVkJNYWZma3pW?=
 =?utf-8?B?cDlxU1RMNDRLb3M1T09RNzM4RElVbTVmQ3liYk1UTVREQUJxQ0w0WUNuK2Vu?=
 =?utf-8?B?VUpHQTF0dmhQRWxDR25rV1VoVWdvM0lOdVhtY00yaGVMODZ0QnB3RmlBN0ZB?=
 =?utf-8?B?a3hpVnVFUS9lRlZuN20wcm9WMENpa0ROUHhodk9DeWsyOW1IcVhUeFFXck9u?=
 =?utf-8?B?MGFJb2laL3FyRzJLU254OUwrNjZLeFFEQ2xtMnQrS3BGMk4rMnhoeVFWRGpV?=
 =?utf-8?B?TFVDNHNaMW5qVC85eElQcUs0aEhpNmNPaEFwTjNwTFN2anB5QWFLMVRNKzli?=
 =?utf-8?B?YUVTVm9BY1dxV2NEU2MyK2dqZ3hhZ0IyZklueXRLMytYV1ZycE5CTndwQWhY?=
 =?utf-8?B?VkVHRVlmT1Z1dklaMmN2QWtYNE5hWTBUKy90UUppQlBKeFh2QjEvTWZnVW9X?=
 =?utf-8?B?eSt4SkJSNHl0TzA0MHI3VmtST3ludFA3bmt6Y3RuVmkxQU9wYk93ZGpBU1dJ?=
 =?utf-8?B?STBhdXl5N0dUdm9jUWhlWjBwOWZQQWEzUGtGSG5namdmUWZDVWpkZXJLM1Vk?=
 =?utf-8?B?WGlpeWdMOUpMZUlIdnBRa08yOVBOckVaUXV3TlBrS3U0OVh2SGpueTlPZFla?=
 =?utf-8?B?VENBSm9jenB3MktLYm02ZmVwc1dmRXdqcG5uUVpXc3JLM0hWTWt2TjlUSERU?=
 =?utf-8?B?Z3RBMncxMTJZOHpaTnpZVndMQmYwZHoxVVl6WXJXQk4wN211M3VXSk55eE80?=
 =?utf-8?B?N3E2cmJKa1hUT3kwOGpQOXVub3RZZ0pHRkY1a0tESU5LZXF5b2FtR3hwblNY?=
 =?utf-8?B?MlkySUszOWFwT1R6dGNrNktra0RGUWw5cEhaM1JYREV0Y2ZUTG1FZTZOTzRZ?=
 =?utf-8?B?d2tjdXcrNUxuWXB1OG1SZ2tXWnkwNk1wR2Z4ckN1OENMdWpVcDBzdDJNUUhV?=
 =?utf-8?B?VjhvL210MHdLNU94OHovaXFTSHp5eDZJNmtNRkhvdHF0UFdsMXYyTlVwWlg4?=
 =?utf-8?B?bXZlaE9ISmZuRkhybTlhN2lxdTA3eSsvR1dwdndvQ21RY0E1WnVQNWpQOXFJ?=
 =?utf-8?B?OGRVZnJVU1k0UURsTGZ5YTJaU2hhUGQvT2NhRURiek1TUWZoaHdXQWZiWElr?=
 =?utf-8?B?N0M5MEppdUNEOEthRHBXQkJZVHRlWkpNRFRrT2w0a3ArcHVRdWNrQnVoMWtD?=
 =?utf-8?B?MDhoa2hsMmNrRlpLalNaSzd4cng3Nzl3V0tJcGtpcElOamdTSGR6UkJyMDVm?=
 =?utf-8?B?SU5IZnpXQmh2QzR6RkFqaVRDMGhoNUUxTjUwclhjT2xyVUs5YXZpWEpOL05m?=
 =?utf-8?B?em1vTTM0REoyU0xTQkgvQWNsUXBKRWE3YVFwa3F1RVhUWnJoSW84cFEvLzBq?=
 =?utf-8?Q?lPJ0geFty47MI08v7YCdjbPLpPkuhA1YGTX2q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efedcb0-5363-4151-e41c-08df313e2fe9
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 19:45:27.2187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mrvr3q1m9rV5ZNoSBCwDG9T6tMQ/46/T0eqJu6icMQGIdoemgVfsBLYX1bkXi9lyQ8Q5mSgxE7W26nHkA8GZu+6hDB3rRYfe9V1E6dpVyDKCE4fnwEEIPgzWiQgmvkO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

Add WKS101WX001-WCT panel, which is an industrial-grade 10.1-inch IPS TFT
LCD capacitive touch screen display module.

Acked-by: Liu Ying <victor.liu@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- Use Waiken Technology Limited in description
- Use 10.1" at comments
- Use waiken,101wx001-wct
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 Documentation/devicetree/bindings/vendor-prefixes.yaml            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index eb49832b26c46..15f7dc0d0f6d5 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -353,6 +353,8 @@ properties:
       - vivax,tpc9150-panel
         # VXT 800x480 color TFT LCD panel
       - vxt,vl050-8048nt-c01
+        # Waiken 10.1" IPS TFT LCD panel with capacitive touch
+      - waiken,101wx001-wct
         # Waveshare 10.1" WXGA (1280x800) LCD panel
       - waveshare,10.1inch-c-panel
         # Waveshare 11.9" (320x1480) LCD panel
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 473019dd01263..97d77d1759e39 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1885,6 +1885,8 @@ patternProperties:
     description: VXT Ltd
   "^wacom,.*":
     description: Wacom
+  "^waiken,.*":
+    description: Waiken Technology Limited
   "^wanchanglong,.*":
     description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
   "^wand,.*":

-- 
2.43.0

