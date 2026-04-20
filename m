Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD2EF557EA
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 08:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560DC10ED4D;
	Mon, 20 Apr 2026 08:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t4FdsTlW";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A757510ED34
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 08:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jh46c+snIxoX4nH777OfacfINYs2xznCoEmG0piKlnrcFvUC/GIjEdAMvBiZ0I3IfqbA2rdmCozR+gDtG7nwtU7xoMN4tvC6UQViNa2l8HsuTh58S4RRXpZ6PgtL2s5+h322+9y967+9lfGyquJg7i/gHcJrHZbaZMSVkur6ipsWwOZ08ltPP6apEGXwHY2EYrZ6nwwZsJCuI5DLggjUTqskh+huBgjvjDD53sB9dOazGE4s3fyFWLGNbrlSBeeUUC38WXp0sHrZCSXLSe4l27OFeKklmiO9PJkpUPYoGPh28GShXP14UG20TEBKGaJvptfqbilbGprlP5lrYC5M9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsDrcaNrUkCXNMufmLhSGq4a1iTV4V5vsYmPV2fsJR8=;
 b=oGLQD/7sBNo4UBN0tTrM1QHAcUetvekOTmbcKStsATy9XwmXA0sXCgD5ayE4Apom4xFOImwIXLeUR8bzDqFyMcjvLJnKVLBOvyaBCbMaDA1kHiHsCDgODFYzre16AOWbAqMD+sSVBlpZOZcts3UZn0+QQ53btO7VGhZ1OjXWvdfvIg7uYAMV+FLmQwyXbbJ9+OGnzZTDFULF8ofCs6WDickLVmvUth+8B31NOK0UKmyiVFJAP8Fm5Na6tqi8sgwc2YF85w6Nx1l/wN9PO2ki0t0wTnUhFS9Oqeh8AkeMG9YQuSYt4n4wyn0yfH1mIQ20g5RdJbW4Rv/8Voocxqbdpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsDrcaNrUkCXNMufmLhSGq4a1iTV4V5vsYmPV2fsJR8=;
 b=t4FdsTlWK6acs+uLIEv84DvBMpmRRPGGYpIyb2q7tIm2VPWzcr/QbgLbbNEwjFfbi1DdI95N4vvc07OKXvEvZRxnOXBcxq4TekxDNjhZsm2cS0vvc81VULsvB9KKTD7KCaSbMQ+2Qa+YyINI4LGu+k2dMM0fCKOavvM9pr4o3/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CH1PPF6D0742E7B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::613) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Mon, 20 Apr
 2026 08:49:34 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 08:49:34 +0000
Message-ID: <8fe8b78b-5294-4319-af92-a4fb00527417@amd.com>
Date: Mon, 20 Apr 2026 10:49:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Pinned, non-revocable mappings of VRAM: will bad things happen?
To: Demi Marie Obenour <demiobenour@gmail.com>,
 dri-devel@lists.freedesktop.org,
 Xen developer discussion <xen-devel@lists.xenproject.org>,
 linux-media@vger.kernel.org
Cc: Val Packett <val@invisiblethingslab.com>,
 Suwit Semal <sumit.semwal@linaro.org>
References: <a06133f7-3093-4733-9786-bc46c1453e06@gmail.com>
 <b8d04414-18b5-40f7-9ea2-88b30ff5bea0@amd.com>
 <c7865b27-6bf1-4df1-9520-c9ef6b3ef368@gmail.com>
 <4751cf03-d3c1-4d5d-af8e-39ad7c8ffb84@amd.com>
 <7472bfcf-8c22-4ac7-b903-a883cdb8f1c6@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7472bfcf-8c22-4ac7-b903-a883cdb8f1c6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:208:530::14) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CH1PPF6D0742E7B:EE_
