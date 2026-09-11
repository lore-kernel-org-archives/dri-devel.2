Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5748FC88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E7D10E30F;
	Fri, 11 Sep 2026 08:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="IjaX3zOW";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BBCB10E30F
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:19:20 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so5096335e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 01:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1789114758; x=1789719558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3VSH3uim0qHfCyk3GNDzVd8qd6vMAbK7ziEAl5hIbw8=;
 b=IjaX3zOWlkXtoY7WmbW1MTATKUrFToPu2/Gr6VPqN5FQX8UzBUwco0ltCbv2Hj2k1r
 w2u+OVL7MWQmSjrL47BRXn8dHnb3rVjUo1BOr+N+qck99YQqypIASNq1EWKMaNwegGOH
 MVJl3qIMPrjUOmBg+1ZrvYsQai7KQ6ZCmddr3mYmbUP3YtXYOqVjM0biRNT/mmeM05F/
 2doxFE7jmoWgwzL9vPD1hmRsYrPaHtpIWYLZw6Ak8JsX7wYlBjQZ94qnkGYKWRQ4YsMW
 bHWEeYRBW3G9UFaUTMDy4xT0bAAi+bqySiDuRMh99QBc6trzieFAZRln53ojRmHK4m+a
 KLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789114758; x=1789719558;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3VSH3uim0qHfCyk3GNDzVd8qd6vMAbK7ziEAl5hIbw8=;
 b=D4c5YR3JGnaEgviGrtq5myvxLOf7sngNa9rq9JRtVm5uCZvNEAFwInTikdRHU8+MKd
 ke4oklIGmKn/X6/ctbLBD7gO0DMVac7iCQaEQCHgbpogXGAuXwkWoAXj1c86EjfIz43y
 4FB+qccrnMw6cOiC2kCRQjGfLSj+ZCMA1hOQTzy0AR1aO5828hoTj5lcbo1Qx7wPzWEJ
 uGEBa8Dg+ncIqcsHZA7R9hTkG63QG3P5LgLOwlr8k3DEeEpjtglfcP4wiCWHVIvgllcz
 9mxJIwb3AiXdNljdU2dhi0jtqhkEmJQD6SCq8J2dwWSou+2kQ/H7fxddaQl48jBBtZ+T
 pNOA==
X-Gm-Message-State: AFuF++mRFBWeip70mN4hrc0ONhzRZIIey74hzxfkP4HvGx5t/mlY56KZ
 9qRVhLNGiMG7bZmNcHc1GppcpvvtNWPs12/RVN+Fb/EX7GVBrbhyow+P+EmXeIYMKvY=
X-Gm-Gg: AYBFou29x4Mm9KJbnZFC54duaQA43xnq2CRr14STqcFDA6zO2Pw4efl6iFRDuZVCKG0
 pfNvIZV6fZ3IIhsqX/yKXYesKMXIXcW7/6WCVyZmYnRvMK5ZajTNrxQh5A2CPP2Jtsxzm1gG0lR
 /jWOXAFPxPrButLuKfwmH4SoZXiCbL/3+F5F3jhqRE2v7h3DFVURyL7v5fF4YG9g6XSRAtOYu40
 w8IgD9qVh1RCQ2FvnJt0YNCVcD6QGhLdCX/5t7eu+g4G+HtBQtbik339IaDgeVzwwagORXsxSQm
 SYF+bVuAfxzF00WHa0btcPpeY/oOu6h+MTgIzvPdCUl3gNKyGHEYg8YK5o9+CLqsUBP4a380ewc
 atxi07Ajm/WAiIAHqliIb4ctEICc8vAqevOBSDpx4Whu1aToy+IRrn5LFh+wi0XaIpxhQtw/6C1
 DB0GmcxP1minygnRV7Za3lCQpAGcNSOWr4+pKh1NFlojzYupWu11fm1YF5YuA6bahxUzFOirOr4
 6wK7WdIAbr2gfw=
X-Received: by 2002:a05:600c:e547:20b0:49c:dc14:d681 with SMTP id
 5b1f17b1804b1-49e6198377cmr22396795e9.3.1789114758269; 
 Fri, 11 Sep 2026 01:19:18 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26d4e3f3sm151236265e9.15.2026.09.11.01.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 01:19:17 -0700 (PDT)
Message-ID: <23c88f50-1998-4de9-bbdb-3d15fd06d642@ursulin.net>
Date: Fri, 11 Sep 2026 09:19:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] drm/sched: Introduce more locking to entity
To: Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260910075942.2000338-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260910075942.2000338-2-phasta@kernel.org>
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


On 10/09/2026 08:59, Philipp Stanner wrote:
> Changes since v2:
>    - Fix ordering bug between spsc_queue_pop() and
>      drm_sched_rq_pop_entity().
> 
> Changes since v1:
>    - Remove a bunch of patches; make this series only about locking
>      entity->last_scheduled. The rest shall be done in separate patches
>      and series. Consequently, also do not lock spsc_queue, yet.
>    - Move lock-cycle patch to first position. (Tvrtko)
> 
> 
> Both Tvrtko [1] and I [2] have recently proposed some improvals for
> drm_sched.
> 
> While taking Tvrtko's feedback into account for my patch, I realized
> that both his and my patch can be fully replaced with a bigger and far
> more beautiful series.
> 
> If I am not mistaken, it turns out that the entire entity->entity_idle
> completion is also nothing but a workaround around the grave mistake of
> not using the greatest helper with parallel programming that exists in
> computer science: Locking.
> 
> This series adds locking to the last_scheduled field and all checks
> related to detect the idleness of the entity. As before, the
> job_scheduled event queue causes the periodic checks.
> 
> This way, we can get rid of memory barriers, RCU, a few lines of code,
> make things more readable, understandable...
> 
> Greetings,
> Philipp
> 
> [1] https://lore.kernel.org/dri-devel/20260611123423.39819-1-tvrtko.ursulin@igalia.com/
> [2] https://lore.kernel.org/dri-devel/20260626081942.2122144-2-phasta@kernel.org/
> 
> Philipp Stanner (3):
>    drm/sched: Lock drm_sched_rq_pop_entity() externally
>    drm/sched: Lock spsc_queue_pop() in drm_sched_entity_pop_job()

FWIW if you could review 
https://lore.kernel.org/dri-devel/20260907130527.52530-1-tvrtko.ursulin@igalia.com/ 
you could drop the first two patches from your series. Extra benefit is 
that patch fixes a bug and has been tested by the user.

Regards,

Tvrtko

>    drm/sched: Protect entity->last_scheduled with spinlock
> 
>   drivers/gpu/drm/scheduler/sched_entity.c | 53 ++++++++++--------------
>   drivers/gpu/drm/scheduler/sched_rq.c     |  4 +-
>   include/drm/gpu_scheduler.h              | 10 ++---
>   3 files changed, 28 insertions(+), 39 deletions(-)
> 

