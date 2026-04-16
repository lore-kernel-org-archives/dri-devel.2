Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF88F8A15F
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA8010E88B;
	Thu, 16 Apr 2026 11:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ue9QzsUz";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9873710E88B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xytJPFtviZFmLvy8Z1L0SKvnv5mhxjqvlYNt3Y0YhVw=; b=Ue9QzsUz1A9PKYGdxYef25K9qt
 SasuatY9kj8gh2+v7KMC/EFOBM4YshZFCO/zi8gyqtRB4YPs82p+7TX3Q6TKf56AUnj8vYgYxy96f
 1BF5XQ+jy7HxznrfKktwFqN5TS8ltI8XY6x7J7WfR2pk+RqaV4Usssv0CRnaILC1U2BGp3baQ73D+
 bcX6xHOkKwwj9tvsfR7HtwOmE6EFoZsbSn3wIQcPxUHqfSbruQZJyseVE2wgV1dd5MrM66Jj42Y5/
 iXKAfPNfSwLc+elCTWbKsDy/DtcnQ8NTgwQj6hto+9KImWxpv5GqVXupeARSrlpKJqT7G31T7gh8u
 gbSLoudg==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wDL8z-00GxXp-Jg; Thu, 16 Apr 2026 13:44:25 +0200
Message-ID: <d03aa1fd-b974-4e90-a917-c5a48f5faa26@igalia.com>
Date: Thu, 16 Apr 2026 12:44:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] drm/v3d: Use inline lock for dma fence
 initialization
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
 <20260413-v3d-sched-misc-fixes-v1-3-bac63a8ceb6c@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260413-v3d-sched-misc-fixes-v1-3-bac63a8ceb6c@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 13/04/2026 16:03, Maíra Canal wrote:
> Since commit 1f32f310a13c ("dma-buf: inline spinlock for fence protection
> v5"), dma_fence_init() accepts a NULL external lock and will fall back to
> an inline spinlock embedded in the fence itself. The embedded spinlock
> allows the decoupling the lock and the fence lifetime.
> 
> Pass NULL so each v3d fence uses its own inline lock. This will allow
> queue_lock to use spin_(un)lock_irq() in all its uses instead of
> spin_(un)lock_irqsave().
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_fence.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fence.c
> index c500136d0455..9b1a882a4c15 100644
> --- a/drivers/gpu/drm/v3d/v3d_fence.c
> +++ b/drivers/gpu/drm/v3d/v3d_fence.c
> @@ -15,7 +15,7 @@ struct dma_fence *v3d_fence_create(struct v3d_dev *v3d, enum v3d_queue q)
>   	fence->dev = &v3d->drm;
>   	fence->queue = q;
>   	fence->seqno = ++queue->emit_seqno;
> -	dma_fence_init(&fence->base, &v3d_fence_ops, &queue->queue_lock,
> +	dma_fence_init(&fence->base, &v3d_fence_ops, NULL,
>   		       queue->fence_context, fence->seqno);
>   
>   	return &fence->base;
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

