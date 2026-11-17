Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDFA606A336
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=i923S5T7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F8C10F1E8;
	Tue, 17 Nov 2026 08:36:19 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5D210F1E8
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 08:36:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRCa+jD7BFnbv9GrgaS23FO3z3+kn+f96UpUPxGr/RCvcwytQT4HJgjhGY44IT+F4wv6DtcH9V5koZXA8SuG2dVNL24bV0e5U2pcvIf5k2/XkO84pV+vEaSCRkH1GpJI+plvj8KSWrAi2+rx18BnK1JsYfv75n1CCxxw9Rtr2jX0v2jRr8s65uDNywBxNqBvcu8+onX2jpXu5bsdUhDraIcZsexQWB/DtP3NK42Wxyg14JH5oEnpag9zB/VjJIhi6TTVBJFpQ0FTmITeQDmLpWVgCqBpLED8fJGk4cQ5Dwh3gCKKRCsMlYtPQQj6y32EHoLukT/cw8K9jeeR6lNglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTY7OgCtCzcSy47iUe38LBLwFuKTZiF+CzcZNIOzlrQ=;
 b=cvIByRlec6i6QPgXHRw5FWHJ6h7VArXVIXM5vWCdUULvCltLUl4RA6YuHCh3ei8Paf5Prkr5T/5mPzbnDS3RBUI6FT69z/FzrRMsxJe8MiIDrsuN0nSgrndY0R2K9jhvBipq/8EJzT2/I6EHlyAAJtVtYEUOpMEUETy0p0eP+0mjO6SVL9zGYGxKgtU/iIhJRPprTLWpAPwTmgrVraNyj78NjAxGk4qaj+/LGdScujK9bIiIqb8TdTD1PgnwQ4fYc3kysX+D3tzGeeQHx9J8Nu3Slmg1IgiLqs8rUfrKFNGAT+s4JpVqLa0FcVlWaLgFCjkoZ22HJYmUbe7OyMp2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTY7OgCtCzcSy47iUe38LBLwFuKTZiF+CzcZNIOzlrQ=;
 b=i923S5T7t/Uwvf/HsRIKKdCcOruuyGNBfdq8Jjr7/s7m5SLa/q/iLgPBWKyZxGBwcsR+JA2c+md894qt3kbm0sBvxM+kpZXUwCkZPU+MszasQHzIpsBYZ2mZKsYCVZVUyXblxO0IaC0dLDiF3ayaY0hPVS3w/IPelfBUsAk6Aq6ljRtUvEqOLALtu8qU39gyYBU0lQ+MaDyISvcchzKZMy3DfMsDIE79vCizJzeF1AWiYTmkh0CiRQ6BBQMYLsGmljd6bU+3jGY+PBLINsE+31LCUKrqQ7hrf/s0K9rhaFAXGIysxGjJkfxH9fre92Af6lXJPB1gMfPXOg7+7aLjkg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by EAYPR12MB964616.namprd12.prod.outlook.com (2603:10b6:303:2ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 08:36:08 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 08:36:08 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: dri-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 07/10] iommu: Enable DMA default domains on (most)
 32-bit ARM platforms
Date: Tue, 17 Nov 2026 17:36:04 +0900
Message-ID: <ee_tanGoRBaIng-ImaPnLg@nvidia.com>
In-Reply-To: <sashiko-outbox-185113@kernel.org>
References: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
 <20261026-b4-arm32-iommu-dma-cookie-v3-7-3901d74b1ff2@nvidia.com>
 <sashiko-outbox-185113@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0176.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|EAYPR12MB964616:EE_
