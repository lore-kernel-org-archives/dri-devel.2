Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91B606A336
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=en2eFRUd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981CB10E64C;
	Mon, 23 Nov 2026 07:52:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529A910E64C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:52:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9403861D5B;
 Mon, 23 Nov 2026 07:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8B61F000C6;
 Mon, 23 Nov 2026 07:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795420347;
 bh=/ak4JXEcaxLe+7GTY2EM46gD3aKECWkUdMVlHN9qWAU=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=en2eFRUdtlQW6ldje8ZlkP4FyNawEEtEifjq2+Aqwy+8kV0CvK9j7OAvO+fVdK1IG
 MWonCPsilBRcHlS3KPwN3O+DWHstQ+kbVzKNlAwqnMRAbtVG5YAbT2HeeGrGXVRDZ4
 1saUxaP5f+al0PSGSyvtVslACTx7GbSTlDbmT506uTUToKE3eVuuWtY7nRoUdeII+J
 VoaZ9wbQ0+t3TT4/dfieZsNDvV/CxdkrZSo1Tl5aV7WTO551uh0kBQVVx9oMW5UK6u
 0+IAKM4A7AcFw0bHWWOXPoD7/cdCaCgEcOsASHR5n5vI4qj9OYRk/Tf0p/HHWKeD5r
 28bdXh/Rr+D1w==
Message-ID: <24b7d337-341b-4bd6-82bd-97347095be2d@kernel.org>
Date: Mon, 23 Nov 2026 08:52:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH] drm/bridge: tda998x: Fix CEC calibration with lazy IRQ
 disable
To: Nhat Tran <nhat.tranminhk2@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Hans Verkuil
 <hverkuil@kernel.org>, Linus Walleij <linusw@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261120150004.64033-1-nhat.tranminhk2@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20261120150004.64033-1-nhat.tranminhk2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/11/2026 16:00, Nhat Tran wrote:
> The CEC oscillator calibration pulses the TDA998x interrupt line low for
> 10ms through the "nxp,calib" GPIO. Before driving the line,
> tda998x_cec_calibration() calls disable_irq() so that gpiolib allows the
> GPIO, which is also used as an interrupt, to be switched to an output.
> 
> gpiolib only allows that once the interrupt is actually disabled at the
> GPIO controller. Since commit a8173820f441 ("gpio: gpiolib: Allow GPIO
> IRQs to lazy disable"), disable_irq() is lazy on GPIO controllers that
> do not implement .irq_disable, such as gpio-omap: the line is not masked
> and gpiolib still considers the interrupt enabled. The direction change
> is refused and the calibration pulse is never generated. On a
> BeagleBone Black this happens on every boot:
> 
>   tda998x 0-0070: found TDA19988
>   gpio-537 (nxp,calib): gpiod_direction_output_nonotify: tried to set a GPIO tied to an IRQ as output
>   tda9950 0-0034: TDA9950 CEC interface, hardware version 3.3
> 
> Set IRQ_DISABLE_UNLAZY for the duration of the calibration so that
> disable_irq() masks the line immediately, and clear it again once the
> interrupt has been re-enabled.
> 
> Tested on a BeagleBone Black without an HDMI sink connected: the error
> is gone, the GPIO is back to an input used as an interrupt afterwards,
> no spurious interrupts are raised, and rebinding tda9950 repeatedly
> reruns the calibration cleanly. CEC communication with a sink was not
> tested.
> 
> Fixes: a8173820f441 ("gpio: gpiolib: Allow GPIO IRQs to lazy disable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nhat Tran <nhat.tranminhk2@gmail.com>

Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Regards,

	Hans

> ---
>  drivers/gpu/drm/bridge/tda998x_drv.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
> index 0b966c9844e7..0815ce283f49 100644
> --- a/drivers/gpu/drm/bridge/tda998x_drv.c
> +++ b/drivers/gpu/drm/bridge/tda998x_drv.c
> @@ -495,8 +495,16 @@ static void tda998x_cec_calibration(struct tda998x_priv *priv)
>  	struct gpio_desc *calib = priv->calib;
>  
>  	mutex_lock(&priv->edid_mutex);
> -	if (priv->hdmi->irq > 0)
> +	if (priv->hdmi->irq > 0) {
> +		/*
> +		 * The pulse is driven on the IRQ line itself, and gpiolib
> +		 * refuses to drive a GPIO whose interrupt is still enabled.
> +		 * Make disable_irq() mask the line right away instead of
> +		 * lazily, so that the GPIO can be switched to an output.
> +		 */
> +		irq_set_status_flags(priv->hdmi->irq, IRQ_DISABLE_UNLAZY);
>  		disable_irq(priv->hdmi->irq);
> +	}
>  	gpiod_direction_output(calib, 1);
>  	tda998x_cec_set_calibration(priv, true);
>  
> @@ -508,8 +516,10 @@ static void tda998x_cec_calibration(struct tda998x_priv *priv)
>  
>  	tda998x_cec_set_calibration(priv, false);
>  	gpiod_direction_input(calib);
> -	if (priv->hdmi->irq > 0)
> +	if (priv->hdmi->irq > 0) {
>  		enable_irq(priv->hdmi->irq);
> +		irq_clear_status_flags(priv->hdmi->irq, IRQ_DISABLE_UNLAZY);
> +	}
>  	mutex_unlock(&priv->edid_mutex);
>  }
>  

