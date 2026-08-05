Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14130C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4A310EDB5;
	Wed,  5 Aug 2026 09:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D/RhqBgh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD2210EDB5;
 Wed,  5 Aug 2026 09:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785923139; x=1817459139;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VbXQHh8evBzgMPcOjnNk5oHCvpn+mjwupKHiUdef7CY=;
 b=D/RhqBghYlYisYUPKn1wINC0pssQjYu0aLgkF4axnfnQTVsb4Skaan/j
 ONP9IapzCht+zPNsDoBg+ezUOkBvqAttWAyi7BcX0HslPHSo48Iziynoh
 F2Vd8Jmz+kTETQPW7sHqB60mQvyGUfeG1eZzhAL74ugtpAl1enBOQUczD
 CR8QKnhFJJtgjqOZDL1an7VHyMcsIwHD3aPIx3z4icm+yuLxvW0OuI/K9
 nk0vu4gGTEbGa5Lw7Jso523JSw1dD3H6ZADPUkYG2reHD2TrTjQn5BYje
 SlHt4TbMAIfu4OMm7eQG6j8uilJRjXov3nLGEtn5sFo/igOTXQhEIYfuj g==;
X-CSE-ConnectionGUID: /+FRkK81SZ2JoGL6W9bJEw==
X-CSE-MsgGUID: eS4VYdrySmyQxVfpyIhQBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="89015021"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="89015021"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 02:45:37 -0700
X-CSE-ConnectionGUID: zw19Zo1eR1KWkXZ1vP8qNg==
X-CSE-MsgGUID: +m8ykC3QREiergrF+UVGGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="263750057"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.244.54])
 ([10.245.244.54])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 02:27:11 -0700
Message-ID: <7cc285c5-ecd2-4f65-8d2c-4c597b060841@linux.intel.com>
Date: Wed, 5 Aug 2026 11:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/i915/userptr: Fix user pages leak on get_pages
 failure
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, ZhaoJinming <zhaojinming@uniontech.com>,
 dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Kees Cook <kees@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Matthew Auld <matthew.auld@intel.com>
References: <20260728054152.140524-1-zhaojinming@uniontech.com>
 <178591982239.30698.15708833006428973734@jlahtine-mobl>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <178591982239.30698.15708833006428973734@jlahtine-mobl>
Content-Type: text/plain; charset=UTF-8
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

Hey,

On 8/5/26 10:50, Joonas Lahtinen wrote:
> Adding Maarten and Matt for below discussion points.
> 
> Quoting ZhaoJinming (2026-07-28 08:41:52)
>> When ____i915_gem_object_get_pages() fails inside
>> i915_gem_object_userptr_submit_init(), the pvec containing pages
>> pinned by pin_user_pages_fast() was never freed:
>>
>> 1. obj->userptr.pvec was set to the pinned pages
>> 2. The local pvec variable was NULLed
>> 3. ____i915_gem_object_get_pages() failed, but its internal
>>    i915_gem_object_userptr_drop_ref() only decremented page_ref
>>    from 2 to 1, not triggering the pvec cleanup
>> 4. The unconditional obj->userptr.page_ref-- brought page_ref
>>    to 0, but the pinned pages remained referenced only by
>>    obj->userptr.pvec with no path to reclaim them
>>
>> Additionally, the cache hit path could return success on a
>> subsequent call despite page_ref being 0, leading to a
>> GEM_BUG_ON(obj->userptr.page_ref < 0) crash in drop_ref when
>> the pages were eventually invalidated.
> 
> That's a very verbose way of saying that error handling is missing
> for ____i915_gem_object_get_pages failures here.
> 
>> Fix by calling i915_gem_object_userptr_drop_ref() on the
>> get_pages failure path, which properly decrements page_ref
>> from 1 to 0, triggering the pvec cleanup. Make the page_ref--
>> after the if block conditional on success, since drop_ref
>> already handles the refcount on failure.
> 
> Not sure that is the right fix, seems that i915_gem_userptr_get_pages
> is rigged in a way that in the intro page_ref >= 1 is required, and is
> unconditionally increased (becomes >= 2), then on error path drop_ref is
> called which will unconditionally decrease but never free because page_ref
> always remains at least 1. I think that is the real bug which is being papered
> over here. Maarten, am I missing something?
> 
> This seems to be introduced by commit:
> 
> 	ed29c2691188 ("drm/i915: Fix userptr so we do not have to worry about obj->mm.lock, v7.")
> 
> As for the original report, lack of error handling seems to be introduced
> by commit:
> 
> 	b4b9731b02c3 ("drm/i915: Simplify userptr locking")
> 
> The commit message goes on to explain it a little bit, but this chunk from
> original patch still seems quite odd?
> 
> -------------------------- 8< --------------------------  
> @@ -341,12 +317,14 @@ int i915_gem_object_userptr_submit_init(struct drm_i915_gem_object *obj)
>         if (!obj->userptr.page_ref++) {
>                 obj->userptr.pvec = pvec;
>                 obj->userptr.notifier_seq = notifier_seq;
> -
>                 pvec = NULL;
> +               ret = ____i915_gem_object_get_pages(obj);
>         }
>  
> +       obj->userptr.page_ref--;
> +
>  out_unlock:
> -       spin_unlock(&i915->mm.notifier_lock);
> +       i915_gem_object_unlock(obj);
>  
>  out:
>         if (pvec) {
> -------------------------- 8< --------------------------  
> 
> Regards, Joonas
> 
>>
>> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
>> ---
>>  drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
>> index 043095f93ac6..7d2750528485 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
>> @@ -292,9 +292,12 @@ int i915_gem_object_userptr_submit_init(struct drm_i915_gem_object *obj)
>>                 obj->userptr.notifier_seq = notifier_seq;
>>                 pvec = NULL;
>>                 ret = ____i915_gem_object_get_pages(obj);
>> +               if (ret)
>> +                       i915_gem_object_userptr_drop_ref(obj);
>>         }
>>  
>> -       obj->userptr.page_ref--;
>> +       if (!ret)
>> +               obj->userptr.page_ref--;
>>  
>>  out_unlock:
>>         i915_gem_object_unlock(obj);
>> -- 
>> 2.20.1
>>

I completely and entirely forgot everything related to i915 userpointer code, so I'm not much of help here.

It seems that i915_gem_userptr_get_pages() checks if page-ref is 0, then increases the page ref on success, which we then use to decrease our original page ref.

The patch by ZhaoJinming removes correct handling of the case where page_ref is already >= 0

Might be better to do change it to

	if (!obj->userptr.page_ref) {
		obj->userptr.pvec = pvec;
		obj->userptr.notifier_seq = notifier_seq;
		pvec = NULL;
		ret = ____i915_gem_object_get_pages(obj);
	}

and in i915_gem_userptr_get_pages, look for !userptr.pvec instead of !obj->userptr.page_ref

Kind regards,
~Maarten Lankhorst
