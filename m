Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D015ECD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 06:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A43610F20B;
	Thu, 30 Apr 2026 06:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X0YE2Nt8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3220610F20B;
 Thu, 30 Apr 2026 06:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777530217; x=1809066217;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GYx60uaRlQGW0EsRTMLa7CsUXvd8xj5mNuxoKzqzuxk=;
 b=X0YE2Nt8p/Pp1CMRTrVCIdVfRRKiulBYxA5Iikw72juajx2RG7rDET5P
 OXhyTT2uRNuKETeiN+DHaN/KwAqHm7v3h/59NBSUj2FrGE2i+soH+bpTR
 iMvXqg+G1jojckgAE3uHZvD3AFn0YYL43Dt+AiRJ0G4JhQI8lE5SbNeRt
 AbZfrchN2dlVJdYYH5Q61aKwYhKcdWPKN5JJkEEOwnsJkiM2n2UMXaUva
 lNjyBOmXZiZDVBcfCbr+On6VbSwRDSIaAkDS3AKzoE58iJNsHQ77ve0Vo
 j0kdqTFSGRbbYm/TbCsDYnM8mXuRWYQ7NOeEh8z3MDY6fwPgq0ZGxbqcc g==;
X-CSE-ConnectionGUID: qW/V4cKZT5KbgtoHUlFJ3A==
X-CSE-MsgGUID: LTAanJ8oSSK8C67IblnLDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82078976"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="82078976"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 23:23:28 -0700
X-CSE-ConnectionGUID: zlmd4GFhSVeapKETjqManw==
X-CSE-MsgGUID: oC/cVWsnRfi5cSQgMJRWyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="233647844"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 23:23:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 23:23:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 23:23:27 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.35)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 23:23:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THCHJMlTlS80LSQtoDN9JJ8WM1onwOF5zq0jWFuRwGNS+XRbNZaLXKTYaX76SJqWQ3/he2FAOzI0UGPV6pRINYaDG+yT2GllrRNLrXX4d/GY12ZV4me4EMIQBn12yCEoJi+1rFCtpXf1j7Bc6d/Lq89Tiabkt3hSRCX+Jsbh+sYJIKRGfN5nTxD7cb0sJ8HZcNQZ89PySkcrVtma6b1C5PD5zKKmXqEJuA9Sa5O92MbMFWBrxtHqxQNuBZtkVO1V92qTflAkRA8FlkRWfct8BhGQv9zRu7wzuOj5VQ38bJE0vNYqfi4PUHGLNcTocBu8dMvZ2lTnnqhhjv1/Pndm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+WypYH/B/rSIxQV/WA3ZbyhXALFZzFkVsbNabYGh2Y=;
 b=lHDjIFUJovGgimQLl0QQAd61J1MTgMb6C1j7KFalOMZRpOB+w2qh1BzpGr76e3XCa8C3AlvpyYkYwotSZVCw+P06n5hQ61/4L1j/72AuX0FInIfSz3uBAvfvBUYtRCgbT8y2Db7301iyM+u9sXduhWsTvS6l+xlnIi7JMczoi4VZKBMN+jDhawj8ZAqgt1mFCx2MpcXD4+IVoHwVBDEG+VafiZeKn3jsvovF+IaxfoIw2SyCWUnx117d3bGBHA+dN3GcSmI+cnDMjAfLb+cEBPH/ThepDDjQte30XatzhBN21sC38b/kaYxI84vatI9aPUfwUw/bdP00OzzeXrMbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA3PR11MB8001.namprd11.prod.outlook.com (2603:10b6:806:2f5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:23:21 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 06:23:21 +0000
Date: Wed, 29 Apr 2026 23:23:17 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, Christian Koenig
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Matthew Auld
 <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Colascione <dancol@dancol.org>
Subject: Re: [PATCH v2 3/5] drm/ttm: Introduce ttm_bo_shrink_kswap_fragmented()
Message-ID: <afL1VbG9HNDnA5Rq@gsse-cloud1.jf.intel.com>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-4-matthew.brost@intel.com>
 <afCGat6ADLrHYEIn@zenone.zhora.eu>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afCGat6ADLrHYEIn@zenone.zhora.eu>
X-ClientProxiedBy: SJ0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::12) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA3PR11MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 8346559f-98fe-4cd9-66bc-08dea680fa03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yA08jlGcHbebeY1ku4db36Fc9TJnF8sgntz8wQKRMbUjIWVbJTvkUXVhkflOU+YBrFegaPW+P2dlZHmPTyTM+LkqFCoJckveJ20xXlc6CLDAvHo3NsMXF3DKGw+3+aPV0YL8StgOLakhpGyMW7s8qbbFy8eBXMDAk9/XkYtf3iJ1lP7htKEp8+aEOqn8UqLGVKFZgCxR5v7sOcwKlTH7t0SROXCTzLcvBL8NipFD1JXMHaITYlTuDkIHyzUlbR/hVKx/uQ00O1tdYZR7rftRVhS4f0qZGGsDR/QfDp2bcn2AGQrx2frgwbc2MlFegaH3BR9EkiohpbU7Cq6JFwUUKQL0DpU4QNXklscEcBQ7teSqvIR5TqmwWeMnp1nnWdBqljZXxpGdcL4yOiyhaMQMLgKeH7Tz7UeA2b3Tj3mitppyi5QEv/L35WV8NWQ8UazQ4leTQqbso/U5J/rSiwrI5rJnUF5cTK0ckzDUxztvZPjfIWMGo89ijrf1K6WyDAe6kFqsEuRTiLmUhldYuddh3gkCBZLqPSCvZN/+YEJWxeYHBhH29kul5NnHYsOR1YKWEqXSQ8NzSR0NQjnHDZ4v0XOIFgo/TaCfq6n752m5uPI264cAU9eesCKwz2oGf4HU4wN5beydiG5l2rSX1aUgtEcMwFQ0q5y3MR0cqeJQuf20hFXGSbAO5+k8A/T82ZGACOpJMxJYHwlV1OS6YaZomjRVkMN7XXQJOIVrJ2M0r7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y+Eqvx+lZqTBtBfH0MUSk8jK6ADdXmjgkMAZerCpZIBLLrFPIbMZ3X54HcUG?=
 =?us-ascii?Q?IVOrbLItp2xD6ryxoA2LXefnQNZswYgsNBb4MIFhtAZwrAWVZrYpzkh6e8xa?=
 =?us-ascii?Q?Ifxp9bJ0JGTrbVcGHPft7Z1M3tn89sjWvUoq+lnnpwom3Rvh7CvG9Wo1VvEe?=
 =?us-ascii?Q?kXz4gX0aKuTO8X6w10idAYC2TeY7KRRt09zuBUYsTblh3+EviBW8Ljv7i7QI?=
 =?us-ascii?Q?9Kuc4V576uOruk+x0iHS8GRWW28Xr8tUUEzPJeT3HqoasO+QdOsTs9fTFJuy?=
 =?us-ascii?Q?DYtLqun2zQ2V9F2/pNHvOM4a+25v8yNle4wgSusNXMS6h1vA/gfUtLSTyQxT?=
 =?us-ascii?Q?jLtiuLxOEHhiIJninOj+Z7+vLa+SCod1f49mBaHJd4fmwsq/sozmBBTStOT1?=
 =?us-ascii?Q?zBmEh5NsD/uvwEoyrdsb5a7t3BwuvRU3q+FWNiUdTAY0Wj92enuslp6t7vZ5?=
 =?us-ascii?Q?tOkknUFtboTZJQ0sunbTcYHc3OpMA/a/IqUL6svZBF//0xvYXjPyJSmApx4h?=
 =?us-ascii?Q?J3/4012F8HRx80e+vfdfzlHcnnPXg1KfYonUPTnZ4couF7/dz1tWlart0gvh?=
 =?us-ascii?Q?Nq1dvtDwPqsu++osVDM4GeX5iplkOlMG98s5nI2CtPFj/RIXFBrte+a94xwF?=
 =?us-ascii?Q?5ECjVaDw+LwzlRVatFkDu5QBN8bZmFUprmaYmdgv7I4KJ8vLRbaJs6OD0eMw?=
 =?us-ascii?Q?hL4N7s4K8jwSnt2GlVbG0U1l1Y79HYeYfG5328QULRBcX1pU0SFDlm9141/l?=
 =?us-ascii?Q?wkGHZUBPBQJjFoY++hGD6BsdkAmCth/ZDC2A2LKgcfmd9huWzXxwd7PJMO+L?=
 =?us-ascii?Q?y2ORXqNmgzJ5oChfQXea27cQO+69Hr99MK4aBm7F8ouRq+RwQJWeh7EKomIq?=
 =?us-ascii?Q?4FfCHsMtS0DiHS8xjvGoKEvDzi1Ao2YD83/F06aXjwQIeMsMiGLIH2LSoHYk?=
 =?us-ascii?Q?4+mdJydReCMe22VZ/yjBwVSTN9bJRTJEYjOna8WUauruc/kdeyzY+YVGk97g?=
 =?us-ascii?Q?/siNOp0JL52i2G5hbX2TkU5FCZsneEZ8fMlyAr74+BlJn6bPGgZmyxiH0XKF?=
 =?us-ascii?Q?mPpQzwQj00Haf5oSRjgG0hugvRekI0jcnBChWMuF23ofaXdCKTbeLidubibe?=
 =?us-ascii?Q?PG9P7kU0ywO9wnlRPjxsvGaYLKXFNBAO6PNFmZppReCvAtFN5hUnHFrHTc2X?=
 =?us-ascii?Q?LMwcvXAcveR/Smv4Rn6suE1+rwgeVknzItAIKGofE/ET+Rzb4c2cy0q0l3GG?=
 =?us-ascii?Q?c0+w/Hgl4TlRAjp46wzQZumbxFU2LBUBRNTcw5tywPxVNfTAcjIsV8CSkC5e?=
 =?us-ascii?Q?81uyA8GHMopQC64AUzON4aoFq6/ueLii9c2JAtL9r1GvBj4Msg2aZ0TZJQJZ?=
 =?us-ascii?Q?0jS6m9FxI5zN4g77eVffeOtIN5dM5cypDhfpxPDFcq5dwiAiMS+NCG0yoc9v?=
 =?us-ascii?Q?GFX5of9incGVg7J+OmYLCGTSt5NPeky2yoSkeqpFGoWDVT1HvX69u2XmdHjW?=
 =?us-ascii?Q?emHzjj4r9Dsw1s226CdBvnl8TD1VhqSC/hqsZxwMWmVQGEgVO9tWw5hqyl+Z?=
 =?us-ascii?Q?GjaWXEvcEoKJ2gsqoltIFs7i+4fR1NbFsJh1oMeTIqdUkW6LQUmFu3tW6XIP?=
 =?us-ascii?Q?x1O54fUNdIJLqL3fTnTEbNV9IPAewXYQZE/Bbi2kGAfrtX5sroBkucPHthC2?=
 =?us-ascii?Q?SKOaklbWW79SXki713znTtKsb4zjadyC7LnmnUk4VWj+1TCFd8nQgnQA5DAN?=
 =?us-ascii?Q?pZKYzxmxpQ+N7XzIPzbWnxtUMwQjS5E=3D?=
