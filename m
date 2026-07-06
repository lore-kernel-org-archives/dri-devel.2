Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A72C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962CE10E917;
	Mon,  6 Jul 2026 12:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="DEGeeabR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0A110E917
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=55gmLcJ85/0JRNc6P95j7xiP6Emzben5yecc81t/fNg=; b=DEGeeabRJiglW+yYlpucbeKRkp
 q3w9Ql/MkNRgOCY22gh1iBUJ47iLUBbckSqST1945uj1OTYjlcFjBXwZOy3nAVkc0wSVhkoJfVhlY
 zahjGTDrYyrmEmuWIN2TliGoes0m/nTilzZBGMJIBGvuRJLQ+PkrNOQui8KP2ovOg7Bq/CNRVA8wN
 yctvpEZ5knUOqMFPurX3GnNXLugWFtYLFLaQrl84RBKnXMNvCntpk2MUzh4kIeRGfa+E3X6ZXnqvn
 fQSzJhK6UOkL1L2jtcRi1ObM1fbpLYHoJZA0njkpyDKqIk2qrlbZZRPCSuU9H7cxHzCcau7xnYt3T
 MjL3n+aQ==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wgiJe-009jEY-N7; Mon, 06 Jul 2026 14:20:50 +0200
Message-ID: <b76ea01c-ead3-4eaf-86a7-5bf91bfdb9cb@igalia.com>
Date: Mon, 6 Jul 2026 13:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, kernel-dev@igalia.com,
 Tejun Heo <tj@kernel.org>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <4eb23476ff56bee108578adfe131be38e8fc1476.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <4eb23476ff56bee108578adfe131be38e8fc1476.camel@mailbox.org>
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


On 03/07/2026 09:52, Philipp Stanner wrote:
> +Cc Tejun
> 
> On Thu, 2026-07-02 at 15:37 +0100, Tvrtko Ursulin wrote:
>>
> 
> […]
> 
>> DRM scheduler was originally using kthreads but was converted workqueues due
>> desire by xe to create thousands of schedulers. This series also questions
>> whether that was needed, given how the submission is serialized by a device
>> global lock (per GT, so almost device global). Panthor has a similar situation;
>> hence the series contains two patches to move those two to a setup which matches
>> the design of those drivers.
>>
>> Other drivers, like for example amdgpu, v3d, etnaviv etc, which use the
>> scheduler as a hardware scheduler, where number of instances follow the number
>> of hardware blocks instead the number of userspace contexts, are completely
>> fine.
>>
>> There are use cases however which do currently track the number of userspace
>> contexts and which do allow for more parallelism. For those a straight
>> kthread_work conversion would be a problem due an explosion in number of
>> threads.
>>
>> The most direct example is panthor VM bind queue which creates a scheduler per
>> userspace context and relies on work queue concurrency management to keep the
>> number of threads in check.
>>
>> This creates a challenge for the kthread_work conversion. To solve which I for
>> now opted to create a trivial round-robin thread pool. For the RFC this is
>> limited to four CPU threads and is something which will need to be discussed.
>> Ie. how much parallelsim those really need. The true answer is somewhere between
>> "at most the number of active userspace contexts and the number of CPU cores".
>> Or it could be less than that, since after all, VM BIND parallelism is
>> eventually going to choke on a narrower gate of actual GPU execution. We could
>> also allow drivers to pick their number.
> 
> Anyone remember whether that was discussed back in the day of
> converting to workqueue?

AFAIR the only thing was that existing usage of kthreads did not scale 
for the new use case of one DRM scheduler per userspace context.

> What makes this idea suspicious in my mind is that the workqueue
> implementation exists to solve precisely this issue: decide how many
> kthreads really need to be spawned. AFAIK it can spawn additional
> threads dynamically if necessary.
> 
> So the first question I would like to see considered is whether
> workqueue could be improved in any way to address said latency issues.
> 
> Have you already considered that, Tvrtko?

Yes, priority inheritance was justifiably rejected for generic 
workqueues. There is WQ_HIGHPRI, but the idea here is to go one step 
further and allow tracking realtime scheduling policies.

> IOW, is it the nature of workqueue or our way of using them in
> drm_sched which causes this performance difference in the submit path?

Mostly self inflicted pain by the kthread->workqueue DRM scheduler 
conversion.

Before we had threads which were woken up on first submission and would 
fed the GPU until the software side queue was empty. With that design we 
would still have the scheduling latency on the first submit but it would 
be easy to add priority inheritance.

After the workqueue conversion, it is not only that we lost the ability 
to do priority inheritance, but it was also changed to only feed one job 
at the time to the GPU and rely on efficient worker re-queue.

> It would seem that it's the desire for more fine-grained scheduling
> characteristic control that you get with a kthread.

I think we have roughly three options:

1) Just use WQ_HIGHPRI and accept real time clients at best get re-nice 
level boost. But no RT.

2) Do something along the lines of this RFC.

3) Split the scheduler into frontend and backend parts and make 1:1 
drivers not use the actual scheduler.

The last one can be a combination of efforts. For example we can not go 
for splitting the scheduler design, but adding a new dependency sorter 
scheduler like Matthew was recently proposing. As long as that one can 
handle priority inheritance ie. not suffer this submission latency issue 
for 1:1 drivers it works.

M:N drivers we could then revert the code based back to kthreads and 
probably simplify some things.

Downside is two schedulers in the codebase..

Regards,

Tvrtko

