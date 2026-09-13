Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC555C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA76010E9A2;
	Sun, 13 Sep 2026 20:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PCoIL1x4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCAA110E9A2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:19:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 82F614348F;
 Sun, 13 Sep 2026 20:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464721F000FF;
 Sun, 13 Sep 2026 20:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789330754;
 bh=BvPooVDxzVJWrU2vp1zWZwyj2NRk5xh+nI4YZ4niHgg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PCoIL1x4IWc3PJ/ZuvgnCDNyJswdjO2ufxrRHaMCL5QSHknj8VqIWIsxl1I/RD9+s
 gPbJeY7gbKMa2rS7p8UUzwLkSCacX8de8wqhwMWsYKgxTb8pSdvUx+rkRlN1MlKLpu
 /tsMCPgVpRAIMWZ1K7mCcmu9J5UmYV64OnbBh/QbOqxCnk/tCpuDUGrPJDhaY2+Tfb
 J7Hg3pet5nAF55Z2koW3GtptA/EZWikoKbu7aoIuV4qyJStqQYtG+xWKufNGSBOe7Q
 G6LCJkRJeuE2aVrIgCanmASAmwFt70lSM598q8d6MZea15co39W0RBaht1erenTtEn
 6Uhxc/tkCO2pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] accel/amdxdna: bound the firmware-supplied mailbox
 register offsets
To: "Eva Crystal" <0xiviel@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913200212.133126-2-0xiviel@gmail.com>
References: <20260913200212.133126-1-0xiviel@gmail.com>
 <20260913200212.133126-2-0xiviel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 20:19:13 +0000
Message-Id: <20260913201914.464721F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Dangling stack pointer dereference and arbitrary memory overwr=
ite when a synchronous mailbox message times out
- [High] Incomplete bounds checking for firmware-supplied mailbox ring buff=
er offsets
- [High] Missing alignment check for firmware-supplied MMIO register offsets
- [High] Dangling pointer in the error path of aie2_create_context() leads =
to Use-After-Free and Double Free
- [High] Memory and XArray ID leak when firmware does not respond to a mail=
box message, leading to a rapid Denial of Service
--

commit 6dc11363e9e0c2c2b0493330df8c49c994026bf8
Author: Eva Crystal <0xiviel@gmail.com>

accel/amdxdna: bound the firmware-supplied mailbox register offsets

Firmware chooses where a mailbox channel's head and tail registers live
and reports them to the driver as device addresses. This patch adds
checks to ensure the four register offsets and the interrupt register
are within the mailbox mapping size before use.

> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdx=
dna/amdxdna_mailbox.c
> index cc8865f4e79c9..0c4cb8beb26ea 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -112,6 +112,28 @@ static u32 mailbox_reg_read(struct mailbox_channel *=
mb_chann, u32 mbox_reg)
>  	return readl(ringbuf_addr);
>  }
> =20
> +/*
> + * Firmware describes where a channel's head and tail registers live, as=
 raw
> + * offsets into the mailbox mapping: in the management mailbox block it =
writes
> + * into SRAM for the management channel, and in the CREATE_CONTEXT respo=
nse for
> + * a hardware context. Both helpers above add such an offset straight to
> + * mbox_base, so bound it against the size of that mapping first.
> + */
> +static bool mailbox_reg_in_range(struct mailbox_channel *mb_chann, u32 m=
box_reg)
> +{
> +	struct xdna_mailbox_res *mb_res =3D &mb_chann->mb->res;
> +
> +	/* Every access through the two helpers above is 32 bits wide. */
> +	return (u64)mbox_reg + sizeof(u32) <=3D mb_res->mbox_size;
> +}

[Severity: High]
This is a pre-existing issue, but since this bounds check validates the off=
set
magnitude, should it also enforce the natural alignment IS_ALIGNED(mbox_reg=
, 4)
required for 32-bit MMIO accesses?

If the firmware provides an unaligned register offset (e.g., 0x1), could th=
is
lead to hardware alignment faults, Machine Check Exceptions, or PCIe AER fa=
ults
when readl() or writel() are called?

> +
> +static bool mailbox_chann_res_in_range(struct mailbox_channel *mb_chann,
> +				       const struct xdna_mailbox_chann_res *res)
> +{
> +	return mailbox_reg_in_range(mb_chann, res->mb_head_ptr_reg) &&
> +	       mailbox_reg_in_range(mb_chann, res->mb_tail_ptr_reg);
> +}

[ ... ]

