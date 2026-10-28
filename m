Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903E606A329
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RI7Vg4vE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEB110E622;
	Wed, 28 Oct 2026 13:38:48 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6879110E608;
 Wed, 28 Oct 2026 13:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxQf5qqSefHsqcqupprFJRAqnsgHtYcYI8ts7P4/eDkq4RejiiDeRIAIrznAxUjfaKgpCmxkPZ6acxMFZ/LSsWEAoV8JRSuCF3TDqkhgmnWUi6hleVmegRmxo53WLjZemBgxpcMC42AM1z/8MnJ3k4Ew1XaJF4VHfqEDUuT+x8ZuUL7Ggv6fi7346PYpD2Ur8PLuI5UQUJDsb9ojUcP0YTQcP+Q0hkVcAAmwFKe8NnDhOp+h/y9xl5H+m1QxF5gk9diEAA/q3GgQlhRAaYiHQMfi49u9+im1KxaNUKMTMyMwfezvRmQeqzVCTRw8VzKd0JvTc4fwN247fkQ3h1PJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTFKvQwf0RRVN3Mgzl0LALWZOxUzGu2XIJ8vjddXIx4=;
 b=od4c/uKtZCPKSKYDFP3VXHO0Xb3wyrgmhjaK5klFh5/heS02XU6qbGhFb45ByfzGSYEgmCTKn5w43+gEFi0vsncz9g93xP+cyqwDTe07avltNUMjj5TTbOWF2ArqDp8BvrP3VrYPQXz7BmlIjaC+PUrRkdg+Twhdd0HcizBpWgur2bOe/+7hDBP9T3/BAugcrOn94n0GC2Z53R4yJ9K1Ot3R39tOy0M1d4mtffSroXpcL2WF7/xy2IDVt5EteY8CryJgd/Hi6tr5QdPg9qWXSKm73AfkqRXfjAybroG4YjCb8owLkGIyn/1WP72RXFLvCv5stmI8vImS+1IMsR18kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTFKvQwf0RRVN3Mgzl0LALWZOxUzGu2XIJ8vjddXIx4=;
 b=RI7Vg4vE4WBS+QdjaQeHr9BYKzk50cljq2DWEVZ/IaZLefnL5RBVElFia0f1NgdMuyk8NIqkRDBUAkFShHfvpzquAmVpHKIGbkH1fN9FqBu6ufsktREjb864NlWJBYSuWfgZgXY7maoULo/lmiAB5/kMklCLq+x6dkqfK7BlNg0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Wed, 28 Oct
 2026 13:38:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 13:38:35 +0000
