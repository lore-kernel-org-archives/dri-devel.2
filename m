Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFD3D6AAE8
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 15:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6D3810E3F6;
	Thu,  2 Apr 2026 15:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ER8dYMKU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514CA10E3F0;
 Thu,  2 Apr 2026 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775145570; x=1806681570;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nNb8Xmw06bgVfTNEgTX1bQTOFnUgcxk/ggVpu7jDPO4=;
 b=ER8dYMKUJ41QOD79rwgYB/T7x2bgfpeMKuJKzr7BEOS9Y3UJNb2cufc1
 P8VD9n6uiO7WY4EPWdrDOgvLBhWlEFhFZJ1kxrKvsVNGrTKIB90C1sDD/
 0DpehuNKqnxxP3upWjmO9jdCc5MQbH+wEbAS/swVC3zlZKQTUzjBQDk0U
 gvXJGYHl7SEfhN04g3HoCuDkWyUR0xjzuLz30vVIC/WVn4ga79r5OUNlM
 KUmdi757maxDpJccGI58jw22R6ZzCgYS5VaUzYwVXeOOd/QlimOPtaEHP
 0xe+0n2z0ffEy5/rZRAVxGCVgcUhEU6Odj2iHC1VK55V5CfYSSRVORovC A==;
X-CSE-ConnectionGUID: muuN4bCvRSm0VEe1y24ZRg==
X-CSE-MsgGUID: 0k3FFpDQQkqkagqUlk6NPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="86910156"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; d="scan'208";a="86910156"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 08:59:30 -0700
X-CSE-ConnectionGUID: PgsWEhQ+QR+2tsA8zmKfvg==
X-CSE-MsgGUID: ZrRLNcydR5WETo9+PkcGug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; d="scan'208";a="222651727"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 08:59:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 08:59:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 08:59:29 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 08:59:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drKzEm1b8XcUUfbYlAU3+kqXycottrrpaI9m/Xni/jvDtPsBelLOAxbVZELaTIeZ/8VFg/4YK4bX01SkPmvTjaG8y+eaHiYZDdxK6uz3GNL5h2sth6t6uhrU4GKa6Is3q1DyKQtw/U3ZiMU+daooRnuKw7S8nRn5oz4W/hEeWLByA7wUP6yMmdIV8OVDA4uMY4BSJaKD5if4JOEgilG8WIeGjX4xQugNfdM/RC6h3CC4EBtWLsW6NKpoxt/k7rOT1W1Uh4ySdvlSjH/keBYHq4gG6BKGiGrW0XjNu0elYIsj9jOfj8TsLMd4TTyDlDx6YXdp19EXcTiDNUPN7lTafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lu1Oiva/CqRf0RjgTeKcCGdKaOOJIQ0j5fdtZCwARyI=;
 b=ETlSJJsKE2I107OPvpsHx+LYp/SM8IneJrPnPvzWdfLRywOvK2+NrdO+hETsqvGBPgOkxP4eYf8EO31QfzueGEGPFqfLfHbycltT319qFXcf/jI5yK75Iklje3DMXabAYOdoweWvjOAzk5xKqD1jzLKs64OjcId6nD9DgIsfR3MHlASTed7yER8BESMicmCO0A6fEUxyz9XJ2Et6pkA14eV5gDxNMMWjT6xrwXpG7VZhjB+5dfNFUqf3feBGPxLA/AIZLkbnQa8l4EeoJlIwIUIJYNW2/Yx+wVu1wwz246BbY2GoQyxA4Jvh/eXlJUi7YA8Ha4mGaVySth27Hjt8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by IA3PR11MB8917.namprd11.prod.outlook.com (2603:10b6:208:57d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 15:59:27 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277%3]) with mapi id 15.20.9769.020; Thu, 2 Apr 2026
 15:59:27 +0000
Date: Thu, 2 Apr 2026 17:59:21 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <leonro@nvidia.com>, <jgg@ziepe.ca>, <thomas.hellstrom@linux.intel.com>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH v5 5/5] drm/pagemap: Use dma-map IOVA alloc, link, and
 sync API for DRM pagemap
Message-ID: <ac6SWbCDbBvRPbUj@fdugast-desk>
References: <20260219201057.1010391-1-matthew.brost@intel.com>
 <20260219201057.1010391-6-matthew.brost@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260219201057.1010391-6-matthew.brost@intel.com>