> @@ -518,6 +540,16 @@ xdna_mailbox_start_channel(struct mailbox_channel *m=
b_chann,
>  		return -EINVAL;
>  	}
> =20
> +	/* A zero iohub_int_addr means the platform has no such register. */
> +	if (!mailbox_chann_res_in_range(mb_chann, x2i) ||
> +	    !mailbox_chann_res_in_range(mb_chann, i2x) ||
> +	    (iohub_int_addr && !mailbox_reg_in_range(mb_chann, iohub_int_addr))=
) {

[Severity: High]
This is a pre-existing issue, but the patch attempts to establish a
firmware-to-driver trust boundary for mailbox offsets and completely omits =
the
ring buffer limits here.

Does this code miss checking x2i->rb_start_addr and i2x->rb_start_addr agai=
nst
the mapped ringbuf_size?

If firmware provides a malicious rb_start_addr, it will be used in
mailbox_send_msg() directly to compute an MMIO address:

drivers/accel/amdxdna/amdxdna_mailbox.c:mailbox_send_msg() {
...
	write_addr =3D mb_chann->mb->res.ringbuf_base + start_addr + tail;
	writel(TOMBSTONE, write_addr);
...
}

Furthermore, if the firmware sets rb_size to a tiny power of two (e.g., 2),
mailbox_get_ringbuf_size() - sizeof(u32) severely integer-underflows, break=
ing
the ring buffer wrap-around checks. Initial x2i_tail and i2x_head are also
read directly from device registers without validation, leading to immediate
out-of-bounds MMIO accesses.

> +		dev_err(mb_chann->mb->dev,
> +			"Mailbox register offset outside the %zu byte mailbox mapping\n",
> +			mb_chann->mb->res.mbox_size);
> +		return -EINVAL;

[Severity: High]
This is a pre-existing issue, but adding this return -EINVAL actively expos=
es
a dangling pointer in aie2_create_context().

If xdna_mailbox_start_channel() returns -EINVAL here, aie2_create_context()
jumps to its error path and frees the channel without clearing the pointer:

drivers/accel/amdxdna/aie2_message.c:aie2_create_context() {
...
free_channel:
	xdna_mailbox_free_channel(hwctx->priv->mbox_chann);
del_ctx_req:
...
}

If context creation fails, aie2_xrs_unload() subsequently calls
aie2_destroy_context(), which evaluates the dangling pointer:

drivers/accel/amdxdna/aie2_message.c:aie2_destroy_context() {
...
	if (!hwctx->priv->mbox_chann)
		return 0;

	xdna_mailbox_stop_channel(hwctx->priv->mbox_chann);
	ret =3D aie2_destroy_context_req(ndev, hwctx->fw_ctx_id);
	xdna_mailbox_free_channel(hwctx->priv->mbox_chann);
...
}

Can this trigger a Use-After-Free and Double Free?

> +	}
> +
>  	mb_chann->msix_irq =3D mb_irq;
>  	mb_chann->iohub_int_addr =3D iohub_int_addr;
>  	memcpy(&mb_chann->res[CHAN_RES_X2I], x2i, sizeof(*x2i));

[Severity: Critical]
This is a pre-existing issue, but I also noticed a potential vulnerability =
with
synchronous mailbox messages.

Does xdna_send_msg_wait() leave a time-bomb callback pointing to the stack =
if
it times out?

drivers/accel/amdxdna/amdxdna_mailbox_helper.c:xdna_send_msg_wait() {
...
	ret =3D wait_for_completion_timeout(&hdl->comp,
					  msecs_to_jiffies(RX_TIMEOUT));
	if (!ret) {
		XDNA_ERR(xdna, "Wait for completion timeout");
		return -ETIME;
	}
...
}

If this times out, the function returns and destroys its stack frame, but t=
he
pending message remains in the mailbox XArray. When the device firmware
eventually writes a delayed response, the RX worker calls xdna_msg_cb() with
the dangling stack pointer:

drivers/accel/amdxdna/amdxdna_mailbox_helper.c:xdna_msg_cb() {
...
	memcpy_fromio(cb_arg->data, data, cb_arg->size);
...
}

Could this overwrite arbitrary kernel memory using corrupted size and data
fields from the destroyed stack frame?

[Severity: High]
This is a pre-existing issue, but related to the timeout behavior above, do=
es
xdna_mailbox_send_msg() leak memory and XArray IDs when a timeout occurs?

drivers/accel/amdxdna/amdxdna_mailbox.c:xdna_mailbox_send_msg() {
...
	ret =3D mailbox_send_msg(mb_chann, mb_msg);
	if (ret) {
		MB_DBG(mb_chann, "Error in mailbox send msg, ret %d", ret);
		goto release_id;
	}

	return 0;
...
}

When xdna_send_msg_wait() times out, it fails to release the XArray ID or f=
ree
the dynamically allocated mb_msg. Since XArray IDs are limited to 256 entri=
es
for the mailbox channel, could an aggressive user repeatedly trigger timeou=
ts
to consume all 256 slots?

Once exhausted, mailbox_acquire_msgid() will indefinitely fail with -ENOSPC,
permanently causing a Denial of Service on the mailbox channel until the dr=
iver
is reloaded.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913200212.1331=
26-2-0xiviel@gmail.com?part=3D1
