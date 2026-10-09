Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCDACA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882531121AB;
	Fri,  9 Oct 2026 14:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MPdRqLmn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41BE61121A7
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 14:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMXBW8OrP+OXkDBF2gTJPHqP6lllVDNfoESgP/Qfw/lRHLLA8+7AsUJ9BvGpfmxVy6E5EEs/s0Mc+/VFTlhfbFGus7S8gl/S1aI2zoFhELiZJDS8a9kA3f4UGO/WLpgVb4II2OKM2on4i5v27DAMnaNOQt1QwGOwJZ0tUgSUKSbkcVnvIEkHDOsEwRIXA5d/wMyWPG1fhzYRVpoOpqoXJ2LLDsy+ksxf14svR3mE3lhAj8obf4pW1RZRdRGRqX42pp3KdK5duknm31ImllekCYFQ0qiYcEfn0PLVM/HhXAECYn7qHcynuJPstrzW4CpvFF0HRAi+Z6wK5DapI8/5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lzj0/FMthPmD+zy8ocYz7qr/nwxApU7bjPa3TkzroPc=;
 b=tSPDse3dL1sEtnU/MOK7b1m33wpJtBjoeQyuCrWrUM6dVzobp2vMwFI/XfUDXxiSlan7W0rtPdP+g1p8TLeTUnKfODrW7xPSv5juL0umKB5MbVj9n0pa7f/TGthR/GFpmROjYt8LKBpr+jKiaRMn/rtLwBIPC/xPn8OQm+aAR7SX7kQIB5cJKNSbFk/yHhwGCHjINtjTZJ4UhpZ1oleuyliqZ1ZbfHrfmQaqN5z73Elkg1ivNNEHEAZjy85D01+vbMvF6V8LAH8DOij/N9oPlA1rDYTaHOBj7aFbs76ZviAPXVCg39kAb2CtXPKtpil45x2C6SzakSMwUg6k2aX+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lzj0/FMthPmD+zy8ocYz7qr/nwxApU7bjPa3TkzroPc=;
 b=MPdRqLmnHsIYs+6FZXShhvJQgFFHB3WUo4d7i5jowa2ioNP4cQR+PrPnN4vwBd8FXxoCCveVunr6Z9EAg9Z28wFzl0yLa3sotKOzWD2DHrfqMchpkEp2o0lXbd8xlIRuVPLRy1mmvG4BQCqFyznCYBLQNHyrt32LwuqhElR/jyBN/wmFgcWCnHK0OwoEV2zr8ValgBqcgHJl7BhFzbeyamkgCeQEdnYcfuko24BhLLBXxHopaMf/RWrTZwpvo0gsc5pYwJr2omRlmFyzRpz+FtrW819Kk8Z39xdbgPjx78HaOCv/eY9NpvdKcIcTiFXwiUqiIsuMFPTMPqxfSOpslg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA0PR12MB8207.namprd12.prod.outlook.com
 (2603:10b6:208:401::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 14:43:20 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 14:43:20 +0000
Date: Fri, 9 Oct 2026 11:43:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Alistair Popple <apopple@nvidia.com>
Cc: iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] iommu: Add iommu_map_sgtable_dma()
Message-ID: <20261009144319.GA58900@nvidia.com>
References: <20261009002114.67851-1-kmehltretter@gmail.com>
 <20261009002114.67851-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009002114.67851-2-kmehltretter@gmail.com>
