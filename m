Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEA0CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24E010E337;
	Mon, 15 Jun 2026 10:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VNqoc1HU";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50C610E337
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 10:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZ50hXdST1Z/MvVUVaQ0NgtpfF3dmvHiaF6EGBYurgOWd6DaF7WV5o2Jlt/u5w2k/WZ1n2Rg2U8mUmAgkoiBoEPJ5FCGniNuBRuGY6iX1tKyrvIGMbTm1r+yo+bRaagSuVNTGv1PYDUYfq6nGd08KBao13oX1BkDTfVCT8odjO3/dcnzqB82/1QC7P/yWaM6zJGh3hm14o/xMnZJp+Mos97jp+/0fKoQUcaDCc0G8IsouDBmUj5ebVfGtS/oXDda/g7aVQgXOd92FXyb7g0Jb+Yo0sSyx64rbX8TDqjrTFnQs+mZBFuqVSrrtaUIY0YDxLZIzF0p2jr/1Bucwxx0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpkU7eP0CL6UyXuuWM4tgUpoclR4cNpl5SdiiVVUKdc=;
 b=oAfPyIpo8gRQsUQi+0lX/5Q+BZMnU0OnobPNdKvTvjKWLtsB6DE5klklI/VrbGCnUFI8rJhnwVL1x5CRPnFKfA/jCEIwpYQxAZ/oIf4HLGQc6+FHheJ4ehECYtA+NzNUcKQI20H6ASBnWKvv8XcRlYnlzz0NxoXF5Q4lHLq7F1Mirc9+Pve25zwO7t4uudEpFevfo3Te0wsIMoT+1z9rj/boW7O/LLThw0gUTiMhVTDM5WHzxeDslc9mqxmHRdeSSHSlFXh+T1VwKw0Ae8GwIcFIn4wMkg5jxjxUG6mheTIoAdhQlsMdx1dLkke50F+8fbElQZ2YS82tV9hs1AFm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpkU7eP0CL6UyXuuWM4tgUpoclR4cNpl5SdiiVVUKdc=;
 b=VNqoc1HUM6d6FBb2d9Y/fDIDs6oAGrGhek/aHQDd+2lnWHaPn7hrvjRud8d/CUHR1QzGHfikhIigWdWKs/h97m2qxfzcj5udQzdANR1OwKtgwI6F1/QTjuRYHU/QTWy9Fn5N3gGj9yH3wkekCExVHCp2eXA8OAMDZUI3HRzhWLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:10:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Mon, 15 Jun 2026
 10:10:00 +0000
Message-ID: <2c59904c-9e04-4d96-94db-aa5306fe40c6@amd.com>
Date: Mon, 15 Jun 2026 12:09:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dma-buf/dma_fence: Make races for
 dma_fence_is_signaled() less likely
