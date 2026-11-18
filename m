Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079FC606A885
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IPJqcUyT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D661A10E710;
	Wed, 18 Nov 2026 00:36:51 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B1589364
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CV333uyPZwsCm2ZNAm1zydJRTmgER1gIfDfl4fNYxGZFpxPD1y+BZtwhFCTUGiiTH8IG85ynJ1tygNPVzvnFLekIXKg8Kxn1JrgAm0vvcEL841U6xRRnMcey1mzXa7ojBO6KUeI6UL6Yo5e5tAtj103dRWrRAVdZZhIDIYB6NNYFEClpEnLO+n6WI4c8LOwEJPR6+DbAsUL7SeFlUsC9uqw1UI/bpuluJ38zJx+ImgnXbL+wER0AFPsnEXe7eRNYHQUxLQayAMK2FV3SnUXisMOiJD/hQDRpATA+8I5HVw43nN/zT72721J/aXB4t9XrRTYPu9RDYiLBrveKgbQW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVmDMwMbzuuQrorBOWRocj36NnGlmcrCZx58QcX6CFM=;
 b=Zm1SWKc71jFpebRIZ7MPdMZV0srn56OXZtZjh3cDl83I83XGpaZA38Na4Bf73hFeaOLKhM1lIwzF+te0UKW7uvJYzHP48L1McM3l1ILumQ+C7a7RJp0Cy4X2b1jX9RGCxcij5vYqN7yC7TGZEH0BCT19ttANT4EVwKj6IOcncP68RRdqV0Flu3fDWKmJztbdRj1/1cSlE0gkCCU2kaxqhf9qwXfdsmtXVimagx1cnD1qU0EBi2G2YBEeR/ZGQA/rv6i21xxarDcC9JAhJN9kRPFXI3e1VbAseLwHvqg3lb1CkMLrB4kepAJCX+iDLnByLuSIn1iJelUzJ0ZUY4u2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVmDMwMbzuuQrorBOWRocj36NnGlmcrCZx58QcX6CFM=;
 b=IPJqcUyT30Gp5SZK9ab+QRb/IWAV5B7VR2lP0nwAxqbIew8YG20Yt0z8cK+MUUBvcXR3+NV0rcF947Gr+UmPYrjnngaXUEnZ13+NC/sp4xRdg4XawJgY68jRFn48kDSteetkkydL7w2nkAMyaZnbEBrkeuKPiJFZ49UogW3LpwM5qbyQ58I9TX7t7ilhe38e/+ui+SkIoiI0f4xEPH07+OkdZ+UP+raFUp195/i/j8Jq4gUq5BQoIqaGeHCbGg7A1xoiqCQqD7OUXZWtzcXT3kNBEEjI4liB0vKVXjS7lst6nVs2994aLI/4BKLf1nDhlOi+8suz8Cxo/0eJH2w4Sw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 00:36:31 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:28 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 18 Nov 2026 09:35:14 +0900
