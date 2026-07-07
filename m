Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5DEC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D27510ECFE;
	Tue,  7 Jul 2026 13:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="dWjazBt6";
	dkim-atps=neutral
Received: from 10.mo534.mail-out.ovh.net (10.mo534.mail-out.ovh.net
 [46.105.32.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECAF610ECFE
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:12:54 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gvhVC6Qf5z6JcK;
 Tue,  7 Jul 2026 13:12:51 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Tue,  7 Jul 2026 13:12:51 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.231.53])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gvhVC55kjz1xyV; Tue,  7 Jul 2026 13:12:51 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.11])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 6586D9A1903;
 Tue,  7 Jul 2026 13:12:49 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001ad5d9db4-2061-4297-b6e6-0f6bd507a9e5,
 F51ABC51DEFAB5EDC130C4DD81C4A0C3FBCA9704) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <35e58b52-8b40-424e-8d27-00e0ca34acda@pixelcluster.dev>
Date: Tue, 7 Jul 2026 15:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/exec: Add helper to bypass IGNORE_DUPLICATES
 flag
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-1-43685ac1286b@gmx.de>
 <673ae71a1fc4dcce0e6a1655985a141d6f08c06f.camel@linux.intel.com>
 <0f85e12e-7d34-40a8-9efc-0d1a00b7c24c@amd.com>
 <6fac8343dc71b1dbf17e77390cc878cfaeb6d650.camel@linux.intel.com>
 <9a55ba77-6920-427d-9325-ca0e3b8ee94a@amd.com>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <9a55ba77-6920-427d-9325-ca0e3b8ee94a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 18109818530335777084
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGpMHMiR+lV9BG0g8y0r2YN9yKo++eDVO5jx4tO5/nQak9qOI47eseKMoIcSZ62nsQ8OdE5PKzsBipKvfIlVx9gsfZynHGCR9kl6L+2Nb4b5DI490aLOJ701YTtbnnrQKXmE/03XMqw1I+PvFIeiCSj8m8PSMaqxqq0ns7qepNXdNHJFR7QlZZWpzV/eVdNy5XnJ+6To7eqXqAgJ+LaLhGak6FrxMlCWiaVc5Ibzr0BEQdeqmaUoCsEcyoacxj4wjWZngaHCgj5goJPa2I8+0KK5GfBxvZ0l6mJdd72hsGkSf3F0b2vQWVQe8d2sRv3iaFqVvfiOdArPni0Q97UD34yuIsL1N2s+vFsKkHGR9/o2EovG25L6inKQn+SXh4jCA+u8njsQqGqornxTSRLdMfo2CsZinW73WZHVWdPuGYcUyUGOwIFFG/QhO+uvwUf2TSVIp9DIWCedg1bydg2sRA432R/m24W0DsPeVijIARYeY7gXQlU2ZcsLA5+ygN3DZ99ziGuc4qwgkAeH5E/xlyWCmI+nGGhDwm1z1oBdr3rEZmjdFLcYXBuTPeLPJGOyxDxc4ZqBWvX+66eljpK8auN4JKwmOY3yc05oyB4QnnmAnQQ+i3jTcIIwB8bYiMP12+b4vuKB8c2Qy1IIg/LXcOPpEchjgISrc4J5oLBZEfGHg
DKIM-Signature: a=rsa-sha256; bh=wAaSTv7CvzFDUj4WCr27u6J3GWGLHQxhDZYELXFtVPc=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1783429972; v=1;
 b=dWjazBt6rp8LErXBxgUf0PFTFcyJ9ver2YjnnHcWM/VevIPoip/0kWFxZngk/Mf+817pNbNy
 g6utW/bEfkfwb3uF2Zwo0KkXV4y/2j1f1rwEyymqWYB+GAwuIecgS6+B685kgZVjRwKDdgFoBtQ
 65ErNX+rKEmp/E3Vr2/2o6S3gv6aj6vajBW3Uw9xeww6MiDt72oqqOYa4zRoEVleFlPMsrebtKf
 h4Hi9D4TppFL/udb8Ws6JopTTNEmT9kwJO0CxcKxf/dZnCVOdrO+rZIjjJoIzTfFRYdQAC5NCIy
 ZlR6Q0VqCIsvQKdvxcXW2UIteFiel7atxOKzg0PnQpQBQ==
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

