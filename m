Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2C4C5DF86
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F7B10E4E2;
	Tue, 18 Aug 2026 17:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="TOzHT9Pn";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 11B5C10E081
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 17:08:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6B951AED
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:08:51 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 60C723F763
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787072935; bh=+NK6o8MGjYbKz6ghgXSTW+obZNqfV8MyVVPimVK7gGY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TOzHT9PnziIFon3mM9gaBBLOj1MHr32FlzsWm67aCjaXIkNZzz5/n76RzdIR1Jl1w
 jkVe3+kk2EgnGrH9I8opeXrVH0MZWrG/d5niLJl8jhIKF5GDVodSHR1jfXHr9wAP+A
 1XagCUBAV/Y1DlzEcWo5sxrYMCDH6wLXXXabpD3E=
Date: Tue, 18 Aug 2026 18:08:45 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/9] drm/panthor: Don't update might_have_idle_groups
 in process_idle_event_locked()
Message-ID: <aoSRnaR61TpwRnPi@e142607>
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
 <20260811-panthor-signal-from-irq-v6-4-12f2ab53d735@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811-panthor-signal-from-irq-v6-4-12f2ab53d735@collabora.com>
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

On Tue, Aug 11, 2026 at 01:23:38PM +0200, Boris Brezillon wrote:
> By scheduling an immediate tick, we already force idleness re-evaluation,
> which gives the scheduler the opportunity to evict idle groups
> and schedule onces that have jobs pending.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 5832dccfc093..baa06731797c 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1733,8 +1733,6 @@ static void csg_slot_process_idle_event_locked(struct panthor_device *ptdev, u32
>  
>  	lockdep_assert_held(&sched->lock);
>  
> -	sched->might_have_idle_groups = true;
> -
>  	/* Schedule a tick so we can evict idle groups and schedule non-idle
>  	 * ones. This will also update runtime PM and devfreq busy/idle states,
>  	 * so the device can lower its frequency or get suspended.
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
