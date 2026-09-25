Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F13C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 08:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B8010E1E8;
	Fri, 25 Sep 2026 08:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WWIE8+sH";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F0D10E1E8
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRbZOf6+Oj3GtvrFJbh/RLctwoc0/3Bz2gY685hHZTR/JCN5EdCa6hqlIS4KvinXiJAZErLyZFl7OZ+zBoUFOI13yQuMWxANn676KJeUpH7QS0gPu3l3vsk8yiWQQ5Dw1+YOUFj0Sg3oRJy8QARIHIeLouheUzdAx2hu3BKyFJ8d2w3VSFACvVjl0dM+F9Lc4sCnXAbadzGuHU68mYrlTpmr+75fsps1hwtPUopD8Ii/nOQj2WKtGiC7GW2hb6uXcekOOK4nCYCpGDp+vaqFqmPi7D6BnAxkAWRlLPwXI+E0XL+Fe2OUVz2kLsm6uXadm10VMs/7ScDEjm3k2Mci7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z5oahYwuBr8ie5hSjIEV0OPpwUjG2xbUsQxSxOUv64=;
 b=LnP9TyaBQTvURLGbfNu9qdwb6oK+L64VVJnIxz16EIgzu5dEvCH7sryub7AJwzADupb9p7AxitiINFfHUpiyFE3VvPQUI2kKXCF8dfKgXuf/0CiV5paz9TLrhSgCoQEikDPTKfCkOAkRiPO18n9xwuGZIVPdzP1sJhsFv91imAE2o5IpndN2KuAnCB+A8fHwzVdhJOrRGEhD3Cj1khB3VncRVwHoVLxLnN3Es1JtdOnva5JZuqJ6w3LaeV3/6J0/O3yPtLiOz2qDTzyBc4rAsHKF99JzZc+Sm4Emgb8kfFcwxQ12+tcGjIrD4mMwprlhGBiDC/XVpJuCH1sA+hYcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+z5oahYwuBr8ie5hSjIEV0OPpwUjG2xbUsQxSxOUv64=;
 b=WWIE8+sHHX1+nbDtTBp1FjGCPhsU7Q2aigqFVgnfALZdxY/Yu4EVIwjMGj0zUfubf3ZQymvtbh/YPw3z87Y/ew9ZLfoPrIymqjHk/obxstkTTxXPfY02RDkLCQVyX2xo+fNQpKk6zOkS0hddqVYUV5+HnwVXFT+ng+FZlVY4y4Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV0PR12MB135619.namprd12.prod.outlook.com (2603:10b6:408:3e0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 08:21:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 08:21:37 +0000
Message-ID: <c7d9c659-d903-456f-87f2-d75aafb8de3b@amd.com>
Date: Fri, 25 Sep 2026 10:21:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/dma-fence: Mark two callbacks as deprecated
To: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260923150308.1294592-2-phasta@kernel.org>
 <3983b2de-b6ee-4674-be22-9ecb2525a055@amd.com>
 <469d5deb2ef644b5d77d21bc2d700443f00c0b4d.camel@mailbox.org>
 <c400f12a-04db-45eb-853b-629f19e3060e@amd.com>
 <a4655e4ab7a2477b75351a0e83b98e0cb0396fdb.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a4655e4ab7a2477b75351a0e83b98e0cb0396fdb.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV0PR12MB135619:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ee2692-db8e-47d5-19ae-08df1ade0461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: xqIrCoMidPwR/w8F2OK2K8JA8owyHmovFyLmzdjFOEBPYn7y230HVxzH7IwY5jhS23k+jvT6sgj7TBW4NFi/USPnl8ga3/EmgO7do660NFeJMKEegGz4h8zy0A0PeUT5OUEPh9CUMCqC7g9ZKlSR3IsTxVYCGwkSLLwH0zLhNk2x+UxNq5Xmsvq1VxrN+dKZnFPgiO2x7mPQ2Nz1qhuXGRZ+zprzohK7X7hf1AdPL82bGNI9CPJdj3lBrRLR16AyGk/fc43D4ahTmRC1ZTJ63avjCJI6JXsv+D+8WObnqdPvA/uJVRCiCASxuF0xPk+WBwHb4uN4oQ2A5z0ko9zr5rgnL+YPUUDQNYxxwoqK+uxL/CibtXrRiaZlVgXBDDSgXHp4BTCDTA7r3ZLZcGDZ8AgHPFABgjihLICTDZ9BdqoVSz821bSlq57EdEM1DdNdSFNl9KtSPqHEw6Elidkx777RofYRQwiFvBJv9cLaoKw0KYsDCF15+jR3EFbY8fKyKz2/zjOAy+zJovzVCO8qSQI+sPUBJpOXEzSVJI1biVv29DmQc+/nNknk5nC/CioA4cyoOcl5ESDZ+uaW0X9jYbKoGLqeB+SlNfqxMl+ozVmuVNT9FgitRTX8iSpYt7f5c7JX/OANtPg4uK9sY/TOY/nWoc8KsM6dYDuffmiNbq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekt0Z1ovaytERUdBMmJ5bFprbFFzblBmQUlodk1EcFFUSzhQVHVyZjhnTUg3?=
 =?utf-8?B?dXR6c1JJeC9PMHRuMk14YWFJeERVM1lsa2trSC9laDFzL1lSSFhwL1pBNm43?=
 =?utf-8?B?bzhBK1VVdWoxOTExdUJVM1lENWdMNkMrMmpSYmVuRm1URjlQNko1V08vd1NR?=
 =?utf-8?B?L2tjbzc2Skh3b2tkTDBkR0E3TnNtbEIxSUlVK0daUEZPSFRxYzF2aGlTSTgx?=
 =?utf-8?B?cCt3L3U2NkdXa2tONDBSZmIraUQ5R1Z5cTZXQWJMZjJidENoY0xteXg3cWxi?=
 =?utf-8?B?NkJrMXp0T3lnT2FpMDVzV0RrTGxBc0Ruc1dPU2tBbFZrVG5WQUVqVHo3VDJU?=
 =?utf-8?B?RFhJVW9aWjBib2MwVDR0REg5Vjhxa2ZEYVdZMEtwbm5weVAzemR0Rm1IOHJ3?=
 =?utf-8?B?SVBNaEFrRnNMbm1YMHVSWnQwRnhuUGNDVXJkMUVONWljWExEUTZkbGtOZTRx?=
 =?utf-8?B?Y25yS01sNlVYM2dwVzNmREdvbS9XOFhtcmhZMzE5b2hDN1dGWlhWUXFoZ1cw?=
 =?utf-8?B?RW9iRVVsT2NBRnVkUW9kYWN1U2hpLy9qWEVHeFA0cnUrMno5aGkxelRHVk9B?=
 =?utf-8?B?K3VHMEo3MUUrOE0yMG1SL1VVM2IvcTdWM1JuWHA0NytURXgvRnJHdVFUY1I5?=
 =?utf-8?B?UEJOTjk0eVRjakVJbjNiOFZIa0Fxam0rZ09lOTJyKzRQcVFpdkczYjgrWk5G?=
 =?utf-8?B?Y1dXbyt2R1UyemRYN0tZQndMSnpMVUF2bDIxTEoxUVhsU3QwZUlyRURBeEJw?=
 =?utf-8?B?c1ArVjB3bzNBbmVmY2VjSllWK2s4cjhFb09lbjI1dG1USWtLZUhQNHl1cmJW?=
 =?utf-8?B?T1dZUVhWTXBxRE93WmxNVzROZGJ0V1pSM3hxTlErT3FpYkVzY2ZyREoreHJm?=
 =?utf-8?B?eGE3Ym9NLzhlQk5zcjFZRVVtbVFxYzVTVkRpeDJDenFlek1BdHdYZnduc3Rv?=
 =?utf-8?B?a3lNeHhIZXBLMHRreklaRGgzTmJvOUpCa1N3SHAwNVMvL2FQZmNYZUVadU8v?=
 =?utf-8?B?Y1BHclRHZWx2bXpxbUVQKzN2ck1kMUc1VjhDQzJQVlhqcXFRRWdwbUtMc0VQ?=
 =?utf-8?B?cVRnQWhTM2hCbnVxODI0Qm9MMWR4TGlMdlFvSzBONFo4dlFjSGNBeW9LNDEz?=
 =?utf-8?B?ZG9ISk1MQnBRb0JTdVpaa2F0M2N3YitqSHVpK2V6QU9CMG1DVndBY3V6WlFO?=
 =?utf-8?B?T0JUK2NsejR3dlVlOXF0N3AreWZuQndJNVB5V2RqTHROdHAwNWFRZ2RIeVZ6?=
 =?utf-8?B?STBtMVFlcWlHYmZVYjFOTnd2MEx0UXgrZ1cxcFpwcXcxQ2xpaThTZ0U5eEZp?=
 =?utf-8?B?Rk4xS2JpclI1ajlQNnZId2huWGsrS0xHVWNJSVZUQmNZYkpldEZ6TGV0Vjc0?=
 =?utf-8?B?VG8xeTUxVGFIdFdRMmhUZTRUd2p6eGZHNlRvZ1NRb0M3TGhUWW0rdjZ6b0FD?=
 =?utf-8?B?TGtJdkFyR3FER0tpcy9SMWxyeFdnMTFibDdnUXNhZ2NuN2c0RndMOWNPaW13?=
 =?utf-8?B?bXAraGpqWnkrQ1grWkoyWUR1dGtjbUFRTTVGcEdPRGRZQmc3Yk05QWJYSUlh?=
 =?utf-8?B?V25oWjBJQmdBdGhpSFZiNlZuZXZwYStHNnNnT3RkNHpjcksvRHJ0ZnMwNW1r?=
 =?utf-8?B?bExHWHIxYTRGNjErTVROa2xtUDdsS21LbW1JNVNMVUpGNWM1RVVuK0lXQUtS?=
 =?utf-8?B?TVlWNmhzWU4wZDFUem1jVHJ6eXBJSFdxS3Z5Nnk1YlNOY3gxQXVpZ3V4ZVps?=
 =?utf-8?B?VHJNVnUwNzBtQzYraGpXSU40OTRFNDY1UDJWUURkTUlLVHZZMUUySHFxbG9B?=
 =?utf-8?B?cTVKKys1Y0hyOGZLK2xzZWhrRjExbjdZVWlIaSt0TTMrNlFrNm9CWXRNaE5M?=
 =?utf-8?B?a2xFV0dEL1RlZW94aUt1V3VQMHVlMVl0bVVGY2ZyRUo3UFY1TFI3eUwvVVVE?=
 =?utf-8?B?eUVkaSs0TnloVGN4dlIzSERLVTdOU0FwcFdDVVVpeDl5TzNDa1RFUmxNVWsz?=
 =?utf-8?B?MDlVQ2M4WEpIYnJDb294bVRWcE41aVFXSm1yaUNqQk5VeHo5U0dvVFFmbW1p?=
 =?utf-8?B?dVMrcFQ4ajEzVzFBWktSRHd5L0JxeldVZy9zem9lWGxBTjR3WDhlcmI1SFk5?=
 =?utf-8?B?LzE1bnoyYkx2RE9FNE1maFV5OTZMd0NyMlB6bGYzUHVrVnN6Nk1wUElxOVdL?=
 =?utf-8?B?Ni9XdTRGSTBPVDF0M3dKVGdDMkcrK1RDcHhqTDFlUkIybWdWZ3VZOWJEdVND?=
 =?utf-8?B?Vk1NQktuTi9qekVrbVRTWTZZMGtYMHBuTXd5V3QxZjBucGhwSjgwMlQ2OUwx?=
 =?utf-8?Q?11ZIYB1mE547X1xr0y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ee2692-db8e-47d5-19ae-08df1ade0461
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 08:21:37.0227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1t6oHbJDjXT6RSvUALxtcUbAL97GTFFCxDU/5J7EFdyTg0WWK6nxUMeMX+0rsAHA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB135619
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

On 9/24/26 10:14, Philipp Stanner wrote:
> On Wed, 2026-09-23 at 17:35 +0200, Christian König wrote:
>> On 9/23/26 17:27, Philipp Stanner wrote:
>>> On Wed, 2026-09-23 at 17:13 +0200, Christian König wrote:
>>>> On 9/23/26 17:03, Philipp Stanner wrote:
>>>>>
>>>
>>> […]
>>>
>>>>
>>>>> 	Consumers of a fence can instead notify themselves by
>>>>> +	 * registering a callback on the fence.
>>>>
>>>> Mhm, the wait callback is transparent to consumers it's just that
>>>> implementations used it for quite a number of different hacks.
>>>
>>> Right…
>>>
>>> but doesn't the question then become why dma_fence_wait_timeout() even
>>> exists? IOW, shall we deprecate it, too?
>>
>> Yes, without the wait callback it is only a wrapper to block the
>> current thread for a dma_fence to signal using a callback.
> 
> I agree that it's probably quite a common use-case. I'm not sure
> whether it's possible to write a convenient wrapper, though, since you
> need to carry a waitqueue around.
> 
> Maybe we can put a task for it onto the DRM TODO list?

Maybe, but I'm not even sure if that is even possible/doable/make sense now.

A dma_fence is indeed very similar to a waitqueue, but with different locking semantics (at least at the moment) and different callbacks etc...

All of that is changeable, e.g. no uAPI dependencies, but also rather tricky to do because a lot of different components are involved.

On the other hand that code now works, it is just quite awkward to re-implement more or less the same functionality as a workqueue.
>>
>> It's still quite useful to have a common function for that I think.
>>
>>> It seems to be a reimplementation of waitqueues. The driver could get
>>> this functionality by using a waitqueue whose event gets triggered by a
>>> fence callback.
>>>
>>> dma_fence_default_wait() interacts directly with the task state with
>>> __XX_task() functions which looks very.. deep to me :)
>>
>> That is *exactly* what I pointed out as well >10 years ago before that stuff was merged upstream :)
>>
>> A wait_event based implementation would be tons of cleaner if you ask me.
> 
> So you objected and it was merged anyways? With any rationale?

