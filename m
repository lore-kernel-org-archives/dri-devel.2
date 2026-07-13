Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1154C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 292F710E993;
	Mon, 13 Jul 2026 13:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SHOAH5Ps";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C102110E993
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:06:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8938600AA;
 Mon, 13 Jul 2026 13:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF0B1F00A3A;
 Mon, 13 Jul 2026 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783947972;
 bh=EUC4Kd6YeSlx6wPBaTuhucFiR4l8oX10MVHRygNQjxw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SHOAH5Psk3uAnsfV3dEJH61I53VGXstqf64GkHVAEAYltLtORB5csZNn9Gu7RFA48
 2GMaVqNRGsDZ7zkSgnfK66rd3o5oWLz/v+Fw4Aip8730s8n/JveCrocnnSoy9hacKb
 vrZQ++qJ9I9h/sXDZkX7rZcTPRXm9fadU6SngXN8WWNcjCQyqLy09J/FoMke5NJuya
 VwiZchnVfAyEOVyUo/tP7sOu1YtrgHtwkOYsfmrW+yfQvesve4siA9k2koJA66byl+
 KrIxm6nqVON5VKd4RG/mNpGWaFsaYu+OIF938SsXMscS9k1Ckm6SesYN+Aoji15LdA
 jffOHgApZXUsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 18/19] media: meson: vdec: Increase VIFIFO buffer
 size to 32 MiB
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260713120840.17427-19-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-19-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:06:12 +0000
Message-Id: <20260713130612.7AF0B1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] The `esparser_queue_all_src` workqueue handler contains a fatal in=
finite loop due to incorrect usage of the `scoped_guard` macro in combinati=
on with `break` statements, monopolizing 100% of a CPU core.
- [High] Double decrement of the `esparser_queued_bufs` atomic counter per =
video frame leads to counter underflow and buffer overruns.
- [High] The 32 MiB VIFIFO buffer increase causes the bitstream size to ove=
rflow the 32-bit hardware PARSER_CONTROL register calculation, crashing the=
 esparser DMA engine.

Pre-existing issues:
- [Critical] In `vp9_update_header`, an integer overflow when decoding mali=
ciously crafted frame magnitudes allows `frame_size` to become negative, by=
passing size validations and triggering a massive out-of-bounds `memmove` t=
hat panics the kernel.
- [High] Physical address truncation for the hardware ring buffer end point=
er causes immediate DMA corruption when memory is allocated near the top of=
 the 32-bit address space.
- [High] Use-After-Free (UAF) vulnerabilities in `vdec_close` during device=
 unbind due to `devm_kzalloc` and `v4l2_m2m_release` lifecycle mismatches.
- [Medium] Timestamp tracking and matching breaks silently when the 32-bit =
hardware offset wraps around at the 4 GB bitstream boundary, due to an impr=
oper naive unsigned sequence comparison.
- [Medium] Race condition in `esparser_write_data` overwrites the completio=
n flag, causing false input parsing timeouts.
--

--- Patch [18]: [PATCH v7 18/19] media: meson: vdec: Increase VIFIFO buffer=
 size to 32 MiB ---
commit 2addc7a4961dc5fcc69dfbb2e96d57eb89853de9
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Increase VIFIFO buffer size to 32 MiB

During 4K video playback, the hardware Elementary Stream Parser (esparser)
can rapidly push massive burst data payloads into the Video Input FIFO
faster than the VPU decoding block can consume it. This causes a buffer
overflow when stream usage breaks past the allocated hardware boundary.
This patch doubles the parsed bitstream swap exchange memory pool to 32 MiB.

> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/me=
dia/meson/vdec/vdec.c
> index d33cbebc4453b..824e2f156adeb 100644
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c
> @@ -29,8 +29,8 @@ struct dummy_buf {
>  	struct list_head list;
>  };
> =20
> -/* 16 MiB for parsed bitstream swap exchange */
> -#define SIZE_VIFIFO SZ_16M
> +/* 32 MiB for parsed bitstream swap exchange */
> +#define SIZE_VIFIFO SZ_32M

[Severity: High]
Does increasing the buffer to 32 MiB cause the bitstream size to overflow
the 32-bit hardware PARSER_CONTROL register calculation?

In drivers/staging/media/meson/vdec/esparser.c:esparser_write_data():

	amvdec_write_parser(core, PARSER_CONTROL,
			    ES_WRITE |
			    ES_PARSER_START |
			    ES_SEARCH |
			    (size << ES_PACK_SIZE_BIT));

With ES_PACK_SIZE_BIT being 8, for a size >=3D 16 MiB this left shift will
overflow a 32-bit unsigned integer. This can result in the DMA engine
receiving a truncated payload size and crashing.

[Severity: High]
This is a pre-existing issue, but does increasing the buffer size make it
highly probable that the hardware ring buffer end pointer truncates, causing
immediate DMA corruption?

