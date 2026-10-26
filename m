Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C273606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hwO+ADO4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A3AA10ED04;
	Mon, 26 Oct 2026 09:21:32 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD8410ED0B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7PW4opq1i+9H89kAZH1XDwBrjkFdt51snWrRC6WfDQ1vDtAGO1dSrLf1L4/VxRj4/DQCI3vnXgEkBToO5m3KKO4Oqfk9VJOLr3bdYkgkNBm1x8qwwgGvWJohpaGgzkxhwpRxo0huPNL9WjjK/xKv8e1/Z7P8Vyy7QVZ7cxwQTOUPDO/uZrKwIRVY5pp1sdt8SMgIIhsPAQ1oqA4bXYLxdAEZ91ot/X8o6RwZJiuwebZ+dJf967PVa2YNBpnhCDz6s+YwBuHq/kk47ZqPd/4Cd1hoQZ1wJG27MExGIUhxax0XD6VnGSH0n56RY8nWwRZDU3FPXA9NyeF6B4IEFw7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb7gXSc4n9LV6BI/QTsPfo8P4LSGM1aBl04aHyczUyg=;
 b=aQsighp6WFl23hZ6Py/+Umvb3KuUqrldPfM1HF0a0CSSZq4rX8cFz9qNsDqSSqGWvpnbdc/j2O0tBAPHoEsg1j+HeCaTwttXlXH8J5zUzb5wByB6YDR8FCyDd+Lx9JsylGEJzXg6faB4GMYEmORmQN7Rc2o8TEqa7wunza+HTX3vvGrK+wFHff/2U3cpnv6OjCyXLlQM5hDOzsCiL3XfvE+wKLMjC/jDkNFzlvsmccGmPgJlWaLmE3ynk/EJUCJOuo6ihLtn1uCFi9jmWcQlFpbJzu+88YqhHdvO3VyDUhAQp1B5xz6YbjizLDHkiacpOBDgkApIPFy+mB5ZpMjQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb7gXSc4n9LV6BI/QTsPfo8P4LSGM1aBl04aHyczUyg=;
 b=hwO+ADO4v/FbzDyMPZtCgunXmg3WpFM4xIbJMt/rZj8q+0+DCnoDbXikOyDdBssShDYbJI7CFtVT2aga31q/gzS9bdf7VH3KrYAOhXjjfsjAAcGFGCd0shATlWtz52E0wYz1fCSvOITubVI7YzwJkgyvoS/5S8s4Jon6FDfZbQUV0dnWssdapRYA7tIO8ed0RnbR092u68MPWyfLckjSCzckwxTkTHAkKfSwxK2t7GnLwflbJDpVr1ddG/6aiUSEohHTBuiRr+uECHCAnDzOKxV1KnUXgphTUZWeJKr5NevodG9x/QwqbjY+o+76SAe4i6LrDhc3LoT1D+xPG3/SbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:21:04 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:21:03 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 26 Oct 2026 18:19:32 +0900
