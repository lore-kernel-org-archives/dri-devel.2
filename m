Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC906CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0429C10E5E0;
	Tue, 19 May 2026 14:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rE+a4yEn";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B5710E5E0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGUumhtmwXtjA+BrpxDr1Rj8i0/1KfXlb5ByAgPmQITrJQPgqxx9I+fCsdVXNvA2gC+9EDDpq+Phwg9Bb33bGD0yvuCMy+pvmVGuEVd/lxzSUfkB7zW2qxLztLX0wAd+IijslOLn9JNcisM0w7v5qv0P5hD9H5iUt9aYdTywkJwerLKx+cCwLBeE1k9/nuSliMpAa8+rDA6hBGoWgUW04PrICE+zDCX62dpPPXMnfyL57y4VVKavfehvE+yzJRbalhqGyrkc5bdZZwtEgfgf6ImzLJ8w6h9u5xW1Yp6SjIJzJ6fbWPXSbqvINkkJzvlMGxgjdi6oaxqbav3P4KNWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zo9SVukgQRgCyZMkvij1lPeAzz3DvwoOZzss3aiJLuY=;
 b=KuanfQzmc9vYsMW2YC0J/tRgIntI+wj9v8C57SxhOnDAzzlyztdHSRXs8+J5b21xoA9WCsrDAeBoSFR/NKxXo2EXrOxAYTX6QDAshJA6tqlubHchcdAZll/4A/eq0kX/deBG0/lj6UjfKuFvWudql2Q+zej8zC5LhGl5jFpxIht2dwVSlOolWX91lBpFdh7GAB+1ugZWLV4Tmy/RecHJUILShN4mUm4+5SwKck7xAQUtS5OlyV/fUx0jGbnwXyJsQOJ5tvuJEEBJEAwJJJptsyrf5yv135NBc/6gXfwCRtIJxtPHp3Op1l1pLEirtB8IzvtFvNkkFM/RtIUftv4vGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zo9SVukgQRgCyZMkvij1lPeAzz3DvwoOZzss3aiJLuY=;
 b=rE+a4yEnnGCTBTyKzDkFgxJ++rmFFtwyTGTnbmrfYP1IRWTfn7i9Vmf32E0weg6Ph5mgki5vsTnJmLiZuYvf2VvkGsaV4jhBR0gWFso45yJPuu0BARN5t+bhkiqGh3UOh+dV3QFCLF5N0JSxObxWKTuMGA+jS96dbS56G7xCuowz0glkcSI09XX9GOG/CxoQ7xWKEt8sBxzcpjgaaDvCZk4GkTHH7cpVW3s+ZYTt09h+7oRuRQ6f3xbZMJpEIDDGMTXm7QyhPuA4YRiNnAcKh8bnxxxpUUbCN7HtEZ0LW8RNRXQVZwYN6OL+4NhE8ZgbuODpnBKsYhRwEE7fpbhF5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by VI0PR04MB10831.eurprd04.prod.outlook.com (2603:10a6:800:25e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 14:43:04 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 14:43:04 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Parshuram Thombare <pthombar@cadence.com>,
 Swapnil Jakhade <sjakhade@cadence.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Nikhil Devshatwar <nikhil.nd@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ying Liu <victor.liu@nxp.com>
Subject: [PATCH v23 0/8] Initial support Cadence MHDP8501(HDMI/DP) for i.MX8MQ
Date: Tue, 19 May 2026 14:42:23 +0000
Message-ID: <20260519-dcss-hdmi-upstreaming-v23-0-5615524a9c63@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260406-dcss-hdmi-upstreaming-28998a88e911
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0025.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::15) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|VI0PR04MB10831:EE_
X-MS-Office365-Filtering-Correlation-Id: 47605f3c-6995-4dcf-a5c8-08deb5b4eed4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|19092799006|366016|921020|3023799003|11063799006|18002099003|56012099003|18092099006;
X-Microsoft-Antispam-Message-Info: lqcdihBxxsGESPounXV5DAyj38O/UlIfW/rIkIAyYE2PM0n2K3Q4E9oUnOVmeDzjIRXdddcpeQVkotBbqTAXldc1u5ntqS7EVhLNzN0I52inhMUR0af3aA7zBpkOf3bH0RQSJG0D0e/YweqWUP5LyDLduIp1oflq9EJ52R7tiA+o7Qv56jXaTAbxqkkHi6SPXnGYKW987oKbdndzRIHyrpAN4RB+L8bR19+D+VfLSGWNxIPvl5Z2ESFq0qRsKP6d6uaFtO9rTK4Nl95pdQ6mwciZ3zfM2Z1wEWlvc9eQiUSVj/QS1t1Vmyy2zdA88aO/7TrSkz3TmXRJcDbnX2QltlerBoCsFmhraEYA/bdpT77x34idf/KJ/naxYOyPVGjuTx5y8vzTAw0srRIkAogxdZ1D+7U5CHdSgX+57Y4/y/rO39MLEdHwAji398ghgHAT/MzAMH4bj1438CodTy7CvJmQ6wqdEdvt8k7rHfVyZEnnVeixr4rDcJezIwiS3+iWme6PCqzO/Yzsjzcn8bcNNlJZTHDreRvprCLuiFzWjV27l8WRAM+UZoZsrNBb0gU1TTPSNnPkMaLhR/w5UaaoJLiZk5OFdh4I5BQL/Yjp9Bjk81PuKg/JZ3qN0V5hup0T6aA/Xo/gv93CLhNGwzE1wE0UO45T96nfOocPM4hYd9ETPoR1wwI+ZE87MJx/iAsS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(921020)(3023799003)(11063799006)(18002099003)(56012099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1VoYXp6OUdZblBMQytnNEVwbUkzM2hyZzZ6OEMzd09xUHA5MlNWZGpOcEJh?=
 =?utf-8?B?eHNIVUxTSjZyZU02OThmb1RnaElOdUZFaTVBdUdjcnBUVWdINmpkOTJON1FX?=
 =?utf-8?B?MUliQUl3Vzk5dDlDTFN0V3Vya1N0RkFqcVovL3RvR1Qrb3FRZFpDN2hERmZN?=
 =?utf-8?B?UU5lYmc2dEJZVlBXcWI2VWNpMkI3QXlhS0pwZDk0ZnhLVUV3bkNRc3l2bjB5?=
 =?utf-8?B?ZThVblE1UUd1MUlVeE1jY0l6cDBsNnB4cG5wSTA2ckVFeWVINVo2dmppSkVn?=
 =?utf-8?B?SU5lUzZhREFkNkRhU3FYSGFRKzEwVjc1c3NwZ29mRFgrcU9YZmFhZzdGMDV3?=
 =?utf-8?B?OTBmZGE5bnFnU2QrZFBuQ2RjcVJJMjZpQXJkcVhyUzU0bldmN2pnalE2VDl5?=
 =?utf-8?B?UkpDbzFCaGw4azF5c1NnVDlhSHNYaGVaYlNtRi9uY3ZaYWZWS2orTmdtTUMz?=
 =?utf-8?B?WHZ1S0NCSjZEbEtVeFpiajdPSXFRaVY1bENZQW5UZ3o4c2dFUm84dkJjWGJz?=
 =?utf-8?B?cndWVE5DSFd0bjhMOUh5MXRZRC9RSktiVTNqOGl6T05xQnFtWEJTYXhvTVhq?=
 =?utf-8?B?eCtOTG00N2N6TFlzVksrYkJTVkI4Lzd4SXhWN0REelBSbTV2WGkwSWJramdj?=
 =?utf-8?B?QnlaRW5JNFExRTFDUGhCNmdSUDd5alM3dkwrNVZSWHA1NEtzaXBKbWUrOEw1?=
 =?utf-8?B?d1NvMmpIZVdrcFd5UHpubW9hdjVMVWRjM252Y3htejZQanllZXlDZmpVWXNI?=
 =?utf-8?B?QkZsLzJGS1JSdklHa3pYbHJKQWQrcjBpdkdPdDRiUnk3bHhqRHk5MU1aazBG?=
 =?utf-8?B?WlZnSTAyVTVpUGllK002cXdhOHVicTN4S2pBMktkVGtqM3NwRmluTWpRb1ZX?=
 =?utf-8?B?REl4R3d5YSs1VjFoVG52TlRza0poSXpBK3o5cC9ncnprR0dpY2lRaEQ4Qlp2?=
 =?utf-8?B?TXVhbE1HWlo5S1daV0Z5Nlo3d1JiakRoM1hGUmVRN0pWOHdtM3JiRGNMQkN1?=
 =?utf-8?B?ZTRpNDRwZE9VVHYzVU1Oa3dYWklHb083RzFkV3J6VEYxVHNMZE43a0txZm40?=
 =?utf-8?B?NUEvdllNdEZoVyt2RkN6U0RZY3JIQk9IZGpjVFVPWE1GTUcrTXlrckZqUDA1?=
 =?utf-8?B?K01TSXNSSmFkUVVwc09rVDNHVzdYRXc3ZUFranI3bFNTK0hvR3lUQ3Z0UVJP?=
 =?utf-8?B?UjVpUUZHc0U2WXQ5Skd1dnJDMEczYVNOTGhRT1Ntb0pxU1l6aFIvMVFNRllh?=
 =?utf-8?B?K1UxcnR3QlY0ZmkxVjRlUXgveDRVcDNJV3pacUh0VG1Tb0x0cHlrdEtJa0pD?=
 =?utf-8?B?c1g5RHVJSHI5SFNqaGRsNHlDTGdpalpqNzBOM0VMRU5lQThyeDRCMStrRm9Q?=
 =?utf-8?B?cWY5Rll6QjRoM1BrcE1zZVZPVHVLRDBNbUJqVFRpYXdxSExSRGRPMEhpcEgx?=
 =?utf-8?B?SHNyWEsyZWFCN0psR0F2WGN6VWFZVGV6SDN1UUJrMTBLNmZ1cisySmd2ZFBP?=
 =?utf-8?B?ZHVCdlN0QTZBcGl5NURBbTU3M0llRTdrdXZ2MHgyM0RLNlVwRGJkVTdKWHA4?=
 =?utf-8?B?MU0vUjlzRVVFSmhhdDhkZkRnMnQ2bVlmY0lhMkVwQVhUUExCZ3IrQ1k4SkZr?=
 =?utf-8?B?eHJFNTVSUWpXZTZRYm5PbnJLcGQxWTBQM0lCVzFSanZqcEF0Y0JMQ2J0V0RH?=
 =?utf-8?B?VlN5TmxXVEd1eTg4M0RPVHp4eHVCd0x1U0YwOThtZUV3VVJtaGkrZFYzNWFW?=
 =?utf-8?B?WWFZNjNET0ZSeG43UmFIdEkxUEFwZDlnSFNuNXF3elJndHhPc3hFbE1nMWtM?=
 =?utf-8?B?L2hXUGkxMWRxOVRjRG5HLzNJd3RPbm1COXhWbUxyNTVGZDhUakt2RXduRFhJ?=
 =?utf-8?B?THorblpxaVkxZTRrUjVkaTFxRnlvbWIxNEVtckhEVjBQUGIrNFVoNDFVay9o?=
 =?utf-8?B?bVZEb3lIeWtVeDRsVTNPR0s2YjVMNmFOTnZRY1pCcE9tbGNOcXhjdkZIdXM2?=
 =?utf-8?B?L09BY3ptbXYwSVk0TGVGNG9Xc0tubmM3YklrMWFGdWNCaHZ3b1Jkcnp2OHFS?=
 =?utf-8?B?L2Jhb1VjY0ZBeEdxNHJvN09kYlpWUE1xUzFUclorMXpTREhoRi8rRG9TVjNj?=
 =?utf-8?B?NGdhWFRhNnA5MVZ1WGhWVjBqMjZDMFExa0tmd0toc2YvK05FUlJVMXFnc2Zt?=
 =?utf-8?B?RnlEMUZzYVFNZ3UycFFEaUYxSHpQRGhDZW50ZDllMEwvellZaVB2Q3dOUXA4?=
 =?utf-8?B?TTJsTytKOGFLZkxpZnhWcCtISU5VYkU4OWljY3p2QWo0TVVwZHZWM01wTUlu?=
 =?utf-8?B?dzhYMzdiRUxJVzBUYStJTmFISDZ6dllzUjBna0k0RUtib0ZiL0hPVjNEek1R?=
 =?utf-8?Q?InXX48huTNjj7dJw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47605f3c-6995-4dcf-a5c8-08deb5b4eed4
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:43:04.1969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoWsrZBy4rJ2Nhzxbq/zjEWuNa01XYdvBFiqXwv1CHYT9F7aprU4Tms02l8+FyRBgUlQwbCFbyyIZLbped4fQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10831
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

From: Sandor Yu <Sandor.yu@nxp.com>

Hi,

Since Sandor left NXP some time back, I'll be taking over this patchset
and continue the upstreaming process from where he left off.

The patchset adds initial support for Cadence MHDP8501(HDMI/DP) DRM bridge
and Cadence HDP-TX PHY(HDMI/DP) for Freescale i.MX8MQ.

I addressed all remaining reviewers' comments from v20 but I'm not sure
whether Alexander's issue is still present. Alexander, let me know if
you're still experiencing a black screen with this patch-set and I'll
try to address it in the next revision.

Thanks,
Laurentiu

--
Changes in v23:
- Reordered the patches: moved the phy related patches before the
  mhdp8501 ones. The mhdp8501 DT binding references the PHY DT binding;
- Addressed more Sashiko comments:
- 0001 - soc: cadence: Create helper functions for Cadence MHDP
  -  cdns_mhdp_dpcd_read(): error-checked the mailbox call result; added
     response address validation (returns -EINVAL on mismatch).
- 0002 - drm: bridge: cadence: Update mhdp8546 mailbox access functions
  - payload[7] zero-initialised in cdns_mhdp_adjust_lt()
  - IRQ number stored as mhdp->irq in the struct (was a local variable)
  - disable_irq(mhdp->irq) added at the top of remove, before flushing workers
  - int irq field added to struct cdns_mhdp_device
- 0003 - dt-bindings: phy: Add Freescale iMX8MQ DP and HDMI PHY
  - Maintainer changed: Sandor Yu -> Laurentiu Palcu
  - Example simplified to just the PHY child node; removed the full
    display-bridge example;
- 0004 - phy: freescale: Add DisplayPort/HDMI Combo-PHY driver for i.MX8MQ
  - base changed from embedded struct to pointer (shared with parent bridge)
  - cdns_phy_reg_write/read() gain an int *err accumulator parameter; callers
    batch many ops and check once
  - All config functions changed from void -> int
  - read_poll_timeout() replaced with explicit poll loop (handles read errors)
  - mdelay() -> fsleep()
  - char_rate_khz: u32 -> unsigned long long
  - New cdns_hdptx_phy_init() op: fetches cdns_mhdp_base from parent at init time
  - Various validation fixes: link rate check moved earlier, HDMI rate comparison
    fixed, unknown mode returns -EINVAL
- 0005 - dt-bindings: display: bridge: Add Cadence MHDP8501
  - Maintainer changed: Sandor Yu -> Laurentiu Palcu
  - Compatible string split into fsl,imx8mq-mhdp8501-hdmi and fsl,imx8mq-mhdp8501-dp
- 0006 - drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
  - Bridge type from of_device_get_match_data() instead of OF-graph traversal
    (cdns_mhdp8501_get_bridge_type() removed)
  - dev_set_drvdata() stores &mhdp->base so the PHY can find it
  - bridge->next_bridge used instead of private mhdp->next_bridge field
  - phy_powered + link_mutex + removing fields added; all PHY power ops wrapped
    in scoped_guard(mutex, &mhdp->link_mutex)
  - curr_conn -> curr_crtc; bridge->driver_private -> bridge_to_mhdp() helper
    throughout all three source files
  - AUX native-request check fixed (was always false: & instead of ==)
  - SCDC I2C: devm_i2c_add_adapter(); off-by-one fix in length check; better
    I2C transfer validation
  - struct drm_atomic_state -> struct drm_atomic_commit throughout
  - HPD retry on read failure; debugfs creation deferred until after firmware ready
- 0007 - arm64: dts: imx8mq: Add DCSS + HDMI/DP display pipeline
  - Compatible changed to fsl,imx8mq-mhdp8501-hdmi
  - port@1 block removed from dtsi to avoid dtbs_check validation failures for boards
    including the dtsi without setting data-lanes property; downstream boards will
    instantiate need to add it when connecting a display
- 0008 - arm64: dts: imx8mq: tqma8mq-mba8mx: Enable HDMI support
  - Connector port endpoint block removed from dtsi since it's redefined in dts anyway,
    to avoid any duplicate label dtc warnings;
- Link to v22: https://lore.kernel.org/r/20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com

Changes in v22:
- Addressed most of Sashiko review comments (per-patch changelog below):
  https://sashiko.dev/#/patchset/20260407-dcss-hdmi-upstreaming-v21-0-4681070ab82f%40oss.nxp.com
- Removed all existing r-b tags since pretty much all patches have
  changes;
- 0001 - soc: cadence: Create helper functions for Cadence MHDP
  - Global mailbox mutex replaced with a per-instance mailbox_mutex in struct
    cdns_mhdp_base
  - Added dedicated mhdp_mailbox_read/write_secure() functions; all mailbox
    helpers now take a bool secure parameter instead of a raw regs pointer
  - Fixed HDCP opcode numbering (values 0x09–0x0c shifted up by one)
  - KDoc style fixes throughout, added a kernel-doc comment to cdns_mhdp_base;
- 0002 - drm: bridge: cadence: Update mhdp8546 mailbox access functions
  - Added mutex_init / mutex_destroy calls for the new per-instance mailbox
    mutex
- 0003 - dt-bindings: display: bridge: Add Cadence MHDP8501
  - Dropped 'cdns,bridge-type' property (Krzysztof); added 'phy' child-node
    property to avoid having 2 nodes with the same address;
    fixed mdhp_phy -> mhdp_phy typo
- 0004 - drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
  - Bridge type is now auto-detected by traversing the OF graph to the
    connector (DP or HDMI), replacing the removed DT property
  - Since PHY is now a child platform device, use devm_of_platform_populate
  - Extensive error handling improvements (goto labels, proper unwinding)
  - HDMI: fixed uninitialised packet[] buffer, SCDC read rewritten for
    correctness, hotplug handler uses proper modeset locking, atomic commit
    handles -EDEADLK, infoframe update moved after hardware config
- 0005 - dt-bindings: phy: Add Freescale iMX8MQ DP and HDMI PHY
  - Binding file renamed to fsl,imx8mq-hdptx-phy.yaml to comply with DT spec;
    removed reg property (PHY inherits parent MMIO now); expanded example
    showing PHY as a child node
- 0006 - phy: freescale: Add DisplayPort/HDMI Combo-PHY driver for i.MX8MQ
  - MMIO now mapped via devm_of_iomap(...parent...) instead of its own reg
    resource
  - Fixed uninitialised variable, wrong return type on link-rate error, NULL
    dereference in phy_valid, and swallowed error code in clock enable
- 0007 - arm64: dts: imx8mq: Add DCSS + HDMI/DP display pipeline
  - PHY moved from top-level bus node to child of the bridge node;
    fixed mdhp_phy -> mhdp_phy typo
- 0008 - arm64: dts: imx8mq: tqma8mq-mba8mx: Enable HDMI support
  - Added status = "okay" on the HDMI connector; removed now-gone
    cdns,bridge-type; added status = "disabled" in shared dtsi
- Link to v21: https://lore.kernel.org/r/20260407-dcss-hdmi-upstreaming-v21-0-4681070ab82f@oss.nxp.com

Changes in v21:
- Dropped "phy: Add HDMI configuration options" patch because it was
  already merged separately;
- Rebased to latest linux-next (7.0-rc6) and fixed all issues
  introduced by API changes in DRM;
- Addressed Maxime's comment on patch #5 and used debugfs file instead
  of sysfs for printing firmware version;
- Addressed all Dmitry's comments: handled the
  cdns_mhdp_mailbox_send_recv_multi() error, removed the RGB 10bit
  unused code, added a dts property in order to get the bridge type (I
  couldn't find another way to do it...);
- Dropped Krzysztof's r-b tag for patch #4 (which is now patch #3)
  since I added a new property;
- Link to v20: https://lore.kernel.org/r/cover.1734340233.git.Sandor.yu@nxp.com

Changes in v20:
- Patch #1: soc: cadence: Create helper functions for Cadence MHDP
- Patch #2: drm: bridge: cadence: Update mhdp8546 mailbox access functions
  - The two patches are split from Patch #1 in v19.  The MHDP helper
    functions have been moved in a new "cadence" directory under the
    SOC directory in patch #1, in order to promote code reuse among
    MHDP8546, MHDP8501, and the i.MX8MQ HDMI/DP PHY drivers,
- Patch #3: phy: Add HDMI configuration options
  - Add a-b tag
- Patch #4: dt-bindings: display: bridge: Add Cadence MHDP8501
  - remove data type link of data-lanes
- Patch #5: drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
  - Dump mhdp FW version by debugfs
  - Combine HDMI and DP cable detect functions into one function
  - Combine HDMI and DP cable bridge_mode_valid() functions into one function
  - Rename cdns_hdmi_reset_link() to cdns_hdmi_handle_hotplug()
  - Add comments for EDID in cdns_hdmi_handle_hotplug() and cdns_dp_check_link_state()
  - Add atomic_get_input_bus_fmts() and bridge_atomic_check() for DP driver
  - Remove bpc and color_fmt init in atomic_enable() function.
  - More detail comments for DDC adapter only support SCDC_I2C_SLAVE_ADDRESS
    read and write in HDMI driver.
- Patch #7: phy: freescale: Add DisplayPort/HDMI Combo-PHY driver for i.MX8MQ
  - implify DP configuration handling by directly copying
    the configuration options to the driver's internal structure.
  - return the error code directly instead of logging an error message in `hdptx_clk_enable`
  - Remove redundant ref_clk_rate check
- Link to v19: https://lore.kernel.org/r/cover.1732627815.git.Sandor.yu@nxp.com

Changes in v19:
- Patch #1
  - use guard(mutex)
  - Add kerneldocs for all new APIs.
  - Detail comments for mailbox access specific case.
  - remove cdns_mhdp_dp_reg_write() because it is not needed by driver now.
- Patch #3
  - move property data-lanes to endpoint of port@1
- Patch #4
  - get endpoint for data-lanes as it had move to endpoint of port@1
  - update clock management as devm_clk_get_enabled() introduced.
  - Fix clear_infoframe() function is not work issue.
  - Manage PHY power state via phy_power_on() and phy_power_off().
- Patch #6
  - Simplify the PLL table by removing unused and constant data
  - Remove PHY power management, controller driver will handle them.
  - Remove enum dp_link_rate
  - introduce read_pll_timeout.
  - update clock management as devm_clk_get_enabled() introduced.
  - remove cdns_hdptx_phy_init() and cdns_hdptx_phy_remove().
- Patch #8:
  - move property data-lanes to endpoint of port@1
- Link to v18: https://lore.kernel.org/r/cover.1730172244.git.Sandor.yu@nxp.com

Changes in v18:
- Patch #1
  - Create three ordinary mailbox access APIs
      cdns_mhdp_mailbox_send
      cdns_mhdp_mailbox_send_recv
      cdns_mhdp_mailbox_send_recv_multi
  - Create three secure mailbox access APIs
      cdns_mhdp_secure_mailbox_send
      cdns_mhdp_secure_mailbox_send_recv
      cdns_mhdp_secure_mailbox_send_recv_multi
  - MHDP8546 DP and HDCP commands that need access mailbox are rewrited
    with above 6 API functions.
- Patch #3
  - remove lane-mapping and replace it with data-lanes
  - remove r-b tag as property changed.
- Patch #4
  - MHDP8501 HDMI and DP commands that need access mailbox are rewrited
    with new API functions created in patch #1.
  - replace lane-mapping with data-lanes, use the value from data-lanes
    to reorder HDMI and DP lane mapping.
  - create I2C adapter for HDMI SCDC, remove cdns_hdmi_scdc_write() function.
  - Rewrite cdns_hdmi_sink_config() function, use HDMI SCDC helper function
    drm_scdc_set_high_tmds_clock_ratio() and drm_scdc_set_scrambling()
    to config HDMI sink TMDS.
  - Remove struct video_info from HDMI driver.
  - Remove tmds_char_rate_valid() be called in bridge_mode_valid(),
    community had patch in reviewing to implement the function.
  - Remove warning message print when get unknown HPD cable status.
  - Add more detail comments for HDP plugin and plugout interrupt.
  - use dev_dbg to repleace DRM_INFO when cable HPD status changed.
  - Remove t-b tag as above code change.
- Patch #6
  - fix build error as code rebase to latest kernel version.
- Patch #8:
  - replace lane-mapping with data-lanes
- Link to v17: https://lore.kernel.org/r/cover.1727159906.git.Sandor.yu@nxp.com

Changes in v17:
- Patch #1:
  - Replaces the local mutex mbox_mutex with a global mutex mhdp_mailbox_mutex
- Patch #2:
  - remove hdmi.h
  - add 2024 year to copyright
  - Add r-b tag.
- Patch #3:
  - Add lane-mapping property.
- Patch #4:
  - Reset the HDMI/DP link when an HPD (Hot Plug Detect) event is detected
  - Move the HDMI protocol settings from hdmi_ctrl_init() to a new function
    cdns_hdmi_set_hdmi_mode_type(), to align with the introduced link reset functionality.
  - Implement logic to check the type of HDMI sink.
    If the sink is not a hdmi display, set the default mode to DVI.
  - Implement hdmi_reset_infoframe function
  - Reorder certain bit definitions in the header file to follow a descending order.
  - Add "lane-mapping" property for both HDMI and DP, remove platform data from driver.
    lane-mapping should be setting in dts according different board layout.
  - Remove variable mode in struct cdns_mhdp8501_device, video mode could get from struct drm_crtc_state
  - Remove variable char_rate in  struct cdns_mhdp8501_device, it could get from struct struct drm_connector_state.hdmi
  - Replaces the local mutex mbox_mutex with a global mutex mhdp_mailbox_mutex
  - Remove mutext protect for phy_api access functions.
- Patch #6:
  - Remove mbox_mutex
- Link to v16: https://lore.kernel.org/r/cover.1719903904.git.Sandor.yu@nxp.com

Changes in v16:
- Patch #2:
  - Remove pixel_clk_rate, bpc and color_space fields from struct
    phy_configure_opts_hdmi, they were replaced by
    unsigned long long tmds_char_rate.
  - Remove r-b and a-c tags because this patch have important change.
- Patch #4:
  - Add DRM_BRIDGE_OP_HDMI flags for HDMI driver,
  - Introduce the hdmi info frame helper functions,
    added hdmi_clear_infoframe(), hdmi_write_infoframe() and
    hdmi_tmds_char_rate_valid() according Dmitry's patch
    'make use of the HDMI connector infrastructure' patchset ([2]).
  - mode_fixup() is replaced by atomic_check().
  - Fix video mode 4Kp30 did not work on some displays that support
    LTE_340Mcsc_scramble.
  - updated for tmds_char_rate added in patch #2.
- Patch #6:
  - updated for tmds_char_rate added in patch #2.
- Link to v15: https://lore.kernel.org/r/20240306101625.795732-1-alexander.stein@ew.tq-group.com

Changes in v15:
- Patch #6 + #7:
  -  Merged PHY driver into a single combo PHY driver
- Patch #7 + #8:
  - Add DT patches for a running HDMI setup

Changes in v14:
- Patch #4:
  - Rebase to next-20240219, replace get_edid function by edid_read
    function as commits d807ad80d811b ("drm/bridge: add ->edid_read
    hook and drm_bridge_edid_read()") and 27b8f91c08d99 ("drm/bridge:
    remove ->get_edid callback") had change the API.

Changes in v13:
- Patch #4:
  - Explicitly include linux/platform_device.h for cdns-mhdp8501-core.c
  - Fix build warning
  - Order bit bpc and color_space in descending shit.
- Patch #7:
  - Fix build warning

Changes in v12:
- Patch #1:
  - Move status initialize out of mbox_mutex.
  - Reorder API functions in alphabetical.
  - Add notes for malibox access functions.
  - Add year 2024 to copyright.
- Patch #4:
  - Replace DRM_INFO with dev_info or dev_warn.
  - Replace DRM_ERROR with dev_err.
  - Return ret when cdns_mhdp_dpcd_read failed in function cdns_dp_aux_transferi().
  - Remove unused parmeter in function cdns_dp_get_msa_misc
    and use two separate variables for color space and bpc.
  - Add year 2024 to copyright.
- Patch #6:
  - Return error code to replace -1 for function wait_for_ack().
  - Set cdns_phy->power_up = false in phy_power_down function.
  - Remove "RATE_8_1 = 810000", it is not used in driver.
  - Add year 2024 to copyright.
- Patch #7:
  - Adjust clk disable order.
  - Return error code to replace -1 for function wait_for_ack().
  - Use bool for variable pclk_in.
  - Add year 2024 to copyright.

Changes in v11:
- rewrite cdns_mhdp_set_firmware_active() in mhdp8546 core driver,
  use cdns_mhdp_mailbox_send() to replace cdns_mhdp_mailbox_write()
  same as the other mailbox access functions.
- use static for cdns_mhdp_mailbox_write() and
  cdns_mhdp_mailbox_read() and remove them from EXPORT_SYMBOL_GPL().
- remove MODULE_ALIAS() from mhdp8501 driver.

Changes in v10:
- Create mhdp helper driver to replace macro functions, move all mhdp
  mailbox access functions and common functions into the helper
  driver.  Patch #1:drm: bridge: Cadence: Creat mhdp helper driver it
  is totaly different with v9.

Changes in v9:
- Remove compatible string "cdns,mhdp8501" that had removed
  from dt-bindings file in v8.
- Add Dmitry's R-b tag to patch #2
- Add Krzysztof's R-b tag to patch #3

Changes in v8:
- MHDP8501 HDMI/DP:
  - Correct DT node name to "display-bridge".
  - Remove "cdns,mhdp8501" from mhdp8501 dt-binding doc.

- HDMI/DP PHY:
  - Introduced functions `wait_for_ack` and `wait_for_ack_clear` to handle
    waiting with acknowledgment bits set and cleared respectively.
  - Use FIELD_PRE() to set bitfields for both HDMI and DP PHY.

Changes in v7:
- MHDP8501 HDMI/DP:
  - Combine HDMI and DP driver into one mhdp8501 driver.
    Use the connector type to load the corresponding functions.
  - Remove connector init functions.
  - Add <linux/hdmi.h> in phy_hdmi.h to reuse 'enum hdmi_colorspace'.

- HDMI/DP PHY:
  - Lowercase hex values
  - Fix parameters indent issue on some functions
  - Replace 'udelay' with 'usleep_range'

Changes in v6:
- HDMI/DP bridge driver
  - 8501 is the part number of Cadence MHDP on i.MX8MQ.
    Use MHDP8501 to name hdmi/dp drivers and files.
  - Add compatible "fsl,imx8mq-mhdp8501-dp" for i.MX8MQ DP driver
  - Add compatible "fsl,imx8mq-mhdp8501-hdmi" for i.MX8MQ HDMI driver
  - Combine HDMI and DP dt-bindings into one file cdns,mhdp8501.yaml
  - Fix HDMI scrambling is not enable issue when driver working in 4Kp60
    mode.
  - Add HDMI/DP PHY API mailbox protect.

- HDMI/DP PHY driver:
  - Rename DP and HDMI PHY files and move to folder phy/freescale/
  - Remove properties num_lanes and link_rate from DP PHY driver.
  - Combine HDMI and DP dt-bindings into one file fsl,imx8mq-dp-hdmi-phy.yaml
  - Update compatible string to "fsl,imx8mq-dp-phy".
  - Update compatible string to "fsl,imx8mq-hdmi-phy".

Changes in v5:
- Drop "clk" suffix in clock name.
- Add output port property in the example of hdmi/dp.

Changes in v4:
- dt-bindings:
  - Correct dt-bindings coding style and address review comments.
  - Add apb_clk description.
  - Add output port for HDMI/DP connector
- PHY:
  - Alphabetically sorted in Kconfig and Makefile for DP and HDMI PHY
  - Remove unused registers define from HDMI and DP PHY drivers.
  - More description in phy_hdmi.h.
  - Add apb_clk to HDMI and DP phy driver.
- HDMI/DP:
  - Use get_unaligned_le32() to replace hardcode type conversion
    in HDMI AVI infoframe data fill function.
  - Add mailbox mutex lock in HDMI/DP driver for phy functions
    to reslove race conditions between HDMI/DP and PHY drivers.
  - Add apb_clk to both HDMI and DP driver.
  - Rename some function names and add prefix with "cdns_hdmi/cdns_dp".
  - Remove bpc 12 and 16 optional that not supported.

Changes in v3:
- Address comments for dt-bindings files.
  - Correct dts-bindings file names
    Rename phy-cadence-hdptx-dp.yaml to cdns,mhdp-imx8mq-dp.yaml
    Rename phy-cadence-hdptx-hdmi.yaml to cdns,mhdp-imx8mq-hdmi.yaml
  - Drop redundant words and descriptions.
  - Correct hdmi/dp node name.

Changes in v2:
- Reuse Cadence mailbox access functions from mhdp8546 instead of
  rockchip DP.
- Mailbox access functions be convert to marco functions
  that will be referenced by HDP-TX PHY(HDMI/DP) driver too.
- Plain bridge instead of component driver.
- Standalone Cadence HDP-TX PHY(HDMI/DP) driver.
- Audio driver are removed from the patch set, it will be add in another
  patch set later.

---
Alexander Stein (2):
      arm64: dts: imx8mq: Add DCSS + HDMI/DP display pipeline
      arm64: dts: imx8mq: tqma8mq-mba8mx: Enable HDMI support

Sandor Yu (6):
      soc: cadence: Create helper functions for Cadence MHDP
      drm: bridge: cadence: Update mhdp8546 mailbox access functions
      dt-bindings: phy: Add Freescale iMX8MQ DP and HDMI PHY
      phy: freescale: Add DisplayPort/HDMI Combo-PHY driver for i.MX8MQ
      dt-bindings: display: bridge: Add Cadence MHDP8501
      drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver

 .../bindings/display/bridge/cdns,mhdp8501.yaml     |  136 ++
 .../bindings/phy/fsl,imx8mq-hdptx-phy.yaml         |   52 +
 .../boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts   |   28 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   60 +
 arch/arm64/boot/dts/freescale/mba8mx.dtsi          |    7 +
 drivers/gpu/drm/bridge/cadence/Kconfig             |   17 +
 drivers/gpu/drm/bridge/cadence/Makefile            |    2 +
 .../gpu/drm/bridge/cadence/cdns-mhdp8501-core.c    |  447 +++++++
 .../gpu/drm/bridge/cadence/cdns-mhdp8501-core.h    |  391 ++++++
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-dp.c  |  725 +++++++++++
 .../gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c    |  805 ++++++++++++
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |  504 ++------
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.h    |   49 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c    |  212 +--
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h    |   18 +-
 drivers/phy/freescale/Kconfig                      |   10 +
 drivers/phy/freescale/Makefile                     |    1 +
 drivers/phy/freescale/phy-fsl-imx8mq-hdptx.c       | 1359 ++++++++++++++++++++
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/cadence/Kconfig                        |    9 +
 drivers/soc/cadence/Makefile                       |    3 +
 drivers/soc/cadence/cdns-mhdp-helper.c             |  625 +++++++++
 include/soc/cadence/cdns-mhdp-helper.h             |  143 ++
 24 files changed, 4937 insertions(+), 668 deletions(-)
---
base-commit: e9c9ed45e9870a5c221ff199fff1fb529f3f1691
change-id: 20260406-dcss-hdmi-upstreaming-28998a88e911

Best regards,
-- 
Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
