Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A40C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138AB10F41D;
	Thu, 24 Sep 2026 10:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iqD+eH7G";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB11F10F41E;
 Thu, 24 Sep 2026 10:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790244397; x=1821780397;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kFkevQsMz2heXC6zJ+CGqEGWFn3qpN2Y0mX1Y3z1SW8=;
 b=iqD+eH7GA4n6dldlsyLbQycUF+TnL+LaLqbV+2vHsaALIXiJFa5G++Qu
 KxINvLb/OuK0SnR05kPONG9cPhJeTJTXb4fJnHt3M+B9kLZeByifeoJwp
 rK/Yl4LyOg/R+S5wsp7tIot9JTWYUxzGksOhMaM2YvVaNCBek7+9DASkP
 x3THqgw1tPTzqBGk8L+Q1Ij7cyyC3ukTcyZd+4QT2D4RFpK/p955PzOTp
 dGmmrkYDs7DRnsktxB2iZXnzcoCQzDGgKqxKAkG6t08IlrH5W2Gjpmubn
 3zN9YET6VCGusnoy+pQxeZfDbRxHdWu5ZRyVC4xtJEqdghy39CH60UKdl w==;
X-CSE-ConnectionGUID: YdtQAjo6TwSFC1rGh14ZAA==
X-CSE-MsgGUID: 2h/64r2lQNKDzQz2ps7ZVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90132686"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90132686"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 03:06:36 -0700
X-CSE-ConnectionGUID: lJPNDhdJQXSPeBud+VMLAw==
X-CSE-MsgGUID: 7DQJXT/TRJ+MRGM3qeApTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="272571957"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 03:06:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 03:06:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 03:06:36 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 03:06:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xc0fTKuaTPz9ptz/wa7wzm0DMOR2sV0HpbAbGe3gTs+p1uQgl0QoKrrH7ija5oWK+OuYl5mpT20laDjLHz56ENOjjA6/fZHADqTgsSHoNZRsCzUBto1eVgHGmrTzKelckFlroS8xqSJ85CPMUTD9wQHi7HXn+vAeqAiVA54lacgwGBPlF7fIv4L58tPjhX5FshMT+e2atNQ/oP0NojVW/4sRsEDaSTVAdN7n4lKGImwgqlZxV4GdjtYUuPlRoF45D1CKcvqkzymfkp+AA7kDfCsW8R8iabQnCHlb+vyoyCG2zZ0fTPJllSu0s8r3/aORpnkr+pXJ5YOUTFk8axwK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PGBuHFDtc1vB0nl5FZWsNw0i1lszD0FAWup7ewt/0Q=;
 b=eem2z5Bmj2m/LawGoU5O+vMDdRpisbVCLJwJt2kRppQfQ91q9z88MBqz+AbWlCbUQPEx3izVHRkF6SJVMK51ydPMlABZocCGB+26JAIeL89FFjn79C8iLXOFW/AsbrU7GQRd9PXvcs+tDAcrUago0vSo3ERp5TzkTFNCCpl4ZOCJymAy6LPeF+Y+9Br7z3WcZEjt+Yqg4rQucTTz7FjE71LfNq0G6sC25RwNfFwE1Rk0HbyzdwdlPYhkA7FTD0BvdorayNNoDH+Wp0mzM2OxI4hDQQXjO3vsAIPV7Vm2QuauFyUH8MS1zVOSUskb3wVvkUycoFN48F6BvouIvavIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by PH4PPF722C57DB3.namprd11.prod.outlook.com (2603:10b6:518:1::e68)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:06:34 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 10:06:33 +0000
Message-ID: <841ed3ad-f8fc-4d70-832d-a1129ba1dd11@intel.com>
Date: Thu, 24 Sep 2026 15:36:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/xe: Fix VM teardown and migration queue recovery
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
 <aq270L/+biIRJHkX@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <aq270L/+biIRJHkX@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0307.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::10) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|PH4PPF722C57DB3:EE_
