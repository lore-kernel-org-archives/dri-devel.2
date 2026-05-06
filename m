Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC93CD3427
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 02:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B1C10E4D3;
	Wed,  6 May 2026 02:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OcT9WUW1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E94610E4D1;
 Wed,  6 May 2026 02:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778035180; x=1809571180;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JLEin5uu6wK+r+yKoWEqmEEuPmh9mLlp0ml5T4Tr5lk=;
 b=OcT9WUW1l7icN41Gga2FlAbmsiKRBiJr74x0uzgV3musAhdDsizlJDCY
 2V8TbI3tQQ34DQgAXZDKsQ2XOB+dlKhhoOm6Lzs9lhBJJSMN5SFGfi4xl
 nnWNSJulvpRJRLU3P5+XqAa5gH9FR6Txrw64q4hMCf/JBm59fX7gQFnAY
 TDAsFjo+GCXm1HsRu8asCSWLSwbWfbWAYOnakWw8ohgzLZ521uPg/ZtdD
 nbQqJDnmri4zqxKyHw9sMpu0kJTogJK/y6mqVlZbUv7SQUMG0uYgHRCS7
 cH5BD8w5SLSP9AuRHN27aU3wxitex5sg9TqQFheudnqpfSR3C24kJeI/a g==;
X-CSE-ConnectionGUID: X9VR3ZqlQF+6aK8uRxnbYg==
X-CSE-MsgGUID: uXc7xn6VRPS8mh62Z12cKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="79020445"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="79020445"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 19:39:38 -0700
X-CSE-ConnectionGUID: dXC5s2X9RVSW7utveQHRtg==
X-CSE-MsgGUID: EJ4B7RoLT2+Z5jTZNDOq3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="236236091"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 19:39:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 19:39:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 19:39:37 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 19:39:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tfl1B9zfpXdvYo9PWaPhJMtSMwDC1Ez7HhbDNWc6Fmi+wc6mmNAz7EtYt6RmXrrBIKvAOdi/jliUQealOE7c1jbsINgit8fZOigYbKGusYl94I1DmmPx5FlpsUL9i56eptMh5Ep06FYhLe0qUoWMX2lFXcqYKEYmR07eiMCHZeuwVVrf4efFEto+QpcVuUS67OxI2USg9YamDPxUaf2Tb3cAidp9M2WSXwVGsoQQzo28QrxIP4PyFfqOi/Hi6op/xd+5k438FVgbIUNzrdve58Jg+WuwiEnI3O9T9ManhU1EKRALMdtjgCBSR+h2KmiLKkyuSgSMxbjoj9gSuw4MNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5Txh/oji/8ALvMHvOMbSBFQf2FLoJMjbDnIfwR4SCQ=;
 b=lctcWUiTZWligyq+HrpvvWuB07oVfRzwG+smD2bUj62f2IxWMf8pbyLWqGYp5yVrKLA515kc0z5N5bJmPzHZfGNYeTH6UTicLvUTiy6RAH7Jahowhcs+iSe+f9hV/urX/B3wtvhN0yLAHYmmT+yN8Zhkf3FmzEhDFEyZSMO28hZNRWaWmFNyXj2VGnrQYImUnOYi4J7rzKXtMLC0YXFCdjFn2xgYiHMUvcLZ6Nuw2+r4/m/iWY6ElZGQuyXcDdyxc5pyyU1W5LEODbVhaVgOgY2Xg1JYDTj7+PeUBffdunJmgT4mYpTXOjwlRC1oVXDyD1CxxPfttraTaLUrgI29hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 02:39:27 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 02:39:27 +0000
Date: Tue, 5 May 2026 19:39:25 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Dave Airlie <airlied@gmail.com>
CC: Randy Dunlap <rdunlap@infradead.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, Simona Vetter <simona@ffwll.ch>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, linux-next
 <linux-next@vger.kernel.org>
