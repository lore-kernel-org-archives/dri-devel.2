Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E46FED3F5
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 18:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044D510F682;
	Fri, 24 Apr 2026 18:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qYgyXtBy";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013000.outbound.protection.outlook.com
 [40.107.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50E110F682
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 18:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLv8EA+WrMKTrnC5FOq91QkIUvqFBd/SXCrZk/0ZBIIbr4qoU7oQWrOhhTwetNfIBnZqbE8EQFLmu7moe3aymR4dYZQUKbWLHcf3uV+cNmlyiPs11Tn4pX/bOMYY+Ncwa1yrlcbQge9ZwOUc3WTSxzGRrMwl4+Z0/BZAozYzr6IOaPj7k8QPHw/aQusGLRXUIPJB+Vgl64m1fdMyVvcGZ1vo7jnXIIFcfwHdYHyEhGYBhM9Poq6KfqsagchdJRb/dbyHkHtx5kLvHEKwvZFTlY+uprlaUCmaBeYSwX/K/BGRpYVyhmefNegxkbFkgG1l+EtYEkWZFkVj2scEYrxokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9MRAeLVFUMHgD6BzisL/E3Ccb0RUihrqxAQX+qRoZE=;
 b=wOSR2EY/D7oMbdwMPcn80Xgcdfzms9Bkc47NZKmFcBHubHhPA9P68ipgQvpm2AV1qDCvGL0Vbn9ahJk+U61dcasbf9ufeoplMCp0bdgPzNAQmg77cUQ7WQOPismxyAJ70t/mwAGl4PSl7kxZ3p4XQ7SAGdp5wxZpsc1GFC7PI0ONlG9Ta82nQOImA7JPl9YNomeZUOrS3fsxPhxZunEHXfMFCO+hge82KC77B0sLlmOC4V9xpkk8HBzPZgiF0q+OrVQU56BQLpIJ/yLB2X8mY43d0yVQoBL+L5pU/wwgPjeN/FYy2sUxiyFa+ENVunodPxg5AQ/QLBaLtUwGrycvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9MRAeLVFUMHgD6BzisL/E3Ccb0RUihrqxAQX+qRoZE=;
 b=qYgyXtBy0UXjZHR3yAncMB7a1iZ3jyHQ78KrBt6vjocf8SGfJgSK8ZFSwMH6UhHF1sF12/PBIeOBZ8sOuGnTn+i6fyQE1BK2m6XkrzcnbveTj8ZDeZHSGgW3l4mxW+GzsrAtTJq6996AgyH8AWKqZZqEjrtmyFOP0BciTnWH4E0H5gx73oJNMfOB44sITRVVkLcCYVtcUJaNRr0sQGAJ0Y81MlL/bh34C51qBRRbtluH07RhZon9pbqNGWePtKrJluNcM7QaOHn54tmGihDldPZjO9lzepkGpTpz7+9czXILM621v0WPPq4kM3c41sllzTb57UoIMIngAKgEMTROOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 18:31:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 18:31:54 +0000
Date: Fri, 24 Apr 2026 15:31:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matt Evans <mattev@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Alex Mastro <amastro@fb.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Message-ID: <20260424183153.GJ3444440@nvidia.com>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-10-mattev@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416131815.2729131-10-mattev@meta.com>
X-ClientProxiedBy: YT4PR01CA0359.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad76bd2-2963-4c86-c812-08dea22fc286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: xcCc6LDo9D+P43AEj92B6NahyqPeamQhg2XVZ7bmYIhSqRGXGD3S4TJRNN+sD15vtruNixkVyHrtHQKTASwQY6u0r+wKDjtmYajKHVWmP7me3n8SGI7LhbwHAMacE6Te3kv1mCA0OZoBejRHIjRpQ1WtNmW+tN1KMonby+0+9PmwjzfCdfQlJVZdy/OwFjlpYCBHZaFBc8C3+iA3LBzvi+hhwOlgXMkVELvVZDnrwUFp24/HCALe1T4UcnBYlM8ofCSd7mqZ0yZKzhleNAuuUl8Xy6eiqiNAuqNCMA/iiSZCQEVY3P/wekThwLrNlM6t2eOWmh5wjMEL0fqY/k4ALHk14PhC3stQx7a+j18ALUhvTTEabO9y3aqGa1TBpbwMeTrGcpw39N1F0+JcV2FXXUsGWUZIF9cw+5lNvWek3QPHpJSFgFZSjtC8bsquNwBeQbEyEJJaM6IYLpbJWr97XH3QP7rb541sbvL/IBHrjLuIWFARS9dRP+uZzy2BvWjfBvNsuSjCZrvCzkqrZDcR2HnGSr+HPHfsbu5/87KAYGYuq3mggbr8MtRKJo/QX6l23bOfPQsJG3alFrNOQcjAW1/w8yZeavtwXNR+mF9qM1qmKWVkUlH6lb2CaR94DBa4UeQZBh/DjyYnGqpmUdtUhoCC5nUftUOgyiW+2Cy/wQ67Qub4EqJCqVJ35NrTlSj3Sc0CXsEBrQ+M8Wgr9miNRR7zR+9xlijzmlZvpGj00UY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KJauQdAp0eUfpHUbrJtMlcbMSbCCY3ZhoTA89jEblu1QM0URJxMoNTm4TsH9?=
 =?us-ascii?Q?0IC6zkbfZlZajjaSkhKnhj47u8qHMlx+KTzqajzj/pWoXTxadKSwXdqs3ZKe?=
 =?us-ascii?Q?P10QsVpvnnp7KLTHPisI2T5maugpkQDjSmzaijDtypFGPd/lw12DGqRXSUje?=
 =?us-ascii?Q?vDD2L1lRypi065fS2AGHSY6mQs+LRI/GToiMYzgv+vderDGRipErFVYDKz7A?=
 =?us-ascii?Q?s7FrMSKdk0RT+m/U3c7dQ+v6hUiDmOvVxrelrAnfO0gNZkpCW/qRmG8aJzNe?=
 =?us-ascii?Q?8nMpDVeF1eyXcTvcLrnE2lC09/VlKMBONFD/BdakkNz5Vr8AK+7fIL9/qEhx?=
 =?us-ascii?Q?e25CYfrZHp7C1j9DyxMyhN3oPezlmX1/8noRRpBWD7adzQh+PucP6OQxWmaD?=
 =?us-ascii?Q?PPRG9TjQuPamec7Bc3VbaGttjQPI6UP3xu+6a2UaT/7G63d2VFoLWQQ1pwDO?=
 =?us-ascii?Q?sukkhB4hc4kCBvpWVcqKD83aLVVGDibc+XXJIBzqOMlvh9u9k3dA+Y4grVWG?=
 =?us-ascii?Q?yxhHisPl1C35cNIzUYdcINbJklGK7yXxVVu0dTI2UItfFvNEGc0+zlzJUsnj?=
 =?us-ascii?Q?rwL2HheQqg+XRNPA6k5HbNcmGeIIlk1ZUz/eor9bh2KpuVoieFsZ6hOVjRmY?=
 =?us-ascii?Q?9Yzl4QyfWt+cJzw3CP1Hy7XnBOrGVoHfa2b6j0wjZItUlOV6+oVrNJbLKizg?=
 =?us-ascii?Q?4VG2096nR29GeseXMsuvcJKc8pTXEk3isW2Yf3X/Nh1ZaDmB6woI4ugR8eEh?=
 =?us-ascii?Q?5LXx0r8FN3LMhnWYVOJcFaxXwUcmW5W+tVEraeROux89RA6jAJRN5qz/k4YF?=
 =?us-ascii?Q?165iXpq7zanI9EqT6x/4LnZm8NEUDYEqWy680NphVTNVT9eBPXotGYY/cz9A?=
 =?us-ascii?Q?LSJtbkWlUJ+vcEa4X2uxZ5BRfohTIzphtNNqTbqToVtSr+YhXkYmOwe2ShE/?=
 =?us-ascii?Q?lA1LyE1G3M3M32cmUo3BRvxUqCDKxWC47H3oHoRoduiQidFrh3DLuKFm318e?=
 =?us-ascii?Q?wAV09jJRT8ZNYoU60BIa3FGbxDrr8bjzTxFgK1jEUGKSup6yUqSu908Avuzq?=
 =?us-ascii?Q?AhdXb7TO2dEkrfFRMy9ccpr15Lw26CpQNNPmE8PBzPPzSylzwv7+8+My9CPW?=
 =?us-ascii?Q?oMFkIKGQB8oHY+vo6TR9kNCJsUplnVOSKGjwlRRhaMiWGpeZvtGC8SEg/SKk?=
 =?us-ascii?Q?ohtW5UGfrjdvjSXSzbZeI7AkUN84v+r1qWdP6fpKhX2q6pc32wqvE7TxDMYq?=
 =?us-ascii?Q?laQ8k4m9W28Dn24OqB8oN8GuLRws9nUqXoSPyGV+gawaxXnuEnTBcApWNaTE?=
 =?us-ascii?Q?X/Rci5WbdqVzJIiJaicjBeAb9g1x6HrCRfsid0wxCzWE/gevZE6+c2mcp7lb?=
 =?us-ascii?Q?VGukxHq9NrOGKR+cGF3337hYxMllprWbls17Vi1P2QRA3htk5fpkJVSigRav?=
 =?us-ascii?Q?OvUPM6mrkL56xe+Fnb0XXhAES5S439AhUgqAfSKb8dd0P9lX3BaHojnrf7QK?=
 =?us-ascii?Q?wnLEpK/LBd39lwk4/t3zbykpmCPg57Sax+jpZKMDTRXYxjEsMImCUJ9pURC2?=
 =?us-ascii?Q?zul0y7qLmYJeXAyoTvmh5DFQGWvX52jSMz3ECA3HY8flNdvTa6qWNe43LMk3?=
 =?us-ascii?Q?+uMEacEsFeVe7lJVldH/+lruUie1xpxFtvsJb51ZQeiwf3Di41EhZ4O5uIV3?=
 =?us-ascii?Q?vsIOCKzNc2lb9CoV4I1oz8CV+RnHO8++GFHMSrWp8ZAbL81S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad76bd2-2963-4c86-c812-08dea22fc286
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 18:31:54.6330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0b3otYlj65BJiMiO4XrGW/gxlufC22/CkXeGj42hxuMwy08Vy2PoxVhSp3lDexFc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
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

On Thu, Apr 16, 2026 at 06:17:52AM -0700, Matt Evans wrote:
> A new field is reserved in vfio_device_feature_dma_buf.flags to
> request CPU-facing memory type attributes for mmap()s of the buffer.
> Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
> PTEs for the DMABUF's BAR region.
> 
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++++++++++++--
>  drivers/vfio/pci/vfio_pci_priv.h   |  1 +
>  include/uapi/linux/vfio.h          | 12 +++++++++---
>  3 files changed, 23 insertions(+), 5 deletions(-)

Nice and simple

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> @@ -1549,8 +1551,12 @@ struct vfio_region_dma_range {
>  struct vfio_device_feature_dma_buf {
>  	__u32	region_index;
>  	__u32	open_flags;
> -	__u32   flags;
> -	__u32   nr_ranges;
> +	__u32	flags;
> +	/* Flags sub-field reserved for attribute enum */
> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK		(0xfU << 28)
> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_UC		(0 << 28)
> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC		(1 << 28)
> +	__u32	nr_ranges;

Though why did the diff format like this, is there some whitespace
changes? All this did is insert defines it didn't change the members

Jason
