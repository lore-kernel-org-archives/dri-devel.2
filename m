Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269B0CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7343D10E32C;
	Fri, 26 Jun 2026 09:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pJnefy1t";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id EEDC410E32C
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 09:30:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE58F1FCD
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:30:00 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 326FC3F836
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782466205; bh=SzEpVJRZUWtd025zQUfcikjEtXWKzq+av2jgcHORPGQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pJnefy1tmMjJAl1GXXwfTusYrQqxEi++DPtefmdsla/a2rKUNLB58uSXyjqT+6d3E
 i1YoGIgnzjQNdfxpRFcFPizPOFSEQ+rFkMQvPI7AdD8x6ZKHv2pZw9AxvqI6S3OrKl
 tEq2ly74TVbYl7mY1Ifk/T41PpXgqA4KKd83cg2I=
Date: Fri, 26 Jun 2026 10:29:54 +0100
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
Subject: Re: [PATCH 05/11] drm/panthor: Fix theoretical IOMEM access in
 suspended state
Message-ID: <aj5GkoBpmrpMWHSV@e142607>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-5-b67ed973fea6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625-panthor-misc-fixes-v1-5-b67ed973fea6@collabora.com>
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

On Thu, Jun 25, 2026 at 02:40:31PM +0200, Boris Brezillon wrote:
> In theory, our hardirq handler can be called while the device (and
> thus the panthor_irq) is suspended, because the IRQ line is shared.
> In practice though, in all the designs we've seen, the line is only
> shared within the GPU, and because sub-component suspend state is
> consistent (all-suspended or all-resumed), we shouldn't end up with
> an interrupt triggered while we're suspended.
> 
> Fix the problem anyway, if nothing else, for our sanity.
> 
> Fixes: 0b2d86670a84 ("drm/panthor: Rework panthor_irq::suspended into panthor_irq::state")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com?part=1
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 35679bfa1f3a..a39386bd6382 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -512,9 +512,6 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
>  	struct panthor_irq *pirq = data;							\
>  	enum panthor_irq_state old_state;							\
>  												\
> -	if (!gpu_read(pirq->iomem, INT_STAT))							\
> -		return IRQ_NONE;								\
> -												\
>  	guard(spinlock_irqsave)(&pirq->mask_lock);						\
>  	old_state = atomic_cmpxchg(&pirq->state,						\
>  				   PANTHOR_IRQ_STATE_ACTIVE,					\
> @@ -522,6 +519,13 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
>  	if (old_state != PANTHOR_IRQ_STATE_ACTIVE)						\
>  		return IRQ_NONE;								\
>  												\
> +	if (!gpu_read(pirq->iomem, INT_STAT)) {							\
> +		atomic_cmpxchg(&pirq->state,							\
> +			       PANTHOR_IRQ_STATE_PROCESSING,					\
> +			       PANTHOR_IRQ_STATE_ACTIVE);					\
> +		return IRQ_NONE;								\
> +	}											\

Hmm,

I get it that you're trying to revert the effect of the previous atomic_cmpxchg() here but it feels
like a better option would be to not do the swap at all if the state is not ACTIVE.

Best regards,
Liviu

> +												\
>  	gpu_write(pirq->iomem, INT_MASK, 0);							\
>  	return IRQ_WAKE_THREAD;									\
>  }												\
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
