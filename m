Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A88E606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p9IMTTmI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BC410EB1D;
	Tue, 20 Oct 2026 12:02:54 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013016.outbound.protection.outlook.com
 [40.107.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1FA410E8E7;
 Tue, 20 Oct 2026 12:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n671J66i9hvc9U3qj+/t2j+7udiRmcq7jJeMLOAgB5LrjsE3oFDeQGP6tZiaON7t76vMmsOM447Ah16rN3pLI/qPKEz3/8hZbuta7QimqumlpnYfzVnR0xqs7RJ8X//IjZPCdgPbalVBIBYKbK/7B4GSQ23/k2LVX05o5F0u30MQ2qOICCQKPUhqWyiwtVR8TFHeR4x2oxWLRKC18NHRUSqmsgqfzf5eXAZ2ie5gAaeZGpxNJsS7h8VQczyK4CdFo4y4Ca/m15H7jbKIftjV9SxItatQSiHcBhV5XZyGM5GgcVvsNTdL0KNbKkKYIRr+/N4DkCjKOhRGLdM87zs0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSZ1F4X6coN52T7MOXjo53+xj/9nzGuJ/iy5Vx6vPEg=;
 b=rzR471RNEm9+p6KDCcZ3Xowzwo1bUMTBV71EAjIsqcvTvS4IydXfTGVS3iFosQkdyPaW/tqS4lqUuw2XF4yhzGRxPYjvR/XEhMZFyuFIbxXM+lfwy/pgS0YdTIqi+1RhnkJHdF5vyTLEFpOqBVqyeoC+8o7YXtUAosb3gPBdJMIkW7LkjDWNB8mgTJJ3cRr0YcmVNX1Qdj2BzRKWNI6p0/KhMnYszi4O69/L7uXn47pqCoa1cAqkZQXbfZVJfHsp/P/zFjQJ5193EbcalwePNIg0NGXe4fiusebcgOnVMEb9tNxkJZlitapW+Wh3f2dsLtwlsk18XiZcwqCaCzf71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSZ1F4X6coN52T7MOXjo53+xj/9nzGuJ/iy5Vx6vPEg=;
 b=p9IMTTmIFaimUH7FaYcSE+pr31b45Fo1RnFxzLN18J3bSUWulwOexMoNVbJ7GgxxabrlV1iS32PImnCoLrc5OEds89fUchYlqnEfLZB4KGiQAW2/PVecRT+zVgePVWt256roeAGXiUvMhFi0Y5FvCJIn8rWirlGA7eQqMDRsiro=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 12:02:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 12:02:40 +0000
Message-ID: <3e8bc11d-6f90-47a4-ae63-cf2ff37f1ff6@amd.com>
Date: Tue, 20 Oct 2026 14:02:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] Solve dma_fence's problems by locking
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261020100034.759183-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 88086a99-ab93-45c9-997e-08df2ea20a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|5023799004|11063799006|921020;
X-Microsoft-Antispam-Message-Info: 2mmuSQtNgzgmHyV4lR0RjpRTw95AMvAvSYc5xHaDHELyoYRe3KwHPdi47CY7Kj2iIgw6620WXYGES5EjEXtBVnuYe63MLfzPu1puFov78pyIu0kcFKkkcrEoxyVlmGcsX6R0mT19RVt8X9Cl/EJY/jJt5WD85OTiMpM5NuwnHRZK2bhZLll+2W3xJzf8lp55WTCN/QB+IhMW/TTAy3ROA7WGqQGjZCd9w/rXxvcYnXUlNSjc02ox2AiplZE8fQAbGKkdMnlGKKDAUlCcv+2NnDbLrrZ1bcmJQ9mHdy6Y4sdxX5nliARaqjgzShiItS6y5Ahtzg+XRjBsVtfo5MJw++qDOOT1NGmfo8ltLg4sY+ktNaG9gWbnraVyeLPvMMlwFvdSbev9kv4YVU4ByuZlu8yQUq6I+rYjPKbRfbmZnRgXGzKFJycCz+GaFAnudFHUL6LJIKhYakJhUo8q+lzFp28i7jr805jjRe8BxVi1JLslo2GheZ8kbwAzX0J0xvbQUOEw5IPOE/mbYkS/mpINXnBPyf6vOdLXnQ/Dkxt2ziAm2aS1DBOoKt0kFvIdFK90Y+6C9LHxVMiFjujlRwLHip5e9EyVe0e5JwLpFEGl4OFYAMqygDRpmny4z3VjWxZajxF7+/lGcED7ltwRtURuq1MYBpBtIkI6KGh970FDRqly+DituAG3i7OMXiQvR/3nEEzrcHmD6fHE4AH0PWDI6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(5023799004)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnBXc2ZaU1JjelUyM3pEMTZ4UENLeUVjYVV6ZHhWZ2IzOEY2dVlwcFhzNUhI?=
 =?utf-8?B?L1FMaFZxeGY1NGVJL1ZDNHBDbW0rY0NmN01OZ2JZREFUeEsvTVMrS0lzVURN?=
 =?utf-8?B?T3kwSmdjaUV0UGIrSldIdGZTYzVJNU01VFVhVGl3bHJlNjZDL0k2UW9UU3d4?=
 =?utf-8?B?MlZZVGtmd0krT1VjUnhlMmU5dzE4UXJqNFZjM2dlR2xSZ3NCdDNnc3ZMMnJv?=
 =?utf-8?B?Mzc4d0VRS2dYRUJBUGo3OWZFTFhMemZabXhGa3BZcjFTMlFvb3RrRzhXWkQw?=
 =?utf-8?B?QUxYV0VhS1BPa3lsZnhvN0VERk1DTm1INis4VzFFdWhENGdsbkIrR1ZIWStv?=
 =?utf-8?B?a1hEMFZVdVA5SWcyek41UTR0WXhvY1k2bituQWswZXBKUjdYaWZNRkowVGxK?=
 =?utf-8?B?dE9GU1Z1aEFURmdyQStZUDhWc0VKTFJRdi85eUFkZUJMUnpIcVo2U0pnVXh4?=
 =?utf-8?B?ZFhsVG5taXJTUjBoOUk4d29hVGlBckJvSytMS25UcnZ0VEpLNmlEdGt2NU8w?=
 =?utf-8?B?eldjZy9uQWNwSkgvUnZPNHpXQ1Qyc3lXc2JSNUVYb3VVdmFuZ3FEQk43Nm1G?=
 =?utf-8?B?aDlEdjRIN2hYODZRZVh3MTJBOU1ROEwxSVdObENyK3lMMmtlemJjZTF4NHN4?=
 =?utf-8?B?dFVLbmtOZDFZMFE2bEx2ZFkzOTJCV1M5dExDa1ZzcEdOaE1rTWl4c3ZkQlFi?=
 =?utf-8?B?NTl4Nzl1VGtzSUJxYXRqelMzVkwvRUlnRkVDU1ViUU1ZMnk5TzJqSU1vWjV0?=
 =?utf-8?B?NWNRTXZuRkc1ZmVHZm9pd3E3RVpVRXFXbmtDVDRrb0hDOTlLaVUzRGJXMGZP?=
 =?utf-8?B?Ym9YeTI2OTBUVjRzdFNobUdVUlh4SjVxUzViWWJLREZtbVFZaENqb2phbWxl?=
 =?utf-8?B?TzhhN1FiQ0hBVG5XdEFDWEtQaHFhOE1XR2JyNG85dUlZam1TNjhVNGZ6NWph?=
 =?utf-8?B?VnQrU28ySHE4S0JkcldGR0I5OGkxWDRGa0xPZVhWRHhlekhIRWpxMHoybHFy?=
 =?utf-8?B?empoaHlRdjJ5dHdZUXEzQkJDQkFFdGVCNUIrOFdnZ3ZGcXhoaE5tOWRyMmQv?=
 =?utf-8?B?R001N1Y1UlZ2T3NPNjZESlM5a0JaS0Y5dm9SUDJKMGVieVZCT0tGd0w4Z0dY?=
 =?utf-8?B?WFJCRUk4eFJEbEZpRWdBQUxIM3ZvUUNzQUdaZ0Z5SlNrUGtsZXN6Y1NBUjhi?=
 =?utf-8?B?K3hBNEh3ZVBLZzQxMVI5ZzlMYjEvaEg5KysybFVBTlQ0YjRBTkovTFlsRFpL?=
 =?utf-8?B?Qm8yZGZGdXFaYzdWemdUaTJmTkJUNlhOMlh5ZWRWdW4xMTdZWjZ5OTZKdnUy?=
 =?utf-8?B?bnNZWktCbklWTHgxM21Ed0FSV2VZQkdjcHQxZU9GNmZPZHVXQzIrUGlXZzBE?=
 =?utf-8?B?UVJ3SllMYi9lb0Rab3pHcEZYeTJGdWhFWGNYWGQraHlFbmdKZGgxa2lUVzF6?=
 =?utf-8?B?MThuUEtiMm5CL2JuUFBrbjA0NDNsUnVlWUttM2w0QXEvb09yeUozazRubDZv?=
 =?utf-8?B?M045V3g0WkN1SDBaUXhGL05aMzJqSktpNStQa0ZkYk9oQXVZaGZYa1lSTVNh?=
 =?utf-8?B?RzkzclRFTndwd0hEM2QyNGora09Sb2RCVGJORDJmUDV2b3pxSzc4ZGozVXBP?=
 =?utf-8?B?cFBRZlRobCtaVFp2Ukg2S0piZzEwNGcrWmhvK0JsREFvUW5QUURiZGpHUXIy?=
 =?utf-8?B?UmhxSXJ1anFCRjRaVTd5NGw3WEU0aGI3cEVhTkdrK0dscFVlSHBhQTRxbEVn?=
 =?utf-8?B?eUlidUN4aWxIMU1kSVR3RlZSUmNLUmRZZjVSKytLR3BZS1BjbFdscHpOL0NW?=
 =?utf-8?B?Nm1qakp3SVpFQWs0TzVMaTk0M3NVNzlGZWRId3ZMLzFibjJSNnpoTEdBSHV2?=
 =?utf-8?B?S0IzL1Z3TldOdVV4SWtWcVBnYmFrTVl6T2R6dDZVRXhYY2VqVlpGeGgyNTA1?=
 =?utf-8?B?cEEzSjdRZ1RETFpWWnVIejc5Y3hlSmk2b0RNRzVETmZTSnFyOEs2QjRRa1NG?=
 =?utf-8?B?bFdnajk0MENIeWJHNytMb0E3WDVBZ1NQd3p3R1FFWWJyc2tSak9INHFLN0U0?=
 =?utf-8?B?eTV1MEpyQnF4am95ZmFGTmd3MklpQmNhb2VBbGNjZExNRGRuUjE3WDFCbE5E?=
 =?utf-8?B?eS95RGZua21SOE9sdXMwMnBPQmlTeFJ5SHNTbTFUTCtUM1c5d2gyNDNlVVNJ?=
 =?utf-8?B?azloZ1JuSGRTakJvaFk4WVJyNkNqWHc0blFIN2JjZFlyWW16UkdDRjVBY0hX?=
 =?utf-8?B?b1ZwWEI3MW9pQUdpRkkwTXFvaktiWEo1TC9ZU3hZWjl2citJSEZDaHJuN0pM?=
 =?utf-8?Q?Bfq2HY3ckYctOpV8k3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88086a99-ab93-45c9-997e-08df2ea20a05
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:02:39.9065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSBHYOF5aEWjoNUABcEgHiEnKgsTWu987F44OBuoLBRBAYh182mbky8aJOYZgaDG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 12:00, Philipp Stanner wrote:
> In our Rust code bases, I'm currently experiencing what we also
> experience in C at many places: that the dma_fence contract's RCU
> requirements make the API more fragile and put an unnecessary burden on
> the API user. Most notably, in C the API behaving correctly now depends
> on the API *user* waiting before free()s, waiting before unloads – all
> because dma_fence is not properly synchronized.
> 
> The patches commit messages give more details about where I want to go
> with this particular RFC.
> 
> My rough "vision" for dma_fence, where I think it should develop to, can
> be described like this:
> 
> 1. All users should use inline-lock.
> 2. The fence-signaled state should be our decoupling point.
> 3. The fence state must be consistently locked.


