Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB592C88E72
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CAD10F861;
	Tue, 15 Sep 2026 02:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lzMZGQMo";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C45110F863
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9TTCguAQ0jiMPINa+xgtCP1kCwuXToJogb6WWkNXKwn2VXmVmRaLrSNjwchxXxcXmOqe6RBptbaAcMZBiUfDbI1nvbSc8T/Z4d0QEi17AKMc3BfDxwpmSiNw6IEPUGpfXZxLHHW7qzaxg9wg3XIH1PNoNy1i7skQJntEhEpUjlOu8FXSWqTTFZ/XR5hb+W12kJwpoPWX/Q1jaf1BoRFZg5r37djrj4B1Ex8xih5a19rlMn9uk/c+6a1uvqi4k/Lx0G+icqD60bWmJCf05KXVYuRPyVGohKsTwkC7qUGTr0B2WZPv0+6Aa6QkYlLCdroyD3oUwQQ+dSFEKLJwmchyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1abI+a9JXXG3v5c8epAFkWiVeHszOdATa1fKZ7qoz0=;
 b=caS5B3pLapjIff9jFLVo1PSiULILQ0XG6gf1JIW+xQixZe5NI75FnGdAbY4rg6tcsHvg0gLj35WNoNdodL6ByMBG2+TmulDM9LhIcVMXnHFGYFrToz7nihNXqTT6MhwdY7biALBNbv8huGUXS5Kl/45Zun7uj/P8xvVMMDJ5D8JM2oIZVHPJx42f85eFxD5Xn5E5LJMa7NtJXpVRqn/uiAa5bxQJGQdnVYnJFpcU2zlv1uPFLHiXchEqw5NI8K82glqUu6poP6G2Ko909EPZ2gr/MX8y0veQ7cbSWDoKem1zHWXiiY4MKklJByPEtVsIRwvFqTgfiKcRrTqMIfP6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1abI+a9JXXG3v5c8epAFkWiVeHszOdATa1fKZ7qoz0=;
 b=lzMZGQMoL1u+s6SVgX6CG/XyxwEwBuYvm+7QTov1fEq125nRk2WnG+mtp20U/CvjQAl1hOn3otyG2C52eNajSVGrWVG/GE6nK/ouqD35zAee70DbPlU7xqViMGOGObFe9n3QUgmrC5ivS9Ep9kj3c9NAN5BYNh3ppnYCs03KHORTXp0e4L+AqkbAKtYDxQzuwDGE8tG0Q4riewMNBXU9ZcXew48I3hcviOfLle6LGuL+/NEu2xwKdT7aSbuwf3uBRreoB5q3HRn8xZClySP8K/Ek3d7tARODIJe8yBazKBhF7dJh2vZPISNKbsG/ENA8V23WeUjWQUnPaTCa7SP6fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:15:53 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:15:53 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 15 Sep 2026 11:14:59 +0900
Subject: [PATCH 04/11] ARM: dma-mapping: Implement and expose DMA setup
 functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-arm32-iommu-dma-cookie-v1-4-ba4f9d33a2b8@nvidia.com>
