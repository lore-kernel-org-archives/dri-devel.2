Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50988606A338
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aIWyHE2D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8760110ED02;
	Mon, 26 Oct 2026 09:21:07 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CBCC10ED04
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:20:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfLLDEMphQ2fFz/udXDuO87mXOtPyw27CUy8cZlMO6uPD1Uh4sx/ig/iqObE0LA2r7zn/Rj7LIj9OStqiPwNFo7CCNoZYNPPOtMKKCtlNy8sw5L+OOcE6Hsrmf0E5sAvWjZi7jBTK7PnIRkQYu9ajPRvJXnjTRl4djyvFgd1q+GTpNwxNQQJAmPtItt9wzBJr6EZEsAs0gen7GCzhCzwDGhm+aE7Jt1JlPfmeJw/o70QEg8ancrpNojnzgcEMM8vRjJhsBbKn4wXmsLSRFxvNZOR4i4MtZ+fXWx8NZWiEk/fftf+yCuM95ZYyCOW5ZXDIwWLxaFPvsQ+f1VT692X4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv3BpPskb8qHn8Vy6Qv/BBbo2Hwz1/nZxHPFwXeWQDc=;
 b=dblHFn+hhMy/bb7+X9XDvqTFXpsyjYJZ1boVGw2jcbkHp646EPzCCgoXvPByzBlJvgyElfjAzokIfOd2C5pNoGzIsJGChxdLCkmxhjZHUhwJEr3tZYa2csna57O8RVTkVINJ/cVuNCNPwgcT9tHQhRwvCfms5rrWljcVDpViyKPKko3bqjOWSZDMBoMwnQlGEgGceWVbfsI5KAgEfzir6j0wGCcjH+7qKvzz71U3SKcw/F1BBFxkNDfojIRjxMkKlU3vuiRx4yZ8cC9tRMLe8/ru8lW6xubOcn1d3pNY9I1I6qI+AHCgA3lJzBbUfvIc8fZ6qMFv6ixNWaXAhT3hCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv3BpPskb8qHn8Vy6Qv/BBbo2Hwz1/nZxHPFwXeWQDc=;
 b=aIWyHE2D8oSqUtmxeSI3NhqacJfXRVl5/gxrGfQNgjd9cEa6WZpW6LNujXAo971k06lTwk3QbqwYgkYV48b6zPi5yLXflFDfiOPzJZvDxof9/uso0yT5CVmj9Np6m5ZOd07BgO/VqQ4XH/j0kP7qiV0yMfJvTAVfvdv9LRWzCgdplwWNVBSElCQnxSV9DXzqkCI4xneqRAhZO53ex+v+wnp53MwlREAaan1cK1vGDE4cXROvAMQwKYB1BNNPW1loeFqv15k5jQSQRDJDf+o0aKCMBzrP4AQN9eu8hK3vD46pejzqW05OSHHSqTSTWU637uYGR2Xq8Id6NFf910a1cA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:20:53 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:20:52 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 26 Oct 2026 18:19:29 +0900
