Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41AD606A320
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KDfpvWtV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B673112A86;
	Fri, 23 Oct 2026 10:00:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8B1DB112A6F
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:59:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7EAE1692
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 02:59:49 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 E55963F7B4
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792749593; bh=AdJpYJ1hfByJ4QHJIAC72tRES7U+BgqdvCBCxNPxJ2g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KDfpvWtVIOXmbBQmMFz7fGvKb/uzYwzGNKQb5+1iyWTpzfp5YD4aqNitbjRH1p5eV
 LCbi6pfK+xqs19nhD9HAvnB7glgpClTYF3p7mnZUmb72AL/0aHZ0EW3GZHkggzU1lm
 8NDbFZSVFMvciJoCqEIpHyzZLy0hUyIJJRIzLStE=
Date: Fri, 23 Oct 2026 10:59:47 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Avi Shif <avi.shif@arm.com>
Cc: mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, Lisa.wu@arm.com,
 rosen.zhelev@arm.com
Subject: Re: [PATCH] drm/fourcc: Add MSB-aligned 12- and 14-bit formats
Message-ID: <atswE57d6oulEE7W@e142607>
References: <20261021150348.1634126-1-avi.shif@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261021150348.1634126-1-avi.shif@arm.com>
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

On Wed, Oct 21, 2026 at 06:03:48PM +0300, Avi Shif wrote:
> Define padded 12- and 14-bit RGB formats and add their format
> metadata. Each component occupies a 16-bit word, with the unused
> bits in the least significant positions.
> 
> Add P212, P014 and P214 for two-plane YCbCr buffers, including
> their plane sizes and chroma subsampling metadata.
> 
> Due to collisions with existing DRM FourCC codes, the codes for
> four-component formats indicate the total number of color bits
> per pixel rather than the number of bits per component
> (e.g., '3', '6' and '4', '2').
> 
> Signed-off-by: Avi Shif <avi.shif@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/drm_fourcc.c  | 23 ++++++++++++++++++++++-
>  include/uapi/drm/drm_fourcc.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 60cd02b7ea64..608e2d411dfe 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -255,6 +255,16 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		{ .format = DRM_FORMAT_ARGB16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_ABGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_AXBXGXRX106106106106, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +		{ .format = DRM_FORMAT_RX124,		.depth = 0, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> +		{ .format = DRM_FORMAT_GXRX124124,	.depth = 0, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> +		{ .format = DRM_FORMAT_AXBXGXRX124124124124, .depth = 0,
> +		  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1,
> +		  .has_alpha = true },
> +		{ .format = DRM_FORMAT_RX142,		.depth = 0, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> +		{ .format = DRM_FORMAT_GXRX142142,	.depth = 0, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> +		{ .format = DRM_FORMAT_AXBXGXRX142142142142, .depth = 0,
> +		  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1,
> +		  .has_alpha = true },
>  		{ .format = DRM_FORMAT_XRGB16161616,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_XBGR16161616,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_ARGB16161616,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> @@ -316,7 +326,10 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		  .hsub = 2, .vsub = 2, .is_yuv = true},
>  		{ .format = DRM_FORMAT_P012,		.depth = 0,  .num_planes = 2,
>  		  .char_per_block = { 2, 4, 0 }, .block_w = { 1, 1, 0 }, .block_h = { 1, 1, 0 },
> -		   .hsub = 2, .vsub = 2, .is_yuv = true},
> +		  .hsub = 2, .vsub = 2, .is_yuv = true},
> +		{ .format = DRM_FORMAT_P014,		.depth = 0,  .num_planes = 2,
> +		  .char_per_block = { 2, 4, 0 }, .block_w = { 1, 1, 0 }, .block_h = { 1, 1, 0 },
> +		  .hsub = 2, .vsub = 2, .is_yuv = true},
>  		{ .format = DRM_FORMAT_P016,		.depth = 0,  .num_planes = 2,
>  		  .char_per_block = { 2, 4, 0 }, .block_w = { 1, 1, 0 }, .block_h = { 1, 1, 0 },
>  		  .hsub = 2, .vsub = 2, .is_yuv = true},
> @@ -324,6 +337,14 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
>  		  .block_w = { 1, 1, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
>  		  .vsub = 1, .is_yuv = true },
> +		{ .format = DRM_FORMAT_P212,		.depth = 0,
> +		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
> +		  .block_w = { 1, 1, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
> +		  .vsub = 1, .is_yuv = true },
> +		{ .format = DRM_FORMAT_P214,		.depth = 0,
> +		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
> +		  .block_w = { 1, 1, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
> +		  .vsub = 1, .is_yuv = true },
>  		{ .format = DRM_FORMAT_VUY101010,	.depth = 0,
>  		  .num_planes = 1, .cpp = { 0, 0, 0 }, .hsub = 1, .vsub = 1,
>  		  .is_yuv = true },
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 0bb049f91524..efd8bc81e91a 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -234,6 +234,16 @@ extern "C" {
>   */
>  #define DRM_FORMAT_AXBXGXRX106106106106 fourcc_code('A', 'B', '1', '0') /* [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian */
>  
> +/* 12-bit components in 16-bit words, with 4 LSBs unused per component */
> +#define DRM_FORMAT_RX124	fourcc_code('R', '0', '1', '2') /* [15:0] R:x 12:4 little endian */
> +#define DRM_FORMAT_GXRX124124	fourcc_code('G', 'R', '1', '2') /* [31:0] G:x:R:x 12:4:12:4 little endian */
> +#define DRM_FORMAT_AXBXGXRX124124124124 fourcc_code('A', 'B', '3', '6') /* [63:0] A:x:B:x:G:x:R:x 12:4:12:4:12:4:12:4 little endian */
> +
> +/* 14-bit components in 16-bit words, with 2 LSBs unused per component */
> +#define DRM_FORMAT_RX142	fourcc_code('R', '0', '1', '4') /* [15:0] R:x 14:2 little endian */
> +#define DRM_FORMAT_GXRX142142	fourcc_code('G', 'R', '1', '4') /* [31:0] G:x:R:x 14:2:14:2 little endian */
> +#define DRM_FORMAT_AXBXGXRX142142142142 fourcc_code('A', 'B', '4', '2') /* [63:0] A:x:B:x:G:x:R:x 14:2:14:2:14:2:14:2 little endian */
> +
>  /* packed YCbCr */
>  #define DRM_FORMAT_YUYV		fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
>  #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
> @@ -334,6 +344,20 @@ extern "C" {
>   */
>  #define DRM_FORMAT_P210		fourcc_code('P', '2', '1', '0') /* 2x1 subsampled Cr:Cb plane, 10 bit per channel */
>  
> +/*
> + * 2 plane YCbCr MSB aligned
> + * index 0 = Y plane, [15:0] Y:x [12:4] little endian
> + * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [12:4:12:4] little endian
> + */
> +#define DRM_FORMAT_P212		fourcc_code('P', '2', '1', '2') /* 2x1 subsampled Cr:Cb plane 12 bits per channel */
> +
> +/*
> + * 2 plane YCbCr MSB aligned
> + * index 0 = Y plane, [15:0] Y:x [14:2] little endian
> + * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [14:2:14:2] little endian
> + */
> +#define DRM_FORMAT_P214		fourcc_code('P', '2', '1', '4') /* 2x1 subsampled Cr:Cb plane 14 bits per channel */
> +
>  /*
>   * 2 plane YCbCr MSB aligned
>   * index 0 = Y plane, [15:0] Y:x [10:6] little endian
> @@ -348,6 +372,13 @@ extern "C" {
>   */
>  #define DRM_FORMAT_P012		fourcc_code('P', '0', '1', '2') /* 2x2 subsampled Cr:Cb plane 12 bits per channel */
>  
> +/*
> + * 2 plane YCbCr MSB aligned
> + * index 0 = Y plane, [15:0] Y:x [14:2] little endian
> + * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [14:2:14:2] little endian
> + */
> +#define DRM_FORMAT_P014		fourcc_code('P', '0', '1', '4') /* 2x2 subsampled Cr:Cb plane 14 bits per channel */
> +
>  /*
>   * 2 plane YCbCr MSB aligned
>   * index 0 = Y plane, [15:0] Y little endian
> -- 
> 2.55.0
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