To: phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260612104251.2264707-2-phasta@kernel.org>
 <600885fc-7e07-4713-b5c2-a470637040c8@amd.com>
 <bf3917fb3ba6bd34611f5aff63178d80c13ebc4d.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <bf3917fb3ba6bd34611f5aff63178d80c13ebc4d.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:208:2be::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 580028f1-bd5d-484d-9d02-08decac642b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Jqw47c+Wc1bcnjqeTW4XRqSGaH/mkXlNctRtmdJJEaAPPo59lSd/BIBaX7mg6Gd0RSqp98W0nURp9Rd8YQ7AEZhCeLJ6cVbrVg+rh+Ch9fmHC4tb8axLOHqs5IlsCX060Sh2JD+a5JRiiCLvSkrDNyiQbId0RsDqllBVKnuCr32Ns3r1bqvPgdeb01p90HE+FruoG7O8WAUKQwe0IzCPUY2e0uzLlCeVJF6Se2V4NstOhJ8Df1LV3uNLE1ZDkuq4PGnurR3dznkdfJF/+As2wWa6yCvu8Gb4zL/OtAMpUKQA781ovbMKtfYS3ffkKVG+USdAiLMf7m1ok4UzfBQVkvNisp0Q6yN2fRKRFwS10RDWpmaVOI7G/vUAxudLQwsW4r+JOtdApAMAPveHajy6pbVSEv59XHuVnMvZ1LL4FQwSPrYpWIM+oGmuLksB/z9daTLFPolY6HZFqQC1j9UfGN6uPLORoYenb4SwIImRLwGPBf4Uh0rTbc+ES3eCXDhcld2uvMVWMjSJ/pX5xuxNfld4NiD7AdVhnQuoPXuCbrfqEkthP1HpX+Z31b+qBSUMQn9JmV29HOEqn33j4bO9J6OuplDXY8vWom5Y81jGaJKpMEsGBwvVyoYqTsRqo78Dbw0g/2WmQHkgAacj5kwXkjDJ4GEQvGNoPffwZjpBjl8+GAfQEWDyf16l0Hj+5C3K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm43QnVpM3llN1NVMXdHUkZFcnNrTTNFdFUxeWlXdmlEY1pKaFl3SzZQUlpX?=
 =?utf-8?B?bEZxLzgxZnhhMmp0UHIyZDJzZnZNb0JMa2N0V2NMV201em9FUHN3ZzQ0ZnhI?=
 =?utf-8?B?UHdNNm5mc3ZkdnBXb3Z3a3lmeU9ZT25mRzVJWlVKSWZNZFFJRzBXZVhaTUQz?=
 =?utf-8?B?V2loWWRJOTJ3aEVIdEZsc1BiR0VBb2s0MkIrTG95WkRLalR2d0hDU1AxWEJl?=
 =?utf-8?B?RWMzWlY0V0k2SUJhUWsvWExpcE5nVVhTQWpwTlU0QWNCTXQyMDZjQjV6WWsr?=
 =?utf-8?B?bmYzMnR3V1BpY29LR3BURFpPdUEzS1F1V0I3VVF3MWNxMmFyditWQXpzNC9Y?=
 =?utf-8?B?Mzg1RWtHRm9sVzFSSXBpVDY1NWdxcVFXZXFMQ0lJZElLM0M3ei9YbEloeG5U?=
 =?utf-8?B?SG9XNGR5Vzh2b3U1OGUyNXZPK0pNekEwVzI1bXR3NnNweS9IYklYNTNOSmJl?=
 =?utf-8?B?UmR2OFRxUXRlREVGUHlRZ0p5NEtHV1NjMXIwbUlMSUt3MkhTK3ZRS2hiVHBi?=
 =?utf-8?B?SXlpRGZPS05EWTFjbnJQRnZyN0k5WG1hOW12ejc5dEJkVllwSWdTcVRhNzlu?=
 =?utf-8?B?VGJTVVgvM09iTnVZSTlQeFRpTEIrY1dDcEd2SU4xZ2ZiT1B2Tk1ZelFldk5o?=
 =?utf-8?B?a1RpdnRHMGNWVVMzTkhiYUhreFV5c25vZnhKeDh1WkhIUVVJTWRKQjhYaHVo?=
 =?utf-8?B?OFBEUityL3ppVnRKcmQxNjQxdTh3ZEZKZEpwcnNTV29Ha2lqMVJ4cVc2Yjdk?=
 =?utf-8?B?SkVjZzJ4V3lHcmRKQktlSDMwMFcwVFVqMlZUeWlBWisweWtQSDducmd0L1JI?=
 =?utf-8?B?MXdwcEZwdjFtekF2V3lhQ205K2dKWm41YzJYUUNmeGFLeCttbHZ3SENlOXY5?=
 =?utf-8?B?R1crdnZxM3RCSGtQVHZ1NFdoUEtTeGsvTjg1U1JkTXk3V0FJSithSVRxWENR?=
 =?utf-8?B?UENhTXVRL3AvVU5xeXdtL1J5alBhTGxkM3hmSThRazJvMytYWXhiRDVvZkw0?=
 =?utf-8?B?OWU2R2dNV09sM3NySitJZ2NHM0lwSzRyMXJkMlpQS3JQWGlWa2hmSUdoOUpa?=
 =?utf-8?B?VVlvc1RzaFhJNFVkaU44Rlk1cEpOeGNlN0Nnb29UajhIbDhNOW1iZGs4QzV5?=
 =?utf-8?B?UjV4NHB3TXZrOW0rM1o5RFdpcmVMajlCMTZoS2czcUNnTEFmQ2dtM1M3WVY0?=
 =?utf-8?B?SnBvSCtWcC9NR2JZWmRCZzNkdTJjdUlsRzZTSUZxbnZXK1BHMGtvYmVzN01Q?=
 =?utf-8?B?OEk4Ykw5azZCR0VZL0tmekVDY1BNSndKWEZxYXNZcHQxc3hTZHJsTWVoMjNu?=
 =?utf-8?B?cHA2UWh4MjdIUXVRL3RwR3R4ZW5IK2NvRkdGZ21INEVickRhRUp6QlpVVkNi?=
 =?utf-8?B?SWJweEJNanlCQmR0eXdzbW15ZldRbmJjNDVpODVVWEhkR0NHSlJ5a3JRc1F5?=
 =?utf-8?B?YUFwMmZ4UlYxVmRUN2JqUjlKcisrTXIrUllteGZHeUQ3K05PN0lSdW4yZTl2?=
 =?utf-8?B?UW1tdjNQZElHdEFPTzFLUzdEQUtoR01mTDhzaE5vVngveFBhbktWZmIySnNB?=
 =?utf-8?B?Nm5uSGtHdnhUTFU3SGdZdUN1ZXZIZmdXdEZCOXQvMXAvYmxOaVFCVFVxUUNZ?=
 =?utf-8?B?RWEyRFRVdWVuaGx1NHRXUnBCOXJwUVFuSW4yOW1nbHh2K0ZMYlAxdkJHSEVV?=
 =?utf-8?B?d2VrdVV3OVd1Z1QwblRlbVBBbEl5MkNpeE1tWDhSUzhzb2Frb2UyTXZsRlps?=
 =?utf-8?B?Y2ZpYThGQWg3b00xYTZDdkMvL2dWQkFQVjBSZXNZMVk1MjRlajUvNzFPaWIx?=
 =?utf-8?B?c3M5cXFQdGNHak8xYlN3RDNYQTFKU1BVVVBZUGRTQnJKR3NjajBOLzBYVktB?=
 =?utf-8?B?SktITDkxeWc5VGM0RFBISWsweFI3NWxkTGtqaUJKNklJN2xDeXVDbVFFTGx4?=
 =?utf-8?B?VmJQQVlKWm1PdHVtY0FJdTlQQ25zcFllSWFJSmpsSGZ5S1ZhRCtsdjNLeElh?=
 =?utf-8?B?ckxpekFZSGZxSlJOdmJ2TWJuUE94TkFqRGkrRlNkRUJ0YXoxTW1FYVVhSmhO?=
 =?utf-8?B?YldrZ09BMDJOTlJCV3dEWXlCN2Q4L01zbnhhc3lzRmdKYzk4djRSWjk1aFRi?=
 =?utf-8?B?RkE1aFdCc2VJNk0zaUFtbVVxbEZXZ3JrR0VDZEJsMWU2eklOMnRIS1JGZkt0?=
 =?utf-8?B?NnpyRDBFeTM4bkE2T0tQWDlab1gwN3ZlUUxaOXZKNTRPUWZZWGtseGZpSEtR?=
 =?utf-8?B?ODhTaXJjWDhQR1NBOG9BM2ZlTTlzMXRwRStRcVA1UU9wUmI2cHhoM09IL0Fm?=
 =?utf-8?Q?4wt3Jjbne5DPBIlEH3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580028f1-bd5d-484d-9d02-08decac642b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:10:00.6127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4UzxH55xU1j9MhytHzhgy7fR0L0H0HUGumLm9totlYfuU7IxXzhTmKTXupiZuGD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
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

