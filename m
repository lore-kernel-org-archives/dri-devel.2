Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0A606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ap6ejG2m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B141D10E8A0;
	Mon,  9 Nov 2026 11:32:27 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4DF10E88E
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 11:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=vo6QyzQs0o4MmCEDBAEDfTcKi0qlPsBdi9a2qyFZL0Y=; t=1794223940; x=2109583940; 
 b=ap6ejG2mxK24Ys55fWVQ0OBfFBk7yenanuAD797PSZdFaJN6YS+m5cG4yoW25Z8U+t5k+3GzYYx
 kBUXVjxArygeG64yOmp0FIiI48nRSs1mW1iwfXR0fAspdTkJ/KDRWKvXxyopByGoYDuT6jzGUv8Sv
 LG+N/rZAVTnUl40/7TaZa+T2c6vheAHqxkKg1qtMzJSThFgEpmrvN8RmuseCUzQtj0hyCTadZ+mf5
 b5a3QAWUke+ztbGHvUFf4j/WL1irlrLLVZFF0cgP7vtRQoMr6gd8Xm7akeXVeffNJwv5Agqs5lwu1
 x7aRkm2HTzcjvbK9HvVqwf0bEvQwhaW+oU7A==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xQNbm-007Dme-0y; Mon, 09 Nov 2026 12:32:18 +0100
Message-ID: <10bb1fac-61ce-47ab-939f-4ff72fed3425@igalia.com>
Date: Mon, 9 Nov 2026 11:32:17 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/gem: Fix and enable CHANGE_HANDLE
To: "Francis, David" <David.Francis@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
References: <20261103155411.3305376-1-David.Francis@amd.com>
 <ab5eeb46-f119-4430-9f91-e530a74f036c@igalia.com>
 <CHAPR12MB999247EFCE060F1DA5575E0381EF772@CHAPR12MB999247.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <CHAPR12MB999247EFCE060F1DA5575E0381EF772@CHAPR12MB999247.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 05/11/2026 19:49, Francis, David wrote:
>>> +     if (new_handle == 0 || new_handle > INT_MAX ||
>>> +         args->handle == new_handle)
>>> +             return -EINVAL;
>>
>> I'd like to open the same discussion point that I opened in the
>> corresponding IGT. Should we or should we not check for INT_MAX here.
>> There I wrote this:
>>
>> """
>> About this one I am not sure. Is it not implementation details as long
>> as the uapi for handle is u32? Let say someone converts to XArray one
>> day and then we have to artificially limit that to s32 just so
>> gem_change_handle can keep working.
>> """
> 
> uapi is u32 but idr only does handles from 0 to INT_MAX. I think it's
> correct for this to be an error now; if the interface one day changes
> such that INT_MAX < handle < UINT_MAX is now valid, I think we're okay to have
> some cases that were once errors now work (that's what happens whenever an
> ioctl adds new flags / replaces padding with new inputs).

Okay I get it. Output handle from BO creation is u32, so rename is u32, 
but internals cannot handle it and we want to avoid silent wrap. You 
have to somehow handle it.. hm.. I guess we have to live with it. If we 
replace IDR with XArray one day we can always artificially keep the same 
s32 limit.

