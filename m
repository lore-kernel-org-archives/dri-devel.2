Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D88AC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F1B010F0F8;
	Wed,  9 Sep 2026 13:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dhy7V1FM";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8EAD10E1AB;
 Wed,  9 Sep 2026 13:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFch5AmN70jckfKU11SPqMhqhtcFTNpgSHCcb4PNRWDNWWbsQCpmWqW+gYiyMW73Qras7l05vmV5M+UdAkuA86XzFJeu6e/1myozQNTP9/2PjlxxK/Bgsi5qbooK74hB/8ySyTHkRCjpBjvuWXub4OQ1fze/BgVeKJaaCafMW9XK2DGCij4Xood8rack/KqPLpVSI2JOMRCBfN5kSP50SJFkai7WfzTOXU8VatQ6j2yGenDA0DIRUUiPMLFlVfWGZ8n2NKgGIAy75YbNaZPzClszK32O8nvs608eyVqWnus5qcHAY+XyYACxnh3Fto2VJk/pk7Pq1fVzMYAVxl2xnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxlDZTcF0fh3QvXh8qfUwVUfKyFaONChdOcNAJnkEeo=;
 b=IFiCOxJ5nnRalMXIEQwsjaDRFZ3tXPxV8Lgd3YwBVsOZGkMsC/bZRPiInIpM1z8j0E7iH6eTTsd9U6tci6mK6dtfx9Y+kPlZjgWROZTZqcymhGsdUfVGWKSGT2a7Wt1HqTeiypCo8Z9btFeqUnar55WX/3ZehKnfQ4dKZP/ncD4UOLVivshrexPkJ8ZxHWAFK+dPBUy7485t+l3JEu3pmqmx7omnIP0G4RZzl8i5Uddd/89m9WhJtjEy063wpG5xl1Xi8/0ORSGY2iYHCWQYbKDXysflnF1QbcvcMvdBfU8mtPbVAQnY5i1/V5+gEV9QUWXW7uGgqVDeMfI6++it/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxlDZTcF0fh3QvXh8qfUwVUfKyFaONChdOcNAJnkEeo=;
 b=dhy7V1FMTBPuXOUCue+t9c1BiUgTILAooVsDhfGyaCH/E6NqoYpsv6aJoWZQxXh/i22ZZXiPCF5zbd8MkDGqwBLLZWLWW0zKB08ujE9L1OBjtykdOmhmaIq1dnfqN6jG4GK0Qwnf+5nUtqPo8/2nSLzY3O+zAmcUsCYEH81uGoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 13:03:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 13:03:37 +0000
Message-ID: <3c7020e8-eeab-4cc2-9286-2ca613c08e07@amd.com>
Date: Wed, 9 Sep 2026 15:03:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: FUSE deadlocks vs. copy_from_user() and locks (Was: Re: [PATCH
 v10 04/27] drm/xe/eudebug: Introduce discovery for resources)
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
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
 Mika Kuoppala <mika.kuoppala@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
