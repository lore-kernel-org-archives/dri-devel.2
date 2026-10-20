Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A1606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bafbO6ud
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3248910F640;
	Tue, 20 Oct 2026 15:07:23 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE23110EA06;
 Tue, 20 Oct 2026 15:07:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5xhobP5lA/Ff+1ip4r+/3+HSBuADAXL3B24XZdjOEuvRbhFn/LmbLKm4sI32QaKp60qHVib+wBelF8paqkUmWkkTjo/ZYqWFGZ/YZRjnj03YbFxT0fL3q7LF6TRJfonVc0mfSksVQQYb8vTFPXcQE922hYfYrvWXat7t8D7tltg2mcbYYSF5mDFBcMaL3aRJK6nwgMU3+8iz5zJUTdHFKN03YGMueQvQYVVJ9VIq2qO9Le5s/K9x02b9J7sf+VlpnLt5gZfd5jYBVo4seWPALzB5EYZirjOXzsIBMjsBUuW9M/RRHoZGoqPGmjHBmltiMhEAnPtKuw4I234TBJ/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6HLUxKMsi37djEH/5s2JjRmTVm9gbiLogoLM8Nk5J4=;
 b=Ilb+1gw7u6Q1jOSJ4xdHx3GW0VPmIC8uqHTvS5mV0Ogg2nJGsPpze3fQpTs5xzBF7AcKirB3rvfWI8T2kuTuKkHQH1UA1/fBPaPWJSpCpSGmsfMftLPVwVIjITltCT/6B/bOXzrLAf1AWx1Cuj8YiFLWyWTwfXJIxX71RuUinko2nK2CJX3Ofm544MqYBQJ2UjpGe1+w0AEhFj5cLuaaV7aRivcbLVX4JQ3YT1S8Gjele5hQwxH1FbdkbElRMmhjIB9GZGWmMn+WxDorhsCQFquoGFMnjnUxd447Z8bXZI7LEAr0QYaUup922ikgBRnb4E9G2uELGhtdU+PievattA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6HLUxKMsi37djEH/5s2JjRmTVm9gbiLogoLM8Nk5J4=;
 b=bafbO6udna7bGpTYm/SZlj2PA8GSZdYoFFZMcUa3pFHzUWOztWepWeP3yQ2KUk+DngWaKRjlUFrF7MRD+EI62fr/kmoVVJD3xODTJ9Kjy0MAzLrrBfFLPpso19yIQSxnXcepWjOgMLA5QUAZijKOv8hikq6Pk4FcBmY3s5PcJQc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 15:07:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 15:07:12 +0000
