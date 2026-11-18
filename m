Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED6606A333
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duYSkf2f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A9910E823;
	Wed, 18 Nov 2026 21:10:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F6410E831
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:10:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 03D29401B4;
 Wed, 18 Nov 2026 21:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E75C1F000C6;
 Wed, 18 Nov 2026 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795036212;
 bh=XigeT5uf/wY83tegE/CRnA1U4KFWVArSIQzQylrRCCA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=duYSkf2f/5AlY4K6FA+L3S5MCBURqDOdhI1NNNLNT3Jpind21LyxvyfMS6abmke6l
 n+dK607PKwm0IQS5a+AWOHDYVXU9c9Sj8QNrUTfVi3N29PWutCO762RjSEQtvZaDYb
 tK/CTTa/JmOaSvxywUiWYkvr6rpUAvYj86ciDCltIq32TmKgoyPOUW8DjcAdDiYnX6
 9lSyZ3/WOR7jG5iWvTV/tZyI4HxQ65y+2nEsBooU3BG4zQigkgywlSQ6b/p6Vs6G1L
 3rfT3meMhWHChi/Bnlra8y80S5Zpyj1perQZdflgZBNGD1wqQ0sd9kJrElccbVypcR
 38B/xLazMpG0g==
Message-ID: <sashiko-outbox-221973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] i2c: omap: add DMA support
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261118205213.88778-5-apokusinski01@gmail.com>
References: <20261118205213.88778-1-apokusinski01@gmail.com>
 <20261118205213.88778-5-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:10:12 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] i2c: omap: DMA wait ordering and cmd_err gating in
  omap_i2c_xfer_msg()
- [Medium] i2c: omap: NULL dereference in omap_i2c_dma_free() on probe
  error
- [Medium] i2c: omap: uninitialized pio_irq_mask and missing DMA cleanup
  on timeout
--

commit 7af8eb0f57b65f48015dfec1a234f795398aca59
Author: Antoni Pokusinski <apokusinski01@gmail.com>

i2c: omap: add DMA support

This commit adds TX and RX DMA transfer support to the OMAP I2C driver for
messages of at least 8 bytes whose length is a multiple of the configured
FIFO threshold.

> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 3f7060d57a869..acff27f3f4385 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
[ ... ]
> @@ -663,8 +837,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  {
>  	struct omap_i2c_dev *omap =3D i2c_get_adapdata(adap);
>  	unsigned long time_left;
> -	u16 w;
> -	int ret;
> +	u16 w, pio_irq_mask;
> +	int ret, use_dma;
> =20
>  	dev_dbg(omap->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
>  		msg->addr, msg->len, msg->flags, stop);
[ ... ]
> @@ -692,6 +874,27 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ada=
p,
>  		reinit_completion(&omap->cmd_complete);
>  	omap->cmd_err =3D 0;
> =20
> +	if (use_dma) {
> +		ret =3D omap_i2c_dma_xfer(omap, msg);
> +		if (ret) {
> +			omap_i2c_reset(omap);
> +			__omap_i2c_init(omap);
> +			return ret;
> +		}
> +
> +		omap_i2c_dma_enable_req(omap);
> +	} else {
> +		pio_irq_mask =3D OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
> +			       ((omap->fifo_size) ? (OMAP_I2C_IE_RDR |
> +						    OMAP_I2C_IE_XDR) : 0);
> +
> +		if (omap->scheme =3D=3D OMAP_I2C_SCHEME_0)
> +			omap_i2c_write_reg(omap, OMAP_I2C_IE_REG,
> +					   omap->iestate | pio_irq_mask);
> +		else
> +			omap_i2c_write_reg(omap, OMAP_I2C_IE_REG, pio_irq_mask);
> +	}
[ ... ]
> @@ -727,6 +930,16 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ada=
p,
>  			if (time_after(jiffies, delay)) {
>  				dev_err(omap->dev, "controller timed out "
>  				"waiting for start condition to finish\n");
> +
> +				if (omap->scheme =3D=3D OMAP_I2C_SCHEME_0)
> +					omap_i2c_write_reg(omap,
> +							   OMAP_I2C_IE_REG,
> +							   omap->iestate);
> +				else
> +					omap_i2c_write_reg(omap,
> +							   OMAP_I2C_IP_V2_IRQENABLE_CLR,
> +							   pio_irq_mask);
> +
>  				return -ETIMEDOUT;
>  			}
>  			cpu_relax();

[Severity: Medium]
Is pio_irq_mask used uninitialized here when use_dma is true?

pio_irq_mask is only assigned in the !use_dma branch, which triggers a
-Wmaybe-uninitialized warning on this timeout path.  If this timeout is
reached during a DMA transfer, returning directly also leaves the DMA
channel active and leaks the DMA mapping and bounce buffer without calling
dmaengine_terminate_sync(), omap_i2c_dma_cleanup() and
omap_i2c_dma_disable_req().

> @@ -742,8 +955,15 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ada=
p,
>  	 * into arbitration and we're currently unable to recover from it.
>  	 */
>  	if (!polling) {
> -		time_left =3D wait_for_completion_timeout(&omap->cmd_complete,
> -							OMAP_I2C_TIMEOUT);
> +		time_left =3D OMAP_I2C_TIMEOUT;
> +
> +		if (use_dma)
> +			time_left =3D wait_for_completion_timeout(&omap->dma->complete,
> +								time_left);
> +
> +		if (time_left && !omap->cmd_err)
> +			time_left =3D wait_for_completion_timeout(&omap->cmd_complete,
> +								time_left);
>  	} else {
>  		do {
>  			omap_i2c_wait(omap);
> @@ -753,7 +973,23 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ada=
p,
>  		time_left =3D !ret;
>  	}
> =20
> -	if (time_left =3D=3D 0) {
> +	if (use_dma) {
> +		if (!time_left || omap->cmd_err)
> +			dmaengine_terminate_sync(omap->dma->chan_using);
> +
> +		omap_i2c_dma_cleanup(omap, time_left && !omap->cmd_err);
> +
> +		omap_i2c_dma_disable_req(omap);
> +	} else {
> +		if (omap->scheme =3D=3D OMAP_I2C_SCHEME_0)
> +			omap_i2c_write_reg(omap, OMAP_I2C_IE_REG,
> +					   omap->iestate);
> +		else
> +			omap_i2c_write_reg(omap, OMAP_I2C_IP_V2_IRQENABLE_CLR,
> +					   pio_irq_mask);
> +	}
> +
> +	if (!time_left && likely(!omap->cmd_err)) {
>  		omap_i2c_reset(omap);
>  		__omap_i2c_init(omap);
>  		return -ETIMEDOUT;

[Severity: High]
Does waiting on omap->dma->complete before omap->cmd_complete stall for
the full OMAP_I2C_TIMEOUT (1 second) whenever a DMA transfer encounters a
NACK or arbitration loss?

When a bus error occurs before all bytes are transferred (for example, on
any RX DMA transfer or multi-burst TX DMA transfer), the controller stops
asserting DMA requests and the IRQ handler signals omap->cmd_complete via
omap_i2c_complete_cmd(), while omap->dma->complete is never signaled.

Additionally, in omap_i2c_xfer_data(), a standalone NACK interrupt sets
omap->cmd_err |=3D OMAP_I2C_STAT_NACK and returns -EAGAIN to wait for the
subsequent ARDY interrupt before completing omap->cmd_complete:

drivers/i2c/busses/i2c-omap.c:omap_i2c_xfer_data() {
    ...
		if (stat & OMAP_I2C_STAT_NACK) {
			omap->cmd_err |=3D OMAP_I2C_STAT_NACK;
			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_NACK);

			if (!(stat & ~OMAP_I2C_STAT_NACK)) {
				err =3D -EAGAIN;
				break;
			}
		}
    ...
}

Guarding wait_for_completion_timeout(&omap->cmd_complete, ...) with
!omap->cmd_err causes omap_i2c_xfer_msg() to skip waiting for ARDY if the
standalone NACK IRQ has already set omap->cmd_err, accessing controller
registers before hardware is ready and leaving a stale completion on
omap->cmd_complete when ARDY later fires.  Similarly, changing the timeout
check to if (!time_left && likely(!omap->cmd_err)) skips
omap_i2c_reset() and fails to return -ETIMEDOUT when waiting for ARDY
times out after a standalone NACK interrupt (and even returns 0 if
I2C_M_IGNORE_NAK is set).

[ ... ]
> @@ -1336,10 +1562,70 @@ static struct i2c_bus_recovery_info omap_i2c_bus_=
recovery_info =3D {
>  	.recover_bus		=3D i2c_generic_scl_recovery,
>  };
> =20
[ ... ]
> +static void omap_i2c_dma_free(struct omap_i2c_dev *omap)
> +{
> +	struct omap_i2c_dma *dma =3D omap->dma;
> +
> +	dma->dma_buf =3D 0;
> +	dma->dma_len =3D 0;
> +
> +	dma_release_channel(dma->chan_tx);
> +	dma->chan_tx =3D NULL;
> +
> +	dma_release_channel(dma->chan_rx);
> +	dma->chan_rx =3D NULL;
> +
> +	dma->chan_using =3D NULL;
> +}
[ ... ]
> @@ -1476,6 +1762,22 @@ omap_i2c_probe(struct platform_device *pdev)
>  		goto err_unuse_clocks;
>  	}
> =20
> +	if (omap->scheme !=3D OMAP_I2C_SCHEME_0) {
> +		omap->dma =3D omap_i2c_dma_init(omap, (dma_addr_t)res->start);
> +		if (PTR_ERR(omap->dma) =3D=3D -EPROBE_DEFER) {
> +			r =3D -EPROBE_DEFER;
> +			dev_err_probe(&pdev->dev, r,
> +				      "can't get DMA channels\n");
> +			goto err_unuse_clocks;
> +		} else if (PTR_ERR(omap->dma) =3D=3D -ENODEV) {
> +			dev_dbg(omap->dev, "DMA setup failed\n");
> +			omap->dma =3D NULL;
> +		} else if (IS_ERR(omap->dma)) {
> +			r =3D PTR_ERR(omap->dma);
> +			goto err_unuse_clocks;
> +		}
> +	}
> +
>  	adap =3D &omap->adapter;
>  	i2c_set_adapdata(adap, omap);
>  	adap->owner =3D THIS_MODULE;
> @@ -1491,7 +1793,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  	adap->nr =3D pdev->id;
>  	r =3D i2c_add_numbered_adapter(adap);
>  	if (r)
> -		goto err_unuse_clocks;
> +		goto err_dma_free;
> =20
>  	dev_info(omap->dev, "bus %d rev%d.%d at %d kHz\n", adap->nr,
>  		 major, minor, omap->speed);
> @@ -1500,6 +1802,8 @@ omap_i2c_probe(struct platform_device *pdev)
> =20
>  	return 0;
> =20
> +err_dma_free:
> +	omap_i2c_dma_free(omap);

[Severity: Medium]
Can err_dma_free trigger a NULL pointer dereference in
omap_i2c_dma_free()?

When omap->scheme =3D=3D OMAP_I2C_SCHEME_0 or omap_i2c_dma_init() returns
ERR_PTR(-ENODEV), omap->dma is NULL.  If i2c_add_numbered_adapter() then
fails, omap_i2c_dma_free(omap) is called without an if (omap->dma) check
and dereferences omap->dma.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118205213.8877=
8-1-apokusinski01@gmail.com?part=3D4
