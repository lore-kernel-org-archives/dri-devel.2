Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB98410F995C
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 16:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E43410E6C0;
	Wed,  8 Apr 2026 16:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YpVFBSv/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C089810E6BE;
 Wed,  8 Apr 2026 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775666816; x=1807202816;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iUUiwBNCAw9pwCRPEd8AXxdTTyDNa8bcKke8Le8C6Kg=;
 b=YpVFBSv/FVK+JQ2k5pQv5QwA1id8f8x31H/kC9pNLcrHSQgurQ8A/+Pd
 g2whUTNolz5V86sH5apzaDP4vMBB4O9VNl0OE9WuuXO7zGMM9BSmKZUAn
 YLnFVgUBaZX1xts+UJVFDVXAUeOAFiy4Tb4dR3GeUerE79HwKbcXWZ2/Z
 ZC/T2dkGYLkDtkvVPc70ad+BpXbPzHZAZcGsfx0AUbvM8eYa9ZGSQ41bO
 oPv4Kb/rg4ME66iY60tL4NoNOs9jO4tWBVOg/TMnM8e8TixlErAcQOotq
 TuSjesiRE7FvaqxlPatOGSsC1MjbVMJimRXipTVT3utSwxQ4EuO5mpGXk g==;
X-CSE-ConnectionGUID: 4ZldJmVBR0WkgpO0kX4n4g==
X-CSE-MsgGUID: 7TcZ7D0nQai6wyud6NhyWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75694749"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="75694749"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 09:46:55 -0700
X-CSE-ConnectionGUID: Q8XchNXBTC6xWDAQZqG3sw==
X-CSE-MsgGUID: kiIANapJRXSbwrtaesWhrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="222001378"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 09:46:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:46:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 09:46:54 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:46:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTtDQYbxdMImD0bR2s7xXHNF62j6WlcoPIi36+lPMOxm7KStnm19jjj1NhqUxuw2UGyNggXzJvlTs7pg5bKKFNB4ZwrFI0N10uWAaHyOelquikDSEQcmXtdPEnogn+z1qV1eIRML/qvOdXUeN4Genq6GZgKRfFq32/h/aJ7CSxRzhg26moAAVmoAA3gQJJaVP8wQAuS43V/6es1GuKLx3/flYZVIhN4g8F4XvYkB9W8JYUmB0/uk4Bou39gtZ2odaTDio8yGUVawaFos7ei7nBTzeya6ypv4hwlCi1D8wTsuREYRQTaOm4kieK1qQl71kFUNAOYwn66DX4q1lr6vWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE+fAY6HGBd04o7oHdvtM4qkehfeG+IeT7H3ICghvM4=;
 b=TAGmWSaVE6xkmbX4UT13x9EAAx6jKdvtzsknfwrH75LtLyV8JNtvxMI7R+jxypICoohnYvaDyQHS7fsDzYG3IaCrnjIiQqNP10nbggdKQ5qT7CNI7In5jQVTcXeGP0+GABsq7tPIlYrIXNfDbEPmRA+mGppF9lsxMEO8w6XPOVO45h5BiapMMID2rIBbO7rt7G8hIij92FCvy9Iqs8VmMW9ITWAQ/JcUjKF5RT1z+6vKCZ3YQpk/qbo9Sgo4QvP69ghQMJ7gtrHlx9LEDEGAFNaSiPtOsYOcp0TKDqw0Aq332dvef7aEgbnbIgneOEYK3sgaHdUvxS0ztaEEhanRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by IA1PR11MB8829.namprd11.prod.outlook.com (2603:10b6:208:59b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 16:46:51 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 16:46:50 +0000
Date: Wed, 8 Apr 2026 09:46:46 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Francois Dugast <francois.dugast@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <leonro@nvidia.com>, <jgg@ziepe.ca>, <thomas.hellstrom@linux.intel.com>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH v5 5/5] drm/pagemap: Use dma-map IOVA alloc, link, and
 sync API for DRM pagemap
