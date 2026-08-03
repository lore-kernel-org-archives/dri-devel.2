Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC26CC55822
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24CE910E04C;
	Mon,  3 Aug 2026 17:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZgDYAaJl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE62710E04C;
 Mon,  3 Aug 2026 17:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785779706; x=1817315706;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ZbY2ZzqEGuTn6H3FNaabR8JlydwDX5TXBrJB/cbclNA=;
 b=ZgDYAaJlyVbbeb88CSNF7DKSZWDWnbBvoSArBW/0/T8aaC4oxYv5U7zO
 yglPmrf4Sv2iy3RwusiSNqkucGU5KZTeo5bDAB+PFyTPRRwzdfbFKCZ3x
 4MgoNC29cyT/1zxmrYuo0KWwzN3HqfQDR72JnYnVQNjzkO5G9YqTNzmJX
 fT68jiTBkyoLPYQus/ZA90p+Xs8zCl+cXzKEZ0hmUwgo2laGxqtBf0s9a
 /Edg5MOQvLNwXjkhCSBSqcxRcfl8ALaQONRmxpx1ES8PkcTX6K4V9MuC6
 EOwjqrPMeaiBRwueNwGnSnGqf8f9UiqI6/4jAtOiSO3xPSYSXDVddl2Aw Q==;
