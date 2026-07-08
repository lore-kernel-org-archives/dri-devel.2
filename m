Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7A0C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC1F10E179;
	Wed,  8 Jul 2026 20:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="p0j5nntp";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75BD710E179
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 20:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N22ERXe/rI0/5Xyu7rYJzzuUwmncQUxorBgACQCxMEP6uvP2yNCzIBH8GCW/i6O3PlLORznEAJExUBkhRyoVrnbq4Hg7ucHWdw358pkMURbB5wvN8hntahDe89qQ6gthmntTzDIcQscXaggk/SdITPkc8iX4DkAuLSbYm5MdGY8Q6l/1NdQvNI+MlUk6/9p1c/e/6ft0V6BaZGKw3lfOqgnfj6jyWVv/XSIVg24sH0QUwX80IjEXCO3yWB3qLZTgFe9YRpT3RNKVHvRiyu3B5+5SxGiMqrtkSBIq4+4LBFAMnLMZeihVa621xqE2+sZaug07X6HJ8dcCviwxdpI6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+WeaZmoFuMJ8he7+etfrUrzwuhx5kRyXrzD2z5datY=;
 b=aBFKwzNwGNJlMO6UY7cZFpdx278fprSvyiYvONW0oC+Sha78BwOm3o4jfNwKnPWMXqd2X7tcEJFRMHySX+3d1K9XSD+cLdRV2vJrIYSHQLZRx2YNChFE6xjH+FqkzI+G/fcNiTqwIbs0YtaeXS1UWJMUY1AbPr0lt6ePy+EcrtwuQhLl5tj3/2lfeHCQ3iYYRmXAwn1Kb2WjEywTyIexeVB7AIUmGI5+nnAiuvT2O70v2C2S8Kf30v4mEPkQ+Eya5rGSo93Oahiz1gRTP30SF3TYTcdvNQ6mjL48X3JZn9wRis6RsIuOSFuu+DOZTjAv4ZFdhwJUPaGZlyOw5DO8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+WeaZmoFuMJ8he7+etfrUrzwuhx5kRyXrzD2z5datY=;
 b=p0j5nntp9AO8MmfPdzPthKwZv0Am47gQ03El04v4jpszAEpuGHpPe9xU/PjBraH9FksWWbkHtUPBpfpNQt2eovk4OjkrZ08avg2Gso5vIS3Y0Ob6xLLLsAIOe2UhKVL8peXVyBtccN7LDyJrooFI6RV5FpOyneDFNhEr/EGNf/gmLzNjRvwBCHRSQ+1Rx9c2dRgR8x9HLlJF1raDR6FkLQvNHBqZbGElwynf5Htx9Lgc1lC5tENZnTwwaKP37qNTtfm7t2e/ETlT4iur7mweX2KUBqrB2DrqOeZtqc62keRIcHK0Y09oijwJz2EzGy4FtQ9agpqucMUaFYbS2R0MMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB12605.eurprd04.prod.outlook.com (2603:10a6:150:36f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 20:29:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 20:29:18 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH 0/4] ARM: dts: imx: fix ldb related CHECK_DTBS warnings
Date: Wed, 08 Jul 2026 16:29:01 -0400
Message-Id: <20260708-arm_dts_ldb-v1-0-4f5579b85797@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA2zTmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwML3cSi3PiUkuL4nJQkXcvkRJNkUxOLlJTUFCWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgBaUAxAbwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783542553; l=867;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gbcuq+yxl2Xu6IEXFnzySWS7P0wQi/Q7auzedB8+9sg=;
 b=Ssk3kozFCPLIIB6rsPxUNbHtmz88Qp/v6aOzzC9/uZ45y4uUWWlVKmcCvLJT3rs3gO+oeFuKq
 haGwbKC757hDQBnxpvPsUBnNNDIOPrrJCQuReCinOn1VqmVD4grJaGC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB12605:EE_