X-ClientProxiedBy: YT4PR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::21) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1ff189-dbec-443b-9628-08df2613a9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|4143699003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: l1SKlmN7a5cmPfSoAOiOcHkmYwgnQPag5BK4t68BmMxHgEvn8pLf9uN/3EIJb3wvZcG0k8D6b99yvIK3q2sc4Knnzbapo+BAt7uhTVE7nGUlETM1CQqd+Wvu2km7CLMYhNVA9OHoc1d7bVFFMc8Vu5v1Ju0arAx6NtcMUg2zZn0ehEAv6LispeEiMphD37MCUUt4GLt1cbNiZRnKH57aTVuijVrCxCpVLCyzp6LCnxMvtXkIoT+t31taIKLU32ICkS6g/0TYoP7jLqSCRva7OJivNzROracYYTOnSzCY4kQu/jv3/7jM+oTQCmL95Ycz/k4sOmQv0G2gYZa2HCBRAio/rocnMbvEVuJkCEtNi1L4XzNUDhp7ib7lvjMKE3cEh0hqQOyKY7/g73pyqPW6B8WtT+ctxVjwmJ2a4sXP8d3RZbouA6BbCb393KGvbcZtm+l2iIqxZOPLPudQpkbQTpV9X9qbFpMog0Kw/D3+tC9HK3X5oBnYH36/RreiqDlkhrYBksKDLX0i3SwwJOxwvQ9ht0mH+pYV6W8wS985kinyAJY860WWbZCzk8FyEdQC+aCeFa4BFp+SJTpMzTbyry/xu3lzF6ILgsE2/1md+8qAZ2q5PHrGkmI8yb9p6/eCADQ9ZT0fPZRMPC6S3bWDo+/k0sDQlPFkXOl8GitG1HM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wvH+h9sEGxVzQEnUy9PMqtWLSATdT2bltIY1F4wxk77ddwR2hNm3YqIqWKyJ?=
 =?us-ascii?Q?0kiT5CSfisUxHz0he3Ls0FNd4gsvy1vYAGMR7wv9XAHeFfEhmA1Hy8xBpgfc?=
 =?us-ascii?Q?CeVQp3MJSXujY6S/6KjxsxNN8FrszCmWUSyg+HN4+tmbOS+pVO4gCmfgPeRp?=
 =?us-ascii?Q?R3oLX33LU4l4xqitz4eQ9qyAyhC7ed/ybXIzDlxg3ZEqBxiHJA3MrONirZnG?=
 =?us-ascii?Q?fD37etUy09OAZRAltCjVKSwKWTaE6H0jQcYsQ+5F1dqbwxsYPpTLa56Uyhay?=
 =?us-ascii?Q?6HJLGJ3nRBQI4Wyly7o0mmlIVpdXOOOO4tqpl5bgEpanXWQ0jogbCtnd1bl6?=
 =?us-ascii?Q?Wf8wEFkUSqk3jH78YAeJ+sz6PIFpwdGtV49ljXpczrYS4aybuman/MaJ5GCu?=
 =?us-ascii?Q?xDQ6P16MAkWtLTl0BLd9CgRBSoKYAjWIm/sjRIxHGaPGLu/Ny1xZssx3qRW8?=
 =?us-ascii?Q?1UsemdXhqCi4EJSSNY/c+owRbCNYoJXcw5YITM+9Nmwe1fieB92yRqFQlPV1?=
 =?us-ascii?Q?xOYF7i1c3yDNS4NBVOpZliWhFl7+vdaeKEa8dgMiV91M1wK8Ua9iaX1aP5iB?=
 =?us-ascii?Q?0JrmMD5kSGHssr2P0ww73kEEqAuMh5212+RjxK5g8Vx0K/usKFt06aLUiHzx?=
 =?us-ascii?Q?2AxLAtr4x2SBOJHuzEaJFB+RxyFCHMpCo9aPlOxmKm49T8d3jya3SflNpxR3?=
 =?us-ascii?Q?Hzc8c4dqJuMeZObCXwA2yxRAWiLr5k3NHITvQI4WW9b31fpS04A7NY6Kd6PD?=
 =?us-ascii?Q?UpofJoOF3xMwlul0Ef7KL/li0NCcFpI88Dejwp3kV705nugUnfljxtmyQrGi?=
 =?us-ascii?Q?qHQvhGyOhX/S9AflTnx8BuxT97VWChuzl81DvefiAJt6EB4E/3Hpj3VEFx23?=
 =?us-ascii?Q?WgQliMVT0hfzOTndcB8rQ+X0xCIg5c4XL+tSvZCIL1LwQjjvJF9/0E5FG94V?=
 =?us-ascii?Q?hqxMjp/hhw20y+dQdDkke0jDnDZfH0tJUWYubwgBI4XM+Y+YN9HBgHnQx5Nj?=
 =?us-ascii?Q?IRqc7RFXaCiuUkT9dM+1ETT1mHF2MK3/Pr5yeNbVs3GLn3olp7bSSlhpOVrc?=
 =?us-ascii?Q?A/AGvYtRhAGCQnGBZGrgLy7tqNgPIzXCXD3IlmAFeBH5PBUU4kIfo9m4vwdW?=
 =?us-ascii?Q?fBKCQmMtFza2GCltsV7XSFqpL92ukqAEZcAaE+S/fKYm9YI3rCGrLR28SEG1?=
 =?us-ascii?Q?I0/Cfm0UVlMHUo2oqdxZ6c6yWA6FTYAasmde8R/9AeB/17v6qSPU6ljSFgqc?=
 =?us-ascii?Q?azgs7gWy+PmFlBYNMKMM8nLdV0sVVUlyNhIfoZYZVr3JhTK78UqBn2mZTiNx?=
 =?us-ascii?Q?nsBhMNXKaei69iB0p+lXpwnRgUGJzolEq8Ff/rSLCR668A1Ia1uKlmVZwzGo?=
 =?us-ascii?Q?3miEQqNwXzDBqGjAZ/3desJsJDbmc91gO1K0aqBMoUt6GKGWQgzebcoTVZw0?=
 =?us-ascii?Q?pVsl/Emf8W4tShIdo146xKZLYbRIkOqL5QAezBUquRswv41/suLqaL4Gw3As?=
 =?us-ascii?Q?hbEbPUWlXzK7bTjZUY2onnMPaFpxD2ZbvmBjnBlk8s/85glTTcZ+V5stiibk?=
 =?us-ascii?Q?3H12B1+NT2FeJOyg6LjP/TwgajA92WPxNmfVK5OjehLDEw2j7hfc3dJmLNDv?=
 =?us-ascii?Q?xY7/FDMZI/3nG8/pEAp1YpR6gwsKKfucUJCWWxN4ZJ2MNxW/VCszX+Koe9xc?=
 =?us-ascii?Q?NlwzNTit9HetBJPQkLO2YFQgm71Dkmijic1wc7nfwQRDLiYQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1ff189-dbec-443b-9628-08df2613a9b2
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:43:20.3977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzXEd/gUoEsZUvqa7XwV8tugZN2Bt6Reo9yjYPaCXa8IdvlCUBp//hoqG4EFVYXY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
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

On Fri, Oct 09, 2026 at 02:21:13AM +0200, Karl Mehltretter wrote:
> DMA-BUF attachments provide DMA addresses, not CPU-side pages.
> iommu_map_sgtable() needs those pages, so private-domain importers such
> as Rockchip cannot use it with strict DMABUF_DEBUG.
> 
> Add an iommu-dma helper to map a live attachment into another domain by
> translating through the device's default DMA domain. Roll back target
> mappings on error. This still recovers physical addresses
> internally.

Absolutely not. You cannot recover the phys_addr's from a DMABUF
expoter by using iommu_iova_to_phys(). Christian is adamant that
drivers must not use physical addresses, and I will not agree to any
hacks like this to try to end-run around his prohibition by abusing
iommu subsystem.

NAKed-by: Jason Gunthorpe <jgg@nvidia.com>

If you want to keep the domain in the rockchip driver you have to fix
DMABUF to allow an importer to use an iommu domain safely.

It *must not* be done with a scatterlist interface, sorry, I know that
is alot of work but Alistair is going to take a serious stab at it.

Many users want this, not just rockchip. So help with the work to
allow iommufd to do this and you will get it for free.

Jason