Subject: Re: does DRM_GPUSVM require hugepages?
Message-ID: <afqp3eF6hvVtL2xq@gsse-cloud1.jf.intel.com>
References: <c36e7dfb-cf62-4d21-a3b1-f54cb43e0832@infradead.org>
 <CAPM=9txXGY7Pv7ge-x3roA422c=Ycefc7Ens20dEiHuKrKR=3g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPM=9txXGY7Pv7ge-x3roA422c=Ycefc7Ens20dEiHuKrKR=3g@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:303:6a::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ0PR11MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 96138a6d-1146-4c99-ae5f-08deab18b137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: tIa1gVM3V6iW+OZiRcEhVDI8lwdT+XVH44AejUA7ZOFfQTUVzH42jS4Y6GbWXB2x8aHDq94MYJ5ymOJoiI41EJwHJ9KiA0aBAR6/K9TEu/kUQUsaiIdr+y8UPdRPdtzIbNR4/+VYwWhMlAlvchOvCrKIa0Vp1dNYhtdjgp4ifqK3uyqVtENrfW47dqyoLRQg3YCrxmbskvR7WpnEyi7zmmj2BcE3C99XJs3+b2HefdctRjJDB1fXifuCp2lMqM+YsFz8ceBE8z/wzG36jRTOo0Tg/RJpTpiXbQZHwsiL69f8yfhbRSXLbX8btGBXeMzX0XqMyjnrGUM/hY/lvJfKotG8XzUljjz5u475G6EoPNILkSuoILDjQMA4SSpVhvUw+L4DGMM5Rj+PShFg4IKrFs1SBa1NMz5kZ0SH5uPSPS6S99XhfDdbXqZo1DI+QeGrvZ+dae4uvJfFilzjmR2iidqAxAUuNDanbH2iI/LgP8PnOWNyo5RCaYN2Q/OVE2pNwUgFf9rBNgs67LTPymLPkdtWXIMA5ATx16nJKBaMqluxH+blUAtHs7MLNpD9FaEo2yUwl9zWZ5ZJtUOYqGGrvksIkTbsE80D26GEU+nXfMfW24/PTawPuf19xtbI/FGQd6IIhO4F17xEvcCXCq5WSoL+am/WWv2voue8uy/YASiIGL6H2+TxoTCrJlF81+9/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LAm6SGxmCC7R1Q4M1qaKKw71XV72YX+krNONja+QCDxcw1HzrejJlnf+uUjf?=
 =?us-ascii?Q?lEyu+z9jJdDMgNl2daJxY2ROdtidduy50wNLwzskZg1unO02kAtcUK8o/Ahe?=
 =?us-ascii?Q?fC7N5TELE6UV3oiNTHPVZu1xet9EtM0RTQf9LoxDphs+//RaCe5wIm9n3tY8?=
 =?us-ascii?Q?P72VBvY9TSaXGvKdb3Dv6hZy4b+g7ZoOStOZ41+PYVKZ6UVSf3W4vE2Y5BXD?=
 =?us-ascii?Q?RHBGvJmcMpOKf7SwV6aL99GPPoDpMDHdD/QI6t0vi4p0/jO31jj/xby4hUcz?=
 =?us-ascii?Q?V2ZK87HEzk5Cc7nichVKXVPJIUultcJJ5lYoKIfWhd+Tr0lVFBZZ9dCFtQxi?=
 =?us-ascii?Q?lYqw3vXIidEC/hJAWz3b4O67/XDwmigra0YDQ3OQKHaBEDxpYVxncqHMPX+T?=
 =?us-ascii?Q?WSJl7Xa0WFUI4M3awfWD+i2vhNTtfMN9gYolsKbtN0iQljISESgJ6BYAtEHK?=
 =?us-ascii?Q?7JkLA/27oeoeVr1c41cuBZrBphz/iXrspmKyd8L0YKhCpbIvdrou5tLaJmM8?=
 =?us-ascii?Q?P/4PM1FdhxdVTqZSfQBk96/ub755er0kRac1ua43MWuWRBr4kjEavLQ/oB5I?=
 =?us-ascii?Q?E7l7taZJGPdKog+KQDvRWHvesTLkWNA+2z5muh+C1lmuq9SYNnFwuGDlZpki?=
 =?us-ascii?Q?91hCoqyy7MAvciM5XZmgPe0FOgnUbs1QK8FoeiHCuTPcBM40xIrbG4VwLC26?=
 =?us-ascii?Q?9xPVg4wKkKEhUNjoSIc2pBov3okO6M4ODce0EyXPcOHM+1eGmmwhbkwo9rtT?=
 =?us-ascii?Q?kf3ReRKq9qyB34quhgLB6Dcal+73bDvayJ7FNvrIjwSGFUQ7J7lSeKLzrvoD?=
 =?us-ascii?Q?BPoFuGs+gfYnAxjbLsJ2NWbgDall0BhstMB1qmqIgNW3De627hrbT3iSd5Jl?=
 =?us-ascii?Q?jIAY9uRPYuaJ0fbH3qR4nv5cT95I7qE7we/CUhNTiQKMm/yA8L4OfBVxL2I0?=
 =?us-ascii?Q?a5Nj954B4vEXaBh5q5u8PJovttiDfdFTsWTGF36jNu2biPFEAv8nbS/H54ii?=
 =?us-ascii?Q?delEmUV7s5Xytn0n2jzqKtj5Cc2zP6g54v7kpmYtF7HPlANiBBXNWmASNPQx?=
 =?us-ascii?Q?niviXm92pOhBCWN2c9yBHAGopSMqbOiZX7peXk70zyX80y01l8Lp9tWOippV?=
 =?us-ascii?Q?Vrq1F6OKsadZJoitPF8LM5bQ6xupQSHrlY7aalz154BzeTMqbWimNXtnnQjV?=
 =?us-ascii?Q?4D5cFKtzLYZje+UuisIQj1qAng8YfuLcbvP8qZP/WplFzsxgtR6kySEjPyLL?=
 =?us-ascii?Q?QFGfWAscEGXiWP7LsGDKBN8M++gB8QHxSsHrRbHM6lFa6UyXx+sPz1o/7w9v?=
 =?us-ascii?Q?QHtpuqv2eGrsGz8wj/19PnF+q2qZVn3qvYkQC5kDegWrvtgw0Xdig/taIt8u?=
 =?us-ascii?Q?fSQRcXmbmsj3woAPC9Pp6UUG90oWvy+kmLcIBOKIaNhbq8fR0Pz7GeURp3eD?=
 =?us-ascii?Q?MdRblDQ2SZab9+bLXW63Tfoe3vLF3KxQ3KQ31y6IFwD4ntG4F3FfCBLVEplx?=
 =?us-ascii?Q?vTdlzNpqyhj27FPQcr03UfPamiLuhbb9L2MEimkqZi1xSsz7sG/xKAA7JljD?=
 =?us-ascii?Q?X7SsR3ZnuHU9VHphXn/Wbe6WOtTTot7/4029GFYDi1xzocYNl4WHpyFYxg24?=
 =?us-ascii?Q?0bzSn21zaxySG6ofY5qMgD0WBEVV46QazuDk46asq2coUUzWEiC50TOhI+8F?=
 =?us-ascii?Q?GJjyqaP9ckI+NJfZX5kL8ugtfvB3PEn29iFiobQvyoVamJhTonBQT8ZGSRNI?=
 =?us-ascii?Q?ecL2rG2pPQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: JOz51lEUtIklzoSDEado0hFM1hFj/AIs6+//tEjD5UNdkkNK9NtrOqtgT7itHJ0kxee5IzgzDzJgmrihkb/tlgXDdKIvlbzYVe0YCRLIIG/CV+gzZWZDlE47gOvaYwdqChJMekkSm/ExmiaTFOVb5qc/5PMqbyuPu3L7ATrqLhB7v7etd/37WQ456ghAkoXRmcJRcLgCuS/9sgiZvWvPZbpz1DbDoi+7pCq+TTFaJGvsfzIV7Tr7U+ytUt1xI1346LstxHc1ejdki/rTRiIPsNLBFFwnQVAvdV/ugP0DUkCcJ3uPXch+mo1M6OxTi5iJQqO16OcFuXVFhuWYAse7qA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 96138a6d-1146-4c99-ae5f-08deab18b137
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 02:39:27.5076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBe+nVU1mkNxY4+7+KAEqkd6bhEBLHBaTOVeod8PSsl7uQxeIJ6MSH30pW6tSUqNqCoQ+sXqq0SwDFlkZsJR2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4798
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

