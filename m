Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC32E7E345
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33A2B10F416;
	Fri,  3 Apr 2026 08:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Ljqz2umr";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D4510ECE3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 10:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMpBshTvMLMltCU+6Qvb+2hrXE9rXiXbhvlzehIWUYm/kX9PGvtahe3ZABDZwDApv+nW3r85yCeO5PeRiM5XZbNk8O0Sv9i8CiKJbZjYU/eRfTwDgYkIEV5dEMJ/iMzHHm4Y1wrHmbep10vKKoQBRv3dIbilhtkAq+E3vhWV5ajIm7gGNd4UkIasV3ZpHV9/1cY1DVQ52Aka7gj/7IdN0yYYsZ9YK/eRVhKJwUvwyG2JzPRZlQcV9kui3oJrsEquWMS14+suorhycxuzw8cGqyHYrTNI0D0tjW0q7uLwdMhLOCd772EDNTxzDmWwJztL45OjBLRaVeFagtgYQadSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CZTPOsuHsNV/MIJ53ilZx4Acs2Gx2bXgjhbH+GOyG8=;
 b=o+tyj0mTFxDjzoEX5Ddq0h4Eezu29kPrMMbXMzUBKFRuyeUl433+VKL/OUMuxK6pEe9hMAgLrPVCLL65KhhvZRszVZdkinxAgPI3jM/ReuJl1kZ2b1aHgYCZ5LBUBZP8en1jFmA6oFfZd86VWFw3WGLNU5gUNwO7SxakNdJnfWlkxNF/EdO5X41YLTSlKafZAdcZU1csDF4PGPWhnmLGEME/PclBrH86jvheyS0DOkan6Hip4s9xRU+29ONiszdNPc2z4HyQ2SCzc2F9CiikphSMN58MQxYNJ2SGtwpWXNFmIF+1KxDKVYSQM7bqAqNuTZQLPgA7th+ASOdfx/uW8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CZTPOsuHsNV/MIJ53ilZx4Acs2Gx2bXgjhbH+GOyG8=;
 b=Ljqz2umrAg+Lalhq+iy3oUExKKsow8zxZjBICmxA/vUX/dfOxo2TkeK6Lj32pVy9Vw21Lr9IvmkRV8YXLEPywNQabS8l7G8+d1zpyUwna0YgupPnHsUvHgAVPafLC6QUy44cCioXA+Z1b6d5sRgkbVWEvUT2jamUurad5DEzy83RjBMLGcU07TtELB6/o1OjhZoPKWCr5nZ8vDBgPih5eCSBu6erA7x8U1uk69rEu21RU4abRxNMpScLXuZpAnNt0RkOFii/ZjfoeXu0SrkhjS1T8iDMLkZkyFyYhekJtGKXESc9bJxJIb1bmRywAyRUdSEbIYv0awODHoO7Y4KRUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by VI2PR04MB10667.eurprd04.prod.outlook.com (2603:10a6:800:278::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 10:10:41 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Wed, 1 Apr 2026
 10:10:41 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
Date: Wed, 01 Apr 2026 18:19:12 +0800
Subject: [PATCH v2 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-master-v2-1-20d3fbcd19d6@nxp.com>
References: <20260401-master-v2-0-20d3fbcd19d6@nxp.com>
In-Reply-To: <20260401-master-v2-0-20d3fbcd19d6@nxp.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Guangliu Ding <guangliu.ding@nxp.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775038767; l=1101;
 i=guangliu.ding@nxp.com; s=20260331; h=from:subject:message-id;
 bh=hUY9kgrBQ/WegpJ86SdI9Bctdf1An2jG47pTqJ7IKQw=;
 b=V5wM7ZO5pbnEEc+1rmTD9uW7ndhp2XAAq5OpSfwnbJVRvT/KFRToqDNNnkBQpalZ6li6PcqK3
 8W2SpBuBGIvAP9eTirswv8wX9thzHd62S5x9UAJjiJ5W0IJWvjf2Z2I
X-Developer-Key: i=guangliu.ding@nxp.com; a=ed25519;
 pk=Ozo8o/sk09NyO6URvn0eD0v0uVHduT/yJzVGTAJ9gxw=
X-ClientProxiedBy: MA5PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::16) To AM0PR04MB4707.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4707:EE_|VI2PR04MB10667:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de2e7ec-1ab8-4492-07b8-08de8fd6ed49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|7416014|366016|56012099003|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 7VMYu8TyZC1PlkywpDwRPp+VSsjkxoWdgPbQyQINCGCMze8KRdZTBsFDBkwSQwUYBd43VImlQJCyZxgNJb0Wkjjw8Yj62hMTrrjPMgjavWV/XZNoLGpM7h1QnNd3KQ2vByNVPGdtlC/kqvm9YDyEg2liA7llLAE6giKd0HnOPJABShoh5wDie2HwyjTrw2OI3PoWQZ1g+YGGe+CyGoy0ssCPiHdLoCfr+QkckAdV8E5rkgIYt7A7QnClWnBuEtXUFakr4tz7miO9hGf80p2504fadeov4mzmtDz4j3iB+99zEhPerm6fk6dN9sqPk54VpHx4jfDbPK1OKWOPm82wlGBN3ce8OJhBB2LnLjd7Z7bq7r6Ri+K3ZHq7huRmXMuofYa2qSuOBgwE2BKtjQc0TS7EIV86ri0mBSX7uZMdicjhnqV2XFHt2whXd9muApdyzXpNG9D+VfVx5CbNhwLeP480Y56vwyU5PjByDiNDoB67vJHrkG7JqwWd6RAI5jfwxXTH1TF8h+kamwvtOvZUj3gDn402cKeZot0klZ9uZP34T1xAhGUZHcJ0Oinp8WxpHDrV+rtPibVOX1PI59tM1UUMyVzmgBBGzSdcREEB0DeGJ0M0KuEiw7WygpJQ47hO7ZhoLSX/Il+isZQe/YcDyVNkZaaBCBXmiDLpq4iqMjpEn7+/zWFr/RU82zQGVnSKgdt40Gp79upfE1TYULuzfhvRDkoTCdGoM+qb2zORW+u+wHtHl0bzwmZqqfe5B+YQpqZe5d06LXdrG1Z0MMI/NbBQFZ4p/XrnIYZLliNoIgmZ/vmIrsYepKRkWAGuJpqk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnU3TXJETGkvSzVoYUhIMHMwajhGcHBiQ3h2K1VyQUdnUWZLWTdZM21sZGpz?=
 =?utf-8?B?b0xIeWJQclhxTnJiSS9PUVlpYjdsaERrYXpNTEMraTQ1RmdxMlQ5cmgwcURM?=
 =?utf-8?B?NHFSVEs4c00zUzhQbWI5ZXF3KzMvWmZieUtGa3MvcGpYM2hWTVpoekhRZlBF?=
 =?utf-8?B?ZnJ3Y3Uyb2NnaUJFeWxxS1hxVjh0Z1lGdVd1bitXN05adStlWVhhRWU5cFB4?=
 =?utf-8?B?Y3p3TlRoMVlFQ1YvbkU4MGh1MXd4eUY1M2VucnBFempJclRrMlFLeGt1dDVR?=
 =?utf-8?B?ZWZSYXdFRUFJMXArckIvU1loK1ltN08rU2R5Q3J1MGpFcjBvSVNOemgxMEI3?=
 =?utf-8?B?cUFvMmR4akltQmkxeUUyM0VTVjB5bEE4MFk2V2V5WDM3bDlkK3lmTWxGMXN0?=
 =?utf-8?B?VnIxWG5iQU5EVmtuKzNtY0NpUEU1Q3NXY2U4MnlxUG9Ec2RqcmR6enB0MGpM?=
 =?utf-8?B?aGQ1RzVVSnBQWWRQWmZFbmk5VTgxM1dVa0xFbnVJTnJMdHhWamtUNjhxYVR0?=
 =?utf-8?B?ZkJsc2JNV21ZS2wvWGc2U3ZKZjBLTTRHWFZWUmtLMVFLdnNuTS9UZzV4QXZl?=
 =?utf-8?B?OHFXellYZXZoeVlvR1NvVDBhYnA2N2FXOGM1ZEdQMEQxT3YxZ3BzSEJzamN5?=
 =?utf-8?B?QUlwME9RWmY1OXNjZ0NDWUwyYjQ0R083RFlKdU95aGhycTRaVkI5Y0oyYTR2?=
 =?utf-8?B?NVVzOHQzOE16NFExNm5aUFkzZ3NvUlZNYy9KSzlUU01GRUswb0xrUzY4a1FO?=
 =?utf-8?B?eUdic000bVZZd2Fqbjc3WkV6bGZ1c3pJbzFxbzVXbmRBNmdEZldHN1d6dlc4?=
 =?utf-8?B?dmt3THJQeDZySCtFQWFsK2dpdHRLRElqS3pScUFmMjlKZHNSMDNib1d1d2Mz?=
 =?utf-8?B?aXBhQ1Vud3E3TEt2N1lPTjVFRmhsVFRpL1haL2Z0UjRNaUVRbm5YU2kxakto?=
 =?utf-8?B?aXBTa0twd2RQaitaK0g3dTlYaVVveGRUVkg3eHZ0M0YvL3Y5V1BwTkNxeWdo?=
 =?utf-8?B?d2RrMGU5enlaZHU5WmlmTkhFWUVVMnQ5c1VscXhZMytnVlpLMDZ5MG9rMWM4?=
 =?utf-8?B?eXBCS2cvK00vRFZVd0hrckxXbk9CbXV2Ym1RZlpldE5veFdvOFJycjBLYlhr?=
 =?utf-8?B?SFRJcjFMQVFTTXBtemZEa1g0NTJwTStGamNFTmRobmw1Ym96eUloVmMxL2I4?=
 =?utf-8?B?dGl1STMzTVEwV2pYaFhyZFAvUGpsOEtwUHVrbnNMMURQQlJiM2xDaGJnMWVF?=
 =?utf-8?B?SkltSkVBTHJpZ3JpaVZrb1NIaHVZOXErMlc3a1pHODFRQ24wdExmS1grMlgx?=
 =?utf-8?B?Y1FUYjVlR2hiZStRbzZ3TlBVYXJ0amJERHAvVmF2OVdVaFVYUUlqb3RSejJS?=
 =?utf-8?B?TTFUc2Z1NEkyZTFWNGNISW1xUEdVRUxNMVBRQzRzbnQrZldyV05abUZVZUJD?=
 =?utf-8?B?WHpZamhNNS9HNlBtL1ZGOUxiZlQzYWdGcWIva1BkcVZwc2dGVDRFbk1DQnZr?=
 =?utf-8?B?K3pTeXhyMzBBNmowU296SCtsOHhySGVtN3FaNjB0b05TVzd1M2VmZitVK2JU?=
 =?utf-8?B?Q3gvSThOdURwTTh5UGZlV1V5U3Z2WFNac3liT2Yyc3JjbVN0VGFORjl1bGxL?=
 =?utf-8?B?WnEya0JDMXF1Ly9XN24zQXY0a21GRkZ4YzN4ZmhFZFFpWE02emRlSUM1MVFW?=
 =?utf-8?B?S0p0bXQvdTZid0c1d1Z0QmVsQmZiTExsN0RubmhqSXRyRGNMTTBnWlVnR0Nu?=
 =?utf-8?B?bHJGMjFCN0xlYVE5cnNzOFduM0lzSmF2b0lvYnNiajM4R1RkZnJzZzdwUU5y?=
 =?utf-8?B?TVBpRjF3WDNXUCtnU2pDL2hQeldPaUZ5MHhvZEF6UmRhUklNOGVhZXAyQk9B?=
 =?utf-8?B?OFhQTGkxbDE3OE52VXpyMkFqQWVPWFgxS2FpK1N6K21sREhDRThxUUltaWpx?=
 =?utf-8?B?Zm0rWFRZUHFMRjcxT1U2c1AyclJSM2t5dnVtQ3BaVy9OVGZUd294WHRKTkdG?=
 =?utf-8?B?UkxOOWM1UTJHZmszdWRwb0xNbEdRM1NnSVdvV2JsMzRORGEwcGpSNUhSYkpn?=
 =?utf-8?B?bDRXdHJMWk4yd2R2Q0lISVRQdzBqUUhaWW9Nd0huRTlKTGcwalE2dDdrQjNy?=
 =?utf-8?B?Zlp1NVZKQW5zNThnRExzR1R5a0tsTmJHd2dTbm45ajF1bnJHaU1iYjlvb0pK?=
 =?utf-8?B?SVlWdWVtTGJ1U2dOOHJKcGo5UGdiYU5uRnd3WEVnTGUzamdNZzAydlhBV0tD?=
 =?utf-8?B?MTFoU1o0STNtRHYzNEcrVXBJQ1JsQTBQa2gzWkVTYXd2WWN4bjlEMStuTkdD?=
 =?utf-8?B?WTBWSWE3T294cDhCNFI3QytiMy9rK2dYdGpOTDl1MVVXajZuQTdqdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de2e7ec-1ab8-4492-07b8-08de8fd6ed49
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:10:41.0262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+neToEZayeltRbnZGzMRN0BfCvQ7ElMQus1eHH6pFoPJhuss0Na32Ic3LKg+cml8Rz6oUH9WIpchpVKt+jHPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10667
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

The GPU instance used on NXP i.MX952 is the Mali‑G310,
document support for this variant.

A hardware GPU auto clock‑gating mechanism has been introduced,
enabling GPUMIX to automatically manage the GPU clock. This improves
overall response time.

Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index 8eccd4338a2b..6a10843a26e2 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -20,6 +20,7 @@ properties:
           - enum:
               - mediatek,mt8196-mali
               - nxp,imx95-mali            # G310
+              - nxp,imx952-mali           # G310
               - rockchip,rk3588-mali
           - const: arm,mali-valhall-csf   # Mali Valhall GPU model/revision is fully discoverable
 

-- 
2.34.1

