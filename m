Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E872CC61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1139D10E5E8;
	Tue, 25 Aug 2026 12:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="arq0Uifv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D0610E5E8
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efyiE0hqb3IyZe+2hdnFLBkCSCn65O9Nr3oEqP/Fe/Nxsm5YzQX14N1xvxFBwFgUhhydd5ZBnU/4Cg7dZyuof5+xFHMGkDW46RkTxYP5IG63rk6Cw8BOaxtqCaOj6gPVt2mgIQBrPolbZflaFsbz+fHBzMuHEpu8rx2XxmZowMvn++CPPL1kXCC/pz1mdOBMX4/1mcHtXKH87y3Z3+VFIYjo//gy63PMr0sT+KZrvkGc5Hn6gQWoFfzbJptMHXR2vRoy+pfZfI4we5z95f+jowKoNxMeBiaasKXfgr8zSR9b6dQp238KiqPFcZjXWXCYJvmgFVm6f6bGwyrgYZ7U7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa3w34QikZCV+bqt5lOVM9nSXYXTupBtWuTfH2hk0zk=;
 b=IvotnX94Z+qmFQ2RtPY/eaSqp56oPmR2/FxhZFduIn3LjFNdud6CAaH8l/iQu8ACHVUn1SL9zAcoYwJnvo8mS/WwevhOhc1Sh4kvSp0tij98kbSdhQx0EE4i4ooU6nQDnFwsXiVphS01qqogPWmNf2eiAWo6J3ukNUpgLFz4tIb+MDir1SnB05W+iuQyejY0CPe4BzbDVYtZUMKb+90R5rb8m/3E77oQYF4IFOd9AbWSOXZQza/pku8Su9B8ERt/nzrBFHE5q0aHuyyOY+OLt4BnLUDZlf5/gG+0IcPhyNIGxRyQJiq5t2nladY2mobLiO0BvGcvv05y22n40W5Elw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aa3w34QikZCV+bqt5lOVM9nSXYXTupBtWuTfH2hk0zk=;
 b=arq0Uifv0IRRekfj8pkfAuP7dSbL+eTQoEqptG9S0OGwMg0/YK0CKmR8iiQg+Rx/OtTd4Zmoj27xXh+/MzzE/HT8rk6+FOaiLZLfT+x4imAXshNQIGjIC5Xfk3X/sY4RNo9VdFEcpMrPr1fqzFakQQuroafQNm7QIkn1ZzaYf4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 12:13:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Tue, 25 Aug 2026
 12:13:48 +0000
Message-ID: <2140e7f2-d329-4726-b593-72e935fca4f4@amd.com>
Date: Tue, 25 Aug 2026 14:13:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Synx: A global synchronization framework
To: Pravin Kumar Ravi <pravin.ravi@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-accel@vger.kernel.org, sumit.semwal@linaro.org, andersson@kernel.org,
 mathieu.poirier@linaro.org, konrad.dybcio@oss.qualcomm.com
