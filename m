Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C360A4ADB
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lHmqkyjX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990E510E43B;
	Thu, 22 Oct 2026 15:06:44 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708C310E43B;
 Thu, 22 Oct 2026 15:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jolzPHTr93G6hGLYSCkYjCbVCZN4v7EBTRQGisStHFVOSIebTJDS2qVSddqPB4o6fQTBs0RtbqiZsZheYx39KuveyvJzqZ7dMnABBd/n0oVRf2gAO2VZGR6/jKM0wNtqj3gD3DX5QT73J4zXjB0XiY4IEjVW4VjV89/kKRVOHR+7PM+ckOfKx5g9kuErVKxfYppo2vLSlXs7AtvPAKTwZkkX3U62g4TsUDdbPxFAKVIfF62w2GRvYtEgLryLXLP8NMjrfg4wHsxck9HtJC5d3ez0CbIlXX5Jp5WkzPSWTWe2WRCR27MI2F6i98xqKFANhY77DJ4G2vexHJ5tP5Jdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOOexMh6euwpja80Fw5pf/wjjDyWHlVgIbkm4BH6YIU=;
 b=PljsnKn7vb5K1lpm361ycPan9YCkq0O1T4rOcEWv7cXYJwx63a6QhNY6RdkfwoL8o+PAQZJx/5F7r81O/77JnVFbXOAktZpI5pFhcQLbeRFnniektcNuV8KqYBQUGKLMm2K34VTefPmTNnk5tA6qEWHXBAvdETimmscH38IqeOiVt7/hMCLFuG0SlhF+xxSWMMShcxe2bO7xoguiolgof79PzlCL+q/GVRGeLYKM8WfBuxlA/8igg7WxGw7aNopF/2OfsmAhcBZqxp+zv7nBDBK4RtTVfh/Y+pM4kfpevmxJSJ/T+uyW1dz51BYEpwOa1EcQe966mMiL07PRk5j5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOOexMh6euwpja80Fw5pf/wjjDyWHlVgIbkm4BH6YIU=;
 b=lHmqkyjXZU9aK9/2U7PAF0U9oxiWUF7SgoaKUoD9i7oNM+jFZGk3bo1AQxou5pQK6X9TOypMslFL3AiBON/FbuQNxRhMAChW/Xz9vfnYgxN7gDSITkW3/2RMSkDOBeI+NIpMhKu40mh21XkQoJaokYIPc8Fp0ELBqTIHEa2MkHw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 15:06:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 15:06:35 +0000
