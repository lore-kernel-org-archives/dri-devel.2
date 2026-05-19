Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE19CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 15:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDFD10ED7F;
	Tue, 19 May 2026 15:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GJBRL4et";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ADB510ED95;
 Tue, 19 May 2026 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779205260; x=1810741260;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4I+wW6WkW4tD3Qv0+332H5PAxGUVekfan0iFSep0muk=;
 b=GJBRL4etdLWaFC4G/odUNX5TiqKjKI8J4oBqvrvKAvVkwj1B5L8enHTo
 N8SMOm0+frQhpsH12CJRHyfUSHUBPZgCHR3LZHwBJid+FB8jwj4QoVV5+
 bHgI0cFrrT7gzpFnYbi543bUyFog1zGzLRFRHfm4KqoaSwHCpc11vyzqu
 kUtcdDRRdLI+KZSJLEG/esZ0DYYFtfizFb2vkbBknv7mNTfTWR+Ca30FD
 I6e1szcVGPRqOmpHVLtPIIdp8XcKCK2zvtrZvaGheEHgMA076XRDKxnj8
 JVUD2IHMGXR1c3DnJmdj13pDNJENkpCmgquFF1H/+se5GvUNZjGL5WQU5 w==;
X-CSE-ConnectionGUID: MnM9n8qWSNexJA+yUPM1jw==
X-CSE-MsgGUID: X0qrfxd8Qt2qoe3vmln/vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79938977"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="79938977"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 08:41:00 -0700
X-CSE-ConnectionGUID: 5paBBLj0RlGQ4sIWnLRnYA==
X-CSE-MsgGUID: Zx4yk7MXSNCUKMQs+evpMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="240076692"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 08:40:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 08:40:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 08:40:59 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 08:40:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEyR8ZZZnpRun2biGN7zA2Av6Ww18XHAtvT0ru+hm5KENVCX5JkRGwtS3nBH5G/pH3WyCgAnMaYq3jBb1D8Ui2e3MipD+jZcnachJ+BVD4QG5P6hmKNngOxAwJMjyTY6yJ7+PKHdb+RV7mthSBk3FVlg2l7CF1QHIBFFTE/XvVd1WvXfZK4QJDa4N+nxG5Zn3A8KvtDAmofPVwklNRANbL7i/09scRv245dTfkxfkGCCYUle6AZL31Pa7s6+NC1j55R5syP44S7RJ638EPm0sR2v/BpU/cI3szVv4WNS5fXYvW5aVL2azcLKXIhehvZ6UXwHP3pBEghel7cu04IoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrZepFNI1fBYdpCSEXKUpo3dtJFXF7+EBff/7Jev3r8=;
 b=C9jglefq2mS+uh4bX3HSTXShlTVyKfzdR6jymBZ6szX11YWtgu949cK48yEqR2o1oSmapH+vaxVWgcZats0aBNXKY3SoFgxU+ODOu2gEO3kKhteW9mFwRk7arr77LuUc1lvHoNdRscmUTEbbu+Q3KaJ4BExawA7nCpJ0MvZcXsuoT2x/zmIEfcc8zXVWNU9xnsjPZDwoUygS5axiqwtCRafi5Zi/4e9Mywqz2p17TmEOymDp2h237Gnd5F/0sQsjy1PGIlzf2MQlHQUxqrVstM6eUyMb7guxKjKg7WXuTJqy3uTIcnO+mOTL5HGiKH/WsIeQFHPoBjGlv/MaljehYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by PH7PR11MB8600.namprd11.prod.outlook.com (2603:10b6:510:30a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 15:40:53 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277%4]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 15:40:53 +0000
Date: Tue, 19 May 2026 17:40:47 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 5/5] gpu/buddy: Track per-order used blocks with a
 scoreboard
Message-ID: <agyEeIMZ3o1KlVzI@fdugast-desk>
References: <20260518141446.124508-1-francois.dugast@intel.com>
 <20260518141446.124508-6-francois.dugast@intel.com>
 <ddfb5ef7-e01a-4a9d-aa16-bcd475338135@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ddfb5ef7-e01a-4a9d-aa16-bcd475338135@intel.com>