References: <20260806051915.2234481-1-pravinku@quicinc.com>
 <CAPd7Qn3QYyrzBFFjB4+M9Je7uykYgxHiM+vh-mNVJ16QaoPkJA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAPd7Qn3QYyrzBFFjB4+M9Je7uykYgxHiM+vh-mNVJ16QaoPkJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 10282248-fabf-4bf4-90af-08df02a25185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|3023799007|6133799003|10067099003|56012099006|5023799004|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: b/dh6TnVa1T0HtPjtC/brtituJKGFePxhBHekRYpaCS/NJMVTZ5CK7ar1LD4z/pEWIrg7glOwPR1DVbjdyI82KNFpIEJ7ij3acz7+eMO7g9Di/dpB5eCGef9LoW4IkFJ9FuKeMHwlghgH4Z01NY6/N3zPI5ogwWyrLEUZTMk++y6Nb2Rnd+6P+EZDWQ55Uz126D5NI9uERUhy1hVCk6R6LdfQDuwxUvqerFmqclQG+iQKQE1dRTqJDIAe75J1f5JR2KiN7XP0AJx6Zrw5tFTScx9WA3sQcjRu8Eid7qlE8jUUxGft30WpJsVkZbwMMqDRk/gpoGKBTWj3LYpl4jvaUn3P8pMzrR/C7WnI7qxt6ppwPPLF/CV9qkUHioFAu67WZzfXfordm0JbHVBDpWQpJ95CnDyI8cRJdYZSHawIKiTm04IN9SZDNpJ3or60WtwPPs7xvmlIhXNh7A4Le676SADFDyEp8OiE8lBZm8oIbRm3CKwGbdF7QF7WGouyFmoyAHDvOX4xeGgAxPqYqh6x5kOZEGAfI8WrlMeGcuJaEGMcd7kpvxtcUEaWGgCAHvvxkeDXIOrOGDkIzVFoYiXLpF7VA/dZRzy9O4i4DHnn2df/410c0YMSL84ZkQaFt0w5XJX+O6cfgR5hwloibmEZx9UCYfmhfAByoyFyw8v3VE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(3023799007)(6133799003)(10067099003)(56012099006)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHdWb1BySk5aZWJIVWpWMnpPdDU1dGM0dkJQS2pISm5RMnQvNXNZU25XN0VD?=
 =?utf-8?B?dWFhSWVDbGwyK01vMFNJaVBVSlZXdTY5UUNMd1hnQ1M2SWtPWXJRRnlKQTNz?=
 =?utf-8?B?cUV5bHlkY1h2cTFzZGpCRmZmd04wQ2dma2JXT2Zjazhybm15VzJKamRCbG9L?=
 =?utf-8?B?bWdHbjI2TUFzS0xBbkxLMmsxcEtWR2M5SjlwbVExWkpFWHJHYVhUWmQrZDJL?=
 =?utf-8?B?cTBxUGNBT1hNZGFNMFJ6cTJNUTlRNzVxVUtIV0RQSXN4R3NyN3oxQ1ZmMEd5?=
 =?utf-8?B?WWt6TFFkQzNleHJoT2JzWld5aTJmMVBMUEswUFk1a0VnN3ZDZ1IwSlVDVExJ?=
 =?utf-8?B?Z2dhMWhUY3A2ckhkMnJyZGVMR1BTcFJLWDlPOUpjMzh4a0hhVWFIQnI3N2cz?=
 =?utf-8?B?QVlGOXJpMHhuZC9zSDVXNlZKYVZxaFYveFAxVXFaK0h5Y0wwWEJwWElEVUVO?=
 =?utf-8?B?cEJsZ1pKaU1lMzhhNnAyRW42WXlSWk1VL3liVzNxRmpTSmVIcWhrN0EwcnZs?=
 =?utf-8?B?MG1OWE5SV29DcE5jYWczd3JSb0JKbDFxQXZZNGs0QzFBeURSRG5xbUd6RmF6?=
 =?utf-8?B?OHMxZEwyQlRuT1F0bFFhSkE1MXVxcHhYVkl2MStyWjJkblE1YzdnM3ZFdFd6?=
 =?utf-8?B?UHlWc3lCVjl5OWFQOStzQ1lOZ1dyQmJUQXFUbGIxSHE4VHlaWkJFK0hhWUUx?=
 =?utf-8?B?eTVJMHNpd2p0TVBhVFlyOU1xY2tiVmJEN1AzazU0bVJoN2h4dTFKTUlRd2VW?=
 =?utf-8?B?aE40Z0V3Q2l2cit3K25wcHFvNFdyeUhMYVVCSEpRTzRQNVYzYWV4dVh1dVlk?=
 =?utf-8?B?T1dteS9KanJLUGtYc1hJZU1ZbktKZTRWVlpPN2hwZlUwWjYvT2ladW5Rd0VO?=
 =?utf-8?B?emw4VVdpSUdiVUozOUJhTHVRbmkySUtweE5FTTNUNmVXNGZxZU43K2dkRUQ4?=
 =?utf-8?B?dW9ZM0ljbGRRMmZrSWRWcnZXQkloTG00eWVkaytrVXF5bzdVVk9jelNWK3hL?=
 =?utf-8?B?RmZwc1JCTHFiOS9nckNGbmRkR0JxaVhYeGxhVnFKbVYvaGhDajh5VFZwU3Uz?=
 =?utf-8?B?ak1wZS9kcVJLWXQ3bVJFcjBIRGZpSktYdE9iakJ1bW1kNzNxM1d2RGg2cUx5?=
 =?utf-8?B?ZWViYlBkelREMnZza0ZMdFVWajkzdlg2VzZzK0xJVmhjRTNhc29DcUZWZEtn?=
 =?utf-8?B?cmJ2N3R5dU1HY2orQmlYSG5aUU1JNFhmODNNWEIwZTdhUHN6RFJIcnoyb1JD?=
 =?utf-8?B?TkNzS01KQzRpTVV4L01wSS9Bc0VXZUZIeUFtMk1yZ2hwVlZNb1pORHJYMHpF?=
 =?utf-8?B?VEdkejN0NDREWGRYM3lLMHY2QUpzYlVyWWd6dVFHZ0VLSHhGSVJ6UTdqb2Rh?=
 =?utf-8?B?a1lGbW94MGNSYUhMcGFzT2JQMGdNU2VjOWdKTVVBMnZBZDNBSkhBZTQ4Q3hS?=
 =?utf-8?B?ckhHN2NFWXp4NXdjME54V2g4ZE11WlFtMUJrTEJmTnJFU0E1Q3lGNFQvVDho?=
 =?utf-8?B?clQzdXZWbURNR0xoVk9pSmJMNWx3TGcybHdKcFBmbjV3TWkzVjZRZUNDZFJq?=
 =?utf-8?B?QmlwaWViYlJyZG9OKzcyWjdqSEx5SVVhbC9OcmpJN0crc2hab3VBVUs4bENh?=
 =?utf-8?B?WkdLb1N5L093d2U0YW1zbmJnZjA0SGp3T3p5UFlEdzRjekZIaWNYNWJ1M2FH?=
 =?utf-8?B?OXRyLzkySnRadEZhL3RJYVZnUk1hN1FXdTFPS2VKMUhDMnYzMEcwWjNRZSsx?=
 =?utf-8?B?ZEh2QzFTbTlRemhqL1AzRTVrbVJYVUpPNk9PaEJvUFRrSDJCYlVJcnNjS3lG?=
 =?utf-8?B?NGJjUitHWmoyUTRlYkxmZW05WU11N3gzV2NubHgyckRWMHg4R1NLNXUwRVdj?=
 =?utf-8?B?V0NuMmJjWWhDQ3Y4U1VoRGpsYUh5czQyM3BIM0tONDlKL1pHT2FTSXVRWWlY?=
 =?utf-8?B?KzAycDVvRTNLdmU4cGR2V1dkYnRHVm5NaFZMRFRSSVA3UXh1YWY1a2NQUVNz?=
 =?utf-8?B?T3Jzcy9wNDliRXBoTG1NQ3dSc0lyc1I3L3FSTVY2NDRrMVBuY3BpNklaa0I1?=
 =?utf-8?B?cDlUN1p1VXJYZFpna0NWS3NPLzUzYVZ1WmtKRUYvV3Y2NVYyK29CV2NZNFBy?=
 =?utf-8?B?dGhBZnZFcDdxM050UEVtMW1PMUFpV2hMSkxZVDNIRDZKdk9VQnYzUnE1OVV2?=
 =?utf-8?B?YlNoS0F4VVpmeDhxQkQzV2psOHcwYnNLQ2JEdlZyL2c2TXJrdmU5VUdNWGJz?=
 =?utf-8?B?UlYwWXhFcVJwN1VnbW1nQmZhRkdDWk5KbzlrWC9TK3V4ZDF5UHcvdVp3ZWg4?=
 =?utf-8?Q?cM5O4Hr/NGeYdKWeMB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10282248-fabf-4bf4-90af-08df02a25185
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:13:48.6620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSRx4l9QMVSv74h5xXPYMDXsDGh0LkHWnIEaxg/SSG+2jngDw9pcupKEH3QL27+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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

