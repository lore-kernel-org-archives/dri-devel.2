Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C692C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 23:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9205E10ED49;
	Tue, 30 Jun 2026 23:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ak8ZPvJ3";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7484810E18D
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 23:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzbhRbPqe6VrJOdGaONR1JxF2J0fTItBBx5VBoB+fH4YYav7Ne7q6zZBgo5HOZTZqdjFKPo16nOr3oKDmiRgk2cmFFpbtTxwSTur8Br8c7MmD3C19ssw4xNFrFYNX9DZu1zY36mtMrfOnI2WZjX0kDNkANtMhlki8FVwG9e5HEmIgkhjM1Qilwajy6n0r8kVdfn2TYnGhdgEritFfe4bDlfR3eOwBzR7VRZ3uf1gV1URL1l+OWdqcD0dDpEhrbwUv+PvlY4SQLmIIXt65OIVraiRE4yVgQkgjjYx3+XFYtEMl6hAJcfTmqZ0u9Xh4pqt8dtf6Kkf9SmGKcKkj+RPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unixySxMj8RGdShFqdVkXaeurZ+rlxQ+Su9yb+CdI34=;
 b=bGCK6RDlXJDh/WViKG1mx4stRYuaMby85juzSoSIfJkgfLGlFzV5ET+dpmVo6nzcwl/WjtLP47wtIyucJrmIxhR21dUMlRDcdNwW7ASITqay/8PTyOknaEpEfDRE8X6TUBNK8dOwWXA8HEsWJ5jKXjToIGcUkWORx5GhwZDybtCDDOsc3Q4OjgGM35xFd/WamcP6lybGI4PzegmCRNYl6mPiFdwTK3GXw4jfKNjH6/Rl0Uqr+lq8qmnEnQIEv3TLvRBLHEDc+y7NDiQGkMhQk8ufNf7gRDBsb9js30jLgZCxPHGJ3XHUxvllhMe6q7ej1w1uQ8Daud2zbXLUvpvg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unixySxMj8RGdShFqdVkXaeurZ+rlxQ+Su9yb+CdI34=;
 b=ak8ZPvJ3iKL+I+sIb5L+efDDvECSO+pZk2si69yF4kcXWkhmEwNuhDnouOZcktNe8FYH88ionR9MpW0Yn3JC1iQS60b6w6gNVJx0xdfWPINuOc09tEG27L5wxHHQgZ1Ob3kdO86dC+eG1hKEOmNFOWt2RoFE3P991C/wfVwNgp0M1eMYraap2b+XOeDwdHf3zwdpxje9M4b6/oBVKYrHxRlIdmYrVvGCDVdW1/nN1yuEqES9OgmiAIPRMb8fvSx5erodgw34wd2PI2sX7l6A5AuRyLkUJugylzNlA1EP2XtlzgZsIXqsI9oEKY4PwneiiFPd1vofmxHZAdWTpKXz0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 23:59:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 23:59:50 +0000
