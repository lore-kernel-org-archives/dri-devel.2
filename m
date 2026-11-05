Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D3606D816
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WmdSuRua
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 743B810E295;
	Thu,  5 Nov 2026 20:32:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEF810E295
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:32:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E660C43D74;
 Thu,  5 Nov 2026 20:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C35F1F008A4;
 Thu,  5 Nov 2026 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793910733;
 bh=Z4vIFIPuDFiLGFfDxxuz3AZoANnEm7koIMt0swHWc+E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WmdSuRuaUuWzywwWxFGPiKCI2GNbRCMO/l6Sjz+guc8I7Kk2/n7YAKLRjU7aVUvJl
 QTzAXPTO41EEeSRJHNTH5+1OpTnBmpMyDj1bZ3odCPDKzV8PftOlzlpvgT7LcNEM7C
 qyFvr7jcTNlFouhWbs5+JSw+quzdvWJ1q74TFQ+nleV1DzziU2E0YCO35P9qffmKNP
 fj4YGmbp15FDmy+/0rAPttwuub7j+HSGJ/aOkbLV8SayjzFoIpQ/HHexa9vbUNW1ZS
 NPQm9wbTIkOj9zZvsGyK46tBTQkmiQrOHlk6ViedHO5wfVTEd3FZUdH0eaf7Q3tvza
 4Z142HhoaDJ1w==
Message-ID: <sashiko-outbox-200108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] i2c: omap: add DMA support
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261105200556.34240-5-apokusinski01@gmail.com>
References: <20261105200556.34240-2-apokusinski01@gmail.com>
 <20261105200556.34240-5-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:32:13 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] i2c: omap: stall and -ETIMEDOUT on bus error in omap_i2c_xfer_msg()
- [Medium] i2c: omap: DMA channel leak in omap_i2c_probe() on adapter add e=
rror
- [Medium] i2c: omap: active PIO FIFO interrupts during DMA in omap_i2c_xfe=
r_msg()
--

commit 4941414830d919c66f3a4ea17fab3a4dcf5a305e
Author: Antoni Pokusinski <apokusinski01@gmail.com>

i2c: omap: add DMA support

This commit adds TX and RX DMA support to the OMAP I2C controller driver for
messages whose length is at least 8 bytes and a multiple of the configured
FIFO threshold.

> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index f02d294db42a6..59e633c80236b 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c

[ ... ]

> @@ -742,8 +928,17 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ada=
p,
>  	 * into arbitration and we're currently unable to recover from it.
>  	 */
>  	if (!polling) {
> -		time_left =3D wait_for_completion_timeout(&omap->cmd_complete,
> -							OMAP_I2C_TIMEOUT);
> +		time_left =3D OMAP_I2C_TIMEOUT;
> +
> +		if (use_dma)
> +			time_left =3D wait_for_completion_timeout(
> +						&omap->dma->complete,
> +						time_left);
> +
> +		if (time_left)
> +			time_left =3D wait_for_completion_timeout(
> +						&omap->cmd_complete,
> +						time_left);

[Severity: High]
What happens in omap_i2c_xfer_msg() in drivers/i2c/busses/i2c-omap.c if an
I2C bus error such as a NACK (OMAP_I2C_STAT_NACK) or arbitration loss
(OMAP_I2C_STAT_AL) occurs during a DMA transfer?

When the target device NACKs or arbitration is lost before all msg->len byt=
es
are transferred, the controller stops generating FIFO DMA requests, so
omap_i2c_dma_callback() will not be invoked to complete omap->dma->complete.

Meanwhile, the interrupt handler path:

omap_i2c_isr_thread()
  -> omap_i2c_xfer_data()
  -> omap_i2c_complete_cmd()

records the error in omap->cmd_err and signals omap->cmd_complete, but does
not signal omap->dma->complete:

static inline void
omap_i2c_complete_cmd(struct omap_i2c_dev *omap, u16 err)
{
	omap->cmd_err |=3D err;
	complete(&omap->cmd_complete);
}

Won't waiting on omap->dma->complete first cause omap_i2c_xfer_msg() to sta=
ll
for the full OMAP_I2C_TIMEOUT, reset the controller, and return -ETIMEDOUT
instead of handling omap->cmd_err and returning -EREMOTEIO, -EAGAIN, or 0
(for I2C_M_IGNORE_NAK)?

>  	} else {
>  		do {
>  			omap_i2c_wait(omap);
> @@ -753,6 +948,15 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *ada=
p,
>  		time_left =3D !ret;
>  	}
> =20
> +	if (use_dma) {
> +		omap_i2c_dma_disable_req(omap);
> +
> +		if (!time_left || omap->cmd_err)
> +			dmaengine_terminate_sync(omap->dma->chan_using);
> +
> +		omap_i2c_dma_cleanup(omap, time_left && !omap->cmd_err);
> +	}

[Severity: Medium]
Could disabling DMA requests here race with the PIO interrupt handler in
drivers/i2c/busses/i2c-omap.c?

During a DMA transfer, omap_i2c_xfer_msg() still sets omap->buf =3D msg->buf
and omap->buf_len =3D msg->len, and OMAP_I2C_IE_XRDY, OMAP_I2C_IE_RRDY,
OMAP_I2C_IE_XDR, and OMAP_I2C_IE_RDR remain enabled in OMAP_I2C_IE_REG.

If a DMA transfer times out or fails while the controller is still enabled
(prior to omap_i2c_reset()), omap_i2c_dma_disable_req() clears
OMAP_I2C_BUF_RDMA_EN or OMAP_I2C_BUF_XDMA_EN in OMAP_I2C_BUF_REG. Once the
DMA request bit is cleared in OMAP_I2C_BUF_REG, can pending FIFO threshold
conditions trigger XRDY/RRDY/XDR/RDR interrupts and cause
omap_i2c_isr_thread() -> omap_i2c_xfer_data() to read or write
OMAP_I2C_DATA_REG and omap->buf concurrently with omap_i2c_dma_cleanup() and
omap_i2c_reset()?

[ ... ]

> @@ -1478,6 +1742,22 @@ omap_i2c_probe(struct platform_device *pdev)
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

[Severity: Medium]
Does omap_i2c_probe() in drivers/i2c/busses/i2c-omap.c leak dma->chan_tx and
dma->chan_rx if i2c_add_numbered_adapter() fails?

omap_i2c_dma_init() acquires dma->chan_tx and dma->chan_rx using
dma_request_chan(). Later in omap_i2c_probe():

	r =3D i2c_add_numbered_adapter(adap);
	if (r)
		goto err_unuse_clocks;

The err_unuse_clocks error path does not call omap_i2c_dma_free(omap) when
omap->dma is set:

err_unuse_clocks:
	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
err_put_pm:
	pm_runtime_put_sync(omap->dev);
err_disable_pm:
	pm_runtime_dont_use_autosuspend(omap->dev);
	pm_runtime_disable(&pdev->dev);

	return r;

Should the error unwind path release the DMA channels with
omap_i2c_dma_free(omap) when omap->dma is non-NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105200556.3424=
0-2-apokusinski01@gmail.com?part=3D3
