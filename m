Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E53606A33B
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.a=rsa-sha256 header.s=google header.b=kALG8biF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6139D10FDD0;
	Wed, 18 Nov 2026 16:34:19 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403EA10FDD0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:34:12 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e47347279so750428f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1795019650; x=1795624450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C0uQO4m5AZQuZD/qmLkcdjegER6bbbPKAATaLMex7+s=;
 b=kALG8biFivbWH3oAerR3QtM9MPxui+5AyyV4Iu1D7bIEG87gZSs0auBbWUPm8g+lID
 NOfCJe1sevW5bXhCtVdtpyTNHLbN2eqzmhS8450TuHLRdKQ+NnsuhzbR/ZRYEQDEcAjY
 tsj0ng/cEszZhykS2dso0lCDlOci40qyijHACeemRHmSsqmrools/Y4k3svl06+cnVNc
 4YIAUZimCjskhuJ5Xcae48PRCPJBegaeAtBfLRVQ6SuZrC21X4/TQfBIq48Gcmp4ZdZu
 QJ7PXD81Pm5ocdl8d3/mhmVNCAg/5hjOmvEfos1s+9p2s5PRUGp7lA9/JPDlAT3YeVlC
 pSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795019650; x=1795624450;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C0uQO4m5AZQuZD/qmLkcdjegER6bbbPKAATaLMex7+s=;
 b=ewEirp8drT0PfiQQy9139+R9CdLP1W0oB1n7z0sD6Mq7ot65QsxgHZX5qGCf9FULwL
 P7XHPILWIRhZ75zx0grNGNnfSioFTBpjefhK9Y7oC31Cg3/yJAw4wGfTdj7+9UCY7OoJ
 E0U1Dd7nttCVwOfeKHUDvusDGl5v5kXVWGZeWNieciwUjV11ByUXDqAS7T8vCXU6Ao5b
 iiQ8BrmnXaYWx9CMwyWqrZDV+24GGamcZgy4CsJN9L6Sk3UYAa63LLIdAQf25IIyw0Em
 GPx/vHhiMVIbsi8nXAYg5i2kFv4tk3A9ti2LeSiTfR9GHOA1GNWlJnEooufpyQGoaf3H
 7+dA==
X-Forwarded-Encrypted: i=1;
 AL+hErFxlJwpnslXJzj0i/cikcq9iC8LCk4uPLHvhnB3vT8NPa8xpxRKh4dfC+fLrk3kJHv7GzVCFJzoWU4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/bbPqGmrtNlL25DHBTTYOn3AkD1LKwftQpqQZZLMdE3chaX0Ik
 XJAhCjGk7ZNE9efNr/FrM8t38ZIJHsZfbFnvII5p7MVn658ksGZ1K7JOEVLTaTm3lVs=
X-Gm-Gg: AZFdTZdiIRt6OI9tahxD/r4+BBe5u7LFyX7oUPwQ4/cWYK0gtrFg3wWSza/oO5GWizC
 mZWr4HZIQat+LJNAD9GbvrlEep905InRFBbrVUkJKiTWAs9iP1gWtLGCWGX4/L0udgIjP7lAwzc
 d1+QosQfcqkzX//rkZotSLJGi/P6eD8+aLAAj0lkWVX7DVcHF/VMou5k7XVV3kPnP9vLBkcQ5xn
 DaCyrZRW6vZzALAoVgIJ7MKkzry7ivTHm67Gh9uvif+LRAophnFTmO8gwhtJ7kgo2i0zGt5sP1A
 aG16mHsg5WuluKbh9PK+BHSUjSg9Y0pNSU25DQqSrP7AS8LNqiaX6K/QEkxRhRpKGf+Ns02kqpj
 LN9OsqH1TmKo/p6HcUyzFoui+xq4J9bdN0MUJ2l22wwW00PxORVrbIkF/bCFNyIlFgiFVITLLKu
 TCO+i2QUPk1S/zoX+0wM6A7ZWuFtZOuLCeL1Gog5baXX/P7/8fKlwnq8Vr9KMnbaoVC11YUPIaS
 L+J0dKsk9JmT7aBS9V/r4z260lBNjxc2s3FGzruw11PQf6gMT/X4epDN0MxGNOeTdBICZAkoRkF
 mrV3kYVSfDLcCButOhKHIxU6Wbl5UyPKTkNkPm3Cbg1cyQ==