On 7/7/26 14:54, Christian König wrote:
> On 7/7/26 14:41, Thomas Hellström wrote:
>> On Tue, 2026-07-07 at 14:28 +0200, Christian König wrote:
>>> On 7/7/26 14:09, Thomas Hellström wrote:
>>>> On Fri, 2026-07-03 at 18:31 +0200, Natalie Vock wrote:
>>>>> TTM is about to switch to drm_exec for locking objects
>>>>> in the LRU list. When we're done processing the object, we want
>>>>> to
>>>>> unlock it only if the caller doesn't already hold that lock. If
>>>>> DRM_EXEC_IGNORE_DUPLICATES is set on the exec object (which
>>>>> callers
>>>>> may
>>>>> require for unrelated reasons), we have no way of knowing whether
>>>>> the
>>>>> lock is already held.
>>>>>
>>>>> To remedy this, add a separate helper that forcefully bypasses
>>>>> the
>>>>> IGNORE_DUPLICATES flag for only a single locking operation.
>>>>>
>>>>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>>>>
>>>> The first, more complete attempt to try to tackle the exhaustive
>>>> eviction introduced a drm_exec snapshot ability instead.
>>>>
>>>> https://lists.freedesktop.org/archives/intel-xe/2024-May/035820.html
>>>>
>>>> The idea was that one would want to incrementally lock more buffer
>>>> objects until the validation succeeded, rather than dropping each
>>>> single lock after processing the eviction. That's actually what
>>>> guarantees forward progress. Restoring the snapshot unlocked all
>>>> locks
>>>> that we grabbed in the process, and would work also for single
>>>> locks.
>>>
>>> That's actually not what this patch here tries to solve.
>>>
>>> The problem is rather since we don't remove the BOs from the LRU list
>>> that we try to evict some which are actually part of our working set.
>>>
>>> So when we lock for eviction we can't ignore duplicates no matter
>>> what the global flag says.
>>
>> Ah yes, I see that now when I've gotten to patch 9. But then I think
>> the commit message is a bit misleading. It talks about unlocking an
>> already processed object?
> 
> Oh, good point! Yeah the problem isn't the unlocking but that we evict an object from the working set.
> 
> The commit message clearly needs to be fixed.

The problem is actually both. Evicting an object from the working set 
definitely is potentially unsafe, but I considered that a minor thing. 
Unlocking the already processed objects is a much, much bigger problem IMO.

The worst breakage is for AMDGPU's per-VM buffers whose resv is just the 
VM's own reservation object: If we encounter another per-VM buffer from 
our own VM on the LRU, we may or may not decide to evict it, but in any 
case we leave the VM completely unlocked for the remainder of the 
submission, including in pagetable updates and all that, which more or 
less completely smashes the state of the entire VM if multiple PT update 
operations end up racing with each other.

This was the breakage I observed myself, so that's what I described in 
the commit message. In any case, I can also change the commit message to 
primarily point at self-eviction and/or expand my explanation on why 
unlocking causes issues.

Best,
Natalie

