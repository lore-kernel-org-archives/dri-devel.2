Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F18CD3424
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 04:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0335410E1A7;
	Sat,  2 May 2026 04:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mlwaF5Wg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E33F110E0A9;
 Sat,  2 May 2026 04:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777695158; x=1809231158;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=VYJiTjBuQfRVDhhOrQwJNjBkPyyRPWJE6nmJ3zTjuCQ=;
 b=mlwaF5WgWGvx3PdApEL2iKXdjvjawn60w9s6UXlt0RU3t2dGsx2gtF+N
 pPShSGmBkX+uxhVw+KPxRCeLxjgQTGMxXqtlPHn3SkQT2NC2StS/dF87J
 UPfenV3dWlKzSkIRoGr3HjIHrt+tOsaBzs6B/2wC6ILyBTd1xwwwsd0D5
 PM99yDLzMI4aHBNfgTraWLVZnl5GabIWGtODSYg9piAsqinEpSDAcpff4
 yaarV67HZWaGrFH8B24iiNGLKhvLzLly04ujnW78ry4L8FHLjI8b8jzzd
 DhxbvUqPBN40/av1c/D3kfATlvdl1HCgoUm0cisNiPLtLSLskiAf+HGgP w==;
X-CSE-ConnectionGUID: 7LmyUd25Tv6X+YwLfQsDKw==
X-CSE-MsgGUID: k6nBEirlS/GS0gm+NJYfWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="78702700"
X-IronPort-AV: E=Sophos;i="6.23,211,1770624000"; d="scan'208";a="78702700"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2026 21:12:38 -0700
X-CSE-ConnectionGUID: snAAWsJqTWWZZMayUCRi5Q==
X-CSE-MsgGUID: 5sfoMz3wTUeiGzzz/++EpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,211,1770624000"; d="scan'208";a="231886716"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2026 21:12:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 21:12:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 1 May 2026 21:12:37 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 21:12:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuPVEHZYrMpGrcGhYuZg5aUu4MCf+0i+wJ0SThYFhfiJvCq+D9s//r3KBvMJKcuSqt5iKkXmVnVwSg7yg+06Nk1kIdw23FUHKfRLmQoQ32FvRq5UqFbzbVTbsuDlEQ7dtJQJOfAnaphnyvTX+LpoHk429A2EQ3iiJGty6wg9PGjCix4vSeZVY227d6gB4xSMsQIz3ouwkJ4AdUtC+Jao5DvYAwTH7khdMHYxWPNs24r+pvLGnwYqfD83cBpt00IxbO5fE+IuN0aF3rE0zayi+18gQ2UDYsUCwyHeXg6/jv6HaiymT7tgj2r4hEvrkWoufRZRbdMjG3vRhsVtGL639g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1Uc5/Wnn93uRx7tzoHhiczyXBdr25Yh3zMMQ4Z2Eqw=;
 b=gidBFu9XQVCtbMX3AUkv9AuEVkuTkypyOo7S4v5iDJZjLZCqQOshsmKVwi1qZR1E8icc5IZPyBDWKJi617q8SiQ+bEkgiwDBbSwgHjYhXRkSxqeF3ik+OW2cmeNl8MFG/LKEF8D5xE3o6n5a9kSe9SZZXzH93OAxgJWdG7daEYVgP3ZxnvwODefUgJunBRBXJsIqkFn6HPY4wg7ZgKdw0qNsa1XCcNiGzOwOfueaYGI4fkR8VxclugjR7mLhjDxI6x5puQxm3KSy6740mukmJ/0v0EFFFymJ+XsT/Z9rKPrYwXcfCDsmW8bHDp7P71CthigEJYAoK85C0NfD76Up3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB8812.namprd11.prod.outlook.com (2603:10b6:806:469::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 04:12:33 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 04:12:33 +0000
Date: Fri, 1 May 2026 21:12:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Kenneth Crudup <kenny@panix.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/ttm: Fix GPU MM stats during pool shrinking
Message-ID: <afV5r9PpyAimOQmV@gsse-cloud1.jf.intel.com>
References: <20260501223003.2648450-1-matthew.brost@intel.com>
 <18c48e7f-a2bd-4e74-9262-266cd5c2fde8@panix.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18c48e7f-a2bd-4e74-9262-266cd5c2fde8@panix.com>
X-ClientProxiedBy: BY3PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:a03:255::11) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2e5a55-edf4-487e-27a5-08dea8010904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: TeoODVkDELZpi30QN0svwjDL6/WM28xM/3Wnuwvqxs+aBx5lx3hn5A5OzX9FnyJqyD3XyRcHt5QqAQAV+7NXOdxbVFihiL4+rqEy+JMB7C7QKo60WEEemxaHh8XzB/PkbfhR2XxoBpkyn6ZGVoqEg1ch/er8F1ecfjvX+wX9s3VUzdWiiO3HN1dEmlrO4OyM3Y7dc70GfsRQG+OzF2jGta9qiW7764R69BR2CF4Ao0u0VZmRjp/yAEOeYJe2+qnTxMnZ6fjAoN2V4IXtdnmWL00PCLe4kjD2FdkHsEjCwyQoVde1lGQxTeyCev8T95zDZYMbA+uxIQcWQwdFFXhCv9YZQR9kyISttgLOq5aj7WDvvx3dQNCOXfUHXgTLDrDRiGiDVMx/lR/3upqsEUMDSGNxisMWYKGMXBtbdYMLGKTE2e6IR8EcoY/lD9RjiZFSFLeAYXyoU10ZTkZofMKxNXRCCycuP+00IcWD4wS1LAZhliOHJAgUpAPIqIXUEj5Pcdi8CHApdQY61rmgU2KXLlMhNu5KV2h9SyXpcZWF95cRy+HxwmSczawLYVw4UUZe/Dqurvqf/2hgYOcOMi39gYETAbo72u7AL4JiuUpqAGO4PqnadkQMshdTtMUngte6SV83aE4H8fTF51zuiQdSl27hcvMzfpOwvs53MwqPsmHhG1jqWgJbGro1PUNV37fg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjdTQSsxbHFRcWxaQ3kzZEszblRYSmxlZkdWT01NZE81ak5SNFM3NUVtTXBX?=
 =?utf-8?B?L2NrWXNIU0Y1Zjl6QmI5dm85YkozT0Rkd053Um5GL3JmcDVVeUI4RlZpYjFl?=
 =?utf-8?B?TS9Sd0dNN1hrMmE5c1B0ZmVMSkd2NUVuNnRycmdiU2wxbnEzTTdQeXVvOWRJ?=
 =?utf-8?B?ckNQZU9xek83Z2JWSEQ2SXIwNkR4UG1WWW1IaTlBazFQT2VvQjBzSUJUclVN?=
 =?utf-8?B?SytwODdsUlZPTmtnTk1qK254WFA5YU4xV1VhM2tIK3lyWThzSm1zdFhNTDk4?=
 =?utf-8?B?bHc1Z0t4YU8zekVIWnpzajAxNE52U1doMzRsTnhILy9QeFY0aVNMVFo1TnFY?=
 =?utf-8?B?aFNkK3hSUjZKUnhWM1JKL2ZuSHVrd1lXSGh3M3pvKzZNWVBiOXB3VVdLL2Nw?=
 =?utf-8?B?eXoxa0FlKzdRSFFWeGZkbkhSTFI3dFlMV0Zib3Vjd1kyc29aaTZ3MWlpMHc4?=
 =?utf-8?B?SXJVd202TE8zZ0JqVzdQblh3M0tjQmttcmkwQStrYVVRSUVObFNzekJXRTZx?=
 =?utf-8?B?d1JERUVDQ0piTVcwZVBXcUFGcC8rSEJhdWVDL0dGa2RqcWdFVWdMQ2NZRzBV?=
 =?utf-8?B?OE5qZ1dheGRpaW1JNnhzV3NxUjVoRTdrQjJZOXcvRVFhTnVrakpQaEFBaHgy?=
 =?utf-8?B?WlJkdlA5ZDQxaFg1dWZGY1RGWmFkNUVlVXdUNmptZDhQd0ppT2NENFdqV1pt?=
 =?utf-8?B?RVVrOHVMdFRyZS95WFRuYURsYTlRSHE5cXJvMnpTWjBCOFlPUll2YlpoL0xm?=
 =?utf-8?B?dDh0SHdFdXhEYkdmSEx1QTA0TnY3QmE2RndhYksyeUxWOUhUREZkcllSemFq?=
 =?utf-8?B?NlVhQjdwTTZKRDMzdjhOdnJqZmpjUkU0QWhKNlNINVFOMFZUQXJTbSsvRiti?=
 =?utf-8?B?b2ErTjhvNHlEcnpHclNnd3lFREpHY1lGcXNKaVd3dWpSUkdkNDhLdW01UGVv?=
 =?utf-8?B?dnp6dWpmZkk3RkZNcS9RVnZ6MEhZaVl6cnpITVJBVE1rM1k4QnVaa2t0a2Er?=
 =?utf-8?B?enBYditUQjQ1dkgzeHNTUGoxR1RnbWRINGcvYkVNVHRpTSsvbFdEWmVUSHA4?=
 =?utf-8?B?OVl3c1RNQTQrSGtzalhDaWtnOFAzakRGZXpKZkcxMlI3SGEraEtRUTVCSnRW?=
 =?utf-8?B?VFZVRlFMUzg2MCt5OUUvd0phWmJ6b2xWRU4xNDIydzlobkdwVjBsQnR3NVQ2?=
 =?utf-8?B?R1YyR3c4b1hMTkJzOXNOeEZ4aXZUcU96ZFVld1d0eHc2QkZySlhPOEpMRzRW?=
 =?utf-8?B?S0EvNWFBbWI5V3M1cWg1Z24rYVhKZExXbHFNM0lESjFQSDNNQWNEc0JBc0FB?=
 =?utf-8?B?RTZCMkxMMS9WQy9GV2FqRzN0bk5LUlZJS3pCK1pWQWpkbmp3NzlSc29OdC9l?=
 =?utf-8?B?eHNZc3BwdUYrcyt0R2tEZkVTanJsSEdlRTdQcW1aZThaMG0xcGZ6dTRIMnp1?=
 =?utf-8?B?UTRtR3FTeHBRdkxaTExaOXBIMU82SGFVcVpNSkhqOFNBTG5SQVI1a0xOWWE2?=
 =?utf-8?B?djAxb1RpSXRRdk5UUUR1U1R4d2c3RHI5RytCejNYcTFNRzFZeTl4ZkZIVWl1?=
 =?utf-8?B?bWozckI4elYxR1o0UFIyWUd0T3ZhUmp2NmJOL2o4ZWdZNm1JbTZ2bmpuRnEr?=
 =?utf-8?B?R0ZOQjZycHV5SmxwZjJNZlF6ZVlDOVVibEtnNkppakxPQlNJWEVLL2NVaUIv?=
 =?utf-8?B?ZlozZXVZYy9IdnJHcWE5S3F5T0FJRFhxQ2Z1WUtVRjN1UDJJZlNjUFpKaXF1?=
 =?utf-8?B?NkdvaTQ1Umt4Q2h6MFJ3alVILzJHTytiam14MDRaVDhvVnR6cmZuMWhDSFRE?=
 =?utf-8?B?L3FNVGxEQ1lPU0hrQUgwZmMwYlpDdTBncUdnS2M0OEpXVnRpRzBjS1EwZWNm?=
 =?utf-8?B?cnBsVmhQajZvNFc2bXg1WjZPbVRQOWFmRnhiTHVzRWkxNmt5ZmxqejhJYStK?=
 =?utf-8?B?aFM1NXltUUEwblRpWkMxWDEzbkc2WjRLQkdJemkvbFNwdHh3MmRnSnlLNUJi?=
 =?utf-8?B?VnFTS1g5YmpzR2x0MmNZM04rSjRNaUpid2RReEwxcWpEdXFDdnJPQjE1NUU1?=
 =?utf-8?B?bXN5ejNzRTJSdm14TGVrRFV1Mmo2S2liV3Y4d2trYTgySXJJaTZnVVNOSXB1?=
 =?utf-8?B?eWttditUbGt0bkI3bllNTzVuc2N0YzMzMDYveCt6VHZ4QmM2OHZBMlEyT0VU?=
 =?utf-8?B?cVlKRlNHTnRCSEJqRVRMZG9sTXlKUnI0NWNnL2tXWHJZQ3VRVUFvM3JmTWhq?=
 =?utf-8?B?RmtCQ2NZZThPbThDR1NrNnBzRVFvMXlQYkdPdHhhN3FITElqUUY1cTdka3RF?=
 =?utf-8?B?LzVrWUk2VWVOUXpGTW9GcUh0OWlKSEl3OGVPVElZemhjT1ZYWURlbVZnamd0?=
 =?utf-8?Q?wqlsGYmcVUxyKzKY=3D?=
