Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B435CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6187E10E0ED;
	Fri, 16 Oct 2026 08:53:43 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC5F10E0ED
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 08:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=2fZrUSOTZ206+wLywyJBhLbacf5AQAt6MAEx2t+xWjw=; b=ovoZQn6GKxFWwKFD7ZF3XfLjje
 HN27PXUDq3h1BT9Z0gBU5pDIwAC8FqREuhrU9EmXXwv6ZjTKhnRniDbp4sJXY4IaGEVGpybMqwGsy
 nUcVFkemNC3Ci7sUdZ1k6TI1AZoLc3gxOm2o5aFmxTNsd7DHniUyhNeSFahVIvYwwXOhyd8HM/EPz
 VdP9mCCZeFlsrjdJ+cI3swpK8AyvAcRYnM/kvXgt8aMZSZ9cnz6mHoheVY4cNI53olBVA9yNgwjuG
 M2GjEYiv5/JRrTGL5LPZZJLlZ5KqdkLKehKyu+/rm3pQvUbsVtYa2AzAYOWobYpECaIT17NA9WOHl
 M0xV7VkQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xHdh0-000xcD-Ir; Fri, 16 Oct 2026 10:53:34 +0200
Message-ID: <16bf9c91-79b4-4217-b200-e037d9226998@igalia.com>
Date: Fri, 16 Oct 2026 09:53:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Document entity->stopped is protect by
 entity->lock
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>
References: <20261002124655.74716-1-tvrtko.ursulin@igalia.com>
 <c7a17c258ae39abe74e7abe270aaee1daf31258d.camel@mailbox.org>
 <103fba2b-c47f-4b17-a8a6-804ca00ff15a@igalia.com>
 <c4072b932f874bc1fc1bf60a0ead4948eff2b530.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <c4072b932f874bc1fc1bf60a0ead4948eff2b530.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 13/10/2026 11:45, Philipp Stanner wrote:
> On Mon, 2026-10-12 at 09:05 +0100, Tvrtko Ursulin wrote:
>>
>> On 08/10/2026 11:10, Philipp Stanner wrote:
>>> On Fri, 2026-10-02 at 13:46 +0100, Tvrtko Ursulin wrote:
>>>> Commit
>>>> 0e118b936dc5 ("drm/sched: Lock drm_sched_entity_is_idle()")
>>>> has removed the last unlocked entity->stopped access so lets officially
>>>> document it in kerneldoc as locked with the entity lock.
>>>
>>> Ah nice, I overlooked that. Thx for fixing.
>>>
>>> Nit: typo in the commit title, "protectED". I can fix that at applying
>>> if you want.
>>
>> Ah yes, best not to spam the list for that. If you want I can push and
>> tweak as well.
> 
> fine by me
> 
> Acked-by: Philipp Stanner <phasta@kernel.org>

Thank you, pushed!

Regards,

Tvrtko

>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Philipp Stanner <phasta@kernel.org>
>>>> ---
>>>>    include/drm/gpu_scheduler.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>>>> index 563d7fb88a6d..3b0978fa8cf0 100644
>>>> --- a/include/drm/gpu_scheduler.h
>>>> +++ b/include/drm/gpu_scheduler.h
>>>> @@ -101,7 +101,7 @@ struct drm_sched_entity {
>>>>    	 *
>>>>    	 * Lock protecting the run-queue (@rq) to which this entity belongs,
>>>>    	 * @priority, @last_scheduled and the list of schedulers (@sched_list,
>>>> -	 * @num_sched_list) and @rr_ts.
>>>> +	 * @num_sched_list), @rr_ts and @stopped.
>>>>    	 */
>>>>    	spinlock_t			lock;
>>>>    

