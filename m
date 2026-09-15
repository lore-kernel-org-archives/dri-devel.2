Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522D8C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95CC10F9C3;
	Tue, 15 Sep 2026 06:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="trVAg2BA";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC50610F9BC
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 06:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfydCpcXn+QiVdiZuXFO0aJhy1q855ATQWtVuc9e4XLuNRXgeVEvuVNhPiav4taWzB4+9NJa60f2ufhFZYoYpJKqX11yPuk8d1xJO/VRKAaIT99d88V2Uc1obWpuyOkvWpID2rMJTxGl/4xCSMz8an/XjLP39bZClMh4z1seTY9ZuH/1i8iz64usY65PtNe25dTlsL6179IhbusjtcKkhZDcWa89qIhFlGEkZGmzVzfKaUF3EdnZeHNnf4qJuNH/GTQ4WW5XE4qX4m9WhJIg26jV2StgNeqftOrk1v3BvqAXHSMdrkOh/T/wJVntMPLi5mcEAMysetnivePA8sEHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+smPUcoHVL0i/SW429zthXccci64Qt21UXG+n0oEbio=;
 b=grfMszs+v1vA1RxVEtPl2c4sQpnsc9Ci50ARv+3PJgl/ZJsHRVMieHpy+QVlQs52ztE6cEVRfbLb5CNlzdZAjfYQR7r87jErmPNwYCmVf/qUdHCiUbVKJuzzKCWtYhGxDTVoeHC73IlUI/9gwagtzkF2p09W/Z3Jbajp+bsKmGIuYGyc6xfE+ymVRlM7G6uvmJAW+gco3sgoAmTmufZqwfFYwPI9OHV1Y4Ie22xXfeQMQezw5YLqMDgRDZ+NR3uUpAhUH4SZYKfj7i3hkG6Kisv/4dXPh5/Q83qGb/miXbtZElt0dEr266xglt2CH0S9T4AE0jFPpmIIe1z2w4xgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+smPUcoHVL0i/SW429zthXccci64Qt21UXG+n0oEbio=;
 b=trVAg2BASCr/y622e1KtBDLD4Tx3Ieb950qQe4dcJU4+KN0Y4Xg1q3ZJXc+qpbfaLsudOdWhZVXy/Go+uMyTdd7niK4BxMxU4KlioB9qfBV7qES7Qc15gmVBSH8dpzesfZLHTw9wEO3ZzatEBWrC5cfPM2Ea7xUgtxs2gZj2nvZyY8D8dl8EMuaH9EXbBMx/SMRm+vmopDLmbXlthWdbgrFVJiEq6RmR78Ad7NgkWjm8x4SS5ONjZsdtslDrv2fqqUpvuUQ9xB0mVNoIhYFR5rYYTDmVY9qE+WGAgNHy/oaqNl4hp9UGgSOky9HsSVwlzRFOzU8Qy/a3Jv/iHLzjzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 06:00:03 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 06:00:03 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: dri-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 05/11] ARM: dma-mapping: Bypass the legacy path for
 core-owned DMA API domains