X-MS-Office365-Filtering-Correlation-Id: fc543c91-ef17-4b23-d4d3-08df1a23825f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: kFbhSmeHkREDg9ianVzIRvElaiU5vn2HQVNrCIve8IKj4cTk7r1JLjDmJ55rVLgYBQs1OZLvg3q5bTpWp8ZVgDb5AiRvaYTmwb/RVo54muijdV6ORY1ggqAZELJSFyqxs/o7X15W7uA875mLTvLKeagmWwAPRLFlGDpor3y57CtesH0RSuNuZMqXz746pCGqs5vxk1J540fhDtidfTOPQP9/QXDhirE5So3am9jon5mrqFvHO3ZHMKwd775etkOnRLyi35ykwZyKcVtxOIte2oXrPH36ggWe0ALsB5VP28NMmZ0qpicvlfmvZEx8reWJ05NgRRjEeteqjyrazU0i2I0r96YilsKxGDSuDlmyE52fGPlCm1qORPl4BSH/AFIuM+F5jDekbgruU9OMrTOlrO0bn89BWLt2xyU/g54yDjWzDIHfwqu5LFfWWo1k7qsDWtMzaRUOkmqvRgvHllLUce9BAPARIHUdREUZZ7o8FKoMOy/dg1a5yFmR8qT2CGuGbw72BZtOE0cnsdHDTjdc/b9CoVzxxHNlVkz5R4W4D710tkmqHikuWCFReGYw4cymanvUbmXkyBS97og3ZaHvfh3I/WjiNiKKqD1D02QTbWwWphwZMFa8toYhmpCo8Z4W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1dRd29kdC9vT3Y3MDU4OVF0SS90Sy9BUG51QUZtWlJlZXhoRlRVZ2lwdy9R?=
 =?utf-8?B?MFlZMkMyeE13SGkxWGsyWHAxa0NiakVhemRqUFNJM3NhVi9lbXlWSDZRaFF1?=
 =?utf-8?B?bjBWZ01lMForaDV0QW1LNkdBNnRwcFlvNjBDekhpbjRSM3BGRy9MUFVJMm1w?=
 =?utf-8?B?WHFQaTVMUUZXOTlwWTNYOXIycjB1ZzBUZXRhQ25SaldBSUNwNmlicWtsdnYw?=
 =?utf-8?B?WGxHMTEwRFhrdGdDRzN3aU5VaHFJa25GVDROQ2k2UThPWVEvZisrNEhDYXpq?=
 =?utf-8?B?SE5LRHZIZkppeW51S0VuMTdKa1dRdVNCN2xWa09vSk9WWFhPQWpRUHlUTzlL?=
 =?utf-8?B?Z1o2RHY2VVRRUUx6TFYwdXhtcll5YnR1NVQ2WlhJN056YWluYXlXKzdrbFFq?=
 =?utf-8?B?TXh3K2FVZk9ZTXBuUFYvL05EMUxkZGRwREFpOHFrTEV4UTJ6QmhoTzRJc0dn?=
 =?utf-8?B?SWZBV0hKUExvYWRsUEZSU25lSTVWeG9sUjduYWsvem9OYUh4UnBiMktsN3BS?=
 =?utf-8?B?c0x4ajZYRms4TTQyQWV3Qlk3cThDNzJJYzEvcXZwL29ObXpzenFoZ0Jza2g2?=
 =?utf-8?B?ODlPa0RndXhOU3ZacGczVmhEVmVpY1pTK0ZaelNpV01HVFllQUNSSmE0d1lC?=
 =?utf-8?B?dkc0Z2YySHdYcjJOOWNFYjZBTnBvVlhMbkxjQll6RWZ5RVhRVG1ubnBUS2py?=
 =?utf-8?B?NUFVSFd4ZmxWajhEc0VNYS9KVFdnTWpMeWhtVjhyZTVFREhHdW0ycDBmWUg1?=
 =?utf-8?B?UzNsUXd5dUJZN3BWbGcvenB4UG5Ic3JMODhsdTlEdTBMblQyOC84MDF1Q1VL?=
 =?utf-8?B?S05lVTh6end4aTVBQU9HYUc1RFYrcWUwZ1dQbDRuVmp5TUV4blVPRWVWcFVE?=
 =?utf-8?B?VE5nQ3NvQzZkOGw3MkNKblNjQjFBZldRYUEwRVVHcUw4TTczTEk3NDFHYXlG?=
 =?utf-8?B?bjlSdVFRQW5rL0NHL3FCbjVQVERmRTRjRHM0ajRVNTlLNEJFVDAvZFNpeEtY?=
 =?utf-8?B?dmJNeWNGODI0aHFWS1ZlQVlOOTBSNlYyUGpaOGlOYnVZK3oyVkVFY0RLRWVo?=
 =?utf-8?B?L01DL0VuOFAvb1hNclRpdyszak9CZElSNkZrcHVUVFZXMGhBWHpuMWZjRmVT?=
 =?utf-8?B?eDNpOGxFWVpkN2ZFNk5sZ0JqeWpyZ2QrMlBpTExDVHpEckpVbUFtRVJCazE5?=
 =?utf-8?B?RHFwaDEwaFQ2TDc0MDZJaHJWRm91MWQ0QXFUTFlMcVZybzB2ejJYNE1LM3Zx?=
 =?utf-8?B?Smx1SFVWT0JBWkRVUHh0My9XM0dDQmdtWVRPUFpVTXlEblFlOXpjNTEzcENn?=
 =?utf-8?B?Vm9tcWk0ZDlRa3AvZW1lTDY3cnBldGtCa2g4MjdKNlZDajBDSWgrMCtBaGht?=
 =?utf-8?B?UkRWZEM1YUJWR0lWSVlCTEdvY3VLTGpmODlPd2txOXZDYnl0c2g5MUQ4NGZu?=
 =?utf-8?B?a2d0akNlR1hUY2dxOTlBNWdZbU9mWi9lWEhXSEhPMEZpL1ZoTDh3UlFWRlBZ?=
 =?utf-8?B?TXQ4MnUzTGJMYWtVYTdvUnJyL0szb2Q3UnZ3OXJEU1JuTWMwbnJWVmpsUENk?=
 =?utf-8?B?SnVpbStXSXcrTEt2QzY5K2ZxNTN4eHpDSkg1bGR2bE84MkRzS1JhWlJXZ25t?=
 =?utf-8?B?UFZ0YmlKNFBKUG9WNm9CSmRhU3kvUzUxQWdxS3pYK1NBWHVSTVhIazI4RFg2?=
 =?utf-8?B?ZTZGajhEdjdoWnlnN2dXQkpBUk1majliNnF2TzI3am9wZlNNMHBBMnkyWHBV?=
 =?utf-8?B?V3R3dHZRQ2xjZ0lDczBXaUtuemZGMTFYbWdLdHkvVjJuRkd2enhxZXlQYzVM?=
 =?utf-8?B?Z0t1aGtpRlJ4aXQyNFZJT3VqMEIzZCttZ3EveFEzRllWYzE4a1p2ZkJ0ZE9z?=
 =?utf-8?B?SUlzbnVZbTFyT0FoWmVObnEyVW9vekZvS3g1YzlLam1ucUk0Yk9XUW9JSXhS?=
 =?utf-8?B?MEN2MU1SM1BrWnBqTUtnU0tPQ2hIMUp5M1RuUTVnT0ZJR3N3VjVvQkJpMU8r?=
 =?utf-8?B?MWtNRVg3OTdWZkoxYzV2SWRMT0hxUVdNbGxVOXAyc00xaW9LRTFCUk5id1ND?=
 =?utf-8?B?OE05UHNlSTZDekhmK1R3Wm80d0gzb01ZTm81V1U3RzV1NGo0MURNa2UxUkRN?=
 =?utf-8?B?cmpwbHRrUm1tc2xWcEtyeWNXME5hUnpuemZpQnA0cGZqUWJGNWZWakdjZFJD?=
 =?utf-8?B?eGIvTnRjaE5yNzcyY0UydXNsbWxZNWRvVkhhYlN1Mno3SFdtTThySnZZL2Nz?=
 =?utf-8?B?V2JaaElvVDdKMmFiY2dnWThLeUhrdFE5Z3RlNXdkQUVua25LcVgrMmRZaWcv?=
 =?utf-8?B?U0lPRmxxRUEwZDZYWFRQenV5VWhzbkhBb1NPc1FlS0FCTWdmSUE2dz09?=
