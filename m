Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB45606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OIHtzld7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5001410F03F;
	Fri, 20 Nov 2026 09:16:08 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D657A10E86A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:16:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHT0qL0lNtxJG8a5Upn0+tP3FJLUzODwbWrKh2pUK+k/hbLfC0HP1tJ448DvTzHDn/b0bvYXOdAIr8/1DpkXgNaonJps4AaX5sMgOTWFN9CNeFXwMroHFVBGhOQGXfigXLM1qvsz2owmBLbedAWpnSdBLNV7Xmhp8sztQkbwvBYa97qXSftZzvbTF15rcixCva43n0bnK647ygevW1b+Z9PXK8lhmnMH+v5+dUtPVaFnE/pGy08jlxaKLoiecDHqf/xkxPV+2XbAlBenXP8D/HHyPcI6QczyVqpjcIQOk1f8jpY//Ky6LvrOElJgya/3r+MWgc9GyrfHnsXAGtc6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jgvV4gcibRf40b1fBeZeYXU7rHwCs5h2w50tFNfQ9Q=;
 b=JIdULeLyTLID1nZj7ADq+F0lCQZiOSwCxW+LTj4jFduoZ/j5DOSLGMQpGdjFoGO4rzpGVfrCU7L3Oio+xdYzuKe7lWQoSOfCxgu1tdbAvTTH0dXWaRpnsdpyMnLwkgK7gVS5NfR2Iv2OT3+5l6xDDBJzehXv9mnFQGHwzKqMXiXeCsqlDVVTDLQHkMqwwRKCP+6iMcZZbT2cCHh8c4XIttdO83wh/olQkzSI6LifjmppBP8ein3nz6bOEe+MU08j9RdrfnJlSiLXksxWgpM8pnNymDGiJZoTx+hcVaYd2zB2kJvdYctZ2U4NYB7pVlm/FiN0fdNtqWfuSQcFo6rQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jgvV4gcibRf40b1fBeZeYXU7rHwCs5h2w50tFNfQ9Q=;
 b=OIHtzld7lT7bWc2Ml1EejBmg2IvcB82BxRNp2KefVuW63awkwhC1c7MTpbTV8mAj8n14ftjJ9VS+020WVUkQ9WTZ1tb32YJF//T8C1a8rfJFu+fSt7L8hYJMMwoEiZ4/WF6OBBAB4DsmiIaFRG9PsEaGaPxGoIG61NUwhu9zThc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH8PR12MB999206.namprd12.prod.outlook.com (2603:10b6:610:35a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 09:15:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 09:15:58 +0000
