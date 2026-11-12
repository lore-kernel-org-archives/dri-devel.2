Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E60606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SFWqRC37
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3F310E60C;
	Thu, 12 Nov 2026 14:55:32 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6B710E60C
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfYE1uPS8mOjok0J4uKFaMWyxJu2VbZbKbgthTuz/m76V5dl0cWKcaWtXRWHML9/afZo/MDA0jCsCaqpTMep0qt3z7OaHh0cK8w52NOPFvQoMmtBvsQMy5mEAa9iUtcxELRjPA1LoZ+NDveAMaudKqC2+qjyWFlzoG2e0pnWVr4LqAF5SzzB/uJeQQhfQYDxdgtVn5yH6elDg61LCVcMoc2jE4xHqap8X+5BYCZ7g1aNzpgZNfLm0dayb5H9Y+CTckt2DAp2LJ4kR0Cw/l8LQmKpzPgolqOUlfpzmQfreQAafce0C5TiAt/Q0BTUfH0m0y3HC+8QrrULgeGEEU4IMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVoCgB13YYiMtWpV93mxx28UAaFd3uN5svw9dgkNGUg=;
 b=Y0d/NwBgB3iy+Xrfxg4JEucBatr43hT43wdnZt8aYrXkx+FjgN6GyWVPsSyj78rKAMjtonOptUNzWcsb2F0Pr6US5lN3XjIeLasyNaJXsCA6YfDMWkZyG3/v0lTKII9EB4XlaqkyStuQJy5WTeKI6DVU/NUh59sdKYlul4AmVVRTmKBGwznrTmsvS2PkaKl+xbMe9wnPDPohE+Ei3ahVKa0iO21empo8cjnSG9phyLrEXmHEhFNyz0oEEujN21WpjFFnxO51dFK3JebvGRUeVvyUiF7hWkR8Bnzz91ayqN0euEqf+VlapCIAw4B3/hN96QTo7bmdLB31Es/PFP26YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVoCgB13YYiMtWpV93mxx28UAaFd3uN5svw9dgkNGUg=;
 b=SFWqRC37e2RdW5Shc3GeD3T8Qp0H0zjehmYK52tVLXLtf6BPp0Fak1754IEQK28UUHoFI4qOE0OY8lIP96HlUl1A3NyksR86ZsUVabTL3qCYX4utSU2mPipJSgAkEP5dGh9Fdq6BE3aPEF2uSQus0U29kzM3Gb36rcMlF8Ivyz4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 14:51:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 14:51:09 +0000
