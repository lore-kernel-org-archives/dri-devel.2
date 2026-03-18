Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F129107BCF4
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F08FC10E7B9;
	Wed, 18 Mar 2026 10:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="ad7IzKKw";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD5F10E7B9
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:44:04 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso60224595e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 03:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773830643; x=1774435443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1kG8BKd00+dTSphLdn6jytbj/goNh6ZrVP5Wj3Jlxp4=;
 b=ad7IzKKw58NYHNo01jpab89F3lAFKbOlV9bCRKQr0vcdLv0fMxw4pfWDbZs+CqNLBo
 jTaFmVOtZmmZNlod4G4IG6YCyIMEHZHNksa+7x0z2pywLAOTmFEvXf1NtT9elHui62+f
 fMRu3IUuGC2QkSTbmjbQXmptO5GLw96P0qzdpuQULEVYfS/2Vn4IAu7hu0MnzSGADBFN
 LyM6aJoz6KqSkbtL0C6NDOcVONMK0xuAhKPosI1/RyTc0/if1FFzDPbONI+H3P1VoXpK
 TmCpyoRMkY0GcRvUrLHfTXIa7o94Ve+w1dErza+l9iPkZtb1R0B0Bu7x8TkzSoiOsm39
 A3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773830643; x=1774435443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1kG8BKd00+dTSphLdn6jytbj/goNh6ZrVP5Wj3Jlxp4=;
 b=DRgUYtbd3hkYJW2ukobZPqNiBcSHuoz5fHiyQ/UfpAJKO54gKLVc2yVXjJ0czIC4bi
 lAckWkBPzQ+ErRvIQhoyR08o/zqC0G8MTE8K2r8oawIW7qT3C0QQGOkMjbdrDvQQjO0J
 4YPThAPaRQvHEg6H8tBcuUuGJasVyrlEGFuXucGPnZNpr+chZuP+Uidh1QXojpUB6CHP
 9CkLXaupS9h9iKqovS5PAxIow6rHQo9EFV3avK3ayfqX65604mcSHVT9gp9bL6V74NTj
 DtOZzI8UkF7a3r39/UynjVo3GfvMJBG2hGkAggAIS4aeUvYUi6/x65zkELQHI4zG7Hbh
 hlmw==
X-Gm-Message-State: AOJu0YxpPeYPKyIwFQ9xaAahk22azohn3XxeMESePs6G9fCv25/PGWR4
 q+FmUvIEQL7bJYuuCJuMc0cIv9ydkDOUMC8dCPoeEB1QBjEQ4p2L+IWXb9g8Si0hBRc=
X-Gm-Gg: ATEYQzwByQVp5DG/I9N4h+EWx5kEg7OmtUNJo/KkSGae4SajW56ONyy1W1VSVbN2AIP
 msWegcio41Gp0E1vzc+TxgPF/F8J9npw1JRkbd+aPrbeJgSRwsBhdpWw5GYVM26panWFypSAumq
 ddE7BgFwMCi7tp4d0+JoSbOPgrcuHV+c6IUDcrHtinHMzJOiYUz/d7wnW2+7ut2MjK7jqB2wgW9
 MAfPzroSNRLTdMFTD2WIICqAr5pYCyXuDEbFpVPJFS5S0Y70+LZoKOayzw199WzZH8nu8zJuYMy
 8yob5YbsD+80IJYuGyVQuht9MemQiKGvDB8TENOa+4bb6gxMEEi3UVLo/DrU2egCXnsnpvm+C90
 uxM3G6RhZIPBzwnu3iFEUYUvI5SGojKaebcma6NG0yH6038z6drIoGOTGAOkqQLbUlBExiAX5SE
 3fEjNgA4o4fGTgMnrZSh71kX64Su+MrpuifpI0D9I/QxYb
X-Received: by 2002:a05:600c:6d97:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-486f4460736mr31744255e9.15.1773830642628; 
 Wed, 18 Mar 2026 03:44:02 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4e48ad5sm63470795e9.1.2026.03.18.03.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 03:44:02 -0700 (PDT)
Message-ID: <2b50fbad-1fd9-4490-9f30-b7fb8d1e09bc@ursulin.net>
Date: Wed, 18 Mar 2026 10:44:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Add new KUnit test suite for concurrent job
 submission
To: Marco Pagani <marco.pagani@linux.dev>, phasta@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260219140711.3296237-1-marco.pagani@linux.dev>
 <e215efdd-c547-4ce4-affe-7198ed37c2a6@ursulin.net>
 <f5c76fe9d70f106f58b9f06f644534c2cead96fd.camel@mailbox.org>
 <62024790-d792-4789-9452-f5b294969a9a@ursulin.net>
 <8075c105-c7a1-4223-bf67-aa7f0c1b6f76@linux.dev>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <8075c105-c7a1-4223-bf67-aa7f0c1b6f76@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 17/03/2026 17:27, Marco Pagani wrote:
