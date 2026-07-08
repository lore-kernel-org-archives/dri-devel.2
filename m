Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EF8C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E2210F257;
	Wed,  8 Jul 2026 19:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="afMhst9R";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04CF010F257
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 19:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUD3GWvB7YTCZKq0uBshT9fYYh/5+Hx4qrXuRVgmb0czdNAFXQPKhPOScssxngrcVjRif2ZIfD0uFcrdEyq+F5725A3F2l9P8CcGejcfCLFufX4FTCVLUbDNGsnCCRDKIXGswtTJ23XfFTYtTlaa4Uy/jRVX1e5Dsa0KRNB/B7U9fxPmSfDWpc2c9dSX+7SHMwOAKLwDQT61/DveLEgWutsbAzuHfJoNX0B/YY1PM3wLmCWW//m95HcHdbTFhtC2GkJ98U2kdDsNsaLqzutPFqJcwzzNkkBJTqS2dFGodPtumAnx/J8gsHuuYIodr1E00Ijva9xf0273SnqU/EKmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b9WfmhokkM2Ox6I+BLF+kHKEb+Mw0dUlnPTgkMPa4Y=;
 b=fb17lC2X8XfJMiKI4B8MWU8sLMJWAvonac+8ewmQXdHvjVBK8zW4epGgaSUb4sN4fRIR7Tod9TaoyJWy91I/RpOXNLb4K42hcGehnCzBafDBjx5W3p5XEx1ZRQB8ZFLMkNBIjFvMnBb01Ui4Jj1Df54H7c3FJfxCHfKwL+mMcKr07VVYLOuD6+aYl5TS5O81xcgAV166KTZX+RD+U0iY6q4QJ7Y8SnSsQwpG1jPZofAATPAY+N0zD1nXa33bT7cM0I7dPUmAY20aDkrMj3wjkala1KLPze8VLL3cooSP2ebssSazLT95OOlCVEYt4IRGpFSIZgqR78WSYEM4v8vBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b9WfmhokkM2Ox6I+BLF+kHKEb+Mw0dUlnPTgkMPa4Y=;
 b=afMhst9RLzgZJcb1xfQmlBWLMu5soiS4jAYjWQZd0DvzUKW+MTT5BMSozc1dhcX8hjRJTmtJ2RyhASiYvnHPRrixbd9W1cCDvzMePb3tAdhVrc4Z7EAqav4MOtD7lUKe1RHORzY0tH3kQ+8zdyFhQD4BfxAhqYUPReEGSaMHM+KEk3bTE7VinewdzdhG5nm8OBZgmtbACJ6K/0NniBBbJ9baTet56xNAfJpGLyTtjj9rsnGE39JIjT3FIdgT3WNVUhEEs5p4+nq1qu2KWXQfy/wEDgPpdFB4t9OOf/w7+SoKiP6tbkUKltr072TP5UIBHC4YOMC0/TFr0XuxjJC4Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS5PR04MB11465.eurprd04.prod.outlook.com (2603:10a6:20b:6c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 19:40:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 19:40:08 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 15:39:52 -0400
Subject: [PATCH 2/2] ARM: dts: ls1021a-iot: rename display@0 to display0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ls-dts-display-v1-2-1986b2611895@nxp.com>
References: <20260708-ls-dts-display-v1-0-1986b2611895@nxp.com>
In-Reply-To: <20260708-ls-dts-display-v1-0-1986b2611895@nxp.com>
To: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, vladimir.oltean@nxp.com, ioana.ciornei@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783539593; l=1327;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=j/dMvugCgLP24DzGvgUdGJE3YrQeulJ0DqsTIpeKndo=;
 b=3scRRSWD6oJZYdT47u22So9JvkJUR7CNmfJUkx0asIczV5RcJ/8WtFgsMKR/GCVE57H+ulvMo
 qUjhn8jHCcuB1gRuy/O7jJUQ/MEMVeTNRFLPxj+RdOuf8QuxscSlQiW
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0185.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS5PR04MB11465:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d6e21a-2a22-4f22-5966-08dedd28b74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|19092799006|23010399003|1800799024|366016|921020|18002099003|22082099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 9yZcDNb7g720zu6EAPVgGOHalJKhF5Slu8GqoAn3o8Ecvq5pijGsMohQ8YKr/emdEEaKe+zoqb0Lx/S+rrZ7ET4vZ3tmIDGEUlCcuVhWjPlea94l0V3RezEcj5bWLGOVXIn31a3SgEi7RliuGNOB/+na76vnqjJ/7XUDY84D7YJ+ZzZYfFsbWFz5kcUrXTUCxPkv70hwurxi1oAx8OhS9jjH7FSTm4pobFZyYOHRIIlt9+1RyN8ujpP2QUgf4rZGMmfLp0QrN/EPNjBGDBDXH2OVy8Rp0/14YZl+DJVD86g27gW35pQaxv5fQM67aSPPVT4tDe2yWWL6SGeRM++0yGEyk5RtoBGVCkplRveeaoEoXIbY0PqEiats9m7V+C6VR4c9rQQsdgOi7QMnrtptPeMN2p9TRq2DTBPXt0NyC3N2LusZqJp5ahwB6UMzskac+lAUnOI4JxGX8LGJ+htNHKdcf7XExX2RL7HQmDiH/5VoS+0CN/0/TdAwSF6xjCmUw3mlyNFceLxkjAnJgRXyM4rF4qaUxizvTWi+eQkwONoj1F6BCZnOvPP2TTuGNKx6BwMP48f1f5uwuDcLUR1kkWKC9W2RSUMzNIjuUkqepLl1NfKhvy5l97TPPKGAsrCu7mhyoBsnZLSEaHZFbGIx/iT1t9IE2cUsPJ+knrutCvwknMGYfffX7VLZwiPNoxrzN0PzrJsQfWZ+Fr5Jd2fVpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(19092799006)(23010399003)(1800799024)(366016)(921020)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEhrVmZONUJLTlBFdmh4NnQ3VVd4cFg4M1JWUFJNM3FVMGVQMGZyWjlra3ZC?=
 =?utf-8?B?dDE2eDRJV3NNYXpJZ1hxQ3k2Rm9wSUFFeVNHNlUwcWpZRVk2NjdzOGN4VG12?=
 =?utf-8?B?c1dvbXd6Mm9pdmVqTkZXZXVJODJKK3F3aFVQTFNuUmZRZ2NyaWNDUFRIWXN5?=
 =?utf-8?B?aWtUOVVrQUNzSGU3dHp4dFhpZEZUa2pOQUVJSHliSWRoSG5HL2hsYkFZMkQr?=
 =?utf-8?B?MERmWWJmZ0c0em00bE9YSk5uQ3J4aFdSQ20rOGtCbGNtZG9IZTkwWHJjQVhJ?=
 =?utf-8?B?ekdjWWVZeWFoQ3E0TGtyUlhOLzBxMDNrenJqZnU1eGFyYUZ0ZEdYME8yUDRw?=
 =?utf-8?B?YTFEc3I1Vno4NmhNcEYwaHR5MTdkR2VMelBQd2FSSlBSMDZWTWZvcjU2N3hO?=
 =?utf-8?B?NHFWK3JacjZTczR0WVpRSitLMW1wbkhtUXZLaDJEWGhoTkRsb1BPL2VmR3RM?=
 =?utf-8?B?emtKWm5WbWFjaHFOYzZQVWF2bHVMemZtU1NLOS9mTlJuM2VMc2wwQ3NWenJo?=
 =?utf-8?B?cVQ2VndZQnpBcmQxZGE1dVRUamcyY0JMbEVlVVRaTnYrQzEvZjZyMzJnWXN4?=
 =?utf-8?B?a01FRXpSdGt2OFJSWjR3ejZ4cUdxUzFVTkNObi9KR0tQOWxSV0lDL2h5SDNR?=
 =?utf-8?B?UjROVXoxYVQ4Qk5uOFREVTlhRHR2c1JuNzlleGtNNEw4V200dytKQ3lzUE1Q?=
 =?utf-8?B?cGFGUnh1V1lDTlJUNkhYVGRvZXdOZzNjbURtVVdweFp0bGE1VlZ5bVczM043?=
 =?utf-8?B?bWR6OHdvMk4zbmRURWdPbWtRTWRKUHZROG9ZZXFjQitRdk1PekNMbThTTzY3?=
 =?utf-8?B?dW5RTnhhSDkxR2IzM0xUZGlhVGNGRUhDTk9rTjFzMW04bVlyRE1IV3RzZWd0?=
 =?utf-8?B?MXlUM3lVOTd4bGUwdy9IUnNYRUUrMmI3UmF5cytZd3lFTStQRUdqeFEyQnZR?=
 =?utf-8?B?TDdGcldpUHhQY29qRmxjbE1XcmpXb2tRQ2hpTWxWeGNONC9kU3Z6bFBMTk0r?=
 =?utf-8?B?cHRtZUxQTlZkUUFabk4rN0IwOXJvakFTeG8wN3p4K2ZISmZDVzdWcFhoMFY5?=
 =?utf-8?B?WWRlWUFzMGtwYzFJUWFWcG5TR3ErMmhJWmgwZml1L210Tm5BVm9wVjFTWm04?=
 =?utf-8?B?UHBFaXgxcHgyT3J6akI1ekJRTXZra0NLeXR5dXMxRi8xVWVLMXBvUk5uMnY2?=
 =?utf-8?B?Zko3YTZKOWlVMkd4VjFIbWJ1a2c4MTdzY0NpVkVqUmFGQlk4OUFxek16ekhI?=
 =?utf-8?B?Wm1xbHpRMTMrVCttb0ticld5ajJPQVJZZzdSNnpLVGxFem9aMXllWnZBbjhh?=
 =?utf-8?B?R3E2Ry82SklzWHpqbVo4Mld3NzQ3NjZxVUl4ZHZZTjhhcXpOK2JNbzJRVEYw?=
 =?utf-8?B?QWRkVFZxYTQ0T1dlaVFuTWZ4TDJuZHNmWG1TRGZySzhCQkRHclo0akF0UHRZ?=
 =?utf-8?B?NTZBMXpEdVA2NW8zdnBxaFIxUzVqRjI0cXRMNDB1WDNYaTQ2bTdnTnlMcHlr?=
 =?utf-8?B?aTBLQkJIMHFoUXA3ellIN0t5cU9VTWFWR1pncFF0U1o4dUxzZDZ6MlluTVhX?=
 =?utf-8?B?VTNMVUk1UlpEdUt3M3Y4YkdtMmNTYUdSejRPVmYwQ0g4bC9ZbFRQdllQNENs?=
 =?utf-8?B?cTNkU3NCNWxKZDNVaHYwRTRBRkxjQVhHODVYUjRURkFvVDlSZ05mQ20rU3Jj?=
 =?utf-8?B?cEZaZzROcE9RODhobDBaMnVzYS9FOVdKVWx4ODBGcmlHSFRUOFJzK0I5Y3Ey?=
 =?utf-8?B?Q2JyTld0azMwM1orcXVFelEvVWlJT2wrSzdJRm5Xb0cvcGlLT2ZGRm94WDIw?=
 =?utf-8?B?TUQrWHp6d08rS0RrUGxNWVI3emRuMDJSS0RzLzV1ZngzUU9GZkZhUUhFbzdU?=
 =?utf-8?B?ZnV0QXY2RnNyQ3VPTGJ1cGJDaEFiNnAvckltTGgzd0JiVitJVE9sOGg5RHI2?=
 =?utf-8?B?S0h0U3dvcmxoRzc4TVlpUUt1VTFGMXVpL3pYWGJFN1pmaFZKanZIblpKanBH?=
 =?utf-8?B?cWszd0tadlRQT3pISkwza2VsMnp0eVc3MmpjeWlYajNnaktST3g5cUNhNUhF?=
 =?utf-8?B?bHRmQjhEVEZocjdISU1JL25FdktQQ1psQlpHR2lwNWhocHFKaHd0OGt4VzhE?=
 =?utf-8?B?NTJ6a2Q5N0JDVFM4NWl2bVFYRXFUbWxuQlBxdk1UdkR4NGo0WGtKOGxJQVFW?=
 =?utf-8?B?WHU0Sm1hMGJBTUpMVThKVlNHQkx5Y29SZlpWY2NIbXhIOFdNV1hqQTYzWVF3?=
 =?utf-8?B?RGMwRG1YR28zaXBBYUM4Z001dWpaU00zTEJnZWhoVkVGelhpMVdJN0IyRXJt?=
 =?utf-8?B?QllYbVZwQ3ByTHd4aDZuM2dqOTBDS2tzZWZ6UVdTejBwSCtHTFUzVGczY2xP?=
 =?utf-8?Q?RITJpZSlLCgGcST18tZPW1Lt6BLHyu1x9DtaU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d6e21a-2a22-4f22-5966-08dedd28b74b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:40:07.9838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvGqfSAjha6P33VeAWv82NtPOLyIwB7VyxTHI8KDWxqo9N0RIsqJwLuLo+CU+RMHFAkntltkqXaeM5kTQd4++4rzoWlR92/MZMH6RyXCa6fZTFaqRfnM9i9XKBDM8BZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11465
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

Rename node name display@0 to display0 since no reg under it. Rename mode0
to timing0.

Fix below CHECK_DTBS warnings:

arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: dcu@2ce0000 (fsl,ls1021a-dcu): 'display', 'display@0' do not match any of the regexes: '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/display/fsl,ls1021a-dcu.yaml
arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: display-timings: 'mode0' does not match any of the regexes: '^pinctrl-[0-9]+$', '^timing'
        from schema $id: http://devicetree.org/schemas/display/panel/display-timings.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
index e13ccae629a71..07b01434fc047 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
@@ -82,13 +82,13 @@ &dcu {
 	display = <&display>;
 	status = "okay";
 
-	display: display@0 {
+	display: display0 {
 		bits-per-pixel = <24>;
 
 		display-timings {
 			native-mode = <&timing0>;
 
-			timing0: mode0 {
+			timing0: timing0 {
 				clock-frequency = <25000000>;
 				hactive = <640>;
 				vactive = <480>;

-- 
2.43.0

