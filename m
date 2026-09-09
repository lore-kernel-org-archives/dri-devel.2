Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02423C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 349CE10E169;
	Wed,  9 Sep 2026 11:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G7WM3SRE";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FCEA10E168;
 Wed,  9 Sep 2026 11:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOSJwPRoKBUW2B3hMkLX1MKdL91AvYDEkCnrowMF3sO6v4a7DpsZgZ/q4V9f85NEoLVOApCyg6yoY4d7kwNeoBFk2kMjPn36jdbl1bXstzwqgapG328OKcG7rsJd2T9mwFtv7cwDAwTuoM+Ua5ag+WjHofvsoL5Re73BTmKVF243ouBSV5DpLXmqV9XlaxxJPbgXokZqcrI2kZ2oRTvnHidjnxpjDhaR7ETwzdGVtg3Cu1elYmS32/kSQhiJBnhKxFBchqJHWB+eFbtsLGXzpMe+UV8wooQNYjO8/zrmnz+bGtxarxdDUj4LnIesUqGMY/lt50/bnVvQWmS4TULpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX04wFwdGnFT8Frfnw3aKCnaYyTSp9UpaTMXgb7CoxE=;
 b=s/dq4csDFRfZ98sfhskfcCyv5j3UDTcprW77c1XVEwF2JNc0Fe94bk77zX8oTXtihf7XTuFWytJ2eSm7CImGRdsaMPdOng/ru8W8MUHQ7KePrJrCKQ9x1mE76WJKFMnk5nhXvwlpjh+Dju1rMBKSRnRHup8gPfRCneaonhdiVrPHCP9j8QwkJ+uMn/xE6gMYQ0Ij54LUq3lGAIr4KGEIhF4NL7swWr99O5nD3kQh3szxwrWkpSUFvlSYK9f6jb1Sue/EXittHboV4exjbwGEuZJM8kursZ8P6Lp5hr0mHLRUd79TO/2hX8A0gkVjDjZHWUY+E74xpnbBJ9lHnthiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX04wFwdGnFT8Frfnw3aKCnaYyTSp9UpaTMXgb7CoxE=;
 b=G7WM3SREPlR1AIkXy9uhAV0uASkBTfX7flmjo/QeGtImNeQwc52f+UKjSwSnovLTAWQZk3D8QVcsP+kmcnfF2mq41VR1V5V5EmSy3Dg50NZvuTMAe0UQENPfc/9bDcXUT2DSBaTVVzcG8WC4H0VejR8kl7wk1gLv/66582MLugg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 11:02:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 11:02:27 +0000
Message-ID: <785085e8-c9db-4d84-ab55-3a8caf9f4a35@amd.com>
Date: Wed, 9 Sep 2026 13:02:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: FUSE deadlocks vs. copy_from_user() and locks (Was: Re: [PATCH
 v10 04/27] drm/xe/eudebug: Introduce discovery for resources)
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>,
 Joanne Koong <joannelkoong@gmail.com>, Amir Goldstein <amir73il@gmail.com>,
 intel-xe@lists.freedesktop.org, fuse-devel@lists.linux.dev,
 sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 dri-devel@lists.freedesktop.org,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