X-MS-Office365-Filtering-Correlation-Id: 74101976-b1e2-4965-0bf1-08df4485d38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|10070799003|1800799024|5023799004|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|261009221227099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: EHxJKG5hFa2qTVwZN2OYD2LOwgniSuKbVu7ZY0FpAVnz9Md5MoqM4ceZQSbrN62ZfhYPheSfoRTih9zGRqeGCM9bDv2XJZXphv1LIY14XuhIASufykyYTzAY33Wb9DLfxoaq7PQZS/opJkNdt++zzoZA3gPUwmMoA6FqI7uhis7KTRyKicdz02b1/BW5joGrOfqwNJNurGCJOU1bmJyNS3vZUwNwQ9zHViw3Bp+bZ5GA5hll321owJiwmcd3xWtv9WoceFsL5Cqx9igwJBihoEkBo2eptR6NN5pnhM91P1j4XTSFM/mkJmQgKeY5vHoym0VhQuYBnvrIPb0gb/PLPwsq2XLNP1nQ5zIngwYZZUY7X3H47yAn9TSIrJo9Vx2X/m1CaMZb4uI65Yht4jKu7Upgdox5CtviC8BZQLZrh2b1lvz4llkpGQr9Ba/FUSbIRbiNSX/Ib4cSlNtXa2eWEUxCrwbkj/+7A4pF3CSoJJlgBQnjR+q1Mj9Fj75/YzMSypUn6GArzOWyCHoEKhs+j++mVUdfJeRV7q649jPoOIZMmOoq2JJDBo3uZ5LUNF/3cdF4zXhY+sXqUkDVkkdsh4mSd59jWObjx8z4tqVCTOOtNQn1ZpK0ogOpP4xRCSnarXaintfpOPktmNYKbPPms06wfLejKNSafwP7K4Vhxak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(10070799003)(1800799024)(5023799004)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(261009221227099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHpjalVrOHFzcTlkR3VJSUhXZkZlSzZwN0Y0RnZCODNXUmRNMktGSDVTS0pK?=
 =?utf-8?B?Q28rWXlvZUQ4M214NGZPRHBmUG9VL01mNmdaWnV0QVJWSjhqQ1VjMjVVSkpn?=
 =?utf-8?B?dEhCblRLeWJMVUIrSElPNWg3SGJwUGNQS2hRUGRsSW9EQjlOdTJpUTNFRXRU?=
 =?utf-8?B?NGh3dGNxQ2pqYUVxNlg1Sk0xamEyamlxQndLVjZPVWV6Yk5XY0VXVVRub0pj?=
 =?utf-8?B?ekdTVkNzUXRyWVp5dXBKU0wremgzV1Q0NUwwNHJod2h5OEhDNTFsMWJWdmpj?=
 =?utf-8?B?TE9QN0dLSlhpcDZ0ODV2bHd4QTZBaktmOFVjSE1NWTdDbE54bUo4Zm9udHZt?=
 =?utf-8?B?RFVaZ1EzeDVCWnJ5YU9RRldCYU82RkR2TlJ4K0hIdlJGc0RFZlRtTzloNjU0?=
 =?utf-8?B?UVhQZktjMUIrL0pJaCtReTNPaDFnVkgrdlFaWURUNHE3S1dSbk5xcDlYU1Zt?=
 =?utf-8?B?TVFXcWRDVG5ReHhtbWx5YkNNelZ2Y3JkUWIzT0QyS2I4S2luVXZKS3daamlF?=
 =?utf-8?B?ejB2MjJBTi96Wno5UG5XU2JFM2Zla2FQaTkySThVbWVwMGNkRENuUFJRZmg5?=
 =?utf-8?B?QVF0R0ZOQ2tLMk9QTHQrK2hiREdEMG83ME5sdkJtYzN5dUNaenpEdE5VNGo1?=
 =?utf-8?B?bzVER3JyQVo4dkRMWmV2d29tTmJtcWVaMzhJYUxlTkVjZU5DM25vU0VRejNK?=
 =?utf-8?B?MjFMMktVcDFVb1V1WjBldHF0d3BZenhRUGRpNVBQbnYrcUNJbjNLTHMwQi8y?=
 =?utf-8?B?MHJBeCtEUmNVRjZscXpHWFVnYjhWZENYb2tEY045SUY1UllBdWhycDZURGtk?=
 =?utf-8?B?c0Q3Vk9xaktpTVFxdlMvYmFQTXUya0NmL3pHU2FCdHNkWmM1a3hSKzZLNDJi?=
 =?utf-8?B?M2czL2RiUjJSUkdDL0J3N3FMUFRYVzlQTUpwUWN6N3dib1doSW0wbVVjNlIv?=
 =?utf-8?B?a0Q3cTdBUDA4aHFkeFl6cEZxeXBEdVpDUjBsM3J2UUJvNjh3dmJBaWJSNXpZ?=
 =?utf-8?B?eFlmWlpPWnlkalJPaGJHUW1kVHZZUEx0b1B4STdUYlRrb1BlTERJWlpIMzVG?=
 =?utf-8?B?V3YyYjh5Qi9VTHhIM2FoR3ZEVWpWeFo2TmQ0NHloT3hJbE9ubnA3eElpd3Mx?=
 =?utf-8?B?YmpmQS84cllwa0ZjamF4UkpHMi9pcFhvbnREZ2d5T1JFN1JzNlZtVC9GL2Vh?=
 =?utf-8?B?djE0Q09rSmRkcTNqa3RWVFZMcmhhaXg2emMwQ2k2U1lHaUh6S2hxNUFKcUFv?=
 =?utf-8?B?NDZtb3ZJZzRjZHJyejMvcnd1T2hQMjE1M0psVFFBSXdzc0thK1piODdxS1J4?=
 =?utf-8?B?ckVwZE95aDV0TWJRYTN3Kzk3enJ1TzFKaWswWE5VS2xLOEFJRk56aUV1V1BM?=
 =?utf-8?B?UUcrV2pDZFYrd1JKWEVlVUV0N3NmUitqSzFFaVdDSjhUUzhSUlhCUHJ1Y1E1?=
 =?utf-8?B?b3Y3cVR2cmY3emZpZXdxYnBEeU9qcjRyV25hVEo4NERwUHlDT1g5aDJzZG92?=
 =?utf-8?B?cWtxQU9tT3FObEJOOFJRZEx5d1Z2MVFNSzU2YmtVTGt6Wkd2QlJJcmFUZXBo?=
 =?utf-8?B?N0FwdS9sZ1VIY1Y5d1NzMFM2MGJhWCtKVnNmYmJoTWx2cFE0aStSZDFJQjBW?=
 =?utf-8?B?NC8rRjNTd2lNajNPSlZMeDA5OFlnckhqN095MmhTVWY0V2FVU1NuVE0ydGEy?=
 =?utf-8?B?VjZNQTVaUVFySFBuWnNLYnNFa21WSFR4a3E5ZFNJM3IzVFBpQW9ydFZ4VGFX?=
 =?utf-8?B?RTJXekhNV1pGSEtJRkxtVjNpblhnOVhrQ3NRVkM3Z256eXcwYS9mVDVkVHlK?=
 =?utf-8?B?UjMvZnp2ckRVOFVpYnluNlNLd29GcVNZYkJkcXFrUWFqWEY2U1pJdGcwaTVp?=
 =?utf-8?B?UzFMTG1UVXJKN2dWYW0rc2JqYkd2U0JzdFk2cEJqYkNVRC9tTGkwcVl6d0Fa?=
 =?utf-8?B?ajVXS0s0MTgzemNjRFFFbmRUVjNBTFN1blJZbkpNWThmcTNKUjB4VkFYTExl?=
 =?utf-8?B?UlhlcU9sd1NkQVFMYndVdi9GTkpIYnk4cW1YN2h5bmdPQW5KT3U5ZlFYd0hs?=
 =?utf-8?B?YVFiWElraGdoRW1idGVQMXJKWnk4S3RnNTVwN3JxU2FBYkhyc1lNN0NEQyt3?=
 =?utf-8?B?bGhBdGR2OE9MQkozWkdXVXhmL3FrVUVhcml4SWpsWHJNbENwK3hLTkU1bHE0?=
 =?utf-8?B?S0VBdGJWUUpuR2YySDNuMXN0clU4SnNuTVlMVU9lNGtxL2tqVkNZRHB3MVly?=
 =?utf-8?B?QW1wZVpGcEFIMTFVcDBZaCsyUHJBYTVuT2IveUladUVDWlB2RDFrYWt4dU53?=
 =?utf-8?B?cFhQUUZsVXkxYnZJTXliVzdMYjJ2V2poNlVHakNHNmZaQnU4dC9senRNZ1pR?=
 =?utf-8?Q?mSVvZJoXyLpAzeiukNYOrcCXR0Lx5+sJq+M5VASlhIm4r?=
X-MS-Exchange-AntiSpam-MessageData-1: P0PvknPnETFpcQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74101976-b1e2-4965-0bf1-08df4485d38e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 08:36:08.3015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgFmZQLD4pSrs+KJHHxSNjQUXPNhM8vtDtJda5ZHdMj+F2NqCa5W4XUg3odXEfabK3rPnQLCywLyRHVMyNDOVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB964616
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Monday, October 26, 2026 8:38=E2=80=AFPM sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] iommu: missing IDENTITY default domain override for qcom_iom=
mu on ARM32
> - [Critical] iommu/rockchip: use-after-free on device teardown with DMA d=
efault domain

