Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25904D3517F
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC45210E90D;
	Wed,  1 Apr 2026 20:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dF9Y1AwL";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8B210E5CD;
 Wed,  1 Apr 2026 20:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnBxc2XwFKZBO/pm0GBwVVhrmv7yliMCz3Q8gKPhoSDn1x10xEZc0lUzJKU2SL4TlSMEvKy4Y6x3zDaClYEIPl4Yv9Xf8H3raJV310kn8B72MV4r+QrXbyLEr0BvMEFTu1vUcX91wKPg7a1yJNdDCJZu0UNYd5rpUc91u+FxlqS32Uk8OcS0nlYmFuHDhj1emAJniGVBEj8HTK92zWV93G6pKwkfVAW7enznw/1iOB/Cjko+tpuxVBsH8W7ZbXMUSyWf3t8TwzZ/sXvzOj87wrEaZtwYcAs9XsjBnoz+olJfvcSa5gVaFhKHrvwgYppj5xLBQnzoGPXdZCm6T7aNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsBJT/Em8skk6q552ZPA8UnfgSb1z7Ed2IUmXbFTv3k=;
 b=udUZI+XctFX7wOZwh/9Qw+YfhIWZXuDUOo8o0Z/Mkvwn+Pj9A+7IVYD0pITnTQnWgwbuUn1URIHNHJHJFjYs8zaSzI5iq55SqfeSgle9XFABgcUIArEw9g3aj8Fu3qtzBUUgotPMoBeP2/StA5rXgtcewI2k4EnSGRoIBNWd0jwMkFR6kS0634jbXcWaqiSkqLXI3Vkdt2ZTVi9DkpxUEuNhdqPtur9LfsEWKsg2ggvmjKcvYPAKinq4ExRPP2+zpwdLe3E3hE5+HBYCWGN1vdnAqJgQNEY+udC0gLf1MphWi0TH8gDKUMwbfiMzM8x21H1y4QWdVelMD4hprYV4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsBJT/Em8skk6q552ZPA8UnfgSb1z7Ed2IUmXbFTv3k=;
 b=dF9Y1AwLvvvplvkI3QUjH+pqyhR+TukSFQOuD8ISHVWQ0tQnQa6IJWrVyrIl4tSZ1kVRTk4olt6Xlb8VSaHx2k+flPLjFymZ6uZ5lUd3q1/ua/6lsPfqnhxXgQfYdrwxrC2wvE/N021rsO9+vN3s4vpZdLoCndjTHq7wuOjCfVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 20:01:10 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::715:65fb:c3fa:9c26]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::715:65fb:c3fa:9c26%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 20:01:10 +0000
Message-ID: <9ed0f453-23ad-49c0-9ad9-c14f1999dba2@amd.com>
Date: Wed, 1 Apr 2026 16:01:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/29] Fair(er) DRM scheduler
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, intel-xe@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Leo Liu <Leo.Liu@amd.com>, Lucas Stach <l.stach@pengutronix.de>,
 Matthew Brost <matthew.brost@intel.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
