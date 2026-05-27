Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77A5CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 14:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B21910E851;
	Wed, 27 May 2026 14:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UkU6uQ35";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A880C10E851
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 14:55:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A94C6054B;
 Wed, 27 May 2026 14:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157F41F00A3D;
 Wed, 27 May 2026 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779893717;
 bh=sY/TVqy3uC7O75twxr1NslKF+o2JmY9Df75dLar6AWc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UkU6uQ35ng8UBJZ2ZxsJaHd3FFGLYpNbmVjkbNN1IUww/fqMggQfqqLQjCW+bWWBI
 unNQFBRXAFbI7NSUnNi95fu0v9OLNFKHRhYKhofp1IvbPgTdlq/w4W0a0vHUadj3hi
 AhsvtWxQnh1PwVeongwstvX7Mn8K/tyR0CLwi0Ls+n80BbkImNVmL0wuO05ZaIiy2r
 a3Hal+d+Tm6Q8ag5vMlglseXueafh7943/ihoZw54VjsOZBk8s7KeN7KcMgwPBToIb
 suHyF2me2ssuBYaooyvyPQu7jaS9Q+UaXKNPY9yZ4TnFdwsXb5/dwxUqsgZumldMj2
 /l9FD0epjRMKw==
Date: Wed, 27 May 2026 15:55:12 +0100
From: Lee Jones <lee@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] drm: atmel-hlcdc: add XLCDC clock bypass support for
 small dividers
Message-ID: <20260527145512.GD671544@google.com>
References: <20260519090135.1188405-1-manikandan.m@microchip.com>
 <20260519090135.1188405-7-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519090135.1188405-7-manikandan.m@microchip.com>
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

On Tue, 19 May 2026, Manikandan Muralidharan wrote:

> Define ATMEL_XLCDC_CLKBYP and set the clock bypass bit on XLCDC
> hardware when the computed divider is less than 2, avoiding an
> invalid divider value. Non-XLCDC hardware retains the existing
> minimum divider clamp of 2.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 7 +++++++
>  include/linux/mfd/atmel-hlcdc.h                | 1 +

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 6da428361c19..f837684654ea 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -87,6 +87,13 @@ static int atmel_hlcdc_crtc_setup_clock(struct atmel_hlcdc_crtc *crtc,
>  
>  	div = DIV_ROUND_CLOSEST(prate, mode_rate);
>  	if (div < 2) {
> +		/* XLCDC: bypass divider when div < 2 */
> +		if (crtc->dc->desc->is_xlcdc) {
> +			*cfg  |= ATMEL_XLCDC_CLKBYP;
> +			*mask |= ATMEL_XLCDC_CLKBYP;
> +			return 0;
> +		}
> +		/* Enforce minimum divider for non-XLCDC */
>  		div = 2;
>  	} else if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK) {
>  		/* The divider ended up too big, try a lower base rate. */
> diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atmel-hlcdc.h
> index 8e86219293b7..1463c7db0e64 100644
> --- a/include/linux/mfd/atmel-hlcdc.h
> +++ b/include/linux/mfd/atmel-hlcdc.h
> @@ -44,6 +44,7 @@
>  #define ATMEL_XLCDC_HEO_UPDATE		BIT(3)
>  
>  #define ATMEL_HLCDC_CLKPOL		BIT(0)
> +#define ATMEL_XLCDC_CLKBYP		BIT(1)
>  #define ATMEL_HLCDC_CLKSEL		BIT(2)
>  #define ATMEL_HLCDC_CLKPWMSEL		BIT(3)
>  #define ATMEL_HLCDC_CGDIS(i)		BIT(8 + (i))
> -- 
> 2.25.1
> 

-- 
Lee Jones