Subject: [PATCH v4 05/12] ARM: dma-mapping: Implement and expose DMA setup
 functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-b4-arm32-iommu-dma-cookie-v4-5-0c5561288e22@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 70610255-afb9-4d57-0a0a-08df450bfc1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|23010399003|7416014|22082099003|18002099003|6133799003|261009223027099003|3023799007|921020|5023799004|11063799006|56012099006|261021135927099003|261102123227099003|261026130827099003|261102130727099003|261026140227099003|261028144727099003|10067099003|261022113327099003|261021130227099003|261022105027099003|261021121427099003|261026121527099003|261022115727099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: EMe1EA4ZbnWcVPt7kZ5DqRfvSGqaaMfXp+lUL+SwQUknpLjyHTytCWU6XOqsaNKelpJUv0OvLfF8Q8bNXd9BtkF8Ss8vSu98IkHRHAl7m1VzJtEeTJiddltO2c//JraP8RQar9ZQ+wkgLDljbJAF0mKmWh04jSFNdV43MybqaanZ5pUYmDLOP4cLEvgE7+VANOFWHB6kNAr2eipiTVZGxpMlr+N97yF59JD1u6hcriIAVgItnTzzN2bNpiRFvRFtkfYLbBDAlkiVSWYjMdh3HxDSUAPuPTM7RkOdquWPn6BXAntGPyxHEtyHGTf+/lB6iRwVrhIzl9+aRLAxPDJwxSuWbBpyhZxhy3qw6gZxZsd7PeNprqYZOatfeKDMOorTfm4iTu5UTN5Qt/5XZgUD+egGIWU/zaMDAwvscNQ0DRyBdSUHGniNCoOxYUX3Mr/SYNjAbMqCe31i6xCWniAulFFsa33k14UdJ3sn1OEwRcLnW3E9yp67RqvkOHDG99WEFewkCEeUW4g8tglmW7eX0rW8J42vYH5MNXZ0Yt11ttIMyzu0lpqp23I6hX/jwqZ+jC2711FdIKcnznc+ZnGlw5k7oUPVqHS9cL0y5tNdtRReecoOoTP8tXBOKduehgEVdcs/49OvddnxNjv0ZRfxg39KHYX/4EjyuKNo/wM/C0DiuCHOQSsgJmNjCYNDRtOlSU+XimsskhRBoCtm9DSJJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(921020)(5023799004)(11063799006)(56012099006)(261021135927099003)(261102123227099003)(261026130827099003)(261102130727099003)(261026140227099003)(261028144727099003)(10067099003)(261022113327099003)(261021130227099003)(261022105027099003)(261021121427099003)(261026121527099003)(261022115727099003)(261022075727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU5McUZlQmxWSS90T0Q1Mjl3WnVtOHBHWXlLZlU0M0FmUjB1YzNZZ0NxZVVy?=
 =?utf-8?B?WWRINU5wRm0zZ3d0SncrTXhVMGQ4RWk1UjR6SHU2RUhIeHo0cFBBS2ViRDNO?=
 =?utf-8?B?TVU4TUN3RkVLcHUrbEd3OGFKdFowR0U4RVduMzRhRGF6THJkRHFhcmNmYlJw?=
 =?utf-8?B?K2k3T09UNDFSejJQQTVCM2g0REwydFlaMEJ1RlN4eXljbnJ4YVdDUGtNbmdD?=
 =?utf-8?B?UVI4dlBPd1ZCeXBXaXNwRTFHVFhrV0xhQTkycmVqUFI5VnY2Ujl6MTlwaXI4?=
 =?utf-8?B?MmE2ejlueDRNTjB0R2d4Nzc5S09lcG5wUWd0cnhkckNjRTFMajg0OFd5Ty8z?=
 =?utf-8?B?TEgzb0M1VGRKaDBJanVQZmo4SU50SFdVYm51azQ0K1c5RW15RDRueVFBa0xu?=
 =?utf-8?B?WUVFT29WS25Sd3dKRlphaWxkM1JSTWF1VEV6OEFGMnIyMVlyUXFoM0VmbmdV?=
 =?utf-8?B?SE9USE9oUWNDS1BTU210RFBxMys0T01wYXd5YWtRSndTcnVtYWw4d2taTHRP?=
 =?utf-8?B?Zzg0TWtxS2psQjN6MzVtRk9BTGNrQU5EOUt2SWovSWtLUldtdlJtYkhOcTM5?=
 =?utf-8?B?TUFyeHhMY0Ntd2M3RU00TE95M21CZWZvZStRTDZMVFJoVFRoSWhMSEptZ3Q4?=
 =?utf-8?B?MzA4SHV6YkRxb2RVKzFGZHVMeUFKclJzUWx3VkM4R2VEYkxwVlRyWHBsSmdZ?=
 =?utf-8?B?bTcrVnpmenBtTGZ1NSsycXVITlNqZ1hRaDI1dGtKbk5JZmtjSmt4Q2pGRmtB?=
 =?utf-8?B?V2J1TEdGVC92eUttRlVhaGlFdUJyT3kwWm0ycWpXeGcwVTVqeTV4Nnp5N25j?=
 =?utf-8?B?cVB1SEN3QWlhQmpzNFNIelhscFlibDdQdkhpamR5ZXpaYzVrSzRCVUh1N2Vn?=
 =?utf-8?B?WnRwYmdna3dMK3pXdGgrTUlEUkFkNEJETHcvb3FiRFIvQjdvQ0VtK3FHNjZJ?=
 =?utf-8?B?QU5tUTk5T3lDU2NiTnNTeExvV1grMFphRnRQL3hBOXcxSktrOHh2K2ZLRlVF?=
 =?utf-8?B?Z1RLYmNCdGNOK0Y4ZXo0dmRXSGFVTVpPM0I1SVRRcGNMa1JJYmIzVWR6QklH?=
 =?utf-8?B?NU02MXVaM1ZrUlRDOHBmaGtDNENnc0hEckxLNXVrN0ZkY1FybmRqcW4yelRU?=
 =?utf-8?B?TjU2UHI0RHpERE5KSFdjY1F2Y1A3ZWs0SnBjNXFjSSt1SFVuYTY5VzFwcVk2?=
 =?utf-8?B?T3djcjYxK0Q2WmtGKzFiY2FyZllMZmczbWxLSUVMWXM0VFdLR21IQkM1OW1T?=
 =?utf-8?B?SDlseEpRWS85NmpFNmIxRm9UbmlGZy9PUkluTU45b0Exa1o3dXRHZ3FiK1Uw?=
 =?utf-8?B?dmJjU0hIRGV1YU1JTWxVcTVZUUZTazJZSzk2YVRTbTlidzlHcEVzRXA2bDZO?=
 =?utf-8?B?anNSbUcrUFZPYmFhWTRITTFCNFpmVVJaTGc5Umd0cElGMTI1QWR3SEdjdEVK?=
 =?utf-8?B?bzUzTWtxOXJrOXllR3NtZml2UVFlZlduNXRodkRSYlI2Sk5KOVVKays5Zmo1?=
 =?utf-8?B?NXE4dDVPQ3hFZUw4cUptNVZuUW9JYitVRUp3YnM1V0JHOWJOdThlaWw1SXRs?=
 =?utf-8?B?WkxOdWNmZ2RUbzZNVDYwMzdMQUhrZVhZZE1lYlEzNU0wZVR2dDNTYzFkZGR1?=
 =?utf-8?B?V05CODBWSWFGSkdYQkNGT1h1UlI0ZllUdXAzR1N5d0Z5eGJhQ2txNjZRbTdF?=
 =?utf-8?B?dUN6alNTeGl5OWFzY2UrbTcvWjJoRjVscXFFQzNrcmVOOUxZMjdwblFzYmRz?=
 =?utf-8?B?eTFZVnBmZFhUQmx6MlZyQ2NUK01MOXB6c0JEMzhxcTJza0ZBTGhXbWt1YnNv?=
 =?utf-8?B?Q3Q2dWorRTQ3RHZ3MVJGdTIwblN1dWZZWFpMQ2t4OTgyV3hhN040VG15ZGFO?=
 =?utf-8?B?MTIySEg4NDJLZ0xpbWZEaCt4TlZqUHdJaW8wQjhoZkJYQkphUTBMM1hrWE1S?=
 =?utf-8?B?djF3OWhoMC8zL2RaK2YwdHcrazlOZ2p3d1paemJHZG95Y2YybFRxMnFOcDZB?=
 =?utf-8?B?RUFQSzB4eEZlZUMwWXMycGhMZmV4bG1XQU50VGJGQ2wralFUNVVBNndmWEJM?=
 =?utf-8?B?YlRqSmc3SThDODNFK3hTUjA2RWUyMnJTR3VGZW1sdHEvL3dQdU9pQzY4aU1l?=
 =?utf-8?B?MmdGWEo3Z0JWZ1BMdVlzc1dlSGlqN3FZWk5WUXAxTS9LdkZ5RndmM09MelBz?=
 =?utf-8?B?ZktJOXhxcFA5aGs4QnpTYzBpZG1GSjVEUDNxbEtMSDJMbG9ZM2c3MTNmQzVV?=
 =?utf-8?B?Z3lYOFFla2FBWlZLenIxY3JYb001T0VJa2pvR3BCamlIbzBWTVQ4SHl1UlJ1?=
 =?utf-8?B?QnlsSk5ZZmt6d2xPb1F0M05ybGRXeW5xbktLVXVqa0dCaDEybkhJSHA2eGI0?=
 =?utf-8?Q?mR/AiuD7bLpZgXUzwqYAtepcoMFnoAZSyp6oWVDIl7CPg?=