Message-ID: <5d15d668-7191-4e96-922c-82982787b50c@amd.com>
Date: Wed, 28 Oct 2026 14:38:27 +0100
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
 <22d66945-8854-442f-a69d-fe02726eccda@amd.com>
 <f9a47d563f896e0789fffa72df5847e2878cbe5e.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f9a47d563f896e0789fffa72df5847e2878cbe5e.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:208:23c::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e35df7-199a-47bb-4dcb-08df34f8c3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|22082099003|18002099003|261026140227099003|921020|5023799004|56012099006|261021135927099003|4143699003|11063799006|10067099003|261022105027099003|261009223027099003|261021121427099003|261026121527099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: bbgt6D2QYu/fQz9U8rSalnA4jxI+AsXW6XsXWER0KijUF5t6xgm4oA84qhOnz1OOUbEcChKn+kxh3m+tKkCtkV1dmDUoRARrVGU/aZ+kcMryoBHHBTSpuY+xcVXXF1ML/sCLKYoJ3zs2wFEt/gHuCgLpU8G/8OAE3YblwzxHaUtq+V0odjOuzaeKTpnS5AMOQQMK4SbBXpIJq0j9fNlu9i/bvff1qaIfxuywCIQWmEFXpQ6J53R0kquZDXtAzHklVkM690578phjzgWgAdoHinlTTrs76VAuUOfhZ3DYP+Xej4BXS3mroi2a8B5AfgQtnUXgkXHoWAFc/PcAbKvyREiDaDH2OQww0q37XyqYxSY9SCLeSGke8fa7JdJnL9u/pHomLf9J4WIWbEjQXs92KcYH6UtuTeJYNMtL94xVIZUFTOZHSUdyf5X2Mugww6yN3TcsYlpRGIMY2UkRvo7/b0NplagVBCi8l/Mnm34l56JB6AnQsUv1I43yxtBjFleSlIxaRPO+zIQT5IZIG8pMdojlqMNPuAv4ydOSJNO8PEakUyrTSDofMhIs7k6nCiEcyik0mpogQcxFr6poQ5FiV/H12SclYaFhfpQpO87VUT0IbLu9R2qa+eXNoX3mlP1CCuAjU6pQogDGniQ32042Qk/YDLsqqqrmQ0ATGrFT22mWlKx4Q1gS4IEhxuBvWRCsxN6YO25gVU88EcxyDnDoRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(261026140227099003)(921020)(5023799004)(56012099006)(261021135927099003)(4143699003)(11063799006)(10067099003)(261022105027099003)(261009223027099003)(261021121427099003)(261026121527099003)(261022075727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3VGWkRRVFVRejhPZTR4Nmt3TGhCVXlvRHF2V3lBcVgzbFg5L2pTb3hXK1ZH?=
 =?utf-8?B?bUZDL2hGRGNzbCtYclU1VHhlYjVwcE5QSmc5QllNNGQ4V2dqemVPMVllaEhr?=
 =?utf-8?B?cUovM0FxdFVsUWlXcXVsbGxaYnZVZUFSTEFXeDhhMmRHMU0yYkZLOHhOdXh4?=
 =?utf-8?B?Q2plOEZxMTByanNUelgwUEQrdlQ4RWJDaS96TFBCOHdBWFhVeDNDb05Pb2tw?=
 =?utf-8?B?RzZDNmpPTzJ0eUwwbHVVMDZhVXpKOTJxSlNaOG9uNnhta1FId1h3V3ZOdHRP?=
 =?utf-8?B?NjRSNFEySG8yUCs1OXJscE5hUlVVbEZoN0QvY1gxWFEyRVNSSVhob2xsUDA2?=
 =?utf-8?B?eDVpbDFaRE5YM0xvZUZUOTlRVExraGtGYzIvTlR5RXZpN2lZTUlvQkhjeWVM?=
 =?utf-8?B?cHFuY3ZlaTZrc2gyOHBrUW10SXBPTkdzQ1d4UzY2b0pibTA3Mjh5dmNpWGpQ?=
 =?utf-8?B?Y210MThQbUZLL3BrZ3o1Q3Nqby9hWnBnTUd0cVlZSmZZamZxVFVkVU1tRDRF?=
 =?utf-8?B?NTY0enBBenNWSmR5Snd1VDBsK21xc0FGdWhjMjRHQ3hPVm9iekYwRXZpQjE3?=
 =?utf-8?B?Sm4ybE5OYURMZk93UVZKZnpTOTZDMXhWbzBxZUgwWjBSeFVPUG1qMlkwWm5Q?=
 =?utf-8?B?WkhiaUtzbUhySTRpakV1VWY3bmd0RVU2SnpnSDJIK21XQjZWbnZQNldQU1NN?=
 =?utf-8?B?dGJSU0NDWXVyM09yNDRQYXVGK2oyYTRyZUZwUXh5RHFSVk9MaWdGVnBFVGgr?=
 =?utf-8?B?MDRTUHBTdkZBeFFRa2h3aHV3VWJ4TllMbUF0Q3J2V0FTYjdaOXlVOWxidkhE?=
 =?utf-8?B?VDJrbGY3QzZuUTVnTXgwc20wczR3TXkzSWpFenQ2OVlyRVU1WXNZejZuVUNT?=
 =?utf-8?B?TGVaTllaSWpvS1Q5R0duNElIWVR1MG9kZWZOTXlWT1Y4b2FHdnZNanF6QWo1?=
 =?utf-8?B?MEtZTTkwMjBiY1RtWGpIajBsUkN6bUdOdWJKMG5xSVF4cGFILzNxdnZ2eVQ5?=
 =?utf-8?B?aFlkd2xqblNtRzhGOFUrbDBoWGpRRFFRaUc5RVBsYkt4My84SzIyYUc2WkJ6?=
 =?utf-8?B?TE1TQW5DSU1yc3VSUjdaNnE0ZFBWanBDelhDSjBlcFArZEhDNFg3Qjk3blc1?=
 =?utf-8?B?QmRCL0Jqb1ZLL0EwYlZsdGlQSXB0S3V4bkl4c0xhb0FxVXUzRDloUy92ZnBX?=
 =?utf-8?B?ZHZ0aG9NcndFckRKcm5xWHBveGp2eW5GSi9nbC9rUnFkU3BzUmZha0dMbVlY?=
 =?utf-8?B?UEQ0VENOSy9RdmYzb3NmdjBoUG10ZlhxVVpPUVlBSGpNT3BMeGpZNmxlU0p0?=
 =?utf-8?B?ZEVGeG9DTE5ocTZ3WDhWNUsrU2h6KzNhaXU3cGFWRHFjUWVVY09mY0E0NEJI?=
 =?utf-8?B?Q1M2a25hK200Ry9tdlZ5c2pTaUFiNUN2cDRXc2NqTmw2SlV1MCttcktuQUk2?=
 =?utf-8?B?VTlsRWtqa0U2S0VHRTltZXhXako1SnlUUXFHb3FBdFN3UjNDTThaTnRoN3hF?=
 =?utf-8?B?aHNCRFV2dTFtV2pITDRoaWt5WDY0b29sMWtFdWtCZXQyaERHd0JQK0IzZmNQ?=
 =?utf-8?B?NHBFTDRSbU5UbFM0MGtIWXQ0Y3RycTZPODRkL2xmdlNMSFB6ZmJyZE14c3ds?=
 =?utf-8?B?cFJrRDd1blo4Z2drRUlHaVJOVGhUdUFUMFdOY05tRnpDZHJPZ0xLNTI3L2g3?=
 =?utf-8?B?Y0V3QzRmb1BORmFiN0NPdzBpT3NHb2t5Z2ZFSzA1cGRodjkvaXZpcHZQWnl1?=
 =?utf-8?B?N0phNm9kWEloMDFmOFlMdzdEOU43a3ZXc0gwVSs0bC8rQ1RaV0NSMXFMVVpQ?=
 =?utf-8?B?YVRqUUJROUZTUnVHbXRpVlYwOXFkYUc1NU12QjJCcjRTbzNIeURBS3pKZVVS?=
 =?utf-8?B?aldXZzNNMmhkT1hueCtCcUhQaC9hK2lwZ3c0cW1IOGJzVEJLRnM0SnVGMTIr?=
 =?utf-8?B?T0hzUCtwSDVNTUxHTnNsR2pJNnI3RG5qMFdMbDExa0dSWHEvWlU2MmdwZ3ZK?=
 =?utf-8?B?eUZGZ09UQ2RxV1ZtYklCbTBOSFVIQ2ZZR3Flajg4WGpaR29sTGJIa2tnUzlm?=
 =?utf-8?B?bG84QkliWDBDc215WUs1eVhzVytBMjJrWmFZUCtSNEJjMmNXY1U1WHJjbm01?=
 =?utf-8?B?M0JzdU9RVk9MeVJnUHVuTFUyMGs1ajVHUDh1dy9naDhWajY1ZzZwbjhpN3hn?=
 =?utf-8?B?dmh3L2tiQU9BZDFPTmQwaVFzWndRWGFaUFRoYzVvNHROMWVyQVhZZTVWdlJG?=
 =?utf-8?B?ZmNFWVpqUHFVMnRHOFh5b2RwL3NKTGMrdWRkMnJXMXRyOFZ6dmIrNDYvOHcy?=
 =?utf-8?Q?X4Fe/PAO92XtEVoQmx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e35df7-199a-47bb-4dcb-08df34f8c3ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:38:35.5320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEbua0J+UdFYhv9ifGOX/vH7fw1IQ8k2RNAlxTnLOMQVK40tgZaHtGFGvWNV81hU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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

On 10/28/26 10:47, Philipp Stanner wrote:
> On Tue, 2026-10-27 at 15:59 +0100, Christian König wrote:
>> On 10/21/26 14:49, Philipp Stanner wrote:
>>> On Wed, 2026-10-21 at 13:53 +0200, Christian König wrote:
>>>> On 10/20/26 17:36, Philipp Stanner wrote:
>>> […]
>>>
>>>>>
>>>>> Nope, I want to protect shared data, which is the signaled-state. Which
>>>>> is currently a race-condition worked around with RCU (and sometimes
>>>>> with manually doing the right thing (locking!)) [1], stemming from the
>>>>> fact that the fence's spinlock is not used consistently.
>>>>
>>>> The fence spinlock is consistently used for protecting the fence
>>>> signaling, in other words it always happens with the spinlock held,
>>>> same for adding callbacks.
>>>>
>>>> The only thing which happens without the spinlock held is the fast
>>>> path checking of the signaled and enable_signaling bits and as far as
>>>> I can see that is ok as well.
>>>
>>> No, it isn't. It makes the API fragile.
>>>
>>> 	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
>>
>> This bug is exactly what I'm trying to prevent here.
> 
> What is your proposed strategy for preventing it?

nouveau_fence_signal() is consistently used by all signaling path to both signal and cleanup a fence.

When we stop calling callbacks with locks held and signaling fences from dma_fence_is_signaled() and dma_fence_enable_signaling() nouveau can call nouveau_fence_signal() consistently from all cleanup paths with the proper handling.

This makes it completely unecessary to have those cleanup hacks as well as the nouveau_fence_release() callback.

Background is that you can then put the fence context directly after the fence is signaled 

>> This problem only exists because we call the backend operations with
>> the lock held!
> 
> Nope, this particular bug exists because Nouveau thought that it can
> drop its reference when dma_fence_is_signaled() returns true, which is
> not the case, because the fence backend has a race condition there.

No it doesn't, the fence backend works exactly like intended.

I agree that we made tons of mistakes here but that is actually one of the few things which we got right on dma_fences from the very beginning.
> A race condition that was allowed for performance reasons.

Well it is at least partially for correctness as well.

It is mandatory for quite a number of use cases that the signaling status becomes visible before the callbacks finish because otherwise you run into race conditions with the callbacks again.

And even if that wouldn't be mandatory for correctness the performance requirements just make it mandatory. Just take a look at how much people complain when we took the signaling callback away from radeon because of the locking issues.
>> What nouveau does is to delegate the cleanup since it can't do that
>> in the signaling handler because of the lock inversion.
> 
> What signaling handler are you referring to?

Take a look at the hack nouveau_fence_is_signaled() does for example. The cleanup part the other signaling call path do is completely missing here because the function can't take the fctx->lock.

>> This problem doesn't happen any more if you just completely drop the
>> approach of calling the backend operations with the fence lock held
>> and then re-structure the cleanup handling in Nouveau.
> 
> ops->signaled() is typically not called with the lock held. You might
> be referring to ops->enable_signaling(), which is consistently locked.

Yes, but if we want to get away from the external lock concept in dma_fence we must allow drivers to take their own fctx->lock inside the enable_signaling callback.

Just take a look at what nouveau_fence_enable_signaling() does, that is only possible because the dma_fence framework has grabbed fctx->lock before calling this function.

The alternative is forcing drivers to use lockless approaches for their internal handling, and that is much much worse than that a dma_fence signaling status is visible without taking the lock.

>>> 	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free
>>> of VM")
>>
>> I already discussed that with Simona back then. Simona actually
>> explicitly rejected my approach to take the spinlock to check for
>> signaling. Pointing out that amdgpu is using the API in a wrong way.
>>
>> The problem is that amdgpu doesn't track the callback structure and
>> so can't remove the callback. It's on my TODO list every since to fix
>> that miss use of the API.
> 
> You mean the issue is that amdgpu cannot deregister callbacks?
> 
> I don't see how that's related. The lock-unlock-cycle clearly ensures
> that amdgpu cannot continue while the fence is signaling.
> 
> To clarify: our conversation circles around two partially independent
> topics:
> 
> a) the signaled-bit is read without lock-protection as a fast path in
> dma_fence_is_signaled() and
> 
> b) the ops are not consistently called with the lock held.

