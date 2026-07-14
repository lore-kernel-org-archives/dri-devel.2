Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199A6C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1FC10ED65;
	Tue, 14 Jul 2026 13:59:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AkgyjnmJ";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D5110ED65
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDn7FuYG1QPRUywEprcBgWl/JfRPAcQJuwijt+2P1Fw4lYEtvSZrtKFMo4E40q5/ur7C6PoIi67EWDz6WIPx2FDIwamoH62cv3JgBnG0xr5e5lwAZDreBY4G+AMJdG5CDBJV+pvHMD6/BxEBfYv5tcqTTU40SRMxyNwBEwuc1Zs+zivdjZcXJMuFn7+3nezWVWTqqzs7WvAUTLXfO131TqYE6t3C5yfRIeKdq9wnf2AlnQbZu54e49YGWowoBy/SUs1V6eAu5Ec551eSdDPFRLV/bWljNRKnUd7n4qfzVjr83vYbaHRvIEZMDHBKwY5l0N2Q5RYxgnQ8o4cwBaCrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqsQu4D8ARZUUPlV+hivL9SWLh5PN2zkxqcPPjvGbjs=;
 b=cdCLaG6GqGvzOTUaf8OfI3AX2bgJ8dtgQwBD9bhgY+L3/BKcVTO09Ug0tHZKt+tvRN6g6HTMbZ4HYEbwT7rKcSW4KKLhNjk8F71SyV20Wm9J7V9h6MSMEzURl7i/Rn0YQGLz8G0t1HWgZXc7lJdhHufGF93RephU0F+G22AQID/OXD10KFi6k30HDiDghe91cgIl+fyNiNQku8TScF2/JD7QnTooJfCxBQTcPV42eOJbI/Y1/2VueInhmV7v6fiOkcSi1sWxkdlGyLDTmmESn7RpWG2R+LA1ECp6JN0vLnIPLansGa4b57hNO9JNas9jTyF7s6q9PMbkQBZUpGZ6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqsQu4D8ARZUUPlV+hivL9SWLh5PN2zkxqcPPjvGbjs=;
 b=AkgyjnmJevpSfGG9GsQ3QEfZgN32D+Xi99aKgTvcTDZMtloIHqxzXDnwQalV+RVj9QpAtsr/6xmQmHzBIX5uh/xzBAQ9tg2cbdJguIHY32f7RhNOzcQPRQdBbViiTEPo22/DnOeLd1OvtO1DKa4jKe2fc2idgHyQHwjBGsaI4ckKQUJMGqTUvK9UuiHfVD/3q02vyqVnEyHrPh+hCn1gbuF9sUPEmwEIKgppkUdU9n2MXOiRQgK/nG06Sd3PzG2s0TNTES4x5JPk/cqsshqnkN2PjZcF4U3zt9bJn++ISfqT8lD8RmjOltdDNHv+HW/U/RDtBj2ZLAPwoV1MIoH93Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10842.eurprd04.prod.outlook.com (2603:10a6:102:483::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 13:59:01 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 13:59:01 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 14 Jul 2026 09:58:44 -0400
Subject: [PATCH 2/6] dt-bindings: display: simple: Add waiken,101wx001
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260714-dxl_lcdif-v1-2-6761a8a6592b@nxp.com>
References: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
In-Reply-To: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037527; l=1665;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=sP53lVYPOMnQbWKcGkGP8VAV1edtwxOeLzkYThF+zUI=;
 b=ZOqc0ykYFVuV6UlEusiMsukWSTNjWNebCTuia1eWxhrQXkhnudq39gah7CMkhbwUYimdasitP
 tKCiRW5E5VNCiQ2Fl7Wwar2LYpArSDE7eW606U7KE1MlG7rI6tlgktS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10842:EE_
X-MS-Office365-Filtering-Correlation-Id: b78fca02-47cd-41a9-d38a-08dee1b00ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|19092799006|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: Ah0p9bxSfVh2jNPO0dLGytgKXKgSdc+vL0JkIsc2S/YAARlX5DQp/68PUFS9sJT03ugbO7Cd5mMlD4nFz4XXxLqTSZRWcu7xP9OG69GVThb7oD2PCajd0PM86zaS/+np3OeKIRu/Ywg0B5wsY0q9biapDBtUoyn0nlHItvPKkwHXg3AwX6SaaEmau0051r0T3aBWfT7JVWcyNgIPiOCjFbXK+4OhjjaNTVGebpLtte8+1lPFG+oGbV05YtIb79JrZLwXeWki/S3CGYP7u/B/7txAMT9ONspBktD8/ZxlyN0Fxpo6dhQ8Ru2L+sEtjy9ov2Y9EFUivuzCyT5Okxj+IWb0dAkutH47yLcSZ38KPedI8mGIs4z7Om86wMx8pwPSSBfA5vr+mt0Aeim0NVuKPyMVTpwtqc6/opCAK78ObB/rRjfDFKIJkjRv3nPhf07SrRG9Ku/49XIp3hyyXBU7L80VsB2HCo1jP98HJ3W6+mgn9WH7mm8+/AFNVcYuNipTNeUri0R+x1NZz0ZmWolQlU6VYSmyJsrpMjRnAZ1VCavF16vhaFJtYQS3poNejkvTeBNcxBjw222t4UIrTG9Mn6NBhLSji0sveS1y8AdFshVuq7VhsWD8xeTfh8hwQBW68Ds0oMp+iuc68hfJK5ftO2lKajZzkITt1SHBntyHIudEkdgsAC0Zw2rXufOQTXvjYhrxcAyQcB8PIMKK48M4dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(19092799006)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW1mQkxucTdlWWNMRmJiRlpzY3EzLzlLWUR4RkJRalJFcEZycStLMjFkbnN6?=
 =?utf-8?B?SWd5c1FBdTRFT3lFUG1nb3pGbmMrNWFWbkZzaE5QZDVGNXVuVkEwNXg4bllG?=
 =?utf-8?B?SGU4MC95THZhalFEN2c5eEFCUGczaCt5UjRhUEVKK0JtYmJybTMwbTkybEh0?=
 =?utf-8?B?ZlJXN25kTGxFOGZ4VnJtRitFeGRtZ1RJbHdQdUdYendoSnpBWmJoOGE0aVhn?=
 =?utf-8?B?UlY2eUVMbGVlVGxob0dDVW5ocndoTWhpNkRsV0Z0TFpsWDFiRThBVjRpbVcv?=
 =?utf-8?B?bmZvVkllM0pTUXVyRyswY1NmQjB0V2ZWNCtPbmNSLzhZbllrQTZCWWpFWDEy?=
 =?utf-8?B?MWZwem5aTk1Pa3ROSGt0NEN2ODhIR3UyUzNmQzhITStMamhoa3RxOHpRb1hk?=
 =?utf-8?B?ZGhCMmZHa0pRNnBsN1J2aXRiMEhReVJBbmJYaldqTi9DdWJoa3l4YmVJWDQ4?=
 =?utf-8?B?YnJhcmxoc0tNTDZZV0RTbkhBcTFwRGdQOHprM0puQTd0NE9lUFBNakxFM2pG?=
 =?utf-8?B?OS81cGVYQ0ZPOGY2MWRDL05jR0c5dGtxK1c1OTVxanVIODJmeWlGM0JLeVd6?=
 =?utf-8?B?cUEyb2FPZHZPV0RuOW5wTTdYVjkrcUpyaW1XZ0pKc09IMFNUSlo0RXRyMXlp?=
 =?utf-8?B?VFlDVk53UXpnVTRlcFhRWE9ocVdmUmROd0JMVDVjanpZdHB3Y0lnMDRJeWht?=
 =?utf-8?B?NWhRRzBQT004VjRZbmZsYlVxTDZOT3FmejR4ekFkWkpBSWtpZ05zbEk2VVUx?=
 =?utf-8?B?d3lhaUIwcHhQOHI3RGZwaWw3cGFLRnFWQXY2VnNTMjZXcVZrRmVCbjNQdVdD?=
 =?utf-8?B?cGppUnF3TkNJQWxGY05keVNDeGVnNDFuU2RLL1FXTXZtQ2p2U1RIM2lqWUNx?=
 =?utf-8?B?YWFUcWhpV2xMdlVERlExMjh1ek0wVG51YlUxcDJzSFBrakU3WUR5blllY2Ux?=
 =?utf-8?B?SlNFYytCZEZQWDRyT0ZVRjFWL3U1dEVkZExxTmh6V3JPUURvS2hQMjlVbkw1?=
 =?utf-8?B?WjRKalJTY3ROWmV4cGpyQUoyYTR2Z1p1cjQrUkdCY2pVUWtHemYwRGRMVGp3?=
 =?utf-8?B?YXBYOFJwM0F3YkEwNXFBbGQ3MXIwWHRrNjZXQUVjQThhQXBsaFc0cFBtOWNO?=
 =?utf-8?B?b3dVM2hTd3VpL3ZYRU5seTh1RU9OQkRSNHpNNEYzSExaUE96L0VyeXJtN1gy?=
 =?utf-8?B?R3I1V1ZER2pMYU9mRnBNYWdtTXM0TWsva2lHK2V3MjhXWk85MEIzTEpGTzcx?=
 =?utf-8?B?SFE3aXo2ZE5tUDhKV3F4eXpFZlBXaUYwaExnbVlkOWpUbDQyTTJUbGxUT2tR?=
 =?utf-8?B?WGJISDcvdkpBd20xNDg0U1lxYnJvYzRQUkthRDE0Vkt2SmFkcDVvQ2FNTXN2?=
 =?utf-8?B?TUZLeUFIcVFvU29DUVVYUCtPR1BlOG1NYW95U1Y1ZGxnck12eU9RRENiTmxk?=
 =?utf-8?B?dnBtR2tqUU90eEs2eDhBaVZsTzgxYnRVR2djWnY5cGRmdkpJeEVZeE84V0tY?=
 =?utf-8?B?QmpxZUVsMXN3a1Q0WnFmR25rVTdHU3BOUDZEQ2h1Z0VmZzFCZXNyVFg0NW9B?=
 =?utf-8?B?aU1OdC9aQ3huRFY4VTVab2Myai9ySlRrZnU3YnVOQnRiMWo2dERHdG41UkpE?=
 =?utf-8?B?TGU3dHhaTkxEbmVyZ1lxRE9DbDdxNzVBUUFvSVJrclE2QnIzT3dMb1pjcFEz?=
 =?utf-8?B?UXp2OGV3bXo5M0xma2RENmlZK0grVTNLRklUeHF6UVhJS3JmOTQ2aDRZd3cw?=
 =?utf-8?B?MndKNk9tSlBEZmdwQ1VpbGk0SXZKSUJMcmpvVWhEYmhySkpRcnh4ZjFkQUQz?=
 =?utf-8?B?TlhaZDg1M0RkZXRoYXpOeldKU29CSE84SnNVSnExaGVIbFZSUGZUQk9NZVh4?=
 =?utf-8?B?Y0xCMWZISzQ2M3FpL0phc0M4VkFLQ1pXTGk1VWxyRFhnYzU1Y2UwV2l3YVhN?=
 =?utf-8?B?UmVJNDVNN2ErZm5vWGpYUlJ0aThaUy80QjRqZHJ6cTRZRkhQRGl4bHNpQkxv?=
 =?utf-8?B?WUNnNzZmeis3R2picFFmaUFES084VW1JYmdlZ0E4LzZYOEJDTm1wRXMzd0M4?=
 =?utf-8?B?UFhqMGRwTHNSTU9BdU5Qbkw2bzlMM29wUEZ6R2ZTSzdldmR3NVlRY0xRbzRZ?=
 =?utf-8?B?MS9jcmNRQ0Y0amFNOFFJa0h3Y1Rzdk1idU50VUhpM1U5amwvdXpxQTk3ekNq?=
 =?utf-8?B?dG5Xa2J4d0NzMW0vaHN3R0tPTFgrck5SSXV6Vm1JQ1AyKzMrWGI1d0tuL2pQ?=
 =?utf-8?B?QmFjck9wc2dCZC9pZ0FJTGZmTHdMeUJLMkIzTmRDbVJuMzBhVUpoZFNTWlhN?=
 =?utf-8?B?bXJGK2lSSld5ZHBaZkl4cGo1aWR4ZXlTNzlxR1NId2dOWk9IYUpGQTM0NG1T?=
 =?utf-8?Q?3UefSFW9+kc9B5qgVKhFoNNqXR85lfPkOt2Fy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78fca02-47cd-41a9-d38a-08dee1b00ec4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:59:01.3550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OA97nnfLhDceBen6Meq7E0GCrjcB7jbJBfh9A7EnDBXbwS+xJkbkEFgTsOXHTMkIc4D9cdGF5vz7NVWQ06R2tAEMYZPJnO+SIWiDot6hd1ogIPpjgZ5FoeJfp66mahyE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10842
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

Add WKS101WX001-WCT panel, which is an industrial-grade 10.1-inch IPS TFT
LCD capacitive touch screen display module.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 Documentation/devicetree/bindings/vendor-prefixes.yaml            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 21453f0d7ce22..01da44ed3e20a 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -349,6 +349,8 @@ properties:
       - vivax,tpc9150-panel
         # VXT 800x480 color TFT LCD panel
       - vxt,vl050-8048nt-c01
+        # waiken 10.1-inch IPS TFT LCD panel with capacitive touch
+      - waiken,101wx001
         # Waveshare 10.1" WXGA (1280x800) LCD panel
       - waveshare,10.1inch-c-panel
         # Waveshare 11.9" (320x1480) LCD panel
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 396044f368e7c..38d6765ed62ed 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1833,6 +1833,8 @@ patternProperties:
     description: VXT Ltd
   "^wacom,.*":
     description: Wacom
+  "^waiken,.*":
+    description: Waiken Technology Co.
   "^wanchanglong,.*":
     description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
   "^wand,.*":

-- 
2.43.0

