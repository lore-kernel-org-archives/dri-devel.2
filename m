Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5825CD98F3
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E7110EEFE;
	Wed, 17 Jun 2026 09:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TRnD2csL";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63AD10EEF8;
 Wed, 17 Jun 2026 09:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgduAV74/Si03mmuFe7j32qZFjvXppVDzAIg/OwWLw9g+jdrqsFbnYpGEhP5OK0UDOSEa3EybYoROgCZHtnl3pp1XnhjnEwAk3TwuTX01Z70FYO96Vx2u23dTlQ+HZQeBEw/lcRGLR2cE1k+XLtx8zDxBKb5D4pO++sgzY15A6qUk26UbTxL7l4QfpaypwqVRh/aZYbe64un2rWmfriE2TjVunj3jZEP3qXxnPldLCgYOdxLWHgG3InB48dt/HtdVICBcU0D3nowhX7zVSRl82GtD0zc5SnGv6FZf9ndJc+/6+03khd4CiSUCMfqAkt3f2q7hmgPdhwvkPhxEwX97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iv4kVLCV4+j8AFUOUKySUn93Ew5atQ4TcRpRrOxobrA=;
 b=tVufTN7Jy0YUwlf/WSK4eg4f3ohYNG8PkW3T7sjIwxUOEBE/8oi9J/V9+Qa5uNEhU56GMJTSJu9dTxsnJamA6Ywdh/t+geTPgJnp6QKudGEMVKqb3IpA1GtRcVutlYTBVolXO1+9GXyXH49NOXoH0spCPga1Q807cOjZni1VkIUbMt6vWJQA46F4692UU62NTSIUf3U+B8QtObe4olKR7JKOrqqdImV+71Wc/hNeKdrN9GvuP4/RD+G0eygc8UC6Gsz3fp23L2F84iTzDAMTDXGMKkNr09q3qImVducnhZuGQYeO4NWWrFP8iYnROWtt1rmGbD0u71jiX0K8KaQClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv4kVLCV4+j8AFUOUKySUn93Ew5atQ4TcRpRrOxobrA=;
 b=TRnD2csLCVXDmfCjwmdZh0XadJTI9++V/LUVjw8nl8gR94vNnGKoEpc6ToEXWcnxgaqR9tbMe6qY3iDq0EoE8TstRwPo4qx/1r4ux7Z1VCJ+8/ivcmFy8P4bO0ronLv4ceFJfH5UaA3S7VQCzGhoub8oP8sqHY2BXifIJnjsm5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 09:13:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 09:13:41 +0000