X-Exchange-RoutingPolicyChecked: vjLZYPsTPV7B7UMVg4zbjXx0ihwMNe4Jp6iB6VwsizZ1Qbgyr4FS79XwGYiqB0SesWjz6hztV+zO0x3+jhQU3qNk5oYQq0X/G7jm5J2GkC9vpM6FNZ4PyMDETK6diDGQwZl5vbd+60m5c9+uM6IydHQ8QHjzpep8mnnHGzYtReLqn7+Z+T/RaZQhC/tBkokcUi88mL4toddQ0zURIsR5PWz+q0ASaCfSdMo+a3xPlfgC3Hq2FiryYmRvoiOR+C8EKQa1QQjvRQjRyFwatmHPO3BxwhltJlY0YytV65aqzTI+hfELnxrqtAE8ocq1Y9eSkTL+YJKjS+HUN3d1hcOdOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8346559f-98fe-4cd9-66bc-08dea680fa03
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:23:21.6544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPxyIW7lDjEweim4diYiddroUO1FscvjQPzEZGOwfffCbIhuaZAYQmvIKe86A6Nde7d5BuCKeJhrcJ8B1U3Bbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8001
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

On Tue, Apr 28, 2026 at 12:07:07PM +0200, Andi Shyti wrote:
> Hi Matt,
> 
> ...
> 
> > +/**
> > + * ttm_bo_shrink_kswap_fragmented() - Whether in kswap and memory appears
> > + * fragmented
> > + * @nid: current node being shrunk
> > + *
> > + * Return: true if in kswap and memory appears fragmented, false is not.
> > + */
> > +bool ttm_bo_shrink_kswap_fragmented(int nid)
> 
> This name is a bit to strong and misleading, in my opinion.
> 

