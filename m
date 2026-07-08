Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BEBC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BFE910F2AA;
	Wed,  8 Jul 2026 20:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R6/+HHna";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 004F010F2AA
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 20:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+yOybQ0WFIXRc4+U69aucCl65vYJT8cB1xJPl6wROwoZC9d+zTU8MQDaB/CdyBtQ2Vvq7CuOiWvI5KQqfq60hkp0kWnhPLFpyg16JqTWeBlVCBPM4Zz4luun25s1Z2e/qVxfB7I9syw13PU9dek1Zy7JjKOYTl7dYf/XjPwo5uLixeVHNw77RpsO+XcNvo481sUd4m+4UfDGe34xdD1yhyNKgEOO1ORT6BhDCzfferLYEHKnop36uknKjcbXkSw36BJ4nCV6QLmb7odNo/l7S2p6VmrrYlfanfVIhzFtCQH1XDRO+01d1OL8NUpZEb4ZCOEBG6ovUbK2asgqLERng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4tehzPf7uu/ei0Ds6mLsD/PtUbJuEqJ+QFyCb16DaM=;
 b=KMqGUk9VO+E8z4DVbUnqYePlaKop5H8VY6fAYBhRb2UFhRv/rCCdn3gIDPll4vSxkiBOVVItTBBrmU9dUN8oF+fbFvZ6fzBx7rtlQfpqzuW0jv7xRNMSlToGM9irIXUZl/bnlQ0aDODEZ+plI8P5wj9yvu2EPlZ/NI/o2h+7ByNSBBavAzSg+mMX4KZk/A5H2f/RDzdXDdULmqNyaOdpNCeuJJCUVjGHHAauMaKzZG1v1hlfLxkbUZ5lRtKRMA4AIZiLZliQX+rPr3hUlK4wzTLOKNebOgyywX/yFPzV6/WErKrbfOoADdWrZ6Me0l96CbvPydo9jBajxAzKvQu9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4tehzPf7uu/ei0Ds6mLsD/PtUbJuEqJ+QFyCb16DaM=;
 b=R6/+HHnajrtSrnl1iW0uQPbBN+gWM4ijtN/bgWzE/YHQ9uIS5ReyN6XAZHvrmS71zzDzJh3HuhIPpuyG40sDcBFvXWepYrViOap24yAKmZ7lmh2GXQhmEqgj0bNB1Ey60VJsyS9GMjZT2fK8ZGegLuyzMKxXJ8exL7o+5IAt6L2TqlxXYVn9DcMRNNZxC3EmPfRKBnA8HYL0LwrjO47X6qXkdCePdmP/MV6auB/eTNVBngFqT0MTHc0yICka+/4I00lxpGKTFRPsmqg9DIFm/74L2DZ7c//CEGPmyqI5wFhjCdedfE7mQ/XVA9DpmD0Acb9caX89Tj85WtTpYje0Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB12605.eurprd04.prod.outlook.com (2603:10a6:150:36f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 20:29:37 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 20:29:37 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 16:29:05 -0400
