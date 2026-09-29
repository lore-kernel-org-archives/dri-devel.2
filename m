Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D9DC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0430210ED1B;
	Tue, 29 Sep 2026 07:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="agEi3mQc";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8628710ED1B
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRzDOMP6bsDXurS3WjeU9E+IenhSDC5b+hpLGK2qSeeT3mQoiYnggAif8UmC12opseJ27MaeA9VXUerZFVfLOb+Z/v6CcsFG+hJF+mtgihpZjkiWe5fKxyNqA1Ja/xoKn6tm2n7YLhPpLs4ejCCUpFotPfT27FNGIWwUvcPqVxTm0Th2AFmvsBSav+NywR5I0VjpbonDFSx9NwL9CIJwTdQO7MmjSY7vCjdPQUSheWut0xLlURWPgrlly81CxCWK8MUh2bBjn/jTUwX+hMuK9I9TBR0FyJaFPdAnmADJZssP6jThJ2r2gTnY8ro4hqrMeWFxD+6wMJ4BM5kucBJZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMDgxOnntUM4Mqp2gyb0ZzF+sPD9Fz6yuDG/SWQ7Q+I=;
 b=O8smkyNWfelNtRlTZbkPqAt8JZMeMYaHtuBQXvDv4af8BXAItvPOKlcIc5hjXKngvuMk3KR79SxhXhNDje4RQ40zyQ6SbnoQzjBvU/iWhvb+F+LGW4sqoh9xAEYYl4G6QQzsgB6UJZ7iOwu0BQ8hylWSlCWwmxVakBpfsPuzSwPJUPXMsA0YWtqBYsuFnvhcOyGgkfsFbb+RWYKA0KoAuRwPKplyFO0SuImSVPu/2q1BXX9J5f7fa5f/FI9yutBFFp7KrXyQGc+wciblWcYJg5FqdYUZijLpRcuH3h6N5EGNuTcbushbesKHLVPMQmiZbm/WxWtrMJxjJ1ToLKMB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMDgxOnntUM4Mqp2gyb0ZzF+sPD9Fz6yuDG/SWQ7Q+I=;
 b=agEi3mQcLFQZa7Xd1p9pjBXKqP6n3+BhhhZmrSDOawLT5ufGCZRRahaSHzOfh1D6RRKqF4ynoLWfiioqVHd+eDmbbkgjj0qiitOf2SMzhBgfOJ9pknL+yEOJcHDM9hieL3A79UtWhlx2AiWv7eLSDWjUXLAwIIldyXivy4x76ZIyEnMINNutSiSjunnHknhE3Z7RtO38xGT/TDsS49K6p9vXMR0hBzBHo/PFeYVZbggC3dTzMWRrasJs4yfVIxOn9T0SUdBfOjQrqH+n+sht+jjMAHa4+2uVLqCJ/QBtzSH3kueCFY75DARJrm779Iojz2CTcUr9pYpcjsw5eTng4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 29 Sep
 2026 07:28:52 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 07:28:52 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Krishna Reddy <vdumpa@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Marek Szyprowski <m.szyprowski@samsung.com>
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
Subject: Re: [PATCH 00/11] Make the 32-bit ARM DMA API work with normal IOMMU
 DMA default domains (+ Tegra PoC)
