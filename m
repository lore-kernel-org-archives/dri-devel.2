Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26D606D4C2
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HMoSVdce
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54B210E2B3;
	Wed,  4 Nov 2026 21:36:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC9E710E2B3;
 Wed,  4 Nov 2026 21:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793828165; x=1825364165;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=r4EEbqCuIUN7LFMl4EhOnYgTuEe6YLlbUl02dD/XgrE=;
 b=HMoSVdceKszgNgsFmu9cEep7BFySN7ts5/X8tB6qnXXyHCTpcENo9iy6
 nIAge0UcflOZF3XyYHwTp7jHR2wz4EXYa09vxpvIVzEssJSQ7th3u+gSN
 mUjvc0xQSnUZzMjAfQhy7pkffy2FnLEdkxCG6MkFfyS+JftRILFh39N3K
 NZiuedxcOx2l9IqEwFifSDEV8GgQ72De/G1ZZlz9i1C6s09D7jJW5dNAO
 2hMhvKMETNrc3vCsm3Bxeg+PqJkOKVP/vTzlDEZe/0eoo4/SbQf5OOLlr
 NfjnUCOmDyVPvdAxDRS7h8syDMsXlZBB3H6BIlplmGUH0IErMa3R+oGqU w==;
X-CSE-ConnectionGUID: qtWvpa0qR1Cupbb3mxiH7g==
X-CSE-MsgGUID: KWeXDXZ9Rs6HFE6esPAmWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2500049"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2500049"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 13:36:04 -0800
X-CSE-ConnectionGUID: KYVHstQ3TEiDA8yI4F3u6A==
X-CSE-MsgGUID: OAmQzH4sTT+jAYZkCpvunw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6733498"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 13:36:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:36:03 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 13:36:03 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:36:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKEqn3Vx0nKdyxy2Rots0m0cy2Kw8uDvZvMRXoI3v/0SdCrF0sejdKm3GXGN20JqpgFpN6A0G6LyDiJ7zDd2a7/qvL98HEMMOO2IY8cS28WdYIYPrc/qPTEwHpcQrBfDuBQqHnS5CM5ljHIna8i2UR+wyWYQKfJgvbn7E098QpfDHyWa7N7fobKBLXXsMLxGN0PejgnXJASojD24i3u6dMLl6XhkBEHtk4tdTubi9E6A2AYViqyfL/rzW1VlPLQDOOBQ/qo+MWJ1pKvcDO18zU5GVcJAYWV1+AXENy+1a/ssMXoNgWo4LrV5LQ26Nj0M76ifoz3KcnT3hCT+hM2fxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ej8z5jqw3XgMkd9Xra7s4CFDSRUTC1KjSouYR76V7s8=;
 b=U856q2Z0WE4OmoKr2X4JZCNfPKqDZvwm1ro0416mQmZvafwi5+v11YWKjn0tq1M/d7WLnhV1f4XhYHbpwRI3svkKZOGZRFln/ACAyjmuTh33V/M5NmnLhu5UqKfNLdb38qREQjVwtJxSCSEEFLDz3I+I9rnQjXWtD/t5uBPvHPOWT7r/YTcRYsn1MiKWsHEVtmcIg8LNY3Gyj6zchnKvL1a+0XVGrJC36qKaJj7NKP3bdOszN7bCFEezGcBXh2D6xT3xX0CKrHyzQojb9TVDG8gkUbXiR+eTsxc8AGNqoO9Tmzr2pOB8neFG55kdai0R+rvCKADKGUE8aE9RsQPjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS4PPF25B1C4D24.namprd11.prod.outlook.com (2603:10b6:f:fc02::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 21:35:57 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 21:35:56 +0000
Date: Wed, 4 Nov 2026 13:35:54 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 11/33] drm/gpusvm: Add a DMA-mapping accounting callback
Message-ID: <auulOl8XHvbblp4j@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-12-matthew.brost@intel.com>
 <auqpUmz15VVS3aSB@nvishwa1-desk> <auqwRZJRXoQPmVxJ@nvishwa1-desk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auqwRZJRXoQPmVxJ@nvishwa1-desk>