Message-ID: <794f96f2-dc6a-4185-8fb2-092644b65230@amd.com>
Date: Thu, 22 Oct 2026 17:06:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/scheduler: signal fences of jobs pushed to a stopped
 entity
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 tvrtko.ursulin@igalia.com, phasta@kernel.org
References: <20261022105454.60267-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261022105454.60267-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fbfd3c-89a7-484c-aa0e-08df304e1091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|22082099003|18002099003|261021121427099003|261021123027099003|261009223027099003|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: T0dENT/1XQXYmduvW9tymJr9c7/J+43f/DmItuLZTgMlKa5F/76fh8rH4AdtnArwQ/51FcrMB938qSccGOop4h2wAuBpP26WeQaOAO6lY04rID5uWiF4ByLXWI5mNT7SAUu7CBrgYs5qUFBKaSd7/xwg6rzqItdwmJlODQnsVzGaKivdW7X2OfGy9uYe+fGc8S0sl/2A/UhnORa0274+St/x6G/1peZoO3qjVtN+mwEFXpO0wMDiiPh+W0zf4E6K6M3+B00zhBMMtLc72RF6q4ndRmef5CFv3/gLkr7sjJTdioVaMOa6yctVPWw72Udmy6wS1VzbfutvBCy4qN+qwcDtC4QPS3dQFDoKTAKthP5XJDHx+BABYK+dEUeZkQnISPkSk95YZHmXXULu/ukWBgbaM+GCj3phpJQ0/8XZV+qqROroMPeoDFL8c5x8rl7gWpqp2nYFDk9hMn1xZ4ajwQruUTLflryHrcGjTFKu5krIKgHfTF0tDryTOvkPcSWEFdHGPAH6dGS0zVirDME/CfmYbRXJNp3gdVZDYEWDm68YU0hJXoMoCoVmY8+XhLtftnoFh4ae7Orsjb+Rf1InJUlUqe+1l+e8eSOm0v5tjaQW9BGN3pGQcHtmSvQ/4GIE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(22082099003)(18002099003)(261021121427099003)(261021123027099003)(261009223027099003)(5023799004)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlBvZ21IS1daN2I0ME5YcEVaU2ZuZmZDQWw4RytEWGE5THRWWXBHekRyeUdS?=
 =?utf-8?B?a3NHSXByWEhQcVRRUlFIdW5MbWt6RXZhMjl3YjBQbUpkRXl2dDZlWWlCcnJN?=
 =?utf-8?B?MVQvcDM3dk1KdUNIK0hCcHoyQWlpdXRrTVpLd1J0NS9pYWo5c2FBMHNDNngr?=
 =?utf-8?B?RFV5QThuc01UUnJhdHVRalNMMHVYVW9XMkFtT2VrUVJSVFFMQWRlczQ2UitP?=
 =?utf-8?B?V0ttR1Jid2EwSnl1aHNxMk1BNGRqb29BemFmR3dOZHc5TUkwaWUxclN6MFhO?=
 =?utf-8?B?NElScHQxTUlRMjBMU2dtU2lBZ3NVTmZ2N0JKN01wei8zNVZSZFcybzVmUW5J?=
 =?utf-8?B?bHZGbWd0ZEFML2p3U3U0VWcwakE3V1BTQzFqNytGWHpDcExPR1c0NFNKM2U5?=
 =?utf-8?B?ZUQzNFVBWTR4T0VMeUZQUDRaWkY2OFFkNTBvR0dlQmJzMkxjeXNvY0dFWGV1?=
 =?utf-8?B?N2s1V3BObnA0TW5nQnZjQlZMVmtYeE5oUXorM3lodGJsMXJXSVRDTXpYZUNt?=
 =?utf-8?B?dzkzR0J4QzFoSlNjK1RHYVpqOXVId1E1MGhHY2VoQkkwckR1bitGcmFFbStQ?=
 =?utf-8?B?TllLYWV3QkJFRjhBN2p4K01KRHkwVmdMK0R4NnB5Vkdkdmt4YmdRNDZucVF4?=
 =?utf-8?B?dnRxMDdOaEhHSWUwNjllVjZTQzVFT1F3amprY01FeTZ4Z3g3ZFFHVHVnR1pz?=
 =?utf-8?B?eVZBcHF6a3JaVlMxRzlWZkpTVzIvMis0OWlKZ01KMFJ3dVVzSUNvRXVoZWgr?=
 =?utf-8?B?enhQSmg5aXMrT3p3NHpOa0h2Mk1icGozTlIrK1NXdmhRUmNWSUhwUU5tN2h2?=
 =?utf-8?B?c3dFcVU4Vy9vK3owNm44N21PZ2dtOGFHaEJjdm5HQnl4bVMrTThXNmFvRTIx?=
 =?utf-8?B?cStBcWNVc3lPbVVzRWRMajE1cnU3NDhISFFOZCtSYVZjQmdXS3dQU0lZOEh3?=
 =?utf-8?B?MGtHUG0zYVRuYUU1anVIWTJyRGZXQllLUVZhalViVUlLdG5GZUNBV3p3dm9R?=
 =?utf-8?B?YXFDQy9FWnJXdVN3QnlKM3JVQnB2UUFVYjgzeC9XYVFsUHFxelo2NFJTU0l2?=
 =?utf-8?B?QkNrZFMzSDhiRUlkV0VaUnp0TU1wY2EzM3NxMURmWHUzcmMzaS9ITEJ2dWZr?=
 =?utf-8?B?ZGxNdjA0d2UwQ3VCcUVHYlVmSWl1d3VFSmlZeGNhT2RQY1pVZmZJMm9RVzJ3?=
 =?utf-8?B?ZVc4RjdhV0FPRTNkNVJWQ3E1V1pDaVdENkt4eWVrNnRIbDVyUDVTdVc4OFV6?=
 =?utf-8?B?VGRORWtTUU0wdkdwaHhxZ2Uzbjg3YkE4Qm9ncm1QcFFmQWFwSWYyZmZwU3FV?=
 =?utf-8?B?RjN0RUtmR2xYUlI0WlpMQlVoY0wrRXdVMHdaSm1MM0dmNUpSeTc0UkJNUnBo?=
 =?utf-8?B?SE1tbWR6NWJ5MUx6RHZnU3ZqQm5vNmlSNG9hMzYrZk42QjI1ai9KM29yTEcv?=
 =?utf-8?B?TmtjRjR6MVg1V0RjVzd3T3dPVmNPRVRhRkkzNTltRzNZa2NNWE9KOXc3T0pn?=
 =?utf-8?B?SkpnVEM0WkpybzhaWFZZK1ZsMDBsbDBoNVRoMzFYYlgva0dKcUdmM0NVL3RO?=
 =?utf-8?B?dGdtcnJQRVhsbUFCNWk4NVpBMWlPQk9mcUlOU1A0TGE2dWY5TnQ0aE55R0ps?=
 =?utf-8?B?dVhUckpNTGF4ZTdjUEVJNG9vR1YzQTVZaWlkczZzb09qVTkySG9BMlAxVk8w?=
 =?utf-8?B?bEdYbDc1VVlheDlyMjFodWgzdkxYcHA0LzFhN1kyWFl3WVZWMEtkanoyS0Js?=
 =?utf-8?B?RlRPdW54YXdhY3ZKK3BvbUI4Um1MNWNPQi9vQ2Z6TW9xQnMzVFBBWENQR1lk?=
 =?utf-8?B?RWtNNUwrSGtWdVE1MVJoa29yTXhtWm9VNmh6UklsTW45TU5zQStKVmpLTkJz?=
 =?utf-8?B?VkdyaklpQi9ocVB0R2F0YlVOZ09RS2RXbWl2UDFBRW9meTR5V3hDcmxQSGwy?=
 =?utf-8?B?bzlXaUxmcVo4Q1hHYWZ5VTUwTStjMHlTb2ltVm1iVVROeGxaYU43OUFKRjFT?=
 =?utf-8?B?aWZ6Yk12Q0MwUDhvWmJBRlBmT2lQajZRTk5IdVpWelYvNFZZa3FJOHBsNmdw?=
 =?utf-8?B?RFovSVJ3Q1dVWE9SOEdCY3d1SUZqMWh3TjZsTGlEejV5SmdycWZ2LzU3NVB1?=
 =?utf-8?B?YkREQ3dXOEZJL256MktXL0hSWkNCWXN5Tmd1clZ0MktJN1c4T0JQdElWWlh6?=
 =?utf-8?B?aUc0NWtBbVkwMitITDdEd2h0cWo3ZkpZc2krN2lWTjRsVVpwN2srcVp5Y2dw?=
 =?utf-8?B?a0doRGNmZ01kWWxqN0w5UDd3blVKNFc1T3k0K0lha1F6Y3Mzd3IyQ2RBMFBI?=
 =?utf-8?Q?2KxNcCDtC+/Nuiieu+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fbfd3c-89a7-484c-aa0e-08df304e1091
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:06:35.5312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgcswARg6cJgUU+GxRaYsXDtIPJx1IGofmmdTkpLVyoqyfqSfBprmZwttKgn3CEE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 12:54, Olivier Kaloudoff wrote:
> drm_sched_entity_push_job() queues the job on entity->job_queue first,
> then drm_sched_rq_add_entity() notices entity->stopped under
> entity->lock, prints "Trying to push to a killed entity" and returns
> NULL. The scheduler is never woken, the job strands on the spsc queue
> forever, and its fences never signal, hanging any task that waits on
> them.
> 
> One way to hit this is process kill racing a late submission from the
> same address space: an amdkfd SVM migration job submitted from the
> fault path of a dying process (SIGBUS on device unplug -> coredump ->
> get_dump_page -> svm_migrate_to_ram) lands on the process's already
> killed entity and is never completed, which then wedges the entire
> PCIe hot-unplug removal thread.
> 
> Check entity->stopped under entity->lock before queueing; since
> drm_sched_entity_kill() only sets ->stopped while holding that same
> lock, this cannot race. A job pushed to a stopped entity is never
> queued; instead it is run through the normal kill-jobs work so its
> finished fence completes with -ESRCH, exactly like the jobs drained by
> drm_sched_entity_kill() itself. The sched->score increment is balanced
> explicitly since drm_sched_job_done() only decrements it for jobs that
> actually run.
> 
> An earlier attempt [1] checked ->stopped without holding entity->lock
> and was rejected as racy; this performs the check under the lock where
> ->stopped is written.
> 
> Note: Tvrtko Ursulin's entity run-queue consolidation series [2]
> moves this code around, making drm_sched_entity_push_job() lockless
> and taking entity->lock inside drm_sched_rq_add_entity() instead.
> The orphan survives that series unchanged -- the job is queued before
> the NULL return and nothing completes it -- so this fix stays needed
> whichever lands first; the loser's side just needs a context rebase.