References: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
In-Reply-To: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
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
X-ClientProxiedBy: PUVP216CA0008.KORP216.PROD.OUTLOOK.COM
 (2603:1096:301:16f::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 333bfd83-e51c-408f-d54a-08df12cf44de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: UXYi90nEvEhEgeTo7vVtkfDy8J3bnCi0HGk1ZV6luu/+qMHm69Ge8jQzVpt1DtkVSDWbGs4tPxFk2/Hr10Xa6Iy8xCtmftEA/6uL7IN1bvX8N8XHUnHa7/RteTdO7sJUe3FOJSDNe5bs33Kc8JgYHZSbEpmixjhAW0m2AHZ78Y/PG6Nc63SXWaeJj8fjwV8FJbHO7/+fbrhgEf0w1qlL0lTFF9k26Nm+KcQr6C8vYk2ZrD9b5jOyx8x3NUKS0FexVst9EHCtRYK6/78gjf1MyJw2zN9FATQFqPdRP+BOlCmlIxY+senyRyEBBYsA6VXXLhd1plWah48d5m6Pa6n+ctGfbLxb4jw1CsayT4WlO6dr0zYhmMebaSmwDAhVjWwE0QTOUHE8e9Z2QmSlxyVIXfGKkjkEwmFqgaEeE2q8loD5g5mW8/0I6r1ecIug8ChnJS8wxuPwdmMrwPGTB7cIZ5rFU0uCKU+QBw7akRCHeJU+4wjc07LYyiAwplZ1SbMEEDxp4IsptHVBxQ5DSGldSD3mzJ/NJ7F4Lq5lstS4mZdjlEZvPHST5J02Jbp6wVtJr1S0rV9h2gWT8SylA+2d6ONCSUQghCRDF+LXXajlx7hXVVEeX+4EB0UpEHl5ORERuBinokUoVO+UNsY/Hy96FXVzKi13r55JonnFGHg/PLpETo2bZZdTELDdvDwh1ZTvaZ4SF4zfo4lPQdi606p7pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2k4RndXSHc0Nk1FL25VdjNnT21qL3NCai9iTjMzR0RhVjlRNlZ1U3J2akZz?=
 =?utf-8?B?T0tSYi9aMm1JWGcyYTZZK21zbWs3b281Q1Qzd2g0amtUYWxzTWdVZnlNeGRL?=
 =?utf-8?B?aGE4WW14MFNvV2F2bElTWW9RMHVod0taUEJYbytBZ2V2K0p2L1NBa2ZDWEk0?=
 =?utf-8?B?bFVhUFBUMVdtVWpFVkY1bFJWYUdlYlYzVStKeVZCMDh3ckcwUWgrbW4zVGpB?=
 =?utf-8?B?MFM2ZCtUTEFRUFgyVzNibm9PeUlwd0dHTVlsLzE0Qm5WdDFZNFpPY3ZhVmdL?=
 =?utf-8?B?Y2xrTXpDSHJJRW9NRm1XRW03ZDlyaGN2RFVvTlpqeEhIUll6angyY2NWSHhv?=
 =?utf-8?B?cHRXeHhTS3ErUkdyVlBUUVIrVEtlMWVnZnJlL3k3MUc4WEVMMmpHMU1qaXhF?=
 =?utf-8?B?aTE1R1ZtRHJsemIvdkZMbk9NV0ZvdkFJYlo5cFB1V0ZSSzg2T0RjYmtXRVhH?=
 =?utf-8?B?MGdSME5XZ0Vrd3Y1Nm5CaDFmMGExS1JqMThoQmQ3MDFhR1JqRVJYRlFUU2dF?=
 =?utf-8?B?czhSSHdueUJPeG5yZWlOTnlzZDE1ak4xeVRad1kwSEJlZmZ5VlpoVkk0cTJN?=
 =?utf-8?B?dWhvc2phUFAyRllicGs5U3dGa0tsYzEydWh0Y2pzZ3lXb0t5cjBBcnNkaG1J?=
 =?utf-8?B?UWIxeVdYN3hBaXRld09BME14QkVHbFBGN3UyWDlzanJWYVlGbVZJMUVVK1Uy?=
 =?utf-8?B?dW1VSHlKakdCNG56ZXp1NmdaVnBYRU03ck9TYlZHYUU2SXd5Vm1MNm5XVHNP?=
 =?utf-8?B?QTI5TDl0cG04enhwNzNCYVBjZkVRQzVjZWEyTHluSkIxUjRwVFJHSW4yY1Q5?=
 =?utf-8?B?bExFWTJubDdURG1rK0tkVFZhY2VMUUxINGxxVUFnR09Rd2RtMFNBT3VvOFRn?=
 =?utf-8?B?ZkJlSWsxeFBkT3NRZEg2TG52NFZNZ0pzVUJKQjE1MTZzMFcweXlucUFOcTFC?=
 =?utf-8?B?VlF5SnRmZ0FuNVdhOWZGVjBHT1QxdElVNFBrK0hTbGN5SlNvMFNHOUsrZ240?=
 =?utf-8?B?VmNiMmhtSnhUV3p4Y0kzUHVSZTR3VEZDZ1pGV3NBekpqbjNLOVVEMDhsTFQr?=
 =?utf-8?B?eWo1VlF3SzdNVnZROVU3NmN0eUJ6NVhkVU8yZmZ5VVhLUWQrZThmcW9mTm51?=
 =?utf-8?B?bmVZWkMyZm80Z3RCMkdtN215MThOazZhRkw2U0U5T1AzN1JPSzVJM3RwNE13?=
 =?utf-8?B?cVAzYWx6b3dKMHdhdXRUVlBuSHpWakJJci9mU2pBK2ZrZWlnNXBCT0o3VlNq?=
 =?utf-8?B?aTM3U0lNb0VuL0lzNHlnOGtMNFExY29GZzNQeEg4cWdxRTh2WVU3VitlYzlw?=
 =?utf-8?B?Z3ladFp0NUlLc2JIM2szRkt3Y0s5cDBkVnZzK1JYQXhmUXVEUjZOUVo0QTJC?=
 =?utf-8?B?NFluQUpCYk42d2hSdUVHSjdwQVNkZUtQY2xLM0VBbW9Bd2hzUVZmK2tLRTdr?=
 =?utf-8?B?ZjM1ejZlbnBOOVlWbWFDRDhEVUU4cGw2cGRFQ2FGeloxdXpKNDJ1cWl1aVk0?=
 =?utf-8?B?ZDVmeXkyZUlTMHExK3ZlTi82aS83Skd4S3BPemRuMXhLLzFjbkxtY1VIQUZu?=
 =?utf-8?B?WDZLUzRsWGRES08wVjMxeHYwUzNuTk1jVkJqRTAwcVRBRm5aVnphVnpJaEhF?=
 =?utf-8?B?eTNnNTVHMWhUTkVnQmJBOVVvNDBGd0hrOUlBbzYwSW5qM213ZUxJalJWaW5a?=
 =?utf-8?B?TlhSOXAxUDlaK2FydUpET1lsVlNGekN2djdlZUExYWFlczJ6STFVdk53eXhw?=
 =?utf-8?B?cFhKS0tqbjMrWUtMTVllQ1Z3cUtjc3A1YmpHMjRJK2E1VlhtZjFnT3lqQS9h?=
 =?utf-8?B?dWtyRkd4WlZoMkQ1cko5c1NwOFdmcldvK25CNlcra2JzZ0FWZWQwZThHSU5Z?=
 =?utf-8?B?R0dHd2QyajFUYWFvejdFbXhGYk94NTltZ2NCWEJiMjM0cG5CM1NFU1BIVTBx?=
 =?utf-8?B?ZE1BMzgvNWRJV0xGOFd6a3hTcTQvdjFhalUxNURJYkxQTnJjRklwQzN2Vld0?=
 =?utf-8?B?MHBHYXVzT0djK0Mydk55MjJkWU0rR0ZwTDBaQlk3bDVDTVdxU05KT29WR2Nu?=
 =?utf-8?B?QXhVd1NYQjNiRkE3UlgwVXdtclY2Wk9vbmZrT1hCZUh4a0FCZ0xNaEF1dDFs?=
 =?utf-8?B?TmZ4VFBQeGRFaEUwSkRYdlNVV0M5c256SHQxMUt6dGhTNHBnMFlzalVhWml1?=
 =?utf-8?B?ZXdrU2tTWHJzV2c3eGlzSEhzd3B6Y1hNZDhpeUhmR0F6enJaL3E3QkhyZ1o0?=
 =?utf-8?B?NVdlcVpUR3c4NVZGNmdEYU5rSUJHNXlGRUFIc1cycmlRYTBVZExJRXBNcTdY?=
 =?utf-8?B?dC9UVENWS1kxWHNPWVkraDZzTS9ZNHo5MG1UOStxQnI1SFNKenFlSlVTMk1X?=
 =?utf-8?Q?Ppn4695VrJ1rlHap249Rz9h/NtqE8f0xOYEKS6l4H+a++?=
X-MS-Exchange-AntiSpam-MessageData-1: OU/aKbgueou7uQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333bfd83-e51c-408f-d54a-08df12cf44de
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:15:53.4554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhDtXW5po40nzndjWca0ash8czygWBl1jwtCJ9+U09UETqsdEnNmgmF3jVAsRcivjuPWBj2VJiOYqiybaJsENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF
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

ARM DMA domains are currently allocated by the ARM DMA code, with struct
dma_iommu_mapping owning the domain and the IOVA bookkeeping. To allow
the IOMMU core to own DMA domains as is the case with other
architectures, we have to allow that code to allocate the domain and get
the cookie from the ARM DMA code.

Implement ARM versions of iommu_get/put_dma_cookie that create a struct
dma_iommu_mapping that doesn't have its own domain, as well as
iommu_setup/teardown_dma_ops that set the device's archdata.mapping,
allowing ARM DMA ops to seamlessly work on these devices.

The code is protected by CONFIG_ARM_DMA_USE_IOMMU and mutually exclusive
with the same-named functions in the dma-iommu code; and not reachable
yet.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/include/asm/dma-iommu.h |  17 ++++++
 arch/arm/mm/dma-mapping.c        | 118 ++++++++++++++++++++++++++++++++++-----
 drivers/iommu/dma-iommu.h        |  50 +++++++++++------
 3 files changed, 154 insertions(+), 31 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 2ce4c5683e6d..85cf9b05faab 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -19,6 +19,14 @@ struct dma_iommu_mapping {
 	size_t			bits;		/* per bitmap */
 	dma_addr_t		base;
 
+	/*
+	 * Set for mappings created by arm_iommu_create_mapping(), where
+	 * @domain is owned by the mapping.
+	 * Clear for mappings that are a cookie of a domain owned by the IOMMU
+	 * core.
+	 */
+	bool			owns_domain;
+
 	spinlock_t		lock;
 	struct kref		kref;
 };
@@ -32,5 +40,14 @@ int arm_iommu_attach_device(struct device *dev,
 					struct dma_iommu_mapping *mapping);
 void arm_iommu_detach_device(struct device *dev);
 
+#ifdef CONFIG_ARM_DMA_USE_IOMMU
+struct iommu_domain;
+
+void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain);
+void iommu_teardown_dma_ops(struct device *dev);
+int iommu_get_dma_cookie(struct iommu_domain *domain);
+void iommu_put_dma_cookie(struct iommu_domain *domain);
+#endif
+
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index a7ad194960ce..e0d58778c5f5 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1531,6 +1531,79 @@ static void __arm_iommu_free_mapping(struct dma_iommu_mapping *mapping)
 	kfree(mapping);
 }
 
