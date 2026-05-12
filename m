Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD2CCD4855
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 07:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266A610E98E;
	Tue, 12 May 2026 07:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XHXn0K2w";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85FE510E984;
 Tue, 12 May 2026 07:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778569510; x=1810105510;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gFxOUTdHi1ON73eyqP8Zw6VdThM/NXOLTzVBCu6I1aQ=;
 b=XHXn0K2wkYr4o8McAVB/9Bo2yFBYT/nqVnia7C1bA67okgXcV2vxTp3L
 tWqv7qHb4sYZ7ERnZpETreqcmsPZpMYsCESU6otNwZxsSVfJPAbeDa6QK
 tn4mKeeqrrAYLEp8pWu0xSxE0+msQUiAAIEG/WrQhCniK2ggc//gA0VRI
 0qtQoJOZI9ElvvX5QDC3VkYlR9OZQ6JkBbnEP48VkBCGG7A0X1fnHfibl
 S+Ctp3myTsuidH56usn3wQW/pnoqtIM4dnaZMYJYVCkfSt97XbfIXptmx
 2r2/mQbm2sQPexsjlggSKb+jK6ZghsKh8BFcAxER6rGY8wrRTKC9Xa2GV A==;
X-CSE-ConnectionGUID: vfyx9xKVQkO9+fl2BoPf2A==
X-CSE-MsgGUID: LciBiiYOQyGHs4EzH6y1bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79501140"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="79501140"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 00:05:09 -0700
X-CSE-ConnectionGUID: uWEtV6ywTwuRKcT1BtLYJA==
X-CSE-MsgGUID: kmJqgkzdQPqgrmD/qeGKsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="241676599"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 00:05:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 00:05:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 00:05:08 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 00:05:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6JmRbthUQzvm3zxYBPmSguKA2jFGNknriD7DI69H6ycw2D45LFTsNg5OzSuZ3QjD2KMZNy+JmsxkTecaGQi2CMCnnjuqaS+GYHnLhWpoEugdwlsiiFP+y5Bfd9Wx49ZSLTjJAS7lBQ2MhRKQoiWv3PpAltcHsSjdEZbM/aVtUAuwmgPqxmYbCKjcon3zrnHRIClQh8orL/6B7cRT+IHmPBdEA6pfGxfE+BOzWzU5OJMuKJgJMpheYhqc521I6Kh50rI8/1R8V9PmHKz4S54fwQkRdoyUQdDyXucX1umd/U+Hdb4Yc7Q6l1B11a8qG5q32QWOl74bNKNiamHFK2acw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eE+NR11Pogozf7pIScHpKFz14mQVeVxN+hhLoVak4Y8=;
 b=hjI8Ooe/HIcl947nGKu+39dPM3AnIXWiYH0YulN8x1250cngYdHnEyzBkZKAdiA2AZJSyevenltkk7ZSwYz5OdmFOzUeVklNmCfJbiESKaRYGviVhtWQPXvNujc8BN0Z4fADWiiP996Gt7el7lIHI7okwvOdIOnBj2oOAcEV7e9c5Hb1FccCDg2yvU2sEbcA2w1ySLN10vzJFL4R2qQlmECK9zazklswZt/XOoAorwAotfJ5yEnbTnaUS4nxpp1WAhc2ckPGrwj/QKqZEf1xo1GiJ6uHJm1A2CgQQp6VA6t9ZldD5rUbxwkUAEBXw31q8XLyC27nj83mPSqttetAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 07:05:01 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277%7]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 07:05:00 +0000
Date: Tue, 12 May 2026 09:04:54 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <dri-devel@lists.freedesktop.org>, "Paneer Selvam, Arunpravin"
 <Arunpravin.PaneerSelvam@amd.com>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] gpu/buddy: Track per-order used blocks with a
 scoreboard
Message-ID: <agLRDPOjJD_-u00y@fdugast-desk>
References: <20260504135343.1797869-1-francois.dugast@intel.com>
 <20260504135343.1797869-3-francois.dugast@intel.com>
 <fe332774-5678-4b9e-8453-49355de1f773@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fe332774-5678-4b9e-8453-49355de1f773@intel.com>
