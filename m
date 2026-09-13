Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C419C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F5010E12C;
	Sun, 13 Sep 2026 21:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cqF7SEVU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D933410E12C
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:44:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A1B1E40142;
 Sun, 13 Sep 2026 21:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639251F000FF;
 Sun, 13 Sep 2026 21:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789335891;
 bh=84CRFCAFk/O0TSbZ16kA+QYc+i7fcu/uq1/mL93dlLM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cqF7SEVUFouAF3o9sfTje8l5MFJOIDu8JbP4mRppocYqojGTZQvo3BOpeM3Ybq9A5
 g6FRMX4bu2V26/eLvPvYbDeV3ds2J/n++3AFcBaXK7WI7NGMx20BK1jYCK9JBFjABV
 uOz+rOzi21zXiXiEo+u6LjJYm3XZ3ZIQSPuv0nQf2VrIWzBWVBzaJyGiUlUt3zUGtt
 AgnKDSivQw40hwNin9287zuUqhEx1WRpE86Wxhb5P7SNWV1bZrBOVpH3cy46JVxQRw
 wLh2KQevhHkcIB5cxo7wJIy9VQlzq+JBeGAR1KRfOO71WFOufx6i/B3i2hgoLRSlrw
 p0ilDrKXKhV4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] accel/amdxdna: bound the firmware-supplied
 mailbox register offsets
To: "Eva Crystal" <0xiviel@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <cddcbf5989cdbf6da94855152a34451ffa07860b.1789334558.git.0xiviel@gmail.com>
References: <cover.1789334558.git.0xiviel@gmail.com>
 <cddcbf5989cdbf6da94855152a34451ffa07860b.1789334558.git.0xiviel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 21:44:50 +0000
Message-Id: <20260913214451.639251F000FF@smtp.kernel.org>
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
- [High] The firmware-supplied ring buffer offsets (`rb_start_addr`) and si=
zes (`rb_size`) are not validated against the mapped ring buffer size, leav=
ing the driver vulnerable to out-of-bounds MMIO accesses.
- [High] Initial ring buffer head and tail pointers read from firmware are =
not validated against the ring buffer bounds upon channel start.
--

commit e583a0672be522b7766ae36362808346f5791f45
Author: Eva Crystal <0xiviel@gmail.com>

accel/amdxdna: bound the firmware-supplied mailbox register offsets

This patch adds bounds checking for firmware-supplied mailbox register
offsets against the device's mailbox window size. It aims to secure the=20
trust boundary between the driver and firmware by preventing out-of-bounds=
=20
kernel MMIO accesses through the mailbox mapping.

> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdx=
dna/amdxdna_mailbox.c
> index cc8865f4e79c9..a390836fe797c 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c

[ ... ]

> @@ -518,6 +545,16 @@ xdna_mailbox_start_channel(struct mailbox_channel *m=
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
This isn't a bug introduced by this patch, but while this secures the mailb=
ox
register offsets, does it overlook the ring buffer offsets and sizes?

In xdna_mailbox_start_channel(), the firmware-supplied channel resources are
checked here, but rb_start_addr and rb_size are not validated against the
mapped ringbuf_size. This can lead to out-of-bounds writes later:

drivers/accel/amdxdna/amdxdna_mailbox.c:mailbox_send_msg() {
    ...
    write_addr =3D mb_chann->mb->res.ringbuf_base + start_addr + tail;
    memcpy_toio(write_addr, &mb_msg->pkg, mb_msg->pkg_size);
    ...
}

Could a compromised firmware provide maliciously large rb_start_addr or=20
rb_size values, causing out-of-bounds MMIO accesses when calculating=20
write_addr?


[Severity: High]
This is also a pre-existing issue, but does this function also need to
validate the initial head and tail pointers read from the firmware?

Right after the new checks in xdna_mailbox_start_channel(), the driver cach=
es
the initial pointers directly from the firmware:

drivers/accel/amdxdna/amdxdna_mailbox.c:xdna_mailbox_start_channel() {
    ...
    mb_chann->x2i_tail =3D mailbox_get_tailptr(mb_chann, CHAN_RES_X2I);
    mb_chann->i2x_head =3D mailbox_get_headptr(mb_chann, CHAN_RES_I2X);
    ...
}

If a maliciously large initial tail index is read, could it force an=20
out-of-bounds write in mailbox_send_msg() before normal wrap-around checks=
=20
occur?

drivers/accel/amdxdna/amdxdna_mailbox.c:mailbox_send_msg() {
    ...
    write_addr =3D mb_chann->mb->res.ringbuf_base + start_addr + tail;
    writel(TOMBSTONE, write_addr);
    ...
}

Should we bound check x2i_tail and i2x_head against rb_size during channel
initialization?

> +		dev_err(mb_chann->mb->dev,
> +			"Mailbox register offset unaligned or outside the %zu byte mapping\n",
> +			mb_chann->mb->res.mbox_size);
> +		return -EINVAL;
> +	}
> +
>  	mb_chann->msix_irq =3D mb_irq;
>  	mb_chann->iohub_int_addr =3D iohub_int_addr;
>  	memcpy(&mb_chann->res[CHAN_RES_X2I], x2i, sizeof(*x2i));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789334558.gi=
t.0xiviel@gmail.com?part=3D2
