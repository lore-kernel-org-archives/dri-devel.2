Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAC606A332
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oqoOn2MZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A4E310E1E0;
	Thu, 12 Nov 2026 14:15:47 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D454810E1E0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvT+gee3Msht622eas1sMiBYi2W/hYHtQYfZy3UGSjSNOHXnt/42yEK9xi7WjU8G8fopG27Mi4VJo8ooGzK7q3qs0F/Qa5Vk1FyPL+aVeXXIvmbUdT3D/Gsv60JgLSRABy/GmAXnhZcupeStWU8/NfXdFZQoLW7RIM4sY66J09DuE9FTgAZTnLAY/B8Cei9X3h0cEPdrqM+1mU7aYpP6Li86F8eUJoLwzwbq1vO20kF7pEjT9BJIXkCJ7+JQbjgt9u79P7RyNWRcQnO3wznncvuwPEm8zGhCps8XWH686jK1mnKOn9UzeHawhysWoTNp1SUoBepSWurDt1lJzc2qwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixZJb1pspJQ97OGTcjupsXCejTrbDTAdUEeOQWT28Y0=;
 b=inb8yt+SnH65suzFpeNaA2AxUxzeuxcNiMlg8cN6lGiKkxOQPGZysIiqOpZPJhMgri+qh/hcoN9rXmZoeXispL/1rNxboZuhmaKqY8SeYFwFl8V3K+bdTU6wi4/eQ8itniuJD4hXjyBWaFPIlhaAtpacGbt/VPXWvqNtyk1EY5nziqgZONpiM6XzIHFJ18xYEY86XBnme6htgU7+TIWd/AlgZTtEC5eKqwbVrtH8JIDaaQPt7GuCve6xscmac1Z459gomlq1yWEKNCKbVWN+YmzihziRp2kUM3ayAOBcJtV4IHHBUDzDfZvhYwSBShlOenoKPk1IEVBUu1QauIOZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixZJb1pspJQ97OGTcjupsXCejTrbDTAdUEeOQWT28Y0=;
 b=oqoOn2MZaDGvZT2T/LxFhGmXzRMZw/rUI0vB3RIP7uqLLAhCNM82HRhm+kHVy9wKXArhfw81R+7tBPOoNI7ulcWGtXnSxVvOKiBmp2HxJQncpkcMnGq+0p+jg4rC+9CLa7VClNLY4kubbW2gb4yZCkytdEshvNpVu7ygS7yLRrI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 14:15:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 14:15:35 +0000