Organization: Intel Corporation
X-ClientProxiedBy: DUZPR01CA0266.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::29) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|IA3PR11MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: c62dc539-ddb1-4f17-b899-08de90d0d114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Lb2q9BfYeN/EambbAuWWq8snJ/5emctV5bWmt8+qOoG1m6gPb/6EFQSVnclSLQH2QChrC6SVNU9eJxn82+PWFL71pJZZ6kduh/Xxu3JK4bdrdJNy/idnOBWXtYue973pzoNOEUsSHCPsr6ykF4CywE6G9H6NO9SNifrMWjrvwVTyHlMa8LrwrF/MfXwj6r54X8nzuYEm7Lr28+ig04EIZSmSzYO6WPeMoEVhqZo8ckmIq5yTrmkCJp1+8xCVP//tc0dIilfPXyWVWxOxJ546dkiFtG2SJaOmWDTnASgPBJ1F/w86/L+/Kod+GQ/MhqRnOgKelC/PCEHqozrNe0PccVjncddexPYJPA8UIyLRu/O/ywAyyKXH/0FLdo/1LpYgg24CQro5QtXHbC/CpKxnSXagZtOIM731/fOs1bwDywTPtccVIKue0O/wkcEx2MYWBF/CCyldxjIUSYUo3bCJmwjr7FgFR5qVEV7Y/lokVgExFF19P759OF9Fa8JQWzIfqi44V0BOalTmxGAXaibPLTrOVWyxNzwwacvVQM81VQTn1yMmvB+LrZ5lHxYF3Wb3T/1pPTKdIZqp9dA5BDiBaqs1gw1LfAghS2KVAhskmXPmyeFygZWTYVG6Hd113lqQ7LdYM6lfIy+PpwBofYUlZGnhOV/XMLeQ+/W42V2V9jpwYfQ+72StlNlNws/Cxn2Oir+clI4HqGNPZ9tA8muuD6JoH81jW579oj/wfP77IJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7828.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LhM8P3eYLNVAfagmN7jugv60gMaoBVQBBaZBK+ZEvyrcsYotKXyYdLYBOYPq?=
 =?us-ascii?Q?A9oD/8WZ15U54SjYhOjvTKwjrg50GRNl+enva3ypqFpbsEvLyT3VB/H8c4ne?=
 =?us-ascii?Q?1qCj7kr2tW5oA5sgTn/kZj45RJZdxKXCAWuRO2yyhdmkkydjMkXckTDBK4bm?=
 =?us-ascii?Q?XBFPMjbNenYZaKjtLay3K/UYTLFByv5WMkds6YKv2LiXVDcC6keIB3c1DbcN?=
 =?us-ascii?Q?FU0QtBv1qadjGHqUJSMgnytgX58ajlBXyWJq7Mo6xJ43OASKsA1+naBcVlCf?=
 =?us-ascii?Q?rVxSzN2LaAL6QlGNIbUkSLzXVJ73ysabZRKremxsS/cfX2t0+fZNXIAI7rt6?=
 =?us-ascii?Q?qylfMlclHzcMZNts+HVRcsF/UbJ2TffnglVglJLurY7yayNIfyNYF6NLrDxU?=
 =?us-ascii?Q?IDZ817+bMV8iYENzs9o2iK8G9wW29e+aFcsOXoq9NR0ar/R40O3K6cLGp2s6?=
 =?us-ascii?Q?/OSLC3G7zUCuceMVn2l8FOttO1MsGoXOlsXlJtwyOx/p06A5gg3IcoSWlew/?=
 =?us-ascii?Q?QLXNxJ/LnjEjyCD05t4TWGn0QUXu5koubOR0mRwhs1K81gFpNnv7HtBKBjCD?=
 =?us-ascii?Q?82NT9hldZA825RB0Hx93g0racTOkijH6U5mUP2g4oQjm/wIaGoc0Yd5dxvAu?=
 =?us-ascii?Q?BIog0S+GkFr91uGIevtKz7PvWF9i0j43VdkKunq2A6xgZWLokI37jTSSETcI?=
 =?us-ascii?Q?SaqG+yhzjYiKd6oNLSM24iJBz9IKVoIKKcYQvN2Y0fvBhD5wYiYyaRvmOf6S?=
 =?us-ascii?Q?zgGPODUX5HUiDyAbcS+HFWusxpeqejJMeHYrfgX7V/jfELoxNrjvSQ5Vi0DR?=
 =?us-ascii?Q?afO65jNCxOg+zHfeDxkf7n578DIGpL57bHMBJ/ZtNDJOD+l8RwmsMKTlWhRg?=
 =?us-ascii?Q?XWIdA/hscm+f/uj8P3hRvDNZsg3SwPWPDjD0x4LxNvUsDIRz0bGWqWYYP1My?=
 =?us-ascii?Q?xAV6udMMOGT8NZHD47lHLtt4yf0mX6+VuPs1+2JO1PYJA8ghHRflcJeLvntL?=
 =?us-ascii?Q?sK8h2H+UazBI9yAFrUbylJQb5cp1jmOiFnxD7R9BSM35uW+gf1m9fdSRiTEa?=
 =?us-ascii?Q?RUiHo3e2cZPIWeJg0PVWn4AlCWsSMHJC9v4XMUjtskUwLJBySrHYEgChKUTD?=
 =?us-ascii?Q?7SEJ4cH6AcFiFAq6h3Nn5mXP6lZZQxpzGhDU9Kb2lX6bUBas0Zgz8GG4ue5l?=
 =?us-ascii?Q?SRKUW/V5vz3+6ukbtGr+V15guPJ1/akHqLl6shuKeSLrdARic0NGTh2yqXY7?=
 =?us-ascii?Q?ZQpu2aEa3/F7QLZeA1JtrZ4SIHzW75u6Zg4OzlLCUAhilMnMxtwo3D3Uf7mz?=
 =?us-ascii?Q?LPaREulIZl31995Pnaa7vMzwnCsdRvW4XPy2O+pYhZ7h5M4DVq5h81WJVO8Q?=
 =?us-ascii?Q?2ribduVRI2GIehJwI13+KsDg1n2GbDQBfyFhA0v9aoEe5/8yZJruQ2zCkla/?=
 =?us-ascii?Q?5xyR0n0/Ps4ztERHP8fsStFOjZbkbjwd9ZZwJLcKuihuxGzHcze9o6eDPC/x?=
 =?us-ascii?Q?qktzFXImkZkRxmjxfRJkUqhtzh7sPRGs5Hp67KFKVpAVMTiNoUUg2DSihWoo?=
 =?us-ascii?Q?2h7WYrCMYKEWLCP3npOGQgkajvKWNNYlIMrfsCV9C/55DI3ZO3Z8v87yNMX3?=
 =?us-ascii?Q?ZteYf1DzelvYqfWoNkUjRTYYEpRF0nKzWnHy5x2DD1sAkuK0QvzyXg/NxSHg?=
 =?us-ascii?Q?flvmoS3uPcruDfnppR5HPZuU5FiRHJwPoA2N+BBngkfi4d43X9rITdux3ts2?=
 =?us-ascii?Q?AYweCQ52NBhBt5hOcKBqecL3FRoK+/g=3D?=
