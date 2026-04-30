Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA61FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043ED10F288;
	Thu, 30 Apr 2026 08:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sYydr70V";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013054.outbound.protection.outlook.com
 [40.93.196.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E21E10F288;
 Thu, 30 Apr 2026 08:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPmRDIXhiqk8NPl9OrrONeGCFkwPPehotqmjDAgpjdwcxH3z8Ib+I2ugusRB5CMK9eFQY7xx8TYRaDESBe+9/USANwRQR0+Hs7YkSXPzcG8k9e19lgcy8XkY0n6CZQSk69+YqDBw0BO0aWoXjLcybCCCmHQSdYAOfArigiO+p6D+rlYWAZMAre3mdnAexj4AeaWt+GYTePIgTryuG+2rGlduJfVAI2Jrx29wQDuUbAAMntT+NOlTbJZh0i5GE+GhMS+RaKbLZdlwwsV/OxODLST/K3dRAyvR6rTksot9xupaKQq0SwQ72Pry5GQD17EwyyzEijjm7GTyB0FA7395rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp6NpY+uiokR0OIkAs8fRUUi7JjiJAe3T2cXWmesaFU=;
 b=r9BwNxjo8QHJ4zcKFjePqC+OCFb+5NypQ19FShKSV9h6pMrE0FJ+mTWVxjXocndiKL7W4l1CJvLGGgU2I7N/WXBW32paQLoXYCSVo6Rk42gFFtTotcYpcYovYNGFIbkIgllRGtpfs//DWXGmZr06o9C114nDQwC916TX3y+0isILsnHBeBZmZ5q3SzdfVX/unpfMGpZ++VdxjYuUkT+WiJN/V0gQibfJJsHG8BWe7rVrvG1gstCY+cyJleYlU6U7QReZcMiA/mFPiU0VG70toITryPCr//cqI1HIJXKO0vAFXgLo3M5ZWDHMH/WkgkKoxnCa3qXDm9pop1AVVJidSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp6NpY+uiokR0OIkAs8fRUUi7JjiJAe3T2cXWmesaFU=;
 b=sYydr70VUrREhhxKGMIGsFcxgvrhz3zSk327U7/KcgAfVTNKSp7s3+ausVd7IDAZ+bKysJR6tqA4v2P8UeShBlvY1OOXIDV2ziu6ggBCFdnXLLX47cT1fg4X8LBf5R9y0yUDa0Ka0Yf5zyvn/OrrrcAszQZn96c0I7A0qiZQZQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 08:14:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 08:14:14 +0000
Message-ID: <83bcff90-0e12-457c-9573-ed677a8cbb46@amd.com>
Date: Thu, 30 Apr 2026 10:14:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Dave Airlie <airlied@gmail.com>, Daniel Colascione <dancol@dancol.org>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Carlos Santa <carlos.santa@intel.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
 <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
 <d7dda563-280f-4126-a822-a3d43ce5048e@amd.com>
 <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
 <5bd5ed0a-fef2-4bd4-b7a0-d263bcfb1c7f@ursulin.net>
 <87se8didkt.fsf@dancol.org>
 <CAPM=9txEMjXVvxAOxx7GND5tQLO2sA7K49piXN=PBchNG11H7g@mail.gmail.com>
 <1e049fe5f571e26417d4a9b4234e163e4c0d53b0.camel@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1e049fe5f571e26417d4a9b4234e163e4c0d53b0.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:208:91::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8f8f37-0ad7-4f4b-2e88-08dea6907727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jxRdd+f9JfntrEzQAo683eqMMC07C/OpCCZJxcWX6zrZNkWxnvMpg9WVSgEAXreeAOKm0lB3zCOP529nTmcHtXrLXUi/TaSF4fSZ52rS1rb0MDM9SjdmhTAkXa+IeA8juRadudrhSTaj/L6cw1BQgAcRYVUYZ9X3oGVyqJqeNLaZip+w1Vg1aHkTWPFUn+YWzbb7JWLOLBjr3GvgDLhnKuMldTecEBAka/d6L20Be1ox3VKKyoz6KzwbZx/Z16dzdu4CVNDDQijAOAN5H9CPAq3oW67RoNQyRuFEz903YfZ9+UhCDDxOq8RKIESL3k5HRtagGOYl1Xv5eUdewfipTMnBSLx/nerItPMcWKrflm4YHbKLSTpNB/CTqKJH1hcQ4BEs8YR6KQMS84sFrNo0P3lqGTh0n7gqXKAgwuvrLNHl+mjJ/ER5UZuP2qQP6vQVUm8SW7DVF4bWab9cOAzVrtIQ0EDxaHT2YTgRZhw7Bc5Zb/Zn5W/9feYFw+FuEebCjLTVUKK0QAz7CpHzf3ii0oyx8I8sIch85gogRZCQSmwJ1ISb2XsOjdwbJyO0N3EO8S5MIMcViUBXd7M/VP7XFTzmXFuS1BLfRu8IPNoWjTTBNap530g58xY3xQbAec9BFSyCWnie5TXuJbLklrEE8daMIyE7yOJX2/ok06BsSS7cU2792epVZSt39eEEkGCRoBIK/rRvWlG7NKiXLwnlKaXeipdGXamKEnKN0/JJDy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGVuYXBISnExb1ZBYllWeDM1TUtOUUhabkxDQ1MyZFVNdjgrbHdUTDBEdjB3?=
 =?utf-8?B?UVRWRzZyYmthdXM4TlZsZFRWNmpDR21rdmk1ZStWeVE1TUdrR2R1T0tmUisv?=
 =?utf-8?B?dUtDdU0xMksrK3lhQ0FqWnFDamVRemExWlNsLzVXM2tvRWtkeXdibUwraW52?=
 =?utf-8?B?aVIyM0wzdmp0L0gwN3Zua3R3blFBQ3dRVXZuMDJ6UjB6K3ZRUWxHREdOOXh1?=
 =?utf-8?B?ZFVoaU9aL1BXaG5ycVRtZ0JUQ0JRNGxGU0plbTZaaDRQMjZOYzVpV1YxNzhj?=
 =?utf-8?B?dDNaMkpxRjZ4MXZ5alFKNmV4dlJJei9qUnc2T0NIOHR0UUgvVmx6RSttOXJ4?=
 =?utf-8?B?blR6cWtEck5iRXVjTjRXbTNBUUFlVm9XdG9VSlhpaSthSWVwbU0zSkZ1VkxN?=
 =?utf-8?B?ekJUNUcwTHNNaFA3ejJCMXFhOWFGNERtdHhJejBJcEJoZ3VmQjVoTExkNE5H?=
 =?utf-8?B?elRGN0RyYnNpaDBxcy91elVIdnF4Zmo1UkM3QWJNQ1pHM01PejhSdENnNFRo?=
 =?utf-8?B?SzFGMVlza0duR0gxcDhvQlJUU1NvWnd6OWI4ekZlaGN3aWpYVml4NXl4TzYx?=
 =?utf-8?B?Y2hFc3FuY3JRbUZUM0pSQ0dRV2ZzdkQrd1F1TXNMMjNmRjlWc05BRUx6MU1W?=
 =?utf-8?B?clZLSDRsSVVLYTZBMlBqSnVEUHZKSlVGQkVMTTYrZEwrcUQ2KzU5REI3Rm84?=
 =?utf-8?B?OWpmK3JmdzJBWXFxV0Z5enhSNDNxdHZBV3pKV0pNUHJ5b252VjVrM2dvVFhi?=
 =?utf-8?B?MWV6MjFNTy8vQysvYUVMYTRyajBQTkZ6REpiaXRGbThHY3hkVnNNajR4dkVE?=
 =?utf-8?B?SDB0WFlzSkxxbWltL2QzUFNGdWszMjQxRXZINGNDVFlmTjFwZlhKNWFINEJ2?=
 =?utf-8?B?TlJvVWFJTHU3RzB3bFhlY1pLOGRrUG1nMUNWQllLaURqeEo3K3RjZnJZTEZC?=
 =?utf-8?B?bmhyQTRwUGV6R25vcUloazk4OHFmV20rdU1iVnJWWXU0UlJEREcvRnpTUVB1?=
 =?utf-8?B?eklkWkk4MjdLSDVtYXh2aHl5bDkxUVZPZXdWWTBaTVhSV3lQc3VBdE5WVS9M?=
 =?utf-8?B?T2o3ZjhMRXRNTktFQyt3U01lcEhyeVM2OUVIemsrbW0wejEyNVNHM3RaRmlw?=
 =?utf-8?B?TE9oT2t5MW9wc0c1UDJwOGRPQnlmbTRWakJUZ0lBcC9tbW1OZlV3N2VGL2xH?=
 =?utf-8?B?bUV1bk9FakRDOUlMbjZ6MlNJM2J1bUltaVRUcHRCL3JaRDRtNjRhQ2lPb2pS?=
 =?utf-8?B?UlZrTXN6bzN0RlAxMUQxU3pJcVdERXV2L0hPWlNabnUxMlBvSlp3dVdXMUYx?=
 =?utf-8?B?cXpEemFUb1FpNEpjdVRpUXdubGIxQWVlMkwvWGMvM0lGZWIzK2lOeUJpSHcx?=
 =?utf-8?B?RERabUxXdU10OU93MmRjVW5IQ3pkNjFnNnpHaVAxWTJBYnZzL0NXNDN4YzdE?=
 =?utf-8?B?SE04ZmtJeGJ0ek5ldWZlSnkxald0YlRSakp6SEtZaU5BNGFKSFVUNm9RMjZm?=
 =?utf-8?B?b1cvQnhXOUNXQXI4QXlCR3NiSTJBWEk4S2ttMnVMZVBmQ05Jb09nYnkvd1Rj?=
 =?utf-8?B?Q1Y1YVpvZERrVHFKQVBhWm1SNCtHcm1yaDZBSE1Bbm5va29KbkdEWDkyWktT?=
 =?utf-8?B?RnpSNlFuUGxJNkpqSTFWK281dk13RDMwVmx1UzY3QkhDeERkSU5jM2JUOTBJ?=
 =?utf-8?B?U2JLaDFkU1BITHhYdXk3WFh6Wkg4cGs3aUpwaTdhdmtQZDI3bGNNSVhzN0p2?=
 =?utf-8?B?dnNYTjFmSEVRS1Joa1l5V3UxNThpbGFJaW5SM1JxaDRNTjA2cGFkNWpPUDFv?=
 =?utf-8?B?WFRvZzB2OEsyQndVVGUvRzV2RDQ2SXJNYVVCNGhLd3dGRHpKYjlidmhCOFJ0?=
 =?utf-8?B?U1BrcDhNaFpIakw4dmRJR2JsWkhTZ3Q1Uk1QNGF1NUpFcXY1MGFlV2xZRG1k?=
 =?utf-8?B?R3ZUb3pOd2FqYVdwZ0J5NmNTMUVaU0NLbEQ4c1BwT3NxOVdzbVdEaVJkNDE5?=
 =?utf-8?B?SDh0Yk9tMmJ4NU14bnd3bVBJQnRXVXIySERTMnB4eTcvYk03aDlUZUhOY3pT?=
 =?utf-8?B?SVo5TC9zbzErV2hXWDdCTkdaekJkc2tqQzFZMHMxMHp4Q202MlBnQ1pSYWFO?=
 =?utf-8?B?bmRuYWYweW1WMlpOcCtucGx1VWQ0VjJOMERGK2NQVWJKekJldk9rL2thMzQ0?=
 =?utf-8?B?L3EzRDFKWE1rMWJkclNDTzN3emd1OXVyUG5JVWR0UEx3QWhNKzNNQW9nRWZw?=
 =?utf-8?B?eUxLWDNoc1dkSlB1Q3RJZlRpMDFVT0dOUTZHQ1ZVUldjdHU1OXpFTXV6QXV1?=
 =?utf-8?Q?4fyZfXoQwZV1gSS6WD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8f8f37-0ad7-4f4b-2e88-08dea6907727
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:14:13.9483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ef4w6ZAxnQBXL00Wg6M0lq1UNgE6ly7JCrNCDStQ84lD9FINLvcF5N+qykVzyYe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
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

On 4/30/26 09:59, Thomas Hellström wrote:
> On Thu, 2026-04-30 at 10:11 +1000, Dave Airlie wrote:
>>>
>>> Probably stupid question: for systems like my Lunar Lake Xe2, which
>>> has
>>> unified memory and (IIUC) no special cache-type or write-mode
>>> constraints for GPU mappings, would it be possible to use regular
>>> system-provided pages (e.g. from shmem) instead of going through
>>> the TTM
>>> pool and allow mTHP to provide the aligned and contiguous backing
>>> storage that the GPU wants? Something like GEM has, but maybe
>>> inside the
>>> TTM API?
>>
>> TTM pool doesn't get used for system memory allocations in that case,
>> if you are asking for cached memory.
> 
> Both Lunar Lake and Panther Lake use write-combined memory for buffer
> objects in performance-critical paths. So the pools are indeed getting
> used.
> 
> And while it is possible to change caching on shmem pages if they are
> pinned/unevictable, trying to pool them quickly becomes messy.

Yeah the issue is just that this functionality is strongly x86 specific. From what I know basically every architecture came up with a distinct way of handling this.

We could move all of this behind GFP flags and into proper architecture abstraction in the core memory management.

But while the functionality was basically mandatory 30 years ago by todays standard it has only a handful of use cases left, so I'm not sure if that's really worth the effort.

On the other hand it would indeed make things *much* cleaner and interestingly at least x86 already tracks the UC/WC state in the struct page.

Christian.

> 
> /Thomas
> 
> 
>>
>> Dave.

