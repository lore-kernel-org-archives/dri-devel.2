Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD2ACD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 998BB10E9D5;
	Wed, 17 Jun 2026 09:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1T5vsDH4";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9487C10E989
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 09:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZsUEIbzq4XygFUeuxKtZPAX7RnjpvipPezLm6XMW5x0So3kQUy4dflAHigATLKzBsVoNMgBOxa9GowQlMMDLg7rdeCbAitxUYm6QKs6qWTP2ipGl3b7TDPfwqUC7UA+eg91wT7YCj/nweDv7Iugs1yYkSaxJcUJKUPiyhMHsPIK6ys2Hb3iSXU6LwxCOR96Y7PXjZAWWasdLp0Ciugx9i257gwmN/ROzwQ0rMzSegc21SPpvOeeYUO2DpW03IEwkGsfQAueuN+4Z/Ts7EaDhJeK0jt04BoKyTUPJN5LRyVx3vZm1NyIV3N+JcCOtSHnVI3Se0vjhC7pnban8PMhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO9/Su/HXOR/NIiKeTcnGWTjEF8QEUCRw5JC2VDeM08=;
 b=T9CYNx4L/t5XR3a2XWLeYw/7sy5wW5wLWNC7DRmuqPk6c+KI7kz29wMIPs5Bg1f/CWK//XeF7jPlj+RtUGapeIoI/tk5OztgrknOIqfNT2DUTqqxsHKsYg+N9oCmcxTaaCX3sg7CK/qYhGjYOCTj1KHNy+nXji6Zaod+j6wbEDuCMBj/4euklHBVTV2YlUOHYshMhXgHRF9+LyLGHDp0qCwHcGuj1fBBcBI3WFMXkmrpGPgLKjv6/RzT5DnGwlVYY56LAF73FqL7UxLD16jlLpl6PabsirQLfeB2V3WBzc/H62oBXpiCZINW6d1yRDLf5g0/NeDQUBSd+XpmOU772g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO9/Su/HXOR/NIiKeTcnGWTjEF8QEUCRw5JC2VDeM08=;
 b=1T5vsDH4HCclZ5h20892pEZdBCwt38e7GOpZxttI6Ak19YtSFsDjSdzG0zYx4mOkeDZ5bceKNybJnC+4ruY60w5k4lgnZJhRsuLsw1AO0iIFmIn25ZM6FlLzxnUNeq9y/c+TThe0/MYBFkCzvCxupX52JeXtwu4GWtiWuUWAPYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 09:46:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 09:46:51 +0000
Message-ID: <7ff7dc15-4df5-443c-8d7c-c8e9b2672f2c@amd.com>
Date: Wed, 17 Jun 2026 11:46:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Properly synchronize dma_fence->signaled bit (Was: Re: [RFC
 PATCH] dma-fence: Fix races of fence callbacks versus destructors by locking)
