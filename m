Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F8BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46EEB10E5C6;
	Mon, 13 Jul 2026 12:42:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fqYCaxOi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C75F410E5C6
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:42:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B0C9C41B22;
 Mon, 13 Jul 2026 12:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAC21F000E9;
 Mon, 13 Jul 2026 12:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783946571;
 bh=DLOKfhMF9U39UQq9muQz486tYguO/0MmnNEfurD/sVQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fqYCaxOi03effUzQZfKSZcF2VHc7fh3Xj6I52F9B5Hh6LZEu/QMixgkdShZMkIfYk
 FyQhbzPge7tc4U5m9cufkRGP5OgBVQYhq27i2LuBvF103ASJNa14/FFzsHHrIRY4Q7
 1n4apn+NFXjNPbqqVtv7oWdIKleEnkKim4R1LV3mq5zrbBgeUD/SJFdKBaS6RA8i0s
 xbvCtfeRn1LnbpuMrRkmxYbLH0l7emyvGNp6bV8CdTluwXl5+He5raxBvVCZrJnGQk
 Y9UJF7YIvDRLsVvpCOtDmT8UZVNK7DtI3kItL9c2H0CJm2vsQiQSY8oO2+fpY10G9J
 0a1ycD+UtNJyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/19] media: meson: vdec: Fix vp9 header update
 failure on invalid payloads
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260713120840.17427-10-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-10-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:42:50 +0000
Message-Id: <20260713124251.5DAC21F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] Negative error code converted to massive positive integer bypa=
sses validation, leading to out-of-bounds DMA fetch and memory corruption.
- [High] Early return from `esparser_isr` bypasses hardware interrupt clear=
ing, leading to an unrecoverable IRQ storm and system lockup.
- [High] Using `break` inside `scoped_guard` escapes only the guard mechani=
sm, causing an infinite busy-wait loop when the worker queue is empty.

Pre-existing issues:
- [Critical] Implicit integer promotion of VP9 frame sizes allows crafting =
negative sizes to bypass bounds checks, causing a massive out-of-bounds hea=
p copy.
- [High] esparser worker accesses hardware registers and waitqueues without=
 taking the global lock, causing hardware state corruption across concurren=
t sessions.
- [High] VP9 frame size validation checks against maximum buffer capacity i=
nstead of actual payload size, allowing information disclosure of uninitial=
ized kernel memory.
--

--- Patch [9]: [PATCH v7 09/19] media: meson: vdec: Fix vp9 header update f=
ailure on invalid payloads ---
commit e42c61ef1ea850aa0156d3301824f682854a42da
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Fix vp9 header update failure on invalid payloads

Ensure vp9_update_header() returns an explicit error code on invalid or
malformed buffer payloads instead of silently returning zero.

> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/stagin=
g/media/meson/vdec/esparser.c
> --- a/drivers/staging/media/meson/vdec/esparser.c
> +++ b/drivers/staging/media/meson/vdec/esparser.c
> @@ -97,11 +97,15 @@ static int vp9_update_header(struct amvdec_core *core=
, struct vb2_buffer *buf)
>  	unsigned char *old_header =3D NULL;
> =20
>  	dp =3D (uint8_t *)vb2_plane_vaddr(buf, 0);
> +	if (!dp)
> +		return -EINVAL;

[Severity: Critical]
Does returning a negative error code here cause an issue in the caller?

Looking at esparser_queue(), it assigns the return value of=20
vp9_update_header() to payload_size and checks if (payload_size =3D=3D 0). =
If=20
this returns -EINVAL and the caller assigns the result to a u32 variable,=20
could the negative error code underflow to a massive positive integer (like=
=20
4294967274)?=20

This might completely bypass validation and be passed to=20
esparser_pad_start_code(), causing an out-of-bounds memset and out-of-bound=
s=20
DMA commands to the hardware.

