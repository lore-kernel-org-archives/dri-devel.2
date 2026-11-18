Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7390A606A881
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qFPU1PM9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79F7D10FA1E;
	Wed, 18 Nov 2026 00:37:30 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A6E10FA0D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCGhKowu7BTC6NCszBgqJ130P5M8JrQeGY21oXOVBGxzbHXis4N3sIxmA7Cyc5aUq2CLvV5cHPytx3Eh/h3bG2VqnqTXaZTQV8Z+c313bxKxSL7rJADQTUcwPpPwsx0gMMQGdS70ECBje8iYIThyuKzv8HhJfbeMgskxPwC817pNpIXoLW/uqAZWhEn+qzFfHnBQXz0Gl5tj1j5jqta0eFKymTFPsM5nqlVl8lkI1fMwYtwbtEoWGSyQ46hM8o5qFRRWFnVKbDWf3VIuglWM/esRGGQXw7Qp9c+tmYzvthpE1MXsP77UJDT9Dstb13R5fDxrS1ZZ/MnU4QGQuADljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKyLJg1LBY/j9ckAJ+2IwfM6IFU4eIbBlJ7QNvZOIqo=;
 b=Gydkca0LnboLfY/MJr81pxYR1LchKolZTd+JaxCGXVNnipc46wwIvcjvnMGrwg83YcriWZkXMwG+/Pzj/t/exfQTU/HINjbHX3mqGmp0AvcJp2rzNR65tUwnmuL94K5/wNvy7QLsl/K6zLR4te8XEMV1/1EOPk0AqofvIgld2wLGqYehePyTTKIvUdccOpaWvIjskfLUMgSP7QvX8sd7LOXDQz8d7hArixKZ07mfOYN/FfsuMSmjab3mzVZlLBl27wSQerWYR4t0UolEHSAYoe3PJCgdwMJJG0qHlqtxutMKB/JB9xi1Ecd4yLTfKFCkS48aNoWZPBLO+jpE6ZxD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKyLJg1LBY/j9ckAJ+2IwfM6IFU4eIbBlJ7QNvZOIqo=;
 b=qFPU1PM9xFqoti3wq19rSTe1CtIN8KR5/qXI1c7o+yoBnCyj4RQ3BMC9uQU1WCwxSQu8HmjcqD09eIysa3Oufcs9UkvSKKNJtqh+cgg+TJkrPZvSSMqrmV/1ghrwkeRRg82nCjA8kuJvhEr0qXE6Hfyf2FWdt7RzYHFTUD50Ao37iThaGeix6QTbY7S17Crb3V5Dsa1+KXFodtZz9uYuEW5dcy0vVk28Vj8uvJrxPNAR6lBL5j5oR77RpEtSMI+qG3NydoM84Z4oyzAlEcbZvWy3yvht9dr9oQLLMEwyVexoas2LK3CaMR30L3vSvPcwxcXuP2XrOHdAaEK+H5RoAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 00:36:54 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:54 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 18 Nov 2026 09:35:21 +0900
Subject: [PATCH v4 12/12] iommu/tegra-smmu: Use a DMA API default domain
 per swgroup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-b4-arm32-iommu-dma-cookie-v4-12-0c5561288e22@nvidia.com>
