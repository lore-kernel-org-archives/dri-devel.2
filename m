Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913C6F8E486
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE3E210E240;
	Thu, 16 Apr 2026 22:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="lBpjrR8t";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C848110E0D0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 22:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=xOejhf2JTlBUOqRfxdf0lvXpMeOShPqCZFMc+hUVVlA=; b=lBpjrR8tWIGchgX60Dx+3/WuGd
 z6WoGjbPom/arFHO7QAxC3NtAM+p+0nay1/wyz4eyi85ig4g2oEhSE1rottWgaivgQ/bkLIG6vkz2
 56LUcBaN0ACOx1WIiF5PuvDIFo6+4ab8Yaq9SERLeQ9u3Lp4eoPmY/pX5SOaj1FQrt1VP+p3AsgBJ
 eeVeNGH4LrGBtIJbfeC+bITlD1zcbt4Ds5WVPLlll9p3lDcl+DR0/nmWkr8X9R6rqhBvugLKBKnGM
 ZEMQcF9vUyFTaJjSpKBrVx7BCSUbMW6TraI4EZvU2WAVwHaHEDizW5hsy0+Nb3BHbv0tDYuSLgAmg
 IIC67+Sw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1wDVS0-000000039Xq-1DLf; Thu, 16 Apr 2026 22:44:44 +0000
Message-ID: <e2b309c3-c287-43cf-9ee3-6d092086924b@infradead.org>
Date: Thu, 16 Apr 2026 15:44:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpu: ipu-v3: clean up kernel-doc warnings
To: dri-devel@lists.freedesktop.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
References: <20260219215211.459108-1-rdunlap@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260219215211.459108-1-rdunlap@infradead.org>
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

ping.

On 2/19/26 1:52 PM, Randy Dunlap wrote:
> Correct all kernel-doc warnings:
> - fix a typedef kernel-doc comment
> - mark a list_head as private
> - use Returns: for function return values
> 
> Warning: include/video/imx-ipu-image-convert.h:31 struct member 'list' not
>  described in 'ipu_image_convert_run'
> Warning: include/video/imx-ipu-image-convert.h:40 function parameter
>  'ipu_image_convert_cb_t' not described in 'void'
> Warning: include/video/imx-ipu-image-convert.h:40 expecting prototype for
>  ipu_image_convert_cb_t(). Prototype was for void() instead
> Warning: include/video/imx-ipu-image-convert.h:66 No description found for
>  return value of 'ipu_image_convert_verify'
> Warning: include/video/imx-ipu-image-convert.h:90 No description found for
>  return value of 'ipu_image_convert_prepare'
> Warning: include/video/imx-ipu-image-convert.h:125 No description found for
>  return value of 'ipu_image_convert_queue'
> Warning: include/video/imx-ipu-image-convert.h:163 No description found for
>  return value of 'ipu_image_convert'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> v2: add Reviewed-by, update Cc: list, rebase, resend
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> 
>  include/video/imx-ipu-image-convert.h |   16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> --- linux-next-20260218.orig/include/video/imx-ipu-image-convert.h
> +++ linux-next-20260218/include/video/imx-ipu-image-convert.h
> @@ -27,12 +27,13 @@ struct ipu_image_convert_run {
>  
>  	int status;
>  
> +	/* private: */
>  	/* internal to image converter, callers don't touch */
>  	struct list_head list;
>  };
>  
>  /**
> - * ipu_image_convert_cb_t - conversion callback function prototype
> + * typedef ipu_image_convert_cb_t - conversion callback function prototype
>   *
>   * @run:	the completed conversion run pointer
>   * @ctx:	a private context pointer for the callback
> @@ -60,7 +61,7 @@ void ipu_image_convert_adjust(struct ipu
>   * @out:	output image format
>   * @rot_mode:	rotation mode
>   *
> - * Returns 0 if the formats and rotation mode meet IPU restrictions,
> + * Returns: 0 if the formats and rotation mode meet IPU restrictions,
>   * -EINVAL otherwise.
>   */
>  int ipu_image_convert_verify(struct ipu_image *in, struct ipu_image *out,
> @@ -77,11 +78,11 @@ int ipu_image_convert_verify(struct ipu_
>   * @complete:	run completion callback
>   * @complete_context:	a context pointer for the completion callback
>   *
> - * Returns an opaque conversion context pointer on success, error pointer
> + * In V4L2, drivers should call ipu_image_convert_prepare() at streamon.
> + *
> + * Returns: an opaque conversion context pointer on success, error pointer
>   * on failure. The input/output formats and rotation mode must already meet
>   * IPU retrictions.
> - *
> - * In V4L2, drivers should call ipu_image_convert_prepare() at streamon.
>   */
>  struct ipu_image_convert_ctx *
>  ipu_image_convert_prepare(struct ipu_soc *ipu, enum ipu_ic_task ic_task,
> @@ -122,6 +123,8 @@ void ipu_image_convert_unprepare(struct
>   * In V4L2, drivers should call ipu_image_convert_queue() while
>   * streaming to queue the conversion of a received input buffer.
>   * For example mem2mem devices this would be called in .device_run.
> + *
> + * Returns: 0 on success or -errno on error.
>   */
>  int ipu_image_convert_queue(struct ipu_image_convert_run *run);
>  
> @@ -155,6 +158,9 @@ void ipu_image_convert_abort(struct ipu_
>   * On successful return the caller can queue more run requests if needed, using
>   * the prepared context in run->ctx. The caller is responsible for unpreparing
>   * the context when no more conversion requests are needed.
> + *
> + * Returns: pointer to the created &struct ipu_image_convert_run that has
> + * been queued on success; an ERR_PTR(errno) on error.
>   */
>  struct ipu_image_convert_run *
>  ipu_image_convert(struct ipu_soc *ipu, enum ipu_ic_task ic_task,

-- 
~Randy