Subject: [PATCH v3 04/10] ARM: dma-mapping: Implement and expose DMA setup
 functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-arm32-iommu-dma-cookie-v3-4-3901d74b1ff2@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0286.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 60763384-062e-4a5d-a2eb-08df33426e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|18002099003|6133799003|22082099003|3023799007|921020|56012099006|11063799006|5023799004|261022075727099003|261021130227099003|261021123027099003|10067099003|261009223027099003|261022113327099003|261021135927099003|261022115727099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 6pwFxE6cEfHWAakNAxvnhWTuASHSZoZbhFTy7/mluYBa0WG9XqSfLe4Etcboh5haShgDjopiIJ1wvrsHppXy4lgj+liRXmzi5I8C8C/4UWBEV5JtShs//cB2zesbSRnbxlTuJg/jXYqqQ8IFQTdKz4dwSfh7J3JaIQY49D8edKbS81NvFRzmtTO9Wb1OueMnRssf5NMGeCWgU+xavneHuuq90fcxj5BYh8ZHb7C/2TcMuQewf2arJ3sdma7ygVC4AXXeh2VGqk9uUhg0uOlZgoGuIEP1jiLw1y4OHGwvmUaNdIh7mVrn8d057Jji1rRR6PjM0D8P2X6CesOSoO9qA2erocIr+7MYB/sGXbnuqyhD8lYYyPAE5RoHwDw9i9+rFpzunNT5WArLd1nW668QVroDWlBbvoiEtthCAGMWqe1+ZLrqVfY9iM/tPutZ04lITfHYGV3EVtxL0+8IWUlEGD95SljOLC3aeCyHQ2HK2jAVOntV7C/0BLJhSEqAQb4tTfqwvlQTdvUAoEviNvjfPjNGjZW28qyOba0MyeaIXcIoj0KVvV7QHny653p2RTf+kKuyxzeSrp53DPb/f/uRvAjxNDZeK+bBDKAkGaEqpw2qMNUEhdTrzO/zkEaRjkSH4ffLt+IMiMe0x8Xek46VRaOhFRn1//dMWoIZGv87fOGlZZZda0Wr3dWUACFqLX6u8W7TMlObhKFOg1k5Q3Fd0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(18002099003)(6133799003)(22082099003)(3023799007)(921020)(56012099006)(11063799006)(5023799004)(261022075727099003)(261021130227099003)(261021123027099003)(10067099003)(261009223027099003)(261022113327099003)(261021135927099003)(261022115727099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJ0ZGJORU9iNVF6dG4zUlVLNXI5TExlR2thbzBlZjE5NmpFUDhzYzVMVXFU?=
 =?utf-8?B?Uk45V3lFZVFtT09JenZhVlN2TGRqRkdzc3oveGVFKzFmS013SUNrdmJaSndz?=
 =?utf-8?B?WE9qbTFPZ043aHpXSk83aUVZTEtpcWZzeStVa3k2NkpnakJXN1llUVFoU0J1?=
 =?utf-8?B?QlpUaVBHU1pFS01BMzZwSmRoYlQvOGJBKzNVSTlvdUNKV2l4dkRybjJEMjFX?=
 =?utf-8?B?UDZwbDk0b2krMEJyZnBGNS9xUm5vakRqU3hJQ0hXVWozYzZTU1dpdGwraTQw?=
 =?utf-8?B?WVF0Y3VYc3ArQU5taG0xcnNHcCtudWwyU3ROSzdSRDZYd0xaMWpvQ2F4OUdq?=
 =?utf-8?B?OW4zM3FwY0dqTzV2dnFlZUoxUlF0bkJ6S2VvVEhMeFFDQUc1YTZlUHVwaldB?=
 =?utf-8?B?ek84ZzY5NGlVTXEvVm03YWlOL1pBT2JnbUJsL09yL0JaanhZdVNLSTJrUmYy?=
 =?utf-8?B?WTFRZVJTNmtmc0NxMnB3cmdqUGlPdjV4bHNJamUxZHNlZFJJZzdqZTNmMHNw?=
 =?utf-8?B?MUQzcmptSjhSVHdHbVJJSUlMYWtGSXVlUVRaV1NqSG9BUVRhSDZwR0gwSlJZ?=
 =?utf-8?B?T1F5dEZ6VkkvU3htdWhscDgvMUlJSUYwdFRndll4ODZreXhWOUowYlAySTk4?=
 =?utf-8?B?cVpHZmVYRERFenQ2TERTdUd3SWgzbkVOdlRqRTlzS2xyN3J2Q0hnVzE3Ujhw?=
 =?utf-8?B?RENnOWtDNnI5ZEM0M2YyNHVnZWhOT2hYUEJvWHY3R091UG1WbU1pMFRTUExw?=
 =?utf-8?B?TGp1ZktIVDdSblJxSVdTc0s5SUg3d1Z0a1dmTzkyZHVWYWlZUmk2VExjamI1?=
 =?utf-8?B?VEpUZEZPVlNlcmo0d1VGY2ZOcHo3Ky9xWXhWVUdUYXFUd2FidElPSTVCUzJT?=
 =?utf-8?B?K1JDNmhWejN4WVo1WGRjVXRIcDAxVEhLbzVuVTdpRjVwVGdtRDFWeHhZK1FM?=
 =?utf-8?B?WFMwbzBsV05TSVZMSEJmbHh4c3gweTZxaUkzeDFHSDFITTFQUkJ2QTFqMFJL?=
 =?utf-8?B?QUgvTDkrNHBUVnNLV3AyQlNiUEMxV0RrSUlrbjJ6Rzl1UFo3SE13M3kwbDFz?=
 =?utf-8?B?KzhDbjYzVERBSnprYVRNdjdIbmR1K2Urek1DOUtwTUFxdUllVXI4SjN1Y3VM?=
 =?utf-8?B?UHJBajRKNmZCZmp3dm1peEdpcEtnbXFrNUJRUlhnQTVLNDRYR2dvVGVPNmtF?=
 =?utf-8?B?bUdMNGJNeXNHbUZJWnF2dEdwa1lhL2twUzF6MkFVZjQxL2pOeUV3YUwyV21j?=
 =?utf-8?B?aHl4SWw0MTN0RWdUM04wNEFOZUc3ekdwRnV5UHo3a1JSNFp0dFMwY3dFcXFn?=
 =?utf-8?B?TWl0SHVnSXI2cVVQV0JEOU1iRDJwaWVsUkVkZEs1ZGhNd3krVFF5Z3JrbUpa?=
 =?utf-8?B?SWJiTDJEdVZwWjRrWnYxbk9uRXdzaTVQWmI3WVNvMDB0emNKcDU3Ym1KMWtq?=
 =?utf-8?B?VHRHbU9QUjJLN3lvdDVhMk1rYlpaa0xrbXFVRmFzOHEzSmJxb0tTUmJXVzU0?=
 =?utf-8?B?a05vQUpjV28yOFF2VzdUTTNDR3A3ZlVyemV4WDM4UlRxL1dpSXQ3enU5WTBY?=
 =?utf-8?B?bTVqVTdOT1c5Y1BEQ04wRUFCbFhuWm1SU1hXcjg5QWJZbUNBVldmTWhQZElM?=
 =?utf-8?B?cnZ5SkVWZ1NiU3BodGhwTWxpWFdZczF1S1pZRG5ZS1piVmNzREFiTDNzWnRR?=
 =?utf-8?B?NmNLZWZyOVcxZmd5MDBrQ2tUV1RMU1pvK2wvOWpMbDlGRmRqc3JhbVpUbVMv?=
 =?utf-8?B?NUJ1ZG5oQk5lWWV6K1JqWXNzWFoxTi9XdXQ1QnpGYWpXK05zWnZaNkc2M0FR?=
 =?utf-8?B?OWp4N211RkZ4empOQXFCMXNZZWlWTlpZcXp3b2pwb0toc2J3UE1YVnBHQnFV?=
 =?utf-8?B?VWJBQnAxRmxMV3ZFMXhUNzRSaFdxbXN4SlZaQ08rWmIrTEI5K1B5YWlpdUVU?=
 =?utf-8?B?dDExV0lzWno1N3kzL0tSZTBqLzd5QkJ6K3UxQmJ4dGJZVHJRUmwrR0FReXJT?=
 =?utf-8?B?dUNzMGZIcmJUc2g4UzhFNUpmaG9UYTRMNHJ2YnBTL2FjbWRvbjFzWXMwcE02?=
 =?utf-8?B?OGkzYStOb2h2NkRXYytIZzV0MThIT2xtMXZvRVZ0a3ZFUGZMYjNhclpYa2l0?=
 =?utf-8?B?RFN4OURjbFpQZ2tSaklCYmorN3lveVEwbnlyTzJBS1p5T3NjcktaK3YzZ1Vk?=
 =?utf-8?B?dFBFK0hkaUcrZVBjanNuNUdxOWdPQldreTh3MkNUZVJHeS81UDV4QnkrdU5q?=
 =?utf-8?B?M2pVQmpxTk51bEJvZEI2UE1VR3F3dXRQUWc4b21UUloreUtiU2VVUlVFUWoz?=
 =?utf-8?B?QmpMVTQ2aEhaelNXcno1THdHN3FncjVJaUkwaHBuT3dXYmlRSVdXN2JaTnRX?=
 =?utf-8?Q?BBECRD66pVGbQkTbAneLwql4rJDAWhMdOhxE8e/9aMfCz?=
