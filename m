Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26141C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 459D610E06B;
	Fri, 10 Jul 2026 16:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OKVAoDCr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C2310E06B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:25:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 261AE43830;
 Fri, 10 Jul 2026 16:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8691F000E9;
 Fri, 10 Jul 2026 16:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783700728;
 bh=xGgtpzBJX+tzW9t919oF1Q905X6LilNnXEJNrjToVOg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OKVAoDCrsjZSDuhV+SPtdEAkIbaMCFcuKU+KNZfgpbt2Y4yqp89/0VUYx/YM0F9U8
 PJ6k4ngnQBl0R6HfSSyWkT+R/VizBs827VyBtE3SZtzrH1kNbNNk5WtJncOwKbsxT2
 eKQyX5WbCqJd7Oj/STvLPT832tkqTJh0CnU5grc2P9KApIcpP+oq6dEuA2oVgIT4ii
 anCK3zExdugWuBAXohBBDylL00GTm6hpLDI4tjBV9fVND1M9ykG8SbBs8ErM3mqcVV
 wsO55xqDIx/y3QeU9pDjX2ZjPU9NfwePds7S8/IaX5SVhlgf1KTnmExHOC0rDkdOFT
 mcN4g4FUo+0ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
To: "Aniket Randive" <aniket.randive@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710161056.1799019-1-aniket.randive@oss.qualcomm.com>
References: <20260710161056.1799019-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 16:25:27 +0000
Message-Id: <20260710162527.DA8691F000E9@smtp.kernel.org>
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
- [High] The `mult_frac()` macro used to calculate `bit_usec` suffers from =
a 32-bit intermediate integer overflow on 32-bit platforms, undermining the=
 author's intent to prevent it.
- [High] The timeout calculated for multi-descriptor (GPI) transfers incorr=
ectly uses the maximum individual message length rather than the sum of all=
 queued message lengths, leading to premature timeouts for batches of small=
 messages.

Pre-existing issues:
- [High] The dynamically allocated `dma_buf` and `dma_addr` arrays for mult=
i-descriptor transfers are leaked permanently on early error paths.
- [High] Concurrent lockless calls to `reinit_completion()` during multi-de=
scriptor transfers can overwrite pending completions, leading to lost wakeu=
ps and transfer timeouts.
--

--- Patch [1]: [PATCH V4] i2c: qcom-geni: Add dynamic transfer timeout base=
d on transfer length and frequency ---
commit 6638d80f15522cd0e8e676c42f903f9ce0d7a55c
Author: Aniket Randive <aniket.randive@oss.qualcomm.com>
Subject: i2c: qcom-geni: Add dynamic transfer timeout based on transfer len=
gth and frequency

This commit introduces a dynamic timeout calculation for I2C transfers based
on message length and bus frequency. It replaces a static 1-second timeout
with a calculated timeout that includes a safety margin and a 300ms floor.
For multi-descriptor transfers, it applies the maximum message length across
the queued messages.

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index 96dbf04138bee..c5c3adc8ec771 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -204,6 +208,16 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev =
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
Does this mult_frac() calculation suffer from an intermediate integer
overflow on 32-bit platforms?

The size_t type and USEC_PER_SEC are both 32-bit on 32-bit architectures.
Because mult_frac(x, n, d) internally computes (x % d) * n / d, for a
large transfer the remainder term multiplied by 1,000,000 can easily exceed
U32_MAX and silently wrap. This would truncate the calculated timeout to a
value less than the theoretical wire time, causing valid large transfers
to spuriously time out.

> +	size_t xfer_max_usec =3D (bit_usec * I2C_TIMEOUT_SAFETY_COEFFICIENT) +
> +			       I2C_TIMEOUT_MIN_USEC;
> +
> +	return usecs_to_jiffies(xfer_max_usec);
> +}

[ ... ]

> @@ -601,13 +617,13 @@ static void geni_i2c_gpi_multi_desc_unmap(struct ge=
ni_i2c_dev *gi2c, struct i2c_
>   */
>  static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>  						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
> -						   u32 transfer_timeout_msecs,
> +						   unsigned long timeout_jiffies,
>  						   struct completion *transfer_comp)
>  {
>  	int i;
>  	u32 time_left;
> =20
>  	for (i =3D 0; i < multi_xfer->msg_idx_cnt - 1; i++) {
>  		reinit_completion(transfer_comp);

[Severity: High]
This is a pre-existing issue, but can this concurrent lockless call to
reinit_completion() cause lost wakeups?

During multi-descriptor transfers, reinit_completion() is called locklessly
in a loop here. Concurrently, the asynchronous DMA callback i2c_gpi_cb_resu=
lt()
can call complete(). Since reinit_completion() happens outside the waitqueue
lock, the process thread might write done =3D 0 and then read a stale irq_c=
nt,
causing it to evaluate msg_idx_cnt !=3D irq_cnt as true and block on
wait_for_completion_timeout() indefinitely.

>  		if (multi_xfer->msg_idx_cnt !=3D multi_xfer->irq_cnt) {
>  			time_left =3D wait_for_completion_timeout(transfer_comp,
> -								transfer_timeout_msecs);
> +								timeout_jiffies);
>  			if (!time_left) {
>  				dev_err(dev, "%s: Transfer timeout\n", __func__);
>  				return -ETIMEDOUT;

[ ... ]

> @@ -736,8 +752,16 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, s=
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
Will this timeout calculation cause spurious timeouts for batches of small
messages?

When a multi-descriptor transfer is submitted, the process thread blocks
on the first iteration of geni_i2c_gpi_multi_xfer_timeout_handler() for
the entire batch duration. However, the timeout here is calculated using
only the maximum individual message length instead of the sum of all queued
message lengths. If a batch contains many small messages, the actual wire t=
ime
can exceed this calculated timeout, leading to premature timeouts.

> +			ret =3D geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gp=
i_xfer,
> -								      XFER_TIMEOUT, &gi2c->done);
> +								      timeout, &gi2c->done);
>  			if (ret) {
>  				dev_err(gi2c->se.dev,

[ ... ]

A related pre-existing issue exists in the unmap path:

drivers/i2c/busses/i2c-qcom-geni.c:geni_i2c_gpi_multi_desc_unmap() {
    ...
    if (tx_multi_xfer->unmap_msg_cnt =3D=3D gi2c->num_msgs - 1) {
        kfree(tx_multi_xfer->dma_buf);
        kfree(tx_multi_xfer->dma_addr);
        break;
    }
    ...
}

[Severity: High]
This is a pre-existing issue, but does this logic permanently leak the
dynamically allocated dma_buf and dma_addr arrays on early error paths?

If an error occurs or a timeout happens before all messages are successfully
processed, the loop bounds will exit before unmap_msg_cnt reaches
num_msgs - 1. This causes the kfree() block to be completely skipped.
Since the structure is zeroed out on subsequent runs, the pointers are
permanently lost, which can lead to memory exhaustion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710161056.1799=
019-1-aniket.randive@oss.qualcomm.com?part=3D1