X-MS-Exchange-AntiSpam-MessageData-1: BL5ugiO6txjzSg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70610255-afb9-4d57-0a0a-08df450bfc1f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:28.7719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKEkFI7jNKCi7Aeu9149/QTDJPeQqzat7BI4O3zrvbC0e7rpUWdQQsZUEIV3AIu5uz1ilj0GKCjFJEQm72I64g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C
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
index e3de7be174e5..01646521b5cf 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1524,6 +1524,96 @@ static void __arm_iommu_free_mapping(struct dma_iommu_mapping *mapping)
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
@@ -1534,6 +1624,9 @@ static void __arm_iommu_free_mapping(struct dma_iommu_mapping *mapping)
  * IO address ranges, which is required to perform memory allocation and
  * mapping with IOMMU aware functions.
  *
+ * Unlike a default domain set up by the IOMMU core, the returned mapping owns
+ * the domain it describes and releases it along with the last reference.
+ *
  * The client device need to be attached to the mapping with
  * arm_iommu_attach_device function.
  */
@@ -1597,8 +1690,10 @@ static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
 
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
 
@@ -1607,11 +1702,17 @@ static int __arm_iommu_attach_device(struct device *dev,
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
@@ -1649,12 +1750,14 @@ EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
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
@@ -1662,10 +1765,25 @@ void arm_iommu_detach_device(struct device *dev)
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
@@ -1720,6 +1838,8 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 
 void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
+	struct dma_iommu_mapping *mapping;
+
 	/*
 	 * Due to legacy code that sets the dma_coherent flag from a bus
 	 * notifier we can't just assign coherent to the dma_coherent flag
@@ -1730,10 +1850,14 @@ void arch_setup_dma_ops(struct device *dev, bool coherent)
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
 
@@ -1752,6 +1876,7 @@ void arch_teardown_dma_ops(struct device *dev)
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
2.56.1

