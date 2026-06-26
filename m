Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A83ECDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81DDE10F51E;
	Fri, 26 Jun 2026 09:13:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Fe+QSCZR";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D1CD010F51E
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 09:13:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE16B1655
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:13:15 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 3F8733F836
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782465200; bh=mHqoRBqCubvAn4NQxEzT9fZCFvPwJirqUm1aU7D11N4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fe+QSCZRtrjcSuqkp8AZLG6KgVGFxwhlPdvOg+iXmkI7DGnhXPWhrU1ydUCn+sWMM
 HX7tZui56HxMv1FLtjyM/czQv7grE3ktvfmUt47LAGF7VNjOHchZgT9TyeBkJb6Tfj
 X4OSh7ZoxsEFfOrhCX+hQlDBcEOfnbUy4dJVoBss=
Date: Fri, 26 Jun 2026 10:13:09 +0100
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
Subject: Re: [PATCH 02/11] drm/panthor: Keep the reset work disabled until
 everything is initialized
Message-ID: <aj5CpfReNqU_qiBr@e142607>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-2-b67ed973fea6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625-panthor-misc-fixes-v1-2-b67ed973fea6@collabora.com>
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

On Thu, Jun 25, 2026 at 02:40:28PM +0200, Boris Brezillon wrote:
> The reset work will sub-component reset helpers, which might not be
> ready if the reset happens during initialization, leading to NULL
> pointer dereferences or worse.
> 
> Avoid that by keeping the reset work disabled while we're initializing
> those sub-components.
> 
> Fixes: 5fe909cae118 ("drm/panthor: Add the device logical block")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=4
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index bd417d6ae8c0..0b25abebb803 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -207,6 +207,7 @@ int panthor_device_init(struct panthor_device *ptdev)
>  	*dummy_page_virt = 1;
>  
>  	INIT_WORK(&ptdev->reset.work, panthor_device_reset_work);
> +	disable_work(&ptdev->reset.work);
>  	ptdev->reset.wq = alloc_ordered_workqueue("panthor-reset-wq", 0);
>  	if (!ptdev->reset.wq)
>  		return -ENOMEM;
> @@ -285,6 +286,9 @@ int panthor_device_init(struct panthor_device *ptdev)
>  
>  	panthor_gem_init(ptdev);
>  
> +	/* Now that everything is initialized, we can enable the reset work. */
> +	enable_work(&ptdev->reset.work);
> +
>  	/* ~3 frames */
>  	pm_runtime_set_autosuspend_delay(ptdev->base.dev, 50);
>  	pm_runtime_use_autosuspend(ptdev->base.dev);
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
