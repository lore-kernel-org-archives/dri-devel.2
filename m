Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB6CC61DD4
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B178F10F2CA;
	Fri, 28 Aug 2026 08:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B86AGb4M";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A4810E49B;
 Fri, 28 Aug 2026 08:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMtBW0eWz4SmT8yiVgV88hvCABar9gdpOsqO8Q4ifCqppmWds2b8Gjpb5K1i7MC/TSVg2VfEH8DCWoB3H5UqvL+zv83b+dDgOu1tBzsWQhW1xvq7/Z5dSEheTeq8N8vsQLR5V1uv31vv073GNjfQ4qYm8M84nf5DeXDyd5ftjbIVf9SwIq+9djF+8FdXke1HMG19cwo9YeUb6NtZRVHBNg3dN7Lvwlp0oQB7fW7IJo7KD1D+4vQlJ1wkJH5AJYJP5hvZCQELvVDSAD0xpRS6+bM7UTkxcDzOuhc45iEGBf0n/fnvB3CuyXLQicVdmLhRour++fDzvx+TFKJQ7xLjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGp9mhz6iaGudhw1clnmnQtxbYq5tUhToCkH1HLO/CI=;
 b=Mc18RcFlAuEKAdv+PcGoyW7QhHlmkEIg8M0hbJ+o63mZrWgCHkBD0G+sJTioGFC1Yyxws6snzlGLz5YfI9Z4NrEjUUqxao063A0UApdVQMOjjhjpG3z/K0EDIySObfV+C2WSMsT3uUV6+EZV8RPck9hytUFpJHzw7l3nqyZqB+V0Majx3kj/RwJyvfeVPWTFBOBPa/SFmZm8QF8NwZjI7iLQx45qoJRhAW/yzT7HQWcgADXIH/xcPWYPJJ+FoCRhEkuRmtrsYHnSKvrdFD43C22j9YS3q6/L01DZlnImYNd5zdOVxcrNn/hb31SJePxkIsfAInX0QNMjdywPjzrLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGp9mhz6iaGudhw1clnmnQtxbYq5tUhToCkH1HLO/CI=;
 b=B86AGb4MJqs7idkR5//v/cYHvJFXRq8pGStDzaZ3kvoTXGRWoYVM3s/eUDVCjovv5yGnDN3c6DRPGc616rhVkyBobHkTvYAuqFFTAyuEOxcpP5c/mhPLKWnNvBaopHVbBlxk7nv+PVkuNnNyLLnrQEpW4X5/1yJedHDqcuPqaVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 08:18:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 08:18:30 +0000