Organization: Intel Corporation
X-ClientProxiedBy: DUZPR01CA0342.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::26) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|PH8PR11MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c6ebff-31e1-4db8-a6a5-08deaff4c8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dOjaCpZzudb0W5l3dRH97jKGJPIthIQ/Oa513KwgFCGAc+p8PZ/7GJe96Vh3hyl8pyugMKYpdrvIWuqxldG4KeKstKUJAhiyc7duPPc4g/j35zaNKMurcMlP19IC/Bdn4AIpRBXZcS85FK4raSmI8J06zUzGuvbjHkYNbaagXLRn5H9khM+iROTxsjBNL5wh9jrJDx5FHICVY4DIbTqfEMLOk5brWSn0YuS+Dh95WNh3bXglcfpGUEet9N70IJUIc0NwHmpDlWQxkmiUL65HqmL/6J1KU8eNZhHUlm1v0f34Ci6AJ8wDl7QhawtXZDWmyoEGDCCnay3c+Onz/29FJZTOa6xAlIldN2OkDQ7Mt38shpG/ChVUUqOLwjdCcVyFIcNe0SeyCpRWt5uvzgS/+Jdwh0w3oSFNU/OpjjM+s5yEiMpYT02Z2qSyUgsuTvSoVE37jGE1nvE+0Ox3l9NFpZ82zxHu/VcWX1x8EP3+VQHgrAI5egVwnqHJpTYd6m0bn1sk4sy5MhxXto9N5MSe0HuXn9ZWlQkq0xkMqRYuIGCRzm8qBwQj0iJzYh7E+QpEZyK5jvbb00hYmEErEcSNLVrfepdsym0JzkGtsP6N8b/h8lGIDM1eUnD323wvPd9o+hOqkTyh0VVWh4XtBvuXqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7828.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wkBrJ5eQklU1fMowNMhThMi2yvI7KyxBYnr0GpTpa77y4a6A4zcAC+OGw1kY?=
 =?us-ascii?Q?kP2wmhnhDnAmmPwNvV0tbcMLdtNtuoRJhebara6IMVLC6lhDGQS0p42eSuLK?=
 =?us-ascii?Q?i134lBQT7gUnvjsE5km01w/SgWa2/Rjp6xI88lGPoUP8H1M/chIVEQ8Mpz3y?=
 =?us-ascii?Q?skpwOCisheSk9VSLqX0KsZDNdfqvHxTlhnsIMKiZEz2CmdIUAi8DVE7wp4SL?=
 =?us-ascii?Q?uao4/XR+0ZLURviiFYObqu52E/ZC3IZcBAlrytyCJTtbWKcE69DA0Nd8yVVd?=
 =?us-ascii?Q?9aPJURoUfCP21aqX7fnZ+ruHsrcLMZem1wFw2xXYbDDjxXLJt7Tq3QNKE548?=
 =?us-ascii?Q?+pHcZbWJNQZz/GMUdz5iknzvRsYq8I3vzZBpYp5E/SxX02k5mkjkUs1tiYdq?=
 =?us-ascii?Q?YYY9RUMactK0gWJ8PfZL/ayAUTnrhZNiS3+i3D0XonfZ3utzuiFa4nabcphT?=
 =?us-ascii?Q?9X7wRuOw3+tDwsn2Xg85NuaIwGNUv6BPy8LUOa7b0kc44rMSaggxOqI67LPA?=
 =?us-ascii?Q?dlUho+BH6sghOgf90/Q7IPVEZKUDYn8M0A0KuanONpqBQO16z97/uk+FpDVK?=
 =?us-ascii?Q?yIBOqxmVps2BOXvOQVlsiytjfgBXRQTCYhU+aJAoJZCmcMgDZ4H/pnp1fdUO?=
 =?us-ascii?Q?nHs2UxCx4m7TL1T1IF+3/z9VXaXWbqSjAoyXj8uf5IYuZjQYnLpStjYvww8C?=
 =?us-ascii?Q?hO4X+gLRNBh+k1+0eTu88wTNBVHUKJtUEdBTGMu+4a3zOUMBmdapTT+jc171?=
 =?us-ascii?Q?R/VSp/ydjLuoy6EDU73kRGOMst3JPXxr9HLKMu9fkQxLFj9s46oYEEgYpDW7?=
 =?us-ascii?Q?W5O5txrTxVuo/4YZCuTS8PUz4oLgZ6mySLHQMgvj26vYRtO4D/aKEoXRf0Rx?=
 =?us-ascii?Q?miND7fwQZhM7JvBFGmUE79rKc/27bZhVWWlefkRld0b30Vw2ktS34GdfGj2A?=
 =?us-ascii?Q?kRpAtrR/8fIdIIsOR+De33lKxF6Tt0Y0gKbi6pk2QJdBvHhR/66MKwmby/5X?=
 =?us-ascii?Q?srG/hzuTX5bvR/xL2kxawbKVD4eBIvl9uc1GOT0LG6InAdFRhootodgYKFg/?=
 =?us-ascii?Q?/bD95j4q3VfOzB4e5Zmjl9C8KOcUT6EkYss+rk5zJvGSe1lVvEnrgpsbzBQv?=
 =?us-ascii?Q?RMzRHFUzGWDtbr3nU5u1Ff9hy7ctlLz5zuKKskvJ/VFX66k0iin97/CKwa6g?=
 =?us-ascii?Q?m92K7/VxvdGptujeL+yya5z/WyFHzUsa3LSClaBeTR3IG3U48yiyc2rcg6TO?=
 =?us-ascii?Q?9Z9uTdhKj+efUk4irKnrEPky26ZTwcRb+dWE1FJhlozuu5qFNrSSu0YadSCi?=
 =?us-ascii?Q?CAk+ImQn/jlY5KSy0IecyNtB90ksYwB80ZyFy12KbVSK6j+ASABXsuFA+kqt?=
 =?us-ascii?Q?7qXnbETJUOWT3szt0RYKNpmyyngW5Cpp6ns2QBinpq+WzuFm87KdWz8OAHc9?=
 =?us-ascii?Q?N/1mASAPli8v5HrE2hbap9WgsKj6cYPFNoXCSpsaFrDKJ5e/gxAyhPmFofi8?=
 =?us-ascii?Q?3tJhXk2GIndMe9GZn6KwjDFrhA2ztJj1Dxx7rKn5TuixlFQ2D26RtTTy2vKI?=
 =?us-ascii?Q?uhPaTTmamaU6wVnb9jSGAY6AErEfYj14AY9wUkxmNkLhOcuVW7Xsv/GWvPx4?=
 =?us-ascii?Q?Eeadamd+xpsGT0ziQ5R/X4FybbxeYe8iVZxUp5+hLfAbZYogbwEngs35aAXR?=
 =?us-ascii?Q?jDiM6gNHFmTvDwlvj51eUwlcYTLd43FRrTc1+IRyZDJoXJ7OlVj7nlOYdqGY?=
 =?us-ascii?Q?1NUuAriLhsHeCxaV0vVpzspI0cz7kl4=3D?=
