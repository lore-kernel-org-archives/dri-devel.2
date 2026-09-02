Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5003C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0663F10E477;
	Wed,  2 Sep 2026 05:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Fl+hdM8h";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 135CC10E456;
 Wed,  2 Sep 2026 05:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788327216; x=1819863216;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=dFSYRdybayE34HpLRJHmFR5WbDpZrUY2oxtafhygk1w=;
 b=Fl+hdM8hD4VnscV3hjagCUbZ7VJAONtkBqJ7my2ty9lUX8IRXOmYk8u9
 KDZUAfyAbrCLsaM14kgoBsRegIo5dsyuuMISIEK9wW16Vg+yxCLjuPIoT
 CSxliAjVHHkakCGzJgnizfN+R7w3yzevt/rDCR2BmECEGyBZ6Du7/KMFu
 Zfj4Q/vVTmUBWKwzXy3R0HT+SK6F8TVPFQG9/FaWNAkDoFZrmgXq3t6L6
 2fxCdmCKMDgplMP5yb4fw2QvxiK5NnDOH8TErtUwRznqH87tlx60DRstw
 5n14B3bCbvuIPlw2RSiIsza78JfrhE5DqjFPGrwpqE3tiRU+2w99k8qya Q==;
X-CSE-ConnectionGUID: oJ3zCJH5Qv6iqFtfljEx5A==
X-CSE-MsgGUID: eQP9qsonSqawoTEykmS5aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="114315312"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="114315312"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:33:36 -0700
X-CSE-ConnectionGUID: wMSPn9spSQ6CZ6d4o0k7eQ==
X-CSE-MsgGUID: G0UcCHztRIW1hocFWwet9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="266702392"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:33:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 22:33:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 22:33:35 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 22:33:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4fhguJLqsAP49NFWm2muBL0nhTf6AkrX30xCnGueNjenZx0lgCBTZIVHYBIsl72l2OH5fq7f8A57pfuj7JLZ5X8lPPD2qShWy8bTtfE7JP3seAm7xq47G5+HQZFKBNBo6gDapEnkFQhNWVTS0Hg4ZAfpdslU8Y0eFKIPbzJN9xJBtMxTm7fRefGB0e8p2vLIgrnl4mjRaCrcNnvoz4lFYnWjK4y1S8TJRjGIEGHi4WHd6Wv0eH0tUF3WQ84JWXIQVAIFv+lfnwR6g34uJjnnHVgkK0iirmhm7LE6RQHtEIZBCjeYnQy/vr2YkBZUU6Kpw8hhdPYQ+gZLZpKIS6IAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KK2pZcav6AfvPzqotuP/Sd3D39uQvptwkGQXqkyT74Q=;
 b=Nx0V3pWbNxtPf1qT7i6JORp382cOAWFCn2miY/0TJCCY+jxhdIq1FPEYMEvNW5tWW6HI2D6vmreMyimgXE94q+XVeQ0LiOtrxWA0JLQHb2ShU54eM+CqOl+PjAa+HC3M2LsgO+//DjRSitY64xw/TPLAQJDxHi3Or6hNXTrjIQfmYJgDp2wN01l4Ej9pgdeeETz6MNGkcAAptEUOw5WhEgQfD++1kkra0kTG6EENV9tDRFtZTQljLzc1IYWOy+Mzt3nm52rIQUiXvnX/J3b2+YBNmgrB496xj9/h4jZIIVWfb9UULpa1EHyTKy6Z9G4m8W9GP1KYj0T+Ok6bgkn/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:33:32 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:33:26 +0000
Date: Tue, 1 Sep 2026 22:33:23 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Yadav, Arvind" <arvind.yadav@intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 03/13] drm/xe: Drop queued page faults when device I/O is
 blocked