Message-ID: <cc1dc9ee-e21d-49ea-968a-14a97bdc5afa@amd.com>
Date: Wed, 17 Jun 2026 11:13:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/sched: Replace completion with a flush
To: phasta@kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
References: <20260611123423.39819-1-tvrtko.ursulin@igalia.com>
 <ba8ea856526d54753da68deefe7b77f15c908fa3.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ba8ea856526d54753da68deefe7b77f15c908fa3.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 03107834-bed3-457f-04cf-08decc50b958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|5023799004|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: EUE0CD7+qdAk60Z42Kaf4+C7KNe2ReAn4jJHGLacRpBNppgBm+2xSDh18/2LisdJwJvblkF8Fr31o830SQRI1v5skIZlpUNlrJnZao1kD/45zwSs7pzlUmTXPs8Ex0dReL+HxZ29snavON9pMsRfNwqTYusTPldCKBBst6Mwldgepel/T3iHqEDy51EYaNGJXB1xuy9QIPkbGXnDdVEZjUTohLrnn+wiOvGwFD36/pzCVMeph9yqdjapEwBsgsu9YXM4JT5jrKBKAvts/uNYYUO2C7FavDqYUMlYdnDwpS627/+a1eKtzHHSXbSjNQ9qZr29yu2Cy/zSrb0X4zTbEjOZII+4Ocz8vuIMehxpiOI9E+HYkUbtAq24r7b0vCuVAcYQKLEKB24yNT9aNvd7qcGoEBR4/sFnfyIgG+NV1BK2Xx5q2r0hM1ZmnFWB+cP3IniytU3IOZLTxVkj7BmvyXGoas+Jh4LuBjDXRNoZPr+dTiHDOYrOwZ7UjK+uYFRod2IhTU8JZYbzLC8oBdrZXfBvcO45fijHVh3pXUjxw8b2ViVl6DA/V7I33r5SkgGRKajCBzKukW/yzZR6iUB+FltL3ueFoCoOtZwQ4cQKGlTfGqFfND6ZslsobAAYgA7CHwBr5QxNT8JS0V0SaVl9D9m2yQ+DrKK92KjL6CU068MqIfTej6pucsfZhn0fOp9U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZjVEIvSWs3L1JTcGl0VEllYnlqVW5jTnc2dkRib21jYURTWVFWdW84ZkQx?=
 =?utf-8?B?TC9oV1RLVGhqdjlyRERDa2hIN1QrN1o0NVdMQTloUlZ0YjQvNUFrUlNiTlZZ?=
 =?utf-8?B?c2c0ZEU2dk5oOUVvR1RHRFA5bld5emRGSzhCd3NhVDl0b2xlS1FpdTNuYkN6?=
 =?utf-8?B?T0xvTU1PdFRBVXlqaFhrSlNFUTdzOUtRUld3WE52WmJ6Ynp5THM5TVpTKzlT?=
 =?utf-8?B?K2FxQ3JTUysrZElxaVFIOVI5c2wyYzNOWlh3WTF6VFFXS1pJTDVWS0pUb0ND?=
 =?utf-8?B?VVJtWklKbCsxcjk5Tm4zYnE1OEtNeVQ3d0M5S2dKSU9NbVNDWGFDN1BGZ1hS?=
 =?utf-8?B?RTFCUnNBMHFiWVNJNEJIVzl1R0FTVkFtRnliZjZCMExBQWFXZWNBL211dDUw?=
 =?utf-8?B?Q0NZOStnWjR5cDhzaFRWOVJkN1FieElQSjdVd1dmaWpFVVhlbC9PdFllUnJo?=
 =?utf-8?B?M0ZoNTU2NWk3V1lTNm5jaUx6a043bFZ6blQvTy83bWNiRG5xaGdicW1xMEIy?=
 =?utf-8?B?Sjlaa0ZhNGdCYTYyQjdhL3drS2RuMExydk5mZDVlTUxSdjMwV2Y3aEIzQXFy?=
 =?utf-8?B?cVZ4cEw0UkRkTmZmK1kvYXRhNDQ2bExGT2FNN292RDVVZmY4NmJtbG9CTW4v?=
 =?utf-8?B?NDBuZ2FUVGw4YTBmVVAydThKK2RKdWt1Z0VZZktvUlV5d1dKdHZzTm9pUjAz?=
 =?utf-8?B?VzVnYmRJcjdxS2VhelArQUZXWU54TXc4L0QyTXdkN1VFMHJqR0VUQWxzUlJ4?=
 =?utf-8?B?NXlBVms5MGhOZVB0L0V2cUlneWQ2a1ZPRmVPaWNIcVdxMzJQUUxKcDU1K3hu?=
 =?utf-8?B?NmJrY0luY1JTbnBmeEpzMkVaUG9xajdlSFFMdHdDK24xTjVDRE9pa3BMaFhP?=
 =?utf-8?B?eWtiRnFGeHFMTnh3eUt5SjFWOUE3Y2w2Ni8waGtheU5QVHBhY1FHbkRGQnRt?=
 =?utf-8?B?RGJHYTZnSE5Yck5rZnNEWjA1cmpZdmxWTVRqNVJKQ2x1ejY0V3JaS1gwS3Y4?=
 =?utf-8?B?QmJ4eENiaWE5NHhjZ3doNWNMUVFRVFhoZ1ZPeTBPTHRBYUNtL3NMVHRRZnc1?=
 =?utf-8?B?SzRjaWhuVmZDam0zYTU0dXlwQU1saGE2QzNNNzVNcllkNVcrYlBUa1dhenJZ?=
 =?utf-8?B?VmN0cXpqUDBoNU84SExtTHlac3QvaUZDRTNvM3NoOGZaWm05cGFtckFZdndZ?=
 =?utf-8?B?NlYzeDRKUUVDdy9NQUJiK2VTTXROMGJYUjBCNjMzMm9pZUdPeHRVaEc0Zm1J?=
 =?utf-8?B?djZwYUFCdkppZW92TWpNTmZwbHVBdGwwVVNFTVBPM244WjloeGw0ZndsRXB3?=
 =?utf-8?B?cjhuT2xMUmFYUFJzYURxUzJpdmpxV1NtTmxBbFN3VGNpQ21zY3RyRHZBa2tP?=
 =?utf-8?B?alRsNXZlaEFIcGlKZjRkMktqUmRyVDNVRGVKUEpkV1NQSzd4U0xyWlhJMHY1?=
 =?utf-8?B?L0s2Y0QvY1JQaHIvWEtBdVRoZXJCaytOMGxXVFpETXVjVUdBWE1sQ1lxRk16?=
 =?utf-8?B?NUpBUHpEOGx6M01Fdy9nQ1NHQ3JYckRPTzYxS0E1bGZqNDJBWUlDUkYweWlw?=
 =?utf-8?B?T0JHZUIzZTdoRTVOcWdBRUllWEJQY1dmUWhDWFBWNFdWWnpZWVZNL0NXdjB0?=
 =?utf-8?B?MStFakEvbXZpQ2dRVHY0dmVmeTA3c25OSTNacllwaUtSQnFYNmVyMzJaRm1U?=
 =?utf-8?B?emhHSWNHMlVxUTN6NjczcDlUS1A0bDZMZ3Y3WGZLSjM2Q2pGc1BTVHlIbDBX?=
 =?utf-8?B?bWpmQ1E4SmlxN2tIdWlET0VESDN6UnBibHBsQlQvOURoendQaGZaa0w2K3Yy?=
 =?utf-8?B?OHM0RXNpbjRYSmpVTWNQdWdwdGluZm53ME40SVQ4amNwc2E0bDYzMmt0Y0hk?=
 =?utf-8?B?RlZVai8vTnIycm1VYm41YWMyemNONmZJdjlFL0xLVEx5RENLVFFFWHlnb05Y?=
 =?utf-8?B?TFFONWVudVQ4RmJkWHpUTUQxQkowZzNHeGFmRHkwd3B5eTZxVmI2WXhmWGt4?=
 =?utf-8?B?d0kyR1FJcnBKWmdQeU1hZEFvYTBVWG5lTVFvT3NHUnZFVitLakltckFLd0sw?=
 =?utf-8?B?K2IwUzhxS284RHRyVFZNSS9GbUo4VFlHT0YvK3J5bCtIUjhmOUEyeWNYSG8z?=
 =?utf-8?B?L0xxeVdCMjlVRDRLU1A5UFMvK0FBdjlZTDJYTlJZK3J0YkZzRU85dU41blVB?=
 =?utf-8?B?RHRoSFhraUlYNFdZMHdRK2ZNUzdSVlVxMmdXeWhRdnpLRHFkMUM4bjU5R1FI?=
 =?utf-8?B?M3pnN1VjNnpiSzk0V0ViV28vWjRGczRweXM5RUtUU2FHRUdxc24yZUxRWjhM?=
 =?utf-8?Q?9fL4X67cKM6ZflufcM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03107834-bed3-457f-04cf-08decc50b958
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 09:13:41.3540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3NF/+zfw+mKhRZbaG546Zvw1dztpQ3OXCZk0BT4fo+Egdh6FsHW0EX7YLa1wB63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716
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

