Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2397C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D844C10F0C7;
	Wed,  2 Sep 2026 09:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a82mPD5U";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1B410F0C5;
 Wed,  2 Sep 2026 09:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuF2zFkzQQR6Cz/H8Siy7if0hJJB8ROefwiw+HQgfo+XCrAu7CluMNxKxxmjeVZx8zyrKD/DMbmWbKVFhl+ZEcWrtd1hCzpTPw34xXH74T03dXHXUMV0Vd8NswHtLqxOhQBCUSq/RYd/hfxPuOzJhTT/3s7rUreZOThMEpsdGkredSMBCRalYUCcpGNvO6OcbJtfwXSg9v6TPK43alqY7ImxvDQws5HrYi7uapL+CUKwtpgk9cYtIA7nZqDLD2Xy6sYmSDYLFpQPfaiFRdYx1Mi3kWDpm5S2AlOyjvS5mXlM9BNMRccOZU6cfRVe/oBPCOXGnhX9VHP4DmUBGg63qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoQ2WjreQ+q9pz7IROBRQmYQ9+bjpJUiOyQDjajw+ZM=;
 b=KuzLwGQGzDXHJghYBogiBYmhZwuZyS73RkSr78LKOxns7fuhEMBIWaEIlDKGAgi7OJugVxp9H6XwQjKuhADXbUSFl7tNo4ClYHfzqJduLq0wia0xmcy2g86XlSotdkLdruKifz3qBq3I6/xVmKxRp6ek3AwHBJMXExDc0yA/6FSKWAn7a9YWG6nqkmingc6ce/uMp1Btx7/7e9rNiJreeb+onTs0dh8PVqlM2i3NtWUCZah+rSW6e0QfdgaeJsKKPb5zmJwgMo2hAvd4RSgKhuEVB9v3Ri9ohu6HfaXVGxL1eb/Dm5gPV95jBIzsgvssfAvgdOGkZgUlW1DaWUjZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoQ2WjreQ+q9pz7IROBRQmYQ9+bjpJUiOyQDjajw+ZM=;
 b=a82mPD5U+B3AsjHKARxphwD7Q08pVaghi4t4+Ee1mz0GQIcnMYB1wE8U7bkiqtzCs4xuHIPOJjxEsJCjLklboe7yodf/ela1gwD/vTFCMZD7E4XJY9Xuf9iwCRH40cT1AWj3DvEbq8Kaxr3azxZUk1qC27HDHmoUrsiPjgbRGeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:04:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 09:04:21 +0000
Message-ID: <60f8132f-efc9-4dc1-bd02-b62391bf3fa0@amd.com>
Date: Wed, 2 Sep 2026 11:04:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt on
 non-TT resources