Subject: [PATCH v3 07/10] iommu: Enable DMA default domains on (most)
 32-bit ARM platforms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-arm32-iommu-dma-cookie-v3-7-3901d74b1ff2@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0259.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: a87693b5-9d0e-4edb-c534-08df334274e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|10070799003|366016|921020|5023799004|11063799006|56012099006|261009223027099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|10067099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: OcJ7/RIKqpPL8vHOVqEyDL8YWdtdA2GRF/lo7Nf8heQzl+1PYCWD2XTXY3rolG4OvYFsZ/K3/PAJOhb6dE0YcfaA0j9EPFSsuh2vh8FlyDNLEWtegZAnr1imzdPlN16/hbX/pgAEYM1l3sd4RpKgK/TttvZMdrF51HetsjHGlO4PINlUM0MM5L4PgGSebkDTmGSWgRBNJzjcaSt86MfJrPaPVtoGUxyPtcANBO6DdO2EVrGxa6wSNx7V/wFu8+Vvsx4KCxknXpWZiZWhC29aI0wX1U23hj+uIJECAWfjVpypuOXrs2fJo66SdBvx4F1JYOIh4Hvpg9Eh0uwlkjVH00R9nDiQjSZwvpchbaJi0YHpZ/n4Lq/B0Ut3sNFAm/QUG+WAnGC3OGQs56UeXeGLdwi4h2wQgutOaovDjQmoWDAR4umwGO95Suo10/loguDXiNTrIxsJ2lJRK3O+EZM7xeEw2Nbjl07mwPePx5hLhdAdVXpSxqXXsipjNDxdvrYGKeSKq4aOIMu0uBvQVzK7GSfodlHUX/cashHAMeWWvXeMLnGUTjGvhkhWV/sI5UddZ5aQNuj95DXxVRgN/VQdycf1ryqw+Ic+IBjoPqOwfQj5mbvc7eggY/La8uL2qxqQy4WCW7LZPo/hZyDoXPLeE1TKuPu3fXQSqcdhzVxaV7AopXeOTq+gYsR9r6cRl9tHZbyC42jNbjNhDL/QDTGIHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(10070799003)(366016)(921020)(5023799004)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(18002099003)(6133799003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFZyL2c0YWtLREYxK1VjOHpaWnFsUHp0RXFWclpiNlJtdWl4Z2VEY1FPMDYv?=
 =?utf-8?B?N0x0Ty93akpxSWRWTHhHTmhnRWMyUnRlQWlFTXhjZ04vNEdIWEhuTzFQdzRa?=
 =?utf-8?B?MUpINnpqK1VmbjhYVVE5L2lOTUdlNlVWbTVRcHZHU1NoaDBLSit1UExKUmx5?=
 =?utf-8?B?UnpjVTYxTzhackh0YXhVOEFBa214UEN3R2dQd0VMSWJIcUlBUldkTVJmb3B2?=
 =?utf-8?B?YTR5amlMdDc2TTd4bmF4d3NsNXFINjlSZXR4ZW1kVDcxMEx2K2g0M0REemU5?=
 =?utf-8?B?U2pNbVZTaVNCV3lGcjdkTWdCbE1oaVNtZUZxY0NtWDlhL01KOXByNmZacUFx?=
 =?utf-8?B?aGZFZ29kWVRNUXVZRkpFQUc5eFNSV3RydThjSEViWHNTUCtubGY4RDdVUUMw?=
 =?utf-8?B?cU1ObXRpR1JOWlFrbkx3Vk5acllQMWtGcVYwNHNqa1VvTldiM1JBdWVkN1dk?=
 =?utf-8?B?dUlORm15cGZJdkN3VGF4dFE1bGZDejhuS2g2VkpXNVZsMmsvdFRRWFNXYTdG?=
 =?utf-8?B?ME5RekhxVk1md2RZWDNUVVBXVHd5cWRpbzlhYnlxTHFsZXlaVE93eGR2UjBP?=
 =?utf-8?B?Z2tvQXIwZXQ4cC9JbENFeVIzRnpjck1EVFZNcTUwRG1iLzFTdVVkelBZWGxT?=
 =?utf-8?B?L0w4cGp2MkFUKytpUTdxbng3U2Zvb1ZXUlpnNlhmdGUyOFlCaThSaGdaR0Vj?=
 =?utf-8?B?cDdxeXIxZHZQaG5hbmpXR0tKM2dTNEh4S2xsVFRtSDl5UysrRTZ2Tm1tdVAx?=
 =?utf-8?B?Y0MxTzFVU0p1SUtXaWJmRDlZbVNuV3Jjd2xyWmYxSEM1OEpxVGVlYkFUU2hk?=
 =?utf-8?B?UFprQnA2OHhSdDdiSk0wM0lPaGI0aEw2dGdKcFBFZmN2TG5neVE2dlM5TVdu?=
 =?utf-8?B?TmpKK0xMbXgwVnU5RkF1TFdwTFNybFJwdFF2LzVmVnJKZXFBZFh0WWV5OGtX?=
 =?utf-8?B?NnpmZTZuWWhhbGNXSkhZNjVMSzNPSGxyM0toeEVqK2tGMmdBUTR5ejZ1YXU3?=
 =?utf-8?B?WHVmNExCbVVBVnVUai9objRYME83a0RUdzRkajMxMi84cURod0N2YlZiZnB2?=
 =?utf-8?B?RVJxT1RjVHplZjdnSldHRnJ3WTR4QUtRRGgyUGNTWWEyQW82bzVVMTdKSks3?=
 =?utf-8?B?aUo0TDlnZWRXdmhTZ053cWM1YmFXeGxsVGNKUjRxWmNwcjZGa2dDSmZWcHUr?=
 =?utf-8?B?K3V0SUo1N3R4QnhxaFhSSmNISWQ4bm1NR2VvZTgxOGlUOWV4bzNDa0c3SWh5?=
 =?utf-8?B?c1YxWVpJdTZuRmRRbnNOYjdia3NXMU5waEtLQTNKWXNpTVZ2U3lBNFJodmxG?=
 =?utf-8?B?OFphUFZob2Q5dGpuRjJ6VzhsbXlEMk4xbkF4a0pzcDVyeWg0bTZwd1ppMlU3?=
 =?utf-8?B?cUg1RUFZblVrQWszS3MyM1Ftdk1nTVNtQXh0MnQ5a1NOdldKRjZ4eElxd01H?=
 =?utf-8?B?UitrZ2oxR0hDalJJaDZDNFIvTXU4d0p3Vjh3SUN2VWlnWEtCQjRRSy9PNkQ2?=
 =?utf-8?B?d1VZS3l3R0llUW9tNFM1SmdwMXhmUnVxSkdKcHZXNHkrNHkrWkVjdnorQ2Na?=
 =?utf-8?B?d1Q3K0tyOHVoeWpReS8zVS93YllpT1hXd0FqL3oyZyttdmM4SHNPZHIyWEtO?=
 =?utf-8?B?aG9GZllVeERicnp5Y2ZqaFVpZTFHYWgxSGM1eU9VM1dlTzkyTUhmbUN1aTgw?=
 =?utf-8?B?c21LbDY5azB3dHBkTXBHMlREdDRoZDIrMVI3OFJMTXVwSUhHZVdWTFFadzBh?=
 =?utf-8?B?bmRkUzFBOFFGZzVUaVRQRGQvdDdQZUFBSFhTb3BFSVpnTkpZQ1l1OFYzb2hw?=
 =?utf-8?B?bUsvbHVyYTNhZGxFdHk4RWtEaVVXSnY5SVgwN0tmU3Q5RitmWlRwemRRLzlU?=
 =?utf-8?B?UFN6bVBsRE1RR1JtcDVxZnF6N2tIZTllUVphbitGNGtxQ2pmd3k3R0dwY1M2?=
 =?utf-8?B?UDVtMm1ScDlTcy9sSzQzNmJDa1B1b1pwNXZ2VFhuTitYSm9DbDhlU0htNkh6?=
 =?utf-8?B?Z1hrZUlFUjIwOGVuK2k4OXVMM0FLdEdleklPUmJoaFhrMTREeUZsNmZxNWVl?=
 =?utf-8?B?YW1HdE5ROCtWN2F4Z21taGlnU01rQ3Q3cCtWUVQ1UTFNT3NpQjh4Mk9kQ3Fs?=
 =?utf-8?B?Z1R6alAvL2c0QzBxVDA5cUVyVjVoWlFuc3ZoaTRMOEVLN0NlcnFqV1BsSnB5?=
 =?utf-8?B?VFd6NWx5UVI0M01FRC9YcGh4M1pOd29pRFEyVS9rZmU3ZEExY3J1cm5rZkV5?=
 =?utf-8?B?eVlCUDVqekRzSzU3c0ZBMldLQlNzQ2kwRmZYTkxsQ1BiZHQvdUt5RmFkdlh4?=
 =?utf-8?B?YkRNa1czbVpGYU1xaXRSa1Zxc1dvYVNxWW9KekNCbXMzcHNqV1Y1ZG1RL0o0?=
 =?utf-8?Q?Ca81+7STSPvaMAp49Zb9Q0wNxfaIs9RHfeIXNOBJ/MGIi?=
X-MS-Exchange-AntiSpam-MessageData-1: 37DmZXGHJ+WDQA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87693b5-9d0e-4edb-c534-08df334274e8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:21:03.4507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBp1uQd8/Yd3pBnzbIW3D0jDIJHCVo77buYSZryfdHn2430gbUeWsFjycEMKvSBY8R/GeiGxXjUC37/ZH0ICcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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

iommu_get_default_domain_type currently forces an IDENTITY domain type
with CONFIG_ARM_DMA_USE_IOMMU because the ARM DMA implementation
traditionally installs its own UNMANAGED domains.

The ARM DMA implementation now supports core-owned DMA default domains,
so remove that override and follow the same logic as CONFIG_IOMMU_DMA
platforms. The static assertion making CONFIG_ARM_DMA_USE_IOMMU and
CONFIG_IOMMU_DMA mutually exclusive is removed as both now implement the
same callbacks making the build fail anyway.

Based on LLM eyeballing, some platforms are still not ready to be
switched over. For these platforms, a def_domain_type callback returning
IDENTITY is added unless it was already there. Specifically,

- mtk_iommu_v1 only supports the domain it internally creates via the
  arm_iommu API
- ipmmu-vmsa creates its own shared ARM DMA domain. Also creating a
  default DMA domain would exhaust contexts on configurations with only
  one context
- omap-iommu among other things due to the omap remoteproc driver,
  which relies on detaching the legacy ARM DMA domain to restore direct
  DMA ops
- msm_iommu expects previous context assignments to be released
  before attaching another paging domain

These drivers can be migrated later.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/iommu/iommu.c        | 20 ++++----------------
 drivers/iommu/ipmmu-vmsa.c   |  6 ++++++
 drivers/iommu/msm_iommu.c    |  6 ++++++
 drivers/iommu/mtk_iommu_v1.c |  6 ++++++
 drivers/iommu/omap-iommu.c   |  6 ++++++
 5 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5fbb76d44a1e..e47f95fea44d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1884,18 +1884,6 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 
 	lockdep_assert_held(&group->mutex);
 
-	/*
-	 * ARM32 drivers supporting CONFIG_ARM_DMA_USE_IOMMU can declare an
-	 * identity_domain and it will automatically become their default
-	 * domain. Later on ARM_DMA_USE_IOMMU will install its UNMANAGED domain.
-	 * Override the selection to IDENTITY.
-	 */
-	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
-		static_assert(!(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU) &&
-				IS_ENABLED(CONFIG_IOMMU_DMA)));
-		driver_type = IOMMU_DOMAIN_IDENTITY;
-	}
-
 	for_each_group_device(group, gdev) {
 		driver_type = iommu_get_def_domain_type(group, gdev->dev,
 							driver_type);
@@ -1912,11 +1900,11 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 	}
 
 	/*
-	 * If the common dma ops are not selected in kconfig then we cannot use
-	 * IOMMU_DOMAIN_DMA at all. Force IDENTITY if nothing else has been
-	 * selected.
+	 * Without an IOMMU DMA implementation, force IDENTITY if the driver
+	 * has not selected a domain type.
 	 */
