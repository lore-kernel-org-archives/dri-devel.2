Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69C3606D81E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=IbukNwkJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B21310E051;
	Thu,  5 Nov 2026 11:08:13 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD9E610E051
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 11:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=441X45gSk9zUWM+BKp8ddCPWW5+eG4Ep8QeHVB4L9ow=; t=1793876886; x=2109236886; 
 b=IbukNwkJ2l2QjTDJtY+amKrbUKrKYzSHNOXjLAXLS/oYUc6jLGYfF39nCsiT+JCl4Sw2S7OSElq
 hgk5lGSL3BU/eoS9ceC7XI2LooUFVOoHrV/xZwHMtiW00VBl1n3ArMYSzxK1BRtJOsUmiOHuagsYJ
 mHh/ZkTpiwDGMFyksXus6SYpYBt5BpplGQgpcwDV7xbU2lZq7c0JuPiMImEHPtyZC+oMwJzewoGFu
 dyicLZVP/44UPWJUqPEOjeyoQOybvkB8mXblmv72EbLW44WsE59szUJ5GR5Rjgyibi1xu1cSvC7Oj
 evGMzGfLeaE3C+cVdRCs/muZkF6Ze10Mj0jg==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xOvK5-003G9k-8t; Thu, 05 Nov 2026 12:08:01 +0100
Message-ID: <bd2c65d2-c94c-4eca-9fc5-ec366e0be0fb@igalia.com>
Date: Thu, 5 Nov 2026 08:07:57 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] accel/rocket: Report NPU usage through fdinfo
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 Sidong Yang <sidong.yang@furiosa.ai>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>
References: <20261103155338.1949294-1-sidong.yang@furiosa.ai>
 <a9f016ce-f086-412d-9ca6-6608a41840e5@ursulin.net>
 <33ccceef-3498-426a-ae7c-a8bafbb88992@igalia.com>
 <2ca12f1b-89f6-4069-aedf-4e5d645e8deb@ursulin.net>
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
In-Reply-To: <2ca12f1b-89f6-4069-aedf-4e5d645e8deb@ursulin.net>
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

