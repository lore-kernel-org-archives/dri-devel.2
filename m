Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377E9C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1AE10E5C5;
	Mon, 13 Jul 2026 12:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CFofveuW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA4A10E5C5
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:55:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 840ED600AA;
 Mon, 13 Jul 2026 12:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8621F000E9;
 Mon, 13 Jul 2026 12:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783947312;
 bh=eDcr8g8qLo8wZ1+lxgJhIOeDMv3ri/NFrDyckCjdkLw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CFofveuWoQZvwOzWotTUe7SuqOU/rkOhXu6pRVPSeuDTD36pr5K3Qnl0Dy//1umU9
 eMknIQPwaaNtDBZ9hCAn3oNLXOVipPsk+dcQHJRsTggQEDxUg4aGqXuhIye7E4nwAP
 h0DjhS8ZN+Z4uGUTl/mVnRFJEYUyb5iq5mCODYzDBxNDhDVzUuf1kxE6dYntk7hQ9u
 EyU9a78mieYUM3JI/6QCjcolWREhPOCxX+hkdeZzXO9RKfGSSnTxw8hifMWIfp2R6Z
 Ou+uHGZS/jo00TMBPuI3S0KaY4ODmjemehsZjExZRnLvcNcvz8qrksSBebgQTuGJVy
 VdE28PWCMBTBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/19] media: meson: vdec: Configure DMA mask and
 segment size in probe
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260713120840.17427-17-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-17-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:55:10 +0000
Message-Id: <20260713125511.5F8621F000E9@smtp.kernel.org>
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
- [High] Hardware interrupts are not masked prior to calling `synchronize_i=
rq()`, leading to a race condition that causes a Use-After-Free of `sess->p=
riv`.
- [High] Misuse of `scoped_guard` inside a `while (1)` loop combined with i=
nverted logic causes the workqueue to busy-wait infinitely when no data is =
available.
- [Medium] Missing release barriers when publishing `core->cur_sess` allows=
 the lockless ISR to observe an uninitialized or stale session state.

Pre-existing issues:
- [Critical] vp9_update_header trusts user-provided frame sizes to calculat=
e offsets, leading to integer overflows and massive out-of-bounds memory ac=
cesses via memmove.
- [High] `meson_canvas_get` retrieves a pointer to the provider's private d=
ata but immediately drops its reference to the provider device, leading to =
a Use-After-Free if the provider driver is unbound.
- [Medium] Potential NULL pointer dereference if the driver is probed witho=
ut a device tree node.
--

--- Patch [16]: [PATCH v7 16/19] media: meson: vdec: Configure DMA mask and=
 segment size in probe ---
commit 8dd369d994b7e2a6a1fb0db5dcba10a32f46beaa
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Configure DMA mask and segment size in probe

This commit addresses missing explicit DMA constraints in the vdec probe
routine. It enforces a 32-bit coherent DMA allocation window and maximizes
the contiguous allocation segment boundary constraint to UINT_MAX.

> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/me=
dia/meson/vdec/vdec.c
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c
> @@ -1186,6 +1186,16 @@ static int vdec_probe(struct platform_device *pdev)
>  	if (IS_ERR(core->canvas))
>  		return PTR_ERR(core->canvas);
> =20
> +	/* Enforce strict 32-bit DMA limit to match hardware capabilities */
> +	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set 32-bit DMA mask\n");
> +
> +	ret =3D vb2_dma_contig_set_max_seg_size(dev, UINT_MAX);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to set DMA max segment size\n");
> +
>  	of_id =3D of_match_node(vdec_dt_match, dev->of_node);
>  	core->platform =3D of_id->data;

[Severity: Medium]
This isn't a bug introduced by this patch, but can this lead to a NULL poin=
ter
dereference if the driver is probed without a device tree node? If a user
with privileges binds the driver manually via sysfs without an associated
device tree node, dev->of_node is NULL. The of_match_node() call will
return NULL, causing of_id->data to be dereferenced blindly.

[Severity: High]
Can this regression cause a use-after-free of sess->priv in the interrupt
handler?

