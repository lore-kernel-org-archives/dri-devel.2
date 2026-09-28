Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFED1C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F25610E92D;
	Mon, 28 Sep 2026 10:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="16tgGGhH";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42BE210E92D
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rfr2+gtyKZPNwKAczzHqSCaNVsDHrctz1aivBxT3AjsYdnynyFa9F/DnQUuJCPb6udZ+UjNMXvTj8YOUcFiCTEVomzPSvbu60XAZnxuLaXEbigsuilYXi8E38eRD10ucLQA+XXLu2QRAuIWHnEy9IIp2C3mzl9eQNBRNGsowbhNAaQ3EU+id3s7f8YDO/326prYW6J/IkV/NUeKfE2TrLFDVjYcdyQBUznBAOw0JZEkS+x4QtY4FlGcRZo7lTlC7Y8otWlW6dcS4jlqS/7/8Nzgn6N9hh5aIlVNO3/5iEf24Mxz3vlfvCv+RpuGnEjC/OjCxcqz8P4LdkkfQGTr01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJdIjuvaOGcx2DMmEzDSSyQMcQWd3XYAmnGuzp/bTYE=;
 b=O9hGQaN0GRflk+XR+v4UgJqFGh5zpNpSgi2B1guYKjAPjHSIiIH9V0BgfoEyq48mKNWa0DuxpywyOHozumZD626M3H6evMsJMvh0bqLAPy19loY+ngEwsOD6Pb4q+Z81kQzAkMMmioNXCfviVsH/9f7OTNK3swclhPgqd7hJ/asUiPmHENn52QMT+9O5YD+xYrr6yEuW7+G5oI63kSaD+zWBXePX2VQtZmKZFlDBgJ0g1V5xotbuQJJ9Obc+8vVcgDj1LdeJtlmiaWHR6nUN37cB6XZbIHf577G6qYwU3Ztg2F5g2I35iZ+8POginG8ZPZIHQDtVfZf/4vz6xUFfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJdIjuvaOGcx2DMmEzDSSyQMcQWd3XYAmnGuzp/bTYE=;
 b=16tgGGhHufmyG53Q/MCv7vzqmK5PNtDHrlumguChyj6kMQerrUUjjmJOCEiRfkFhqd05qPBppAqdEJnEazrjAnL4oAQWB/t3Nk1Scr7q8yRJ0DHTegaU+qZR4tEOjHYkykyqdhmK35v2/8zMnKpBj7C/I83igPbgtttFN0+3ebM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 10:21:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:21:31 +0000
Message-ID: <b16574e7-f8b1-4a2a-b063-7c565c0a9708@amd.com>
Date: Mon, 28 Sep 2026 12:21:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Synx: A global synchronization framework
To: Pravin Kumar Ravi <pravin.ravi@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-accel@vger.kernel.org, sumit.semwal@linaro.org, andersson@kernel.org,
 mathieu.poirier@linaro.org, konrad.dybcio@oss.qualcomm.com,
 faith@gfxstrand.net, simona@ffwll.ch, simona.vetter@ffwll.ch,
 airlied@gmail.com, matthew.brost@intel.com, srinivasan.shanmugam@amd.com,
 rob.clark@oss.qualcomm.com