To: phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <dwlsalmeida@gmail.com>,
 Gary Guo <gary@garyguo.net>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260608142436.265820-2-phasta@kernel.org>
 <95f4ae6b-9dec-4122-84e0-fbb0cdee9cb5@amd.com>
 <fa9a335196525adbc03ec21b2e05bb526e4fc174.camel@mailbox.org>
 <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
 <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
 <ea4e0541-3702-4014-b8f6-0746a148df86@amd.com>
 <fa0dc9757bf8343516c4b156a2b70ec91b64ef8f.camel@mailbox.org>
 <6ea6c373-c6cb-4221-ad9d-e60b04d1368f@amd.com>
 <630a8a84ee8fdaa634c7b104742e7a28fcfe507c.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <630a8a84ee8fdaa634c7b104742e7a28fcfe507c.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9710e6-db18-423a-c41e-08decc555b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ceTn1q6fZ0kPRMCKLCp30gn8RXbSL7ii7M1ooZ/2QIZcx8HixU9eM3j3iD1cAT7m2iYQORsKFsUwWyPE/AMJ2V3TbBHh3f7uzhFb96h0fOV+ej5ndWcFVJFJpYHs5UKHO25k/2+DslrnTobFSzxAgsMrLUdzUhfZN22xIpcFJreeyBLZY47qrx9B1JLFoYRgwgNDcueayQZQWQsZ1/2WyL5MBCRW302Bi2+ya7554JSuG919ACzjy9+kZx2vx4DueBEBVib9fZbbFcQQfD9NJMiS7wTK8m+A08xiF9exj8/PO8H6U8s1EZsYaaQ1NJprEenp4Bz50viQrlCHct+O3l+FSsbrmgfTZCUKB4GGIEMyBQlFI7h5jyADAGYUHQ4SlwXzlIANuMsIoQgfMNyzayY9Mf6TVbw39aqIc5WormBFq6mqsIoEMvLJLgn4kvSL4s8XMn490Gq4EbR5SWhj0ajqaZrzH3dNoqGc9OHNOjq+SJXwJiHB+Vesp2QhqAv7L76B5uTowx7ly+P2VNl9zwTJuJqlwMhKjIb6jfc5Ar/VRc9hEt3LgrR/mOcR8p26ZMK4uNzI65vuyErquRDuZwmbmbCMgeHBOqJxHVyJ2T9CurJGzZ4EUFHds6BPHd7Wo7pTFG5i920q118RBjbDo4uZJTbiyzU5PpVc9BHhrARoNQ2McRfmp5gvPIkQPENP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHc2SUs4YUpJeWVuaENRUVdYMjZBWlVsaXhrMkdqbmtTWXFuZnVQNk5CNGt2?=
 =?utf-8?B?Um5DazNaWm1WTXhrOFFoUDNhREVhUnFDZ3hESVgxcHAyWFJwUFVBRkVoVy9x?=
 =?utf-8?B?OHlwaUlUcVhZNWVQcWg3SFdNWGxDRVM4QnBMMzVER20vMzc3a3BhR1VXMTFK?=
 =?utf-8?B?MjA3S1pPYkNZMTBJWUU0c0JmR0ZUZnZXK3MxMGE3R0JFL3ZWMGZjUVJiNWdZ?=
 =?utf-8?B?MkZxajN2SlUvcW81dEZCRE9xc3FrZGtJbURtQ1NWWEpCSUpxZDJvdjJLRVFZ?=
 =?utf-8?B?M3NxUjhLS3F3bWZlUmVlc1Z6WnFjS2lVSVZqaE9SYksvSkhSVWRMM2FzTUwy?=
 =?utf-8?B?ZFVBWWw1N0VpVkFyVWZrcHBtMDlldWlZRTlYbzZvS3FpSUt2L1BUcldRa1Vv?=
 =?utf-8?B?TWRYZ3Y4NkkzNmhyUitxZTd5UGphTUZUcDdVaTU1cDg2VzdIeFF3RDhuZnVK?=
 =?utf-8?B?djRyVGNiTmpWSU5UN2J6QXFBd3B5STQvYVlOVHczNjVYYlY1NHBzSW1OR3oz?=
 =?utf-8?B?WXBpWUpOOG5Ra0NhZHRlaytCQzhxSmtvZ2h2RzVMS0VsdUxOcVJMK0xxWHhR?=
 =?utf-8?B?ckVmbDd5Ujc3ai91eG10amllcm5qZmZiWEE4cDFQTkZYSEFtUlNocWpDOVlN?=
 =?utf-8?B?VDUxcSsxdVA2T1pjRFRVNjZadS9BYnI4bmFyY2ViVVV5RklSQS9TdjltWGFr?=
 =?utf-8?B?d1dkLzBIZ2doSFcwZXYzK3RpaHhnbWtZR0M5dXRiTkdIWEZGQUdSY0s0M1Zi?=
 =?utf-8?B?Q3FEOXRUN3NHOVdFeEI4aklucTE5TitBR3owNEhWd3VQV1ZBUGh5czBZVFZq?=
 =?utf-8?B?WjNXY1crWHpoNUJScWN4ZHdMczNYZHdmODRSVHYyQVdFdlA2R2dEcC9VUit3?=
 =?utf-8?B?Y1Q1ZTVXUlQ5L1VoNW0rZS9Ibk82bDBQYUNYaVRHcVViVnhuNWZzakFqckFD?=
 =?utf-8?B?VkJxbURyNHp6M1NjNEcxZWEvOVhpZGQ3dUVXc0sxTHhCSml4a1QvOURQenc0?=
 =?utf-8?B?QlBaNHg1ZmNOVHNXaXQwQTVscFl4RFVvb3B5akowMEoxMTE3Q0ZrRWxFWk5Y?=
 =?utf-8?B?RUowNE9CODBWamxRenJTTi9iSnMzWDAwUmZ6YmNTOXhQSDBJNENRTklDZXFE?=
 =?utf-8?B?MWNjSWxtVEpXTzRUU2UwampwNmUrNWRyaVZwektVRlZWTnJtWGtrZnRWamNh?=
 =?utf-8?B?MGlmbzA0SGJJR2JtTGZsU3dvS3ZBR0JpcVFLYTdILzJjellwbmx1VzYwZHRC?=
 =?utf-8?B?UDd6ZGNvVHlaMVpJRHNHcnhkS1QrUk1NZzdTdjIvVE5WM2NUTFFXaFlaL1RC?=
 =?utf-8?B?aEFCVGx1WDRUQnhtcDZPejVBWW1jeWFRWVA2MlM5dEk0aU1sSmprdzArNEsy?=
 =?utf-8?B?V3BPSHIzWTdSWUMyM01DakU2TkZrVUlYSmJzeDNYSm5UM1htRE9lZ0lqUC9O?=
 =?utf-8?B?Zzl4RXlISHhjemRaV1I5VGZoVTVKSmNsaG9oWnFyQXdPRG9tUUxiRkV6Njk4?=
 =?utf-8?B?RFZzczcveGMvTnpqSDM5Sm4vamc2VEJQVWFwVFU2SXNLdWJkTnczRHdQNVc5?=
 =?utf-8?B?SjdnMVhWWDFrM1p1M0xnU1NkcTJvQlZyd3JrVEM4UWRkUWp3bmdWL0p4SSt6?=
 =?utf-8?B?MDZzWS8wMjBvdmVEUmNlS08rZ0VvTndPVTFhaWV2TGJNQktJblg3a0VrTzg1?=
 =?utf-8?B?UzRZQXFYRE5IQVBXR1BjcTJZOGorUDdzSUk4ekhkMmRWc3RBL0pUakp3SU5Z?=
 =?utf-8?B?dDltQ0RIdVNncDJzNnVjRmZuQUt0TlRQSVV6K0J5VXc5OU95V1h4TS93Sktn?=
 =?utf-8?B?TDJRSnFEcUYyOWp1UXBxMnNtNHpBTzVOTnlCYjhlYUlOV0YweUswQnpRbHQx?=
 =?utf-8?B?SnNhcFZxK0F5NndDcFJMY3BVempiM3RIaHNNQkRYRDYvR0prdXBOb3kwUFZ5?=
 =?utf-8?B?Q1BhMzN1NzJoR05QTVRBR0ZKVXhCZGx6bllPb2I4RTl4ZS9qcmZDYkg0ZSs1?=
 =?utf-8?B?T3Roa252UnM5d1FpZHRZbFE2ckR4cmFpNDQwbFl2enV3OTdsVTFkN3pETHNm?=
 =?utf-8?B?dHNqcS9NNUM1blAwVkF3cDMxMGNiZGlUMHpNSWw5eHY5QVdhTDZaWWZEc29H?=
 =?utf-8?B?YlhYeXpHUlA2cSt1OUM0bEpJeGtSelljelFZNVFnSnhoTlBWbnIzbUVxRERx?=
 =?utf-8?B?d21nOUY2SUFPazJzZnEvaEMxSCs2NytkbVFGcXVIeVJWR3VLY3NGWExseVBu?=
 =?utf-8?B?NlRhWXNOZWN4MU1LRWloSVJnQ2NjcFBFendIejA1VTRLYUxEQTVqSExycVJm?=
 =?utf-8?Q?q5TPlbo03VfKYQR5ip?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9710e6-db18-423a-c41e-08decc555b50
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 09:46:51.0824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dctIISGDjgzULudCog5rS7Y7UzfgWFIV7V807UWprFVhP2HcLfulJzuXkaogta6e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
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