Message-ID: <4606cd56-f1c5-4a00-b9ba-fdbf2206681d@amd.com>
Date: Thu, 12 Nov 2026 15:15:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Do not overaccount job runtime
To: phasta@kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Gary Guo <gary@garyguo.net>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20261111105921.38710-1-tvrtko.ursulin@igalia.com>
 <71ad23bcb3d48f771ce74270dbe4dfcf39827031.camel@mailbox.org>
 <0ff2a53b-377e-4839-88da-1c2b3c25b3eb@igalia.com>
 <6f2f8ff3738152b50521e0cad88978e2ffdb5feb.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6f2f8ff3738152b50521e0cad88978e2ffdb5feb.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 6990cd82-e18c-4813-48b7-08df40c76b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|3023799007|4143699003|11063799006|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|56012099006|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: 7U+snOY4rEjKisfbBGbmeUxu/woJbpAOBAMoz7jXO7NCu6ak412Mxs4/ox+gUk05qIp5AEWpCxA2xCj6M2eOXqosqezmLaNisiuJDSys5xLpuan7IjGu+VLW1eqtnElcPaoFBJQkbNlFsIZfQAKw199WEhq7g0qPjNZRpdUhKXjGi6wnW9pP4UK7vIFkmMazzW89tTgPlzrhBdwU2lZ9p6fYDC3lF4gj/y3cuTxY7ekc3XPWBcT63OjB+TmZrbevG/yu8jdbKxVftT/dNJtM8abZSeqkHMiVIUA363pxHowg+QaJi+5mBOc7AZ+67fwqekf2NU7lxlUb+xCLrTS6TMPh3iVRzlKtLn2ralKUBctLp2kHrW/f0KTNKalqt+VkKLKUGz08H/2OLm8lUkNfjZivgtvJTj5J02GHRw55DMHUB+aBmr+m0M5g0wC/sST0uufFQu7ekFqZahb7yIqSnVDhR6q9LJN7D6x9p9MgzZqPrFWjE78NlnsYSTTSQfzhMh35HwlnZLEEN0r0QcoMRE9eQRq+IC6QZEnlHxBrkRq2Mnm8BOzUkODBHTIZtuVVbJA79ENoxnX1Pg8GTnRCwhPUgfH8OkqdicOt9hCweMWpmtI0JlZhPqE2XHF2TPCm62K8iIlayF/cbNdhlqpJnqZ76DXTgOShtzREbr9pjlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(56012099006)(261021121427099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3Y3cDZCcGVrT3ZGTXRMM0hLL2hOaFFmQUpuekJnT1cvRHJYTE92SVNzY2Ux?=
 =?utf-8?B?eHpuTDBQQ0tuTk96S0tKcW53Y0hISWNmbm4wT201NnZmYmlrSG5iRVJWTllD?=
 =?utf-8?B?bW10K1JJeTRweUs3QlRlb2p5V0JMc2VHUGpDK2dlUExlM1RKMVg2d005SjV0?=
 =?utf-8?B?WDdvOEVtblNxY3dLczVkL2tJRjVpLzUxTTdaV0wxN2lNRUNsclNSdEZ5czR3?=
 =?utf-8?B?UjlhOE1PMkVpRXVPSG1saktwMkxMdzVJa2prL1RLZkN4TjVkNlYyNHVkUERp?=
 =?utf-8?B?VTFDY0x5cDFMYi9NTTdhZ0hFbkptaEVTalBlUm9RQnVtZG9PZXBwbFYzdXBw?=
 =?utf-8?B?d0ZBb0w0YXBYazRkcGpmWnI4M1F3VEluK2VINFRaTUFaZElEMzRTbmw0YTBV?=
 =?utf-8?B?VVU3S3o3WXZuWStjZWRvY1RWQjdqZjU0YmNFS2VSZ0lxM3ROenNYM0NPVkxh?=
 =?utf-8?B?cGpwcmdtQ0hPV3F1eGYyM3RlYWJYRXBHbmMrK2lWL2FqZXNOUjZIWHVPTHo5?=
 =?utf-8?B?ZGVDSHFtZEhQajVWK3FaK2JVa3JJREsyd08zVXpGeDU4a3pmRmxFYW1QUXAr?=
 =?utf-8?B?YWhyenBidGxIa2NpdVVoVm9UaWpvSGg5eUh2RVBRNU9IR1FCdS9oOTdPSkhk?=
 =?utf-8?B?bFg3c3Y3ZHAyNG1yZjVHQXdGMHVxQnhGeUNtOFB4T2ZYRUhDTzdhZkRISTI1?=
 =?utf-8?B?bmtkR0xrQUkwdkMwKzZCK0pVdXovOG8vQ0VtbEV4YjFBZWRqUmJBQ1NnTlFD?=
 =?utf-8?B?WDRuM0IyYUloclY1TWZhM3JhRmw2MHMzVndzMW9scDFiWWlRbnBqWGl1NUd4?=
 =?utf-8?B?ZXJMelNvaGtSR1dPTmhyR0lpdFA1b3VOVXdqT0lWMVY5bVJBQW5Nbkc5V3Fh?=
 =?utf-8?B?em1iYVhoKzJmUDArRjV0VGx6cnFZYXBmTDF2SDFpelpmcXUxdWhPVERGZUx5?=
 =?utf-8?B?TWMyYllVQ1g4NFNtQUFMOXdNNzRPa0tCWm0yNHJzWHI1ZmEwWDYxbFY1QitS?=
 =?utf-8?B?Q2FlTFVLQjdPajVJUXJ6NHRqNU4vblN5ajhMWDNEN1oxMjBYTEoxYzNBTm5E?=
 =?utf-8?B?clNTT3hEWmduOU1mUGFyNmFxYTgvNytVang0alN3UlFGQmZmUzN0UnFlbkY5?=
 =?utf-8?B?NVV1VWJjT2tlMVkraFBBUmJYZ0VsbnBFNDVmQTB2VFc2Z20raTllTUcwVEw2?=
 =?utf-8?B?eXNsM3hOcmNyL244UnJSY0YzZjFHaHlvR3F2bFdUTGQzRDRnWTRuN0lxVzRu?=
 =?utf-8?B?Yncyd01Rak1JMjBUOVBkOXJRUlNpeGZSSER5MXg2elAyajlOSGJHVUxSU2Q5?=
 =?utf-8?B?K0VLMzNUdFZJM3dwUWc1ck51RU5lWXRGOENIRFFMK1dKTlZDL1lxSDYySkg3?=
 =?utf-8?B?ZHpzT2NiWEZhU3AveWc4dS9IR1ZUV2lRc1dnZktQSUpDcmJpQlJRVldjcFBX?=
 =?utf-8?B?N3hrTDV0UUljcnJiU01XNDVYMGJRTXVGeEVkWEdmNG00YUt4ZFAzNmlESEd5?=
 =?utf-8?B?OVRhUm1CZ0ZTZ3QrZmxUL3JqRGEwYUhxcTRYcjNUMkNwZ1dCTHIzQlR1dmFU?=
 =?utf-8?B?YzIvK1NBNldJSVZ4cnhVN2J5VklGSG0wRkNFbWxralEzeXZLMS8zbU5hS2ky?=
 =?utf-8?B?MTRKdCtqd05hV3hHdFl0V04vYTBFWldIakVZcmZ6eFQyakVKL1A0enYzWkJu?=
 =?utf-8?B?M096dnV0MjJnWndmdEhETkdZbGUzb0RuUUxwU2V2ZUJLNkxPcnhhNk44a3Q0?=
 =?utf-8?B?V3VTR0JlZFQ4cHJrV3hDRjRaU0IwdVltRTh4RTlWV2dsdnA4MnRtUzlrd255?=
 =?utf-8?B?bWFxM0pZcUdZWWNhT2p0aERtOGIrYnUvTmxGREpQVk1VMVltQjFZR0lYeEV6?=
 =?utf-8?B?Z3hJdjR2TFV6aDg2MDNENUFyajJTR3B4RFRCbWhBakp6NmtXUkRXSTMxZ3ls?=
 =?utf-8?B?OEw4YXdRcG12M1dQQjQzUXN4R0oyQW5yZTg5UkpRYlFmdnZZbGI5SWViTzFI?=
 =?utf-8?B?T2V1bEJLdGhoYVY4dGhUZ0JMTGF1SUc1dm5Zcm9IRnAyaFd4MzY5b3Vud2VL?=
 =?utf-8?B?MCtNZXJheXhJamdnQS9Ody9GQ3B5elRaVFAzZzF1ejAyanNhK2htNTVXU2dE?=
 =?utf-8?B?aXBHZ0pGT1EyTUo1VVN4SlFUa3ZMbnJOVjlrOGQrQVNnNkQzZExWUEZhbG93?=
 =?utf-8?B?MFB0UTY4dk10ZFRVUitZZDUyOEtBMGJISHM1RzBIRHFmU2RWdm5sMGRzT0Rj?=
 =?utf-8?B?SEV4RmNRMzc3VzhLMWQ5Q05UcU5KdE1jMkpLYmZkZkVhVjRGQ2pUbzJNU3c0?=
 =?utf-8?Q?WxA5PstXrIwSLS569f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6990cd82-e18c-4813-48b7-08df40c76b8f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:15:35.9238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nk6y2HjFNj4rylzqmYqSlRbgzEU+AQ8J81mlmb9SvzNk0GVmQzTwgoo+0keWdxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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

On 11/12/26 09:48, Philipp Stanner wrote:
> On Wed, 2026-11-11 at 15:05 +0000, Tvrtko Ursulin wrote:
>> jobs. It did not feel worth explicitly putting cc: stable on the patch.
> 
> OK.
> 
>>> This is the *next* job's scheduled fence, so this sounds suspiciously
>>> racy. Testing the bit and overwriting the timestamp, can't that race?
>>
>> I have a feeling the code was assuming the default ordered workqueue 
>> ensures either run_job or free_job runs at a time. So seeing timestamped 
>> next fence guarantees free_job has exclusive right to the timestamp write.
>>
>> That is not true though for the three drivers which use own unordered
>> workqueues - pvr, nouveau and panthor.
>>
>> If we look at the drm_sched_run_job_work():
>> ...
>> 	drm_sched_job_begin(sched_job);
>>   -> puts on a pending_list for free job to find
>> ...
>> drm_sched_fence_scheduled(s_fence, fence);
>>   -> signals the scheduled fence
>> ...
>>
>> If free_job interleaves in the middle, so it sees the next job but it
>> looks unscheduled it will skip the correction.
> 
> I'm not even sure why this is done here. We just overwrite the fence's
> timestamp. Why?

To allow drivers to more accurately calculate how much time the job spend on the HW.

> 
> The fence gets marked (signaled) as scheduled in
> drm_sched_run_job_work(). Hence, that should be the relevant point in
> time. Why should free_job() have anything to do with that?

The time it was pushed the to HW queue is pretty uninteresting for the time spend on the HW.

What you need is the time it started running and that is when a the previous fence completes.

> Looks very suspicious. As if there are two redundant mechanisms here.
> 
>> Yes I think you are right. As said I think there is no real bug due race 
>> with unordered workqueues, but for formal correctness it would require a 
>> memory barrier after test_bit, or full blown locking.
> 
> Is it guaranteed that this fence is signaled and, thus, has a
> timestamp, or is it not? If it's guaranteed, the test_bit() is actually
> unnecessary. If it is not guaranteed, then there can be misordering
> between the two operations and it's UB and, thus, a bug.
> 
> 
> That said, I'm OK with your patch here being merged since you did not
> cause that chaos / problem, but a second patch with a FIXME about the
> issue that links this mail-thread would be good.

I've considered this approach as well when we originally merged the change, but the timestamps are only like 90% accurate anyway so to be honest I don't think it really matters.

This was merely to make gputop output something at least a bit more accurate.

Regards,
Christian.

> 
> 
> P.

