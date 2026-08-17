Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AAAC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC5E810E428;
	Mon, 17 Aug 2026 15:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Td0+vMAP";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 408BF10E428
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:12:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBD6B1655;
 Mon, 17 Aug 2026 08:12:21 -0700 (PDT)
Received: from [10.57.6.69] (unknown [10.57.6.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D4B53F673;
 Mon, 17 Aug 2026 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1786979545; bh=SbZm9X+mRtNNbTef9XWXfpE6SD77RIAaE9pWNJa7ec4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Td0+vMAP7XqOUyQnUZw2oa7rbd7/aeVddWouUHYOi7fpPNoPdtwxLk1R2xIJVWc7n
 D8F8QiVK9FRUhhxGM/Gn592f2s99d5QIk4n592JYJBgw7b8TmaSXmdq+Z8rKIN7k9X
 /Mg4piIao+fv5pp0sMZiC/Zm37+Bdf9oCrraiH+w=
Message-ID: <44deb321-aa09-44f1-beb9-86a4d7eea1f4@arm.com>
Date: Mon, 17 Aug 2026 16:12:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] drm/panthor: Get rid of panthor_group::fatal_lock
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
 <20260811-panthor-signal-from-irq-v6-5-12f2ab53d735@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260811-panthor-signal-from-irq-v6-5-12f2ab53d735@collabora.com>
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

On 11/08/2026 12:23, Boris Brezillon wrote:
> This lock is never used, and we're about to make fatal_queues an
> atomic to cope with concurrent updates.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Although it does make me wonder if there's a fix that needs backporting...

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index baa06731797c..9adf1e21eb83 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -565,9 +565,6 @@ struct panthor_group {
>  	/** @idle_queues: Bitmask reflecting the idle queues. */
>  	u32 idle_queues;
>  
> -	/** @fatal_lock: Lock used to protect access to fatal fields. */
> -	spinlock_t fatal_lock;
> -
>  	/** @fatal_queues: Bitmask reflecting the queues that hit a fatal exception. */
>  	u32 fatal_queues;
>  
> @@ -3675,7 +3672,6 @@ int panthor_group_create(struct panthor_file *pfile,
>  	if (!group)
>  		return -ENOMEM;
>  
> -	spin_lock_init(&group->fatal_lock);
>  	kref_init(&group->refcount);
>  	group->state = PANTHOR_CS_GROUP_CREATED;
>  	group->csg_id = -1;
> 