Date: Tue, 15 Sep 2026 14:59:58 +0900
Message-ID: <13h4sEdhSdWkep6PrkUEeg@nvidia.com>
In-Reply-To: <20260915022922.ECC6F1F00893@smtp.kernel.org>
References: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
 <20260915-b4-arm32-iommu-dma-cookie-v1-5-ba4f9d33a2b8@nvidia.com>
 <20260915022922.ECC6F1F00893@smtp.kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: PS2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:300:5a::36) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: de249134-7e1c-4619-618f-08df12ee9578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|23010399003|6133799003|18002099003|22082099003|3023799007|4143699003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: +JpmuBKBFaRLV1QsqNPqBEaNxbMqWRuBAvm+Ic344osiiW9w9oS8ij1T7v3QSkrBTOuhbgr0lnZTaWuD7hYwTHSMB7bvHNvg4yMiHbxCU+8SploiOYebQyfOH0b4lHSw5lpFhRbozlP5wWopRewICOffCiAH4Fr5GeQ3pszwvCUfOoEhDi3zxZBo0RTf7ny0k7h4KH3ypu6++HNJMasLOEb5lOczlIQOEpanmcnOpy7ArAb6NKSQpgaqj0O3PMhVbVUgRj+yQ3K+MNhvlmhwbzS0vUprLNea3gLXTKYIU4ixPBytqxPbTs+HhtHyY2TV55ntfDcCZeC1AQeaLodNpuzlz1Fem15Y3QuqnbcZXD6Beed8wWOm46/9bJbTHwXrUVjzfqDIAJdfbPJiIGBzrT86+m35cXpr9NG0agYB79L7mZtXjwl9bQBkvRiN1Ucw9psly5kGvJDnHs9i79ZKkbCy1aMq4aHj1w06Qh1xlGYJISnv9vhflh9YHc+Nizt1Q5hSRS41gsBBMhBSjcKg4uw1LybWpTcgcs+yPzQlOm8pEMnD99PJcw3CBGrak98BL+p0L4Lkrzr4cNCXDHndNsMvRyBk9YHf7U2Invy82nZqQI5KxUh1Qxij0UtWl2aPCDuE7mTl772f0UB/0bgrfHh7Cvfs3665znGepZEphU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVh6bTNHTTBIeUY2RjVCcnhPMWlaVGNGdkdMZlhzdzNhcnc5MVBDbWJIYUI0?=
 =?utf-8?B?NTJYUnEzZ3RjT2FPTDMzRXZhYTZGZUYrOUVPODhFRFB3RkFOMnlQdnRIenFV?=
 =?utf-8?B?WFIrVUl5Rkd3QUdHdjBmcjZFZlZaZTV1TzlZNkJMd1NVdjJDeEs0OFpSR2xt?=
 =?utf-8?B?NWVjcDNIRnJSRWRUSUtoTkpIaWNEeGlJTER5R21TbkxwT3NCTnk0VG0xbzUx?=
 =?utf-8?B?VzJNMmhnajRBZnRMR2FrRjh4NXV0OWUrYlg1UHBUeUFVRks4ZDl4eDJOOUhJ?=
 =?utf-8?B?QmtiMnJkRFRIaWRuWXQ5M1M5aHN4S0Vvb1BEYUI3eVoyNEdFMkR0d0xsQVg5?=
 =?utf-8?B?SytUZkt5VVZ1Nld2OW9rL1ZxNXpCTEMrTWNiRHhxQTBlSXJkaWxmempUYTQr?=
 =?utf-8?B?OVJMUXVZcXdmbWlURkFHYTkwODkzZW54MHQzZkR5bFFOMjU1TkZIME8zTmNU?=
 =?utf-8?B?YmJlcVFOVmlPT080b09LTUJoa3dZcEc4am5jTjczbVIxOHRPWDV3Z0N0Nm01?=
 =?utf-8?B?eExTMjZ2ci9kMmZsaEEzR1BzM1hqTUdDNE5zdWhod1VEOStIWkh5cmoxRU1F?=
 =?utf-8?B?U2N3b0NqSDk0MjBKMzlqZkdNVXkwNFBYeWtJeXh4SVltWnI1cDUxeWdtMFp4?=
 =?utf-8?B?Q1JVdk1DamE4OGJQQ1I3VFgwL3ZCMlNHeHF6TlpLVWRZV0Z6MldQMG1zK2dT?=
 =?utf-8?B?QW5pU0JYallqQXpqMERNTmdYak1WMWlYT0l6Q2l1UlFZdWRKUFd2U2s5Sm1s?=
 =?utf-8?B?dU9pOEo4QzNabHArenFEMW16Y3lVTks3dHFNR0VlcXhtQU5oUEdHbngwOEVp?=
 =?utf-8?B?b0oyOGZRbk54cVZVUVdaTHdXbTFmSUg2WGJzN1pkckppVVBjQThQWkViK2VI?=
 =?utf-8?B?VWtibElVdW5PK01qS2ltYUZURTEwOC9tUDRPYUNQMk4raUVkNXR0d1hOV3Vy?=
 =?utf-8?B?N3RMdUtYMXh1WUwzT3lJbzRaK21iTmlXNGNuT0ZoV1dtbkJtendsYmtwbzE4?=
 =?utf-8?B?cW53blZtbVprOTZlTklNQk1iT2EvcDVlYklvMDFHb2NRVWpWZlVnMWo3Uy8r?=
 =?utf-8?B?eFNYMC82SXB6Mld6MitoTFVXckc5S2hhV2N6bDJiVWdPdTJ3a1VZc2hSRk9P?=
 =?utf-8?B?WVAxQ2FhMXhUem1BbEMzWDBpWkIrQm9ldlovanF6bmZ0U0hRbGI2Sm5NM082?=
 =?utf-8?B?RXRKNUZzS0M2TlVKeUNBUHJhbGw0Y055VHpDZ0ExUDlJdTlnSWd1NDVoR3Vm?=
 =?utf-8?B?eDRxemRDV0FwOERRVlJHWjU2WmErTklyT05HdGFNQkw4VUVvRktTdWtla0ky?=
 =?utf-8?B?bHlLZFFmN25VNVVYVkd0OFRTc3hBVW1Eakh0UlRQc3UrU3RnT3hnREp5ejd0?=
 =?utf-8?B?U1dEVW1UMGsyZ2dJRmhDYS9nQi8wVDNJL0YzMDBQeXdtdUpzWWhXVmZXbkVS?=
 =?utf-8?B?S1pnRFFkdEVMMzRpL1FYLzNFN2RKeWtYcmg4M3NLWVFJMFg5VVVISG96TzFG?=
 =?utf-8?B?MHgxMk5UeVVyNjd1WGVnUkVNYnlxVzNuck5GTk9vU3RYQXRabHJiSXRkbWFi?=
 =?utf-8?B?K0JQVGluZjRiMG50YkhmL3BnN1o5QUlRTDlPSHNxNCtNM2w0YlRLSTJIWXpk?=
 =?utf-8?B?bm1uaHB6NzRLc1RVUlF0VER3dmZRcFFVckNENFBCSWtGNkNnUjlOVERwT1lh?=
 =?utf-8?B?RmcxKzVxYmk3alVRMXlyMmZKY0ZuU0NhOVI2NXBJbFJ5YWNzRm11eVpqQ3BI?=
 =?utf-8?B?WFF0MXcybk9rMVd1VzdxM2hINVlHOWZ4VUNnQ244bmtjeEVNeDdKZE5GQU1P?=
 =?utf-8?B?KzRlOW1qcEJlNnpTdU12eEhmdXYvMjNUVm1HQ1UxWm9ZZG4yN3dYek1Jd2xT?=
 =?utf-8?B?WEV0OERWL3FjMnZMU25UQ21uYVdxUXBKdGkzMnJqMjROMXpENTFueGsveGMw?=
 =?utf-8?B?NkhmaGlFVVNqdlUyRFRFbHQ4NFU4M2cvaklsODJGN0VXMk0zYVdNeHZwMktk?=
 =?utf-8?B?WlBPY0tPQ29hcmFvaXVpRFhlaWMwYnNSUnNVbnlCb085QklCUFk1ZzRZWjl5?=
 =?utf-8?B?LzBzdzhSYjFrb08wVWxsZXl2VWxQRTl5SDJteEsvSTlQbmx6TGQ4L0thb3JL?=
 =?utf-8?B?V3Brek1sNHcyVGZ3cXE3NmZHbjl3NDdHejZJN2JKK3RZSFRvdFl2b2MreWY0?=
 =?utf-8?B?ZHg2VUg3MDN0WEZLUmtpRU4wNEtDS291YVJhUXJnaWcvL0xDS2JiWUV5ckxB?=
 =?utf-8?B?VzNwY0txMHlLZysyQS9CdHgxakd0ZGdNM1ZLcktLeERlNSsrdXlTNkxScU1F?=
 =?utf-8?B?cWMwQ0tzVUZHdzlLKzZqcitMS1Q2aHN3RGN3djAvVVIwczNkRXM4Vzc5Nzg0?=
 =?utf-8?Q?KXeK+5p7NK2Flb9gqGH8I7okOv8ABQUQAZbsGhzW7Wlqz?=
