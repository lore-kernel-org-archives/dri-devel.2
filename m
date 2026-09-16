Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06539C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BDAD10E009;
	Wed, 16 Sep 2026 12:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="VFNl5IAt";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A2BC910E009
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 12:47:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 771BC176A
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 05:47:22 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 D23F43F7B4
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789562846; bh=2H1OdElD4RQ4dUDiQHkKrw1VjD4zYa3IPGAdrvABJxE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VFNl5IAt3k+F1sA3C8hH6A17Vr31omjoETVDLA6YWcx1EfZOT/wiEa/bW2UMpsp4p
 EYN79qSZI8UCp+dzoIecpIJ847uURdSVImCxUQ84UUARH6S7d2VEKyRY1COd+V7CqX
 T2/oZd5eBSdM2c1Ut4YDmfG3UbiZbw2Pj5nLLAdI=
Date: Wed, 16 Sep 2026 13:47:22 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/mali-dp: Fix runtime PM leak in
 malidp_crtc_atomic_enable()
Message-ID: <aqqP2ruyA6jSsIIy@e142607>
References: <20260916102112.2018372-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916102112.2018372-1-vulab@iscas.ac.cn>
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

On Wed, Sep 16, 2026 at 10:21:12AM +0000, Wentao Liang wrote:
> malidp_crtc_atomic_enable() resumes the device with
> pm_runtime_get_sync() and returns early when the resume fails.  The
> runtime PM usage count is incremented by pm_runtime_get_sync() even
> when the resume fails, so returning without dropping the reference
> leaks it and, once the error has been hit, prevents the device from
> ever suspending again.
> 
> Drop the runtime PM reference with pm_runtime_put_noidle() on the
> resume failure path before returning.
> 
> Fixes: 85f6421889ec ("drm: mali-dp: Enable power management for the device.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

I will push the patch to drm-misc-fixes.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_crtc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index 18e6157b1047..a2c6e536c55d 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -56,6 +56,7 @@ static void malidp_crtc_atomic_enable(struct drm_crtc *crtc,
>  
>  	if (err < 0) {
>  		DRM_DEBUG_DRIVER("Failed to enable runtime power management: %d\n", err);
> +		pm_runtime_put_noidle(crtc->dev->dev);
>  		return;
>  	}
>  
> -- 
> 2.34.1
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