References: <20261118-b4-arm32-iommu-dma-cookie-v4-0-0c5561288e22@nvidia.com>
In-Reply-To: <20261118-b4-arm32-iommu-dma-cookie-v4-0-0c5561288e22@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Krishna Reddy <vdumpa@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Yong Wu <yong.wu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCPR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 047ba444-38ae-43cd-eca1-08df450c0b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|18002099003|22082099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: qHa9oYvXeMuArpP8dxOfgvFVuTk7IXoYlkd7Ke9srkWZ/QMcurzHZehoLuG4ML+eQs/24O+DIwMs+KWpJ756deKzRc39SykLx4ecAVgc4L5X7x0xKo0o7WzOlLzIul2jCMQnjs2iEPJ+m583NdMqrEpJEwobS/eJTp89VPUFyiPiM4/44RuMqU/FVCuk9IKQ5tSezxmxuW31X0xkp7KkYRkORcuiAW1sWaA1VzdYoJUdRKoPQH6mnb8QX/U3jHbFLRzlwlcTNQl38aGGsdRmjevDcJlRLCU4nquCmOzOvR/BmhuWWhcJCHMgLIvKCeGJw161Jen2CKHuREFzR3jLtRy2huLjTu/GQbHQ26pOSjFOlDC2vQdhY1U5HlAi3Dyd+1rficZCzblx29MZlsXhuMSJ5mq8ibab6euyHKjQZ07YSNYp9rBpOD8iFg0Bcup4d/9F8I8bZNmcUC3RrNwi+UhygGyLZgUqalltVzogxRivh52VN3zsk+fLa7VjCNrptunD+TCGora4zZlu89DXklR1tC7mpVDQYXOdzBrsD/h8ZoGgIxZC+nDdNLMK/5ZraC8Z/KZHdKONo/ds5S1L1Yk7y1O+AXjBPAmniLZ09XSR5ZZ8mP2Q8+7xMiXvUvSR78384D5RxcjHTlZ+uRganVP1p+xcCuUXqcaN1ILseNJQ30Y4oV+VSYm6WRfpw9LwUQFh/w9qtuKC/avqDoeC4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(18002099003)(22082099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFp5TkQ0ZjY5V2tuTmJuRHdPUXI4ZjFxWjdNYzNCL3BFczFyNGtYMU5GTHov?=
 =?utf-8?B?b0k1Q1Jud2ZLMlZkVFZKekJMelB1bkVmcG8rZDJEV1dBS2hneHhkdEl6cXpT?=
 =?utf-8?B?UVFsNXVwTytySGUyb2dSbkp6empTY3VQSGhKMHVIeUhrUnIrK3QrUTQxelVO?=
 =?utf-8?B?YWtXOHhoNWFpTENGRUZDSzVWSzU1VmloVXBXamZBMW9KYlV1aVdGY3diUkU1?=
 =?utf-8?B?cDJpVGtMZnYzSi9Dd283T1FscGl4VkNYbURacmVUNzdVYnhIQ25HcXFreWRK?=
 =?utf-8?B?d0VHTlBLRmxERS9Na001b2xjd2NJc1dHODVHaGpGVWFIc2Yxb0htZG9vTU1X?=
 =?utf-8?B?bzlENUFISUpiQlYxZUVBZzBVVjhmUFhvaUdXdFFXZ2ZXRGs0bmZtSTFpQ2NP?=
 =?utf-8?B?dVAwSW1CK2VsRjlmYVpUMzBuYXF2UCtpMUI3M0hxS0IybDNpVGNlWGk1MGQ5?=
 =?utf-8?B?UzV3N3MwRU1IQkR6c1Z2dlJZWlpzZ2FzQml1T2RjMG40cVU2U2hFWEUwbFFO?=
 =?utf-8?B?bG1QNGE3NXNWeGY1R3dxRmdVcXA2R2tYa3IyWEcwQkcreG1aU2VxbGJJS1hw?=
 =?utf-8?B?cU9qSjNvZ0ZHRkZwRnpsTjlzMittdWZJcVlvZlU1Vk10STBVT0RBRXNqZzF4?=
 =?utf-8?B?aHY0bHFqOXVQa2EvVzZ1Zm1DV29QcTJzam9KemNyRmx2RlZBbHFyQklOSU5o?=
 =?utf-8?B?WlpMWU9DdjlzcnVvVks5YXFKbklYNHJWNEhCY0lVQVVVMEpYNzRia1V6bkEx?=
 =?utf-8?B?SG1EamNBQkFDU1ZLclJFNVhsMFo2cG1DdEVpMmRMY0Q0bDArL2Zya0VzNWkw?=
 =?utf-8?B?MDBaWDJRU3JpR0h1Ui9sS1JUdExBMUdWd0t0YjdFSVBNaVFKSkE3M1h0TFZX?=
 =?utf-8?B?bURJTGtOR1lpN2JSSmY2YkJiYW9aZG13akxpMU0yQ2QyQzNubTBKM1Jna1l3?=
 =?utf-8?B?VWxGM1FFQXNQVTFRbHZxRnE5OXZncHFuV1dBcnBhU05nYzZGTXkvSzRhMHp0?=
 =?utf-8?B?QkF0MCt0ZnpTOTJCa2xheG5PUHpNeTdxUSs1UzRSL1pMUE14Y09xejlza1BW?=
 =?utf-8?B?L3RRc0greEhqUElXV1VJd1F6VXh3TFl3YTAvZGZpd2RQMVd6Z3dqS3dOdURG?=
 =?utf-8?B?UHRtMnE0UHk2NUVQT3hwUksyNlNKN1cvU1Q4b2dJRTlPZEozcEc4UFl0OGFV?=
 =?utf-8?B?Rld2TFRtcHBCV3pZNEZDOGVTUGJlOEZCRCtVR3dMY3F3TVl0cDVXNEdCN3Uz?=
 =?utf-8?B?VzlOZzJUZSt6T1JyQlVJZ0VYT25DbkhuK0NqRVJCL2dIdi9FcjROZjA2TnFY?=
 =?utf-8?B?bEtuM1h0K0o2eEgxUWE1RW54WjNTM0luVStvM3FncTZ2QS9zNlN0OXphMFlY?=
 =?utf-8?B?cVJWeWM4eXpYTjNlcXBrdDdQL21GSVJYQjRSMVBmQTl6QWFHRFFwVGVKNmNQ?=
 =?utf-8?B?ampJTFNCQ3ZPQzRkUVliUmtncTVhRzUzYldoa21iMXpudHRYd2J4Nk14RDNZ?=
 =?utf-8?B?Znc3VkJubkZWMkYxVEFMUG1kdjlpaEIra2t3Ry9MOTdrbHlUY0o4WmZMNStD?=
 =?utf-8?B?dTRseGlpRWNyRnNuZUN0VlF5aW5mb0NRNGx0YUt0WG9TTnk2MVdra0NhdVR1?=
 =?utf-8?B?dHJJaGxNaHBHa2hYUExtNDZ4R2tGd0JVZ0ZOS3BJNTdXcGFTNTd5alF6UWIr?=
 =?utf-8?B?TjZ2c0lkVGdqbEZBNkN0UzlmYWNuV2o5eDhEZ0t1Y2k3NGcvMGtSRXJiZ0J4?=
 =?utf-8?B?MUdkSk5BdDAzRWg2dDZ0eGhUVDllZHNOZXNTN0NPKzRCVTEzWFZFOEI4TUpC?=
 =?utf-8?B?aDlQbG41YXVqdVdockExWXJ3b3grNmQwTzFsVjdld3lrTE9aYXcxc2h3alF1?=
 =?utf-8?B?WWs1UEtySzd2Wm9nZTB0Q0tZN2VscEgvMjA5U0lWZFRnUG9ZTkxUZmM5U3Y1?=
 =?utf-8?B?elFLUHJPZEN3K0JuQnFvME1tM0d0aktoT0ZmVlExVHlzbFpOa3g2RXhrc2U4?=
 =?utf-8?B?OXlaYXA2K2pJVmJ4SHIrcVM2RjV6OTFQWnVMNzR5bmwwOWxJRjJvOWF6OS9w?=
 =?utf-8?B?UHlkenZHL2x4YU9XT1NQY3Yyc2R3MHdYdzRYMGpSWERwK0NrSHUzckg5bXlT?=
 =?utf-8?B?UE0wcUROZ0gxK2xiRkJyRkE4Mi9Wd3VsaWJIN28ya2pQcFgyYnIvRlhiakoz?=
 =?utf-8?B?OTlhUTR3Q2hUZlZYUE1DOWVDZHJIVVR4cmIxQnN2cWdleUt4ZmswajVjamI0?=
 =?utf-8?B?aERFR24zVXNUY09vK2FLTjkxR2ZFLzlUMVFreXNkMUZmYzRiY0hEMS9LYmJE?=
 =?utf-8?B?T0grVE1GWHNhZTVzSXpsMU90UG9yMU9mR1lqbDZmWXAyMFJHMzlzWnBsVWpt?=
 =?utf-8?Q?GSlKATuvs9eOpzosCm9unJiuBpcfvbhAjQrI+Ngm5TC3Z?=
X-MS-Exchange-AntiSpam-MessageData-1: emFJJw0OiM+Sfg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047ba444-38ae-43cd-eca1-08df450c0b30
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:54.2039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pu6W6X3b98bTyKZjWl/EdQYUB41Z8N8JybmFUldXp4aYH204Zv8f80UYicdfrhGiEM+Zt3rcTChkJPxHjSCzzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Everything is now in place for the Tegra SMMU to give devices a real
IOMMU_DOMAIN_DMA default domain.

Some device drivers still rely on explicit domains (and being able to
detach a legacy ARM DMA domain if any), so DMA default domains are
enabled on a per-swgroup basis via a use_dma_api flag. As drivers are
converted to DMA API usage we can eventually get rid of this. Initially
the flag is enabled for TegraDRM and Host1x devices.

On multi_v7_defconfig (where CONFIG_ARM_DMA_USE_IOMMU was always
enabled), this will fix TegraDRM probing with certain probe orderings
where the legacy implementation's lack of support for multiple devices
in one IOMMU group would cause breakage.

On tegra_defconfig, as this now enables CONFIG_ARM_DMA_USE_IOMMU, all
devices move to either the legacy ARM DMA path or the new one. This
should in principle not cause issues as the drivers would already have
been verified on multi_v7_defconfig.

Also set .release_domain to the identity domain to ensure the AS is
released appropriately now that the domain can be non-static.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/iommu/Kconfig           |  1 +
 drivers/iommu/tegra-smmu.c      | 52 ++++++++++++++++++++++++++++++++++++-----
 drivers/memory/tegra/tegra114.c | 13 +++++++----
 drivers/memory/tegra/tegra124.c | 10 ++++----
 drivers/memory/tegra/tegra30.c  | 16 ++++++++-----
 include/soc/tegra/mc.h          |  7 ++++++
 6 files changed, 78 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 85a8d7fdfa30..e3515feecaa2 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -253,6 +253,7 @@ config TEGRA_IOMMU_SMMU
 	depends on TEGRA_AHB
 	depends on TEGRA_MC
 	select IOMMU_API
+	select ARM_DMA_USE_IOMMU if ARM
 	help
 	  This driver supports the IOMMU hardware (SMMU) found on NVIDIA Tegra
 	  SoCs (Tegra30 up to Tegra210).
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0e8414d8a504..3f938ae4cffc 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -997,16 +997,20 @@ static int tegra_smmu_of_xlate(struct device *dev,
 
 static int tegra_smmu_def_domain_type(struct device *dev)
 {
-	/*
-	 * FIXME: For now we want to run all translation in IDENTITY mode, due
-	 * to some device quirks. Better would be to just quirk the troubled
-	 * devices.
-	 */
-	return IOMMU_DOMAIN_IDENTITY;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
+	const struct tegra_smmu_swgroup *swgroup;
+
+	swgroup = tegra_smmu_find_swgroup(smmu, fwspec->ids[0]);
+	if (WARN_ON(!swgroup) || !swgroup->use_dma_api)
+		return IOMMU_DOMAIN_IDENTITY;
+
+	return IOMMU_DOMAIN_DMA;
 }
 
 static const struct iommu_ops tegra_smmu_ops = {
 	.identity_domain = &tegra_smmu_identity_domain,
+	.release_domain = &tegra_smmu_identity_domain,
 	.def_domain_type = &tegra_smmu_def_domain_type,
 	.domain_alloc_paging = tegra_smmu_domain_alloc_paging,
 	.probe_device = tegra_smmu_probe_device,
@@ -1111,6 +1115,40 @@ static void tegra_smmu_debugfs_exit(struct tegra_smmu *smmu)
 	debugfs_remove_recursive(smmu->debugfs);
 }
 
+/*
+ * The default domain type is a property of the IOMMU group, so all swgroups in
+ * one group must agree on use_dma_api. Otherwise the core sees conflicting
+ * def_domain_type and falls back to identity for the whole group.
+ */
+static void tegra_smmu_check_groups(struct tegra_smmu *smmu)
+{
+	const struct tegra_smmu_soc *soc = smmu->soc;
+	unsigned int i, j;
+
+	for (i = 0; i < soc->num_groups; i++) {
+		const struct tegra_smmu_group_soc *group = &soc->groups[i];
+		int dma_api = -1;
+
+		for (j = 0; j < group->num_swgroups; j++) {
+			const struct tegra_smmu_swgroup *swgrp;
+
+			swgrp = tegra_smmu_find_swgroup(smmu,
+							group->swgroups[j]);
+			if (!swgrp)
+				continue;
+
+			if (dma_api < 0)
+				dma_api = swgrp->use_dma_api;
+			else if (swgrp->use_dma_api != !!dma_api)
+				break;
+		}
+
+		WARN(j < group->num_swgroups,
+		     "SMMU group %s mixes DMA API and identity swgroups\n",
+		     group->name);
+	}
+}
+
 struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 				    const struct tegra_smmu_soc *soc,
 				    struct tegra_mc *mc)
@@ -1145,6 +1183,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	smmu->dev = dev;
 	smmu->mc = mc;
 
+	tegra_smmu_check_groups(smmu);
+
 	smmu->pfn_mask =
 		BIT_MASK(mc->soc->num_address_bits - SMMU_PTE_SHIFT) - 1;
 	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 2883c4f91144..024c63bdd480 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -1029,15 +1029,18 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 
 static const struct tegra_smmu_swgroup tegra114_swgroups[] = {
 	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240,
-	  .defer_enable = true },
+	  .defer_enable = true, .use_dma_api = true },
 	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244,
