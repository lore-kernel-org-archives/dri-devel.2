Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952AF606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jy/7Gz8m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE7AF10E216;
	Tue, 20 Oct 2026 03:55:52 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7444110E216
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 03:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMmt7TLH215xsbRnvZNqG6xjfdLTMzkQfOlFK26K8Ws+0auu4PKuFdgq2PQv+HIcIpJCCbU8/2wmXG9hsF9gsDXA/Zn04F7E7z9hDIDcyfuhgOs5mxwxmZMM8wLXOSmY0ntFczR31VrWv0y2zBAshHVdu6UZhNt5VzD96pcKyvIjvX8huBrQP7bcTpla8G256yGVAoHZElzwK4Etx97zHkvA3BXrvb+FZnUw40paSDAj1teivHRtV5yOqcHeb28D/CN75ONswJB+yX/fHunOfP41BG6X+alYVxfnjMlLnVGGMgNPCIUYZZ4YnrSO0LuhcVuQdF9KaJ95wgnPk6yicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB3EMeCLT6tUp6/1r4igHRDKO9JLOX6M799+v8giSI8=;
 b=ZKXEwW2IBspS7t53k7p2UvQJ2FDp0R23di3HfsfWZMFKgiPTPQ/m8BjRXzhYtB7v9jybC/8W5GGDjVTxwCb4JALrBGpWPPzzrOT0+Df8lqCii3NeLLO13H/XG0vwfuKAS3hc4wb9kS34h3OvmA4yUKhpWcPQxitl8vaP4XL0VV454CZpyCzkApJ11/H/Fzgy6a5aQm5RjYUF0/T34tShk5gSPHRQllBdeTXUNeEDeOsqwUQaajyoJ2PD7CFaRxP0gR1gvbPsWOdRw3UDPfaZhIzoSFQHWBlTA7lmxw8FQD8FJp2CslHdHNadi5BgLy0ZOs6t0NRAn//qc5ncPgCULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB3EMeCLT6tUp6/1r4igHRDKO9JLOX6M799+v8giSI8=;
 b=jy/7Gz8my3qMgIso+OD1Ntns728wnFuZ5yICXvZMivl8TmSJaGtuAraxDwvEOemm3ETX4s60bLPl5YoR1bcrLl35cc12HjeKZAJQZ2MlidIV75UxHhdQxyDxFRk5LIl/ZBuu+gb7i1DOA7VAFurJNuhNWLhrzazer87BfA3Za8Lrof4DaiPl1dV8CEVcmOzbUn51sgenSSD2ZvyA89v9gn2SFxo0+p+V0KO0jn3nRi4jrkuoxRIuGDG02K1bJryOfhYz3WYo2X2rQ65KOhbVUSfOOq9qm2GOpTYnMGDQPBtmJlg20eBdA/KXRRJaTCI7ncYrczk9s/SeT6zFx36Rzg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Tue, 20 Oct
 2026 03:55:33 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:55:33 +0000
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
Subject: Re: [PATCH v2 06/11] ARM: dma-mapping: Handle foreign buffers in
 arm_iommu_get_sgtable
Date: Tue, 20 Oct 2026 12:55:19 +0900
Message-ID: <lJdkrMxST1imtqkbsWFTHw@nvidia.com>
In-Reply-To: <52c9bad4-39f4-46cf-87c2-9e57e8beeb5c@arm.com>
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-6-b06842a01938@nvidia.com>
 <52c9bad4-39f4-46cf-87c2-9e57e8beeb5c@arm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P286CA0110.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be499c2-cea7-4e80-4dc2-08df2e5dfdb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|23010399003|7416014|18002099003|10067099003|22082099003|4143699003|261009223027099003|11063799006|921020|56012099006;
