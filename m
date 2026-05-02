Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2C1CD3424
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 04:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C105A10E0A9;
	Sat,  2 May 2026 04:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z1WEJgFV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB7710E0A9;
 Sat,  2 May 2026 04:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777695231; x=1809231231;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+i4wgFioWDzeZIDZX1rpYtI8R9EDxjZvqUvvtbiTOUU=;
 b=Z1WEJgFVPlWI9sr5BHfL8iK0ZUIVYYnH0kSgzwHhBHayIwyneJAB9eTy
 85if45UKmvvCUBJ5kQigYmdRM/JqBX4pH5HehCI+AQIJdMtSsukDwrD8B
 fHIQs1fqgzRrD8WMFYbDCD5zuwO6tVKf3Rg4SECDivgmBEn3oGN+BszxN
 LcuAC/HRhIqNqjbMk7T5R3LQsJf0O5Z4tSG9zo+s4gfgmS7zsPOooyyoo
 t4JvYMliovIEGuv+VAHK5tluRSDuhlo71U8j6I6nTYbiKKAG1B0aNBwY1
 ZPofQuQl1/Uk5pD723W3nOjSGdLBvyOqV61ROFDafIk2qko4AsUevzZUN A==;
X-CSE-ConnectionGUID: LDaM9FO1Se+zrfeVVBpJAw==
X-CSE-MsgGUID: kL+kiLM3QlqSUsQQXXG6fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="78640263"
X-IronPort-AV: E=Sophos;i="6.23,211,1770624000"; d="scan'208";a="78640263"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2026 21:13:50 -0700
X-CSE-ConnectionGUID: aVQfa3gjSUiFyhwn3Vktzw==
X-CSE-MsgGUID: u0IfoECMRhuVMdjbplc4CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,211,1770624000"; d="scan'208";a="236808648"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2026 21:13:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 21:13:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 1 May 2026 21:13:49 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 21:13:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSsD8qnxKwdJAQvh7Er1FYrqjySNXJf6hv9qZKjR63V7ynn91w//FXx976/VYizU1SpkV6OwmtT6P604WZ85eMgSVLwDG9nGIv6VRVHaGQmRUY+b9MN2RWi2G9kKcnMSLIdCqFhqq9TXrn85qER2Wzntz2Xj8kVpQ79b+Ku86bhziQsMSuMkFmhWmWX5ebJvoKurBF71zQZ5BXwnIccyzIW3MSv0zXBNWRYlOvwURkWSLLBdhGSsM8nIcFI0ZqyEwN9952dGo4Yz11M041SGZE6pZNE4jXq0jBaISk3h2BKUfjpxONjxc63QMakU5HWrAhuZ3Uy8j5biSoAxWtHfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksYsJ7DUfKgXaJleY1OaWRNtBgMAxwfCTa17B7pcJaA=;
 b=Gav5Hq7Uvw51cz7TZNt0tt5CMsrbCKj+m25qnyw2kWJ55BdeVZUezlVkYmfpVi87hcl6nE7Ln9A1JPyvOUq/AOiijURoK4+o8KLvME1FL5ndIwUxsf0lpIesnCWxg5NVUKeNme9gX2CLrbr3NgstHShvhMA/sYUZQPktmFmzqE0+kTx8iJu/EqFKaflxnSohswMusKke//sVasyy6ncDZu0hsDqp3X0DB0BEjRDOB2tluklH2RA+fOuj926YPrFhpY0tkud+52GVrhXeYWnfFFJUyRaO4e+vKrGJBXK04rgKfVu7KmvZWiAQ2Wc77IB0He7BVBg7ajc+9UiFk4OO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB8812.namprd11.prod.outlook.com (2603:10b6:806:469::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 04:13:41 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 04:13:41 +0000