Completely agree.

I mean regarding a) if we add the spinlock to dma_fence_is_signaled() I can live with that.

It's just that Simona explicitely rejected it when I tried that and we will have quite a crowd complaining about the performance and a handful of people complaining that this broke their timing.

I know that relying on the timing is also questionable to begin with but yeah some drivers really do that.

Regarding b) I honestly don't see another option as to stop calling the ops with the lock held, except for forcing all drivers to use a lockless approach.

Just take nouveau_fence_enable_signaling() as an example, if we don't use fctx->lock as external dma_fence lock then the whole approach used here doesn't work any more.

>>> Tell me one thing:
>>> If locking is the wrong approach, then how come it was added to
>>> literally all callbacks except for set_deadline()? Seems to me that it
>>> must have solved some issues.
>>
>> Well, it's because concerns with the lock inversion brought up by
>> Alex and me was ignored and the patches merged anyway.
>>
>> This is just another one of those DMA-buf design problems which would
>> have been fully preventable if I would have clearly NAKed that stuff
>> from the very beginning.
> 
> My impression was more that central design criteria for dma_fence (like
> module unload of the driver who issued your fence, which is designed to
> live arbitrarily long) were ignored, there was no clear guidance for
> drivers how they should use what callback, and then driver problems
> were solved in dma_fence, for instance with this shared lock. So same
> story as with drm_sched.

