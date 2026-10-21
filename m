Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6239606A31B
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WAr2RtJg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538C910E297;
	Wed, 21 Oct 2026 03:13:09 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C57F10E297;
 Wed, 21 Oct 2026 03:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJA7AJevCGH37zhW2gLFHlgG0bFfn28rrGcbbkhW62N4bCB2syBhCXZinZPJj8+o0XiTUl0akwwkU1x/n1Nd5BwHZnBP6iXwFneibDkLsrOpT/3zZLGFfUfmrsU3o+YCyykiXnFvZVigvtxFoI48lwE30eV/7bLzr8QQbBU9u1fdUgJudpHntu910UQysuKtg+vYvmmhfZVQ8VHU3YVIGQ/a1bqc/PrKFbYK0DLR4yH9VJFeNi7WpSFNEc5HwQh3Pqxmw/GxbyjryMNbLwjcO6LxvhFlpMZ8E8nWUhPTAV8B+/EKEgiPWMu0z7YNxprCEDD63zuw6cUL0y5HLiMIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsZRGLn1g0rO1SSQ0rgwADcWltaM6igYHrUC85vlFos=;
 b=QKLvfDtA4NtpbEoZqXMeaeEq8JN6Mxg9+ULbsRMcN9zyfKBVlJLGydVfNc/dT0trd6NhptPLeJsOR6PSBBaeVAVW6r3jdB58wPHQzyHh/jPlqnh6ClzYwjV0ANl3It6abek0B3rr3tmif4dnmu8NSsHzEggElnHRXgubFkNauIz8CE2NJIOLW8lbE3avZ7F9W/3gFsgHB+0NsX6UvC3hjH7nhinhsz1hvzT5MrJ44IIdGvPvVZmOMbSmBH6TLztU+y1nt5IAwBYxCBDD2edeQBWIHhZy9SqWwmgvXnD2/H69An8VlOvEjlHMOANjsesQbfqddunsTj3hvvscB8l9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsZRGLn1g0rO1SSQ0rgwADcWltaM6igYHrUC85vlFos=;
 b=WAr2RtJgC+es0EIV4JnBCoQ7RVCeH+tnD8fvnK7kUa92h5x140dlxzbatDyWijZmNb5BEDwT0/jW3vXqyAQRRVyXKJXq/jRd4exramWP5KxKoPdUQPvQR5yAG27EVkDQ8iwGECcx3xzt6xuYn33yEoYCHiaf8ISgHoV96+j7HETyjA2rNBLHeQJDD8VUxwrdt6intEz3PqJEjEmHawgO8ArA7KLQUEjHOCLRE0G8AqHRMvDkrn/AC86lKyppTtMhrciPDoXsDZHpCfMdkKs6voMdouqOAmkuhMQy4g5cYvxl6Rt+vFYxRzXxHmyzKM4NFh56+2fVUCSGR0lE7PTq8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 03:12:58 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 03:12:58 +0000
Message-ID: <2cedd65e-514e-493a-a8dc-cba683c84fea@nvidia.com>
Date: Tue, 20 Oct 2026 20:12:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/14] gpu: nova-core: gsp: cmdq: use consume_element
 to implement drain