Organization: Intel Corporation
X-ClientProxiedBy: DU7P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::6) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|PH7PR11MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 191bc09d-57b4-4613-fe6c-08deb5bd02d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Lh4xqccshCcOnhU0Gr1klK0e630vFmRlG3p7kK9POzSbZpb8UksZRVOmmtld6jvZVRdHAQsZ814CW9hw1I8QtuI+en8VTPEjJNnvqorr2Os3oEHpWbwRzSu75KFVscF/qJqY2261TQoyTXdePaB/syqKWQfn/xVlluOG7EhoZRmS3w0PiNS1CJu6LsanQieQlRTntrAWKmzGd0kPrxfmMDdaXHN579LUhXi/v5ezVPigoV1ItCayRtHAmcXZtmBrpmPa0jrbmoK2xp1g61NvLKQF0fBMupaarWJhI1z3ZWhRPcFRihmuNM6CaJ8IoHmhs/WJgVWaORR3wkZIfcX9nK/IHGrU1jRlqR0d/4rrFnnAzFk1HckeqfB87R/ixjdUyJslY2eNSVcdbcZGverxxneulKu69+1LxSgXSsEdJ4eYBR/m+DfrgOIAWJSkGSBwvSSIUzVKI4TzI6lIF9pklVOvCRgv1gvJQ1goqdTF7IW+t4HvtYPMP9EgWZ9MPHt1gP7n8aNOAu7m0RecwlaiNbZh8ytwcwrpfZwrbZEKZ7eUhjIiCs6RoL9SNs0ulGmls59RHmej0LOkhFm42VccrzOHT9UKIrhjIDxXoaqRvdkSgLVWCqYg3ZupdQOpFpeEJUb66SXzNaIGeuSQn/8/NY70vB2t9YWnWyYsTDjop2ve6iq0v8+kHVLNQ/UpZCUq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7828.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ttff4y2day0GKFr935ZTlBqyGgBrIipLDPl4cAPLYWCMckAW9tjN4GLTF7NF?=
 =?us-ascii?Q?Kl6uKnw0vY8gOz7j1KJ5gwg5rBlbSSy/O0lCrlCLbPorkQTjC1Tkg1vlp1oR?=
 =?us-ascii?Q?99LJyWdILA6li5xo/AkEYSUTHcG3lXuU0bJDUSJusBsbV52ZGoxAFI34At3Z?=
 =?us-ascii?Q?rLhKYXYRZ1wL9d64Zbl9qEOch8rpeJdXdOxmEtwg6Z+uBUQwie8M8Sz8YT36?=
 =?us-ascii?Q?d1ga53IH08xr6aZYsK2twrn3UlaiU6R0O9f/SFIQfmgAForQJkJIL5+TMSUG?=
 =?us-ascii?Q?Co2ODqVJnXgphHqTqenx5WzTLph/+OsARqzDnL1YO0ZJIcS8oqFuAokknHVG?=
 =?us-ascii?Q?4FGJiEKiRRfwLRKHlYWRMGXyj+onqvCtxqWete45VqO4hUeBKsOfcHKpB6P2?=
 =?us-ascii?Q?+wfT61SrISXjabH1TSBV2cKv/sI30S1HapgB3mSvof9zgNVRIfsHe8jc10pD?=
 =?us-ascii?Q?lGYs9AbEanf1Nj3hY5Cmo0BuTKcpLQD31rsyhY/LQe/S10dWiy1tLPsCCCKK?=
 =?us-ascii?Q?AIMFOvVkPa685ekYiq8QjcYF9hmGNbiA2UtJh5G7Ny1gbZn6H6ZSztPvoLCz?=
 =?us-ascii?Q?Y5QaBHvbPPc/XJHU1mAr/hOH8NXJJL9CuBs2IT0Jr6EmZj/h4pMhJpwZ+y3Y?=
 =?us-ascii?Q?y+yq0UXCTPlkk7H+f+Mr3k7atDBABQScv83V+uaKizi+bQOCpyXiOak+Jh5p?=
 =?us-ascii?Q?NU1WoRhaRDld8GUNxtTji5TdedemgKVODXQRPkhRMyKfUxuc20qTo0D9vvd+?=
 =?us-ascii?Q?lw0H96P1xu8ETpEM8FMM067DKFEv/kV/q0TMTR7/dp/ur55KBT0umj95SoWB?=
 =?us-ascii?Q?Bb0MfSXc0g5TMCoDpVRrx/jECr+zUwow/NDrl4eZw/bNXY31+Jb7v2K86Pks?=
 =?us-ascii?Q?aHZk/Lt5wXjkv0FyIu2wZNvD5kZOZALaBDYhcgKCuumVMaj7QyT4uytc3gKK?=
 =?us-ascii?Q?Gs7GTChLvbHLtPeTrk+ekitJxOeG/+hIBIuVPganKpV4sCO9CVA/5YJviemh?=
 =?us-ascii?Q?d+usSg3FPDsdAw6RcWIZpOfWYGGc195xyLGZUJCy0XuugPHT9JbmOKImA4+t?=
 =?us-ascii?Q?TCE6vwNClh3EF2KudG1Byh2urjGGjzHjHutdEmN9ZgL1mcSY4SQCyJyOKvXK?=
 =?us-ascii?Q?13+2yloJilEUeha0qw9uVlf2PYZseL4lgtQQYwFJdgfUFbog9AgoiZ27w3Ez?=
 =?us-ascii?Q?hFF1elJsPso6L23lXVSM4VeH49FXh+uGuKgfi6kUmj/ntSAKVtICYJQTFufd?=
 =?us-ascii?Q?5Dx2jxVWHemvSzAaizk5FC16OP9kiuZw1a6OQwntBCht/s/lZNY7kd1fTAjS?=
 =?us-ascii?Q?gnyhnOvCfqbZu8yirtN5LDRTsLdHqmeiF/JSUIz1zKiByn2sZpZkha+WuhkZ?=
 =?us-ascii?Q?s5YEoB1Ylyye7FIYwTuyx5MeKJRVGZVl07glI7iFpK3A63Xt29lOF/vT8w19?=
 =?us-ascii?Q?/2IWz8fVrNJr0q7vp1B0qfy+fcSKj64fwJnKGKMoBsJedBadivpYz+XRnDkf?=
 =?us-ascii?Q?WpQ5Y/eD6uD3IG1c8mwy67crP26jT2P+V4e7zV07+w97w3TnSCAm12BNmUQb?=
 =?us-ascii?Q?vaCzrT0m/a02OnMF1Pr0EtTKwi97oAkqduDfFWu048IvbbRAcNcnUdv0T0vy?=
 =?us-ascii?Q?A86osxguvlPwfzvvifbSNZ9qHJ9KtElFBPtxhtHZADuaJHg+/El0BBg+ZGVE?=
 =?us-ascii?Q?3mBMGj8tBpHcQs62eU6nAVUg5w95kMnbjfMtBkrECsB1gEU93Oixaipxyuu4?=
 =?us-ascii?Q?mhODPYw9up/o51oy+HZ/oZyzYPe7l5s=3D?=