References: <20260806051915.2234481-1-pravinku@quicinc.com>
 <CAPd7Qn3QYyrzBFFjB4+M9Je7uykYgxHiM+vh-mNVJ16QaoPkJA@mail.gmail.com>
 <2140e7f2-d329-4726-b593-72e935fca4f4@amd.com>
 <CAPd7Qn3ecF7+TBp4xDUoukVaDCjLjcDjVg+BndhqPN89i=4dUQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAPd7Qn3ecF7+TBp4xDUoukVaDCjLjcDjVg+BndhqPN89i=4dUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e2f11d-6059-4d2f-11bc-08df1d4a43f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yeUovYF8TSQK6uv0EWlV4StROwrCivq8vm0qwEMnebL4vKeGV6rxdFGRh5K9x5VFAbIgMpxu1or8FJ6CAkQaK3cbB/Ik/87AsWHdJ/MnOGHwABzGhQyq5ozg2YZC/cO38R0ih9Z+AewUyNZ2x3NKuLj9g/OYI8FenNaMpGzt3TYKCIwTMME1xkGLaFKRPX269nUrQW1WHDiHPcT5lk0vVYvYB41LiOCf0c9QKNy6+8n7j4hzCyyhJsqmKS+GaxAvT8hdevq0R1wRowmZcnXR1XKjt8L6D0nbhVB/3JVSiljJKuPKWY0Qslbymj8RRIewkpy85HMonjetArB6G++rhgH7lthW5odK2yQt0b/w8bFsNy31kJkdQJofcEiizOllOs7Fihs1TokLwUCbWx7fTji6/+8NiZL+fttEaoEJHnZ2dSLLauYPXKsbmuogmBJJmjQM6yc67RcgWGLiP5grR2fEGA1s4FwRthXZwN2makz0HdFBuX0Hotj9rceJUJHhrzgn+2DRMIooj5DahSylvzbWctVUq3aE4xcYHPSbwWwHLtuSLrYKkuivokA06Sbx3/HnxomjebvVAw8K1oCRsgTKRKX70JbujlYaDzE3LI3p3k3BaGEhb0k8dXoOPbm2YHmHlmTaK5MJZQJsVWIAdSnqiQLjuiuGtDXZc23hukU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWI0ejBvTXJwUWpPZERPWG1LK2NOOWhpODcvMVV1Mkk2N0xVYXlSS0pZTjd0?=
 =?utf-8?B?czVLWUF3ZmhTV20vUjJFN083QlRNQ3ZKamV4cHU0dEh0a1lvcDAzRWRodEpw?=
 =?utf-8?B?bDlGYlpUaTdMWU8rNXdDckdEdmVIOG9VclhZRE92YWhRR25SVEtMajV1QkRT?=
 =?utf-8?B?QUt3ZzNicmczNklJZkpYck9DeTNsSEEvclV4ZU5xOTQ5dGxEOHFxQWNaa0JR?=
 =?utf-8?B?K1VsSzdIRWRBaHRyUjlnMVNvMmNPM3doL2lBZ1dHSVNlbnRVZVV6c2dwNjJl?=
 =?utf-8?B?MmN3YUtQdUpYd1VUTDcwTUhTU3VjK3QxSGxTS2FMSXRtMUhyNy9BM1pLN05w?=
 =?utf-8?B?NFNWY2N2S25RUWJsZGtvNjFOczJrU09BMm9rWDl3QXpWbDhnTmphdkRjUWNE?=
 =?utf-8?B?Y0d3N21NbURyVUNSRS85N0xaNm1abDUzRE1ZZmxmZGFHNFh4ckdoSmtGUlJj?=
 =?utf-8?B?bW1CNFBWeWQvK1Azanh4NzdqSThqb3Frc0VwNjJmK0p1dmVBMmsrZFBxYStH?=
 =?utf-8?B?SWtDTHlJcU1KMnRMc21uekNmVFBva0tMdkMyT2RvU1Q5dTErdWg1UmR0R0Zm?=
 =?utf-8?B?UUtVb0tWcnd4MUF4eVJ2WXZBaGVpQ1haVnFacndzcWVMaXV3SmgzMjJPdm1l?=
 =?utf-8?B?cWI5eEVvUEdEYk1SajROZmQxOE5pWTZzOFRXaGFOVklJdzliM0Y5d0VOODJr?=
 =?utf-8?B?SmJ0c2wrek5xRXZ5VHhoNmpWMnFWQnhyekdtUVBIWGk4d3gwenJsd3dTQ3Ru?=
 =?utf-8?B?N041ZWNvK3dnbUFGRnFVVjkvY0hHOUx4M2NnMHViN1hjaEI1RkhqL1F4eUhz?=
 =?utf-8?B?ayt0WGlIQzFtV0lsSGloZ1Q2bmIvZGY3cytBME1sMnRhRE1JK0UxUGZzQ2FO?=
 =?utf-8?B?c3Y5QmYrWWhFTUNLZFNYcWp4R2ozY3Vtd0NNVWJ2VHFibUdXbWNLUk5MRjVR?=
 =?utf-8?B?YXpJd1pxYXp5L2EydGs4NmczcFVsWG1JUnd3NnZZR1FTTG5GendUQXQrQVEr?=
 =?utf-8?B?WWUyczNMM0tpSyt4ZHg0eVlYdWREbExydm9KQks5S1VXQWlzcnlLWDMxbFI4?=
 =?utf-8?B?RnVwaWVFam95Q2c5S0REM2trWlBvY21PNzBTNTRkV0w1Ym40emptelZZRVhw?=
 =?utf-8?B?VTc3cTVRcnB1Y1ZWVndSSDFQcTdnblFpd0FOZmNxUHFpV3dRdHphRDRTcWVW?=
 =?utf-8?B?QkxseHZoc2JscGlWRU1zREZzL0dURzVxZGFQbW8xVEVpNWtQZ0NUdDNDSEt2?=
 =?utf-8?B?RmtrV05HMzl4RGZkZTF5OEpMOWJCb0pGaTFROGVwcjVybjArcnpIZFYvYy82?=
 =?utf-8?B?S3VLL2pMNk96eWFDWW5TbHU2eUNPaWdUNkR2Ym9sTHJGS0lnUW84YkkwM2dy?=
 =?utf-8?B?RDY1Q0V3Y0ZHSmhQRzkwQytRZXdsSWE4VEhMNEt4ZFV2aU5MM3pHd0hSd0h5?=
 =?utf-8?B?Uk42L09FaWtyNUhncXFPVzZiK2tWbkUyZWVLOVRHRmZpeStBd1pGOWs0UlFC?=
 =?utf-8?B?T0FOQi9pV3dlZ2plTTd1K1RDbVJKVTJuMU4zS1JZdzVZUkQ2NnR3QnY4VVRx?=
 =?utf-8?B?bCs5SUQxTDdid3R5aW1UZFhwbCtTOERwa0RQazlieUZuN09KWFc4djZIUFFN?=
 =?utf-8?B?S1pPZW83V1JQT0RrVGd5N09ScE9FbHIreWNsNVJkNEpGb0xzaVBWM1RlSXBk?=
 =?utf-8?B?bGk1bTFuc3duckd4M1ZZUWRYeGtpeG5qbnA2WE8vVklBaEE0UFNGa1d4cjFx?=
 =?utf-8?B?MitSVlVjZmxLdlNKWGc0TnkvMW1aRWw0UEFJVlQ2a1UyZDNuKy9zNExEdEtV?=
 =?utf-8?B?ZGYzdjVlRHBOMXY4NWdMSUNIWmtmR0VNNXB6bUF6MGE1TzlmYkVES1hValNU?=
 =?utf-8?B?TWxvR2xDSDQxSlg2a1VBSmliWTVEZE5mSjZRbDhMd0l3UFBYa0MrRXJ3cWhU?=
 =?utf-8?B?UTkvQkp5MGNLT0RrbTNJQit0SzhuSVAxTU91WnFrellXQnVFdEw4QlpZcGNJ?=
 =?utf-8?B?VXFaK3NyRFN0d2VHMFczblN5TkoyVy8wMURMRE5WcjQrRU5CTWdxNkFacndT?=
 =?utf-8?B?VzRBRGM4OVFNNTZqL25LekFUL05VWDJsbUxmelEvSW9PVS94TVNoMjdTUUE0?=
 =?utf-8?B?VkZjZU9yOGlCYWtDV0ZjNTdqVHNEaTBNNEptcUdRVURJUEVFaENJMkdSM1p6?=
 =?utf-8?B?R2lJN0xKY3lSUTZENlpoQlhPdUo1UVFUc2VQSWVGMTJBNSsxYTM2U0w5Qy9h?=
 =?utf-8?B?VGZLTVNsb0ZFRDZPOGtXTE1DT1ZqWDJoUjB1VFZaOUhHYkV2SVp1d0VUMkk4?=
 =?utf-8?Q?n/8tnRpazXoK/fgrkk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e2f11d-6059-4d2f-11bc-08df1d4a43f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:21:31.6000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlAGKERch6ESUdVVsh9FEuPfnXr6kgbaG4nqrKxqpZdSh3gHHH4Y2fDMNmneiUcu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749
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

