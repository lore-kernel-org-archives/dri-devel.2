Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D5DC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28ED310E26B;
	Thu, 10 Sep 2026 13:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hDZgfRSv";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013064.outbound.protection.outlook.com
 [40.107.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3E810E278
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 13:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVHKvg58yiNM3KOiYRRyNRpU47YnEezDrKLG6H20lNWFLGGlkTBUfmesU/riZ6tJFfX5CEd/MbWH3MbviCAWfz50xz5eq65hlYH18Kh6BHzwzsDJ44bzYlb6dFfME2YkrMyUBV7x1MY0vNAzRQq2j4QE5PDWsZs9YTVAV0DgmCcBtFFNyxp6MwmCM+SCHNqpLeL1EvZ5bE+cbKEdiNF+fnoLXiEgYpzV6OCKgYrdjukjbnEUX7bbNL12OlE/IYt3YhLBn1pvmKwP7P7Jmp5hbW7XUhMNTaSX9vU2CgjyP/cPdF+gWW+j6zM3V0V0axYnNvDmXYDMwx4hy1mIsV+GFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djYZE2F2fei9QMyhYiiQ8HdCZ9CJoLM/6RJmyeSxBh8=;
 b=kBj+n96SY1IKFsNTIm8zvQBBaMphcJRr45y2ymgJcYi1b5JWX9YXV3e+Y/p+MgtNufLjqYEsERa6ej8j/3ka6HFNQTNEO5y64eP2J39NqZ0rdfcJn5c6TKNtykrWqDt3OUi2EZeYWlAQ6FVvX2gZsSr80Ed/MWWZrCeprfvfq09txIyf8PUr8U3lCqVYkcSZC6Jw//mYt3l0HJWU3/dsqQxCSuYS3RCeauYIH504sYxHaqahBZ1CPOiqkrZZdk0H/9ssanGwPmrLhsxoDEaGDZDjp1Lfr8vQUSQvNUpNim1W4Ax8kDfdq67qPbqVI9J6CDH48++QNzPH0ZWQ9vRm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djYZE2F2fei9QMyhYiiQ8HdCZ9CJoLM/6RJmyeSxBh8=;
 b=hDZgfRSvG2Mi7gZ6l8hCLCC9zQWFlDyjgudArsUJByoiptVYuiXSvRLPOAx4K/qg06ZXbds9HtP1QKp2eGpU4s07kNqYthCclE0J7kflP9/Aoe2MxLE4Vy+t03S/9LengTDfWhpQO5NYUfErRKaGWtZRMF0FGPlZayoqfbloW+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 13:58:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 13:58:36 +0000
Message-ID: <363aa83e-7c72-4592-a8ca-46f0ab56e4c5@amd.com>
Date: Thu, 10 Sep 2026 15:58:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: drm/sched: run queues freed before the TDR that drm_sched_fini()
 waits for
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, phasta@kernel.org
Cc: Philipp Stanner <phasta@mailbox.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260910054605.634135-1-donggeunyoo.kernel@gmail.com>
 <6f52dcbb040b8ba796b56311e9a77465d111c868.camel@mailbox.org>
 <df7b0d1e-5a74-445b-90fe-fae30cee4cb3@amd.com>
 <20260910084408.703333-1-donggeunyoo.kernel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260910084408.703333-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:208:32e::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 764e3560-dcb0-4a8d-9cf5-08df0f439bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5fqp9niYVwFYPjNar+MMNkjj9++DVP8jPo/S8ttlwKuRqH0fERAn8iNY2GaBc1zznQhB3r5Vkq2Zd5EBd8822McemizkRgDs7fkyE9B3k7dEKD6rxgjp/VTNq8iY7as2NwcrUvRn9CB5zVO0D+7kxIhkTmU6hrgTRrioWwigLF2jLxTmuH9QgdNuU5wxzNmVbHzuHClA1yQ3Cjxr01cH6gmflgXLBXlXkSF3NHFPEQN6bAVo99ZjS61P+jcNIsNANojqNCjqgk5NapyUfWkjACFWLemNogzeckhWE94rVeQRqkmi0hPeLq+v/wNSdxEHZ/i7M0llJOhLCtcwYANVoTxSMFhODE0/dPbmAlNtM+i6PhyA47Fsm9Z0s9ntX544ZYHITArRc+CL15Ud9wYjDJH4guOLJ/T++yznMumB4UugdtLqAokuhbH4GdvvuULT+8kmRxFKvtl3nFWaZVhNdWy0LfdjpSX7vwKn8ENOM01HUCWPTro95QnDwdoeJMh/5ao0YV4QxrGcM5qEoTEsiXJWSKz1zhj3VK7S5s/Mow2luU8VPnl658pshLS7TVEyb3wdtBdjjek8b706DfI9BITpuO537578XZNfoahDOmtLCscxP2Vtbh2++XVXq+gAMjyXJJev5L/1Y0rmulABRk4OQcYhTuwbIM37xD4WHPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlBJK0dJaS9RbHF1SC8ybDd6R1VLREFRVVFXUHdRSUxGbmFTejd3UTg4a2Vo?=
 =?utf-8?B?d0JSSnZSekVqRjhPZlhJUTB5SnYzR3R0Vm44eXlucUEzZXpLNUJoMDVwM3hE?=
 =?utf-8?B?N01WejJOWkRHSVZreXJQbXQxSE1FZ3pNZXEvK1ZRK1cyRDV4R0pGUzJXSk9s?=
 =?utf-8?B?UktWTXc4R2phdzQ1YnFNT0lRY2FQdGRvdUlkVS9wOTh6ekZ1aU8rUGV0Wi9B?=
 =?utf-8?B?Z3RSaUdDQW12L1RxNGxveWNNL2JhcnRlOFhPQmdJTkdYcGMrQXVGOEhwWkla?=
 =?utf-8?B?TnBPMU5ySDI3VVlPQ0EwOUFtVmlNdkpiR01aNzBBdVpma1ZSZjlFc1l0OVpr?=
 =?utf-8?B?dHZJUElNdXBXR3g1VzhTeDB1YmRYZjNiZWRrZTVHaWtjdkE1eXhNL1plT25z?=
 =?utf-8?B?QTgyVDlTTkFFblQ4RFIxVjJldGt0S2JuOFFKL3RPVWpLTC96N0FBdXhGazlR?=
 =?utf-8?B?dHMxRDBpb0x1VEdiRnJxTGlDTTM2TFJXbTluQzZxaitiOEtVMzlJVis3bjVn?=
 =?utf-8?B?UE5wQW8yRzNJYnNBZkplMTB5Q0tyQVpJNEY1T0JRallBYlBZOTE1YTkwSkcx?=
 =?utf-8?B?Vm5UeS9WMWFmWjkrbGJZeE9yZGdjU3o0OTBqby9JSXVVYnhSemExUUMzbmlu?=
 =?utf-8?B?ajZxcTR0MTV3eUp2clAwOTFmcVYyVGhBZkNlWHpOeGNXTzZ2NUg4RDdidEJk?=
 =?utf-8?B?eTFyWVZ6SHUwSzZ1MDVUQjZza1MzTUJXUHZEUG5FeFRmVGo4MU9xZXBZREVZ?=
 =?utf-8?B?cHlsK0lMKzJRa2JnQ2JKdlBGczZGSFlFVy9WUE1Jd1dZaUk3SWlrRm1pc2F2?=
 =?utf-8?B?ZFdOeEtWNmpnT2FOOEtGZlBNWStjZlc5clZuQXJiRDg4K01scEZLU05Mbzhm?=
 =?utf-8?B?SlJYMEVIT3JGQVVOeUR2QjY3dWdTM2lnY1dHdnVxNjhsMnRlY3FZemVMSWdQ?=
 =?utf-8?B?RnR1amxBN0JaMEU3U0xaL3VTMjBDVEV5Nk91M2lkQkg4U3hUdlFhdDFjNE81?=
 =?utf-8?B?S1ppcWRlTm5IbTFrQTEva3cyVkE2K0tHYTVicWNwR3MvTXlSbnVIbEg1eXBP?=
 =?utf-8?B?THgyZldmYXBHZXNqbEZQN2dUTkxLSWt3N1g4ZzBSZmZzeFM4aWpES0lSN3FZ?=
 =?utf-8?B?c29iOUtXM2ptNE0vMStJNEJvb3VqVWc3dFNOVnVyZmZvRmFSaVh5c0ZpUVZV?=
 =?utf-8?B?RzNKcytmYXJ2QlE2bnNTejNWZWF6ekNMdVE2T1c1NS9yaTNSZHZoTkROTG0w?=
 =?utf-8?B?VFlyM09uMU10aGZSRFh3VlBHb280QnBtaThvSDkvWmZqZGUyVUp2NG9HWmF4?=
 =?utf-8?B?RllKS09PbjVHbnFWZHZTWmlTY2xBOHJ5dGZEbE55U0J2WlRjSE1CS0dKRlQz?=
 =?utf-8?B?OFpFK1ZXNEFjdzllOURacDN2a2R2SEl0aTVIUTRCV1dCVEhsaTR0d3cxQlJY?=
 =?utf-8?B?ZnUyS24xTlNkV25FWXdMMkZPYmFZUklDeDUzTFZBbUt4bGZpTG5sYTRLL2pl?=
 =?utf-8?B?eUNzQWxKN0ZVQnZaWURZK3ZvbUcvZWp2THExbTd3d2dZY2VLb3JDUGhsVnJj?=
 =?utf-8?B?TnIrWmk4VVNGY0Y3U0NERjd1aU82RytwSE5nTXFHeWxQakZ2dXl5R0lzeEUv?=
 =?utf-8?B?YXR3Y01CcmFOTkYwc0VGaGowbU9Jb1pqMGlqVHZuZGhxbk9xYjhMRjNqcmxL?=
 =?utf-8?B?UVBlV3haL1RnakRDMjV1WTdWYUFST3RtcXFPMFlrYXlNSG5jQkFjUTNWZlZy?=
 =?utf-8?B?NEJ6ZGYyalMzM0dqaUdoNWUrMmhvYWtUN2hrY2xMNlp0R1RKbUVIaEtLbFk4?=
 =?utf-8?B?aWF6aU1IL2tndExDVjVkMXg4UGUzQjVERlZCZ00xUnVrMjU3Rm90YTdoWnlk?=
 =?utf-8?B?eksvUHdwdXRwei9peU9hdnd3VlVoOEcvc1l2NVRJaDlMQTIxcWo0UGZuR0Zx?=
 =?utf-8?B?MVJsK1U3NmltSk0yNGx3V3IxSS9Ta2FkeEJhdHYrWXNRN3hxMCtzdTh6RGN2?=
 =?utf-8?B?WnNVbW1nUTFBRXdId0FQcVl0THBjWGZldTlZdENDU2dsdTRCQmtud2RSUWtv?=
 =?utf-8?B?REdDbXA2WE5pcTNRb2JOSVBhSzk1czZtdURBeDlIUjNwQTVkbGxNNEFBeHJ5?=
 =?utf-8?B?cFUrRFZzd2dDVGtvVG1LZTdaUnJHYzFwdk1zM0dhZGExeGRaNmNjOHRPUDBC?=
 =?utf-8?B?cmFQcWdDcEthQnJmaElEd3V6ZUtGdjNUUFBPSUJEK2twSEVQbDNJSEl6bmNo?=
 =?utf-8?B?Z2I1aGhuWTF4V2VEWWVqaWdDS0ZBQ211NVV2Q1JQZ0FXKzlCcUxXdVZzUWFq?=
 =?utf-8?Q?/2LUaj1jNW1E8W7QGp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764e3560-dcb0-4a8d-9cf5-08df0f439bc7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:58:36.2484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkFDjxbJ0RF5LT0oSo1dgFEdWyPdv2hdkUR88c4IBMmLgyPLXcNmb+kofu8cDhZe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
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

On 9/10/26 10:44, Donggeun Yoo wrote:
> On 9/10/26 09:32, Christian König wrote:
>> Amdgpu shouldn't do that any more.
> 
> Correct, and I should have checked before writing it - 182bdd59be41
> ("drm/amdgpu: deprecate guilty handling") removed it. The callers left are
> etnaviv, lima, panfrost and v3d. v3d is the one I should have named.
> 
>> That was an extremely ugly hack applied long long time ago because amdgpu
>> was broken at that time and didn't waited for
>> drm_sched_entity_flush()/drm_sched_entity_fini() before calling
>> drm_sched_fini().
> 
> Understood, I am dropping that half of the argument.
> 
>> No it doesn't. You quoted the wrong code, this is what really matters:
>>
>>         drm_sched_wqueue_stop(sched);
>>
>>         for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++)
>>                 kfree(sched->sched_rq[i]);
> 
> I am not sure I follow this one.

