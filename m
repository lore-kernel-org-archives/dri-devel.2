Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0402DD3940E
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B60310F215;
	Thu,  2 Apr 2026 10:33:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VrsFrxz+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080C810F213;
 Thu,  2 Apr 2026 10:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775126031; x=1806662031;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xAbVO8TyU8C35jD2ddiS8SA1uxEHa6W6QTH8yawcOsI=;
 b=VrsFrxz+ahaxHxzEQxw+p51b/dJjIZhwkkbvZE5y+bYRh4ccWj98gPX3
 550DzYwiDa+tNM4y5YRbh7RrU7XbfHfiEFBR2ktbn+5/w9sJftS8Z2ac1
 BlDo7yPXvYBl5LvKtBhkt760RTCjAHu4dpS6ZHg8stUTDXmierjpfNAqk
 x+ClIgZ9IGPC33+2UaesBrVxC3WMiUyce79gkHi3iGYbqofVQwrylkN/4
 zXahM3trG/AU9MqtBNy+G0ybjrIGavl8w7T3t+P5rlCzM/LZ6Y9Ve6k0k
 9JplXsfDBrfzzLQoR8qZOVbzMblWPy3NrQURwsPHwTyewxxoSIzaC18MU A==;
X-CSE-ConnectionGUID: F7f7Z59+R/qLASTII8VFRQ==
X-CSE-MsgGUID: enAkSF/+TIO1YGFHutxjUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="101634838"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="101634838"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 03:33:51 -0700
X-CSE-ConnectionGUID: XB+BGBaCRr+QtrjMT1Fs0Q==
X-CSE-MsgGUID: P/qK+txzStKTXguRABUBbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="226917667"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 03:33:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 03:33:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 03:33:49 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 03:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7nwvpwmF30MD6E0f2VEkxSDFKlx9nzi9ldJTZip6dc9FFwV8t5Y7cHYGvjRB9XUrBIMdQof8ATf/z+e4BvcntaMY/1lu6+VMpJOLAY6ZrdnSsWxss0M1frbSbI807TOOE+nBBJmVUpmQXtSTzgPX0/iznVhpNamNS7jHKWa9qy6mvheUggJBQWsJb++YlPJcvkuWScDT63H8I0/vUhBivU58vefsVHaSTSShOp1GqUHQB/XHNW50mTpqvj2o2b3Ddy8kcOq3wCZdl+Jym7B6lGzec7jzRYyU3B+VdrwIQH6sLJGVnysn4dVs+fM5G94/YSSi3grTFt5B6q2S9QZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv/ceBtjLZZOTLXsUfYey+EXIw11C/chXkf2CTHGJtk=;
 b=l1bFe7Syxu+mutopOvu+fyj/+63goZcUgxbhVwJwnah5i7gHq1TDC9iEPfOw6ZO6OHqjpHMTmH12kgQ0JMeA8NutEYJzUn/V+xgcjH2URrJvr5X1PWzwldBBZOZj7Puehq1gM6WoOarSuZsa/4O/vDEFmEQ0QFP4xVXEQf0nRUclul5VEgXpO1e6Hky3/k7rqn6E1rS7CGWFqleS+9ulZ+TkJWe36wiq1L6wEASnfJUksRNR7aKlDPzUi8xKzT/888z8h0zb69SLHs2MkLO+pp35r6uFBXcvMSrYgxenRxou+kbluAATx56MCmZTeKwJFrok8EKljRoc01/JCdH45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7838.namprd11.prod.outlook.com (2603:10b6:208:402::12)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 10:33:42 +0000