-	  .defer_enable = true },
+	  .defer_enable = true, .use_dma_api = true },
 	{ .name = "epp",       .swgroup = TEGRA_SWGROUP_EPP,       .reg = 0x248 },
-	{ .name = "g2",        .swgroup = TEGRA_SWGROUP_G2,        .reg = 0x24c },
+	{ .name = "g2",        .swgroup = TEGRA_SWGROUP_G2,        .reg = 0x24c,
+	  .use_dma_api = true },
 	{ .name = "avpc",      .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
-	{ .name = "nv",        .swgroup = TEGRA_SWGROUP_NV,        .reg = 0x268 },
+	{ .name = "nv",        .swgroup = TEGRA_SWGROUP_NV,        .reg = 0x268,
+	  .use_dma_api = true },
 	{ .name = "hda",       .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
-	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250 },
+	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250,
+	  .use_dma_api = true },
 	{ .name = "msenc",     .swgroup = TEGRA_SWGROUP_MSENC,     .reg = 0x264 },
 	{ .name = "ppcs",      .swgroup = TEGRA_SWGROUP_PPCS,      .reg = 0x270 },
 	{ .name = "vde",       .swgroup = TEGRA_SWGROUP_VDE,       .reg = 0x27c },
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index a38fbf2baf6c..17068aaf163f 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1071,13 +1071,14 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 
 static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
 	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240,