Message-ID: <adaGdp9W0+OJVK3K@gsse-cloud1.jf.intel.com>
References: <20260219201057.1010391-1-matthew.brost@intel.com>
 <20260219201057.1010391-6-matthew.brost@intel.com>
 <ac6SWbCDbBvRPbUj@fdugast-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac6SWbCDbBvRPbUj@fdugast-desk>
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|IA1PR11MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 4083f7b9-e7dc-49b6-423f-08de958e6e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 5wdmLVdK0o959grAtByQs1edN6rEi8cq7yFjQTb/H5nN4CorepG3vxKT9r00cPbpGYwh2W282p0Jxg7UbdWO5xSdsPZXFyih65G5THmkfNmH/s6zTicXXm7HmwEcVpQwfjJhpmHyurpi2DkRdmY9jM8srxf1h+52zczo0azorPSsb2jaa8Aq0o5EUvxfWDuctiNSWSVrmUEjifAt8/JGWj+hAK4sLW0DPPHwzF0F+vDIeS97JdbxHuAibz551pQVtm3bAgwOrYHwhnv1k0aaXpF9saxOZyW+0hs39pmk+zSiF8chP2xkYNnKLbVS6OMN9fMINvBZgJpyzJdlFa97tiAO+hIImKW3a/Cyo8HOSNNxsxi62HUZ0I6rtgDvVfT7Kh8b/6jQiQhgnQN2lkgHvkMpgaolm6ZdjqvXLSInuRMaXTAMZRRaCR9cywgtl7zuKvqMIqHwbZayh67sM+BbjPeSKkYycDtqcPU0mButa113iRvKfWdpUes1sGhwKP5ou4WsfgYCEs+6JNmlW8gRW7TmG/GDLcts+OLyb0uihVOZbohjfdnfDF2CdnFMxnQxwOX1xO3xCCtGcSGzHnvaUBjoVmOV1cqgahuCy8ASZ73J3vkUBEQubFGbcVJA8mO5tUHizV4Plog5xLBtBa49yfIqozR15AcFQI79/EdEZkHso3Kkn252O8imKh4Vp+ZMu83Qgy3o2gDup9Uut1EAtEtP8yELJ3EpZBWwIV12TXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XBVPNqOczONTOwKSaneUK2yilXnDyAS7uZ2tH6FyIssyO8HZFVnqQxZbQcwc?=
 =?us-ascii?Q?p8uz7k5gZIIvXbh+Ps9V6/zM9AyX+zNsVwf7OKzNGUmDFM7SnDRaZbN+32G8?=
 =?us-ascii?Q?1ALww8LmFyzmg6XSjOdUIeSVuZPefZz+VOvAXWrA2d30rzsEswA/4qhE5ztE?=
 =?us-ascii?Q?062sdIQDCRHaoP0Exm/Z842OzxznqDp0xl4wXBmJjaz/5v2FcDAYex/EnVqc?=
 =?us-ascii?Q?fAqMYgbWi8SpFf/z5KqfMKHU3oLlMTzoSpEAWOrbUyo1t/8A7pwePk9KM+H5?=
 =?us-ascii?Q?8NP9FIOQ6ua6ZUBCKCrqvgUoMtcahsv2kHTDbOoKJEio1Mg0x4dbf4b1EYXE?=
 =?us-ascii?Q?Yy7x53sVGdniOkgZedOmPPbnoXPomj2HBWNCArKxGqpQRUd1L86enhR6Znzg?=
 =?us-ascii?Q?P9bQP78JMenwBqrk8XTFtMVShwr7DfqUamvxueCGUabDf5BBXVTsXZOMvXV+?=
 =?us-ascii?Q?jOEqucanA/k/k7OwCWluLkGbEbre8AepPu/WJPnzc1ldETBnSt4qGASREOVq?=
 =?us-ascii?Q?rbEnrWsDmQ4jWMGFZQ2VdOzeCbzxN3oUZWsqQgxM6NwuiVaiLSd4MEtDd2lL?=
 =?us-ascii?Q?G9Kipay2maHA8jl2xcHsZVw8KBEwZ9PkwLWBA3WI7I1u/TQHPhFL9Jk+Iuno?=
 =?us-ascii?Q?oaXYRqkAByLWOXcvL1qVG7tL+MoWbcW4+8gQd6YuSqOLd4l75yXkc8WZREPx?=
 =?us-ascii?Q?Me/yNZusBFb5jVpBE7tCTsmL2OpEa0b4L9yRw6QV8yxjKYtGI+AgEp9ZcTe8?=
 =?us-ascii?Q?tmmtJBoWDBNAVTb4UQRQ5cil7pQigIeQgT530xVcF7DPf58rAqWNes4cxkv1?=
 =?us-ascii?Q?p6j3LSOEw2lnxMfoC+gonJ1wS/MyZPcAe0p+OfbNKrWq/0SpWWIM71+DCL3Z?=
 =?us-ascii?Q?SK0RUG49m1YXK4xCkLvHeyERbC9ldIgUdELegLVsT4gYI+V6f5fWz004Cu7/?=
 =?us-ascii?Q?8LimAXh0rPhiy0QyLRxnpBoupouiST8i68ezsZPLUY5AK7CuhH/YYXDX1H7w?=
 =?us-ascii?Q?VSuGTAyJAnOseGE36LVy8JNLKYqbAdYTHHApeIpV0uShNmdBI+VtbFKI0H2r?=
 =?us-ascii?Q?8SI5FKIw/z8LT3pSHV5PJTydzf+ZrnhKbqBaudT2canpgP6UudhjsMvWJdjT?=
 =?us-ascii?Q?KwE6tWTnV1EOn1W+X3C42PRJdqv0ouFM7tg9MIbbWODI4rb1JCBlosuo3yVp?=
 =?us-ascii?Q?UXq3ZEmSWdnZxizllfTTUo/+q0xTK45p0LvX4HiiGnyLUeDFPnKoa3rbHwp0?=
 =?us-ascii?Q?xzt5XioiZPadUvIieW6EkQfd3eM7QIjkZmBVy9csLDdcRuFYdEVdRCb6GHVR?=
 =?us-ascii?Q?CH6iP1WwfKEqseDDs1VZ4eWGUbFgW4Zfaibi/1vTj6YXryRwHZH0YBGpDSMp?=
 =?us-ascii?Q?gf1Ng+wW5DMjwTqxkp1kWPRZiRwfAxKFr5zy+lYafz5BWwHTPC3DTwCpcFAp?=
 =?us-ascii?Q?vGKM3Awjd9WFes6nXjRTe0omO30sg0ysszrMsEZlvRF4wpDic+5kAhFJIDqB?=
 =?us-ascii?Q?tFnoW/Tq1vx1OGv+d5LThwZtbUszdqlrEgiwXwk81jV92YBZtDcaS6lzUw7g?=
 =?us-ascii?Q?0YlWRrrgQkR7mdHrQCt+IJm+LAao7+kgwjkEWuoKeubObSxq0Br92eRXuM6P?=
 =?us-ascii?Q?4vlj6LqnpEfVpn0Tb96srvZExYPln3B/xEr9lyIGNS4jIoEDPZfW8XN1CnyL?=
 =?us-ascii?Q?4osFeoZP3tka4VWJ6FJ37hDV+N1/SfNHkRuzAVft2poou0XW2X21MPMq1m/Z?=
 =?us-ascii?Q?GlwZZ5TVCTIuKvWJk4jC8fafzH7IETE=3D?=
