Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2D3107639C
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 18:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F35EE10ECAB;
	Wed,  1 Apr 2026 18:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SMuW3VRV";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BDD710EE6A
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775066661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YHfausQ4IwtvMkybG2aXvWsg8wsDkjntzxDmbQVjIVI=;
 b=SMuW3VRVBRozf1enqmHus1KoY5WSfn0+R8RDrO9sRqa95ESaOAcSlBFAZ2db/DiEGBxDOy
 9EVU80aryRhLhv5HVCtmbKolLfFc0g7RgAtUx9mZSNOQtu86qPJ4x+DYnHGbGK0LUD2vxG
 I2rDFJxZIXkjIb0BtMDUlKKPp9kQJZU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-kqARiL1nPcOtGWdsxsHEjQ-1; Wed,
 01 Apr 2026 14:04:18 -0400
X-MC-Unique: kqARiL1nPcOtGWdsxsHEjQ-1
X-Mimecast-MFC-AGG-ID: kqARiL1nPcOtGWdsxsHEjQ_1775066656
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6223A1800372; Wed,  1 Apr 2026 18:04:16 +0000 (UTC)
Received: from [10.22.81.104] (unknown [10.22.81.104])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0A5630001A2; Wed,  1 Apr 2026 18:04:14 +0000 (UTC)
Message-ID: <55434043-ec42-4c3a-a534-4f7a46f4fb17@redhat.com>
Date: Wed, 1 Apr 2026 14:04:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] workqueue: Add pool_workqueue to pending_pwqs list
 when unplugging multiple inactive works
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Carlos Santa <carlos.santa@intel.com>,
 Ryan Neph <ryanneph@google.com>, stable@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
References: <20260401010739.1053192-1-matthew.brost@intel.com>
 <8eaf9c5e-70fc-4d68-a919-df371bb38283@redhat.com>
 <ac08UdszEeEI2iJj@gsse-cloud1.jf.intel.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ac08UdszEeEI2iJj@gsse-cloud1.jf.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: ZrxijZ8-wsLWKhkZ3AzQ_g3wVFbFkJv5659jLvuS0dw_1775066656
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

