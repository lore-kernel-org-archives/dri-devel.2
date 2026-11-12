Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB663606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L6QxfWZr;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Vee9qK6O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203C6112092;
	Thu, 12 Nov 2026 12:06:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E279A112071;
 Thu, 12 Nov 2026 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794485167; x=1826021167;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HgiSu6qaI+dDufZ+THYxM7q9kiFVGrm6bMxRP0a3luk=;
 b=L6QxfWZr4qClwVzst4ETS6QqqNMKsokY8IUo2Wb6jY5MFta9QP7O5vdQ
 DMfKQ9yb0hHaa8XD+WiRwlLHA0Q1+FdWt3NQ0DpUcuOY+BG8IbcsQ7mPJ
 YmVcstN5xIiIqlIqn1lFOLwBeiF/RxSo2IiiURm+ijrt3t5kiQyz6HDyu
 +qbEdtmyWUaVhB7l6A6O3/Lwv0zBbSb0btrKxhtZZ413tzmi5rf6945If
 dw5dWU2GEvlrFsNv0v99mccA1i6QqcCnyzA9td7Qlr65rTVnRMnxHpqTR
 Vx20IEpbLMB6iDqeN/wSBfUjzF56E82JTP8/kosiXly/lhjHIlobpblD8 A==;
X-CSE-ConnectionGUID: rMUNdqISSnGYBAz8cH3pyA==
X-CSE-MsgGUID: QtBSvWWSTsSj2RFVOAQVyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3163665"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3163665"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:06:06 -0800
X-CSE-ConnectionGUID: Ysxz5pKvS1G8DfL80Pkb/g==
X-CSE-MsgGUID: D52R7zzUQ36XAoi4Gi1/6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8513079"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:06:07 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 04:06:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 04:06:05 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 04:06:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUuy9tuRXXXSJ08VTJlPY6M7NVlPE/ImwUledZ88BkLad0iVbvz3/Qg/YHEsWOJxVxjC54di52xypFzrUpo3cJkCY1sgrv8zE8xlby/ENu0rVPoAm6zoGt85yZF7zKOP2A5/KuABQmXYMkUfi0Xsw00uHDr2bFYqEYXoPV+jh1zCjJzAx9SeEUEkErxZ0VYSbDalqcsuRroheGH1dNCn33+NpKBGIKw1qfEqixL10rDS5lUB/8AxsnVWssnnxf6zYtYNmQU49t6QHOVM+iyBBdJp+UYEJ22yK04OybiLzcwDazdCLybGYKT5NwGw92eNmShWKV5Vd5+gDMinyg/eow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUlF5y5it75IVbGdaHo7XEK+6yXjRk597QrP8ZPxJQI=;
 b=sktkTgavv4PNpvIwusFFykK2emPz+lgEWCGXHuK8eAs4J8jT6tAkHLn2XfpqalsGOTLi58l4T3Ltky77I+Mw0c3hgLui36HdzIemAiyOdgMU0acdmeAPBMaS1KMHOu6hx4OyNbGDeKzdzHmbHNsgarAeLhVcJl0FvN9QD7qASbLb5UPNLqCC0wOEKotC3llMKqsNRyPNoakEQW0ptiuB9A1+rVs1SQuSPxJT+GZeIWCyQy9wrJKDrkq+XPrOTxxdWexISNZof2TaTACplyUyzfa1GkUq5i36tdbyXfjCyWe1cGHYzipMVG9TKz21r7ckADWlVZcdRnt2ucP/9LBjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUlF5y5it75IVbGdaHo7XEK+6yXjRk597QrP8ZPxJQI=;
 b=Vee9qK6Ovq3kCNdrIMaZOcdDJ4pl2Gn4cspK75sLkdkZls17UY6eU1wqOngQkEWb8wh4fz3WtYrz6D8WNxqXEq1UQ1aLitt1sHBDMchsMfnJ7Lna1vhM3JXyYgxyQ2+yVsCts92qSLat+TjfPUmUN/wVQ4lPEFIRc0D/TmY440g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by SJ0PR11MB5814.namprd11.prod.outlook.com (2603:10b6:a03:423::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 12:06:00 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 12:06:00 +0000
Message-ID: <888a4f56-f235-4144-947a-a3ca54a725ef@intel.com>
Date: Thu, 12 Nov 2026 17:35:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/xe: Mark VMs as closing before queue cleanup
To: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Brost, Matthew"
 <matthew.brost@intel.com>, "Ghimiray, Himal Prasad"
 <himal.prasad.ghimiray@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
 <20260916095337.3104891-4-arvind.yadav@intel.com>
 <DS0PR11MB871807B50344B8869802E47781772@DS0PR11MB8718.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <DS0PR11MB871807B50344B8869802E47781772@DS0PR11MB8718.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::9) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|SJ0PR11MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 0caa18ec-d33a-4dbb-0748-08df40b55103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|56012099006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IZz43uwITNRDicc6Echf2NcDbuPoZwoACLSNOjQi8GQSA2Ug6MUVpb/c2mHlgDiNVKNjjYdHLh4zzXNW329lpHPGdocMYnpzG5uv7gD5JTJO8+PWHxCq8uj7wssSukXtTMS49/xT1LASA71ODF7FKxUKTA6OveejVf0k7pfBdc/bFzmzfi+fCquWxLdKu69VptNlyK9qmSVLr595I4py1lVl6M1yIwDsEhB9AhJVWYfal7xVqgDWmxpoxM4DMvSpMGdYNb2QLOmVygBPAimkXh82rv2ESCQ5hl4JTLVSzwhsN0VNylZYpYVGlAFd4AbxAD/XjGudC+tVm2qhfYYWGc2Ym2OFWQw3K2OmDvl3m/dY1199qqnhZJ6oDw5F2j5lzX9foLklvfQ01qzW3QG4qfQy2f+KCFBGbwdLYbafob9/bZLB1yFaTHPpAnGJXQeejGCjJhpNQRi2sA6KQL29s5up1fMQXn7gxtGfe+02wKjtobEM8f+tz8JFCPqmDLGwLE2p7j3mRWlup3gdFdW1gMpgO+vH5h6kl4F1yIzpCrvE8X0Q7pgjyVRA+wZI3nzAQwhA6zfsWqTV09uDjNnOjkjJox1tU8vD0nzVgGbRhWTZ90DqRSNbKNAggydXecFQtCse+w8rLaD5DswF/566M0o7RJHJEEpfnPdKqccucf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTdvNUxXR2o5c3dLYjdQT2RZcW51bmZrdDFZS3BXTnVHaWx5azlNb3lIUWxG?=
 =?utf-8?B?ekk4aytmbUNIZk9wY2liUjN4aUl1TzFBY1lzTWhiR0RaSUlMbWY1RGYweEJt?=
 =?utf-8?B?TTdXQWhrblkrV2o5cFFFZjBDa2tLU0dQNGFSczM4eWFMZ21aS240ODBHdnpy?=
 =?utf-8?B?K1R1bTRnUVdXNDExSzl4ZFZreXpzcUZwOTBYVUFnbi85SDg3ZlFRNHZZeHRw?=
 =?utf-8?B?NFBNeHVCbkdYVFhtWGVXcE9DdklBM3d3S2daMFBxdTV1UlJza2pMVCtYRmlE?=
 =?utf-8?B?a1NtTVUvRk01STY3VzhkV1hYRnFCVEk5QnZNNk9BUTcrY0dRRHY0djA3aUIx?=
 =?utf-8?B?ZmN2YW5rc1lVSWJzYlBhN0x6aUg2QXZrNTFib1MrWjNid3IzM1QxVlRGL3FZ?=
 =?utf-8?B?NTVIbVZIVjBhSjIvVnpOOEF0alZTVjg4K2pmMTdkYkV2dS8vMUpKSWh6RTNV?=
 =?utf-8?B?bmdML0ZhRWNwYjdrSURhUmhMcTFRSmdkR2xnR2ZNTStDcEkxcWZHbHNuL2Fy?=
 =?utf-8?B?R1RPYU5TczREbU9Ub1pkSDhXMHhTdEx6S0J1VEFMVUpBcWpSNVJ2d1pMNldZ?=
 =?utf-8?B?U2wxWUpnTEFMOHUvNm9QSTlNUGF1V1lQQ0ZnS3pMMm5adzRyYVpZRVNhWm13?=
 =?utf-8?B?b2xqR2Y1eXlWc2pnNUhUMlRYNE1SVjdjdnNXMVp2cXZocnVSNVNLQWw4OWFh?=
 =?utf-8?B?Rk5DY3hUcitOR3FSaWFNZEF2eGdGbWJOOGZacFpqTDlLRzNxa2V3QjE4emhx?=
 =?utf-8?B?NFBGU2V1RWlzam13dFQ1STJSekZ5ZGpjVEg1REwrVmwrd2VLNjVLS1FKNzkx?=
 =?utf-8?B?NkVuTzNuT0gxZnpPZlJ0djdEcXZ6NDdVazMwWXpsa2pibWtNSzBlR21tTzZy?=
 =?utf-8?B?cjd6VmZmaFNyTkR4U3Ric3k0d096SFJzeTNpWjhhMWpacHpBbWVvV1ZYb1dM?=
 =?utf-8?B?UTBBaDIyNW5RK1pXZ29mZFQwN2ExdlV3VWNOWXlNVlMyaVhVUWlmM1hWZ2I3?=
 =?utf-8?B?dGVnUlBHWUZiN1RMcFdZeExhV3NwT2djV1VwaE8xRUFFUzRaTzFHSDFGaXVm?=
 =?utf-8?B?RFB1Vi8ra2tHVmxYbU1Zc2xaYVF4elFOWG85QWJQTjJYSFYwUFExR0lxUmha?=
 =?utf-8?B?YVU2REkrU3BVYVpPRS85V21LZWsvM3pvdWx0SG95M2E2TGlDd3p4RVBDRUVq?=
 =?utf-8?B?bUl0TW9Hd3VCZkMxNUlsSDVUZWw3STJOa0dHWDVRT3Nqcy9ZWTZyRk81bHZG?=
 =?utf-8?B?RlZqY0QvZmorYndiRndyL3RHZURSTmdjSk03R0d4U1B6NmdlemI4YnNXdHYx?=
 =?utf-8?B?a2s3UCtMaGNJNjBpQUhrbVVXMG81ZXVDcE13V2JEZk1FVDFYTGNhNTFPbmVP?=
 =?utf-8?B?eitHTlF0WUh6NXU2WjQwN0l3eVVUQ0pWTFAzRVltUkhsbllOYnh1TmRVcEJa?=
 =?utf-8?B?T05KQ1VBSFJDS1dCVmQ2M1hpQ0YzQzdzTkFwZ1JRaVhOVk9xSzJZSlQ2S2Z0?=
 =?utf-8?B?VjdhREwzNkZPV3FpYStpN0NUOUVTd21wSkpYRjZjcWJhT201eTEzdllNRTE3?=
 =?utf-8?B?M2ZVM1Yza3VGaXRieVloWWduL0hlenFCWE4wSjJnRmk0NGxHVk5JQVNCOXZP?=
 =?utf-8?B?NWdCbWJWVlV3aURqY0Q5S2JCZXhIYlJHNFMxUnJFb3pnTWkyN2NFU0FOSE9V?=
 =?utf-8?B?MTlnVEdyMDNNcGFpK0pha3B1Zk1EUXpiRm4zL2hwV3pSQUxwZFNKTTNLQnJE?=
 =?utf-8?B?V24zdEdyMHRoYm41RmVSU0tCWGdpcnVCWjRyaWN0Mk1qQkkvVkRaVG5lM0tL?=
 =?utf-8?B?LzBNcHEwRmkwTTZsa3Q4MitRS1hTR3RTdFVkTlgycTVtR050cnVzQzF5TnZV?=
 =?utf-8?B?M2tNNlpmZHV2dHNISVFiRnJVTnRyRXJ4RXZUQzF6YWc2WXN0Um1GTTI5a0dz?=
 =?utf-8?B?ZnliU0xiaVRQN3BERCtHeUNLamh5Mmh2SDVuL0dVUGk5MVBnT1NicU4zTnBj?=
 =?utf-8?B?bmhkUWpTVDRjMCt5dDUyU2JtdDlsWjF1cDNtRHJkMHlyY2xPdGlMa1pDVjhY?=
 =?utf-8?B?NC9TM0t3dXYrU3lsalhHSlY5Q1F6RGg3ejdMcjgrMDExalRwV1RPN0VqQ3VK?=
 =?utf-8?B?YUZNZkxxby8yMXY5MUJYTDQ4KzF0ZXE3dzE5eVpleStyaWRoenI4bklVb3VW?=
 =?utf-8?B?VGZmb3JhQWI0K1R6M2ZUUVJvQi85RTUzeHVQSVRSUklhZnM1S0tuSURkWWVW?=
 =?utf-8?B?c3pIYVpJRTdLSVpma0JnMmlLbnpMRXg1Uk8yTk11dkVKY1RocFNvWGNrM3Ni?=
 =?utf-8?B?WEZQbWpkN1p4UDBrQnl4YmFzSmVPZVFIL1JXdnR0M1dvdjd5UTYvUT09?=
