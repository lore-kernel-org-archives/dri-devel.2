Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E54F459EF
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EBE710E180;
	Fri, 10 Apr 2026 16:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NDWMJK6Z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A92E10E979;
 Fri, 10 Apr 2026 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775837347; x=1807373347;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XY89SokgZcVAXVJFtJ3J/ghlfPlZ+cWY3mhwIBohTnI=;
 b=NDWMJK6Zr6Yul4VUeKH8RivjivHf24kd6Ilvt6VACXGdnvxeftMFGjbx
 zEz/4fHJ6UkdmUVlWVZ8IrDeg48sLw0vxle+vUVxQk8U4CQjAIiiR6ROO
 BtKjby1eo158/hdNnlox72p0z2MNgBXw/Qxr317USMPWTd00iad5Ytllw
 tDhDL4h7iA86zWKKCOhZXYsuZoYzit+TwhB2nchaXj20nm/JC8fgCCybx
 yJat0ysJP9f7C/F8GiKmKedzKUJwj1tqBPcqBK7Fk+jnyZvU34c3lbYK4
 uzvg5Le3EQlDTnPJtpZksVVgg/DiiUk+Lw2hOI+lW8ZDdfiyD+sOEj+3P A==;
X-CSE-ConnectionGUID: oKMeS6MuRMSQqsCuUMTT9A==
X-CSE-MsgGUID: SMYA7W7NSUCchDi7ycoh0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="87556237"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="87556237"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 09:09:07 -0700
X-CSE-ConnectionGUID: MgKFoCwLS96F1ccqNYIYGw==
X-CSE-MsgGUID: LZCTeqXZTSOX2fp0AIpupA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="228272845"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 09:09:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 09:09:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 09:09:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 09:09:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA6Jqo2EWWuR4Dw6G/nqHSVHCtS8nAp1QGhJQUrtSOPITk+1Z9JMoGK+L/OETskNOAJEhG7bWcAW57ZHBDnV3gPnyJRWmVYh/+bXIU1Y5VIwag2SsYC71603VrZM73X+tBj5mUaIVus16popSjepLH5xKpHa8Vzfw5N0Aocym/vX3lp68QbN2zaq8C3o3wU2M+HF2whrdFxguePzbqG0H9/fMCushOaekAN3S7s5Arfhez5eNBKdt34MM20cNQlyihQbz02fOGHSG6jznzWC3qHZULaF3+2UZEKs0w8xhvHr2ol74/LfUkk3Iz6MlhKMNuIHUZJLY7ej4A8ZRfO+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EosNlWFPdF1Z48zkh0p06EwXN1CgmcOKUhtuuMoDaZI=;
 b=gdJpqcYMNP2PWs1wrd+r1oHGk2+IfgsgQht4i/1xmcm76UUzESYiLw4/VUchsGkTbJnJt849HKjdfqK00mCfVOgWuz8ojG7Y0Uvgq2i5Dlih6Vz7fYETHg9bLf1WjRGkLyyC7OF5ZvqZswX7WdBkmz6t0M61UzbxQ81+diOnI/PTkTiToXfkLMtozE6JBMXB+UDoxeuIbyTq9h7rvxUto/kmwx1SyNC0L7v8rNQPXgcX7R4W+kUZjdI3NV1mujhDiAsszL1Rq2O74I1jQsP9OONihLWlrf+vI1CuOXUTthuPlzzk3bagjKG5w+1ViiGc2eWb1JdworY7JWhvBKKLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by PH8PR11MB6612.namprd11.prod.outlook.com (2603:10b6:510:1cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Fri, 10 Apr
 2026 16:09:03 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277%3]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 16:09:03 +0000
Date: Fri, 10 Apr 2026 18:08:09 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 4/5] drm/pagemap: Use dma-map IOVA alloc, link, and
 sync API for DRM pagemap
