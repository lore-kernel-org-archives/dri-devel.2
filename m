Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81056606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFfTkADv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F7810E30C;
	Fri,  6 Nov 2026 02:56:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA7610E30C
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 02:56:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12C086020A;
 Fri,  6 Nov 2026 02:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41781F008A2;
 Fri,  6 Nov 2026 02:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793933776;
 bh=7O4eiLlqeLuaoXQ9+ZQRbb6F7XKyKjw3RekNq4/dbrY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CFfTkADvdrFQmWp1ho11AyVTrI6LP1/hdy/XNTNiUr0xD0OKH3UKjY/VczaDR0JL2
 +DL4JFf8SXEksI0vP8QyUtXL7ACbSOS1aSzY9u4lm1ecmiJ3kj2xY9nMgRmcZslvbM
 KLo0Hs05wi7UGFRtF4Dp7tCp4N6YFt0FnZs3BloVJv3jWQjsm4RFDsXyiCxytnghnS
 0yRuNZU2B0s5fEqosmFE/8VIVgapt7pmlWswBZqAg1iW4HUChCLsv885K/eAQP4DL1
 fFmThnj/bfHaRfEZ+jMKZLCty7x/8pkiaT2nhp606xY8UNJceCop8QwJV1L30r23tg
 1sF56bpmHaXTg==
Message-ID: <sashiko-outbox-200616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/4] drm/fl2000: Add frame streaming
To: "Angel Gabriel Crispin Valdivia" <angelcrispinvaldivia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-fl2000-upstream-v1-3-bb163ecb2309@gmail.com>
References: <20261105-fl2000-upstream-v1-0-bb163ecb2309@gmail.com>
 <20261105-fl2000-upstream-v1-3-bb163ecb2309@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:56:16 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] drm/fl2000: out-of-bounds shadow write after fl2000_stream_mod=
e_set() error
- [High] drm/fl2000: NULL pointer dereference of sb->pages in fl2000_free_s=
b()
- [High] drm/fl2000: infinite retry loop on -EAGAIN in fl2000_submit_urb()
- [High] drm/fl2000: invalid URB transfer_buffer usage in fl2000_stream_wor=
k()
- [Medium] drm/fl2000: missing flush_kernel_vmap_range() before SG DMA in f=
l2000_stream_work()
--

commit 3826e48192d62fc9fe0e2b4c5ca7c2e42d218844
Author: Angel Gabriel Crispin Valdivia <angelcrispinvaldivia@gmail.com>

drm/fl2000: Add frame streaming

This commit adds frame streaming support for the FL2000 USB display
adapter, managing a pool of scatter-gather URB buffers, a shadow
framebuffer for damage updates, pixel format conversion, and cursor
blending.

