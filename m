Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA387C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0568810E586;
	Tue, 28 Jul 2026 14:20:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="lqRrFFDq";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 97B0110E586
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:20:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1CA41650
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:20:00 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 C488C3F66F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785248405; bh=sbnPX/wAJLFWJIwEoUOuGu0Ap9icBCwur3M9doPQ6sU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lqRrFFDqjEmKuG1yvM9UlfckKuUbXbQ0Ebiccx0z8A1n6l8xilK/LsNYhFMbQADRJ
 GXwQU8ZpHQHiU2+MaweDPZyoQMfgjKpfI0G1t9kcOE/TqDGxst0P+sIG5BHZFebQ3a
 OUQUmlxQ9rVk5qq5KTdFdmU9e5Dzi3s/hcI4LpSQ=
Date: Tue, 28 Jul 2026 15:20:03 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Raveendra Talabattula <raveendra.talabattula@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 james.qian.wang@arm.com, vincenzo.frascino@arm.com,
 nayden.kanchev@arm.com, charvi.mehta@arm.com,
 Asad Malik <asad.malik@arm.com>
Subject: Re: [PATCH 2/2] drm/komeda: Initialize encoder possible_clones
Message-ID: <ami6kzBg7zGi4WLs@e142607>
References: <20260721135227.439413-1-raveendra.talabattula@arm.com>
 <20260721135227.439413-3-raveendra.talabattula@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721135227.439413-3-raveendra.talabattula@arm.com>
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

On Tue, Jul 21, 2026 at 02:52:27PM +0100, Raveendra Talabattula wrote:
> Komeda leaves encoder->possible_clones unset, so it stays at 0 for every
> encoder. When userspace asks for writeback, the DRM atomic checks

Can you tell me more about this? What are you trying to do with the writeback?

Please note that there is a patch series that changes the way encoders get
created for the writeback connectors, so that can potentially affect your
use case.

> reject the configuration because no encoder is marked as clone-compatible,
> leading to errors such as:
> 
> 	crtc96 failed valid clone check for mask 0x5

The error you're seeing here is due to the encoder having a non-zero "possible_clones"
which shows there is an error in your setup earlier and nothing to do with komeda.

> 
> Komeda does not impose per-encoder clone restrictions, [...]

Komeda doesn't care about the encoders at all as it is meant to be agnostic
to whatever encoder is used.

> [...] so initialize
> possible_clones for all registered encoders to the full encoder mask
> after encoder creation. This fixes writeback validation.
> 
> Signed-off-by: Asad Malik <asad.malik@arm.com>
> Signed-off-by: Raveendra Talabattula <raveendra.talabattula@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/komeda_kms.c   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 6ed504099188..0dcc8c05e86b 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -276,7 +276,10 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
>  {
>  	struct komeda_kms_dev *kms;
>  	struct drm_device *drm;
> +	struct drm_encoder *encoder;
>  	int err;
> +	/* Bitmap of all encoders, assigned to each encoder's possible_clones. */
> +	u32 clone_mask = 0;
>  
>  	kms = devm_drm_dev_alloc(mdev->dev, &komeda_kms_driver,
>  				 struct komeda_kms_dev, base);
> @@ -311,6 +314,23 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
>  
>  	drm_mode_config_reset(drm);
>  
> +	/*
> +	 * Build the full possible_clones mask once. drm_encoder_index()
> +	 * returns the bit position assigned to each encoder and BIT() converts
> +	 * that index into the corresponding mask value.
> +	 *
> +	 * Komeda does not have per-encoder clone restrictions, so every encoder
> +	 * gets the same mask and is advertised as clone-compatible with all
> +	 * other registered encoders.
> +	 */
> +	drm_for_each_encoder(encoder, drm) {
> +		clone_mask |= BIT(drm_encoder_index(encoder));
> +	}
> +
> +	drm_for_each_encoder(encoder, drm) {
> +		encoder->possible_clones = clone_mask;
> +	}

You're modifying all the encoders in the system here which is not the right thing.

Best regards,
Liviu

> +
>  	err = devm_request_irq(drm->dev, mdev->irq,
>  			       komeda_kms_irq_handler, IRQF_SHARED,
>  			       drm->driver->name, drm);
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