Yes, exactly that.

> If *everything* would have been locked from the get-go, that would have
> forced drivers to design their locking correctly, and decide wisely
> what tasks they want to perform where.

That's what I disagree on. Locking everything doesn't help, it just solve a problem in one place but complicates things in another place.

It's like shifting the hot potato from one side of the mouth to the other.

>> Back then I made the mistake to believe the argumentation you come up
>> here as well and so I don't explicitly rejected that approach, but by
>> now we have strong evidence that this was a mistake and I'm trying to
>> fix that mistake ever since.
> 
> Well, I am a different person with my own background that informs my
> thinking. Please keep that in mind.
> 
> The "strong evidence" you claim to exist has still not been shown to
> me. I show you concrete bugs that we could have prevented, but the only
> piece of code you ever showed me where something would break is the
> list_del() in nouveau.

And that is strong evidence. Nouveau is actually the perfect example of why this approach causes so much trouble for driver implementations.

>> We should have never taken the lock for the callbacks in the first
>> place, this just made the implementation much more complicated and
>> caused way more problems than the few raised by putting the ops
>> pointer under RCU.
> 
> Lock-inversions are not being solved by just not taking the lock, they
> are addressed by having good lock design. We recently solved exactly
> that in the Rust JobQueue, where drivers also reported lock-inversions,
> but we could eliminate them with just a few discussions, discovering
> that the driver does not need these locks when interacting with the
> JobQueue.
> 
> Often enough btw the only object the driver really needs is the
> sequence number anyways, which can trivially be passed and shared
> around.
> 
> Now with dma_fence, I strongly suspect that the problem came to be
> because of no clear guidance by dma_fence as to what the driver must
> and must not do in its ops implementation.