s/ttm_bo_shrink_kswap_fragmented/ttm_bo_shrink_kswap_maybe_fragmented

?

> > +{
> > +	enum zone_type zone_type;
> > +
> > +	if (!current_is_kswapd())
> > +		return false;
> > +
> > +	if (!numa_valid_node(nid))
> > +		return false;
> > +
> > +#if IS_ENABLED(CONFIG_ZONE_DMA32)
> > +	zone_type = ZONE_DMA32;
> > +#else
> > +	zone_type = ZONE_NORMAL;
> > +#endif
> > +
> > +	for (; zone_type <= ZONE_NORMAL; ++zone_type) {
> 
> just start with "for (zone_type = 0; ... )" and you don't need
> the ifdefs above.
> 

I don't think that is correct. Zero could mean ZONE_DMA which is not
relavent here.

For example on BMG + raptor lake system, it clear ZONE_DMA is used.

cat /proc/buddyinfo
Node 0, zone      DMA      0      1      0      0      0      0      0      0      1      1      3
Node 0, zone    DMA32     20     10     11     14     15     15     11     13     13      8    232
Node 0, zone   Normal    876   1782      6      5      4      4      2      6      4      2   7107

Matt 

> Andi
> 
> > +		struct zone *zone = &NODE_DATA(nid)->node_zones[zone_type];
