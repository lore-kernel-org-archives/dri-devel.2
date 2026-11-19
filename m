Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B4660A2618
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OaTekQnc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCE6112287;
	Thu, 19 Nov 2026 10:47:53 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B2F10E461
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKGUQ9IYl0O4KduYqcPSJ8NoA/gdWhSq5UIb0h5eWC9QV4lYa1eNJl7gC1uro1icvw4cBRsxTrUqawo8v4RQ1D8pcEFv6Uc4uCI1l/7tTUfwMlMxa2UTRDZ1q7nAH0RDXLxKu2wltc7ODSUq80PRBHOSBwep8M+GxuAxyFa/Nt3w6CEk+mEkKK3uUlgU5Rcni1HeoVY0jxmdnAX7YQngUDTjgZ0KaEA/k28gooXri+nFWlk+HooKNPqjZDvr8c+9mhGF+h15bMA1f8p587mZaH/6TMJnxZASEjIYYJbTJZRMCCYmSWGRUyIDqfCLzDrlZ5qG9rgYnuFtD7PKjRkknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDMFaX/WjsCXCufWP9KTH8AgKDF2brfKQH1hfBOpovQ=;
 b=R50cuX5lPLVcfziiFAGD8bG34CmK2kfBNeWeA7NcBSdJSFH4MLkeixZ9xsQ8AQeJql+/dazZdRyfCZIuLpTcPVkAtPMlHtGvK4e/dhr7dr5+mE6MNySQOPOygNbuiF4kNg5o1Fecc8uSg/j4IoeCG+QtCGG/QcTONYBMMTl9EV8jcZS4dW4QoDSI6JmZFGMmhjdSog1kdvGNmL4nsCpWfqe8CVlVlAzQN57hRjI4dqXeM+jk3BuBAb+DmBGDaXishehnWYgZsPsOQr1ytTHB9wxnMAI5+nQhLS4bWqmiCR/t88g3kcFBWkVHTwRUx08mRbmgZQWmBcV2Uynbw+DbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDMFaX/WjsCXCufWP9KTH8AgKDF2brfKQH1hfBOpovQ=;
 b=OaTekQncAJEDVu0moHCR6bXgzuSd6WWi0ZLxBMR0SM6YVQR5wEbZRR9NgF3oCzSLXGes/7xMN/f+M9vI3rWLAJY6ZLxX+3Y5ggBMbI4HqVzJ2n9jpoSNOYYDgJ87uQ0s6x1D+L67nxDyCKjDxVY5Iwb+IshRyHPwxv7Tmd5jNHc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by AT6PR12MB727359.namprd12.prod.outlook.com (2603:10b6:170:116::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 10:47:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 10:47:42 +0000
Message-ID: <141892f8-180c-4157-8c59-6e69057334f2@amd.com>
Date: Thu, 19 Nov 2026 11:47:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
To: phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Alice Ryhl
 <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261112101015.528127-2-phasta@kernel.org>
 <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
 <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
 <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
 <ab99758408df682c68a3792cc3014b77d6e1c8ab.camel@mailbox.org>
 <c2dd46ea-94d8-4720-af37-897c91809338@amd.com>
 <DMXJ8TBSZJJ4.3HG0OJDI9URTT@kernel.org>
 <8da4a8c0-1740-450c-9cf1-1a7b21d12997@amd.com>
 <DMXMSIQONGUW.1RRNS7I6LACD6@kernel.org>
 <a7f9e0f3-b299-4d40-9230-106003725dc2@amd.com>
 <202dd0c3d515ddfa77a8ec8751badadd31b8a7b0.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <202dd0c3d515ddfa77a8ec8751badadd31b8a7b0.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|AT6PR12MB727359:EE_
X-MS-Office365-Filtering-Correlation-Id: 4670aae7-b866-4f4d-6226-08df462a8984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|261102123227099003|261022075727099003|261022105027099003|261022113327099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: PXMV9WAGfL8a5MRiXY1szduw0jyyOe3Up5721rWS8UbkN3yOZKjv4Y+Jl3vefQeutmWnOuGDdxMsq4pFSrqDF/+sKwOamso7uFw8kmEkFJEX/G7DQDfZfuIXGiAeGq+jL/u00MUcXTorROJyOIAbT12jMIQ6eFaw10PCaw1wgMpqYLhr113Qybd1tAjJ6Az7crIzW1yjU+wPAx9bkNR+mcjS4C2q/6A/nqO08qmuYOKhgMMQs+XybySh81msHCEYxi74ObLwvJ26kwzsTzyGgmM1oHvc3feLMUV3qGvhln6EGym2sfYaoz5qkAMv3OP7gbdmBTy+KfcesHplw9p86RIJeXPvbNWiC6Q0R3GtRIM5Py0Lffi94RFSCa3nHq0ugn/Ets/WkvjKhPuQTElGxmILq9NRvH5bd8rEs0rPB7JGyzLgY2T9vMkwDGjlXbamoWiGgYhqhyyEbRoYc2hDWmvXz0km5Palox0Xith8sCSibE3DDU+6weaWDsX0YfDVt7SG4PAI5nPIpXZPCkq1blTdXUZTb0MREJ4T/ZwS8iJ5BTULZXG3H1medLOq2qrvNbf1AWulssvs2EnLi3RTWkMqXQg/3OkWb6MVp4NhP+eN8uU3sUNOsFBogEOSq4+K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261022113327099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktrOEZwQkpDcUZia2dxVFBHWndhajVlUExCREkwUWVMTUEwZnhnQ0hodGp5?=
 =?utf-8?B?TW1CUkxWb2F2cVBCaERjSWN1bXlXc0UxZ1lNSzY3WlVVOS9ValBhTEQrZEJS?=
 =?utf-8?B?SGZkNUo0OWFRK3JyNGkwQjJWUER5eTN5clhCNzJ4ZDUrZDJkMWtwaU82UlVu?=
 =?utf-8?B?WFlDTDJCWXVQOFZpeUoxRWJhcHpKK0NNK1dpWmh4T2xQTG5DV2pGK3NEOWFo?=
 =?utf-8?B?cFROQkNldlBxNm9KbkdWNHpraWZvR1hpTVlCUGFWMUg1QnJTa3M1bENvdDdp?=
 =?utf-8?B?bUtUeEt0ZldFUkcxY0FDelRHQWZmWHd4SWRFQlVFMHFrcXBraXYvQloxSFRW?=
 =?utf-8?B?cmFYQ2VIMFFhME1OdFo3amovSUdQaEdhM0hUODE3dzJuRU5qd29ETTJYMkFR?=
 =?utf-8?B?UzZkRHY2WmtOODgzRU04L3NidU1EQXBiZEJEeDl4ZmJqTm14VTV6eHFVbWw3?=
 =?utf-8?B?eHdVdndUcGlUbGI3cW5DczNRSEw3NEJQRkg5ODRoZUZ1Tmk4UzdDNlUrcjlp?=
 =?utf-8?B?SWdNQmJsL1RaM2tSaDMxV1RIaFFQQVdyZGRJNUhCTXkxMS9QQitlRjVUSHJO?=
 =?utf-8?B?VGthMVNYdUFJdWFFWEp3RnpsbEhYSEpRQi9Vdi9nd1NvNTJNSkJhQmxDS1pR?=
 =?utf-8?B?SEROcE4za25mZ3lMRFRkOFFxQjNYUVlsSUI5UGFXanVpclh5VmRwOVQrSkc3?=
 =?utf-8?B?eFBvdlROMk1kdnJmUENpVnlBK0MwM1FvRzdnbnNtaVlsbTRoankzbExLNmJL?=
 =?utf-8?B?dGlhUmRzYU0waW9Ba1pmUWMxRzA0V0xHVkJ6UDJpYW9TVmZEYXFkYldtbmdM?=
 =?utf-8?B?QTZLL0ZRQkE4SHRIVm9xMk9nMnZvSWZCc3NyMzNiMEtwa1lGZTRLWFFHUmdq?=
 =?utf-8?B?aWtIN1AxSEZZdStnV0ZNQjIyeDl1eHpvTkZSOG51bzVURkJXOHFObG0xMnJS?=
 =?utf-8?B?a0RvRllQblM2M005ZkhoWDl6UFFla0hDdTRFbzBZMGhrQXRIUytRNEZyanlp?=
 =?utf-8?B?ZGZ5MVlXVTc3UXVzbmhCT2Fqd2pxVTJjdUFLRUVJUFptUEdUTkI2aXIrV3Zi?=
 =?utf-8?B?Z2t6OEJ0VTJzYTU2R0VWR3lZbjJOVEdjNHBFZm9nV1MzNTJybzhkMWg4TTlx?=
 =?utf-8?B?THAreVJieFVLT2p4K045TDVLZHNMdVhPVlZ1RFlxelRlM2d2dDk4N0tCU29u?=
 =?utf-8?B?NzdyVEltdFpHVk40TEx1UUp1V2dqdjNkU0RJTW9xVHNOc2NGWjVwNm11MjEv?=
 =?utf-8?B?V1NxU0J1blJWTGxmWUJUeWNEMnNjUWpaNFl6SDhoV2hvdEVZZklTYjJqSnE2?=
 =?utf-8?B?emtpUUNkenBQZngyV0NXT3JxS1BBb0tQUFR0WktnN2lnZ3JtL0hhTTJFdFVm?=
 =?utf-8?B?ZUhMQ0gvbGlVUjluQmdBbUFFdXVEWWw3S1hMcjYxWGVRZ1Z6UDVhUVBsKzlV?=
 =?utf-8?B?UWh2WnhQV3hlQzRGdFJvUWNoa21icnZtTEtLS1VvTUF4V1d2ZlRpU0owNkE3?=
 =?utf-8?B?VzducU5yZUFFeGRwMm50NzRUZXFWNHhGM2J4b3hmQ3NoTHJKQWF6QkpGakdw?=
 =?utf-8?B?eU9rNFlqdjF6ekdTNTNJWHAyc0NueW5IcC9MY1Vza2hUOUJqWVN4QmhReFli?=
 =?utf-8?B?N0JBUWg0aHgwcVNnRlArWktLanIwMFJJZDhla3BJa2NVejlKVDljSDBJQnZG?=
 =?utf-8?B?MUY5bkh6dVRDenZ2L2M2eThGMzVreFFnMW1RZjJFdE5FbUdMQVltZUhKYndu?=
 =?utf-8?B?THIwSEhaUkMzYW9IS0NNNEthQnAvamtJMXhaNG1lUXV2djVTdVpRNHRpWTNX?=
 =?utf-8?B?T2xMbFJSTUN6cWxMYWxFb3cxU0J0a3kyWkRWTEhxRFpWUWlOQTNyVVFoZDlK?=
 =?utf-8?B?UUJuTXhyNjV5c1c1aHVzUXc2WmZVdTc1NXN1aldJL09VSHE2ZVprdG1zQ3lO?=
 =?utf-8?B?ZzdPRWRaN3hIVlhDZk1laVhBc0Z1NFRDQVBOQzIweG1iQkFKZlhlMVFpMkV4?=
 =?utf-8?B?dnk1L296K2hha05TV0hKUnowU2ZkTVdldlVrcHNSS2YzR0ZjVXAwMGIwclQy?=
 =?utf-8?B?RWJjei8zQ2VKSlYwK0NvTVVrM2JtaC9yRlJhdWpTeHpJYnNoMVBzbmYxQmMx?=
 =?utf-8?B?aVQxUjhyeGlXallFbFd6aVAzTEMwZk8xRmN5TStwMVdQS2lTZm5vU0tFenlP?=
 =?utf-8?B?QlM5MDJqdDhqbmhWUXZVaXFTWHpDZU84d1lGQTRkWkRyR3JRcE5vRFBmcDJa?=
 =?utf-8?B?VFVUNTRxY0N2Q09BcERnS0xVM0NvRlRPUHU5STZZRGNpVHBzelp6SFM1MUVL?=
 =?utf-8?Q?x/mtisaQPOsYhPeA4/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4670aae7-b866-4f4d-6226-08df462a8984
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:47:42.3079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qU0ykhTfLmpMy4dYE0Y/hFs1ZlXuNhYpAtDw28Pk7p1QITGMXBMx/T5ZquBOdYSt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB727359
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

On 11/19/26 10:58, Philipp Stanner wrote:
> On Thu, 2026-11-19 at 10:32 +0100, Christian König wrote:
>> On 11/17/26 17:36, Danilo Krummrich wrote:
>>> Drivers often reference count representations of hardware resources and hardware
>>> states and hence keep them alive beyond what their actual lifetime should be --
>>> even beyond driver unbind.
>>
>> Yeah, I agree 100% with that. I know why drivers do this and there are unfortunately really good reason for that.
> 
> To me it seems more that we are often working around fundamental design
> errors. What good reasons come to mind?

Because of the different requirements.

You have one arrow of dependencies pointing down the SW stack, e.g from the application over libraries, uAPI, drivers all the way down to the HW.

But you also have the different direction, where your HW has dependencies on signaling both completion and abortion from way down the stack all the way up to the application.

Now at least permanent references can point only in one direction or otherwise you have a circle dependencies.

BTW that is the reason why dma_fences are RCU protected as well. That is not because of performance but rather to be able to do a try get on a reference to solve reference direction problems.

>>
>>> This causes lot's of issues and I'm looking into fixing this up, see my talk in
>>> [1] and an example from Xe [2] for reference.
>>>
>>> That said, in Rust we don't have this kind of ambiguity, lifetime and ownership
>>> of resources are well defined and the core infrastructure guides drivers
>>> accordingly.
>>
>> I disagree, you do have that in Rust as well.
>>
>> Background is that the fundamental problem of having two signaling
>> directions which want to define lifetime differently doesn't go away
>> because you switch the programming language.
> 
> For Rust DmaFence, this is addressed by having two distinct objects
> sharing the same refcounted memory, DriverFence and Fence.
> 
> Dropping / signaling DriverFence is the decoupling point.
> 
> Which is by the way why I am trying to convince you so hard to give me
> the spinlock, to make this simpler and fully sync ;)

