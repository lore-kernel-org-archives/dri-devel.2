Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6F6D3942D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 14:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A196A10F0A4;
	Thu,  2 Apr 2026 14:12:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J+2N+uyG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA85410EFBD;
 Thu,  2 Apr 2026 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775139132; x=1806675132;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=j+1Cjwh1A87eXH1rqiq5ryAkq1syGa6kq900tONJeHQ=;
 b=J+2N+uyGwJSlBu7Qs6slwUalZ7niL47FbL1s/cRkBlaCHai2k77ME+hN
 LCQeSz0KG9m9sTtMGZHR5Wd/kIphPqSnNILimoU1Mhqwq8/hn1FEXo++Y
 u5JMaYDoFEOpDRL48ikxrnqjvlyy/cxTKzaG8UqwSN3v86m5BnlgwM87F
 amCHYcYqrqiarg2CPNv4he66Z3N5iscznfDh9mZ6dhnWo6aE0JeJlKc52
 60LIs7D52m96XCaJm/YI+cn35/y33Cs/5Ss2zBZrm2WCIts0ZLIZf54XA
 PmEmrwMgSjYcOeNphb2YF5zKylN06RU9jY0PtwQkNc98pVOQyrqr+XugL Q==;
X-CSE-ConnectionGUID: J3haruEnS5GJqlxj1vAxmA==
X-CSE-MsgGUID: GAmSS191QfeQoT2dYSmUbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76386365"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="76386365"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 07:12:11 -0700
X-CSE-ConnectionGUID: b0jAGDTqSBeFI1o1CoB0nw==
X-CSE-MsgGUID: fxbtsVmiSuubWm9gYMtJGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="228616210"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 07:12:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 07:12:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 07:12:10 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 07:12:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2lH+/ZU1jUzTeP7aX8fRkjG4BjFRfb2qdrwyYpigNH4a94XwItvo3LYWGNSATe0QpihmGGaVxpqhB25FyfkydsW5NVRcbmjWUQ/zZW/RQQlxRo5o9sVknlTfQnyM/+wM17jJ6vMBpjCaPJYxrGcQIMCSwATO5QZrJ2OtvsBdLM64vyFnSlQzXUhJhB54W7bJusGvnYqSFBhQxx6MFydbNNKrS0a0HCM9uQPLv9AD8E9FQNlIaiJkssNeUeCIcqQXIW/vVaYcoFUJSo0hv8u+gwfmqCpQ7ecl/NFdzrMpce1NdrnpgVd7brRNlJ1b9owhqYsXntpMGt6AyO2Bb8RFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC2Ra3me4hlLvkhrLvsr4ZMIMncfCS7ozw+6sPKxmgI=;
 b=boasDe2A6lT54y9+JBrQ0Kdnd3kAk0mHSpeK7SJPd12y1n0iASScEjTO+UXpNs/gDH0N808XCAj2lE7+W7eO9QyzTc7rJHBy7GxzaB7noBdKiA9Lw5zVGhkbvJ0/kQA8O371FQlq/ROmM7awm2oqB1T/wFhKbHA3zmdLv916V9ux2K3GAnYrHZv5jikfsXB0B4nT3YrfbtI7SWR8tnL2o7RwSWOhnPXu7V76E/wUd+WInXyomF1JGz+s7YEGzSI6qIyIWWAHc3bE5DBzFh9ZmC9MXKO8MtbIjRUuSHdi2d9xllBsuHy7zeovX8m6Lz1A0Nf3JUF1m0bwRkzEJbuSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 14:12:08 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277%3]) with mapi id 15.20.9769.020; Thu, 2 Apr 2026
 14:12:07 +0000
Date: Thu, 2 Apr 2026 16:12:02 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <leonro@nvidia.com>, <jgg@ziepe.ca>, <thomas.hellstrom@linux.intel.com>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH v5 4/5] drm/pagemap: Split drm_pagemap_migrate_map_pages
 into device / system