On 05/11/26 08:04, Tvrtko Ursulin wrote:
> 
> On 05/11/2026 10:43, Maíra Canal wrote:
>> Hi Tvrtko,
>>
>> On 05/11/26 06:22, Tvrtko Ursulin wrote:
>>>
>>> On 03/11/2026 15:53, Sidong Yang wrote:
>>>> There is no way to tell how much of the NPU a client uses. Implement 
>>>> the
>>>> DRM usage stats: account the time each job occupies a core and report
>>>> it per client as drm-engine-npu, along with drm_show_memory_stats() for
>>>> the BOs.
>>>>
>>>> The cores are identical, so they are reported as a single engine with
>>>> drm-engine-capacity-npu set to rdev->max_cores, the number of core
>>>> slots. The time is summed over all cores, with an atomic counter as the
>>>> cores complete jobs concurrently.
>>>>
>>>> Jobs can outlive the file that submitted them, so the counter is
>>>> refcounted and each job holds a reference. The time covers the whole
>>>> period a job owns a core, so it also includes handling the completion
>>>> interrupt and the gaps between the tasks of a multi-task job.
>>>>
>>>> Document the keys in the rocket driver documentation.
>>>>
>>>> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
>>>> ---
>>>> v4: Report a single drm-engine-npu key with drm-engine-capacity-npu,
>>>>      instead of drm-engine-npu0..2, as drm-usage-stats.rst specifies 
>>>> for
>>>>      a group of identical engines, and document the keys (Tomeu 
>>>> Vizoso).
>>>>      The subject no longer says per-core. Gyeyoung's tags are 
>>>> dropped as
>>>>      the accounting changed.
>>>>
>>>>      Still depends on commit 6eff1d69dae8 ("accel/rocket: search every
>>>>      core slot when a core is removed") for rdev->max_cores.
>>>>
>>>> v3: Add a rocket_engine_usage_create() helper for the counter
>>>>      allocation in rocket_open(), to pair with
>>>>      rocket_engine_usage_destroy() (Gyeyoung Baek).
>>>>
>>>> v2: Size the per-core counters by rdev->max_cores, the number of core
>>>>      slots, instead of the number of cores bound when the file is 
>>>> opened.
>>>>      Sashiko reported the out-of-bounds read and Gyeyoung Baek 
>>>> reproduced
>>>>      it with KASAN.
>>>>
>>>> Link to v3: https://lore.kernel.org/all/20261103104804.1887489-1- 
>>>> sidong.yang@furiosa.ai/
>>>> Link to v2: https://lore.kernel.org/all/20261101152723.1430312-1- 
>>>> sidong.yang@furiosa.ai/
>>>> Link to v1: https://lore.kernel.org/all/20261031083642.1076356-1- 
>>>> sidong.yang@furiosa.ai/
>>>>
>>>>   Documentation/accel/rocket/index.rst  | 28 +++++++++++
>>>>   Documentation/gpu/drm-usage-stats.rst |  1 +
>>>>   drivers/accel/rocket/rocket_drv.c     | 70 +++++++++++++++++++++++ 
>>>> +++-
>>>>   drivers/accel/rocket/rocket_drv.h     | 15 ++++++
>>>>   drivers/accel/rocket/rocket_job.c     |  7 +++
>>>>   drivers/accel/rocket/rocket_job.h     |  4 ++
>>>>   6 files changed, 123 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/accel/rocket/index.rst b/Documentation/ 
>>>> accel/rocket/index.rst
>>>> index 70f97bccf100..53c9aa7e2229 100644
>>>> --- a/Documentation/accel/rocket/index.rst
>>>> +++ b/Documentation/accel/rocket/index.rst
>>>> @@ -17,3 +17,31 @@ project.
>>>>   Hardware currently supported:
>>>>   * RK3588
>>>> +
>>>> +.. _rocket-usage-stats:
>>>> +
>>>> +Rocket DRM client usage stats implementation
>>>> +============================================
>>>> +
>>>> +The accel/rocket driver implements the DRM client usage stats 
>>>> specification as
>>>> +documented in :ref:`drm-client-usage-stats`.
>>>> +
>>>> +The NPU cores are reported as a single engine, npu, with a capacity 
>>>> equal to the
>>>> +number of cores. The time is summed over all cores, and covers the 
>>>> whole period
>>>> +a job occupies a core.
>>>> +
>>>> +Example of the output showing the implemented key value pairs:
>>>> +
>>>> +::
>>>> +
>>>> +        pos:    0
>>>> +        flags:    02400002
>>>> +        mnt_id:    33
>>>> +        ino:    749
>>>> +        drm-driver:    rocket
>>>> +        drm-client-id:    246
>>>> +        drm-engine-npu:    2296549300 ns
>>>> +        drm-engine-capacity-npu:    3
>>>> +        drm-total-memory:    24216 KiB
>>>> +        drm-shared-memory:    0
>>>> +        drm-active-memory:    1920 KiB
>>>> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/ 
>>>> gpu/drm-usage-stats.rst
>>>> index 70b7cfcc194f..288764730d23 100644
>>>> --- a/Documentation/gpu/drm-usage-stats.rst
>>>> +++ b/Documentation/gpu/drm-usage-stats.rst
>>>> @@ -218,3 +218,4 @@ Driver specific implementations
>>>>   * :ref:`panthor-usage-stats`
>>>>   * :ref:`xe-usage-stats`
>>>>   * :ref:`amdxdna-usage-stats`
>>>> +* :ref:`rocket-usage-stats`
>>>> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/ 
>>>> rocket/ rocket_drv.c
>>>> index 2bcfe4ab3c68..e22e8623db64 100644
>>>> --- a/drivers/accel/rocket/rocket_drv.c
>>>> +++ b/drivers/accel/rocket/rocket_drv.c
>>>> @@ -3,8 +3,10 @@
>>>>   #include <drm/drm_accel.h>
>>>>   #include <drm/drm_drv.h>
>>>> +#include <drm/drm_file.h>
>>>>   #include <drm/drm_gem.h>
>>>>   #include <drm/drm_ioctl.h>
>>>> +#include <drm/drm_print.h>
>>>>   #include <drm/rocket_accel.h>
>>>>   #include <linux/clk.h>
>>>>   #include <linux/err.h>
>>>> @@ -68,6 +70,38 @@ rocket_iommu_domain_put(struct 
>>>> rocket_iommu_domain *domain)
>>>>       kref_put(&domain->kref, rocket_iommu_domain_destroy);
>>>>   }
>>>> +static struct rocket_engine_usage *
>>>> +rocket_engine_usage_create(void)
>>>> +{
>>>> +    struct rocket_engine_usage *usage;
>>>> +
>>>> +    usage = kzalloc_obj(*usage);
>>>> +    if (!usage)
>>>> +        return NULL;
>>>> +    kref_init(&usage->kref);
>>>> +
>>>> +    return usage;
>>>> +}
>>>> +
>>>> +static void
>>>> +rocket_engine_usage_destroy(struct kref *kref)
>>>> +{
>>>> +    kfree(container_of(kref, struct rocket_engine_usage, kref));
>>>> +}
>>>> +
>>>> +struct rocket_engine_usage *
>>>> +rocket_engine_usage_get(struct rocket_file_priv *rocket_priv)
>>>> +{
>>>> +    kref_get(&rocket_priv->engine_usage->kref);
>>>> +    return rocket_priv->engine_usage;
>>>> +}
>>>> +
>>>> +void
>>>> +rocket_engine_usage_put(struct rocket_engine_usage *usage)
>>>> +{
>>>> +    kref_put(&usage->kref, rocket_engine_usage_destroy);
>>>> +}
>>>> +
>>>>   static int
>>>>   rocket_open(struct drm_device *dev, struct drm_file *file)
>>>>   {
>>>> @@ -86,10 +120,17 @@ rocket_open(struct drm_device *dev, struct 
>>>> drm_file *file)
>>>>       }
>>>>       rocket_priv->rdev = rdev;
>>>> +
>>>> +    rocket_priv->engine_usage = rocket_engine_usage_create();
>>>> +    if (!rocket_priv->engine_usage) {
>>>> +        ret = -ENOMEM;
>>>> +        goto err_free;
>>>> +    }
>>>
>>> Glanced over this patch by chance and it very reminded me of 
>>> drm_sched_entity_stats tracking. That object is reference counted by 
>>> the entity so I think it would satisfy your requirements. We would 
>>> only need to add an accessor like drm_sched_entity_get_runtime() and 
>>> just call it from rocket. Thoughts?
>>>
>>
>> I believe we tried something similar in the past (commit 97804a133c68)
> 
> You mean df622729ddbf? But yes, I don't think I knew about that.

Yes, sorry for the copy/paste mistake.

> 
>> and it ended up being reverted after this regression [1]. I would be
>> great to give this idea another change (specially now that we have
>> drm_sched_entity_stats), as it would also be useful for V3D.
> 
> It makes sense to me if Philipp and Danilo will agree so adding them cc.
> 
> It would just be adding u64 drm_sched_entity_get_runtime(entity). 
> Nothing else would need to be exported and the implementation simply 
> locks entity->stats and returns the runtime. As long as the caller knows 
> they haven't destroyed the entity it is safe since entity holds a 
> reference to the stats object.
> 
> If rocket and v3d can use it that's a reasonable starting point for 
> adding common API. Three users would be even better than two though, 
> going by the long standing DRM tradition. :)

Considering commit 97804a133c68 (right commit this time), I believe that
Etnaviv could also benefit from it.

Best regards,
- Maíra

> 
> Regards,
> 
> Tvrtko
> 
>> [1] https://lore.kernel.org/dri-devel/3e00d8a9- 
>> b6c4-8202-4f2d-5a659c61d094@redhat.com/
>>
>> Best regards,
>> - Maíra
> 