X-Exchange-RoutingPolicyChecked: BfKNUJA9rXbOmPm0rGSfKUbC+ryMZFnper7RrMydrspRBdpScmOsjbMglV/bP14CppcpYPsBWhw+VekxRq4Hdj5CzZcgjqlxDCiBU/11sLkEUTBAr0nFoIaX4xHLObnHtXc8nRQ1eYZJW3Zg+tzedEwqXGYomcyI8dwCYCZ7+IK5AD7DaknE7K2xR5mwUrVhrQggbfMvNWt+AD+0O41aRwyoF+dvaYdISUFomXcXcg5BKAqxQjkVienzkxg0AhS2pvhD+MOqqCZ42klTUbYtRbfyTrTep7aynrhOZ25eO0vpLFfWx69WBoYUHGuvomrEMWD432nTojCMNssvY0LwnA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c62dc539-ddb1-4f17-b899-08de90d0d114
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 15:59:27.0236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVwkTKcfGmDI29bAGd/dY98C3ZXQa1UPKgTI7orOhJioddGZwBnmjGyNS2UDUYHerawBYRbgd/ux5ruV6kjl1VivClahGt9BQYwgeoMd/aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8917
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

On Thu, Feb 19, 2026 at 12:10:57PM -0800, Matthew Brost wrote:
> The dma-map IOVA alloc, link, and sync APIs perform significantly better
> than dma-map / dma-unmap, as they avoid costly IOMMU synchronizations.
> This difference is especially noticeable when mapping a 2MB region in
> 4KB pages.

Still a good improvement but with device THP now in drm-tip for GPU SVM,
the speedup is less noticeable when looking at latency and throughput.

> 
> Use the IOVA alloc, link, and sync APIs for DRM pagemap, which create DMA
> mappings between the CPU and GPU for copying data.
> 
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> 
> ---
> v5:
>  - Remove extra newline (Thomas)
>  - Adjust alignemnt calculation (Thomas)
> ---
>  drivers/gpu/drm/drm_pagemap.c | 83 +++++++++++++++++++++++++++++------
>  1 file changed, 69 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index ef8b9c69d1d4..d9fceffce347 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -281,6 +281,19 @@ drm_pagemap_migrate_map_device_private_pages(struct device *dev,
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
> @@ -289,6 +302,7 @@ drm_pagemap_migrate_map_device_private_pages(struct device *dev,
>   * @migrate_pfn: Array of page frame numbers of system pages or peer pages to map.
>   * @npages: Number of system or device coherent pages to map.
>   * @dir: Direction of data transfer (e.g., DMA_BIDIRECTIONAL)
> + * @state: DMA IOVA state for mapping.
>   *
>   * This function maps pages of memory for migration usage in GPU SVM. It
>   * iterates over each page frame number provided in @migrate_pfn, maps the

Not visible in this diff but we should update the doc as the return value is
not only 0 or -EFAULT, it can be any error code returned by dma_iova_link().

> @@ -302,9 +316,11 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
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
> @@ -319,9 +335,31 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
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
> @@ -332,6 +370,9 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
>  		i += NR_PAGES(order);
>  	}
>  
> +	if (dma_use_iova(&state->dma_state))
> +		return dma_iova_sync(dev, &state->dma_state, 0, state->offset);
> +
>  	return 0;
>  }
>  
> @@ -343,6 +384,7 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
>   * @pagemap_addr: Array of DMA information corresponding to mapped pages
>   * @npages: Number of pages to unmap
>   * @dir: Direction of data transfer (e.g., DMA_BIDIRECTIONAL)
> + * @state: DMA IOVA state for mapping.
>   *
>   * This function unmaps previously mapped pages of memory for GPU Shared Virtual
>   * Memory (SVM). It iterates over each DMA address provided in @dma_addr, checks