X-MS-Office365-Filtering-Correlation-Id: 98689cc9-59bd-445d-e193-08de9eb9be74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: +XAwL9tin4y75mfpeY78I1nRzW8iBdYspBxw9Pxhl8JrFjDKFS13+gUHoMi8CVYheJxcu53js2XRK0sOlhRywmo7TGlEOs7J8QGlMz26a1djMb4yhD8IF0fe6fipq7edwi0E0aYHzdJF4JYuvB0Y13kY/WREKNXX9kckXNrskc1wAlEyLthOwVwVzkH6bIeyv+H3EbCesHyovZEGiWsz2WBn0rVEzZaiqneiVEpfVKHcfxRe5vkYg+JsDriwypqkshYJysMr/M82x0KDlORYc701byk/wNYESFsEr4jFybig4UH7NunZ+4Kkvs+0TUjhRlxDt/Ek05ad1eMY+aPtdNCQa9rVf6Truq8E0PrYA2aFim4XIAHO3YVdv2M6SQ8vz0bdvb3Ulq4lUSr2J914VzDdTbLc/6tR+8PHiRx/wAxmP9F0nlzNJcgeWBdv+mm/tL/OZ4CgSbhdB2+aTCjWy5xm6YUzeYkN4i7c9ySqE1uHZgENDN/rjhLc6QUeIi4r02u5oRDyZWxpMw1PPo3zaF19kau0oKDkvB5k+c73+4dClsb628YMU2EdQ65ZTOLUgR/Fe9ZHsYrcCSor2OwabGvmkP8uLgeFyWbeVCDEok+xGydMQr2SKgADo7Ef95iH26DArplVb5cUMa+qf1uJy8m8IFwQ7AdInyj/Npj912LiktYqKNmKpUXNGlvo8p+c31GADPkU0G9t7uZs/58D9eClrZswlBi3hlR7f9ydv3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWlvSFpLUmNpZGhWb0lZSWg2ZEN5VXBITDZUa3hTRTE4WllTdzJWTFM1NVRY?=
 =?utf-8?B?cmE3UXRRNDFpdFBUbUY1QkE3QUJUWmxaSnJDaU9HaEVMYmN5MTQ5YnFTK1VL?=
 =?utf-8?B?RnNITlFFdEU2SkNsbG5FUHA3Ukd1eDVHdDJDN2NNTU5Wa3B2RWp3NE9jcVND?=
 =?utf-8?B?RElCcnpGNkZ6U3ZnZkFXR3pKaVcweERTbEFQUzRNMjN3NElUNU16YVdPbWdP?=
 =?utf-8?B?and6K1FjbmdRdGFtemk4L2dCRkl6OGxaUWl2SGdTcVBySC9nSVJCTSt6c0JD?=
 =?utf-8?B?UEpOeTRGbVFoVU1WSmxpeDVET1RGQ2FpR2xjK2g3SlFDNWJZSjZadGJ1ZWZt?=
 =?utf-8?B?M3htM3NmQk9mQWlYemtJVW1zNVpiVWVqYzVVU0VpRXVlQjZpU1NkMEgzM2Zi?=
 =?utf-8?B?YUxJK2p4NWRzUzRFMVVMMDAxamlHSmtWdXF3NmZJV3dLZmhjMGYrU0F3Yytp?=
 =?utf-8?B?REFISmMrazBIbUFHSkJ3QkV0UVd2a3IxR28wNFFmUXJHODRRV2JTMWxWNjhS?=
 =?utf-8?B?c2dTbCtMZXNqcjV0VzhzbWNKMVNSbFB1WjI5Z3orbjROTVFLTTZVNVUxMUo5?=
 =?utf-8?B?OFAyUjUzdEI5ZjBRUllDTllYWkxZSC9ud3FCRXptT0FuR0o1aWtOa1ZlbFF0?=
 =?utf-8?B?WTV4VDRheE03QkNESWRRWHBOS2pQQTN0emlxYUdxL1VHTy9EVmh6bGpKcmFW?=
 =?utf-8?B?VTNYYTFMMWo0bG1LMngvMi9GdU53UW5WVWNHSjZVUWowR2M1MU5saVRwSlBF?=
 =?utf-8?B?ekxkQU0wOXBaekNNdm1EaytZNW1qWUx1UWl3V2NRcTFEUGpyQXk5dXA0dmdE?=
 =?utf-8?B?cE5lMldNV0VQUmJ2S2h4dmZDdnA1QmdtL2h1anRUSGxnZFBKZEdvdHE0OEt0?=
 =?utf-8?B?cHBPZUorVkUyamsvcFgzWUROZXRzMVJYNE8zYWM2a3d2NzhxR0I1RGo0WUN5?=
 =?utf-8?B?Q1RNSnl1emxLOUtCcktNTktnSWRwOWxwL3ZTZjBXMkZwNkovSjM4SDRKZGdn?=
 =?utf-8?B?bm05dm1ueTAvSklKSEd5QUE4WTArdis4M1JhcXpZNXhHSTF2TVdHcjBTQzYz?=
 =?utf-8?B?ZnJDd0xDZDJMVWdkcWpEaG81ekdEbk1La0xJTDhCYStEZmVwamtLVEZyZzR3?=
 =?utf-8?B?R00rUlZPTmJNZU1UeWlsQmxUUWl3S2lYL2gveGdaZGd6cVB2WkpRUUhQT0Vw?=
 =?utf-8?B?emNvUTFUZStDa0lrUExOeDJqSEg0Ylg5YlhZWTVEMGxkUlhpUCtsNHp0azV0?=
 =?utf-8?B?SjhTekVya1JxM2JGaTNyakliUFJiZFlDbERIWXJIRkJncWQzZTZSZktrQ2c2?=
 =?utf-8?B?RFlNdFRTejlwQS9hY1QwMGxjME1IbHRoZ2RURmtlendiMER0K2V5TUhwRGto?=
 =?utf-8?B?RjJqN080czlHV2FScVp2T0Nxb2cyVXZCSU4rVHR0bmF4TldqVzgzemQvcVUv?=
 =?utf-8?B?bXlNRU8wS202YnhQRE1jSFpjNklLdFlXZVJtbElUZVJUSW1yK1NDcklJMEcw?=
 =?utf-8?B?cjFoc3A4Y0I4bGdzNVVHVU11WmQzOTVXbmNkVEtWdWFvRzBpR1QwRmsrd0Va?=
 =?utf-8?B?bitlQVJXRFBrRGVUZ0hBQU1hSU12cU01dUtaWjVVaVQzem9GK1JTRFVsb1Ri?=
 =?utf-8?B?MVoxY0Z1enFtYjlPSFRwTWJKbHlGaHJWU0RKclk3b1Z3UENRQlVLWFdzUzVN?=
 =?utf-8?B?bDlvRlFtcGdhVEFBT0N0aWVGaDVheFAvbDgvWllYekVXcGU5WHFBMXg4Vm14?=
 =?utf-8?B?YUtvbXY0UzhpWE5RNTkxSWk5TmVvckZZR2dDdi9MSUUzQ2NPUkh3RmFMNlhh?=
 =?utf-8?B?RGQyeEVPR1NFNTV1ZXhvcWFOK3hWOXdkLzZDYlZuYXVCcEtaRHlhdlVETUVJ?=
 =?utf-8?B?Ty8rNXVYNWRyNFo4aSt4WGgveWxVVEc3TFczUjdLaWF4bDZ3RHUrekpRZFFK?=
 =?utf-8?B?SnBoWTZ1aVRSTXp4Umc5VHoyTjRtZGpQd282VXM1REFsVklZTS9uRnAzRHNa?=
 =?utf-8?B?UTVURUlpaDlMR3JobkYxUjZVRkNNZXVUTmJEYURTdmhIamJ4ajBYRmRoYUd3?=
 =?utf-8?B?YXFmNjR0QjJwSGhsUnRONktHRzFVbHd3SzAyTVQ2TFNsRFhqS01uRENGSm01?=
 =?utf-8?B?S3dxOEFSckh2YjJXRXhtUnptVlVKOUY5aE1HYXprWGt1TXYzVE90enBRcGU0?=
 =?utf-8?B?U3ovYmNVRlNGaDlTUDFpK1pvWG5QVDdqT1J0OWdDVGRwVTJ1dURnZ09mREJG?=
 =?utf-8?B?MGdQTkFRalpTZW9UTDZKYUpPb1hnQ0p5UG5hblFrZHkxRlBGTU90WEhTVzY3?=
 =?utf-8?Q?37HLKVtdCnOfqq24jU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98689cc9-59bd-445d-e193-08de9eb9be74
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:49:33.8690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4AOF/wSRw0kWpgFsMG7PMglELLckluyinfWDWX3HxcHZmptE+iGzvQbn09MZPy9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6D0742E7B
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

