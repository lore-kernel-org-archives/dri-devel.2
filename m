Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF85C5DF77
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E920A10E852;
	Mon, 17 Aug 2026 15:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="CkrR0FxJ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A649210E825
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:09:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C9D71655;
 Mon, 17 Aug 2026 08:09:37 -0700 (PDT)
Received: from [10.57.6.69] (unknown [10.57.6.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4C0B3F673;
 Mon, 17 Aug 2026 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1786979381; bh=mxdae8qsaz2QSj4rpZX0Bin/qg2+zw4DuF6U7OmGWfA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CkrR0FxJ5A2GAIn6XoNMQZK+c0+sn95o3keMwioGNEOEC21P6dTfoRI8sbcEytvHy
 d0BTDAfIt+jaItWyH5u3gFmatU3VtC4tyGLHH3CuwXTTIoeQsQ3t0ZiNk537WD/Z80
 +K425k7of3BHFp4N+el28SC51SYdE1CaRPt2SPdQ=
Message-ID: <c7ce5120-f599-4248-96e4-e34bc1b77887@arm.com>
Date: Mon, 17 Aug 2026 16:09:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] drm/panthor: Don't update might_have_idle_groups
 in process_idle_event_locked()
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
 <20260811-panthor-signal-from-irq-v6-4-12f2ab53d735@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260811-panthor-signal-from-irq-v6-4-12f2ab53d735@collabora.com>
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
> By scheduling an immediate tick, we already force idleness re-evaluation,
> which gives the scheduler the opportunity to evict idle groups
> and schedule onces that have jobs pending.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

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

