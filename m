Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F55606A339
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sJ+xAG+1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA3910FDB2;
	Wed, 21 Oct 2026 11:54:05 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010060.outbound.protection.outlook.com
 [52.101.193.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6901510E04D;
 Wed, 21 Oct 2026 11:53:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdkT54/qRMbDl0RvATfcNfOYZaG7+hkyqIq7KsFKD+CBZi0ds3CwH17VZOPY7C83Zx/f5NNLdEf0mRjwVjXxWm+s0WIEmWyuO8Gp5OnX80mzoj6vAAhPQaiFB1cLwQJKPfjkb8n+8XVbbDgX3Yxt1mKl9dEEqQABu1PDVEH8G27BHYUYjMMBjciLsYy+SPUZct5tUXBZkdWswoxUhUUVnvkVdPYz3iDotZ9jbcRzTYB/C97TsZyyx2pW6GaOhRoUFBDHQuHJBnL7yNs486wXOj3rQGeNLORvUWGVIfV87Oa9Q0EE3bPg3d+sm4sunN2qd5HcU6gIn8eRJ3z1JXlspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cm012yYJ1YIdCPrhsc0eeBUyJixwaQrBU038SefJC8I=;
 b=W5t1QL36EzfT7WDKxDaIDNKB2kVuy5+ez8mE0n7GlNrOo2BEVEgtxxHorEXzfjIdnXJ2lPgcC5/gh5Dla478Yg3GQ0QVT4Q03Fs3KFZSfDiNxNYpeH7Mu8Sv+V8AuwTGikR47/hmREMPjRltdIGhEglW/vo/z9ZhXmfdw8knJEMvO9ezR/nTcXy04g004ZAyFZWtHtqzJSLPhBDxYz1gGm/NtW1CsTXcVnRbKvHAawJDmq+pJqE4Wv28BR8uKGfsTav7a9VTw+mKHrHWDZIFpOzUSGwre5wNCtSK59acwIh4Pcnd9lHYyIurwpTG1M/LF+jpf5/QhZmiqSC5P1cx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cm012yYJ1YIdCPrhsc0eeBUyJixwaQrBU038SefJC8I=;
 b=sJ+xAG+1vZloEEnvoTWE+nwQ0sD4Ijic/82tFpQUyHh1ZoGoSzV1rWOFP9nqcwEolghyk61YiS9Le6oLSZoDATqnaaqbMkcbYqlqeavq0ar9ZprEMy786Lg8M0u0iaR9MR/XvGcPeCAZm3h9rqk3EjNuIIZUNUeT7azu5aWbz7E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 11:53:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 11:53:54 +0000
Message-ID: <d13d1a6e-bba2-4275-984b-145e0252eb0f@amd.com>
Date: Wed, 21 Oct 2026 13:53:46 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4a7294da65c8744ba6355730e304b5250d0ca351.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 0753fa10-db99-4ac6-5e5c-08df2f69fb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|11063799006|5023799004|4143699003|921020|56012099006|22082099003|6133799003|18002099003|3023799007|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 7SiMbu4G1LKl4DIqVZcHjV5c6fPH7oCYDYbCfkhZreXKNDlVm89t2epihglQWt0yKCqAGHcv2PMUXCBTcBwzrnEKwsZZf6HpooAqQnruD+k8K5eQhvrE3B6Cz2Rejqf08le9KGtIEkYLVXxNUNY6xeRjjFTIUkdkB5RTksuvYCFEJCFva5U/yIG8pZkJp69ukekN+mhSZFsZ0n32qEFzu8SsQvuYMr3j9qEu4icIgoMLs2++MneS5idRfqek2Q2c1z4pZ/lllcXuDNfAoRTsWcvvKyAcugin+w6G//EdR9dxPlrBxkdLWZpL/IXJpc5iBWVPjYIZjY4CFWNN/HoKyC8j9bSc7a8+KV4ncqxrQ8SOumomRatdUh5IJku6fgdZcSJ3wzJgg+8AwfDnLRm1hGBnVsZS2vXAK6oNYW/8BPB5EPrz2ORItfpP94+vxmwtla/SKHeRKWBinaEe33JB1IelN5huP1aruxNQhLUh1UE0je3+eSACGr/dqCGJes5kDXmOT6y6e/bG/ne0Y4e69h9WyBGBednPkEQCMTglBW3wn3J5JAVPcIURlaa2o2kojkx0xJCS9NUdTjGXoZcCZ6cQxGAdq93tDjNOjdjUsq3UqWkzkf+gH13Ybm0l8k8ng+NpLboohRzvGwWwqutgF/EmBIvJVVnE/x5cBDTk9X8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(11063799006)(5023799004)(4143699003)(921020)(56012099006)(22082099003)(6133799003)(18002099003)(3023799007)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YSt6VExYUkZrQ0pkQUJ3Tm0vL3VJZktqeGh4ZkJmZ09ud0p4ekhSRmJTdzkx?=
 =?utf-8?B?TTNUKy9tSzR6bGJ5NXdxb1pkR2ladHU3WGFxSlFPc0ZkQVM4OUphdWsyQ0lW?=
 =?utf-8?B?Uld4Wkx6VWxSNDJJb2FQSWZrb1lDTU9iVnRmVk1GZWxPN29zSTdjUHIzYW5t?=
 =?utf-8?B?Q1VvQVk2RkZKTUZKd3IzRThUb1U0dlduUUFsNmQxWWJPQ2VOdmtNbW1HQVdh?=
 =?utf-8?B?S3dWTkwvenQ3Mm00aWk5emJoR0kxQlFwellKM3RseWV5aWNSUkN0d25vaG9y?=
 =?utf-8?B?VElBeE8xUXJrT0VUUjJLbm92cWh6OEhjZGpmMThRdk11dUgzUGNCbVpFZWFp?=
 =?utf-8?B?alFrRGJ1b3BFN2E5RTVoeUVjbmcvSXdyTkJKeHhoUWZGQk1yM1NuYXU2eTBQ?=
 =?utf-8?B?RDA4YnRWUURScUxBZ3ZBanNub0NLZXk5QWg0LzVUVlVDcGEySmVFWXlTQ0g5?=
 =?utf-8?B?Q1NjUTBuNlFaUUVNTG5Md1ZhWDZyN1pBSnh0anYzeEgvYXBFMG5vUXJsMUNs?=
 =?utf-8?B?SXcyVUNFSEM4WlI1NWk0MGo2L0dQT2F5WUZETXZHS2ttelNRbkUzYmRKakgv?=
 =?utf-8?B?blVMOGllOFVrVFRRd1NmVmRsQ1E1b3JwaUw0S3ExczlpUDc4S0dEWlR5V0s5?=
 =?utf-8?B?NTF5OFlqMk9lMnFSTktQTDhrclBkaW1lNVo3WGorTWtGS2hYMGJVak1Wank1?=
 =?utf-8?B?d3J6ZGpsUlcvNWdaVndvYVRUdVF4WHFsVE4rRUU5UDJqWjVDbS9DUk9JRDdX?=
 =?utf-8?B?cHFoZHVqV1g3YkttSlhiNkRXTGlkT1IvUG9pMUxvcHRBaldmZERpY1AwSlRy?=
 =?utf-8?B?aGxacTlvRVNJakI0OFVOVnVhb0FrUnpXN0JrSzJlUmM2dDROYXNyRm1TbEZm?=
 =?utf-8?B?N3ZyRmxjbzVKeHZJR00wQ2dQOWhNYlFSWGpTdnhyVEtpZUwweS9wdkVBeHBJ?=
 =?utf-8?B?cWJMWm51SUtPT2pnTXlxUyt4QlNyU2FWY3JiS3VDdEVtbU1kcGl5bzNzTzdv?=
 =?utf-8?B?UG4zUVl5eVg5cVhWOWZwRFhndHdBTXBUYndnOENuUk5DeXVCaUtDa1ZocVlD?=
 =?utf-8?B?VHBKVEltTE5KZXB0WStuOHllVTUwTVA5TmJ2QlZiZXVBZG15Uk1HbnNSckpP?=
 =?utf-8?B?K2Nhb2l4dVdHZmhNNElPbXczNjFYUWtUd1VIKzI5czhlc2huc0YzcFl4S1lC?=
 =?utf-8?B?QncwblFJOUV4RXI0dW43RHBidEhaRkZIVDlKRUxBUVJERkI0bUh1b3BDU2o2?=
 =?utf-8?B?RmZMOWJxMnJMWXM0bEFvelFFQnZPZTc2Rm1HVUJ4MTdTZnhMKzVwWjF2QVhu?=
 =?utf-8?B?TjhhRGwzbzBSM3RxOW95cC9xZlIwV0RJd1hnakNOaVUyY1MwL2tHSGhEMFFE?=
 =?utf-8?B?blUrcWV4Z3VGbURVbTlPc2RZWE1uZlFaOHJ4OGJBazhicmUxUHQ4YzZxQW1j?=
 =?utf-8?B?TVp1N252SmhLMXVCRkRXbmZNRnpscHdWSmNweVNxcVgwUDk0MHBUTDFsZVlw?=
 =?utf-8?B?aDNWcmt0blA0NVZTeUVKaElvdncveldUNHIwYVFmZTI3R1ZaTFl0QWtkOGIy?=
 =?utf-8?B?Y01RNG4xSjU2OUYxb1oySlJ2MlhURUlNTkRSUnhYYitCRkZyaE9uMW5iTkFQ?=
 =?utf-8?B?MTJvZklQdXAyTVdaQUVmQXpuR1NNM3drRGZ0bHkrZnhTa054cjdtL0pIdmhL?=
 =?utf-8?B?KzhwVDFPOC9iNmRjeW5ucFZvQ3V0ZU04MnBIeGVMcHpzdGpZcUplVEllWC80?=
 =?utf-8?B?b1BVNHIzL2R2dWZ1cUY3V05LdUxrRlRkbDZSRUZaeWJ2czEvQmlwTWV3cHBr?=
 =?utf-8?B?cXlIaTlMZjNXYy91YW5pbFJTM2M1aFVxejZ2UWVrbFlvd0NOTE9KR2hnR3Fn?=
 =?utf-8?B?eTlFVzBIQkZsL1cvK1JVWmdYT3IzMVV6QlFJS1AxTXk0M3VYSUlKVXZrM0Zz?=
 =?utf-8?B?aFJiOWxmZ2ZiSjVXZEtqZHl0M1NheEJkeXFHNVNhaTVHU1V6RUIrV0dkeXhj?=
 =?utf-8?B?Y3pwUU1rQ3JSczRWamhQakN5RE1OUDFjMDRYTHlIWVEvNTF6UGlWZmxidFdx?=
 =?utf-8?B?Qng5QjlsODNwTTVMZ1Z2cFBubEY4eGlDL0xRM2dFcjZncVpZaHgrNjl1c0xP?=
 =?utf-8?B?U2lITGhVQ0Z1M2VhNy85QUhGdng4aWh3YzE2a09ENTNMb0VHQnA5VTI4Q21z?=
 =?utf-8?B?TGRUaHJIVHR5b0IxbzhvNEI1bHRBelc5L2Z0VC9PWlp6RkRSMTQwSGllMVZs?=
 =?utf-8?B?T1UxNG53N1JMeXpGMmhQZTVpeStSR1pQeUlkdHJ3RU1BREkyS01DTmVXcVl6?=
 =?utf-8?Q?2VCx7LUE2PSGDuLdm+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0753fa10-db99-4ac6-5e5c-08df2f69fb5b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:53:54.6789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUDQjL1TyLidFlNT050/ppTt3ypgXVHerC16SFkjWE4C/a0M9SfwqticegPsr5Kp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510
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

On 10/20/26 17:36, Philipp Stanner wrote:
...
>>>> First of all that prevents concurrent execution of the callbacks
>>>> which for a lot of use cases is a must have.
>>>
>>> Currently only set_deadline() can execute in parallel.
>>
>> Especially the is_signaling() callback is executed in parallel by tons of use cases.
> 
> ops->signaled() you mean.
> 
> Anyways, only one will succeed at having the fence marked as signaled
> anyways, and then all other callers of dma_fence_is_signaled() will be
> guarded by the fastpath bit-check (which btw is also broken; but we
> want to address that in a different patch. For now my series proposes
> keeping the fastpath).

What should be broken here? As far as I know the signaling path works perfectly fine.

What we have problems with is the lifetime of things.
>>> IIUC in our past discussions, your wish has been that the driver can
>>> take its own locks with free locking-order in the callbacks.
>>>
>>> Thus, the callback is invoked under lock in any case, just a few
>>> instructions earlier or later. Thus, no callback ever truly executes
>>> concurrently.
>>
>> And that is fine. Taking the look when you actually need it to
>> protect data structures is perfectly correct.
>>
>> But what you propose here is to abuse the look as a barrier, e.g. to
>> find out if something has finished or not and that is a completely
>> different story.
> 
> Nope, I want to protect shared data, which is the signaled-state. Which
> is currently a race-condition worked around with RCU (and sometimes
> with manually doing the right thing (locking!)) [1], stemming from the
> fact that the fence's spinlock is not used consistently.

The fence spinlock is consistently used for protecting the fence signaling, in other words it always happens with the spinlock held, same for adding callbacks.

The only thing which happens without the spinlock held is the fast path checking of the signaled and enable_signaling bits and as far as I can see that is ok as well.

The problem here is not about the state of the fence, but if the callbacks are still executed or not. And that is not a good task for a lock, instead what is usually used for that is a barrier and that is exactly what RCU provides. 

>>>> Then as I pointed out before the second problem is that this again
>>>> makes the existing lock inversion between the signaling by polling
>>>> and signaling by interrupts even worse than it already is.
>>>
>>> We asked for examples in our last discussions, and the only one ever
>>> presented was the list-access requiring the fctx-lock in
>>> nouveau_fence_no_signaling(). Nouveau is often not a good example.
>>>
>>> Can you provide examples in the kernel where deadlock would occur?
>>
>> Just exercise the simple example of a driver supporting both pull and interrupt:
>>
>> Interrupt: Handler takes lock protecting a linked list, finds fence
>> and signals it.
>>
>> Polling: is_signaled is called with fence lock held, can't take list
>> lock and so needs to work around that somehow.
> 
> signaled() neither needs a list lock nor any other lock.

I don't think we should decide that inside the framework, this is up to the implementation of the dma_fence backend.

By taking the lock for the callbacks we just move the complexity of handling from the framework into the dma_fence_ops implementations, and that is something I would *really* like to avoid.
> It needs to read a sequence number from somewhere, so a u64. And then
> it returns true or false to the fence_backend.
> 
> The u64 can easily be an atomic. Also ioremaped reads should work
> locklessly.
> 
> No need for any lock.

It is perfectly possible that you need to take whatever lock you want to cleanup things. E.g. spinlock for list removal, common lock with the interrupt handler etc....

That's also why I said that the whole approach with the signaling and enable_signaling callback returning a boolean is broken.

Instead what we should do is to forward the requests to the dma_fence implementation. And that dma_fence implementation calls dma_fence_signaled() as necessary.
>> This pattern repeats multiple times all over the different dma_fence
>> implementation. Nouveu is just the tip of the iceberg, we have cases
>> of this in amdgpu as well as i915 as well as XE.
> 
> I guess my question then becomes what complicated locked tasks someone
> has to do within its callback that locks are required, locks that
> cannot be partitioned in a smart way to avoid that.

Simple cleanup tasks, like just list_del() you need to take a spinlock for so.

> 
> We have 3 callbacks that are relevant and not deprecated (the name-
> functions are trivially solved by copying the data):
> 
> - is_signaled() ⇒ solved, see above
> - enable_signaling()
> - set_deadline()
> 
> The latter two might want to talk to their hardware, either enabling an
> interrupt or telling it to clock the frequency up (see MSM). They might
> need a driver-lock for that, fair enough.
> 
> Where does such a driver-lock need to be held while operating on a
> fence, opening the deadlock-path?

In the interrupt handler.

> Note that, as I pointed out many times, all callbacks are already
> called under lock-protection. Especially enable_signaling(), and
> is_signaled() must be lock-resistant, proven by
> dma_fence_is_signaled_locked() existing.

Yes, but we clearly want to get away from that.

See the calling order in the interrupt signaling path is driver -> framework.

While in the is_signaled/enable_signaling/set_deadline path it is framework -> driver.

The dma_fence framework solved this issue by using a shared external driver provided lock, and that lock is then taken before calling into the backend operations. But we want to get away from that and use an inline lock in each dma_fence.

So the only two possibilities I can see is to either call the backend without holding locks or force the backend operations to use a lockless approach for their internal handling.

> Regardless, what I propose would only make a potential difference for
> *new* users, with inline-lock, who can then cleanly design to avoid
> locking problems.

Yeah, but I'm desperately trying to avoid the complexity of using a lockless approach in the driver implementation.

Just take a look at amdgpu_fence.c and how complex the RCU handling there becomes because of this issue here.

Or the dma_fence_chain and dma_fence_array containers, same problem there as well.
>>> Note that I pointed out that all callbacks are already invoked with the
>>> lock taken, which proofs that it's doable.
>>
>> Again, no it isn't. The shared lock was invented exactly because
>> drivers ran into this problem.
>>
>> The common pattern is the same, implementations just dance around the
>> fact that the callbacks are called with the fence lock held by
>> delegating cleanup work and/or using lockless containers etc...
> 
> I suspect more that drivers attempt to do unnecessarily many things in
> their callbacks which are not supposed to be done there.
> 
>> A common component like dma_fence should never enforce users to do
>> such workarounds just to solve it's own lifetime issues.
> 
> Our common component forces all users to take our locks manually and
> plaster everything with RCU. If they forget an RCU delay, outside our
> API, things explode :(

And I still think that this is the simpler and especially more defensive approach.

The dma_fence framework should not leak it's internal lock anywhere externally and that includes calls into the backend operations.

Regards,
Christian.

> 
> 
> P.
> 
> 
> [1] https://elixir.bootlin.com/linux/v7.3/source/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c#L2787
> 
>>