drivers/staging/media/meson/vdec/vdec.c:vdec_stop_streaming() {
...
		/* Synchronize and flush pending hardware interrupt service routines */
		synchronize_irq(core->vdec_irq);
		/* Ensure esparser ISR finishes executing */
		synchronize_irq(core->esparser_irq);

		cancel_work_sync(&sess->esparser_queue_work);
		mutex_lock(&core->lock);

		if (core->cur_sess =3D=3D sess) {
			vdec_poweroff(sess);
...
}

It appears hardware interrupts are not masked prior to calling
synchronize_irq(), which could allow an interrupt to fire immediately
after synchronize_irq() returns. Because vdec_poweroff() is responsible
for masking the hardware interrupts, could the main thread then free
sess->priv while the concurrently executing ISR dereferences it?

[Severity: High]
Does this loop correctly process the buffer queue or does it spin infinitel=
y?

drivers/staging/media/meson/vdec/esparser.c:esparser_queue_all_src() {
...
	while (1) {
		struct vb2_v4l2_buffer *vbuf =3D NULL;
		bool processed_frame =3D false;

		scoped_guard(mutex, &sess->lock) {
			/* Safe atomic tracking check: exit loop if session is shutting down */
			if (READ_ONCE(sess->should_stop))
				return;

			/* Queue completely empty: exit work loop cleanly */
			vbuf =3D v4l2_m2m_next_src_buf(sess->m2m_ctx);
			if (!vbuf)
				break;
...
}

When v4l2_m2m_next_src_buf() returns NULL, the break statement seems to only
exit the inner for loop created by the scoped_guard macro. This bypasses the
subsequent loop exit conditions and repeats the while (1) loop endlessly,
potentially causing a CPU lockup on the workqueue thread. Additionally, if a
buffer is present, could this break out of the loop completely instead of
processing the queue?

[Severity: Medium]
Can the lockless ISR observe an uninitialized or stale session state due to
missing release barriers?

drivers/staging/media/meson/vdec/vdec.c:vdec_start_streaming() {
...
	/* If already half-initialized, do not re-initialize */
	if (sess->status =3D=3D STATUS_INIT) {
		mutex_unlock(&core->lock);
		return 0;
	}

	sess->status =3D STATUS_INIT;
	core->cur_sess =3D sess;
	mutex_unlock(&core->lock);
...
}

Because core->cur_sess is assigned using a plain store, could the compiler =
or
CPU reorder this store before earlier initialization steps like
sess->status =3D STATUS_INIT? If the lockless ISR uses smp_load_acquire(), =
it
might observe the new session pointer but the old memory state.

[Severity: High]
This is a pre-existing issue, but does this code cause a use-after-free if =
the
provider driver is unbound?

drivers/soc/amlogic/meson-canvas.c:meson_canvas_get() {
...
	canvas_pdev =3D of_find_device_by_node(canvas_node);
	of_node_put(canvas_node);
	if (!canvas_pdev)
		return ERR_PTR(-EPROBE_DEFER);
...
	canvas =3D dev_get_drvdata(&canvas_pdev->dev);
	put_device(&canvas_pdev->dev);
	if (!canvas)
		return ERR_PTR(-EINVAL);

	return canvas;
}

The put_device() call immediately drops the device reference before returni=
ng
the pointer. Since no device link is maintained, could an admin or
unprivileged user with sysfs access unbind the amlogic-canvas driver,
freeing the memory while the vdec driver still holds and uses the
dangling pointer?

[Severity: Critical]
This is a pre-existing issue, but does this size calculation prevent integer
overflows and out-of-bounds memory accesses?

drivers/staging/media/meson/vdec/esparser.c:vp9_update_header() {
...
		for (cur_frame =3D 0; cur_frame < num_frames; cur_frame++) {
			frame_size[cur_frame] =3D 0;
			for (cur_mag =3D 0; cur_mag < mag; cur_mag++) {
				if (mag_ptr >=3D dsize)
					return -EINVAL;

				frame_size[cur_frame] |=3D
					(dp[mag_ptr] << (cur_mag * 8));
				mag_ptr++;
			}
			if (cur_frame =3D=3D 0)
				tot_frame_size[cur_frame] =3D
					frame_size[cur_frame];
			else
				tot_frame_size[cur_frame] =3D
					tot_frame_size[cur_frame - 1] +
					frame_size[cur_frame];
			total_datasize +=3D frame_size[cur_frame];
		}
...
}

It appears user-provided frame sizes are added blindly without overflow
protection. If a user crafts a V4L2 VP9 buffer payload with two frames
specifying sizes that sum to 0 (e.g., 0x40000000 and 0xC0000000), could
this bypass the new_frame_size bounds check? The driver might then use
one of the huge frame sizes in a memmove operation, leading to
out-of-bounds reads and writes on the kernel heap.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D16