+static int __arm_iommu_init_cookie(struct iommu_domain *domain,
+				   dma_addr_t base, u64 size)
+{
+	struct dma_iommu_mapping *mapping;
+
+	if (domain->cookie_type != IOMMU_COOKIE_NONE)
+		return -EEXIST;
+
+	mapping = __arm_iommu_alloc_mapping(base, size);
+	if (IS_ERR(mapping))
+		return PTR_ERR(mapping);
+
+	mapping->domain = domain;
+	domain->cookie_type = IOMMU_COOKIE_ARM_DMA;
+	domain->arm_cookie = mapping;
+
+	return 0;
+}
+
+/**
+ * iommu_get_dma_cookie - Set up a domain cookie for ARM IOMMU-based DMA API
+ * @domain: IOMMU_DOMAIN_DMA domain being configured
+ *
+ * Allocates IOVA bookkeeping for the domain based on the domain's specified
+ * geometry. The aperture can currently be at most 4GB in size, otherwise
+ * fails with -ERANGE.
+ */
+int iommu_get_dma_cookie(struct iommu_domain *domain)
+{
+	dma_addr_t base = domain->geometry.aperture_start;
+	u64 size;
+
+	if (base > domain->geometry.aperture_end)
+		return -EINVAL;
+
+	size = (u64)domain->geometry.aperture_end - base + 1;
+
+	return __arm_iommu_init_cookie(domain, base, size);
+}
+
+/**
+ * iommu_put_dma_cookie - Free domain cookie for ARM IOMMU-based DMA API
+ * @domain: the domain being freed
+ */
+void iommu_put_dma_cookie(struct iommu_domain *domain)
+{
+	__arm_iommu_free_mapping(domain->arm_cookie);
+}
+
+/**
+ * iommu_setup_dma_ops - Record a device's DMA API domain cookie
+ * @dev: the device
+ * @domain: the group's new default domain
+ *
+ * Records the cookie of @domain on @dev, or clears it if @domain is not a DMA
+ * API domain. The DMA ops themselves are per driver binding and are installed
+ * by arch_setup_dma_ops().
+ */
+void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain)
+{
+	to_dma_iommu_mapping(dev) = iommu_is_dma_domain(domain) ?
+				    domain->arm_cookie : NULL;
+}
+
+/**
+ * iommu_teardown_dma_ops - Clear a device's DMA API domain cookie
+ * @dev: the device
+ */
+void iommu_teardown_dma_ops(struct device *dev)
+{
+	to_dma_iommu_mapping(dev) = NULL;
+}
+
 /**
  * arm_iommu_create_mapping
  * @dev: pointer to the client device (for IOMMU calls)
@@ -1541,28 +1614,32 @@ static void __arm_iommu_free_mapping(struct dma_iommu_mapping *mapping)
  * IO address ranges, which is required to perform memory allocation and
  * mapping with IOMMU aware functions.
  *
+ * Unlike a default domain set up by the IOMMU core, the returned mapping owns
+ * the domain it describes and releases it along with the last reference.
+ *
  * The client device need to be attached to the mapping with
  * arm_iommu_attach_device function.
  */
 struct dma_iommu_mapping *
 arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 size)
 {
-	struct dma_iommu_mapping *mapping;
-
-	mapping = __arm_iommu_alloc_mapping(base, size);
-	if (IS_ERR(mapping))
-		return mapping;
+	struct iommu_domain *domain;
+	int err;
 
-	mapping->domain = iommu_paging_domain_alloc(dev);
-	if (IS_ERR(mapping->domain)) {
-		int err = PTR_ERR(mapping->domain);
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain))
+		return ERR_CAST(domain);
 