X-Exchange-RoutingPolicyChecked: JxDhBztmF5HG21EWZUfwljygH5weNeH8vcKOJUa7ySP8bNKFn8En2zoIuate+awYt3nquaPgeXokFuGmk7hvG4GtDFbhL4w920oS6JWGHmB5xcF//23VcuUTS7lPlPj4ouuVq2PL/xdCIZIe68DQq42NimuL91wtj5wj0TNZhwWz7F/UaRIR6k8AoWkJlso/fNSBaVRd/SsCSoDFFgCZYtFhVqmsKcyaYRLrjfSnb1xkkMlVutwqWdrmZE/tm2Pj97UygXfrHpjqfc03sm/aX1p5a3mxKpKfg7eTcVTLDqiZfNuUBHsNKEAAsR+yHM7ofwyck5J2bRdU0ACOvg+4tw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2e5a55-edf4-487e-27a5-08dea8010904
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 04:12:33.4244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRkybiZOP7mKfAKi2+B+DqLe1ljqIHk+JctOwk56QxKBrZd0uoPxMLjghb8UK1+/nhsmvxfcdxZnbmG4Ot09mA==
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

On Fri, May 01, 2026 at 05:05:14PM -0700, Kenneth Crudup wrote:
> 
> On 5/1/26 15:30, Matthew Brost wrote:
> 
> > TTM pool shrinking frees pages by calling __free_pages() directly,
> > which bypasses updates to NR_GPU_ACTIVE and leaves GPU MM accounting
> > out of sync.
> > 
> > Introduce a helper, __free_pages_gpu_account(), and use it for all page
> > frees in ttm_pool.c so GPU MM statistics are updated consistently.
> 
> OK, so why/how does "bonnie++" increase the GPU Memory size?
> 

