Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416E8C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728EE10E027;
	Thu,  9 Jul 2026 06:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TtB08VwX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A07210E027
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:18:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BF7443625;
 Thu,  9 Jul 2026 06:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E262A1F000E9;
 Thu,  9 Jul 2026 06:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783577913;
 bh=2Z+/xW1K97dhwPD6e8oAPPMReBcz8lfz6ijMBK3xyQg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TtB08VwXhZHCAT9k/gR7oqbhdRCOkMEyXYYJGU4PweTM+Uk80SRjcRyvvnjaVcs9d
 /78wRjsDTlIPOFtFQXTT62BEvbQyWmW3FQLm+Z+FPjDjT9kBLUfWv6A+jsi9/jYK2K
 F7TPSMXQtSqW38pe4Xs5KJhC4fST18lqd73+Me6QMBui7sNSlCKcX4S7x7BeErazxW
 FKVCdCq+8TIUEZmahQhtsO11f7kJxspG1txTMAHGgBahuhZ484cXsWR+SlNZcJgy4R
 Sr9/OEdLVMXhongDWhq7bkimfMMSkfw69xl90aLNDUK2gvOucgzhhPxGiZycea1TJT
 cWOFm1GJFRJSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
To: "Aniket Randive" <aniket.randive@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709060521.4091523-1-aniket.randive@oss.qualcomm.com>
References: <20260709060521.4091523-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:18:32 +0000
Message-Id: <20260709061832.E262A1F000E9@smtp.kernel.org>
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
- [High] Dynamic timeout calculation causes an integer overflow on 32-bit a=
rchitectures for large transfers, leading to premature timeouts.
- [High] Multi-descriptor transfer timeout calculation uses `max_len` inste=
ad of total transfer length, causing premature timeouts for batches.
- [Low] Mismatch between kernel-doc comment and function signature for `gen=
i_i2c_gpi_multi_xfer_timeout_handler`.

Pre-existing issues:
- [High] Data race and missed wakeup in `geni_i2c_gpi_multi_xfer_timeout_ha=
ndler` due to lockless `reinit_completion` without memory barriers.
--

--- Patch [1]: [PATCH v3] i2c: qcom-geni: Add dynamic transfer timeout base=
d on transfer length and frequency ---
commit d129d3fb4c6f62c77ad085c820aa98f9027086bf
Author: Aniket Randive <aniket.randive@oss.qualcomm.com>
i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and f=
requency

This commit replaces the static 1-second transfer timeout with a dynamically
computed timeout based on message length and bus frequency. It aims to redu=
ce
unnecessary delays on error paths while adding a safety margin and a 300ms
floor. For multi-descriptor transfers, it computes the per-completion
timeout using the maximum message length in the batch.

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index 96dbf04138bee..d43db77b36781 100644
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
Can this calculation overflow on 32-bit architectures? Since size_t and
USEC_PER_SEC are 32-bit values on these platforms, does a transfer length o=
f=20
478 bytes or more silently wrap around and result in a prematurely small
timeout?

> +	size_t xfer_max_usec =3D (bit_usec * I2C_TIMEOUT_SAFETY_COEFFICIENT) +
> +			       I2C_TIMEOUT_MIN_USEC;
> +
> +	return usecs_to_jiffies(xfer_max_usec);
> +}
> +
[ ... ]
> @@ -591,7 +606,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni=
_i2c_dev *gi2c, struct i2c_
>   * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message tra=
nsfer timeout
>   * @dev: Pointer to the corresponding dev node
>   * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
> - * @transfer_timeout_msecs: Timeout value in milliseconds
> + * @transfer_timeout_msecs: Per-message completion timeout in jiffies

[Severity: Low]
Is the kernel-doc parameter name mismatched here? The function signature
below updates the parameter name to timeout_jiffies.

>   * @transfer_comp: Completion object of the transfer
>   *
>   * This function waits for the completion of each processed transfer mes=
sages
> @@ -601,7 +616,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni=
_i2c_dev *gi2c, struct i2c_
>   */
>  static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>  						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
> -						   u32 transfer_timeout_msecs,
> +						   unsigned long timeout_jiffies,
>  						   struct completion *transfer_comp)
>  {
>  	int i;
> @@ -612,7 +627,7 @@ static int geni_i2c_gpi_multi_xfer_timeout_handler(st=
ruct device *dev,
> =20
>  		if (multi_xfer->msg_idx_cnt !=3D multi_xfer->irq_cnt) {

[Severity: High]
This is a pre-existing issue, but does this sequence lack memory barriers?=
=20
Could the lockless read of multi_xfer->irq_cnt be reordered before the store
to done in the preceding reinit_completion(transfer_comp) call, potentially
causing a missed wakeup and subsequent hang?

>  			time_left =3D wait_for_completion_timeout(transfer_comp,
> -								transfer_timeout_msecs);
> +								timeout_jiffies);
>  			if (!time_left) {
>  				dev_err(dev, "%s: Transfer timeout\n", __func__);
>  				return -ETIMEDOUT;
> @@ -736,8 +751,16 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, s=
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
Since the hardware takes time proportional to the sum of all message length=
s,
does calculating the timeout based only on max_len cause premature timeouts
for batches containing many messages?

>  			ret =3D geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gp=
i_xfer,
> -								      XFER_TIMEOUT, &gi2c->done);
> +								      timeout, &gi2c->done);
>  			if (ret) {
>  				dev_err(gi2c->se.dev,
>  					"I2C multi write msg transfer timeout: %d\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709060521.4091=
523-1-aniket.randive@oss.qualcomm.com?part=3D1
