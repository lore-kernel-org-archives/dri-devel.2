Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5431CC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 23:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A292310E26E;
	Thu, 27 Aug 2026 23:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e4QYYy+p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E77510E26E;
 Thu, 27 Aug 2026 23:15:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D0FBF40B9B;
 Thu, 27 Aug 2026 23:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175201F000E9;
 Thu, 27 Aug 2026 23:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787872500;
 bh=FSiachqhOyDPNWrlLQoqGt+BCbYARmL495v902rUypk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=e4QYYy+pO699YsBo/xCNhLC1ICmILsO9BcM1N4gedqewQV850r49t4Syseil45jyn
 IGt3oBOCOMCAH1atWcsgglC1x8MmsjItYgsikvh5YJaa6jcydHbq2j013AnZIHdpGF
 4jiMOsWXaiOixJk2JwTSSuk81d3FCpLPB1hYFieI3f08QMrB7C1hYExYAVSVA8ueP2
 ov0YHYCK8jnIJQhauLsJyAEqu+rt0YGQ6fq9WwL6IwIdfbHYbrZaNCB05NY9b5l1Sh
 URA7O74XHcZYUoUt9e3enHtObZuthdac1P99W3IshK9COQw2iwSmaEFtIMRr+wefrQ
 85vu1YXo9efPQ==
Date: Fri, 28 Aug 2026 01:14:57 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 Krzysztof Karas <krzysztof.karas@intel.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, 
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v3 1/2] drm: Unwind drm device registration upon error
Message-ID: <apC_eePJyeGnVQTG@zenone.zhora.eu>
References: <20260827143447.99553-1-krzysztof.niemiec@intel.com>
 <20260827143447.99553-2-krzysztof.niemiec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827143447.99553-2-krzysztof.niemiec@intel.com>
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

Hi Krzysztof,

...

> Amend the problem by removing debugfs entries and marking
> registered flag as false upon error in drm_dev_register().
> 
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Co-developed-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

I think the right order should be:

Co-developed-by: Krzysztof Karas <krzysztof.karas@intel.com>
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index e51ed959da89..b98e8af6f1c1 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -1140,6 +1140,8 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
>  	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
>  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
>  	drm_minor_unregister(dev, DRM_MINOR_RENDER);
> +	drm_debugfs_dev_fini(dev);

I think sashiko is right here, this should be removed.

> +	dev->registered = false;

dev->registered = false should be set at the very beginning,
maybe something like this:

err_unload:
	dev->registered = false;
	if (dev->driver->unload)
		dev->driver->unload(dev);
	goto err_cleanup;
err_minors:
	dev->registered = false;
err_clenup:
	...

Thanks,
Andi
