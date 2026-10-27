Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C18F606A32D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N79ZeVuX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7902510F5FD;
	Tue, 27 Oct 2026 15:00:31 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFAD910F61A;
 Tue, 27 Oct 2026 15:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVNiXEyTzDIrBLWDPN10HICUvUJdh7LwKVzVTc/o0H+0959j/8c3iYruwFjcvKjXeUPI2GvyL3WZzDEWKEu2XwfdiNWI1NVSw9kHs58cIuOWxcTPlt1UpdJIWBb0zeaI+utDRD++2uCnL+p5BVfU6ADC5B6f225P2xshlAqhDznNQ/LiUtmh5MwDjkCIX7E6606BCOEvn9oYhyXRajzG0jAVXUtE0Hk8Xu6hJTlUufRGuSG9iIphODKt1ivZloRZBTiMhlMuPPag93/XTCSbctcTMOdYXt5hA+d/oZvBKnW2GMtZer8R2NOKUF2FI7WBlvN56JetqCt07ZhmgfZrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pABlS6hjZixmx7DLsVt+Gh3/D2QR7yvzOR3o2BqpkiI=;
 b=xNif/K4Iy/OPNQymS7Pi+E65P76FhZFXzoWtaOUvYHmT4BkqVSQJJQ1YwcaghPimoCZjBs82w65Shs0B+gtjyhnEYIAXCqHBWeE0aB4x+3LwzPvo10xULJEflERlkn9m/KKn3ISOKH9JLbJ/X/01VfmBJqT1VvKmlBQMDw/cr+rtc9dmgCZ2etYfaUKmafyWnyRZhRb29d82KDQKwFs6sidZATyvX5nFHBKOOfbw79PgNTKn65qpov6XaY7Hy0G8qEQbIE346/Px+XAFD42xSkqEk5pJ4qzVnXPFsSJFiYIt3fXLxKu1JwCbDErIDiEkUXzbi+SC8VwZJV0TcgrZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pABlS6hjZixmx7DLsVt+Gh3/D2QR7yvzOR3o2BqpkiI=;
 b=N79ZeVuX4XEkoF0V+UavXEDLEJnueV6t55DC0hN+3WXLy0Ak5Gnb8XjjRNpQmysMacIgiaSwaeyKtCJH55y2z4RLUUrbTzu84yFmG5+Z0WC9plgBVs0bJ7UN3LojnxUIWT0jChOHeiQIWsOIRwgstiHBiaqDYM+XnK3xdytQhrA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:59:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:59:54 +0000
