Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE4606A319
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Wv2B+uMX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E86E112996;
	Fri, 23 Oct 2026 05:14:38 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010043.outbound.protection.outlook.com
 [40.93.198.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38A1112975
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 05:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJ6MgBdtoQFFS3hpWu/0aW2OXnDSb/Sys/UVzj6+zV6ji+6avImL5vju9XZh5o6enQda/8UVNej3MF0a39fvVyZ+6MBKBdUXUmYrVOr1LmU48aIZDsN4m+qnqFNT0/mKRRIPjaftd/u5LAu2XPY9ceJwXglfFLqiBkfZuuxxUJhIMjsAViZC/Cf6AhO7OtHo3u4MRmhLdadqQSHAEFDnqqE07dI5OdpQEKX8Zko6nDlAdFUUok5xiXe9dHvJ2pJnVGUakqYMyiMf+0cW2SWfzQFdlHdA7bs0DVNwAB1VfrYx7WF7Wq2V0hesry10ZX9LU6ciQZwFGhImtzYnu6bPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HGbAcZ+uAZtDLxyXfE1sVP01NiSulntFXer27tAqqA=;
 b=Yl3iNRzYYv18p0JmWOm3+ziUqXeLdKjUNFghYctoundTpBsM9UqWVe6c01yKP/N40XKeYB/yY6/dEyi+53DezMtoGgA2cFYsYBnIDmNZukQgqI3c0i7YkjXJIxe0AlFDMauawDX9KJ31kJiUhk+7JJZK5GPXaV2Vdy8Fn6QkBsml9cLV4ujoyBz9a6MAijHbgQx/D2bAHcuP8zod2sHqpDl244ucEzEK87NhW1qImswHJZTAc+Phu9jQMyWwVmumD4Wo8Y4as2j7xU0Zn1zlupdF5+UVE+0g9vY1eAhIZYFbWOzvQxzaRy3OCL6f+/sdrQRlJapuse36vVTQ7ypvJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HGbAcZ+uAZtDLxyXfE1sVP01NiSulntFXer27tAqqA=;
 b=Wv2B+uMXQ959Ft74u1dHKEeFnBOtsXZCMxQYTVJ3VvpD0zGYATGkhh/5Wql/iqiyHsUUsAynfU+QmJ1F3IDm8TH2Nacfn5b5oztcwqst6D4FIjimY23s4hmiqSZdLOovThRavxl38kgU/5PXtSPdIA4iwz0UCvoM5I0SsWmNhevANxYbVFZGxitS7P1Q/kd8XLiXSAyvABbSCfgduLm4VbaiDxqeZ91m9IFu7IWSjTk3iSSOKXSKfMpi7spGPYMI6d/GUXM/hcJQuEukcEs7erc6tm88ozwl6gX4+QQBuxFcpVDFNKNFBK3BkAKk45GPKDIdsnAZPTMqjYrvRIK/Mw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 05:14:26 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 05:14:25 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Krishna Reddy <vdumpa@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-tegra@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 11/11] iommu/tegra-smmu: Use a DMA API default domain
 per swgroup