Message-ID: <ac55MqY8MucJK6_V@fdugast-desk>
References: <20260219201057.1010391-1-matthew.brost@intel.com>
 <20260219201057.1010391-5-matthew.brost@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260219201057.1010391-5-matthew.brost@intel.com>
Organization: Intel Corporation
X-ClientProxiedBy: DUZPR01CA0284.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::22) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|PH7PR11MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: f79ffee4-3dbf-4b99-dd9b-08de90c1d2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: CzDwz9s7Zd9ZQNZ/2omngT5U6Gh+w70+KNolFTFcsWVEKXuz4DhGG9Np67sRbc/DIEfSUyjj3iMnLDAbCYKiXzWw6j3fAcXjiJvJ+hvNo0NMoplozpNnHhrcYwClde52Iz2U7KrP2hgoIsKi/N71R2uncKHGWyIsRKZl66EGaVXOYXykQqBFwTYRHN7bkWG93+4UHfmgaX8jFsaOU4TGOpfFkCMdbuaUsoOK0iIFUA/C/4R4Qm6alFrmiHJu6a/cRczmqiI79uJdQPkveLB779+/wx03+PUOCXhMx22iRpagWyAUENYW0ijy9645nfkEv0bceqAlt8MLHrZrjcDppf9AG5ahqjPIjORumZ2u7gNhtHvq/CFGTh8XlB7RWiYffsHQZXCzGfpLxxkHCcbyPMgB1VA6JJ/Yd0Fei+KNRUWVmY6YTROSgnjsV4nrHPNNwLegvRsTa98+nSaoRKz3y8kAQbucYt7I8E9cyWdKYLcKfuvC43qMsTsLy7Rz75UsRImbTCvyWPBxB0Cbaku5nGU91IC1d1H3RGfbh/wLMvy0pwheryQVZjaEtPqhxhSxlb9WDrN4ySLH6tKHRfercaZZNMvfrPOpOU+w3w6jWO2DG9KSeN8noXiD8QhqmNddF7LprfvPD0TDlBaSuqnNysZsWxmyxKcDMMW4ZKOLwP7dtK1FiXZjViqzoCPkmKwLrKjQ9Bu5LTobGyK1Y+W3h3WTXXQz6uWFP1WXirz0Xn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7828.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RhOJyfgX6ju0cVIbw+E3OA2AAdb1G29K95Ypqo+wUfzq/L0wGtfFM9eeXKEO?=
 =?us-ascii?Q?rm0RSLcjU9vVa2T/LaQEhC5DSuol/s5YJuu0t9oadOtCpnwWH5BTIY2uoGQ2?=
 =?us-ascii?Q?i14ozsr7QgOVmpGldSNZg+dmeycP6IZD6MI1o/Fh0eSapb67JgqU54hl9o8J?=
 =?us-ascii?Q?RVYP8ktLI1KQNlgJUUbbvjMqgf8uJwy0zvao8gFAayBAWAJeZ7uQnNGX/qyJ?=
 =?us-ascii?Q?Zkhh/VWNOWo17De2taFyB0Q8rVUHpbtAptz2hCFdo7GiCbntTi6/qnxrttDF?=
 =?us-ascii?Q?Lcfz2+J9q0hlTKKZnIQ4sDy4L9c6X89dG7soLLzoPBTJ7LKrT0aiLrGL9vue?=
 =?us-ascii?Q?Mrv6WpZsn6MrDCKH2X0vRzzB0DYtMNqWFZddKfNP3WV4w5vVgK6yywEp9JlK?=
 =?us-ascii?Q?WaivoP7pEiSRUX3zOvYKasODFDwDYGzeOQV8+JSQf9QUDsnWUw7SbpS3w6tG?=
 =?us-ascii?Q?Pr1dBgF4ZDoV0rM4A2kgSQ19P8zUor3itYJ3Pw/QHpMPg0fEQLY/6YTQh3m4?=
 =?us-ascii?Q?OzgSb0Cu3fbipcTmxl6i12kKJw7LMicTbRsYa6eNlCtomhomiZ58uiT10YWm?=
 =?us-ascii?Q?EMoJy4foESujgG35s9GpZaKXd/CCJ0xUUweNUO2XkEOu3qBPjwgSHKOKWDEl?=
 =?us-ascii?Q?yMy19z7kULWZLIKAIzsyFeecLUOov6tpezQpUD8oKZkvwqAN8lh6mc4TpPCW?=
 =?us-ascii?Q?QjF3LlcKzoUYxWdqAGuW0fXjUuY9yz9VDpIjXSAlrY7Bfpq/RxSQRxfolNxz?=
 =?us-ascii?Q?43opHND41+UZSCVy6HysbWz4uEUOQ9UVmIf6lonr/lN/gtt8RgOAf0MAkmCG?=
 =?us-ascii?Q?/tjaaHNZRZuR80mPvxbODWafXPCzijK6D3ZQu2UVj0GiEe5zX7WFaUb3CErS?=
 =?us-ascii?Q?ZSbUZIrEssv5vUv3SUItTMVyoDqczhRHjlKfnT+Z39Db4lZ7rcIg+5oMm6Ej?=
 =?us-ascii?Q?xuosJZV/p9O2bqoZJ60xBK3/OKxeud1QMqlg00/0CJMJMlt7l4/3JsQr9wlu?=
 =?us-ascii?Q?eytTKRFgDKanNVDcrv1liqeh/+YQRx/zLBJuzIrzQL/Zi5pSgdrBH3xjC0DQ?=
 =?us-ascii?Q?GaNL/dEK0HSb6lTZWep3QOuZztiahtqcUD6OBNPsX+UQgWcxMcWDCRujRj2J?=
 =?us-ascii?Q?7qL9pWeDTEw6dP4+6b6ap3OsgeE3jlB2dWnUdpw6vQH6oTxs3dm/ADWNPDhX?=
 =?us-ascii?Q?Dy7OwTCKYCKzZxEqV8ahe2Dx6q5DV1X+Hk/w8ZpB7n6tqmceBWWA/Cdzt8sg?=
 =?us-ascii?Q?KzXzqOmSfoK0oLuVha3aMiP+d1b+ivX5Om5YGa+D1XRYFsX7Nw/LPubnQWRS?=
 =?us-ascii?Q?5lPP1ycqoh6h2UIX4atnT/zIII2mslTWLTe/deFrL57icARtQ1wo+B9hfWig?=
 =?us-ascii?Q?QJgG5PjcHnIlOg8FM0v0tPBEFiCuHURXWSXzgMWUTxd3QQXpbyJV3uJ24lew?=
 =?us-ascii?Q?pnekRREq78PkOB69u3rtibAJ7F1nmDPYVfqGACXGSykmddS9Q4WFynyqxm4h?=
 =?us-ascii?Q?2OCTCkPkVsO0efn9hksfMuDKB9vYlGnGjeoldAzQBZI/lwTWvadpYD4EESME?=
 =?us-ascii?Q?/spFN32Ede0GjKZYkdsLm9oUABrmpdamzLy8R0CVIEPSM3AcgdYOITpHX+GX?=
 =?us-ascii?Q?WjBohsiLeMHjJAtq9XvdyhN+HoL0AzQxrfy3NUa80gu3gdKBKMCGf1tOTfJk?=
 =?us-ascii?Q?/uKgvoSwG54Q+MLlGL1Q4WxSHaIWyeZLIoQ3acxsYJIny+SuQmYtHFDMqdEJ?=
 =?us-ascii?Q?ZjDtq/SOar9G8JA5TTr+7quuHzbzOAs=3D?=
