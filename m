Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415F606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ursulin.net header.i=@ursulin.net header.a=rsa-sha256 header.s=google header.b=l/Tss5IC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A298A10E01F;
	Thu,  5 Nov 2026 11:04:38 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78BB10E01F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 11:04:32 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so1186897f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 03:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1793876671; x=1794481471; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FFlRj7zu5hDTpY8G/PTsL3dfYcV7jbNwNQB5CRVczZA=;
 b=l/Tss5ICwFwNi9AaF5kZfRNHwFJ2TqlvrFcYk0+dVMpH1NRQo18LAywPVwmFqWghz8
 h2mg40cDaE99atyijC4VBeYBR9RfLQ3JIm/4/1HGi9Ld+j2FLlnZgAmBsZcjCGH29gbh
 P2yQAlqOyWr7PfSbehXzyrQwtRNx+OcawVUHIiDFGu1Qb0w5N+6rIPU7LXEArVUymTWp
 BXedc8oHgxX13rypmtCct4Vxij0OaKUCSr+HgFC2yB5fvjMhK7FgJNVkRgFxtXvnF04q
 PbfvugbwSWvho7bz1smtxYTgdUnlM4ihJveF7MnZ29rjixzrdi/2avriGXP3Y8wrWPn6
 /34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793876671; x=1794481471;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FFlRj7zu5hDTpY8G/PTsL3dfYcV7jbNwNQB5CRVczZA=;
 b=QQXYxYXynXJJCD8thMz0XXWFY6PtAHkT6l39LrCYegephg8nRfR0y5cmdYLbgxdxOk
 epAFL5LImeGfEemgHy97FfyMY35K0zTp/zGZbaqqqo2BFCLQNsdpXlmkRkLCB6aDpcI1
 cwZF7/bJxzBg9Iiw/4p/gqDTtK7z74FtCL6qIxp6uKrVhCu1/uM/QLHTobBEu1SGI79J
 ixvSdy2vhVHY/NNwPGxADBgWRf92iGzT5F9lMeqRCDccigFmDRqTcajmyKcHu4S9RnXO
 45vHbsFPr3Go4uMtyPqdRvlqGx5jBQmNzuR3ucXAubiqYJ0J00pJGcKqq5OOzgALcVqh
 Yx5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzI2dTnxuXpMEzYrsbWATjsXH1wOQzrXM4WcGGAPsNXuS49rjGgmHdANfr+BUCDnji0wH8a+LQmlyg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z87r1JamGg7qPH3fPemfdKvlVy3HRq3lV1NZpC7adR8nIMogYz4
 LwPF+Q9gLYXUZwwhp1A+oMPOOytRa1vWd8yC9xFjWp1ESPHop+DjXgA6n0UKaWfbmX4=
X-Gm-Gg: AYBFou3/ma9Sv8jWTrV6fANJpGHF2FJeQmAzZZLUjkaiPzN/OGfXkdh06GfZizA4U+K
 tKpuseoFuhx/wWspZ7yOfs4ZMzDETs736WCmECNlrvqd0rSFYRkL8JcWEq6LDptfBFKbkihhR9m
 1LG0yDd5jHAP8sahzRJ9XsUttKLyNisrUcu6Anas6jaW7d6vaalQ5Da4tr86l8IA5FukLRAbus4
 vjpG/celRjURdm1Rfx0m6HOjHi4Qifmri+ImyQvNPsCKOgw7uszIFpWHTEf4YDRNFSEsXa+vNAC
 nCiIV793uRQaOH7FHofSi/LW8kyQr9vpoTPsoAQ87nyDw58G/UAthYKczH5CjYMlyKMM/mJWqjH
 0siW6fMyXuy2WK5IDtXwh/9pvXfSHjBEAq2jmI8qQO4eVxsaawNyItYaj9lC2K2+dhZqCh7JxH/
 LaUfk7oLDno1Z0xr9X4GLYNg7jAXHaFK4USc/kDt90jfAqquNp4A4SH9qYJwmwrsdHyxmZdl4C0
 7dw7EPNxCyUwvzRQDvIIEnJkdjWHqsC5dHBZRx1n3XJcrlIvzh6lvsssC2dj+z3F3odP6JDuRIK
 PJ5keWUmZYb1LYBYw1Kq2d3d+1nPabB2tIpK+6mRWtSL
X-Received: by 2002:a05:6000:2889:b0:48e:f10:ceb8 with SMTP id
 ffacd0b85a97d-48e6e2e769amr38528504f8f.11.1793876670833; 
 Thu, 05 Nov 2026 03:04:30 -0800 (PST)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed92a753sm10471113f8f.45.2026.11.05.03.04.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 03:04:30 -0800 (PST)