>>> +     ret = idr_alloc(&file_priv->object_idr, NULL, new_handle,
>>> +                     new_handle + 1, GFP_NOWAIT);
>>
>> And here I opened a point about what happens when target handle is taken
>> (again in IGT review):
>>
>> """
>> Hmm.. this is actually leaking the wrong implementation detail of
>> idr_alloc to ABI. ENOSPC is "no free handles". It feels it would be
>> better if gem_change_handle returned EBUSY or EEXIST for this case so it
>> is not conflated. Thoughts?
>> ""'
> On balance EBUSY is probably a more accurate error code for this than
> ENOSPC, I can make that change. Neither is perfect? "Busy" to me implies
> a temporary use of a resource, but this is about a handle which is persistently
> being used. EEXIST has the error message "File exists"; I don't know whether it's
> used for cases like this is practice.
> 
> The definition of these error codes seems pretty loose, as long as it's distinct from
> the other error codes this can return

I suppose all three could be argued for.

ENOSPC - No space in the target range, just that the target range is a 
single id in the case of rename.

EBUSY - Target handle is busy.

EEXIST - Target handle already exists.

There is precedent in DRM for EBUSY and EXIST judging by a quick grep. 
EBUSY sounds the weakest though.

Don't know. If no one else provides their 2c in due time keep it as it is.

Regards,

Tvrtko

____________________________________
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Sent: Thursday, November 5, 2026 6:12 AM
> To: Francis, David; dri-devel@lists.freedesktop.org
> Cc: Koenig, Christian; Simona Vetter
> Subject: Re: [PATCH v3] drm/gem: Fix and enable CHANGE_HANDLE
> 
> 
> On 03/11/2026 15:54, David Francis wrote:
>> Make the following changes to CHANGE_HANDLE
>> - reject new_handle = old_handle with -EINVAL
>> - idr_preload before idr_alloc
>> - reject new_handle = 0 with -EINVAL
>> and re-enable it.
>>
>> These changes are prerequisities for the enabling of this ioctl, which was
>> disabled over security concerns and the lack of IGT tests.
>>
>> For a summary of the saga so far, see
>> https://lists.freedesktop.org/archives/dri-devel/2026-June/571890.html
>>
>> I hope these changes leave the ioctl in a spot where it is safe to
>> re-enable. There are now igt tests covering all corner case behaviour
>> and race conditions between change_handle and itself, create, free,
>> import, and export.
>>
>> The new_handle = 0 and new_handle = old_handle corner cases
>> are now -EINVAL as recommended; these are covered in the igt tests.
>>
>> idr_preload is now correctly called before idr_alloc.
>>
>> With these changes the TODO can be removed and the ioctl can be
>> re-enabled.
>>
>> Accompanying IGT patch on igt-dev is
>> tests/intel: Add edge case and race condition tests for GEM_CHANGE_HANDLE
>>
>> v2: new_handle = old_handle is EINVAL
>> v3: More detailed commit message and some cleanup
>>
>> cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> cc: Christian Koenig <christian.koenig@amd.com>
>> cc: Simona Vetter <simona.vetter@ffwll.ch>
>> Signed-off-by: David Francis <David.Francis@amd.com>
>> ---
>>    drivers/gpu/drm/drm_gem.c   | 30 ++++++++++--------------------
>>    drivers/gpu/drm/drm_ioctl.c |  3 +--
>>    2 files changed, 11 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>> index 6a86bd2a0343e..bb55715e8d170 100644
>> --- a/drivers/gpu/drm/drm_gem.c
>> +++ b/drivers/gpu/drm/drm_gem.c
>> @@ -1018,19 +1018,6 @@ drm_gem_open_ioctl(struct drm_device *dev, void *data,
>>        return ret;
>>    }
>>
>> -/*
>> - * This ioctl is disabled for security reasons but also it failed
>> - * to follow process in terms of adding testing in igt and verifying
>> - * all the corner cases which made fixing security bugs in it even
>> - * harder than necessary.
>> - *
>> - * To re-enable this ioctl
>> - * 1. land working IGT tests in igt-gpu-tools that cover
>> - *    all corner cases and race conditions.
>> - * 2. handle idr_preload
>> - * 3. handle == 0
>> - * 4. handle == new_handle semantics definition.
>> - */
>>    int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>>                                struct drm_file *file_priv)
>>    {
>> @@ -1041,21 +1028,22 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>>        if (!drm_core_check_feature(dev, DRIVER_GEM))
>>                return -EOPNOTSUPP;
>>
>> -     /* idr_alloc() limitation. */
>> -     if (args->new_handle > INT_MAX)
>> -             return -EINVAL;
>>        new_handle = args->new_handle;
>>
>> -     if (args->handle == new_handle)
>> -             return 0;
>> +     /* idr_alloc() limitations. */
> 
> Nit- it's now more than idr_alloc limitations.
> 
>> +     if (new_handle == 0 || new_handle > INT_MAX ||
>> +         args->handle == new_handle)
>> +             return -EINVAL;
> 
> I'd like to open the same discussion point that I opened in the
> corresponding IGT. Should we or should we not check for INT_MAX here.
> There I wrote this:
> 
> """
> About this one I am not sure. Is it not implementation details as long
> as the uapi for handle is u32? Let say someone converts to XArray one
> day and then we have to artificially limit that to s32 just so
> gem_change_handle can keep working.
> """
> 
>>
>>        mutex_lock(&file_priv->prime.lock);
>> +     idr_preload(GFP_KERNEL);
>>        spin_lock(&file_priv->table_lock);
>> -     ret = idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle + 1,
>> -                     GFP_NOWAIT);
>> +     ret = idr_alloc(&file_priv->object_idr, NULL, new_handle,
>> +                     new_handle + 1, GFP_NOWAIT);
> 
> And here I opened a point about what happens when target handle is taken
> (again in IGT review):
> 
> """
> Hmm.. this is actually leaking the wrong implementation detail of
> idr_alloc to ABI. ENOSPC is "no free handles". It feels it would be
> better if gem_change_handle returned EBUSY or EEXIST for this case so it
> is not conflated. Thoughts?
> ""'
> 
>>
>>        if (ret < 0) {
>>                spin_unlock(&file_priv->table_lock);
>> +             idr_preload_end();
>>                goto out_unlock;
>>        }
>>
>> @@ -1063,10 +1051,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>>        if (IS_ERR_OR_NULL(obj)) {
>>                idr_remove(&file_priv->object_idr, new_handle);
>>                spin_unlock(&file_priv->table_lock);
>> +             idr_preload_end();
>>                ret = -ENOENT;
>>                goto out_unlock;
>>        }
>>        spin_unlock(&file_priv->table_lock);
>> +     idr_preload_end();
>>
>>        if (obj->dma_buf) {
>>                ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
>> index e2df4becce629..ff193155129e7 100644
>> --- a/drivers/gpu/drm/drm_ioctl.c
>> +++ b/drivers/gpu/drm/drm_ioctl.c
>> @@ -660,8 +660,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
>>        DRM_IOCTL_DEF(DRM_IOCTL_GEM_CLOSE, drm_gem_close_ioctl, DRM_RENDER_ALLOW),
>>        DRM_IOCTL_DEF(DRM_IOCTL_GEM_FLINK, drm_gem_flink_ioctl, DRM_AUTH),
>>        DRM_IOCTL_DEF(DRM_IOCTL_GEM_OPEN, drm_gem_open_ioctl, DRM_AUTH),
>> -     /* see drm_gem.c:drm_gem_change_handle_ioctl for why this is invalid */
>> -     DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_invalid_op, DRM_RENDER_ALLOW),
>> +     DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_gem_change_handle_ioctl, DRM_RENDER_ALLOW),
>>
>>        DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETRESOURCES, drm_mode_getresources, 0),
>>
> 
> The rest looks good to me.
> 
> Regards,
> 
> Tvrtko
> 

