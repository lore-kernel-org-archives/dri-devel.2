Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0A3CD8CAE
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8BDF10E102;
	Tue,  9 Jun 2026 06:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NLCsZ19G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7B310E102
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:55:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F086844047;
 Tue,  9 Jun 2026 06:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B861F00893;
 Tue,  9 Jun 2026 06:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780988127;
 bh=O8/28jK+1pApKhF9qrm0Nwhq+8IlIKdje4ROdSVk5jM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NLCsZ19GGxnrOLD/W4IPOvqWVEcwmHsI7ZYelLjVYMYZQiDJXleqD8Pn8XYxtFAeg
 NRaG9RXwR+B0WDUlwNkd3LDrvjV5/+KJg6cd9XzVExiAnPzvaerXGQSWNq3qiMjRdp
 9perlEQeAekO+OAeGBCeyL/p9UPwpa+u0aFcB3Ev+e9u3VfLRQczJhdTU3B4gYAfXP
 2T3ya4iEfdC3bDTsGuuBcjTOdsRsKe1Pxu2KyWVJF0YI141lT8KpD/bvH14yDB61yT
 Zg+brTtZbNn9GCX+06nJnepU2lWtwL77/BbJvMOxwES14usPFowLJ8hoI4DkJh+1b8
 JMXFnNU7Utaaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/14] spi: stm32-qspi: Open-code message transfer walk
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609062526.94907-7-kaitao.cheng@linux.dev>
References: <20260609062526.94907-7-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:55:26 +0000
Message-Id: <20260609065527.A4B861F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Early returns in `stm32_qspi_transfer_one_message` fail to call `s=
pi_finalize_current_message()`, leaking the SPI message and hanging the cal=
ler.
- [High] The driver mishandles SPI transfers where both `tx_buf` and `rx_bu=
f` are NULL but `len > 0`, causing a NULL pointer dereference.
--

commit 0feb4c5cf513d6c2af724ffe0a636c0f0b92a880
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

spi: stm32-qspi: Open-code message transfer walk

A later change will make list_for_each_entry() cache the next element
before entering the loop body. stm32_qspi_transfer_one_message() can
consume the following transfer as part of the current operation and then
advance the loop cursor to that entry.

Keep the transfer walk open-coded so the loop step observes that cursor
update and skips the consumed transfer. This preserves the existing
message sequencing semantics and prepares the code for the list iterator
update.

> diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
> index ea69fe25686f3..e264fee2bd2d7 100644
> --- a/drivers/spi/spi-stm32-qspi.c
> +++ b/drivers/spi/spi-stm32-qspi.c
> @@ -576,7 +576,10 @@ static int stm32_qspi_transfer_one_message(struct sp=
i_controller *ctrl,
> =20
>  	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), true);
> =20
> -	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
> +	for (transfer =3D list_first_entry(&msg->transfers,
> +					 typeof(*transfer), transfer_list);
> +	     !list_entry_is_head(transfer, &msg->transfers, transfer_list);
> +	     transfer =3D list_next_entry(transfer, transfer_list)) {
>  		u8 dummy_bytes =3D 0;
> =20
>  		memset(&op, 0, sizeof(op));

[Severity: High]
This is a pre-existing issue, but I noticed early returns in
stm32_qspi_transfer_one_message() might fail to call
spi_finalize_current_message() and leak the SPI message:

	if (!spi_get_csgpiod(spi, 0))
		return -EOPNOTSUPP;

	ret =3D pm_runtime_resume_and_get(qspi->dev);
	if (ret < 0)
		return ret;

Could these early returns cause spi_sync() to hang indefinitely on
wait_for_completion() and permanently lock the SPI bus? Should we arrange f=
or
spi_finalize_current_message() to be called in these error paths?


[Severity: High]
This isn't a bug introduced by this patch, but there might be an issue with
how the driver handles SPI transfers where both tx_buf and rx_buf are NULL
but len > 0. In stm32_qspi_transfer_one_message():

		} else {
			qspi->fmode =3D CCR_FMODE_INDW;
			op.data.buswidth =3D transfer->tx_nbits;
			op.data.dir =3D SPI_MEM_DATA_OUT;
			op.data.buf.out =3D transfer->tx_buf;
		}

If a local user sends a message via spidev with tx_buf =3D 0, rx_buf =3D 0,=
 and
len > 0, the driver assumes it is a transmit operation and assigns
op.data.buf.out to NULL.

Does the operation then fall back to stm32_qspi_tx_poll() which loops over
len, and since the transmit FIFO is empty, immediately satisfies the FIFO
Threshold Flag?

If so, could this result in dereferencing the NULL buf pointer in
stm32_qspi_tx_poll():

		fifo(buf, qspi->io_base + QSPI_DR, step);
		len -=3D step;
		buf +=3D step;

and triggering a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609064122.9582=
5-1-kaitao.cheng@linux.dev?part=3D9