Message-ID: <adkgaXUuBdD5A4ZO@fdugast-desk>
References: <20260408201537.3580549-1-matthew.brost@intel.com>
 <20260408201537.3580549-5-matthew.brost@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260408201537.3580549-5-matthew.brost@intel.com>
Organization: Intel Corporation
X-ClientProxiedBy: DB3PR08CA0002.eurprd08.prod.outlook.com (2603:10a6:8::15)
 To CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|PH8PR11MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b78b04-840e-4fa1-02f7-08de971b7be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: UzuifmtHEW9Ko4421aJ+j4jEIHYtb01qIo5tEAbWdBf4XqW3bQEp/nYXdy6W5NaSOaHYhbl64bsvhloZ4HFJBk4QbEuwG7WpHNhxaHevfQwEm9p5fJvlQoKUR5Pux8PL5Lj3OHNmMZXiuypdpEjFqHOYj1uMq6hPwoozQ4+pd31Qmu3uezUX63HlrQ3jlaNuvl5PELAiomn4/3pMr/pjV1ucrGpdRtUGDzCu9fQGlo8aBJgNMUrLIJzsSdmXc5VlO4h86jsKhuHZjN8aL1nspZVWJKeTmcDdK9h+d9cmVxXE8l4md0EL2JpTcMoz4h88Wfim3WrmLIGCqTw/TJUSiwRX41WfVREnB6zk4ymf8YH+SR2h/EuC6whHyl3reHqsxblT1Gsv+HgwYSnfHGEz7IFgSkNm6tECoG49rqGD7lP17b5u2dlE3rHns3jEkbPkgqH1W9/GM0qTU2sKjIkF1/dLedPd2lD3TJhY8ve7Z2ghTu0TuBqoQUUl0ohJP97kK72LVqx2in4V0OkmxxqvjR1LNE5nS1ApAPlMV/iYwRh0M73ZLJsMurMQPYDM44AC0504MzlMRmUrFgcwNmfuECAOIUmNEm8879/HD2uamv8ZGdXRVW+huKpJRQ88WS4nQ0/PteRUTJ56ZB1pM+aV1Wvo2mpb2xnHaykRZNpT6je+niCqbZKkXhePlJ+iw4o9L8MRp8p4wFWpWWOZxPrPCe8BHhhRl9YnlFCph1vf1Uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7828.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zn9JLEO05Y4w2Q8cQ2RwPUHJX+2eUkdyqjMNMu2Zd2TwWP/GrA6zhxTlMcGe?=
 =?us-ascii?Q?L4yg7NTrAAXHV8Y9YA3Qt3dN5c6gxY6L8qsv/44hW2kgyOpzqqseDnUuI8xL?=
 =?us-ascii?Q?F2ko6nHYu79MDdJO9US80RTWV2roKwYtqLMJ67mxfleksY978gPNKSoaUuz9?=
 =?us-ascii?Q?6pG4phI5LpSjXIYN/55IdYEDv1S1B1YWjcHlZ4YjHU6NkrCTkDRXwX5kMzxz?=
 =?us-ascii?Q?2bRGGYQXdRcxl70V+apgYlpa6RrsVmv6u+9wkKrQpfCA3kUUCySdtocdrf9k?=
 =?us-ascii?Q?a4F+HsR+7Yl7r2p4maAm0BUpxzf75wy1F7prxGLRqYkwNU6jPIyEXLTZVA6e?=
 =?us-ascii?Q?aJUTmlv0asSbSbkfE3fzqyrLJz1w+NTHhoPz9r2TURqsr0ma0Yq//BpNZs3C?=
 =?us-ascii?Q?CBbVd5LhZRNgNhsTbVnHjnF8NYqjWeV+CxYPlVFGYA7X4alGXJA9Mxk5UAWo?=
 =?us-ascii?Q?+0PB65mh0JkXt4YS7H5wlzLbz2weZOWpBrrVQJhMMbI94pVZMTBstaVztuJk?=
 =?us-ascii?Q?9meSwepXg8kXVzdLiGHmCFL6gLeGWdwB0T7gxvpbJZCDzSP2U14fwhVtC5Ua?=
 =?us-ascii?Q?NvZl0JUvHC35HL5KPfw8p6QRdpYyefJIkNnRVrfFkHJG8en3nmuvzfut9rkt?=
 =?us-ascii?Q?4617S5pSP0RTNTr79TahVvh0ghUkS71D4/yscQn3U0jVXtioz3WztbS8rs1c?=
 =?us-ascii?Q?GwD2Gx54o4OzMw5JTU2AX7e0NpXWYrQopwu7tkJTBhVBYKb2MEyI5HWzAekk?=
 =?us-ascii?Q?lgPKOR1PBX6VX90uuozyyHgbYSepRj9dO55sbmAcliAFnJL//eDunZoAmJfp?=
 =?us-ascii?Q?dqIf5mwQedsL8QyGpBebreGL7JxVkGo4vY70FBUBY9OB8Ka4gU/VCJh+ZKhg?=
 =?us-ascii?Q?L++v9vSHWugrqpLGtXMIe43OKAZlYez/GqNlbxX+aN4jZ0UrdgYnYD1Mpij4?=
 =?us-ascii?Q?UunMxUrWVCmtyD9ik+QBzl+3acljvsftyofh6qHI1coMJxLBSHrIFJfUM0cu?=
 =?us-ascii?Q?3oaXVwUi0X2hT+0qHMREdoc2gO13Scq6s3st9zNbl8XWeWPzoiQ0nY0WybcQ?=
 =?us-ascii?Q?QAFuJpAJZ/4SyPh3HHmxDSqWGuQDRq9jOz98yWLgr9XCX/efi33bmPnhAvFh?=
 =?us-ascii?Q?OaZx3cYfBgmQlHrZFyVm2CAsFYE87ZrOGiyyY4Wp5O/8KaZ04yfgSzHY4sAo?=
 =?us-ascii?Q?c1O1eeRp7VBar6J0+83yc0LJyYh2tk0t+sL0BJcYlV9C0cNFSeZEMe4Wkqzi?=
 =?us-ascii?Q?vZqYdh13UvRaQJ4rULXzZkJEcGGFvvi2/Ex3lBYtxLC2WWjvzBGnd/+YiqHh?=
 =?us-ascii?Q?qhtmK+8rtNuV22bc9NXP+NHeVbz7+aFkkBHmqWKmj7KKLxBzoM0yqIFGifvA?=
 =?us-ascii?Q?IY5JaVvQg2RaAj9r7zpE8NMtdZj3gvGmsV4fPBZtbHTpEt3YEn8LGzcDmC8P?=
 =?us-ascii?Q?o0kWUGKZ6ultFId+cV9g8gXTfqrpl7iGPLOryWJJ9wt8nXHr6ex8yxfSk7hg?=
 =?us-ascii?Q?PxD6CYlFIc+ZJSP6cw4DxQbloAhXFJSC762Jb5Fo/THOgar/U95fTcfyTg3j?=
 =?us-ascii?Q?MM8achl+gHV9oIxIqomQ6CC4a7rZIpU1k1y34vNeNV7FDv13GnWkxGotQhFh?=
 =?us-ascii?Q?VNSYY8PuMKYN394Nz579q2rzjLvb6kCaCrdj3ayKetIrGiNINsIL5JO4G8ji?=
 =?us-ascii?Q?tPp9djXFxlCRQvX3gr/eoiGUG7hdYWnbKsQyTWY/4462fBgq/WxTyiS1tdQH?=
 =?us-ascii?Q?RbJ7GZftH7L1eMhFX/USniYTDZFrq88=3D?=