Hi Ravi,

On 8/20/26 19:59, Pravin Kumar Ravi wrote:
...
> (1) condition to assure point-to-point signal completion : remoteproc's path
> to signal must not depend on Linux memory management i.e. every buffer the
> remote touches in order to reach the signal is committed before the fence is
> published, with no on-demand faulting and no allocation from a Linux managed
> pool. Wherever this does not hold, the handle must not carry a dma_fence.
> This condition is what makes the amdgpu user-queue fence driver
> (97ff19462539) legal: the memory firmware writes into a pinned kernel
> BO allocated once at init.
> 
> (2) the condition wants to be enforced in code so that reviewer and
> lockdep can check. We would make it a per-remoteproc capability and
> refuse to attach a dma_fence to a handle from a remote that does not
> declare it. This is how Xe refuses out-fences backed by dma-fence
> for a long-running VM. Composition would follow the same rule: a merged
> handle is dma_fence-capable only if every constituent is.
> 
> (3) on top of the point-to-point signal, the remoteproc's Linux driver
> has the obligation to complete the dma-fence within a reasonable time.
> Interop fences can't avoid CPU wake-up but standalone synx handles can.
> Interop fences benefit from the low latency in point-to-point signalling.
> 
> (4) to handle remote hangs that aren't related to memory, we need a
> watchdog armed at the dma-fence initialization which upon bite prevents
> further submission and triggers remoteproc recovery.
> 
> Please let me know the issues in the model above.