On 9/27/26 19:13, Pravin Kumar Ravi wrote:
...
> (Bringing Rob's September 27 reply from the parallel thread
> CACSVV00oBPN=rw1yVBjNm2TMHuQ+3iv84jKP4djQcnKRxcvWCQ@mail.gmail.com/)
> Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>> So I'm just starting to think a bit about this, since it will be
>> potentially relevant when we implement fwsched for adreno..
>>
>> Do we really need anything more than some sort of dma_fence signaling
>> extension?  Ie. signaling on the CPU remains exactly the same as
>> today, anything waiting on the CPU would see no change.  But if both
>> exporter and importer support the same extension, that can be used to
>> extract extra information to pass to fw.

Yes, I completely agree to you Rob.

The existing uAPI is perfectly fine to handle this use case as far as I can see.

I mean it was designed in the first place to handle this, so that is not so surprising.

>>
>> The fw might observe the fence getting signaled with lower latency,
>> but that's fine, there isn't really any guarantee (other than timeline
>> ordering) about the order that multiple waiters observe that the fence
>> is signaled.  We've just pushed one of the waiters down to firmware,
>> that is all.  Ie. something like
>>
>>    rcu_read_lock();
>>    if (fence->ops->signaling_ext &&
>> do_I_understand_this(fence->ops->signaling_ext)) {
>>       fence->ops->get_magic_signaling_foo(fence, &magic);
>>       ... pass magic to fw ...
>>    } else {
>>       ... same as before ...
>>    }
>>    rcu_read_unlock();
>>
>> If either the importer or exporter don't understand the same signaling
>> extension, everything works as before.  For ex, external eGPU/dGPU
>> sharing with say the on-chip ISP.  But if both do support it, the
>> signaling extension provides a way to extract whatever magic thing is
>> needed to do the wait in fw.
>>
>> BR,
>> -R
>>
> 
> Hi Rob,
> For operations that already satisfy the dma_fence completion contract,
> this looks worth exploring.
> 
> Christian, does this fit the case you described about known drivers,
> provided the participating drivers preserve the resource-lifetime
> and recovery guarantees?