Message-ID: <c18fc55a-717f-42a0-b37f-4ed81efd29d1@amd.com>
Date: Fri, 20 Nov 2026 10:15:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
To: Danilo Krummrich <dakr@kernel.org>
Cc: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
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
 <141892f8-180c-4157-8c59-6e69057334f2@amd.com>
 <DMZAQ0G6LTTB.1CRPNXSYB4QHG@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DMZAQ0G6LTTB.1CRPNXSYB4QHG@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH8PR12MB999206:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d6fef5-1f2a-493c-113b-08df46e6e2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022105027099003|10067099003|261022075727099003|4143699003|11063799006|56012099006|261009223027099003|261102123227099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: RmUkEsmqdkFsYYgrfEiq1dSUPUtw6gG1RagZ73SRrE1knVh/+zoddnW9H16fDnNbQLztQFCXZkw5beZ7sxJOrmkvYmSZS4mL3torHSWp/VE2S2SZ5Z+YNfQhnJ9F9Z0d1pf2x42AE9HPXSGboe1I/NUoUo6vG3jSkrGLeZlruZ1l1WfUAl5l9fsjLXzrVjK9v58hde7PXhW4H8LZnG9PDjQeqGCnpSyCeDZ8Z5VFQ3Uqwb+1nmkuuooXRNWM0/isI/zjH8NM9wGHPvcUg84vv7wb/JL5ynGkLVqWEzbJanjDalGYof/VDEqvnKSQ5PkqlPKhzoln1XZRpSgX3DsYZbXW3SOc+sldbN7w58rW518u12/ly55dQWOmeDeHXZxeSGZh4DfQCP7UfGL//Wuf0So2cL9YUs0f+2Fx4o4P4XrzJdVFm+5DB3BfYpjeUv5m3So/Y5MG22Me2t8MXP77PznVv7RYkQ2Gvv47UkpQpahjoWAvRaSfxaC3BcV8ZQmK+5D9yz+poGXSpYeJPcxDhTQWCw06oxldLJTlhjCuHErRH5UK4/E8XpGEfJM7R3S4q5TEIBoBUoFEwFEJFKcbTRpAnlCo2TJvE41/wCnW3fhQ4abNIU5q0VzgzusDYx6p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022105027099003)(10067099003)(261022075727099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3RucEVWbVlHbE4wUCtZQ2pOM3BLcmljaUFpdmNTRFlWZlIya21BbFFFUlVu?=
 =?utf-8?B?MVdWaDI5TmZja1NGSStiejAweXJ2bHRkSFhvdjNnMlJ0UG9nL0l6RW9La3JY?=
 =?utf-8?B?TVRZRmoyODFPT1puVmpVeXhNY0ZDZnFPQVNXemF1WDJ4L29FRGhLV0dqS0s1?=
 =?utf-8?B?M3plaUJVOVZRL3F0Sk1tWi82VjNBQ0NMVWZsYXo2cUJ0WXNtZi9GS1lITS9Z?=
 =?utf-8?B?YytnYkNxR3JWdk1sWDBlSHBkdGxJRHNnMnk3d3ZzZFAzQVlXYllWZHVubjR0?=
 =?utf-8?B?WHFpbnlJQk1CaXZrYWliOTZGVVhmZXZVSGhkT2lnL1ZjaFU5UHI0aFhOeDNG?=
 =?utf-8?B?SlZjYUx3S1RtTUsvOU5MdXBTQTR2QmRNQmg1Rm9VTUt4cnNudFp0MXBDcFNT?=
 =?utf-8?B?WE9xKzE0REEyUWhqSDRhc3dycDlab0JmVm8zdVBSWTZhd1VXcDlrTmVmM1E1?=
 =?utf-8?B?LzNESGtZZ1prakoySzhadmhDdllHQUxXbWM0ZWx5Q205T1BvRmYrcUk2WHI1?=
 =?utf-8?B?cUd6cGh1am1iM1pmY1ZzUEdzeHE3MXQzM25GLy9teUVUeFRXbGlQSWJsNkpF?=
 =?utf-8?B?NWhhOC9EQ3Z2WnVtZmR5VEJYWE1YcGxuT3Y1aHlVejhqa1VScUpnVmFiMnNm?=
 =?utf-8?B?UmxsVVZwdUVqcWNVcC9HRko0dEQrV3l2aU1UN0lBL01zMXZ0Q3RYV1hkR09s?=
 =?utf-8?B?WEtBZDJlYUZvWEhyYzJKTm1ubHZHSjhlaGI3S1FUM0dUdHc4OElTVkl1ZmJB?=
 =?utf-8?B?UlVuTTI4T1gvdHVUdmdQNG9FaVU2aGg2QTFzakNwYVgxcnM1TWY2aUlTWkVQ?=
 =?utf-8?B?NmZrV2VVNURTZVdlQStYbUZPSjZBNlArcElqNHg5NUp1RFBycDdpeTBFbjZS?=
 =?utf-8?B?K01pMmNMRW4vd0ZhMkk1TGNmcmdpcVFkOStBVDRxY0dPUkxZbEwySGh4VU5i?=
 =?utf-8?B?eG52QmVURHZQTGVFa3J3VFVJd3RITlNKZzZoN0dUNFIzZStlMGlwbUd5QVRj?=
 =?utf-8?B?K2QySzNxcTlZcTF3aWEwT3QxenNPWWxsOTlrdHVOMUluSlN4OGppbUR3Z2lY?=
 =?utf-8?B?RGtocUUwd0lFWGtVRERiQk5hZHRheWFQNzZ1SWxmc1lXTEVZbi82SjBZTVBJ?=
 =?utf-8?B?SkFXNThwWVRUY1FNRHBMcmJMMndSL2pnbkVJRTVsUG4rVThhelpEbTNobGhO?=
 =?utf-8?B?aHM3RXNjalR4NFZCd3VPaXl3bW9KYmhvdDBIcjNPZklyY2hlV3JPNkF3TXVL?=
 =?utf-8?B?M2NsWURkQkNQTDVMUWFhTWl5VnlZMzl4aWg5SnRKcjQ0YmJWc2s2WnltK0h6?=
 =?utf-8?B?WkVPRUJldnQxb1orMHNndkFlREI5bWtaNjZyM1VPVC94bU9PUVArUGozUURU?=
 =?utf-8?B?UHJmaGdqZlo0OGl4S3JjcXdSS3BUejB1SmE5L05jdFZ1eklsb0NjL3BGcVJG?=
 =?utf-8?B?aWo1VUNWOGN0cUlTeWJqd2FNbWlKQWt5aFEyMzlqSkpvL3FIUXQzVHNBakZ5?=
 =?utf-8?B?STI0cnQ3blpxRmlqYW4zK2t5aDBkN2xGZDZDRzhhUC81cFRaTUpncHVyK1I1?=
 =?utf-8?B?SUU2ZHN1TkR0clhDTGV0a0c5dXl5b0g2U214d09oNVN0aHBCcSt2NTNVZTlK?=
 =?utf-8?B?QjdIZU1ZWFJmY1BacFdtTkM5cGtMYnQ2Nk5lREtXNEZwQXFIeW9EY2NQSDIy?=
 =?utf-8?B?RFVGTXNUQ0todEdBQVE3TWxMMzc0UEFScVJMaG9GTFQ1S1JiWWNxVXNTd043?=
 =?utf-8?B?QlR1LzdSV1RnRlFOZDk4ZU5TWW81YlhCLzRpUHYxbzZDR3RtbkRCU0RDZTRN?=
 =?utf-8?B?R3M0b3pJSnBGM3duTlBadVphMHBvWE9ySTZEbUtaaUVJT3FGTzlWc1JFSkZ3?=
 =?utf-8?B?MGJhM0hMQ0VJM0FNdmJIQkY4bG1DNzRwdVRLMGdoUjlSVXgyQXJacUJMSllP?=
 =?utf-8?B?UzVTb1BKbkUyUFNaVHNoNm9IZjZDdG5tTWR4cXFpVndNQ2IwelBQcTloVkE5?=
 =?utf-8?B?NXc2YUZUbjNiOHhic3czMGZaaHovQWZVNll3SkJlNGZOaEs2MzdqWlBYSTJ1?=
 =?utf-8?B?TVplaTF6aTRkY1VQcmphRGFYUXVCaUdobk9FUW9KNjNNR1p5TlUrQWw1c0Ew?=
 =?utf-8?B?NlRLSW1rZy9ld2JiQjJnVGowOGRvYWlOcUc3WDBJeDlZMFA2ZmM3WEJPZnhE?=
 =?utf-8?B?ellCbGx3dTZ4dnlJKzZXV1NIQ1RVNnZDdldPSmI3aXBrYWFEbEF1SEQvTTV6?=
 =?utf-8?B?c1J4VnBWdXV4UzZTWkZOTXlpNHRjdjN5b0g3Q3hkRWR3QlFrbW9IUnFoU2Fh?=
 =?utf-8?Q?KEbkIXVHcWj4Xn9VII?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d6fef5-1f2a-493c-113b-08df46e6e2ea
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 09:15:57.9750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yJ9FA4+GnkjMS7t755KqLI4q+S/5dyJRFTkU/t1eYS+bymJ/h/U5KEnCDlj5cUs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999206
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