On Wed, May 06, 2026 at 11:42:13AM +1000, Dave Airlie wrote:
> On Sun, 3 May 2026 at 10:03, Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > Hi,
> >
> > In linux-next-20260430, I'm seeing build errors on some ARCHes when
> > DRM_XE=m (probably just "is set") but HAVE_ARCH_TRANSPARENT_HUGEPAGE
> > is not set (not selected) by the ARCH.
> 
> I'm seeing this locally on my arm32 builds, Matthew, Thomas?
> 

Thanks. Yes, this looks like an issue we fix in this cycle.

Matt

> Dave.
> 
> >
> > Does drm_gpusvm.c require hugepages?
> > Or possibly DRM_XE needs some kind of restriction?
> >
> > I see build failures on ARCH=alpha, ARCH=openrisc, ARCH=mips (32-bit
> > or 64-bit), and ARCH=arm (without ARM_LPAE set).
> >
> > Example:
> > ../drivers/gpu/drm/drm_gpusvm.c: In function 'drm_gpusvm_get_pages':
> > ./../include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_361' declared with attribute error: BUILD_BUG failed
> >   699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >       |                                             ^
> > ./../include/linux/compiler_types.h:680:25: note: in definition of macro '__compiletime_assert'
> >   680 |                         prefix ## suffix();                             \
> >       |                         ^~~~~~
> > ./../include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
> >   699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >       |         ^~~~~~~~~~~~~~~~~~~
> > ../include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
> >    40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >       |                                     ^~~~~~~~~~~~~~~~~~
> > ../include/linux/build_bug.h:60:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
> >    60 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> >       |                     ^~~~~~~~~~~~~~~~
> > ../include/linux/huge_mm.h:113:28: note: in expansion of macro 'BUILD_BUG'
> >   113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> >       |                            ^~~~~~~~~
> > ../include/linux/huge_mm.h:120:35: note: in expansion of macro 'HPAGE_PMD_SHIFT'
> >   120 | #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
> >       |                                   ^~~~~~~~~~~~~~~
> > ../drivers/gpu/drm/drm_gpusvm.c:1560:52: note: in expansion of macro 'HPAGE_PMD_SIZE'
> >  1560 |                                                    HPAGE_PMD_SIZE ?
> >       |                                                    ^~~~~~~~~~~~~~
> > make[6]: *** [../scripts/Makefile.build:289: drivers/gpu/drm/drm_gpusvm.o] Error 1
> >
> > where include/linux/huge_mm.h:113: says:
> >
> > #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> > #define HPAGE_PMD_SHIFT PMD_SHIFT
> > #define HPAGE_PUD_SHIFT PUD_SHIFT
> > #else
> > #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; }) <<<<<<<<<<<<<<<<<< line 113
> > #define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
> > #endif
> >
> > --
> > ~Randy
> >
