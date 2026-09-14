Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D95C88E70
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFC710E1A4;
	Mon, 14 Sep 2026 13:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gcuwOU+h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71CD10E1A4
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:37:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D82FA601FF;
 Mon, 14 Sep 2026 13:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CA41F000FF;
 Mon, 14 Sep 2026 13:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789393069;
 bh=2Z+GoOGLdrjjH1/mFtuP+6w7Xa3JV6s61/HvHEeLBAY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gcuwOU+hcyF/pWrR6u/FrE2cTyPOn/2R9jSQrs9m4TcAlQRAAkCXSba81l1suKavk
 TW0Jb3CI+E4WFe9ZUuamlgD3fDV9Cgc4ynwwZbNCwRtsMyn79IjtKihwbH3yQjB2BY
 /KZBBQjs8RXTIwk6SGKSIZWnT5ImRRiXQsAG+nr4EO660NkZugCMFtEDmX89zuhTm1
 xhTXJoMvzpbd5TI8MZSpDOSofMf/D6yUuEinSUGKQzoLajfk0sfgl/faEe44XvaSzl
 ltwYvR/c6GTxjfzp08DPM0pxa2JbSJSvHOcYxISl+kYhUp4JNIeO5A7/UZZGEZCDfz
 kSZ4G48SI/jAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/trigger5: Add MCT Trigger 5 USB display driver
To: "Ho Jie Feng" <hjf3108@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914131924.196251-1-hjf3108@gmail.com>
References: <20260910171709.396071-1-hjf3108@gmail.com>
 <20260914131924.196251-1-hjf3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:37:48 +0000
Message-Id: <20260914133749.70CA41F000FF@smtp.kernel.org>
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
- [High] Sleeping functions and blocking memory allocations are called with=
in DRM atomic commit callbacks, which are strictly defined as atomic contex=
t paths by subsystem guidelines.
- [High] trigger5_crtc_create_state() returns ERR_PTR(-ENOMEM) instead of N=
ULL on allocation failure, causing a crash in the DRM core.
- [High] Missing cache flush for the vmalloc DMA buffer before initiating U=
SB transfer.
- [Medium] The USB bulk header's horizontal and vertical offsets are popula=
ted with raw framebuffer coordinates instead of screen coordinates.
--

commit e87cbb95a349285fc94e00546c2aa86f1ff4d509
Author: Ho Jie Feng <hjf3108@gmail.com>

drm/trigger5: Add MCT Trigger 5 USB display driver

Add a DRM driver for MCT Trigger 5 USB display adapters. The driver
implements modesetting and USB framebuffer updates, connector detection,
and EDID retrieval.

> diff --git a/drivers/gpu/drm/trigger5/trigger5_drv.c b/drivers/gpu/drm/tr=
igger5/trigger5_drv.c
> --- a/drivers/gpu/drm/trigger5/trigger5_drv.c
> +++ b/drivers/gpu/drm/trigger5/trigger5_drv.c
> @@ -248,8 +248,9 @@ static void trigger5_atomic_commit_tail(struct drm_at=
omic_commit *state)
> =20
>  	if (!drm_dev_enter(state->dev, &idx))
>  		goto commit;
> =20
>  	trigger5_stop_io(trigger5);

[Severity: High]
Is it safe to block in this atomic commit tail callback? The DRM subsystem
guidelines explicitly designate drm_atomic_helper_commit_tail() as an atomic
context path where sleeping or blocking operations (like flushing workqueues
inside trigger5_stop_io()) are strictly forbidden, which could lead to
deadlocks or kernel warnings.

[ ... ]