References: <20260306163445.97243-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20260306163445.97243-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0423.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 664fe0a0-40ba-4bd9-1a35-08de90296b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: y6HV8PQZeg37HpH84h+lEK9DSVCGQm2u4DdOZDxyeYYRADVihvgMVYmZxG+lu32O4EQ6HXELXmA4NNmhY0fhmlTo5JDlAb490D3fvFwQe9YEW4NeLxn3YCY61nNsNsHqdZ5IN5RtUXmWx4EUGfBO4cQXWxeyUL0qXBXhu2E8pXZqd2kyBPoMA6KgAUfa+MncOjIiYPfhi3Eo32fIE3cmiXkH2x1SBfXEB8J+/NZrPGbHUHEAgIECZfB3G55bXv3SJ2tLqmVmgMcJVgm1a2GtlDjYNscCF0WvCPhSoJjp7P97Q8QummhdBtLCttziiobiRX06iyIgFUnXLtTwu1I9bqgu4pmEs8YddOIXLXb0qQOEnvgLcuoQfMalBbKKYoyt64bPVQ5k1iOhu3WDEn885NeBkJiMNv14xvbdk+vfuLzAybJfe34OvmrosFlEwkqBVd9EZpWIDCW78gzUMkt7I1xdzB0ksZy3IJR+6Zg3MK9Tuv0qkEgBIIH6IGNOyHenOAyBAK9iu/wmymLXJiptVLbVUjogFm6mjwIXlSIdT/1ORlGwepdJR219Z1mUoJnoiA6YsjQgWPQ+cHRx1iVj58ekXyNd2lFSpDmd/q306x3gkrkbvpuTkrNDpj0nHjAOtuCm2W4bIAIhCJ5/eQfKsZWztwebeVfFOb4aaUA2SPQtc4KLLVkdTS5R/EEAsrnZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bENaSjVadGxmYTZIcmY0N2tQNklpOHhLdTRRb1FoU2ZTb2JyWDRJcDRJVWxm?=
 =?utf-8?B?cDJJWU5leUhINmI4YVd6TVJXcW1GM3ZrSDhZclMzRm14TVgyTmNDY2JiZVJj?=
 =?utf-8?B?QVNTU1M0UGQ5VHZpSk16Vm0vSFpMQU03L3IvUDhtRzdFbVNxZXUzMjZnRE5G?=
 =?utf-8?B?MFhqams1cE1tZHd2MzQxTVQ5YlZPZjRYaVZoL1RPTFF0c2IvNm5Xd1A4YTdE?=
 =?utf-8?B?QkhkZkxaUUg3Wit2OUpwMEdESVNWY2w5TU5xcmxVc0M0U1BWZ3lROHdnZkxw?=
 =?utf-8?B?Y1ZHdlptcEk2bVg1TUR2RWRBbzhyeWYxdjN4MHZmdUJNYVJBVzJubnNiRjJu?=
 =?utf-8?B?VjloT0lpeHNsREtvbnN1bTFWaG5FNk9BbGN0TjAwcTdOdU5URFZ5SkxzS0hH?=
 =?utf-8?B?TGJvMnlOeE1VN0JTblNWNE8rQXhmOEhhK01tVXpLOHI5ZzRJUFNBUW9TbGE4?=
 =?utf-8?B?TjFKVFN1MHE5N3QrNWFrT2lzNzBaOVkwVkJlbTBBRjUwZHNLR3BrV3RYTHNY?=
 =?utf-8?B?UHdVQVErMVZKUjZMR2dUWUVLeTdRNWNjbVdKTUo0cHB5QXlyYnF4Q0daak1p?=
 =?utf-8?B?aVJ6b2J4VGFDREZONExGUzkzWndERTdYdUJvTTM5MW9mM3hjTzB3VDNORzhI?=
 =?utf-8?B?Vm1XSTFkcFNMWlc0bGFxMC9YcTkwZ2F1RVJzR1VCU25XV1UvWFFHNlFUSzNH?=
 =?utf-8?B?ajV4UkJEa2NiVS9aMUVoejI0QktYcmlZd2phd3NzZit0RnN6MVV1TkRrNnhp?=
 =?utf-8?B?ckhlWGFUUmMwUllQcnpVVE5XbmQzVlFnWEpRdHVMY2Y1NnErNUVxODVZVVh2?=
 =?utf-8?B?ZGFFVXB0VEROViswdzAxQmJrVW1OV2V3VlFIRkZ0V0hzVStPM1R1U0FWMGg5?=
 =?utf-8?B?eEl1Q1R2ZS9GL0ZCT3FubVkycURFYlhrRjhGN1ZZMTlCMDVxempYMFZNVkNq?=
 =?utf-8?B?NnJlVFBjNEdvTUFUN3NmbEdZYmx2ZnEwenBDMVNQMHNYOGRuN1FMN09NZ2Y1?=
 =?utf-8?B?VnQxb3BDbjZ5SEpKY3BSWHcvc05NUkFMSmJkbVBYbDhRbXd5aXh4dUdjRFZk?=
 =?utf-8?B?V0w3Zkt4bWdCS0VuTUNzU0pBNlYycVhWZXV0T0pWeDZCcjdsamV2Y3MzREFT?=
 =?utf-8?B?T0FKSjRveFBUU3V2Z3NEYkV5VDdKUlUxWlRmMDlZWlpZMkR4UkhaeXYxdkhJ?=
 =?utf-8?B?UnNmTkFzY3BFbnhhbS9hSG9tZkJRTHIvckNlaE8wV2xhNmt4YWkvbFZHWnJy?=
 =?utf-8?B?SlNuL0hnRS81WWNaQndsSytrR2xTTVlVMkdtYTNnZjJuSW1pRDdXSDdKK1Jl?=
 =?utf-8?B?aktpaWhlYzNRb0hqS1Vka1RWZWhLb2VZZFRQQ3dRaFhmY0VKSGJPc0ZNNlda?=
 =?utf-8?B?VXpBS3ZJR0VVQXBOMjBxTGxjQ3NsMmNDMEp6SWRxWmRaVkhJNHpXUmNpK2Vz?=
 =?utf-8?B?aldvQ0xlNTVwcEZkZzhNbmxLblYyTkJiOEw4OUk5UDFoZ1VaYkJkVFliSkRP?=
 =?utf-8?B?alNmWVgva0dzZVlmZzc5QkxCaWZKcUtCWlFFNzlFSHJHZTFKU3FuY3dWa1lG?=
 =?utf-8?B?RE1oTlh2YXU0MWhMWjhLUGN5MUVZcm9ZazNVcXk0cDVnYUgyODBBN1pFSGF0?=
 =?utf-8?B?VU9Hcm0raUpkVGJtYTZSa0tkNHJYSFpyVXpFRXZ3OXljQjBGT0dWYmhxM0pD?=
 =?utf-8?B?SGtzMThJdFhydFZaSTlCejk5THBnWmdGUHFsRktyaEpMcUhDaGdYNS8yZ0J4?=
 =?utf-8?B?NmdmTHZXVlhWRlU3Vmp2T1RxL3JUSXRDandkLyt4MkZ1NDI0cWQ3c0FNS3Vo?=
 =?utf-8?B?TmIxd0dzUFBqRFQvcTZnS2RVVEZqc1ZFRTRlNEFDeEVRK0hjeVpOdlpxVlk2?=
 =?utf-8?B?YmVLWG9UeUNiU0laTWEyUzAwYmtRTEl1MWJ6d2U4dWVtOFN0Um1VbCtrNlhj?=
 =?utf-8?B?MkpOVVlpeGhxTkQyakZneU1xN3FCNEVsUXFRL3lFK21odlNsaHJTRkJQMkRp?=
 =?utf-8?B?UjNVZjZwL1lPdThwTm5oK1U4ZUNOUzh4MVdMOEdMcFZlSnlNbUdmR0FMamRS?=
 =?utf-8?B?VnIrMFNYbEFBb1c1NXRBRFpvdEh4VVpqNGJBN2h2UDg5Qy9JK0RCTkpqYXBK?=
 =?utf-8?B?TjdpY1ZOdEtHQ0JDT2Q2L2RwZFI3MjAxYzA3SWZpLzJvTFd4VlZSN3p4YmtB?=
 =?utf-8?B?eXIzQXJwK2NvbTV1endHbXdZaGdMRXh0dXFudStWazU1QnJPWkpUUmVzY29n?=
 =?utf-8?B?aTJrZnhwWGQ2Qk5hSmt6czNvdGR5dmVxRFRZWXRwRTR1SG11OXNaekl1ak5P?=
 =?utf-8?B?cElZOWFoRGtBNkFzcjhqay8yV2xoUXo0cXVKQm4yeWsvN1Z4bXBWZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664fe0a0-40ba-4bd9-1a35-08de90296b1d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 20:01:10.0761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 237jFsobhwm5aFf20YgzXbPyOk7fIqtyI7nlbubSPIiUSEF9jJJxxv6Rugy2EHfKxhrswVbJyRg8/5BLqmtlOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228
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

Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Tested the 29-patch scheduler series on our CI; no issues were found.