On 6/15/26 12:04, Philipp Stanner wrote:
> On Mon, 2026-06-15 at 11:53 +0200, Christian König wrote:
>> On 6/12/26 12:42, Philipp Stanner wrote:
>>> dma_fence_is_signaled() returns whether a fence has been signaled
>>> already. That function contains a fast path opportunistic check which is
>>> not guarded by the lock and, according to Christian, cannot be guarded
>>> by the lock without causing a massive performance regression.
>>>
>>> This now means that dma_fence_is_signaled() can return true WHILE the
>>> fence callbacks are still being executed. This is razy and has lead to
>>> at least one bug solved in:
>>>
>>> commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
>>>
>>> Make this race impossible, by simply setting the bit only once the
>>> callbacks are actually completed.
>>
>> Groundhog day, that has been suggested before and it simply doesn't work.
>>
>> The flag is intentional set before calling the callbacks because the state needs to be visible.
> 
> It will be visible. Just later.

It must be visible *before* the callbacks are called. The whole idea with the callbacks is that you can install a notification of state change.

>> Just see dma_fence_default_wait() for an example why that approach doesn't work.
> 
> What's the issue? It will be set. Just later. Who is ordering with
> whom?

See the functions dma_fence_default_wait() and dma_fence_default_wait_cb().

It wakes up the sleeping thread which in turn needs to observes the new state.

Regards,
Christian.

> I BTW suggest to write more code comments in the future to document all
> these supposed pitfalls for those who will hack on that code base once
> we have left.
> 
> 
> P.
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>>> ---
>>>  drivers/dma-buf/dma-fence.c | 18 ++++++++++++++++--
>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>>> index c7ea1e75d38a..2416cc86ce93 100644
>>> --- a/drivers/dma-buf/dma-fence.c
>>> +++ b/drivers/dma-buf/dma-fence.c
>>> @@ -359,8 +359,19 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>>>  
>>>  	dma_fence_assert_held(fence);
>>>  
>>> -	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
>>> -				      &fence->flags)))
>>> +	/*
>>> +	 * First test the bit, so we don't signal an already signaled fence again.
>>> +	 * The lock protects against multiple parties setting the bit. The bit
>>> +	 * is then set at the end of the function.
>>> +	 *
>>> +	 * The background is that there is a fast path check in
>>> +	 * dma_fence_is_signaled() which does not use lock protection and can
>>> +	 * return true *while* the fence callbacks are still executing.
>>> +	 *
>>> +	 * This fast path check supposedly cannot be guarded by the lock because
>>> +	 * of significant performance regressions.
>>> +	 */
>>> +	if (unlikely(test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
>>>  		return;
>>>  
>>>  	trace_dma_fence_signaled(fence);
>>> @@ -384,6 +395,9 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>>>  		INIT_LIST_HEAD(&cur->node);
>>>  		cur->func(fence, cur);
>>>  	}
>>> +
>>> +	// TODO: we need some barrier here, don't we?
>>> +	set_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
>>>  }
>>>  EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
>>>  