On 6/16/26 13:25, Philipp Stanner wrote:
> On Mon, 2026-06-15 at 11:57 +0200, Christian König wrote:
>> On 6/15/26 10:29, Philipp Stanner wrote:
>>>
>>> This fast path check in my mind certainly breaks the intended dma_fence
>>> design:
>>>
>>> void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>>>        ktime_t timestamp)
>>> {
>>>  const struct dma_fence_ops *ops;
>>>  struct dma_fence_cb *cur, *tmp;
>>>  struct list_head cb_list;
>>>
>>>  dma_fence_assert_held(fence);
>>>
>>>  if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
>>>        &fence->flags)))
>>>  return;
>>>
>>>
>>> Modifying the bit is consistently done under lock protection, so
>>> reading must be done, too.
>>>
>>> Do you remember who wanted those fast path checks? Who is spinning on
>>> that lock?
>>
>> Simona Vetter and basically the rest of the community.
> 
> I did some git-blame and it would seem to me that this fast-path hack
> was added in
> 
> e941759c74a4 fence: dma-buf cross-device synchronization (v18)
> 
> in 2014 A.D.
> 
> So it was there from the very beginning and was not added because there
> was a performance bottleneck later. It is conceivable that a
> performance issue was present from the get go, of course.

Not saying that it wasn't there from the beginning, but multiple people (including me) have tried to improve the situation and that was either immediately reverted or directly rejected.