-		__arm_iommu_free_mapping(mapping);
+	err = __arm_iommu_init_cookie(domain, base, size);
+	if (err) {
+		iommu_domain_free(domain);
 		return ERR_PTR(err);
 	}
 
-	kref_init(&mapping->kref);
-	return mapping;
+	domain->arm_cookie->owns_domain = true;
+	kref_init(&domain->arm_cookie->kref);
+
+	return domain->arm_cookie;
 }
 EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
 
@@ -1571,8 +1648,8 @@ static void release_iommu_mapping(struct kref *kref)
 	struct dma_iommu_mapping *mapping =
 		container_of(kref, struct dma_iommu_mapping, kref);
 
+	/* Frees mapping too, via iommu_put_dma_cookie(). */
 	iommu_domain_free(mapping->domain);
-	__arm_iommu_free_mapping(mapping);
 }
 
 static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
@@ -1595,8 +1672,13 @@ static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
 
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
 {
-	if (mapping)
-		kref_put(&mapping->kref, release_iommu_mapping);
+	if (!mapping)
+		return;
+
+	if (WARN_ON(!mapping->owns_domain))
+		return;
+
+	kref_put(&mapping->kref, release_iommu_mapping);
 }
 EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
 
@@ -1660,6 +1742,14 @@ void arm_iommu_detach_device(struct device *dev)
 		return;
 	}
 
