Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33953606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GlFbjFdR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D0F10E6EA;
	Mon,  2 Nov 2026 18:59:03 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846E110E6EA
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 18:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793645931; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=k+k3BxfmINTBv26V4GK90M+bQkHthaUzYFN6eiJ9zfsSgd+btWnYgbdIXKbFM6y+A2r+iEnX4Ddobs/rQWdHM91FEjhBTMR07HV8dE0ojFOneMLzq72okklP9a74dJXYVeaDWA+GXqqb7H/zY30STkoHf/r/t8f9iIkvUCYYRo4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793645931;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5G/MT9AU1YYv+31eCpWvkJ7LR+8cbCi0bWza4l5yhow=; 
 b=CHYZwEnLMtHawOzNr8WKQA6z8PtG53Ud5dUM83zmtdY1qsv4ovPteJnGMMBIPiR13LQHRI565Po7dV4KXkpKOgEuFNcUWYh6grt474Fs1H2WAgkDHIfteEtiAVR7ZDKe8lb/bNJx88oq3u+8cgP6WxFymFnQ65gOJgE9x02t81A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=GlFbjFdRcIs964QhLu3f6OXVJRtFeG+Zgukho7gHBH+WFH+nQCg+jsZWYlwhrL7kLCMAsUjnKJgXdPljL1ig7SvUNXZmj/rpnzrkFwFu5C8Xx61ek91FORfKcsmwMwBuXy9nXTDk0ig+gJTqy/e9Wg1aIMdcDysuu/rU/mRxIAc=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=5G/MT9AU1YYv+31eCpWvkJ7LR+8cbCi0bWza4l5yhow=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793645930423756.5918385363401;
 Mon, 2 Nov 2026 10:58:50 -0800 (PST)
Date: Mon, 2 Nov 2026 18:58:45 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Boris Breyillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: add missing
 pm_runtime_dont_use_autosuspend() calls
Message-ID: <aujdLAyik6MT6TxN@sobremesa>
References: <20260916075051.1353-1-joshua.crofts1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916075051.1353-1-joshua.crofts1@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.627.56
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Joshua, thanks for the patch.

However, a fix for the same issue had been in the making for some time. It's already been upstreamed:
e9672bf9382f ("drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove")

Kind Regards,
Adrian

On 16.09.2026 07:50, Joshua Crofts wrote:
> panfrost_remove() and panfrost_probe() disable PM runtime on teardown or
> failure but don't call the pm_runtime_dont_use_autosuspend() function,
> causing potential resource leaks.
> 
> Add the missing function calls.
> 
> Found using Coccinelle.
> 
> Fixes: 5c0c825ae4c6 ("drm/panfrost: Replace DRM driver allocation method with newer one")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 36cc2e67a308..74e8e5783f9b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1012,6 +1012,7 @@ static int panfrost_probe(struct platform_device *pdev)
>  err_out2:
>  	drm_dev_unregister(&pfdev->base);
>  err_out1:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> @@ -1027,6 +1028,7 @@ static void panfrost_remove(struct platform_device *pdev)
>  	panfrost_gem_shrinker_cleanup(&pfdev->base);
>  
>  	pm_runtime_get_sync(pfdev->base.dev);
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> -- 
> 2.47.3