Message-ID: <ed2728bd-1df4-478e-9e6f-a96dfd172b48@amd.com>
Date: Tue, 20 Oct 2026 17:07:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] Solve dma_fence's problems by locking
To: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20261020100034.759183-2-phasta@kernel.org>
 <3e8bc11d-6f90-47a4-ae63-cf2ff37f1ff6@amd.com>
 <ca78cdb7c24a9be9b640db782168cdcc5fe30b60.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ca78cdb7c24a9be9b640db782168cdcc5fe30b60.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb79cd9-c9f9-41a9-5ab1-08df2ebbd1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|921020|56012099006|4143699003|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: SmLSQtCBlLwwAeVRQoA3MDUuevVWomPYPGo6hMvpQVmf/dhQQFquBqmfJzZIe2emWcvyDKPHq2ut7oyxP+BrL8o81GAh43/yQl3g5LCGL12urjYFeUvM+U361/kE5BSGX3UjoXE35vdNsL+p6tQIUVsp9EfMIO/lWcLNZ71SHcORR37KM4n98KMc3GcITktvLq2AJEAs60SModD41Tu6jn11cItBLSe0NFaBSLLOjD0njhGDFNfgUFgSBL6I9TdHqbGfCnCPfbxtTfT1R+SjYr96PsTOegf38ZSutN7/0ZOMRRSXanEco0DtipnP6cBIYt2mRHYUFkXM6Ru6pO3OPeuZNEkOXrGXfoDGL7pby0psq9sWAO/htJqEY6cZ89yzt2mzR8DJ5kiBRZXxnmltB5bbGDWM8bIpPvwd9AfZKxdyP+yz/TPlox2cQm1wTRTM3Rl85A8l1XCbd7VbEHW1d/eXmhUaK5OreV+hI0TzTePH7DGRXVY0VtiF7KOkAy6dz1PQn2+9CG0VQ8EKEMGnbqiWWUkl61j3eNAKgb/LAwH0bMki056mvo6EY8/NiqV5pVyQoYRKuqR8IFp81FJmSOtldLXjFQtogrYqQmBxnglHnBxBhJdz0m+vAP8jaqnr1T0pPfgY1quEa6uPmAvyM6dCO/KsV+Cswsj5r0A6MhTOxyecUipdCqKPoIxaVwVjdSruCbd5dXv6PRRMu5iCHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(921020)(56012099006)(4143699003)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGR5ZUIxb09FdHJzVFBmVWFES1Urd2pienVFTzRPNWVCYjdsVWY5ektVVGN5?=
 =?utf-8?B?eUxzYW1Bc2VmbUpNdS9pOStmMjRBM3lpOUVuRi81Y1NZUURNUjkwNTdhc2h4?=
 =?utf-8?B?dXoyYitzREZ1V3FJazYwSDVuM2lSTGZ6dit1MkFEaUY2b05Sbi9VRnIybUVn?=
 =?utf-8?B?RDhqNXFnSjJxUFZhdXN2WGluSEl6TFhpU0NPMmdNOEczcEdrWHpGdmdkcTNC?=
 =?utf-8?B?M0RqY3B2aElRRFJsYllJZm9zeUdFNS9IaytXamZhM3F3bWY2OGRCZm5KbzI0?=
 =?utf-8?B?RlBFLzJ3RWkydGdWODFBdjhmL0twU2NiS2g1OVhWbHFwQkl4Q3ZMZlZhYkV6?=
 =?utf-8?B?ZHZCWlNldFVnaGpqQlhsekMwRCt5aUIrd3dlYVRCdlFKZnBWYmpSM3l2OXFk?=
 =?utf-8?B?YUNwU1hsS2RiODg0ZEFCSm41cWN4NDBIam1JSVBQZU1QTVlZODZtdDlEaWdT?=
 =?utf-8?B?T0tTNWpOb1JyUjQzRmdiQUEzVVlSakJhc2lJaUpuSnNNUnF5WVlGUG15UGlS?=
 =?utf-8?B?WEUrTWtwMzJMVjN4MHRza01Qb2FNVDNiRUMrRVpkdi9lemVoVTdkM2xDMXN5?=
 =?utf-8?B?QjkveXZvVmloRkFZaTkrdURYb0ovMVI5SlhiMXppZzdBWExRakM0ZlBpaDRZ?=
 =?utf-8?B?VlNydm1ReDd1cUMwRDlLaTh1NDlNbVQwM1MxUUw0S3N6L3pjb3B3T3Q1MUt0?=
 =?utf-8?B?blZvbVBzZFZuWk5GSjgrQVZFNTBad0d6ZDAzc0JLQUxCcmo5Smc4c1NCeEMv?=
 =?utf-8?B?RzVmTEh5M2ZaSDRIQ1lJMWswV0N6azA1SHNveE5pTU1QUVJpaktIOG56ZmNI?=
 =?utf-8?B?SlBoUU1mTHVsQWRXUGZQVW8yM1FWSzNIc0Q5Y1Fmckp4VXlsQ2w5WHZVZlh5?=
 =?utf-8?B?YW56Q3BCMWhEem85ekdyQjRpMDEwYUlVRGJGamNPYXpDcjd2VmJuYVJFUWFU?=
 =?utf-8?B?enIrNXBHOGtrbUkyK1lZZlpZWkNqSHVtcGJ2bGV3djR0RlBMVm9MSHFRdlFp?=
 =?utf-8?B?V1hZZDk1QktYSjhyVjYzZTVmY04ySXBLU0VCM29kbFVGQjVYTkJUVWYrOHQv?=
 =?utf-8?B?enVxY2FyVHhRbHpnVGhVWE1LQ083Zzh5OUVsOExFNFc1WTQ2cDRIc01adEtL?=
 =?utf-8?B?R1J6dzkvUXozcDVCcXRFR2phTTFicUhDdWNrYmhEY3E1RTNaRjVXMTBuQ1J3?=
 =?utf-8?B?VGFvdUxnZnVKcHNIQ1NGTi8zQUsvcndLaWxRRDJNVGt5ZHovTEk0QUMxUnJV?=
 =?utf-8?B?WFF2c3FILzUvYlRZMk5KbGJwNERuamx3em9jNGx3WFZZSVdzRW55Z1Z6enQ1?=
 =?utf-8?B?b0RlejR5d25qcklGZk9zbXJoSzNud3dVUFU0amxXWWUxTEtScjRFa2VsTVhH?=
 =?utf-8?B?L2hTM252R1ZDRHV1eDVpN3lmQWYyOUs2T3NPcWVkMGxESjFid1BJN2V3YmR2?=
 =?utf-8?B?cTM1WitwZUhISXRNM0x3N1hvcWx3cE1DM1VOM3FKSTYxdjVGN0RxSW9WRTJY?=
 =?utf-8?B?N1NPM2ZKa2drQ0J2TEttM1VuTmUvRHl5bGZSNGpTN1FDM21oSzUxc1VxbVZW?=
 =?utf-8?B?QU9lRkxwaStPeENzanRpS0JpMng1SUsrVUZBdWhQNXV0QUE1bjRDLzJwbE01?=
 =?utf-8?B?L0RnTTNickhQYnpjczdMa2cxTDg2RW1LblpoeEZqRkprT0JLRk1pQkdOK3N0?=
 =?utf-8?B?MmN1c1NTdWJnd3JzZFV4Ym5zVkhtRWc5eXoxRjRUSVlRNjYwVTZNYmVuOG1q?=
 =?utf-8?B?VlFOSnRoUnMrMGtNRTF6S2oxcDhZNE0wMS8rNm9xMlNwNU1KZk4yNklYVkE1?=
 =?utf-8?B?dGFiT01ZdkltcHlQUENuSElYUHNzNWwrWkNLaWRTQkhzRXJpa2U5Q0VadFc3?=
 =?utf-8?B?NVVmWVdDQXhOT2EvZWM0Snd4Y1BMbUljL2FteGw5ZG1MSUh0WFpSeDFtWkJI?=
 =?utf-8?B?RkZHNHpEdTdCUE90MFNVQ2NodVV4bHQ5Rm96eFVISTZwOFRRRlBNb3hXVVdG?=
 =?utf-8?B?aFlrNXpXSnRTdkI4M2IyckdUMGg4WElDVjhBbU80Vkt5WTRQYVIzeWt0bVdz?=
 =?utf-8?B?dFRIKzZOT1pDRVVvcWZSQ0wvUm80UmRQaTRVSU85bStEYVdOL3E4ZUFOYVhl?=
 =?utf-8?B?QkdaN2NXTHEzanNSNGxXaEhRcWcxa0ZXamJxcGJxVU1tK2NCaG00OEp2NFF2?=
 =?utf-8?B?VDREYkkzTzgrbng4T3R6cW9td2s4c2cwTlExbWhPVGwyK24wZ1RuUFFxNG1F?=
 =?utf-8?B?cWRUK00xQi8wT09OdGFzTE5Qb3JaUDZBZ2kvUEdacWFZN0VwNERyZmJhR0Nt?=
 =?utf-8?Q?ose1TUiYHyZ8YQRaJg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb79cd9-c9f9-41a9-5ab1-08df2ebbd1ce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 15:07:12.5000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ni8T9rhHD8WShv2SYRoGGwaw7gW7ILlIAedGD9p/Di/XzvdHXYvMJV5dO9OXRS9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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