-	  .defer_enable = true },
+	  .defer_enable = true, .use_dma_api = true },
 	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244,
-	  .defer_enable = true },
+	  .defer_enable = true, .use_dma_api = true },
 	{ .name = "afi",       .swgroup = TEGRA_SWGROUP_AFI,       .reg = 0x238 },
 	{ .name = "avpc",      .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
 	{ .name = "hda",       .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
-	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250 },
+	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250,
+	  .use_dma_api = true },
 	{ .name = "msenc",     .swgroup = TEGRA_SWGROUP_MSENC,     .reg = 0x264 },
 	{ .name = "ppcs",      .swgroup = TEGRA_SWGROUP_PPCS,      .reg = 0x270 },
 	{ .name = "sata",      .swgroup = TEGRA_SWGROUP_SATA,      .reg = 0x274 },
@@ -1093,7 +1094,8 @@ static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
 	{ .name = "sdmmc2a",   .swgroup = TEGRA_SWGROUP_SDMMC2A,   .reg = 0xa98 },
 	{ .name = "sdmmc3a",   .swgroup = TEGRA_SWGROUP_SDMMC3A,   .reg = 0xa9c },
 	{ .name = "sdmmc4a",   .swgroup = TEGRA_SWGROUP_SDMMC4A,   .reg = 0xaa0 },
