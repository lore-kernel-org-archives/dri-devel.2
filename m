Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82015CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8C210F8C3;
	Fri,  2 Oct 2026 15:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SF03anza";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E591710F8C3
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:28:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B673143D;
 Fri,  2 Oct 2026 08:28:20 -0700 (PDT)
Received: from [10.0.129.26] (e122027.cambridge.arm.com [10.0.129.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 413F33F85F;
 Fri,  2 Oct 2026 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790954903; bh=+c2XfBklE+xxM00L91xC98BmEy1tRYcDNN94L00w0FI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SF03anza6RwRPD8/TqflSqJSUNpMzGBQmJ4mxIT1x+WHcGQflCOE7659vrNAfZwN1
 WlLbYN00xi3Wm9p4x2w4WnKYay3BDSm11GxmvSdNEVZMNRku/8mD0Gl+j8ptVPa5iI
 mYQldc5QeZH0BtK9i1BgjKDfNTrVfWecGO3NWP0k=
Message-ID: <ff25c611-abe3-4ba1-85db-9e3f6372fcec@arm.com>
Date: Fri, 2 Oct 2026 16:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 13/15] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
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
 <20260929-claude-fixes-v12-13-62beb08de207@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260929-claude-fixes-v12-13-62beb08de207@collabora.com>
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
> If the GPU and CPU are fully coherent, then there's no need to flush the
> GPU caches after a perfcnt sample is made available.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> index ffc77121070e..b3f71d7fd82a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -52,7 +52,10 @@ void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
>  
>  void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
>  {
> -	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
> +	if (pfdev->features.selected_coherency != COHERENCY_ACE)
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
> +	else
> +		complete(&pfdev->perfcnt->dump_comp);
>  }
>  
>  static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> 