Unfortunately not. The problem is that when you have HW specific signaling paths between your devices you also need HW specific recovery methods.

So for example let's say we have device A and device B and A can notify B about finished work using shared memory and an interrupt line.

Now let's also say we have a submission to device A which locks up, e.g. an endless loop in a shader or corrupted video bitstream gets the FW stuck or...., we somehow need to somehow unstuck submissions to device B.

When we have a CPU round trip for the signaling that isn't much of a problem since we can pinpoint what submission was problematic and have per submission timeouts etc...

But when you let the drivers talk directly with each other both submissions to A and B become inter dependent and you might need stuff like inter device error handling and resets.

That is a whole different beasts you are tackling here.

> Rob, could we have the shared signaling mechanism in an independent
> and generic synx_global.c layer? dma-fence can tap into this
> layer for the signaling extension you mentioned.

Well to be honest forget about your synx stuff. At least upstream I don't see that flying at all and I strongly suggest to the issues we are pointing out here into account for downstream as well.

You basically have repeated a lot of the mistakes we have already seen with dma_fences and re-implementing it in a different kind of framework doesn't make such problems go away.

The issue here is that your solution seems to work in testing for you but if you have fundamental design issues similar to what I have pointed out so far then that will sooner or later blow up in production use cases.

> The reason for keeping this layer independent is that we have clients
> who use reusable synx objects (signal same handle multiple times)
> which don't interop with dma-fence. And we continue to get more feature
> requirements from performance-critical clients around reusable objects
> with timelines. Assuming this is where global synchronization is headed,
> these clients should be able to tap into reusability via a route other than
> dma-fence.

Yeah that again is a complete no-go for upstreaming any of this.

That dma_fences are one time use and have clear state transitions was one of the things which has proven to be mandatory for correct operation.

What is re-used in the uAPI are containers for dma_fences, e.g. sync_file and drm_syncobj.

> For existing dma-fence operations, your extension could expose the
> information firmware needs for its wait, preserving CPU signaling
> and the fallback you described. Other clients could use the synx
> global layer under a separately defined resource-management contract.
> Would such layering address your use case while also supporting
> clients that need reusable remote synchronization?

Well what would be useful is a functionality so that multiple device drivers can consume dma_fences by utilizing direct interconnects.

E.g. something device tree or dma_fence extension based so that device A and device B can say "Hey I'm consuming your signals directly, please use this interrupt line, memory address for polling or whatever functionality we share and BTW this is the interface for error handling".

But non of this needs any new uAPI at all. That must all be inside the kernel so that userspace can't mess with it.

Regards,
Christian.

> 
> Thanks,
> Pravin