While we are here: s/@dma_addr/@pagemap_addr/

Francois

> @@ -352,10 +394,17 @@ static void drm_pagemap_migrate_unmap_pages(struct device *dev,
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
> @@ -410,7 +459,7 @@ drm_pagemap_migrate_remote_to_local(struct drm_pagemap_devmem *devmem,
>  			       devmem->pre_migrate_fence);
>  out:
>  	drm_pagemap_migrate_unmap_pages(remote_device, pagemap_addr, local_pfns,
> -					npages, DMA_FROM_DEVICE);
> +					npages, DMA_FROM_DEVICE, NULL);
>  	return err;
>  }
>  
> @@ -420,11 +469,13 @@ drm_pagemap_migrate_sys_to_dev(struct drm_pagemap_devmem *devmem,
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
> @@ -433,7 +484,7 @@ drm_pagemap_migrate_sys_to_dev(struct drm_pagemap_devmem *devmem,
>  				  devmem->pre_migrate_fence);
>  out:
>  	drm_pagemap_migrate_unmap_pages(devmem->dev, pagemap_addr, sys_pfns, npages,
> -					DMA_TO_DEVICE);
> +					DMA_TO_DEVICE, state);
>  	return err;
>  }
>  
> @@ -461,6 +512,7 @@ static int drm_pagemap_migrate_range(struct drm_pagemap_devmem *devmem,
>  				     const struct migrate_range_loc *cur,
>  				     const struct drm_pagemap_migrate_details *mdetails)
>  {
> +	struct drm_pagemap_iova_state state = {};
>  	int ret = 0;
>  
>  	if (cur->start == 0)
> @@ -488,7 +540,7 @@ static int drm_pagemap_migrate_range(struct drm_pagemap_devmem *devmem,
>  						     &pages[last->start],
>  						     &pagemap_addr[last->start],
>  						     cur->start - last->start,
> -						     last->ops);
> +						     last->ops, &state);
>  
>  out:
>  	*last = *cur;
> @@ -993,6 +1045,7 @@ EXPORT_SYMBOL(drm_pagemap_put);
>  int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  {
>  	const struct drm_pagemap_devmem_ops *ops = devmem_allocation->ops;
> +	struct drm_pagemap_iova_state state = {};
>  	unsigned long npages, mpages = 0;
>  	struct page **pages;
>  	unsigned long *src, *dst;
> @@ -1034,7 +1087,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	err = drm_pagemap_migrate_map_system_pages(devmem_allocation->dev,
>  						   pagemap_addr,
>  						   dst, npages,
> -						   DMA_FROM_DEVICE);
> +						   DMA_FROM_DEVICE, &state);
>  	if (err)
>  		goto err_finalize;
>  
> @@ -1051,7 +1104,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	migrate_device_pages(src, dst, npages);
>  	migrate_device_finalize(src, dst, npages);
>  	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
> -					DMA_FROM_DEVICE);
> +					DMA_FROM_DEVICE, &state);
>  
>  err_free:
>  	kvfree(buf);
> @@ -1095,6 +1148,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  		MIGRATE_VMA_SELECT_DEVICE_COHERENT,
>  		.fault_page	= page,
>  	};
> +	struct drm_pagemap_iova_state state = {};
>  	struct drm_pagemap_zdd *zdd;
>  	const struct drm_pagemap_devmem_ops *ops;
>  	struct device *dev = NULL;
> @@ -1154,7 +1208,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  
>  	err = drm_pagemap_migrate_map_system_pages(dev, pagemap_addr,
>  						   migrate.dst, npages,
> -						   DMA_FROM_DEVICE);
> +						   DMA_FROM_DEVICE, &state);
>  	if (err)
>  		goto err_finalize;
>  
> @@ -1172,7 +1226,8 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
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