Date: Tue, 30 Jun 2026 20:59:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 iommu@lists.linux-foundation.org, Alistair Popple <apopple@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>
Subject: Re: iommu/smmu/PCI ATS + TTM unmaps + nouveau best way forward
Message-ID: <20260630235949.GH7481@nvidia.com>
References: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
 <8702af7f-47b2-4dcd-bed2-9fa64a8fee9b@amd.com>
 <20260630115150.GD7481@nvidia.com>
 <CAPM=9tyajYEV7tN+J9oG0wrJfx6Sy-ydB8-ZS+izBEpDJdT0CA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tyajYEV7tN+J9oG0wrJfx6Sy-ydB8-ZS+izBEpDJdT0CA@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bc8ee5-d58b-4a59-12a6-08ded703abe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: lWkB/xo5S3QXdhA7XaGagpPXHue25msKbOA+3p9T0kRyr+8/BQeXXpfnVaPtHLIYdcOlwbcgU38uaNKWqqes2QCUtWfRRYbMsNbFeweJqu9uWtsnvB9GnW3TWqAxrnbDHeRbhxBXU+OLTGghCczIUrbmQGUN3CjR+xmau+PJ9tRgAI1nSRms7wD9NVyZlT1QwLuAmUjfXxMrKMFuYvF8AGDnzSouro+7Wn/kBrGpwJD5jfi/6zDsmTbd1mpwCTkY1nrzOKkQF0JD4bmSFQFpjDu8aGA/2cI1jsRV9NyEfbZxF5wOMOzLZk2jf/OC0HTW7VufWxKhsP8kGImVumsppRbu+0V1Q9v+6e1pZPFYT2bC4IYj50f1kkuoOmjkaFt6lHGnNefIgB/4BOMUvI98VgMmFlpHQqhPktyvBKH5c7s81vky63gxRqxpEKGLJKmrl6KJNOhBIQgxlBSEyRFTokonkWhodP+HXvBp5agksIhVZxKoMAEt0r8vKNYerCcXSVxnu4R10sJ4meFJVVJk9GjqBuy723p/trS/8GVuMLRj1hQJjwbBl3xXgmL/XV9C24kL1B88MZu25vQ++rv/+TSUFTPmE+pPrGGatmfNJOIqCveD5ULpUmjf86EWZka2Xam2+aQcgfR4RUmXYhVnxm7pNjqGwADN4DKUjjmLMIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HBSnbU88IBuParh9vnEk2YZTbKPiFFzTVwlwNQhrOTsa2juIj00SX9J6O3C1?=
 =?us-ascii?Q?mwI8cHkKpa+p8wWuRk9Xmmc+nUYrg5a35zD7aOOMslRfyaU1EiAaQhIMiaGf?=
 =?us-ascii?Q?1pzI3hCmjEZfhipqnWLnGRFMPOwFgrlgoXLhgiQpvy6vNVjWnGFQ5MOFEoDw?=
 =?us-ascii?Q?gVlldFSBjyhkQVIF8mZ8oWa1GKXKXtEzS91T0Vw0Cw5f5lg3biEkjrXCxxbD?=
 =?us-ascii?Q?jn1qKsb33wiw008IvExhAopXulWUB82LtcOyrsOR1H+XGeiRvodsajDIpyHP?=
 =?us-ascii?Q?/WgTubfUKTMrXNbsAHGBSjfDpnx7Bg73FR2Y4oyEQCo5xw4vuU6OdzHp8DSX?=
 =?us-ascii?Q?wjcp+cm7FSzkX9VhdSya0YyIa7ee246HxUp2m8yV2d6R0xyH7MKFPI3FEJMy?=
 =?us-ascii?Q?8c2YazTUu+hR6++gi+1apVX5Lyn8b4nRuWffmbMsf7veWs6RCg3eBy3ObL+L?=
 =?us-ascii?Q?K6nTUJ2U5h/vSmZGbb+EOJA4A4bGc4THAzfIx7j9By/nD5gL04PZsKIBCGxL?=
 =?us-ascii?Q?uyyXG5QpBaHjGtkMKN/LJib0+0+chC5hqyaCYPAb5/YcmarQeLgBBpkhV3DR?=
 =?us-ascii?Q?yRWuDRWgrqwlc5nl+DPEUJZrl+PGCj3Z+lBx/ac7P0uOVmoqF34g8p25o5ee?=
 =?us-ascii?Q?2pdWp3p1KYUEpevPQRtv5Mca5sYyBEUOoodY59bMu3m9ZO0EX+2tDJ5nviNG?=
 =?us-ascii?Q?c4Rfl9oWL8a5FC6uEG78/7yDZkZMreDYVOkAj/mCigznVMvTN2sWB9rA7avr?=
 =?us-ascii?Q?UCX0CsFVfIwoDzKUUXcHn3j1aGji0QKbPkpMVUioyNPHKReneQzTnoLhvr1v?=
 =?us-ascii?Q?sf3GLqTAkf675h1eYX060FSvorVkLHuFHTo8y0bXy4VzmT6BCkNqVruam1HI?=
 =?us-ascii?Q?PicAYX2Il61VWj3+N2iuIqEVRnV6qOLMHbGFUYOYydp3cAU0NiCAs8xLv4L8?=
 =?us-ascii?Q?VvdZBlC2N819TViQikmBVZOmLs5reMJwgmyLWp8fYF8f4XnJ48Wfayda7Sl4?=
 =?us-ascii?Q?65aAoYRWrF5NLeXOpV4GRXdyg7AjHfCLNSOCaNzaVzaUMSp5HK6q1uzktwcd?=
 =?us-ascii?Q?aOSzmmsnzuhf2bZ6+Es95rHT2GVwWstou7ZLbQvuOvIDZLHrO/V1MlJsjDmj?=
 =?us-ascii?Q?726LU7QJYrWJT6oSX5qfwp7CRxmD1PTN0Hf5/K4rLGMcvSONkc50toLNzlRW?=
 =?us-ascii?Q?X18Jjohx751aX/d/q/dX+hkjmHUgXLSMqmy/Z/slkwW30zMWKpwoRbzezGQC?=
 =?us-ascii?Q?9eypPahYXpNBzxt08PaSmm3YsRqGPgUfKk6LIe1Aifi7IVvwaqseVdnPEYJB?=
 =?us-ascii?Q?/e8ng//zMZZERljBFKEHl4NRrojE9L9nu1AbQLMQaLueO3PusW0mP96dlJ2n?=
 =?us-ascii?Q?5w9WdsD4LZHloS9VolPEoua4TaQ3k2fAD52TCEGl+Hy1YjX27updNRpRRl/+?=
 =?us-ascii?Q?IYKGyZkGvCaP+AnXesm1vUnJ+ghUWK3mNOmm80ymbRNO6gtrFov1+eSAIc9V?=
 =?us-ascii?Q?KdpimFQOlxenKHYi1g4PNccosS5Jf/pnBjiKFo2HUtrn/MSpOisO/sPre338?=
 =?us-ascii?Q?ZkxhrXMnS9yfTfkqzAbqKc5+1R8IoHjsmDZAFAqXTsUy4TBsK5hNn2iSChth?=
 =?us-ascii?Q?WatwkdL2nRE6QHCzdM+05RVGlO1cz6s6jB9+Xw5Kcd1yMAGFYG++3BzizWw7?=
 =?us-ascii?Q?ePPABeP+5W2dZXwIYAJZsFV/+TAKA72lxmFUczXlnGb8Y8Do?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bc8ee5-d58b-4a59-12a6-08ded703abe1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 23:59:50.3265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBI9a8KS9VRoCJrpHVeW/vqldXMDx3VB8As0ZQ+gfNEMAYx4T0bHGce0yv324Xlh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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