Message-ID: <ape1I1UFDGD2r5Fv@gsse-cloud1.jf.intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-4-arvind.yadav@intel.com>
 <apXnb3_WmpYhPeUo@intel.com>
 <ec7667c6-edc8-497c-97f5-872ba5d63bc3@intel.com>
 <ape0gZng5JWbd+Sa@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ape0gZng5JWbd+Sa@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 8163d436-36f0-455b-3a73-08df08b3b640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YTZXNJoUZZH7yl/iR0n4cmkUdFk/SBKPCuLixqBsj2ewQ98SNgYEXYiC39AbBTfvlaF7xlTxHGys0b1mikwE6lFZunBxy7bQkn9jUzDkrZoO/Mpk6bxQMBbfcpef2rEnXWBFVdRqzyQwIYsLheHUHAU5edmMoV3OsAtybB2XdCkxn+59tccTcrdJRfV/Vxwg6fiIzRBoHXI0/m+yvuHFhBYpTbsxu7Nf2l2vElcRGRRP2Ae8CN0CoKDP1xIaXFwpsiLKUz4qXh8QidYYzz7XpzcCRaOp8LGe9BvzmkackPo2F+vtlROlQvhPBFhkatpUZRmkmXHu5TU1PMKhluFIE22jxPOje8K//hlbdgqAR0KX05l8dzLzxR2NIqKKAOZtHMZor128OxjuoF+ORRmSCSWAo/PFgP70doJSTcWh48jhCzX7KQkSHJ1+gMckH6+1jPAnqQitKUenqSXVWG1yclAqFjGvmqSwZAgZ6ohmukdtYfUackuP6BvO+QOg0CJ5vWbc9f6W2CVWPp0aKgbYfNp85g4g6fcgpHLJQQQLzGCYQDrD3MrVviV9P/4cVrPmt9RfwWf07/c01xHzomdsIBkns/poMVjrqb0BeyPVUcsl3GbjoVy6u2sO3a+w8YIRIcfu+PbSneMu9mJtHKBy2NjAYPldJTRNWjJ5JKCPsDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TQBVhK3gw9YojJ61UcxRouxw41UUO30GlCx9Y3hUIQ+aF2av5bMzhp7ftV?=
 =?iso-8859-1?Q?cXxINQuirHsjo0i/77hb/zug6dDkaxiUjG5s/fpLm+Omt2pOmKnd/x0zFH?=
 =?iso-8859-1?Q?7vbnUp6ldqvnAtsNHCzcyBc/tNadPiuOhJd3klz8SRQyZA3pnPJL3z8RRh?=
 =?iso-8859-1?Q?C8cmaq4eUECggJZJN3p43b9iwCkphB0z15Luhsz4tXLbMCNUzWuzjntVmy?=
 =?iso-8859-1?Q?9JAOnfqOhH6vfiaQPcp/fwdckLgrl4z5NryUIUvYXW6wnf+jBRp1jr5N5f?=
 =?iso-8859-1?Q?8802oSps3yBuSoI2QrhW57PsupwN3opf0S9+lbBjULJByuQAHIVUjtcv8D?=
 =?iso-8859-1?Q?69shniHYWRfYzyvQxdoy4Z3sfEfFhauhBSDOxQQOzhMe9pGnzIlenVyPKN?=
 =?iso-8859-1?Q?3VH3uK6EvcwEhgNNxgwUbJbbFWNKYPNEwTHgP3ZJfoezI8d4wy04XJpoQa?=
 =?iso-8859-1?Q?4uFjEP4uj2qy7GauSqeT4XL6peJZGLyziVVFvn9I7HgeJrQs1s3jS7jxlY?=
 =?iso-8859-1?Q?Rmq6QTJK8YdB1Xvij5IQoGquiXcPvlEnY1xhRWzVkNtBc34V5XY+ldHTE4?=
 =?iso-8859-1?Q?DAX0tf4RNffvvaOqVkB3EgeyJAyWq/UhAZ93eEkvQ+C/7WxIvkHXYgHzwT?=
 =?iso-8859-1?Q?QW0vtPgHD9bu28n9lo+n1P6uZ0kPPbMMdEil9yh7hTIXH+QDLSjT9t/M8M?=
 =?iso-8859-1?Q?aAkohkuFu5E8rCswNYH0QShArTi6oZuNX0OOne9I7zeXyQvgJ+Roouaof6?=
 =?iso-8859-1?Q?1ufbpXQw/MEbi+3jF0l3z26oGgEZeIsFiOPXh+mqvJQQwVknV/EyiNyRv+?=
 =?iso-8859-1?Q?h1w1aTln4ruVgNo9qx1HySIXl10CpiICtmc3QUEGvmNV2d/v9u+pbJ8/WT?=
 =?iso-8859-1?Q?5tNUGj8D4eaTcNHKacZp2RHesPi+nKnFJ2QUHKRyPZx4BAYF0VqLQy81iZ?=
 =?iso-8859-1?Q?PJZNi+dN+tVL46EpZhgjYICtVgJa/UGu7DB8THt9HAyKYBRnuJtRi1+kIp?=
 =?iso-8859-1?Q?fwjNtE1KiRPX6sHrD2986WSHNllzoHnHRqyf911+p+umAmcdhTUtJDwASD?=
 =?iso-8859-1?Q?XOy1yBCDQm3MLo0oStw9iHjWOD16FITcyFTeefS0HiwOdMW3R+bdZqiwf5?=
 =?iso-8859-1?Q?sLSb/nMwaK0gCeQB/LjckQ/krvWzDIAEheUMY+r4OcZML0uQ/4dcf8HOmm?=
 =?iso-8859-1?Q?emgCXF4bL5MZb7LvdGT6uwvVy6H8BM0a1J3ip0PERTz1TgLD/STDyk2xis?=
 =?iso-8859-1?Q?085VEi3lfF9YCOxb7eNLJnZAPi/e1FqsPTcPGczithmBnvf3xj6rC96qyB?=
 =?iso-8859-1?Q?IbIa8+NDVgnsNRZ9yPyozcaGssXHIQFbj5inuXC+WVVs1IKgD+V/iKzqwB?=
 =?iso-8859-1?Q?25738ghZNy6Wx3yj/rkqSyIF+XB8lprE3w/ws83ZO67Z9Kb9vaS2+Um00w?=
 =?iso-8859-1?Q?LFqA4fbQ0UtoT2MQ5ydJhAU+tvAieUlAzdcIvJEUpaoL5OhH/qXT817FF8?=
 =?iso-8859-1?Q?bK46IzoA2j1h71STAbFHi11MvfuB8MXXCDeGizUie9wJRwABWXAeUGeCcN?=
 =?iso-8859-1?Q?KGXk85da2g/hLgzcp1ti8WfVieNBMku0zWIGw0eVWBaysoBAyzsCqTdHIB?=
 =?iso-8859-1?Q?21YolEPYkF1ZmaujP1FtXFizKLPrmmM6XrBHpxwusXi+hvO3OsBnGfvcx3?=
 =?iso-8859-1?Q?SgIOUhwagkzhj6WpmcmuFsuVzakViwbuyLMaQIgs6zw1wyuNejBIzufGSI?=
 =?iso-8859-1?Q?TEGuTBli2Woqe1s4sJSjKYh0raOdonSN+B1qRhlc2g8CX5hVKAjxTdHAGQ?=
 =?iso-8859-1?Q?+1QVmcIi2cM4GtPZGxBWx6TLTI0ncCw=3D?=