X-Received: by 2002:a05:6000:1610:b0:491:e062:383d with SMTP id
 ffacd0b85a97d-4a63d1daa1fmr4563395f8f.57.1795019650348; 
 Wed, 18 Nov 2026 08:34:10 -0800 (PST)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2e26csm5659578f8f.4.2026.11.18.08.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 08:34:09 -0800 (PST)
Message-ID: <598d80dc-1269-44ff-8852-b63b6ab57ea5@ursulin.net>
Date: Wed, 18 Nov 2026 16:34:09 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/sched: Add drm_sched_entity_get_runtime()
To: Sidong Yang <sidong.yang@furiosa.ai>, Tomeu Vizoso
 <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, ckoenig.leichtzumerken@gmail.com
Cc: mcanal@igalia.com, Heiko Stuebner <heiko@sntech.de>,
 Gyeyoung Baek <gye976@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261112171144.3151554-1-sidong.yang@furiosa.ai>
 <20261112171144.3151554-2-sidong.yang@furiosa.ai>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20261112171144.3151554-2-sidong.yang@furiosa.ai>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 12/11/2026 17:11, Sidong Yang wrote:
> The scheduler accumulates the time each entity's jobs spend on the
> hardware for the fair policy, but drivers cannot read it. Export it so
> drivers can report per-client engine time through fdinfo without
> keeping their own counter.
> 
> The stats object is refcounted and held by the entity and its jobs, so
> unlike commit df622729ddbf ("drm/scheduler: track GPU active time per
> entity"), which was reverted, accounting a job does not touch the
> entity.
> 
> Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 25 ++++++++++++++++++++++++
>   include/drm/gpu_scheduler.h              |  1 +
>   2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 03e68b4102d5..ac040f95876a 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -238,6 +238,31 @@ int drm_sched_entity_error(struct drm_sched_entity *entity)
>   }
>   EXPORT_SYMBOL(drm_sched_entity_error);
>   
> +/**
> + * drm_sched_entity_get_runtime - Get the time an entity's jobs have run
> + * @entity: scheduler entity
> + *
> + * Returns the time the jobs of @entity have spent on the hardware, measured
> + * from the scheduled to the finished fence of each job. A job is accounted
> + * when the scheduler frees it.
> + *
> + * The caller must ensure @entity has not been finalized.
> + *
> + * Return: Accumulated runtime in nanoseconds.
> + */
> +u64 drm_sched_entity_get_runtime(struct drm_sched_entity *entity)
> +{
> +	struct drm_sched_entity_stats *stats = entity->stats;
> +	ktime_t runtime;
> +
> +	spin_lock(&stats->lock);
> +	runtime = stats->runtime;
> +	spin_unlock(&stats->lock);
> +
> +	return ktime_to_ns(runtime);
> +}
> +EXPORT_SYMBOL(drm_sched_entity_get_runtime);
> +
>   static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>   					  struct dma_fence_cb *cb);
>   
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 3b0978fa8cf0..96a3401d4c88 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -730,6 +730,7 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity);
>   void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
>   				   enum drm_sched_priority priority);
>   int drm_sched_entity_error(struct drm_sched_entity *entity);
> +u64 drm_sched_entity_get_runtime(struct drm_sched_entity *entity);
>   void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
>   				   struct drm_gpu_scheduler **sched_list,
>   				   unsigned int num_sched_list);

LGTM.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