X-MS-Exchange-AntiSpam-MessageData-1: Och+Lczgd8p/6w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60763384-062e-4a5d-a2eb-08df33426e45
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:20:52.1997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiC56VT6NM3LZcyo2sLKl3Bykjxs0CbV+GxfopW/FwGhEd6iJBvXvtdcCiW/mNzlvyaWQv7V1PtDvz3RKDoEug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195
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

ARM DMA domains are currently allocated by the ARM DMA code, with struct
dma_iommu_mapping owning the domain and the IOVA bookkeeping. To allow
the IOMMU core to own DMA domains as is the case with other
architectures, we have to allow that code to allocate the domain and get
the cookie from the ARM DMA code.

Implement ARM versions of iommu_get/put_dma_cookie that create a struct
dma_iommu_mapping that doesn't own its domain, as well as
iommu_setup/teardown_dma_ops that set the device's archdata.mapping,
allowing ARM DMA ops to seamlessly work on these devices.

For core-owned DMA domains, the IOVA bitmap is allocated at
iommu_setup_dma_ops, after the IOMMU driver has been able to establish
domain geometry, matching arm64.

The code is protected by CONFIG_ARM_DMA_USE_IOMMU and mutually exclusive
with the same-named functions in the dma-iommu code.

arm_iommu_* APIs stay functional with DMA default domains, restoring the
default domain when detaching an explicitly created mapping.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/include/asm/dma-iommu.h |   9 +++
 arch/arm/mm/dma-mapping.c        | 145 ++++++++++++++++++++++++++++++++++++---
 drivers/iommu/dma-iommu.h        |  50 +++++++++-----
 3 files changed, 177 insertions(+), 27 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 2ce4c5683e6d..d8d37980794f 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -32,5 +32,14 @@ int arm_iommu_attach_device(struct device *dev,
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
index 7ef7c268c583..48b9a9f26095 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1521,6 +1521,96 @@ static void __arm_iommu_free_mapping(struct dma_iommu_mapping *mapping)
 	kfree(mapping);
 }
 
