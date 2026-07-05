Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DA5C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 496BD10E1CD;
	Sun,  5 Jul 2026 14:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BMmFSXWT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817DC10E1CD
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 14:00:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B1E5E6138A;
 Sun,  5 Jul 2026 14:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3461F000E9;
 Sun,  5 Jul 2026 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783260022;
 bh=qQg5lvRfYaU76KjBmnMui5GjmwLgwnqbXEfOAFSM990=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BMmFSXWTwpbS8Wnpk+xwzbpCdD6zfaND6/RIqC4w/aBjH9P6hGoAwkxkH663JG5qY
 m6Jvy04lhsRgylJncLJJ6Q3zKvmk1kiXY3PTpgILs0QObB+0GwSRZKeVKc6Ca67nC3
 LOwojfjm5hPYvNmhAk3pVT84oJkDObixyHwh4ytVOzIJr8v6KTA5PsEbIq+Toq90S6
 /BG0vg6YESObfH/ftdmG/F0Ti3ufITM1m5R2yrdpd9/s8eGqBCkv5sPQVciTye1Rmc
 VbadaRUUu6wcDTY4u206qFlheKkOFX4bO3qprlQASOYkki5wfFOwPIP7FHgQGwjOyH
 nUCaD3H/8b0bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
To: "Aniket Randive" <aniket.randive@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260705134619.4030745-1-aniket.randive@oss.qualcomm.com>
References: <20260705134619.4030745-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 14:00:21 +0000
Message-Id: <20260705140022.3C3461F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The dynamic timeout calculation overflows a 32-bit `size_t` for la=
rge I2C transfers, resulting in spuriously short timeouts on 32-bit platfor=
ms.
- [High] The timeout for GPI multi-descriptor transfers incorrectly uses th=
e maximum single message length instead of the sum of all message lengths, =
causing batched transfers to time out prematurely.

Pre-existing issues:
- [High] The `dma_buf` and `dma_addr` arrays in multi-descriptor transfers =
are leaked if a setup error occurs before the last message.
- [High] The multi-descriptor DMA completion wait loop is off-by-one, leadi=
ng to either early returns and Use-After-Free, or spurious timeouts.
--

commit ecf799f9a50e09d26f5ccb839643f2514a2b8b98
Author: Aniket Randive <aniket.randive@oss.qualcomm.com>

i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and f=
requency

The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
regardless of message length or bus frequency, causing unnecessary
delays on error paths.

Compute the timeout dynamically from message length and bus frequency
with a 10x safety margin over the theoretical wire time and a 300ms
floor. For GPI multi-descriptor transfers, use the maximum message
length across all queued messages as the per-completion timeout.

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index 96dbf04138bee..43ae2121f01c2 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
[ ... ]
> @@ -204,6 +207,16 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev =
*gi2c)
>  	return -EINVAL;
>  }
> =20
> +static unsigned long geni_i2c_xfer_timeout(struct geni_i2c_dev *gi2c, si=
ze_t len)
> +{
> +	size_t bit_cnt =3D len * 9;
> +	size_t bit_usec =3D (bit_cnt * USEC_PER_SEC) / gi2c->clk_freq_out;

[Severity: High]
Can this calculation overflow on 32-bit platforms?

If USEC_PER_SEC is 1000000 and size_t is 32-bit, large I2C transfers
(e.g. len >=3D 478 bytes) could cause bit_cnt * USEC_PER_SEC to exceed
the 32-bit maximum.

This would truncate the upper bits of the result, causing legitimate large
I2C transfers to fail systematically with -ETIMEDOUT because the calculated
timeout becomes much shorter than the actual required wire time.

> +	size_t xfer_max_usec =3D (bit_usec * I2C_TIMEOUT_SAFETY_COEFFICIENT) +
> +			       I2C_TIMEOUT_MIN_USEC;
> +
> +	return usecs_to_jiffies(xfer_max_usec);
> +}
[ ... ]
> @@ -601,7 +614,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni=
_i2c_dev *gi2c, struct i2c_
>   */
>  static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>  						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
> -						   u32 transfer_timeout_msecs,
> +						   unsigned long timeout_jiffies,
>  						   struct completion *transfer_comp)
>  {
>  	int i;
> @@ -612,7 +625,7 @@ static int geni_i2c_gpi_multi_xfer_timeout_handler(st=
ruct device *dev,
> =20
>  		if (multi_xfer->msg_idx_cnt !=3D multi_xfer->irq_cnt) {
>  			time_left =3D wait_for_completion_timeout(transfer_comp,
> -								transfer_timeout_msecs);

[Severity: High]
This isn't a bug introduced by this patch, but does the loop bound in this
function cause synchronization issues for multi-message batches?

For a batch of 3 messages, the loop bounded by msg_idx_cnt - 1 executes
exactly twice.

If the DMA hardware is configured for Block Event Interrupts and signals
only once at the very end, the first wait would complete, but the second
iteration could time out because no further interrupts arrive.

Conversely, if it interrupts on every descriptor, returning early after 2
iterations would leave the 3rd message in flight, allowing the caller to
free the message buffers while the DMA is still accessing them.

> +								timeout_jiffies);
>  			if (!time_left) {
>  				dev_err(dev, "%s: Transfer timeout\n", __func__);
>  				return -ETIMEDOUT;
[ ... ]
> @@ -736,8 +749,15 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, s=
truct i2c_msg msgs[],
>  		dma_async_issue_pending(gi2c->tx_c);
> =20
>  		if ((msg_idx =3D=3D (gi2c->num_msgs - 1)) || flags & DMA_PREP_INTERRUP=
T) {
> +			size_t max_len =3D 0;
> +			int j;
> +
> +			for (j =3D 0; j < gi2c->num_msgs; j++)
> +				max_len =3D max_t(size_t, max_len, msgs[j].len);
> +
>  			ret =3D geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gp=
i_xfer,
> -								      XFER_TIMEOUT, &gi2c->done);
> +								      geni_i2c_xfer_timeout(
> +								      gi2c, max_len), &gi2c->done);

[Severity: High]
Does this use of a single message's maximum length provide a long enough
timeout for the entire batched transfer?

When using multi-descriptor transfers, the DMA controller executes the batch
sequentially.

The single wait_for_completion_timeout call here will block for the
duration of the entire batch.

If a batch contains many messages (e.g. 50 messages of 100 bytes each),
the combined wire time could easily exceed the timeout calculated for just
the single largest message, causing the batch transfer to time out
prematurely.

[Severity: High]
This is a pre-existing issue, but does early failure in multi-descriptor
setup leak the DMA tracking arrays?

Looking at the unmap function called on early aborts:

drivers/i2c/busses/i2c-qcom-geni.c:geni_i2c_gpi_multi_desc_unmap() {
    ...
    if (tx_multi_xfer->unmap_msg_cnt =3D=3D gi2c->num_msgs - 1) {
        kfree(tx_multi_xfer->dma_buf);
        kfree(tx_multi_xfer->dma_addr);
        break;
    }
    ...
}

If an error is encountered before the last message during intermediate
descriptor preparation (like a failure in dma_map_single), the unmap loop
won't reach gi2c->num_msgs - 1.

This leaves the arrays allocated, and since the tracking pointers are
cleared by a memset() at the start of the next transfer, this memory
is permanently leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705134619.4030=
745-1-aniket.randive@oss.qualcomm.com?part=3D1