-	if (!IS_ENABLED(CONFIG_IOMMU_DMA)) {
+	if (!IS_ENABLED(CONFIG_IOMMU_DMA) &&
+	    !IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
 		if (WARN_ON(driver_type == IOMMU_DOMAIN_DMA))
 			return -1;
 		if (!driver_type)
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9386b752dea2..39dddc3467a2 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -873,8 +873,14 @@ static void ipmmu_release_device(struct device *dev)
 	arm_iommu_release_mapping(mmu->mapping);
 }
 
+static int ipmmu_def_domain_type(struct device *dev)
+{
+	return IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU) ? IOMMU_DOMAIN_IDENTITY : 0;
+}
+
 static const struct iommu_ops ipmmu_ops = {
 	.identity_domain = &ipmmu_iommu_identity_domain,
+	.def_domain_type = ipmmu_def_domain_type,
 	.domain_alloc_paging = ipmmu_domain_alloc_paging,
 	.probe_device = ipmmu_probe_device,
 	.release_device = ipmmu_release_device,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 4ef1e8c8244b..7d7e91ffbf68 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -691,8 +691,14 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 	return 0;
 }
 
+static int msm_iommu_def_domain_type(struct device *dev)
+{
+	return IOMMU_DOMAIN_IDENTITY;
+}
+
 static struct iommu_ops msm_iommu_ops = {
 	.identity_domain = &msm_iommu_identity_domain,
+	.def_domain_type = msm_iommu_def_domain_type,
 	.domain_alloc_paging = msm_iommu_domain_alloc_paging,
 	.probe_device = msm_iommu_probe_device,
 	.device_group = generic_device_group,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index e907c9953142..8d8235f55050 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -578,8 +578,14 @@ static int mtk_iommu_v1_hw_init(const struct mtk_iommu_v1_data *data)
 	return 0;
 }
 