X-MS-Exchange-AntiSpam-MessageData-1: ZsjHO8jXMK68TA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de249134-7e1c-4619-618f-08df12ee9578
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:00:03.2175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Zdamsr1v8xX2uLraCt2kVsG/Ynn9L1oXeYkBAa/RZDgQiL+Mo6NApO0gWoZf+bxe+7yaw3vrnga8fBH3yT2NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468
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

On Tuesday, September 15, 2026 11:29=E2=80=AFAM sashiko-bot@kernel.org wrot=
e:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] arm: loss of per-device IOVA bounds for core-owned domains in AR=
M32 IOMMU DMA
> --
>=20
> commit ebe6429aeb25c05897865b7deefe9f71d234666a
> Author: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> ARM: dma-mapping: Bypass the legacy path for core-owned DMA API domains
>=20
> This commit updates the ARM DMA mapping logic to bypass custom IOMMU doma=
in
> management when a core-owned DMA default domain is requested. It adds che=
cks
> in arm_setup_iommu_dma_ops() and arm_teardown_iommu_dma_ops() to skip leg=
acy
> initialization and teardown steps if an existing cookie indicates core
> ownership.
>=20
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index e0d58778c5f54..91f12fb91509e 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1761,9 +1761,18 @@ EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
> > =20
> >  static void arm_setup_iommu_dma_ops(struct device *dev)
> >  {
> > -	struct dma_iommu_mapping *mapping;
> > +	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
> >  	u64 dma_base =3D 0, size =3D 1ULL << 32;
> > =20
> > +	/*
> > +	 * An existing cookie means the core owns the domain. Only set the
> > +	 * per-binding DMA ops.
> > +	 */
> > +	if (mapping) {
> > +		set_dma_ops(dev, &iommu_ops);
> > +		return;
> > +	}
> > +
> >  	if (dev->dma_range_map) {
>=20
> [Severity: High]
> Does this early return cause core-owned domains to bypass the legacy logi=
c
> that extracts and applies per-device dma_range_map constraints to the IOV=
A
> space?
>=20
> If a device specifies a dma-ranges property in DT and operates under an
> IOMMU driver that opts into the IOMMU_DOMAIN_DMA default domain, it seems
> this early return bypasses the custom mapping initialization that previou=
sly
> baked the dma_range_map constraints into mapping->base and mapping->size.
>=20
> When iommu_ops.alloc is called, won't the ARM32 legacy allocator
> __alloc_iova() assign IOVAs based solely on the generic IOMMU aperture
> geometry, ignoring these device-specific constraints?

Ack, will look into this for v2. FWIW, on Tegra (and thus any device=20
affected by the series) this doesn't matter.

Thanks
Mikko

>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-b4-arm32=
-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com?part=3D5