Message-ID: <2ca12f1b-89f6-4069-aedf-4e5d645e8deb@ursulin.net>
Date: Thu, 5 Nov 2026 11:04:29 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] accel/rocket: Report NPU usage through fdinfo
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Sidong Yang <sidong.yang@furiosa.ai>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>
References: <20261103155338.1949294-1-sidong.yang@furiosa.ai>
 <a9f016ce-f086-412d-9ca6-6608a41840e5@ursulin.net>
 <33ccceef-3498-426a-ae7c-a8bafbb88992@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <33ccceef-3498-426a-ae7c-a8bafbb88992@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 05/11/2026 10:43, Maíra Canal wrote:
> Hi Tvrtko,
> 
> On 05/11/26 06:22, Tvrtko Ursulin wrote:
>>
>> On 03/11/2026 15:53, Sidong Yang wrote:
>>> There is no way to tell how much of the NPU a client uses. Implement the
>>> DRM usage stats: account the time each job occupies a core and report
>>> it per client as drm-engine-npu, along with drm_show_memory_stats() for
>>> the BOs.
>>>
>>> The cores are identical, so they are reported as a single engine with
>>> drm-engine-capacity-npu set to rdev->max_cores, the number of core
>>> slots. The time is summed over all cores, with an atomic counter as the
>>> cores complete jobs concurrently.
>>>
>>> Jobs can outlive the file that submitted them, so the counter is
>>> refcounted and each job holds a reference. The time covers the whole
>>> period a job owns a core, so it also includes handling the completion
>>> interrupt and the gaps between the tasks of a multi-task job.
>>>
>>> Document the keys in the rocket driver documentation.
>>>
>>> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
>>> ---
>>> v4: Report a single drm-engine-npu key with drm-engine-capacity-npu,
>>>      instead of drm-engine-npu0..2, as drm-usage-stats.rst specifies for
>>>      a group of identical engines, and document the keys (Tomeu Vizoso).
>>>      The subject no longer says per-core. Gyeyoung's tags are dropped as
>>>      the accounting changed.
>>>
>>>      Still depends on commit 6eff1d69dae8 ("accel/rocket: search every
>>>      core slot when a core is removed") for rdev->max_cores.
>>>
>>> v3: Add a rocket_engine_usage_create() helper for the counter
>>>      allocation in rocket_open(), to pair with
>>>      rocket_engine_usage_destroy() (Gyeyoung Baek).
>>>
>>> v2: Size the per-core counters by rdev->max_cores, the number of core
>>>      slots, instead of the number of cores bound when the file is 
>>> opened.
>>>      Sashiko reported the out-of-bounds read and Gyeyoung Baek 
>>> reproduced
>>>      it with KASAN.
>>>
>>> Link to v3: https://lore.kernel.org/all/20261103104804.1887489-1- 
>>> sidong.yang@furiosa.ai/
>>> Link to v2: https://lore.kernel.org/all/20261101152723.1430312-1- 
>>> sidong.yang@furiosa.ai/
>>> Link to v1: https://lore.kernel.org/all/20261031083642.1076356-1- 
>>> sidong.yang@furiosa.ai/
>>>
>>>   Documentation/accel/rocket/index.rst  | 28 +++++++++++
>>>   Documentation/gpu/drm-usage-stats.rst |  1 +
>>>   drivers/accel/rocket/rocket_drv.c     | 70 ++++++++++++++++++++++++++-
>>>   drivers/accel/rocket/rocket_drv.h     | 15 ++++++
>>>   drivers/accel/rocket/rocket_job.c     |  7 +++
>>>   drivers/accel/rocket/rocket_job.h     |  4 ++
>>>   6 files changed, 123 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/accel/rocket/index.rst b/Documentation/ 
>>> accel/rocket/index.rst
>>> index 70f97bccf100..53c9aa7e2229 100644
>>> --- a/Documentation/accel/rocket/index.rst
>>> +++ b/Documentation/accel/rocket/index.rst
>>> @@ -17,3 +17,31 @@ project.
>>>   Hardware currently supported:
>>>   * RK3588
>>> +
>>> +.. _rocket-usage-stats:
>>> +
>>> +Rocket DRM client usage stats implementation
>>> +============================================
>>> +
>>> +The accel/rocket driver implements the DRM client usage stats 
>>> specification as
>>> +documented in :ref:`drm-client-usage-stats`.
>>> +
>>> +The NPU cores are reported as a single engine, npu, with a capacity 
>>> equal to the
>>> +number of cores. The time is summed over all cores, and covers the 
>>> whole period
>>> +a job occupies a core.
>>> +
>>> +Example of the output showing the implemented key value pairs:
>>> +
>>> +::
>>> +
>>> +        pos:    0
>>> +        flags:    02400002
>>> +        mnt_id:    33
>>> +        ino:    749
>>> +        drm-driver:    rocket
>>> +        drm-client-id:    246
>>> +        drm-engine-npu:    2296549300 ns
>>> +        drm-engine-capacity-npu:    3
>>> +        drm-total-memory:    24216 KiB
>>> +        drm-shared-memory:    0
>>> +        drm-active-memory:    1920 KiB
>>> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/ 
>>> gpu/drm-usage-stats.rst
>>> index 70b7cfcc194f..288764730d23 100644
>>> --- a/Documentation/gpu/drm-usage-stats.rst
>>> +++ b/Documentation/gpu/drm-usage-stats.rst
>>> @@ -218,3 +218,4 @@ Driver specific implementations
>>>   * :ref:`panthor-usage-stats`
>>>   * :ref:`xe-usage-stats`
>>>   * :ref:`amdxdna-usage-stats`
>>> +* :ref:`rocket-usage-stats`
>>> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/ 
>>> rocket/ rocket_drv.c
>>> index 2bcfe4ab3c68..e22e8623db64 100644
>>> --- a/drivers/accel/rocket/rocket_drv.c
>>> +++ b/drivers/accel/rocket/rocket_drv.c
>>> @@ -3,8 +3,10 @@
>>>   #include <drm/drm_accel.h>
>>>   #include <drm/drm_drv.h>
>>> +#include <drm/drm_file.h>
>>>   #include <drm/drm_gem.h>
>>>   #include <drm/drm_ioctl.h>
>>> +#include <drm/drm_print.h>
>>>   #include <drm/rocket_accel.h>
>>>   #include <linux/clk.h>
>>>   #include <linux/err.h>
>>> @@ -68,6 +70,38 @@ rocket_iommu_domain_put(struct rocket_iommu_domain 
>>> *domain)
>>>       kref_put(&domain->kref, rocket_iommu_domain_destroy);
>>>   }
>>> +static struct rocket_engine_usage *
>>> +rocket_engine_usage_create(void)
>>> +{
>>> +    struct rocket_engine_usage *usage;
>>> +
>>> +    usage = kzalloc_obj(*usage);
>>> +    if (!usage)
>>> +        return NULL;
>>> +    kref_init(&usage->kref);
>>> +
>>> +    return usage;
>>> +}
>>> +
>>> +static void
>>> +rocket_engine_usage_destroy(struct kref *kref)
>>> +{
>>> +    kfree(container_of(kref, struct rocket_engine_usage, kref));
>>> +}
>>> +
>>> +struct rocket_engine_usage *
>>> +rocket_engine_usage_get(struct rocket_file_priv *rocket_priv)
>>> +{
>>> +    kref_get(&rocket_priv->engine_usage->kref);
>>> +    return rocket_priv->engine_usage;
>>> +}
>>> +
>>> +void
>>> +rocket_engine_usage_put(struct rocket_engine_usage *usage)
>>> +{
>>> +    kref_put(&usage->kref, rocket_engine_usage_destroy);
>>> +}
>>> +
>>>   static int
>>>   rocket_open(struct drm_device *dev, struct drm_file *file)
>>>   {
>>> @@ -86,10 +120,17 @@ rocket_open(struct drm_device *dev, struct 
>>> drm_file *file)
>>>       }
>>>       rocket_priv->rdev = rdev;
>>> +
>>> +    rocket_priv->engine_usage = rocket_engine_usage_create();
>>> +    if (!rocket_priv->engine_usage) {
>>> +        ret = -ENOMEM;
>>> +        goto err_free;
>>> +    }
>>
>> Glanced over this patch by chance and it very reminded me of 
>> drm_sched_entity_stats tracking. That object is reference counted by 
>> the entity so I think it would satisfy your requirements. We would 
>> only need to add an accessor like drm_sched_entity_get_runtime() and 
>> just call it from rocket. Thoughts?
>>
> 
> I believe we tried something similar in the past (commit 97804a133c68)

You mean df622729ddbf? But yes, I don't think I knew about that.

> and it ended up being reverted after this regression [1]. I would be
> great to give this idea another change (specially now that we have
> drm_sched_entity_stats), as it would also be useful for V3D.

It makes sense to me if Philipp and Danilo will agree so adding them cc.

It would just be adding u64 drm_sched_entity_get_runtime(entity). 
Nothing else would need to be exported and the implementation simply 
locks entity->stats and returns the runtime. As long as the caller knows 
they haven't destroyed the entity it is safe since entity holds a 
reference to the stats object.

If rocket and v3d can use it that's a reasonable starting point for 
adding common API. Three users would be even better than two though, 
going by the long standing DRM tradition. :)

Regards,

Tvrtko

> [1] https://lore.kernel.org/dri-devel/3e00d8a9- 
> b6c4-8202-4f2d-5a659c61d094@redhat.com/
> 
> Best regards,
> - Maíra

