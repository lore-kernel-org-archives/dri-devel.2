Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F26F3D604
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 13:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BBFB10E48E;
	Sun, 29 Mar 2026 13:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="DQRlphdF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58AB10E48E
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 13:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PCuJ+sQztOoTeOVKSXpW1LrL6o/FBVeSe0mjlPreaoQ=; b=DQRlphdF/Z52h0nqR0Wqo1RK+W
 STj0xbRdc2djw308i24RcJW0ArTGHYLjO/NKO9f6s00DqIj6ZtVlltqab2pYRTXg1k8VxEL5XUwHW
 8AKiZnO/pd50bqtafT50KtBzvvg1AxpekmWGkXzN5V8aw94arWbL1HieByR1MmkPhVHllxGhZ4f48
 VnAeXuI0QD+stSafZ9B5SXxmpnLl+wWOux5glBD4qVtKnGj/dftdSBhTOaNx1u+ASC75fQQXUJmhu
 0br9zThmUKX/zrj0gmtnTQD2bWI2JVuK3gBL4R7IUPzyRZ6OTZmS02RzXBdgToHRVkVNTL/yzbZ7s
 Ua6gg5gA==;
Received: from [189.7.87.169] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w6q3L-008Ykj-E4; Sun, 29 Mar 2026 15:19:43 +0200
Message-ID: <a3d06a64-d0cb-4090-8e11-95ac473910e6@igalia.com>
Date: Sun, 29 Mar 2026 10:19:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] drm/vc4: Add new job submission implementation
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260205-vc4-drm-scheduler-v1-0-c6174fd7bbc1@igalia.com>
 <20260205-vc4-drm-scheduler-v1-6-c6174fd7bbc1@igalia.com>
 <1d9813ab-67b9-43a8-a7ed-e713fab3140a@igalia.com>
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
In-Reply-To: <1d9813ab-67b9-43a8-a7ed-e713fab3140a@igalia.com>
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

On 06/03/26 08:28, Tvrtko Ursulin wrote:
> 
> On 05/02/2026 21:31, Maíra Canal wrote:
>> Introduce vc4_submit.c with the job submission path rewritten to
>> integrate with the DRM GPU scheduler. Most of this code is adapted from
>> vc4_gem.c, with key changes concentrated in the job creation and
>> lifecycle management. This implementation follows the same design as the
>> v3d driver.
>>
>> This code coexists with the legacy path until the switchover commit.
>>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/vc4/vc4_submit.c | 509 +++++++++++++++++++++++++++++ 
>> ++++++++++
>>   1 file changed, 509 insertions(+)
>>

[...]

>> +static int
>> +vc4_lookup_bos(struct drm_device *dev, struct drm_file *file_priv,
>> +           struct vc4_render_job *job, u64 bo_handles, u32 bo_count)
>> +{
>> +    int ret = 0;
>> +    int i;
>> +
>> +    job->bo_count = bo_count;
>> +
>> +    if (!job->bo_count) {
>> +        drm_warn(dev, "Rendering requires BOs to validate\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = drm_gem_objects_lookup(file_priv, u64_to_user_ptr(bo_handles),
>> +                     job->bo_count, &job->bo);
>> +    if (ret)
>> +        return ret;
>> +
>> +    for (i = 0; i < job->bo_count; i++) {
>> +        ret = vc4_bo_inc_usecnt(to_vc4_bo(job->bo[i]));
> 
> Quite odd model in vc4 that this can fail for completely different 
> reasons. Looking into vc4_bo_inc_usecnt().. There are reference counts 
> for the same bo? One GEM and one vc4, why?
> 

I just noticed that I didn't answer this question. I'm sorry for my
overlook.

So, this refcount tracks active usage: whether the BO is currently in
use by the GPU or display. When the refcount drops to zero and madv ==
DONTNEED, the BO goes to a purgeable pool. On the GPU path, this
refcount is indeed redundant, but it's genuinely needed in the display
paths (prepare_fb/cleanup_fb, async page flip), because those don't use
dma_resv fences to track activity.

I agree it's an odd design, but I believe it was needed at some point in
history to conciliate vc4's display and rendering capabilities in a
single driver (that is, vc4->gen == VC4_GEN_4 // RPi 0-3).

To make things less redundant, I'm thinking about adding a
vc4_bo_active() function for BO activity tracking, which will account
both for the internal refcount and dma_resv.

> The runtime invariant check is needed at this level, I mean this one?:
> 
>      if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
>          return -ENODEV;
> 
> It cannot be moved somewhere higher up the chain? There can legitimately 
> be a mix of bos with different vc4_dev?
> 

No, vc4->gen is a attribute related to the HW generation. That is, for a
single device, there can be only one generation. From my understanding,
this guard is just a sanity-check. Just to make sure nobody will call
this function for KMS-only devices (RPi 4-5). For RPi 4-5, there is no
need to use the refcount path, as vc4 is not responsible for rendering
(v3d is).

Best regards,
- Maíra
