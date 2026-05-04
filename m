Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6823FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 04:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2048210E367;
	Mon,  4 May 2026 04:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="btzcL5pv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF8710E366;
 Mon,  4 May 2026 04:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777867784; x=1809403784;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lEBvibbHOAblkGJgM5oR2rCbglV2NMxLxLMdOHxuZ/c=;
 b=btzcL5pvu/rAuwNpnxziiNgr9rOYD8pyTT10KgO4vAHuAKmF7Ly89QXy
 YWI9fIvoyzTpatVOYffXiwzrq2R1AOQi80xmG6nGbuiCDQslYutfXkC4/
 ekdcQaGAy8xVyGe8UgYdxiNV5mL7l0GwuISo2rf6PWCGIN7uwjuFBl07s
 FHnfIY/aV6DMfmOmajilvKFdNbrZ/INjxrjWTE0F/15RvLeYETDhMT9HG
 ELfKBKGTISzURxILsKpEgn7qNBy2VZ72KbuuWdIdxYZYZf1KnMKLpC+jV
 UzFgSBZn2W4X18ocYHC71aIFUmpJx9afwVJVBPcyw7jykVmlh+Dq/FsId g==;
X-CSE-ConnectionGUID: 0/nc2/D3QV6+1GCUj5G4GA==
X-CSE-MsgGUID: dhh6i/6mTE+HEiyK6oK6fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="89415347"
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; d="scan'208";a="89415347"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2026 21:09:43 -0700
X-CSE-ConnectionGUID: U8Uk9miyRkKqB5+gX/HvTQ==
X-CSE-MsgGUID: JyHG77jiQraMPaw3B98mbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; d="scan'208";a="265753455"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2026 21:09:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 3 May 2026 21:09:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 3 May 2026 21:09:42 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 3 May 2026 21:09:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4sREwSVZ8k6AGdOsitqPfBbnvo0ATHKJ1XOE+MGFI3/IWiWn5N1JfqS3eGa568J3ziCeEzS0a62uW0QC7EiJX91Z03hBPJpTuU51azD/XXGSeVibYxcrEfdApI3kXfo3b+IQTuS05l1uZMWkT0IT5T+dy2hnSvGiDvw4FTH9/pbUNd1RZ2NHJjzv8rgqx09BUKSXpWtkTq1tkKnaGgKkzHHGmt82u78zP/uhua4GA/0vM+lziQR6fGfQBcTTBnCt9KEiWeXjl1PmcGiAYLjaTBMWXaOSmrFbqX+4R5eSeOaYoByWA76g7B4k6VmpIbZagXrvnE+gK25TYJG9fjl2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkrHJksC9bKFJ2LaIqk7wZsnXttusdIGOqP45jpCu74=;
 b=EZhXg+ICJW8J8y3p7smBNBXliC3DiG6jExm0T1JT6VhMH2Jiosg/PuyRxbcd8cigjraiFYtTmc81Oyw02zcZtC+yy+sH6oWmAJXl9EOy8jirhzpO/ugRXSz3ggbtYMfM0K9jRfu9p5PkD3jw9LHYwEmdKZZevdjAiLBysT/3WPQIzTMO3NTUCX2moOR1PUVBoNzR/LGxOO9tbtr2xaheTj4U/4hQLmc0X4PO7MHLcTtAsPTi8WNivh86JaJWzkZm+ir8IT7BBZ5a7kaCUaPuiAuglNiip/WPxq+AVbuAXMbm2Gz4d5S7t/ghMCPhsPQF9PPBgBh2cV90OPmGdANzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ0PR11MB5086.namprd11.prod.outlook.com (2603:10b6:a03:2d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 04:09:33 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 04:09:33 +0000
Date: Sun, 3 May 2026 21:09:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Dave Airlie <airlied@gmail.com>
CC: Kenneth Crudup <kenny@panix.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Christian Koenig
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Matthew Auld
 <matthew.auld@intel.com>
Subject: Re: [PATCH v2] drm/ttm: Fix GPU MM stats during pool shrinking
Message-ID: <afgb+7p7ecnMGNQL@gsse-cloud1.jf.intel.com>
References: <20260502065338.2720646-1-matthew.brost@intel.com>
 <7f927ef8-2d3d-4609-926d-b18535794f72@panix.com>
 <CAPM=9txfkvL4pWW53Pk0OtJ=vBaa-SCv6npSCK5f0zuOOJUfSQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPM=9txfkvL4pWW53Pk0OtJ=vBaa-SCv6npSCK5f0zuOOJUfSQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::7) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ0PR11MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 19dc777e-47d7-4cd5-adb5-08dea992f2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: YbwCGLypwoSZorfZyGw0VZxfBgwhE3JTmZwvfhpCw1zOCMd0AasuTC2dZVqElacI/JTtPYOip4UXKeJZY5XCvgHsGmNtDqFdVT7/+Sdwgwvyi1wYu/lBHsKGPEhMNbpUmMtlMzjs3aNTnZvaGjZ3TUvpz69kvfi2lHRG/uzVviExDH6atOWz8VmTqV7cSn0hgYDCiXvLtSixvxbuis5/+QcbEuhxqWH9WdfymVe+PtzTEob/s9OInxE5/pXCiGxMnCiMeapLoUQ1nUdgat2u2sNeuyTbQ5isn98fImecxriJAj5gohaAwIKxsCqbR/a751dW/0QZnPxWcQxfPw+VwMx4+77jMKqFMiX8ngQwHMSMdkKnQVVTqp28PXlFzQ83fRjhgNx5Mo/g4EnY2vMy1L2KpoNw0sgzIVGhrld0Ufe2tDfIIJvxR0fyT1Pd1WqxvHfSDzS3Oqrs7NQL1IQBAbRO9UmloI2zbAtqjrDYC0VvNCnEH1x9QBo9cX5I0Gh5nakUNPaIxvivigEqsKaIp5Yfa9KD6KQVBzfMuchhOOcE5DfXycuLBCWT0+xIUv1gbqIveEvn6KABb3QdfXVm/TTfKQ9RctP1qjsZRdFvoB+kOKj+1ofV7rQ/qwR+pJsEE8Owdb9gzb7/UpTdqX64OIMO+Dxaonb0yODDFZMXGgzglOSEgJIUr4BqrSHXtx46
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5WloyOrlpPzfldKeC3T5IegEC9oqm6J9VqlfVKDncsMsOApP7Nsd2/eBRaUI?=
 =?us-ascii?Q?Ac3j3K/tql0Fkuk6K5FUXtwae7Y86zgbe6xHB1b5W3haUQyFm8GZthp+Uwkx?=
 =?us-ascii?Q?3EWPnrQ9gAdosaf1lLaOHuCtNcZZnYt9Z26xNT0rLmMw1Xki/dkgMmyT9NPO?=
 =?us-ascii?Q?uLcvOzwVz/f8/0GkBvVoGbMi65PF4XFhToJ1EQ6jalGEHQgK8vegbkAPMoaO?=
 =?us-ascii?Q?9PSnynSEot9pcYP8NvREVlLHyb7Dc53in+ehXRml8qT7tRlKzKvgYzY719dq?=
 =?us-ascii?Q?O5OjDHy+IMcA96bfu9zQxqbLhqHPPdqoyqhStpjTxATiwN8vDskuefBWASrJ?=
 =?us-ascii?Q?M3GGRmBscm2zwKw0BQbYZQu0IhJwbQubXrrWIqdCx9aORCI9kPwoO+JBDcvK?=
 =?us-ascii?Q?IWDoADnECbHJKDeGefpsb7oIrTQeGqBOvMXn4QcSx0HSKle4iqRdXnMBShPx?=
 =?us-ascii?Q?dT5unUDgEh0SdxBPjlR72W/CQVuHiNjpDcpWFa8KI/+oudoHMuiLRUuzNgbK?=
 =?us-ascii?Q?xCGJ/5UFXRYhNeJGu8dcBaj+53eCsb1GdHFVxxosJejmO4pjjdn26QvdTgib?=
 =?us-ascii?Q?AmGmSZUOPt0LchLRIhmSy37CutEja+ts14XO6naFlpzi0Wjqg4Jn2l2+6A2H?=
 =?us-ascii?Q?5f+h8bKtdhmlgMmwRdwG7H2EOu5jc15Pgu2xF968/fJ/CZ5w2/HA9UEWBUvX?=
 =?us-ascii?Q?ziA+CBd4Io6Q0YXdTlqBC++U3xX3RAtLxVFN9gJmH62k9mdQiUAF5bzhiDsl?=
 =?us-ascii?Q?nU/h2xrAvU7x7SPcB5dnHvAt2DE6gsf7ZOka/WQStJNmouEh0cVm1KYaefUc?=
 =?us-ascii?Q?6nfymOgZ1XS+l8NJNHfcfFKKg30DMss4jCWBHNqHp206uFwcbZiWVVk4B2TE?=
 =?us-ascii?Q?B4pFf6IHB96UC1p6F1EF5bQmb61clhmzy01n4YY52v7r8X2fyROiCq6mx7J3?=
 =?us-ascii?Q?LfkLTFVs7BFw0M1ZyUejNLaXyWGn8N/H4M2Prix6Hb1b9iCAI7jORFcg3SWE?=
 =?us-ascii?Q?9XwVIB1pLTW4PT+D8z9vpR0+7wcrPXs1GRs/X2b3lm9IY34mfTa9MFzvvOLr?=
 =?us-ascii?Q?Rvux3OIVJ0/RX+n+ZZlBxwA5ezFyxR25i1PkcysE0hvDweAAYofgynzzDIVP?=
 =?us-ascii?Q?bV4pJpB7cFZDeLivs0Z40uIFQhV6lLU8bihbswxkcW6ejLNJ9RQ9G+jWoG85?=
 =?us-ascii?Q?qGV7NzJCWKdM+CiCPgnH4o3hP86DdSwYBBFwE0KqG/BATqcKH1nYp9HB5cwI?=
 =?us-ascii?Q?EYmdm3mDFALDvNCs1cLT77sOKJ1FlOoYaENSiUDtCxeGz3rVw0TokaIYitM5?=
 =?us-ascii?Q?ux3jrjPw5A72aWeuwpNNBvulqEUE+rbnNXLnSTnUehUpSwZtZyWN4Ur4FkRC?=
 =?us-ascii?Q?ZjAhmPUcT4Cu5FefE2bGMhQX2kkGMt1DIoQL6qoOBNnYUagKYtzN2yBEkl6q?=
 =?us-ascii?Q?mGboBc4IJG2WORRo3OkF5NMzcOw5T2TMF0Mr7Cyhfuc6Uq+OB7j1aMScA8LR?=
 =?us-ascii?Q?j9+r8q2aEeV+jzorIXJwEMkMBbMZ5tyXSykI192P+O5tF9tJUGoNW6dwVBRc?=
 =?us-ascii?Q?KAUpzMcoe66GjDpRY1yx03AYrLiJWy1SOIgWdDBohsv6kyGME71INI+r+i3a?=
 =?us-ascii?Q?wkX1qc8+WIR/S/jMrN9UlUZQVtpNMHlo0k33upKGZ0aLvmCzbqu5gbHopsBQ?=
 =?us-ascii?Q?zndw4OE3laynQb4DkuMCVnDOH18tg637koY4YdK8XKWSC6ZPKcEDTahtjUkR?=
 =?us-ascii?Q?6aJSl/zk6g=3D=3D?=