X-ClientProxiedBy: MW3PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:303:2a::7) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS4PPF25B1C4D24:EE_
X-MS-Office365-Filtering-Correlation-Id: 769e36cf-399b-407c-910a-08df3abb9c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|4143699003|56012099006|5023799004|11063799006|261028144727099003|261022075727099003|261026140227099003|261102123227099003|261026121527099003|261009223027099003|261021123027099003|261021121427099003|261009221227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: XBY011B70y2BnEWyJXDlhTqP7lMf08fdOlVIul5omI4MboQwnJuJBgIYjaaqTBrRQajhqjpOwlmlbhQYvFqUc/Q7BzfXbtZ8krmlBwW6FynkMWW2wSLH/gp77bHkDPcbT2wq6rdLC2XGjl82nlC7rYRd0XE7eocccu5OojkkbwY07R1wBfwNCxDhdW/r1y7YHHAroBnNT0FLdi0UulxZFPAA8YaJm63vHV/2OS9qN2LRey0PZbUvKte3FwnnCLdad4RiUyfNqCNxCkHm6+Ws8Xkx70bakudJy+Y82woYo2T0b2CwHR2LK1mcZPSNsAFJYBK+9dEfqv7I+MvZX+naoJk4iUw51UtCa0wUQDsnHz/RGi4g/emHXMA9G+MvXVxDh0mbfI8N3Pm1xeFGZNFBMX6wXVv/ew/iXWVYp9Gw2QuXaNVblzjl3ob5w/+Ypvpjy4aHru6JYv5NbFJhFEjhGRg76Cis6otUOZzMOno0pA6yY11zLMfa9hmEHECKkOSIxEfepZfMvGgB7Q3tLBGOucM1wKu+l0dAYu7ctX/8sDKPW3IblxlV+M/3CtWMqThGu03XtGBULRGW05zjYRbFohpkoCrjCRyzC4JsRXQ+jdem7mDjoWzJQW2y5O/E3krUAjJzHt+3Wn1pDwAwHQBLnU8O8mN/hCKdTBfeGeIpp/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006)(5023799004)(11063799006)(261028144727099003)(261022075727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261009223027099003)(261021123027099003)(261021121427099003)(261009221227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jpqoXgyuDKkilo7gcxcZY313+mrtE5q+MAjGDIsjqFcvlrFp1Gy3SBVfmu?=
 =?iso-8859-1?Q?Wr2sHFo8WKSPCAKnxSeod5Yrp3yHymWawQmI7478fubTAN8gSOqzIijaOp?=
 =?iso-8859-1?Q?onOrY7AFjH5QnF6qTOPMyHqvV4oufP9QpQgSQRoLzqaS5++A3pQcqMCulB?=
 =?iso-8859-1?Q?qmaVLA0nz6JFPWR0BVIJDxL1NgNSlZ/KHCzyUiUU4Ma5AEQ3dHuKLMh8pC?=
 =?iso-8859-1?Q?VjW4puZxcc3iKh7C/jG+ppAxdQWKu2Jn8CPKSS0AOLrhn+yHQXXhfwXkKe?=
 =?iso-8859-1?Q?+kev/kTqdLovEa5WvqraF8NtQoMgUX6LHVkKMyMq4X+zNSUFVpM00w0Wfm?=
 =?iso-8859-1?Q?FLsFqiWcdidv0oUibhkPnU47zzpOnANzHi8cJbqJUF6Qf/X/R9HsLabbjB?=
 =?iso-8859-1?Q?4h9Lzuk1cofPAhClJHbDg4h2eHrtXX791fQv6AIRAmEsfs1JHkKLYK9zwV?=
 =?iso-8859-1?Q?vNDxHNe5ssIklk7CQLLv4xOCI3KRNEzRTyy6o/4ZqkRK/XsR8sG7iRHycX?=
 =?iso-8859-1?Q?Tlf4s0ckubBwkmhvHdE8aJboMqOxyShiPBPTd18lkTreAO1AJGpgEkH2Nx?=
 =?iso-8859-1?Q?sucaRnguip/+lkeHy3NWxjYWu84pppXNLutLoOXdWlkGwdSZKBTllAaFLL?=
 =?iso-8859-1?Q?Y2RnGVgtLX+hsGqCZJj6lmFuvZDpwfs82CK7Vie7EBU2wyOlVSgNveWm+S?=
 =?iso-8859-1?Q?llNXdvU1qYkTy3rMbANhaAraAIjC+N4fCGyTm5wkcUR6+QhQv6g2QaPYja?=
 =?iso-8859-1?Q?bq9G8KJakbK5IASXS37GWXQfc7N3BKSJV93EvooYhNNCbEm2ihjfdACnqs?=
 =?iso-8859-1?Q?bMAz/YzsUO2LAlQaA5aitAdd6XT1vGP6+08Xta9e6TLRu3D4l0pphSfQXG?=
 =?iso-8859-1?Q?ivT+9qmaOOx41YnWv2cCTvtCOHqRBoiNF0cNiOsczwx6CLY+bNuCyLcB0U?=
 =?iso-8859-1?Q?FhGFqaP8N6+9izpvODbfHgBzBlT6JCO4w4gQQW40rAxOM4DlV3hJhkoGAY?=
 =?iso-8859-1?Q?DIRJ3RG4ZF6I1L9VR5WurT6y+y1NU199NtOKPx6tp198gx3RbcDou/+xwV?=
 =?iso-8859-1?Q?iLmv/KJSY8dM7U1DDk8kOKCpq3sqf1DuI0rAl1cz2GLj6/onmCg1KPCN7W?=
 =?iso-8859-1?Q?vrWjs+M8kREbDS0rzPUXeseDCg/tnxLNMEoBqKWqsTyKXYgRJawXgFEG5+?=
 =?iso-8859-1?Q?MFd65Uvf08h5pzCO1iB3SMdiUSkifIoIg/J6n3JrPFrSaYiFP9UWs3OAuo?=
 =?iso-8859-1?Q?Me+y5G7bEWWM2StMpikcO33lstd7jLjn/qpZdSRbnWKnjCAhL/3L1y3gSX?=
 =?iso-8859-1?Q?wLrnw0/oPEwMQTjLUaktQw4IZPwIDRt8f4qjEURT9mB3MPd4/FDi8ZkxSK?=
 =?iso-8859-1?Q?eAyvfAykJzGqT6T4AK5M9DkhlX+euRNrrlhaAp/qwIgxwJ3gIju6cciUs0?=
 =?iso-8859-1?Q?Z6+rASKCTXnAqgKW6yF+T9XuPLCzVAYLlKPMiUdBRGGr8KmofWLkkSFF35?=
 =?iso-8859-1?Q?bcgJMWaBqTpqBPF7nrLgSUTXqKxQz4UnJ+DnSFpQxMBrX+gUIQGjoZ2MJd?=
 =?iso-8859-1?Q?TBLJ51CgdDZ9lZJBy2S4QBQ6T4Q7EAmw8Jkrx9ogbah/IxIpeQhLG57cRE?=
 =?iso-8859-1?Q?Anmw4PwE7ob/BcsmhZHwjkmzPcW2vE9vAH/j7XQGu1XVFynamjReBO0XA6?=
 =?iso-8859-1?Q?+Ey0FqJNR6oo0p/HDcAtED87NCRlyjdCHnpmP9eyBVMyUYnd9lYBub9HsG?=
 =?iso-8859-1?Q?SYLO6dpxx6f7spRoD5J1UqwS+DB+6huZgZWrBfwDgkOWSMbpB63p5GJRmK?=
 =?iso-8859-1?Q?A8BAAsKQnQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 00bGJm5ObDAU74GWfkFXesXxcwtd37Qz92uahi0OiZOpCqeWnHAp0Sk2stUZIcF+tRRXlCfOyUoakneaxYUthycoCXlicwHtBkePMbVJfXN16Fy3lwECE/Sux30PZicHbzj1cCSadhir0GFk8tx5+BmxpkwlckD45wF3/orGSfmqOJIB4uqPp37spGgZ6MXuPIwhD3Kry25twpvZWDiGd3lUmn/dpwMCVdiGUywtyRr2IS3UUIm9MuLMIWT22ck5M1nveC/M8reCH/286cf3z83zqeNQc1EZ69GfGVJDgnTj/v/rySWINCfrzkpRSpacDr9EuLoX/177dzgFy9Q0iA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 769e36cf-399b-407c-910a-08df3abb9c15
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:35:56.3738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1g6gMQ6dJFCHaTE23JpupgAXasYHGBAvUp6IAq6CMVW1HskUgjdh7J+4onywCjhghXbwBJb0uI3JxDaucebtgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF25B1C4D24
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 08:10:45PM -0800, Niranjana Vishwanathapura wrote:
> On Tue, Nov 03, 2026 at 07:41:06PM -0800, Niranjana Vishwanathapura wrote:
> > On Fri, Jul 10, 2026 at 07:55:57PM -0700, Matthew Brost wrote:
> > > From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > 
> > > Drivers that use the GPU SVM core to DMA-map system memory for GPU
> > > access may want to keep track of how many pages they have mapped, for
> > > example to expose statistics or to detect leaks. Doing this accounting
> > > in the driver around drm_gpusvm_get_pages() / drm_gpusvm_unmap_pages()
> > > is error prone: the number, order and kind of the dma_addr[] entries can
> > > change between map and unmap (migration, partial unmaps, the iova vs
> > > non-iova paths), which makes symmetric accounting hard to get right.
> > > 
> > > Add an optional @dma_map_account callback to struct drm_gpusvm_ops and
> > > invoke it once per &drm_pagemap_addr entry at the exact points where the
> > > entry is DMA-mapped (sign == +1) in drm_gpusvm_get_pages() and unmapped
> > > (sign == -1) in __drm_gpusvm_unmap_pages(). Since the map error path and
> > > every unmap/free path funnel through __drm_gpusvm_unmap_pages() for the
> > > entries that were actually mapped, the accounting is symmetric by
> > > construction. The callback receives the full &drm_pagemap_addr so the
> > > driver can use the order and the proto field to distinguish system
> > > memory mappings from device interconnect mappings.
> > > 
> > > The callback must also be usable by the core drm_gpusvm_pages-only API
> > > (mm == NULL), as used e.g. for userptr-style mappings. Relax
> > > drm_gpusvm_init() to allow such users to pass a restricted @ops that
> > > only implements the page-level hooks; the full-SVM hooks (@invalidate)
> > > and the chunk configuration must still be unset in that mode.
> > > 
> > > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > 
> > Patches 11 and 12 can be spinned out as a separate patch series
> > (for fast tracking).
> > 
> > LGTM.
> > Reviewed-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> 
> One other point below...
> 
> > 
> > > ---
> > > drivers/gpu/drm/drm_gpusvm.c | 17 +++++++++++++++--
> > > include/drm/drm_gpusvm.h     | 19 +++++++++++++++++++
> > > 2 files changed, 34 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> > > index fcfe635bc195..512f52471419 100644
> > > --- a/drivers/gpu/drm/drm_gpusvm.c
> > > +++ b/drivers/gpu/drm/drm_gpusvm.c
> > > @@ -474,8 +474,15 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
> > > 			return -EINVAL;
> > > 		mmgrab(mm);
> > > 	} else {
> > > -		/* No full SVM mode, only core drm_gpusvm_pages API. */
> > > -		if (ops || num_chunks || mm_range || notifier_size)
> > > +		/*
> > > +		 * No full SVM mode, only core drm_gpusvm_pages API. A
> > > +		 * restricted @ops that only implements the page-level hooks
> > > +		 * (e.g. @dma_map_account) is allowed; the full-SVM hooks must
> > > +		 * not be set.
> > > +		 */
> > > +		if (num_chunks || mm_range || notifier_size)
> > > +			return -EINVAL;
> > > +		if (ops && ops->invalidate)
> > > 			return -EINVAL;
> > > 	}
> > > 
> > > @@ -1246,6 +1253,8 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
> > > 			else if (dpagemap && dpagemap->ops->device_unmap)
> > > 				dpagemap->ops->device_unmap(dpagemap,
> > > 							    dev, addr);
> > > +			if (gpusvm->ops && gpusvm->ops->dma_map_account)
> > > +				gpusvm->ops->dma_map_account(gpusvm, addr, -1);
> 
> In the latest code, there is use_iova path and unamp there doesn't seem to
> come here for that case. Something to take care of during rebase.
> 