X-Exchange-RoutingPolicyChecked: J8JOOqRblP63Zf23RprCiJQ22xCznIphPkCU8Bo1A05gD+SmHn3KEAUWwmL572uD300XJZzO9m+KLgs9sK8F8mSCEm5TsPDlq8lc+NYTMnq2Jw6lzXd7+7zAkQEh153w2qVeY9/xJWy7TnBc9N2JONSY5PxB0i790/fE45cOP3UXOGfI+3A2Epr2B6/Xxwpz1nUFXl6nQAG5oEGDVwZCzSNqYJOkQ6UZQeB5SrGlVglOuoXT8WgnU9UHCoWQLHyaNWddLecj9WeTi3t0dTBGk3rLDbhX9slXw3cjfOuNsmIL7u/a/8TUcb74pbEI+TsNi4PmcEuNgNpHCjTEx7DKFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4083f7b9-e7dc-49b6-423f-08de958e6e1a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 16:46:50.0608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP0NVWtHbQbYoeJbuxSwFABOqqIvKfguxcQesycPR9jclSSUEa4VOSi770VmQN0LSQ2iMc4b3EMBnVNrnWz35Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8829
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

On Thu, Apr 02, 2026 at 05:59:21PM +0200, Francois Dugast wrote:
> On Thu, Feb 19, 2026 at 12:10:57PM -0800, Matthew Brost wrote:
> > The dma-map IOVA alloc, link, and sync APIs perform significantly better
> > than dma-map / dma-unmap, as they avoid costly IOMMU synchronizations.
> > This difference is especially noticeable when mapping a 2MB region in
> > 4KB pages.
> 
> Still a good improvement but with device THP now in drm-tip for GPU SVM,
> the speedup is less noticeable when looking at latency and throughput.
> 