Well not quite, I didn't explicitly NAKed it.

I just pointed out the different problems I saw, but at that time nobody (including me) expected that I was Nostradamus foretelling the future and putting the finger on exactly what we have forgotten to take into account.

A good bunch of the issues have been fixed over the years. Especially the dma_fence today is way more resilient to coding errors it was in the beginning, we basically had random memory corruptions all over the place because of avoidable driver bugs.

Some problems like the locking design are still WIP, but we are slowly moving towards that.

But some problems like parts of the dma_fence uAPI are unfixable without time travel.

> I think I understand now why sometimes people apply a Nacked-by, so
> that it's documented that people objected against merging.

Well I rather learned that I should take all concerns into account and explicitly say NAK when I see something fundamentally problematic which can't be fixed later on.

Regards,
Christian.

> 
> […]
> 
>>>
>>>
>>> Well, what I'm trying to say in this docu is that the driver can kick
>>> off custom operations that shall be performed once everyone is "done"
>>> with the fence after signaling it. Any driver data that might still be
>>> around cannot be accessed by fence consumers after signaling anymore.
>>> So the driver could trigger cleanup work after a graceperiod, as long
>>> as it does not involve kfree()-ing the fence itself.
>>
>> That sounds sane to me, but I'm not sure how to phrase it cleaner either.
>>
>> For now I'm ok with it, maybe somebody else has a better idea to how write this.
> 
> I try to come up with something slightly better.
> 
> 
> P.