X-Exchange-RoutingPolicyChecked: qlYRNm/IJYmqOE7RkiA6nv50CgIxk1C/FrAv1uTgj9DlYn/FtSnJh4dCtZP8oB0SCzssn9ut+nU0UUscw9mCI5R4qt+VtpPqsyTbevAEDrulij9ZLdu5RvBz1BVocBdz8MpjNn5820ueEB7frNDfrronaGcWQi3esh6uiYZDj5npIrhvsBstygSpJV12/LMAN33U2E1vgdQ3D6fakuqpsXVXjKIFSrXsyTrn4cvEU0+PhTkHf+O0HC4Dl/Payr5+Rsa5kfmfpYOmIjHrPjK6XqVsRiXVxYxjfy/bSIJ5EVjPof+nRLb+CK5no/SWQ4KjY+M4A0NEQKtpRp+FBHhjhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f79ffee4-3dbf-4b99-dd9b-08de90c1d2a9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 14:12:07.2726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HAzpeA8nDNfPq6igOgoQbStPRBo8vE4fyvTxL+3wK6IcTJ8eh9HiYVPt+NIBCskuPA25WwHvEExx37CK4iCMWb1khbi+N87qv3hwiodMcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
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

On Thu, Feb 19, 2026 at 12:10:56PM -0800, Matthew Brost wrote:
> Split drm_pagemap_migrate_map_pages into device / system helpers clearly
> seperating these operations. Will help with upcoming changes to split
> IOVA allocation steps.