Received: from IA0PR11MB7838.namprd11.prod.outlook.com
 ([fe80::9123:8c3b:893f:5196]) by IA0PR11MB7838.namprd11.prod.outlook.com
 ([fe80::9123:8c3b:893f:5196%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 10:33:42 +0000
Date: Thu, 2 Apr 2026 12:33:34 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <leonro@nvidia.com>, <jgg@ziepe.ca>, <thomas.hellstrom@linux.intel.com>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH v5 3/5] drm/pagemap: Drop source_peer_migrates flag and
 assume true
Message-ID: <ac5F_oLmMeFwrWc0@fdugast-desk>
References: <20260219201057.1010391-1-matthew.brost@intel.com>
 <20260219201057.1010391-4-matthew.brost@intel.com>
 <aZd4OfBJyMepd4Of@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aZd4OfBJyMepd4Of@lstrano-desk.jf.intel.com>
Organization: Intel Corporation
X-ClientProxiedBy: DU6P191CA0043.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::29) To IA0PR11MB7838.namprd11.prod.outlook.com
 (2603:10b6:208:402::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7838:EE_|IA0PR11MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a83e8c-c522-4398-10cc-08de90a34f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: r48kmePE7B9bYGBorBeDT4BNuJYjHpxUcMpG9K5BrScE1GbewdXfS1XNFS0aAjSIJyOqrkFCIM5wNqOHruXNG31XYfzTb6lOHuFBawd6da/FdVRgQIulVmDPcFX6u0dMQ2RjkkLVUDVY0yI9AUleRiLA0MHwViOJ/5mwZu0s3UNYWzZmYdqbM8TqTpjtn54r9wtaKBa+ZfTQKp54zTnWOWSL/nckLmqoN4nP+LNI/KV51XZSKeEsHt1I/Dro3wEVjpBAlu02JMAvdS1X6t6ynZSaPIR71d1hmzE+X31u0ZH49myfj91TEDglai0HtvoJwfGoyeSWhcoDccND/Ng2C7ta2PirVvHdVoMGkKH5kIrgAkW3u8z6Fh5XWBcExoVLrWOUeFF9V1eCY66lVARR4AcZkZ69e7bJj9hYE+TnObROjUXIu4vbQVb/Z/7nXjHoYnhg6Y1c9HSD0ll8RJ1dOVosE/wsHV3NJiyHw6WWARfwclhJzfMEcjlgtNlIYADXaJBmbybKi8elZADhXI16Ua/Ur2WwUBAN4ne3knifCXb3MlS+ByyFN2nGoCr9kjEcfodiMqa3woiYraEU8NVz5zy9qgc2YJz4c/YuZGpo1bA5LX3P6q+m4JZEzvSJtEuw0YndhOohdCaL7Ef4/SbFen0xd7CLGC9AE+wN1cCvvUU3TG6nr0L6IlpXW58OjqjkJJ7RXdWvG7kIQSNP+M2dSldlqit0qvEiWXtGgEXMn3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7838.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2EDiC14KythCcp/wSL7fvmrx3rKdpjmO18C5ZmRPFu+6d6LFOimHnzXZ0h7w?=
 =?us-ascii?Q?uF+JFSPHzkelvLu1eWMxBvoeVNJ4hI+1BQcZlENoRc9gSToMM5aWQkzKBfDo?=
 =?us-ascii?Q?M3/0JBw0/JXjDevzSxJ8R1jYFUExcPPPYYg4Y/8CvdOYQ6OxyVucq1KpjcOi?=
 =?us-ascii?Q?YKC/HMi/9erIO3A2+TrdA65fgzCdWYwNH6ZTFXHqwe+YMdOk/ZpVJoOOuuJs?=
 =?us-ascii?Q?ZkIPqcB02KkhrKkqIQulyUlFgA0Im8ngwxXNn4jnkr/0Teklhs+oicZenGTF?=
 =?us-ascii?Q?JOTsa+u3hqqRsU0wJ8F05rPvBuAiH+2ZmXM/InQ1UrAhUVh8FW6HHhLtoKE4?=
 =?us-ascii?Q?BkP1aileilinzHk7oBnpCS5laldPU2fpO4diU9tv16mWQAgfaFeOwkITxBwV?=
 =?us-ascii?Q?xK55EyhJZnMgY4ud4AmEMY3+Q4ktLtq5+mtOxUjcR6k2lZuqWv13r7eIczbt?=
 =?us-ascii?Q?rcGqqPa+fkxmf4Vdg7RElskj4C7WLDtDjpGsRAabUpeCmsfqzZ81vUYo+S1T?=
 =?us-ascii?Q?pkWcjqeDSfQVu6v36QRGTeWYFQzHgmbHfzGyYaCCdOAq0SxRYbUKF3AsU1NO?=
 =?us-ascii?Q?WMD4zTCFkRhGDjwy0V6XcHWJ0PQuUdYlUYVNFxJVtvpSBqLlZ1SHXCrtwbjq?=
 =?us-ascii?Q?AfLvrSjgk4r/JJb/YGIEYkuuKM/pe83waSEaDGHTxBYmux6lbHG5g6Im7Ffc?=
 =?us-ascii?Q?okGPj+XGSb/hGzQL6eCmYyLHL5zbdW5cNlCXT6+pPMIXPJhGyzdh1gyWFGis?=
 =?us-ascii?Q?xkKt0VYK0s+3QM9vQodsXELZ1GhpA/ZX/LQo7xh4hG24WGgGHB481lp0tS+X?=
 =?us-ascii?Q?4i3NNsXuYNLGR9WigNn+lpQhxy1UfHIJipNlW2b/D2HmOjhTqoyErTPlHF6O?=
 =?us-ascii?Q?g/3buDRbp0XNdq7g4pQfXCPUB0p1pSVtfB92QS1DyDbkjV7bBq569RPnrQL3?=
 =?us-ascii?Q?G4lNpPXm4b4SSlzsyvsr2Pi2gfEFPyZguDwu0wGHvXVrtTaYgM99vhHY32QH?=
 =?us-ascii?Q?rcnPgWkRrxI8uCHgpzXcXGCG60PaMRYIMxJbsCMX8cyEHhzzEQxFHl5ET/ZA?=
 =?us-ascii?Q?VUGiUPR8Ju8e+lcOUrK4JZVQEvMLm/AHeZjHQFbwjefl+KRpFUyyuTXY6RFw?=
 =?us-ascii?Q?MEC9EjqmUdwcAAavoc78AIFLGDhLdFwO4InHKZU6DgDHLCPG9fxtiifyOlXr?=
 =?us-ascii?Q?HDz6GG8DoIRnGlyofmqgDyjBMHITL+8yn6S0trvyluu25SePITYOYkqIUHkI?=
 =?us-ascii?Q?hvx7VATD4PQ95lm8fUXn2Cjjcqg8BMu06HMB8VABzGqfdmosuOaPjzHcSXmW?=
 =?us-ascii?Q?SscRzYrAjb7Ii5wL2kX8izUGwFtLfGPUJfb2heZK4rpk6h/lTpgSoFqwxunU?=
 =?us-ascii?Q?SKRakgVgMOnsaKaAi7PRZPtO3MINyYe63ESTlStkztDF3xnes46hOlrVrX13?=
 =?us-ascii?Q?jXnEaJUSBsbKhB9587mVMz8/TcSwmXkPhJaDKV6JPGtOqfz3QWHLD59fm+NW?=
 =?us-ascii?Q?xI+vFrtSPrfJj5mS98SC7iB55nl3bD8iIxw7OT6b40WHuQkUpPQohYHPAbQg?=
 =?us-ascii?Q?uFHGouWjZ9n0+wZizDSc38Pm/lLB6beiXn4F9NWlEBTc6P60+plNRdBvCkzt?=
 =?us-ascii?Q?t1wVbXagLpQWWZ8iQ5GSam3rWm+RsgtF9eIrYmv6qlzujvQEHJmpzWP0mk4g?=
 =?us-ascii?Q?P06ukTuRNYBiUBzwczKx0jzAMIRzoFFn4R9A5dD2FgSZeADgZuivQ4hJeDoD?=
 =?us-ascii?Q?wWVnHk2ljugER58egc06pGKR3nKoC04=3D?=
X-Exchange-RoutingPolicyChecked: o+M9QgZ4wSy9j9fG52IPcQNI2ZM6OJzHZNgrZhmz6SZ2Bym/ThO4IT0knO6xSYSFs25+2lxYvMownURmt497r3J5i9ZP6UWjQSeAGH62rnhY4r43TMmh+jL5FY3bhWQ6uKQna8BJdxiO3YgbuMR5DC+9V9W1NrGjwTugs8OsBBr/G6fotHp3Yj/yQrvXRl2Q4b20Jh3EoFeqWsOeC81jQ6UEV7sX9FTROjssua07+4PVkWVUmi1MIeOyTl1OMyUibL0kNUNw9I3jcZBfxvSlsEr9PrPyabC0PaTizj6rnR33tFwZqVuYiwfTnQ501ZaZSS2dQVApbAWqdcC0QqGuVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a83e8c-c522-4398-10cc-08de90a34f82
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7838.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:33:42.4715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUyvqSryND5fEG0hBoCAdebIDvWCxXLXfF2L0dSLzkfD4UKmVOnp+Y0FaHCcCi2XGjuAsz7oO/t6UH8eVc2DuKilmNM24bxnvqhVHm1gSpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
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

On Thu, Feb 19, 2026 at 12:53:13PM -0800, Matthew Brost wrote:
> On Thu, Feb 19, 2026 at 12:10:55PM -0800, Matthew Brost wrote:
> > All current users of DRM pagemap set source_peer_migrates to true during
> > migration, and it is unclear whether any user would ever want to disable
> > this for performance reasons or for features such as compression. It is
> > also questionable whether this flag could be made to work with
> > high-speed fabric mapping APIs.
> > 
> > Drop the flag and make DRM pagemap unconditionally assume that
> > source_peer_migrates is true.
> > 
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  drivers/gpu/drm/drm_pagemap.c | 10 ++++------
> >  drivers/gpu/drm/xe/xe_svm.c   |  1 -
> >  include/drm/drm_pagemap.h     |  8 ++------
> >  3 files changed, 6 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> > index 01a06d1fd1a0..32535ab01c0f 100644
> > --- a/drivers/gpu/drm/drm_pagemap.c
> > +++ b/drivers/gpu/drm/drm_pagemap.c
> > @@ -602,12 +602,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
> >  				own_pages++;
> >  				continue;
> >  			}
> > -			if (mdetails->source_peer_migrates) {
> > -				cur.dpagemap = src_zdd->dpagemap;
> > -				cur.ops = src_zdd->devmem_allocation->ops;
> > -				cur.device = cur.dpagemap->drm->dev;
> > -				pages[i] = src_page;
> > -			}
> > +			cur.dpagemap = src_zdd->dpagemap;
> > +			cur.ops = src_zdd->devmem_allocation->ops;
> > +			cur.device = cur.dpagemap->drm->dev;
> > +			pages[i] = src_page;
> >  		}
> >  		if (!pages[i]) {
> >  			cur.dpagemap = NULL;
> > diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> > index c96ed760c077..e86e69087c7e 100644
> > --- a/drivers/gpu/drm/xe/xe_svm.c
> > +++ b/drivers/gpu/drm/xe/xe_svm.c
> > @@ -1027,7 +1027,6 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
> >  	struct xe_pagemap *xpagemap = container_of(dpagemap, typeof(*xpagemap), dpagemap);
> >  	struct drm_pagemap_migrate_details mdetails = {
> >  		.timeslice_ms = timeslice_ms,
> > -		.source_peer_migrates = 1,
> >  	};
> >  	struct xe_vram_region *vr = xe_pagemap_to_vr(xpagemap);
> >  	struct dma_fence *pre_migrate_fence = NULL;
> > diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> > index 72f6828f2604..5c33982141c2 100644
> > --- a/include/drm/drm_pagemap.h
> > +++ b/include/drm/drm_pagemap.h
> > @@ -329,12 +329,8 @@ struct drm_pagemap_devmem {
> >   * struct drm_pagemap_migrate_details - Details to govern migration.
> >   * @timeslice_ms: The time requested for the migrated pagemap pages to
> >   * be present in @mm before being allowed to be migrated back.
> > - * @can_migrate_same_pagemap: Whether the copy function as indicated by
> > - * the @source_peer_migrates flag, can migrate device pages within a
> > - * single drm_pagemap.
> > - * @source_peer_migrates: Whether on p2p migration, The source drm_pagemap
> > - * should use the copy_to_ram() callback rather than the destination
> > - * drm_pagemap should use the copy_to_devmem() callback.
> > + * @can_migrate_same_pagemap: Whether the copy function can migrate
> > + * device pages within a single drm_pagemap.
> 
> I forgot to delete this variable, in effort to save CI cycles, will fix
> this in next rev or when merging.

With source_peer_migrates removed:

    Reviewed-by: Francois Dugast <francois.dugast@intel.com>

> 
> Matt 
> 
> >   */
> >  struct drm_pagemap_migrate_details {
> >  	unsigned long timeslice_ms;
> > -- 
> > 2.34.1
> > 
