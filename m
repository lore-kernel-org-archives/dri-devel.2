Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC72C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C241810E69E;
	Thu,  9 Jul 2026 06:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JsPSxu3S";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4EE10E69E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:12:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C6A8600C3;
 Thu,  9 Jul 2026 06:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332421F00A3D;
 Thu,  9 Jul 2026 06:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783577568;
 bh=iZ/NhgphlnpmqtQPc55pU7KxcS+OQu2BvFqDSJ2X6UA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JsPSxu3SvKVuXsKfIlv1cBmJO+h27vYXw5D1jQOEw6nvXaxOU2mVjCXcsGuQZ2ZMk
 K6/g0izPjYyTPJzI44P/0LQm2v3lTrTl9UaUVTivYlT6cJsU4EIT2pVXLQcY7n5Eev
 A2NH2FaCTM4sRIWMHpqiUUqMiVwMoSqqVicd4fv8apv/qEkmttKEihh1BzdLVqvHYk
 tR9n+bb5y+T87r/Pkj2wOSQulDJhn7pQ2ddqKU8/Dogf0+3xt9sNT+5wDyhSXExopg
 37tFr5xBbGcVCO0iLyYsWttzq5VZlM9Or4pINT0sv2F5oyN9QkeAMYFExwvw/R0tSj
 CW3c1l00C4aZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
To: "Aniket Randive" <aniket.randive@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709055958.4089039-1-aniket.randive@oss.qualcomm.com>
References: <20260709055958.4089039-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:12:47 +0000
Message-Id: <20260709061248.332421F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The calculation of `bit_usec` can overflow `size_t` on 32-bit arch=
itectures for large I2C transfers, leading to drastically reduced timeouts.
- [High] GPI multi-descriptor timeout relies on the maximum single message =
length rather than the total transfer length, causing premature timeouts fo=
r batched transfers.
--

--- Patch [1]: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout base=
d on transfer length and frequency ---
commit 347c92514f9af6dc3f13bb2e23106b1dc0aa2e87
Author: Aniket Randive <aniket.randive@oss.qualcomm.com>

i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and f=
requency

This commit replaces the static 1-second timeout for I2C transfers with a
dynamic calculation based on message length and bus frequency. It uses a 10x
safety margin with a 300ms floor, and applies the maximum message length for
batched multi-descriptor transfers.

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index 96dbf04138bee..d43db77b36781 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
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
Can this calculation overflow size_t on 32-bit architectures?

Since size_t is 32 bits on 32-bit platforms, the intermediate result of
bit_cnt * USEC_PER_SEC can exceed the 32-bit maximum before the division
takes place.

If a message is larger than 477 bytes, bit_cnt becomes greater than 4293.
Multiplying that by 1,000,000 overflows the 32-bit value, which truncates
the result.

This could lead to drastically reduced timeouts and premature -ETIMEDOUT
failures for large I2C transfers.

> +	size_t xfer_max_usec =3D (bit_usec * I2C_TIMEOUT_SAFETY_COEFFICIENT) +
> +			       I2C_TIMEOUT_MIN_USEC;
> +
> +	return usecs_to_jiffies(xfer_max_usec);
> +}
> +

[ ... ]

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
>  			ret =3D geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gp=
i_xfer,
> -								      XFER_TIMEOUT, &gi2c->done);
> +								      timeout, &gi2c->done);

[Severity: High]
Does this timeout calculation correctly account for the time required to
transmit all messages in a batched multi-descriptor transfer?

The loop calculates max_len based on the longest single message in the
chain. However, the hardware processes the entire batch of messages
sequentially.

Because DMA_PREP_INTERRUPT is typically only set on the final message
in geni_i2c_gpi(), the completion handler blocks in
wait_for_completion_timeout() while waiting for the entire batch to finish
transmitting.

If a batch contains many messages, the cumulative transmission time might
exceed the 10x safety margin of the single largest message, resulting in a
spurious transfer timeout.

>  			if (ret) {
>  				dev_err(gi2c->se.dev,
>  					"I2C multi write msg transfer timeout: %d\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709055958.4089=
039-1-aniket.randive@oss.qualcomm.com?part=3D1