On 4/17/26 21:35, Demi Marie Obenour wrote:
> On 4/17/26 03:53, Christian König wrote:
>> On 4/16/26 18:13, Demi Marie Obenour wrote:
>>> On 4/16/26 05:57, Christian König wrote:
...
>>> Unless I am
>>> mistaken, client workloads are highly non-uniform: a single game or
>>> compute job might well use more VRAM than every other program on the
>>> system combined.
>>
>> Yeah, perfectly correct.
>>
>>> Are these workloads impossible to make work well with pinning?
>>
>> No, as long as you don't know the workload beforehand, e.g. when you define the limit.
>>
>> I mean that's why basically everybody avoids pinning and assigning fixed amounts of resources.
>>
>> Even if you can make it work technically pinning usually results in a rather bad end user experience.
>>
>> Regards,
>> Christian.
> 
> Do drivers and programs assume that they can access VRAM from the CPU?

Yes, and that is actually really important for performance.

That's why Alex and I came up with the idea of using the resize able BAR feature to access all of VRAM on modern GPUs.

There are a couple of hacks which have been implemented over the years for exotic platforms were MMIO/VRAM access was problematic. For example on a page fault you use a GPU DMA engine to copy the VRAM buffer into system memory, make the CPU memory access and then copy it back again on demand at the next command submission.