On 11/19/26 16:34, Danilo Krummrich wrote:
> On Thu Nov 19, 2026 at 11:47 AM CET, Christian König wrote:
>> A dma_fence should *NEVER* signal because you waited for something. Instead
>> the dma_fence is what is waited on.
> 
> In the end, despite doing it on behalf of the hardware, the driver is the
> producer of the fence. And there are cases where it can't wait on its own fence,
> because no one is going to signal it other than the driver itself.
> 
> Assume you have an execution context that is torn down, and also assume the
> hardware supports preemption. Then some of the jobs in the queue might still
> signal, but some jobs are not processed anymore and hence are not signaled.
> 
> For those jobs that did not execute anymore, the fence still has to be signaled.
> So the driver has to signal them after it waited on the preemption and execution
> context teardown is complete and no more operations are in flight.

Oh well that comment made me smile because it confirmed what I wrote :)

How do you wait for the "preemption and execution context teardown is complete and no more operations are in flight" ?

That waiting for DMA context teardown must be done through a dma-fence. That is the whole concept of dma-fences in the first place.

I wish I could enforce that in C somehow but we missed that opportunity when we originally designed the dma-fence and now it is to late because of the fallout and complexity required for such a change.

See the discussion here as well https://lists.freedesktop.org/archives/dri-devel/2025-August/520640.html

I think we are at the point where I need to make clear that practices like signaling fences from a destructor or other IOCTL initiated teardown is a NAK from my side as DMA-buf maintainer.

When you want to push forward with this anyway I think we need to raise this with Dave/Linus to get an answer if such an approach is ok or not.

Cheers,
Christian.

> The same is true for job fences that are in a software queue and never hit the
> queue of the hardware execution context.