Date: Tue, 29 Sep 2026 16:28:40 +0900
Message-ID: <fpDSraffSy-uBmhoTN1C9A@nvidia.com>
In-Reply-To: <a5b453db-a4f9-4dba-b150-6e4045f61027@samsung.com>
References: <CGME20260915021542eucas1p254addab18c10cb117f42ccf3d3522883@eucas1p2.samsung.com>
 <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
 <a5b453db-a4f9-4dba-b150-6e4045f61027@samsung.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0143.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f010b08-d67a-4577-a18d-08df1dfb4f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|10070799003|366016|921020|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: +qEftXZoHdfYddJ3Puras6jQ0pOwIS/rwrhUt39i+K1HWCJiFFIys/sVWe2TTUQ0UzYt5PyOnOkP7UlUQTRfNR7ijAkr9ZEinnOdcQqZZowNsQvRanv/jMXF/zrosE8Y22DI8M9Aye4CoilX1KcITp0a+OCpQolSL7iXd6SVmQaUSM5yzI9vK8uUesWmIx9Y+5Q65hpYkSZSvUtRFYMi9Suhjv3cRIxQAM8JLZ85SA8EbCqSOchYwPcxQs/QpZIdYB7Nr0/NXc0cTnFRsGad15erjs0JiX6gAIZ2Py29lXhqWYDdqs02SlliJDhZ6v22qqWy7exiv+mt8kD17kbgoWs/9XdJ5Q37H6oFlaSGngq431MwjxzjoQ9/UJju47ciJ5xooMWDI8x8zTLrdiCTPPcLk6Lrat7GHrMaBmzJFNVjezlLXGzxdTYB1kipBrpvJD9C4DJ1TQsmAqmgXQhwZeBJNZDU8ZmKpXN3lZRcyFyssf/8RnH9gth2G9zmUWwrhwN3WZZ1CvotEEBEfddDwR55EKLZq4uZWPnVs7R+Wv8WlG749q0p7CiVW7UBAKhCM2nAuomeo9Tp+msF9lQsjlL6I49fS2xmeSYk8iTHSUe66/v8GHcCb7bcstN+XRilC/SwPoDegH3xrjMRR3Yc6p1AWSR8ETFRcwX9GVVyqTFsNiGJxZVfI0pdIe08O29eQXJQPqI5YHokuR6Fb4l2VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(10070799003)(366016)(921020)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elZITmsxMTlTdWsrZ0t4MjVLRWczRFlHRkdoU2Nrb2tpWjVlMFdGWDhzT3dS?=
 =?utf-8?B?S1gwRjF5eG9NTUZmQVQ1Y3d4Y1NNWFIzelhtbGV1N1pNd3h0TjVrWTNqOXU5?=
 =?utf-8?B?QjBlMnBleVljS2tCMjlIZUZoVC93bEhyTHExZjZzbmdDcWppc3NyNExJUXNR?=
 =?utf-8?B?VTgwRW5RMisydDNrNlBNZU5MN0JlcGJiMUI2NHV2aFdVa3lkQXZTbmhPQTFQ?=
 =?utf-8?B?NFZDcWtmOXVZeFp0NHV1bUloQ3hsVTdUUXIvdEJxQ2pOcUVwREgwZTk4NDEw?=
 =?utf-8?B?MGM4NlNocmJOT21XV0lSTmlvU1h1YTIySk0wS1pEK1RLZ1ZFVG9QSkhLdjdD?=
 =?utf-8?B?OU5PSnV5WVQwVW5MN1VocWQ2aWZKMDJiZHNCbUdYMUZhQnZYK3dVSDNkclZo?=
 =?utf-8?B?RkJYVUFYZFpnZGVXUndoNWJYeHpiR3dzcFZKMUtLOVpKcXZCT1hyVFVhTlM5?=
 =?utf-8?B?eTgrSXVjSElxNHNobzAxRUJId21rNTIza3VQdExuenhidjF4ZWFKQTd0NStP?=
 =?utf-8?B?RnA2dXJZM2Z5WmJ1UFpPTFRTUVQ3OUNwTlMyWUFZT3U4eWFoMlRuZUZDWkJU?=
 =?utf-8?B?aFRpUFYra01LemdBWXRSeFpSd0F4YWVKeFdJQ0liK011Y1ZFd1prSFhac1ow?=
 =?utf-8?B?RmNVM0c3QkdSZjR6ZGQyYm9iZlZQSXltNCtkbEFONVJ6WWhRWDRpdU42NSty?=
 =?utf-8?B?QWt1cmtaelFBRDhsOGZTVzl3dkcyNDFWc0w0TjVLdWJnaGx1emFmbzFzVUI3?=
 =?utf-8?B?R3ZYZUNxaGRDRUY3QUd0Y2lrRGIrbW5HM040RC85MWp3NWpTd2l0cjlyMHp3?=
 =?utf-8?B?THRSUVM2K05zZ0d3K0Iza1BvSWlZRjZqUXVrZ0lpQVh1b0Z4aUhva1R5RU9t?=
 =?utf-8?B?Z09IZnFSeWROTnZ1ZFlNZEIzZUN4Mm5QbTZQS1Vzcm8wbXl2bjNUQkxqYnFk?=
 =?utf-8?B?c093Q2dRTXA4VUZjZEd1dzBUckNTeGZqaVBXbEE3Q3hpNkxVS1J1RCtUTGxG?=
 =?utf-8?B?eUdiUGI1T3VsazlFY0c4ZTlIWHRvNlNnN2tuSkV5RFp2TS9rdG5ONUJvUk5N?=
 =?utf-8?B?RzM4OTljYlVlQWxGdFIzMXFvTWgyd1ZObFFPSkpOYTIvMzgrVTBFQnZocVpI?=
 =?utf-8?B?TElzTHc2eWcraGNEQ1ZsdHhLckc0Y0J4QTF6eDFKRUhJYXhBemRSYkR3VjRa?=
 =?utf-8?B?cU0xQS9xRnpTeXIrNEVXdVEzam5yUlJIMlkycjRqbUpiOS9kYkxmNmZJd2Vu?=
 =?utf-8?B?QWdiTGJ3cFpIaWFPNTlnV294dGo3VTU4L0RRQzlORHphTjMvbm5KOVFOQ2Fh?=
 =?utf-8?B?dGtka0VKaUs3YTR4cUljZCt4dHQ1emMxSGlNbkx1endhREFFMC8wVHN0Rmsx?=
 =?utf-8?B?aCtQOGtQNlIwMzFCT1NHaXJObWhUTmhjdnltSnNKdDFvVDI1bXorS2xlMnMz?=
 =?utf-8?B?ZExxdnpOdnJpQ0ROOE04elN2L3h3NTlYa2pYdS8xME5EUTlCMktLSFFyQm9F?=
 =?utf-8?B?VUM1VWlTYi9UTE9UVmVWemx5andKOTRIV3o4MVlUbkRuV2FuUlJUcGZLOUhW?=
 =?utf-8?B?enY2Q3E0SzQxY0kzcGgzQUxSeWJtM0pJeUh5MHRRREx6WXB5Q2JueFFnSThG?=
 =?utf-8?B?Z1RKeFZrampYNERINmlOWUludG82dGxYMmovK25nbXVyN241dithVThRLzJy?=
 =?utf-8?B?NHF5eWkwUFRwU00wY3BRYVFnd09meFNvUDVzYmRRSjhESW1VYmQzOTVwUlZK?=
 =?utf-8?B?YXEvSStuZkdUclRFMHlhUlU1Qmd4UDI0THVJNzZmOUZGZ0tIcklqTmtOb0d0?=
 =?utf-8?B?NTl3UG5ZNkVnVWU3a09saXZCSDZhRVY3Yk9XYjdURmxVc3kzVjRNWVA0am5E?=
 =?utf-8?B?NlZmL1ZRcTFBWng1Wm16Ump2K0dJVXgvQTlIc2V1MGQyVVBmdThIc2lZUC9s?=
 =?utf-8?B?OUtsYnk4T0R3V3FKSzQvNXQ5dTRSeUZEWm84M21XclZZUGVrLzYyUFR5SXZE?=
 =?utf-8?B?TWhvUGJhVmZjRGg2cU5BMm5xZTlRS2JpNXd2RklzYzUrRk5lZmtRdlBPTkZY?=
 =?utf-8?B?WmF3dVJWdjFxdmlDQWUwTTBuUEFvMHQwS1hscU1QNWJsd3FCL2pFb0U3V2Fj?=
 =?utf-8?B?WVZ0OTM4VEJPOHU1QVVlL0Y2Y3B2N0NiWStUVm5UTVpwZ3ovUjF4TjdZMEdN?=
 =?utf-8?B?TjBMTVllam5CRWFaQ0JiWDdET3VjN1d6NEM5ak41bjJDaHAvMlQ4aXZCZU5k?=
 =?utf-8?B?SXZOdkV3MGtENGdWc1pPb2U1dWFpL1pVZk9ya3l1ZFRWYkFUUGYycWcvWUMr?=
 =?utf-8?B?SFpuQWVQTEgrcmRhVnJyNE9NSjJUNisxM1g1WWhONUxDTnllZEFQUUZzNXYy?=
 =?utf-8?Q?qxtY6/XS1JE/90oiKZQWdNMIVBaIQMooJkl5ISQAuvsXy?=