A non signaled fence can deadlock the kernel, but signaling a fence when there are eventually operations still running can cause random memory corruption. So I think that patch here makes things even worse.

Whatever we do we can only loose and the most reasonable thing to do is to call BUG().

A stopped entity is an entity which was killed and eventually freed up, the only reason that is not an use after free is because the backing memory stays around a bit longer than the entity itself.

This here is something we really need to fix inside the caller, in this particular case here amdgpu's hot remove handling.

Regards,
Christian.

> 
> [1] https://lore.kernel.org/dri-devel/20250811072050.3838241-1-Tong.Liu01@amd.com/
> [2] https://lists.freedesktop.org/archives/amd-gfx/2026-April/142980.html
> 
> Fixes: 62347a33001c ("drm/scheduler: Add stopped flag to drm_sched_entity")
> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: "Christian König" <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 21 ++
>  1 file changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 673ca9cbf..22ecc9bfd 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -651,6 +651,27 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  
>  	spin_lock(&entity->lock);
>  
> +	/*
> +	 * A stopped entity is never put back on a run queue, so a job
> +	 * queued on it would be stranded forever and its fences would
> +	 * never signal, hanging any task waiting on them. Don't queue
> +	 * the job at all; run the normal kill-jobs work on it so its
> +	 * finished fence completes with -ESRCH.
> +	 */
> +	if (unlikely(entity->stopped)) {
> +		spin_unlock(&entity->lock);
> +		/*
> +		 * Balance the atomic_inc(&sched->score) above; the
> +		 * decrement in drm_sched_job_done() only happens when
> +		 * the job actually runs on a scheduler.
> +		 */
> +		atomic_dec(entity->rq->sched->score);
> +		DRM_ERROR("Trying to push to a killed entity\n");
> +		INIT_WORK(&sched_job->work, drm_sched_entity_kill_jobs_work);
> +		schedule_work(&sched_job->work);
> +		return;
> +	}
> +
>  	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
>  
>  	/* first job wakes up scheduler */