Message-ID: <1ea90a49-ec2f-4150-a7e2-4f645ef3a98b@amd.com>
Date: Fri, 28 Aug 2026 10:18:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm: Add common drm_user_fence helper
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 Matthew Brost <matthew.brost@intel.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260828063103.4106629-1-srinivasan.shanmugam@amd.com>
 <20260828063103.4106629-2-srinivasan.shanmugam@amd.com>
 <apE17lJZmTD4+5jR@gsse-cloud1.jf.intel.com>
 <IA0PR12MB8208533952E71C3153ED308190AC2@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB8208533952E71C3153ED308190AC2@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4dac39-0dc1-4947-7b7a-08df04dcf1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: ntb3u91syXfdafFf8U17v/fegVc4h1eNVo6NFUM2SA8Af33ArawrOHajdSflZedRYahqYdPLfwytn+/dCTIn5VrLRaFYuZ4+h7PtmJ6AI7qW51vMdvjGTAUSt8PnY1dGEGYQKHYkEhRdM2BWxYDkEbot70xlBA5EsUqDlTUzQrblQGPp1ukYvSzIy1JajGxTY7EZnYKRtoBDe2wIoxRsWH6bckliewpEuyibwx69dShlgaNM1j3WFzXNza8+oOBSKZGvPeVTqnwrHIfzZYwbqJ/VwDKQ0neFSz81bUvDcVhDulA7Y6IstzGt5eYCQjTgq9lvI4y2+fazT69pwRlnh56JAzFq+dorqrtGXy3lVT28G7JmH5HoDCWLlPqXj81rMWZ//7gtQO09K53v5s0lEnkJuTZynhEn2qsro35il9KB3772bSnJ/BYzwOSQQ4IUspSkBm91fZlwofRAo7YMGwpeGKkV+Du/YeAQnBnBN+lIO5PXpAb1z2XXix+Oglz/CE2pCVPKjG/T3FUjIgXTlfbIghKH99RWb3TEf3ZSiqWW87GrGEL3IHSsvDxnMA6mo5ot4gisMGoDTW2H69muGz1RQnTyyD/qRsbRnLxtooVPF70JbmVhPm/6bst61PidziTmjDi+fOWWunGwT0U40o7m7PKi6bvOdDLNezXLPL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmV0RXhsNjJJSUZsa2Q5TUNvK0xtMHpLaThUdXUwMHlnUEpjNnoxM0RKTU9p?=
 =?utf-8?B?My94T0lhcGw2cFlVNmxqNnlRMU1LdGtVNzU0dzEvNTU3NGVod0JjMXdXUHRF?=
 =?utf-8?B?aEVvekloUk43NE10KzlzbjFGVndlamNMNytGb3lpNVFTK1ZqeUJKbTBjZDBn?=
 =?utf-8?B?ajRJVVF4VzA0ZWtsaHZ4ZUZmdDRxb2g3T2lIRk15eEt3K1AwWGVjMHJZakhu?=
 =?utf-8?B?M0VscWF4aTBCUmZnOWdBS3E5d1l3UVdPNFhQK2I4dEhVZHVPR3dEai8xYVly?=
 =?utf-8?B?WktNcnNHdkVwZEJLQTFwaEdteE8yZzJCQmlDWldNSC9zbDVvSnFyNFFIR0pC?=
 =?utf-8?B?QkZMNzgxbS94bHJ5QjZBS3cvRmNHZFlQNjZwZHUxc0dZZmtiTCtSMkg5QnRX?=
 =?utf-8?B?SG1kQndiWlA0TkhPdWxOOWRIS1kxRlB2S0VkUHBWTGZmQXJQOUF5VzdJNGpP?=
 =?utf-8?B?QXJacmhRT0g5SmRYS2Npc1NzQXo5cCtWVy85aW8yaDFBL2lRTllqbzlVYzg4?=
 =?utf-8?B?WUgzTjVDUmVWU1BRNmd1Q0JGc21uMDh6TDZQTkdieWYzL091YlZ6TkplMWM3?=
 =?utf-8?B?ZGRmc29XSXM4OGE4MisvVFVxQWFZN1JMU1ZubG00b0toWEI2RmswckgyS2F4?=
 =?utf-8?B?MXZhOVBhVWFIejZrTmlxbnExY2ZhL0Fmc0NLUTRPKzUxRE1YMEtyTGM2NzVG?=
 =?utf-8?B?NFNVVFFna1FSSFdDbzRmVkQ2QzVlcEdKeUdSMDVhZWdvZnlDak53UjVnS1B5?=
 =?utf-8?B?d1ZPZXM2b2pHY0p0Umx2ZjNYQTBRNzZHbkdiSEx6Z3o0UkxIR0FBampJaHIz?=
 =?utf-8?B?UTFMcGdpU3FmblNEMkh0SUx5UjFNS1lBRUw4V3g1cXQvbFd3aU1MVVVUZEZm?=
 =?utf-8?B?WkR2S0h4NmdWQjN1M0VUbnlyR1crKzV6dkx5ZVFHSUNYem90Uk9BSUhSVGIv?=
 =?utf-8?B?Yk9NWW81TU5rNitncitOdFAwZEkycW1qeSs0eUF2cjQrMUtNR1JITW1WcWU1?=
 =?utf-8?B?U0hYMGlaS2dQdlRtTHRIc2dpSmEvOGNFVURzbzdjc2o0Ym9rdWxkTTE0Vzc0?=
 =?utf-8?B?Ryt1cW5scUVLd3JWaG1nMUd0VTgwU0ptUklGME4zVUgraExFd2F6cGlaam04?=
 =?utf-8?B?M3dVRnFubk5EbjVoUVc2cElmUVJlSDA1ZEFYNUcwWDVVQWZ3ZUgzNWE5WWtk?=
 =?utf-8?B?ZXQyL0VGQmRaM25HNFpOaU14NkZKaUl0bUtHUlBlR2FQY0U0VEhVOEt2TjU0?=
 =?utf-8?B?ckNtNi85eS9GUmk5QnlKczNCbkdsN1VvcGszRGV0VGV2d2dYc1RiSFY2NWw0?=
 =?utf-8?B?bUZYV0VuS3BoZnd2a2IvWUd4SWx4TEE0UjNjbDdWS2NyaUFDbExQTG4zYlNR?=
 =?utf-8?B?M3ltbFZMaUNTUWhaU0MraG5vWWtsY2plMG9TM2p2Q2lNWDNEbnlNOE9KRTR4?=
 =?utf-8?B?SnVUcU5TTjR2aW5IWmRMMmszVlAyd2pzU2hZNm5TdGF0dlMvNnZuaGhWb1NQ?=
 =?utf-8?B?R2tUaUZpbGlEZHVvc0l4NGpVeXU5R24yV0JZdFJSZHRXdG1PVzFJUldiZzB6?=
 =?utf-8?B?TzlDRDFZUmFKaENWTTBtdmN3bXNhdWtHRzNRV05ET0tleHk3YkNyeGcrTzYy?=
 =?utf-8?B?cGNLUzBRZXFKMXVPQnhsbUtScHA3RGN2UUlweWlqYTFkMDJlS0QyaE5ZQyta?=
 =?utf-8?B?T1pzWDZhdnUzSFRmbTRvK0VQcFpMdWp2TEVzc09Sc0VnMUUxTXVWTUJwZ0g0?=
 =?utf-8?B?SllkSHBtVUd5UmV2eDRqQVJWOWsxdDkySy9oUTU4UUx3dzB4d2VYWlR6MWlJ?=
 =?utf-8?B?NUZtTXJ0STJmam8xOVNyY1dmZlAzOFNGU0Z5S0Z3MXg5ZGR5ZmVsTlNXNUpu?=
 =?utf-8?B?SHFaRk0rckxwbVhNVSt1SHhiSHF1NlZtb2JoV2tqdVg5ait6TUw1NE9kYkow?=
 =?utf-8?B?S1NCbnJGTWpTQmFGbU50YVZoRElBYUhvbzJkNjNXcEs4RTYrUGVRZ2tqM044?=
 =?utf-8?B?NCtySzFoR2x1cXpHM1RaTnoxUUR2ZU1vZVhNRnExcjZSc1hqN1lUUFJuTUts?=
 =?utf-8?B?cWJhQys0c09QV21rWHNPUkRQdWVLaWZucVJFZjZGZDd1bThQbWFSUjM0T1Ry?=
 =?utf-8?B?WnF3eTFheklLTlB3TkNlUS9qL1E4NzJRc1RpOVRLemNMUEttSUlucDBUaFRx?=
 =?utf-8?B?Z0w0cmpoZ2V2NUdMN0xqVE8rUnJzMUQycEx4N3hjT2hTSVVjamQxNS9pTEpV?=
 =?utf-8?B?cnNYTDhKNllTTTI3YTRyZnREOUNqZTVTdGpEYWt4MkFSd2NaNDlhQVRDZ1lY?=
 =?utf-8?Q?FszvFVfNfHl37/6/08?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4dac39-0dc1-4947-7b7a-08df04dcf1c6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 08:18:30.6957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRPb+oE+xjFjGDBDvgckFlP/VGyhWt+535jOaRtkZ9Vdu7RrPccHGPnMYbKVpx4X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355
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