X-CSE-ConnectionGUID: OMEP31NESx2XJ0M+gXT2QA==
X-CSE-MsgGUID: PtoUf8x5RS66+aT482bSmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86358066"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="86358066"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 10:55:05 -0700
X-CSE-ConnectionGUID: YgGYRMypT3a8rRQWpmTcMQ==
X-CSE-MsgGUID: h17cqf0PQ1q0mlehYwS3+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="261348566"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 10:55:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 10:55:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 10:55:04 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 10:55:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovtRRruvL49H5XVFy2OyHb8QidDhgGrlEfOy5ZOzoBgTtrBv3hFMA41oCT7gsqJ9tUJEm4yf0NACZHFuMIFQOA+km9mBcZ3rAp+LRIVCVdY0U9m5Bk31RGlujVISS3K9iZCenJwwy4UEPsokRjYpCtibbQ2quGEItsstH36fe+ZxLdSwoeOI5Wes6211Me1rv1XwkxpvC8UGVzLvxEO44J2nnxZtD9eIloggLetiTi7ag+BeSFc0XnzZDlX4vhY/YOOl6TBnzA8egLhpNI5FbaUNudIncV7vFO9cX019kE4u28B0ezND9VFHfCy7V8NEcaNaiaUQ/4uHBDMB+MHVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JlQV7f2ZX3t8BQxB9KtZyxsoh0he4ibOBnqytJbJ/I=;
 b=dsd55ZS/HjIpEMccjrqlWUIdmd4qOKSYLB69ZtA6p1C+SIv04ckhaulda8sns0oUMvO7PXuel6e3aoFc31Qjv8sayTDPAUwiXqe9vIR3G8uic0cX2H9rB1zN++3Bx+dHmonM0qP0yVQTtXt6b2Bps1RO/B3e00f+QbzShIk8ecifP3sZnIW9d74caJaJU2tKKaNIb3vPfg0r5rYTKNPGhPqHqBzh+7jjgsjk164F97Xq8kN8+sGnFm1kGYLJSAushS3sy/GfkmWGtjc/f134GWlUYAzTU97Rw9uBh4rcekqES8blmeVtaGq8eEcTxJXEnbs1/29Sy6tadAHwkMTMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CO1PR11MB4996.namprd11.prod.outlook.com (2603:10b6:303:90::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 17:55:02 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 17:55:02 +0000
Date: Mon, 3 Aug 2026 10:54:59 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <thomas.hellstrom@linux.intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH] drm/pagemap: Prevent double migration of device pages
Message-ID: <anDV8wqPd8G8rIW/@gsse-cloud1.jf.intel.com>
References: <20260803092553.4117408-1-arvind.yadav@intel.com>
 <anDT86fV1Xbq6fkc@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anDT86fV1Xbq6fkc@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0337.namprd04.prod.outlook.com
 (2603:10b6:303:8a::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CO1PR11MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4dfebd-8c68-4a84-3660-08def18857a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|4143699003|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: OsNFaSKsOrxYpHHEuhBn455t6huw/XAQ7FHH5uONcqBaOpRQ+kZQXY1NDoKGTdZqaA2WedW32ELZX5z5ZIi2plosQe4qvTYmFtW/dh0Ayvf+nhtII4UrBxPsIz8rerliV2rcVMyurdAttNGnZji6Zx1agx2EgLbdLivID1PhKbUVK9cO4/LCVi4ZsJhrDuFlzxpvNzo0ePT+CGQaCw6nI7w9tFOhUcg86yCl833xNsEpShCX+MreWCnu1WGhAlbcCDGGTisxggPz5eg8Lc3eLGDZ2k7zRoEFTyTJYKUlQPB//UZUhacYvuh2v888T62h81ZlMvGCJvYu0WqjHlSZnJ37uZfhzLivhh5E/BNOqRF7Tl3DgFmoWJxYQVw86hCiTbdjgr9fqBaLwjiakEGemXK7wu+fcO13CcUsN9ARDLU6iRjUWkyXyykAu57kvWKos9p+C+iuxwlTSG9XT3A46Eh1OrNUZ1BFDXo/qWiUrJ/W6dyGDuKyBYdFUf/OSmAloscBpRu3hY33W8vWDyG9cQx1pa86G2Fha+1hnyhrJWJ/6pUKQ5iyojkuQnREA6M3zalS6PEuZBfBhMqK5wc0WQC9jxuCxanKMIVms4rHve5oBJKLyJgu1SKXQkfgvfls8j1bXHQMXpXt4BicKjvTu3mRUnHdlL1wzJxRmBDgYH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HeoirYkWEYz06lnCOs5hBV/1AI3jgAdNsCF5aTUjsmy4KTHhWEnxPYLSxs?=
 =?iso-8859-1?Q?Wjo9JRSKqD7SvYWsS+fnU/v8osgarXsMWWI3Sj59R7+NPA8jn0keHdDq6y?=
 =?iso-8859-1?Q?2SWrDbcAZDB3arVsfIldaDDPcpkSYRC41zfU82BCmJclunp7fHith/T/mf?=
 =?iso-8859-1?Q?GbHSkPxztwD+6qW+v8Iq7tqPzlPkT3F2KQIZvsb3C9kOJbRI7hYID87Ikh?=
 =?iso-8859-1?Q?vvL7Jj01QUORKDVutJt7hzjndYRpRTiTkSazOyH2Tc5Exej8cVh8JCX80H?=
 =?iso-8859-1?Q?efgs9ZfY0E941slPvjCyJHlN+ughn6DtY5Zviyk8tU76nQo6SqNSQGD2Yl?=
 =?iso-8859-1?Q?TAMidl9CjpKYaqv72t34SFq1c3PAvAGFce+v+/IAXU8MPsoRhkBCTjdNpj?=
 =?iso-8859-1?Q?eEhFUftdSLQeBXKXqiC9kXT/cXEBT7uq20t4hnyF4hPqVKr32a0YvHI/bT?=
 =?iso-8859-1?Q?+v9ji9u2Ybhd7EBnOmoDiUN1tMwgvXV9UaZaorFl4sMGR2m39kUSuPp0xF?=
 =?iso-8859-1?Q?wxXhjr6f7aKRWJ7P4CUcbN/KlydPbTPtyjglE88Xzf6/fN30nlyutQIlq+?=
 =?iso-8859-1?Q?4lG7PzbC+UljklO5Oz+yV45yOayF47Fd5pRs+5WLzQjsqHKY/KoxDFhIhx?=
 =?iso-8859-1?Q?Y1gqcnKXg4pvoO4OEp+AG+lEm7qO74iaRQu6BjV64Z1LZepOwTMK+VrK6O?=
 =?iso-8859-1?Q?E485u0idZdq4OwJn1jDlm6kWqehvhcTj4Qre1vPLHHrbfLGy/2QMOTZ6Vo?=
 =?iso-8859-1?Q?3UEInIkjj39z/6ZNUXDdz/ycsRMqPhWVampReLtrRiwBLU1NOcSKAKva71?=
 =?iso-8859-1?Q?7ODvffU1ZdSRFGv5PKym8EAerFnPOHOEjsXn8SabpwEXJAuH1zLnqJurGt?=
 =?iso-8859-1?Q?SntxgY4/sQEMTuXc9fsrzpmmx2nn6Uc3U72X2Y1/QEv6/vtCWPGMJnXLYw?=
 =?iso-8859-1?Q?dRcipuCqfDmni7O+Di+4iy2iASWzQAg3R9EJPpvzIFfxj79xiEjmRu88VT?=
 =?iso-8859-1?Q?Cjvv+kPmCzMmECyJFod86el/B4Y3iWJa/x/OsCKJycluqmJgrSxp6oPuGZ?=
 =?iso-8859-1?Q?1bYhDN18HtBa6CP+4tG77cii0ffWqcPf0wHlWcU9efyY47ZpGa9EdQ4O83?=
 =?iso-8859-1?Q?/w8mbPFwa4zBGD669GqFyGJAz/33YO71Iy4v92S/eJUbvZAw4QTNeu9S0E?=
 =?iso-8859-1?Q?M5pNOB2EA9e6XR4tR2gigNVnxwFBYTX+MoFUnZjIu69ZOlNFoYaRg03nvC?=
 =?iso-8859-1?Q?nr7bS9jn1Nk8nBimWoEXn6XXuhHioTY+Ksqk3yLvxNEsYbDHfsuKdg/izh?=
 =?iso-8859-1?Q?5WJjc/9QnJ55HDhNPxnOWmYVt7SmEzArHCk4jLmO0PNgIpl2iBGvGM/BAg?=
 =?iso-8859-1?Q?X8nyAcfkQ92RBCioRklB1r0TlGitjjrafED/amjEmkGuXLDnbj/2k6QjUm?=
 =?iso-8859-1?Q?MOnv5wxgPoo8TbjCKmbFwNZm55OlOtfKbu5NR2+ZfyqMWdyE/2kJgOoqm3?=
 =?iso-8859-1?Q?W729kjMrzZAhL8KanaBFQCOdSNYYc6BGYSuXpEG1MENYrOPyBcYXASM107?=
 =?iso-8859-1?Q?yW9xhpcpBLglfZNXCMMW5iSQh8BMx/0S8K7xQBIiFgYI0cWvzX/oFb2xIw?=
 =?iso-8859-1?Q?3C2wk+vHv1oORk5CqGwi9dquznBvta/LD5PsiQCkXpPUCw9ZXxcTpVc63p?=
 =?iso-8859-1?Q?mbK14M5z+h+awaFhagxqqfZJV2BhZUxweY2ZVXymt6CFFcXaNGhkI3o31U?=
 =?iso-8859-1?Q?/i/xz4vWQSie62DX6IzsP/ae7ZxKftnImpd/aZbbGq7xK/GTU+NtbFZqS8?=
 =?iso-8859-1?Q?FNt2KK6oAg=3D=3D?=
X-Exchange-RoutingPolicyChecked: VZkBXrGg8w7H78tmT+VoUxkstOR4EISwpsVpyFdWAbiP/ZTZ9A3MzFj81NeHNijFjCzsciOBQ6bjkce7XpZMEEm82og1Az1X+ZvPFE+MO+XMjqs5dHDhbrbFiGYXWqY9ZdpZcZAJJTetmn+rN0VjSEwZ/SQ8eJ5G+LCfzjwRwocoecLQzUuZASFHo4+0ZxDaUvbTLOoFyvZEtypS0bFN/ylr2PiY+rjXiiH7cSbD+yUJLGY+WgC5mh1ldRu/WA0u/l2OLfxAvYuST6hShMrtL3K5HBUhhiolIOckCRbobB9BtJnROH6gCSLH9bAy7hAdVDm2CdYUNO+On3khKgOS7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4dfebd-8c68-4a84-3660-08def18857a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:55:02.3151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bL4d7Ih2wA2foNag1BAblaCu8bxCVphmlErCzkboIcgnTR+tSYQ1OmtFeu+18lWRTNVlD4VSJ1wmgV5rb8Oaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4996
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

On Mon, Aug 03, 2026 at 10:46:27AM -0700, Matthew Brost wrote:
> On Mon, Aug 03, 2026 at 02:55:53PM +0530, Arvind Yadav wrote:
> > A device page migrated to system memory by a CPU fault can remain
> > referenced for a short time after migration completes. During this
> > window, the raw-PFN eviction path can select the same device PFN and
> > migrate it again.
> > 
> 
> So is the race a CPU immediately followed by an evict?
> 
> > The first migration has already moved the memcg charge away from the
> > source folio. Migrating that source again can create an uncharged system
> > folio. Adding such a folio to the LRU can spin indefinitely in
> > folio_lruvec_lock_irqsave(), resulting in a soft lockup and an RCU stall.
> > 
> 
> Do you have stack trace of this lockup? It would be good include that in
> this commit message.
> 
> > Track successfully migrated device PFNs in drm_pagemap_zdd for the
> > lifetime of the device-mapping generation.
> > 
> > Record successful migrations in both the CPU-fault and raw-PFN eviction
> > paths.
> > 
> > Make raw-PFN eviction skip retired PFNs, preventing an already migrated
> > device page from being handed to the migration path a second time.
> > 
> > Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> > ---
> >  drivers/gpu/drm/drm_pagemap.c | 188 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 186 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> > index 7a056592ac66..f7040fc0dea6 100644
> > --- a/drivers/gpu/drm/drm_pagemap.c
> > +++ b/drivers/gpu/drm/drm_pagemap.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/dma-mapping.h>
> >  #include <linux/migrate.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/xarray.h>
> >  #include <drm/drm_drv.h>
> >  #include <drm/drm_pagemap.h>
> >  #include <drm/drm_pagemap_util.h>
> > @@ -66,6 +67,8 @@
> >   * @refcount: Reference count for the zdd
> >   * @devmem_allocation: device memory allocation
> >   * @dpagemap: Refcounted pointer to the underlying struct drm_pagemap.
> > + * @retired: Device PFNs already migrated to RAM. Entries remain until this
> > + * mapping generation is destroyed.
> >   *
> >   * This structure serves as a generic wrapper installed in
> >   * page->zone_device_data. It provides infrastructure for looking up a device
> > @@ -78,6 +81,7 @@ struct drm_pagemap_zdd {
> >  	struct kref refcount;
> >  	struct drm_pagemap_devmem *devmem_allocation;
> >  	struct drm_pagemap *dpagemap;
> > +	struct xarray retired;
> 
> I don't think an xarray is the right data structure here, given that
> load/store operations are slower than direct memory loads and stores.
> 
> The CPU fault path is about as critical a code path as we can get, so I
> think it needs to be highly optimized.
> 
> I believe a bitmap [1] is the right data structure.
> 
> include/linux/bitmap.h
> 
> I'd suggest using an embedded bitmap here, sized based on the ZDD size.
> 
> For example:
> 
> /* last member */
> unsigned long retire_map[];
>  
> Show more lines
> 4K, 64K -> length 1
> 2M -> length 8
> 
> Lastly, the only bits that are ever checked are those corresponding to
> the folio order. For example, if the folio order is 9, only bit 0 is set
> and checked, and the check loop increments based on the folio order.
> 
> >  };
> >  
> >  /**
> > @@ -101,6 +105,7 @@ drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap)
> >  	kref_init(&zdd->refcount);
> >  	zdd->devmem_allocation = NULL;
> >  	zdd->dpagemap = drm_pagemap_get(dpagemap);
> > +	xa_init(&zdd->retired);
> >  
> >  	return zdd;
> >  }
> > @@ -137,6 +142,7 @@ static void drm_pagemap_zdd_destroy(struct kref *ref)
> >  		if (devmem->ops->devmem_release)
> >  			devmem->ops->devmem_release(devmem);
> >  	}
> > +	xa_destroy(&zdd->retired);
> >  	kfree(zdd);
> >  	drm_pagemap_put(dpagemap);
> >  }
> > @@ -1102,12 +1108,169 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
> >  }
> >  EXPORT_SYMBOL(drm_pagemap_put);
> >  
> > +/**
> > + * drm_pagemap_is_devmem_page() - Is @page a drm_pagemap device page
> > + * @page: The page to test
> > + *
> > + * Return: true for device-private or device-coherent pages, which carry a
> > + * struct drm_pagemap_zdd in their zone_device_data.
> > + */
> > +static bool drm_pagemap_is_devmem_page(const struct page *page)
> > +{
> > +	return is_device_private_page(page) || is_device_coherent_page(page);
> > +}
> > +
> > +static void
> > +drm_pagemap_release_retired_reservations(unsigned long *src_pfns,
> > +					 unsigned long npages)
> > +{
> 
> This function won't be needed with above.
> 
> > +	unsigned long i = 0;
> > +
> > +	while (i < npages) {
> > +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> > +		struct drm_pagemap_zdd *zdd;
> > +		struct folio *folio;
> > +		unsigned long pfn, nr, j;
> > +
> > +		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
> > +		    !drm_pagemap_is_devmem_page(page)) {
> > +			i++;
> > +			continue;
> > +		}
> > +
> > +		folio = page_folio(page);
> > +		zdd = drm_pagemap_page_zone_device_data(page);
> > +		pfn = folio_pfn(folio);
> > +		nr = folio_nr_pages(folio);
> > +
> > +		for (j = 0; j < nr; j++)
> > +			xa_release(&zdd->retired, pfn + j);
> > +
> > +		i += nr;
> > +	}
> > +}
> > +
> > +/**
> > + * drm_pagemap_reserve_retired_pages() - Pre-reserve retirement slots
> > + * @src_pfns: migrate_vma source array after migrate_vma_setup()
> > + * @npages: number of entries in @src_pfns
> > + *
> > + * Reserve every base PFN because migration may split a large source
> > + * folio. Recording the result must not allocate.
> > + */
> > +static int drm_pagemap_reserve_retired_pages(unsigned long *src_pfns,
> > +					     unsigned long npages)
> 
> This function won't be needed.
> 
> > +{
> 
> This function will look something like:
> 
> 	unsigned long i = 0;
> 	int err;
> 
> 	while (i < npages) {
> 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> 		struct folio *folio;
> 		struct drm_pagemap_zdd *zdd;
> 		unsigned long pfn, nr;
> 
> 		if (!page || !drm_pagemap_is_devmem_page(page))
> 			continue;
> 
> 		folio = page_folio(page);
> 		nr = folio_nr_pages(folio);
> 
> 		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
> 			i += nr;
> 			continue;
> 		}
> 
> 		zdd = drm_pagemap_page_zone_device_data(page);
> 		bitmap_set(zdd->retire_map, i, 1);
> 		i += nr;
> 	}
> 
> 	return 0;