These issues seem to also exist on arm64, so I don't see a need to=20
pre-emptively force these drivers to IDENTITY.

Mikko

> --
>=20
> commit b1b0900ebc55a49be25130b8187ffecfc2191b42
> Author: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> iommu: Enable DMA default domains on (most) 32-bit ARM platforms
>=20
> This commit enables core-owned DMA default domains on 32-bit ARM platform=
s
> with CONFIG_ARM_DMA_USE_IOMMU by removing the IOMMU_DOMAIN_IDENTITY overr=
ide
> in iommu_get_default_domain_type(). For several IOMMU drivers that are no=
t
> ready to switch over, it adds a def_domain_type callback returning
> IOMMU_DOMAIN_IDENTITY.
>=20
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 5fbb76d44a1e9..e47f95fea44d0 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1884,18 +1884,6 @@ static int iommu_get_default_domain_type(struct =
iommu_group *group,
> > =20
> >  	lockdep_assert_held(&group->mutex);
> > =20
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
>=20
> [Severity: Critical]
> Should qcom_iommu also keep an IOMMU_DOMAIN_IDENTITY default domain on 32=
-bit
> ARM platforms?
>=20
> CONFIG_QCOM_IOMMU selects CONFIG_ARM_DMA_USE_IOMMU, and qcom_iommu_ops in
> drivers/iommu/arm/arm-smmu/qcom_iommu.c does not define a def_domain_type
> callback or release_domain:
>=20
> drivers/iommu/arm/arm-smmu/qcom_iommu.c:
>     static const struct iommu_ops qcom_iommu_ops =3D {
>         .identity_domain =3D &qcom_iommu_identity_domain,
>         .capable	=3D qcom_iommu_capable,
>         .domain_alloc_paging =3D qcom_iommu_domain_alloc_paging,
>=20
> With this change, iommu_setup_default_domain() allocates and attaches a
> paging IOMMU_DOMAIN_DMA group->default_domain via
> qcom_iommu_attach_dev() -> qcom_iommu_init_domain(), which sets
> qcom_domain->iommu, programs ARM_SMMU_CB_TTBR0 and ARM_SMMU_CB_SCTLR, and
> sets ctx->domain =3D group->default_domain.
>=20
> When a client driver such as drm/msm in msm_iommu_new()
> (drivers/gpu/drm/msm/msm_iommu.c) or Venus in venus_firmware_init()
> (drivers/media/platform/qcom/venus/firmware.c) attaches its own unmanaged
> paging domain, arm_iommu_detach_device() and arm_iommu_release_mapping()
> become no-ops because iommu_is_dma_domain(mapping->domain) is now true,
> leaving dev->dma_ops set to &iommu_ops instead of restoring direct DMA op=
s.
> Attaching the client's unmanaged domain then overwrites the context bank
> registers and sets ctx->domain to the unmanaged domain.
>=20
> When that unmanaged domain is later detached and freed (for example via
> mdp5_kms_destroy() -> msm_iommu_detach() followed by drm_gpuvm_put() ->
> msm_gem_vm_free() -> msm_iommu_destroy() in
> drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c), __iommu_group_set_core_domain(=
)
> attempts to re-attach group->default_domain through qcom_iommu_attach_dev=
() ->
> qcom_iommu_init_domain():
>=20
> drivers/iommu/arm/arm-smmu/qcom_iommu.c:qcom_iommu_init_domain() {
>         mutex_lock(&qcom_domain->init_mutex);
>         if (qcom_domain->iommu)
>                 goto out_unlock;
>         ...
> }
>=20
> Because qcom_domain->iommu is already non-NULL from the initial boot atta=
ch,
> qcom_iommu_init_domain() returns early without reprogramming
> ARM_SMMU_CB_TTBR0 or ARM_SMMU_CB_SCTLR and without updating ctx->domain.
> This leaves ARM_SMMU_CB_TTBR0 pointing to the freed page tables with
> translation still enabled in ARM_SMMU_CB_SCTLR, and leaves ctx->domain
> pointing to the freed unmanaged domain where qcom_iommu_fault() will
> dereference it on a context fault:
>=20
> drivers/iommu/arm/arm-smmu/qcom_iommu.c:qcom_iommu_fault() {
>         ...
>         if (report_iommu_fault(ctx->domain, ctx->dev, iova, 0)) {
>         ...
> }
>=20
> Similarly, during iommu_deinit_device(), because qcom_iommu_ops does not =
set
> release_domain =3D &qcom_iommu_identity_domain, group->default_domain is =
freed
> while the hardware context bank remains enabled and ctx->domain remains a
> dangling pointer.
>=20
> >  	for_each_group_device(group, gdev) {
> >  		driver_type =3D iommu_get_def_domain_type(group, gdev->dev,
> >  							driver_type);
> > @@ -1912,11 +1900,11 @@ static int iommu_get_default_domain_type(struct=
 iommu_group *group,
> >  	}
> > =20
> >  	/*
> > -	 * If the common dma ops are not selected in kconfig then we cannot u=
se
> > -	 * IOMMU_DOMAIN_DMA at all. Force IDENTITY if nothing else has been
> > -	 * selected.
> > +	 * Without an IOMMU DMA implementation, force IDENTITY if the driver
> > +	 * has not selected a domain type.
> >  	 */
> > -	if (!IS_ENABLED(CONFIG_IOMMU_DMA)) {
> > +	if (!IS_ENABLED(CONFIG_IOMMU_DMA) &&
> > +	    !IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
>=20
> [Severity: Critical]
> Can switching rockchip-iommu to an IOMMU_DOMAIN_DMA default domain on 32-=
bit
> ARM cause a use-after-free during device teardown?
>=20
> CONFIG_ROCKCHIP_IOMMU selects CONFIG_ARM_DMA_USE_IOMMU, and rk_iommu_ops =
in
> drivers/iommu/rockchip-iommu.c defines neither def_domain_type nor
> release_domain =3D &rk_identity_domain:
>=20
> drivers/iommu/rockchip-iommu.c:
>     static void rk_iommu_release_device(struct device *dev)
>     {
>         struct rk_iommudata *data =3D dev_iommu_priv_get(dev);
>=20
>         device_link_del(data->link);
>     }
>     ...
>     static const struct iommu_ops rk_iommu_ops =3D {
>         .identity_domain =3D &rk_identity_domain,
>         .domain_alloc_paging =3D rk_iommu_domain_alloc_paging,
>         .probe_device =3D rk_iommu_probe_device,
>         .release_device =3D rk_iommu_release_device,
>=20
> Previously on 32-bit ARM, group->default_domain was the static
> &rk_identity_domain, and during device teardown arch_teardown_dma_ops() -=
>
> arm_teardown_iommu_dma_ops() -> arm_iommu_detach_device() detached the le=
gacy
> UNMANAGED domain (re-attaching &rk_identity_domain and removing iommu->no=
de
> from rk_domain->iommus) before freeing it.
>=20
> With this patch, group->default_domain is a dynamically allocated
> IOMMU_DOMAIN_DMA paging domain attached via rk_iommu_attach_device(), whi=
ch
> sets iommu->domain =3D domain and adds iommu->node to rk_domain->iommus. =
When a
> client device is removed or fails probe, arm_teardown_iommu_dma_ops() ret=
urns
> early for DMA default domains, and iommu_deinit_device() sees
> ops->release_domain =3D=3D NULL, calls rk_iommu_release_device() without
> detaching the domain, and then calls iommu_domain_free(group->default_dom=
ain)
> -> rk_iommu_domain_free():
>=20
> drivers/iommu/rockchip-iommu.c:rk_iommu_domain_free() {
>         struct rk_iommu_domain *rk_domain =3D to_rk_domain(domain);
>         int i;
>=20
>         WARN_ON(!list_empty(&rk_domain->iommus));
>         ...
>         kfree(rk_domain);
> }
>=20
> This triggers the WARN_ON() and frees rk_domain and its page directory wh=
ile
> iommu->node is still linked on rk_domain->iommus and iommu->domain still
> points to the freed rk_domain (which is later dereferenced in
> rk_iommu_enable() and rk_iommu_irq()).
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-arm32=
-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com?part=3D7




