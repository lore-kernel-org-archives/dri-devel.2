Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFA606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgUOXVxE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3FC710FD23;
	Wed, 28 Oct 2026 15:00:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A2A10FD2F
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 14:59:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A37B432DA;
 Wed, 28 Oct 2026 14:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FDD1F01828;
 Wed, 28 Oct 2026 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793199597;
 bh=NSb6a/pDw1kg0BISDKF7FpWlMPPEDSnf/hJXicQJYVw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jgUOXVxES0RtRhBDD5vjPlJx8U4HEZ7aqAILOTNCPBEbA0FgKh+iooXbxMPg1Cq9R
 f3hVu1uOGjh9Ofeeph6srH+EuC+y9sIsXaYCQwPZ5NC7VoEqiyQ0jdQlrogzHZ68X4
 InAkxl/K94Aq+hAu+BKTAO5BsrnPfep3MJFBPxlildgaC/SzVfIaXRdpmyb6j2e6my
 7EoCnJwd7BO9KW5SmD1EMpig8TjfY+FAI3BMMf3mMFLU6ISeDPR9iC5e6p0PkyUbNc
 WUmJrXE+3GL2j/1feyPSiFNmUIAIV3+zy3dIx5FZn9EZ8Rj9AaezMHVZPa+Q+9HGRb
 o1oAR7x1gmj1Q==
Date: Wed, 28 Oct 2026 14:59:53 +0000
From: Lee Jones <lee@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 mfd@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2 1/8] backlight: qcom-wled: fix string detection
 brightness on WLED5
Message-ID: <20261028145953.GD3605912@google.com>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-1-86c05068efc5@oss.qualcomm.com>
 <sashiko-outbox-177041@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-177041@kernel.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] backlight: qcom-wled: wled5_set_brightness() clamps 0 to low_limit on restore

This needs a response.

> --
> 
> commit 1866e6688066844d34f7f3f1d2a0c521bb917107
> Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> backlight: qcom-wled: fix string detection brightness on WLED5
> 
> This commit updates wled_auto_string_detection() to use the per-version
> wled_set_brightness() callback instead of hardcoding wled4_set_brightness(),
> and moves the WLED5 module sync toggle into wled5_set_brightness().
> 
> > diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> > index ca350f320e177..c5243a6d547e5 100644
> > --- a/drivers/video/backlight/qcom-wled.c
> > +++ b/drivers/video/backlight/qcom-wled.c
> 
> [ ... ]
> 
> > @@ -791,7 +783,7 @@ static void wled_auto_string_detection(struct wled *wled)
> >  	}
> >  
> >  	/* Restore brightness */
> > -	rc = wled4_set_brightness(wled, wled->brightness);
> > +	rc = wled->wled_set_brightness(wled, wled->brightness);
> >  	if (rc < 0) {
> >  		dev_err(wled->dev, "Failed to set brightness after auto detection rc=%d\n",
> >  			rc);
> 
> [Severity: Medium]
> When wled_auto_string_detection() runs during probe via
> wled_probe() -> wled5_setup() -> wled_auto_detection_at_init(),
> wled_read_brightness() has not run yet, so wled->brightness is still 0.
> 
> Previously, wled4_set_brightness() only clamped non-zero brightness values:
> 
> 	/* WLED4's lower limit of operation is 0.4% */
> 	if (brightness > 0 && brightness < low_limit)
> 		brightness = low_limit;
> 
> However, wled5_set_brightness() unconditionally clamps brightness == 0 up to
> low_limit (0.1% of max_brightness):
> 
> 	/* WLED5's lower limit is 0.1% */
> 	if (brightness < low_limit)
> 		brightness = low_limit;
> 
> With this change, restoring wled->brightness (0) at the end of
> wled_auto_string_detection() on WLED5 writes and latches low_limit into the
> modulator brightness register before enabling WLED3_CTRL_REG_MOD_EN.
> 
> When wled_probe() subsequently calls wled_read_brightness():
> 
> 	rc = wled_read_brightness(wled);
> 	if (rc < 0)
> 		return rc;
> 
> 	wled->brightness = rc;
> 	...
> 	props.brightness = wled->brightness ?: val;
> 
> will it read back low_limit instead of 0, leaving ovp_irq enabled in
> wled_configure_ovp_irq() and initializing props.brightness to low_limit
> instead of default-brightness?
> 
> Should wled5_set_brightness() check brightness > 0 && brightness < low_limit
> like wled4_set_brightness() does?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com?part=1

-- 
Lee Jones
