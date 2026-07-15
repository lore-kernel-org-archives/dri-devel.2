Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DAAC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A8810F025;
	Wed, 15 Jul 2026 12:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="JrootmzO";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E865E10F023
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:15:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E9462F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 05:15:50 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 3EA7F3F7B4
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 05:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784117754; bh=vXG343RvxNMvT1nDir7w8C4UE4dEAOD/jXueka6+NUA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JrootmzOwW/+m5CfCr01lCYyuwUGifIP0wkd761mVZ01+LfBmS8ehVpYdhCx8SSw6
 SmRtiMDZrLofXqjSvxpsUbUrYpE2JBDI8wUpO9I5K+bZ25cvt7Iqhm3EMcrRXabzKT
 TWNJR/MQ/HcXis5Zf60qsk+wXA6hswdQLMqTc9aA=
Date: Wed, 15 Jul 2026 13:15:42 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Check debugfs GEM lock initialization
Message-ID: <ald57k0t7Sl6Pa7d@e142607>
References: <20260713082912.321021-1-lilinmao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713082912.321021-1-lilinmao@kylinos.cn>
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

On Mon, Jul 13, 2026 at 04:29:12PM +0800, Linmao Li wrote:
> drmm_mutex_init() can fail while registering the managed cleanup action.
> When that happens, drmm_add_action_or_reset() destroys the mutex before
> returning the error. Continuing initialization would therefore leave the
> debugfs GEM object list with an unusable lock.
> 
> Propagate the error as is already done for the other managed mutexes in
> panthor_device_init().
> 
> Fixes: a3707f53eb3f ("drm/panthor: show device-wide list of DRM GEM objects over DebugFS")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 0b25abebb803..9687c59de350 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -182,7 +182,10 @@ int panthor_device_init(struct panthor_device *ptdev)
>  		return ret;
>  
>  #ifdef CONFIG_DEBUG_FS
> -	drmm_mutex_init(&ptdev->base, &ptdev->gems.lock);
> +	ret = drmm_mutex_init(&ptdev->base, &ptdev->gems.lock);
> +	if (ret)
> +		return ret;
> +
>  	INIT_LIST_HEAD(&ptdev->gems.node);
>  #endif
>  
> -- 
> 2.25.1
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