X-Exchange-RoutingPolicyChecked: Pkm3A4gBSHASLiFvb1P7I7gF1j540TBbtRn0w/Nov0wQVg+ZRG6ilm0IlbBDjC+QjaH9Oq2Ex/BAjdxqshFh7AAqNvGLdv34ECDQlNtE1dZyV9vgQHoWhm62FI0e+zyHNlw8OPCoeD2rwJZEWhdOLO9PFr0DsPnBLPcokFHhcIRZVWkPNYOmd9MFPqkjHshsVIJLM/qKYgdFnJhbm8SVpzTZ062/+sHkZCv1qpwJoaALQG0CbqQQpnA68ZohLEVBlV09VYJXWc3YxpgcHDpPHhHndcNuiwFYKn0PjWuFCL3VZEYl2p7z7Tl09fTxbsq87Zwk7Wi0jibbO/LJFS2ZZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b78b04-840e-4fa1-02f7-08de971b7be8
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:09:03.4604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0WL3YJvat6UBZiXxxbAWM5CzoCFLtwRcVHI5yUBJbruWyNK3JnamjGNESaj5BtcwSGgcMhJW4iVm6+bJ4GCNPjXWsjmHmiPukMxacdy8ZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6612
X-OriginatorOrg: intel.com
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

On Wed, Apr 08, 2026 at 01:15:36PM -0700, Matthew Brost wrote:
> The dma-map IOVA alloc, link, and sync APIs perform significantly better
> than dma-map / dma-unmap, as they avoid costly IOMMU synchronizations.
> This difference is especially noticeable when mapping a 2MB region in
> 4KB pages.
> 
> Use the IOVA alloc, link, and sync APIs for DRM pagemap, which create DMA
> mappings between the CPU and GPU for copying data.
> 
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

