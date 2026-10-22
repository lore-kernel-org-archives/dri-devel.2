Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE79606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=C++1EJLn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AAE710E489;
	Thu, 22 Oct 2026 19:37:51 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013003.outbound.protection.outlook.com
 [52.101.83.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457BD10E2BE
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 19:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQ1bxW8SgE0XyGvdrvgBpuLcJf2JW1GTf6PtiX5ZTTMxH2feGHgAg0zrd57a/q0vb+Ehl2tK1CZBbwlrehrTpBb9Y+HZq2HsmGliSOI2SCygZhvYHLKWn2P0SPKyv3gi3BrZZmDVmiZMq25pUhWDcEdd78bN+M0Yj1M2B89BoeD/4P/U1qXFg2jAjoCJpmu140LC9YAPebZj5qgn1T2+a493O42ygIpMInzfseSerso7l1iQUJSP7SKS3YCLPvr1uplgKtqCoNCMwM15gxMDGo68g0+YTJKk+RPeqP5jnOHz4yshigtIvPwBeYkk9VTmgF/a4lBitFO64IOLCxl2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhkAP2LeKywPckto7jEE6mmpb9gohcBu4bdcvXsbfqU=;
 b=csJUXDIcuDJA99XYIqFyn6wuHN0mJoqWIAmKQuwg2PKPWM7WA4adh8fF/BJO3ZXVeNlpHfJL1FOQzcAiLO8XxrbuV5Py6GSUc6sG/N+zYvT/D2eD8pO18IarLK8iCxqFqDUslAwqJMsjElJfQfOnoE8joOcQ/hLixyH6Tk0Xg+FY+LacrBNhJ+n5vTCMnDuPlKiL4wR0q9vhhJr6cwHaRMdFGLG6eqeSpya6r2oH9uF7oIL5cPd8/PrRk3jX6kZRkf14cV+NZm1+EWBHaw4oBb7fL+1mgtqK/8uYZ8HuHbg4cJpsy1xxsGi2GnO/N8NkOu3u22sB+otCiM+x+cNtmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhkAP2LeKywPckto7jEE6mmpb9gohcBu4bdcvXsbfqU=;
 b=C++1EJLnVDVx1sbJUW3CykrXTGxVYDFEHw1t1+iC3ySvbIodTtZvM1aiLq1ANBDoflhl/jVu4IOOnznxZbzfO80juxNq2qlqMbThilKK8COZK0rR2QVAE5Ckzk04T2xRLVeRakknWAlPkpnmEHZI++bT23s0pQJ5eEmiM2cgjVXLxC3LAvYkxUDi7Y/RQwl6lVic7J2WDV4BO/32G1xFLgnocE0+lI6URq4KNeuGF/yPGNlSDQM28HsCrMrzsA0/pehoLPH2/00fffovJIkCZXZRZ71hvHWOvaogVwLxMLutw4DmOQwmE7+dT+qGbXnbB2U508G6xC3TIKLtkEZzRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU2PR04MB8679.eurprd04.prod.outlook.com (2603:10a6:10:2de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 19:37:39 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 19:37:39 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 22 Oct 2026 15:37:08 -0400
Subject: [PATCH v2 5/8] arm64: dts: fsl-lx216x: remove #address-cells and
 #size-cells from pinctrl node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-cleanup_dtb_warning-v2-5-e9502fafec59@nxp.com>
References: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
In-Reply-To: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792697827; l=1135;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lgX4DSVfNJF1xO6kh/Ie5H2c4YGjgIiMjFErMMX552A=;
 b=4Cv1l1cw69a1DJI681WgGphh2tg6Viv9747uNLOYbcwZZv6J3F/ydXX2xxWxUaJ+1HktCj01X
 cYx8rtAI3f4CPn6JjKroxei68wnNSRBrfgD2Y29z6xXnsqO490RyljR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:510:2da::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU2PR04MB8679:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d207f8-fb5b-4054-3849-08df3073eeb4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|19092799006|366016|921020|56012099006|260925021311599003|260925021911599003|260925022911599003|261009223027099003|11063799006|10067099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /liEMKnwpfR8c2DnGXgf5u6AhVMvTYMKzYdThz1Fr6ZBWKvgk0+/wnlpKtHNBCLv+pLye/lUVZDpmL2yK3CAPpWzVB94bBP6xyPvrn7KM06SpqQMOIRc3a2OYxQwmhUsseR9GsHWD/ywGWc9Ol0cZGzyo+2Lu0theKXQMz3qYl4Sfw0oPT/ZzaL1Q9tTMGix/KVyQef32IdEhyxpsrtz7+UEAZl3wpyTrRXAfIFmFDyXUXo4wjj1SipqsDAW1HdTX9EDPiuWuWEPXvkofi9bj5X3X10c0EGxd/Er0LAQJlNJaA1zRBl+bRLhA2++VzD9yEO0/q7xKSMf9171t72TBBGbV9cYULicn+Y1/jQZCoTe5qnBOXpyATvs8/Qk0ZLKqelGCOQh726Ji7vMO3XoQDqnESVU5zsAtfg5ZfuiV3p/IBqiG5MgkVmnUxKCBoEIheQf8iQpygXKusg9UO56PAu76aqOg0E8rajnsMHmKVR3JsVCyspL3s/G8qDcxbD6bD3GOdVwYvRTVK5asCpIH+8VxYlQ52zfpIISF2lMd686d4GKBOD2DJdSnBdp8Urudn7GjcnCF63uOJDKjTQjmZU2mm3vYSG/NDw0aFA6hwmnJGtYom8d2QR7o95/4qj9Yv6sy6yAGMn5kg6mJ1KH/ol/rGPMRW1VYFcZw2Trnf28HUW4DmSMicN7HMDkIcIQB/MGS7d0BpA+t2I+4aFRkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(19092799006)(366016)(921020)(56012099006)(260925021311599003)(260925021911599003)(260925022911599003)(261009223027099003)(11063799006)(10067099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFkveDlna1pPaDBpVHNZdDRwRDlRWkJWVEpHZ1dqZlJyOU9QaWRIRTBGZHFh?=
 =?utf-8?B?a2Z2enNqUVlOYXVoNktkcGVsUkZGbm56ZUwwYTZnc1J1SUwyV2ZwcWpJWmFH?=
 =?utf-8?B?VzU1ZVpIdHYxUkVTbFlma1NvaHJLOEtYaGN3OWRqMGtDVk5MamMxTzhUQXFC?=
 =?utf-8?B?aUlJYnI5THpYNXYwZnA1aEF6VUNQd1pRMXFwbDVzNDllMlFxekZmNzhVd1hR?=
 =?utf-8?B?cW41NjZtL2hURlh2YWNCSjhhRTk0by8xeDdZd2c5UzBySW8raG1iQjhUUnZK?=
 =?utf-8?B?c0pCekdhdlU4aXdCQWxHdW5iQmxQeHp6OE9YVHlIK1U5Y0FlZWFleE5mWVVX?=
 =?utf-8?B?S01SOVliQzBZaDJDOHNMci9DYmhISEVKczRmNTQxNmxWYUxHcER1UUJIQmdM?=
 =?utf-8?B?VEVhRldiNTJ3VnpwK1NHdUhaM3JnUVNuemprREQ3QW1HTW5OalVIYUkwSGEx?=
 =?utf-8?B?K1hacHpLSGlNRWhqd1lpSWx2dVFDTFhXcGFKUWo0RGViWmZYVTlQMlF1R2V3?=
 =?utf-8?B?OWdmT09hL2I1SUxPZTA2NTVzbzVIQkoxK3VXeXR1ZE16YjhIcldvQ1JqdGha?=
 =?utf-8?B?QXh0YmkwMEZTOEF0N0ovcDhHMytyL2FXRmVib1NnOHFqTG00bElIT054TGpr?=
 =?utf-8?B?eENWelI1ODlEbUFEMnlkQ25Eb0NyYkE3bGgxMGwwOVUybTJJWFUxMitLRlJl?=
 =?utf-8?B?anNaTnQ3MW5oZnpmbzFOT0dhUHJYVzlybzl0Y01WTlo2dHNFaTRXL0ZmNUxE?=
 =?utf-8?B?bWVQNUc2N0FKRCtPRnlKdiswczh1S05rdWxOOG1jeG5kMmJ5VzdQVytoemc2?=
 =?utf-8?B?bWNHYWkyYnE0U2Rid3c3UWh0c1JHbEpkbVBaL284THdrbVEvK2lzMStZb1lK?=
 =?utf-8?B?enArREtaa3dZSkx2czd2Qmo2SzhnVFNmQ3N1MXhGaktTOWNBOU82OUt4dEI2?=
 =?utf-8?B?N0JDS1pZanlyeTQ0M0VJQ2NjVGpXeGM2UC9jWVBnemszcmVtWld3Q09aN0Rl?=
 =?utf-8?B?Qk8vSkY4WXV2aytrTnFxRW1VUWxyU1dIYzc3RXJnMzAzR2Z3Zm9ZZG8xYU9N?=
 =?utf-8?B?TFNxMDVweXBIZXFjUW5IT1FsVThYbWVUK3ZPNjJtK0ZDbDF2Nzl5VGlmekFi?=
 =?utf-8?B?ekZxUUh2SW1pbW9HVnFlQmFMWjRuWFlDVk8vdUdra092VkpIcSsydUFoVFFi?=
 =?utf-8?B?Y1VYMWpxUUM4ZVc0bFk0aURPUGRTSWNzV1RPV09NSUlocE1ZSmxpQlZGZFc1?=
 =?utf-8?B?OHpaMUI3MUN3alJzSE5mOStHWjFjOWFBVzlubVZhcXJXZVhXQ0JaaFpISzIx?=
 =?utf-8?B?a2FwcU96aDl1QWM4TVFQdVU3dU03UlVPVUZWbWhrenhIeWlHRWp5cEdiLzA4?=
 =?utf-8?B?a3d0QSszcmMvR0dLZHRoaWM5b0FpL2w2c2tPdVR4RlR1OE01a0Z5MUJRRGRQ?=
 =?utf-8?B?VVMzS0ZMK2dodWpQNG9KR0hBWGdHMSt1UEYrZVpVVUllZVpUUExLOTlseHYy?=
 =?utf-8?B?UWkwZU1BTFhBQzQxSjBzS3p5R0RxQzRZOW9VOEcvSVhQczJaSmRBRnM0REU5?=
 =?utf-8?B?ODVBcGRwS1FwekxPYVN0T0pQWUhkVW12UDAzT09ONXNxTWxzOEFQQTJ5QUE0?=
 =?utf-8?B?RXNhMTRINGkxQWMwSnFTSm1uV21ZZ2tTcG1zdktBekYxNzJRVXo3WGNHQWdJ?=
 =?utf-8?B?NTNTWldyd1l4RUMvMlk1WEFZVkVBRGRtMXVxVXhiU2xqenpaSDJsNk5KeHZi?=
 =?utf-8?B?aWNmME5NMy9IblB3SnIvMzdMbnpIMGN6aFFRM1pOcjBnVlV6NVNnT1dyQ3Vy?=
 =?utf-8?B?NjN4L3U0bjlJUFd2d0Fqbk5aTzkrc1JJanpqdldMOGp1b2V0R1d1N3BDQjlo?=
 =?utf-8?B?UEs2UjRzd0pXNVhhemFpQ0F4MythaVpEMjRhaGNadEQzV1JLUDFFbzlTd3VD?=
 =?utf-8?B?K3d1ZGRzYk8xTDlhRDdreXM5SkNTdFcrcDhsODBPZitZRzArYXJvb1A1bTJo?=
 =?utf-8?B?dFNMUmhINk5OdWhiNFNNUkNzZzZEUHJ6NTFtbTNiditpZ0xmMmFmNkpQZnpC?=
 =?utf-8?B?bVBZZlJHdS95ZGJpdXovSURVNzhjd0xsbk1OZkpjS0NvcWtrOW1lK0FKYXBT?=
 =?utf-8?B?SXhmdTZ4dE1RbW5XQjNEZUdHRTlwbVM2bkhQbnFZTWpCUVZnbUNFaDZpdVpG?=
 =?utf-8?B?cnNDblltbnZoWklKTVFpOEhYeVBwaEJ4TjRJUHExNWVHalFvcm95N0RQL2J2?=
 =?utf-8?B?S1NzUE9nQ0ZCamdLZWp3TTZZd2tELzM2K0YxNmlxRkJ0Yml2TGJpK2hCZHRV?=
 =?utf-8?B?YWgyK091cnNBek15MWNaQjg2bmFVN2ExOHpOWTdIc1g5SEVGNDZqaW14N1Zt?=
 =?utf-8?Q?QrO/qTR7idPN0eqhyzI7z2pEwVqgD8REFSacx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d207f8-fb5b-4054-3849-08df3073eeb4
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 19:37:39.4674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Q4b3FxYrXXuB9gUvCDGEa1fnSwjcNP0vXhWvGaAVqDhSalM0e5ACOcc9weciy4qdyMoBvdmmuM5fVnHHah1/ks/NO4cpWq+aAhRm0pzChd5YX03acQFy00PtTCGEfd6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8679
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

The pinmux node has no address-based child nodes, so '#address-cells' and
'#size-cells' are unnecessary. Remove them to fix the following W=1 warning:

  arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi:1534.34-1704.5: Warning (avoid_unnecessary_addr_size): /soc/pinmux@70010012c: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" or "ranges" property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
index bccf2d6730230..6d2667051674b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
@@ -1534,8 +1534,6 @@ pcs18: ethernet-phy@0 {
 		pinmux_i2crv: pinmux@70010012c {
 			compatible = "pinctrl-single";
 			reg = <0x00000007 0x0010012c 0x0 0xc>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			pinctrl-single,bit-per-mux;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0x7>;

-- 
2.43.0

