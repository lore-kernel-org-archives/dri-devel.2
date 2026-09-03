Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1503EC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DE110F4B8;
	Thu,  3 Sep 2026 10:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EMrYhT9+";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD9610F4B8
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 10:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UB9BFMkp2W/9UEmVUri4sF8quAdXIr09CTl2mBGohQRWc3O4ZshOACIQfIb+46FQWc8gKFa3iDs1tVO4kqn5XArBIH/p7sHYr+bIX9AM1MKIZnK2zLvAe/ngkIOsp4Spw0uUg3jdPcMMshqLnHem4XEBP38iqy67nQossN0/fzdH6cqgotDkHDuqEI0uuwOxllYJQLu6jaD1/+PeZ+0FAoyAGnTmCgNckVuDlt8TZ2LYhXFJXjO6WndVgz4cQm/iJqne5HBNhsJxGxOcbfjR1APrzexmhGKbV8LGcew+XyW+w5rpbeTPFxn/rpHO+HAzrT8V0kEDBtA1oH5Cao9KBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxRbKIERCszE23tL30VeTb73yvjzvGKffrI67zqC8wo=;
 b=jqVyP8XzlerBKS1OIaKzzrqn0i/GPLJSFWh4/5PMQ0rDKPkLNpvXSVyYqnjZpw4gpc3kaG3FETUk1VQw9AEVB8pciZ31sGvfOk6H0065G72S52j3hEO05U2RRzS3tXWh9wfejtyfGT36BJDw7kN6N39F4IYF5i5bJoyd3+jdnqVM3UC4Lq8Nd87YYc8+zgLZ76m58z12AXAjo4kNhqhMqs0oPhL0dA2xBdx7nvKv10VIaI8WVEwPN4OOzo+UUjxLgBLR4lyZWIqeiRY1YrcxNPjMlx92k+A5EopZwiVqqtociq+ja417kDsqhKCjxYNVPvp9AIX2b4QMDDi30j1M9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxRbKIERCszE23tL30VeTb73yvjzvGKffrI67zqC8wo=;
 b=EMrYhT9+HT9J3TWGhCeiFSCmwD3jjSExB/7at6/yFG3uYzwpj6cS7UJCoJp5mi4RLq2ZQv1+wwpBm/cElHNKVvWu8pJhi0TlMgudmtScOfsbdh3Z0Jsn6kWmvGZ3ImkG02+NsbVrVQb+YtLeiZ8x9nyy1s4mnjnwVq0onBwyIRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS6PR12MB764263.namprd12.prod.outlook.com (2603:10b6:8:499::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 10:02:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Thu, 3 Sep 2026
 10:02:56 +0000
Message-ID: <22633519-0eb2-4f98-b669-158b9ef8a234@amd.com>
Date: Thu, 3 Sep 2026 12:02:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/sched: fix use-after-free of the fence
 timeline name
To: phasta@kernel.org, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 tursulin@ursulin.net, matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260902144204.1843670-1-malhyuk97@gmail.com>
 <20260902144204.1843670-2-malhyuk97@gmail.com>
 <611c2624e60ea422229e666480da3e504d126682.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <611c2624e60ea422229e666480da3e504d126682.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS6PR12MB764263:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe5c930-09f0-477b-df79-08df09a286cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|5023799004|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: izg9IwWzKq6xkPILXszOiTbS2ozKHn060FbKTQDVIzjM2LSAaGlxfkHdTdsOwFgUr467j8T6GahugY201tnEkJ0EbUIW/X3l7MhbE35wmfnkZPlitYmzFmgw2QGKctOXdk+PrfepgIy/Sn11OP891kNz7BiCgsppLuPrZXKCELeOncC8pRn/Z6zQZz9MWIsVus04yc4YxspFXQkLqfL9Aaa2dJiIP4nysY9uHiB935dLeyF9DK7zr1xKDgrZgtCYdQZgUtzUU+jEO0tOANcjoLs8htjKTGeuSqm2czveX7b/pXxoh8GHQoetaokNFf7hZ+reu7NyIzz+8I52ZyouKq+dFXsg2JiZ1OhpxTHDs3xgecBtNL+LlrQrKRteagpnoU8fp0w9vF/+MNjaNe4Hu+JOuSL4LvwL9KUZletSiYBCB0LTJPQ+vfL3/4P21EeNYF5vAYqwVEBcujNVYc3yZF37C3T6NT7JirWZxL1EMPeoN4gqGPar7r+TUBTOg91DXfJFptUg1PSCdOXtlfVCBeJz/aGYvdUUXE+mvvw0AS+QZNInN8qzM9s4TVyTvYxLexgZaebp+BedUkAw8N9AdvBRpf5UV4fnUz4wDjBX2ATz9Qc6VW8Aj75vKUhcu5FUXu3jBRdRdo1RKGzhjNbyU8+w+oalBTDoIXck/Ee8vh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnQ0Y2FhRUJKMU1NVERZcmp1SmRyVFpyTnBaejJuZUg0M0x5TUFqakZtd0VD?=
 =?utf-8?B?eXhmRTZ6VkVZaEJwcXFEWWtVMkhucmtZNUZHRk0wUDM4dHpDTXRpTW5NdnQ4?=
 =?utf-8?B?b2lRa0RmczRJazdTbHhBa3lDOFJEZTY5cVMzVjhaL2locmMybTN1RTBWNThU?=
 =?utf-8?B?SEgra0t0OTdtbjVQbDV3SkIxdXpWQStJa0hLeDQvS3NnSTZBT2xwdWNoK1Js?=
 =?utf-8?B?L2F2TUtKZ0ZCMWY3aVpyb0Nsa1dnYTFpQUhYZHVYSXNUcTFOYnVzUkU3YUZO?=
 =?utf-8?B?ZlN5UFQxWXZUd2UwaUlyRlJQVGhvYXQ4VHdZVzFpU1JKRGMzSklRSTRZUGZU?=
 =?utf-8?B?aWJ5SXpUVFhFalpkSFRIbWNuWkNaMlRMbDdmRERuZm0xNzZDOTcxSEFWYzQz?=
 =?utf-8?B?U0swcmd1QWFKQk9zMi8vOU5QM0NqMzJ4dkd0WEhkREZVMzVFdEhseGZzVHhL?=
 =?utf-8?B?MzNUazJPK2p1WlNyU2xLZmxiUmxPQlRYVFJTUURkUnMvc1ByVmR0VnZJck1k?=
 =?utf-8?B?MFY4MWpML01taXpYZmZnbDFvR0ZlcWZENjFVK3E4YzYzeU41VnJ0QUtzSGwv?=
 =?utf-8?B?UlIzbm03OE1HaHNzZktST3VLa1BDRStIbWF5MVZVTU40VmVKakIvc3VLcVAz?=
 =?utf-8?B?U1JQekdMSVBDZGhsaUd0OTVvWjZDU3dSaElWK1U0Y05NczkzNmpGNG9nMm1x?=
 =?utf-8?B?VW9rMEF1cHh1Yjk1Ykh3U0FXdmt6M1VrTTdaNytnUzNjZ0Ryc0NUVHl5OE9x?=
 =?utf-8?B?NlphZGFndnZYV3k5SXJmQ0R2MU1CRmdxRlhGcUlJK0ZFVTRYeHYvVnpiQ25J?=
 =?utf-8?B?MnZnTlRNbHR2ZkRYQkNyeWRrZ3ZhRFAzcDFlSGh5RzViVno2SldpbnE3clFG?=
 =?utf-8?B?UjV0a0tnSWY4bmJSd01IZWNkMDE3NmxSMTJlbGlMSU13NHp6ZThmZVlQcVQ3?=
 =?utf-8?B?ckR3akN6Slg5eHFVVE9ROVAvRnlvR3JBMXU0ZFFmZFNINUNnK2RZUGYwTE1Z?=
 =?utf-8?B?UVU4U002bmZhRG9zVDh5ZklyQWNRa3gwWEtaZE1xWUwyL25rTmlVcXBXRURB?=
 =?utf-8?B?dkRiTWhHeVdla2tuc1NOYTRGKytJZWs3c2N0MUEzMVlhQmhTSkVwQ095dGVF?=
 =?utf-8?B?RVdsK3FSSlU4NXk4UFpqOExONVdLbjV2b2taelpCdDZGT2V3eG9RMll3Ym1j?=
 =?utf-8?B?Ri9PWjZlN3NMd2JKQWRxTGs5d0lIZStIaTNtTnE0ZjZSUmp4REt2M3h3UEVr?=
 =?utf-8?B?dWh4c3VNdDl3Y3RwRi83LzRyeGxXcFgxTENVQUNnMDltK3g2UXhCeTRrTDlR?=
 =?utf-8?B?RC9YQjVneFI2Uy8zZ0k5ekNUcGVBZG85L3FhZVppMHNibkRiY3pmRnJtamlr?=
 =?utf-8?B?L1ZEaFRkckw4eUgrd0hzZTUybGhyU0gvMXpBOStiQm9lSiticXBvREIyaDF6?=
 =?utf-8?B?VTQ0YktYcXVSMUcyampWZW4za1JxTmpzR2tzNlZ4N3pLRDVsei9xOStGVlcy?=
 =?utf-8?B?ZTIyOXIwUzI5VmxFRnpMekNKdzA0R3pqRElnK0lvL0p1SHE1Q1ZlK1Q2VDBz?=
 =?utf-8?B?NDhrcWV6QzY0MHdVcHJ1Q1BHQUdIM2pid2tjSCtjQ1Y2UjV1UjJtZk43QXMr?=
 =?utf-8?B?WkNaRE5zZTNSbVl5M0xEcllPdW1Ba0swY3VabTR6aGljaFdIN3lTUWJwNmRD?=
 =?utf-8?B?ODdmRUJ3MHkrMkxGNDJDTVZ2dGxSL1l6TmtXbDh0VTZYclRyUUhZSm5neXhE?=
 =?utf-8?B?c2E4NDd2OUNrcFBrZG1QdTZiRDl0N1NrUHRlQ083SmRKdVVGdys0dnpJeUI2?=
 =?utf-8?B?NUlYYXdXQ2lPRXJ3VVRhWkFSQjVFTENvck44K3llMk1YZTNUVmR6OWZHcFNk?=
 =?utf-8?B?K1FJcVJ2N1Q3K2tJQU5YWCtFenY0ZW9GYkR4T2M4VnJNaVlNQmFCV2NvcHlz?=
 =?utf-8?B?TlhZaVNvMXE3aVByMGdVUXpDREdzR2NPVldKdk83SnRoZWVPSjRlcE9BU1A4?=
 =?utf-8?B?a1lsNHpYYnpPZUgxZjdibGtzMTNpMFpMQnFDMHczZ2hxOE9qRDhJR1V3ZWhJ?=
 =?utf-8?B?ZjM0cU5rd3ZicXRZdHQ5SnAwOFFDR0RkNVFVaW0wYzNUbWRSV1o4YzlWOFFW?=
 =?utf-8?B?Yy9DYndLK0wxejZnY3c1UHRtcHJJYWxHSXFqTnIwOHJMaEpaQ3VxcHVIZVRu?=
 =?utf-8?B?VW0wZGp2Qy91Lzl0REhHMmIvREVqTDM0SkNsZWR2MkRBRHEyU2FDL3M1NnNq?=
 =?utf-8?B?TUZsbmJnQzNUVy9Ldm5EOW9GNFVhb0duUndJZjVsWVl6SkE4RWErODlEYVBP?=
 =?utf-8?Q?30vIyQaHCF5V3Ij2V2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe5c930-09f0-477b-df79-08df09a286cf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:02:56.2513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQK9lkp63wXAXSjC3azrhMuRa0CzuVh6OiweDv0X5T9LNKA/OTtqrCyRWJSL8jTL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB764263
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

On 9/3/26 10:46, Philipp Stanner wrote:
> On Wed, 2026-09-02 at 23:42 +0900, Jonghyuk Kim(MalHyuk) wrote:
>>
> 
> […]
> 
>>
>> The finished fence carried a .release callback solely to drop the
>> scheduled fence's reference. That callback kept the ops attached, leaving
>> get_timeline_name() reachable on a signalled finished fence with a
>> dangling ->sched. Drop the callback and move the reference handling
>> instead:
>>
>>  - The scheduled fence now holds a reference on the finished fence, so
>>    the finished fence, and with it the shared allocation, is released
>>    last. Its release drops the parent fence and that finished-fence
>>    reference; the finished fence is then freed from dma_fence_free().
> 
> The backend doesn't know about this (admittedly weird) shared-
> allocation phenomenon. I suppose the reason why we don't run into
> double-free is that the scheduled-fence does still implement ops-
>> release.
> 
> If that's the case, that needs to be documented in the code as a
> groundlayer for future cleanups (I suppose we should eliminate that
> shared allocation. If objects have distinct lifetimes, they should have
> distinct memory. It was probably done like that so that drivers can
> access both subfences through container_of()).
> 
> a la

Yes, the reason why that construct is necessary is because to_drm_sched_fence() needs to be able to cast from both scheduled fence and finished fence back to the parent object.

IIRC that was used by both the scheduler itself as well as and drivers, but I'm not sure if that is still the case. At least in amdgpu I tried to avoid casting from scheduled -> finished and only do from finished -> scheduled.

> 
> "TODO: this release callback should be removed, too, but can't because
> double-free"

Yes, I pointed that out before as well.

But those release callbacks are actually unproblematic for the problem at hand as far as I can see.

Regards,
Christian.

> 
>> scheduler. Unlike caching the name string, this also covers drivers whose
>> timeline name is dynamically allocated (drm/panthor, drm/xe).
> 
> It's good to have detailed commit messages, but I don't think hinting
> at that alternative solution (caching), which we don't implement, is
> necessary.
> 
>>
> 
> […]
> 
>> - it is the normal result for a foreign fence - and a signalled fence is
>> an already-satisfied dependency, so the scheduler's dependency-collapsing
>> optimisation is unaffected.
>>
> 
> I don't understand this phrase. You're saying that someone trying to
> register a dependency won't bother if he sees NULL?
> 
> 
>>
>>
> 
> […]
> 
>>  
>> -static void drm_sched_fence_free_rcu(struct rcu_head *rcu)
>> -{
>> -	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
>> -	struct drm_sched_fence *fence = to_drm_sched_fence(f);
>> -
>> -	if (!WARN_ON_ONCE(!fence))
>> -		kmem_cache_free(sched_fence_slab, fence);
>> -}
>> -
>>  /**
>>   * drm_sched_fence_free - free up an uninitialized fence
>>   *
>> @@ -132,21 +123,12 @@ static void drm_sched_fence_release_scheduled(struct dma_fence *f)
>>  	struct drm_sched_fence *fence = to_drm_sched_fence(f);
>>  
>>  	dma_fence_put(fence->parent);
>> -	call_rcu(&fence->finished.rcu, drm_sched_fence_free_rcu);
> 
> @Christian, Tvrtko, opinions on that?
> 
>> -}
>> -
>> -/**
>> - * drm_sched_fence_release_finished - drop extra reference
>> - *
>> - * @f: fence
>> - *
>> - * Drop the extra reference from the scheduled fence to the base fence.
>> - */
>> -static void drm_sched_fence_release_finished(struct dma_fence *f)
>> -{
>> -	struct drm_sched_fence *fence = to_drm_sched_fence(f);
>> -
>> -	dma_fence_put(&fence->scheduled);
>> +	/*
>> +	 * Drop the reference the scheduled fence holds on the finished fence.
>> +	 * The finished fence is released last and frees the shared allocation
>> +	 * from its dma_fence_free() (see drm_sched_fence_init()).
>> +	 */
>> +	dma_fence_put(&fence->finished);
>>  }
>>  
>>  static void drm_sched_fence_set_deadline_finished(struct dma_fence *f,
>> @@ -189,7 +171,13 @@ static const struct dma_fence_ops drm_sched_fence_ops_scheduled = {
>>  static const struct dma_fence_ops drm_sched_fence_ops_finished = {
>>  	.get_driver_name = drm_sched_fence_get_driver_name,
>>  	.get_timeline_name = drm_sched_fence_get_timeline_name,
>> -	.release = drm_sched_fence_release_finished,
>> +	/*
>> +	 * No .release callback: dma_fence detaches ->ops on signalling for
>> +	 * fences without .release/.wait, so get_timeline_name() is never called
>> +	 * on a signalled finished fence and cannot dereference a freed
>> +	 * scheduler. The shared allocation is freed from dma_fence_free() once
>> +	 * this fence's refcount drops - it is released last, after @scheduled.
>> +	 */
> 
> That comment is not necessary. The new code simply complies with the
> current idiomatic fence design. Comments are necessary at tricky bits
> or when one deviates from idiomatic usage.
> 
>>  	.set_deadline = drm_sched_fence_set_deadline_finished,
>>  };
>>  
>> @@ -233,6 +221,14 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
>>  		       &fence->lock, entity->fence_context, seq);
>>  	dma_fence_init(&fence->finished, &drm_sched_fence_ops_finished,
>>  		       &fence->lock, entity->fence_context + 1, seq);
>> +
>> +	/*
>> +	 * Hold a reference on the finished fence from the scheduled fence, so
>> +	 * the finished fence (and the shared allocation) outlives @scheduled.
>> +	 * drm_sched_fence_release_scheduled() drops it; the finished fence is
>> +	 * therefore released last and frees the allocation via dma_fence_free().
>> +	 */
>> +	dma_fence_get(&fence->finished);
> 
> So what was the counter-part of this dma_fence_get() before?
> 
>>  }
>>  
>>  module_init(drm_sched_fence_slab_init);
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>> index 6cb6f9546493..fb238f51c0ed 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -842,6 +842,15 @@ void drm_sched_job_cleanup(struct drm_sched_job *job)
>>  		 * been called.
>>  		 */
>>  		dma_fence_put(&job->s_fence->finished);
>> +		/*
>> +		 * Drop the initial reference on the scheduled fence. It no
>> +		 * longer has a .release callback dropping it (the finished
>> +		 * fence's .release was removed to allow ops-detach on signal),
> 
> Same as above, I think the comment should not focus on the past
> situation. The past should be tracked by the commit message; a comment
> should only mention the past if it's still relevant, for example to
> solve an open TODO.
> 
>> +		 * so the last put here lets drm_sched_fence_release_scheduled()
> 
> Strictly speaking, you don't know whether it's the last put().
> drm_sched_fence is a public object and drivers might have taken various
> references.
> 
>> +		 * run, which drops @parent and the scheduled fence's reference
>> +		 * on @finished. @finished is freed last, from dma_fence_free().
> 
> finished and scheduled would be freed through dma_fence_free()
> simultaneously, since they still share the allocation.
> 
> I think the shared allocation and how things are freed should be
> documented, but is drm_sched_job_cleanup() the right place?
> 
> 
>> +		 */
>> +		dma_fence_put(&job->s_fence->scheduled);
>>  		drm_sched_entity_stats_put(job->entity_stats);
>>  	} else {
>>  		/* The job was aborted before it has been committed to be run;
>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>> index 7a64cc11de08..686c3687944f 100644
>> --- a/include/drm/gpu_scheduler.h
>> +++ b/include/drm/gpu_scheduler.h
>> @@ -287,48 +287,58 @@ struct drm_sched_rq {
>>   * struct drm_sched_fence - fences corresponding to the scheduling of a job.
>>   */
>>  struct drm_sched_fence {
>>
> 
> […]
> 
>>  	struct dma_fence		finished;
>>  
>> +	/**
>> +	 * @scheduled: this fence is what will be signaled by the scheduler
>> +	 * when the job is scheduled.
>> +	 *
>> +	 * It holds a reference on @finished so that the shared allocation is
>> +	 * released only after @scheduled itself is done; its release drops
> 
> Won't it drop the endire drm_sched_fence?
> 
> I think this struct's documentation is the right place to document the
> life time and allocation pattern, together with maybe the relevant
> places in sched_fence.c
> 
> Then you could be a bit less verbose in the other code places; see
> above.
> 
>> +	 * that reference and the @parent one.
>> +	 */
>> +	struct dma_fence		scheduled;
>> +
>>  	/**
>>  	 * @deadline: deadline set on &drm_sched_fence.finished which
>>  	 * potentially needs to be propagated to &drm_sched_fence.parent
>>  	 */
>>  	ktime_t				deadline;
>>  
>> -        /**
>> -         * @parent: the fence returned by &drm_sched_backend_ops.run_job
>> -         * when scheduling the job on hardware. We signal the
>> -         * &drm_sched_fence.finished fence once parent is signalled.
>> -         */
>> +	/**
>> +	 * @parent: the fence returned by &drm_sched_backend_ops.run_job
>> +	 * when scheduling the job on hardware. We signal the
>> +	 * &drm_sched_fence.finished fence once parent is signalled.
>> +	 */
>>  	struct dma_fence		*parent;
>> -        /**
>> -         * @sched: the scheduler instance to which the job having this struct
>> -         * belongs to.
>> -         */
>> +	/**
>> +	 * @sched: the scheduler instance to which the job having this struct
>> +	 * belongs to.
>> +	 */
>>  	struct drm_gpu_scheduler	*sched;
>> -        /**
>> -         * @lock: the lock used by the scheduled and the finished fences.
>> -         */
>> +	/**
>> +	 * @lock: the lock used by the scheduled and the finished fences.
>> +	 */
>>  	spinlock_t			lock;
>> -        /**
>> -         * @owner: job owner for debugging
>> -         */
>> +	/**
>> +	 * @owner: job owner for debugging
>> +	 */
>>  	void				*owner;
> 
> Formatting fixes in a separate patch please, unless you need to modify
> those lines for semantically related reasons.
> 
> 
> Thanks
> P.