>>
>> And I can clearly say even if I don't like them that those
>> optimizations are a must have.
>>
>>> In any case, that needs to be repaired.
>>
>> No, see my discussion with Simona on the mailing list. I need to dig
>> that up as well, but it was around the time I added the same
>> workaround to amdgpu.
>>
>> You are basically trying what I have been suggesting as well, but
>> there is a very wide agreement that the current design is a must
>> have.
> 
> I suggest at least three things:
> 
> 
> A.
> 
> Very explicitly document all lockless mechanisms and their
> justification in both code comments and commit messages.
> 
>  * We need to document lockless magic *drastically* better in DRM. I
>    see code left and right where there is some barrier with the comment
>    simply being "so list_empty() works without a lock".
>  * The commit message needs to justify why a lock is missing, why this
>    is the preferred solution, why it is correct. The latter also needs
>    to be in a code comment.
>  * Note that WRITE_ONCE() is not only about volatile, but also about
>    "watch out, here is a lockless access!", as Linus pointed out
>    repeatedly.

Completely agree. Question is who has time for that?

> B.
> 
> I think rejecting ideas with "we tried this, it >>didn't work<<" is not
> a valid reason for refusing an idea. Point A above helps with that. If
> your commit message contains measurements or links to tickets with
> *real life* performance regressions (microbenchmarks are invalid), that
> helps reducing discussion overhead drastically.
> 
> Now, in this particular case, I fail to see how taking the spinlock to
> check that bit is evil. If it regresses someone's speed that much, it
> would mean that someone is heavily punching that lock, like polling
> 24/7 with dma_fence_is_signaled().

I think (but I'm not 100% sure) the the problem is that taking the spinlock introduces a write to the cache line it is in.

At the moment when a fence is signaled a read is enough to check that state, so what happens is that the cache line for the signaled bit sooner or later end up in all CPU caches.

When you start to use the spinlock the cache line backing that plays ping/pong between all the CPU cores and that is something which always stalls each CPU when it needs to acquire the cache line. Keep in mind that on a modern box you can calculate like a 4x4 matrix in the same time you solve a cache miss.

This is especially important for the stub fence which is used by basically all cores at the same time whenever you need a signaled dummy.

> Again, having that use case documented somewhere could save us all time
> – especially for you, Christian, since you wouldn't be forced to have
> the same discussion over and over again over the years ;-)

Well I could also send out all the DMA-buf resilient patches/ideas I came up with over the years once more.

I think you will potentially agree to some of them immediately.

> C.
> Robustness and correctness always trump performance. They especially
> trump microbenchmarks.

Yeah agree completely as well. We should also in general not optimize for unrealistic use cases.

For example I had to reject multiple attempts to optimize the dma_fence_chain container for something which only happens in test cases.

Regards,
Christian.

> 
> 
> P.