On 4/1/26 11:40 AM, Matthew Brost wrote:
> On Wed, Apr 01, 2026 at 10:44:55AM -0400, Waiman Long wrote:
>> On 3/31/26 9:07 PM, Matthew Brost wrote:
>>> In unplug_oldest_pwq(), the first inactive work item on the
>>> pool_workqueue is activated correctly. However, if multiple inactive
>>> works exist on the same pool_workqueue, subsequent works fail to
>>> activate because wq_node_nr_active.pending_pwqs is empty — the list
>>> insertion is skipped when the pool_workqueue is plugged.
>>>
>>> Fix this by checking for additional inactive works in
>>> unplug_oldest_pwq() and updating wq_node_nr_active.pending_pwqs
>>> accordingly.
>>>
>>> v2:
>>>    - Use pwq_activate_first_inactive(pwq, false) rather than open coding
>>>      list operations (Tejun)
>>>
>>> Cc: Carlos Santa <carlos.santa@intel.com>
>>> Cc: Ryan Neph <ryanneph@google.com>
>>> Cc: stable@vger.kernel.org
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> Fixes: 4c065dbce1e8 ("workqueue: Enable unbound cpumask update on ordered workqueues")
>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>
>>> ---
>>>
>>> This bug was first reported by Google, where the Xe driver appeared to
>>> hang due to a fencing signal not completing. We traced the issue to work
>>> items not being scheduled, and it can be trivially reproduced on drm-tip
>>> with the following commands:
>>>
>>> shell0:
>>> for i in {1..100}; do echo "Run $i"; xe_exec_threads --r \
>>> threads-rebind-bindexecqueue; done
>>>
>>> shell1:
>>> for i in {1..1000}; do echo "toggle $i"; echo f > \
>>> /sys/devices/virtual/workqueue/cpumask; echo ff > \
>>> /sys/devices/virtual/workqueue/cpumask; echo fff > \
>>> /sys/devices/virtual/workqueue/cpumask ; echo ffff > \
>>> /sys/devices/virtual/workqueue/cpumask; sleep .1; done
>>> ---
>>>    kernel/workqueue.c | 11 ++++++++++-
>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>>> index b77119d71641..bee3f37fffde 100644
>>> --- a/kernel/workqueue.c
>>> +++ b/kernel/workqueue.c
>>> @@ -1849,8 +1849,17 @@ static void unplug_oldest_pwq(struct workqueue_struct *wq)
>>>    	raw_spin_lock_irq(&pwq->pool->lock);
>>>    	if (pwq->plugged) {
>>>    		pwq->plugged = false;
>>> -		if (pwq_activate_first_inactive(pwq, true))
>>> +		if (pwq_activate_first_inactive(pwq, true)) {
>>> +			/*
>>> +			 * pwq is unbound. Additional inactive work_items need
>>> +			 * to reinsert the pwq into nna->pending_pwqs, which
>>> +			 * was skipped while pwq->plugged was true. See
>>> +			 * pwq_tryinc_nr_active() for additional details.
>>> +			 */
>>> +			pwq_activate_first_inactive(pwq, false);
>>> +
>>>    			kick_pool(pwq->pool);
>>> +		}
>>>    	}
>>>    	raw_spin_unlock_irq(&pwq->pool->lock);
>>>    }
>> Thanks for fixing this bug. However, calling pwq_activate_first_inactive
> No problem — I think this one has been lurking around for a while, and
> we’ve just papered over it in Xe for a couple of years.
>
>> twice can be a bit hard to understand. Will modifying pwq_tryinc_nr_active()
> I actually think it makes quite a bit of sense, as it matches what
> __queue_work does if two items are added back-to-back on an ordered
> workqueue — the first one updates the nr_active counts and activates,
> and the second one updates the pending_pwqs.
This patch works because only an ordered workqueue with a max_active of 
1 can be plugged. Perhaps you should put the note above into the comment 
too.
>> like the following works?
>>
> My initial thought was that your snippet should work — in fact, it does
> for a while (drm-tip hangs almost immediately), but eventually I do get
> a hang when running my reproducer, whereas with this patch I don’t. I
> can’t reason exactly why — maybe it’s because
> node_activate_pending_pwq() can find a plugged pwq, but that’s just a
> guess.

That may be the case. Thanks for checking it anyway.

Acked-by: Waiman Long <longman@redhat.com>

> Matt
>   
>> Thanks,
>> Longman
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index b77119d71641..b35e6e62e474 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -1738,9 +1738,6 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
>>                  goto out;
>>          }
>> -       if (unlikely(pwq->plugged))
>> -               return false;
>> -
>>          /*
>>           * Unbound workqueue uses per-node shared nr_active $nna. If @pwq is
>>           * already waiting on $nna, pwq_dec_nr_active() will maintain the
>> @@ -1749,13 +1746,19 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
>>           * We need to ignore the pending test after max_active has increased as
>>           * pwq_dec_nr_active() can only maintain the concurrency level but not
>>           * increase it. This is indicated by @fill.
>> +        *
>> +        * If @pwq is plugged, we need to make sure that it is linked to a
>> +        * pending_pwqs of a $nna.
>> +        *
>>           */
>> -       if (!list_empty(&pwq->pending_node) && likely(!fill))
>> +       if (!list_empty(&pwq->pending_node) && likely(!fill || pwq->plugged))
>>                  goto out;
>> -       obtained = tryinc_node_nr_active(nna);
>> -       if (obtained)
>> -               goto out;
>> +       if (likely(!pwq->plugged)) {
>> +               obtained = tryinc_node_nr_active(nna);
>> +               if (obtained)
>> +                       goto out;
>> +       }
>>          /*
>>           * Lockless acquisition failed. Lock, add ourself to $nna->pending_pwqs
>> @@ -1773,7 +1776,8 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
>>          smp_mb();
>> -       obtained = tryinc_node_nr_active(nna);
>> +       if (likely(!pwq->plugged))
>> +               obtained = tryinc_node_nr_active(nna);
>>          /*
>>           * If @fill, @pwq might have already been pending. Being spuriously
>>