+/**
+ * iommu_get_dma_cookie - Allocate an ARM DMA domain cookie
+ * @domain: the domain
+ */
+int iommu_get_dma_cookie(struct iommu_domain *domain)
+{
+	struct dma_iommu_mapping *mapping;
+
+	if (domain->cookie_type != IOMMU_COOKIE_NONE)
+		return -EEXIST;
+
+	mapping = kzalloc_obj(*mapping);
+	if (!mapping)
+		return -ENOMEM;
+
+	mapping->domain = domain;
+	spin_lock_init(&mapping->lock);
+	domain->cookie_type = IOMMU_COOKIE_ARM_DMA;
+	domain->arm_cookie = mapping;
+
+	return 0;
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
+ * iommu_setup_dma_ops - Initialize device's DMA domain cookie and ops
+ * @dev: the device
+ * @domain: the group's new default domain
+ *
+ * Allocates IOVA bookkeeping based on the domain's geometry, which must be
+ * initialized by attaching the domain first. The aperture is limited to within
+ * the 32-bit DMA address space.
+ */
+void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain)
+{
+	const struct iommu_domain_geometry *geo = &domain->geometry;
+	struct dma_iommu_mapping *mapping;
+	u64 end, size;
+
+	dev->archdata.dma_ops_setup = false;
+
+	/* Bail out for non-DMA default domains */
+	if (!iommu_is_dma_domain(domain)) {
+		to_dma_iommu_mapping(dev) = NULL;
+		set_dma_ops(dev, NULL);
+		return;
+	}
+
+	mapping = domain->arm_cookie;
+	to_dma_iommu_mapping(dev) = mapping;
+
+	end = min_t(u64, geo->aperture_end, DMA_BIT_MASK(32));
+
+	/* Are we the first in the group to allocate the bitmaps? */
+	if (!mapping->bitmaps) {
+		if (geo->aperture_start > end)
+			goto out_err;
+
+		size = end - geo->aperture_start + 1;
+		if (__arm_iommu_init_mapping(mapping, geo->aperture_start, size))
+			goto out_err;
+	}
+
+	set_dma_ops(dev, &iommu_ops);
+
+	return;
+
+out_err:
+	set_dma_ops(dev, NULL);
+	dev_warn(dev, "Failed to initialize IOMMU DMA mapping; retaining platform DMA ops\n");
+}
+
+/**
+ * iommu_teardown_dma_ops - Clear a device's DMA domain cookie and ops
+ * @dev: the device
+ */
+void iommu_teardown_dma_ops(struct device *dev)
+{
+	to_dma_iommu_mapping(dev) = NULL;
+	set_dma_ops(dev, NULL);
+}
+
 /**
  * arm_iommu_create_mapping
  * @dev: pointer to the client device (for IOMMU calls)
@@ -1531,6 +1621,9 @@ static void __arm_iommu_free_mapping(struct dma_iommu_mapping *mapping)
  * IO address ranges, which is required to perform memory allocation and
  * mapping with IOMMU aware functions.
  *
+ * Unlike a default domain set up by the IOMMU core, the returned mapping owns
+ * the domain it describes and releases it along with the last reference.
+ *
  * The client device need to be attached to the mapping with
  * arm_iommu_attach_device function.
  */
