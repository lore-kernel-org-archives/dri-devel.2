Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B96C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7EB10E60E;
	Mon, 31 Aug 2026 15:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AAycV00L";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5437A10E60E
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:04:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E45254147B
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C1F1F000E9;
 Mon, 31 Aug 2026 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788188690;
 bh=P2c6goA5+80knEoVcMBJR7RXjCNn9+NOCK97ZmhQyPk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AAycV00Lu3WDZgXHXg/inPi3VFauTD6D0fP1EKltJ5cbQZiKDvWMIKQ/fd4v+b1Yw
 W+s0npwkslhaVsZ8SBGKLZF0c8+BxV96dwRmwgeukMgc+hSyPCHeb1GRmhcS0o8nJZ
 VGUzSkVbmviIVZ8TLaX9l6zVJf/jvwxsfJY2VCWSrt6uXKWAiqPkL/4SFdejUMclWO
 +XaB6MIHEcec1N96LCQEF4nCge5bPwj8Jg2pFfY8U2LVk6yPhKjfhGFy2gbmMBNQVO
 Kk+lbpOjhXy+AnK9irDXZwPpIoZp2YOC/Z16TCZV0tib3bW1zqiHpG3AVJheCiTroX
 knNtQbJ+Bd2ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] drm/gma500: return errors from
 Oaktrail HDMI I2C reads
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-219-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-219-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:04:50 +0000
Message-Id: <20260831150450.A6C1F1F000E9@smtp.kernel.org>
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

New issues:
- [High] Returning early from `xfer_read()` on timeout or signal abandons t=
he active hardware I2C transaction and leaves `i2c_dev->msg` as a dangling =
pointer, leading to a Use-After-Free and memory corruption.

Pre-existing issues:
- [High] `hdmi_i2c_read()` unconditionally writes 64 bytes to `msg->buf` wi=
thout checking the requested transfer length (`msg->len`), allowing hardwar=
e to overflow the I2C message buffer.
- [High] In the module teardown path, `i2c_dev` is freed before the shared =
IRQ handler is unregistered, causing a Use-After-Free if an interrupt fires.
--

commit 605dc1b5dc9a1628f90b0022526c86a3c3636916
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm/gma500: return errors from Oaktrail HDMI I2C reads

This commit modifies xfer_read() to return -ETIMEDOUT or negative error cod=
es
on timeout or signal instead of ignoring them. It also updates
oaktrail_hdmi_i2c_access() to propagate the first transfer error instead of
reporting a successful message count.

Link: https://patch.msgid.link/20260625003240.6923-1-pengpeng@iscas.ac.cn

> diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c b/drivers/gpu/drm=
/gma500/oaktrail_hdmi_i2c.c
> --- a/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
> @@ -106,9 +107,14 @@ static int xfer_read(struct i2c_adapter *adap, struc=
t i2c_msg *pmsg)
>  	HDMI_WRITE(HDMI_HI2CHCR, temp);
>  	HDMI_READ(HDMI_HI2CHCR);
> =20
> -	while (i2c_dev->status !=3D I2C_TRANSACTION_DONE)
> -		wait_for_completion_interruptible_timeout(&i2c_dev->complete,
> +	while (i2c_dev->status !=3D I2C_TRANSACTION_DONE) {
> +		ret =3D wait_for_completion_interruptible_timeout(&i2c_dev->complete,
>  								10 * HZ);
> +		if (ret < 0)
> +			return ret;
> +		if (!ret)
> +			return -ETIMEDOUT;
> +	}

[Severity: High]
Does returning early here abandon the active hardware I2C transaction and
leave i2c_dev->msg as a dangling pointer?

If wait_for_completion_interruptible_timeout() returns early due to a
timeout or signal, xfer_read() returns the error without clearing
HI2C_ENABLE_TRANSACTION on the hardware or setting i2c_dev->msg to NULL.

oaktrail_hdmi_i2c_access() disables the device IRQ and returns the error,
freeing the user buffer.

If the hardware finishes the transaction in the background, a subsequent I2C
transfer calls hdmi_i2c_irq_enable(), unmasking the interrupt before
xfer_read() updates i2c_dev->msg.

The pending interrupt fires immediately, and hdmi_i2c_read() dereferences t=
he
stale i2c_dev->msg pointer, overwriting freed memory.

[ ... ]

While reviewing this code, I noticed a couple of pre-existing issues in
drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c:

[Severity: High]
This is a pre-existing issue, but does hdmi_i2c_read() unconditionally write
64 bytes to msg->buf without checking the requested transfer length?

drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c:hdmi_i2c_read() {
...
	for (i =3D 0; i < 0x10; i++) {
		temp =3D HDMI_READ(HDMI_HI2CRDB0 + (i * 4));
		memcpy(buf + (offset + i * 4), &temp, 4);
	}
...
}

If a user issues an I2C_RDWR ioctl with a read message where msg->len is le=
ss
than 64 (e.g., 1 byte), the I2C core allocates a smaller buffer for msg->bu=
f.

When the hardware fires the FULL interrupt, hdmi_i2c_read() reads 4 bytes p=
er
iteration and copies 64 bytes to msg->buf, which could overflow the allocat=
ed
buffer bounds and corrupt adjacent heap memory.


[Severity: High]
This is a pre-existing issue, but is there a use-after-free race condition =
in
the module teardown path?

drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c:oaktrail_hdmi_i2c_exit() {
...
	i2c_dev =3D hdmi_dev->i2c_dev;
	kfree(i2c_dev);
	free_irq(dev->irq, hdmi_dev);
...
}

The teardown logic frees i2c_dev before unregistering the shared interrupt
handler.

Since the IRQ is registered with IRQF_SHARED, if another device sharing the
IRQ line fires an interrupt before free_irq() runs,
oaktrail_hdmi_i2c_handler() executes and dereferences i2c_dev->complete on
the freed structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-219-sashal@kernel.org?part=3D1