-	{ .name = "vic",       .swgroup = TEGRA_SWGROUP_VIC,       .reg = 0x284 },
+	{ .name = "vic",       .swgroup = TEGRA_SWGROUP_VIC,       .reg = 0x284,
+	  .use_dma_api = true },
 	{ .name = "vi",        .swgroup = TEGRA_SWGROUP_VI,        .reg = 0x280 },
 };
 
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 0ee4715413ba..df6b5a499ccc 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -1140,19 +1140,23 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 
 static const struct tegra_smmu_swgroup tegra30_swgroups[] = {
 	{ .name = "dc",   .swgroup = TEGRA_SWGROUP_DC,   .reg = 0x240,
-	  .defer_enable = true },
+	  .defer_enable = true, .use_dma_api = true },
 	{ .name = "dcb",  .swgroup = TEGRA_SWGROUP_DCB,  .reg = 0x244,
-	  .defer_enable = true },
+	  .defer_enable = true, .use_dma_api = true },
 	{ .name = "epp",  .swgroup = TEGRA_SWGROUP_EPP,  .reg = 0x248 },
-	{ .name = "g2",   .swgroup = TEGRA_SWGROUP_G2,   .reg = 0x24c },
+	{ .name = "g2",   .swgroup = TEGRA_SWGROUP_G2,   .reg = 0x24c,
+	  .use_dma_api = true },
 	{ .name = "mpe",  .swgroup = TEGRA_SWGROUP_MPE,  .reg = 0x264 },
 	{ .name = "vi",   .swgroup = TEGRA_SWGROUP_VI,   .reg = 0x280 },
 	{ .name = "afi",  .swgroup = TEGRA_SWGROUP_AFI,  .reg = 0x238 },
 	{ .name = "avpc", .swgroup = TEGRA_SWGROUP_AVPC, .reg = 0x23c },