Yeah I perfectly understand that :) I just disagree that this approach is a good idea.

>>> Consequently, it is perfectly reasonable to assume that a driver object that
>>> owns device resources (such as DMA memory) will, in its destructor, tear down
>>> the hardware to not access any of the resources it owns anymore.
>>
>> Exactly that is a pattern I have seen many many times before and I
>> can say from experience that it is very prone to human errors as
>> well.
> 
> Danilo's argument is that the object that halts the hardware is the
> same that owns the fences.
> 
> You drop the hardware-ring-object, this halts the ring, waits for it
> synchronously,

Well how do you wait for the HW ring synchronously?

My point is that this waiting should be done by blocking for the fence to signal and NOT by any other funky method the driver may come up with.

> then the fences drop and signal. Of course, you can
> additionally signal them manually before their drop with another error
> code than the default.
> 
>>> Insisting on an explicit method call is not improving anything in this model.
>>
>> I'm not insisting on an explicit method call.
>>
>> What I'm insisting on is that the response from the HW that the DMA
>> operation has stopped is signaling the fence.
> 
> That is effectively the case, see above.
> 
>> And not that driver tell the HW stop DMA and then continue and dma
>> fence is automatically signaled without explicitly saying that is the
>> signal that DMA operations are stopped.
> 
> Again, the main point here is that the object layout ensures *exactly*
> what you want, Christian
> 
> Like this, pseudocode
> 
> // Drops first, stops hardware
> struct exec_context {
> 	// drops second
> 	jq: JobQueue, // signals remaining fences when it drops
> }
> 
> It's maybe more implicit, but ensures exactly what needs to be ensured.

