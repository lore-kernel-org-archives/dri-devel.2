Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BF6CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 11:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0805E10E3AF;
	Thu, 14 May 2026 11:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YNsrm3SO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F78B10E3AF
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qdhUL1NJVGhWXAsEFv60ohLiT1GSMEtSbwbygCIhGh8=; b=YNsrm3SOtPVkk1ggooHGZaXeZs
 Sehj+KM2/ooUkj36vi6VmHW46/lWwtpVe966RRYtsYITWu+oZiDWr8YCdCCT7egNdzCld8gn3BTMl
 vS8LaXjQK+VeIJoQgEtItTriwhyKcs1ooqsUd92G7yN1fUEMfDV4/9ILgYDXt45t0Z5EwEHgaDZjO
 qhZIVXZlI2qIWk8S7dGhvcFFhtZ+K7eFyuVIGHMSHamrKdECLLnSUQJ1qGTB7Mi263BMq09sgA8q4
 /6DSjVdIdM3Pfq3LAvuoQxepfs033HXKc3vzsrTw6B0BBtDQCZNeBMibPlIVBzHAen+cDXAveLf5q
 krcLWMRA==;
Received: from [189.7.87.67] (helo=[192.168.0.5])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wNTyF-00AQRq-U4; Thu, 14 May 2026 13:11:16 +0200
Message-ID: <2f038d56-588a-45b7-9bd5-788b9589328f@igalia.com>
Date: Thu, 14 May 2026 08:11:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel: ethosu: Add performance counter support
To: Rob Herring <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org
References: <20260306163658.2741860-2-robh@kernel.org>
 <f4b64049-e7f4-4d96-84f2-e8dac2cf5322@igalia.com>
 <CAL_JsqLyZ0mtj-i6sOS9rccdc73QGcJt44Tx9jfR8f=eGX--dg@mail.gmail.com>
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
In-Reply-To: <CAL_JsqLyZ0mtj-i6sOS9rccdc73QGcJt44Tx9jfR8f=eGX--dg@mail.gmail.com>
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

Hi Rob,