X-Exchange-RoutingPolicyChecked: en/vujeznOvtgRUkcBRsLL1VYejVBd6GRAgijfIVKJcHK2C8TeWfo+UQX13BXhcBJTRMcCHcWjp59xLsss/91ghr/9pE/cld0xeD0WQhAHcASewVCsEwiAuDofWcXai54B0k3LIIkIUIxtVPB7uv/LCwrhIBcwueXiyV5jwVP04J0GHrJQoUgGptZH4prowCNpKVcNhVegcJ5hCoUOx2h566f6n8mBSZR8HjDqnILgEH7W8KDibKmhUz48V5NnEkKlWq96ZwqnsTjrLyG1K9PiTUNDq1uONWgJd2AppNxC87XqqN2iKUcF4/yoif7+BlYZqZ8UHmHLjPbfEKe08oqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0caa18ec-d33a-4dbb-0748-08df40b55103
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:06:00.4173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u52IUYlgf1OFwLvTcJH4NH8PaKKPrN+rNTVKcDa5SK2l00sUkZTXNtoxwDfE87HH5ydLq5BwlwaBmk8m+nyZwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5814
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 05-11-2026 19:42, Upadhyay, Tejas wrote:
>
>> -----Original Message-----
>> From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of Arvind
>> Yadav
>> Sent: 16 September 2026 15:24
>> To: intel-xe@lists.freedesktop.org; dri-devel@lists.freedesktop.org
>> Cc: Vivi, Rodrigo <rodrigo.vivi@intel.com>; Brost, Matthew
>> <matthew.brost@intel.com>; Ghimiray, Himal Prasad
>> <himal.prasad.ghimiray@intel.com>; thomas.hellstrom@linux.intel.com
>> Subject: [PATCH 3/5] drm/xe: Mark VMs as closing before queue cleanup
>>
>> Queue cleanup is asynchronous. New VM work can therefore race with file
>> close or VM destroy while cleanup is starting.
>>
>> Add a closing state and set it before starting queue cleanup. Treat a closing VM
>> as unavailable for new exec, bind, rebind and page-fault work.
>>
>> Keep vm->size valid while the VM is closing so SVM invalidation can still drain
>> existing mappings.
>>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_device.c    |  4 ++++
>>   drivers/gpu/drm/xe/xe_pagefault.c |  2 +-
>>   drivers/gpu/drm/xe/xe_svm.c       |  3 ++-
>>   drivers/gpu/drm/xe/xe_vm.c        | 18 +++++++++++++++++-
>>   drivers/gpu/drm/xe/xe_vm.h        |  9 ++++++++-
>>   drivers/gpu/drm/xe/xe_vm_types.h  |  1 +
>>   6 files changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
>> index 205cb4e7f9e8..954f0965deb8 100644
>> --- a/drivers/gpu/drm/xe/xe_device.c
>> +++ b/drivers/gpu/drm/xe/xe_device.c
>> @@ -179,6 +179,10 @@ static void xe_file_close(struct drm_device *dev,
>> struct drm_file *file)
>>
>>   	guard(xe_pm_runtime)(xe);
>>
>> +	/* Block new VM work before starting asynchronous queue teardown.
>> */
>> +	xa_for_each(&xef->vm.xa, idx, vm)
>> +		xe_vm_close_start(vm);
>> +
>>   	/*
>>   	 * No need for exec_queue.lock here as there is no contention for it
>>   	 * when FD is closing as IOCTLs presumably can't be modifying the diff
>> --git a/drivers/gpu/drm/xe/xe_pagefault.c
>> b/drivers/gpu/drm/xe/xe_pagefault.c
>> index aeb56ff5d58e..4bdd714b9f88 100644
>> --- a/drivers/gpu/drm/xe/xe_pagefault.c
>> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
>> @@ -265,7 +265,7 @@ static int xe_pagefault_service(struct xe_pagefault
>> *pf)
>>
>>   	down_read(&vm->lock);
>>
>> -	if (xe_vm_is_closed(vm)) {
>> +	if (xe_vm_is_closed_or_banned(vm)) {
> Isnt still it a concern for cached faults, as far as I understand, some ranges are cached and if same is cache hit, it will not reach here and response successful. Context may then keep running and more faults if VM which is closing removing related mappings during execution, may get cat error worse?
>
> Can we check VM state somehow while responding cached faults?


Thank you for pointing this.
Yes, you are right. The cached-fault path can skip 
xe_pagefault_service() so this check does not cover all successful 
responses.


Thanks,
Arvind

>
> Tejas
>>   		err = -ENOENT;
>>   		goto unlock_vm;
>>   	}
>> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
>> index 6c3033fc4db7..c2a9dd98f363 100644
>> --- a/drivers/gpu/drm/xe/xe_svm.c
>> +++ b/drivers/gpu/drm/xe/xe_svm.c
>> @@ -218,7 +218,8 @@ xe_svm_range_notifier_event_end(struct xe_vm
>> *vm, struct drm_gpusvm_range *r,
>>
>>   	drm_gpusvm_unmap_pages(&vm->svm.gpusvm, &(to_xe_range(r)-
>>> pages),
>>   			       drm_gpusvm_range_size(r) >> PAGE_SHIFT, &ctx);
>> -	if (!xe_vm_is_closed(vm) && mmu_range->event ==
>> MMU_NOTIFY_UNMAP)
>> +	if (!xe_vm_is_closed(vm) && !xe_vm_is_closing(vm) &&
>> +	    mmu_range->event == MMU_NOTIFY_UNMAP)
>>   		xe_svm_garbage_collector_add_range(vm, to_xe_range(r),
>>   						   mmu_range);
>>   }
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c index
>> 264bdab75de2..5d0b616a27b3 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -1913,6 +1913,20 @@ static void xe_vm_close(struct xe_vm *vm)
>>   		drm_dev_exit(idx);
>>   }
>>
>> +void xe_vm_close_start(struct xe_vm *vm) {
>> +	down_write(&vm->lock);
>> +	if (xe_vm_in_fault_mode(vm))
>> +		xe_svm_notifier_lock(vm);
>> +
>> +	/* Keep size valid so SVM invalidation still performs its full drain. */
>> +	vm->flags |= XE_VM_FLAG_CLOSING;
>> +
>> +	if (xe_vm_in_fault_mode(vm))
>> +		xe_svm_notifier_unlock(vm);
>> +	up_write(&vm->lock);
>> +}
>> +
>>   void xe_vm_close_and_put(struct xe_vm *vm)  {
>>   	LIST_HEAD(contested);
>> @@ -2214,8 +2228,10 @@ int xe_vm_destroy_ioctl(struct drm_device *dev,
>> void *data,
>>   		xa_erase(&xef->vm.xa, args->vm_id);
>>   	mutex_unlock(&xef->vm.lock);
>>
>> -	if (!err)
>> +	if (!err) {
>> +		xe_vm_close_start(vm);
>>   		xe_vm_close_and_put(vm);
>> +	}
>>
>>   	return err;
>>   }
>> diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h index
>> c5b900f38ded..70456ffe27e2 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.h
>> +++ b/drivers/gpu/drm/xe/xe_vm.h
>> @@ -59,6 +59,11 @@ static inline bool xe_vm_is_closed(struct xe_vm *vm)
>>   	return !vm->size;
>>   }
>>
>> +static inline bool xe_vm_is_closing(struct xe_vm *vm) {
>> +	return vm->flags & XE_VM_FLAG_CLOSING; }
>> +
>>   static inline bool xe_vm_is_banned(struct xe_vm *vm)  {
>>   	return vm->flags & XE_VM_FLAG_BANNED;
>> @@ -67,7 +72,8 @@ static inline bool xe_vm_is_banned(struct xe_vm *vm)
>> static inline bool xe_vm_is_closed_or_banned(struct xe_vm *vm)  {
>>   	lockdep_assert_held(&vm->lock);
>> -	return xe_vm_is_closed(vm) || xe_vm_is_banned(vm);
>> +	return xe_vm_is_closed(vm) || xe_vm_is_banned(vm) ||
>> +		xe_vm_is_closing(vm);
>>   }
>>
>>   struct xe_vma *
>> @@ -214,6 +220,7 @@ int xe_vm_get_property_ioctl(struct drm_device
>> *dev, void *data,
>>   			     struct drm_file *file);
>>
>>   void xe_vm_close_and_put(struct xe_vm *vm);
>> +void xe_vm_close_start(struct xe_vm *vm);
>>
>>   static inline bool xe_vm_in_fault_mode(struct xe_vm *vm)  { diff --git
>> a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
>> index 648031e64145..16b051a0cf10 100644
>> --- a/drivers/gpu/drm/xe/xe_vm_types.h
>> +++ b/drivers/gpu/drm/xe/xe_vm_types.h
>> @@ -286,6 +286,7 @@ struct xe_vm {
>>   #define XE_VM_FLAG_SET_TILE_ID(tile)	FIELD_PREP(GENMASK(7, 6),
>> (tile)->id)
>>   #define XE_VM_FLAG_GSC			BIT(8)
>>   #define XE_VM_FLAG_NO_VM_OVERCOMMIT     BIT(9)
>> +#define XE_VM_FLAG_CLOSING		BIT(10)
>>   	unsigned long flags;
>>
>>   	/**
>> --
>> 2.43.0
