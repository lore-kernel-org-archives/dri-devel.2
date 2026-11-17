Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58E606A8AB
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n+k2RXK6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4F910E56B;
	Tue, 17 Nov 2026 08:32:19 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013057.outbound.protection.outlook.com
 [40.107.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C555310E56B
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 08:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1QGMLhrOQYULdYR1z2mxwuoaKmvFqRZeEKli+f6e7DI2+BHFFYhEa82Qi/MwFnAovMO0ergm3LM662xDFuUylI9c6wt8IXWIFyFtchfAw7hxuwzHYEX0PrJuDl3rqONJVvQ1+AuQUjl+y9flPyR/tk4G6O341xup3HWImux7F/IpGsJMqo4QrRQniEt/lfMhmO6PQzFbbzhQnldNaTGtPmkhnPk+KSy+pfqXXWENY2/rtHdk5hTQt8a9Dorgo4wMb1e9VND84R7ES/MvPeodqPgQFI1ctUFb9n1aQtxIh3udt/LZk+cA9lQmg0WIonFPexmGUv28Vtohn7EnZckBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsX0Na8r0LEdvtPeUJ4lupJWev6O4LS03l7GyoeweoM=;
 b=QQ5QHpyf040v0/cq1mbo0WGTfHNBkIeA4zgcaSAhCtbl2PRBBxyBcl3u1OEiC2JN62AGxAr/q9RJhut1zJPbAZp8tYMMuCYU1J87ZYhsFeTTbqqV7oiLAgyVEPWwQ0Wc+X3HmeiEhW0oyMiDNXHKlaqWkCn+Cqifq5iCABZ9OM+M29v5E842rka20HmpkGjdq0ksHBaRXMflEab4Y7woEZv6vAMrqv6FR3FdXLiNU94KJYWoMnClZeQ41z92bHOvPQ/RT6TofRHmYXQMxG9+q1QgboBhxAFLFp8uSl4mEzxd6zvwiK/ZLBK5dLcRuk40kotMY4ezAI9QOvPTvoreSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsX0Na8r0LEdvtPeUJ4lupJWev6O4LS03l7GyoeweoM=;
 b=n+k2RXK6irnJVfD1IeJpRC+cDm9XInNU1cgv5HWXI0cq3EXhxWxBOBLeHJhkVK6nhsf6frn3fu6UjUG20EvJTxcTUuNywA33fvjcczu9kGZASpZ2rYeWiPaxtnFrW/Ia+wFJxbhYeorbgrZlrc16gahIF0nWvDMduZ2qIfte7bIdi3stwfEf0Sjt8gCjs94G420jpb7U6fJeLvFojqa3VX2AyZjjyAxV1VYlTnXhDm+AFdQ1TLD9ypg4OKiY9YX65gEUPcHeNtFWZcFT8O7q+4aHZC7rG4WcBA9upAasOrF77QArUsHA0bNM2/1duO2DW8qWQnrQJpj+JccOTB1a8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH4PR12MB590718.namprd12.prod.outlook.com (2603:10b6:610:50f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 08:32:10 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 08:32:09 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: dri-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 10/10] iommu/tegra-smmu: Use a DMA API default domain
 per swgroup
Date: Tue, 17 Nov 2026 17:31:33 +0900
Message-ID: <UQktJpp1TiatubO14BhQmg@nvidia.com>
In-Reply-To: <sashiko-outbox-185204@kernel.org>
References: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
 <20261026-b4-arm32-iommu-dma-cookie-v3-10-3901d74b1ff2@nvidia.com>
 <sashiko-outbox-185204@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6PR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH4PR12MB590718:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba0aeeb-244a-41b4-a0c5-08df44854564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|10070799003|1800799024|5023799004|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: cPuDJgma6rYpd3sB9xzobLvcN15MSTl4NE5vIVhvLoCLpM+ykqnvsTlh1urPQIM1a8XDuK5NYAKaHbh28KOilrScwO0nGHA5yDFiie21SHbJzyR097zUUdQzZ0f07IGfixkLYu9pnXpX0xv6M7Xpk9RSmQyY6hFg/gpqWjj7g0ajJTM5qq6ZWGBwLPN30o5H0QmyA0NQuIyfBOl9lliaO4cxGJKeBUJd2fXJRZzApcqVL14GXWMcTdGxSnT4F6oQm3EaHbGqQ3b1azpExFVBCdHt4EyN77T08Lcsq9Y1Awv3GUG1xVF6Jo2o3YWj3uDAyvr69GYsPeqTq6C/Euh2W1p88STUVMZgq2//G8hq1yq9tAtKh9CrCKNsgm/vRbc/YSQ+yNBnAGM5Li9mCkebpts2qzSTdYzLap+5BFbroI/gBYAAAynqFns62R18n0jZKbSvNwHGr4uLXtD8h4EC0VQNqEnZ03MiEqquDOqUiO74ZbX3N5g9NrX9TZZFfZaq4oMm7DD0GIebR7DtP34o/q8Qyag/tpThdB1yjM0qkuME5jdq174wSpHEuIbmC5KjmL9slM3ciEZpCgo79cWly2p+FTGahPxAbQ/qz47Md3KDQKA72+ChBIRHDy2+IXxG4tSOUSCP/EzNbdrsVOvLMrnGGYcdwxyAcyHXzUR1tnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(10070799003)(1800799024)(5023799004)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmVJMDZYTERGRnI4Y1lvcEgvVUR3REpwQTRmTUY2YkhMbTYrVlhVUUFFY3Iy?=
 =?utf-8?B?OFQvZ2dEczNUWENyVDQ1bEFQTWU1SVl0MEdOWWxXSyttR3RYSUtURGI0R2tp?=
 =?utf-8?B?STVDL1Qzbi8zNGRTMk1PVWplcmZCaFM5MnhyTFRwc2NQRHd6cDZVZzhLRkx6?=
 =?utf-8?B?YjFSZENZWnExMm9RM0g3c0xXR29OVjRFdVprZWY3ZW5vb0k4RGdtOE00dnBB?=
 =?utf-8?B?cS9iNE90czFvSldMSG44eDFhNzNCNVBPRW1nWGcrRkpkSE1GMGplMStscEg0?=
 =?utf-8?B?bHh0VXB4MTNtbGhNZ3hGREVGa1pybjVDRS9DOXZuTTgwaCtKRkl2dHBLbDJJ?=
 =?utf-8?B?bnpVQ3UyVU9oN0M1cFJGTi9ld01lVzh1eTF3RkFmQ3N2NitGMS9JTkZFTXNX?=
 =?utf-8?B?dlBwc095L2tWakhCUTZpRnhTWUZVUVBFazRUTExXOUs4NHRUUjlMSDlpY3RX?=
 =?utf-8?B?WGNtbytXUXBVTEZ4dGxtQ0t1cmc4Sk1nU21oNDNzaVIzYk83SVBTamU5a1lM?=
 =?utf-8?B?bngvQnRhRkJ5ZHE4MmRXbXNPTWN1QUh6M1N2R0pxZmxEQVBzUlU2aHI0ZWV6?=
 =?utf-8?B?dm1tVjJkT2ZtaUpNR2pGYzZjVEFXM096dnFDV0Jjc21obHo2aFBOSmhYTmdr?=
 =?utf-8?B?UEl4T3hGZVN6amJkYVNtYjRiNE5yVnZrTWtjK1JGYlkvN3NvTlJhVU15VHFO?=
 =?utf-8?B?eUxaQ1VjbG5qbDdUa0c1eW9aTFFPRUluSlR4eDBDbnFadUJKbjZWdmQvdFNZ?=
 =?utf-8?B?aUNESjN4SU5PZUROZW9pbU9OZUhxQ29jNWp4U2cyU0lTVlNWd0JHaU1xYnc2?=
 =?utf-8?B?dnZjQTlTZFJTMjRwSWo1MndrUENQU2lBcHdmV3NJUExsUXRQZGU5U1Evcklx?=
 =?utf-8?B?cUxzNlNzM1V1S0VDMWpxR0ZLdCtMKzF6cVlQNi9VeWU5OERCaDZtc3R0WjRl?=
 =?utf-8?B?cXo5V3cvck1KNkkrSEdaRFZsQzBITG1SdEE0cmhRK1FDcWhpQmpmUWpiTUZt?=
 =?utf-8?B?S0ExKzJJY2kwWXZENmhFWjI5T2FHSWx4eDlwT1lTVDIzUytzaUIxMDk2d1k1?=
 =?utf-8?B?Um9KNTkvbW96Tlg4ckpFY3dtN0ZwS2RvSWFGRGxOdzB6UTBEdlVmSHcxQWJ0?=
 =?utf-8?B?cXRDQU9wYTZyVk1pOVdyaUtheWdVcXFEWjZGeEREYzFYRzc0OFNLd25QMU5q?=
 =?utf-8?B?WUJRK3VJS0NEQVNBY01kUThjbUtDM01ORmFzTjJzN2UyRnpCMk5ibDVTNXZ0?=
 =?utf-8?B?cVdhb0xxWnJiKzZTTXE4Q25BSmdVRDZzYldQM1hUVEVUaEp3OEJXTDA0dklt?=
 =?utf-8?B?K1VkQXQ2SVRJTmJYZWd0Y09RTVlONG5SYXd5eU4vTnZnSWVES2lPbXRlWkRZ?=
 =?utf-8?B?Q0ZJS0xTazJEbXlTYzNDODdIMXZpOGJvYlJJaE1TUWVLc252ZWFObFdFSjJ0?=
 =?utf-8?B?S2duMkRlV1dkZ2IyajNDb3Vqb3B1cTQ5NnAvYS84cXRZOHV2bWRIaEE4WmJy?=
 =?utf-8?B?bjMxNDBrQ1d1ZVd0aFNPTXdRQUs0aUlMRDFXdTVqVXN5RlozU3k4eEo3dlls?=
 =?utf-8?B?dldMV3BGTGlNODZzR0tJRGUzbHRpbFZmc2d0WFhacDA0TUNrN01IYXdocDhZ?=
 =?utf-8?B?S2NENG9JQlJDeFpqRXF4L2JVWXVtaWFHZnNQZmNOSzlxY0ZZcTBlY0NKQW0y?=
 =?utf-8?B?a1VwVCtpMEdreUhZT0RFc0xkUHcybEJSQnRzVlpVYXY1ZDlSbzlWc01OY2VI?=
 =?utf-8?B?OHRqMzIvczNQOXJVVmZBemkyN0oyMUhFMFhvektleEFYcHkxbTJyRWVzVWNx?=
 =?utf-8?B?V0VoSC9OWUtXT1BTSDBHOXdXaUFZM3dHQlFNSzRWNC9Ma2tUa05SRTgyQVlS?=
 =?utf-8?B?U0JVV1YrZzJROEdjZVViU3dVMll0UDQrY2o0QzBlVDlHd0lZQldycE1hbitG?=
 =?utf-8?B?eTB5RmVWWUtaRzNQcEFTWDNpRkdWVVBxNEpSRStWSnhVcWU2V2ZhdDhsK2ZY?=
 =?utf-8?B?S1U5RUtUTFFJVVZjd2hYaVJGeE5YL1JkNll3TUVJTE1ZYjVoS0NIMnZ2L1B1?=
 =?utf-8?B?N2JlbGdLUVYwdFFQQUZPaFREL0poK3lCMG13clhRd1psejMydzI1SEdEZUsx?=
 =?utf-8?B?OEQ4VHlGU1JZVzA5bGZrdElSNzJ6bTd4SytuVVBybzEwSmVqd1RMVUFIWitX?=
 =?utf-8?B?aGRYSk9wcnpZbm1aMzc5ODVzMEhrZlgvT1RvaHpLcitodEMvMkl1NDVLY1B1?=
 =?utf-8?B?Z0dQc0I1MUZyTFBZTUpLcnFzYlJhUXBEdGM4d25hU3R5NU5JMjU2cjhDYkJ6?=
 =?utf-8?B?RXBFZlpCVWZoSHYxWVU0ckp0UEtpeURoaW1oTlJsaStoUzRiSHpUTmZ5QnYv?=
 =?utf-8?Q?Wz0QvJ0u8QgK3tWOnk8AHQ0DTGFr7vb7Ay3PX/UCJ/Qw/?=
X-MS-Exchange-AntiSpam-MessageData-1: 4GXMVACozmt0QA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba0aeeb-244a-41b4-a0c5-08df44854564
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 08:32:09.8177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ahis3L1oyZmcg5VArIzr20UsGocFdJBuyyTNvQ29p4l8V8s4TF2zYp5yx7gNxOYMSF/+h56TlAEJTC0/rNyROA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB590718
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

On Monday, October 26, 2026 9:24=E2=80=AFPM sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] iommu/tegra-smmu: tegra_smmu_attach_dev() leaks old paging domai=
n resources
> - [High] iommu/tegra-smmu: NULL dereference in tegra_smmu_identity_attach=
() on probe failure
> --
>=20
> commit 82c4953fbede4f90881980155ea701c19e530777
> Author: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> iommu/tegra-smmu: Use a DMA API default domain per swgroup
>=20
> This commit enables IOMMU_DOMAIN_DMA default domains on a per-swgroup
> basis via a use_dma_api flag, initially enabled for TegraDRM and Host1x
> devices, and sets .release_domain to tegra_smmu_identity_domain.
>=20
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > index 6779528a9e7cc..73c6151db8f8c 100644
> > --- a/drivers/iommu/tegra-smmu.c
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -994,16 +994,20 @@ static int tegra_smmu_of_xlate(struct device *dev=
,
> > =20
> >  static int tegra_smmu_def_domain_type(struct device *dev)
> >  {
> > -	/*
> > -	 * FIXME: For now we want to run all translation in IDENTITY mode, du=
e
> > -	 * to some device quirks. Better would be to just quirk the troubled
> > -	 * devices.
> > -	 */
> > -	return IOMMU_DOMAIN_IDENTITY;
> > +	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> > +	struct tegra_smmu *smmu =3D dev_iommu_priv_get(dev);
> > +	const struct tegra_smmu_swgroup *swgroup;
> > +
> > +	swgroup =3D tegra_smmu_find_swgroup(smmu, fwspec->ids[0]);
> > +	if (WARN_ON(!swgroup) || !swgroup->use_dma_api)
> > +		return IOMMU_DOMAIN_IDENTITY;
> > +
> > +	return IOMMU_DOMAIN_DMA;
> >  }
>=20
> [Severity: High]
> Does transitioning between two paging domains leak the old domain's as->i=
d
> and as->pd_dma?

Will fix.

>=20
> When tegra_smmu_def_domain_type() returns IOMMU_DOMAIN_DMA,
> group->default_domain is a paging domain (struct tegra_smmu_as) rather th=
an
> tegra_smmu_identity_domain.
>=20
> When switching between two paging domains (for example, attaching or
> detaching an explicit unmanaged domain or a blocking domain over the
> IOMMU_DOMAIN_DMA default domain, or changing the default domain type via
> sysfs), the core invokes tegra_smmu_attach_dev(domain, dev, old). However=
,
> tegra_smmu_attach_dev() ignores old and only prepares and enables the new
> domain:
>=20
> drivers/iommu/tegra-smmu.c:tegra_smmu_attach_dev() {
> 	...
> 	for (index =3D 0; index < fwspec->num_ids; index++) {
> 		err =3D tegra_smmu_as_prepare(smmu, as);
> 		if (err)
> 			goto disable;
>=20
> 		tegra_smmu_enable(smmu, fwspec->ids[index], as->id);
> 	}
> 	...
> }
>=20
> Because tegra_smmu_as_unprepare() is only called from
> tegra_smmu_identity_attach(), the replaced paging domain's as->use_count =
is
> never decremented. When that domain is later freed via
> tegra_smmu_domain_free(), it triggers WARN_ON_ONCE(as->use_count) and
> permanently leaks its hardware ASID in smmu->asids and its page directory
> DMA mapping as->pd_dma.
>=20
> > =20
> >  static const struct iommu_ops tegra_smmu_ops =3D {
> >  	.identity_domain =3D &tegra_smmu_identity_domain,
> > +	.release_domain =3D &tegra_smmu_identity_domain,
>=20
> [Severity: High]
> Can setting .release_domain to tegra_smmu_identity_domain cause a NULL
> pointer dereference in tegra_smmu_identity_attach() if attaching the
> default domain fails during probe?

Yes. I'm thinking the appropriate route here is to make attachment not=20
fail by moving the things that can fail to domain allocation, which is=20
now possible. However, I'll defer that patch to after the groundwork is=20
merged not to bloat this series too much.

>=20
> During __iommu_probe_device() -> iommu_setup_default_domain(), a new
> IOMMU_DOMAIN_DMA domain is allocated with as->smmu =3D NULL and
> as->use_count =3D 0, and attached via:
>=20
>   __iommu_group_set_domain_internal(group, dom, IOMMU_SET_DOMAIN_MUST_SUC=
CEED)
>=20
> If tegra_smmu_attach_dev() fails inside tegra_smmu_as_prepare() (for
> example, if tegra_smmu_alloc_asid() returns -ENOSPC when all 4 hardware
> ASIDs on Tegra30/Tegra114 are in use, or dma_map_single() fails), as->smm=
u
> remains NULL. Because IOMMU_SET_DOMAIN_MUST_SUCCEED is passed,
> __iommu_group_set_domain_internal() still assigns group->domain =3D dom
> before returning the error.
>=20
> On the error unwind path in __iommu_probe_device(), iommu_deinit_device()
> attaches ops->release_domain while passing group->domain as old, which
> calls tegra_smmu_identity_attach():
>=20
> drivers/iommu/tegra-smmu.c:tegra_smmu_identity_attach() {
> 	...
> 	if (old =3D=3D identity_domain || !old)
> 		return 0;
>=20
> 	as =3D to_smmu_as(old);
> 	smmu =3D as->smmu;
> 	for (index =3D 0; index < fwspec->num_ids; index++) {
> 		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
> 		tegra_smmu_as_unprepare(smmu, as);
> 	}
> 	return 0;
> }
>=20
> Here, smmu is NULL, which is then dereferenced in tegra_smmu_disable() an=
d
> tegra_smmu_as_unprepare(). Similarly, if a second device joining an alrea=
dy
> active shared group fails in __iommu_probe_device() before attaching to
> group->domain, iommu_deinit_device() will call tegra_smmu_identity_attach=
()
> and unprepare the shared group->domain even though the failing device nev=
er
> prepared it.

Likewise deferred, probably a fix in IOMMU core.

Mikko

>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-arm32=
-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com?part=3D10