> 
> Christian.
> 
>>
>> Thanks,
>> Thomas
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Thanks,
>>>> Thomas
>>>>
>>>>
>>>>> ---
>>>>>   drivers/gpu/drm/drm_exec.c | 52
>>>>> ++++++++++++++++++++++++++++++++++--
>>>>> ----------
>>>>>   include/drm/drm_exec.h     |  2 ++
>>>>>   2 files changed, 41 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/drm_exec.c
>>>>> b/drivers/gpu/drm/drm_exec.c
>>>>> index 7988f5e7d56a3..91de6b4d29df8 100644
>>>>> --- a/drivers/gpu/drm/drm_exec.c
>>>>> +++ b/drivers/gpu/drm/drm_exec.c
>>>>> @@ -190,18 +190,9 @@ static int drm_exec_lock_contended(struct
>>>>> drm_exec *exec)
>>>>>   	return ret;
>>>>>   }
>>>>>   
>>>>> -/**
>>>>> - * drm_exec_lock_obj - lock a GEM object for use
>>>>> - * @exec: the drm_exec object with the state
>>>>> - * @obj: the GEM object to lock
>>>>> - *
>>>>> - * Lock a GEM object for use and grab a reference to it.
>>>>> - *
>>>>> - * Returns: -EDEADLK if a contention is detected, -EALREADY when
>>>>> object is
>>>>> - * already locked (can be suppressed by setting the
>>>>> DRM_EXEC_IGNORE_DUPLICATES
>>>>> - * flag), -ENOMEM when memory allocation failed and zero for
>>>>> success.
>>>>> - */
>>>>> -int drm_exec_lock_obj(struct drm_exec *exec, struct
>>>>> drm_gem_object
>>>>> *obj)
>>>>> +static int __drm_exec_lock_obj(struct drm_exec *exec,
>>>>> +			       struct drm_gem_object *obj,
>>>>> +			       bool always_report_duplicates)
>>>>>   {
>>>>>   	int ret;
>>>>>   
>>>>> @@ -226,7 +217,7 @@ int drm_exec_lock_obj(struct drm_exec *exec,
>>>>> struct drm_gem_object *obj)
>>>>>   		return -EDEADLK;
>>>>>   	}
>>>>>   
>>>>> -	if (unlikely(ret == -EALREADY) &&
>>>>> +	if (unlikely(ret == -EALREADY) &&
>>>>> !always_report_duplicates
>>>>> &&
>>>>>   	    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
>>>>>   		return 0;
>>>>>   
>>>>> @@ -243,8 +234,43 @@ int drm_exec_lock_obj(struct drm_exec *exec,
>>>>> struct drm_gem_object *obj)
>>>>>   	dma_resv_unlock(obj->resv);
>>>>>   	return ret;
>>>>>   }
>>>>> +
>>>>> +/**
>>>>> + * drm_exec_lock_obj - lock a GEM object for use
>>>>> + * @exec: the drm_exec object with the state
>>>>> + * @obj: the GEM object to lock
>>>>> + *
>>>>> + * Lock a GEM object for use and grab a reference to it.
>>>>> + *
>>>>> + * Returns: -EDEADLK if a contention is detected, -EALREADY when
>>>>> object is
>>>>> + * already locked (can be suppressed by setting the
>>>>> DRM_EXEC_IGNORE_DUPLICATES
>>>>> + * flag), -ENOMEM when memory allocation failed and zero for
>>>>> success.
>>>>> + */
>>>>> +int drm_exec_lock_obj(struct drm_exec *exec, struct
>>>>> drm_gem_object
>>>>> *obj)
>>>>> +{
>>>>> +	return __drm_exec_lock_obj(exec, obj, false);
>>>>> +}
>>>>>   EXPORT_SYMBOL(drm_exec_lock_obj);
>>>>>   
>>>>> +/**
>>>>> + * drm_exec_lock_obj_report_dup - lock a GEM object for use, but
>>>>> always report duplicates
>>>>> + * @exec: the drm_exec object with the state
>>>>> + * @obj: the GEM object to lock
>>>>> + *
>>>>> + * Like drm_exec_lock_obj, lock a GEM object for use and grab a
>>>>> reference to it.
>>>>> + * Unlike drm_exec_lock_obj, DRM_EXEC_IGNORE_DUPLICATES is
>>>>> ignored
>>>>> and duplicates are
>>>>> + * always reported.
>>>>> + *
>>>>> + * Returns: -EDEADLK if a contention is detected, -EALREADY when
>>>>> object is
>>>>> + * already locked, -ENOMEM when memory allocation failed and
>>>>> zero
>>>>> for success.
>>>>> + */
>>>>> +int drm_exec_lock_obj_report_dup(struct drm_exec *exec,
>>>>> +				 struct drm_gem_object *obj)
>>>>> +{
>>>>> +	return __drm_exec_lock_obj(exec, obj, false);
>>>>> +}
>>>>> +EXPORT_SYMBOL(drm_exec_lock_obj_report_dup);
>>>>> +
>>>>>   /**
>>>>>    * drm_exec_unlock_obj - unlock a GEM object in this exec
>>>>> context
>>>>>    * @exec: the drm_exec object with the state
>>>>> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
>>>>> index 8725ba92ff916..ff80dd2b72240 100644
>>>>> --- a/include/drm/drm_exec.h
>>>>> +++ b/include/drm/drm_exec.h
>>>>> @@ -176,6 +176,8 @@ void drm_exec_init(struct drm_exec *exec, u32
>>>>> flags, unsigned nr);
>>>>>   void drm_exec_fini(struct drm_exec *exec);
>>>>>   bool drm_exec_cleanup(struct drm_exec *exec);
>>>>>   int drm_exec_lock_obj(struct drm_exec *exec, struct
>>>>> drm_gem_object
>>>>> *obj);
>>>>> +int drm_exec_lock_obj_report_dup(struct drm_exec *exec,
>>>>> +				 struct drm_gem_object *obj);
>>>>>   void drm_exec_unlock_obj(struct drm_exec *exec, struct
>>>>> drm_gem_object *obj);
>>>>>   int drm_exec_prepare_obj(struct drm_exec *exec, struct
>>>>> drm_gem_object *obj,
>>>>>   			 unsigned int num_fences);
> 