Side effect is that it makes the code a lot more readable. A couple of
nits below.

Reviewed-by: Francois Dugast <francois.dugast@intel.com>

> 
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> 
> ---
> v5:
>  - s/map_device_pages/map_device_private_pages (Thomas)
>  - Fix map_system_pages kernel doc (Thomas)
> ---
>  drivers/gpu/drm/drm_pagemap.c | 150 ++++++++++++++++++++++------------
>  1 file changed, 100 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 32535ab01c0f..ef8b9c69d1d4 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -205,7 +205,8 @@ static void drm_pagemap_get_devmem_page(struct page *page,
>  }
>  
>  /**
> - * drm_pagemap_migrate_map_pages() - Map migration pages for GPU SVM migration
> + * drm_pagemap_migrate_map_device_private_pages() - Map device privaet migration

s/privaet/private/

> + * pages for GPU SVM migration
>   * @dev: The device performing the migration.
>   * @local_dpagemap: The drm_pagemap local to the migrating device.
>   * @pagemap_addr: Array to store DMA information corresponding to mapped pages.
> @@ -221,19 +222,22 @@ static void drm_pagemap_get_devmem_page(struct page *page,
>   *
>   * Returns: 0 on success, -EFAULT if an error occurs during mapping.
>   */
> -static int drm_pagemap_migrate_map_pages(struct device *dev,
> -					 struct drm_pagemap *local_dpagemap,
> -					 struct drm_pagemap_addr *pagemap_addr,
> -					 unsigned long *migrate_pfn,
> -					 unsigned long npages,
> -					 enum dma_data_direction dir,
> -					 const struct drm_pagemap_migrate_details *mdetails)
> +static int
> +drm_pagemap_migrate_map_device_private_pages(struct device *dev,
> +					     struct drm_pagemap *local_dpagemap,
> +					     struct drm_pagemap_addr *pagemap_addr,
> +					     unsigned long *migrate_pfn,
> +					     unsigned long npages,
> +					     enum dma_data_direction dir,
> +					     const struct drm_pagemap_migrate_details *mdetails)
>  {
>  	unsigned long num_peer_pages = 0, num_local_pages = 0, i;
>  
>  	for (i = 0; i < npages;) {
>  		struct page *page = migrate_pfn_to_page(migrate_pfn[i]);
> -		dma_addr_t dma_addr;
> +		struct drm_pagemap_zdd *zdd;
> +		struct drm_pagemap *dpagemap;
> +		struct drm_pagemap_addr addr;
>  		struct folio *folio;
>  		unsigned int order = 0;
>  
> @@ -243,36 +247,26 @@ static int drm_pagemap_migrate_map_pages(struct device *dev,
>  		folio = page_folio(page);
>  		order = folio_order(folio);
>  
> -		if (is_device_private_page(page)) {
> -			struct drm_pagemap_zdd *zdd = drm_pagemap_page_zone_device_data(page);
> -			struct drm_pagemap *dpagemap = zdd->dpagemap;
> -			struct drm_pagemap_addr addr;
> -
> -			if (dpagemap == local_dpagemap) {
> -				if (!mdetails->can_migrate_same_pagemap)
> -					goto next;
> +		WARN_ON_ONCE(!is_device_private_page(page));

Another nit: could we move this line ^ above that one:

    folio = page_folio(page);

so that the check is the first thing we do with that page, and also to
have a bit more symmetry with +drm_pagemap_migrate_map_system_pages().

Francois

>  
> -				num_local_pages += NR_PAGES(order);
> -			} else {
> -				num_peer_pages += NR_PAGES(order);
> -			}
> +		zdd = drm_pagemap_page_zone_device_data(page);
> +		dpagemap = zdd->dpagemap;
>  
> -			addr = dpagemap->ops->device_map(dpagemap, dev, page, order, dir);
> -			if (dma_mapping_error(dev, addr.addr))
> -				return -EFAULT;
> +		if (dpagemap == local_dpagemap) {
> +			if (!mdetails->can_migrate_same_pagemap)
> +				goto next;
>  
> -			pagemap_addr[i] = addr;
> +			num_local_pages += NR_PAGES(order);
>  		} else {
> -			dma_addr = dma_map_page(dev, page, 0, page_size(page), dir);
> -			if (dma_mapping_error(dev, dma_addr))
> -				return -EFAULT;
> -
> -			pagemap_addr[i] =
> -				drm_pagemap_addr_encode(dma_addr,
> -							DRM_INTERCONNECT_SYSTEM,
> -							order, dir);
> +			num_peer_pages += NR_PAGES(order);
>  		}
>  
> +		addr = dpagemap->ops->device_map(dpagemap, dev, page, order, dir);
> +		if (dma_mapping_error(dev, addr.addr))
> +			return -EFAULT;
> +
> +		pagemap_addr[i] = addr;
> +
>  next:
>  		i += NR_PAGES(order);
>  	}
> @@ -287,6 +281,60 @@ static int drm_pagemap_migrate_map_pages(struct device *dev,
>  	return 0;
>  }
>  
> +/**
> + * drm_pagemap_migrate_map_system_pages() - Map system or device coherent
> + * migration pages for GPU SVM migration
> + * @dev: The device performing the migration.
> + * @pagemap_addr: Array to store DMA information corresponding to mapped pages.
> + * @migrate_pfn: Array of page frame numbers of system pages or peer pages to map.
> + * @npages: Number of system or device coherent pages to map.
> + * @dir: Direction of data transfer (e.g., DMA_BIDIRECTIONAL)
> + *
> + * This function maps pages of memory for migration usage in GPU SVM. It
> + * iterates over each page frame number provided in @migrate_pfn, maps the
> + * corresponding page, and stores the DMA address in the provided @dma_addr
> + * array.
> + *
> + * Returns: 0 on success, -EFAULT if an error occurs during mapping.
> + */
> +static int
> +drm_pagemap_migrate_map_system_pages(struct device *dev,
> +				     struct drm_pagemap_addr *pagemap_addr,
> +				     unsigned long *migrate_pfn,
> +				     unsigned long npages,
> +				     enum dma_data_direction dir)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < npages;) {
> +		struct page *page = migrate_pfn_to_page(migrate_pfn[i]);
> +		dma_addr_t dma_addr;
> +		struct folio *folio;
> +		unsigned int order = 0;
> +
> +		if (!page)
> +			goto next;
> +
> +		WARN_ON_ONCE(is_device_private_page(page));
> +		folio = page_folio(page);
> +		order = folio_order(folio);
> +
> +		dma_addr = dma_map_page(dev, page, 0, page_size(page), dir);
> +		if (dma_mapping_error(dev, dma_addr))
> +			return -EFAULT;
> +
> +		pagemap_addr[i] =
> +			drm_pagemap_addr_encode(dma_addr,
> +						DRM_INTERCONNECT_SYSTEM,
> +						order, dir);
> +
> +next:
> +		i += NR_PAGES(order);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * drm_pagemap_migrate_unmap_pages() - Unmap pages previously mapped for GPU SVM migration
>   * @dev: The device for which the pages were mapped
> @@ -347,9 +395,13 @@ drm_pagemap_migrate_remote_to_local(struct drm_pagemap_devmem *devmem,
>  				    const struct drm_pagemap_migrate_details *mdetails)
>  
>  {
> -	int err = drm_pagemap_migrate_map_pages(remote_device, remote_dpagemap,
> -						pagemap_addr, local_pfns,
> -						npages, DMA_FROM_DEVICE, mdetails);
> +	int err = drm_pagemap_migrate_map_device_private_pages(remote_device,
> +							       remote_dpagemap,
> +							       pagemap_addr,
> +							       local_pfns,
> +							       npages,
> +							       DMA_FROM_DEVICE,
> +							       mdetails);
>  
>  	if (err)
>  		goto out;
> @@ -368,12 +420,11 @@ drm_pagemap_migrate_sys_to_dev(struct drm_pagemap_devmem *devmem,
>  			       struct page *local_pages[],
>  			       struct drm_pagemap_addr pagemap_addr[],
>  			       unsigned long npages,
> -			       const struct drm_pagemap_devmem_ops *ops,
> -			       const struct drm_pagemap_migrate_details *mdetails)
> +			       const struct drm_pagemap_devmem_ops *ops)
>  {
> -	int err = drm_pagemap_migrate_map_pages(devmem->dev, devmem->dpagemap,
> -						pagemap_addr, sys_pfns, npages,
> -						DMA_TO_DEVICE, mdetails);
> +	int err = drm_pagemap_migrate_map_system_pages(devmem->dev,
> +						       pagemap_addr, sys_pfns,
> +						       npages, DMA_TO_DEVICE);
>  
>  	if (err)
>  		goto out;
> @@ -437,7 +488,7 @@ static int drm_pagemap_migrate_range(struct drm_pagemap_devmem *devmem,
>  						     &pages[last->start],
>  						     &pagemap_addr[last->start],
>  						     cur->start - last->start,
> -						     last->ops, mdetails);
> +						     last->ops);
>  
>  out:
>  	*last = *cur;
> @@ -942,7 +993,6 @@ EXPORT_SYMBOL(drm_pagemap_put);
>  int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  {
>  	const struct drm_pagemap_devmem_ops *ops = devmem_allocation->ops;
> -	struct drm_pagemap_migrate_details mdetails = {};
>  	unsigned long npages, mpages = 0;
>  	struct page **pages;
>  	unsigned long *src, *dst;
> @@ -981,10 +1031,10 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	if (err || !mpages)
>  		goto err_finalize;
>  
> -	err = drm_pagemap_migrate_map_pages(devmem_allocation->dev,
> -					    devmem_allocation->dpagemap, pagemap_addr,
> -					    dst, npages, DMA_FROM_DEVICE,
> -					    &mdetails);
> +	err = drm_pagemap_migrate_map_system_pages(devmem_allocation->dev,
> +						   pagemap_addr,
> +						   dst, npages,
> +						   DMA_FROM_DEVICE);
>  	if (err)
>  		goto err_finalize;
>  
> @@ -1045,7 +1095,6 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  		MIGRATE_VMA_SELECT_DEVICE_COHERENT,
>  		.fault_page	= page,
>  	};
> -	struct drm_pagemap_migrate_details mdetails = {};
>  	struct drm_pagemap_zdd *zdd;
>  	const struct drm_pagemap_devmem_ops *ops;
>  	struct device *dev = NULL;
> @@ -1103,8 +1152,9 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  	if (err)
>  		goto err_finalize;
>  
> -	err = drm_pagemap_migrate_map_pages(dev, zdd->dpagemap, pagemap_addr, migrate.dst, npages,
> -					    DMA_FROM_DEVICE, &mdetails);
> +	err = drm_pagemap_migrate_map_system_pages(dev, pagemap_addr,
> +						   migrate.dst, npages,
> +						   DMA_FROM_DEVICE);
>  	if (err)
>  		goto err_finalize;
>  
> -- 
> 2.34.1
> 