> diff --git a/drivers/gpu/drm/fl2000/fl2000.h b/drivers/gpu/drm/fl2000/fl2=
000.h
> index 95603247907cf..d800d943e6e47 100644
> --- a/drivers/gpu/drm/fl2000/fl2000.h
> +++ b/drivers/gpu/drm/fl2000/fl2000.h
> @@ -42,6 +42,48 @@ enum fl2000_interface {
>  	FL2000_USBIF_INTERRUPT =3D 2,
>  };
> =20
> +/* Process context only: may sleep between retries */
> +static inline int fl2000_submit_urb(struct urb *urb)
> +{
> +	int ret;
> +	int attempts =3D 10;
> +
> +	do {
> +		ret =3D usb_submit_urb(urb, GFP_KERNEL);
> +		switch (ret) {
> +		case -ENXIO:
> +		case -ENOMEM:
> +			if (attempts--) {
> +				cond_resched();
> +				ret =3D -EAGAIN;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	} while (ret =3D=3D -EAGAIN);
> +
> +	return ret;
> +}

[Severity: High]
What happens in fl2000_submit_urb() in drivers/gpu/drm/fl2000/fl2000.h if
usb_submit_urb() returns -EAGAIN directly?

For example, usb_hcd_map_urb_for_dma() in drivers/usb/core/hcd.c and
xhci_map_temp_buffer() in drivers/usb/host/xhci.c return -EAGAIN when DMA
mapping fails (such as dma_map_sg() or dma_map_single()).

When usb_submit_urb() returns -EAGAIN, the switch statement hits the
default branch without decrementing attempts or calling cond_resched(),
while the loop condition (ret =3D=3D -EAGAIN) remains true. Could this spin
indefinitely in fl2000_stream_work() -> fl2000_stream_submit() ->
fl2000_submit_urb()?

[ ... ]

> diff --git a/drivers/gpu/drm/fl2000/fl2000_streaming.c b/drivers/gpu/drm/=
fl2000/fl2000_streaming.c
> new file mode 100644
> index 0000000000000..2d2c30cb74424
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_streaming.c

[ ... ]

> +static void fl2000_free_sb(struct fl2000_stream_buf *sb)
> +{
> +	vunmap(sb->vaddr);
> +
> +	sg_free_table(&sb->sgt);
> +
> +	for (int i =3D 0; i < sb->nr_pages && sb->pages[i]; i++)
> +		__free_page(sb->pages[i]);
> +
> +	kfree(sb->pages);
> +
> +	kfree(sb);
> +}
> +
> +static struct fl2000_stream_buf *fl2000_alloc_sb(unsigned int size)
> +{
> +	int ret;
> +	struct fl2000_stream_buf *sb;
> +	unsigned int nr_pages =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
> +
> +	sb =3D kzalloc_obj(*sb);
> +	if (!sb)
> +		return NULL;
> +
> +	sb->nr_pages =3D nr_pages;
> +
> +	sb->pages =3D kzalloc_objs(*sb->pages, nr_pages);
> +	if (!sb->pages)
> +		goto error;
> +
> +	for (int i =3D 0; i < nr_pages; i++) {
> +		sb->pages[i] =3D alloc_page(GFP_KERNEL);
> +		if (!sb->pages[i])
> +			goto error;
> +	}
> +
> +	ret =3D sg_alloc_table_from_pages(&sb->sgt, sb->pages, nr_pages, 0, siz=
e, GFP_KERNEL);
> +	if (ret !=3D 0)
> +		goto error;
> +
> +	sb->vaddr =3D vmap(sb->pages, nr_pages, VM_MAP, PAGE_KERNEL);
> +	if (!sb->vaddr)
> +		goto error;
> +
> +	INIT_LIST_HEAD(&sb->list);
> +	memset(sb->vaddr, 0, nr_pages << PAGE_SHIFT);
> +
> +	return sb;
> +
> +error:
> +	fl2000_free_sb(sb);
> +
> +	return NULL;
> +}

[Severity: High]
In drivers/gpu/drm/fl2000/fl2000_streaming.c, fl2000_alloc_sb() sets
sb->nr_pages =3D nr_pages before allocating sb->pages with kzalloc_objs().
If that allocation fails, it jumps to error and calls fl2000_free_sb(sb).

In fl2000_free_sb(), the loop checks:

	for (int i =3D 0; i < sb->nr_pages && sb->pages[i]; i++)

When sb->nr_pages is non-zero and sb->pages is NULL, won't evaluating
sb->pages[0] dereference a NULL pointer?

[ ... ]

> +static void fl2000_stream_data_completion(struct urb *urb)
> +{
> +	struct fl2000_stream_buf *cur_sb =3D urb->transfer_buffer;
> +	struct usb_device *usb_dev =3D urb->dev;
> +	struct fl2000_stream *stream =3D urb->context;
> +	unsigned long flags;
> +
> +	if (stream) {
> +		spin_lock_irqsave(&stream->list_lock, flags);
> +		list_move_tail(&cur_sb->list, &stream->render_list);
> +		spin_unlock_irqrestore(&stream->list_lock, flags);

[ ... ]

> +		/*
> +		 * Building the frame copies up to several MB and must run with
> +		 * interrupts enabled, so cur_sb is owned (off all lists) for
> +		 * the duration. Holding list_lock (which disables IRQs) across
> +		 * it starves the whole system.
> +		 */
> +		fl2000_stream_build(stream, cur_sb);
> +
> +		spin_lock_irq(&stream->list_lock);
> +		list_add_tail(&cur_sb->list, &stream->wait_list);
> +		spin_unlock_irq(&stream->list_lock);

[Severity: Medium]
In fl2000_alloc_sb() in drivers/gpu/drm/fl2000/fl2000_streaming.c, the
scatter-gather pages in sb->sgt are mapped into a virtually contiguous
kernel range via vmap() at sb->vaddr, and fl2000_stream_build() writes the
frame and cursor data through cur_sb->vaddr.

When fl2000_stream_work() then submits data_urb with data_urb->sg and
data_urb->num_sgs, usb_hcd_map_urb_for_dma() calls dma_map_sg(), which only
flushes the linear direct-map alias for each scatterlist page rather than
the vmap() alias cur_sb->vaddr.

On architectures with virtually indexed (VIVT or aliasing VIPT) caches
where ARCH_IMPLEMENTS_FLUSH_KERNEL_VMAP_RANGE is set, does
fl2000_stream_work() need to call flush_kernel_vmap_range(cur_sb->vaddr,
stream->buf_size) after fl2000_stream_build() and before submitting the URB
so dirty cache lines in the vmap alias are written back before DMA?

> +
> +		data_urb =3D usb_alloc_urb(0, GFP_KERNEL);
> +		eof_urb =3D usb_alloc_urb(0, GFP_KERNEL);
> +		if (!data_urb || !eof_urb) {
> +			usb_free_urb(data_urb);
> +			usb_free_urb(eof_urb);
> +			dev_err(&usb_dev->dev, "Data URB allocation error\n");
> +			WRITE_ONCE(stream->enabled, false);
> +			return;
> +		}
> +
> +		/*
> +		 * Endpoint 1 bulk out. We store pointer to current stream buffer stru=
cture in
> +		 * transfer_buffer field of URB which is unused due to SGT.
> +		 */
> +		usb_fill_bulk_urb(data_urb, usb_dev, usb_sndbulkpipe(usb_dev, 1), cur_=
sb,
> +				  (int)stream->buf_size, fl2000_stream_data_completion, stream);
> +		data_urb->interval =3D 0;
> +		data_urb->sg =3D cur_sb->sgt.sgl;
> +		data_urb->num_sgs =3D cur_sb->sgt.nents;

[Severity: High]
Is it safe to store cur_sb in data_urb->transfer_buffer while setting
data_urb->transfer_buffer_length to stream->buf_size in
fl2000_stream_work()?

Even when urb->sg and urb->num_sgs are set, several paths in the USB core
and host controller drivers inspect or overwrite urb->transfer_buffer:

1. usb_submit_urb() calls kmsan_handle_urb(), which checks
urb->transfer_buffer_length bytes starting at urb->transfer_buffer when
urb->transfer_buffer is non-NULL, reading stream->buf_size bytes (several
megabytes) out-of-bounds past the cur_sb slab object.

2. In usb_hcd_map_urb_for_dma(), HCDs with hcd->localmem_pool check
localmem_pool before urb->num_sgs and call hcd_alloc_coherent(), which
copies urb->transfer_buffer_length bytes out-of-bounds from cur_sb and
overwrites urb->transfer_buffer.

3. In xhci_map_urb_for_dma(), when XHCI_SG_TRB_CACHE_SIZE_QUIRK triggers
xhci_map_temp_buffer(), xHCI replaces urb->transfer_buffer with a temporary
bounce buffer and xhci_unmap_temp_buf() sets urb->transfer_buffer =3D NULL
before completion, causing fl2000_stream_data_completion() to read cur_sb
as NULL and dereference it at list_move_tail(&cur_sb->list,
&stream->render_list).

Could data_urb->transfer_buffer be left NULL and urb->context (with a back
pointer in struct fl2000_stream_buf to struct fl2000_stream) be used
instead?

[ ... ]

> +void fl2000_stream_compress(struct fl2000_stream *stream, const struct i=
osys_map *src_map,
> +			    bool imported, u32 format, unsigned int width, unsigned int heigh=
t,
> +			    unsigned int pitch, const struct drm_rect *clip)
> +{
> +	bool wc =3D imported || src_map->is_iomem;
> +	u32 dst_line_len;
> +	u32 x_start, x_end, y_start, y_end;
> +	size_t span;
> +
> +	x_start =3D min_t(u32, max_t(int, clip->x1, 0), width);
> +	x_end =3D min_t(u32, max_t(int, clip->x2, 0), width);
> +	y_start =3D min_t(u32, max_t(int, clip->y1, 0), height);
> +	y_end =3D min_t(u32, max_t(int, clip->y2, 0), height);
> +	if (x_start >=3D x_end || y_start >=3D y_end)
> +		return;
> +
> +	guard(mutex)(&stream->shadow_lock);
> +
> +	if (!stream->shadow || width !=3D stream->width || height !=3D stream->=
height)
> +		return;

[ ... ]

> +int fl2000_stream_mode_set(struct fl2000_stream *stream, unsigned int wi=
dth,
> +			   unsigned int height, u32 bytes_pix)
> +{
> +	int ret;
> +	unsigned int size;
> +	void *shadow;
> +
> +	/* Round buffer size up to multiple of 8 to meet HW expectations */
> +	size =3D ALIGN(width * height * bytes_pix, 8);
> +
> +	guard(mutex)(&stream->shadow_lock);
> +
> +	stream->bytes_pix =3D bytes_pix;
> +	stream->width =3D width;
> +	stream->height =3D height;
> +
> +	/* If there are buffers with same size - keep them */
> +	if (stream->buf_size =3D=3D size)
> +		return 0;
> +
> +	/* Destroy wrong size buffers if they exist */
> +	if (!list_empty(&stream->render_list))
> +		fl2000_stream_put_buffers(stream);
> +
> +	/* Allocate new buffers */
> +	ret =3D fl2000_stream_get_buffers(stream, size);
> +	if (ret) {
> +		fl2000_stream_put_buffers(stream);
> +		stream->buf_size =3D 0;
> +		return ret;
> +	}
> +
> +	/* One full frame in the device format; only the CPU ever reads it */
> +	shadow =3D vzalloc(size);
> +	if (!shadow) {
> +		fl2000_stream_put_buffers(stream);
> +		stream->buf_size =3D 0;
> +		return -ENOMEM;
> +	}
> +	vfree(stream->shadow);
> +	stream->shadow =3D shadow;

[Severity: Critical]
In fl2000_stream_mode_set() in drivers/gpu/drm/fl2000/fl2000_streaming.c,
stream->bytes_pix, stream->width, and stream->height are updated to the new
mode dimensions before fl2000_stream_get_buffers(stream, size) and
vzalloc(size) succeed.

If a smaller mode was previously active and switching to a larger mode
fails in fl2000_stream_get_buffers() or vzalloc(), the error paths set
stream->buf_size =3D 0 but leave stream->shadow pointing to the old, smaller
buffer while stream->width, stream->height, and stream->bytes_pix hold the
new, larger dimensions.

When fl2000_stream_compress() is subsequently called for the new mode, its
check:

	if (!stream->shadow || width !=3D stream->width || height !=3D stream->hei=
ght)
		return;

succeeds because stream->shadow is non-NULL and width and height match the
updated fields. Doesn't the conversion loop then write up to
width * height * stream->bytes_pix bytes past the end of the old smaller
stream->shadow allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-fl2000-ups=
tream-v1-0-bb163ecb2309@gmail.com?part=3D3
