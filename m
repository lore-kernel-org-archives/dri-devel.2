Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43E1F9EDCB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA4D10EA15;
	Wed, 22 Apr 2026 13:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="a7aCW5+J";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7772910EA15
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:32:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 695432454;
 Wed, 22 Apr 2026 06:32:39 -0700 (PDT)
Received: from [10.57.32.235] (unknown [10.57.32.235])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01FD53FBD2;
 Wed, 22 Apr 2026 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776864764; bh=YXsCrcloyAS6Z2ucKYRhA+5bQY8YXgApvqqeltML85k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=a7aCW5+J+7SKt6IxdKYD1bUqpHeg6nLUIgs3zYF89cI6Z5omtHQOiMz35OL0oGqby
 2Zsyay2BbI9peAyJttIr9x75umpBZg0q8QZPFvxog4KbxZUlQXk/F7zpA+PqJydsHI
 Lt43D0MGdlkRayFpaTZpedX0qQjaixMXOl0xn3So=
Message-ID: <53a66bbd-7ed5-41d9-a15e-af17f292dea1@arm.com>
Date: Wed, 22 Apr 2026 10:34:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] drm/panthor: Store IRQ register base iomem pointer
 in panthor_irq
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260412142951.2309135-1-karunika.choo@arm.com>
 <20260412142951.2309135-5-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260412142951.2309135-5-karunika.choo@arm.com>
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

On 12/04/2026 15:29, Karunika Choo wrote:
> Update common IRQ handling code to work from an IRQ-local iomem base
> instead of referencing block-specific interrupt register offsets.
> 
> Store the interrupt base address iomem pointer in struct panthor_irq and
> switch the shared IRQ helpers to use generic INT_* offsets from that
> local base. This removes the need for each caller to expose absolute IRQ
> register addresses while keeping the common IRQ flow unchanged.
> 
> No functional change intended.
> 
> v2:
> - Change IRQ request function to accept an iomem pointer instead of
>   computing it from an offset argument.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

One minor comment below...

> ---
>  drivers/gpu/drm/panthor/panthor_device.h   | 32 ++++++++++++++--------
>  drivers/gpu/drm/panthor/panthor_fw.c       |  5 ++--
>  drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 ++
>  drivers/gpu/drm/panthor/panthor_gpu.c      |  6 ++--
>  drivers/gpu/drm/panthor/panthor_gpu_regs.h |  3 ++
>  drivers/gpu/drm/panthor/panthor_mmu.c      |  5 ++--
>  drivers/gpu/drm/panthor/panthor_mmu_regs.h |  3 ++
>  drivers/gpu/drm/panthor/panthor_pwr.c      |  6 ++--
>  8 files changed, 42 insertions(+), 20 deletions(-)
> 
[...]
> @@ -1470,7 +1470,8 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  	if (irq <= 0)
>  		return -ENODEV;
>  
> -	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0);
> +	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0,
> +				      ptdev->iomem + JOB_INT_BASE);
>  	if (ret) {
>  		drm_err(&ptdev->base, "failed to request job irq");
>  		return ret;
[..]
> @@ -162,7 +162,9 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq, GPU_INTERRUPTS_MASK);
> +	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
> +				      GPU_INTERRUPTS_MASK,
> +				      ptdev->iomem + GPU_INT_BASE);
>  	if (ret)
>  		return ret;
>  
[...]
> @@ -3229,7 +3229,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  		return -ENODEV;
>  
>  	ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
> -				      panthor_mmu_fault_mask(ptdev, ~0));
> +				      panthor_mmu_fault_mask(ptdev, ~0),
> +				      ptdev->iomem + MMU_INT_BASE);
>  	if (ret)
>  		return ret;
>  
[...]
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index aafb0c5c7d23..11c43de1ddd5 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -70,7 +70,7 @@ static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
>  	}
>  	spin_unlock(&ptdev->pwr->reqs_lock);
>  }
> -PANTHOR_IRQ_HANDLER(pwr, PWR, panthor_pwr_irq_handler);
> +PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
>  
>  static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
>  {
> @@ -464,7 +464,9 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK);
> +	err = panthor_request_pwr_irq(
> +		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
> +		ptdev->iomem + GPU_CONTROL_BASE + PWR_CONTROL_BASE);

This one is the odd one out because it adds GPU_CONTROL_BASE put the
other panthor_request_xxx_irq() calls don't. Sashiko also points out
that there's an argument these should all be using ptdev->gpu->iomem in
the final refactor.

Thanks,
Steve

>  	if (err)
>  		return err;
>  