On 8/28/26 10:06, SHANMUGAM, SRINIVASAN wrote:
...
>>> +/**
>>> + * struct drm_user_fence - embeddable DRM user fence
>>> + *
>>> + * Drivers embed this in their own structure and implement
>>> + * &drm_user_fence_ops. Call drm_user_fence_init() at creation and
>>> + * drm_user_fence_add_callback() to arm on a dma-fence.
>>> + * Call drm_user_fence_cancel_sync() before driver teardown.
>>> + */
>>> +struct drm_user_fence {
>>
>> Should this common layer be split into two distinct concepts?
>>
>> - drm_work_fence: 90% of what is here, minus the kthread_use_mm() and
>>   mm-related code.
>> - drm_user_fence: a subclass of drm_work_fence that adds the
>>   kthread_use_mm() and mm-related code.
>>
>> I suggest this because I was thinking about it the other day (I forget the exact
>> context) and reconsidered a pattern where a fence signals and then I need a worker
>> because some work must be done outside of IRQ context. A user fence is one
>> example, since copy_to_user() can fault, which is not allowed in IRQ context. At
>> various times in Xe we've had multiple patterns like this, although at the moment
>> user fences are probably the only case that requires it. If we looked across DRM as
>> a whole, I suspect we'd find this pattern open-coded in a number of places.
>>
>> Yes, drm_user_fence would be a very thin layer on top of drm_work_fence, but I still
>> see value in the split.
> 
> Hi Matt,
> 
> Thanks for the review and for being supportive of the idea.
> 
> The split into drm_work_fence (general fence-to-workqueue pattern) and
> drm_user_fence (subclass adding kthread_use_mm) makes sense. I'll
> restructure v5 as follows:
> 
>   drm_work_fence: kref, work_struct, dma_fence_cb, stored fence ref,
>                   wq, ops — add_callback, cancel, cancel_sync

Yeah, this pattern came up so often that I already considered adding it to the core dma_fence framework.

So if you feel really brave make that a dma_fence_work helper. If I'm not completely mistaken AI should be able to find quite a number of use cases for that already.

> 
>   drm_user_fence: embeds drm_work_fence, adds mm_struct and the
>                   kthread_use_mm/mmput boilerplate, thin wrappers
> 
> XE will continue to use drm_user_fence. For AMDGPU, The long-term
> per-signal filtering approach (reading the fence value via copy_from_user
> before signaling) will use drm_user_fence — further validating both
> layers of the split.

It would be really nice if we could move those compare functionality (>, <, !=, == etc...) XE has for the user value into the drm_user_fence handling as well.

We also need to add a heck of documentation that while this is able to consume dma_fences it *CAN'T* be used to implement dma_fence_ops. I had more than enough headache because of that.

Regards,
Christian.
> 
> Regarding the CI failure — the root cause was a missing trailing newline
> at the end of xe_sync_types.h which caused the kunit build to fail with
> "unterminated #ifndef". I've set up kunit locally and confirmed the fix:
> 
>   Testing complete. Ran 588 tests: passed: 570, skipped: 18
>   Elapsed time: 22.916s total, 3.949s configuring, 18.350s building,
>   0.601s running
> 
> The 18 skipped tests require Intel hardware — expected. The CI fix will
> be included in v5 along with the drm_work_fence restructuring.
> 
> Thanks,
> Srini
> 
>>
>> Matt