X-Exchange-RoutingPolicyChecked: sRWaemQFCLhY/zL208lmmvK7INQQ2T4Ljb9k2Rf4OVzUKAPY4hCTwCkOcL0tQ8KdLmPVF3+MPsiNrEVAxaD+UA/Fiz1NWkUdnUot1V5JOOA5dL2RzQQHmXF0m4aj/QpdOWxA6Yjr7BGbxyXicC1q86HTNxyKr63vBTSlN9V9ZIJUevXBggMjsiUQuWHJ3Xt/CXMot5rdaXzpVjkhN/S0Jhy5KLHdcc9MXIS+77ctNgSFusOYcGz60hy3AtJwb1q3sr7HF4P4fzt39HIgfcDeKkGxdtRLBs7LbSm95c2FOdDm96kzJuvb6FjNoEnigfdt6i6VB4haCS4FKSgnsRuN4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc543c91-ef17-4b23-d4d3-08df1a23825f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 10:06:33.6318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rphmob3sykxjloABHy8DInMZUuItn9tEFbz+nRb3NFAOU5HRBVqUuSTDc3Wj6gMWFXzg/3LI5NjfBhOVMNuUGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH4PPF722C57DB3
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


On 19-09-2026 04:01, Matthew Brost wrote:
> On Wed, Sep 16, 2026 at 03:23:32PM +0530, Arvind Yadav wrote:
>> On BMG, terminating a process with Ctrl+C while GPU work is running under
>> VRAM pressure can cause an RCS page fault followed by a migration queue
>> timeout on BCS8 (guc_id 0). The driver resets the GT, but the pending
>> migration job can time out again and eventually wedge the device.
>>
> If we can just avoid faults on ctrl-c or segfault will this series be
> needed (or at least only a subset of this series)?
>
> I suggested a way to kill the exec queue first + sync wait on those here
> [1] before clobbering the GPU page tables? I don't really care who works
> on [1].


