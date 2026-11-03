Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D5606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=RQswsYlz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49E510F697;
	Tue,  3 Nov 2026 15:33:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 276D410F6A3
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=cdiA881OKaps9oZINgxCBTFk9oAjabnQAHhO4qLen/U=; t=1793720017; x=2109080017; 
 b=RQswsYlztqeh4yOVvceTNQno8b7w4XgP/NciBSYZSW0fivRmRPMOBFyTMI6aAG89LAMG4bWy2qz
 zWmFISTRnfyfSAxAIUVti0avwopg6JWpKVTj5azEdbGAKSQrk32VvDlkx2N2e698Bai/P5DHF4e3/
 RT4Xr4hgIeBBc7bNY/MGL7iVwfpjavbvlLAbbKnPjFcVDtrcRl46Vodi/akW3/EnXgNe5Ks7kIYY8
 uj41Ii8Tqe1zeseU6iq2pCkT4WJqYkAFmEH+j4/LzhyFqv+qNPAlpKHNhMlX40RX42NPlxTIln27J
 dxJ0hXndGt8c+hHbD3kV2sW/eOzd64+QIYDg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xOGVy-001M3T-Sz; Tue, 03 Nov 2026 16:33:34 +0100
Message-ID: <59c85e41-b896-47e8-9bea-550a73d5066a@igalia.com>
Date: Tue, 3 Nov 2026 15:33:34 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/gem: Fix and enable CHANGE_HANDLE
To: "Francis, David" <David.Francis@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
References: <20261007141043.2928048-1-David.Francis@amd.com>
 <6cae04f6-f742-4e70-84a7-39d123ebf3fe@igalia.com>
 <CHAPR12MB999247B6F07493E00434BE44FCEF692@CHAPR12MB999247.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <CHAPR12MB999247B6F07493E00434BE44FCEF692@CHAPR12MB999247.namprd12.prod.outlook.com>
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


On 03/11/2026 15:16, Francis, David wrote:
> Good finds; will clean up
> 
>> Finally, at the end of the function the final step is like this:
>>
>>         spin_lock(&file_priv->table_lock);
>>         idr_remove(&file_priv->object_idr, args->handle);
>>         obj = idr_replace(&file_priv->object_idr, obj, new_handle);
>>         spin_unlock(&file_priv->table_lock);
>>
>> Doesn't that leave a window where neither old or new handle can be
>> looked up by lockless readers? Does it matter? Would going the opposite
>> way and allowing to transiently see the same object twice be worse?
>>
> In fact both old and new handle are inaccessible for a much loner window
> than that - the idr_replace sets the old handle to NULL in the first lock
> section.

Ah yes, my bad.

> Having both handles be inaccessible for a period is acceptable; if you try to
> do something to either handle in the middle of a CHANGE_HANDLE it might
> fail to avoid a race condition.

Sounds believable.

Tvrtko

> ________________________________________
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Sent: Tuesday, November 3, 2026 8:13 AM
> To: Francis, David; dri-devel@lists.freedesktop.org
> Cc: Koenig, Christian; Simona Vetter
> Subject: Re: [PATCH v2] drm/gem: Fix and enable CHANGE_HANDLE
> 
> 
> On 07/10/2026 15:10, David Francis wrote:
>> Make the following changes to CHANGE_HANDLE
>> - reject new_handle = old_handle with EINVAL
>> - idr_preload before idr_alloc
>> - reject new_handle = 0 with EINVAL
> 
> Please also mention why - like to address the TODO, ideally also putting
> a reference link to lore where the action plan was outlined. I'd at
> least like to read it to finish the review. ;)
> 
>> See also the igt patch
>> tests/intel: Add edge case and race condition tests for GEM_CHANGE_HANDLE
>> on igt-dev
>>
>> v2: new_handle = old_handle is EINVAL
>>
>> cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> cc: Christian Koenig <christian.koenig@amd.com>
>> cc: Simona Vetter <simona.vetter@ffwll.ch>
>> Signed-off-by: David Francis <David.Francis@amd.com>
>> ---
>>    drivers/gpu/drm/drm_gem.c   | 21 ++++++---------------
>>    drivers/gpu/drm/drm_ioctl.c |  3 +--
>>    2 files changed, 7 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>> index 6a86bd2a0343..81aee038e3b2 100644
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
>> @@ -1042,20 +1029,22 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>>                return -EOPNOTSUPP;
>>
>>        /* idr_alloc() limitation. */
>> -     if (args->new_handle > INT_MAX)
>> +     if (args->new_handle == 0 || args->new_handle > INT_MAX)
>>                return -EINVAL;
>>        new_handle = args->new_handle;
>>
>>        if (args->handle == new_handle)
>> -             return 0;
>> +             return -EINVAL;
> 
> I would consider consolidating this a bit. Probably fetch new_handle
> into a local first and do both of the above checks with it. Because
> unless I am blind there is no reason it needs to be fetched in between
> the two conditions so that makes it a bit confusing.
> 
>>
>>        mutex_lock(&file_priv->prime.lock);
>> +     idr_preload(GFP_KERNEL);
>>        spin_lock(&file_priv->table_lock);
>>        ret = idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle + 1,
> 
> Bit - the comma in the "+ 1," part is the only part of this function
> which straddles the 80th column so maybe use the opportunity to clean
> that up.
> 
>>                        GFP_NOWAIT);
>>
>>        if (ret < 0) {
>>                spin_unlock(&file_priv->table_lock);
>> +             idr_preload_end();
>>                goto out_unlock;
>>        }
>>
>> @@ -1063,10 +1052,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>>        if (IS_ERR_OR_NULL(obj)) {
>>                idr_remove(&file_priv->object_idr, new_handle);
>>                spin_unlock(&file_priv->table_lock);
>   > +            idr_preload_end();>             ret = -ENOENT;
>>                goto out_unlock;
>>        }
>>        spin_unlock(&file_priv->table_lock);
>> +     idr_preload_end();
>>
>>        if (obj->dma_buf) {
>>                ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
> 
> There is a "ret = 0;" a bit lower down which I don't see is required so
> unless I am missing something maybe clean that up as well.
> 
> Finally, at the end of the function the final step is like this:
> 
>          spin_lock(&file_priv->table_lock);
>          idr_remove(&file_priv->object_idr, args->handle);
>          obj = idr_replace(&file_priv->object_idr, obj, new_handle);
>          spin_unlock(&file_priv->table_lock);
> 
> Doesn't that leave a window where neither old or new handle can be
> looked up by lockless readers? Does it matter? Would going the opposite
> way and allowing to transiently see the same object twice be worse?
> 
> Regards,
> 
> Tvrtko
> 
>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
>> index e2df4becce62..ff193155129e 100644
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

