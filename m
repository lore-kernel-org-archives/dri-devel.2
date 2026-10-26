Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86615606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SUD5WEnI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B6910ED0B;
	Mon, 26 Oct 2026 09:21:32 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789F510ED0B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KglWRcz1m1aNzSS2AT9MNwR7VKIYai2vU4+c5tsTusYpTwKhKkt0NoVKDKQm+zSJZmfOgmOgudTdWsuX3n85ID0oUqRGXvvJ8veUdoW3QpaMAGDy8bxj5KISA/WW43gweOKnRxbh+iMSpeebykzf27plfiRMQc/OVtHbgIXHNzbNqmW3p/oF/fOUwSMM1X+HSODRggHEh7JMZrlRpsd9d6Ibcn5H/hEP5PjECDGDsuzaxRISwFMOU4M7HCPFVCRsDRJz4sDkgXqEJky3y4m6q/MakxTMGfKyxEaAZzYvNdzgUWbCZGj/JiIi6r+8vnGl+gawcn35ymHpdohhf6aSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BVlh+I32yeq8Ur3F2KQwgnGCgbIOI4eMVj/+r/KyuQ=;
 b=fNBdudffrjSLYb5MrCdqzVI11rFRmOkJM0nP2Hw8sIWEIanC5wFMD2wxEQOM7GRntnpRN2C0xJPPR93OVUO3g0CgKOFUhpgCOOUOkqGdK7nOrRnUsN2wrkSQDeQI96VmMyviKp1pqZ3+CEoU2G5nnDHgBeIo303iaeKtH+5rvVvRqqURunGtyhRDJAkItGSACeSeQycLA1ub5QoHXy0hPc6wsoXkwK6CIw5dYy8oajdn5aTDiO5HyGAonI6n9XVZ6NxgpDxvrpBqpL5gsLOFovY1EXjaBcDXYpCtvjFFr5UFsHmiZ0vycE6bPPajONh4GW8jBwDRSaKZPf2jYZHsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BVlh+I32yeq8Ur3F2KQwgnGCgbIOI4eMVj/+r/KyuQ=;
 b=SUD5WEnIw/2my5l6cwE1p5hGtaTcCLWvwsAE5yFLdgiLZawLSwUNw5IzSGHF4e6esB6GyYL3TRQuq11E0HnxS95YasWmLdLF0jI4+c2CmDVT4lVndQyDMGvXT6X/B9Lzq68glJpeExKRyhavYIm9qMgzY3qY7lDpOoRtn9CQgpGoWP+d6eaG3t6GBgrQhNLlbSzPmYhmbIJGcj37ONyNIAmmeqQHgoQRi8RIk1c8yeb3PFSDOBgEvmXDoNEYqbwhpCg0fpInc/GkJdLdzjlvd6OejWxebScQ8lPcNpjVQC4Ucx2mKyD5aPWdQ1MNj6jduIZe2OsV/va2RJdJKx+Saw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:21:14 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:21:14 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 26 Oct 2026 18:19:35 +0900
Subject: [PATCH v3 10/10] iommu/tegra-smmu: Use a DMA API default domain
 per swgroup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-arm32-iommu-dma-cookie-v3-10-3901d74b1ff2@nvidia.com>