References: <20260903145952.848051-1-mika.kuoppala@linux.intel.com>
 <20260903145952.848051-5-mika.kuoppala@linux.intel.com>
 <20260903152224.AD48C1F00A3F@smtp.kernel.org>
 <178878748003.179185.16833574173741290547@jlahtine-mobl>
 <178894801687.37859.4186888279082797860@jlahtine-mobl>
 <aqEzHQMrI8p9XVcu@phenom.ffwll.local>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aqEzHQMrI8p9XVcu@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:208:530::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef4361c-eb59-4c91-4bd4-08df0e61d5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|6133799003|10067099003|5023799004|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Pun1P0zRYf99lyZd31ocECjw+qWMkxo7G+CUg5a4C5GQA4sK1qBTNhpHYtcVDncNNJNEsp9i3rs/bu0e1MgpXOe1XuatFVsxFzsmlDH1lSWb7TvalP0BCmAODJMhM09wnpO5rLW+cIMSMDkVZRs3Nz8HqLI8qtV9246P3Kc47J3O/aKLVBWaL/Pl533mxObZHf846eTCRD3jr53VyBIh7/iJDELFSE7FjlnZ6WW+cRet1+ob+f5HwM8oLw3kigGBSc0PA8kOnqWN/Z9yyZ+Zr4Y8MRzEqmkUyp2PgZIgnBGOEOlEbktzpHQMKrEtmW6F54mlzdFdWDsNb6o9538AyqT5NmQT6Dm63Bz3sTgtsyJaL79vK04kPIo6Tn0KGpB2pFhlfGsAQnurUrEREa4/BCU4In9HJ2M5AHM25M90ZFU2dp+c+bVwsHN1sBTti6tzAakklmH94/0s6Cam4zMLP7ZxJpHVwqRxuNHdLOpOYIU7kTY5dQ/DH+BxI5qpxHJMI0j2jkd6ySOPLgC6zfcGjxIB7BZ5rrNkmYPjVP2ket9v64uw3sepx9I8SvGN2m2xCXwCGHOoilVT3ljB+Aed2TQVPXSnY3eR2dtY6zWMBxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(6133799003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnFrcjBmNnpCQUF1U0FqdWhyQ1k4SDM4T1hzNmNkaDJJbS9iWVpyNGgwNm5w?=
 =?utf-8?B?RXdzTjlmckRlUGd0NjE4Z0hKY3RTZnBod3o0NGs4TWNEbHNKeHZHalJEcTM4?=
 =?utf-8?B?NXJLQURtV1ZmWFJINFlNSlZ5T2gyakJaYjRCZGxmSTV2S0F6ODdtMkswQ2x0?=
 =?utf-8?B?bmlKaHpybGtiUWlyQmZTbzNyOXdZTm9UakcrMFVwbG4zWDhxanphTkVaY0Js?=
 =?utf-8?B?czE3cUpyMzBualZkNGkzUG4vNU5WWk0wdysxRGdXZ0FPMzJqUkFLaktkNEN1?=
 =?utf-8?B?TnJOY0daUEtIL3RqQ2YvS1pITEZLVVlwUWhWYXdXQnV1d2gxMEQ4YzB3eHhU?=
 =?utf-8?B?dDI2QitWTHF1dzlvd2FRWWRQN2xlSEg2TytQVFR4dGo1cllOcVgyZzAweGZX?=
 =?utf-8?B?eFhjUFdIQ1NHamdsblVNbFZneHhQZk1CcHZQeG1ZV2Z2TWovcitjSVl4Sk52?=
 =?utf-8?B?TExEcm52dzhDTm1jZEx1YmN2dE15QWVsYlFBekYzZkt4NkQrWUhyUUtzUjVp?=
 =?utf-8?B?eENUNFBFMGdJeXBZSmRnZlFab2N1Z1d3YVora3BQcStaVVlWZnRDcFhFb0Ey?=
 =?utf-8?B?YlBQQWliNE1QRVNwNElQUGR2d0NYUVhPaHZxTFlCWlIzZjYwRHA0QUw0Q3Ux?=
 =?utf-8?B?NitNa3htcWd3alkyRUdsbW50WmF2R1ltbURiell1QnFsbGFNUUI0aGgxVGNP?=
 =?utf-8?B?bWRVTWs4ZlNsVDNsdHNjckg0cTBMUXVTZ0E5T3E3NGd2MWoxTk8vYnZFY1hX?=
 =?utf-8?B?N0VKbzR4OHp5QWZoRkErOXQ5MWtWQkRuelAxNXg3YnRWRzdTWnR3S1Z6YkdN?=
 =?utf-8?B?RTZuZWl2WTAzdzhmS1I2OXVNVEJiSklndWdPSXhvRjFpcTU5dWNDMVFYRVVB?=
 =?utf-8?B?cjVFTklBLy8vUTlvTHc3b0YzLzI2aEV5N3dsdGF4OUY5MVkyVUhVRHdxZ2FN?=
 =?utf-8?B?TDgzUXNVNFNxWWNjS09BakNpd0pjVVZvUitxWEZXNEs5bGFneTVkeHByeDlw?=
 =?utf-8?B?cU5VclN1aEZtZk5HWklrbkdXVVZUUmhqVnV2VlE5L3I0QlgzSy9uQTJWSmNy?=
 =?utf-8?B?bFJ2d1NZdk9HaTd0S3UvZDJLUUdHSWh4d3pOUnRUUHJzQUZMRUkxR2RRQ0gv?=
 =?utf-8?B?WUpZN1FoVEJmQ2FWZ2xZR0ZCaWxseUN2WnR4SytaYzdaNEUraXEvSTlURDhv?=
 =?utf-8?B?TzVyUnVYMkJwdjN5enBXdjJLT1JzbE04MEN1aVc2NDV5VFRoL0loZytybHkx?=
 =?utf-8?B?eU5lcE1JWjNLaERIV1U2aVFPaEl6QVdRRFVoeFMrQ2RPbGZjODhCQXFHMVFW?=
 =?utf-8?B?cHNZaEsxdHdDTzZkRkN2SmkxTnZ6dUlyOWpUeG1VTFdVT2NEUzNKb2NzMita?=
 =?utf-8?B?dUduTFhXS25wN21mNEE0YmpzbysvSVZBek1WanY0aDdRdVpkemFXZWJpSllv?=
 =?utf-8?B?Tm9HeTlyR0xYMFhIcGtnZ0hEbStzV2RMcnYzajlmT1l2K0psc2h3SXJRcGlO?=
 =?utf-8?B?RDdERkV5dmZqc3NLeHIxbFpKMjdNU3h3UDNqUFVwcnc1Mmlxem1KMXRTS0x3?=
 =?utf-8?B?Zm1oYXExY2tjVnBzc3IwZXdneVFYNjJHTjludjE3dVVyMDlmVHY1QkFPUzJ4?=
 =?utf-8?B?eHdzUENuWGUrR1pQUFNFaEVhbmo0TTkxYmpEb3l1bWYvVHFXeFo0Mmw5Q1lq?=
 =?utf-8?B?UWQ0a2VNZ0FrMkxtblZRRlkxTzNJUTJHaDVOeUM1cys2WFB6QWpuNkZMQVUv?=
 =?utf-8?B?K1dtSWp6YVA1RW5BT0FlY0RKeVo4SVZ5SkRSQjJLTGU3VllvbmRtZXIyQ0FJ?=
 =?utf-8?B?Qk1QVWxZVEVTMjR1RVJ0dld3Ry9DYkF4NWZRakVVWk5pQ1JMd2wwZ0RLOUZM?=
 =?utf-8?B?aUdVTUR3NVZsdzJlT0ZUd3FEdE5Icm40bTFoVHlTZXZ6SCtQdi9LcWpNbXJp?=
 =?utf-8?B?aThTVm1xcVlSR1ZkemQxdVZtYVFsVGtRbkpPNEVydXpWWldQTjdZWXpuRndC?=
 =?utf-8?B?VEk5NU1uNEdnZGNvc0VmYnZLeFI1NVhla0pwYm13NTZIOUpTZTZpM3ZmTnNF?=
 =?utf-8?B?aUtKMExpd0JNZlFRNE9YWXhMdURIeTNRSkRCMW1oWWNYS2pWRkVBajFXTmtM?=
 =?utf-8?B?MUl3NXZlRkp5TnY4SVNJZkQ3TjJ1WFozZEVOYTNNZDUzWkZtR2tINk41Y0Jk?=
 =?utf-8?B?T01Ib1NVOG5XbXU1dXA1VExtVU5jM09NSlBJRVg4RDdoa0pxQThSazlHVUkx?=
 =?utf-8?B?OTl6blRSeHdIUmczMTZOMGlZaHQvUWRxZ2tOZG8yb1k5Q0FPcUVSTGV2THlm?=
 =?utf-8?Q?4oQh5mLL4M6mEUGup6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef4361c-eb59-4c91-4bd4-08df0e61d5b5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 11:02:27.1903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //d/+yT5SDZQrOuLc/zxN5jLweK6CRTw5VB5HPlfY0DyWFWotmNpZV0YJx8VQ5Jq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
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

On 9/9/26 12:21, Simona Vetter wrote:
> On Wed, Sep 09, 2026 at 01:00:16PM +0300, Joonas Lahtinen wrote:
>> (Adding bunch of FUSE folks and DRM folks in the hopes of coming to a
>> resolution here.)
>>
>> Quoting Joonas Lahtinen (2026-09-07 16:24:40)
>>> Quoting sashiko-bot@kernel.org (2026-09-03 18:22:23)
>>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>>> - [High] Global ordered workqueue stall via copy_from_user block while holding ioctl_lock.
>>>> - [Medium] Event sequence numbers (seqno) can be queued out-of-order in the event stream due to a race between seqno generation and event queuing.
>>>> --
>>>>
>>>> commit e2061e72d8e954a17bde35e9c970ee41bc2db0ad
>>>> Author: Mika Kuoppala <mika.kuoppala@linux.intel.com>
>>>>
>>>>     drm/xe/eudebug: Introduce discovery for resources
>>>>
>>>> This commit introduces a resource discovery mechanism for debugger connections.
>>>> When a debugger connects, all existing resources for the target client are
>>>> relayed as events via an ordered workqueue, and DRM ioctls are blocked using
>>>> an rw_semaphore until discovery is complete.
>>>>
>>>>> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
>>>>> index 032a7ec5fbc8d..f10959b898297 100644
>>>>> --- a/drivers/gpu/drm/xe/xe_device.c
>>>>> +++ b/drivers/gpu/drm/xe/xe_device.c
>>>> [ ... ]
>>>>> @@ -238,8 +239,12 @@ static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>>>>  
>>>>>       ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
>>>>>       ret = ACQUIRE_ERR(xe_pm_runtime_ioctl, &pm);
>>>>> -     if (ret >= 0)
>>>>> +     if (ret >= 0) {
>>>>> +             bool lock = xe_eudebug_discovery_lock(file, cmd);
>>>>>               ret = drm_ioctl(file, cmd, arg);
>>>>
>>>> [Severity: High]
>>>> Does holding the discovery lock across drm_ioctl() create a vector for a
>>>> workqueue stall? 
>>>>
>>>> If an unprivileged user maps the ioctl argument pointer to a blocking FUSE
>>>> or userfaultfd region, drm_ioctl() can be stalled indefinitely during
>>>> copy_from_user() while holding xef->eudebug.ioctl_lock for read.
>>>
>>> Don't think this is a very realistic vector to address, as it would
>>> also extend to every other copy_from_user() and also to userptr across
>>> all drivers.

Yeah I don't think that this is a major problem.

Using copy_from_user() while holding a lock is usually fundamentally broken in the first place.

But there are other issues which are much more problematic.

>>>
>>> Having a malfunctioning FUSE driver and getting a malfunctioning system
>>> as a result is probably somewhat expected.
>>
>> Based on further chatting on this with Sima, I was volunteered to pull
>> together the discussion here.
>>
>> We seem to have Sashiko picking up on patterns about accessing userspace
>> memory with locks held and potential for copy_from_user() (or userptr) to
>> then take indefinitely long to resolve. And that spreads to deadlocks
>> everywhere situation very fast.
>>
>> Based on reading of [1] and [2], it seems pretty much expected FUSE
>> drivers can trivially deadlock and ultimately in worst case the situation
>> can only be solved by manually aborting those connections by sysadmin.

The real problem comes with userfaultfd and the combination with HMM.

Drivers implementing HMM usually use a background workers to resolve recoverable page faults using the function hmm_range_fault().

If userfaultfd together with hmm_range_fault() can block those background workers indefinitely it can block other applications from using the HW without any sysadmin having any chance to figure out what is going on.

That is a classic local deny of service attack and I fear hmm_range_fault() needs something like a timeout to handle that.
>> It also seems (from the Sashiko comments) that by design, there's no
>> upper bound for how long an operation can take, so a bad FUSE driver
>> may stall for however long it sees fit to serve page-fault or in the
>> case of [3] it may decide to not actually populate the PTEs (or maybe
>> invalidate them immediately).
>>
>> Should we really be refactoring the whole kernel for the sake of
>> knowingly allowing potentially malicious userspace driver to idefinitely
>> stall or incorrectly resolve page faults? That'll be quite a lot of
>> complexity added to all the other drivers.

+1

Regards,
Christian.

>>
>> Or should there be more protections on FUSE / uffd to ensure such
>> idefinitive stall can't happen? Or maybe this is just an academic
>> problem and we amend review-prompts not to bring it up?
>>
>> Or maybe I missed some part of the FUSE docs and this isn't a real
>> problem?
> 
> Thanks for typing this up, matches what I think is going on here.
> 
>> Regards, Joonas
>>
>> PS. There is a related patch in [3] which tries to address the problem,
>> but we'll quickly run into live-locks and other issues even if we
>> refactored things into: pre-fault, take locks, do _nofault() access, and
>> retry if that fails.
> 
> Yeah just quickly wanting to add here that in my opinion, trying to sort
> this out in all the various subsystem is not how we should even start to
> think about this issue. This would be a fundamental change in how
> subsystems are allowed to nest locking with stuff that can trigger
> userspace faults.
> 
> I did ponder a bit how this could be solved on the fuse side of things,
> maybe with some seccomp style filters. Like maybe lockdep could be
> enlisted to help catch deadlocks, with a special "this is a fuse process,
> it all defacto runs in fault handler context. But that only catches bugs
> in normal use, not malicious exploits. And given that userspace can choose
> the timing and unblock at will (I think so at least), this is pretty
> powerful tool for being nasty to the kernel.
> 
> But mostly I want to really, really stand back in awe about this issue and
> not think too hard about it.
> 
> Cheers, Sima
> 
>> [1] https://www.kernel.org/doc/html/next/filesystems/fuse.html#kernel-userspace-interface
>> [2] https://www.kernel.org/doc/html/next/filesystems/fuse.html#aborting-a-filesystem-connection
>> [3] https://sashiko.dev/#/patchset/20260827062142.4038272-1-srinivasan.shanmugam%40amd.com
> 