Date: Fri, 1 May 2026 21:13:38 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Kenneth Crudup <kenny@panix.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/ttm: Fix GPU MM stats during pool shrinking
Message-ID: <afV58nx436pwQ882@gsse-cloud1.jf.intel.com>
References: <20260501223003.2648450-1-matthew.brost@intel.com>
 <18c48e7f-a2bd-4e74-9262-266cd5c2fde8@panix.com>
 <afV5r9PpyAimOQmV@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afV5r9PpyAimOQmV@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da8af55-95d7-403b-21ce-08dea8013164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 1a7sAB0Ie8Y1YB25+i7HCA5mIboo9M9hm/SeQ/XhnyH/JB343yeVw1WsGr//Dsq4CK5tEJRwU2D2JKNOk9ICuldtFMSqtY9BZSNkiPgtXpqYBBFxEKlykKvIE4OPrVZVwL0f72oNC7odu/oxSZytAu+r2CePQwzKoPiZzw9RCUp+VE+1cbvlwotyPKMbiMhsiYvTMJiODbBLsx7EdP/ya2bw8cVGk3fEehOCW2ROTqVZsaPa+pLrApnONIUDdm2ULic9jq4L2qo6yqCPN9JcDfKO5Ky69d0x8dyfxtJRK1NwBCZIDCo+QJSzk06FeEa+NaVYaPilkrrtORr7NqJkgz4I+3lSjgJHfqC2li1y918Rhq82+lzbjii2NjS3IK6Ulx1WQph9SmN29jkQlBwJ/JL0pSxWRwKM0WgdBebamSCJGJUhxuzQBVQL7EBTp0KquWzXd2A05HslAMnC9Odw8DPqtBHwMdFzaDwCLiFJgjyh23qqi5jyciJLHLM8CeMeYKdqNjRrOHsK08PHaQTa7j0IedLLJ3QlhQcfNzWzmApVkkYdcG7xob2r6BTNu3qXvIY73WAxlcYH2/yC/WMlClAWYs6i+tNt45lIH2dXnAvOsoJbhy0RnG8TZogMip8dywsr1pZy+46eHWXmUhYcgv7uusTuSXvOrniYwjB+w7gItEazU+ShMAglXZqh12YM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THduTEdqOHRqWnIvaitlM2tYWjFOM0xqNUwwcEoyaC9MY3pkTytYemtGK3k2?=
 =?utf-8?B?eG4xbDJnM1VvSHk4clBJMm1hQlBKYzJTcm4rNENBZVJ5OTBEN2xmT3RhZmxl?=
 =?utf-8?B?NDhhOGJRanpTclZ5aE84aE4wUTJzVEhWRVYvOGVseDlIdldVd3hScW9Qcmh0?=
 =?utf-8?B?QWZybEQzeGhKZDRHWThFZUVnQXhqWjNhMFpZTUM3Yk94VHpldnVkR05LTUpJ?=
 =?utf-8?B?aXJLQU9wTmc4VnZtOFVEMjZMUUtZSUQ5eG9HOTJUNzJXeVhDZjRvbzd4QVdi?=
 =?utf-8?B?QWdkaHNtZHVQcG9IdXhGZjBrb3RMNjV0OGYxU1lKb1pWeEk1NmlWODRObEFN?=
 =?utf-8?B?MFBKTkdZS3BkOWNHQ2lhR1MrVzBQNlpYcVp4aTZJRFZuaXE2VzJuZjh3dWdB?=
 =?utf-8?B?ZzB5MXNaTU9pTFZKbFN0SjVLNWZSYkZYdVJXakJqQ3RBVEIwUUQ5MEJpK3R1?=
 =?utf-8?B?M2pUQzUxWXo5Z29ncGFVUkNicHJXMVNwcHRGYndqcTNheVh0U2RJZGNQOGZ0?=
 =?utf-8?B?MUc2RXdHMEUwdm9zcmlwbUNxcmVzMCtmWEcza2V2VzhJN3ErVTJHOERDT0VX?=
 =?utf-8?B?RVJWVHpkZUJhZ1N6TkZHYWpTQnhFR2ZQMjRWMzhQOHRjTkU5cWlOeE1ReDlr?=
 =?utf-8?B?VkdCUmJ5cUxNQThNOUNpc1c1NWFDWThWdUtKWFhxQnVoUHZHU1JuZGl1ZzV2?=
 =?utf-8?B?VTIrQnd5WGYvajJZUks0dFVoc2dndk54SHFjNWtSMktzRDVMR1pKTm5TeStT?=
 =?utf-8?B?WjRhdWMvNWlneGxXdkRiamlOSlVudmxkN0hjeGFwbjc5WmsrWllQdm5rckZE?=
 =?utf-8?B?NTllZS9mSFdvb0E1RGdybDFZVm5JYnZpY1BlVmQ3T0o0NTgyUVg3c3YzNTRF?=
 =?utf-8?B?TXZxM0hneENpdWl3alNEdWFZb2xKMDRaTUNIbElPczFIMUFhSFJmdmpEUC9W?=
 =?utf-8?B?eFV4dUllZDJ4UFgyeisrYU1ValNyaGpaVkF4U2N5ai9pa2hjR2k4UnFGOGND?=
 =?utf-8?B?NDJHRlFBQjRmTFhxcTRNdDRzNTErMkJLcG0zL0xyWXIvNloxclc5OTBtZmpv?=
 =?utf-8?B?SUQ5OURTL29SbzhQTmZXamhuakpYZlQvTWo0UnRFaWVYbUI3YnRpcDJDOUZ5?=
 =?utf-8?B?amFFaHJJenVaV0RwbWlpZlRrNFp2YkZHS0QwVjRlWVZILzk4eHFuZW1XeFdX?=
 =?utf-8?B?MzZ0ZHVjT0dSbDI3d283QmdxRTFxZFVIcVlPUTg3eDczRnh2c1lBT2N2VDZP?=
 =?utf-8?B?K2ZnWFIzeXdJaW1BU2RxcllBV1FtelZXei85Vjl1UW93QWhiZWU0Tkh1UmZx?=
 =?utf-8?B?R1NzTWxnOHVTdnEzV25pOHdjdWxwT3lpdWhSN1YrYklRMWFIK3FWaWFvWVg0?=
 =?utf-8?B?OXk0a0lyN3ZIdEhjWitkV0tMaGhxOGNhRlgvK2pjMG51cHJEbGhvTmdVNk55?=
 =?utf-8?B?SHU1RSs1WGZNdkNvMzB5cmRxMmZwRklBN29LVEVuSlMwdW5HRGp2TVhEalh6?=
 =?utf-8?B?UC8wZEU5NjJ6Y014Rm16ZklGRXJxSDdFLytRZlRxamY3QWxqdm1ReWJHdGxs?=
 =?utf-8?B?WVVRMUtQVDZKaTdabFkvdE9aczZHVHpuUkxIcm51eHRjS0pvNHR1QmlHelY2?=
 =?utf-8?B?MVNwZHN5elpuYXl1eVhWWnFWa2JXemhxelFYdVBXbDBqUHdEeUZRcG1qUE9S?=
 =?utf-8?B?SDN4WkZWWEVpVkt3blN3UkFlblZLTXEwcVNPVXZGaEVVTWZiTDJtRU9UekhS?=
 =?utf-8?B?UXNtb1FwNmV2eGxWbjBRM04weG5LaTkvTkRlcmhrRi9haDhGTmFkYVV3M1gv?=
 =?utf-8?B?cDJLb2VsSXE3QnBBWFVkYVlITVpuc28xVDdncnB3YmdrUXFYSVdjck9KYUJx?=
 =?utf-8?B?U2xsaDV2SHJYS0xaaEZxTm1nQVJqNXNwUkJuQ3JQbWtyQTdNZG9EekxOREE4?=
 =?utf-8?B?WGpVSnVCV0ZUZU4rQXBVamNDRVlLcTcxZUFmVkpNRUZYZWRrNUtxTlJZaUhz?=
 =?utf-8?B?UzViUlZibktManY4Q0ZaRHJlaFhmUUJ5SDlWVEdiQVVjMGFxRk12ekNFRjJK?=
 =?utf-8?B?V2ZSMjNVQzRZOWRUQmVGQmlqVEhoS3pXZDl3ZmFpSlJsOHdkOXJkaGZ6QWJO?=
 =?utf-8?B?ZzZlR2VDdi9NQ201aWMzOEt0OHV4K0drSitKeW03ZVVQNUNGVGwwb2VLUmVY?=
 =?utf-8?B?bnc4dXRMTkNIOFRKOHhvUnFQWUxJc0szZUVvYVlPNVpZWi9GdmxPb3prVjhW?=
 =?utf-8?B?OEtIOHRLYURHNGtib29XdTZTZG1HZEZ5VFB0M1VBUnNlQ29Od00vd1pBNU1i?=
 =?utf-8?B?cWlwTWg1NE51TzFUdVJwNDFnOVdYYU40dFBKbXMvSWlZbHk5a0ZmMVBzSUVI?=
 =?utf-8?Q?wwiNlCpsOjmTxPVs=3D?=
