Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75D8CD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1486113FA2;
	Thu,  4 Jun 2026 11:52:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cCtsOGRw";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC7D113FA2
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0XYWENPrBjIENXt8ggquUvJiJdTMw6mKgz5J6wnrJJY=; b=cCtsOGRw0sHgwMiujcBrpukf/G
 g4HDBUVX8XI/3/A5HY5my2fTlSegfDVHAYRcVAAHiiG6QSt6gmxAkVKa+NbUdB9Q6sFBNx1b1vNgi
 /aCm9qCiygM6U6cEYV2dmNnSVcs/CL0fxkw2+ttJrRYFdxQ/WgFP/LI17T7tL6W4Lc2Sw4Xzvcdob
 9YjFLxF/f9/Fl9VQiO8NffR8CeH8+88yZPmtarrLu19F1Jk8EhKjkVLLZSh0Xcx2vEOWQiPi1yMI9
 DTcLsjQJQFNQ12vG9kNxo1d64WS/KTlgf8yphlS/e58wg1exfdXPFpppCeZNqlXz+Y8E4BrWVVFSw
 cPl/ircA==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wV6co-00CcSy-7D; Thu, 04 Jun 2026 13:52:38 +0200
Message-ID: <7fecd592-38a1-46bb-8289-cb8599b2df4d@igalia.com>
Date: Thu, 4 Jun 2026 08:52:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] drm/v3d: Introduce struct v3d_submit and convert
 CL/TFU/CSD ioctls
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
 <20260603-v3d-sched-misc-fixes-v3-8-d7114bba55a0@igalia.com>
 <f015504f-ac09-4de3-9727-473108d6757f@igalia.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <f015504f-ac09-4de3-9727-473108d6757f@igalia.com>
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

Hi Tvrtko,

On 04/06/26 05:58, Tvrtko Ursulin wrote:
> 
> On 03/06/2026 23:25, Maíra Canal wrote:
>> +static int
>> +v3d_submit_jobs(struct v3d_submit *submit)
>> +{
>> +    struct v3d_dev *v3d = submit->v3d;
>> +    int ret = 0;
>> +
>> +    mutex_lock(&v3d->sched_lock);
>> +
>> +    for (int i = 0; i < submit->job_count; i++) {
>> +        struct v3d_job *job = submit->jobs[i];
>> +
>> +        v3d_push_job(job);
>> +
>> +        if (i + 1 < submit->job_count) {
>> +            ret = drm_sched_job_add_dependency(&submit->jobs[i + 1]- 
>> >base,
>> +                               dma_fence_get(job->done_fence));
> 
> Is there a theoretical race where job->done_fence could be completed and 
> last reference dropped between push and here?

There is, but it'll be fixed in "[PATCH v3 14/14] drm/v3d: Ensure atomic
submissions in v3d_submit_jobs()".

> 
>> +            if (ret)
>> +                goto err;
>> +        }
>> +    }
>> +
>> +err:
>> +    mutex_unlock(&v3d->sched_lock);
>> +    return ret;
>> +}
>> +
>>   static int
>>   v3d_setup_csd_jobs_and_bos(struct drm_file *file_priv,
>>                  struct v3d_dev *v3d,
>> @@ -921,18 +1048,15 @@ int
>>   v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>>               struct drm_file *file_priv)
>>   {
>> -    struct v3d_dev *v3d = to_v3d_dev(dev);
>> -    struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
>> +    struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = 
>> file_priv };
>>       struct drm_v3d_submit_cl *args = data;
>>       struct v3d_submit_ext se = {0};
>>       struct v3d_bin_job *bin = NULL;
>>       struct v3d_render_job *render = NULL;
>>       struct v3d_job *clean_job = NULL;
> 
> render and clean_job do not need to be initialised.

Ack.

>> +
>> +    ret = v3d_attach_perfmon_to_jobs(&submit, args->perfmon_id);
>> +    if (ret)
>> +        goto fail;
>> +
>> +    ret = v3d_lookup_bos(dev, file_priv,
>> +                 submit.jobs[submit.job_count - 1],
> 
> submit.jobs[submit.job_count - 1] is repeated four times in the function 
> so you could assign it to a last_job local for more readability. Up to you.

This will all disappear in the next few patches.

Considering this, would you consider R-b-ing this patch and I'll address
the initializations in the next version?

Best regards,
- Maíra