Yep. I have this fixed also because of inline mappings some further
adjustments are needed.

Posting now with this fixed.

Matt

> Niranjana
> 
> > > 			i += 1 << addr->order;
> > > 		}
> > > 
> > > @@ -1654,6 +1663,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> > > 				(addr, DRM_INTERCONNECT_SYSTEM, order,
> > > 				 dma_dir);
> > > 		}
> > > +		if (gpusvm->ops && gpusvm->ops->dma_map_account)
> > > +			gpusvm->ops->dma_map_account(gpusvm,
> > > +						     &svm_pages->dma_addr[j],
> > > +						     1);
> > > 		i += 1 << order;
> > > 		num_dma_mapped = i;
> > > 		flags.has_dma_mapping = true;
> > > diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> > > index b7d987bf76aa..36f35816a569 100644
> > > --- a/include/drm/drm_gpusvm.h
> > > +++ b/include/drm/drm_gpusvm.h
> > > @@ -75,6 +75,25 @@ struct drm_gpusvm_ops {
> > > 	void (*invalidate)(struct drm_gpusvm *gpusvm,
> > > 			   struct drm_gpusvm_notifier *notifier,
> > > 			   const struct mmu_notifier_range *mmu_range);
> > > +
> > > +	/**
> > > +	 * @dma_map_account: Account a DMA-mapping change (optional)
> > > +	 * @gpusvm: Pointer to the GPU SVM
> > > +	 * @addr: The address descriptor of the chunk being (un)mapped
> > > +	 * @sign: +1 when @addr has just been DMA-mapped, -1 when it is being
> > > +	 *        unmapped
> > > +	 *
> > > +	 * Called once per &drm_pagemap_addr entry, when the entry is
> > > +	 * DMA-mapped by drm_gpusvm_get_pages() (@sign == +1) and when it is
> > > +	 * unmapped (@sign == -1), so the driver can keep symmetric accounting
> > > +	 * of the pages it has mapped for GPU access. The @addr->proto field
> > > +	 * can be used to distinguish system-memory mappings from device
> > > +	 * interconnect mappings. May be provided in both full SVM mode and the
> > > +	 * core drm_gpusvm_pages-only mode.
> > > +	 */
> > > +	void (*dma_map_account)(struct drm_gpusvm *gpusvm,
> > > +				const struct drm_pagemap_addr *addr,
> > > +				int sign);
> > > };
> > > 
> > > /**
> > > -- 
> > > 2.34.1
> > > 