X-Exchange-RoutingPolicyChecked: aQsWgmvRM6u/iL2igmQcXERN00ngOwqS5cESvdzVKDeV/17ltpquDzem1rTvmfPlZLPGHlJPgYQm6aGYxLlVPlUaI+eyIasWxfeiZKcjVaRC2TgKpZjq60eCBP+NIQNiJIOSkXjXo49mGCAmaRHfbXg3I1c0Y0ZdEdkoiI7X0GjFHrgoXLS3j/ZuQ8u72Cux84zvGN083GmxXSVPfF9RGRmxamHeGMqiSvYQdLSVq1puOmWm/Fe0qzLCYSudjGU4azSLPVU1w1bTeG4TxrNGrwSHsgwj5i+bwuzfzIL3UKKzs1KAWyHpxY51mQE94CVCYhpIiUNq3bNrgGGwAfm4zA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8163d436-36f0-455b-3a73-08df08b3b640
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:33:26.1463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zApskVH8u2kSEsNsyMImzx8+dcpDNCcbjZyz5kjpfX0Qg34BwodBAfidnE103kiGEl2bfo7xdUl2nqiNTXIb7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
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

On Tue, Sep 01, 2026 at 10:30:41PM -0700, Matthew Brost wrote:
> On Wed, Sep 02, 2026 at 10:19:22AM +0530, Yadav, Arvind wrote:
> > 
> > On 01-09-2026 02:13, Rodrigo Vivi wrote:
> > > On Thu, Aug 27, 2026 at 03:47:51PM +0530, Arvind Yadav wrote:
> > > > Page-fault work may still be queued when PCI error recovery starts or
> > > > the device becomes permanently wedged. Servicing these faults can migrate
> > > > memory or update page tables after device I/O has been blocked.
> > > > 
> > > > Check the device state before and after fault servicing to cover a reset
> > > > racing with the worker. Drop the active fault and its chained faults
> > > > without sending a hardware response, and invalidate the cached fault
> > > > state.
> > > > 
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > Assisted-by: Claude:claude-opus-4-8
> > > > Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> > > > ---
> > > >   drivers/gpu/drm/xe/xe_pagefault.c | 40 +++++++++++++++++++++++++++++++
> > > >   1 file changed, 40 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> > > > index 2e415995f067..f486165f2323 100644
> > > > --- a/drivers/gpu/drm/xe/xe_pagefault.c
> > > > +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> > > > @@ -592,6 +592,38 @@ static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *p
> > > >   	xe_vm_put(vm);
> > > >   }
> > > > +static bool
> > > > +xe_pagefault_drop_if_blocked(struct xe_pagefault_queue *pf_queue,
> > > > +			     struct xe_pagefault_work *pf_work,
> > > > +			     struct xe_pagefault *pf,
> > > > +			     u64 *cache_start)
> > > > +{
> > > > +	struct xe_pagefault *next;
> > > > +
> > > > +	if (!xe_device_io_blocked(pf_work->xe))
> > > > +		return false;
> > > > +
> > > > +	/*
> > > > +	 * cache_start is private to this worker invocation. pf_work->cache is
> > > > +	 * shared with fault producers and must be invalidated under the queue
> > > > +	 * lock.
> > > > +	 */
> > > > +	xe_pagefault_cache_start_invalidate(*cache_start);
> > > > +
> > > > +	guard(spinlock_irq)(&pf_queue->lock);
> > > > +
> > > > +	xe_pagefault_cache_invalidate(pf_queue, pf_work);
> > > > +
> > > > +	while (pf) {
> > > > +		next = pf->consumer.next;
> > > > +		pf->consumer.next = NULL;
> > > > +		pf->consumer.alloc_state = XE_PAGEFAULT_ALLOC_STATE_FREE;
> > > > +		pf = next;
> > > is there some helper we could re-use? I know we cannot use the pop directly,
> > > because it would deadlock, but perhaps we can unify some code here...
> 
> Why would it deadlock... xe_device_io_blocked is just an couple of
> atomics, right?
> 
> So why wouldn't this work to squash all faults.
> 
> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> index 2e415995f067..1c9e5539b90d 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> @@ -477,6 +477,12 @@ static bool xe_pagefault_queue_pop(struct xe_pagefault_queue *pf_queue,
>                 lpf = xe_pagefault_queue_tail_fault(pf_queue);
>                 xe_pagefault_queue_advance(pf_queue);
> 
> +               if (xe_device_io_blocked(xe)) {
> +                       lpf->consumer.alloc_state =
> +                               XE_PAGEFAULT_ALLOC_STATE_FREE;
> +                       continue;
> +               }
> +

^^^ This should actually go after the XE_PAGEFAULT_ALLOC_STATE_QUEUED check.

Matt

>                 if (lpf->consumer.alloc_state !=
>                     XE_PAGEFAULT_ALLOC_STATE_QUEUED)
>                         continue;
> 
> 
> > 
> > 
> > Noted,
> > 
> > > 
> > > > +	}
> > > > +
> > > > +	return true;
> > > > +}
> > > > +
> > > >   static void xe_pagefault_queue_work(struct work_struct *w)
> > > >   {
> > > >   	struct xe_pagefault_work *pf_work =
> > > > @@ -615,6 +647,10 @@ static void xe_pagefault_queue_work(struct work_struct *w)
> > > >   		int err = 0;
> > > >   		bool invalidated = false;
> > > > +		if (xe_pagefault_drop_if_blocked(pf_queue, pf_work, pf,
> > > > +						 &cache_start))
> > > > +			continue;
> > > do we really need to loop inside the loop or only check and let this main loop goes?
> > 
> > 
> > Yes, The inner walk is needed. Chained faults have already been removed from
> > the queue and linked through consumer.next. The outer pop loop will not see
> > them.
> > 
> > > 
> > > > +
> > > >   		/* Last fault same address, ack immediately */
> > > >   		if (xe_pagefault_match(pf, cache_start, cache_end, cache_asid)) {
> > > >   			xe_gt_stats_incr(gt, XE_GT_STATS_ID_LAST_PAGEFAULT_COUNT, 1);
> > > > @@ -623,6 +659,10 @@ static void xe_pagefault_queue_work(struct work_struct *w)
> > > >   		err = xe_pagefault_service(pf);
> > > > +		if (xe_pagefault_drop_if_blocked(pf_queue, pf_work, pf,
> > > > +						 &cache_start))
> > > do we really need to check after?
> > 
> > 
> > Yes. The device can enter reset or become wedged while
> > xe_pagefault_service() is running. The first check alone does not cover that
> > race.
> > 
> 
> But this is still toctou - really everything in patch is as immediately
> after either check the state can change. I can't say I'm a fan of any
> weak checks in this code...
> 
> But just for thought: after this point all we do is CT which should be
> down and we'd drop it there before touching the hardware.
> 
> Matt
> 
> > > 
> > > > +			continue;
> > > > +
> > > >   		if (err) {
> > > now this err far from where it is collected is pretty bad...
> > 
> > 
> > Agreed. i will keeps err next to its use.
> > 
> > Thanks,
> > Arvind
> > 
> > > 
> > > >   			if (!(pf->consumer.access_type & XE_PAGEFAULT_ACCESS_PREFETCH)) {
> > > >   				xe_pagefault_save_to_vm(gt_to_xe(gt), pf);
> > > > -- 
> > > > 2.43.0
> > > > 
