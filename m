Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5382C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F2D10E9D6;
	Mon, 20 Jul 2026 17:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="EMAomPxI";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C971010E9D6
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 17:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784567195; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Izisfgd2Y2SBluaBMsLQPXQLsSNKsrNGiRyO7ro/rtO8B6gJAOVoxTFafGsqfKOTSVuUC5DvH6o+6VWMBxwzjq5+oArB39sqHiv6vTzmN4wsOV3SF6VenwkmIpfr8ah25QnIvsY5TmytLxMtZnfO+VriYCupP5B/wGoxwOCQdvk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784567195;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8+nrRBTJbuE6HlyqinBPiMpBMjueSeL5yRq53YAh8fo=; 
 b=oKg6Msu2mC95FTiIGXYLcr0Q4v8mIchugYbVO+WkUVH0BsP02Bh/d/SmrqfhO3XkuXigI6hU9SwLg+X7eiwVF4O6j2ONY8X/H6N1tWQLON5UmZhV0mIKS4eCAosX3xoY953UtkmuFeRT+wzPsEIZbJnkyi339158GV5EUp3XdzE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784567195; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=8+nrRBTJbuE6HlyqinBPiMpBMjueSeL5yRq53YAh8fo=;
 b=EMAomPxII8UIS8TAQzm0W68KPvmYevMANo+5pJEBGtizf+vjJT55QNAlWFcYE8zY
 lqV7jKkAGosB+IDivsshRrwqf0IeScXLAEUN35JdBvuw+mo8iqOtjOkWkcBhQApa+bM
 5te5WbTg3vtnk6So+ulkQGqSz0/DO/KG+3hFY0Q0=
Received: by mx.zohomail.com with SMTPS id 1784567192633822.2108176776928;
 Mon, 20 Jul 2026 10:06:32 -0700 (PDT)
Date: Mon, 20 Jul 2026 18:06:29 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH] drm/panfrost: Remove unused scheduled_jobs list
Message-ID: <al5VYIlLsrrFL2_p@sobremesa>
References: <20260710121423.2820472-2-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710121423.2820472-2-mcanal@igalia.com>
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

Queued to drm-misc-next.

On 10.07.2026 09:14, Maíra Canal wrote:
> The scheduled_jobs list head was introduced in commit f3ba91228e8e
> ("drm/panfrost: Add initial panfrost driver") but never used. Remove the
> dead field and its initialization.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 1 -
>  drivers/gpu/drm/panfrost/panfrost_device.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 7fed22d555a5..d0a23c51be39 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -218,7 +218,6 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>  	int err;
>  
>  	mutex_init(&pfdev->sched_lock);
> -	INIT_LIST_HEAD(&pfdev->scheduled_jobs);
>  	INIT_LIST_HEAD(&pfdev->as_lru_list);
>  
>  	spin_lock_init(&pfdev->as_lock);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index ec55c136b1b6..1fe1554f2652 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -156,7 +156,6 @@ struct panfrost_device {
>  	struct panfrost_job_slot *js;
>  
>  	struct panfrost_job *jobs[NUM_JOB_SLOTS][2];
> -	struct list_head scheduled_jobs;
>  
>  	struct panfrost_perfcnt *perfcnt;
>  	bool profile_mode;
> -- 
> 2.54.0

