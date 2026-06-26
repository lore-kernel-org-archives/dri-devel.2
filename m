Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CFBC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C8E10E1A7;
	Fri, 26 Jun 2026 13:14:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="PDvxQNXY";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 99D4A10E277
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:14:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC17A16A3
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 06:14:52 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 030343F632
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782479697; bh=eF0j0/YTdB0/ZJ3vRoIz/xUJ/gxKGDooPHZJ4OvYhaM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PDvxQNXYJgzovaOtT9szGaEb0bFWLMROJnKVD0nc0er/VTTErcBuMl9EEzYTQgj5o
 XFLpm8RElYJCoQqFsNc8pR5dV64Odg0uWPBDl/99oe3ogPr6bjIYBOsAykFvwIV51t
 3XfqQ1qkGOlZY50KW4EY3QedhxcoJCcL2HWeVLnY=
Date: Fri, 26 Jun 2026 14:14:45 +0100
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
Subject: Re: [PATCH 10/11] drm/panthor: Interrupt group start/resumption if
 group_bind_locked() fails
Message-ID: <aj57RUwD_JwhOSvu@e142607>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-10-b67ed973fea6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625-panthor-misc-fixes-v1-10-b67ed973fea6@collabora.com>
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

On Thu, Jun 25, 2026 at 02:40:36PM +0200, Boris Brezillon wrote:
> group_bind_locked() can fail if the MMU block is stuck. This is normally
> a reset situation, but by the time we reset the GPU, we might have
> tried to resume a group that's not resident, which will probably trip
> out the FW. So let's avoid that by bailing out when group_bind_locked()
> returns an error. We don't even try to start more groups because the
> GPU will be reset anyway.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260623-panthor-signal-from-irq-v3-0-2ece396f8ee0@collabora.com?part=7
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 5fe95d03f23e..298b046c95ed 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2368,7 +2368,13 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
>  
>  			csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
>  			csg_slot = &sched->csg_slots[csg_id];
> -			group_bind_locked(group, csg_id);
> +			ret = group_bind_locked(group, csg_id);
> +			if (ret) {
> +				panthor_device_schedule_reset(ptdev);
> +				ctx->csg_upd_failed_mask |= BIT(csg_id);
> +				return;
> +			}
> +
>  			csg_slot_prog_locked(ptdev, csg_id, new_csg_prio--);
>  			csgs_upd_ctx_queue_reqs(ptdev, &upd_ctx, csg_id,
>  						group->state == PANTHOR_CS_GROUP_SUSPENDED ?
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