To: Matthew Brost <matthew.brost@intel.com>, Dave Airlie <airlied@gmail.com>, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: Nathan Bourgeois <iridescentrosesfall@gmail.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Simona Vetter <simona@ffwll.ch>
References: <aoczaCuoaZfUkfm5@gsse-cloud1.jf.intel.com>
 <CAMpTW2cxRrG4oJ0HrRoKhHrVHxWO01-L+QDoWMLCAUaSfw75sA@mail.gmail.com>
 <CAMpTW2fxFRrpn1b5WGYBrtLLMfUo_fmx9s2D0b552GJp-sF5qg@mail.gmail.com>
 <8b7001c68c94491095f41d2a3dff45090c0a95cf.camel@linux.intel.com>
 <aoeUdfrPX+0ZnZMr@gsse-cloud1.jf.intel.com>
 <CAPM=9twBded3B553KYzwDtVd0NbhbAwbiVDGw_bdrmBnOKgtKA@mail.gmail.com>
 <CAMpTW2eXS9tBzppJvvfZ-FiwoJ5MKOAdB9sqYgCDPVQ_+___ZA@mail.gmail.com>
 <ao+acQG/wyZYNYfW@gsse-cloud1.jf.intel.com>
 <apfZcEF8IlDak/As@gsse-cloud1.jf.intel.com>
 <CAPM=9tw9dtxN+tZLrb4fvPGndUT+He7Y=o39ByMEva8wWyq56g@mail.gmail.com>
 <apflRScB/NTEiEzU@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <apflRScB/NTEiEzU@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: f7bd75df-0ced-4313-4033-08df08d12d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|56012099006|6133799003|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: mLu8mW5hcSqPhH+cPqP1I5yUPi0ooLHMgQt6CHOkAqx8J22X0FuR6Ttb6pHfgCPvh49sUg/enBOc/b/7ygA/+WGXn92r8RjutY8bYh7CyR0Iq159N9Ufa1+H8uZC0oZn7h26b9ducdVdVLQ3rBXyN6rn7yFlqsIKhvSNf1+j58xXbgw8ViwB+ihcEsmPPPLXHeimL73Ulx3ApvQStknABRFb/GgSc49NuoSvTHnIRo6/aLVnQhY0iX4Z/r/TKws79G3A4XkQHtAWsN8BfSk7Rt+lLY7Q0e1Ye0P7alOEXHdq5cLR5uYXDevnbUzcjBYGSsQnD3O7cXfg8ArGOue0f8RJQivPnQPWlH7XHEj/1ZVNzTP5cutjvqZR59kzzBYztpxSYrCT8kclril03x9hvPNBuZgkqVxbAI+5URXnGBVsshHEYu7ipmdKbagYyJU8dl9yXtJ966icX2rkQIS6bleRat4U8OUlxC7K0YXVzkHDYi747tmyuf7Sbi1rrSWmtP7JV1kFUe+OlnGWDyl94AsD0IBO444tgbnSzLQ/wLRuNIR53VzUo4rP+Wu8toCZpOUxc4XgAztWdki5HDRFjaRelZtIjBHYrQXor7dMyoB0Iqr9KQ8975/WgPAvCJi83KEchJVr25KgxCVSdwGFFqhGTIMIx17tt+5kb3A5mfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNjOGpuUVRRMStvalpPNXZSMk1vOExOcVR3NmRQQzIxSWVmUlVLazdvMXpX?=
 =?utf-8?B?Rmc2cVVkNUsvVHdOK29ET1lUZFNNUDMxdDQwUzdIRWp5MDJkNGVvSTBOb0w4?=
 =?utf-8?B?VFdyZ3FNZCs4VmpkR3pRamtmamlIcStPSmFPQXdnWUkrRXJpZUxha2pRYTdQ?=
 =?utf-8?B?TWg4VGV5c1QwRjZKRXo0clpKRmFZQmZ4OXBzc2FsaXROODdMdmhySm9TUDdn?=
 =?utf-8?B?VkZaNmxSYmxLT0pXelB2VEdBbkNHTldJZytnYTZkTE1hZXZ0SG9MYU9pbStl?=
 =?utf-8?B?UHR0TXhJSzBabmRTdFZpS1VyYmc0VzlNdHNtVnFtODNRTmtwNFRjYVIwRFlr?=
 =?utf-8?B?R0xnUDJjeXpvQlcrQXZNaUttNWtpOVNvVHNqNjZSbjZpRmExM3NHRjJaclhI?=
 =?utf-8?B?NTlUY2h0a2YrazIyUnhVSHo0YXMzY3NhMkJ5SmU4UWNFeDM2U1UvS1dvMTRP?=
 =?utf-8?B?V3VkOFpyYXFINFp0em14bXJ5aHdIVlc2enZ2YjF5Vy9IZHJ2UVpzKzdnY3Bu?=
 =?utf-8?B?UXhPTGZyWkdVODhDaHlZZjZrTnIrN3FFT0lnVlNlMVRWQTZaWXFudEhFZVR2?=
 =?utf-8?B?MUpVaHMvZHRZUCtkR3Z4SVErbW9aNDRieHF1MnhZZGtNbzJpdFkzYkQ2SUpG?=
 =?utf-8?B?OG15WHloMGVNY1ZoUFlRZUM3M20zUGkxeEsyR1FPOUZEMDVIdnFuMGQzWk5m?=
 =?utf-8?B?NnB3MEJ5dlBESFBWd29qd09wWnRmVnZVR0pVTmFZSG1wWUZSNmswNjNJejRO?=
 =?utf-8?B?WVpKWEo0R2J3NDZMekRHWmZ3OTZkd0IwK2FmSWhyZGxHSW83U005YThoOUo5?=
 =?utf-8?B?UU5NS0wyUUdGNmNHV1k2MS9reno2VlEwaGxxRlgwTkdFamsxYzA2Y28vbXhU?=
 =?utf-8?B?S3NjSGNJc2tQYUVnOGZGV3FvVDFrT3R2My9rOFhJbE8yRTV2d0xWWUtMY3Rt?=
 =?utf-8?B?VSsyRk5KUU5jMXlNaEg4WXQwWXFRVnJ3Rkg1RUNNL0RXL0cyWFpoWkNSb2xN?=
 =?utf-8?B?VUoyNUZjUmZ3emQ4OWhreHFqWGthTVNzdy9aZWcyU25aSGtibHVBSXFaQThN?=
 =?utf-8?B?NFVnK3l0Vk0vNDRJUWw0LytvMVRrT09FdXM1bkJCamFCcDRYVUdmaEpCT0tu?=
 =?utf-8?B?dVFyNC9tYXZKTU5mY3grTHlrdHpBM1pKcnFvL3FYME9pQk9zMmFTTUdPOC9B?=
 =?utf-8?B?TXdxSmJHUGhFdldTSlVNZUhtREIySm1QN3QwUDIrSldOWEw3a2lhbzJhenZW?=
 =?utf-8?B?NVpCNzZkVjZXWUo1WlFrWXlsdXYrWWhTOWxSbTF3ZmV4RzVyNjNhNlZUdm45?=
 =?utf-8?B?ZjE3MHIwLzNPbkJFb0FGcE9IUlJwT29EbHV5R1V4bjBmUkNIYjNQdExwMXVQ?=
 =?utf-8?B?OFJNN2lmczEzOFJOd3IxTTFjeXNZeDZ0RXNzZUx4cjRJZ093QnJEbHdIVXVv?=
 =?utf-8?B?ZVE3c0tzZ3ZLaGlPeSt5TmhNdWJKeG9NN3kvc2w1WTFuRHJhV0RwVFZZV1p0?=
 =?utf-8?B?OU5LMnJscFFUazc2TXU2MFZoUUJCb0I1d2lOYjVKOEZSOUpjcUZOa0szbDlW?=
 =?utf-8?B?Y0U1OC9qbHVBbER4bVY5SU4rQTdwZThUSUtmK2VkUUJHYzBCNGN1TGhQQzJw?=
 =?utf-8?B?a01FV2hVWnhyNGZ2T3V3ZVh6RWRnZnc0a2tCanprS2E3ODlLVkVmaUZ1cHBF?=
 =?utf-8?B?UWk3NzRFekZCM01Rdjc3aDJ3YnJlZTBhWEhqNGNNak9TRDI5Q3VSTjkxL3Qv?=
 =?utf-8?B?ZnVIT2NSNmpCWmhjb1ZPYk90b2lLQUd5WWtzcnN0cWF6RTNnMm5nTFZPRk90?=
 =?utf-8?B?dURCRG43Y1BURmtYUkxFQ0J2STc4eEJsbmZjTGxibEJFbnFBOVJaSVhseWhn?=
 =?utf-8?B?MUx5MHlwSy9ObitOTTY2Yno4Szd4ODhXb3NLRm55SWZ4RUNnRXpoenlvS1Ro?=
 =?utf-8?B?ejJ5MnpadmJRamF1bFJ5VzRKbEd2bThLUm5GbitIRVRsZEN1QmZWcGRwZVFt?=
 =?utf-8?B?eTBISkJSZDZOMkxHVDM2NkJBVkJUS1Z3eDlMTzRYNGJUM05Sam9xOHZ4Nnpx?=
 =?utf-8?B?VGxlRHlNNmZITDlPU09NWjE0NG5KbjJFR0VzN0YrRWgwakFHVGNuRHVGNlE0?=
 =?utf-8?B?cWlZTUptWGtHZlMwUGwvY0krMmZMMUlWelRxbERrWDFOQ2RocHFYamhwWVdT?=
 =?utf-8?B?Vi9FVWtZdTVjRDRyZWpNOThIaGRjWjd3SEdoT2hVMUdIY0ZGN1dxeVY5cTlJ?=
 =?utf-8?B?a0Vjc2FDWW56aWpOTXp2LzV3S1ppck5zeDRnWDlCcWZJbDcwc0ZxbkhkVG5n?=
 =?utf-8?Q?XsF7crePUwkupTsABq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bd75df-0ced-4313-4033-08df08d12d36
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:04:21.1113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpDEhuadTq90J5fPexAoYvg78FOEsPAsob9uODHkMeOUuztn8HRMpEEIhQ9HJCuY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660
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