X-Microsoft-Antispam-Message-Info: nePAV7UVQp1RZna1LlatTSCgX51kICon8SatyM88NA0fh5gHEHWV5+Pp1b+Ga7r9Y4219TEKWMK2y7E8viJCn3yWCRc34VZFm4UEr4WxmE22CRdqMRqFIWhPUKO2SJ0uaHaxmFG1vyyqUxnMUBiQ+VqDRYrZsIV8iQidz9uqvPGf2Hb0E4BNvMLw0n0NKzEouIeglaBpVbTij5qdVjIx7cLMfPTC62kpseLoATQ0TEVtNm6pkW75nvSWDRkW9/cXrgFEAnGaw1btxqnb91gzkbIWgbsF/wgNCJ7JCLBbYwnfCpGXvjrvWX83TIxNMonWkRn1+HAuBaFJIHKN0N6b6Fuaj4s8muN3A2q8C1c35UFZiZRNGNsqeFtr74pa4GsUegIDOCS2hnGSOJR1ETJ3FdlQDzvenmLf4Gm/PTnBssQ2RZAcktaEtqCb90sTibGD/Af3EiIgLtChxXyyix2vykZTOPQtoVvDBAZj0Lf1KCWx+02RKgG+4oR7HUY9Qy0kTpbwIARDQINoJEn98qgOS23XChAyhzhaJ5+44X7eZxt1Q76XadQIR1Rh03YJL5tXK+3ytjdxMywXm0Xmf9kcYwydR/3Fu/OKzT3eq+t2jdDvagixIn41hM8FGPGzfnoiA4otWA+fazNY49cG2QZoZsbgyVut672jMg/skUv5xrJWSQB4TwFl9a6TjnVDY/U1udWCe9QY0eEiP+FHxmcgVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(7416014)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(921020)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGR4RlF3QUZNc1JqUTVmeWc5VHBOU044aWZ1Q1BsMUNOV01BVk5QK0dlLzBU?=
 =?utf-8?B?bU1qMWpvWng0MitUcGNSSkUzaVM4eTlKTElUQWVmS1lLdVptQ2hLYnZIZHBH?=
 =?utf-8?B?RkpCLzRuQ0FtdDE2K3V6RGNMNXZUWFV3VC94QVk5emR5a0t0RlZCYU5LVmdH?=
 =?utf-8?B?VG1kYW0xZ0M3ekVJUDhHNTdRSUp5T2l6V2kxdVJBdTNjODBnRjh2TnBQQ01W?=
 =?utf-8?B?MmFvSWhETUo1RmhUeGZzYWR0ZUZhaGJwN1pMNHNEZXNjc29LU2hLblRLbGtI?=
 =?utf-8?B?RWNYWGJLUm9XRTRqYWVxbjEvVVphbjFZcHdVOFc3dEJ6Qm9YRFlWYVJPWktC?=
 =?utf-8?B?aGxWa2RNNVVZNlJTd05ZemFKWFhabE85MUMzR0l5aVRZeit5diszUWVyVzY0?=
 =?utf-8?B?MCtvRGh1K2syOWNzWkVaUm1MQXZaY2pFK0RUQ3UvWURqOHhORWVSUXhlNDM2?=
 =?utf-8?B?YVVkVWk2K2ZvaXdjL1BQdHVHMDB6OWw3QTQyTG9wTEVjUlZIeTBzT3JybnJX?=
 =?utf-8?B?dlRETnpZMnVtUTNEUlBZdnJaS3RkcTQ4TmZLVndTSlBHNUpLbmt5TSswL2d2?=
 =?utf-8?B?dlhpaG5vbXRBVzFXaEpmbXB5OGFZazJ5L0VxcjF4MUYxKzJKNERtR3ZDNVp4?=
 =?utf-8?B?K1JqQ2JRVDk4L0cyNkVVZDJsdHNmVmgzYnZzaXdZMmN6NXBPWGRPM3B5bmNy?=
 =?utf-8?B?MnlwSlBrd2UrR04ra2JNNWFOQjlwcWhsNGJ0ZWpOczJNSml4RDBObVJ1Qmxt?=
 =?utf-8?B?UzY4NThQVUtkTjBaT1F1RHMrdVNBQUFQY29heUdBbWNNUnVITzZXM0hXaGw3?=
 =?utf-8?B?ZDQxVWpBb2tiNGtDSVhIUnM1b3BwVlJLRS9mNldDcGxWR0pxcW9nNTYvTXVN?=
 =?utf-8?B?RHRpVEtYdUhNQ0k1ODdQTVh0Z0FuSHZyaHRrczJmSjJKTDVKd2J3SlZ3cnNK?=
 =?utf-8?B?S1FTclhEQXNSK1FxVlRjdHk3SGtGVmZPeTJNTWlhNmZzZWxSR1U0Q2Vzbzdv?=
 =?utf-8?B?aU9ZZ0FWbXNTMHFxV0lTNHV3a01hcE9qZk56SGZ5blFucXlkTzhlanQzT3hR?=
 =?utf-8?B?SGNtV1BPK1dDbTdReFJVN3IzTkcrVjdFMFFSUE9Eakl4SURoWm13T1lUWGJy?=
 =?utf-8?B?OFZKYVRVV3JRS3AvdUNGYjE2Nm90M2l4YWtyU3dpUmdlVkVCdjhiWXRqZnRw?=
 =?utf-8?B?SVZoYlIwNkJyQUNMNzlKeWJaMFpHTnU3RC9ySG1hODcvMDZsdVZBRWlqRnhh?=
 =?utf-8?B?citJSTJHZGFCVWNQSzYrR3QwenlTSk56Zlg5c2g3bzlzWHBwNFl0bjFvSEtk?=
 =?utf-8?B?RG5KdVRiMUpraVp3YUQ0TDBDdFVXbEQwRkZBOEJpZCtNT21rKzEweDNoYXZy?=
 =?utf-8?B?VnFsaTYvQ1RlbjJKQWs0dU1DZ0Fod3ozZUIreGFqN2NYd3N2SUtKSnE4RGZK?=
 =?utf-8?B?RzZwZWpUcy9VM3dZR3p1K201QWl2dDRSbVo4WlR5SnNXMlZmUE9aN2x0dlFE?=
 =?utf-8?B?RGlTZGg4YmhjVXQ5ell5aWFzRkhSYnA3Y2pNS283S2t4cnRoaXM5VG9ZTnpZ?=
 =?utf-8?B?Um9aUVhuV0NkVjc0djA4YlMycUZIVXIrMFVDRENpMzdGSVpudFVtVHZIbDZV?=
 =?utf-8?B?V3ZDWjA0dldPdW5ONUUyMFhDZnNyeGRtUUFYTEZUclFPNDE2OERISk9GRExz?=
 =?utf-8?B?a29nQzM2dFVwdm5MVWZoNzVwbWQrQmpQRWRzMWpRNldZMmVhVitaeGJzcUJP?=
 =?utf-8?B?T1pjTWMzblF5YTk4dmhDbmZGM0E3bzlRN1ZUSmYyYkw0c2JrZy9GUGJxSStj?=
 =?utf-8?B?QmdlRUk1V1RtMHp0UjRwMjhtVXRWY1lXTno5c1hXYUVraHhBblRlVXBqV2RC?=
 =?utf-8?B?dEhrOWRsRGwxRHhPeHQ3K0RHYVV4eUt1THZtMHVIRCtoUjJHMW1DWVpXOTF4?=
 =?utf-8?B?cHdQcmJackJ5K0xRRDhuanB3UjEzZjE4YU5UNFR2VFRaOEFVanZybEg4RjhD?=
 =?utf-8?B?MnZrMXFKU3BEc0UzUUlMU080WXpqWTFPRTdjVFZwMHJWMWUyN0FCS3p3ZTRj?=
 =?utf-8?B?MWI3RlQ5eWhoeG83ODNQQ2NwVjhqZVRCUmk2WDdsS1gzNm5pWUs4OHQxMktI?=
 =?utf-8?B?U252M010bG4vQU1ubXJCblMycmhKNE05YVFxSWsxZjJPdElXbWtsNUNTcEdX?=
 =?utf-8?B?MXNiUVRVN1dlcEFwY1JxemhtS2VMSTBRTFl4RjlyV2lySi9lZzk5aTdLRXpm?=
 =?utf-8?B?U0JUTXRIQU5RUXh4U1hhTkRZR1dCdnZvSjluRTJYNVE3WVBHczZSS3pnNVNN?=
 =?utf-8?B?VE9pN3dMaWM3YnBSdXhwVTlQYTR6SGppbURUMXc3d2I4SDFsS215S1dJSlh3?=
 =?utf-8?Q?CvgHndWuLL3fr4q+WOrJKXfoZa/ejz8eEeHW1uMfOPQ55?=