X-Exchange-RoutingPolicyChecked: OAuCnWh85ZDvwcLM6yG4WZROLL6aI02oGcfhxcHx7fwod3SBgCZup+PhArol0CUJ6NgooijoLUDBNBuDeVU9pvg2Bs3tkeTBs9zGd8BsdlyqfQ6616n57W14iPQW9i9uVn84RXTitEAUq0HWH7d2lr2axHytO0w9TUO/w2pYQd6gKwWQNhC47h58wYHalMU94eKeV9h5Zn39DWjr4yUlU9YOoPUiqF1oOJjiWlYOmZCvS4v/gRtUzJvvPvxYNxyTP5+lFbD+K+vPIrPK1Hwpv4oMPGIScSoVvwlvlpFU/iLu/y8zMbxO6TshLySao3rlIXj001rHDmR6FdOsZAtA4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c6ebff-31e1-4db8-a6a5-08deaff4c8ad
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 07:05:00.8584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvjudOPfYpvMcKvMuSWh9G/a0DLv2llqBbs01scqxJ7GlzAfXlWl+TnxY6SNW6OEOjUAg2KGt3t+6LAtp6An/8SAhWyoBEbiNgrUDNDm8pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999
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

On Fri, May 08, 2026 at 03:13:04PM +0100, Matthew Auld wrote:
> On 04/05/2026 14:52, Francois Dugast wrote:
> > Extend the scoreboard approach from the previous commit to used blocks,
> > so drm_buddy_print() can report per-order allocation pressure in O(1).
> > 
> > Unlike free blocks, an allocated block can leave the allocated state
> > through mark_free() (normal free and gpu_buddy_block_trim()) or be
> > consumed directly by gpu_block_free() during coalescing. Both sites are
> > guarded by gpu_buddy_block_is_allocated() and paired with the increment
> > in mark_allocated().
> > 
> > Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> > Assisted-by: GitHub Copilot:claude-sonnet-4.6
> 
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> 
> Note that Sashiko found an existing issue here: https://sashiko.dev/#/patchset/20260504135343.1797869-1-francois.dugast%40intel.com
> 
> I guess would be good to fix that first, in this series?

