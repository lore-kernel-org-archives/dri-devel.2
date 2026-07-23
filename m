Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E0CC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3369B10E243;
	Thu, 23 Jul 2026 19:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w/wwe4qJ";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013041.outbound.protection.outlook.com
 [40.107.162.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B363A10E243
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 19:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXEN9so4d1u7zk5w6kFaR3aSTMPyAigtX0zV+mAN8Ajgibe1RjARubKkJfZeR4W0BTwCtZqlWOLASbEJvwLLcc0F5gKQn26DI3iZrdiJtFevrD99GNoPELI+u2iaUySehIXu9jurIrgGExLMsU4iL9zzzKQXDqZTyMUcO3dQi1M5IFWJw/JRG1QpEW4IiRfdWLxAUMzXVYbdVXLwyo15me/2lbXljM26qHcKv6DeaCEDE2z6pWsOWx/A9oHA3TQme7+3uQIr2zUL84kuIDFoosVFbd7/3dcNx54HTtR3z+vcK/ynnKKUqH46SDQkHtiwXoeoJXne0wBdS/OUTl2auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpX6WFZm3FNiMppMludq48vW9vWnC993UkcuRmrMtUU=;
 b=FbHYBT/CQtPuBcrNypE6/YFKTN8zU7xiq7cxwdW/C+xZbK11O54YxD1HNzwoc/mFnWA6dlEGhLmEgtCJiWNg8rj1GF44u4uEnvN2WJKozZStWOYIcHl1vFM5oXt83N7+k+J+ZELdZxabv2Xdl1fQq6I8nEMIxsCx/guJ9b4IgHSizlrrojLrP0ccvrNmuGRKNZghGjyMYPq8HmESx4a21MB9JYgh6S+o3LBuscsucHWa03NoLnzyb0/V8U3a6CoYZCsfO8REUF0mMs8eK2R9PastU1motgfbGGK+GMyUsWRTgJxSnBl0cD5Kdvzr2TzywfNVpN1D0iyLqHAEeCx6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpX6WFZm3FNiMppMludq48vW9vWnC993UkcuRmrMtUU=;
 b=w/wwe4qJlZNUkyjrccNOEDBZEAwD3uQJW4W3QNQ3YGekmVWapxEApsAUqHcNXTfUQM82ZHYshGlCacfUHo/ujG46YeLROQAvTkMZ3vF7CtXPQEUoxuqDSMjY+yQwgx19yiQwN7/ZsIGm2hkadI6oOCFA13D+NSAnSyKyEBtHJ7la9iWTu7ga6r6Xj8+xDuwHDriv0alinFG13sMEEG8crV0o3vk8XjIe1luuW0ySDgaa7yrW/zJ44fAP85YTjoOag0VIercotM14bGOVGBnq4w211guyWO9/mhlv96WPefVge/BdgUJfP6tHoB5E2enewMrxG0sM+Eif9TswNzW1VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6818.eurprd04.prod.outlook.com (2603:10a6:208:186::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 19:14:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 19:14:23 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v3 0/4] ARM: dts: imx: fix ldb related CHECK_DTBS warnings
Date: Thu, 23 Jul 2026 15:14:14 -0400
Message-Id: <20260723-arm_dts_ldb-v3-0-96c784b2b84f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAZoYmoC/22NywrCMBBFf6VkbSSJTdO68j9ESh5TG7EPkhoqp
 f9uUheKuBk4cM+ZBXlwFjw6ZgtyEKy3Qx/hsMuQbmV/BWxNZMQIK4ggJZauq83k67tRuNIy1zw
 vjQGDojE6aOy81c6XN/uHuoGeUiItWuunwT23d4Gm3f9yoJjgvOFcVKqMR5z6edzroUOpG9iXS
 X9MFs2GF0XFBZWSqY+5rusLwSRTF/AAAAA=
X-Change-ID: 20260708-arm_dts_ldb-9ca4c548dded
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784834058; l=1208;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=stRZCS5sg9vqCEFKVzKvWSVMX0W0JyjAVs7hUTwLFXI=;
 b=GD3EAtPywHskr0aEr12wWioCdXgmpUWmuT1xz+27Htn5c9nh+jhm+U3S871swEpXE13OpUChx
 vSaR0aY9ZM5A87EqyKfLdhebI4rzN9XvUNu0ojrTXBunMAYnX51GS+9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:806:121::32) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d90bb35-2d2e-4e55-6253-08dee8ee9b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|23010399003|376014|7416014|56012099006|10067099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: 0VU8vQX+TYGDz8auR40b8zV7e0IsStZhUfIrIzbHaGASvSvK6LyEAwe4NIHyN9glbvGCEVflFALHBpoTa25GDTYHpTr07VMCSsYMOwGwK5yx1RlnjNGyVGBJnmRrMMiinCgq1ONwuZS/aThsmtm+yjszxoawoeOT5PCfRbTN6wtOG8Yqyn6jbCez1HNznKhG9/v4/XDGGWP321bdGA1Ruu/6L/MIWy7WfsIMIXEDdNl/4eV5t24LyDyrb+DuQ9k3XPLonUugLRKxradqLka20j7oWMUXGufQsRkDztSJWsn2T/lNobYYCsrdAq5sJY0CKqptgG0xrql5t4TiC86eIM2fKP0UuBWREnDrF8dNRoFIg2MOwnnYWvTGiFrda4Eo5zTM50QOT72LRRCyj+hyXWNoKQ5rPum7SVELLPtT9fuXvqVN3ZAJnVJwwg7za261n2A2gzhAET6C7pBqMgUCn2s9mZw2vE4Ezi88g/nWGI+4//HRK4L5NuXLNnVjc/mLb1H9dRY6GpzaqoCu6CQUsUTXootCoeflCYzBvFT4bJDkbaPw4yvohKXfC2dsjVZA8PwLM+98IECWzSfUaAHfc8KgjE2C6Mltu9P4Cz114QAJXZYeCbjVGIireRowY4l7XTq9FdxOQR3cf9z7PI6TjcY1OEy4zF3kVxRKIR7uYSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(7416014)(56012099006)(10067099003)(11063799006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckNldGcyZ2x4QUliYkd1Zm9veVVZR0JURmlaYklOR21zK0lwakd4b21ld0o0?=
 =?utf-8?B?MmthVUN1c3ZJdzcvcGlXYlVzTjJUbTlLcnpuWVl5SlNoR1Z3OTYydEpHWEdr?=
 =?utf-8?B?Tk1mM2pSSE53ODh5MC9ZOEFudDkzazJjN1FWRUl4YU0rWVhHZWVSWkE5TFZO?=
 =?utf-8?B?SnZiOEtENHJ2ZDhLMDRjemZZQ0JydEdSdVV2OWt4TFU3aG53QVdTNHNKMS90?=
 =?utf-8?B?ODZ0R3N4R0cwSkNiSjM0NFJuTzBkQkxTQzJsTWx5dXR3QkNHdFVhWGEyUkUv?=
 =?utf-8?B?KzJ2L0hhclYrMkVPY0ZYNWQzSDFOMVdURFhDYXp1ZE5NQnZaRHFIMkRIcllw?=
 =?utf-8?B?L0laaDRaaWdMeUFuU3I3VmllWTZwaFQxckNNQzgwaWRPQ1JZUEw4MjFhQjV2?=
 =?utf-8?B?Q1VYZCtST0RkVE1DQUF5S2ovZ0tqTGRUNmdvTTVLR05PK2FiaVBBb3Y0SGRu?=
 =?utf-8?B?R1FOU21hUHVyQ1lZRG9OV0xjeUl3L2dpTWtYVGpxVWNtR3RySlJZd1pzMDlm?=
 =?utf-8?B?STE3OFdoUWZkZG1JZ1FNTmZHQ0V3L3JyY2hpQmNaWmVkQVpZMmNET0hidGxH?=
 =?utf-8?B?UkJNQlFuMjJ3dE5XWjJCRzMxUjYzRytnR3VHSFBNazZHSkdPQVNnSG1GSWwy?=
 =?utf-8?B?THE2NjVCM09aTU5KaVkxVnl4SmcrSEJ4MHBZU25GYlhkS2NudXBxbXZtbDRD?=
 =?utf-8?B?aXNadUp6a2hsQ1dYemdhQ05lVFNVUXY5aEVpa0lScUxmR2Y4emZTa3FBVk5U?=
 =?utf-8?B?VWxicUx3eXo4Y1NyODd4MVluRmxnKzBhS3R2Q3V0bEtZb1l1SmFkS05POGFl?=
 =?utf-8?B?aHVibWRFT29Jd2pXd0lNdmxxS2F5MW4vcHd2R2Y0UmdTR1owVDhrVXZ2dURq?=
 =?utf-8?B?Q1JNV2gybDI5NDJCR2NlS0o3Yk45azFyUnpwYjFKUElqeE9KbmVqaUpicnFt?=
 =?utf-8?B?aWkrRi9hNnBqbEpkbWs3ZzFQa3JCeXAwTWhmWmh1c3NQQ1NETEZya1ZaNzY3?=
 =?utf-8?B?NG1MbTRSckxBVEZSa3VDSEFaVkdKNkE0RkJtdFh6TERqdHZCZk1EOHpJTHA3?=
 =?utf-8?B?T0lCaThSOUJtZzZlV1dWSHVaSmlwOHVIcHFialR2RjNFTmg0UDNnM1IwRjh4?=
 =?utf-8?B?TjlXM3FmZ3dUcWl1d3BGOU9OdGVJRW1zeTRTWXJDaUx4djlxS3VTTDJvdGhN?=
 =?utf-8?B?UmlHZVIzMzROQzlLYXZaQTJhZ0xRVkk0TDE3L3BWUlVVdTRvL2paRTUxd2J6?=
 =?utf-8?B?K0doRGlnQW81WDdIK1lrVHFEK25ITzRvVGg3T0FYUTBsS2VCVXZWRjhHYlNP?=
 =?utf-8?B?aGtYOCtJQnZZbVZCQzV0akJpc09SOGFxak5VUlViS21zMFJPVXdJVGFPdzhN?=
 =?utf-8?B?ZG1rS1JrNVA5TUdFd0JWMnB6aFZXdm9DSFpONGhwODMrb2VpQ09iYjhyMXhE?=
 =?utf-8?B?UzQrdUp6c21OMDI5dHlOWU9EM1UzYTlUbEpiOHlXV2prMFNyMVdzZVM5RGIz?=
 =?utf-8?B?anlMUVNIQVpTcUwyRTExbzdDdVc1Y09lQUU0NUw0NkpFQkRLaGxIME04RHBp?=
 =?utf-8?B?ZjJhSlh0WlFNS0hTdjNmcnFFRHRtVGE5UWFjWkhycTVBeHRCc0I0aWE0djE3?=
 =?utf-8?B?SzVRbUY0UDFaU3U3a255UWcrSkJtdTdyK003bTdUY243c01vZHlBMUN0Tjhw?=
 =?utf-8?B?MFpiL080NElIbTJYZytpZmFjdEpPWXBSWjQvNmFxYjZIR3M1RkdxS2tZOFY0?=
 =?utf-8?B?MGt3RTNUUmd6L3JoSTRoZ0JrblkrdTdQRXd4NmNBTjNpUXNYOXVjekljZjRT?=
 =?utf-8?B?R3FySFVtckFXU3VuNGNlWUh5UmV6dlh3R3g2YVR2QUZrMm50eVY4SGxCTFBp?=
 =?utf-8?B?OVZtTHJ6UTNUQ3dsK3NMd3g2ZXJmQmtrY3dBbFBSd2prenhWdDhHNTNyaTlL?=
 =?utf-8?B?R2dvVGJNa2E2dGNGQ0RpeENHS1IvQlNlZGVXSk5IZlRVcUNBaWFVa2R2bG84?=
 =?utf-8?B?Wm95ZlRxWHl1d0tCVG9KUUttWVIwWDdoM3NyL2JINXg0R2ZWaWw4TE5ueStN?=
 =?utf-8?B?M3JIVWdkeHY3ZUF6NGtQNWsrZ1JVOVZubTVmelRQVXFmWG1qRGtKWUxKZE5k?=
 =?utf-8?B?bFQ1dHFOcXFWb0hLdTNJYjNTRk93RE5kMis0RlVHeEV4R1A3aDJMQ3gxU2RZ?=
 =?utf-8?B?Kys4d0JJd2VVY1puS3hjcktpdHFkUkEwS0xBL3Y5aUVGb2tVS0toYllzNjJM?=
 =?utf-8?B?aElDQkJLUGV5WUtxSXZSYnBWdUZhb3gzcFdEOUl5OFVZQlBOQXJMVjZnSnJ5?=
 =?utf-8?B?RFRDMUhmdC9abW9MNjZXclZlb0ZUcUszMUF1a3hyenAxYnUrNlBzTFhCcCs1?=
 =?utf-8?Q?D71fQmfTaH+Re3bWE6zggxkJ8qk5WgP6JF6qZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d90bb35-2d2e-4e55-6253-08dee8ee9b15
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:14:23.7623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZnhODHRrXb2p8aLfDoCHdLVWeA89HlcgoWy0UZHDfhUpqEbZMI6wHnkT84cR1rRHWM7BnlmTGXvcJq368ojPRVO/p5dONDwq/LA/XJfDweqys1qibHmm4BO++PMmSYX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6818
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

Fix ldb related CHECK_DTBS warnings

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- add ranges
- collect rob's acked-by tags
- Link to v2: https://patch.msgid.link/20260718-arm_dts_ldb-v2-0-f5669571aa2b@nxp.com

Changes in v2:
- Remove status = disabled at binding example
- collect rob's reviewed-by tags.
- Link to v1: https://patch.msgid.link/20260708-arm_dts_ldb-v1-0-4f5579b85797@nxp.com

---
Frank Li (4):
      dt-bindings: display: bridge: ldb: allow a single reg for fsl,imx6sx-ldb
      dt-bindings: soc: imx-iomuxc-gpr: allow bridge@18 as child node
      dt-bindings: display: lcdif: Allow display0 child node for i.MX6UL
      ARM: dts: imx6ul-tx6ul: rename disp0 to display0

 .../bindings/display/bridge/fsl,ldb.yaml           | 23 ++++----
 .../devicetree/bindings/display/fsl,lcdif.yaml     |  1 +
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml       | 62 ++++++++++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi        |  2 +-
 4 files changed, 78 insertions(+), 10 deletions(-)
---
base-commit: 6c94b38b83a04c43ea49004275f0391404051093
change-id: 20260708-arm_dts_ldb-9ca4c548dded

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

