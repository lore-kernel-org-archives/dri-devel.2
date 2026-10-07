Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE45CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 05:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D15710E190;
	Wed,  7 Oct 2026 05:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m7+h4A6E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A99A10E190
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 05:58:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F3E8243A70;
 Wed,  7 Oct 2026 05:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C4D1F0089B;
 Wed,  7 Oct 2026 05:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791352721;
 bh=6xmygw6JGow+wZfs15RIuuQx1nmInn5IAZfaG2lA8rI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m7+h4A6E7k6J5oKTEV4q1WiuxspgbXKGj2k0NimzqUSCRj4nyTNsx8UG0onJqik0t
 DPlVohFuoaHh8VcRfgQzgSY9ZJNDfa+8oJQ40nCEGZWi7JKkvlBNpMggyXaCzyZ3kW
 iwVPJzwFX3wrtowD4HHTCrMNn1JPXcn6JgudrCNUSPhrYOChc2cazHWvP1Y8s57cWb
 rZNjy2/kWxnHV6952E9TSHRu+2E0ZztBjTBLRbV3fdVPzh22MJK1jo9j3sUUHlu/iT
 Voc0m1SFKCxRDURiFD+d0/PyND5HloqMlEkhAVu6fFNfgUKtDPFzUoTgXoa6lJ2h6q
 2eI4hAKAAzO5w==
Message-ID: <sashiko-outbox-162655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFT PATCH] Input: sur40 - fix DMA handling in video capture
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 media-ci@linuxtv.org, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org
In-Reply-To: <20261007054430.40155-1-kmehltretter@gmail.com>
References: <20261007054430.40155-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 05:58:41 +0000
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
- [High] media: use-after-free of sur40 state on disconnect when V4L2 fd is=
 open
- [Medium] usb: invalid GFP flags (0) passed to usb_sg_init in sleepable co=
ntext
--

commit f65bffa4ada0f7963abf3d4813cdc5924218586d
Author: Karl Mehltretter <kmehltretter@gmail.com>

Input: sur40 - fix DMA handling in video capture

This commit fixes video capture failures by transitioning from vb2_dma_sg to
vb2_vmalloc. It receives each frame into a driver-owned, page-backed
scatterlist and copies it through the vb2 mapping, while synchronizing
CPU writes to imported dma-bufs.

> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index 09d8c5f8d09fc..72e3f0fa1f4cb 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
[ ... ]
> @@ -579,11 +584,17 @@ static void sur40_process_video(struct sur40_state =
*sur40)
> =20
>  	dev_dbg(sur40->dev, "header acquired\n");
> =20
> -	sgt =3D vb2_dma_sg_plane_desc(&new_buf->vb.vb2_buf, 0);
> +	vaddr =3D vb2_plane_vaddr(&new_buf->vb.vb2_buf, 0);
> +	if (!vaddr)
> +		goto err_poll;
> =20
> +	/*
> +	 * vb2_plane_vaddr() may return a vmalloc or vmap address. Receive
> +	 * into page-backed memory so the USB core can map it for DMA.
> +	 */
>  	result =3D usb_sg_init(&sgr, sur40->usbdev,
>  		usb_rcvbulkpipe(sur40->usbdev, VIDEO_ENDPOINT), 0,
> -		sgt->sgl, sgt->nents, sur40->pix_fmt.sizeimage, 0);
> +		sur40->video_sgl, sur40->video_nents, size, 0);

[Severity: Medium]
Is it correct to pass 0 as the mem_flags argument to usb_sg_init() here?

Passing 0 implies no reclaim and no wait (equivalent to GFP_NOWAIT), which
restricts usb_alloc_urb() and internal kmalloc operations. This can increase
the probability of spurious -ENOMEM failures under memory pressure.

Since sur40_process_video() executes inside the input poller worker thread
(sur40_poll) which runs in process context and is allowed to sleep (it alre=
ady
calls usb_bulk_msg() and usb_sg_wait()), shouldn't this use GFP_KERNEL inst=
ead?

[ ... ]
> @@ -831,6 +883,7 @@ static void sur40_disconnect(struct usb_interface *in=
terface)
>  	video_unregister_device(&sur40->vdev);
>  	v4l2_device_unregister(&sur40->v4l2);
> =20
> +	sgl_free(sur40->video_sgl);
>  	kfree(sur40->bulk_in_buffer);
>  	kfree(sur40);

[Severity: High]
Could freeing the sur40 structure unconditionally here lead to a use-after-=
free
if userspace holds the V4L2 file descriptor open during device unplug?

When the application later closes the file, the V4L2 core invokes
vb2_fop_release(), which dereferences vdev->queue and attempts to acquire
vdev->queue->lock. Because vdev is embedded in the freed sur40 structure,
this results in a direct use-after-free.

While the commit message acknowledges this bug and defers to a pending patch
series for the disconnect fixes, the current patch adds new cleanup to this
vulnerable path. The referenced series is absent from the provided tree,
leaving the vulnerability exposed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007054430.4015=
5-1-kmehltretter@gmail.com?part=3D1