+	/*
+	 * This pairs with arm_iommu_attach_device() on a driver-owned mapping.
+	 * A mapping which is merely the cookie of a core-owned default domain
+	 * must not be torn down from here.
+	 */
+	if (WARN_ON(!mapping->owns_domain))
+		return;
+
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	to_dma_iommu_mapping(dev) = NULL;
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 349d6a57e5a0..71b23cb698c0 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -7,25 +7,24 @@
 
 #include <linux/iommu.h>
 
-#ifdef CONFIG_IOMMU_DMA
+/*
+ * Both dma-iommu.c and arch/arm/mm/dma-mapping.c implement functions to set up
+ * IOMMU_DOMAIN_DMA default domains. Only one provider can be compiled in at a
+ * time.
+ */
+#if defined(CONFIG_ARM_DMA_USE_IOMMU)
+
+#include <asm/dma-iommu.h>
+
+#elif defined(CONFIG_IOMMU_DMA)
 
 void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain);
 void iommu_teardown_dma_ops(struct device *dev);
 
 int iommu_get_dma_cookie(struct iommu_domain *domain);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
-void iommu_put_msi_cookie(struct iommu_domain *domain);
 
-int iommu_dma_init_fq(struct iommu_domain *domain);
-
-void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
-
-int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		     phys_addr_t msi_addr);
-
-extern bool iommu_dma_forcedac;
-
-#else /* CONFIG_IOMMU_DMA */
+#else
 
 static inline void iommu_setup_dma_ops(struct device *dev,
 				       struct iommu_domain *domain)
@@ -36,11 +35,6 @@ static inline void iommu_teardown_dma_ops(struct device *dev)
 {
 }
 
-static inline int iommu_dma_init_fq(struct iommu_domain *domain)
-{
-	return -EINVAL;
-}
-
 static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
 {
 	return -ENODEV;
@@ -50,6 +44,28 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 }
 
+#endif
+
+#ifdef CONFIG_IOMMU_DMA
+
+void iommu_put_msi_cookie(struct iommu_domain *domain);
+
+int iommu_dma_init_fq(struct iommu_domain *domain);
+
+void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
+
+int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		     phys_addr_t msi_addr);
+
+extern bool iommu_dma_forcedac;
+
+#else /* CONFIG_IOMMU_DMA */
+
+static inline int iommu_dma_init_fq(struct iommu_domain *domain)
+{
+	return -EINVAL;
+}
+
 static inline void iommu_put_msi_cookie(struct iommu_domain *domain)
 {
 }

-- 
2.55.0

