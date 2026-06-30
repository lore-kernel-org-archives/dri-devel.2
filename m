Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3CAC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312D010E094;
	Tue, 30 Jun 2026 13:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="UpVxaQTZ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9D01A10E094
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:21:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6828416F8
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 06:20:57 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 987A83F673
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782825661; bh=AUW140M7pPSScS+h1z4tF9OaZG7H6Ra98dGhhECl/TY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UpVxaQTZNEhk5oNl8FQtFtBZIg6UKZjI04TwNQjqRURuN2X/CpAdL39+5rAQRigJ2
 HTIaOLigGSm2kagfXgwc8Gn8Y3mMAPTO4mlCYYcjjEKzsRF0dOAvjHyDRrbG/gu6lX
 XbSExSZifufIqT/G0hRuZ7QZyxu+e8yhG4HtXlaY=
Date: Tue, 30 Jun 2026 14:20:51 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] drm/panthor: Don't overrule pending immediate
 ticks in sched_resume_tick()
Message-ID: <akPCs8qSQJEKIo7D@e142607>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-6-b67ed973fea6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625-panthor-misc-fixes-v1-6-b67ed973fea6@collabora.com>
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

On Thu, Jun 25, 2026 at 02:40:32PM +0200, Boris Brezillon wrote:
> We schedule immediate ticks when we need to process events on CSGs,
> but those immediate ticks don't change the resched_target because we
> want the other groups to stay scheduled for the remaining of the GPU
> timeslot they were given. Make sure these immediate ticks don't get
> overruled by a sched_queue_delayed_work() that would delay the tick
> execution.
> 
> Fixes: 99820b4b7e50 ("drm/panthor: Make sure we resume the tick when new jobs are submitted")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com?part=9
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 8fd4d97b062e..ab3e13e44a26 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2667,7 +2667,14 @@ static void sched_resume_tick(struct panthor_device *ptdev)
>  	else
>  		delay_jiffies = 0;
>  
> -	sched_queue_delayed_work(sched, tick, delay_jiffies);
> +	/* We schedule immediate ticks when we need to process events on CSGs,
> +	 * but those don't change the resched_target because we want the other
> +	 * groups to stay scheduled for the remaining of the GPU timeslot they
> +	 * were given. Make sure those immediate ticks don't get overruled by
> +	 * a sched_queue_delayed_work() that would delay the tick execution.
> +	 */
> +	if (!delayed_work_pending(&sched->tick_work))
> +		sched_queue_delayed_work(sched, tick, delay_jiffies);
>  }
>  
>  static void group_schedule_locked(struct panthor_group *group, u32 queue_mask)
> 
> -- 
> 2.54.0
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