X-Exchange-RoutingPolicyChecked: B2SzUaNwX47YHBiQa78lyu3pLlTvCYKIVtS2qPMll2ySkv5tokRMJsIKqyLu2jpbi3tQfqNvrVvvJ6jKFVYD3VovscxoGS1+W5DP5YFlSZ9TkDbUY9qELziQXB8WAy3FuhZ8WcAUVmNTZ7yGhiu8tNlTHN/w1kjQQuYqkRABy4P+ppxAlyjyLT3jWCLLptSSKRaYMNBqYKH2kkZjLLz5ciPDYHy5Ru0XTt0HgCPN83PXtao5vvsB9U9XFBwG6NKjzQ/+/M+t+Jn3yMVyEeGd/SLDXJrIk7u+fQ0L8xzNHnBndvkhgpD4HhCtDDYzOtTx+gCze7saHTqT718Hn6TYsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dc777e-47d7-4cd5-adb5-08dea992f2a1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 04:09:33.5911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2T0V1koTNAjV2p+P6v8FW2xjPTQt7rVjf9lV984AKqb50nAKdHlj4x/g/wu8LnP41TgYxOxKAOSyvRZy3fP+lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5086
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

On Mon, May 04, 2026 at 01:56:25PM +1000, Dave Airlie wrote:
> On Sat, 2 May 2026 at 18:14, Kenneth Crudup <kenny@panix.com> wrote:
> >
> >
> >
> > On 5/1/26 23:53, Matthew Brost wrote:
> > > TTM pool shrinking frees pages by calling __free_pages() directly,
> > > which bypasses updates to NR_GPU_ACTIVE and leaves GPU MM accounting
> > > out of sync.
> > >
> > > Introduce a helper, __free_pages_gpu_account(), and use it for all page
> > > frees in ttm_pool.c so GPU MM statistics are updated consistently.
> > >
> > > Reported-by: Kenneth Crudup <kenny@panix.com>
> > > Fixes: ae80122f3896 ("drm/ttm: use gpu mm stats to track gpu memory allocations. (v4)")
> > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > Cc: Huang Rui <ray.huang@amd.com>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > >
> > > ---
> > >
> > > v2:
> 
> Oops, good catch,
> 
> Reviewed-by: Dave Airlie <airlied@redhat.com>

Thanks! Merged to drm-misc-fixes.

Matt

> 
> Dave.