X-MS-Exchange-AntiSpam-MessageData-1: 7x90EcBWwRMhIw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f010b08-d67a-4577-a18d-08df1dfb4f58
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 07:28:52.0395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnBivfYtFavwTZvq6/k0h29ponIRg8NfCNt342YJoUbeAHtvqdXynbR5tfZo6g+Xn0IiuD5iaZGvScZH0tSmzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706
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

On Saturday, September 26, 2026 12:20=E2=80=AFAM Marek Szyprowski wrote:
> On 15.09.2026 04:14, Mikko Perttunen wrote:
> > Depending on the probe ordering, TegraDRM does not currently probe on=20
> > kernels with CONFIG_ARM_DMA_USE_IOMMU enabled, such as with=20
> > multi_v7_defconfig. The Tegra SMMU puts several display and 2D/3D=20
> > clients into one IOMMU group, and the legacy 32-bit ARM DMA API path=20
> > creates one UNMANAGED domain per device and attaches it with=20
> > iommu_attach_device(). That only works for one device per group, so=20
> > every client after the first fails to attach,=20
> > iommu_device_use_default_domain() rejects the group with -EBUSY, and th=
e=20
> > driver goes down with it. tegra_defconfig is currently working by virtu=
e=20
> > of not enabling CONFIG_ARM_DMA_USE_IOMMU.
> >
> > Robin suggested [1] that instead of teaching the legacy path about=20
> > groups, we should explore modernizing the 32-bit ARM DMA code a bit by=
=20
> > making it use domain cookies and have the core code own the domains, as=
=20
> > is the case on other architectures. Still, ARM's own DMA code is kept t=
o=20
> > support existing drivers and APIs that expect it, and because dma-iommu=
=20
> > is considered too big and unnecessary for 32-bit ARM.
>=20
>=20
> I agree that such little modernization is the right step to unify a bit
> ARM 32bit with modern archs and get rid of some workaround in the drivers=
.