On 10/20/26 16:41, Philipp Stanner wrote:
> On Tue, 2026-10-20 at 14:02 +0200, Christian König wrote:
>> On 10/20/26 12:00, Philipp Stanner wrote:
>>> In our Rust code bases, I'm currently experiencing what we also
>>> experience in C at many places: that the dma_fence contract's RCU
>>> requirements make the API more fragile and put an unnecessary burden on
>>> the API user. Most notably, in C the API behaving correctly now depends
>>> on the API *user* waiting before free()s, waiting before unloads – all
>>> because dma_fence is not properly synchronized.
>>>
>>> The patches commit messages give more details about where I want to go
>>> with this particular RFC.
>>>
>>> My rough "vision" for dma_fence, where I think it should develop to, can
>>> be described like this:
>>>
>>> 1. All users should use inline-lock.
>>> 2. The fence-signaled state should be our decoupling point.
>>> 3. The fence state must be consistently locked.
>>
>>
>>> 4. This means all callbacks are only invoked for unsignaled fences, and
>>>    the fence cannot signal while a callback runs.
>>
>> First of all that prevents concurrent execution of the callbacks
>> which for a lot of use cases is a must have.
> 
> Currently only set_deadline() can execute in parallel.

Especially the is_signaling() callback is executed in parallel by tons of use cases.

