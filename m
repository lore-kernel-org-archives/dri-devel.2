Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDEAFDEE56
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 01:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C1C10E134;
	Fri, 24 Apr 2026 01:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bjJBKmYU";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032FF10E134;
 Fri, 24 Apr 2026 01:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFBNa/yutk41Ih+OSrGSM3rSOcdm8WG+ta41pb65IA5zU0qdoGpXvMDgaFdaiKRGUCMRZWyIr4eNuVDarZ/J8dTb7nBAZWfi1ImiQJ13+g9kC55mg8f8AzDptnv0dMVEO0ZK4EmAzf7jZK4/AjdvO2wsr89tK/9To0ZBFbs+0eQtPHrKeSdd5j3fwImhNL5HgUzxwtiGJoIS38qG2VFh898qeED5lnf4+UX41V0B9hUgyHHn4uCf6OUTkbssPOm2kSci65U7ymRuuoprJUdvi1GCdsatx7QTm9JHGEAMU1fYlARgUmKeNUHfDcf2Sdu9PbvCOuyApHEP5GzxzlZUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y9QxxOSAFzEFtJninjOp0oCwTDzwKBnjqCmM3z2tVo=;
 b=KLdZ2wIZ5zBvXCMEeB+9beFAu6PhMHUxJEcz1oh7NSS6BP4egbCaykmqVwSMOanclM7d6P8awkF8gEZcVxw5nWKC1awiSfdxyZvVigSpc4Yh66gKjxoUvy295Ww6goY2k3xEp0h9uFcoRSs2FJAcGVcF3i2/48idbszFqfFNHdqZ4MSUJR7TsvlkLAxIgYONdm7q5gYnazh815tXCBMuF/nMt0/NcVpstt6lpRA2UypZ/hRm+JgJrHcA+yx6vb5PzeB43lcTvfoI+ouPgglhlO4UY28pE7LL5ZGzX9iAvjceImVZ/0iobsLxEd94+prUgKtRNxTI1QhsrleEHO5RBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y9QxxOSAFzEFtJninjOp0oCwTDzwKBnjqCmM3z2tVo=;
 b=bjJBKmYUfyWeqnb0Xpwarbs5WTrRcn/RQlcCpoWjU/6JjCZ6xVnPEY8e5tt6kVhqn+b9WAPbJPTD2e6yOg1XUP/X3CfkoTqANqIEr2sJTgtCenZw3/gCZ7hUPBCl1K8pc+va+SCfcL531YND9ebUwvaPqFJvmvd85+8wS1n2hQSvkHtB8SLOBouCppgygN96jltMbXbgiHEBrxHP7aqvagDYFAN87qMO1vfwH2FYNU9nMSXMMVFHxXdUEuoKWK3x4S1suZgCTJZo/1xjgEUetbQAbJg/FK4jbGQKkENoO/QkRRVGRacjCNWIUxbVFrnUajDo1zMHo8s3uoR7uTMzJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV8PR12MB9692.namprd12.prod.outlook.com (2603:10b6:408:295::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 01:27:24 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 01:27:24 +0000
Date: Thu, 23 Apr 2026 21:27:21 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: use bitmap_clear() in
 amdgpu_amdkfd_device_init()
Message-ID: <aerG-e-D6wgs8gDl@yury>
References: <20260424005218.147961-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424005218.147961-1-ynorov@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::13) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV8PR12MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2c1d13-bb52-49ef-b4a8-08dea1a0a368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3+hQ261tcQZOw50VWqoZ9Fi4AebzRGIz4WFCoMZ/ENJRpBZZTqvuAu2lQWpwsfzoPSgeNqtqs1eme2rn9quQQYn3L9wxrcXq51AhFaQwzcuk2suA/YEp2uKoDNyH1beTqgioIOzs2afKIt4hi918BTo/W8iR4Sb7dHDWTrJcOsJ7Nnf+9ZLbs0Z/RcEi0Rdext8J6778YJ+Zc7pQM4V62ySgeIY33ZOArCWdmUd0dbImp3McwrPxs1992jd73gscIKu2nIGXWIKB+/8dutDsa1Tslthptx34FEnrgtiZMu5rSkDIbfreIxdUYhpno7HqSglODU+9x0tAhqUmND1RVrfnHJ2IHQuuy/CalRiKc8Tct1XK+FcTu5L2OHAOc14Hh9BM56pmT5QIvMIrVUhvs4XZd2gH8PSfUoPJ2tYVC+hsGaR5U3Xn2gyB1GocNOMz+QRts+B7nf0AefufVmv21nMowUudxbKDhTzwPwiVxXFHbiTyem6CC8dH/zih8cyj24ygWwSYs81R4dZSe1I6WBIr+UZWjia6NlylIuEq4cxk1T4Z1sG/QbV7NPg5/HZKoIZ6zZ8tjYeTqPN7Xk5HoJBPjoEbYWto6HPQVZCWq6lZS3dwFaP6dxqGVooDudIid1ePEtaeeeLOyjduOtORw8R327Ho0OgTX/WW8QRjfVVAjlDHc04G0dGJ/HNSPY9kim22BwcJTM/J9GA7FTLjQI3Zi5cmj5FjJufiROT3DOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ITC3GFYXmU1y6pChhM7HcgbsWx/8pmTGqBzCnTOagoBBPZYAsEyDH5WJC27?=
 =?us-ascii?Q?/ApeHfD3kTN4CxT4e/pcjjeo9bZlG8RD4bzh4lP6GkPpAW2rWTMyE2Iz1Gpu?=
 =?us-ascii?Q?wx2g8MXWQcxHui37QX7sWR/rxEo0fgw0T4VylMh6gBHm+5Kb6tqx9iQKsurL?=
 =?us-ascii?Q?/Q125PUvDH9cWpsBt5E2kkZ82zRKCKwZqNxzLRxuujrmeIthF6X1UGSiJTxP?=
 =?us-ascii?Q?dSiyDrJVjD1UPLvg6/SIpmuPaJM7XVKPXEIaeEKz5hn1caUBrsKJt417Q3Bg?=
 =?us-ascii?Q?NkpF33BwWZmwJxl8CCTJvXAPxVzw0yba6wX3qHGxil0+MUUtjcGIS5wwzvvy?=
 =?us-ascii?Q?BHXHBe598ps2v6WDlzC1oOziMX0EvFk0sPIUz6b5teouTO3DMBgcj4w8SpbJ?=
 =?us-ascii?Q?sZ+D/l5Rdnz8WbbDENhEV/8sSLZ95RnQH0GzMjff0pw/uFhLCvCiktR2adAa?=
 =?us-ascii?Q?/hli3mS7QFKg70TDtuPljfnZKQ+csEL9yBSvQn2aEKlMda24qvrc/jHMvXr5?=
 =?us-ascii?Q?kZ4GhoTz9EJbM9932iDIddvp0E1Ptir1BCMBMOYkzQ+Lb3noviEEmngqxgM4?=
 =?us-ascii?Q?KYgs9knfm/7Lh1gAlOsUTSvNv0sj0x7mXl3+vaOawVOSDHAPR7bTZI50AZs8?=
 =?us-ascii?Q?okjZ31zl93PqcNcjSBrOg70nB17GZgzvDFMLCI9kQFDADGj7DHBdMRuy3o+U?=
 =?us-ascii?Q?zHuXv1m1kHQL2Zf7YL9ATAmWuDB95tzZpZ3uL/t5gOtkXnadBhLmZIik6yif?=
 =?us-ascii?Q?bPMl7bb9YlqUiLZ3yYCGA838innnpoctd7Tv4GmFUvjbenW7osoStFiwvHWt?=
 =?us-ascii?Q?UnsWusCngZ9LpNLFMArqQJE40wYXY3bg8q25FMO+L6XxgAnk4U+nqmrplNuv?=
 =?us-ascii?Q?GkV0ChTrfDc+KFGKlpQ7wCRNUBU1WS9GTkwBQ8Fr8l39vkESOeweGJiaaiJo?=
 =?us-ascii?Q?my98rEVFb4lwVynLbnJrN13G8IeM5lbR65QXQkKxqGvv23wuvJ6LPlQABy4q?=
 =?us-ascii?Q?bhzJEfmXcViZe0Zbg52AklXK4bBDFJst2lJG90NkYqG9TQ/b9X9JLrNnVpDP?=
 =?us-ascii?Q?N7bXS3QCAaVy9KAFe56Wz1umPi5VJqTUAe2DgjqXHb8T4OQEbVpUAi9l++U8?=
 =?us-ascii?Q?mKj73dZ5lxnEjxfQwIzKq6MV9PhWUX/DuFeCEOsGEQmZAXerqTNQZkaKR2xX?=
 =?us-ascii?Q?nblUXrHl2gk4GF41yaptQYVTMOYNnswdyLx0LPfx5Qp2a3jKMOcqvwDe/+1c?=
 =?us-ascii?Q?2QRBs7nSvPlOYbJxNWHN02cwFAlX3RmrWZdlGmrbyJ3fWiqY6cq+slyupu7M?=
 =?us-ascii?Q?8eXXG3S4pUP++E56mkbo4ExELZveM3KBt4U49ltVvraEr1HL8pRKx5Rw5kKo?=
 =?us-ascii?Q?i2J6d2JqwhVUaI8VXV+nd75Y6BoXjpJuYD9t3Y+3hPK7WXrGYpVnA8+w3bV5?=
 =?us-ascii?Q?u3ucMLwKdMXut0vZJO15RasqS3UZakbBuavyvW+wS9HXYgc3HfkbxTy1YQhY?=
 =?us-ascii?Q?nBZkwD1kL6oOreUeD+K2Qc3sg3rPgG9Y15uoH3D+FVhRUeDDXh9W1ehBRTHp?=
 =?us-ascii?Q?OoOzl+40+xdlJNmPT0uTvCWjNM7+AUy271fNpj7e1N3lTI/f54MuOKPNQVxo?=
 =?us-ascii?Q?9FgE/+bqgrD/hVJWY6ouKR5kB7nLBG3jFW5GiNcj4Fq9k2+LverwuZrpFfmk?=
 =?us-ascii?Q?7bbVxxcGV+jhi2RPGwXInCmcSlh3RSm96z0BDtHkjsGa1taPRZKtwPLWWD5h?=
 =?us-ascii?Q?dbPPtYD5ZAQZiZixmrRqf8bJGqwz7U5aNdRYw3Or47ThUIq+qK/v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2c1d13-bb52-49ef-b4a8-08dea1a0a368
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 01:27:24.2428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brKSxFCcnOi0x9456Fx9QpQLGjaoPWqfuwn725Mdrd6rZ3fHJNShO950M04OgEUPJI/fhtZLI9r5ozF1u/YdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9692
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

