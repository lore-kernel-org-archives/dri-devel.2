Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1F606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UxHJGdSK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5671410F8BC;
	Wed, 21 Oct 2026 03:13:13 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F4610F8BC
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 03:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+QAHZA2nlPAifjUPdPrJZUS5Vrq0dU5e7w2vncNK1bjKJnhlojo3kAsqO2iMf7xMaJQ4Y0KypLRdBcvz8tKJL1XLAnUjmjPDvf+Rgdf/ZyVamH8MJOXEB7uWCpQVSsEq4i/LlECpY3cff4PILwvoIPg3wZ1NdTlW80D53j0mCNBTuwra90corf4SgnpkUSmN3ZN7MfinWWhDb/5QIn7vrF5ujhLVMZUW4ZvHKA3wL6rap17NMvBG5lqf/mNDyJHjpnOlzVbtxOPDmRkcP+dkQaOu/E/zKnlZ6ujQ/s58GyGfb+qwx2kWSY1VdUsnbaJ6IxsVg0Y4yayYN0vTPqjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0031MfSyWJ86sGKHs0Uq6ld3LLkY7XXgkGqA2txCHwE=;
 b=CXJx9W7kXiH5VVEZWizRf60hJlARCzBaIFthpnDsJa/2bZt4KOFA7T9X0f34+3wu61xVDx0MsuiIJlZaU9gTVLNs6OUcTcvCvYdhZ/Ousc8MtaoNA1GcWsaXKWllIGcAejilr7fc6/zEPA6V1rhx2C4JOak1RLIzLuTkOQRzsLJKHyZbuar6i2Q81TU2KwG126/3yUVLSu0xovznygss/cNGwe9rwVut3OzVuTjkGPbrD95N7FGyrPlA1iZXGzRRfTR2Nt5M0oK/qSZDj21hBmaF461so+oc0+STTIce2n0marPBqVlUIGgGDuHfSRDqbmd4VfRjai6Fg+HoZlsGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0031MfSyWJ86sGKHs0Uq6ld3LLkY7XXgkGqA2txCHwE=;
 b=UxHJGdSK5NwIJyjsUVelRoR9pPVfCcxwXRrKsMatn66xuXqVe4h5slUwYiYkf42FZdVtvM1ghidVjX/f3sqXbZhRjvzb9nVwHb9+LYY0EWDcm/Vrvi5ueR7Dc7+bTT0iCkgZVmYg5yzqsVz6zXKzsZr1NNADOMhto0awXXzZuaLirAFukPFl5IsFy0Vo8VtDEvPmVum5i98U5iK4pK32Q3IHj650vSL7lV2Trx0IBnXPfoxlrGwTJDy/L83vDVZj78huRCWzPPsfREfTyW3stm+DeUO7LAKHbVpH/V+h/y1V45nvuPFAL55ivpNnnVR9eU6EV+H8aOKblRIi6S3v8g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 03:13:02 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 03:13:02 +0000
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
Subject: Re: [PATCH v2 07/11] iommu: Let 32-bit ARM drivers opt into a DMA API
 default domain