Yes -- certainly TegraDRM's memory management paths have grown to be=20
rather cumbersome.

>=20
> It was me who raised the concern about the drivers depending on the first=
-fit
> allocation algorithm used in the32-bit ARM DMA code. This is an issue for=
 some
> legacy Samsung Exynos drivers. I not aware of any other driver used on AR=
M 32bit
> SoCs that depends on this behavior.
>=20
> If one is still interested in switching ARM 32bit to generic IOMMU-DMA co=
de I
> can prepare a workaround for those Exynos drivers. I still have it on my =
todo
> list, but in meantime there was no interest in updating ARM 32bit DMA cod=
e.
>=20

While I don't see any immediate need to touch the allocation algorithm,=20
being able to get rid of some or all of the arm_iommu_* functions would=20
be nice. At least for create/attach, there aren't very many callers.=20
Most drivers just get rid of the ARM mapping.

Thank you!
Mikko

>=20
> > The series is in four parts:
> >
> > - Patches 1-2 are preparation in the IOMMU core:
> >   1. Add iommu_teardown_dma_ops, counterpart to iommu_setup_dma_ops.
> >   2. Add cookie type for ARM's DMA domains.
> > - Patches 3-6 implement the DMA API side on 32-bit ARM:
> >   3. Split up domain and address space management code in arch/arm/.
> >   4. Implement parallel dma_ops / cookie APIs on ARM side.
> >   5. Avoid domain allocation when IOMMU core does it.
> >   6. Support foreign-allocated sg_tables.
> > - Patch 7 enables 32-bit ARM IOMMU drivers to provide a DMA default=20
> >   domain.
> > - Patches 8-11 convert Tegra:
> >   8. Allows deferring translation enable until driver handshake for
> >      selected devices.
> >   9-10. Removes code detaching ARM UNMANAGED DMA domains in
> >         Host1x/TegraDRM.
> >   11. Enables DMA default domain for selected Tegra devices.
> >
> > None of this should have any functional effect on any device other than=
=20
> > the Tegra devices enabled in patches 8-11. Other IOMMU drivers can opt=
=20
> > in later. The new DMA default domains are enabled only when the IOMMU=20
> > driver explicitly specifies a DMA domain type, just returning 0 for the=
=20
> > default is not enough (unlike on arm64), keeping the current behavior.
> >
> > Patches 8-11 are provided for demonstration but we can deal with them=20
> > separately if the rest of the series is accepted.
> >
> > Patches 1,2,3 are applicable independently.
> > Patches 4,5 depend on the previous patches.
> > Patch 6 can be applied independently but is only required once
> >   the whole series lands (by TegraDRM).
> > Patch 7 depends on patch 4.
> >
> > Patches 1-7 only touch drivers/iommu/ and arch/arm/mm/ and associated=20
> > headers.
> >
> > Best regards,
> > Mikko
> >
> > [1] https://lore.kernel.org/linux-tegra/910d1492-ad3b-4201-93c6-208be1d=
cde7d@arm.com/
> >
> > ---
> > Mikko Perttunen (11):
> >       iommu: Add iommu_teardown_dma_ops
> >       iommu: Add cookie type for ARM_DMA_USE_IOMMU
> >       ARM: dma-mapping: Split mapping allocation from domain allocation
> >       ARM: dma-mapping: Implement and expose DMA setup functions
> >       ARM: dma-mapping: Bypass the legacy path for core-owned DMA API d=
omains
> >       ARM: dma-mapping: Handle foreign buffers in arm_iommu_get_sgtable
> >       iommu: Let 32-bit ARM drivers opt into a DMA API default domain
> >       iommu/tegra-smmu: Defer display client translation to driver hand=
over
> >       gpu: host1x: Drop release of legacy 32-bit ARM DMA domain
> >       drm/tegra: Drop release of legacy 32-bit ARM DMA domain
> >       iommu/tegra-smmu: Use a DMA API default domain per swgroup
> >
> >  arch/arm/include/asm/dma-iommu.h |  17 ++++
> >  arch/arm/mm/dma-mapping.c        | 209 +++++++++++++++++++++++++++++++=
+-------
> >  drivers/gpu/drm/tegra/dc.c       |   8 ++
> >  drivers/gpu/drm/tegra/drm.c      |  15 ---
> >  drivers/gpu/host1x/dev.c         |  15 ---
> >  drivers/iommu/Kconfig            |   1 +
> >  drivers/iommu/dma-iommu.c        |   5 +
> >  drivers/iommu/dma-iommu.h        |  52 +++++++---
> >  drivers/iommu/iommu.c            |  24 ++---
> >  drivers/iommu/tegra-smmu.c       | 109 +++++++++++++++++++-
> >  drivers/memory/tegra/tegra114.c  |  15 ++-
> >  drivers/memory/tegra/tegra124.c  |  12 ++-
> >  drivers/memory/tegra/tegra210.c  |   6 +-
> >  drivers/memory/tegra/tegra30.c   |  18 ++--
> >  include/linux/iommu.h            |   3 +
> >  include/soc/tegra/mc.h           |  20 ++++
> >  16 files changed, 410 insertions(+), 119 deletions(-)
> > ---
> > base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> > change-id: 20260728-b4-arm32-iommu-dma-cookie-3170e07f9125
> >
> >
> Best regards
> --=20
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>=20
>=20




