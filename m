Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C07C44501
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE2E10E8E6;
	Mon,  6 Jul 2026 11:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V8HaHo3o";
	dkim-atps=neutral
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7814810E8DC
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:40:56 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-8eabb1a9378so22087306d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 04:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783338055; x=1783942855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BlzqRtlXbabh3QQlkX9Qesj3eyFizaZyJAzX8b4cN6E=;
 b=V8HaHo3oHgaJLTbyVGd1gMUqG8LFHPyGt7rHwV3VRRIxbGVBSDvkzM7AVm6YUdXhQH
 UEicFYsVbAq5U9XOqMGR8LFKaLE6AZVGzmQxSUq7kDPQWEUEJ1b+NiyzZhNmi11a5/ic
 Xww0eoa6InstLQqP4OoeSInjpNnyCrCPpSrEUEdel66hDmXDiFlN5WtfjsKqJIeDNcVm
 Efa0O6LGlGbVaBGIKuF73y8wpCjcuMTRPgIYG0R4Uyo/WNhOrDTTFb7bDty4l7ZIlDFa
 +DQG95q7N3dT6poi3rnV0V9jHX4K0gI+phDPRI+Sv0SOt/zA03xcAFazQHrB1/adJz1E
 jcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783338055; x=1783942855;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BlzqRtlXbabh3QQlkX9Qesj3eyFizaZyJAzX8b4cN6E=;
 b=a7OYXmVoYfgH8wDqujpxsjd3X4wTFS4vWpNYZXGoid2xQ1z15TNrlqUy1hTK7WYSWg
 fEnywdY652DrTmYpwmHb7gctnV4f8gr7RUyxMHSFmkmHpksuPHVcOPfFpWS8ydDTm9eY
 kXXFS+rHsCWaugGj3BXxjZEu2TRpRLbXoB7zX+Mk3bJ04RoV1XW3/gtg7SZj2c0+Msl8
 95kDVnn5TLpcy1E8gVsqgxvBHcxVypzhhahgsq7S/DI4JMGzGFjt1geHw0mfkWEK+3qB
 PNcmqMa8+WBhchRzSRqkABnPs92fKYHLJ8UAymHVBXKRbn/Of+RluIX5xOpxQbNtVDYY
 YSWA==
X-Gm-Message-State: AOJu0YxJ6BlGa+81Be5YwEAXYRfOHHdo+UFv9JzS8eLbftDFl43WzjlP
 0w7QPQB3J3M9VBU5eCGfxl9oNcA01Uulo2zLWj/ldKyJLyQEe+sxhs6e
X-Gm-Gg: AfdE7cnE0FjICacxNEfans7MdR9Up0iZ1cSj1hUyWEaME4+UGrOGIsYfv8lKcUMSV9k
 YApL0wOBhmVnvC4xJfGHu6dmdipeYVQG+RKCslvF4ixE5iguqjkks7urj8PYjPa9we5x9UrfS8w
 dH049NNlxJcdM+a6vPrhvEOAEt1hMr8aHwH4C0vzlXiey0GU1+dey9hEmFKIO0ims94RFomeTf1
 cn7sr8Yf8lwewAOuWBMvFQzPItLrV0tNedVdjtAdOJ/RVuj/NHRERcWsDFmL6bqinm+yTqRsjs5
 k+/lRo3lseKsotnsSMHxmahVzhBlg5S49lXc34BBXxf6i0FMVQ07PGVphUGAWWbVnvHZ+F8Djag
 PWipbZ1pLQr6u7k41sQQGtRyX8It6O+INyNDHViVVyuC011O5nTjrqdWYChGfrWahxbC5UsoJ5A
 3v82aECF+euCUJCJXrJozZ9oM+9oZr26fatBXNW3zHNNK/
X-Received: by 2002:a05:6214:5348:b0:8ed:b644:c03c with SMTP id
 6a1803df08f44-8f74d1b9807mr138872566d6.55.1783338055225; 
 Mon, 06 Jul 2026 04:40:55 -0700 (PDT)
Received: from [10.254.122.221] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f471813d49sm131848996d6.27.2026.07.06.04.40.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2026 04:40:54 -0700 (PDT)
Message-ID: <5acb8994-3076-452e-a95a-d3b0159c21b7@gmail.com>
Date: Mon, 6 Jul 2026 13:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] drm/exec: Add helper to bypass IGNORE_DUPLICATES
 flag
To: Natalie Vock <nat@pixelcluster.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
 <20260706-ttm_2_drm_exec-v2-1-4bf6bfc0d320@pixelcluster.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260706-ttm_2_drm_exec-v2-1-4bf6bfc0d320@pixelcluster.dev>
Content-Type: text/plain; charset=UTF-8
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