In drivers/staging/media/meson/vdec/vdec_hevc.c:vdec_hevc_stbuf_init():

	amvdec_write_dos(core, HEVC_STREAM_END_ADDR,
			 sess->vififo_paddr + sess->vififo_size);

If the VIFIFO buffer is allocated near the end of the 32-bit address space,
the calculation sess->vififo_paddr + sess->vififo_size can exceed 32 bits,
resulting in a value like 0x100000000. This is silently truncated to 0 when
passed to amvdec_write_dos() which accepts a 32-bit u32.

[Severity: Medium]
This is a pre-existing issue, but how does the driver handle timestamps when
the 32-bit hardware offset wraps around at the 4 GB bitstream boundary?

In drivers/staging/media/meson/vdec/vdec_helpers.c:amvdec_dst_buf_done_offs=
et():

	list_for_each_entry_safe(tmp, n, &sess->timestamps, list) {
		if (tmp->offset > offset) {
			...
			break;
		}

The stream offset accumulates into a 32-bit integer in esparser_get_offset()
that naturally wraps at 4 GB. The list_for_each_entry_safe loop uses a
non-wrap-safe raw unsigned comparison. When the offset wraps around to 0,
a large tmp->offset immediately evaluates as greater and incorrectly breaks
the loop, stranding or dropping timestamps.

[Severity: High]
Are there Use-After-Free vulnerabilities in vdec_close() during device unbi=
nd
due to devm_kzalloc() and v4l2_m2m_release() lifecycle mismatches? This isn=
't
a bug introduced by this patch, but...

In drivers/staging/media/meson/vdec/vdec.c:vdec_remove():

	video_unregister_device(core->vdev_dec);
	v4l2_m2m_release(core->m2m_dev);

The unbind path frees the core structure while V4L2 file descriptors may
still be actively held by userspace.

Later, if an application closes the file descriptor, vdec_close() is invoke=
d:

	synchronize_irq(core->vdec_irq);

This could dereference the freed core pointer and the freed m2m_dev.

[Severity: High]
Does the esparser_queue_all_src() workqueue handler contain an infinite loop
that could monopolize a CPU core?

In drivers/staging/media/meson/vdec/esparser.c:esparser_queue_all_src():

	while (1) {
		struct vb2_v4l2_buffer *vbuf =3D NULL;
		bool processed_frame =3D false;

		scoped_guard(mutex, &sess->lock) {
			...
			vbuf =3D v4l2_m2m_next_src_buf(sess->m2m_ctx);
			if (!vbuf)
				break;
			...
		}

		if (processed_frame)
			break;
		...
	}

The break statements are intended to exit the function when no buffers are
available. However, they only escape the scoped_guard's internal for loop.
This leaves the outer while (1) loop intact since processed_frame is false,
which could result in a lockup of a kernel worker thread.

[Severity: High]
Does this code double decrement the esparser_queued_bufs atomic counter?

In drivers/staging/media/meson/vdec/vdec_helpers.c, dst_buf_done() calls
atomic_dec(&sess->esparser_queued_bufs). However, its callers also execute
their own atomic_dec():

amvdec_dst_buf_done():

	dst_buf_done(sess, vbuf, field, timestamp, timecode, vbuf_flags);
	atomic_dec(&sess->esparser_queued_bufs);

amvdec_dst_buf_done_offset():

	dst_buf_done(sess, vbuf, field, timestamp, timecode, vbuf_flags);
	if (match)
		atomic_dec(&sess->esparser_queued_bufs);

This could lead to counter underflow, bypassing buffer limit checks and
causing hardware queue overruns.

[Severity: Medium]
This is a pre-existing issue, but does esparser_write_data() contain a race
condition that overwrites the completion flag?

In drivers/staging/media/meson/vdec/esparser.c:esparser_write_data():

	amvdec_write_parser(core, PARSER_FETCH_CMD,
			    (7 << FETCH_ENDIAN_BIT) |
			    (size + SEARCH_PATTERN_LEN));

	search_done =3D 0;
	return wait_event_interruptible_timeout(wq, search_done, (HZ / 5));

The CPU initiates hardware processing by writing to PARSER_FETCH_CMD, which
can instantly trigger esparser_isr(). If the hardware interrupt fires
immediately, the ISR sets search_done =3D 1. The CPU sequentially executes
search_done =3D 0 afterwards, which could erase the completion signal before
waiting on it.

[Severity: Critical]
This is a pre-existing issue, but does vp9_update_header() have an integer
overflow when decoding frame magnitudes that can bypass size validations?

In drivers/staging/media/meson/vdec/esparser.c:vp9_update_header():

				frame_size[cur_frame] |=3D
					(dp[mag_ptr] << (cur_mag * 8));

The magnitude byte is promoted to a signed 32-bit integer. When shifted by
24 bits, it can become a large negative number if the maliciously crafted
payload has dp[mag_ptr] >=3D 0x80.

Later, this negative frame size bypasses total_datasize validations and
triggers an out-of-bounds copy in memmove:

		memmove(fdata + VP9_HEADER_SIZE, old_framedata, framesize);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D18