+static int mtk_iommu_v1_def_domain_type(struct device *dev)
+{
+	return IOMMU_DOMAIN_IDENTITY;
+}
+
 static const struct iommu_ops mtk_iommu_v1_ops = {
 	.identity_domain = &mtk_iommu_v1_identity_domain,
+	.def_domain_type = mtk_iommu_v1_def_domain_type,
 	.domain_alloc_paging = mtk_iommu_v1_domain_alloc_paging,
 	.probe_device	= mtk_iommu_v1_probe_device,
 	.probe_finalize = mtk_iommu_v1_probe_finalize,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 8231d7d6bb6a..56cdc4c670c0 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1712,8 +1712,14 @@ static int omap_iommu_of_xlate(struct device *dev, const struct of_phandle_args
 	return 0;
 }
 
+static int omap_iommu_def_domain_type(struct device *dev)
+{
+	return IOMMU_DOMAIN_IDENTITY;
+}
+
 static const struct iommu_ops omap_iommu_ops = {
 	.identity_domain = &omap_iommu_identity_domain,
+	.def_domain_type = omap_iommu_def_domain_type,
 	.domain_alloc_paging = omap_iommu_domain_alloc_paging,
 	.probe_device	= omap_iommu_probe_device,
 	.release_device	= omap_iommu_release_device,

-- 
2.55.0