> @@ -282,10 +282,10 @@ static int trigger5_alloc_bulk_buffer(struct trigge=
r5_transfer_buf *buf,
> =20
>  	/* Large transfer buffer requires vmalloc and a scatterlist. */
>  	data =3D vmalloc_32(len);
>  	if (!data)
>  		return -ENOMEM;
> =20
>  	num_pages =3D DIV_ROUND_UP(len, PAGE_SIZE);
>  	pages =3D kmalloc_array(num_pages, sizeof(struct page *), GFP_KERNEL);
>  	if (!pages) {
>  		ret =3D -ENOMEM;
>  		goto err_vfree;
>  	}
>  	for (i =3D 0, ptr =3D data; i < num_pages; i++, ptr +=3D PAGE_SIZE)
>  		pages[i] =3D vmalloc_to_page(ptr);
>  	ret =3D sg_alloc_table_from_pages(&buf->sgt, pages,
>  					num_pages, 0, len, GFP_KERNEL);

[Severity: High]
Since this DMA buffer is allocated with vmalloc_32() and mapped to an SG
table, will the CPU cache for the vmalloc alias need to be explicitly flush=
ed
after writes?

[ ... ]

> @@ -324,10 +324,10 @@ static struct drm_crtc_state *
>  trigger5_crtc_create_state(struct drm_crtc *crtc)
>  {
>  	struct trigger5_crtc_state *tstate =3D kzalloc_obj(*tstate);
> =20
>  	if (!tstate)
>  		return ERR_PTR(-ENOMEM);

[Severity: High]
Could this cause a crash in the DRM core? The DRM API contract requires
atomic_create_state callbacks to return NULL on memory allocation failure.
Returning ERR_PTR(-ENOMEM) creates a non-NULL pointer that could evade
existing checks, leading to a dereference of the error pointer.

[ ... ]

> @@ -377,10 +377,10 @@ static void trigger5_crtc_atomic_enable(struct drm_=
crtc *crtc,
>  	trigger5_stop_io(trigger5);
> =20
>  	/* Sequence recovered from USB captures. */
>  	ret =3D usb_control_msg_recv(udev, 0,
>  				   TRIGGER5_REQUEST_FIRMWARE_RESET,
>  				   USB_DIR_IN | USB_TYPE_VENDOR |
>  					   USB_RECIP_DEVICE,
>  				   0x0000, 0x0000, data, 1,
>  				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);

[Severity: High]
Could calling synchronous USB control message APIs with GFP_KERNEL here cau=
se
system instability? The CRTC atomic enable callback runs in an atomic conte=
xt
path where sleeping is strictly forbidden.

[ ... ]

> @@ -456,10 +456,10 @@ static void trigger5_crtc_atomic_disable(struct drm=
_crtc *crtc,
>  	trigger5_stop_io(trigger5);
> =20
>  	ret =3D usb_control_msg_recv(udev, 0,
>  				   TRIGGER5_REQUEST_FIRMWARE_RESET,
>  				   USB_DIR_IN | USB_TYPE_VENDOR |
>  					   USB_RECIP_DEVICE,
>  				   0x0001, 0x0000, &data, 1,
>  				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);

[Severity: High]
Could this sleep in atomic context? Similar to the enable callback, this
disable callback runs in a path where sleeping is forbidden.

[ ... ]

> @@ -635,10 +635,10 @@ static void trigger5_plane_atomic_update(struct drm=
_plane *plane,
>  	/*
>  	 * This should almost never wait because we have should have a
>  	 * pending transfer ready to be de-queued above in case the transfer
>  	 * hasn't finished, but do a bounded wait just in case it gets stuck
>  	 */
>  	if (!wait_for_completion_timeout(&current_transfer->frame_complete,
>  					 msecs_to_jiffies(20)))
>  		goto exit_save_pending;

[Severity: High]
Is it safe to wait on a completion here? wait_for_completion_timeout() can
sleep, but plane atomic update callbacks run in an atomic context.

>  	current_transfer->transfer_rect =3D current_rect;
> =20
>  	current_transfer->frame_len =3D frame_len;
>  	header =3D current_transfer->buf.data;
>  	header->magic =3D 0xfb;
>  	header->length =3D 0x14;
>  	/* flags 0: uncompressed 24-bit RGB888. */
>  	header->counter =3D
>  		cpu_to_le16((trigger5->frame_counter++) & 0xfff);
>  	header->horizontal_offset =3D cpu_to_le16(current_rect.x1);
>  	header->vertical_offset =3D cpu_to_le16(current_rect.y1);

[Severity: Medium]
Does this correctly populate the USB bulk header coordinates?=20

If the display is panned (i.e. has a non-zero source offset via state->src_x
or state->src_y), the hardware typically needs to receive screen coordinate=
s=20
rather than raw framebuffer coordinates. Since current_rect.x1 and
current_rect.y1 are in the coordinate space of the framebuffer, could this
result in visual corruption when panning?

>  	header->width =3D cpu_to_le16(width);
>  	header->height =3D cpu_to_le16(height);
>  	header->payload_length =3D cpu_to_le32((u32)payload_len);
>  	header->flags =3D 0x1;
>  	header->unknown1 =3D 0;
>  	header->unknown2 =3D 0;
>  	header->checksum =3D trigger5_bulk_header_checksum(header);
> =20
>  	iosys_map_set_vaddr(&data_map,
>  			    current_transfer->buf.data + sizeof(*header));
> =20
>  	ret =3D drm_gem_fb_begin_cpu_access(state->fb, DMA_FROM_DEVICE);

[Severity: High]
Could drm_gem_fb_begin_cpu_access() sleep here? This is also called in the
atomic context path.

>  	if (ret < 0) {
>  		complete(&current_transfer->frame_complete);
>  		goto exit_save_pending;
>  	}
> =20
>  	drm_fb_xrgb8888_to_rgb888(&data_map, NULL,
>  				  &shadow_plane_state->data[0],
>  				  state->fb, &current_rect,
>  				  &shadow_plane_state->fmtcnv_state);
> =20
>  	drm_gem_fb_end_cpu_access(state->fb, DMA_FROM_DEVICE);
> =20
>  	queue_work(trigger5->transfer_wq, &current_transfer->transfer_work);

[Severity: High]
Does the vmap cache need to be flushed before queueing the transfer work?

The DMA API manages cache coherency for the direct physical map, but not the
vmalloc alias used when the CPU writes the pixel data. Should
flush_kernel_vmap_range() be called here to avoid silent data corruption on
architectures with non-coherent DMA and virtually indexed caches?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914131924.1962=
51-1-hjf3108@gmail.com?part=3D1