On 9/2/26 10:58, Matthew Brost wrote:
> On Wed, Sep 02, 2026 at 06:54:55PM +1000, Dave Airlie wrote:
>> On Wed, 2 Sept 2026 at 18:08, Matthew Brost <matthew.brost@intel.com> wrote:
>>>
>>> On Wed, Aug 26, 2026 at 07:01:21PM -0700, Matthew Brost wrote:
>>>
>>> Dave ping. Question below.
>>>
>>>> On Thu, Aug 20, 2026 at 10:34:49PM -0400, Nathan Bourgeois wrote:
>>>>>> Shouldn't we just be calling xe_bo_validate() here instead of
>>>>>> ttm_tt_populate? (With the correct xe_validation_guard() wrapping).
>>>>>
>>>>>> Yes, this might be a better solution, making ttm_bo_setup_export()
>>>>>> completely unnecessary.
>>>>>
>>>>> If ttm_bo_setup_export() is unnecessary, I'm happy to change the patch
>>>>> or make a new patch. I will attempt to implement and test this locally.
>>>>>
>>>>>> This part looks good as different patch from what I'm assuming will be a
>>>>>> TTM fix.
>>>>>
>>>>> Regarding this, what do you recommend I do, assuming the patch
>>>>> remains local to drm/xe? I'm still learning the ropes of contributing.
>>>>>
>>>>
>>>>
>>>> For Xe I believe Thomas and I aligned a xe_bo_validate with a correct
>>>> xe_validation_guard is the Xe preferred solution in the existing
>>>> design... But a question to Dave below before I commit to anything.
>>>>
>>>>> Nathan
>>>>>
>>>>> On Thu, Aug 20, 2026 at 9:08 PM Dave Airlie <airlied@gmail.com> wrote:
>>>>>>
>>>>>>> Yes, this might be a better solution, making ttm_bo_setup_export()
>>>>>>> completely unnecessary.
>>>>>>>
>>>>>>> It's also a bit odd that, in flows where we don't have backing storage
>>>>>>> on export, we populate with pages and charge the system memory cgroup,
>>>>>>> only to move the data to VRAM when the import attach is triggered,
>>>>>>> resulting in a copy and a change in cgroup charging.
>>>>>>>
>>>>>>> I guess the question is why was ttm_bo_setup_export() introduced over
>>>>>>> just a validation at export?
>>>>>>>
>>>>>>
>>>>>> I'd like to think I had an answer for that, but I don't. Likely
>>>>>> because I wasn't thinking about VRAM charging at all, and just
>>>>>> worrying about making sure we had populated some pages for system
>>>>>> memory ones, so the other side couldn't DoS us.
>>>>>>
>>>>
>>>> Dave:
>>>>
>>>> We don't charge any cgroups yet, right? This would only come into play
>>>> once a version of [1] merges, correct?
>>>>
>>>> What would prevent the pages populated for a TTM BO from being
>>>> immediately reclaimed and discarded? I'm fairly certain Xe's shrinker
>>>> could do exactly that, since we don't pin those pages. This seems to
>>>> imply that we'd need to store the cgroup associated with the TTM BO at
>>>> creation time and charge allocations to that cgroup, regardless of which
>>>> task ultimately triggers the page allocation.
>>
>> This was actually to fix a non-cgroup bug with a possible priority
>> inversion problems.
>>
>> i.e. a client could allocate a BO export it to a compositor, and then
>> the compositor would populate it for the first time and get ENOMEM.
>>
>> This was to avoid that case by making sure a client had tried to
>> allocate all the pages for the BO before exporting it, so it would get
>> the failure at that time.
>>
> 
> Ah, this makes more sense.

I was wondering why we did that as well, but yeah now I remember.

> 
>> I don't believe xe should just be reclaiming and discarding these
>> pages without swapping them to shmem first?
> 
> Yes, the pages would be in shmem if swapped.
> 
>>
>> Validating is probably fine as well.
>>
> 
> Nathan - the conclusion is validate in Xe.

I think we ran into a similar issue during some recent amdgpu work as well, so adding Felix on CC.

Basically we sometimes need empty BO objects without resource nor TT object to fill them with some resource object at a specific location.

So far we just gave them a dummy system placement for the initial validation, but that is far from ideal.

Any idea how to do that cleanly without breaking the compositor fix?

Thanks,
Christian.

> 
> Matt
> 
>> Dave.

