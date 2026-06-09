Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4420BCD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827CC10E2F0;
	Tue,  9 Jun 2026 15:37:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="A1XpYIdA";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE66A10E2F0
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781019454; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fI0yBP3pAYKmtR7ud7ICvDeWH7gBFZOgVuZWUH7eFJM3fRJh6Cajbmfw+0r5Sh80VxSyVWLa2RpJw/b30FiomBFUt7Ci0//sIoSVhsEOGIZbGbKBVr1mVAyMFzM0OSLt0YPXjbU1d2liQFLSC9EBWxim897Znsgya4WsfySpbXA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781019454;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QcTwtzLbEmEhj0I8C/P0JRBhexBT7pcjpJ4mpHS8vpQ=; 
 b=DgfB7M0X/dPaVY7rul0AGNf/0W805wSzCX4OZ1IsKDP7cy+eAqsBk+tAFce3qFbSkUhVxznCWrc46GZwQxbkVTKhn9+3g45qbSVwQOE3W7ftcRH0GkoBWc47xIncN1TAn7jiY2LiB6gkb8UuTXXQRT5nZaJ0KfMEP817TxUVAyI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781019454; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=QcTwtzLbEmEhj0I8C/P0JRBhexBT7pcjpJ4mpHS8vpQ=;
 b=A1XpYIdArGqgH2AbINoYYBh5psMNMkG+fp+OuEzttOKBV63d3UQIqETF6gyngUpi
 6EcC81SGoAwtch+Lm0u8/r5GBMbAdX/UpYZs61jUE9NHG4Sa5kkGulw8AZpcTO43JwW
 bdG6Vz2OFrd9tWuuuHYNQ9gL+ulUb2DSlIKmzD1Q=
Received: by mx.zohomail.com with SMTPS id 1781019452386825.7386834372543;
 Tue, 9 Jun 2026 08:37:32 -0700 (PDT)
Date: Tue, 9 Jun 2026 16:37:28 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: fix runtime PM leak on remove
Message-ID: <aigyYE6-GqVfPU1b@sobremesa>
References: <20260609073407.5-1-ruoyuw560@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609073407.5-1-ruoyuw560@gmail.com>
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

Hi Ruoyu, thanks for the patch.

A similar fix is being discussed together with a bunch of other patches at:
https://lore.kernel.org/dri-devel/20260604-claude-fixes-v2-6-57c6bd4c1655@collabora.com/

On 09.06.2026 15:34, Ruoyu Wang wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even when it
> returns an error. panfrost_remove() uses it to keep the GPU active while
> runtime PM is disabled and the device is finalized, but the usage counter
> is not dropped afterwards.
> 
> Balance the get with pm_runtime_put_noidle() after disabling runtime PM.
> This drops the extra usage count without requesting a runtime suspend,
> preserving the existing teardown sequence that avoids suspending after
> panfrost_device_fini().
> 
> Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 074c0995ddc26..d78ea7d4d099e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1027,6 +1027,7 @@ static void panfrost_remove(struct platform_device *pdev)
>  
>  	pm_runtime_get_sync(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
>  }
> -- 
> 2.51.0


Adrian Larumbe