Date: Wed, 21 Oct 2026 12:12:58 +0900
Message-ID: <E_MBcemRRcCDkgXfDjIcWg@nvidia.com>
In-Reply-To: <be6cd787-8502-4499-ad62-597c1b9b7702@arm.com>
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-7-b06842a01938@nvidia.com>
 <be6cd787-8502-4499-ad62-597c1b9b7702@arm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0006.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1bff62-f7cd-4fc5-682c-08df2f21376a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|23010399003|376014|7416014|56012099006|4143699003|921020|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: DEOUpIQQU+X6sFVmI72CCKyv1Hm3eBPAb+2lWlSWttUsyzsb2eNs5vbuWD/724Lwlrfr/N8k7zFQ9p4L9SzKqgw+gby6UfO3wMEMAl4fy3J+KDxeEtG3mhqpnckuTodOEwS5xrrZ1dkIW0TN38dU3rm1oXXXm3XZ5W70WqHB0KrQQY2Efh/1P49UdI9QawsGBTJaLnbC1i9O8BE9jQVku/aXWdgEkmwU4OY+4TIrj8A7PtAgDNdHc4hzyWyFurCTZ3yTDk5AwdOSc0G1ha2CPhQLBULY/Aot0TxpHbfdLFRnm3rIwvmFy1gL1OYl6ipDi1MBeIRi7lOtGPkVXKdOYe+an/9OyHgwz/ccU5s89IOXpwnAtW9zOJ6PptGuwkIJAZkyqQpsi72yR3bCH9jiYRQuP18TQGE2QZ69NGZ7L8/+YCV/pqY8BpXTfwonBVyo6FEk0uQi2cXB+wONqo/svA05Y0WE+Lwh/ca5gmYPZwqg0g7M223YizJ4KJcmnToQBq5ioTkszkrgNKbUwPZaUePVBLP+JgOYms5FvXJufcwr/ymuRFjxbpWokLLnFEL2gGzAeBNh7nZp60XTwZfSxTNo3ulZJon6DwFx6vG5ItXXgvSsCEEjSl0/zKQqP8uvfBSL9ypFouKKUjhNapMXEPxiSAsmbNljRFQt2nep9L1m5Nwx4EwwIuF/04dyLRIr0BV7ybCOKm7uHuuIivrk1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(4143699003)(921020)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWM4clIxcTdUSlNsVi9SVExhL3AxS3Q1aFY0a0U0cDByRTA3QlJiVXVsT3RG?=
 =?utf-8?B?ME52a1lEZlVsQjRiTHdmNFdFWkFSWGNGU2pFQm1EMFlkL1gyWjdIaTdJL3hh?=
 =?utf-8?B?a0ZVQkp6K2QzT015VVBiUS9raUF2RFFzTGFUcE9mRm5CYmtHMFo1a2hXSytF?=
 =?utf-8?B?ZEh2SERsbzZWUkNEM1JOb0ZubUNJMzFHeDdPTHdZeExUUUczaFdXY2M2aTVq?=
 =?utf-8?B?Ny9UNG5JVkE1VnNkdXl5SWEyOFFGY0cxOUxtaDV4S2dEbmdpOUlvazZXODFm?=
 =?utf-8?B?eEU4cmlBUjFtaE9FTzVySG5EbUh1RWdYV3haTFIrLzRTaURsZytqNEN3eXdh?=
 =?utf-8?B?SXdYSWRpTGpmcTQrQld2MmxHeGplYkcrdTVwZTZ4N0NBVjRiQVBsS0x3YUdJ?=
 =?utf-8?B?ank0dWp1eDFwSmsvQVJUcVZGbEdubjBwazRLbkh4bDB3OTc4ajZVeGFGVDV6?=
 =?utf-8?B?Z0FhcTJDc0g4S25nR1Y3SVdFeWlCQWJXZmRKMEVobENxY3JQbVFJV3p0eGhO?=
 =?utf-8?B?dTZRZWc5aDg3WlJNQWdDMy9hZ2dRdmRpV1pKS0sxOWU5VmQ0TFBldkVKUGZn?=
 =?utf-8?B?YzVkM3NuTSsrQVFXNnhabFBWakh6MGRpL2NFYzdjM2hwcXR3cGZFblJDUkpi?=
 =?utf-8?B?RzlUTHNyMWpzdUhKaFVrTzYzbkwxR0RTaG5LT3NrSFl5YmtveGlHUW5kYkdW?=
 =?utf-8?B?L01tbWJyYWR0Q05MSG1lclluNnhRNzcrYlVKa2VmMTBOdGttcW92aTBveTcr?=
 =?utf-8?B?RVE1MDdGS2k0ME50WHhyT1VmOHpLZ2Z2YXRvR0lkRmFNODFHY0RiK3lBeGls?=
 =?utf-8?B?ckhVT0NYWGdHdEpmaVpSL0YzbkM2MUNLbzZzN2ZDUHZ1UVphT2lyUEhPUy81?=
 =?utf-8?B?NHYvejhCdmxpbG4vRG5NUFVOd1grcjBUSGx1ZkVqVTk2NldOWjU4V2R2cFd1?=
 =?utf-8?B?Y21VQnVzKzVlOTNxcE9XSEVvNlRpVE9rYmUvZnZQbnA0OTN3dnNJVnF3WHdL?=
 =?utf-8?B?dnVjNDdKMHl3bGxLR243UmVlTTJLbkowd2hHeFE3ejRONXRKLy9UQ09laC9y?=
 =?utf-8?B?ZlhsMWJscm1jMS91Wm15bVdWWEFQRkxoSlVHYjh6RE40bVI4MVRhSG0xaUJZ?=
 =?utf-8?B?NHRqK0tPSTMzQkpOU0dlVjUxdGFzN015Z3A5b05YQUYrSWpBdFRxSVNiVitI?=
 =?utf-8?B?MjBMVGQvUWhZelE4RDJtdUJRekFGWFQwZGlKNWRaM2N1MzA1aW15d1cybGFV?=
 =?utf-8?B?MHdIeFVzamxLOWxMNWk4eHZRS1FXYjdqY2hzUmx4R05oVHZZNGRpZmpEK285?=
 =?utf-8?B?MDRwNE5yZU5lZTcwTW03aTJCQ0NIdDhKQWs1YU9uTFZyU2dRdllVQXBZdkY1?=
 =?utf-8?B?dkJGVUlrT3JwNlhySm9IOFdEUVBabGhFZjMyZk10V0lCdW5SdFBBWVpYRFl5?=
 =?utf-8?B?UzkvcGRWc0FxL2NOdFhNdHVJMXNINERmelhJYXRrUlNBcjF0Qy9kV2pSdklj?=
 =?utf-8?B?YXh6REtCNGNRQkZkU3pCMjBDbXhYTkNabkhnUXRjL3FZUHplUGhmN3VDSTBa?=
 =?utf-8?B?UnJvSEx6a0FuUHdXUVdsVlRnN0FYNVNrelIvaGZNTTY5OWF3dU9XM2xieGdv?=
 =?utf-8?B?WDFuQUZvRTQ5RHUwb2ZkdnBZZlhvZUcvUEZaRTc5RE1nbWJ5c2x5Zk52eVM2?=
 =?utf-8?B?a1paY2ROVk1PUk5HRjN2VmF2MjFtZytEeWtxQlQxRXEweUZYUDdWMmhKMGFr?=
 =?utf-8?B?Z09jTWFzYk10NGI0dU0yN3FlS0t1YjNRNk5TWFpBZUZ4OG9zOFYyRlZob2VU?=
 =?utf-8?B?RTlwOWJ5VU85Mkl0QnlpSEhkSGpZeUZCL1VvVkRvS25raGJsb2ZuSW9zSnFy?=
 =?utf-8?B?dklnL3ArM09BcEYxanJxOHRPSVhsMW9MVVRCUjkvYnA1cFdNeUYyOTc2TFdn?=
 =?utf-8?B?ZW5ESStDRmJBZ1p5ZWFLRUxWdDFoaFBSMStNaGpiams0TUpuOS9aY3p3L0to?=
 =?utf-8?B?Q3pDT1AxZUNBTmdMV0NnZjBQQjdWMmFMN0dDQUdIMi9BNjlZTjZabCtrVktp?=
 =?utf-8?B?R2w0bTNsQ1gzWnhDZGMyZmtGNFJkT1ZONitNWS9sZDJyTUtuZmxNWWc2cUlw?=
 =?utf-8?B?aHpoU1RoNHN1TEdsU0NtTVR4RUVHeDZOYXFvUHdZV3o5ZFova3J6RlFEYm50?=
 =?utf-8?B?bGlXekpaOUU3MmVsWGUybkZKZjgzTkZ0NWp6YVNvM3A2cjdJN3FFc0JCQ21L?=
 =?utf-8?B?TkpHUjdURExuRjIxZkx4b1VSM2pRcFFvWFZBT20yZTlJMVJBbmhFMm5sc0RZ?=
 =?utf-8?B?dWcyQzFnVEFQZnY0WGd1U3hIL0NYVTRhTE1GZy81clhnYUpLelpVLzNXN3RJ?=
 =?utf-8?Q?aGNDayAuO0sRFXY40kuYZZkqEO5DhR7LLFgDJog+K1xmO?=