X-Exchange-RoutingPolicyChecked: ASpEY6qmCP+bplYLShqPokrVywNTOw/ltB1bFYrGWC1RaO2QMFaDIkSMy/QzkLyARRW+0bP7qnJdYBC5Eunl6jzTmiQ53cZDrn/ktqKv5VLZ0uRmyU8OkjiX9o85jfnorH9SM55WZYojsOB13b53kaaRHXIH/V6K1gmvFmEkcncF5WK908oySPQffkBlcVwdMmgJuymSx5ezYqNsHmnN5fsCdMVcjBsgfUT/q+iERNTicg/Hvjm8uR0tUPTNtInWScnmqILIp5sscZ3BsY/4ycRWI/xTavhwdlRntyQegz4WLaZVpu2SIvmUtdpqxXQkCJwQcFEDrJpFAzF/subCFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 191bc09d-57b4-4613-fe6c-08deb5bd02d3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:40:53.5720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXV//1E9Ttn2XNChMQzr7W+HKmfCMAjJOHKhnyAK36JBpFev8LYJCWkPEboIxKU7xg9uk4u6hORAn4vwD9DHZRZIpASfb6jYuHShes2ow6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8600
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

On Mon, May 18, 2026 at 05:02:32PM +0100, Matthew Auld wrote:
> On 18/05/2026 15:14, Francois Dugast wrote:
> > Extend the scoreboard approach from the previous commit to used blocks,
> > so drm_buddy_print() can report per-order allocation pressure in O(1).
> > 
> > Unlike free blocks, an allocated block can leave the allocated state
> > through mark_free() (normal free and gpu_buddy_block_trim()) or be
> > consumed directly by gpu_block_free() during coalescing. Both sites are
> > guarded by gpu_buddy_block_is_allocated() and paired with the increment
> > in mark_allocated().
> > 
> > v2:
> > - Update after fix for use-after-free in split_block() call sites
> > - Change goto label to out_free_used_scoreboard for clarity
> > - Make drm_buddy_print() and gpu_buddy_print() symmetric for used and
> >    free
> > 
> > Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> > Assisted-by: GitHub Copilot:claude-sonnet-4.6
> 
> Could potentially also assert that used_scoreboard is empty at fini(), as a
> quick sanity check that nothing got leaked/missed with the accounting. Would
> also then be checked across the selftests.

