Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93271CDE002
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E568010E398;
	Fri, 26 Jun 2026 12:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="lPws5hpc";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E50A010E398
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:45:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C32951F91
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 05:45:44 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 262A73F905
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782477949; bh=JLHJkInW6xox/u0mAs1IgK2su7Gqdx8vLjmuLMQnhmc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lPws5hpcu7BFfoEm/e0GEYuUm10BMaH2HTgvO2eVIaxU2kQ3KAre3mtR9KjsRlVee
 07Ng89I2gbdQ0ucOOKlVe07FHG+PVtsHpddIwCVQZ3/YH8J3+JGyUgRWwDPvL+RPh2
 WGyN0LnwwlxIT9PuR+u70BUKzYipDqfmYwJnOrxQ=
Date: Fri, 26 Jun 2026 13:45:38 +0100
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
Message-ID: <aj50chPdgUKBWVBx@e142607>
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

Maybe I'm having a Friday heat brain freeze, but it feels like the comment and the code
are going in a different direction. It doesn't help that the commit message copies the
comment so I can't tell if I'm misreading the comment or there was a different intent.

Best regards,
Liviu

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