But all of those hacks are basically just prove of concepts and result in completely unusable performance.

> Are any of the following reasonable options?
> 
> 1. Change the guest kernel to only map (and thus pin) a small subset
>    of VRAM at any given time.  If unmapped VRAM is accessed the guest
>    traps the page fault, evicts an old VRAM mapping, and creates a
>    new one.

Yeah, that could potentially work.

This is basically what we do on the host kernel driver when we can't resize the BAR for some reason. In that use case VRAM buffers are shuffled in and out of the CPU accessible window of VRAM on demand.

> 2. Pretend that resizable BAR is not enabled, so the guest doesn't
>    think it can map much of VRAM at once.  If resizable BAR is enabled
>    on the host, it might be possible to split the large BAR mapping
>    in a lot of ways.

That won't work. The userspace parts of the driver stack don't care how large the BAR to access VRAM with the CPU is.

The expectation is that the kernel driver makes thing CPU accessible as needed in the page fault handler.

It is still a good idea for your solution #1 to give the amount of "pin-able" VRAM to the userspace stack as CPU visible VRAM limit so that test cases and applications try to lower their usage of VRAM, e.g. use system memory bounce buffers when possible.

> Or does Xen really need to allow the host to handle guest page faults?
> That adds a huge amount of complexity to trusted and security-critical
> parts of the system, so it really is a last resort.  Putting the
> complexity in to the guest virtio-GPU driver is vastly preferable if
> it can be made to work well.

Well the nested page fault handling KVM offers has proven to be extremely useful. So when XEN can't do this it is clearly lacking an important feature.

But I have one question: When XEN has a problem handling faults from the guest on the host then how does that work for system memory mappings?

There is really no difference between VRAM and system memory in the handling for the GPU driver stack.

Regards,
Christian.
