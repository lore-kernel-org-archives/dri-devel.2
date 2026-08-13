Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B86BC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA1110E35F;
	Thu, 13 Aug 2026 10:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="NG8wmxrm";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75DB210E35F
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:37:24 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so3697315e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 03:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1786617443; x=1787222243; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n/cat559Q/c7IiVou1ycCvHuktdLq1Mo05EporTLcd4=;
 b=NG8wmxrm+Na318pQPGv1aN1I8UL0E3/vKqkVC7isL424j97JxqJvGWUwUKH3dfm/Rm
 aRqStKGzUjE+2XjdmY2efpSjQi/FD/iv79hr+XkHFaNPX8TmIYJLXjSCutpSS8RAG8lk
 kJkXUYW6PSk0Md2wUJrVOSdrA2ttFkMEjCtOMHLp1o9LHKU+LlXeFBYMkxGu5rkafoDw
 ITUJPJ9NjmDaIQOD+KpC1hsXRHWDDaJamwKDeW/hc3JY9W6CaNaeuq6Hg7roW5aRky0O
 M5KCVL+G40BZE2P/fvOemTPGZJfSBzM4Gz+6zYc1YefktPSwadXGZQ3DULrI1UIXyZDc
 4Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617443; x=1787222243;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n/cat559Q/c7IiVou1ycCvHuktdLq1Mo05EporTLcd4=;
 b=K6BEDuvzq14AZkoejWybazI19OtKcumpbbcpTFIA/7Kzd5r0zDoSnNcW6/kISMTs1T
 3buvc7eOKkvF3TbSLOYiO562gPksve92g6CWjBycla/WbkfKaNHy9M1aCy5mJBf9H3t2
 SC5PblswQVluHjg+vKX4W4Rh6/dk3BUHEM57KP3WnoqpHL/eK8oWF4jteAvf1GXMQERl
 oGRDzFNLLrk5VyHrjfGQ1mZUlTHJaIFHxQQw72ckHjbh5BwIwzQSlV3lJ+IvQJG4pByT
 17AIcOA0uykkVcN2LL5iOcHsStIuLIe0PC/Tfq2f9YmrnLjglRSBSwDJb5mmJJ5IXZfx
 Ebjg==
X-Gm-Message-State: AOJu0YwnHnzOoVxgnlWoQVAjqpwk93yr7Y2gplB8PydklxchuyLmvGll
 VbDLJMSQJltlz7Ja4A+PpG49bJXrDvGuQwFnFrchNM/wJGtarV877K07ViEDV6CezQ+GqzvvpOc
 uOKoPa5E=
X-Gm-Gg: AR+sD13YboFLNEJPF9jEQR2EeBadYSNmxYnussMO9+/Y+1tH0HiWr40OkKvFscJnGL4
 dNYvjZKYIZJS1NPPaJq0XWHHV1ADNlBtIr3MhOgdgqGTGISWqrQ5O/XbfRGQAbdIoP0gYsg6Ith
 9Q93IzdBdFHEpBoGETbzUmutfvyQa2pP+RGWJ9+FboXMCJpzdJMKtNxyhMRp8sftG8W3CJ+p8oW
 5W+cI8ZyeVKErlpaGRogy6FU4ar2fng1og/WScZ35FC5zsDqHw3tF/WK5jlIDsk7KVKXSolQPqd
 BjONkOHULky2J2AarKmPHbaTl37vGjPDLML/iwpU24mz5Lr99hXk0K+8F6Gq+jOWA4vBXHgKcyN
 lFhW3ikHErIUCFvMcAxnBLkR951lCtrM1vcwGmPLjRpOv4P8WIl5WrIGBF82rCaSvcz5DToEicU
 ZES/o/iYgyYm+DXzy0DurzZoaAVlUVp+GDyyEiAlsTsVSs6hNbFNgDElzalXU5+ugbXimImC0Uk
 tEn
X-Received: by 2002:a05:600c:4e87:b0:499:79b9:e226 with SMTP id
 5b1f17b1804b1-4998218496amr50852475e9.0.1786617442361; 
 Thu, 13 Aug 2026 03:37:22 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b03d07sm62511675e9.2.2026.08.13.03.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 03:37:21 -0700 (PDT)
Message-ID: <2dd34398-3ef2-4573-8311-60e5f6b346aa@ursulin.net>
Date: Thu, 13 Aug 2026 11:37:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Lock drm_sched_entity_is_idle()
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260813094539.2407911-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260813094539.2407911-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 13/08/2026 10:45, Philipp Stanner wrote:
> drm_sched_entity_is_idle() contains a badly documented memory barrier
> and an invalid lockless access to entity->stopped. Moreover, it also
> accesses entity->list which is at all other places protected by
> entity->lock.
> 
> This function is in no way performance critical, so it is safer, more
> readable and more maintainable to take the spinlock.
> 
> Add locking to drm_sched_entity_is_idle().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index c51101ec70c1..2d941b2b2861 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -179,14 +179,18 @@ EXPORT_SYMBOL(drm_sched_entity_modify_sched);
>   
>   static bool drm_sched_entity_is_idle(struct drm_sched_entity *entity)
>   {
> -	rmb(); /* for list_empty to work without lock */
> +	bool idle = false;
> +
> +	spin_lock(&entity->lock);
>   
>   	if (list_empty(&entity->list) ||
>   	    spsc_queue_count(&entity->job_queue) == 0 ||
>   	    entity->stopped)
> -		return true;
> +		idle = true;
>   
> -	return false;
> +	spin_unlock(&entity->lock);
> +
> +	return idle;
>   }
>   
>   /**
> 
> base-commit: c9a2c8ddcd65e96e7f095a87c0cc0b3211f740ea

Spotted by chance on the mailing list but I believe I gave you r-b for 
this one already.

Regards,

Tvrtko