> 4. This means all callbacks are only invoked for unsignaled fences, and
>    the fence cannot signal while a callback runs.

First of all that prevents concurrent execution of the callbacks which for a lot of use cases is a must have.

Then as I pointed out before the second problem is that this again makes the existing lock inversion between the signaling by polling and signaling by interrupts even worse than it already is.

What we could use is an SRCU, but a spinlock or any kind of lock is clearly the wrong approach.

So as far as I can see that is a big no-go and we should really just use RCU for everything and remove leaking the fence look into the callbacks like I outlined before.

Regards,
Christian.

> 5. All fence API functions should be "atomically correct": they can
>    always be called without any manual RCU guards in their proximity.
> 6. The fence lock should, in the long-term, become inaccessible for
>    users.
> 
> Point №6 means that this:
> 
> dma_fence_lock_irqsave(…);
> dma_fence_set_error(f, err);
> dma_fence_signal_locked(f);
> dma_fence_unlock_irqrestore(…);
> synchronize_rcu();
> kfree(driver_foo);
> 
> should simply become this:
> 
> dma_fence_signal(f, err);
> kfree(driver_foo);
> 
> So we would end up with a simpler, more robust and more maintainable
> API.
> 
> I gave this basic testing on a Nouveau desktop and it runs fine.
> dma-buf-tests also run fine. I can do more tests on Xe and amdgpu, maybe
> on Mali, too.
> 
> Since the series is mostly about locking the callbacks, all of which
> except for set_deadline() are *already* locked, I am confident that this
> can be done.
> 
> Feedback welcome
> 
> P.
> 
> Philipp Stanner (3):
>   dma-fence: Remove RCU protection for fence->ops
>   dma-fence: use lock to protect against module-unload
>   dma-fence: Support unload for ops->get_XXX_name()
> 
>  drivers/dma-buf/dma-fence.c                 | 144 +++++++-------------
>  drivers/dma-buf/sync_file.c                 |  29 ++--
>  drivers/gpu/drm/i915/gt/intel_gt_requests.c |  16 +--
>  drivers/gpu/drm/i915/i915_request.c         |   9 +-
>  drivers/gpu/drm/i915/i915_sw_fence.c        |  15 +-
>  include/linux/dma-fence.h                   |  63 ++++-----
>  include/trace/events/dma_fence.h            |  12 +-
>  7 files changed, 113 insertions(+), 175 deletions(-)
> 

