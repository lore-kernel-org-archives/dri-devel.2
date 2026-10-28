Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C74A606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akryjx38
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C3410E6B1;
	Wed, 28 Oct 2026 17:19:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6988610E6B1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 17:19:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 874786020A;
 Wed, 28 Oct 2026 17:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162DB1F01829;
 Wed, 28 Oct 2026 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793207943;
 bh=0uw5b5WJ/frCjF1BWA9yHZlqikkZI7ppytPBUj5YA6o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=akryjx38nvSKvmFQmsM4FgfANs+xzizq8t8ADxLTQXD7fdbD5jVBWqanWmCwOD6io
 EO/3F+59FRmOERJq/FedOjkzAphAO4WSIAUSu595ONgDTOSSzdNI+RR11/8Yw5xjRg
 cg5hteDVrlw+g6psMlAdIJo+c+j4hGYqGzglVZwdTmDGW6enenVxns7UaY6l1UWK9I
 NMjs347zCJe2ITdzscfGS1HUM5tPtEOTEUwdLxyVinG3qG1j7k7xGTvyFxpuRQS3gC
 +Ok70jLCpDKo8p0ZUoi6ZZxZMYNEd5AfeZ2RiavJORBFyKuQPNr+tePllxlByiqZDc
 LGz9oUM73iHzg==
Message-ID: <sashiko-outbox-188230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] drm/vc4: dsi: Recover from a timed-out transfer
To: "Henry Zhang" <henryzhang62@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261028164539.3471833-6-henryzhang62@gmail.com>
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
 <20261028164539.3471833-6-henryzhang62@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 17:19:02 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/vc4: dsi: race on reg_dma_mem before disable_irq() in vc4_dsi_=
host_transfer()
--

commit 748a80df1fc43dd3d1d753f275003873696caaaf
Author: Henry Zhang <henryzhang62@gmail.com>

drm/vc4: dsi: Recover from a timed-out transfer

This commit recovers the VC4 DSI block after a transfer timeout by resetting
the DSI controller and its analog front end, then restoring the hardware
configuration from pre_enable while holding the interrupt disabled.

> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 3ee6e8e86a147..6edda74e1117c 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c

[ ... ]