Message-ID: <c956cf4e-96a5-475d-b12c-406c5e008b54@amd.com>
Date: Thu, 12 Nov 2026 15:51:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Do not overaccount job runtime
To: phasta@kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Gary Guo <gary@garyguo.net>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20261111105921.38710-1-tvrtko.ursulin@igalia.com>
 <71ad23bcb3d48f771ce74270dbe4dfcf39827031.camel@mailbox.org>
 <0ff2a53b-377e-4839-88da-1c2b3c25b3eb@igalia.com>
 <6f2f8ff3738152b50521e0cad88978e2ffdb5feb.camel@mailbox.org>
 <4606cd56-f1c5-4a00-b9ba-fdbf2206681d@amd.com>
 <1f2143d213d22dec427ae1bcfc7cbfe2d34ab83a.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1f2143d213d22dec427ae1bcfc7cbfe2d34ab83a.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: a98cafed-d436-4976-97d1-08df40cc630a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|261026121527099003|4143699003|261022105027099003|11063799006|261028144727099003|56012099006|261009223027099003|261021121427099003|261102123227099003|261026140227099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: sNb7GLkO4Wd61bhpeXri8om03hnzv2MY0UedT/iMN4I+1i/ruJPaMndJPFi71awUpVpW0wBB/GhfEb/GY+LC1wOiPkdaZrm52c3oKAGjDKJyzT55ML9DGANLEVG2NOkFEdB940GvskoI9i2EguPJT8+9dBj3WvXS/Oi5Zq8taTS1AE3ZqfWKBfSCMjmjgj6MgqE3+LP7dXYMRZQPsmfb966DCztKdq8DEwTva1ShoGdJhGt+ryd5qUJYxyU8ORW7iexGRfM8g9CbCcBNQxIfI3mro5zyJY4h9hgKRwUFX+zbTPEhkak1sYr/qpOqZcdxgNMKhHg4oi8/7J8+RH4ks35yrHfrLTRc0GLk3xN6nbz3d9LUFUgvSEjBWjI+I2YN2d2DUMZ23NgE9t55qz4tGPOySYcQ+XE7YBnzRSjTjq3yC/8VLpxwbFEaJHbODZcm5Cmuff+nJ03vlvekeWwscpmdzccjsehCx44t0hIPSAd3cCFGUli2i7Dx4NWk5E1lS/0Pq67DFlPEemi9Pd93Z5VJzWumjoR3BCRjZgmVgK7+T7Br/2a7pYPlb6LgbnYCRkLCQB88MQFfIXss2j72t2bxdel9R4wU6/2VWlzGuLOKwBAfz9zt2nJAE5UGML22w0qb0kxzjCQmusscpXmGQ3pzmrzYMiQxyUqR/6hOEy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(261026121527099003)(4143699003)(261022105027099003)(11063799006)(261028144727099003)(56012099006)(261009223027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUhvM1g5U3NuS1AxanYyalVtMkk2YmY4cU9YaTVDSFV0WlM4bTc3b2pqWFlG?=
 =?utf-8?B?eVFMNG9Pcm1tR1JuWXRac0Y3RzR4SDFEQ0d0MldWdDJtaS9sWndKaFVYbWlH?=
 =?utf-8?B?QVhKcGZpR1RRUzkvWkFldUFrd1JCMEJGZi9GYitMTEhIcFIveVhUc3JzbmRO?=
 =?utf-8?B?WFJzNkhWZ3ZNN2s3bDNrOWhDTVljalpsMXdHSmJkQWZwOHFGbnlzRlBpQnNk?=
 =?utf-8?B?REJPWjh2NVpjWnRFYWZBci9hNU5aQk14VHFkQnA3OUp6MWhmcUdSeHZTRHpj?=
 =?utf-8?B?RjNzRzVBWXVwdjBwMDFsenNMYXU3YTVEeDEvN3J6cEhWdWNCejgyUk1hTnRM?=
 =?utf-8?B?ZDlpNUswd0VTcDV5MWRyTnhzRjhNeXVseDhWL0ZQNno1M2NxbVExaDEzMG9y?=
 =?utf-8?B?VU9XanVveTFPVWROZW1lUnFydVU4ZmpzV2Vqdm1GeVNNMnNHdUc0eWpDRG1a?=
 =?utf-8?B?Ym1rWHZqV0F3WlVFbEFTRC9LMGYwOWtCRUtaMFFrZXNOVHNQVzJwb0l5Z1Zu?=
 =?utf-8?B?ZER4eXUzTjIzRHVVK3Z1c0FsTER3Mk1FTE1qNUFzSnFlUnBxeHpHWmZEUk9r?=
 =?utf-8?B?ank0Z2E1UGljZHBJekNkRHhPUlRzK1FaUVBYYm5oL2sydlhQaUpScWhuQUlr?=
 =?utf-8?B?RTBGY3dZYUlRdXd4Mkg4REJyZXZTUkE2N3NxT0J6SjQxS2lsNzc5QUZUWDMw?=
 =?utf-8?B?OEU3VjBJdExyL1R5c0FFT1R5UmZkWjFkN0JzMlhXY3pzNVJjSXMzeWdkRGtl?=
 =?utf-8?B?V2VhM2VZSHU1SW03NGhLNUdyQW1memVKd2pZUjNDQTRPdUpEd0N6WUZWa0hZ?=
 =?utf-8?B?UlhZTFdjNVg1czR6WW9raDQ3dmlVOU5tc1FDNkhldVVsR1lnUHdmdlZ0N0pQ?=
 =?utf-8?B?YTBhZ2NicGJUc1lQMzNzUjVuSVNWaXF2OVBEMUNrQ0tJSVN0VEpMRVVOeVBu?=
 =?utf-8?B?TGRZY3VTL24xb1FES3pSdGJnU1FvV0NpVE9NamdiOG41UllIOHMwWGZCL3Mv?=
 =?utf-8?B?aE5ZOStlR1Z4WmhtYlJpOWJjdVFVVXVHUC81WWczSU0ydm1zZXJuOWttL1ZW?=
 =?utf-8?B?RjM3SDN1K2trSXVwRUZGalQ1ZUdRVnpxd1lLcGZWOVpoeFpBcWhFTUpBRlFx?=
 =?utf-8?B?VDE2YzF0dk9uaEFRK3VlTDdiZkFqczBPMk9ZVXNzTDBKaXpjNGROVXVHVTgv?=
 =?utf-8?B?VmpreW9oOWcvWi93UVJTYlR0blBZQm4xNUl6bE5DZ2NXenlMZ3p1VWRaNlpV?=
 =?utf-8?B?MEpIMkRKaWRVMURVVFNEVUhnWkxQQXQ4UGp4SXMzUTZlTGtmVHNvKytTV282?=
 =?utf-8?B?ZTltRC92bXhEeHlQZUpKdkhwVXl3d2RhZU50L0c2REcwV2V1VEpWa3FneVcz?=
 =?utf-8?B?bG0xbithTUc0cnBwZEgxT3puRk5ZQk1aZVRibUtHQjgzbDAwc0lIcVJhS3g2?=
 =?utf-8?B?T1FqUXdNNEcxUk8yMkllRXVaTnlGQTFBK2F4amdkWHVOakZvYlkxQXdkdEc3?=
 =?utf-8?B?U2Uzd08zaVNHdjJZR2xlQ25vdWZ4RTZsQU5Ua1c4Qy9EalhPSWZxQnl2Yllt?=
 =?utf-8?B?QVluTXBRMjZnRW84WUQxS1ZFcjJuWUtac2p2YWRSN05EcFRhcUpIVHVVbkxP?=
 =?utf-8?B?djRCK0EvcDVXUDN4NmhCaTBFcFVlOEc4L2luQkpTa1U1aWhSZGFXb2k1c2VV?=
 =?utf-8?B?QkVNS3BDdUJGYXl5WDg1T1VReUlwdURvQXV1V3JvTVlnRXlKRHNjUGFEekw1?=
 =?utf-8?B?NVZSOTRlR2NPbzlIdlhBek1NbFljcjdwMy85SzJCS1ptZHZFSWdrK2lnSzA2?=
 =?utf-8?B?RTg4MVJEeUJWRHpGejd0TGlXYkV4VC8rbXRpWWh0dUFraFRoUVJrMGNBNFNj?=
 =?utf-8?B?Qk5lNWFrc0VrWXdzVzZSeWJwZzlvZmhiMG5XRnRqY3pmcTdSaVN0eGZmUUxH?=
 =?utf-8?B?MnlzWVI0RzlIdGNWTkJhNmFqUnoxZWhvY0FGd2Y0REVaMnVSK0NGc0l6NEUx?=
 =?utf-8?B?MWRCcU1BT0IyL1NmWGt2ZWVxUGlFeGZaTjFYcjdiUkFuY3IxWEE2MHJsZlFD?=
 =?utf-8?B?VzdrSDMzeURQWDZic1AzQi9rM0p2dDE2UUF6UDdZSzk0SWVkRnZ6bVplSmU1?=
 =?utf-8?B?MSs3LzNyNGpGSUUwTW1ERUZodmlkc0cvUXkwWXBUYXQyNmRtVWM2YmRvdUdL?=
 =?utf-8?B?MTFhRGQybW55Q1NrUjFrcG5wYk9VWVJwdlB6TjJNZnphdjNWZTdrUk1Xa095?=
 =?utf-8?B?eHlhZC9BM09OVEZzTHlIYS93N0twMWh4ZnR2TVJpd2ZJQjhrZkMyRzRSaW5W?=
 =?utf-8?Q?cnXAdn0Pbqtia11r6n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98cafed-d436-4976-97d1-08df40cc630a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:51:09.1132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3spaXBHC8WPb1st7bbfJEZtzKWlWcd3b9XKeYp6k/lt9oJsPrQSvFYoTma4SswA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 15:27, Philipp Stanner wrote:
> On Thu, 2026-11-12 at 15:15 +0100, Christian König wrote:
>>
>> To allow drivers to more accurately calculate how much time the job spend on the HW.
> 
> It's still just not a very good idea to randomly overwrite a fence's
> internal value without a formal API contract. This should have done
> through a dma_fence_overwrite_timestamp() which is responsible
> centrally for the ordering, or, even better, through a separate
> timestamp in drm_sched_fence.

In general a good idea, but if I'm not completely mistaken Tvrko came up with a complete framework to track the time each entity spend on the HW based on both scheduled and finished timestamps.

We should probably make sure that this framework doesn't depend on such hacks, then switch amdgpu and others to using that instead and drop that hack.

> Why do they care btw? As far as I have ever seen only amdgpu uses the
> scheduled fence. What do you do with it?

It is used for the gputop information. E.g. an estimation how much each submission uses the HW.

> 
> I see why Tvrtko needs it, to do the fairness algorithm.
> 
>> The time it was pushed the to HW queue is pretty uninteresting for the time spend on the HW.
>>
>> What you need is the time it started running and that is when a the previous fence completes.
> 
> OK, I see.
> 
>>> Is it guaranteed that this fence is signaled and, thus, has a
>>> timestamp, or is it not? If it's guaranteed, the test_bit() is actually
>>> unnecessary. If it is not guaranteed, then there can be misordering
>>> between the two operations and it's UB and, thus, a bug.
>>>
>>> That said, I'm OK with your patch here being merged since you did not
>>> cause that chaos / problem, but a second patch with a FIXME about the
>>> issue that links this mail-thread would be good.
>>
>> I've considered this approach as well when we originally merged the
>> change, but the timestamps are only like 90% accurate anyway so to be
>> honest I don't think it really matters.
> 
> You have considered which approach?

What Tvrtko is suggesting with this patch.

> What do you think of the memory ordering problem I point out?

Not much of an issue, the timestamp is really only used opportunistically. 

> And btw above you said that this is done so that drivers can do
> something "accurately" :)

Well "more accurately", e.g. the accuracy increases from completely off to only slightly off :)

Because of the interrupt latency and everything involved a submission which takes 3ms can report in anything from 3ms to 6ms runtime from my experience.

If somebody wants this to be really accurate we would need to record the HW timestamps. That is possible, Intel does that for example, but for AMD HW nobody really cared enough so far to requests this.

> 
> But as I said to Tvrtko, we are where we are. This here is no big deal,
> but I really want to get the dma_fence memory ordering set straight and
> well-documented. The usage patterns have fragmented. It's completely
> unclear whether what drm_sched does here is actually legal.
Mhm, Tvrtko's work might be a good reason to get the job runtime accurate at least.

Regards,
Christian.

> 
> 
> P.