I have been running more tests this week: this improves SVM page fault
handling latency by around 4% for 64kB and by around 20% for 2MB, nice!

Reviewed-by: Francois Dugast <francois.dugast@intel.com>

Francois

> 
> ---
> v6: Fix drm_pagemap_migrate_map_system_pages kernel doc (Francois)
> ---
>  drivers/gpu/drm/drm_pagemap.c | 85 ++++++++++++++++++++++++++++-------
>  1 file changed, 70 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index ee4d9f90bf67..ed62866b52f6 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -291,6 +291,19 @@ drm_pagemap_migrate_map_device_private_pages(struct device *dev,
>  	return 0;
>  }
>  
> +/**
> + * struct drm_pagemap_iova_state - DRM pagemap IOVA state
> + * @dma_state: DMA IOVA state.
> + * @offset: Current offset in IOVA.
> + *
> + * This structure acts as an iterator for packing all IOVA addresses within a
> + * contiguous range.
> + */
> +struct drm_pagemap_iova_state {
> +	struct dma_iova_state dma_state;
> +	unsigned long offset;
> +};
> +
>  /**
>   * drm_pagemap_migrate_map_system_pages() - Map system or device coherent
>   * migration pages for GPU SVM migration
> @@ -299,22 +312,25 @@ drm_pagemap_migrate_map_device_private_pages(struct device *dev,
>   * @migrate_pfn: Array of page frame numbers of system pages or peer pages to map.
>   * @npages: Number of system or device coherent pages to map.
>   * @dir: Direction of data transfer (e.g., DMA_BIDIRECTIONAL)
> + * @state: DMA IOVA state for mapping.
>   *
>   * This function maps pages of memory for migration usage in GPU SVM. It
>   * iterates over each page frame number provided in @migrate_pfn, maps the
>   * corresponding page, and stores the DMA address in the provided @dma_addr
>   * array.
>   *
> - * Returns: 0 on success, -EFAULT if an error occurs during mapping.
> + * Returns: 0 on success, negative error code on failure.
>   */
>  static int
>  drm_pagemap_migrate_map_system_pages(struct device *dev,
>  				     struct drm_pagemap_addr *pagemap_addr,
>  				     unsigned long *migrate_pfn,
>  				     unsigned long npages,
> -				     enum dma_data_direction dir)
> +				     enum dma_data_direction dir,
> +				     struct drm_pagemap_iova_state *state)
>  {
>  	unsigned long i;
> +	bool try_alloc = false;
>  
>  	for (i = 0; i < npages;) {
>  		struct page *page = migrate_pfn_to_page(migrate_pfn[i]);
> @@ -329,9 +345,31 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
>  		folio = page_folio(page);
>  		order = folio_order(folio);
>  
> -		dma_addr = dma_map_page(dev, page, 0, page_size(page), dir);
> -		if (dma_mapping_error(dev, dma_addr))
> -			return -EFAULT;
> +		if (!try_alloc) {
> +			dma_iova_try_alloc(dev, &state->dma_state,
> +					   (npages - i) * PAGE_SIZE >=
> +					   HPAGE_PMD_SIZE ?
> +					   HPAGE_PMD_SIZE : 0,
> +					   npages * PAGE_SIZE);
> +			try_alloc = true;
> +		}
> +
> +		if (dma_use_iova(&state->dma_state)) {
> +			int err = dma_iova_link(dev, &state->dma_state,
> +						page_to_phys(page),
> +						state->offset, page_size(page),
> +						dir, 0);
> +			if (err)
> +				return err;
> +
> +			dma_addr = state->dma_state.addr + state->offset;
> +			state->offset += page_size(page);
> +		} else {
> +			dma_addr = dma_map_page(dev, page, 0, page_size(page),
> +						dir);
> +			if (dma_mapping_error(dev, dma_addr))
> +				return -EFAULT;
> +		}
>  
>  		pagemap_addr[i] =
>  			drm_pagemap_addr_encode(dma_addr,
> @@ -342,6 +380,9 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
>  		i += NR_PAGES(order);
>  	}
>  
> +	if (dma_use_iova(&state->dma_state))
> +		return dma_iova_sync(dev, &state->dma_state, 0, state->offset);
> +
>  	return 0;
>  }
>  
> @@ -353,6 +394,7 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
>   * @pagemap_addr: Array of DMA information corresponding to mapped pages
>   * @npages: Number of pages to unmap
>   * @dir: Direction of data transfer (e.g., DMA_BIDIRECTIONAL)
> + * @state: DMA IOVA state for mapping.
>   *
>   * This function unmaps previously mapped pages of memory for GPU Shared Virtual
>   * Memory (SVM). It iterates over each DMA address provided in @dma_addr, checks
> @@ -362,10 +404,17 @@ static void drm_pagemap_migrate_unmap_pages(struct device *dev,
>  					    struct drm_pagemap_addr *pagemap_addr,
>  					    unsigned long *migrate_pfn,
>  					    unsigned long npages,
> -					    enum dma_data_direction dir)
> +					    enum dma_data_direction dir,
> +					    struct drm_pagemap_iova_state *state)
>  {
>  	unsigned long i;
>  
> +	if (state && dma_use_iova(&state->dma_state)) {
> +		dma_iova_unlink(dev, &state->dma_state, 0, state->offset, dir, 0);
> +		dma_iova_free(dev, &state->dma_state);
> +		return;
> +	}
> +
>  	for (i = 0; i < npages;) {
>  		struct page *page = migrate_pfn_to_page(migrate_pfn[i]);
>  
> @@ -420,7 +469,7 @@ drm_pagemap_migrate_remote_to_local(struct drm_pagemap_devmem *devmem,
>  			       devmem->pre_migrate_fence);
>  out:
>  	drm_pagemap_migrate_unmap_pages(remote_device, pagemap_addr, local_pfns,
> -					npages, DMA_FROM_DEVICE);
> +					npages, DMA_FROM_DEVICE, NULL);
>  	return err;
>  }
>  
> @@ -430,11 +479,13 @@ drm_pagemap_migrate_sys_to_dev(struct drm_pagemap_devmem *devmem,
>  			       struct page *local_pages[],
>  			       struct drm_pagemap_addr pagemap_addr[],
>  			       unsigned long npages,
> -			       const struct drm_pagemap_devmem_ops *ops)
> +			       const struct drm_pagemap_devmem_ops *ops,
> +			       struct drm_pagemap_iova_state *state)
>  {
>  	int err = drm_pagemap_migrate_map_system_pages(devmem->dev,
>  						       pagemap_addr, sys_pfns,
> -						       npages, DMA_TO_DEVICE);
> +						       npages, DMA_TO_DEVICE,
> +						       state);
>  
>  	if (err)
>  		goto out;
> @@ -443,7 +494,7 @@ drm_pagemap_migrate_sys_to_dev(struct drm_pagemap_devmem *devmem,
>  				  devmem->pre_migrate_fence);
>  out:
>  	drm_pagemap_migrate_unmap_pages(devmem->dev, pagemap_addr, sys_pfns, npages,
> -					DMA_TO_DEVICE);
> +					DMA_TO_DEVICE, state);
>  	return err;
>  }
>  
> @@ -471,6 +522,7 @@ static int drm_pagemap_migrate_range(struct drm_pagemap_devmem *devmem,
>  				     const struct migrate_range_loc *cur,
>  				     const struct drm_pagemap_migrate_details *mdetails)
>  {
> +	struct drm_pagemap_iova_state state = {};
>  	int ret = 0;
>  
>  	if (cur->start == 0)
> @@ -498,7 +550,7 @@ static int drm_pagemap_migrate_range(struct drm_pagemap_devmem *devmem,
>  						     &pages[last->start],
>  						     &pagemap_addr[last->start],
>  						     cur->start - last->start,
> -						     last->ops);
> +						     last->ops, &state);
>  
>  out:
>  	*last = *cur;
> @@ -1060,6 +1112,7 @@ EXPORT_SYMBOL(drm_pagemap_put);
>  int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  {
>  	const struct drm_pagemap_devmem_ops *ops = devmem_allocation->ops;
> +	struct drm_pagemap_iova_state state = {};
>  	unsigned long npages, mpages = 0;
>  	struct page **pages;
>  	unsigned long *src, *dst;
> @@ -1101,7 +1154,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	err = drm_pagemap_migrate_map_system_pages(devmem_allocation->dev,
>  						   pagemap_addr,
>  						   dst, npages,
> -						   DMA_FROM_DEVICE);
> +						   DMA_FROM_DEVICE, &state);
>  	if (err)
>  		goto err_finalize;
>  
> @@ -1125,7 +1178,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	migrate_device_pages(src, dst, npages);
>  	migrate_device_finalize(src, dst, npages);
>  	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
> -					DMA_FROM_DEVICE);
> +					DMA_FROM_DEVICE, &state);
>  
>  err_free:
>  	kvfree(buf);
> @@ -1170,6 +1223,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  				  MIGRATE_VMA_SELECT_COMPOUND,
>  		.fault_page	= page,
>  	};
> +	struct drm_pagemap_iova_state state = {};
>  	struct drm_pagemap_zdd *zdd;
>  	const struct drm_pagemap_devmem_ops *ops;
>  	struct device *dev = NULL;
> @@ -1229,7 +1283,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  
>  	err = drm_pagemap_migrate_map_system_pages(dev, pagemap_addr,
>  						   migrate.dst, npages,
> -						   DMA_FROM_DEVICE);
> +						   DMA_FROM_DEVICE, &state);
>  	if (err)
>  		goto err_finalize;
>  
> @@ -1254,7 +1308,8 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  	migrate_vma_finalize(&migrate);
>  	if (dev)
>  		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
> -						npages, DMA_FROM_DEVICE);
> +						npages, DMA_FROM_DEVICE,
> +						&state);
>  err_free:
>  	kvfree(buf);
>  err_out:
> -- 
> 2.34.1
> 
