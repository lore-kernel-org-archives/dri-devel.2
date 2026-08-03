Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E8AC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04EE10E65C;
	Mon,  3 Aug 2026 14:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pFv0Ui8C";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5B11910E65C
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:46:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A761E143D
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 07:46:05 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 786333F632
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785768369; bh=mz6aAeIuV7986MdQORfvb8r3YaWmRBedWi/6Z3TXQdQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pFv0Ui8CUBhngopOSpUuPNeFAkId72R5e/NhyalMJTR8owrs1GWm8VEzCPvX4kx+g
 2oHd9G4HB2NeHd+C5uDp6tF9roOPz7TRIHIIifpVBI7cFklKxSEmru+Uwlvz7iBGZ5
 yrVuByuxeIj5JHNUBwWSnbJCIks8JFZX5C2/IP9Y=
Date: Mon, 3 Aug 2026 15:46:08 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Raveendra Talabattula <raveendra.talabattula@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 james.qian.wang@arm.com, asad.malik@arm.com,
 vincenzo.frascino@arm.com, nayden.kanchev@arm.com, charvi.mehta@arm.com
Subject: Re: [PATCH v2 2/2] drm/komeda: Set display/writeback clone masks
Message-ID: <anCpsHmX-dpM8PFW@e142607>
References: <20260803142122.4127851-1-raveendra.talabattula@arm.com>
 <20260803142122.4127851-3-raveendra.talabattula@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803142122.4127851-3-raveendra.talabattula@arm.com>
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

On Mon, Aug 03, 2026 at 03:21:22PM +0100, Raveendra Talabattula wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Since commit 41b4b11da0215 ("drm: Add valid clones check"),
> all encoders attached to the same CRTC must advertise
> each other through possible_clones.
> 
> Komeda creates one writeback connector per CRTC. Allow the writeback
> encoder to be cloned only with encoders that can drive the same CRTC,
> and update those encoders reciprocally.
> 
> Do this when the writeback connector is created rather than modifying
> every encoder registered with the DRM device from komeda_kms_attach().
> This leaves encoders associated with other CRTCs untouched.

If you don't mind I will drop the paragraph above when I commit the patch
as it makes reference to code that has not been merged so likely
to create confusion. I think the comment in the code is sufficient.

With that,

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Will push this to drm-misc-next in the next couple of days.

Best regards,
Liviu

> 
> Signed-off-by: Asad Malik <asad.malik@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Raveendra Talabattula <raveendra.talabattula@arm.com>
> Signed-off-by: Raveendra Talabattula <raveendra.talabattula@arm.com>
> ---
>  .../arm/display/komeda/komeda_wb_connector.c  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 41cc3e080dc9..4872253a2449 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -143,12 +143,17 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>  	struct komeda_wb_connector *kwb_conn;
>  	struct drm_writeback_connector *wb_conn;
>  	struct drm_display_info *info;
> +	struct drm_encoder *encoder;
> +	struct drm_encoder *wb_encoder;
>  	u32 *formats, n_formats = 0;
> +	u32 crtc_mask;
>  	int err;
>  
>  	if (!kcrtc->master->wb_layer)
>  		return 0;
>  
> +	crtc_mask = drm_crtc_mask(&kcrtc->base);
> +
>  	kwb_conn = kzalloc_obj(*kwb_conn);
>  	if (!kwb_conn)
>  		return -ENOMEM;
> @@ -176,6 +181,34 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>  		return err;
>  	}
>  
> +	wb_encoder = &wb_conn->encoder;
> +
> +	/*
> +	 * The writeback connector is associated with a single CRTC. Make its
> +	 * encoder clone-compatible only with encoders that can drive that CRTC.
> +	 *
> +	 * possible_clones must contain the encoder's own bit whenever it is
> +	 * non-zero. Add both the encoder itself and the writeback encoder when
> +	 * updating the reciprocal clone relationship.
> +	 */
> +	wb_encoder->possible_clones = drm_encoder_mask(wb_encoder);
> +
> +	drm_for_each_encoder(encoder, &kms->base) {
> +		u32 encoder_mask;
> +
> +		if (encoder == wb_encoder)
> +			continue;
> +
> +		if (!(encoder->possible_crtcs & crtc_mask))
> +			continue;
> +
> +		encoder_mask = drm_encoder_mask(encoder);
> +
> +		wb_encoder->possible_clones |= encoder_mask;
> +		encoder->possible_clones |= encoder_mask |
> +					    drm_encoder_mask(wb_encoder);
> +	}
> +
>  	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
>  
>  	info = &kwb_conn->base.base.display_info;
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
