Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1649C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D1810E09F;
	Mon, 13 Jul 2026 12:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MjHezeNR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9AD10E09F
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:46:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2DA2140A8D;
 Mon, 13 Jul 2026 12:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAE71F000E9;
 Mon, 13 Jul 2026 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783946801;
 bh=5qp4cB28UsZKGHNVhMCm/1kfvcwCj7c2iWrRp/RkMyc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MjHezeNR8aDJFQXD+LYaTJEEHFUxCWP2HlFAlRSf6lAk035xOu58EPgx942BBLA8I
 3TavJA7Z/asNzkWmbqEj/jBRyWuqUfSpfc3zUsR0JpmDE5rLZEm5ZzKLZ+g7mOIHTm
 9RN9IespmO+eFmfLPA8CCeOPXi0YoqzkTWjPTSAsQRX7pDX12rFce9Zj+9+2MtO1hU
 M0W5gNlKJ3tnfUrdGBu3XibexmgYiVT0Pb0HrxtEKrd5qIDBXUPXbqpjEbXjrIjjY8
 wUW6jL5VarNGYry/Lqg3qsofsz2i5w+DcRe/YuCLMBL1FUvUgy3FifPyVma69vDyAS
 pTuUrTfWoZ6XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/19] media: meson: vdec: Fix race conditions and
 leaks in esparser pipeline
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260713120840.17427-11-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-11-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:46:40 +0000
Message-Id: <20260713124640.CDAE71F000E9@smtp.kernel.org>
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
- [High] Infinite loop and CPU soft-lockup in `esparser_queue_all_src` due =
to inverted `processed_frame` logic.
- [High] Self-deadlock in `vdec_start_streaming` and `vdec_stop_streaming` =
due to recursive acquisition of `core->lock`.
- [High] AB-BA deadlock in `vdec_stop_streaming` caused by calling `cancel_=
work_sync` while holding `sess->lock`.
- [High] AB-BA lock inversion deadlock between `core->lock` and `sess->lock=
` in the esparser workqueue.
- [High] System-wide V4L2 stall due to sleeping for up to 200ms while holdi=
ng the driver-wide `core->lock`.
- [High] Silent omission of start code padding for unmapped buffers leads t=
o hardware out-of-bounds DMA.

Pre-existing issues:
- [Critical] Integer overflow in `vp9_update_header` allows massive out-of-=
bounds heap corruption from untrusted payload data.
- [High] `esparser_pad_start_code` executes an out-of-bounds memory write b=
efore evaluating bounds checks.
--

--- Patch [10]: [PATCH v7 10/19] media: meson: vdec: Fix race conditions an=
d leaks in esparser pipeline ---
commit f978165e2ef967ec3f207c80310d474efee3c9e8
Author: Anand Moon <linux.amoon@gmail.com>
Subject: media: meson: vdec: Fix race conditions and leaks in esparser pipe=
line

This commit fixes a circular locking dependency and potential race conditio=
ns
within the asynchronous esparser queue. It moves hardware ownership validat=
ion
inside the core->lock mutex region and properly cleans up timestamp tracker=
s.
The VP9 payload evaluation logic is also refined.

> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/stagin=
g/media/meson/vdec/esparser.c
> index edbfc829e2da8..b9f36fef4be12 100644
> --- a/drivers/staging/media/meson/vdec/esparser.c
> +++ b/drivers/staging/media/meson/vdec/esparser.c
> @@ -199,12 +199,16 @@ static int vp9_update_header(struct amvdec_core *co=
re, struct vb2_buffer *buf)
>   * the ESPARSER interrupt.
>   */
>  static u32 esparser_pad_start_code(struct amvdec_core *core,
> +				   struct amvdec_session *sess,
>  				   struct vb2_buffer *vb,
>  				   u32 payload_size)
>  {
>  	u32 pad_size =3D 0;
>  	u8 *vaddr =3D vb2_plane_vaddr(vb, 0);
> =20
> +	if (!sess || READ_ONCE(sess->should_stop) || !sess->priv || !vaddr)
> +		return 0;

[Severity: High]
Does returning 0 here skip the start code injection and cause an
out-of-bounds DMA scan?

By bypassing the injection of the SEARCH_PATTERN start code, the caller
esparser_queue() might interpret the 0 as success and instruct the DMA
engine to fetch the buffer.=20

Since the search pattern is missing, could the hardware parser scan
indefinitely past the valid buffer into adjacent physical memory, resulting
in an out-of-bounds DMA read?

>  	if (payload_size < ESPARSER_MIN_PACKET_SIZE) {
>  		pad_size =3D ESPARSER_MIN_PACKET_SIZE - payload_size;
>  		memset(vaddr + payload_size, 0, pad_size);
>  	}

[Severity: High]
This is a pre-existing issue, but does this memset() write out of bounds?

If a small buffer is queued, this calculation executes before the
overall bounds check is evaluated.=20

Could this overwrite adjacent kernel memory with zeroes before validating=20
the size?

[ ... ]

> @@ -349,24 +356,38 @@ esparser_queue(struct amvdec_session *sess, struct =
vb2_v4l2_buffer *vbuf)
>  	vbuf->sequence =3D sess->sequence_out++;
> =20
>  	if (sess->fmt_out->pixfmt =3D=3D V4L2_PIX_FMT_VP9) {
> -		payload_size =3D vp9_update_header(core, vb);
> +		int res =3D vp9_update_header(core, vb);

[Severity: Critical]
This is a pre-existing issue, but does vp9_update_header() have an integer
overflow?

By extracting untrusted payload bytes and shifting them left up to 24 bits
into a signed integer, can malicious payloads construct negative frame size=
s?

If a highly negative signed integer is produced and passed to memmove() as =
an
unsigned size_t, could this cause massive out-of-bounds reads and writes on
the kernel heap or DMA memory?

> =20
> -		if (payload_size =3D=3D 0) {
> -			dev_err(core->dev, "esparser: VP9 header update failed\n");
> +		if (res <=3D 0) {
> +			dev_err(core->dev,
> +				"esparser: VP9 header update failed (%d)\n",
> +				res);
>  			amvdec_remove_ts(sess, vb->timestamp);
>  			return -EBADMSG;
>  		}
> +		payload_size =3D res;
> +	}
> +
> +	pad_size =3D esparser_pad_start_code(core, sess, vb, payload_size);
> +
> +	/* Protect hardware register writes under core->lock */
> +	mutex_lock(&core->lock);

[Severity: High]
Does this new mutex_lock() introduce an AB-BA lock inversion?

The background workqueue thread esparser_queue_all_src() acquires sess->loc=
k=20
first (via scoped_guard) and then calls esparser_queue().=20

By adding mutex_lock(&core->lock) here, could this conflict with V4L2 ioctls
that implicitly acquire core->lock before sess->lock, resulting in an AB-BA
deadlock?

> +	if (core->cur_sess !=3D sess || READ_ONCE(sess->should_stop)) {
> +		mutex_unlock(&core->lock);
> +		amvdec_remove_ts(sess, vb->timestamp);
> +		return -ESHUTDOWN;
>  	}
> =20
> -	pad_size =3D esparser_pad_start_code(core, vb, payload_size);
>  	ret =3D esparser_write_data(core, phy, payload_size + pad_size);

[Severity: High]
Could sleeping inside esparser_write_data() block all other V4L2 ioctls?

Because core->lock is mapped to vdev->lock, sleeping via=20
wait_event_interruptible_timeout() while waiting for the hardware interrupt=
=20
blocks all other V4L2 ioctls across the entire device for the duration of=20
the fetch.=20

Can this severely degrade system performance?

> =20
>  	if (ret <=3D 0) {
>  		dev_warn(core->dev, "esparser: input parsing error\n");
>  		amvdec_remove_ts(sess, vb->timestamp);
>  		amvdec_write_parser(core, PARSER_FETCH_CMD, 0);
> +		mutex_unlock(&core->lock);
>  		return -EIO;
>  	}
> +	mutex_unlock(&core->lock);
> =20
>  	atomic_inc(&sess->esparser_queued_bufs);
> =20

I also have some questions about related code paths outside the diff:

[Severity: High]
Is there an infinite loop in esparser_queue_all_src()?

When looking at the worker thread:

drivers/staging/media/meson/vdec/esparser.c:esparser_queue_all_src() {
    ...
		bool processed_frame =3D false;
        ...
		if (processed_frame)
			break;
    ...
}

Because the break statements inside the scoped_guard macro only exit the=20
internal macro loop, processed_frame remains false when the queue is empty.=
=20

Does the inverted logic cause the thread to bypass the outer break and loop=
=20
infinitely, soft-locking the CPU?

[Severity: High]
Do vdec_start_streaming() and vdec_stop_streaming() self-deadlock?

In the current code:

drivers/staging/media/meson/vdec/vdec.c:vdec_start_streaming() {
    ...
	mutex_lock(&core->lock);
    ...
}

Because the device's vdev->lock is mapped directly to &core->lock, the V4L2=
=20
core framework automatically acquires it before dispatching standard ioctls=
.=20

Does explicitly calling mutex_lock(&core->lock) inside these callbacks=20
result in a permanent self-deadlock?

[Severity: High]
Is there an AB-BA deadlock during stream teardown?

During streamoff:

drivers/staging/media/meson/vdec/vdec.c:vdec_stop_streaming() {
    ...
		cancel_work_sync(&sess->esparser_queue_work);
    ...
}

The ioctl thread acquires sess->lock before invoking this callback.=20
Concurrently, the background workqueue thread esparser_queue_all_src()=20
blocks waiting for sess->lock.=20

Does calling cancel_work_sync() here cause the ioctl thread to block foreve=
r=20
waiting for the worker thread, resulting in an AB-BA deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D10