-	{ .name = "nv",   .swgroup = TEGRA_SWGROUP_NV,   .reg = 0x268 },
-	{ .name = "nv2",  .swgroup = TEGRA_SWGROUP_NV2,  .reg = 0x26c },
+	{ .name = "nv",   .swgroup = TEGRA_SWGROUP_NV,   .reg = 0x268,
+	  .use_dma_api = true },
+	{ .name = "nv2",  .swgroup = TEGRA_SWGROUP_NV2,  .reg = 0x26c,
+	  .use_dma_api = true },
 	{ .name = "hda",  .swgroup = TEGRA_SWGROUP_HDA,  .reg = 0x254 },
-	{ .name = "hc",   .swgroup = TEGRA_SWGROUP_HC,   .reg = 0x250 },
+	{ .name = "hc",   .swgroup = TEGRA_SWGROUP_HC,   .reg = 0x250,
+	  .use_dma_api = true },
 	{ .name = "ppcs", .swgroup = TEGRA_SWGROUP_PPCS, .reg = 0x270 },
 	{ .name = "sata", .swgroup = TEGRA_SWGROUP_SATA, .reg = 0x278 },
 	{ .name = "vde",  .swgroup = TEGRA_SWGROUP_VDE,  .reg = 0x27c },
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index ea67972fd585..1cbd990fc0f4 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -78,6 +78,13 @@ struct tegra_smmu_swgroup {
 	 * tegra_smmu_enable_translation().
 	 */
 	bool defer_enable;
+
+	/*
+	 * Set once the clients behind this swgroup are known to work with an
+	 * IOMMU_DOMAIN_DMA default domain. All swgroups of a
+	 * tegra_smmu_group_soc must agree.
+	 */
+	bool use_dma_api;
 };
 
 struct tegra_smmu_group_soc {

-- 
2.56.1

