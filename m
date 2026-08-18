Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1688C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECAEC10E081;
	Tue, 18 Aug 2026 17:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="J1SLbjl1";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4957310E081
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 17:09:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F08A814BF
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:09:29 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 9C8723F763
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787072973; bh=EzeUcnZ/yjp7MrpPjGMan4KyMak0EKtdio5H4NspdMA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J1SLbjl1QKtFgdYK5uOLKT1pAoMhrnsBGkjPqF2WM7XAACVuPeUXSoS+y2s9xLg/m
 WBci3DuEmB/2TWLPJ6oX3GDebjJOicME2MoMkaNdIkXnxpYru5YReXGKe0M/y3G1cL
 9apy++T3nJ+FvS5cNqGIwoEamxdLusdSUTOkn8fo=
Date: Tue, 18 Aug 2026 18:09:23 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/9] drm/panthor: Get rid of panthor_group::fatal_lock
Message-ID: <aoSRw6GjoU8mrugw@e142607>
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
 <20260811-panthor-signal-from-irq-v6-5-12f2ab53d735@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811-panthor-signal-from-irq-v6-5-12f2ab53d735@collabora.com>
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

On Tue, Aug 11, 2026 at 01:23:39PM +0200, Boris Brezillon wrote:
> This lock is never used, and we're about to make fatal_queues an
> atomic to cope with concurrent updates.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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
> -- 
> 2.55.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