> @@ -1374,6 +1378,120 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_=
dsi_host *host,
>  	return ret;
>  }
> =20
> +/*
> + * Reset the DSI block and its analog front end, then restore the
> + * configuration done in pre_enable. Resetting the FIFOs alone does not
> + * clear the state the block can be left in after a transfer timed out
> + * (e.g. on an LP receive timeout): every following transfer then times
> + * out as well, until the next modeset.
> + */
> +static void vc4_dsi_reset_and_restore(struct vc4_dsi *dsi)
> +{
> +	u32 en =3D dsi->variant->port ? DSI1_CTRL_EN : DSI0_CTRL_CTRL0;
> +	u32 ctrl =3D DSI_PORT_READ(CTRL);

[ ... ]

> +	/* Ungate the block. */
> +	DSI_PORT_WRITE(CTRL, ctrl);
> +	/* Bring AFE out of reset. */
> +	DSI_PORT_WRITE(PHY_AFEC0, afec0 & ~DSI_PORT_BIT(PHY_AFEC0_RESET));
> +	DSI_PORT_WRITE(DISP0_CTRL, disp0);
> +
> +	DSI_PORT_WRITE(INT_STAT, DSI_PORT_READ(INT_STAT));
> +	DSI_PORT_WRITE(INT_EN, DSI_PORT_BIT(INTERRUPTS_ALWAYS_ENABLED));
> +}
> +
> +static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
> +				     const struct mipi_dsi_msg *msg)
> +{
> +	struct vc4_dsi *dsi =3D host_to_dsi(host);
> +	u32 disp0_ctrl;
> +	ssize_t ret;
> +
> +	guard(mutex)(&dsi->transfer_lock);
> +
> +	ret =3D vc4_dsi_transfer(dsi, msg);
> +	/* Only a running block can be reset and restored. */
> +	if (ret !=3D -ETIMEDOUT || !dsi->enabled)
> +		return ret;
> +
> +	/*
> +	 * Leave the block usable for the next transfer. The message is not
> +	 * resent: it may already have reached the peripheral, and only the
> +	 * caller knows whether it is safe to repeat.
> +	 */
> +	disp0_ctrl =3D DSI_PORT_READ(DISP0_CTRL);
> +	dev_warn(&dsi->pdev->dev,
> +		 "transfer timed out (stat 0x%08x), resetting DSI\n",
> +		 DSI_PORT_READ(STAT));
> +	/*
> +	 * Keep the interrupt handler out until the block is restored and
> +	 * INT_STAT is cleared. The error interrupts are still enabled, and
> +	 * a handler running during the reset could complete the next
> +	 * transfer, or race with the register writes on DSI1 of the
> +	 * BCM2835, where both go through the DMA workaround. disable_irq()
> +	 * also waits for a late completion interrupt of the timed-out
> +	 * transfer.
> +	 */
> +	disable_irq(dsi->irq);
> +	vc4_dsi_reset_and_restore(dsi);
> +	DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
> +	enable_irq(dsi->irq);

[Severity: High]
Can a late or error interrupt race on dsi->reg_dma_mem in vc4_dsi_transfer()
before disable_irq(dsi->irq) is reached in vc4_dsi_host_transfer(),
corrupting DSI1_CTRL before vc4_dsi_reset_and_restore() saves and restores
it?

When wait_for_completion_timeout() times out in vc4_dsi_transfer(),
dsi->irq and INT_EN are still enabled while vc4_dsi_transfer() performs
five register writes before returning -ETIMEDOUT:

drivers/gpu/drm/vc4/vc4_dsi.c:vc4_dsi_transfer() {
	...
	DSI_PORT_WRITE(INT_EN, DSI_PORT_BIT(INTERRUPTS_ALWAYS_ENABLED));

	if (ret)
		goto reset_fifo_and_return;
	...
reset_fifo_and_return:
	drm_err(drm, "DSI transfer failed, resetting: %d\n", ret);

	DSI_PORT_WRITE(TXPKT1C, DSI_PORT_READ(TXPKT1C) & ~DSI_TXPKT1C_CMD_EN);
	udelay(1);
	DSI_PORT_WRITE(CTRL,
		       DSI_PORT_READ(CTRL) |
		       DSI_PORT_BIT(CTRL_RESET_FIFOS));

	DSI_PORT_WRITE(TXPKT1C, 0);
	DSI_PORT_WRITE(INT_EN, DSI_PORT_BIT(INTERRUPTS_ALWAYS_ENABLED));
	return ret;
}

On BCM2835 DSI1 (where broken_axi_workaround is enabled), DSI_PORT_WRITE()
calls dsi_dma_workaround_write(), which writes the value into the single
shared buffer *dsi->reg_dma_mem and submits a DMA transfer from
dsi->reg_dma_paddr:

drivers/gpu/drm/vc4/vc4_dsi.c:dsi_dma_workaround_write() {
	...
	*dsi->reg_dma_mem =3D val;

	tx =3D chan->device->device_prep_dma_memcpy(chan,
						  dsi->reg_paddr + offset,
						  dsi->reg_dma_paddr,
						  4, 0);
	...
}

If the threaded handler vc4_dsi_irq_handler() runs concurrently (for
example on an LPRX/TA timeout error interrupt or a late completion
interrupt) and calls DSI_PORT_WRITE(INT_STAT, stat), it overwrites
*dsi->reg_dma_mem =3D stat without any lock.

If that happens during the read-modify-write of CTRL in
reset_fifo_and_return, the DMA transfer can write stat into DSI1_CTRL.
When vc4_dsi_reset_and_restore() then runs under disable_irq(dsi->irq), it
snapshots the corrupted register via u32 ctrl =3D DSI_PORT_READ(CTRL) and
writes it back at the end of the reset, leaving DSI1_CTRL corrupted (for
example with DSI1_CTRL_EN cleared so the block remains gated).

Should disable_irq(dsi->irq) be called in vc4_dsi_transfer() before the
post-timeout register writes (or before reset_fifo_and_return)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028164539.3471=
833-1-henryzhang62@gmail.com?part=3D5