References: <20260903145952.848051-1-mika.kuoppala@linux.intel.com>
 <20260903145952.848051-5-mika.kuoppala@linux.intel.com>
 <20260903152224.AD48C1F00A3F@smtp.kernel.org>
 <178878748003.179185.16833574173741290547@jlahtine-mobl>
 <178894801687.37859.4186888279082797860@jlahtine-mobl>
 <aqEzHQMrI8p9XVcu@phenom.ffwll.local>
 <785085e8-c9db-4d84-ab55-3a8caf9f4a35@amd.com>
 <178895308548.62143.17472983986994555742@jlahtine-mobl>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <178895308548.62143.17472983986994555742@jlahtine-mobl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0024.namprd14.prod.outlook.com
 (2603:10b6:208:23e::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 27425ac2-010e-49ea-8d0c-08df0e72c2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|23010399003|366016|4143699003|5023799004|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FWkHueubOFu2r/0uqTlBjL2baRkeAfo7RXmJ3QVWTllzMsLiQdG2vP8PCk4DVvn+i8UcCAu+wMpQS91Qc9IdyPOpw3AhzsTRb2hVg7DtMK8SG8p8quqwxVUSuKmjN/u12BFKi7PNmBtpBKc9YGLK2HEXc4coH4xaNVA3v0NZa+U498QbxO4CVC374cyEzW+15KmWi3SJZPvvIc5PFnPGV8RGtMobNoGVjGepq8NY534zNeE0hKbCzwNNTvCDDhz31PzRqQFfdovBIwpTKkHItCUXD9iolVVSeVtM9x7PjJoAt4qV1XNrzl/7IAYnhPLrHua1g53Z5VHbOrfXrAO9D7NhhbMXr0SJxVGHAATj8y+WXnQdkpBghjFzPe8SM728Q+b5htOgmHkm8ptFLFhqHFrEJ6qBJmN5GKhdsZBUV+pmMjaISaFoeWvfefLA+uWy1CAQggtjy1Yqa5ASB9RdB0EKfOlSNKhv3Ac1Z+yL1EzBpsi1hA8TISu1oqMv2rhzqnqIkE5X591L1duIoE6xZDqAvu4YlkrBEMP6FuFCyEuUeys32p+Ufs9vKfBeLm5gbwgegoDne5rkgghRwlMPtoVoyiqh5/O0xw3SOgFy6BA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDA5aHhhNUpJeS9LZnNLUmhJL0xuK3gxVXVmTG1DTGp3Nmd5NjF6TndIRFlT?=
 =?utf-8?B?bWtxbE40ZjU4T21oaGNKTmlsWG9xTk9TY2p3dk12MldFdzVrS0FYd0s1U1J6?=
 =?utf-8?B?dU56Z0N2VHhZWGVMeURkdHEva2pZcVZhZmF4WWNNVHFZcjZrS1p6bm9OcUpI?=
 =?utf-8?B?ZDdOK24wUmxRZUVPUkVQTDMxVkI3NzZ5RkViYXcvajNzUURhUlQvSFI0bmp4?=
 =?utf-8?B?YmdXc0NhUDRBSzVBQk1uMGJybkdCbU4zcW5GK0ZLSjJZQW5vOEluakI5dWt1?=
 =?utf-8?B?SUUwZUZycEhzK0RYSFo1WGFwTDVpc01WSjM5TnZUV1dMYkdSWjI1eE5xMFFh?=
 =?utf-8?B?QTI5akdiQ0hpNVBxeFVwQkJ3MnFsQW1USnAxczErTlVKcjVKaCtUMEZJT3M3?=
 =?utf-8?B?VFJidm12UUZBREpYZk83T0k3UzF4L3BsMjNtdVZKNlBnalBqb0paMWN4dHla?=
 =?utf-8?B?RG85aDlvdEl5eG53aEY2dE5wcEQ4WDhsMTlXM2E3VWZxb3FYZFRFd09IQVBJ?=
 =?utf-8?B?OFk5RzVYRFZVc2lMcC9wTjR4b1NxZjhoYnJPYm1yZEhFdGp3ODRZcjZwMGVq?=
 =?utf-8?B?bWRNenc2SDlLdENoczNpdWUxQUF0YlAyZWhHTTlCSWVXWHlKeCt4a21hZXpi?=
 =?utf-8?B?aTZtUWF4T3NLeWludjJMYjVPem5UeTltQUUwTVpaUTlnNG1menhqRVcyMllS?=
 =?utf-8?B?UjNXUUU0eVU5clRsQWV5TjRDbTZpK2NHT3dpRGk0TXNOdzdZMnB5QjNGSWVw?=
 =?utf-8?B?VGZ5S1doUnpMMStQTzRodEdkU3VTdkNMbklFMXA3STlOdzlUUk84QnprVktj?=
 =?utf-8?B?RHpRcmdCKzY2cUZoZFkvbW12T0hpcmZ1MkI5dWxTSDIxRlRnOXp2dWJJL3gy?=
 =?utf-8?B?ZnBWUmxqM3JVaFdUR2hxK1huWlBONnpLR0pxUFpBeWY0ejRIbVNYUEl1clBO?=
 =?utf-8?B?Mk5DczBNemhXL3pFdFR0RTA4MUJ0aGhkZUJ2SEU2SEY5QTJ2d05mWWNnWVJQ?=
 =?utf-8?B?UWlPVS9xby9TYmo1STNISk9YRVVMamFKK3ZwNG02ZFFuM1Rud0VkV0F2NTAr?=
 =?utf-8?B?UTlSSzVVbWdYc2JUTFNwMHJEVzJTL3poTHpFWXNwRHU0Y0Noc0xuUkRZRzBw?=
 =?utf-8?B?NUVOUEhZOHVmM1VqYjd5aFVKK1ltaUdiVElSbExLVUM3UUlUTEFJN04vaGQx?=
 =?utf-8?B?OVhWa1lmcHNHeHUzMXZmZHJxTWZhTTV4K1lTbVpRNkgvekg3dDN2N3N0VzBn?=
 =?utf-8?B?OUVpelg5YTZRNDM0NEFSdDhVcmVWdldHUnc0RnpsRktRUm11czlGbFk1QTBj?=
 =?utf-8?B?aVJuUnZqMzZzMzhEamlGWGFTTXNWYVJCY1VuRHdoWVhZY080UllIVEgzSlJh?=
 =?utf-8?B?dWNaYTlPV0l2WjAzRGpiUnA1K3VuVHpNS0hOSkFaTGlpSlJ6U3A3d1N3SW9k?=
 =?utf-8?B?RjNFM2xhTFlSVEx6bnRRU054MHRlUUhMU0hVVzh5VWNMZlNxU0FMVU8vUlVr?=
 =?utf-8?B?ZEgyVFJKQ3M1N09mcGZWV2R5QjFpY1NGRHhna1daUHM0UEQzdzlZQmw3Mk9Z?=
 =?utf-8?B?YUdZR3VFWUprRGdjYisyTTB5bnZZd3NQdGlkVkNYZ29TbThWSUpwZ0xuUk5D?=
 =?utf-8?B?OWt4MjcvcGd5Qk4xY2I0aWs3VzFOczBSYnZ3UjU3M1ZTMS95UU8yWTQ2Z1Nn?=
 =?utf-8?B?T0NaU0s1WVhLT3pIRU91cUVOOVZKZVhWaDdheHZqWmovcDNFMUtoUHk4NGc1?=
 =?utf-8?B?UXdoY1A2RnBkUFlGUkljclB5WHF4OVJYSmsvOVdMZzE3aWIvTHYxdEFXVzdI?=
 =?utf-8?B?aFhOckNPWXRXWkZNUEZwRDNMc2tUMTdIRVVwSTh0Q1pHQkRZcm1TaSs0eGZv?=
 =?utf-8?B?UStQdThuM2pRQlB5NnFQcWhUQ01XYithT0JsNUZGUVJ1UG41VHZSd0pFT2w2?=
 =?utf-8?B?NGdLTUdsUER5cVR6dUxjY0lWd091L20xM0txcnZtcklsMVhWck5PMG1NbXZT?=
 =?utf-8?B?SUx3b2xLaTg3RHBzZHF1MkFiU205Z2Vqa3BrYVVDUDYybEQxUlJ3cmtBQ0hJ?=
 =?utf-8?B?OERvNzFLV2V5L1I0QnM0RDFuSW80ZXNFWkRlcCtybklNSXE5amxQUmJveXNo?=
 =?utf-8?B?cUtUc1h1YnB5L043dkJ5U2gwc2tHNllBeEVZbTVXWE83eUpMRnpJa1RNRU83?=
 =?utf-8?B?OE9XSEVteXdYQVNodGVMRjkwa2loNjJRM2JCdmpDbEY0ZlluSUtyN0ZBbnlh?=
 =?utf-8?B?VTUzcnMwVmV6SVV2UU0wc2cwN3Qrbnk0YUIvSUx1bjdYTTRZejVlanFUaHNj?=
 =?utf-8?Q?MSsJdgtLbufZ16aMWl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27425ac2-010e-49ea-8d0c-08df0e72c2f7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 13:03:37.1501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ah3BMLnprk+U8BNeShDiEVOQXph75Hf3/T9CcWZUdR0dIi+cNSkXN5cr+9qcyVoj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
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

On 9/9/26 13:24, Joonas Lahtinen wrote:
> (+ userfaultfd maintainers)
> 
> Quoting Christian König (2026-09-09 14:02:21)
>> On 9/9/26 12:21, Simona Vetter wrote:
>>> On Wed, Sep 09, 2026 at 01:00:16PM +0300, Joonas Lahtinen wrote:
>>>> (Adding bunch of FUSE folks and DRM folks in the hopes of coming to a
>>>> resolution here.)
>>>>
>>>> Quoting Joonas Lahtinen (2026-09-07 16:24:40)
>>>>> Quoting sashiko-bot@kernel.org (2026-09-03 18:22:23)
>>>>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>>>>> - [High] Global ordered workqueue stall via copy_from_user block while holding ioctl_lock.
>>>>>> - [Medium] Event sequence numbers (seqno) can be queued out-of-order in the event stream due to a race between seqno generation and event queuing.
>>>>>> --
>>>>>>
>>>>>> commit e2061e72d8e954a17bde35e9c970ee41bc2db0ad
>>>>>> Author: Mika Kuoppala <mika.kuoppala@linux.intel.com>
>>>>>>
>>>>>>     drm/xe/eudebug: Introduce discovery for resources
>>>>>>
>>>>>> This commit introduces a resource discovery mechanism for debugger connections.
>>>>>> When a debugger connects, all existing resources for the target client are
>>>>>> relayed as events via an ordered workqueue, and DRM ioctls are blocked using
>>>>>> an rw_semaphore until discovery is complete.
>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
>>>>>>> index 032a7ec5fbc8d..f10959b898297 100644
>>>>>>> --- a/drivers/gpu/drm/xe/xe_device.c
>>>>>>> +++ b/drivers/gpu/drm/xe/xe_device.c
>>>>>> [ ... ]
>>>>>>> @@ -238,8 +239,12 @@ static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>>>>>>  
>>>>>>>       ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
>>>>>>>       ret = ACQUIRE_ERR(xe_pm_runtime_ioctl, &pm);
>>>>>>> -     if (ret >= 0)
>>>>>>> +     if (ret >= 0) {
>>>>>>> +             bool lock = xe_eudebug_discovery_lock(file, cmd);
>>>>>>>               ret = drm_ioctl(file, cmd, arg);
>>>>>>
>>>>>> [Severity: High]
>>>>>> Does holding the discovery lock across drm_ioctl() create a vector for a
>>>>>> workqueue stall? 
>>>>>>
>>>>>> If an unprivileged user maps the ioctl argument pointer to a blocking FUSE
>>>>>> or userfaultfd region, drm_ioctl() can be stalled indefinitely during
>>>>>> copy_from_user() while holding xef->eudebug.ioctl_lock for read.
>>>>>
>>>>> Don't think this is a very realistic vector to address, as it would
>>>>> also extend to every other copy_from_user() and also to userptr across
>>>>> all drivers.
>>
>> Yeah I don't think that this is a major problem.
>>
>> Using copy_from_user() while holding a lock is usually fundamentally broken in the first place.
> 
> Well, ultimately also applies to userptr. How would we go about
> implementing that without any outer locks?
> 
> Grab locks, figure out what pages are needed, release locks, pre-fault,
> re-grab locks and do best attempt to resolve? And that's going to be a
> live-lock at best again.

Yeah and that is exactly what you *must* do for userptrs.

There is no really alternative to that because you can't grab the same lock outside a page fault you do inside an MMU notfier.

So all drivers who use userptrs basically implement the following sequence:

1. Take a copy of page table update sequence number.
2. Walk page tables, extract PFNs.
3. Prepare your DMA operations.
4. Grab the MMU notifier lock.
5. Compare your sequence number, if it doesn't match revert everything and try again.
6. Submit your DMA operation to the HW
7. Drop the MMU notifier lock.

What you describe above for eudebug sounds a lot like it won't work correctly, you can't work with outside locks in the userptr handling.

> 
> That'd be a massive undertaking for each driver, I think.
> 
>> But there are other issues which are much more problematic.
>>
>>>>>
>>>>> Having a malfunctioning FUSE driver and getting a malfunctioning system
>>>>> as a result is probably somewhat expected.
>>>>
>>>> Based on further chatting on this with Sima, I was volunteered to pull
>>>> together the discussion here.
>>>>
>>>> We seem to have Sashiko picking up on patterns about accessing userspace
>>>> memory with locks held and potential for copy_from_user() (or userptr) to
>>>> then take indefinitely long to resolve. And that spreads to deadlocks
>>>> everywhere situation very fast.
>>>>
>>>> Based on reading of [1] and [2], it seems pretty much expected FUSE
>>>> drivers can trivially deadlock and ultimately in worst case the situation
>>>> can only be solved by manually aborting those connections by sysadmin.
>>
>> The real problem comes with userfaultfd and the combination with HMM.
>>
>> Drivers implementing HMM usually use a background workers to resolve recoverable page faults using the function hmm_range_fault().
>>
>> If userfaultfd together with hmm_range_fault() can block those background workers indefinitely it can block other applications from using the HW without any sysadmin having any chance to figure out what is going on.
>>
>> That is a classic local deny of service attack and I fear hmm_range_fault() needs something like a timeout to handle that.
> 
> From my position, if userspace is injected to the dependency path for
> resolving page-faults, with potentially unbounded execution times, the
> timeouts would better be asserted at the FUSE/UFFD side and then simply
> failing the operations with a bang if not met.

That won't work like that. Both FUSE and UFFD can take any time they want for an operation.

>>>> It also seems (from the Sashiko comments) that by design, there's no
>>>> upper bound for how long an operation can take, so a bad FUSE driver
>>>> may stall for however long it sees fit to serve page-fault or in the
>>>> case of [3] it may decide to not actually populate the PTEs (or maybe
>>>> invalidate them immediately).
>>>>
>>>> Should we really be refactoring the whole kernel for the sake of
>>>> knowingly allowing potentially malicious userspace driver to idefinitely
>>>> stall or incorrectly resolve page faults? That'll be quite a lot of
>>>> complexity added to all the other drivers.
>>
>> +1
>>
>> Regards,
>> Christian.
> 
> I was also meaning to convey that I don't think indefinitely blocking
> copy_from_user() is acceptable, either. However earlier you seemed to
> indicate towards that being something we should expect?

Correct, that copy_from_user() can take any amount of time is perfectly expected.

The problem is that most GPU HW currently can't deal with that because it can't take the work of the HW in case of a fault.

Regards,
Christian.

> 
> Regards, Joonas
> 
>>>>
>>>> Or should there be more protections on FUSE / uffd to ensure such
>>>> idefinitive stall can't happen? Or maybe this is just an academic
>>>> problem and we amend review-prompts not to bring it up?
>>>>
>>>> Or maybe I missed some part of the FUSE docs and this isn't a real
>>>> problem?
>>>
>>> Thanks for typing this up, matches what I think is going on here.
>>>
>>>> Regards, Joonas
>>>>
>>>> PS. There is a related patch in [3] which tries to address the problem,
>>>> but we'll quickly run into live-locks and other issues even if we
>>>> refactored things into: pre-fault, take locks, do _nofault() access, and
>>>> retry if that fails.
>>>
>>> Yeah just quickly wanting to add here that in my opinion, trying to sort
>>> this out in all the various subsystem is not how we should even start to
>>> think about this issue. This would be a fundamental change in how
>>> subsystems are allowed to nest locking with stuff that can trigger
>>> userspace faults.
>>>
>>> I did ponder a bit how this could be solved on the fuse side of things,
>>> maybe with some seccomp style filters. Like maybe lockdep could be
>>> enlisted to help catch deadlocks, with a special "this is a fuse process,
>>> it all defacto runs in fault handler context. But that only catches bugs
>>> in normal use, not malicious exploits. And given that userspace can choose
>>> the timing and unblock at will (I think so at least), this is pretty
>>> powerful tool for being nasty to the kernel.
>>>
>>> But mostly I want to really, really stand back in awe about this issue and
>>> not think too hard about it.
>>>
>>> Cheers, Sima
>>>
>>>> [1] https://www.kernel.org/doc/html/next/filesystems/fuse.html#kernel-userspace-interface
>>>> [2] https://www.kernel.org/doc/html/next/filesystems/fuse.html#aborting-a-filesystem-connection
>>>> [3] https://sashiko.dev/#/patchset/20260827062142.4038272-1-srinivasan.shanmugam%40amd.com
>>>
>>