>  	dsize =3D vb2_get_plane_payload(buf, 0);
> =20
> -	if (dsize =3D=3D vb2_plane_size(buf, 0)) {
> -		dev_warn(core->dev, "%s: unable to update header\n", __func__);
> -		return 0;
> +	if (dsize <=3D 0 || dsize > vb2_plane_size(buf, 0)) {
> +		dev_warn(core->dev, "%s: invalid payload size %d\n",
> +			 __func__, dsize);
> +		return -EINVAL;
>  	}
> =20

[ ... ]

> @@ -109,13 +113,16 @@ static int vp9_update_header(struct amvdec_core *co=
re, struct vb2_buffer *buf)
>  		num_frames =3D (marker & 0x7) + 1;
>  		mag =3D ((marker >> 3) & 0x3) + 1;
>  		mag_ptr =3D dsize - mag * num_frames - 2;
> -		if (dp[mag_ptr] !=3D marker)
> -			return 0;
> +		if (mag_ptr < 0 || dp[mag_ptr] !=3D marker)
> +			return -EINVAL;
> =20
>  		mag_ptr++;
>  		for (cur_frame =3D 0; cur_frame < num_frames; cur_frame++) {
>  			frame_size[cur_frame] =3D 0;
>  			for (cur_mag =3D 0; cur_mag < mag; cur_mag++) {
> +				if (mag_ptr >=3D dsize)
> +					return -EINVAL;
> +
>  				frame_size[cur_frame] |=3D
>  					(dp[mag_ptr] << (cur_mag * 8));

[Severity: Critical]
This isn't a bug introduced by this patch, but does this shift operation=20
cause an implicit sign extension?

Because dp is a pointer to u8, the byte at dp[mag_ptr] undergoes integer=20
promotion to a signed int before shifting. If cur_mag is 3 and the byte is=
=20
128 or larger, shifting it by 24 bits produces a negative value due to the=
=20
sign bit.

Could this allow crafting combinations of large positive and negative=20
frame_size values so their sum wraps around to a small positive integer,=20
bypassing the bounds check later on and causing a massive out-of-bounds=20
memmove()?

>  				mag_ptr++;
>  			}

[ ... ]

> @@ -140,7 +147,7 @@ static int vp9_update_header(struct amvdec_core *core=
, struct vb2_buffer *buf)
> =20
>  	if (new_frame_size >=3D vb2_plane_size(buf, 0)) {
>  		dev_warn(core->dev, "%s: unable to update header\n", __func__);
> -		return 0;
> +		return -ENOMEM;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does validating against the=
=20
total buffer capacity instead of the actual payload size allow information=
=20
disclosure?

If the check uses vb2_plane_size(buf, 0) instead of the actual received=20
payload length in dsize, could a valid short payload with a crafted=20
superframe index declare frame sizes that exceed the payload length but=20
remain under the total buffer capacity?

If so, memmove() could copy trailing uninitialized or stale kernel memory=20
from the buffer into the active payload stream.


Outside of the immediate diff, there are a few other questions about the=20
esparser implementation that may be worth reviewing:

[Severity: High]
This isn't a bug introduced by this patch, but does esparser_queue_all_src(=
)=20
queue hardware operations without acquiring the global hardware lock?

The worker runs concurrently for multiple sessions because the work queue i=
s=20
initialized per-session. The worker locks the per-session sess->lock but=20
does not appear to acquire the global core->lock or verify hardware ownersh=
ip=20
before calling esparser_write_data():

esparser_queue_all_src() {
    ...
    ret =3D esparser_queue(sess, vbuf);
    ...
}

Could multiple sessions invoke esparser_write_data() simultaneously, causin=
g=20
conflicting writes to the hardware parser registers and corruption of the=20
global search_done waitqueue flag?

[Severity: High]
Could the early return in esparser_isr() bypass clearing the hardware=20
interrupt?

The interrupt service routine starts with a check:

esparser_isr() {
    if (!sess)
        return IRQ_HANDLED;
    ...
}

If a hardware interrupt asserts just as the session is torn down, returning=
=20
early leaves the hardware interrupt un-cleared. Would this cause the=20
hardware to hold the interrupt line asserted indefinitely, leading to an=20
unrecoverable IRQ storm and system lockup?

[Severity: High]
Does the break statement inside esparser_queue_all_src() properly exit the=
=20
worker loop?

When checking if a buffer is available inside a scoped_guard():

esparser_queue_all_src() {
    ...
    vbuf =3D v4l2_m2m_next_src_buf(sess->m2m_ctx);
    if (!vbuf)
        break;
    ...
}

Since scoped_guard() is implemented internally as a for loop, breaking here=
=20
would only escape the guard's inner loop. If processed_frame remains false,=
=20
the outer while (1) loop proceeds past its own exit condition:

    if (processed_frame)
        break;
    /* Give other threads and IRQ routines a window ... */
    cond_resched();

Could this pin a CPU core at 100% in an infinite busy-wait loop when the=20
queue is empty?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D9