Yes indeed! Please see v2.

Francois

> 
> > ---
> >   drivers/gpu/buddy.c         | 29 +++++++++++++++++++++++------
> >   drivers/gpu/drm/drm_buddy.c |  8 +++++---
> >   include/linux/gpu_buddy.h   |  8 ++++++++
> >   3 files changed, 36 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> > index d831165e87ea..ebef03613b3f 100644
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
> > @@ -398,6 +405,12 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
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
> > @@ -462,6 +475,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
> >   		kfree(mm->free_trees[i]);
> >   	kfree(mm->free_trees);
> >   out_free_scoreboard:
> > +	kfree(mm->used_scoreboard);
> > +out_free_free_scoreboard:
> >   	kfree(mm->free_scoreboard);
> >   	return -ENOMEM;
> >   }
> > @@ -502,6 +517,7 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
> >   	kfree(mm->free_trees);
> >   	kfree(mm->roots);
> >   	kfree(mm->free_scoreboard);
> > +	kfree(mm->used_scoreboard);
> >   }
> >   EXPORT_SYMBOL(gpu_buddy_fini);
> > @@ -1496,15 +1512,16 @@ void gpu_buddy_print(struct gpu_buddy *mm)
> >   		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
> >   	for (order = mm->max_order; order >= 0; order--) {
> > -		u64 count = mm->free_scoreboard[order];
> > -		u64 free = count * (mm->chunk_size << order);
> > +		u64 free_count = mm->free_scoreboard[order];
> > +		u64 used_count = mm->used_scoreboard[order];
> > +		u64 free = free_count * (mm->chunk_size << order);
> >   		if (free < SZ_1M)
> > -			pr_info("order-%2d free: %8llu KiB, blocks: %llu\n",
> > -				order, free >> 10, count);
> > +			pr_info("order-%2d free: %8llu KiB, free_blocks: %llu, used_blocks: %llu\n",
> > +				order, free >> 10, free_count, used_count);
> >   		else
> > -			pr_info("order-%2d free: %8llu MiB, blocks: %llu\n",
> > -				order, free >> 20, count);
> > +			pr_info("order-%2d free: %8llu MiB, free_blocks: %llu, used_blocks: %llu\n",
> > +				order, free >> 20, free_count, used_count);
> >   	}
> >   }
> >   EXPORT_SYMBOL(gpu_buddy_print);
> > diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> > index 7839b54d3da7..3a1cb06923c6 100644
> > --- a/drivers/gpu/drm/drm_buddy.c
> > +++ b/drivers/gpu/drm/drm_buddy.c
> > @@ -46,8 +46,9 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
> >   		   mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
> >   	for (order = mm->max_order; order >= 0; order--) {
> > -		u64 count = mm->free_scoreboard[order];
> > -		u64 free = count * (mm->chunk_size << order);
> > +		u64 free_count = mm->free_scoreboard[order];
> > +		u64 used_count = mm->used_scoreboard[order];
> > +		u64 free = free_count * (mm->chunk_size << order);
> >   		drm_printf(p, "order-%2d ", order);
> > @@ -56,7 +57,8 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
> >   		else
> >   			drm_printf(p, "free: %8llu MiB", free >> 20);
> > -		drm_printf(p, ", blocks: %llu\n", count);
> > +		drm_printf(p, ", free_blocks: %llu, used_blocks: %llu\n",
> > +			   free_count, used_count);
> >   	}
> >   }
> >   EXPORT_SYMBOL(drm_buddy_print);
> > diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> > index 250841ca4bcf..b1cad7833dc1 100644
> > --- a/include/linux/gpu_buddy.h
> > +++ b/include/linux/gpu_buddy.h
> > @@ -179,6 +179,14 @@ struct gpu_buddy {
> >   	 * mark_split() when a block leaves the free state.
> >   	 */
> >   	u64 *free_scoreboard;
> > +	/*
> > +	 * Per-order used block scoreboard: used_scoreboard[order] holds the
> > +	 * number of blocks of that order currently in the allocated state.
> > +	 * Incremented in mark_allocated(), decremented in
> > +	 * gpu_buddy_free_block() which is the sole entry point for freeing
> > +	 * allocated blocks.
> > +	 */
> > +	u64 *used_scoreboard;
> >   /* public: */
> >   	unsigned int n_roots;
> >   	unsigned int max_order;
> 