On 12/05/26 11:45, Rob Herring wrote:
> On Tue, May 5, 2026 at 1:46 PM Maíra Canal <mcanal@igalia.com> wrote:
>>
>> Hi Rob,
> 
> Thanks for the review Maíra!
> 
>> On 06/03/26 13:36, Rob Herring (Arm) wrote:
>>> The Arm Ethos-U NPUs have a PMU with performance counters. The PMU h/w
>>> supports up to 4 (U65) or 8 (U85) counters which can be programmed for
>>> different events. There is also a dedicated cycle counter.
>>>
>>> The ABI and implementation are copied from the V3D driver. The main
>>
>> I'm planning to send a series fixing some perfmon locking issues in the
>> V3D driver later this week. But, to give you a brief summary of the main
>> issues:
>>
>> 1. The active perfmon is not protected against races (run_job() vs.
>> IOCTLs).
>>
>> 2. ethosu_switch_perfmon() only starts/stops the perfmon in run_job().
>> This means that if nothing is further queued up, a perfmon will never
>> actually be stopped.
> 
> For ethosu, other than idle and cycle counts, nothing else counts when
> a job is done. Idle is just the time from enabling the counter to
> start a job and then from the job stopping to reading the counters.
> IOW, the idle count while a job is running is 0 and
> idle+active=cycles.
> 
> 
>> More comments inline:
>>
>>> difference in the ABI is there is no query API for the the event list.
>>> The events differ between the U65 and U85, so the events lists are
>>> maintained in userspace along with other differences between the U65 and
>>> U85.
>>>
>>> The cycle counter is always enabled when the PMU is enabled. When the
>>> user requests N events, reading the counters will return the N events
>>> plus the cycle counter.
>>>
>>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>>> ---
>>> MR for mesa with initial support is here:
>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40269
>>>
>>>    drivers/accel/ethosu/Makefile         |   2 +-
>>>    drivers/accel/ethosu/ethosu_device.h  |  21 ++
>>>    drivers/accel/ethosu/ethosu_drv.c     |  17 +-
>>>    drivers/accel/ethosu/ethosu_drv.h     |  62 ++++++
>>>    drivers/accel/ethosu/ethosu_job.c     |  35 +++-
>>>    drivers/accel/ethosu/ethosu_job.h     |   2 +
>>>    drivers/accel/ethosu/ethosu_perfmon.c | 282 ++++++++++++++++++++++++++
>>>    include/uapi/drm/ethosu_accel.h       |  59 +++++-
>>>    8 files changed, 469 insertions(+), 11 deletions(-)
>>>    create mode 100644 drivers/accel/ethosu/ethosu_perfmon.c
>>>
>>
>> [...]
>>
>>> diff --git a/drivers/accel/ethosu/ethosu_drv.h b/drivers/accel/ethosu/ethosu_drv.h
>>> index 9e21dfe94184..57eee79e4b83 100644
>>> --- a/drivers/accel/ethosu/ethosu_drv.h
>>> +++ b/drivers/accel/ethosu/ethosu_drv.h
>>> @@ -3,13 +3,75 @@
>>>    #ifndef __ETHOSU_DRV_H__
>>>    #define __ETHOSU_DRV_H__
>>>
>>> +#include <linux/idr.h>
>>> +#include <linux/mutex.h>
>>>    #include <drm/gpu_scheduler.h>
>>>
>>>    struct ethosu_device;
>>> +struct drm_device;
>>> +struct drm_file;
>>>
>>>    struct ethosu_file_priv {
>>>        struct ethosu_device *edev;
>>>        struct drm_sched_entity sched_entity;
>>> +
>>> +     struct {
>>> +             struct idr idr;
>>
>> You may want to consider moving to XArray as we did in V3D [1].
> 
> Okay. I'll have to study that some. I still don't have my head around XArray...
> 
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0a5b0d095bcdb219348ed8ae1c97ee99fc4913b8
>>
>>> +             struct mutex lock;
>>> +     } perfmon;
>>> +};
>>> +
>>> +/* Performance monitor object. The perform lifetime is controlled by userspace
>>> + * using perfmon related ioctls. A perfmon can be attached to a submit_cl
>>> + * request, and when this is the case, HW perf counters will be activated just
>>> + * before the submit_cl is submitted to the GPU and disabled when the job is
>>> + * done. This way, only events related to a specific job will be counted.
>>> + */
>>> +struct ethosu_perfmon {
>>> +     /* Tracks the number of users of the perfmon, when this counter reaches
>>> +      * zero the perfmon is destroyed.
>>> +      */
>>> +     refcount_t refcnt;
>>> +
>>> +     /* Protects perfmon stop, as it can be invoked from multiple places. */
>>> +     struct mutex lock;
>>
>> I'm not familiar with the Ethos hardware, but *if* it has only a single
>> performance monitor active in HW at any given moment (like v3d), this
>> lock doesn't enforce this restriction.
>>
>> This lock only serializes start/stop of *one* perfmon object against
>> itself, but the invariant (at least on v3d) that needs protection is
>> device-wide: there is exactly one active perfmon at any moment in HW.
> 
> You mean V3D has 1 perfmon shared among its 3? h/w queues? We only
> have 1 queue. We only touch the perfmon when we touch the h/w to
> run/end a job, so the same serialization for the job accesses should
> cover the PMU accesses.
> 

I mean that userspace can create multiple software perfmons through
ethosu_ioctl_perfmon_create(), but AFAIU there is only one HW perfmon in
the device.

In that case, ethosu_perfmon->lock only serializes operations on a
single software perfmon object against itself. It does not serialize
accesses between different software perfmon objects, so two perfmons
could still race for the same unique HW perfmon.

If the HW exposes only one perfmon, it might be better to move this
lock to ethosu_device. That would protect the HW perfmon itself and
make the “only one active perfmon at a time” invariant explicit by
ensuring serialization between different software perfmons.

Best regards,
- Maíra

> Rob

