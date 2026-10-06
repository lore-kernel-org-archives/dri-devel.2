Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04439CA6001
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C5410E3C0;
	Tue,  6 Oct 2026 12:23:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UmFwHTuj";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2CF10E0D5
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:23:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kT6Nse4yoiAi/kAXQBXYQe6ZsjvQzGLRFV3BKQFQ7JW1NEdJaN2hoNX8xpqbZLudUTXyNn+at5kU2x4jNF9BsbRsV8KcevD4HQKUg3mxOp1+ThkWXcuFDGOs9POp0j6XKZkECgBeJsKNxaphipxUAQ6ljR/Kttw1TsnRUQI1aPmHpvGAICzk8z5JuNmGVKmwOCABx2PGgNJFs/Iu2dk2NwKr33mwG0cFcwGxX7oOOp5a1VpawTf32ZPvyBWeqkp7iP0taeA9uxzaik9b7SI9giiuX8uLRrqL/8Z6y5RmitXtzcPXBytiPYe5LFzzkFg/ASYSfShK5FrErSLtDKxMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luxxy3DlfbQnr0zDgU2+65NWarwwJHYwJimRGjBVfMQ=;
 b=Hl7eMhV6eHrTw7jHhU5/HAzX8QrmcIcJOrthl47BU025lijROgCsth5Qj8pXbUDvM03k2JgBBbMS67pKLpLXC3SbwvIzRYhvLj2AJSi3LaknERBR4bQgUyfU6VgUh0sty9O5zLGvTp7bPqlwK5euAg85ULVeLVcAdIb2IH0ph3bC3k7yZ+8M3UkYLqtbd5iRj3RZTfaAw8situVzQa/hKmCX69Tha34PYkSIZSvqqt0a0jmpBpcpF/3Yf08ZTmS71SBNeCQQKJyiFzBx+Inwg9BcikGGtxyvHHSjb1XA3956JnoNygx+xW8OPRrMrsLBG4UBwfRZ43k/kvWMh7OqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luxxy3DlfbQnr0zDgU2+65NWarwwJHYwJimRGjBVfMQ=;
 b=UmFwHTujZdDiyNlXutuPclQLb9tCN81O8NxCPx7eetQyipkcuo+nuAxWK7w/9d6aRirgu/rnFOBv5RhLhC4DQJnlCUOPgb9qZMWrtTvm7GE4cvl5UEIk6l7lVXjbhOcyhmde2KNZzEtXcbdTMv42CK7GWehtckL0h6JoYYW5ZUHeK53A2ELcW7r6slg0HND3c4YNLj8Y4NNzCySjZKI9DnOEf2fjer6kMPIsg7d8Fvo/8WnvWlXsd8Gl0dvgthnLcvjVGk8GGolMWhA9yHeib/PYRps10N66kcR3Ks90M2Lf6EFUI4EqPS6hykzRigDlpXCZYKosvLkXDWvG4EWm7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU4PR04MB10742.eurprd04.prod.outlook.com
 (2603:10a6:10:58c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:23:35 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 12:23:33 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v10 9/9] MAINTAINERS: Add entry for i.MX94 DCIF driver