X-MS-Exchange-AntiSpam-MessageData-1: OCxhtc/+vwRS9Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1bff62-f7cd-4fc5-682c-08df2f21376a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:13:02.2281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmQHowU7VPV1QwyczpVs2YrecxzVTSZfKZYimDVsjv7Xw2i2jAA5nFLUllPOG/5H7LRMB3Vbtz/RBW6Jw/5I6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
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

On Tuesday, October 20, 2026 8:28=E2=80=AFPM Robin Murphy wrote:
> On 16/10/2026 7:46 am, Mikko Perttunen wrote:
> > iommu_get_default_domain_type() unconditionally forces IDENTITY on
> > 32-bit ARM as ARM_DMA_USE_IOMMU installs its own UNMANAGED domain on to=
p
> > of whatever the group already had. Now that the ARM DMA API state is an
> > ordinary domain cookie, IOMMU drivers can ask for a real
> > IOMMU_DOMAIN_DMA default domain instead. Drop the override so that
> > ->def_domain_type is honoured, and let a driver-requested DMA domain
> > through the !CONFIG_IOMMU_DMA guard when ARM_DMA_USE_IOMMU can back it.
> >=20
> > IOMMU_DOMAIN_DMA stays strictly opt-in on 32-bit ARM and is never the
> > fallback to avoid unexpected changes, as drivers today return 0 from
> > ->def_domain_type while expecting the legacy behaviour.
> >=20
> > Behaviour is therefore unchanged for every existing 32-bit ARM IOMMU
> > driver:
> >=20
> > - exynos-iommu, omap-iommu, rockchip-iommu, msm_iommu, ipmmu-vmsa,
> >    mtk_iommu*, sun50i-iommu and qcom_iommu have no ->def_domain_type,
> >    so iommu_get_def_domain_type() returns the unchanged cur_type of 0,
> >    which is forced to IDENTITY as before.
> > - arm-smmu returns IDENTITY for legacy bindings and 0 otherwise, which
> >    ends up in the same place.
> > - tegra-smmu returns IDENTITY explicitly, and keeps doing so until a
> >    later patch.
> >=20
> > Also move the static_assert on the two DMA API implementations being
> > mutually exclusive to drivers/iommu/dma-iommu.h, next to the
> > declarations that depend on it.
> >=20
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >   drivers/iommu/dma-iommu.h |  3 +++
> >   drivers/iommu/iommu.c     | 20 +++++---------------
> >   2 files changed, 8 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
> > index 71b23cb698c0..24fa4165450f 100644
> > --- a/drivers/iommu/dma-iommu.h
> > +++ b/drivers/iommu/dma-iommu.h
> > @@ -12,6 +12,9 @@
> >    * IOMMU_DOMAIN_DMA default domains. Only one provider can be compile=
d in at a
> >    * time.
> >    */
> > +static_assert(!(IS_ENABLED(CONFIG_IOMMU_DMA) &&
> > +		IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)));
> > +
>=20
> Don't the first couple of patches already make this redundant, since=20
> such a build would now fail anyway due to multiple definitions of=20
> iommu_setup_dma_ops() etc.?