Well, it shouldn’t. What bonnie++ does is basically consume system
memory, triggering reclaim, which in turn will evict GPU BOs that exist
when the display is open. Thanks for pointing me to bonnie++ - this,
plus running something like the WebGL Aquarium in Chrome, is a very nice
test case for Xe/DRM shrinkers.

> ----
> SwapTotal:      33554428 kB
> MemTotal:       32345672 kB
> GPUReclaim:       621568 kB
> GPUActive:        453592 kB
> 
> SwapTotal:      33554428 kB
> MemTotal:       32345672 kB
> GPUActive:       5554976 kB
> GPUReclaim:        12716 kB
> 
> SwapTotal:      33554428 kB
> MemTotal:       32345672 kB
> GPUActive:      18407272 kB
> GPUReclaim:          884 kB
> 
> SwapTotal:      33554428 kB
> MemTotal:       32345672 kB
> GPUActive:      24022916 kB
> GPUReclaim:          716 kB
> 
> SwapTotal:      33554428 kB
> MemTotal:       32345672 kB
> GPUActive:      25258248 kB
> GPUReclaim:        16032 kB
> 
> SwapTotal:      33554428 kB
> MemTotal:       32345672 kB
> GPUActive:      28207188 kB
> GPUReclaim:         3684 kB
> ----
> 
> ... and I'm now not so sure the patch is working ... this after a 2nd bonnie
> run:

It doesn’t appear that it is. I can recreate what you’re seeing with
this patch alone on drm-tip. I originally coded this patch on top of a
local fix to avoid the TTM shrinker allocating higher-order folios when
reclaiming memory—this is working there. I falsely assumed it would work
on drm-tip as well. Let me ensure I have a standalone fix for GPUActive
accounting first, then apply my TTM shrinker fix on top.

Matt

> 
> ----
> GPUActive:      44357100 kB
> SwapTotal:      33554428 kB
> MemTotal:       32345672 kB
> GPUReclaim:        94864 kB
> 
> GPUActive:      44373904 kB
> SwapTotal:      33554428 kB
> MemTotal:       32345672 kB
> GPUReclaim:        94996 kB
> 
> GPUActive:      44354940 kB
> SwapTotal:      33554428 kB
> MemTotal:       32345672 kB
> GPUReclaim:        98048 kB
> 
> GPUActive:      44769340 kB
> SwapTotal:      33554428 kB
> MemTotal:       32345672 kB
> GPUReclaim:       122996 kB
> ----
> 
> -Kenny
> 
> -- 
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County
> CA
> 