X-MS-Exchange-AntiSpam-MessageData-1: X0aWJxPhDNV3dA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be499c2-cea7-4e80-4dc2-08df2e5dfdb3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:55:33.5313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEvpIkQAYFOgs3V3ayXyhOpaWUb3q+e5uQQazGMuTTeiknlj5Fh0TRixI3HW0Ty/JoBhC+Rxq2uww1NhABrkxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071
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

On Tuesday, October 20, 2026 12:47=E2=80=AFAM Robin Murphy wrote:
> On 16/10/2026 7:46 am, Mikko Perttunen wrote:
> > arm_iommu_get_sgtable can only describe buffers which came from
> > arm_iommu_alloc_attrs, and returns -ENXIO for anything else. This is
> > stricter than iommu_dma_get_sgtable(), which falls back to describing
> > the buffer as a single chunk.
> >=20
> > The difference shows up when a buffer is allocated for one device and
> > mapped for another, as TegraDRM does. Buffers are allocated on the
> > host1x logical device, which has no dma_configure and therefore uses
> > direct DMA ops, and are then mapped for a display controller behind the
> > SMMU.
> >=20
> > Add the same fallback as iommu_dma_get_sgtable().
>=20
> Hmm, that's not actually what it's for... :(
>=20
> The "fallback" is only for the case when iommu_dma_alloc() has hit the=20
> dma_alloc_from_pool() path, see a98d9ae937d2 ("arm64/iommu: handle=20
> non-remapped addresses in ->mmap and ->get_sgtable"). It was never meant=
=20
> for dipping into *other* DMA ops because the caller has erroneously=20
> passed the wrong device. Just like dma_mmap_attrs() and=20
> dma_free_attrs(), dma_get_sgtable_attrs() must match the original=20
> dma_alloc_attrs() call - that's a bug in TegraDRM.

Ah, indeed. That's easy to fix in TegraDRM. I think this happened=20
because TegraDRM has this (a bit unsavoury) use of DMA API on both the=20
drm device and the actual platform devices side by side.

Thanks,
Mikko

>=20
> Thanks,
> Robin.
>=20
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >   arch/arm/mm/dma-mapping.c | 25 +++++++++++++++++++++----
> >   1 file changed, 21 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index d6315baeddb9..c2ec4f107808 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1169,12 +1169,29 @@ static int arm_iommu_get_sgtable(struct device =
*dev, struct sg_table *sgt,
> >   {
> >   	unsigned int count =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
> >   	struct page **pages =3D __iommu_get_pages(cpu_addr, attrs);
> > +	struct page *page;
> > +	int ret;
> >  =20
> > -	if (!pages)
> > -		return -ENXIO;
> > +	if (pages)
> > +		return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
> > +						 GFP_KERNEL);
> >  =20
> > -	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
> > -					 GFP_KERNEL);
> > +	/*
> > +	 * The buffer was not allocated through these DMA ops. It may belong =
to
> > +	 * a device which is not behind an IOMMU at all, which can happen whe=
n a
> > +	 * buffer is allocated on one device and mapped for another. Describe=
 it
> > +	 * as a single chunk, as iommu_dma_get_sgtable() does.
> > +	 */
> > +	if (is_vmalloc_addr(cpu_addr))
> > +		page =3D vmalloc_to_page(cpu_addr);
> > +	else
> > +		page =3D virt_to_page(cpu_addr);
> > +
> > +	ret =3D sg_alloc_table(sgt, 1, GFP_KERNEL);
> > +	if (!ret)
> > +		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> > +
> > +	return ret;
> >   }
> >  =20
> >   /*
> >=20
>=20
>=20