Message-ID: <22d66945-8854-442f-a69d-fe02726eccda@amd.com>
Date: Tue, 27 Oct 2026 15:59:45 +0100
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
 <ed2728bd-1df4-478e-9e6f-a96dfd172b48@amd.com>
 <4a7294da65c8744ba6355730e304b5250d0ca351.camel@mailbox.org>
 <d13d1a6e-bba2-4275-984b-145e0252eb0f@amd.com>
 <320b6e7c75da6f05c015e89df0e2c7d11f20d70a.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <320b6e7c75da6f05c015e89df0e2c7d11f20d70a.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7c9e24-0f89-4390-63ee-08df343af5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|18002099003|6133799003|22082099003|261026140227099003|921020|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|10067099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: Fxfcg+0D0A+KVfPGIf9Vtz+6OXu1nDn0niuTgbNlAjhcOmnuQUuQs0bU/9CJWe95T1AJ6Jy9+buFSGZaQime+JmHPGPpUi719NPS7LQNX75LseVr/7KM+ILufyB34ma3zz9Uqd61CmcRUhiVUQDc/yNy72wTNlWuSKcjdzhT92E75Y23YflrP14dURLte20RzMT9TB7G8YVolPQ3VztMq4e/ojqCmzInZq8LYxpIp9M5Jg9wjKRUR0sJvbBxIg6a43PHe+SmulConnmtAZhjWm1SbXUyaiIhwlIDYQ0+EV6TWVhP0sn/EKD+7dDrlzuf1P32bKYndiG9swCQR8vOFTaOmbJefHfLcQL4fukkMkoFI2kSwlMcEGWxBhWIGp2ux/syZW7g0AqKBUI2HVV1fTxeS7LoklulddoZKE2XSkvBetz+Voo+GnwQGTPP/Ljhafzwb6hPRFZKU2NmoDgAPr9YujGIA4cZMY+iR8Fjtvx6o0d3uU99MgkQJdSqiyo0sUmiLCVU1HvQfnqZfFhy3LZRRNvZZpIM6E+BLuHljNjPj7on7es56SQM3PhKSW/VMUZZ8iNSQ/ARiItCckyqi3YmadWrRKFLfDp+gDzVxO1K8crlBVnUeir4WnPd9973CMGXDHeWOy3O0xSf959WAIvFDoJiVHKfHze7WCotFGPSPfV2Asj9WZL5cwBAgL9oOqfEZYEHFZe36JSLwfhgUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(6133799003)(22082099003)(261026140227099003)(921020)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(10067099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVljTGgwZDN0VHdHRDI4TzRxbHBqTjIyRWNHVWhOTjZTdmUyOFVVTytmR0NC?=
 =?utf-8?B?SFJaRU5wTTVXNlFOSHEvVUJ2eFFUZXJjdWkzV1BBeUlJT3UvYUFMcjJERHRV?=
 =?utf-8?B?cWdUZms0MEVGaWpPRWFtYlc4Uk51bXVuZWJBS0Nad3NCOGhwOG9CeFd6Q0ly?=
 =?utf-8?B?SkpQTnI5a3Z2VldqbHl5M2VxTnRvblAvOE1MRUZzMnU2SDl5Q3llR1F6NVVa?=
 =?utf-8?B?NVFLR3I2UTE4cEVoaW9MRFhqYURXNzhUWmdoRTQyNlcyenRYN0lqbW0rUDBp?=
 =?utf-8?B?RTBsV1NSSG1xQXFKSExVNkFoQWVCYUkvc1k0WkFhaS93dm5GVXMyU0xDWXpR?=
 =?utf-8?B?ZFJ2V3JKUy9FekVWdHE3QUZFOHl3TE1RNWxYZUpiNU85c0xDaHVyeU1CdnVz?=
 =?utf-8?B?SnpPNU9Vb2ROM2lRV2JYMHRPM0ZpZlQxWDhBc243Z2dsNFNIWG4zMHh1YlhN?=
 =?utf-8?B?SDVRcEdRemxMLytRR0pOVnI1MWFNUUFjV0ZMR28zejdRWW1FV1dhQWVHNHBv?=
 =?utf-8?B?Y3ZtUmJEZjVOODlqak9NVnVld1VUdzg1ZWN0cVVVbVF6ZzNaRzB1Q1VFTlR0?=
 =?utf-8?B?ZTlVYU9yNVBMUzJvcm56NVpJQ085OHBMRTZnK281U3B0cTdVK1krOXhub3ZU?=
 =?utf-8?B?eHJIR2lIeFo3TnNWdkR6OE5HbEt0UGFLZlJSM3VvUUwyek1rUkdHS1FGVW4v?=
 =?utf-8?B?SWlWdS9lQXN3QXNQRXkvSG9OYlpYb2FiTEVoUjNxNUxrUFhDbnppV0NsSEtN?=
 =?utf-8?B?QlVYaGxRSWxIb2J1MndEZEpXcW5kUjliMEtCN2VpdFBSNmJ1R2llU3NYdmps?=
 =?utf-8?B?VjhEamlwM1NLS3FIYm0wd2ExWk1jUFc4YVdKN2JTVmNtTmU4N0RrSktTeDIz?=
 =?utf-8?B?SVFKelpvMTBmTHN2MVVqdzFrTFliemZCRHJwSThkdS9jeGRuOGxLdFdoSnd6?=
 =?utf-8?B?OXQySW5LQ05uOVNMWEtsZU1MTUQ5SXp3U2lLa3VpMklDMEp5dkV5OS92L3ha?=
 =?utf-8?B?SmUrSVpzUWZCL1Y5dkNpTVVva2IzbllCMDJTcHNOcjRQaGkzNk5Db3ZRdWE4?=
 =?utf-8?B?S0NHcnJ1MW93ZUJrRHoxS0dlTXRRWW1KTXNOS0wrMVRrN01GVnVueU5Ic1VX?=
 =?utf-8?B?ZDUxUjlzV053Q1ltVlRSdjB3bk9lMEN1RDl1Z3ZxblAyY1VkRTE0c3pRTXM4?=
 =?utf-8?B?a1NGNWxuWW5DdVNLSzFHMDdGT2hjRnJHazZ6TWJDQlFTeXZ4S2I2TFhNWUtS?=
 =?utf-8?B?M1NUMzMvQ01OUUU1TFNMM2FUMFYzRFdPTG41TE90Ykd3NlNrV0F6N093MDNX?=
 =?utf-8?B?ZE1kQzVZU0lEejNTOFBjeXZwSUs3TU5aYmgzOWFKQ2ZTQ1FqdmpFb251VUxm?=
 =?utf-8?B?RlRxQ05qMDRuc3ZFdms1U2paRTdYeXV5aWlhZTZVcGZRK0o3NEZwVTNuUW9G?=
 =?utf-8?B?Y2t2cmlOa2o4bWZYdlkzUGJjUGpudjJFb21HSWVSa2o1QmZjclJ6K0tUdUhz?=
 =?utf-8?B?ZVR5L1QwazdiR3YvTkovYk5kZ3VNRitCQ3lkb1NlbTg1VEVHVHBBSmpqVVVk?=
 =?utf-8?B?Tmw3YWh5cWhpQ1owMzB4TTBUb1pnaVJSNXg3b1BUQkxxL0pzaE0vcGJHOWZT?=
 =?utf-8?B?RVlmVWlmQ0pKdXNlSnBiYnFQdHNCNEpLR0JiWlFhZzJqQkdMQVFvbUVoZnlB?=
 =?utf-8?B?bkdxUzZDb1ZkbmhjR29WU21MR3RHUVBvbzl0V2dpQXMwa1BOMkdsMlM1Z3hi?=
 =?utf-8?B?ODRPd1RDbHd3UDN3dncyY1ZsZHYxaTlaYUN6V2pXaW9qbFZQeW9ZNW5WTW5n?=
 =?utf-8?B?MzZMNFRjK3VLeWt0V1d4ZS9oUWhpSm5SYld1OEdNc1gxWHVabUVnRDgwQkJL?=
 =?utf-8?B?NUpnQWQzcWdvT2xUTE14NDRUbWJLMG0xaGRqaDd0cThIakxQWWlTMzMrUXMz?=
 =?utf-8?B?RkZHaytkOXowWEdQVnJ6OWJhN1UyRXo0MEI3MnpEZ000TENTRWkxeHkrWG9r?=
 =?utf-8?B?d3h4cjh6SmluQTNzY1FiY1hIdXhYTXd5UVNvTm5HY29yVmhOQlUycnZrSUR0?=
 =?utf-8?B?OVhUam8yZmp4NVZkTk1STVdqZC9vbFJhVUV4Z1dxU1VwSmI2NjZnbk1pMUdy?=
 =?utf-8?B?RXBvc1dDQ2dvM1I2dTMyTFIvTmVxRWFRY2FreVhLeCtzMWNyWHozTVFyT3Bv?=
 =?utf-8?B?QjNseDlOZlFUTlkxUkEwSVVMZkhraVNXMVAxdDhNK1c4ZEpROHVIeVcxWTZ3?=
 =?utf-8?B?QnNNWEQ1OU1GeW9Uck1wRUU3OVNZRS93SkhyVkt3WnZUZndEWGpRRm5VRG16?=
 =?utf-8?Q?AlxWSjYoir99RHEoRa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7c9e24-0f89-4390-63ee-08df343af5a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:59:54.5350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzN4NHXMBMwd/TaEYD1LAcuT2hA2pFwCV5H4b1GVjV8/F2/Fmk5IHQHy1RoJffq3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872
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

On 10/21/26 14:49, Philipp Stanner wrote:
> On Wed, 2026-10-21 at 13:53 +0200, Christian König wrote:
>> On 10/20/26 17:36, Philipp Stanner wrote:
> […]
> 
>>>
>>> Nope, I want to protect shared data, which is the signaled-state. Which
>>> is currently a race-condition worked around with RCU (and sometimes
>>> with manually doing the right thing (locking!)) [1], stemming from the
>>> fact that the fence's spinlock is not used consistently.
>>
>> The fence spinlock is consistently used for protecting the fence
>> signaling, in other words it always happens with the spinlock held,
>> same for adding callbacks.
>>
>> The only thing which happens without the spinlock held is the fast
>> path checking of the signaled and enable_signaling bits and as far as
>> I can see that is ok as well.
> 
> No, it isn't. It makes the API fragile.
> 
> 	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")

This bug is exactly what I'm trying to prevent here.

This problem only exists because we call the backend operations with the lock held!

What nouveau does is to delegate the cleanup since it can't do that in the signaling handler because of the lock inversion.

This problem doesn't happen any more if you just completely drop the approach of calling the backend operations with the fence lock held and then re-structure the cleanup handling in Nouveau.

> 	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free of VM")

I already discussed that with Simona back then. Simona actually explicitly rejected my approach to take the spinlock to check for signaling. Pointing out that amdgpu is using the API in a wrong way.

The problem is that amdgpu doesn't track the callback structure and so can't remove the callback. It's on my TODO list every since to fix that miss use of the API.
> There are certainly more related bugs around.
> 
> Also think of the various ordering issues between signaled-bit and ops
> pointer that you and I observed.

It's just that we changed the behavior so that we drop the ops pointer and are missing places where that pointer is used.

I wouldn't really call that ordering issues, but rather something we have overlooked.

>> The problem here is not about the state of the fence, but if the
>> callbacks are still executed or not. And that is not a good task for
>> a lock, instead what is usually used for that is a barrier and that
>> is exactly what RCU provides.
> 
> Locks are for mutual exclusion. Which is what you want here: you want
> to exclude someone from signaling the fence while you are working on
> it.
> 
> Tell me one thing:
> If locking is the wrong approach, then how come it was added to
> literally all callbacks except for set_deadline()? Seems to me that it
> must have solved some issues.

Well, it's because concerns with the lock inversion brought up by Alex and me was ignored and the patches merged anyway.

This is just another one of those DMA-buf design problems which would have been fully preventable if I would have clearly NAKed that stuff from the very beginning.

Back then I made the mistake to believe the argumentation you come up here as well and so I don't explicitly rejected that approach, but by now we have strong evidence that this was a mistake and I'm trying to fix that mistake ever since.

We should have never taken the lock for the callbacks in the first place, this just made the implementation much more complicated and caused way more problems than the few raised by putting the ops pointer under RCU.

So even if it is possible to implement the backend with those locks being held I will keep pushing hard for removing that.

Regards,
Christian.

