Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDA6C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D9410E140;
	Thu, 30 Jul 2026 10:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="fi5MCVVA";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D0E5110E140
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 10:57:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A34B1688;
 Thu, 30 Jul 2026 03:57:30 -0700 (PDT)
Received: from [10.1.25.28] (e122027.cambridge.arm.com [10.1.25.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8CBB3F86F;
 Thu, 30 Jul 2026 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785409054; bh=I+BOU42tMMvmeX0swrH8qcDr//Gd8XuL2Gg9evqGb2I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fi5MCVVA/BV6ZVt8RSDU3GrDge46pg/m7qECpxGCNQ1sSQeQ9pob3mj3U8NVwOMNr
 1XSnZbPgfsSaJWf8FD4b2fqrsDAI2GrwGCH7+KVO/r6zl1nlqkaGDkwA8zynmLLrJK
 h+G/P/Om/OPI6ZVu8uB0hx3e2nH+92TgcfEQ8bXQ=
Message-ID: <795eaa59-11a8-4048-b00a-394ebcc6a984@arm.com>
Date: Thu, 30 Jul 2026 11:57:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/13] drm/panfrost: Explicitly enable MMU interrupts
 at device init
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-6-01968f2ec77a@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260729-claude-fixes-v4-6-01968f2ec77a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 29/07/2026 03:54, Adrián Larumbe wrote:
> Because the device must be in a position to accept jobs between the time
> drm_dev_register() is called and autosuspend first kicks in, there's a very
> narrow window inbetween during which jobs targeting the tiler buffer
> object would time out, since the device's PM status is 'Active', but no MMU
> interrupts were enabled at device initialisation time.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c |  3 ++-
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 14 ++++++++++++--
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 35ff5b0f0013..bda1494eb430 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -871,7 +871,6 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
>  	js = devm_kzalloc(pfdev->base.dev, sizeof(*js), GFP_KERNEL);
>  	if (!js)
>  		return -ENOMEM;
> -	pfdev->js = js;
>  
>  	INIT_WORK(&pfdev->reset.work, panfrost_reset_work);
>  	spin_lock_init(&js->job_lock);
> @@ -906,6 +905,8 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
>  		}
>  	}
>  
> +	pfdev->js = js;
> +
>  	panfrost_jm_reset_interrupts(pfdev);
>  	panfrost_jm_enable_interrupts(pfdev);
>  
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 4a3162c3b659..aad0cd31516d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -336,6 +336,12 @@ void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu
>  	WARN_ON(atomic_read(&mmu->as_count) < 0);
>  }
>  
> +static void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev)
> +{
> +	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
> +	mmu_write(pfdev, MMU_INT_MASK, ~0);
> +}
> +
>  void panfrost_mmu_reset(struct panfrost_device *pfdev)
>  {
>  	struct panfrost_mmu *mmu, *mmu_tmp;
> @@ -355,8 +361,7 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
>  
>  	spin_unlock(&pfdev->as_lock);
>  
> -	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
> -	mmu_write(pfdev, MMU_INT_MASK, ~0);
> +	panfrost_mmu_enable_interrupts(pfdev);
>  }
>  
>  static size_t get_pgsize(u64 addr, size_t size, size_t *count)
> @@ -880,6 +885,9 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
>  	u32 status = mmu_read(pfdev, MMU_INT_RAWSTAT);
>  	int ret;
>  
> +	if (!pfdev->js)
> +		return IRQ_NONE;
> +

I find it odd to check the status of the job scheduler here in the MMU
IRQ handler. Personally I'd prefer we just delay the enabling of the MMU
interrupts until the driver is in a state to handle them - i.e. move the
call to panfrost_mmu_enable_interrupts() to panfrost_device_init() once
the call to panfrost_jm_init() has completed.

Also note that simply returning IRQ_NONE without actually clearing the
interrupt is likely to cause problems - panfrost_mmu_irq_handler() will
have disabled the interrupt mask and it won't be re-enabled until the
timeout happens.

Thanks,
Steve

>  	while (status) {
>  		u32 as = ffs(status | (status >> 16)) - 1;
>  		u32 mask = BIT(as) | BIT(as + 16);
> @@ -970,6 +978,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
>  		return err;
>  	}
>  
> +	panfrost_mmu_enable_interrupts(pfdev);
> +
>  	return 0;
>  }
>  
> 