@@ -1594,8 +1687,10 @@ static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
 
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
 {
-	if (mapping)
-		kref_put(&mapping->kref, release_iommu_mapping);
+	if (!mapping || iommu_is_dma_domain(mapping->domain))
+		return;
+
+	kref_put(&mapping->kref, release_iommu_mapping);
 }
 EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
 
@@ -1604,11 +1699,17 @@ static int __arm_iommu_attach_device(struct device *dev,
 {
 	int err;
 
+	/* Avoid attaching if IOVA bookkeeping initialization failed earlier. */
+	if (!mapping->bitmaps)
+		return -EINVAL;
+
 	err = iommu_attach_device(mapping->domain, dev);
 	if (err)
 		return err;
 
-	kref_get(&mapping->kref);
+	if (!iommu_is_dma_domain(mapping->domain))
+		kref_get(&mapping->kref);
+
 	to_dma_iommu_mapping(dev) = mapping;
 
 	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
@@ -1646,12 +1747,14 @@ EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
  * arm_iommu_detach_device
  * @dev: valid struct device pointer
  *
- * Detaches the provided device from a previously attached map.
- * This overwrites the dma_ops pointer with appropriate non-IOMMU ops.
+ * Detaches an explicitly attached ARM DMA domain and restores the default
+ * domain's DMA cookie and ops. Does nothing if already using a DMA default
+ * domain.
  */
 void arm_iommu_detach_device(struct device *dev)
 {
 	struct dma_iommu_mapping *mapping;
+	struct iommu_domain *def_domain;
 
 	mapping = to_dma_iommu_mapping(dev);
 	if (!mapping) {
@@ -1659,10 +1762,25 @@ void arm_iommu_detach_device(struct device *dev)
 		return;
 	}
 
+	/*
+	 * Allow callers who think they're detaching the legacy UNMANAGED
+	 * domain to work transparently.
+	 */
+	if (iommu_is_dma_domain(mapping->domain))
+		return;
+
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
-	to_dma_iommu_mapping(dev) = NULL;
-	set_dma_ops(dev, NULL);
+
+	def_domain = iommu_get_domain_for_dev(dev);
+	if (iommu_is_dma_domain(def_domain)) {
+		to_dma_iommu_mapping(dev) = def_domain->arm_cookie;
+		/* Restore NULL ops if default domain initialization failed. */
+		set_dma_ops(dev, def_domain->arm_cookie->bitmaps ? &iommu_ops : NULL);
+	} else {
+		to_dma_iommu_mapping(dev) = NULL;
+		set_dma_ops(dev, NULL);
+	}
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
@@ -1717,6 +1835,8 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 
 void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
+	struct dma_iommu_mapping *mapping;
+
 	/*
 	 * Due to legacy code that sets the dma_coherent flag from a bus
 	 * notifier we can't just assign coherent to the dma_coherent flag
@@ -1727,10 +1847,14 @@ void arch_setup_dma_ops(struct device *dev, bool coherent)
 		dev_set_dma_coherent(dev);
 
 	/*
-	 * Don't override the dma_ops if they have already been set. Ideally
-	 * this should be the only location where dma_ops are set, remove this
-	 * check when all other callers of set_dma_ops will have disappeared.
+	 * For DMA default domains, iommu_setup_dma_ops manages the DMA ops.
+	 * Don't set them here.
 	 */
+	mapping = to_dma_iommu_mapping(dev);
+	if (mapping && iommu_is_dma_domain(mapping->domain))
+		return;
+
+	/* Preserve DMA ops installed by another owner. */
 	if (dev->dma_ops)
 		return;
 
@@ -1749,6 +1873,7 @@ void arch_teardown_dma_ops(struct device *dev)
 	arm_teardown_iommu_dma_ops(dev);
 	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
 	set_dma_ops(dev, NULL);
+	dev->archdata.dma_ops_setup = false;
 }
 
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
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

