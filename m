Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68E0C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AAE10E5CB;
	Mon, 13 Jul 2026 12:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DPpbyazk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D028C10E5CB
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:27:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8508A43A30;
 Mon, 13 Jul 2026 12:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277121F000E9;
 Mon, 13 Jul 2026 12:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783945668;
 bh=9lWL1wFnx282U3FDeE8CTKRAyj7rhRIO0WfAjoBdkiw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DPpbyazknplDjaZuVWkH7+Ch96IGMJG7w0HcTNEYzlCW8ubiDXdy/7X8D5Drfpw4N
 eXW0Eg3Z28CQgjzhxJa6nLe3PFk1xJ3Rm/WHzbAlh2C4n3AqWOYAoSyBmhcTLQA9Wb
 gPSj4fx3Z4ru1AKpME4u0CntE57iV6b3FVd8PhfstCz3B7K0UNM84voXvXyw8XU8PZ
 lj1xS4egpjQehuDdjFgBY8MmP9CPj5QQ93LWJYUQ1OStISIxXWWZxuGChKVOQo6Vja
 0/P81c36xjdLYecCrpCNyLz7uAfylmE4RTkiRNE/SjwEym4/qetTqBsX46HU3drf5Q
 EiSGpuQxJVHEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/19] media: meson: vdec: Refactor esparser work
 queue and fix teardown race
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260713120840.17427-8-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-8-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:27:46 +0000
Message-Id: <20260713122748.277121F000E9@smtp.kernel.org>
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

New issues:
- [High] The worker thread enters a 100% CPU infinite loop when the queue i=
s empty, full, or hits an EOS buffer, and prematurely exits after a single =
frame on success due to an inverted loop condition and misuse of `scoped_gu=
ard`.

Pre-existing issues:
- [Critical] Maliciously crafted VP9 superframe headers can cause an intege=
r overflow in `total_datasize`, bypassing bounds checks and triggering a ma=
ssive out-of-bounds `memmove()`.
--

--- Patch [7]: [PATCH v7 07/19] media: meson: vdec: Refactor esparser work =
queue and fix teardown race ---
commit f4cf4afadbba1cd9ed8438a311d676dabd768d33
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Refactor esparser work queue and fix teardown race

Rework the esparser work queue logic to prevent concurrent queue mutations
and fix a race condition during streaming teardown.

> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/stagin=
g/media/meson/vdec/esparser.c
> index 37749ede308c6..e5d3d817b9b2b 100644
> --- a/drivers/staging/media/meson/vdec/esparser.c
> +++ b/drivers/staging/media/meson/vdec/esparser.c

[ ... ]

> @@ -348,12 +344,10 @@ esparser_queue(struct amvdec_session *sess, struct =
vb2_v4l2_buffer *vbuf)
>  	if (sess->fmt_out->pixfmt =3D=3D V4L2_PIX_FMT_VP9) {
>  		payload_size =3D vp9_update_header(core, vb);
> =20
> -		/* If unable to alter buffer to add headers */
>  		if (payload_size =3D=3D 0) {
> +			dev_err(core->dev, "esparser: VP9 header update failed\n");
>  			amvdec_remove_ts(sess, vb->timestamp);
> -			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> -
> -			return 0;
> +			return -EBADMSG;
>  		}
>  	}

[Severity: Critical]
This is a pre-existing issue, but can maliciously crafted VP9 superframe
headers cause an integer overflow in vp9_update_header(), leading to a
massive out-of-bounds memory copy?

Looking at vp9_update_header() in the same file:

    for (cur_mag =3D 0; cur_mag < mag; cur_mag++) {
        ...
        frame_size[cur_frame] |=3D
            (dp[mag_ptr] << (cur_mag * 8));
        mag_ptr++;
    }
    ...
    total_datasize +=3D frame_size[cur_frame];

If untrusted user data shifted into the signed 32-bit frame_size becomes
negative, multiple negative values can sum to a small positive
total_datasize, which bypasses the size checks:

    new_frame_size =3D total_datasize + num_frames * VP9_HEADER_SIZE;
    if (new_frame_size >=3D vb2_plane_size(buf, 0)) {
        return -ENOMEM;
    }

Then, later in the same function:

    int framesize =3D frame_size[cur_frame];
    ...
    memmove(fdata + VP9_HEADER_SIZE, old_framedata, framesize);

The negative framesize is implicitly converted to a size_t, which causes
an out-of-bounds memmove(). Could this lead to memory corruption when
handling untrusted V4L2 video stream data?

[ ... ]

>  void esparser_queue_all_src(struct work_struct *work)
>  {
> -	struct v4l2_m2m_buffer *buf, *n;
>  	struct amvdec_session *sess =3D
>  		container_of(work, struct amvdec_session, esparser_queue_work);
> +	struct device *dev =3D sess->core->dev_dec;
> +	int ret;
> =20
> -	mutex_lock(&sess->lock);
> -	v4l2_m2m_for_each_src_buf_safe(sess->m2m_ctx, buf, n) {
> -		if (sess->should_stop)
> -			break;
> +	while (1) {
> +		struct vb2_v4l2_buffer *vbuf =3D NULL;
> +		bool processed_frame =3D false;
> +
> +		scoped_guard(mutex, &sess->lock) {
> +			/* Safe atomic tracking check: exit loop if session is shutting down =
*/
> +			if (sess->should_stop)
> +				return;
> +
> +			/* Queue completely empty: exit work loop cleanly */
> +			vbuf =3D v4l2_m2m_next_src_buf(sess->m2m_ctx);
> +			if (!vbuf)
> +				break;
> +
> +			/* Stop processing if we hit the end-of-stream drain buffer */
> +			if (vbuf->flags & V4L2_BUF_FLAG_LAST)
> +				break;
> +
> +			/* Check hardware FIFO limits safely inside the locks */
> +			ret =3D esparser_queue(sess, vbuf);
> +			if (ret =3D=3D -EAGAIN)
> +				break;
> +
> +			/* Pop the buffer from the source queue since it is now processed */
> +			vbuf =3D v4l2_m2m_src_buf_remove(sess->m2m_ctx);
> +			if (!vbuf) {
> +				dev_dbg(dev, "Buffer missing during queue removal\n");
> +				break;
> +			}
> +
> +			/* Complete the buffer transaction based on parser results */
> +			if (ret < 0)
> +				v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> +			else
> +				v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
> =20
> -		if (esparser_queue(sess, &buf->vb) < 0)
> +			/* Set tracking flag indicating transaction completion */
> +			processed_frame =3D true;
> +		}
> +
> +		if (processed_frame)
>  			break;

[Severity: High]
Does this code inadvertently create an infinite loop?

Because scoped_guard() is implemented internally as a for-loop, the
break statements inside the scoped_guard() block will only exit the lock
scope, not the outer while (1) loop.

If the queue is empty (!vbuf), we break out of the scoped_guard(),
processed_frame remains false, and the while (1) loop continues infinitely,
consuming 100% CPU.

Conversely, if a frame is successfully processed, processed_frame becomes
true, which causes the outer while (1) loop to exit after just one frame
instead of continuing to drain the queue.

Could the logic here be inverted, or should the inner loop use goto
instead of break to exit the outer loop?

> +
> +		/* Give other threads and IRQ routines a window to execute while unloc=
ked */
> +		cond_resched();
>  	}
> -	mutex_unlock(&sess->lock);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D7
