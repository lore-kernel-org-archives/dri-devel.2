Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7E60A2607
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=foSmjJpT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B5110F542;
	Tue, 20 Oct 2026 12:56:32 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C60510F542;
 Tue, 20 Oct 2026 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=rcqQs1KsuV1i9etju70EFVPW7acs6Azgaihxvv3DMvY=; b=foSmjJpTbfllhPwFXHyRdx7ZrY
 /s5fI7OKUZCwkP5r+D3My3lMbKSWb3wjc2MrSPCphkb7LyconjXN7vz+JtUMHf6fnmy+p22p3TYfR
 d0QATcSOZo39sjp+0skwWF066rWBv8aeVXlF7MddbKJyabq5/68GQVQHfX9TYx9appq+TbOgZBIyV
 22T2y1kfXti0u8W7OCxxnamGL6Sjd7KzACzRa2oTSU29SwfHsy0czovbnt2XI1oeKiQ/wsXaBs98R
 qkmMvvbAw++itp7izjhtv9uPCJp8qke7vxLPizgsMrxGuUENw5ePaFDM9iwWQ192NI8pLJl3MNw9T
 9S0dO9bQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJ9OD-004adJ-5m; Tue, 20 Oct 2026 14:56:25 +0200
Message-ID: <1e33d9fa-f278-4bb6-a166-73a94dba2c5f@igalia.com>
Date: Tue, 20 Oct 2026 13:56:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] drm/sched: Replace completion with a flush
To: sashiko-reviews@lists.linux.dev
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
 <20261002154713.77591-9-tvrtko.ursulin@igalia.com>
 <20261003013314.507811F00893@smtp.kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20261003013314.507811F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 03/10/2026 02:33, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] drm/sched: cross-entity deadlock via flush_work() in drm_sched_entity_kill()
> --
> 
> commit 3786a3d89362d00183a97f456e4eaeb1dff144f4
> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> drm/sched: Replace completion with a flush
> 
> This commit removes the per-entity completion used to synchronize entity
> teardown, replacing it with a direct flush of the scheduler's run job
> worker. The goal is to achieve the same synchronization guarantee without
> requiring the scheduler to signal a completion when an entity goes idle.
> 
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> [ ... ]
>> @@ -304,16 +299,23 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>>   void drm_sched_entity_kill(struct drm_sched_entity *entity)
>>   {
> [ ... ]
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
> 
> [Severity: High]
> Could this introduce a cross-entity deadlock regression during context teardown?
> 
> Because drm_sched_flush_run_work calls flush_work on the scheduler's shared
> worker, it synchronously waits for the worker to finish its current execution.
> This might cause it to wait on a job belonging to a completely different
> entity.
> 
> If a process destroys its device context and triggers drm_sched_entity_kill
> while holding a driver-specific lock, and the shared worker is concurrently
> running drm_sched_run_job_work for an unrelated entity, that driver-provided
> run_job callback might attempt to acquire the same driver lock.
> 
> The original code used a per-entity completion (entity_idle) which explicitly
> avoided waiting on other entities. Does this flush create a new cross-entity
> dependency that could lead to a deadlock?

I don't see that anyone flushes entities under some driver lock, nor 
that anyone would ever want to do that. So I am trending towards saying 
this is not a concern.

Regards,

Tvrtko