Well to make it clear I would NAK that approach from my side as DMA-buf maintainer.

We have tried that multiple times with the same extremely disappointing results.

> And to extend beyond the above conditions, the following proposal
> from you (which hit a deadend) seems very relevant.
> "Tackling the indefinite/user DMA fence problem"
> (20220502163722.3957-1-christian.koenig@amd.com)
> Were/Are there any efforts to resolve the challenges that are open in
> this thread?

That is simply not possible. It is basically a re-occurring topic on every XDC conference of the last 10 years or so.

>> What you can do is to do this in userspace with DMA-buf and user>> space fences, signaling points etc... Take a look at how user space
>> waits in XE work, how eventfd works and ROCm events work for an
>> overview and maybe some starting ideas.
>>
>> We could certainly build a framework around that, especially
>> eventfd sounds like a common ground to most drivers already, but
>> please stay away from dma_fences when you want to do something like
>> that.
> 
> These pointers are helpful and we can start looking into these.
> We could keep the dma-fence interop discussion open and move ahead in the
> standalone and memory fence direction. Will share the high-level design.
> Please let me know if you need to focus on anything in particular.

Essentially you can have two different modes of operation:

1. Preallocate resources on work submission to the HW. This is what the dma_fence framework implements.

The restriction here is that you don't have any dependency to userspace or other device drivers, e.g. no page faulting, waiting for memory values etc...

Background is that the core memory management depends so hard on the execution properties of the dma_fence that none of those advanced features are possible without breaking core assumptions.

Inter device operation is only allowed if the device drivers "know" about each other, for example between rendering and displaying pipelines.

But we have intentionally rejected any approach of generalizing device to device signaling in a framework because it makes dma_fence practically a recipe for trouble and we have more than enough evidence to confirm this now.


2. On demand resource allocation using PCIe functionalities like IOMMUv2/ATC/ATS/PRI or device specific page fault handling.

The point is that you can do things like generating commands on the fly, long running jobs, device to device signaling etc...

The only restriction is that you can't create a dma_fence with this as output, you can only consume them as input to the operation.

There was also an absolutely great presentation on the topic from Faith on LPC a few years ago.

Regards,
Christian.

> 
> Thanks again,
> Pravin Kumar Ravi

