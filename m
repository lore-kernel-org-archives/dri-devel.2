Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EC7C5DF86
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B4110EBE1;
	Tue, 18 Aug 2026 15:55:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="Ui5KdUDl";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798B710EBDD;
 Tue, 18 Aug 2026 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=Oib1sAGemzHmu6ROtRkEHyhCtwDTicVNKskycatCaao=; b=Ui5KdUDlipNO9Vm4nINkg/+v4R
 bOUqu7BxrFpPjJPyyxL5/SQNc4/JySqtBdMrb5CyEz/IRILpW8+YnFuGzsaYbvWJv+9e0YtT8uwx/
 eE0eXe6fRPjm1sfCVSmOReeGwtH7/zEHlNxdnu5tpHNRyMiy4cejksDu81kvbeMEFRTaItbMt/IGi
 Q61CWpoF2IThZoi159FSHVf/TCVp1AzMzc9ZSRaQVSMkGFqvkSEm1dUtgG8Qvp88FNz5jkcBhNEOs
 ACjeQ2XWgqHevHSOffjhKrvnRBjt4Y+4cNGXzMxdf7NzZpsvk2bac1B5a/UMTuKt7keKswSiklY2c
 JG0mN6zA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wwM9g-00000008JC7-1PPo; Tue, 18 Aug 2026 15:55:12 +0000
Message-ID: <916c4bd5-c73f-466e-8e9b-aee9d4d7d742@infradead.org>
Date: Tue, 18 Aug 2026 08:55:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] drm/panic: Move panic display code into helper
 library
To: Thomas Zimmermann <tzimmermann@suse.de>, jfalempe@redhat.com,
 javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-12-tzimmermann@suse.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260818125012.468092-12-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

On 8/18/26 5:28 AM, Thomas Zimmermann wrote:
>  M:	Hans de Goede <hansg@kernel.org>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 323422861e8f..cdfd72d9a9c5 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -45,6 +45,7 @@ config DRM_MIPI_DSI
>  config DRM_KMS_HELPER
>  	tristate
>  	depends on DRM
> +	select DRM_PANIC_HELPER if DRM_PANIC

but DRM_PANIC_HELPER depends on DRM_TTM so
DRM_KMS_HELPER should also depend on DRM_TTM. Otherwise:

WARNING: unmet direct dependencies detected for DRM_PANIC_HELPER
  Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && DRM_TTM [=n]
  Selected by [y]:
  - DRM_KMS_HELPER [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_PANIC [=y]


>  	select FB_CORE if DRM_FBDEV_EMULATION
>  	help
>  	  CRTC helpers for KMS drivers.
> @@ -130,6 +131,10 @@ config DRM_PANIC_SCREEN_QR_VERSION
>  	  Smaller QR code are easier to read, but will contain less debugging
>  	  data. Default is 40.
>  
> +config DRM_PANIC_HELPER
> +	bool
> +	depends on DRM_TTM
> +
>  config DRM_RAS
>  	bool "DRM RAS support"
>  	depends on DRM

-- 
~Randy