References: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
In-Reply-To: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:405:370::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc0aa2d-dc60-4bf4-7e8f-08df33427b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|18002099003|22082099003|921020|56012099006|11063799006|261022075727099003|261021123027099003|10067099003|261009223027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: tmzaf0hNY40t8RLyZr7DLCowecLRt9Bq3tvDt9yHsEo5KkNv926rfpLAS3i910sqxF2JszRzdZlVSt5YmIsnHaN1+OcxZVeNIyL4Oo2dirWu+CI4pdGUgLaT0ZFiy4lfUemsvnAb/ArcJ4pEJFNaJQf8KhIsfX21MhEB87uQ0jrKt3LL6qcPktYx/WiVVisyV9M0kT3DL+rrZIMmKYlpHNRCAheZdNpHpooRLW49WfQql/NRHnXpyrELwMngyksWow1NqXZSHdPMEzhEXWfS8FXpv8gX9bb2G/tL5N2IxTI9LdxgKgWyvVubvyV281ho8PIOFoM7tZjl/l6Jy/ZmDTEVILHpQr44iWbg6Z2vIrX/gNrNDcz7T1xxIa+lSrqPK+iklWw34+U506ykQSTh0JCrtA0xpjNVimvJWc+EN75cFlHOYTW099TJtPkC9vFuOVUnaF36e7tX8WJyABDrtlOCoixCWWYvfav87yMiJ7ULyDJ9mcps1CrayhJE3XZugdca8GSrOxvqx8R5lEGObCRbTrIk57z/5z/ES6FkAA1/7LuuMk73DriQMH9smSHpwJ2TT14IzCq1T7TUKtdvuSHGlAvoEV3M2zTJ3UZ6NL/0AamKbPWlGqDEAXw+A0I/h9CtXQwFTDakTO8AbJ9kNx3ENQCNT8L/xkxrv7R7S/i93eB4BoJ7Ar+INq+ROyA3QEwTnETMJ9P4QED7QhmIPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261022075727099003)(261021123027099003)(10067099003)(261009223027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2FHR3hrUFRJSVJGbFFQd0Jib2dnVXU3VzNIWEJjckk0dmN4NXhVY0h6WXlI?=
 =?utf-8?B?VythazVkZFlvNlUrT2ptcjZpOFkzWkxkVXRJMmlPQWdnYlowZElyVUZpWWpM?=
 =?utf-8?B?cHFzRUkwcURzNFVxL0VIdVhIRTNma21tMHczeU5pMmwvSnhaY2RmQlhmMDRm?=
 =?utf-8?B?by9iZFJqZ0JCcU00YVI4ZmJna1BlanE0Z2htRnY3d3ZDamNQbk5Lc1ErODRC?=
 =?utf-8?B?S1dGZ1lDVGY1Rk4vaktZZHJmbVBsaWdCUGlXZXNBMnByeFVueHJkcjB5Rmxu?=
 =?utf-8?B?U2l3MEpqeVU0OVh1aU9RdlZlcTlCWXc1d0Y4aTRKZTlqVis4b1lsY0VkdEpF?=
 =?utf-8?B?b2g3OTd3aFNwZkpZYi9PRFFkTGVuZ1QxeVZ1YUZhK0Nnc2ZmMEtWc2Flbk9Q?=
 =?utf-8?B?YmFvczNyam1hZGUxaFlCVDVselNlTi9lMUc3OEI3WjdwZWxCRmEzRG5IaXV1?=
 =?utf-8?B?V2pZR3paYlMvbjBvdzYrc0JLZjdGQmw0ZmJ6cjB2NStJTkx1YkxsOXRUS1ZL?=
 =?utf-8?B?UzZCcmJMZ0U3Mmlvb1U1b29QVHlTTHdKc1FzejgwMlRMSVVlcmJUdXNNZ3FM?=
 =?utf-8?B?R2J3UklXNFlJWEpncDB0L1pXdWlvaHF6bzNMVnNOMWs4aUxqLy9McXJkRzAw?=
 =?utf-8?B?dEJYbk1xL0libG44M0J3U0w2ekNJS0dGTVJwcnlXcUdCbEVFOCthYTFvSFk5?=
 =?utf-8?B?UWlYRlRXdk9YUDBVR21pQ2dGdzRUOXV2eVdzVHY5UFFRcWxwZXMxVjNNNDlI?=
 =?utf-8?B?R1NSbmpnREZ6SzZId0pvNnh1OWFDMjN1eHJrSkNoZVBRY0VwYmx3RTltOWVB?=
 =?utf-8?B?MEF5ZUNwbUZscng2V0x3Zk5lZCtRRG1vWjg2OVQ0WGhhOUJyaHM4djFBZ2JS?=
 =?utf-8?B?T3dHUERwellUWkV1UGF1Z2c1NmorWDBjWlBzTm1RaFNkSU02d0c0ZFlvYkNa?=
 =?utf-8?B?SWpFd3hId29ONHRZNW80OUdNbUpzSmxDME11cFFXLy8vWmt4MXdoL0k1OGF5?=
 =?utf-8?B?azFUTTZ4UFlianhFb3l4UnBoRklIbHlUd3lvaDd6dTZDeWoyQjdUL05RcGtW?=
 =?utf-8?B?YVhaanRweGk4WmlQOXphUjZ0YzcwakpOSGY4cHVCckU5UWhnRmRSc3AremRF?=
 =?utf-8?B?WGNHU1FOMlZrSHZtTUZuckFaQkgwYlZZWmdNMitLbG1yN3VmNU95V0IzajRD?=
 =?utf-8?B?V0x5aE9UbmRVSUFCRjNZblVTbVhLaEJ3VUlvTzJCQzdQMjFMeWhrdElUbmZR?=
 =?utf-8?B?Qmp0aTQzT2xtOG9rUnNoOFRCdkVlNUt3TGtmSGlZVENPTkdvY1pwTTdwaG8z?=
 =?utf-8?B?dW5vZ1dvK25zMDhsZEJJL2M3VU5BQ0ZUYTh3NVpUYWhXNng1Um9hRUYrRWJj?=
 =?utf-8?B?MDNVS09lN3pxRGF1WU9XaFg0emV6ZHVQb2hCS0kyQjlYRWdYNnc1LzhWN3R6?=
 =?utf-8?B?K05MaWVVeFZvd1BlZkN0aER5ZnlJRnJYZTF1Vk1nS2dIYnEzNTRyOEFoNGFQ?=
 =?utf-8?B?elgxdUxPT0J1Tk9TR3lsZUtTZzRGYklrSTBZLzVwVU93SExIMGFWNmVEVE5O?=
 =?utf-8?B?SUFudGdvMVVSdnVYeGc1RHRVbzB5OVgybVlKMG5abTY4LzRRVi9TZGZOc2h0?=
 =?utf-8?B?cW9BZDI3Y3dRRzB5NXVyakhDWE9oOE5tUzF2aEp1STBKQmd4RDNLSVZlcEpM?=
 =?utf-8?B?STc5RGxpNkdkK0RIMms1NU5heG80MExwSDV0SXRzMml4UkdFWmNlUk1oYTJs?=
 =?utf-8?B?a250bEgzMEJrOHNwQjhPT0lpSFV4RFRFRVZlRG5RdG8xSEpQSzc4RXlwRUIy?=
 =?utf-8?B?QUxNWUxPZ3BRM24rbHlQSTNPU1lKbm9KcXJmY0FTNSt5T2U2Nktsb0NKUk5N?=
 =?utf-8?B?N3hyQlJxek0xcVVYZ0NHNmRiRkJMRzkrYXBYYmhhbDFsN3hYMnF0SzV6WkFS?=
 =?utf-8?B?NnZRUXdEcmZieS9ZSTVsWkJqZi9vRlRRRXY1MkFpYmNUcHoyK3RwQ3E3Nk5G?=
 =?utf-8?B?cEEyTlJrK2xseStRM0YwVTZ0WE9nUVRCZTgvN1doSEljbmRvaHdHN1NDRXp5?=
 =?utf-8?B?ZUdZRUo2RGVET01SUEYwMEtBT0xPUEt3KzNRR2NGaEF6cW9WbEFERWNnRmZh?=
 =?utf-8?B?TlluaXlPa0wwTGVPalR0Y2JiSCt4bUlpQ0xxdERqMms1MGtJMjZ4cm1RbDJ4?=
 =?utf-8?B?S2VHU0M5WHVHOEo2cE1iQU9kc0hiNFR5QWkxYW9RUFc1VUFCUHh2a1Boemp6?=
 =?utf-8?B?aU53TEU1eE90dzhMSjQxMXJCSzRIdVQzS2VhakI2aG9selJDSEdwMFRDbEZE?=
 =?utf-8?B?UVgzZ1Y2QmxyVmpUVXJjaFNJTElVQ1dqSHhIRk9ZOS9QYmNiY1RPbTZJeDBM?=
 =?utf-8?Q?YiZ/wGqjybquZXTYxbSV93dGR/7xUJQDHWLGeBa0D0S/R?=
X-MS-Exchange-AntiSpam-MessageData-1: /Hvi9G87JQBvkQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc0aa2d-dc60-4bf4-7e8f-08df33427b64
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:21:14.2181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cB4Veok2yigsuXr47AnBR2cBM8gAJW2WzfRijj4HKv90/1x1XISSqDXHRU2u5tYEvPn2lEMeraKMIdU0iVz/nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
index 6e07bd69467a..817e84e0e6ab 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -252,6 +252,7 @@ config TEGRA_IOMMU_SMMU
 	depends on TEGRA_AHB
 	depends on TEGRA_MC
 	select IOMMU_API
+	select ARM_DMA_USE_IOMMU if ARM
 	help
 	  This driver supports the IOMMU hardware (SMMU) found on NVIDIA Tegra
 	  SoCs (Tegra30 up to Tegra210).
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 6779528a9e7c..73c6151db8f8 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -994,16 +994,20 @@ static int tegra_smmu_of_xlate(struct device *dev,
 
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
@@ -1108,6 +1112,40 @@ static void tegra_smmu_debugfs_exit(struct tegra_smmu *smmu)
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
@@ -1142,6 +1180,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
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
2.55.0