Date: Tue,  6 Oct 2026 12:22:04 +0000
Message-ID: <20261006-dcif-upstreaming-v10-9-bcfb28de0aae@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU4PR04MB10742:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a9ff4d-6daa-48e5-649f-08df23a4a366
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|366016|376014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: HefWsqY1hkk00+F3xhaWp4gbk6gtCHbMONESzTdmg3SIa4qii0I21IhCsSLdXPWbrvjo30gnz3gxhVW3qnLIG4Dv59ffnfoLJzcgPk02h6B/gQ56k/mU8Ki8HGQUiLmWGjgL3Oqchn8kfwF05ZuH5JyAXFsQuOGqa8FZYfVBL9GWribOcZ118W7roUpNKORdCOvV0Ap73GECP7lyCNGNyVi5M2jgRvauCyBOyL+2+Z0nZcOejC6FUN4qPsC7FOf9Svx//RVpr7INP8b4ESPHkE3/cg932yIbwD/BrRGypQHQkfIFXxQx2KMywuFqPthtsQSjp8Lpgo1t+u+2oWfNDqQPotJu5ZONw1eSXYW9UVw4qPuRhqq1i7oub61uLUBrf+xTBXKYVEo5oBQ/YK1olOa4+hoMh/g7+7i582w88UqFqmQehwZ37MvUbeL4m7XkdYxZo1HCWA23ZAwX8BIztIG4E+wW91NmVchc78TAsQ382/NtxMXPfBfluSqEn1xvfKg3TXIfW4iwgr+CAF5gZTAavTKtcMbBfP98H/TNu+n9thR4HxPi5Bp49K0q7s1tCntCzBo+NPKdF8MoGRKDnSxUB0UeTTBzJUq0oXrjMeFEti+UocjnpXy3ZMLmhDIV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(366016)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDc0bDJzclg0aC93anZEdmMzejc2SWVQaUpBSHZ5MXMvVEc2TnlYTDFWNGZ3?=
 =?utf-8?B?Ny9RSjJkb1NUNHZDZnhDRVI5TzFHQUdPamFLUXZrSE9yQ2p2V25yOUp1a04v?=
 =?utf-8?B?eWExVTNtd2JHcW5qWGV2Q2FVR3BqelNJdzdrdzdyTjUrMnFTcUE3d0phcW9B?=
 =?utf-8?B?Ync5aGNBQmpmRGMvQnVuUmN5UmVhaGJMZ1JNekIzWUZiWGVPSytHeHdsNnQz?=
 =?utf-8?B?VWZ0ZmxZQXJZR29HRmxjM0x5TFV6UXFMbjZEWElMbXlQaGZTV0gwbUtIa2dQ?=
 =?utf-8?B?NzFKQzBkdE1zRzB2bTBRcDdDaGt3WjJyQTczbDZXMnArdEdtSnNjcXY4UVA3?=
 =?utf-8?B?bUx2REQrTTlybjhvblg2UzJIWWZwT0ltM0FRZjkzUjNFaUlxRU0vT1VpUmFY?=
 =?utf-8?B?WG9zZHBqVGo0ZzVZaWtwTWRXemN6SDlldm55UEE5eERhSUhxS0ExQ3c3VFRR?=
 =?utf-8?B?Yy93YitJMmNEa3hHOTBPOUVPWmFDQTFZTVF4UXBLVHBNSGd2NFExODVZak9N?=
 =?utf-8?B?TE5KYW1UT0dPYi8xa1lmdThtd09YdURXRytZWW1zVFk4eXY4RXVtb0R1UGZI?=
 =?utf-8?B?U3c0Q1I2VWZMeWdYcllJQXc0VUlsV05uSnQzVVhCalFlSkh5UUVXbTVDZm9y?=
 =?utf-8?B?dThrSmQ1dmorZUxpaXA3WXluSEs3QmEzVU9hdGlSZkNoZlR4eTNYTjUyVUtD?=
 =?utf-8?B?ZHlOYk1OZTJtSmozUUVvZnhRMnlNdGdvNHVueWh6ZUppdnJQbWZiUHRhN3F4?=
 =?utf-8?B?TU9jR3M2eXVNQ2NGTkI5V2U2MHRRYm1nODFQS1Bmc2l5a0dFaXdHOWd6QjJn?=
 =?utf-8?B?MUtrVUNwQmcyRUxRQ1cwbGRVdmhtdWtRVkN6Mkkyb0wzZnJ4SkFiZEdGM0NP?=
 =?utf-8?B?SU5BV0FUdGF4Y0JCQ3JHcDFwcXQ0Z0MwL0ZQY2xMU1c0TjJyM3Y2dXZ2SWps?=
 =?utf-8?B?eFJPYTUxV05kM1ZoQ1gzSDZFbDNGVGJxbFlVaEx3ZkNrUzFZL1VYR2krK2ZV?=
 =?utf-8?B?dFlxdzhDdjRnMnd5aXNFalRRcUZ4Q2gvZU9SaE81V2ZCL0xVWlM2N0o5czY3?=
 =?utf-8?B?S3JzWEU5SnFoR05yejU4bUZJQ1NrTk95YWVOZ1VnSHRyL1VXanNTS3hoaGhL?=
 =?utf-8?B?c0gxdzVBQXpacW5Pd1JkSnlGY3dOVmo0MzFIVkc0cjZLc3ZDWExudjhFdDR2?=
 =?utf-8?B?WlpWWE0wSVk3RW9Db3lVcjlWNXBkK1BkelFNTXJBOTNzNndiVHJOSHZBQzRK?=
 =?utf-8?B?a3FtRDhxcHUwMUhZL2thcFNndXhld2dZaUpOcGZyNERyZC9kc3RMOXEzSk9T?=
 =?utf-8?B?K051SDE2ZlJGQ09mUHhydWg4VWxnZ3dJRW5LWnpPMGFJcEMxYk5abjR3bWQ2?=
 =?utf-8?B?MnQzSE8zanU4NENsbnVMTFZER05BU0p5VXRDZFQwdkFycHowWGpGOGVBNzFv?=
 =?utf-8?B?dDRQUmdOTDNEdG1hdUsvdGxpVHlJTjRJWkZ3VmwyWTIzbzFpaFcyeE1ZWHJn?=
 =?utf-8?B?cEhyU3NGWE94cTNJblZPUWVsdkdoNmJKYWhVUnYyWG12UDNzcGVDRmZSd1p4?=
 =?utf-8?B?SzJRVVN2cDRkTiswak9NcDN5RURQRDl5T3hQZGxuNXFUKzRVYWJVNFA5UVJi?=
 =?utf-8?B?UkJaYS9LN1QrK0g2SkNnSWtCNk1pVDUzVlV6UXlIeEFMTXlNQUl5U3BFL3RN?=
 =?utf-8?B?YWxKWjZlOVRUK0FtQTgyQ2JoM0RENmFIaWprbENyWkpxdk92UjJ2d1h3Mmc4?=
 =?utf-8?B?UWdYbXEzQjFhNWtsTEsvQnpVTytVR2cwUFVhSnUyNHBYOTh0NjlPSGtLMDht?=
 =?utf-8?B?bFBGT0NuTnpXU0Y5QmhhU290MldWY0JzR3NiL29MLzhmbUpwTUhrZVl1RTlu?=
 =?utf-8?B?RHJiRG5NNyt4UHNEcGNhYVJYNFJOcnA4a0tHVmF1eTBqeW0vcTIxT0k1Mjgw?=
 =?utf-8?B?dFo1Yjl1VXVGa1lnZVhLdHAwM09uMzV6SzZSVWVrTEhmak02Vm0yVjVDcWls?=
 =?utf-8?B?Q3RpNUl5N2NFejcwblRmU1drMldBemJ0eUp2YmxOVVhUT1hEVDVYLzBVYkFW?=
 =?utf-8?B?ZVg1SjY3bFpoNjVNM3A1emdDUjIya1ZHQzlLRUVLVjU1VmZQNkhxYTlBb3BU?=
 =?utf-8?B?a3dNaWFFa0Fxd0JDQWFMMStKLy9pVzhIdTBjTTUxbUtRUjlSUWVOT0lHRlFq?=
 =?utf-8?B?cmgyaSt6c05RelNieWZjemFmdEFaRW5RdTJkN0FHUDlONzY5YUZNQUxVQ3BH?=
 =?utf-8?B?b0dDMlJLUFZCOEFRUFZNMm1zTDlIODlWU3NuaEtwRGNHRi8yWHh4RXJ2cTVX?=
 =?utf-8?B?eTdxSEpIclJWaW92TlFjZzlhcTkwcHloa1BOMlNFaW9uMHhhN3lzanlWbEtB?=
 =?utf-8?Q?K1hqj6F+MexTEW14=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a9ff4d-6daa-48e5-649f-08df23a4a366
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:23:33.3929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FF4SZG80/NWJ4Hl1HYtxJtx8XjzHFmh2tUxZg8o9sW/IkmGTTt4XzEbgRmC/B+DizV5Sj4t5ritpZd70KOo5MQ==
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

The driver is part of DRM subsystem and is located in
drivers/gpu/drm/imx/dcif.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff3bfd42d3f3a..519a52e81e4af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20039,6 +20039,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
 F:	drivers/media/platform/nxp/imx-jpeg
 
+NXP i.MX 94 DCIF DRIVER
+M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
+L:	dri-devel@lists.freedesktop.org
+L:	imx@lists.linux.dev
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
+F:	drivers/gpu/drm/imx/dcif/
+
 NXP i.MX 95 CSI PIXEL FORMATTER V4L2 DRIVER
 M:	Guoniu Zhou <guoniu.zhou@nxp.com>
 L:	imx@lists.linux.dev

-- 
2.53.0