X-Exchange-RoutingPolicyChecked: bxuHDk6Crno8AfBtzkeNgCMfzL8q1c8W1qR2EYGZN0KnwDKXuudYfB5YnUE2vY7I3My0fztUy8LmtK1JzshcYFma9CLAjmcyZWD4jgc6es+3tHznpo4M9gff1RrK2x/Leuca60DuLnLQA1/IGDifvvrpkODGKue1VqR4QlJfeOhD4c+cCJDWaq3LRr76SxLPy7ESawPVqgdJ8h+6sDefax3OJdpYL6Nq1cGj2U/rmxgsDtGTPnyJbR7d+B07ikZwRJxZ14vJ5dFqphwWBSuIqsGsPvDz+tsmg4UwPIYC0hxfHkKXuQO6q+WA1FTPo20RsDAtISxDw3RhnXxFN9NpZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da8af55-95d7-403b-21ce-08dea8013164
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 04:13:41.1670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahr1YEUFCklN0wWXj2U3SOlwmUQ3vdkQAGqqsNKPdNXjZ1wcBsMUXE+eHncVr1d2V/R3eUHWcBQT5GcP8TqTVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8812
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

On Fri, May 01, 2026 at 09:12:31PM -0700, Matthew Brost wrote:
> On Fri, May 01, 2026 at 05:05:14PM -0700, Kenneth Crudup wrote:
> > 
> > On 5/1/26 15:30, Matthew Brost wrote:
> > 
> > > TTM pool shrinking frees pages by calling __free_pages() directly,
> > > which bypasses updates to NR_GPU_ACTIVE and leaves GPU MM accounting
> > > out of sync.
> > > 
> > > Introduce a helper, __free_pages_gpu_account(), and use it for all page
> > > frees in ttm_pool.c so GPU MM statistics are updated consistently.
> > 
> > OK, so why/how does "bonnie++" increase the GPU Memory size?
> > 
> 
> Well, it shouldn’t. What bonnie++ does is basically consume system
> memory, triggering reclaim, which in turn will evict GPU BOs that exist
> when the display is open. Thanks for pointing me to bonnie++ - this,
> plus running something like the WebGL Aquarium in Chrome, is a very nice
> test case for Xe/DRM shrinkers.
> 
> > ----
> > SwapTotal:      33554428 kB
> > MemTotal:       32345672 kB
> > GPUReclaim:       621568 kB
> > GPUActive:        453592 kB
> > 
> > SwapTotal:      33554428 kB
> > MemTotal:       32345672 kB
> > GPUActive:       5554976 kB
> > GPUReclaim:        12716 kB
> > 
> > SwapTotal:      33554428 kB
> > MemTotal:       32345672 kB
> > GPUActive:      18407272 kB
> > GPUReclaim:          884 kB
> > 
> > SwapTotal:      33554428 kB
> > MemTotal:       32345672 kB
> > GPUActive:      24022916 kB
> > GPUReclaim:          716 kB
> > 
> > SwapTotal:      33554428 kB
> > MemTotal:       32345672 kB
> > GPUActive:      25258248 kB
> > GPUReclaim:        16032 kB
> > 
> > SwapTotal:      33554428 kB
> > MemTotal:       32345672 kB
> > GPUActive:      28207188 kB
> > GPUReclaim:         3684 kB
> > ----
> > 
> > ... and I'm now not so sure the patch is working ... this after a 2nd bonnie
> > run:
> 
> It doesn’t appear that it is. I can recreate what you’re seeing with
> this patch alone on drm-tip. I originally coded this patch on top of a
> local fix to avoid the TTM shrinker allocating higher-order folios when

s/allocating/spliting

Matt

> reclaiming memory—this is working there. I falsely assumed it would work
> on drm-tip as well. Let me ensure I have a standalone fix for GPUActive
> accounting first, then apply my TTM shrinker fix on top.
> 
> Matt
> 
> > 
> > ----
> > GPUActive:      44357100 kB
> > SwapTotal:      33554428 kB
> > MemTotal:       32345672 kB
> > GPUReclaim:        94864 kB
> > 
> > GPUActive:      44373904 kB
> > SwapTotal:      33554428 kB
> > MemTotal:       32345672 kB
> > GPUReclaim:        94996 kB
> > 
> > GPUActive:      44354940 kB
> > SwapTotal:      33554428 kB
> > MemTotal:       32345672 kB
> > GPUReclaim:        98048 kB
> > 
> > GPUActive:      44769340 kB
> > SwapTotal:      33554428 kB
> > MemTotal:       32345672 kB
> > GPUReclaim:       122996 kB
> > ----
> > 
> > -Kenny
> > 
> > -- 
> > Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County
> > CA
> > 