On 6/17/26 10:38, Philipp Stanner wrote:
> On Thu, 2026-06-11 at 13:34 +0100, Tvrtko Ursulin wrote:
>> Due the scheduler locking design, and the inability to always lock both
>> the entity and the run-queue in the consistent order, a completion exists
>> which effectively marks the entity as in use from a call path which is not
>> able to lock it.
>>
>> When entity is selected from the run job worker, its completion is marked
>> as non-idle all until the code is sure it will not be dereferencing it any
>> more, at which point it signals it as idle, releasing the potential
>> parallel cleanup path.
>>
>> We can remove the need for this completion by implementing the identical
>> guarantee by simply flushing the run job work from the cleanup path, after
>> having removed the entity from the run queue.

Oh, yes please.

>> We then know that the entity is no longer reachable by the run queue
>> selection logic, so as soon as any pending work is done the cleanup can
>> safely proceed. And because we have marked the entity as stopped, we also
>> know that the entity cannot re-enter the run queue.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: amd-gfx@lists.freedesktop.org
>> Cc: intel-xe@lists.freedesktop.org
>> ---
>> "Perfection is achieved, not when there is nothing more to add, but when
>>  there is nothing left to take away." - Antoine de Saint-Exupéry
> 
> 
> Hmm, alright, so the basic trick just seems to be that the workqueue
> implementation already can ensure the synchronization which we manually
> implemented so far through the completion.
> 
> 
> It's a bit more LOC, and doesn't solve a bug. However, I kind of like
> the idea because it removes a redundant mechanism. Would be cool to
> hear some other opinions, though.