> On 25/02/2026 10:03, Tvrtko Ursulin wrote:
>>
>> On 25/02/2026 07:47, Philipp Stanner wrote:
>>> On Mon, 2026-02-23 at 16:25 +0000, Tvrtko Ursulin wrote:
>>>>
>>>> On 19/02/2026 14:07, Marco Pagani wrote:
>>>>> Add a new test suite to simulate concurrent job submissions to the DRM
>>>>> scheduler. The suite includes two initial test cases: (i) a primary test
>>>>> case for parallel job submission and (ii) a secondary test case for
>>>>> interleaved job submission and completion. In the first test case, worker
>>>>> threads concurrently submit jobs to the scheduler and then the timeline is
>>>>> manually advanced. In the second test case, worker threads periodically
>>>>> submit a sequence of jobs to the mock scheduler. Periods are chosen as
>>>>> harmonic, starting from a base period, to allow interleaving between
>>>>> submission and completion. To avoid impractically large execution times,
>>>>> periods are cycled. The timeline is advanced automatically when the jobs
>>>>> completes. This models how job submission from userspace (in process
>>>>> context) may interleave with job completion (hrtimer callback interrupt
>>>>> context, in the test case) by a physical device.
>>>
>>> I still maintain the opinion expressed the last time: that the commit
>>> message should make explicit why the patch / test is added. Which this
>>> doesn't do. It just says: "We add X", but not "Currently, the problem
>>> is that YZ, thus we need X".
>>> (also breaking longer commit messages into paragraphs is nice)
>>>
>>> Also see my comments about interleaved submits below.
>>
>> I'll address the ones addressed to me.
>>
>> 8><
>>
>>>>> +struct drm_sched_parallel_params {
>>>>> +	const char *description;
>>>>> +	unsigned int num_jobs;
>>>>> +	unsigned int num_workers;
>>>>> +};
>>>>> +
>>>>> +static const struct drm_sched_parallel_params drm_sched_parallel_cases[] = {
>>>>> +	{
>>>>> +		.description = "Workers submitting multiple jobs against a single entity",
>>>>
>>>> Each worker has own entity so the description is a bit confusing.
>>>
>>> Do you have a suggestion for a better one?
>>
>> Along the lines of:
>>
>> "Multiple workers submitting multiple jobs from their entity"
>>
>> 8><
>>
>>>>> +	}
>>>>> +
>>>>> +	for (i = 0; i < params->num_workers; i++) {
>>>>> +		INIT_WORK(&workers[i].work, drm_sched_parallel_worker);
>>>>> +		queue_work(ctx->sub_wq, &workers[i].work);
>>>>> +	}
>>>>> +
>>>>> +	complete_all(&ctx->wait_go);
>>>>> +	flush_workqueue(ctx->sub_wq);
>>>>> +
>>>>> +	for (i = 0; i < params->num_workers; i++) {
>>>>> +		for (j = 0; j < params->num_jobs; j++) {
>>>>> +			done = drm_mock_sched_job_wait_scheduled(workers[i].jobs[j],
>>>>> +								 HZ);
>>>
>>> same
>>>
>>>>> +			KUNIT_ASSERT_TRUE(test, done);
>>>>> +
>>>>> +			done = drm_mock_sched_job_is_finished(workers[i].jobs[j]);
>>>>> +			KUNIT_ASSERT_FALSE(test, done);
>>>>
>>>> This second assert does not seem to be bringing much value, but instead
>>>> makes the reader ask themselves why it is there. Remove it?
>>>>
>>>> Hmm in fact this whole loop could be removed. All that it is needed
>>>> below is to wait for the last job to be completed.
>>>
>>> I suppose it's being tested whether all jobs are finished. That sounds
>>> clean and not harmful to me.
>>
>> No, it is assert false. It is testing the jobs have been scheduled but
>> not completed before the timeline is manually advanced. Both those
>> behaviours are already covered by the existing basic test cases.
>>
>> In my view the general best practice is to focus on the thing being
>> tested, which in this case is the submission side of things. The rest
>> can just distract the reader. And in this case that is parallel
>> submission, which is all done and dusted by the time flush_workqueue
>> above finishes. Everything after that point is just test cleanup.
> 
> I see what you mean. By that point, concurrent submission is complete, so it
> may be considered outside the scope of this test. However, my intent was to
> check that the basic behaviour of the scheduler also holds after the concurrent
> submissions of multiple jobs, which is not covered by the basic test case.
> That said, I'm open to removing those asserts if you and Philipp believe
> they are redundant.

Some time has passed and I don't exactly remember now with the trimmed 
quote. If this part of the test is using manual timeline advancement 
then the assert is basically testing the mock scheduler (not the DRM 
scheduler). For me that is lukewarm, but if you insist feel free to keep it.

Regards,

Tvrtko

