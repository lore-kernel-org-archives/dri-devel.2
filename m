Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FF2CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E51010E253;
	Thu,  4 Jun 2026 12:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WL1ClciG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0219110E253
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ky5YGFDwaAZLt8d9YJquHE9wdHOK5M93Y7ohAMxyIOo=; b=WL1ClciG/6xY/5BBS7plwPJHrm
 /f71b1ASA5Cj3Yt/CVBuUQTNSRswelfItiPmyUQk6sYx/+MTRV1JfNkODS5vN1IP9TUEQyxFB7I5r
 9F9QBHYO7HDtjegpXxKBu31nARvbZe9hOPj1XSX9fspaX3YSBp8nchdN89PCBl97k2nTVQAGL0Vp/
 dyTKV75IH87Sa6crM/H2mtoPP/mlJaCBK5uLk5LXQSGBsBTM0BPwjdBKDm2zXq4mijPn2Lwh/miqC
 E5VL8+vMUar9RvRe67eBahE9108YTTDGQcbet9h+qbD+lqFYbbIpbsIJJLhypk9lcDzph//erEqdg
 IxuJJq8g==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wV6ot-00CciK-DR; Thu, 04 Jun 2026 14:05:07 +0200
Message-ID: <617cb27d-a797-474e-9407-c575a1b393ab@igalia.com>
Date: Thu, 4 Jun 2026 13:05:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] drm/v3d: Introduce struct v3d_submit and convert
 CL/TFU/CSD ioctls
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
 <20260603-v3d-sched-misc-fixes-v3-8-d7114bba55a0@igalia.com>
 <f015504f-ac09-4de3-9727-473108d6757f@igalia.com>
 <7fecd592-38a1-46bb-8289-cb8599b2df4d@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <7fecd592-38a1-46bb-8289-cb8599b2df4d@igalia.com>
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


On 04/06/2026 12:52, Maíra Canal wrote:
> Hi Tvrtko,
> 
> On 04/06/26 05:58, Tvrtko Ursulin wrote:
>>
>> On 03/06/2026 23:25, Maíra Canal wrote:
>>> +static int
>>> +v3d_submit_jobs(struct v3d_submit *submit)
>>> +{
>>> +    struct v3d_dev *v3d = submit->v3d;
>>> +    int ret = 0;
>>> +
>>> +    mutex_lock(&v3d->sched_lock);
>>> +
>>> +    for (int i = 0; i < submit->job_count; i++) {
>>> +        struct v3d_job *job = submit->jobs[i];
>>> +
>>> +        v3d_push_job(job);
>>> +
>>> +        if (i + 1 < submit->job_count) {
>>> +            ret = drm_sched_job_add_dependency(&submit->jobs[i + 1]- 
>>> >base,
>>> +                               dma_fence_get(job->done_fence));
>>
>> Is there a theoretical race where job->done_fence could be completed 
>> and last reference dropped between push and here?
> 
> There is, but it'll be fixed in "[PATCH v3 14/14] drm/v3d: Ensure atomic
> submissions in v3d_submit_jobs()".
> 
>>
>>> +            if (ret)
>>> +                goto err;
>>> +        }
>>> +    }
>>> +
>>> +err:
>>> +    mutex_unlock(&v3d->sched_lock);
>>> +    return ret;
>>> +}
>>> +
>>>   static int
>>>   v3d_setup_csd_jobs_and_bos(struct drm_file *file_priv,
>>>                  struct v3d_dev *v3d,
>>> @@ -921,18 +1048,15 @@ int
>>>   v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>>>               struct drm_file *file_priv)
>>>   {
>>> -    struct v3d_dev *v3d = to_v3d_dev(dev);
>>> -    struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
>>> +    struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv 
>>> = file_priv };
>>>       struct drm_v3d_submit_cl *args = data;
>>>       struct v3d_submit_ext se = {0};
>>>       struct v3d_bin_job *bin = NULL;
>>>       struct v3d_render_job *render = NULL;
>>>       struct v3d_job *clean_job = NULL;
>>
>> render and clean_job do not need to be initialised.
> 
> Ack.
> 
>>> +
>>> +    ret = v3d_attach_perfmon_to_jobs(&submit, args->perfmon_id);
>>> +    if (ret)
>>> +        goto fail;
>>> +
>>> +    ret = v3d_lookup_bos(dev, file_priv,
>>> +                 submit.jobs[submit.job_count - 1],
>>
>> submit.jobs[submit.job_count - 1] is repeated four times in the 
>> function so you could assign it to a last_job local for more 
>> readability. Up to you.
> 
> This will all disappear in the next few patches.
> 
> Considering this, would you consider R-b-ing this patch and I'll address
> the initializations in the next version?

Normally best practice would be avoid leaving a know broken stage 
mid-series. But, as I don't see this series getting half-reverted, but 
instead if there will be regressions you will be the only person working 
to fix them on top, I think we can dispense an exception:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

