Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0FEC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480B710E07C;
	Sun,  5 Jul 2026 14:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AQq33ub+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CACD10E07C
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 14:09:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7040441A29;
 Sun,  5 Jul 2026 14:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330431F000E9;
 Sun,  5 Jul 2026 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783260572;
 bh=FRer8d12dP4j8fk1IpJpJHENAP/CfnCO7gFFq8HSGno=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AQq33ub+7tzOCSADAHdsYV6HtWd92hOBRLa2/ucGbmVqHeVGb5vCAaU3Y4NLGrp6i
 NsNZC1l9AhoDB/lGH6sy0sWqpjhajttfANBpMYkI6D9QEn0zOPUlAr/bZ92PRAZzOQ
 Wqqeht7Qea55pYv5INsE1X01shmDuSs440el+3Bp43v34MFLhXJ+eYHVoA6d8qC3iG
 +scsjK/XkaCgU5aIyIuyg7+b02k/Q/zIfMnUwnDd51q2UDeMrPL3w44FfHJPTpz5fL
 C9Mi7kcQ6WaWhLS12JZWS2A3vff6h9PCDvBh/QQ7lvPW0PrNKLdQepwIosm8DfdMWZ
 RZsH6geQkvmAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
To: "Aniket Randive" <aniket.randive@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 14:09:31 +0000
Message-Id: <20260705140932.330431F000E9@smtp.kernel.org>
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
- [High] Integer overflow on 32-bit architectures in dynamic timeout calcul=
ation causes premature timeouts for large messages.
- [High] Multi-descriptor DMA transfers incorrectly calculate the batched t=
ransfer timeout using the maximum single message length rather than the agg=
regate transfer length, causing premature timeouts.
- [Low] Kernel-doc parameter name mismatch for `timeout_jiffies` in `geni_i=
2c_gpi_multi_xfer_timeout_handler`.
--

commit 7cdbc3fca002264681a23e9e8f274275a5451975
Author: Aniket Randive <aniket.randive@oss.qualcomm.com>

i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and f=
requency

The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
regardless of message length or bus frequency, causing unnecessary delays
on error paths. Compute the timeout dynamically from message length and
bus frequency.

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
Can this calculation overflow on 32-bit architectures?

If size_t is 32-bit, bit_cnt * USEC_PER_SEC can wrap around for large
I2C transfers, such as firmware uploads or EEPROM writes over 8KB. This
would produce a calculated timeout much smaller than the actual wire time,
causing operations to prematurely abort.

> +	size_t xfer_max_usec =3D (bit_usec * I2C_TIMEOUT_SAFETY_COEFFICIENT) +
> +			       I2C_TIMEOUT_MIN_USEC;
> +
> +	return usecs_to_jiffies(xfer_max_usec);
> +}

[ ... ]

>  * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message tran=
sfer timeout
>  * @dev: Pointer to the corresponding dev node
>  * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
> - * @transfer_timeout_msecs: Timeout value in milliseconds
> + * @transfer_timeout_msecs: Per-message completion timeout in jiffies

[Severity: Low]
This isn't a bug, but does the kernel-doc parameter name match the function
signature?

The comment documents transfer_timeout_msecs, but the function signature
below was changed to take timeout_jiffies.

>  * @transfer_comp: Completion object of the transfer
>  *
>  * This function waits for the completion of each processed transfer mess=
ages
> @@ -601,7 +614,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni=
_i2c_dev *gi2c, struct i2c_
>   */
>  static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>  						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
> -						   u32 transfer_timeout_msecs,
> +						   unsigned long timeout_jiffies,
>  						   struct completion *transfer_comp)

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
Does this calculate the timeout correctly for multi-descriptor batches?

For multi-descriptor transfers, the hardware processes the entire batch bef=
ore
raising a single interrupt on the final descriptor. Wait for completion use=
s a
timeout computed from max_len (the length of the single longest message).

If a batch contains many small messages, their cumulative wire time could
easily exceed the timeout calculated for the single longest message, leading
to premature timeouts. Should this calculate the sum of all message lengths
instead of taking the maximum?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705135739.4038=
826-1-aniket.randive@oss.qualcomm.com?part=3D1