To: Eliot Courtney <ecourtney@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-11-dceeb8f360ec@nvidia.com>
 <sashiko-outbox-178822@kernel.org> <DM9QI47QSJ0L.2QMRVD4AP5WIV@nvidia.com>
 <DMA6GSC7REE4.1OL8XYR8JKJ3C@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DMA6GSC7REE4.1OL8XYR8JKJ3C@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::29) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: eec653cc-377e-41ce-1eb7-08df2f213567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: F7A9tYqniTRF0UkGPGmmNw2RwSMZ9ehvY+TUEnETKm1GMJj4nhSz1G5CEz8sQcCYM+4YzX6ONWjaZ3gLZWr4IMRRuB7XbUw4VXaICznst3qL7k6VxpfuEcyaAGB/Mm5Iorz3CEPD0fzUkvGVoaiqPRwu5LTkGXYUIt1SXS5RJHtfJsMSXDHbP+ER35/PgpulJLV9wIikvH0qTIN3l1uMUzGvMaQ+a4kh7tZDgwMO0FG6yygj1QnD0mRQEHkfyqueFyt5NI1pdMncXE3Bx67c8/OY+XLsI2qsjOIuA+qco8reH4K8TL78nqqnGwK9UNDUhr3htDhmfWj3prD70P3lq3O/3+U7asLxmqmSKCx+LjvJkLPsp/Vce50pF+hrJ42/DY2qIyQ+4UIhtFt6Cek47FZmw0buBEn6DExA0mkLZDs6s2JWlXJ+1Jw8Pi3Ooz8BPSSf5IjteANP2xjzwgQ+5jwIgxa7RqFNwKOdVS5wBjVvgQXoA4vSzr8qwdRV5YDQ8zh+aPu6r9lp1extJTpFkJCrUmO4rTOSj4p3TOjJCpD4J0eDKXUwVDMwBv9n3U+3jmq0/1VYJqqVoD9xGEGEfAWCTvVlvjcyte+IGYyOs1RmW/RlzbTpVFIIjh7qmnSCIL3YlcazkB7FqO7BHGaiZa5Npydsz545WwDiJ+OD9cM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmxNanAzYXBqNjhuMFdMS3FhVXNPSEFyTk8rWVZOTnRvSE5WYzZHUlI0UC9Y?=
 =?utf-8?B?YVIrNW4yUWxKMWVsN0FwYnB6ZVFwWTkzNWxaQzgyMXdPd3BMYmNPc0JxdEIy?=
 =?utf-8?B?NVJCcTUvSElWb2IrVXkxWk15MllteXVyRFJhSUwyTTlzQklJbDVPVTZhVXFH?=
 =?utf-8?B?Q1J2M1lvRTc3OVZsOEZ6cjRXaHV2RUJpckhseThDMmdDTEI2U3NpWldGRkxq?=
 =?utf-8?B?NjZnWXh5VERuem8xbE1lYk9UNkN4VnRzZ1UxY2ZpSkJReDBqM3o1SVlBNjc5?=
 =?utf-8?B?OHRpSmo0YmFyWmNZK09mU0t4QmY2UXgvSVZ0UkRwYnVxRHF0b3d0RVduOVZT?=
 =?utf-8?B?RFgvU2tjS1pSMnFiUU8wN2Jtb3EwVFR6Y0ZUTHMyRDhROTdIWldUUVViV0NI?=
 =?utf-8?B?cEw4UnlDY29yckFqS2FmYTdqWTZlUGp5NnhuZHVodlVBeVhQMlhpcUpKaDQw?=
 =?utf-8?B?QkV0Slg2S2hYWXJBSnRIWGV3NS9oalJvZGYvUTZTcG9IQmljMHJlVEpOUjBy?=
 =?utf-8?B?bGEvbVRzd2hTWE8xbVd0MndQNnRWbUZVeHVBb1B1WnR3Y01Lb1V5em9LT01m?=
 =?utf-8?B?aTJMT3FJOEppL1d6UjNhWCthQXJHbUg3S3hFdndqeW1Qc0hlQzJ4MElXaXBY?=
 =?utf-8?B?ZWtLanpzQjBzTkdXeGdsUkhaN3VuS0JEQmpmWXgvbHd6cVlMZnRNbElZb1Fs?=
 =?utf-8?B?NXVTR3pOMXBkaEFHazBtaUtOaTlWYlZUb0xrUEQ3ZlQ0bFZuM2dGeHF3Qzlv?=
 =?utf-8?B?dC9pWFlZWUNPWnFiQVQ5aWJqbjAyRlJ3VlV1UGpkdlFTUXM1by9jcHpjWlcx?=
 =?utf-8?B?V0lXWnNRWnFIblRGT3ZUQ3JIS0JvbXpCZG1ZRnYva2I4bndmQU1SYmp2U0hU?=
 =?utf-8?B?NmFGSXdjTDlXQUtHVlRkNWtnK01sZTFMY2x6VVlWeHF1S2hRdG5KekVkZTk3?=
 =?utf-8?B?UDhLbzBHV3hRbUxOajlrcnhjZmZSNUJIN1lHSFF0M2ZldCtiMXF4YWdFSHha?=
 =?utf-8?B?Zm5yTWxRbVQrQThDays2ZkYzUWVmemNjSU5aUXFVdnIvaFFVcW1wN3pQU2s4?=
 =?utf-8?B?dm9XRldRUjJjcEtEVWNSY0lBUjBmUmlabTRLc2JHUFhNTTVjZmM1czk2YVU3?=
 =?utf-8?B?M0xNTEdxd1NqTmFmcXVaejhGa3NiS3lLVHF2Zit2eVhnOHRBWkZTb29wb28v?=
 =?utf-8?B?azhoa2d1UWJ6UEoyY2JUeU8waW0rdUFKL085UnFiaTU1ZmdhZUhvRTZaKzk0?=
 =?utf-8?B?aGVGRHZ1REFxQ2FVdk5HdCtiV2tXVzZycldyRzlKOXV5dUQrV3J0MXFXamY5?=
 =?utf-8?B?U0F3emhrdDFKOTdSZFBKK3dWbVFEZXdjUGhMOTdLaGgwUG8vNkJxK0x4cVZ0?=
 =?utf-8?B?dzVXUGFGTUZpSmxiVEVFVDV2NDd0eGdNU1lxdHJGVloxN2U4dFh2WHR1dDZh?=
 =?utf-8?B?eTNwTmxuK3JJR1ZDd1JsaHl6Q1dyL29lZmIvT2ExenZmY1UyKzFvQW5mTlNy?=
 =?utf-8?B?T0hVQnhpVVFWOGpKSzA3anljV29DbFR5VWg2T3J4K0NyZStuOFRscTF5b2pW?=
 =?utf-8?B?UFZQOSs0SDNGQzRsbmVBbXBmekxUZms5RE1wVEc2QS9MSkZMQXh6TTdMNXI5?=
 =?utf-8?B?TllVWm9QK2V1N2NVVlRLTTNzbFdCODhyUTBQK05yMUlJczdrT1lxYVlkdGN5?=
 =?utf-8?B?MFNmSTVFcFJmcFgzNVhBWTh3bGcwdmhkSXUxVXJ0NEFmMllGaHBEMEdMM2Ev?=
 =?utf-8?B?UTBnakg3d1M5cVNuNU8xZ0M4RE1XbmJ5eG1jLzV6NGhXd2FYdHU0enk0YXNL?=
 =?utf-8?B?Q0RQdzBJWUprcVVucCtYejkrSkVXZTFqNnF5S3BCalVUMlBNUnlLcVNMQnd1?=
 =?utf-8?B?Wk1FVmJOeThVTGZpUUNHRmp4aFk3Ym1ab2xEUFIyQzE4Skx5WERkaHBwRXkz?=
 =?utf-8?B?b0hsNEYxTkRVR3pYZ1JTbnpzWTUzeDBkZFA3SG5ObzlYeDBBVFdkM2YrYWZZ?=
 =?utf-8?B?UHBjcjQvcE1SS3FZN3ZaaEdFMzkzK1k4bTZUSUJFMjB6SW1aOVRGU1pjZVlh?=
 =?utf-8?B?Q0I4OGdoZXZqekZLWkhMN1gwVm5SSnZYMkxCdzdrZkxoZUJsdnJtem84bC9L?=
 =?utf-8?B?bnJYbnVlSXlnbmxLMU5xVHhuTTBPL2hzS1hBdUJJc2hSNFpPQ0tpckM2RFoy?=
 =?utf-8?B?T1RaUzdoS1IzSUcxbWlySE1NelMxR3pnWkxxK2I3d1hRc01HU0ZFczhtMWRH?=
 =?utf-8?B?ZXJLNDl4a0MwL0Yyckw0MlBjN1lQU0dTSHBWL1FRWGxWRVFvSEtGNWZYWnVS?=
 =?utf-8?B?b3h3a1FxSlMvWlIyaTBHdmNSRGF3Tm9pZmxodndVYTBmbDIvQkJmQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec653cc-377e-41ce-1eb7-08df2f213567
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:12:58.7561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0eBxcD1palVoGEU5UmO60dvP9A28BNQrBv8kdTaxwM28cDsJN0dG5oNIDZTr8Lwn+x7u3ocozfGsgGJoAeb/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467
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
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 7:57 PM, Eliot Courtney wrote:
> On Tue Oct 20, 2026 at 11:27 PM JST, Alexandre Courbot wrote:
>> On Tue Oct 20, 2026 at 7:18 PM JST, sashiko-bot wrote:
> 
> [...]
> 
>>> In rust/kernel/io/poll.rs:read_poll_timeout(), when the condition is
>>> false, the timeout check uses a strict greater-than comparison:
>>>
>>>         if start.elapsed() > timeout_delta {
>>>             // Unlike the C version, we immediately return.
>>>             // We have just called `op()` so we don't need to call it again.
>>>             return Err(ETIMEDOUT);
>>>         }
>>>
>>>         if !sleep_delta.is_zero() {
>>>             fsleep(sleep_delta);
>>>         }
>>>
>>> Because op() only reads two u32 indices from coherent memory in RAM, if
>>> the monotonic clock has not advanced by at least 1 ns between
>>> Instant::now() and start.elapsed() (for instance on architectures with
>>> coarser timer resolution or under virtualization), start.elapsed() is
>>> Delta::ZERO. Since Delta::ZERO > Delta::ZERO is false,
>>> read_poll_timeout() falls through to fsleep(Delta::from_millis(1)) while
>>> holding the Cmdq mutex (in paths like GspInterrupt::handle_threaded() ->
>>> Cmdq::drain() and Gpu::new() -> Cmdq::drain()).
>>>
>>> Would it make sense to keep the while
>>> !self.gsp_mem.driver_read_area().0.is_empty() loop condition around
>>> self.consume_element(Delta::ZERO, |message| message.log(self.dev))?
>>
>> Mmm, that's an interesting one, in that I am not sure there are any
>> concrete implications but I'd like to fix it anyway.
>>
>> I was thinking that maybe we should add a special-case to
>> `read_poll_timeout` so it returns unconditionally after checking the
>> condition once if `timeout_delta == Delta::ZERO`, but doing so would
>> make the `sleep_delta` argument moot so I guess that's not adequate (and
>> the current behavior is technically correct). So I think I'll
>> special-case nova-core's `wait_for_msg` instead.
> 
> Personally I don't mind the special case in `read_poll_timeout`.
> If you say, I want the timeout to be zero and then it sleeps, that
> sounds like wonky behaviour to me. I think it feels weird to have

Yes, it's odd behavior by the function, but on the other hand,
it pairs perfectly with the odd behavior of the caller. :)

Let's avoid special casing. Just let the zero flow naturally
through the function and leave it alone. Special casing should
only be added in special cases!


> this special case w.r.t. `sleep_delta` only because we are using
> constant values and that's a common use case. TBH I think it would
> even be fine to change `start.elapsed() > timeout_delta` to
> `start.elapsed() >= timeout_delta`, then it's not even really a
> special case. I could try sending a patch for this.
> 
> I'm also fine with special casing `wait_for_msg`, but personally
> (maybe) sleeping when you set timeout to Delta::ZERO sounds busted to
> me.

It's not necessarily wrong, depending on how you think about it:
"sleep, but timeout at zero" is something I've seen used (I forget
where) as to mean "context switch away", kind of like a cpu_relax().

Anyway, I am voting heavily away from special casing here.

thanks,
-- 
John Hubbard

