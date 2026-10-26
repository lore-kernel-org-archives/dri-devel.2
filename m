Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30158606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqZERHaS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9899310F0CC;
	Mon, 26 Oct 2026 19:30:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD93D10F0CC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 19:29:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D665A601EF;
 Mon, 26 Oct 2026 19:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BFB1F01825;
 Mon, 26 Oct 2026 19:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793042994;
 bh=s28Zpnmih3RgakWjcDbcJANRBfHAt8QZQlFAkiLmZ2A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XqZERHaSGNP5W4fkpfHV2QzMFS2MPeZ5Mb8Nk6OobrOUZng6aE33gDOjxhtWZzKcM
 YWPUGn1l+ObekW5xZZEjO9vc1DYy9deKCtYTPFG8V0KPhdTFFi4PdddrSDk1aZbCKJ
 uM53JW7Aul+XgRivDPLb15lJ2qvVo8GXNQp0eSNIXW1xm7SuGLkST0GTuBTPVYvZ9v
 BI1d+sUGU29wqzEtO8k28VuYaqdykhpykglR0/9N4U32lBsZk/ndSCZYPsYKIuxj4u
 Ni3wW8dhtpYIPFErJtIeZtS7p1mUKOtSawJ0PdvVHwWYuTDC9lsJ0cWCgwAeazzKXw
 R7lGW+gLSqxkA==
Message-ID: <sashiko-outbox-185675@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] drm/vc4: dsi: Recover from a timed-out transfer
To: "Henry Zhang" <henryzhang62@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026191618.9430-5-henryzhang62@gmail.com>
References: <20261026191618.9430-1-henryzhang62@gmail.com>
 <20261026191618.9430-5-henryzhang62@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 19:29:53 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/vc4: dsi: synchronize_irq() called before masking INT_EN on ti=
meout
--

commit f8356e0d93ae02c55bbda5440fae3505620f2bfb
Author: Henry Zhang <henryzhang62@gmail.com>

drm/vc4: dsi: Recover from a timed-out transfer

When a DSI transfer times out while the block is enabled, this commit resets
the DSI block and its analog front end and restores the hardware
configuration from pre_enable so subsequent transfers can succeed without
requiring a full modeset.

> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index ea3a6d06b045a..42f50d2ca401c 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c

[ ... ]

> @@ -1374,6 +1378,114 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_=
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
> +	u32 afec0 =3D DSI_PORT_READ(PHY_AFEC0);
> +	u32 afec1 =3D DSI_PORT_READ(PHY_AFEC1);
> +	u32 disp0 =3D DSI_PORT_READ(DISP0_CTRL) & ~DSI_DISP0_ENABLE;
> +	u32 disp1 =3D DSI_PORT_READ(DISP1_CTRL);
> +	u32 hstx_to =3D DSI_PORT_READ(HSTX_TO_CNT);
> +	u32 lprx_to =3D DSI_PORT_READ(LPRX_TO_CNT);
> +	u32 ta_to =3D DSI_PORT_READ(TA_TO_CNT);
> +	u32 pr_to =3D DSI_PORT_READ(PR_TO_CNT);
> +	u32 phyc =3D DSI_PORT_READ(PHYC);
> +	u32 clt0 =3D DSI_PORT_READ(HS_CLT0);
> +	u32 clt1 =3D DSI_PORT_READ(HS_CLT1);
> +	u32 clt2 =3D DSI_PORT_READ(HS_CLT2);
> +	u32 dlt3 =3D DSI_PORT_READ(HS_DLT3);
> +	u32 dlt4 =3D DSI_PORT_READ(HS_DLT4);
> +	u32 dlt5 =3D DSI_PORT_READ(HS_DLT5);
> +	u32 dlt6 =3D DSI_PORT_READ(HS_DLT6);
> +	u32 dlt7 =3D DSI_PORT_READ(HS_DLT7);
> +
> +	/*
> +	 * Mask the interrupts while the block and its AFE are in reset: the
> +	 * error interrupts would otherwise fire continuously.
> +	 */
> +	DSI_PORT_WRITE(INT_EN, 0);

[ ... ]

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
> +	 * The completion interrupt of the timed-out transfer may still be
> +	 * in flight; let it finish so that it cannot complete the next one.
> +	 */
> +	synchronize_irq(dsi->irq);
> +	vc4_dsi_reset_and_restore(dsi);

[Severity: High]
Should INT_EN be masked before calling synchronize_irq(dsi->irq) in
vc4_dsi_host_transfer() in drivers/gpu/drm/vc4/vc4_dsi.c (or should
synchronize_irq(dsi->irq) be called after DSI_PORT_WRITE(INT_EN, 0) in
vc4_dsi_reset_and_restore())?

When vc4_dsi_transfer() returns -ETIMEDOUT via reset_fifo_and_return, it
leaves INTERRUPTS_ALWAYS_ENABLED active in INT_EN and does not clear INT_ST=
AT:

drivers/gpu/drm/vc4/vc4_dsi.c:vc4_dsi_transfer() {
	...
reset_fifo_and_return:
	...
	DSI_PORT_WRITE(TXPKT1C, 0);
	DSI_PORT_WRITE(INT_EN, DSI_PORT_BIT(INTERRUPTS_ALWAYS_ENABLED));
	return ret;
}

Because synchronize_irq(dsi->irq) in vc4_dsi_host_transfer() runs before
vc4_dsi_reset_and_restore() performs 18 register reads and writes
DSI_PORT_WRITE(INT_EN, 0), any error or timeout interrupt from
INTERRUPTS_ALWAYS_ENABLED can still fire in the window after synchronize_ir=
q()
returns and before INT_EN is cleared.

If an interrupt fires in that window on BCM2835 DSI1 (where
broken_axi_workaround is enabled and devm_request_threaded_irq() is used wi=
th
vc4_dsi_irq_defer_to_thread_handler()), the threaded handler
vc4_dsi_irq_handler() will run concurrently with vc4_dsi_reset_and_restore(=
):

drivers/gpu/drm/vc4/vc4_dsi.c:vc4_dsi_irq_handler() {
	u32 stat =3D DSI_PORT_READ(INT_STAT);
	...
	DSI_PORT_WRITE(INT_STAT, stat);
}

1. In vc4_dsi_irq_handler(), DSI_PORT_WRITE(INT_STAT, stat) invokes
dsi_dma_workaround_write(), which writes to the shared 4-byte buffer
*dsi->reg_dma_mem and submits a DMA transfer on dsi->reg_dma_chan without
serialization:

drivers/gpu/drm/vc4/vc4_dsi.c:dsi_dma_workaround_write() {
	...
	*dsi->reg_dma_mem =3D val;

	tx =3D chan->device->device_prep_dma_memcpy(chan,
						  dsi->reg_paddr + offset,
						  dsi->reg_dma_paddr,
						  4, 0);
	...
}

Can this race with the register writes in vc4_dsi_reset_and_restore() and
corrupt the values being written to the DSI registers?

2. While vc4_dsi_reset_and_restore() holds the block and AFE in reset across
mdelay(1), error bits in INT_STAT assert continuously. Since
vc4_dsi_irq_handler() reads raw INT_STAT without masking by INT_EN, if the
concurrent IRQ thread reads INT_STAT while INT_HSTX_TO is asserted during
reset (or if a late completion bit latched before TXPKT1C_CMD_EN was cleare=
d),
won't it call vc4_dsi_xfer_complete() and signal dsi->xfer_completion after
synchronize_irq() has already returned, leaving a stale completion for the
next transfer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026191618.9430=
-1-henryzhang62@gmail.com?part=3D4
