Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFD1C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF5AA10E327;
	Wed,  1 Jul 2026 09:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QIVYRHuO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACD910E327
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bcuJIHJURN2nRVwMc14bEcKEFn5tgCON28gFcUCQqSQ=; b=QIVYRHuO5eyGWfbHfZ8UPQhTe3
 e1UlX0EpGFowYIEBa4o2cHjcOdMf1S+kB/c9YID9dDiY/b2u8ZbvpMWQ6N4MLuM5D2V+PUcq0E6qu
 E31KvA7J9esLGZ2kZCZdiT7mNvQfP9peAA6GiU9pqk3rYilwpz3myiGh0aNOcu90J9bPneLQJxkGm
 fhBk5s+3cmhnFGYbnpG2T3J3ka6JNwLoRdLkh3ymA+t3bVxTBzMOb82/cOy5WY4Hj7RgMYVczqxfQ
 bVEPiCTl4DkGhGvn6sIgHjDmnuOjpjHR43UNSQkYIZFdB3Uu+IPTtT9HmWRiLiAPuHkd7p8Z9zyPf
 ymNihnhQ==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1werX3-007UwW-GA; Wed, 01 Jul 2026 11:47:01 +0200
Message-ID: <c607eb83-7051-46d4-b630-ff44c34d9410@igalia.com>
Date: Wed, 1 Jul 2026 10:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/sched: Lock drm_sched_entity_is_idle()
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Marco Pagani
 <marco.pagani@linux.dev>, Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260701085920.3253248-2-phasta@kernel.org>
 <20260701085920.3253248-6-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260701085920.3253248-6-phasta@kernel.org>
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


On 01/07/2026 09:59, Philipp Stanner wrote:
> drm_sched_entity_is_idle() contains a badly documented memory barrier
> and an invalid lockless access to entity->stopped.
> 
> This function is in no way performance critical, so it is safer, more
> readable and more maintainable to take the spinlock. This also enables
> future cleanup work where the entity can be fully synchronized via its
> spinlock.
> 
> Add locking to drm_sched_entity_is_idle().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 0fc1213a0d3f..cb03d6a36578 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -178,14 +178,18 @@ EXPORT_SYMBOL(drm_sched_entity_modify_sched);
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

I think this is fine and indeed not performance critical in any way so:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