At least of hand it looks cleaner to me.

And just for the record: This was also the original design the scheduler had before people started to "optimize" it.

Cheers,
Christian.

> 
> A comment below
> 
>>
>> Lets see what Intel's CI says about this, not to mention our new AI
>> overlords...
>> ---
>>  drivers/gpu/drm/scheduler/sched_entity.c   | 25 +++++++++++++++-------
>>  drivers/gpu/drm/scheduler/sched_internal.h | 14 ++++++++++--
>>  drivers/gpu/drm/scheduler/sched_main.c     |  2 --
>>  drivers/gpu/drm/scheduler/sched_rq.c       | 14 +++++++-----
>>  include/drm/gpu_scheduler.h                |  9 --------
>>  5 files changed, 38 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index c51101ec70c1..e6f7c2fbefce 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -137,10 +137,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>>  	entity->rq = &sched_list[0]->rq;
>>  	RCU_INIT_POINTER(entity->last_scheduled, NULL);
>>  	RB_CLEAR_NODE(&entity->rb_tree_node);
>> -	init_completion(&entity->entity_idle);
>> -
>> -	/* We start in an idle state. */
>> -	complete_all(&entity->entity_idle);
>>  
>>  	spin_lock_init(&entity->lock);
>>  	spsc_queue_init(&entity->job_queue);
>> @@ -276,18 +272,24 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>>   */
>>  void drm_sched_entity_kill(struct drm_sched_entity *entity)
>>  {
>> +	struct drm_gpu_scheduler *sched;
>>  	struct drm_sched_job *job;
>>  	struct dma_fence *prev;
>>  
>>  	spin_lock(&entity->lock);
>>  	entity->stopped = true;
>> -	drm_sched_rq_remove_entity(entity->rq, entity);
>> +	sched = drm_sched_rq_remove_entity(entity->rq, entity);
>>  	spin_unlock(&entity->lock);
>>  
>> -	/* Make sure this entity is not used by the scheduler at the moment */
>> -	wait_for_completion(&entity->entity_idle);
>> +	/*
>> +	 * Make sure this entity is not used by the scheduler at the moment.
>> +	 *
>> +	 * Scheduler is guaranteed to be stable after the entity was stopped and
>> +	 * removed from the run-queue.
>> +	 */
>> +	if (sched)
>> +		drm_sched_flush_run_work(sched);
>>  
>> -	/* The entity is guaranteed to not be used by the scheduler */
>>  	prev = rcu_dereference_check(entity->last_scheduled, true);
>>  	dma_fence_get(prev);
>>  	while ((job = drm_sched_entity_queue_pop(entity))) {
>> @@ -576,6 +578,13 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>>  		return;
>>  
>>  	spin_lock(&entity->lock);
>> +
>> +	if (entity->stopped) {
>> +		spin_unlock(&entity->lock);
>> +		return;
>> +
>> +	}
> 
> Seems unrelated? Why wasn't this needed semantically before?
> 
>> +
>>  	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
>>  	rq = sched ? &sched->rq : NULL;
>>  	if (rq != entity->rq) {
>> diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
>> index 13ecb771d7a2..80dece3be415 100644
>> --- a/drivers/gpu/drm/scheduler/sched_internal.h
>> +++ b/drivers/gpu/drm/scheduler/sched_internal.h
>> @@ -35,12 +35,22 @@ bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
>>  			 struct drm_sched_entity *entity);
>>  void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
>>  
>> +/**
>> + * drm_sched_flush_run_work - flush the run-job work
> 
> In v1, you'd probably want to document what this function typically
> will be used for :)
> 
> 
> Greetings,
> P.