> 
> IIUC in our past discussions, your wish has been that the driver can
> take its own locks with free locking-order in the callbacks.
> 
> Thus, the callback is invoked under lock in any case, just a few
> instructions earlier or later. Thus, no callback ever truly executes
> concurrently.

And that is fine. Taking the look when you actually need it to protect data structures is perfectly correct.

But what you propose here is to abuse the look as a barrier, e.g. to find out if something has finished or not and that is a completely different story.

>>
>> Then as I pointed out before the second problem is that this again
>> makes the existing lock inversion between the signaling by polling
>> and signaling by interrupts even worse than it already is.
> 
> We asked for examples in our last discussions, and the only one ever
> presented was the list-access requiring the fctx-lock in
> nouveau_fence_no_signaling(). Nouveau is often not a good example.
> 
> Can you provide examples in the kernel where deadlock would occur?

Just exercise the simple example of a driver supporting both pull and interrupt:

Interrupt: Handler takes lock protecting a linked list, finds fence and signals it.

Polling: is_signaled is called with fence lock held, can't take list lock and so needs to work around that somehow.

This pattern repeats multiple times all over the different dma_fence implementation. Nouveu is just the tip of the iceberg, we have cases of this in amdgpu as well as i915 as well as XE.

> Note that I pointed out that all callbacks are already invoked with the
> lock taken, which proofs that it's doable.

Again, no it isn't. The shared lock was invented exactly because drivers ran into this problem.

The common pattern is the same, implementations just dance around the fact that the callbacks are called with the fence lock held by delegating cleanup work and/or using lockless containers etc...

A common component like dma_fence should never enforce users to do such workarounds just to solve it's own lifetime issues.

> Future users with inline-
> lock could employ various techniques for dealing with the lock-order.

And that's exactly what I'm trying to avoid.

> 
> Only exception currently is set_deadline(). The only user, MSM,
> acquires the lock manually and then nevertheless triggers work on a
> kthread, examplifying just one technique.
> 
>>
>> What we could use is an SRCU, but a spinlock or any kind of lock is
>> clearly the wrong approach.
>>
>> So as far as I can see that is a big no-go and we should really just
>> use RCU for everything and remove leaking the fence look into the
>> callbacks like I outlined before.
> 
> Look at patch 3. We might want to add some legacy support for shared-
> lock, but it is evident how much more simple the code gets.

To be honest I don't think that this is simpler at all.

Regards,
Christian.

> 
> Also:
> 
>>>
>>> Point №6 means that this:
>>>
>>> dma_fence_lock_irqsave(…);
> 
> I even forgot that you also need a
> 
> if (!dma_fence_is_signaled_locked(…))
> 
> here
> 
>>> dma_fence_set_error(f, err);
>>> dma_fence_signal_locked(f);
>>> dma_fence_unlock_irqrestore(…);
>>> synchronize_rcu();
>>> kfree(driver_foo);
>>>
>>> should simply become this:
>>>
>>> dma_fence_signal(f, err);
>>> kfree(driver_foo);
> 
> 
> :)