On Thu, Apr 23, 2026 at 08:52:17PM -0400, Yury Norov wrote:
> The bitmap_clear() works OK with both compile- and runtime nbits. But the
> comment says it doesn't work, and opencodes the call for nothing. Drop
> the misleading comment, and use bitmap_clear() as it should.
> 
> As a side effect, the patch switches from a series of atomics to
> a single non-atomic operation, which is easier on caches.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index d9e283f3b57d..47d52cb2f1ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -194,14 +194,11 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>  				  adev->gfx.mec_bitmap[0].queue_bitmap,
>  				  AMDGPU_MAX_QUEUES);
>  
> -		/* According to linux/bitmap.h we shouldn't use bitmap_clear if
> -		 * nbits is not compile time constant
> -		 */
>  		last_valid_bit = 1 /* only first MEC can have compute queues */
>  				* adev->gfx.mec.num_pipe_per_mec
>  				* adev->gfx.mec.num_queue_per_pipe;
> -		for (i = last_valid_bit; i < AMDGPU_MAX_QUEUES; ++i)
> -			clear_bit(i, gpu_resources.cp_queue_bitmap);

Please disregard. This patch accidentally dropped a chunk removing 'i'
declaration. I'll resend shortly.

> +		bitmap_clear(gpu_resources.cp_queue_bitmap, last_valid_bit,
> +					AMDGPU_MAX_QUEUES - last_valid_bit);
>  
>  		amdgpu_doorbell_get_kfd_info(adev,
>  				&gpu_resources.doorbell_physical_address,
> -- 
> 2.51.0
> 