Thankyou Matt for you review comments and suggestions.

My series waits for final queue cleanup before removing the VM mappings. 
Your suggestion is to disable all queues first, then wait for them to 
stop before calling xe_vm_close().
I will build on your v6 patch and add the synchronous wait from the 
earlier discussion. I will test that approach and check which parts of 
my series are still needed.

>
> We still need root cause why a RCS fault affects the BCS engine - it
> shouldn't and need investigation.


I will also continue the GuC investigation into the first BCS8 failure. 
Avoiding the teardown fault may prevent this reproducer, but it does not 
explain why the RCS fault affects BCS8.
I am discussing this issue with the GuC team, and once we identify the 
root cause, I will provide an update.

Thanks,
Arvind

>
> Matt
>
> [1] https://patchwork.freedesktop.org/patch/752845/?series=173889&rev=1#comment_1391707
>
>> BCS8 is reserved for paging and runs migration and VM bind work.
>> The exact hardware link between the RCS fault and the BCS8 stall
>> is still under investigation. This series addresses the teardown
>> and recovery problems found while debugging this failure.
>>
>> During file close, exec queue cleanup starts asynchronously, but the VM
>> mappings can be removed before that cleanup finishes. A missed wakeup in
>> the GuC disable-completion handler can also turn a completed operation
>> into a five-second timeout and an unnecessary GT reset.
>>
>> The reset replay path rewinds the software ring tail to the oldest pending
>> job, but leaves the LRC head at its saved position. This leaves different
>> starting positions for replay.
>>
>> The four patches address these paths:
>> 1. Clear pending-disable state before waking waiters, so a completed disable
>> does not appear to time out.
>>
>> 2. Mark VMs as closing before queue cleanup. Reject new work and page faults
>> on closing VMs, while allowing existing SVM invalidation to drain mappings.
>>
>> 3. Keep VM mappings alive until queue cleanup completes. File close uses one
>> five-second queue-wait budget across all VMs, then defers any remaining teardown.
>> VM destroy defers without waiting. Device references protect deferred close and
>> final VM destruction on the module-lifetime destroy workqueue.
>>
>> 4. Set the software tail and LRC head and tail to the oldest pending job before
>> resubmitting jobs after a GT reset.
>>
>> The five-second budget applies only to the new queue-cleanup wait.
>> Existing teardown waits are unchanged.
>>
>> Arvind Yadav (5):
>>    drm/xe: Hold a device reference across deferred VM destruction
>>    drm/xe/guc: Wake disable waiters after clearing pending state
>>    drm/xe: Mark VMs as closing before queue cleanup
>>    drm/xe: Defer VM teardown until exec queue cleanup completes
>>    drm/xe/guc: Reset LRC ring pointers before replay
>>
>>   drivers/gpu/drm/xe/xe_device.c     |  25 +++-
>>   drivers/gpu/drm/xe/xe_exec_queue.c |  22 +++-
>>   drivers/gpu/drm/xe/xe_guc_submit.c |  60 +++++----
>>   drivers/gpu/drm/xe/xe_module.c     |   6 +-
>>   drivers/gpu/drm/xe/xe_pagefault.c  |   2 +-
>>   drivers/gpu/drm/xe/xe_svm.c        |   3 +-
>>   drivers/gpu/drm/xe/xe_vm.c         | 205 +++++++++++++++++++++++++----
>>   drivers/gpu/drm/xe/xe_vm.h         |  14 +-
>>   drivers/gpu/drm/xe/xe_vm_types.h   |  16 +++
>>   9 files changed, 289 insertions(+), 64 deletions(-)
>>
>> -- 
>> 2.43.0
>>