What I wanted to note is that the line you pointed out is irrelevant, it was only added as a (very hacky) workaround for amdgpu and should most likely be entirely removed from drm_sched_fini.

> If the point is that
> drm_sched_wqueue_stop() has already quiesced the users of the run queues
> by the time the loop runs, I cannot find where it covers the timeout work:

Before calling drm_sched_fini the driver must ensure that all HW fences are signaled. Those HW fences then signal the scheduler fence and terminate the timeout handling.

But it is correct that drm_sched_fini() needs to make sure that this terminating the timeout handling has propagated throughout the system.

>         WRITE_ONCE(sched->pause_submit, true);
>         cancel_work_sync(&sched->work_run_job);
>         cancel_work_sync(&sched->work_free_job);
> 
> work_tdr is queued on sched->timeout_wq and is only canceled by the
> cancel_delayed_work_sync() below the loop, so a timeout handler can still
> be running while the run queues are freed. Is there something else that
> rules that out? And if I have misread your point, please elaborate.

That is a really good point, canceling the timeout handler should indeed happen before freeing the runqueues.

> On how I got there: the KUnit case never signals the hardware fence, which
> is what keeps the handler inside timedout_job() while drm_sched_fini() runs.

Oh, that is completely broken behavior of the KUnit test case. I suggest to fix that as well.

> That breaks the rule that all run_job() fences are signaled before
> drm_sched_fini(), so a correct driver should not reach this, and I have no
> reproducer that does not cheat that way. The same caveat is in the patch.
> 
> I am writing up the patch Philipp asked for. The only change is moving the
> kfree loop down beside kfree(sched->sched_rq); no new code.

That sounds reasonable to me as well, yes.

Regards,
Christian.

> 
> Regards,
> Donggeun