That is true. I'll get rid of this.

>=20
> >   #if defined(CONFIG_ARM_DMA_USE_IOMMU)
> >  =20
> >   #include <asm/dma-iommu.h>
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 5fbb76d44a1e..0d812c4b9f08 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1884,18 +1884,6 @@ static int iommu_get_default_domain_type(struct =
iommu_group *group,
> >  =20
> >   	lockdep_assert_held(&group->mutex);
> >  =20
> > -	/*
> > -	 * ARM32 drivers supporting CONFIG_ARM_DMA_USE_IOMMU can declare an
> > -	 * identity_domain and it will automatically become their default
> > -	 * domain. Later on ARM_DMA_USE_IOMMU will install its UNMANAGED doma=
in.
> > -	 * Override the selection to IDENTITY.
> > -	 */
> > -	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
> > -		static_assert(!(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU) &&
> > -				IS_ENABLED(CONFIG_IOMMU_DMA)));
> > -		driver_type =3D IOMMU_DOMAIN_IDENTITY;
> > -	}
> > -
> >   	for_each_group_device(group, gdev) {
> >   		driver_type =3D iommu_get_def_domain_type(group, gdev->dev,
> >   							driver_type);
> > @@ -1913,11 +1901,13 @@ static int iommu_get_default_domain_type(struct=
 iommu_group *group,
> >  =20
> >   	/*
> >   	 * If the common dma ops are not selected in kconfig then we cannot =
use
> > -	 * IOMMU_DOMAIN_DMA at all. Force IDENTITY if nothing else has been
> > -	 * selected.
> > +	 * IOMMU_DOMAIN_DMA at all, unless this is ARM32 and the driver asked
> > +	 * for it explicitly, where CONFIG_ARM_DMA_USE_IOMMU provides the
> > +	 * implementation. Force IDENTITY if nothing else has been selected.
> >   	 */
> >   	if (!IS_ENABLED(CONFIG_IOMMU_DMA)) {
> > -		if (WARN_ON(driver_type =3D=3D IOMMU_DOMAIN_DMA))
> > +		if (WARN_ON(driver_type =3D=3D IOMMU_DOMAIN_DMA &&
> > +			    !IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)))
>=20
> This ends up looking a bit odd, and not clear that it's still more or=20
> less the same special-case workaround seemingly being removed in the=20
> hunk above.
>=20
> At this point I'd rather push any remaining identity special cases into=20
> the relevant drivers, however I'm somewhat more confident that there may=
=20
> not actually need to be any:
>=20
> - exynos-iommu, omap-iommu, rockchip-iommu, msm_iommu: AFAICS these all=20
> only ever have a single client device, so the per-group implicit domain=20
> should be equivalent to the per-device explicit one, so they should not=20
> be impacted by switching (provided the "throw away the ARM domain" idiom=
=20
> in some of their client drivers becomes non-destructive as mentioned)
>=20
> - mtk_iommu, sun50i-iommu, qcom_iommu, arm_smmu: While Kconfig might=20
> allow building them, I'm not sure we really support the first 3 on=20
> 32-bit at all, but again since these all have no special CONFIG_ARM=20
> group handling anyway then either they must work out as above or they're=
=20
> already broken, and thus at most the change might un-break them.
>=20
> - mtk_iommu_v1 and ipmmu-vmsa probably wouldn't care given that they end=
=20
> up attaching to their own shared domain anyway - they just can't wait to=
=20
> be able to use a proper singleton group to rip all that out :D
>=20
> The main reason for forcing identity was to meet the expectations of the=
=20
> existing ARM DMA ops setup, but if we're now touching the ARM code to=20
> properly tie that in to the IOMMU flow, then I think we can just do the=20
> right thing.
>=20
> Thanks,
> Robin.

Very well, I'll give it a shot! You're right that it /should/ work :)

Thanks
Mikko

>=20
> >   			return -1;
> >   		if (!driver_type)
> >   			driver_type =3D IOMMU_DOMAIN_IDENTITY;
> >=20
>=20
>=20




