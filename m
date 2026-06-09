Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A99CD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E113510E103;
	Tue,  9 Jun 2026 06:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MD6YR5gV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B642210E103
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:57:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14620601DC;
 Tue,  9 Jun 2026 06:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905CA1F00893;
 Tue,  9 Jun 2026 06:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780988231;
 bh=OIgKjvdnvYDeBEn7hCwDPPVa7/Bt1BfSSqlFgrBxFPI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MD6YR5gVjMI4PhCo6b/EgxiGMybyNVxctK0XP/Y8qTy+IxK0KQDhAg416qcTFrOAq
 I1KIJ4RoSW8O+9UESg1XKCZB9VV5eNZ9dahmL0ctrXCDsFC+3jARWEg8hNMib9IOUM
 BgmtrYcEPz1HsotCPxf0mHY7bXooEYRAwI8YoErRL2yH0Ho8Re+9shF/gx9nYi00Hb
 XAL0/3Q9egmywdF86LQI35UifnwtpCng94QjWPlzsJyxLgDPle2TKU0Ty3Cb/PunOS
 X94GvUUjhZ381ec/TP43Gq1TIFYmZtNW8RlLBXCa1YiuFzB6OcrQ1/v53i3G5Jt/Cp
 eAJ3DcC00QR5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/14] spi: stm32-ospi: Open-code message transfer walk
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609062526.94907-6-kaitao.cheng@linux.dev>
References: <20260609062526.94907-6-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:57:10 +0000
Message-Id: <20260609065711.905CA1F00893@smtp.kernel.org>
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
- [Critical] A valid SPI message containing a transfer with length > 0 but =
both `tx_buf` and `rx_buf` set to NULL will cause a kernel crash when the d=
river dereferences the NULL buffer during FIFO writes.
- [High] Early error returns in `stm32_ospi_transfer_one_message` fail to f=
inalize the SPI message, resulting in a permanent hang for callers.
--

commit 77e013496da647c31add0f5085a07d31c7c250b2
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

spi: stm32-ospi: Open-code message transfer walk

This commit modifies stm32_ospi_transfer_one_message() to open-code the
list iteration over message transfers. It prepares the loop to observe
cursor updates explicitly, anticipating a later list iterator update.

> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index 3757f6ba8fc61..fe92bb06251be 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -674,7 +674,9 @@ static int stm32_ospi_transfer_one_message(struct spi=
_controller *ctrl,

[Severity: High]
This is a pre-existing issue, but do the early error returns in
stm32_ospi_transfer_one_message() fail to finalize the SPI message?

If cs_gpiod is null or pm_runtime_resume_and_get() fails, the function
returns early:

	if (!cs_gpiod)
		return -EOPNOTSUPP;

	ret =3D pm_runtime_resume_and_get(ospi->dev);
	if (ret < 0)
		return ret;

Since these paths bypass spi_finalize_current_message(), does this leave
the SPI core waiting indefinitely and cause a deadlock for callers?

[Severity: High]
This is also a pre-existing issue, but can this driver crash if an SPI
message contains a dummy transfer with both tx_buf and rx_buf set to NULL?

The SPI core allows dummy transfers with both buffers set to NULL. If a
transfer reaches stm32_ospi_transfer_one_message() without the dummy_data
flag set, the driver defaults to a write operation and assigns the NULL
tx_buf to the operation:

		} else {
			ospi->fmode =3D CR_FMODE_INDW;
			op.data.buswidth =3D transfer->tx_nbits;
			op.data.dir =3D SPI_MEM_DATA_OUT;
			op.data.buf.out =3D transfer->tx_buf;
		}

This eventually leads to stm32_ospi_send() and stm32_ospi_xfer(). Because
DMA mapping of a NULL pointer fails, it falls back to PIO mode by calling
stm32_ospi_poll().

Inside stm32_ospi_poll(), the stm32_ospi_write_fifo() callback is invoked,
which dereferences the NULL pointer directly:

	switch (len) {
	case sizeof(u32):
		writel_relaxed(*((u32 *)val), addr);
		break;

Could this trigger a kernel panic and allow a local denial of service?

> =20
>  	gpiod_set_value_cansleep(cs_gpiod, true);
> =20
> -	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
> +	for (transfer =3D list_first_entry(&msg->transfers, typeof(*transfer), =
transfer_list);
> +	     !list_entry_is_head(transfer, &msg->transfers, transfer_list);
> +	     transfer =3D list_next_entry(transfer, transfer_list)) {
>  		u8 dummy_bytes =3D 0;
> =20
>  		memset(&op, 0, sizeof(op));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609064122.9582=
5-1-kaitao.cheng@linux.dev?part=3D8
