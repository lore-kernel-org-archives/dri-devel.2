Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF87ACDE002
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ADF010E31A;
	Fri, 26 Jun 2026 12:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="bKsrdYDZ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9F36910E31A
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:42:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F2251F91
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 05:42:48 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 D123D3F905
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782477773; bh=pkJ7hKqsHzdywNID8YI4JJNx0CiKhJYQK75DY9g6CuE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bKsrdYDZjaekRWHuRxEXg0tF4qTYVpqTDApnYGxEQdkZuyMrU2X1x6XQ3cbgg6HA4
 ZyMF9O62ioONqDwzxIMphqueWQQcceGc2Z1bEHubGUvv/nkn+03JNOuaj/UDHti4lS
 8hOmLY56+pSQ4I/59GPkomM/YRUvqoV47QAET7Wg=
Date: Fri, 26 Jun 2026 13:42:42 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] drm/panthor: Fix panthor_pwr_unplug()
Message-ID: <aj5zwiEkeczn0IPs@e142607>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-7-b67ed973fea6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625-panthor-misc-fixes-v1-7-b67ed973fea6@collabora.com>
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

On Thu, Jun 25, 2026 at 02:40:33PM +0200, Boris Brezillon wrote:
> We can't call panthor_pwr_irq_suspend() if the device is suspended,
> or this leads to a hang when the IOMEM region is accessed while the
> clks are disabled. Do what other sub-components do and conditionally
> call panthor_pwr_irq_suspend() if we know the PWR regbank block is
> accessible.
> 
> Fixes: c27787f2b77f ("drm/panthor: Introduce panthor_pwr API and power control framework")
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_pwr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index 7c7f424a1436..090362bd700b 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -453,7 +453,8 @@ void panthor_pwr_unplug(struct panthor_device *ptdev)
>  		return;
>  
>  	/* Make sure the IRQ handler is not running after that point. */
> -	panthor_pwr_irq_suspend(&ptdev->pwr->irq);
> +	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
> +		panthor_pwr_irq_suspend(&ptdev->pwr->irq);
>  
>  	/* Wake-up all waiters. */
>  	spin_lock_irqsave(&ptdev->pwr->reqs_lock, flags);
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