Yes, it is less important with THP but 64k gets a speedup or memory gets
fragmented and THP allocation fails we will get a perf win.

> > 
> > Use the IOVA alloc, link, and sync APIs for DRM pagemap, which create DMA
> > mappings between the CPU and GPU for copying data.
> > 
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > ---
> > v5:
> >  - Remove extra newline (Thomas)
> >  - Adjust alignemnt calculation (Thomas)
> > ---
> >  drivers/gpu/drm/drm_pagemap.c | 83 +++++++++++++++++++++++++++++------
> >  1 file changed, 69 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> > index ef8b9c69d1d4..d9fceffce347 100644
> > --- a/drivers/gpu/drm/drm_pagemap.c
> > +++ b/drivers/gpu/drm/drm_pagemap.c
> > @@ -281,6 +281,19 @@ drm_pagemap_migrate_map_device_private_pages(struct device *dev,
> >  	return 0;
> >  }
> >  
> > +/**
> > + * struct drm_pagemap_iova_state - DRM pagemap IOVA state
> > + * @dma_state: DMA IOVA state.
> > + * @offset: Current offset in IOVA.
> > + *
> > + * This structure acts as an iterator for packing all IOVA addresses within a
> > + * contiguous range.
> > + */
> > +struct drm_pagemap_iova_state {
> > +	struct dma_iova_state dma_state;
> > +	unsigned long offset;
> > +};
> > +
> >  /**
> >   * drm_pagemap_migrate_map_system_pages() - Map system or device coherent
> >   * migration pages for GPU SVM migration
> > @@ -289,6 +302,7 @@ drm_pagemap_migrate_map_device_private_pages(struct device *dev,
> >   * @migrate_pfn: Array of page frame numbers of system pages or peer pages to map.
> >   * @npages: Number of system or device coherent pages to map.
> >   * @dir: Direction of data transfer (e.g., DMA_BIDIRECTIONAL)
> > + * @state: DMA IOVA state for mapping.
> >   *
> >   * This function maps pages of memory for migration usage in GPU SVM. It
> >   * iterates over each page frame number provided in @migrate_pfn, maps the
> 
> Not visible in this diff but we should update the doc as the return value is
> not only 0 or -EFAULT, it can be any error code returned by dma_iova_link().
> 

Will fix.

> > @@ -302,9 +316,11 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
> >  				     struct drm_pagemap_addr *pagemap_addr,
> >  				     unsigned long *migrate_pfn,
> >  				     unsigned long npages,
> > -				     enum dma_data_direction dir)
> > +				     enum dma_data_direction dir,
> > +				     struct drm_pagemap_iova_state *state)
> >  {
> >  	unsigned long i;
> > +	bool try_alloc = false;
> >  
> >  	for (i = 0; i < npages;) {
> >  		struct page *page = migrate_pfn_to_page(migrate_pfn[i]);
> > @@ -319,9 +335,31 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
> >  		folio = page_folio(page);
> >  		order = folio_order(folio);
> >  
> > -		dma_addr = dma_map_page(dev, page, 0, page_size(page), dir);
> > -		if (dma_mapping_error(dev, dma_addr))
> > -			return -EFAULT;
> > +		if (!try_alloc) {
> > +			dma_iova_try_alloc(dev, &state->dma_state,
> > +					   (npages - i) * PAGE_SIZE >=
> > +					   HPAGE_PMD_SIZE ?
> > +					   HPAGE_PMD_SIZE : 0,
> > +					   npages * PAGE_SIZE);
> > +			try_alloc = true;
> > +		}
> > +
> > +		if (dma_use_iova(&state->dma_state)) {
> > +			int err = dma_iova_link(dev, &state->dma_state,
> > +						page_to_phys(page),
> > +						state->offset, page_size(page),
> > +						dir, 0);
> > +			if (err)
> > +				return err;
> > +
> > +			dma_addr = state->dma_state.addr + state->offset;
> > +			state->offset += page_size(page);
> > +		} else {
> > +			dma_addr = dma_map_page(dev, page, 0, page_size(page),
> > +						dir);
> > +			if (dma_mapping_error(dev, dma_addr))
> > +				return -EFAULT;
> > +		}
> >  
> >  		pagemap_addr[i] =
> >  			drm_pagemap_addr_encode(dma_addr,
> > @@ -332,6 +370,9 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
> >  		i += NR_PAGES(order);
> >  	}
> >  
> > +	if (dma_use_iova(&state->dma_state))
> > +		return dma_iova_sync(dev, &state->dma_state, 0, state->offset);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -343,6 +384,7 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
> >   * @pagemap_addr: Array of DMA information corresponding to mapped pages
> >   * @npages: Number of pages to unmap
> >   * @dir: Direction of data transfer (e.g., DMA_BIDIRECTIONAL)
> > + * @state: DMA IOVA state for mapping.
> >   *
> >   * This function unmaps previously mapped pages of memory for GPU Shared Virtual
> >   * Memory (SVM). It iterates over each DMA address provided in @dma_addr, checks
> 
> While we are here: s/@dma_addr/@pagemap_addr/
> 

Will fix.

Matt

> Francois
> 
> > @@ -352,10 +394,17 @@ static void drm_pagemap_migrate_unmap_pages(struct device *dev,
> >  					    struct drm_pagemap_addr *pagemap_addr,
> >  					    unsigned long *migrate_pfn,
> >  					    unsigned long npages,
> > -					    enum dma_data_direction dir)
> > +					    enum dma_data_direction dir,
> > +					    struct drm_pagemap_iova_state *state)
> >  {
> >  	unsigned long i;
> >  
> > +	if (state && dma_use_iova(&state->dma_state)) {
> > +		dma_iova_unlink(dev, &state->dma_state, 0, state->offset, dir, 0);
> > +		dma_iova_free(dev, &state->dma_state);
> > +		return;
> > +	}
> > +
> >  	for (i = 0; i < npages;) {
> >  		struct page *page = migrate_pfn_to_page(migrate_pfn[i]);
> >  
> > @@ -410,7 +459,7 @@ drm_pagemap_migrate_remote_to_local(struct drm_pagemap_devmem *devmem,
> >  			       devmem->pre_migrate_fence);
> >  out:
> >  	drm_pagemap_migrate_unmap_pages(remote_device, pagemap_addr, local_pfns,
> > -					npages, DMA_FROM_DEVICE);
> > +					npages, DMA_FROM_DEVICE, NULL);
> >  	return err;
> >  }
> >  
> > @@ -420,11 +469,13 @@ drm_pagemap_migrate_sys_to_dev(struct drm_pagemap_devmem *devmem,
> >  			       struct page *local_pages[],
> >  			       struct drm_pagemap_addr pagemap_addr[],
> >  			       unsigned long npages,
> > -			       const struct drm_pagemap_devmem_ops *ops)
> > +			       const struct drm_pagemap_devmem_ops *ops,
> > +			       struct drm_pagemap_iova_state *state)
> >  {
> >  	int err = drm_pagemap_migrate_map_system_pages(devmem->dev,
> >  						       pagemap_addr, sys_pfns,
> > -						       npages, DMA_TO_DEVICE);
> > +						       npages, DMA_TO_DEVICE,
> > +						       state);
> >  
> >  	if (err)
> >  		goto out;
> > @@ -433,7 +484,7 @@ drm_pagemap_migrate_sys_to_dev(struct drm_pagemap_devmem *devmem,
> >  				  devmem->pre_migrate_fence);
> >  out:
> >  	drm_pagemap_migrate_unmap_pages(devmem->dev, pagemap_addr, sys_pfns, npages,
> > -					DMA_TO_DEVICE);
> > +					DMA_TO_DEVICE, state);
> >  	return err;
> >  }
> >  
> > @@ -461,6 +512,7 @@ static int drm_pagemap_migrate_range(struct drm_pagemap_devmem *devmem,
> >  				     const struct migrate_range_loc *cur,
> >  				     const struct drm_pagemap_migrate_details *mdetails)
> >  {
> > +	struct drm_pagemap_iova_state state = {};
> >  	int ret = 0;
> >  
> >  	if (cur->start == 0)
> > @@ -488,7 +540,7 @@ static int drm_pagemap_migrate_range(struct drm_pagemap_devmem *devmem,
> >  						     &pages[last->start],
> >  						     &pagemap_addr[last->start],
> >  						     cur->start - last->start,
> > -						     last->ops);
> > +						     last->ops, &state);
> >  
> >  out:
> >  	*last = *cur;
> > @@ -993,6 +1045,7 @@ EXPORT_SYMBOL(drm_pagemap_put);
> >  int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
> >  {
> >  	const struct drm_pagemap_devmem_ops *ops = devmem_allocation->ops;
> > +	struct drm_pagemap_iova_state state = {};
> >  	unsigned long npages, mpages = 0;
> >  	struct page **pages;
> >  	unsigned long *src, *dst;
> > @@ -1034,7 +1087,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
> >  	err = drm_pagemap_migrate_map_system_pages(devmem_allocation->dev,
> >  						   pagemap_addr,
> >  						   dst, npages,
> > -						   DMA_FROM_DEVICE);
> > +						   DMA_FROM_DEVICE, &state);
> >  	if (err)
> >  		goto err_finalize;
> >  
> > @@ -1051,7 +1104,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
> >  	migrate_device_pages(src, dst, npages);
> >  	migrate_device_finalize(src, dst, npages);
> >  	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
> > -					DMA_FROM_DEVICE);
> > +					DMA_FROM_DEVICE, &state);
> >  
> >  err_free:
> >  	kvfree(buf);
> > @@ -1095,6 +1148,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
> >  		MIGRATE_VMA_SELECT_DEVICE_COHERENT,
> >  		.fault_page	= page,
> >  	};
> > +	struct drm_pagemap_iova_state state = {};
> >  	struct drm_pagemap_zdd *zdd;
> >  	const struct drm_pagemap_devmem_ops *ops;
> >  	struct device *dev = NULL;
> > @@ -1154,7 +1208,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
> >  
> >  	err = drm_pagemap_migrate_map_system_pages(dev, pagemap_addr,
> >  						   migrate.dst, npages,
> > -						   DMA_FROM_DEVICE);
> > +						   DMA_FROM_DEVICE, &state);
> >  	if (err)
> >  		goto err_finalize;
> >  
> > @@ -1172,7 +1226,8 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
> >  	migrate_vma_finalize(&migrate);
> >  	if (dev)
> >  		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
> > -						npages, DMA_FROM_DEVICE);
> > +						npages, DMA_FROM_DEVICE,
> > +						&state);
> >  err_free:
> >  	kvfree(buf);
> >  err_out:
> > -- 
> > 2.34.1
> > 