On Wed, Jul 01, 2026 at 06:45:11AM +1000, Dave Airlie wrote:
> > Dave could be facing a fabric issue. AFAIK the ATS invalidation that
> > the iommu=strict pushses should fence the fabric so would resolve a
> > missing fabric fence. I suppose if you don't see any evidence of a
> > non-present ATS response explosion with strict then this would be a
> > really good theory.
> 
> It's definitely a fabric issue, the iommu ATS invalidation is what
> "fixes" it, but I'm not figuring out how to flush it from the GPU
> side, and I'm not seeing where the official driver does this either,
> guess I have to keep digging. Maybe Alistair knows something.

Well, as I said the ATS does two things, it fences the fabric and it
will fail DMAs with ATS non-present (which doesn't trigger an iommu
log). If you are confident there are no ATS non-present events inside
the GPU then fabric is the best guess, but most likely the fabric will
clear in microseconds after the last GPU DMA so it would be a pretty
narrow race.

> From the ubuntu kernel this thing ships with:
> https://bugs.launchpad.net/ubuntu/+source/linux-nvidia-6.14/+bug/2132033
> 
> "Add two more Spark iGPU IDs for the existing iommu quirk "
> 
> diff -u linux-nvidia-6.14-6.14.0/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> linux-nvidia-6.14-6.14.0/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> --- linux-nvidia-6.14-6.14.0/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ linux-nvidia-6.14-6.14.0/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3654,7 +3654,9 @@
>   if (IS_HISI_PTT_DEVICE(pdev))
>   return IOMMU_DOMAIN_IDENTITY;
> 
> - if (pdev->vendor == PCI_VENDOR_ID_NVIDIA && pdev->device == 0x2E12)
> + if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
> +    (pdev->device == 0x2E12 || pdev->device == 0x2E2A ||
> +     pdev->device == 0x2E2B))
>   return IOMMU_DOMAIN_DMA;
>   }
> 
> 
> I should probably work out if anything upstream does this or if I can
> mess up the production driver against an upstream kernel.

Latest upstream has this fixed now in a different way, this is about
forcing ATS mode on inside the SMMU driver because spark can't work if
ATS is disabled.

Jason
