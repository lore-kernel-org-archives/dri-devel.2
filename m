Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3E8CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 05:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E9710F897;
	Wed,  3 Jun 2026 05:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="yC4omG5w";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A32310F897
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 05:58:12 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45ee6d32402so3347186f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 22:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1780466291; x=1781071091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9vh0MNyTx90915CjAy5zcalwyPXTfoUxPJ3DLQUU3F8=;
 b=yC4omG5wt6UUPDz9h3M8k8ky5ctRmRC5fgpcW9nOI8kTK3PvsRD6ArpTGtL/CqMv0M
 oHApPjPq5QZamWYFQ30EuNE1lEhN1/xfhBLuexsVxBdqaVJfeCBs0RReDC4T6WOLSqZ2
 aPn/XXJCdHk3ldXnK9snd8ueJIWvJCTgLoZhjctKMtX+lQ6gcsAgraFndgN2gjmXCBW9
 HvSUThEVltvAF0H6dOgbO8mf5bCKgLDqZBbQ/ClS7fN2yRPMwmeHXEQVqFaGZ2DDovHo
 +3bcGTc3uXgFS0wB2KjujpSwOY+giCbBDiQ9gvl/Z5YQCO12GOoHDRdS/ORkgS6f00PA
 mNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780466291; x=1781071091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9vh0MNyTx90915CjAy5zcalwyPXTfoUxPJ3DLQUU3F8=;
 b=baRn/G0Kyv2FUZNUyiQI2IKSv6E+F1zE7yXCQhEUM8bo9438dTHh92ofE8zQzks3RE
 iglOE7VHqyjQ7NGIU37p9mhuH/63d8QAjXfzxkwgsiV3vfTMLJpVBiVJlqwALz/5tx3p
 G24ip86zmKj6Oh1Burw2yqex4nWXwhS46fv1yKODw3nGuHOZ5pmiRAlIT7gzUpo1ySSE
 D+JD+0l1kbgD7Kr7g86UJucMnGYrZ9NAq8ZpneeRirHMBbodGhBMUM/dWgBlIl99VvBg
 k23VlEa/WHN3yagQOnrXGMEUTfVhnZLKLmQKmMYlTVNa0xigRuKebIK/dI3AOfp/SLat
 0RfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/t+BvoTH95f1MNcR6pc8ZKs2SX+qrfQqCMZpTz4fZJMM+t3XNGCwS/c2cEu+YbqOKoA1sXmHF/VKE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvbxnAh0sF4Ij2q1ayyLc5NbLk0YB3IcZSXWUTW3j4dpFuQFfA
 xarSBwniRt93GRQw6g9RzsNe8pWOmhknWAVf+79XsJvCG2RmWnXDQgxp+FJVDihgF+Y=
X-Gm-Gg: Acq92OH8Seuxov4byGKM8Po69yKHrUP/Qp9T2PhTfzBvGewAXZo2i52KpEwFqyY/9LV
 qNESLqh7TcHUZDi/SwIbVTQKt0h/HssRDuRAR8o6lMhsvIiCeN98yGeLYOaIyUT+tskGFZz+i9K
 Ez7DTU1RKF+i0W+Fsxnw3TamCVLvNJmBLvS91irVdBV7Txtti00+DPPAyrYdNexuG/2Ioi3QZ/2
 tvzfo/7+9Dm5wlMYH9eJZwJ8puQ5LHOEICqhENhrgFuBLzPeNGe+o49pyruJMiKH97uqlRB9R0D
 HizCANELrJNetGg2UKQPLjnenSh64ikCXdodO3jW00+U3eiWl9JyPEyKmocifhIX7gvEJVPE67J
 ET5uIZz8vK9UJj48ZL03e6fao63kAulqBxrgOWxgd/wBnMNTFrHbayKxycpIA9Bpe53jk07L30Z
 CJ3delExVbhP5jQI4G8Km1tm9VUNd2rzJDVOJFWy7iRVSvYdnD1uA7Hvw=
X-Received: by 2002:a05:600c:c174:b0:490:b258:3576 with SMTP id
 5b1f17b1804b1-490b5d1cf1bmr28645585e9.7.1780466290142; 
 Tue, 02 Jun 2026 22:58:10 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35133csm4468360f8f.25.2026.06.02.22.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 22:58:09 -0700 (PDT)
Message-ID: <82e8aead-9782-4d2d-8fd9-7d0aed291e05@ursulin.net>
Date: Wed, 3 Jun 2026 06:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: fix NULL deref when logging missing entity
 runqueue
To: Candice Li <candice.li@amd.com>, dri-devel@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
References: <20260603025636.1301481-1-candice.li@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260603025636.1301481-1-candice.li@amd.com>
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


On 03/06/2026 03:56, Candice Li wrote:
> job->sched is not initialized until drm_sched_job_arm(), so use
> pr_err() instead of dev_err(job->sched->dev, ...) when entity->rq
> is NULL.
> 
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index bd7936c03da2aa..d21eada76cedf1 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -806,7 +806,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
>   		 * or worse--a blank screen--leave a trail in the
>   		 * logs, so this can be debugged easier.
>   		 */
> -		dev_err(job->sched->dev, "%s: entity has no rq!\n", __func__);
> +		pr_err("*ERROR* %s: entity has no rq!\n", __func__);
>   		return -ENOENT;
>   	}
>   


Even better, entity->rq cannot be NULL:

https://lore.kernel.org/dri-devel/20260602153339.43453-1-tvrtko.ursulin@igalia.com/T/#u

Regards,

Tvrtko

