Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D69BC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D7EC10E589;
	Tue, 28 Jul 2026 14:06:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="vr7OFN72";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id C5FDE10E589
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:06:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 147361650
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:06:45 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 DC0E53F66F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785247609; bh=oh/tz0oaXwZk1r+xJ7nKsqhdVTLA4/q103YvNyJqQlk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vr7OFN72RWiwQ6Qe91tcWum2bF6WmGcD0sObSMiL3215uYLhj+GT/GmxPLfMIuC/G
 jl3rZoCSshV4AQ+VymC+vjW/7fbcLvbIPZqRU4QgJchCaXcAWwknfKoUVjbK+mwtvp
 GC7/ZiQM6S4Pec1ZUoe8J3n7PD6KLVHHSMgjJk3c=
Date: Tue, 28 Jul 2026 15:06:47 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Raveendra Talabattula <raveendra.talabattula@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 james.qian.wang@arm.com, vincenzo.frascino@arm.com,
 nayden.kanchev@arm.com, charvi.mehta@arm.com,
 Asad Malik <asad.malik@arm.com>
Subject: Re: [PATCH 1/2] drm/komeda: Fix bits parsing of GLB_CORE_ID
Message-ID: <ami3d4pvkRrOtJoZ@e142607>
References: <20260721135227.439413-1-raveendra.talabattula@arm.com>
 <20260721135227.439413-2-raveendra.talabattula@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721135227.439413-2-raveendra.talabattula@arm.com>
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

On Tue, Jul 21, 2026 at 02:52:26PM +0100, Raveendra Talabattula wrote:
> GLB_CORE_ID contains the product and version information returned by the
> hardware. The current macros parses VERSION_MINOR as a 4-bit field and
> VERSION_STATUS as an 8-bit field, which does not match the register
> layout. As a result, the driver reports an incorrect version number.
> 
> Fix the parsing macros to match the hardware specification:
> - VERSION_MINOR is 8 bits at [11:4]
> - VERSION_STATUS is 4 bits at [3:0]
> 
> Fixes: bd628c1bed79 ("drm/komeda: komeda_dev/pipeline/component definition and initialzation")
> Signed-off-by: Asad Malik <asad.malik@arm.com>
> Signed-off-by: Raveendra Talabattula <raveendra.talabattula@arm.com>
> ---
>  drivers/gpu/drm/arm/display/include/malidp_product.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers/gpu/drm/arm/display/include/malidp_product.h
> index 6f954bcdf40e..bf63c4e05c3e 100644
> --- a/drivers/gpu/drm/arm/display/include/malidp_product.h
> +++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
> @@ -8,14 +8,18 @@
>  #define _MALIDP_PRODUCT_H_
>  
>  /* Product identification */
> +/* GLB_CORE_ID fields as per HW specification:
> + * MINOR is 8 bits ([11:4]) and STATUS is 4 bits ([3:0]).
> + * Update masks/shifts accordingly.
> + */
>  #define MALIDP_CORE_ID(__product, __major, __minor, __status) \
>  	((((__product) & 0xFFFF) << 16) | (((__major) & 0xF) << 12) | \
> -	(((__minor) & 0xF) << 8) | ((__status) & 0xFF))
> +	(((__minor) & 0xFF) << 4) | ((__status) & 0xF))
>  
> -#define MALIDP_CORE_ID_PRODUCT_ID(__core_id) ((__u32)(__core_id) >> 16)
> +#define MALIDP_CORE_ID_PRODUCT_ID(__core_id) (((__u32)(__core_id) >> 16) & 0xFFFF)

This change is redundant.

>  #define MALIDP_CORE_ID_MAJOR(__core_id)      (((__u32)(__core_id) >> 12) & 0xF)
> -#define MALIDP_CORE_ID_MINOR(__core_id)      (((__u32)(__core_id) >> 8) & 0xF)
> -#define MALIDP_CORE_ID_STATUS(__core_id)     (((__u32)(__core_id)) & 0xFF)
> +#define MALIDP_CORE_ID_MINOR(__core_id)      (((__u32)(__core_id) >>  4) & 0xFF)
> +#define MALIDP_CORE_ID_STATUS(__core_id)     (((__u32)(__core_id) >>  0) & 0xF)

Shift by zero is unnecessary. Simple bitwise AND is enough.


Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

>  
>  /* Mali-display product IDs */
>  #define MALIDP_D71_PRODUCT_ID	0x0071
> -- 
> 2.43.0
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
