Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFEACD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 21:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECAE10EB63;
	Wed, 17 Jun 2026 21:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="etJTjAJ7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F0D10EB63
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 21:36:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A94F40E21;
 Wed, 17 Jun 2026 21:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B0D1F000E9;
 Wed, 17 Jun 2026 21:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781732212;
 bh=WlVMQ8Mr+X/Zm0i+lz3syf4cgnIeT3isgWGu7TQuEN0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=etJTjAJ7KMXIjihj7HUnEwiWUdyr4MvoXwVn/TvWd83uH80k583APJ3J0FDH0IQnw
 j/58I+Z5faWVU22m4FytbN1AKZFTCt631T9AFBF7V6ZkMsU1rIHszrWhLnABgHp2K7
 PaKis/shT2gphwdRJK4Ya5c3oZ2l7U12HWVtEN3Xkl2twJTngbaElcjt8gfzkMEeG0
 ZLeMGtSxTom8WYiBHjiNDL9AWHfzkAsKgaFatrxsOrwkl9SgH8HNPQ6irZuIwM5QKh
 OsFpNm/QgrO5rLMo+eN3dp3TFDaJGalYH/k+tWp2e/CTnURX4mXToqEw8jXQVIKJgt
 90056BJogEhSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/qaic: use sizeof(*trans_hdr) for transaction
 length check
To: "Muhammad Bilal" <meatuni001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617212520.59801-1-meatuni001@gmail.com>
References: <20260617212520.59801-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 21:36:51 +0000
Message-Id: <20260617213652.52B0D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing transaction-specific size validation in encode_message=
 and decode_message allows kernel heap out-of-bounds access.
- [Critical] Incorrect remaining payload length calculation in decode_messa=
ge allows reading past the end of the device response buffer.
- [High] Missing `kfree(out_buf)` in `msg_xfer()` error path.
- [High] `decode_deactivate()` advances the message parsing length by a har=
dcoded size instead of the transaction header length.
- [High] `encode_activate` overwrites `resources->buf` with a new DMA coher=
ent allocation without checking for or freeing any pre-existing allocation.
- [High] `save_dbc_buf` improperly ignores the return value of `wait_event_=
interruptible`, leading to severe race conditions if interrupted by a signa=
l.
- [Medium] Malformed packet creation in `encode_status()` due to unvalidate=
d user-provided length.
--

commit 5efe51dab6d84a356365c2dd664f57b3a5563a27
Author: Muhammad Bilal <meatuni001@gmail.com>

accel/qaic: use sizeof(*trans_hdr) for transaction length check

The commit fixes a bug in encode_message() where the transaction length
was being compared against the pointer size instead of the struct size.
It correctly replaces sizeof(trans_hdr) with sizeof(*trans_hdr).

> diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_=
control.c
> index bb94d3556904a..50bf3340e49ce 100644
> --- a/drivers/accel/qaic/qaic_control.c
> +++ b/drivers/accel/qaic/qaic_control.c
> @@ -786,7 +786,7 @@ static int encode_message(struct qaic_device *qdev, s=
truct manage_msg *user_msg,
>  			break;
>  		}
>  		trans_hdr =3D (struct qaic_manage_trans_hdr *)(user_msg->data + user_l=
en);
> -		if (trans_hdr->len < sizeof(trans_hdr) ||
> +		if (trans_hdr->len < sizeof(*trans_hdr) ||
>  		    size_add(user_len, trans_hdr->len) > user_msg->len) {
>  			ret =3D -EINVAL;
>  			break;

[Severity: Critical]
This is a pre-existing issue, but does `encode_message()` validate that the
transaction length is sufficient for the specific transaction structure?

For example, in `encode_dma()`:

drivers/accel/qaic/qaic_control.c:encode_dma() {
    ...
    struct qaic_manage_trans_dma_xfer *in_trans =3D trans;
    if (check_add_overflow(in_trans->addr, resources->xferred_dma_size, &xf=
er_start_addr))
    ...
}

If a user supplies a valid transaction near the end of the buffer with a
length of 8, is it possible for `encode_dma()` to read `in_trans->addr` out
of bounds since the generic checks only verify the 8-byte generic header?

Similarly, in `decode_activate()`:

drivers/accel/qaic/qaic_control.c:decode_activate() {
    ...
    out_trans->status =3D le32_to_cpu(in_trans->status);
    out_trans->dbc_id =3D le32_to_cpu(in_trans->dbc_id);
    out_trans->options =3D le64_to_cpu(in_trans->options);
    ...
}

Can this write out of bounds past the kernel allocation if the device
supplies a truncated transaction?

[Severity: High]
This is a pre-existing issue, but are we unconditionally leaking `out_buf`
in the `msg_xfer()` error path?

drivers/accel/qaic/qaic_control.c:msg_xfer() {
    ...
    if (ret) {
        mutex_unlock(&qdev->cntl_mutex);
        return ERR_PTR(ret);
    }
    ...
}

If `mhi_queue_buf()` fails to queue the buffer, this error path unlocks the
mutex and returns immediately. Shouldn't we be freeing the buffer here?

[Severity: Medium]
This is a pre-existing issue, but could `encode_status()` send a malformed
packet?

drivers/accel/qaic/qaic_control.c:encode_status() {
    ...
    trans_wrapper->len =3D sizeof(*out_trans);
    out_trans =3D (struct wire_trans_status_to_dev *)&trans_wrapper->trans;

    out_trans->hdr.type =3D cpu_to_le32(QAIC_TRANS_STATUS_TO_DEV);
    out_trans->hdr.len =3D cpu_to_le32(in_trans->hdr.len);
    msg->hdr.len =3D cpu_to_le32(msg_hdr_len + in_trans->hdr.len);
    ...
}

The user-provided length is injected into the wire header, but the actual
wrapper transfer length is clamped to the structure size. Will MHI transmit
fewer bytes than the wire packet header claims if `in_trans->hdr.len` is
greater than 8?

[Severity: High]
This is a pre-existing issue, but does `decode_deactivate()` advance the
message parsing length correctly?

drivers/accel/qaic/qaic_control.c:decode_deactivate() {
    ...
    *msg_len +=3D sizeof(*in_trans);
    ...
}

If the firmware sends a larger transaction structure, will the parser lose
synchronization by advancing by a hardcoded size instead of the parsed
dynamic header length?

[Severity: High]
This is a pre-existing issue, but might `encode_activate()` overwrite
`resources->buf` and leak the previous allocation?

drivers/accel/qaic/qaic_control.c:encode_activate() {
    ...
    buf =3D dma_alloc_coherent(&qdev->pdev->dev, size, &dma_addr, GFP_KERNE=
L);
    if (!buf)
        return -ENOMEM;
    ...
    resources->buf =3D buf;
    ...
}

If userspace provides a message with multiple activation transactions,
could a local user loop this to exhaust contiguous physical memory by
continuously overwriting the tracking pointer without freeing?

[Severity: High]
This is a pre-existing issue, but are we at risk of corrupting hardware
state tracking if interrupted by a signal in `save_dbc_buf()`?

drivers/accel/qaic/qaic_control.c:save_dbc_buf() {
    ...
    wait_event_interruptible(qdev->dbc[dbc_id].dbc_release, !qdev->dbc[dbc_=
id].in_use);
    qdev->dbc[dbc_id].req_q_base =3D resources->buf;
    ...
}

If the process receives a signal, the wait returns `-ERESTARTSYS`
immediately. By ignoring this return value, does the driver proceed to
overwrite the DBC queues and forcibly set `in_use =3D true` while the DBC
is still actively used by another context?

[Severity: Critical]
This is a pre-existing issue, but wouldn't the bounds check in
`decode_message()` allow reading past the end of the device response buffer?

drivers/accel/qaic/qaic_control.c:decode_message() {
    ...
    if (hdr_len < sizeof(*trans_hdr) ||
        size_add(msg_len, hdr_len) > msg_hdr_len)
        return -EINVAL;
    ...
}

The variable `msg_hdr_len` includes the 32-byte header itself, while
`msg_len` tracks the offset in `msg->data`. By comparing against
`msg_hdr_len` directly instead of `msg_hdr_len - sizeof(msg->hdr)`, does
this allow `hdr_len` to exceed the actual remaining bytes in `msg->data` by
32 bytes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617212520.5980=
1-1-meatuni001@gmail.com?part=3D1