No it doesn't.

What I want to ensure is that drivers don't come up with funky methods to signal fences.

The cleanup part you want to have here is clearly good to get that defined as well, but to be honest that is peanuts compared to what you get when you have the dma_fence signaling wrong.

> 
> That's how teardown is done in Rust. You drop the lock, it unlocks
> itself. You drop the memory, it frees itself. You drop the fence, it
> signals itself.
> 
> That's by design because the object lifetime model falls naturally into
> place.
> 
>> I think the most defensive way would be as last resort scream loud in
>> the logs that the driver is somehow buggy and hasn't signaled it's
>> fence, wait for a certain amount of time (100ms?) as safeguard and
>> then signal the fence with an error.
> 
> Now that doesn't make any sense at all, either the hardware is stopped
> or it isn't.

There is a huge window of state in between.

> Having some random delay is probably even worse because
> the problem is then more difficult to even encounter and thus fix.

Well the whole point of the delay is to at least have some kind of save guard that makes follow up problems less likely to encounter in production.

That the underlying problem is fixed should be triggered by the big warning in the system log and not because I notice that my valuable data is corrupted because a DMA fence signaled to early and caused random corruption.

> 
>> Exactly that is what I disagree on.
>>
>> Stopping the HW is what makes fences signal and that is what this
>> tear down process should block for.
> 
> Our point is that dropping stuff stops the hardware, and *then* signals
> the fences. Exactly what you want! :)

No, that is completely backwards.

A dma_fence should *NEVER* signal because you waited for something. Instead the dma_fence is what is waited on.

>> Well the question is can we enforce this?
>>
>> I mean there are usually only limited options from the compiler side
>> to enforce things, but we should still push developers to use well
>> proven patterns and coding practices.
> 
> You currently cannot prevent people from refcounting stuff if they
> really want to. The Rust language is working on enforcing that, too,
> though
> 
> https://goals.rust-lang.org/2026/move-trait.html
> 
> 
> btw the best feature that Rust offers IMO is that the refcounting is at
> least always right. That's quite cool. A great many hacks I've seen
> stem from the fact that programmers are not disciplined when it comes
> to copying pointers and their refcount.

Yeah completely agree as well. I mean OCaml already got that point right.

The problem with OCaml was always that you had to distinct between strong and weak references to avoid circle dependencies and therefore memory leaks.

The ownership model from Rust seems to be a big step into the right direction to also solve such issues.

Regards,
Christian.

> 
> 
> P.