Thanks,
Vitaly

On 2026-03-06 11:34, Tvrtko Ursulin wrote:
> [disclaimer]
> Please note that as this series includes patches which touch a good number of
> drivers, I did not copy everyone on everything. Assumption is people are
> subscribed to dri-devel and for context can look at the whole series there.
> [/disclaimer]
>
> As a summary, the new scheduling algorithm is insipired by the original Linux
> CFS and so far no scheduling regressions have been found relative to FIFO.
> There are improvements in fairness and scheduling of interactive clients when
> running in parallel with a heavy GPU load (for example Pierre-Eric has one
> viewperf medical test which shows a nice improvement with amdgpu).
>
> On the high level main advantages of the series are:
>
>  1. Scheduling quality - schedules better than FIFO, solves priority starvation.
>  2. Code simplification - no more multiple run queues and multiple algorithms.
>  3. Virtual GPU time based scheduling enables relatively simple addition
>     of a scheduling cgroup controller in the future.
>
> There is a little bit more detailed write up on the motivation and results in
> the form of a blog post which may be easier to read:
> https://blogs.igalia.com/tursulin/fair-er-drm-gpu-scheduler/
>
> First patches add some unit tests which allow for easy evaluation of scheduling
> behaviour against different client submission patterns. From there onwards it is
> hopefully a natural progression of cleanups, enablers, adding the fair policy,
> and finally removing FIFO and RR and simplifying the code base due no more need
> for multiple run queues.
>
> Series is structured in a way where we could apply the first 12 patches (up to
> and including "drm/sched: Switch default policy to fair") in one kernel release
> and then follow up with the rest of the cleanups after a release or two if
> things will be looking fine. Until the remainder of the series would be merged
> it would be easy to flip the default algorithm back.
>
> Onto the performance evaluation. As a headline result I have tested three
> simultaneous clients on the Steam Deck:
>
> One instance of a deferredmultisampling Vulkan demo running with low priority,
> one normal priority instance of the same demo, and the Unigine Heaven benchmark.
>
> With the FIFO scheduler we can see that the low priority client is completely
> starved and the GPU time distribution between the other two clients is uneven:
>
> https://people.igalia.com/tursulin/drm-sched-fair/fifo-starvation.png
>
> Switching to the fair scheduler, GPU time distribution is almost equal and the
> low priority client does get a small share of the GPU:
>
> https://people.igalia.com/tursulin/drm-sched-fair/fair-no-starvation.png
>
> Moving onto the synthetic submission patterns, they are about two simultaneous
> clients which broadly cover the following categories:
>
>  * Deep queue clients
>  * Hogs versus interactive
>  * Priority handling
>
> Lets look at the results:
>
> 1. Two normal priority deep queue clients.
>
> These ones submit one second worth of 8ms jobs. As fast as they can, no
> dependencies etc. There is no difference in runtime between FIFO and fair but
> the latter allows both clients to progress with work more evenly:
>
> https://people.igalia.com/tursulin/drm-sched-fair/normal-normal.png
>
> (X axis is time, Y is submitted queue-depth, hence lowering of qd corresponds
>   with work progress for both clients, tested with both schedulers separately.)
>
> Round-robin is the same as fair here.
>
> 2. Same two clients but one is now low priority.
>
> https://people.igalia.com/tursulin/drm-sched-fair/normal-low.png
>
> Normal priority client is a solid line, low priority dotted. We can see how FIFO
> completely starves the low priority client until the normal priority is fully
> done. Only then the low priority client gets any GPU time.
>
> In constrast, fair scheduler allows some GPU time to the low priority client.
>
> Here round-robin flavours are the same as FIFO (same starvation issue).
>
> 3. Same clients but now high versus normal priority.
>
> Similar behaviour as in the previous one with normal a bit less de-prioritised
> relative to high, than low was against normal.
>
> https://people.igalia.com/tursulin/drm-sched-fair/high-normal.png
>
> And again round-robin flavours are the same as FIFO.
>
> 4. Heavy load vs interactive client.
>
> Heavy client emits a 75% GPU load in the format of 3x 2.5ms jobs followed by a
> 2.5ms wait. Interactive client emits a 10% GPU load in the format of 1x 1ms job
> followed by a 9ms wait.
>
> This simulates an interactive graphical client used on top of a relatively heavy
> background load but no GPU oversubscription.
>
> Graphs show the interactive client only and from now on, instead of looking at
> the client's queue depth, we look at its "fps".
>
> https://people.igalia.com/tursulin/drm-sched-fair/251008/4-heavy-vs-interactive.png
>
> Here round-robin and round-robin rewritten on top of FIFO are best, with the
> fair algorithm being very close. FIFO is clearly the worst.
>
> 5. An even heavier load vs interactive client.
>
> This one is oversubscribing the GPU by submitting 4x 50ms jobs and waiting for
> only one microsecond before repeating the cycle. Interactive client is the same
> 10% as above.
>
> https://people.igalia.com/tursulin/drm-sched-fair/251008/4-very-heavy-vs-interactive.png
>
> Here FIFO is even worse and fair is again almost as good as the two round-robin
> flavours.
>
> 6. Low priority GPU hog versus heavy-interactive.
>
> Low priority client: 3x 2.5ms jobs client followed by a 0.5ms wait.
> Interactive client: 1x 0.5ms job followed by a 10ms wait.
>
> https://people.igalia.com/tursulin/drm-sched-fair/251008/4-low-hog-vs-interactive.png
>
> All schedulers appear to handle this almost equally well but FIFO could still be
> the last while fair has a slight lead.
>
> As before, I am looking for feedback, ideas for what other kinds of submission
> scenarios to test, testing on different GPUs and of course reviews.
>
> v2:
>  * Fixed many rebase errors.
>  * Added some new patches.
>  * Dropped single shot dependecy handling.
>
> v3:
>  * Added scheduling quality unit tests.
>  * Refined a tiny bit by adding some fairness.
>  * Dropped a few patches for now.
>
> v4:
>  * Replaced deadline with fair!
>  * Refined scheduling quality unit tests.
>  * Pulled one cleanup patch earlier.
>  * Fixed "drm/sched: Avoid double re-lock on the job free path".
>
> v5:
>  * Rebase on top of latest upstream DRM scheduler changes.
>  * Kerneldoc fixup.
>  * Improve commit message justification for one patch. (Philipp)
>  * Add comment in drm_sched_alloc_wq. (Christian)
>
> v6:
>  * Rebase for "drm/sched: De-clutter drm_sched_init" getting merged.
>  * Avoid NULL rq dereference from a bad rebase. (Maira)
>  * Added some kerneldoc throughout. (Maira)
>  * Removed some lockdep annotations not belonging to one patch. (Maira)
>  * Use dma_fence_is_signaled in "drm/sched: Avoid double re-lock on the job free path". (Maira, Philipp)
>
> v7:
>  * Rebase for some prep patches getting merged.
>  * Dropped submit all ready jobs patch.
>  * Fixed 64-bit division in unit tests.
>  * Fixed some more rebase and patch re-ordering mistakes.
>  * Preserve entity RR order when re-entering the queue.
>  * Fine tuned the queue re-enter logic for better behaviour with interactive
>    clients.
>  * Removed some static inlines.
>  * Added more kerneldoc.
>  * Done some benchmarks in the round-robin scheduling modes.
>
> v8:
>  * Rebased for upstream changes.
>  * Added assert for reverse numerical order of DRM_SCHED_PRIORITY enums.
>  * Fixed head of rq priority updates.
>
> *** RFC -> PATCH change log version reset. ***
>
> v9 / v1:
>  * RFC -> PATCH for the series as agreed during the XDC.
>  * Updated interactive benchmark graphs.
>  * Improved handling of interactive clients by replacing the random noise on tie
>    approach with the average job duration statistics.
>  * Document in code why we track entity GPU stats in a reference counted structures.
>  * Document the new structure fields added by the fair policy.
>  * Undo some tab vs spaces damage.
>  * More accurate wording in the fair policy commit message.
>  * Default to fair policy in a separate patch.
>  * Renamed drm_sched_rq_select_entity to drm_sched_select_entity and make it only take sched.
>  * Fixed kerneldoc after removing scheduling policies and renaming the rq.
>  * Reversed arguments of drm_sched_rq_init and cleanup callers. (New patch)
>  * Removed unused num_rqs from struct drm_sched_args. (New patches)
>  * Unit tests:
>    * Added wait duration comments.
>    * Data structure comments.
>    * Better name for a local variable.
>    * Added comment to the short job duration assert.
>    * Added comment for cond_resched().
>    * Tweaked some comments
>    * Added client_done() helper and documented the READ_ONCE.
>    * Clarified cycles per second calculation.
>
> v2:
>  * Dropped the sched_rq_init() argument re-order patch.
>  * Pulled run queue management consolidation patches to start of the series.
>  * Drm_sched_rq_get_rr_ts() renamed to drm_sched_rq_next_rr_ts().
>  * Added DRM_SCHED_PRIORITY_INVALID local define.
>  * Added locking around the ktime_t vruntime read.
>  * Expanded comment relating to the unlocked entity->priority read.
>  * Expanded comment relating to the unlocked scheduler average job duration read.
>  * Various kerneldoc tweaks.
>  * Undo some tab vs spaces damage harder.
>  * Undo one empty line rebase damage.
>  * Reworded commit message for the FIFO and RR removal patch.
>  * Various commit message spelling, grammar and typo fixes.
>  * Unit tests:
>    * Various style changes.
>    * More descriptive test names.
>    * Print legend for measured metrics.
>    * Check for memory allocation failures.
>
> v3:
>  * Marked fair policy as default in the correct patch.
>  * Further improved comment in drm_sched_rq_update_prio().
>  * Moved DRM_SCHED_PRIORITY_INVALID to gpu_scheduler.h.
>  * Added description of the GPU time to vruntime scaling factors.
>  * Recorded more collected acks.
>
> v4:
>  * Rebased, collect ackes and r-b-s receives so far.
>  * New patch in the series for handling the new ethosu accel driver.
>  * Bump lower priorities lower down in the run queue when they re-join, in order
>    to penalize them a bit more than simply making them second in the line to
>    run as it was in v3.
>
> v5:
>  * Rebased, collect ackes and r-b-s received so far.
>  * Fix lost return statement introduced in v2 refactoring.
>  * Use virtual runtime based on average job durations when placing the re-
>    joining lower priority entity in the run-queue.
>
> v6:
>  * Renamed drm_sched_entity_stats_alloc to drm_sched_entity_stats_new.
>  * Moved drm_sched_entity_stats_job_add_gpu_time to sched_entity.c.
>  * Improved kerneldoc for struct drm_sched_entity_stats.
>  * Explained GPU accounting placement in the respective commit text.
>  * Removed duplicated sched list assignment int the embedding the run-queue
>    patch.
>
> v7:
>  * Rebased to catchup with upstream changes.
>  * Dropped the two amdgpu dependencies from the series - they have been merged
>    and have propagated to drm-next and drm-tip.
>  * Applied acks/reviews received since v6.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> CC: Leo Liu <Leo.Liu@amd.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Michel Dänzer <michel.daenzer@mailbox.org>
>
> Tvrtko Ursulin (29):
>   drm/sched: Disallow initializing entities with no schedulers
>   drm/sched: Consolidate entity run queue management
>   drm/sched: Move run queue related code into a separate file
>   drm/sched: Add some scheduling quality unit tests
>   drm/sched: Add some more scheduling quality unit tests
>   drm/sched: Implement RR via FIFO
>   drm/sched: Free all finished jobs at once
>   drm/sched: Account entity GPU time
>   drm/sched: Remove idle entity from tree
>   drm/sched: Add fair scheduling policy
>   drm/sched: Favour interactive clients slightly
>   drm/sched: Switch default policy to fair
>   drm/sched: Remove FIFO and RR and simplify to a single run queue
>   drm/sched: Embed run queue singleton into the scheduler
>   accel/amdxdna: Remove drm_sched_init_args->num_rqs usage
>   accel/rocket: Remove drm_sched_init_args->num_rqs usage
>   accel/ethosu: Remove drm_sched_init_args->num_rqs usage
>   drm/amdgpu: Remove drm_sched_init_args->num_rqs usage
>   drm/etnaviv: Remove drm_sched_init_args->num_rqs usage
>   drm/imagination: Remove drm_sched_init_args->num_rqs usage
>   drm/lima: Remove drm_sched_init_args->num_rqs usage
>   drm/msm: Remove drm_sched_init_args->num_rqs usage
>   drm/nouveau: Remove drm_sched_init_args->num_rqs usage
>   drm/panfrost: Remove drm_sched_init_args->num_rqs usage
>   drm/panthor: Remove drm_sched_init_args->num_rqs usage
>   drm/sched: Remove drm_sched_init_args->num_rqs usage
>   drm/v3d: Remove drm_sched_init_args->num_rqs usage
>   drm/xe: Remove drm_sched_init_args->num_rqs usage
>   drm/sched: Remove drm_sched_init_args->num_rqs
>
>  drivers/accel/amdxdna/aie2_ctx.c              |   1 -
>  drivers/accel/ethosu/ethosu_job.c             |   1 -
>  drivers/accel/rocket/rocket_job.c             |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  27 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |   8 +-
>  drivers/gpu/drm/etnaviv/etnaviv_sched.c       |   1 -
>  drivers/gpu/drm/imagination/pvr_queue.c       |   1 -
>  drivers/gpu/drm/lima/lima_sched.c             |   1 -
>  drivers/gpu/drm/msm/msm_gem_vma.c             |   1 -
>  drivers/gpu/drm/msm/msm_ringbuffer.c          |   1 -
>  drivers/gpu/drm/nouveau/nouveau_sched.c       |   1 -
>  drivers/gpu/drm/panfrost/panfrost_job.c       |   1 -
>  drivers/gpu/drm/panthor/panthor_mmu.c         |   1 -
>  drivers/gpu/drm/panthor/panthor_sched.c       |   1 -
>  drivers/gpu/drm/scheduler/Makefile            |   2 +-
>  drivers/gpu/drm/scheduler/sched_entity.c      | 163 ++--
>  drivers/gpu/drm/scheduler/sched_fence.c       |   2 +-
>  drivers/gpu/drm/scheduler/sched_internal.h    |  70 +-
>  drivers/gpu/drm/scheduler/sched_main.c        | 351 +------
>  drivers/gpu/drm/scheduler/sched_rq.c          | 379 ++++++++
>  drivers/gpu/drm/scheduler/tests/Makefile      |   3 +-
>  .../gpu/drm/scheduler/tests/mock_scheduler.c  |   1 -
>  .../gpu/drm/scheduler/tests/tests_scheduler.c | 884 ++++++++++++++++++
>  drivers/gpu/drm/v3d/v3d_sched.c               |   1 -
>  drivers/gpu/drm/xe/xe_dep_scheduler.c         |   1 -
>  drivers/gpu/drm/xe/xe_execlist.c              |   1 -
>  drivers/gpu/drm/xe/xe_gpu_scheduler.c         |   1 -
>  include/drm/gpu_scheduler.h                   |  44 +-
>  33 files changed, 1497 insertions(+), 481 deletions(-)
>  create mode 100644 drivers/gpu/drm/scheduler/sched_rq.c
>  create mode 100644 drivers/gpu/drm/scheduler/tests/tests_scheduler.c
>
