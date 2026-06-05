Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03A2CD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3D910E5B2;
	Fri,  5 Jun 2026 10:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ny9xg6XC";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8A20610E5B2
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 10:30:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C20C4CEF;
 Fri,  5 Jun 2026 03:29:58 -0700 (PDT)
Received: from [10.1.31.21] (e122027.cambridge.arm.com [10.1.31.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A6713F632;
 Fri,  5 Jun 2026 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780655403; bh=l5XPrdnvXRn0Y9bhoXgXDo2kdLCPso1A+0xVqL4ZDJc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ny9xg6XCs67fm5c1dlmk3M1pMfJA3tjrXoXLYCKZeTS1x/rDJqfk3e1+NSU+ZBDhM
 MoULuUDgJfb5fgrE1Dy5Cm3gDVQkL0NaN+ysn75ePhktMuRq9DyzWnAoJRlUAuNyCx
 PXH+Kl7/E161kUuDP6HgDba6XBOnFa5DQ99WhRzE=
Message-ID: <e39c48a3-6e4e-41ea-9fe1-6b8c4b3ff36e@arm.com>
Date: Fri, 5 Jun 2026 11:29:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drm/panfrost: Check another bo field for cache
 option query
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
 Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-1-57c6bd4c1655@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260604-claude-fixes-v2-1-57c6bd4c1655@collabora.com>
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

On 04/06/2026 18:35, Adrián Larumbe wrote:
> When querying the properties of a BO, whether it was created in
> Writeback caching mode for userspace mappings, is recorded in a Panfrost
> BO's wb_mmap field.
> 
> Reported-by: Claude <noreply@anthropic.com>
> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: 62eedf1ccba5 ("drm/panfrost: Add flag to map GEM object Write-Back Cacheable")

This is a subtle change in uABI because bo->base.map_wc reflects the
actual properties of the buffer. So on a coherent device this will
change. But it does match the intention/documentation of the ioctl
(returning the creation flags), and I don't think user space could have
been usefully relying on the current behaviour.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 3d0bdba2a474..cb8e5015847f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -659,7 +659,7 @@ static int panfrost_ioctl_query_bo_info(struct drm_device *dev, void *data,
>  		if (bo->is_heap)
>  			args->create_flags |= PANFROST_BO_HEAP;
>  
> -		if (!bo->base.map_wc)
> +		if (bo->wb_mmap)
>  			args->create_flags |= PANFROST_BO_WB_MMAP;
>  	}
>  
> 

