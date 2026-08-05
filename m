Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4B4C55838
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 00:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2DE10EC38;
	Wed,  5 Aug 2026 00:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TEliQUlf";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012047.outbound.protection.outlook.com
 [40.107.200.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA7F10EC0A
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 00:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMG9s9Ce5ujNuRv9NxclovfOZP11e9UEFxRtco5tn8b02MlrH3bu5StJP6BTxLoi9Tle9TU70YVT3qKg2EMaGknKfi+l8P04laxcX8owZ+Gb6w1ecw157IW46rLZoY45+BACv1082wHN/Dhf5hC5POtQt0w+4uMHWZ5xEWiZZs1Sp3JMhdKrwUcKWZ6CXyTeukaosp4Kxov1DUQmHtpVVRde3PkynHv3N4UoMSfKy55j5Td00nM6V1RmANI8bPyXwQwgRy3KVYCONc7pha79CW5NvY7ukYOZ0VZ94oBOYa8/doVy4kOWi1zKzpoKu8YTWhmEy92SiO2dxTSny0YiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p9ft39X0W9GY6Y1TrkUIE1odMdfYUUsClrB15ANBbQ=;
 b=mbVlGT/8M8H1AOOoLqCZzBkJ6Khyy2as6ByRVC7pIBt9QZx7cGKlDBrWRatXkNxsVe0aMT5ifa6EEnuIISOUaojXxzIWA1jx1aLpYuRTxdUa5RmtNJw6tg8GcPTKwDeoBvlH1KoTV+fYtqF7vUJ1TGDpEhnNlDtRhbd0RfpdoWK77cuUymVpFlfQaD+m6PeF15i2ITN30xiXVmiYzvx8quMPN2p6LD3exZHikQ4OjQRkt73RevMHPc+YDOUk0m7GXDMKCrVIL/ROVLpi7zXMZaY1AvWfGWRs/QyvYTDpBfWXR9ReNWk0yVbNgjJmjzW6lGxq/PIcGxoHzFL4vCnOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p9ft39X0W9GY6Y1TrkUIE1odMdfYUUsClrB15ANBbQ=;
 b=TEliQUlfpJDE+1NjqrmXEqLJ5tUGM4Q41gOgUaWB9XajXY/dDI5GoDIgE7QOroabUNn7reAZmcayWyeYu/7yaZb38k+oWypm6ftd0q4cHoEoApyYeHazGyvjTC3/QQhpo9LNqtTcQHmt4hndeb1+iozR/5wvhedlIWJVMVyRNtKtYC87l9swC/q2V9Fy6ccBPnvFpFNdRp0c7wKFqOsuiuGo4XEBwWoccAiiM4hI5Yr/kApo8G9+udsh2Gmxnkuthm0FtwHlEqBHNtfSUX92rRls/EHDKX1Jp7eOv0/v8ng1DynXUDHwyTY543wOVLa0w37mVGedp2icRBPQKprXLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 00:41:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 00:41:38 +0000
Date: Tue, 4 Aug 2026 21:41:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Pranjal Shrivastava <praan@google.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Alex Mastro <amastro@fb.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Message-ID: <20260805004137.GL27883@nvidia.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-4-matt@ozlabs.org>
 <amvWXNRtviKEuUoV@google.com>
 <ecf9b355-9fe1-440b-9281-08671a995139@ozlabs.org>
 <cfae30ec-18ed-4f06-bf96-ef294a8c2744@ozlabs.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfae30ec-18ed-4f06-bf96-ef294a8c2744@ozlabs.org>
X-ClientProxiedBy: MN2PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::36) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 5957665c-a684-498d-042f-08def28a4f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|22082099003|18002099003|11063799006|5023799004|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: bEIjLTVFjoGV7sLqXhihjL3VlTOTV8Vs1FIUyd5wJlO9GChGyEiQ52cUkV70Cj8lyuCLCpHqcoqsTu9aDkADsCb9Pw5KmuxDB8tGvlzpPiuIHz61vX5EqqTxTVkQPCotGZe6ExdkhSyjckCAnWmR28J7E9xnPHvhqdPsV5Zy2PBYaylks10Za1zN+z0EH9fmcrP9/pl3VgPQLi5dri5L1SnxRkwluATKUo7hWs/C5id2e08wGaQnJJfe57CsLKr5k1ixAujrGSJDAYkYrIAO+p9ZLM07vSl14Yw01nR8TlkbOTM2d0gmSrVJ5xw0LQ1F5cYfbfq3AB4vo/xn5qHgHHosdBsAxALfYU+RT75Op34/wQaOH5QuZj7G9A6mEV2bSCSGVDvbo1YpYA04JUnc5TKeYEpjRxqPOykF3qYa39CHsiK76tnxuFw1lLhcg353DXjonSzfWXBR1f7q+dpCRCSXMj8UQNk6D3/4Mzrvk2yJ+Don+Ol/814xn2dxKtIy9f84jnnV9d4oUSYMvgbBr2P022eSLVOkXj6gtthQyHVtt0lESYOfJL0w0klIMGuSz+WLe7WHnoXiMprgyV+t2irbkp8TSxMx1iaIPgcX9Zr3fueVB7M45ca7vVT/68kEQI8fjH7TjPlwZcP5isN9MX4dPGtAYjbs5oimmO4/EtU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WMGLzHUUEXetKPbaU3+QdYnCi2OtYAtYJh2GV6s3bSQlKKU20cIi12ppZ+nO?=
 =?us-ascii?Q?0OwUow8720nrrAi8/lj6zvS4xfp9obZ3yN36Y8Bxb8JOomZWzhct4iMikYq9?=
 =?us-ascii?Q?6f3HOev+sBEtMfWRU4BPFs2fvIqCcGkR3SHkMf4PKIejXOk+66pVOTgMy78H?=
 =?us-ascii?Q?EhwXWnomIMl0IxVAbfPDJkBiM22XAIOTRWCY8MvgidVzS/GqdB+/KO40Ip7U?=
 =?us-ascii?Q?E1JmI+KM3+oO2egP9F1dDogDpH73DNNrkCzLeqCZnjXQRWmS0m7alFxJSYUK?=
 =?us-ascii?Q?C26EKU97Ki2rdF+UB9r2doPQiLUJ8Fscm7a4MlO2BG9ZOevlxAMSJTEGqkat?=
 =?us-ascii?Q?oRkeJSKaNzpzdRJ6rAs6q+Un1OrGlO10iUW0zjs1NwHN/gv4HctRYXoQrt2q?=
 =?us-ascii?Q?P9FqQYfXwHyUjTNpdA5B2eCIAPtxXwGA7Wi8RQndSzd++S85WmaHLf1GXz26?=
 =?us-ascii?Q?32S5aAtGe98NyT247DoX+GKfkjW6ucP7Nn/k9GNk4SYSrcGD/51C+hO4RMIs?=
 =?us-ascii?Q?Hmlv5qLk0CekFzkKD1hV0y7Ny/d8/V8l3zX8owym0tNHhADUe2iGX+HGQoeg?=
 =?us-ascii?Q?+Y3L/DYysZhQNOFKMc3s/jFGjVxP9mcvCyvqJAKiC3UgWsQsSdLE4MSOmOqq?=
 =?us-ascii?Q?t5y1g4eYb+adLFDqGfoxuucHDyLW3H1NvhOSnzHXTxHglxPsUdUMo1tHBz+1?=
 =?us-ascii?Q?fvOfVUzaRhH9lqIqnOEHepKSxi/avx5sdwCLXBt9Kh8+ABtkqIaldjmNUtXj?=
 =?us-ascii?Q?67vEeMrl/aDypGpqCiUR8gM+o5nd4bv8oR2g1jbHFSn1/fPwA1wkD0X3gTv4?=
 =?us-ascii?Q?RGvAAE9bPzWdVwVEMwvaD08qKAan3AZwbH8eCD8uYepl3Y5HJwvBsenhsxbV?=
 =?us-ascii?Q?pDIM1jhKowI40GrQ2yKQaMm0pO4k615oFAPI7V8z+ck1y9rBR8pXX086dAWW?=
 =?us-ascii?Q?uObuxUXseBcCbLq8YDs1/a91NjUbP91x5vtu2OyEjF1C1th1RUEZBsdnI6j/?=
 =?us-ascii?Q?hjHUa09+Fic2rgJOSGRsRFAUOySHO34JUOPpC3cHnfQToDzhql9h5HE6NLYH?=
 =?us-ascii?Q?sJL/R/AiQA6MuWDDDooJqgDx1NsA/z/7ataxP875oYi8wtcwB9LzRE6JKQbp?=
 =?us-ascii?Q?tGVMdcvG+5UDE8SOlZ7HDoF92ZXhsqyrZs2elwf6MFKkcemWtkQaaf1asvJ1?=
 =?us-ascii?Q?4nBr6+n5NWaY+nhAhyVP3vB19y3GnebOevDuXf7d1os3y87UcZDi6zMrxUR0?=
 =?us-ascii?Q?YKlX6ZqS5rqnnBw/DM5HvwtGJLz7kP0+Fd0iDMGBHJCfV99vYcNwV5/bZz4V?=
 =?us-ascii?Q?VES8d5QyhupaBUTRgoj1lCplJxmDiSG6i4fQ5aZ22VRpwCNEzuwH/ojslKSD?=
 =?us-ascii?Q?AZ4++IzRTfz/LT1zRsl00E9LoVGJNjBpnql1boA4gJkXfV/EFMY5YNV7I37c?=
 =?us-ascii?Q?3q9qXyR4CpSEetEYxne8dBUMrNDSMHgC319zaNmKix0cCfnmV9vQ8XUGPow1?=
 =?us-ascii?Q?B4PiX8aDwcqzq5JAbFQUL/mwOQHuRkcgL+TQJeCnV6OEiXJgnHC84V31E5Vx?=
 =?us-ascii?Q?MVtk0k8LBXFEikyZW+RcekUcIIqeYVLZggnGJmG6JtnyLOPreGfVgMeXU0KX?=
 =?us-ascii?Q?/HOJZCNzo6VJ7l+JoNaByEvga9DfoZZNqRP6wGOmrYul/iJV8Mg2W27KCW3N?=
 =?us-ascii?Q?WZzRrLURIa3cX9Uuu5ebD3Kj7efjtrhdMKx4CT88nUL3JdPnpFJEt2ZkbySH?=
 =?us-ascii?Q?FIOu1TLsdw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5957665c-a684-498d-042f-08def28a4f58
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 00:41:38.5368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wA6o2Pvsu7aUbLPJTCJYQLS39jCah3vh+0kFiNk7nCxfH+d4SEvI+jFcwZwpvIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
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

On Mon, Aug 03, 2026 at 07:22:06PM +0100, Matt Evans wrote:
> The second problem is this isn't just a limitation to not do an mmap()
> with offset approaching 1TB, because you could run into trouble just
> mapping, say, a 2TB BAR and then splitting it by unmapping a hole in the
> middle:  the second VMA now has a huge offset.
> 
> It seems a proper fix is easy though:
> 
>  unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) <<
> 	 		  PAGE_SHIFT;  /* No masking! */
> 
> Then in vfio_pci_core_mmap_prep_dmabuf(),
> 
>  priv->vma_pgoff_adjust = vma->vm_pgoff;
> 
> I.e., if vma_pgoff_adjust just includes the region index up high, it
> cancels out the (same) index in the vm_pgoff.  Thus regular mmap should
> work (up to the 1TB offset), and DMABUF VMAs can have arbitrarily large
> offsets.

This is what I was expecting when I pointed at this stuff in the first
place :)

Jason