^^^

Opps, copy paste error. This function isn't needed and the above snippet
is for the function below (include there in previous reply).

> 
> > +	unsigned long i = 0;
> > +	int err;
> > +
> > +	while (i < npages) {
> > +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> > +		struct drm_pagemap_zdd *zdd;
> > +		unsigned long pfn, nr, k;
> > +
> > +		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
> > +		    !drm_pagemap_is_devmem_page(page)) {
> > +			i++;
> > +			continue;
> > +		}
> > +
> > +		zdd = drm_pagemap_page_zone_device_data(page);
> > +		pfn = folio_pfn(page_folio(page));
> > +		nr = folio_nr_pages(page_folio(page));
> > +
> > +		for (k = 0; k < nr; k++) {
> > +			err = xa_reserve(&zdd->retired, pfn + k, GFP_KERNEL);
> > +			if (err) {
> > +				drm_pagemap_release_retired_reservations(src_pfns,
> > +									 npages);
> > +				return err;
> > +			}
> > +		}
> > +
> > +		i += nr;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * drm_pagemap_retire_migrated_pages() - Retire CPU-migrated device PFNs
> > + * @src_pfns: migrate_vma source array, valid after migrate_vma_pages()
> > + * @npages: number of entries in @src_pfns
> > + *
> > + * Record successful migrations before finalize unlocks the sources.
> > + * Release reservations for pages that were not migrated.
> > + */
> > +static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
> > +					      unsigned long npages)
> > +{
> > +	unsigned long i = 0;
> > +
> 
> 
> This function will look something like:
> 
> 	unsigned long i = 0;
> 	int err;
> 
> 	while (i < npages) {
> 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> 		struct folio *folio;
> 		struct drm_pagemap_zdd *zdd;
> 		unsigned long pfn, nr;
> 
> 		if (!page || !drm_pagemap_is_devmem_page(page))
> 			continue;
> 
> 		folio = page_folio(page);
> 		nr = folio_nr_pages(folio);
> 
> 		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
> 			i += nr;
> 			continue;
> 		}
> 
> 		zdd = drm_pagemap_page_zone_device_data(page);
> 		WARN_ON_ONCE(__test_and_set_bit(i, zdd->retire_map));		
> 		i += nr;
> 	}
> 
> 	return 0;
> 
> 
> 
> > +	while (i < npages) {
> > +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> > +		struct drm_pagemap_zdd *zdd;
> > +		unsigned long pfn, nr, k;
> > +		bool migrated;
> > +
> > +		if (!page || !drm_pagemap_is_devmem_page(page)) {
> > +			i++;
> > +			continue;
> > +		}
> > +
> > +		zdd = drm_pagemap_page_zone_device_data(page);
> > +		pfn = folio_pfn(page_folio(page));
> > +		nr = folio_nr_pages(page_folio(page));
> > +		migrated = src_pfns[i] & MIGRATE_PFN_MIGRATE;
> > +
> > +		/* Keep later folio splits covered. */
> > +		for (k = 0; k < nr; k++) {
> > +			if (migrated)
> > +				WARN_ON_ONCE(xa_err(xa_store(&zdd->retired,
> > +							     pfn + k,
> > +							     xa_mk_value(1),
> > +							     GFP_NOWAIT)));
> > +			else
> > +				xa_release(&zdd->retired, pfn + k);
> > +		}
> > +
> > +		i += nr;
> > +	}
> > +}
> > +
> > +/**
> > + * drm_pagemap_skip_retired_pages() - Drop retired PFNs from a raw-PFN eviction
> > + * @src_pfns: source array after migrate_device_pfns() (MIGRATE_PFN encoded)
> > + * @npages: number of entries in @src_pfns
> > + *
> > + * Skip source PFNs already migrated to RAM by either migration path.
> > + */
> > +static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
> > +					   unsigned long npages)
> > +{
> > +	unsigned long i;
> > +
> > +	for (i = 0; i < npages; i++) {
> > +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> > +		struct drm_pagemap_zdd *zdd;
> > +
> > +		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
> > +		    !drm_pagemap_is_devmem_page(page))
> > +			continue;
> > +
> > +		zdd = drm_pagemap_page_zone_device_data(page);
> > +		if (xa_load(&zdd->retired, folio_pfn(page_folio(page))))
> 
> if (__test_and_set_bit(i, zdd->retire_map))
> 
> > +			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> 
> Iterate based on nr.
> 
> Matt
> 
> > +	}
> > +}
> > +
> >  /**
> >   * drm_pagemap_evict_to_ram() - Evict GPU SVM range to RAM
> >   * @devmem_allocation: Pointer to the device memory allocation
> >   *
> > - * Similar to __drm_pagemap_migrate_to_ram but does not require mmap lock and
> > - * migration done via migrate_device_* functions.
> > + * Similar to __drm_pagemap_migrate_to_ram(), but uses the
> > + * migrate_device_* helpers and does not require the mmap lock. Device
> > + * PFNs already migrated by a CPU fault are skipped.
> >   *
> >   * Return: 0 on success, negative error code on failure.
> >   */
> > @@ -1149,6 +1312,17 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
> >  	if (err)
> >  		goto err_free;
> >  
> > +	drm_pagemap_skip_retired_pages(src, npages);
> > +
> > +	/*
> > +	 * Reserve retirement entries before migration so recording successful
> > +	 * PFNs cannot fail. Otherwise, a retry could select and migrate the same
> > +	 * PFN again.
> > +	 */
> > +	err = drm_pagemap_reserve_retired_pages(src, npages);
> > +	if (err)
> > +		goto err_finalize;
> > +
> >  	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpages,
> >  						   src, dst, 0);
> >  	if (err || !mpages)
> > @@ -1179,6 +1353,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
> >  	if (err)
> >  		drm_pagemap_migration_unlock_put_pages(npages, dst);
> >  	migrate_device_pages(src, dst, npages);
> > +	drm_pagemap_retire_migrated_pages(src, npages);
> >  	migrate_device_finalize(src, dst, npages);
> >  	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
> >  					DMA_FROM_DEVICE, &state);
> > @@ -1276,6 +1451,14 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
> >  	if (!migrate.cpages)
> >  		goto err_free;
> >  
> > +	/*
> > +	 * Reserve retirement entries before migration so recording successful
> > +	 * PFNs cannot fail. On failure, finalize can still restore the sources.
> > +	 */
> > +	err = drm_pagemap_reserve_retired_pages(migrate.src, npages);
> > +	if (err)
> > +		goto err_finalize;
> > +
> >  	ops = zdd->devmem_allocation->ops;
> >  	dev = zdd->devmem_allocation->dev;
> >  
> > @@ -1309,6 +1492,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
> >  	if (err)
> >  		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
> >  	migrate_vma_pages(&migrate);
> > +	drm_pagemap_retire_migrated_pages(migrate.src, npages);
> >  	migrate_vma_finalize(&migrate);
> >  	if (dev)
> >  		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
> > -- 
> > 2.43.0
> > 