Subject: [PATCH 4/4] ARM: dts: imx6ul-tx6ul: rename disp0 to display0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-arm_dts_ldb-v1-4-4f5579b85797@nxp.com>
References: <20260708-arm_dts_ldb-v1-0-4f5579b85797@nxp.com>
In-Reply-To: <20260708-arm_dts_ldb-v1-0-4f5579b85797@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783542553; l=859;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0hpK498VUO8dxtBKG2KA9GUlzyB29UEOvgq/J4+0ua0=;
 b=ICkHOXcpSpMqm83nW16OdFplOBKqA0sobJAjcqUVcYtejc/uBwrNFpV+WU42C+alElcjm0P4S
 IKOaeVn64OpA+Z3WcjX8s1XX2NfSKJA8cTXieI920Nc3BrHQ/Hta2iu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0180.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB12605:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ff8cf0-365a-4f47-c3e0-08dedd2fa126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|7416014|376014|1800799024|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tmkKpXCiNjpWhkTZ+VlGsFtJFRnkdTjvoueieHI4F71sQNqwCUrv+1dDdxXHuaPYUL03Ci2cCsjP1Zd72yfxMC1ekTFJItVK6CcKoismwyJx8hvXQEUPbaizRE5efOr7Qm3HnmOgcOKV2NAxPAsiVIi5I+3ul2dKPsHI92ydgzDb+qmdNrIcCMYAVQ/D1v+LeZl0mZ/r8PpDo4FJ3Es9C3QS5wOr8c+oabmBuTHl4QgrijYuKn3n4mwO2VGbt0xlQaDYp8Rvpzd7IEm+vFqWjPdv3XiaRBbrI5oFHd36TmtxHqcvrnDNAqulkJtJsd0X2PB8rCpNqLrXzcmTu0plPiszJ78oBkBjXX1GgDze1KzHEF0YHlVNDh9JEal5XFAC24x+7zshFsETge0k3BkaTWGBYz0TYXaYY8g9BLHDSYP8Q42VEa2hlMFqHl5JOAkpZut6RVEELG4OjnKSvR9li7HzCbdoJxOBGgHIUBczQur5FspMx98xTQfdGDZa4mjY8ZDH7Ej4XKp3PxOD5aqmI8rJQaLH7l/j8HTfyTCuH2YIL2vj6xhy/rN2++3xI/qauG0rYscAQHEzvoDB9olvt6KPlsWBv8yOL2QxBDr3z0ROyA59F5ykj3NcxA8viOM4RVIwQoBRBTk9GELGFsGKKCY7ynnFq07Eb/zcWJP9IJXEjYG1u3Jyxm7+f6Efs94mIsYcm7pZ4goYhZuJSnyxDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2x0UGFRNGR0VmFjNWlMRFNPZWxVOStxcDVpOVIzR0dKaVdGWVlVMXpRRFNM?=
 =?utf-8?B?YkcycHE5OEJNdk1FcmZaeUJTbmtEVG5SUzhMYWNsYkJ2ZUJXa0hqN2lGTVA5?=
 =?utf-8?B?ZTEzNEx0VFRxQzhmMVVhUnRsbFdEdkdzR0NtYktMQUx5N2NyUzlkY3hBc0pj?=
 =?utf-8?B?N0FYSG9NWDBabTdlLzZpem0wempNQy9KLzdhdXY0QUo0NnV1UUVzTlh4ZUJs?=
 =?utf-8?B?Yyt1TUdpMHJIcXEvSk4zVXVuK3BKaHBGRHNJK1NseUlUMkU3REN5c3dYYm5L?=
 =?utf-8?B?VXhmdzBIL05vK3M2WkNDRlFCZEtNR0NGSmJXTkNIWFpaUDNaKzBELzJXNDFp?=
 =?utf-8?B?V1F3VHJaMVBhWTdNaHcwdjR3RGIrZXVDM3ZRUEFkbmwzK1dOamp6WHo0em5H?=
 =?utf-8?B?MTBWNGNpdGlLRnV1akF0NHdUMW41cjA0Vm9lVGthWU1iSS9KeWlSZEN5UnVV?=
 =?utf-8?B?bmhMMzkyQ095eHhhaU1iT1Y2VkhhQjJIeUVnNWREM29sdHpYWVJzV1JRTURr?=
 =?utf-8?B?bS9wUEdqT3hNRUtTekJjNkhLQ0ZaZ1ArbHBEUkRoWlVaeW0vQjdrWlBOaDFH?=
 =?utf-8?B?VkMxZWdyZzFjUTVhNGtBdnRlT0lSWWFGYnlGZzhYZ0pXS2FyMDFZdzlhSmFD?=
 =?utf-8?B?VzN5VlFQZUo0RUdNdlBWUVIzVjBXMUdybm5iNGMxMDcrSXJzT2NLdGlWaXc0?=
 =?utf-8?B?WWxudWFOckM0SnY4TmtFbTY0eDVuc3VzdWcyQXY2UjdJc3B1bGx1U3pXRzlh?=
 =?utf-8?B?bytEK3djY1lBbkp1UUxnY3JiclBTemhwWWV3Q0ZGWEh4R0JiRDRWQ0h0bkt3?=
 =?utf-8?B?UXNNSTNEVGY0Y0xKSTBsTGxRaWRVOVR6UnZablRvbGQ0Y3V3ZDdXeStTSWdQ?=
 =?utf-8?B?Q2p2MllweW85Uyt6T3lSakxuVExML0pWMFpWR1E0czBrRkpRZklEVytmM3p2?=
 =?utf-8?B?TUNpcU9HYTJvOW9FY0I0QzZFYjQxT2NUMUZTejJCaGdlN0RIcXFJNDNqOTN4?=
 =?utf-8?B?ZzVrd0liLzBXdDRMKyt1MHlHeEEyK3REMkZmdFpqSXR2RnNKWDBLa1lEbVdy?=
 =?utf-8?B?MTZEOXBFSnM3ejVPUXYvaGFBQnZGMUpocE5ydkxJVFVqWHZaZ2NNdVA1YWlW?=
 =?utf-8?B?RHBDNHZZM2ZlbitJSS83N2ZTTlZqRTl4NE0yM3l1Y2V6MytzUHpLSWJwUHd6?=
 =?utf-8?B?dDVNK3RwZ0VlVGJHak55OTl5ankrckE5dDlzclgzYTVGRFpZVHYycWRvWjhM?=
 =?utf-8?B?ejN4S25nU2JZME9YaDdFWjlwWkdUbm94NjExTnZFa1VkMmVRSXBxYkQ2ZVdE?=
 =?utf-8?B?eXo0ckJ4Q0huOGpzUkhBRDFwaWtQSkJRdjVsY1VBTDNzSFlvZzdiSzdHOXZO?=
 =?utf-8?B?UHZwSURSMlpYRGZxa0IyeHZTZVhremhCMHFuSWV6UFBWWEt3cjNKTEFXR21p?=
 =?utf-8?B?Ylg2bTdPUlAzdVk1MXQ0NkJiMWpIbXB3akVNNzBDMHpzM0U4NWJRcmJ1RkhY?=
 =?utf-8?B?VFpjSHJiRnZtOTFqcUxZNFk2TURWSHM0U2tRVFBRV2hnZkRIVlFWMkhGeXpk?=
 =?utf-8?B?Y2gzWFZwM25rV3pZTmE1OHlRVVczc3YwOWMxRnRDS0VrUGw0VW5oSGFnb09B?=
 =?utf-8?B?Um8yZ1pTQVdVRG1RNFI1ZVB5NUZnYkZZcld1RWRubVN0aUxQclFHVUpXUHRB?=
 =?utf-8?B?dlJ3Z2lYd041OFNHaVhNU3F0MXQrWEw1S3dua0NUYW13amRTdjN4dENGdDM0?=
 =?utf-8?B?VWNjOU5EYU9aS08yWVhBeEtxUTZhVlphT255UUUzWWs2V1F2dVRJQ3ZtZEFK?=
 =?utf-8?B?SDBpQlVLRit5NTNBZjZyT3FiejA2dGZkZEZaMGpVbmNOd2YxOE9Kc3dLajRv?=
 =?utf-8?B?Y1lvbmprdkpyWnRJN0xsRUJ4dFBlb3BnR29NU0xob0FUanRVZnMzVERBVWJv?=
 =?utf-8?B?YkloYVVUbEpoWlhXV0hqME5ZamN6QngrTkFZWEMvT01Xc09Ka2pDWU1rR1Ji?=
 =?utf-8?B?cmFOWWlLK0I4YnQvVTJDK2JUSGFWQTc3YmxvOXNFNU5nUC8xRVlJQTRCMlJx?=
 =?utf-8?B?WkpqakRjdnZOclZDempjLy9iZGlCVmpBUEx5a25wbGgxZFVhYkpLMTFJdHh3?=
 =?utf-8?B?RVRMQmNTdTcycHpKZkt6aElzcnd6YTlhakQwVzVzVFBpcVRvZzhYMzRlVjgz?=
 =?utf-8?B?QjlMWjdtMmExc2w1TExCRUlYWER2Zlk4N3h4RHQrSm1YUUV0YjJxS0R2WHRt?=
 =?utf-8?B?eFlZWjY0emI1VFZINm5uM0tFWndSdmxib0pJNmFhWGd3TCs1QUFweERDRldU?=
 =?utf-8?B?KzV2RUowQXdQUzl4dmJUNUtEVS9aQS9meDZiaVhkSHlDTytPaTRFVURqS0Fa?=
 =?utf-8?Q?7YEdrBotHxsT02sLySw0scAhIcUrf1PsyFPli?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ff8cf0-365a-4f47-c3e0-08dedd2fa126
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 20:29:37.2010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yyk3XZKHosW9un1xMmbExTxJEVnz0QnSKdyviDw24wtWLZdgDiQJcGUmac5OzLMjxDyDHz9kwQdE7m7e9Q77Y7395CymRSa3ciKtk2mCD8JF9H7+2FXykRehpuFw3Hde
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12605
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

Change node name disp0 to display0 to match binding define.

Fix the following CHECK_DTBS warning:
  arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0010.dtb: lcdif@21c8000 (fsl,imx6ul-lcdif): 'disp0' does not match any of the regexes: '^pinctrl-[0-9]+$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
index 192c6a95ae589..2f6916c0359c5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
@@ -369,7 +369,7 @@ &lcdif {
 	display = <&display>;
 	status = "okay";
 
-	display: disp0 {
+	display: display0 {
 		bits-per-pixel = <32>;
 		bus-width = <24>;
 		status = "okay";

-- 
2.43.0

