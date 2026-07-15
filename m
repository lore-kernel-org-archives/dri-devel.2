Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF48C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1EF10EFB0;
	Wed, 15 Jul 2026 10:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g7heWBPC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B72B10EFA4
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:32:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D32643342;
 Wed, 15 Jul 2026 10:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9971F000E9;
 Wed, 15 Jul 2026 10:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784111534;
 bh=IEaTMro6D5oiVHLyiUTdBwefd7VHswLt6gRFU/gRM/Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g7heWBPCobjk0aIIm4KIZIah0SeRYMrYduI2G6d004bdHCTZYOesqljZRfrhFaJIg
 GcNkYu8FHiPXXbPBSKzC7Cp/bsWv8/gKfQbzxSzQNT0cioO4o+0jWk/TmtxRo4mp/u
 tBrEruUiulbo5EjKC1UhqN8SM+ql/7z6IiJoHtSFFg2ynr4LedYxrZRNZXxrjyPQi0
 TQNylkL4ksm+VSK9W2IaqWw973Ma+a7+PhUro0Ev6iQbzxiZ1ilkeI7P+CqTLB2nW/
 4602cMmU1oKXWjOc69NdmFVlWngYSvxhpqaa3xhBVqFYz1MN1OT/B/A9Q+7lsYztUY
 ksi1Md6jP1afw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
To: "Aniket Randive" <aniket.randive@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260715101805.3615166-1-aniket.randive@oss.qualcomm.com>
References: <20260715101805.3615166-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 10:32:13 +0000
Message-Id: <20260715103214.0F9971F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] A 32-bit integer overflow in `mult_frac()` causes the calculated t=
imeout to be severely truncated on 32-bit targets for moderately large I2C =
transfers, leading to premature aborts.
- [High] For multi-descriptor transfers, the timeout is incorrectly calcula=
ted based solely on the maximum single message length rather than the sum o=
f all message lengths in the batch.
- [Low] The kernel-doc block for `geni_i2c_gpi_multi_xfer_timeout_handler` =
has an outdated parameter name, causing a kernel-doc warning.
--

--- Patch [1]: [PATCH V5] i2c: qcom-geni: Add dynamic transfer timeout base=
d on transfer length and frequency ---
commit 99a3ffd517ce0554f8d902961d8c4336195d5457
Author: Aniket Randive <aniket.randive@oss.qualcomm.com>

i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and f=
requency

This patch replaces the static 1-second transfer timeout with a dynamic=20
timeout calculated from the message length and bus frequency. It adds a=20
300 ms floor for clock stretching and updates the GPI multi-descriptor=20
transfer to use a maximum message length timeout.

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index 96dbf04138bee..f011d2564cd20 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -204,6 +209,16 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev =
*gi2c)
>  	return -EINVAL;
>  }
> =20
> +static unsigned long geni_i2c_xfer_timeout(struct geni_i2c_dev *gi2c, si=
ze_t len)
> +{
> +	size_t bit_cnt =3D len * 9;
> +	size_t bit_usec =3D mult_frac(bit_cnt, USEC_PER_SEC, gi2c->clk_freq_out=
);

[Severity: High]
Can this cause an integer overflow on 32-bit architectures?

Looking at mult_frac(x, n, d), it calculates r * n_ / d_ where r is the
remainder of bit_cnt % gi2c->clk_freq_out and n_ is USEC_PER_SEC (1,000,000=
).

If size_t is 32-bit, r * USEC_PER_SEC will exceed U32_MAX for remainders
larger than 4294. This wraps around and results in a truncated timeout
that might prematurely abort valid large I2C transfers.

[ ... ]

> @@ -591,7 +608,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni=
_i2c_dev *gi2c, struct i2c_
>   * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message tra=
nsfer timeout
>   * @dev: Pointer to the corresponding dev node
>   * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
> - * @transfer_timeout_msecs: Timeout value in milliseconds
> + * @transfer_timeout_msecs: Per-message completion timeout in jiffies

[Severity: Low]
This isn't a bug, but the kernel-doc parameter name @transfer_timeout_msecs
was not updated to match the new function argument timeout_jiffies below,
which will cause a kernel-doc warning during compilation.

>   * @transfer_comp: Completion object of the transfer
>   *
>   * This function waits for the completion of each processed transfer mes=
sages
> @@ -601,7 +618,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni=
_i2c_dev *gi2c, struct i2c_
>   */
>  static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>  						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
> -						   u32 transfer_timeout_msecs,
> +						   unsigned long timeout_jiffies,
>  						   struct completion *transfer_comp)

[ ... ]

> @@ -736,8 +753,16 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, s=
truct i2c_msg msgs[],
>  		dma_async_issue_pending(gi2c->tx_c);
> =20
>  		if ((msg_idx =3D=3D (gi2c->num_msgs - 1)) || flags & DMA_PREP_INTERRUP=
T) {
> +			unsigned long timeout;
> +			size_t max_len =3D 0;
> +			int j;
> +
> +			for (j =3D 0; j < gi2c->num_msgs; j++)
> +				max_len =3D max_t(size_t, max_len, msgs[j].len);
> +
> +			timeout =3D geni_i2c_xfer_timeout(gi2c, max_len);

[Severity: High]
Will computing the timeout based on max_len cause multi-descriptor batches
to time out prematurely?

Since this is a Block Event Interrupt (BEI) DMA transfer, intermediate
interrupts are suppressed and the hardware will take time proportional to
the total sum of all message lengths in the batch.=20

Calculating the timeout using only the maximum single message length rather
than the cumulative length might result in a wait timeout that is shorter
than the physical wire time needed to transmit the entire batch.

>  			ret =3D geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gp=
i_xfer,
> -								      XFER_TIMEOUT, &gi2c->done);
> +								      timeout, &gi2c->done);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715101805.3615=
166-1-aniket.randive@oss.qualcomm.com?part=3D1