X-MS-Office365-Filtering-Correlation-Id: 8890f185-bf8b-4e6e-f940-08dedd2f963a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|7416014|376014|1800799024|921020|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: FUfDRULM+X94dkNyjDSocpHJjjVyoKsLt+3CH6SeoCMcJ7aPx8Q7XvyLz7Ycie7GwcMbP4FDbyfNBDcZBZcM8xfANHZJXkcIx6rkNvZ1jZj0z/ZDGBxbtXnIwYlqTFSz7I2ct8g15DZ6iPXHaj95dC0HlJGWT2Ti96dfUsSYw44ywwr17tdJ35bqtv9FOJqPn61Wt4PiPDlwwQc0Y/wl9eP3I+D6J1z7BtowwH5IqYUBxE24SE4vLXL3taJWC4X5qfkh7ENj5rVoLFaqkTBX85KhACWzeZ14cgImTPkDpAl1NCZnGWjXShjXjw3ZMmve6TLSVevzeuGD+L+Dkg/PwYtlN9y4b7h+7KnRMcqV1XBqKzTWcXChBQDL7E66z42mSspkTVnh29rXXRhxDnfOS7C+r2VrKEe08LESOqb4u+JtnzZYSppQS7q7ZDaB9vfX06K0W7lQxD0WpbI9vfdc3+NL0+OmpO6OFSF4hxHOeffIkS31u72s+jD59Xp+7EWlVgeOgt6KpgALeYpXqENcw+HrWYsStCmzWkbyWj53IQRbvKxkx5MefAf1HYsUqFXCyY9c3U/vA7YmowrFT3n11p1eRrwhJYlg3AwtN99sRFNoSKb4lhDuF84ZYtHHRnDlFSmHkL0rXUxzMXXaAE3xZkFmGWiW4fzQs5Y4hzc+yFYzSA6o99UFsozDnnFSKqDGHDOBoCh2zXvreS2S778RRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(376014)(1800799024)(921020)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RC9vMkZrVDdvT2lyK0dXTTJUdXVBZE5sdUZobEdyNU9XeDc4VEdyN3VLVTlk?=
 =?utf-8?B?dm9ZMzZrQnhPN3pjczl6d3ZXSnVUeHU0WHNRL3ZXRlNyUFhteG1lM0EwdWRv?=
 =?utf-8?B?Z1JxdWpvRHpLQjZIcHdoK3NkbGs3elN3MVlDMWhvbHp0K0lYS09XU2o0MmdW?=
 =?utf-8?B?QnVUWjE4ZVlPQWcveDBjYkJOdWs0V2hNQ2h4blRiV0xUMG1iWkdXWjZlWVZF?=
 =?utf-8?B?TFBOZzIvdEdDYmw1S3ZTTE41ODlUOTZtaGVLM3RmNDVFSkcxL3FneUlxV0cw?=
 =?utf-8?B?MVpRSUQvY0MyNGtyRnRRYlJvNVh1aG5LNGlRb21ONFVJSnRmcFFSbyt3YW05?=
 =?utf-8?B?bVY3WkVmNkE3UGw1azVyR3BHdWl5bkhoamNyYzVSZ3d2bW9qMVpxZjRDZmdj?=
 =?utf-8?B?ZVlyTkpnRnpiL2Exa0FWQ0V1c0lEZDE4bGRxZ09JVm5WK3p4anJWeFVJTkVF?=
 =?utf-8?B?bFFjUCtqY0QxckNSTkQ5T1FlOThFY0J4aUNaMS9jZ3g0WE5obksyRDZMdTk1?=
 =?utf-8?B?V05qdE5JcTJlNUFHem1oenFXWjZiMXZYSlI1d1R4UWozUkFHOXRjaVlEZDB1?=
 =?utf-8?B?WVdsdXNHTlpNdnlDN215OEF3eVJZUGlWU1VYYXFXVlRXT1poa1UxT0VYL0hl?=
 =?utf-8?B?NWJ5Y1lrb1EzVTQxQ21SNVh0Ujk4WU1uTDFHRnBGUGtNUlBvVEZlME5oWFcz?=
 =?utf-8?B?azVmbGs5QkpGZFJIRGlFaTNOeXdFUHVmWHp4dmJEaEt6aDU0cFpBVlZxMWF5?=
 =?utf-8?B?b3NmRndRcUNCL1V1SzdkTHNkcm5NZDlxRzFVSGsvMm1JNnR0dVUvenpoUGs0?=
 =?utf-8?B?dklwa3Q5SWpmN1JTNVVGb1FnaU1Ba2xLdHlid3FtM2JoaFRzbm9XczN2MjFE?=
 =?utf-8?B?dlhwSVZBVUpuT2J0NXBZSEtOaVNvZ21DSEkvQmgyejBIVjRBWlFMVk0rZ1RR?=
 =?utf-8?B?TitMcmxnaE5LUTFVemUwOXpWdi9MN0VHVUFuVmJDTkJIS0xGUmxCbFpXSUJh?=
 =?utf-8?B?Vi8wRHBPdUhoYnMvNVkvdTVWbFhJQ1g0TlNKaG9KQXdIU1JIb1BXVCtBV29v?=
 =?utf-8?B?aG5mWEhYYlpoSUMrOFY3VjZac2lYR1BmV2h3TFF4MFAxTzYvT2JYdCttMHJt?=
 =?utf-8?B?V0dYWnZFMzJkUzJxaFozb1Z4RG00bklWZjgwNnJrUy9wYlYvbENsUzJnWXRm?=
 =?utf-8?B?amU4dmFseWRLSUFIa0N2dkhFRGhPOW9aOEd2dWkrdStEd1JYZGtrblFQbVBO?=
 =?utf-8?B?S2JFUkk3RGRVb2o3dFZtZjc1MlVwbm4xUmJDcUREa3FSVVpOdWd5SWNtRk9L?=
 =?utf-8?B?eS9KSUF3RTlYS3lQRWx4TGtTcW1BYUoxQ0tsWHJNczdKdVVNcno0MUxXK0hX?=
 =?utf-8?B?Q28zSGljZGU2TnM3TUZDbFlSdmdyU2Fpcit5ZVlWNFZwNDVFMHNmd1pJL1ZR?=
 =?utf-8?B?TWRrNDg3ckJsT0d3WktEZlpkQjl0S3h6NGZWdmg0Z0NUcklHS1BuYyt4N3VO?=
 =?utf-8?B?aFg1MjdGVS9yMTU4bzBzb2taUG9sZmFpMmZtR3lIMlBWU0NUQ1NBZFRlNlFX?=
 =?utf-8?B?UWljNFNUYkZTQkNSN1pNYVl5VWFZM2VJZ2ZvREk5eEw3dGJIdlJmbURqc3Fr?=
 =?utf-8?B?UUozWmVpTWlreHVBWTVPMUtBQWRuUGkrUWwxZmUrYzdmZHpocGZpZlpmVGNk?=
 =?utf-8?B?Q2lncmlaSWRWaDdzeWk3U3QrQTg0b0h2WUFZZTlybDd3aFUzRGRBUC9EbTNs?=
 =?utf-8?B?TlBmWFJUdnZQTEFueTByTVlranR6bjl1TWttUnNYR2RsNm5KVlk1RmEvb1hV?=
 =?utf-8?B?NnpSK3hXV2o1NmV6K0RmcmtaVGpWdUcraUhsckREaXEyaFBFdmc3dys3RlhC?=
 =?utf-8?B?WCtKblpieDJFT2ZONUxBYTdmRG9ZM3I4Szg2aGNjeTE5NGp1RUlBN25HR0xu?=
 =?utf-8?B?YTF2L1BxZG5ZMmx5TllLMHVjVlY2Y2cxNkw2N0xUYXBqMjdxYTBlUWdmV0xQ?=
 =?utf-8?B?aVA3c0VFYmVDSCt4TzRNUWd4Mlk0M05OcWtUVEN2MkloVXRVa045QjlpaG9q?=
 =?utf-8?B?Q2JVM3N0eEVJc3RuankzaERyN0lTeG52cUN4bFByUUZtMUdiR2VlSUFldko5?=
 =?utf-8?B?blhGZnZsaVgwUWVNTFRiOXZsNUR2UDYxeVNSUEVaVmVwU05pNHJWSTdFTTlC?=
 =?utf-8?B?OHFWNjViVG9WUnBmV1MxWUFPbFpUTDBjSWdVdWg0aWY2SU5tOGpCRFZTQ0tY?=
 =?utf-8?B?VFZWVms5R3ZhMXdXSDVwWGtPRXROWU5CaXNtTDM5R05oV1BheTVPMlJDYnYy?=
 =?utf-8?B?bWdSdktvNjBDbHdsRmxZTzBqeWxacm5XTHVsQXZGNmJ0RHoxZlNsMS9xcm5l?=
 =?utf-8?Q?MirFPKPi711wBN6UnleAxXq7ajW8J064R5BAW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8890f185-bf8b-4e6e-f940-08dedd2f963a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 20:29:18.9176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vVJJ2bEEgV2u8JcYaGHk3ZRq/B1nQgcDZnHQSZqWSWyEJwlAHqla26LalcqEluabvThk1SdaZyQ7J7zlXSwulGcg6k9eKnPhDvi/HWA0byiHbrK1eo5DYhQbH8Coy2o
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

Fix ldb related CHECK_DTBS warnings

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (4):
      dt-bindings: display: bridge: ldb: allow a single reg for fsl,imx6sx-ldb
      dt-bindings: soc: imx-iomuxc-gpr: allow bridge@18 as child node
      dt-bindings: display: lcdif: Allow display0 child node for i.MX6UL
      ARM: dts: imx6ul-tx6ul: rename disp0 to display0

 .../bindings/display/bridge/fsl,ldb.yaml           | 23 +++++----
 .../devicetree/bindings/display/fsl,lcdif.yaml     |  1 +
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml       | 59 ++++++++++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi        |  2 +-
 4 files changed, 75 insertions(+), 10 deletions(-)
---
base-commit: 6c94b38b83a04c43ea49004275f0391404051093
change-id: 20260708-arm_dts_ldb-9ca4c548dded

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