On 7/6/26 12:07, Natalie Vock wrote:
> TTM is about to switch to drm_exec for locking objects
> in the LRU list. When we're done processing the object, we want to
> unlock it only if the caller doesn't already hold that lock. If
> DRM_EXEC_IGNORE_DUPLICATES is set on the exec object (which callers may
> require for unrelated reasons), we have no way of knowing whether the
> lock is already held.
> 
> To remedy this, add a separate helper that forcefully bypasses the
> IGNORE_DUPLICATES flag for only a single locking operation.
> 
> Signed-off-by: Natalie Vock <nat@pixelcluster.dev>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/drm_exec.c | 54 ++++++++++++++++++++++++++++++++++------------
>  include/drm/drm_exec.h     |  2 ++
>  2 files changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
> index 7988f5e7d56a3..ec33ed4a523cc 100644
> --- a/drivers/gpu/drm/drm_exec.c
> +++ b/drivers/gpu/drm/drm_exec.c
> @@ -190,18 +190,9 @@ static int drm_exec_lock_contended(struct drm_exec *exec)
>  	return ret;
>  }
>  
> -/**
> - * drm_exec_lock_obj - lock a GEM object for use
> - * @exec: the drm_exec object with the state
> - * @obj: the GEM object to lock
> - *
> - * Lock a GEM object for use and grab a reference to it.
> - *
> - * Returns: -EDEADLK if a contention is detected, -EALREADY when object is
> - * already locked (can be suppressed by setting the DRM_EXEC_IGNORE_DUPLICATES
> - * flag), -ENOMEM when memory allocation failed and zero for success.
> - */
> -int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
> +static int __drm_exec_lock_obj(struct drm_exec *exec,
> +			       struct drm_gem_object *obj,
> +			       bool ignore_duplicates)
>  {
>  	int ret;
>  
> @@ -226,8 +217,7 @@ int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
>  		return -EDEADLK;
>  	}
>  
> -	if (unlikely(ret == -EALREADY) &&
> -	    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
> +	if (unlikely(ret == -EALREADY) && ignore_duplicates)
>  		return 0;
>  
>  	if (unlikely(ret))
> @@ -243,8 +233,44 @@ int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
>  	dma_resv_unlock(obj->resv);
>  	return ret;
>  }
> +
> +/**
> + * drm_exec_lock_obj - lock a GEM object for use
> + * @exec: the drm_exec object with the state
> + * @obj: the GEM object to lock
> + *
> + * Lock a GEM object for use and grab a reference to it.
> + *
> + * Returns: -EDEADLK if a contention is detected, -EALREADY when object is
> + * already locked (can be suppressed by setting the DRM_EXEC_IGNORE_DUPLICATES
> + * flag), -ENOMEM when memory allocation failed and zero for success.
> + */
> +int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
> +{
> +	return __drm_exec_lock_obj(exec, obj,
> +				   exec->flags & DRM_EXEC_IGNORE_DUPLICATES);
> +}
>  EXPORT_SYMBOL(drm_exec_lock_obj);
>  
> +/**
> + * drm_exec_lock_obj_report_dup - lock a GEM object for use, but always report duplicates
> + * @exec: the drm_exec object with the state
> + * @obj: the GEM object to lock
> + *
> + * Like drm_exec_lock_obj, lock a GEM object for use and grab a reference to it.
> + * Unlike drm_exec_lock_obj, DRM_EXEC_IGNORE_DUPLICATES is ignored and duplicates are
> + * always reported.
> + *
> + * Returns: -EDEADLK if a contention is detected, -EALREADY when object is
> + * already locked, -ENOMEM when memory allocation failed and zero for success.
> + */
> +int drm_exec_lock_obj_report_dup(struct drm_exec *exec,
> +				 struct drm_gem_object *obj)
> +{
> +	return __drm_exec_lock_obj(exec, obj, false);
> +}
> +EXPORT_SYMBOL(drm_exec_lock_obj_report_dup);
> +
>  /**
>   * drm_exec_unlock_obj - unlock a GEM object in this exec context
>   * @exec: the drm_exec object with the state
> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> index 8725ba92ff916..ff80dd2b72240 100644
> --- a/include/drm/drm_exec.h
> +++ b/include/drm/drm_exec.h
> @@ -176,6 +176,8 @@ void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned nr);
>  void drm_exec_fini(struct drm_exec *exec);
>  bool drm_exec_cleanup(struct drm_exec *exec);
>  int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj);
> +int drm_exec_lock_obj_report_dup(struct drm_exec *exec,
> +				 struct drm_gem_object *obj);
>  void drm_exec_unlock_obj(struct drm_exec *exec, struct drm_gem_object *obj);
>  int drm_exec_prepare_obj(struct drm_exec *exec, struct drm_gem_object *obj,
>  			 unsigned int num_fences);
> 

