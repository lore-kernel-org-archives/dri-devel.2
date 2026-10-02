Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF40CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2DF410E5DF;
	Fri,  2 Oct 2026 14:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="aDIBqAD+";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8DEF810E5DF
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:26:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E6AC497;
 Fri,  2 Oct 2026 07:26:32 -0700 (PDT)
Received: from [10.0.129.26] (e122027.cambridge.arm.com [10.0.129.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F0AF3F86F;
 Fri,  2 Oct 2026 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790951195; bh=G1b6+FzmJ7CQe86VL7gfDxvD8oZUy5D4lkrvIw88dW8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aDIBqAD+gqPATxJKKF/+8cM8SrWmfJzHX2eIwm4daytFGk9vpipq7KJpJqqA9G8L2
 Dj4cgdSqboT8ejPUIo4o1jzRMq4qXXEcPwKzc9qWkB0hIzE09A8NkNiIO7UiGCNRLL
 7BqhgMVG4GukNhX0GYd+7wbGJMjaMWQS0rAZ/mvk=
Message-ID: <95357e9c-5cec-4fcb-8329-9b83bfa0bea0@arm.com>
Date: Fri, 2 Oct 2026 15:26:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/15] drm/panfrost: Explicitly enable MMU interrupts
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
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-7-62beb08de207@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260929-claude-fixes-v12-7-62beb08de207@collabora.com>
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

On 29/09/2026 04:44, Adrián Larumbe wrote:
> Because the device must be in a position to accept jobs between the time
> drm_dev_register() is called and autosuspend first kicks in, there's a very
> narrow window inbetween during which jobs targeting the tiler buffer
> object would time out, since the device's PM status is 'Active', but no MMU
> interrupts were enabled at device initialisation time.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 5c393ed6e310..faa62643caf1 100644
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
> @@ -973,6 +978,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
>  		return err;
>  	}
>  
> +	panfrost_mmu_enable_interrupts(pfdev);
> +
>  	return 0;
>  }
>  
> 