Date: Fri, 23 Oct 2026 14:14:23 +0900
Message-ID: <9NN3esQaTdOIroYwCH7uag@nvidia.com>
In-Reply-To: <605a143f-d452-408f-9fcf-259af8ad004b@arm.com>
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-11-b06842a01938@nvidia.com>
 <605a143f-d452-408f-9fcf-259af8ad004b@arm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P286CA0097.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c510920-618d-4e88-f704-08df30c4819f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|18002099003|22082099003|10067099003|921020|5023799004|11063799006|56012099006|4143699003|261022075727099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: HHvur91IMJQCp1qXPk50okhHDwwwzkAMRb1sc1bXYT/uHqVR5DCGTOLIzjOlEAAw2vrZIjfF56AUL+xzLDKemDLBJcxVUQpt30/2SrLP9TW1EjXDxB8nbnTPkaZmrIAMoMgePUXLHRxo1nDhGcVGEJgRPIAQydTrVaFM/hKdPIRYpE6ij07e2fYabTBZiq0AKsgvkqEDHHQz5+JL29JvhAO8FiacTvFfDd5j2TynL/JZWVjIQo5rwSpz2en1+Z6VdnPoj8nH/wRovFaNYT0r5TPFNiXlo5MIVzqqBDPh/N3FklLCawKV2v/nt2EtXfHR/1sVM/IazjDZMUZ1B1rbzIh+Y2PwLNZPwtAFlAIJ2Y1dl6OvQlcLxhm3vV4tPM/DFE62aZu+oogjOQiUkVyrcx/dZgGjbGF5DDX2PHqPpgWb5l7qeLXCWyOtF3NpLO+TjhwS0JbGcl+ykw4lpV7RHKwWV5OYy6Cg1eoCLxiTS387DUM6tAclD4QmC4PPuCPOZiTIsWyOxOQFsq0Mx/GzunOwNsIZFZNQcbglGdXIUYiseD1Bs+adossv1x66+oqwSaNYPV1BkvXpGIZ2esqsORtoELVGoDXLs53KSWRpc+l9j+rNRGTrzD3nv6kPhcAr4/Gc+1IB6YXIP0aNZbBf1LqACa+wsInSddZfb4tjrmQhNuwoP0LWi/gAEybeVEG16348pZYGMpOpySnUkc0KCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(921020)(5023799004)(11063799006)(56012099006)(4143699003)(261022075727099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFN0MjZabVVxaWFiUEVnYnpKRzQzR2R0RTI2dVQwYkFhakVUa0ExQXBOM01G?=
 =?utf-8?B?NzQzMTE4M2hkMy9BdDFFTkJZRmx0SzlXMnhVR0lhbG1wdFhIVjlvVGs0Wmlx?=
 =?utf-8?B?WGlFcUEvWkxHNkVCSDRHYmdZSkEwMGJkbURwU3F3dUNIZWFTZ2JoRzBEeXIv?=
 =?utf-8?B?bXVEZW92SlAyajI3YlFuRTQ0U0tZMThYM05tcVU3TjNSeUc5TXRlM3FGdzRv?=
 =?utf-8?B?bm9vM1QvNGQwd0JGMm5iU1owWmY1K1Ftd2RXZnZITmhMaVdpbUp6Wm0yRHJK?=
 =?utf-8?B?a1ZvQ3lwMGozemRJSGZtaEE3eitsbHV4Z1cwOW02NkFpb1VvWEJFMHpBUTJ1?=
 =?utf-8?B?RC9TT0pGTXc1d3M3KzZZVVlYaTVCTzRESkpLUGp1YXFpMDQ3TFhhRlNBYVIr?=
 =?utf-8?B?TFUzaU15dXlLRG5xcXJTbVlmZnhLaEUwZi82bmNOK2RvVDZQNWV5RWR0Tmxj?=
 =?utf-8?B?dVdNQlRqWTEvRUtCczZ0cFZVK3p6c09GeDBvK2xzeG5xT25wcG5RY29IdDZZ?=
 =?utf-8?B?NWNmK1lXRkdaYVhrV3lwODkraXhVN3Nra3dYTW5CSFJ5QXBta1hqWU5rbDly?=
 =?utf-8?B?emZJcDhTUCtXRlhvNUJHWDlDTjlwcmR1UkpsZFNaZGptYy91cHFYbjVLaEY4?=
 =?utf-8?B?eVU4cGl5TGZSdWMrQ0s1UlBISjJMYm80Uy8vL3B5ZGFteml2eVZZdWhRQWpG?=
 =?utf-8?B?Zmc2dnJ2cGtZdURPYnBCWTBXSWkrbzVyeHBrelFSWk1QSU9sMm4zYUVJeWo4?=
 =?utf-8?B?WTZnYXp2bDYxUzBEM21kOTFjQ0RianpjdUxyaEZ1V1J5WDNRdkczUjdmNjkw?=
 =?utf-8?B?Zm01ZWZjUTROTGgxNkhNUm9ncEVQVnF2RXU0ZjQyNTFkWVZHbGNFWHN6WXVw?=
 =?utf-8?B?WE54b29NWUhYUi9ib0dtT0VhOVRxbGx4MkljUkNuTVQ1OGJuVnhVbjNxNHdl?=
 =?utf-8?B?RnhkaWpMdm1mYWRlYktsOTg0cG5hNGZJSUdFdUZOa2RhNmFlaFRLNkNmbkRF?=
 =?utf-8?B?bjBPVVJML1RQdDJaRmFOYVJxNm5rQXgvVnlYbmJ0ZHZ3VEhCV3pocjF1OEhS?=
 =?utf-8?B?LytNelJ2ZE9jODc2OHJBVGovcG1pUWhvbDRhSDMzVmFqK09zbnkzOG9BajJO?=
 =?utf-8?B?NlJ3SFJPV2lzdXVISWx0aXluanRMdVhIMjNNRHVIV21Pak4yamVaN2lZdWVu?=
 =?utf-8?B?MlVoeUg4WVpybElvRi9KclJwekMwQzFnbHlJRWVicjQzQUpibHA3blFOdHcz?=
 =?utf-8?B?V3JHbmFoMUplNFVhY2U0c1hvbmxBNk4ycWhJMFBXekNPR29VQjhUWTg3emY1?=
 =?utf-8?B?RDhmZnhKVVVVR3VIKzZjdnBHWWQ0WVZia1c5cWdyMHBrVFBMMzllNHpiRlZ6?=
 =?utf-8?B?SnJDTXp4c1lpYlZRUXQ1RjQ2eU1qczd1MnNoeXV6ZW5CbXBFcitrUmF4OGVR?=
 =?utf-8?B?M1Vvcm1oQ0pZQjdYTVVxa2ZqMmNhTkd3WVRuTVFSTll4K2kyaTBaVUVYK0to?=
 =?utf-8?B?elU1MFh2VTFXazY5RmRGM0ZJelFJeS90UjNYUEQ1Wnd2M1Q1RHljUXNvOGZq?=
 =?utf-8?B?V0oyajBZWlNVY2tObmJ5MHhlYVJvYXVNeXUxUk1WYTNhLzF4dGlZeHVHTlBz?=
 =?utf-8?B?aStyRHk4ZU5DclVnR2F2cHYzWWx4S3lycWk5NFJnK2JrUmVhTlNwY1BwY25y?=
 =?utf-8?B?ZW16SlgvQTEzQURaQkgyb242bm9aa0VkOWpPSnVFV09ubzVzQlE1K2tYNkJh?=
 =?utf-8?B?QlUxcjgrcFZLUlRVdFBHODlPNWRnbnMrRURETlc2aExWem4vU2laLzZYa1NQ?=
 =?utf-8?B?U2tUeDF2VzRGTXpZcGNFTHkwanVyaHNrTlVjZXNsNTNXK3U5R3lmNGdwQm01?=
 =?utf-8?B?ZkcwT1BILzdKckxDa3pBazY1L25nQ0JZcDkwU3JyS0d1dG5odm4vMmc2Yitu?=
 =?utf-8?B?dnAraGQ3NnRHRlZnb0hoUi9NeTI3bDA1bGtJdm9nWHFaVVkrV2ZBdnBUKy9D?=
 =?utf-8?B?dFFmMVR0TU1aclFiMkVrZmNmTkpGbThTQXJIdHZLZitUcS9zMEJJemhyeHVH?=
 =?utf-8?B?ZGtHajdTQ1lYMFcyOWZFbXBNamJYMzJSUVQ1eTJDd1ZEZ3RNbk8wMmlXamho?=
 =?utf-8?B?bHI5c0FQZlVmaUozbGQxQTJXeTFIS1RnREFjdXpJUHNmTlFvSXBGcmtqLzhI?=
 =?utf-8?B?WWhnOGJVZXlGSjdaMXRtRG1sSkUyMEFvKzhuVFdzVTl2MldIUUFRdFFpMUlz?=
 =?utf-8?B?WG1RemlCdm9YZCtXdHpHYjFZaUtQUUk3anJLVmRNWmIxYmpKU3BmMUlFSkdP?=
 =?utf-8?B?SHE2aUVBbjUrUnE2MTRPSEw5cGN4Y3NlRkVpV3habjNRNDYwWjBOMVMxdUV1?=
 =?utf-8?Q?eQcsQARA9q6aPHny/U5iFr0f92hz9fVXpdcOROa9JT49i?=
X-MS-Exchange-AntiSpam-MessageData-1: 4wYd7xmTZsFMgw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c510920-618d-4e88-f704-08df30c4819f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 05:14:25.7617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VC2CqTQLN9VPYVEmJCq5REH0ffB4WTNakC2tTp2OpImOmp/Fm5EJyj/PPh3rvY4ix6lB9HKUU8lEmWInKjZCaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wednesday, October 21, 2026 12:30=E2=80=AFAM Robin Murphy wrote:
> On 16/10/2026 7:46 am, Mikko Perttunen wrote:
> > Everything is now in place for the Tegra SMMU to give devices a real
> > IOMMU_DOMAIN_DMA default domain.
> >=20
> > Some device drivers still rely on explicit domains (and being able to
> > detach a legacy ARM DMA domain if any), so DMA default domains are
> > enabled on a per-swgroup basis via a use_dma_api flag. As drivers are
> > converted to DMA API usage we can eventually get rid of this. Initially
> > the flag is enabled for TegraDRM and Host1x devices.
> >=20
> > On multi_v7_defconfig (where CONFIG_ARM_DMA_USE_IOMMU was always
> > enabled), this will fix TegraDRM probing with certain probe orderings
> > where the legacy implementation's lack of support for multiple devices
> > in one IOMMU group would cause breakage.
> >=20
> > On tegra_defconfig, as this now enables CONFIG_ARM_DMA_USE_IOMMU, all
> > devices move to either the legacy ARM DMA path or the new one. This
> > should in principle not cause issues as the drivers would already have
> > been verified on multi_v7_defconfig.
> >=20
> > Also set .release_domain to the identity domain to ensure the AS is
> > released appropriately now that the domain can be non-static.
> >=20
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >   drivers/iommu/Kconfig           |  1 +
> >   drivers/iommu/tegra-smmu.c      | 59 ++++++++++++++++++++++++++++++++=
++++++---
> >   drivers/memory/tegra/tegra114.c | 13 +++++----
> >   drivers/memory/tegra/tegra124.c | 10 ++++---
> >   drivers/memory/tegra/tegra30.c  | 16 ++++++-----
> >   include/soc/tegra/mc.h          |  7 +++++
> >   6 files changed, 87 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 6e07bd69467a..817e84e0e6ab 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -252,6 +252,7 @@ config TEGRA_IOMMU_SMMU
> >   	depends on TEGRA_AHB
> >   	depends on TEGRA_MC
> >   	select IOMMU_API
> > +	select ARM_DMA_USE_IOMMU if ARM
> >   	help
> >   	  This driver supports the IOMMU hardware (SMMU) found on NVIDIA Teg=
ra
> >   	  SoCs (Tegra30 up to Tegra210).
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > index 6779528a9e7c..1c1910f25553 100644
> > --- a/drivers/iommu/tegra-smmu.c
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -994,16 +994,31 @@ static int tegra_smmu_of_xlate(struct device *dev=
,
> >  =20
> >   static int tegra_smmu_def_domain_type(struct device *dev)
> >   {
> > +	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> > +	struct tegra_smmu *smmu =3D dev_iommu_priv_get(dev);
> > +	unsigned int i;
> > +
> > +	if (!fwspec || !smmu)
> > +		return IOMMU_DOMAIN_IDENTITY;
>=20
> Dead code - by this point tegra_smmu_probe_device() has already run (and=
=20
> we've literally reached this call via dev_iommu_ops(dev)) so the device=20
> is definitely valid.
>=20
> > +
> >   	/*
> > -	 * FIXME: For now we want to run all translation in IDENTITY mode, du=
e
> > -	 * to some device quirks. Better would be to just quirk the troubled
> > -	 * devices.
> > +	 * Only clients known to work with the DMA API get a DMA default doma=
in.
> > +	 * The rest keep running in identity mode.
> >   	 */
> > -	return IOMMU_DOMAIN_IDENTITY;
> > +	for (i =3D 0; i < fwspec->num_ids; i++) {
> > +		const struct tegra_smmu_swgroup *group;
> > +
> > +		group =3D tegra_smmu_find_swgroup(smmu, fwspec->ids[i]);
> > +		if (!group || !group->use_dma_api)
>=20
> Similarly, dev->iommu_group is already assigned with whatever valid=20
> group tegra_smmu_device_group() returned, so you could perhaps just do a=
=20
> single iteration over smmu->groups for the lookup.

Yeah, this was way overcomplicated. I've rewritten the function to=20
directly pass the fwspec ID to tegra_smmu_find_swgroup - much simpler.

Thanks!
Mikko

>=20
> Thanks,
> Robin.
>=20
> > +			return IOMMU_DOMAIN_IDENTITY;
> > +	}
> > +
> > +	return IOMMU_DOMAIN_DMA;
> >   }
> >  =20
> >   static const struct iommu_ops tegra_smmu_ops =3D {
> >   	.identity_domain =3D &tegra_smmu_identity_domain,
> > +	.release_domain =3D &tegra_smmu_identity_domain,
> >   	.def_domain_type =3D &tegra_smmu_def_domain_type,
> >   	.domain_alloc_paging =3D tegra_smmu_domain_alloc_paging,
> >   	.probe_device =3D tegra_smmu_probe_device,
> > @@ -1108,6 +1123,40 @@ static void tegra_smmu_debugfs_exit(struct tegra=
_smmu *smmu)
> >   	debugfs_remove_recursive(smmu->debugfs);
> >   }
> >  =20
> > +/*
> > + * The default domain type is a property of the IOMMU group, so all sw=
groups in
> > + * one group must agree on use_dma_api. Otherwise the core sees confli=
cting
> > + * def_domain_type and falls back to identity for the whole group.
> > + */
> > +static void tegra_smmu_check_groups(struct tegra_smmu *smmu)
> > +{
> > +	const struct tegra_smmu_soc *soc =3D smmu->soc;
> > +	unsigned int i, j;
> > +
> > +	for (i =3D 0; i < soc->num_groups; i++) {
> > +		const struct tegra_smmu_group_soc *group =3D &soc->groups[i];
> > +		int dma_api =3D -1;
> > +
> > +		for (j =3D 0; j < group->num_swgroups; j++) {
> > +			const struct tegra_smmu_swgroup *swgrp;
> > +
> > +			swgrp =3D tegra_smmu_find_swgroup(smmu,
> > +							group->swgroups[j]);
> > +			if (!swgrp)
> > +				continue;
> > +
> > +			if (dma_api < 0)
> > +				dma_api =3D swgrp->use_dma_api;
> > +			else if (swgrp->use_dma_api !=3D !!dma_api)
> > +				break;
> > +		}
> > +
> > +		WARN(j < group->num_swgroups,
> > +		     "SMMU group %s mixes DMA API and identity swgroups\n",
> > +		     group->name);
> > +	}
> > +}
> > +
> >   struct tegra_smmu *tegra_smmu_probe(struct device *dev,
> >   				    const struct tegra_smmu_soc *soc,
> >   				    struct tegra_mc *mc)
> > @@ -1142,6 +1191,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device=
 *dev,
> >   	smmu->dev =3D dev;
> >   	smmu->mc =3D mc;
> >  =20
> > +	tegra_smmu_check_groups(smmu);
> > +
> >   	smmu->pfn_mask =3D
> >   		BIT_MASK(mc->soc->num_address_bits - SMMU_PTE_SHIFT) - 1;
> >   	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
> > diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/teg=
ra114.c
> > index 2883c4f91144..024c63bdd480 100644
> > --- a/drivers/memory/tegra/tegra114.c
> > +++ b/drivers/memory/tegra/tegra114.c
> > @@ -1029,15 +1029,18 @@ static const struct tegra_mc_client tegra114_mc=
_clients[] =3D {
> >  =20
> >   static const struct tegra_smmu_swgroup tegra114_swgroups[] =3D {
> >   	{ .name =3D "dc",        .swgroup =3D TEGRA_SWGROUP_DC,        .reg =
=3D 0x240,
> > -	  .defer_enable =3D true },
> > +	  .defer_enable =3D true, .use_dma_api =3D true },
> >   	{ .name =3D "dcb",       .swgroup =3D TEGRA_SWGROUP_DCB,       .reg =
=3D 0x244,
> > -	  .defer_enable =3D true },
> > +	  .defer_enable =3D true, .use_dma_api =3D true },
> >   	{ .name =3D "epp",       .swgroup =3D TEGRA_SWGROUP_EPP,       .reg =
=3D 0x248 },
> > -	{ .name =3D "g2",        .swgroup =3D TEGRA_SWGROUP_G2,        .reg =
=3D 0x24c },
> > +	{ .name =3D "g2",        .swgroup =3D TEGRA_SWGROUP_G2,        .reg =
=3D 0x24c,
> > +	  .use_dma_api =3D true },
> >   	{ .name =3D "avpc",      .swgroup =3D TEGRA_SWGROUP_AVPC,      .reg =
=3D 0x23c },
> > -	{ .name =3D "nv",        .swgroup =3D TEGRA_SWGROUP_NV,        .reg =
=3D 0x268 },
> > +	{ .name =3D "nv",        .swgroup =3D TEGRA_SWGROUP_NV,        .reg =
=3D 0x268,
> > +	  .use_dma_api =3D true },
> >   	{ .name =3D "hda",       .swgroup =3D TEGRA_SWGROUP_HDA,       .reg =
=3D 0x254 },
> > -	{ .name =3D "hc",        .swgroup =3D TEGRA_SWGROUP_HC,        .reg =
=3D 0x250 },
> > +	{ .name =3D "hc",        .swgroup =3D TEGRA_SWGROUP_HC,        .reg =
=3D 0x250,
> > +	  .use_dma_api =3D true },
> >   	{ .name =3D "msenc",     .swgroup =3D TEGRA_SWGROUP_MSENC,     .reg =
=3D 0x264 },
> >   	{ .name =3D "ppcs",      .swgroup =3D TEGRA_SWGROUP_PPCS,      .reg =
=3D 0x270 },
> >   	{ .name =3D "vde",       .swgroup =3D TEGRA_SWGROUP_VDE,       .reg =
=3D 0x27c },
> > diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/teg=
ra124.c
> > index a38fbf2baf6c..17068aaf163f 100644
> > --- a/drivers/memory/tegra/tegra124.c
> > +++ b/drivers/memory/tegra/tegra124.c
> > @@ -1071,13 +1071,14 @@ static const struct tegra_mc_client tegra124_mc=
_clients[] =3D {
> >  =20
> >   static const struct tegra_smmu_swgroup tegra124_swgroups[] =3D {
> >   	{ .name =3D "dc",        .swgroup =3D TEGRA_SWGROUP_DC,        .reg =
=3D 0x240,
> > -	  .defer_enable =3D true },
> > +	  .defer_enable =3D true, .use_dma_api =3D true },
> >   	{ .name =3D "dcb",       .swgroup =3D TEGRA_SWGROUP_DCB,       .reg =
=3D 0x244,
> > -	  .defer_enable =3D true },
> > +	  .defer_enable =3D true, .use_dma_api =3D true },
> >   	{ .name =3D "afi",       .swgroup =3D TEGRA_SWGROUP_AFI,       .reg =
=3D 0x238 },
> >   	{ .name =3D "avpc",      .swgroup =3D TEGRA_SWGROUP_AVPC,      .reg =
=3D 0x23c },
> >   	{ .name =3D "hda",       .swgroup =3D TEGRA_SWGROUP_HDA,       .reg =
=3D 0x254 },
> > -	{ .name =3D "hc",        .swgroup =3D TEGRA_SWGROUP_HC,        .reg =
=3D 0x250 },
> > +	{ .name =3D "hc",        .swgroup =3D TEGRA_SWGROUP_HC,        .reg =
=3D 0x250,
> > +	  .use_dma_api =3D true },
> >   	{ .name =3D "msenc",     .swgroup =3D TEGRA_SWGROUP_MSENC,     .reg =
=3D 0x264 },
> >   	{ .name =3D "ppcs",      .swgroup =3D TEGRA_SWGROUP_PPCS,      .reg =
=3D 0x270 },
> >   	{ .name =3D "sata",      .swgroup =3D TEGRA_SWGROUP_SATA,      .reg =
=3D 0x274 },
> > @@ -1093,7 +1094,8 @@ static const struct tegra_smmu_swgroup tegra124_s=
wgroups[] =3D {
> >   	{ .name =3D "sdmmc2a",   .swgroup =3D TEGRA_SWGROUP_SDMMC2A,   .reg =
=3D 0xa98 },
> >   	{ .name =3D "sdmmc3a",   .swgroup =3D TEGRA_SWGROUP_SDMMC3A,   .reg =
=3D 0xa9c },
> >   	{ .name =3D "sdmmc4a",   .swgroup =3D TEGRA_SWGROUP_SDMMC4A,   .reg =
=3D 0xaa0 },
> > -	{ .name =3D "vic",       .swgroup =3D TEGRA_SWGROUP_VIC,       .reg =
=3D 0x284 },
> > +	{ .name =3D "vic",       .swgroup =3D TEGRA_SWGROUP_VIC,       .reg =
=3D 0x284,
> > +	  .use_dma_api =3D true },
> >   	{ .name =3D "vi",        .swgroup =3D TEGRA_SWGROUP_VI,        .reg =
=3D 0x280 },
> >   };
> >  =20
> > diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegr=
a30.c
> > index 0ee4715413ba..df6b5a499ccc 100644
> > --- a/drivers/memory/tegra/tegra30.c
> > +++ b/drivers/memory/tegra/tegra30.c
> > @@ -1140,19 +1140,23 @@ static const struct tegra_mc_client tegra30_mc_=
clients[] =3D {
> >  =20
> >   static const struct tegra_smmu_swgroup tegra30_swgroups[] =3D {
> >   	{ .name =3D "dc",   .swgroup =3D TEGRA_SWGROUP_DC,   .reg =3D 0x240,
> > -	  .defer_enable =3D true },
> > +	  .defer_enable =3D true, .use_dma_api =3D true },
> >   	{ .name =3D "dcb",  .swgroup =3D TEGRA_SWGROUP_DCB,  .reg =3D 0x244,
> > -	  .defer_enable =3D true },
> > +	  .defer_enable =3D true, .use_dma_api =3D true },
> >   	{ .name =3D "epp",  .swgroup =3D TEGRA_SWGROUP_EPP,  .reg =3D 0x248 =
},
> > -	{ .name =3D "g2",   .swgroup =3D TEGRA_SWGROUP_G2,   .reg =3D 0x24c }=
,
> > +	{ .name =3D "g2",   .swgroup =3D TEGRA_SWGROUP_G2,   .reg =3D 0x24c,
> > +	  .use_dma_api =3D true },
> >   	{ .name =3D "mpe",  .swgroup =3D TEGRA_SWGROUP_MPE,  .reg =3D 0x264 =
},
> >   	{ .name =3D "vi",   .swgroup =3D TEGRA_SWGROUP_VI,   .reg =3D 0x280 =
},
> >   	{ .name =3D "afi",  .swgroup =3D TEGRA_SWGROUP_AFI,  .reg =3D 0x238 =
},
> >   	{ .name =3D "avpc", .swgroup =3D TEGRA_SWGROUP_AVPC, .reg =3D 0x23c =
},
> > -	{ .name =3D "nv",   .swgroup =3D TEGRA_SWGROUP_NV,   .reg =3D 0x268 }=
,
> > -	{ .name =3D "nv2",  .swgroup =3D TEGRA_SWGROUP_NV2,  .reg =3D 0x26c }=
,
> > +	{ .name =3D "nv",   .swgroup =3D TEGRA_SWGROUP_NV,   .reg =3D 0x268,
> > +	  .use_dma_api =3D true },
> > +	{ .name =3D "nv2",  .swgroup =3D TEGRA_SWGROUP_NV2,  .reg =3D 0x26c,
> > +	  .use_dma_api =3D true },
> >   	{ .name =3D "hda",  .swgroup =3D TEGRA_SWGROUP_HDA,  .reg =3D 0x254 =
},
> > -	{ .name =3D "hc",   .swgroup =3D TEGRA_SWGROUP_HC,   .reg =3D 0x250 }=
,
> > +	{ .name =3D "hc",   .swgroup =3D TEGRA_SWGROUP_HC,   .reg =3D 0x250,
> > +	  .use_dma_api =3D true },
> >   	{ .name =3D "ppcs", .swgroup =3D TEGRA_SWGROUP_PPCS, .reg =3D 0x270 =
},
> >   	{ .name =3D "sata", .swgroup =3D TEGRA_SWGROUP_SATA, .reg =3D 0x278 =
},
> >   	{ .name =3D "vde",  .swgroup =3D TEGRA_SWGROUP_VDE,  .reg =3D 0x27c =
},
> > diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
> > index ea67972fd585..1cbd990fc0f4 100644
> > --- a/include/soc/tegra/mc.h
> > +++ b/include/soc/tegra/mc.h
> > @@ -78,6 +78,13 @@ struct tegra_smmu_swgroup {
> >   	 * tegra_smmu_enable_translation().
> >   	 */
> >   	bool defer_enable;
> > +
> > +	/*
> > +	 * Set once the clients behind this swgroup are known to work with an
> > +	 * IOMMU_DOMAIN_DMA default domain. All swgroups of a
> > +	 * tegra_smmu_group_soc must agree.
> > +	 */
> > +	bool use_dma_api;
> >   };
> >  =20
> >   struct tegra_smmu_group_soc {
> >=20
>=20
>=20