Good idea, will do.

> 
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> 
> > ---
> >   drivers/gpu/buddy.c         | 39 +++++++++++++++++++++++++++----------
> >   drivers/gpu/drm/drm_buddy.c | 18 +++++++++++------
> >   include/linux/gpu_buddy.h   |  8 ++++++++
> >   3 files changed, 49 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> > index de18b63fef0a..f81d0d8fde15 100644
> > --- a/drivers/gpu/buddy.c
> > +++ b/drivers/gpu/buddy.c
> > @@ -194,6 +194,7 @@ static void mark_allocated(struct gpu_buddy *mm,
> >   	block->header |= GPU_BUDDY_ALLOCATED;
> >   	mm->free_scoreboard[gpu_buddy_block_order(block)]--;
> > +	mm->used_scoreboard[gpu_buddy_block_order(block)]++;
> >   	rbtree_remove(mm, block);
> >   }
> > @@ -203,6 +204,9 @@ static void mark_free(struct gpu_buddy *mm,
> >   {
> >   	enum gpu_buddy_free_tree tree;
> > +	if (gpu_buddy_block_is_allocated(block))
> > +		mm->used_scoreboard[gpu_buddy_block_order(block)]--;
> > +
> >   	block->header &= ~GPU_BUDDY_HEADER_STATE;
> >   	block->header |= GPU_BUDDY_FREE;
> > @@ -281,6 +285,9 @@ static unsigned int __gpu_buddy_free(struct gpu_buddy *mm,
> >   		if (force_merge && gpu_buddy_block_is_clear(buddy))
> >   			mm->clear_avail -= gpu_buddy_block_size(mm, buddy);
> > +		if (gpu_buddy_block_is_allocated(block))
> > +			mm->used_scoreboard[gpu_buddy_block_order(block)]--;
> > +
> >   		gpu_block_free(mm, block);
> >   		gpu_block_free(mm, buddy);
> > @@ -398,11 +405,17 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
> >   	if (!mm->free_scoreboard)
> >   		return -ENOMEM;
> > +	mm->used_scoreboard = kcalloc(mm->max_order + 1,
> > +				      sizeof(*mm->used_scoreboard),
> > +				      GFP_KERNEL);
> > +	if (!mm->used_scoreboard)
> > +		goto out_free_free_scoreboard;
> > +
> >   	mm->free_trees = kmalloc_array(GPU_BUDDY_MAX_FREE_TREES,
> >   				       sizeof(*mm->free_trees),
> >   				       GFP_KERNEL);
> >   	if (!mm->free_trees)
> > -		goto out_free_scoreboard;
> > +		goto out_free_used_scoreboard;
> >   	for_each_free_tree(i) {
> >   		mm->free_trees[i] = kmalloc_array(mm->max_order + 1,
> > @@ -464,7 +477,9 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
> >   	while (i--)
> >   		kfree(mm->free_trees[i]);
> >   	kfree(mm->free_trees);
> > -out_free_scoreboard:
> > +out_free_used_scoreboard:
> > +	kfree(mm->used_scoreboard);
> > +out_free_free_scoreboard:
> >   	kfree(mm->free_scoreboard);
> >   	return -ENOMEM;
> >   }
> > @@ -505,6 +520,7 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
> >   	kfree(mm->free_trees);
> >   	kfree(mm->roots);
> >   	kfree(mm->free_scoreboard);
> > +	kfree(mm->used_scoreboard);
> >   }
> >   EXPORT_SYMBOL(gpu_buddy_fini);
> > @@ -1505,15 +1521,18 @@ void gpu_buddy_print(struct gpu_buddy *mm)
> >   		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
> >   	for (order = mm->max_order; order >= 0; order--) {
> > -		u64 count = mm->free_scoreboard[order];
> > -		u64 free = count * (mm->chunk_size << order);
> > -
> > -		if (free < SZ_1M)
> > -			pr_info("order-%2d free: %8llu KiB, blocks: %llu\n",
> > -				order, free >> 10, count);
> > +		u64 free_count = mm->free_scoreboard[order];
> > +		u64 used_count = mm->used_scoreboard[order];
> > +		u64 block_size = mm->chunk_size << order;
> > +		u64 free = free_count * block_size;
> > +		u64 used = used_count * block_size;
> > +
> > +		if (block_size < SZ_1M)
> > +			pr_info("order-%2d free: %8llu KiB, used: %8llu KiB, free_blocks: %llu, used_blocks: %llu\n",
> > +				order, free >> 10, used >> 10, free_count, used_count);
> >   		else
> > -			pr_info("order-%2d free: %8llu MiB, blocks: %llu\n",
> > -				order, free >> 20, count);
> > +			pr_info("order-%2d free: %8llu MiB, used: %8llu MiB, free_blocks: %llu, used_blocks: %llu\n",
> > +				order, free >> 20, used >> 20, free_count, used_count);
> >   	}
> >   }
> >   EXPORT_SYMBOL(gpu_buddy_print);
> > diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> > index eef995e08a37..1536e59c6fe7 100644
> > --- a/drivers/gpu/drm/drm_buddy.c
> > +++ b/drivers/gpu/drm/drm_buddy.c
> > @@ -47,17 +47,23 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
> >   		   mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
> >   	for (order = mm->max_order; order >= 0; order--) {
> > -		u64 count = mm->free_scoreboard[order];
> > -		u64 free = count * (mm->chunk_size << order);
> > +		u64 free_count = mm->free_scoreboard[order];
> > +		u64 used_count = mm->used_scoreboard[order];
> > +		u64 block_size = mm->chunk_size << order;
> > +		u64 free = free_count * block_size;
> > +		u64 used = used_count * block_size;
> >   		drm_printf(p, "order-%2d ", order);
> > -		if (free < SZ_1M)
> > -			drm_printf(p, "free: %8llu KiB", free >> 10);
> > +		if (block_size < SZ_1M)
> > +			drm_printf(p, "free: %8llu KiB, used: %8llu KiB",
> > +				   free >> 10, used >> 10);
> >   		else
> > -			drm_printf(p, "free: %8llu MiB", free >> 20);
> > +			drm_printf(p, "free: %8llu MiB, used: %8llu MiB",
> > +				   free >> 20, used >> 20);
> > -		drm_printf(p, ", blocks: %llu\n", count);
> > +		drm_printf(p, ", free_blocks: %llu, used_blocks: %llu\n",
> > +			   free_count, used_count);
> >   	}
> >   }
> >   EXPORT_SYMBOL(drm_buddy_print);
> > diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> > index a28f7d7637ca..e037714563d8 100644
> > --- a/include/linux/gpu_buddy.h
> > +++ b/include/linux/gpu_buddy.h
> > @@ -180,6 +180,14 @@ struct gpu_buddy {
> >   	 * called on a free block.
> >   	 */
> >   	u64 *free_scoreboard;
> > +	/*
> > +	 * Per-order used block scoreboard: used_scoreboard[order] holds the
> > +	 * number of blocks of that order currently in the allocated state.
> > +	 * Incremented in mark_allocated(), decremented in mark_free() (guarded
> > +	 * by gpu_buddy_block_is_allocated()) and in __gpu_buddy_free() when an
> > +	 * allocated block is consumed directly during buddy coalescing.
> > +	 */
> > +	u64 *used_scoreboard;
> >   /* public: */
> >   	unsigned int n_roots;
> >   	unsigned int max_order;
> 