And such guidance should not exist in the first place.

It is up to the driver if they want to use locks for their internal state protection and the dma_fence framework should absolutely not enforce anything it doesn't need to deal with.

That the dma_fence lock should protect the state of the dma_fence is something I can perfectly agree on, but that does not include the ops call chain because that isn't dma_fence state in the first place.

> The only evidence I have ever seen is the fence-list-lock, and it's
> just not clear at all why any callback would need access to that.

Because they need to clean things up after signaling.

> Let's walk it through together, shall we?
> 
> ops->release() and ->wait(): deprecated
> 
> ops->get_XXX_name() -> never needs driver locks
> 
> ops->signaled(): "Driver, here you read an atomic integer, the sequence
> number, and tell the fence backend whether this fence shall be regarded
> as completed"
> No need for any driver lock.

Incorrect, you can only work without driver locks here when you delegate the cleanup.

In other words either to a worker or the ->release callback, both are things we try to avoid.

Again see nouveau as a perfect example of the problem.

> If this particular driver also signals fences through an interrupt
> handler, it can take a list lock, then signal the fence. The ops must
> not do that.
> Why would a driver need both modes, sw *and* hw signaling? And why then
> is it supposedly the case that both paths need to keep a list updated?

Because the signaling through the interrupt is mandatory for correct, the signaling through the is_signaled callback is then on top for performance optimizations.

> ops->enable_signaling(): "Make sure that this fence will get signaled.
> Register an interrupt or schedule a work item". These locks also don't
> interfere with the fence-lock.

Yes they do, see nouveau_fence_enable_signaling().

> ops->set_deadline(): clock up the CPU frequency. The only implementor
> trivially does that through a work item, too – after voluntarily taking
> the fence lock over the entire section.
> 
> 
> As you saw from our recent amdgpu discussions, the confusion of what a
> ops is even good for caused drivers to mess around with the fence
> directly in their callbacks, checking for the signaled state etc.

Yes and that is exactly what drivers should do.

> It was too much freedom that has caused the trouble. There are no
> canonical solutions now.

Yes there are. Use RCU protection for the ops and the per dma_fence spinlock for the dma_fence state, problem solved.

As far as I can see that approach fulfills all requirements we have and there is absolutely no reason any more to take the lock while calling any of the ops pointers.

> So except for updating the linked list in ops, can you show me any code
> example where a lock inversion would occur? I'm quite confident that it
> will turn out that the driver has no good justification for performing
> the related acts in the ops in the first place.

Again, drivers don't need a justification! The dma_fence framework needs a justification to restrict the drivers!

And that justification is not given any more when we drop the concept of a shared lock.

Christian.

> 
> 
> P.

