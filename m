Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADE2C61DD7
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A209A10E07D;
	Fri, 28 Aug 2026 22:28:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KCZL+uL9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF4E10E07D
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 22:28:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 199744374F;
 Fri, 28 Aug 2026 22:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DC91F00AC4;
 Fri, 28 Aug 2026 22:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787956095;
 bh=coSrFZG4sQU3Djycv3JnwXtAFMyWPSZl7evMesYYYa0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KCZL+uL9Qe7fPvKpsh1wxCBSObE8Ocz4J4FGSyl8Ay/cSSqgyok40uvZWzPxNWlk2
 0Xb8Q+/39V3d+V9izumDe6v8Jol1LJYtynDaoAFBLd4U5mwlmhIhrTTQrhX4P5eCPM
 8Gz7YBWIiKhEKN9Oqusbjd5+wjMDqFyC1vrgd2QduVDVRkO1xkIAjSoxwGp5AYzRfd
 GenU0zfsJ6WQA8M+nAFCBGgd7iSP9/m4LGKcyFCgefzoXaoYPyzJ9XRUVKqMvD4xZI
 jpxmcUnkShMn0fHCjAjObNgQIn3wJUPpQangoSMgy9k2NCVZ2+4HjgkHsh+f6Y+36x
 4+NRRMA4ZCMOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: fix race condition in mailbox send path
To: "Deniz Aydogan" <denizaydogan1902@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828221641.10034-1-denizaydogan1902@gmail.com>
References: <20260828221641.10034-1-denizaydogan1902@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 22:28:14 +0000
Message-Id: <20260828222814.C5DC91F00AC4@smtp.kernel.org>
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
- [High] Calling a sleeping function (`read_poll_timeout`) while holding a =
spinlock in atomic context, leading to a kernel BUG.

Pre-existing issues:
- [High] An off-by-four bounds check error in message size validation allow=
s a message to equal the total ring buffer capacity, leading to an out-of-b=
ounds TOMBSTONE write on the subsequent message.
--

commit 53ca6b8d64c390a01eafa41c7e331865b9a73f9b
Author: Deniz Aydogan <denizaydogan1902@gmail.com>

accel/amdxdna: fix race condition in mailbox send path

This commit introduces a spinlock in mailbox_send_msg() to prevent
concurrent writers from overwriting messages and writing conflicting
tail pointers to the hardware ring buffer.

> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdx=
dna/amdxdna_mailbox.c
> index cc8865f4e79c9..bb0cb34b41a7b 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
[ ... ]
> @@ -203,8 +204,10 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, s=
truct mailbox_msg *mb_msg)
>  	u32 head, tail;
>  	u32 start_addr;
>  	u32 tmp_tail;
> +	unsigned long flags;
>  	int ret;
> =20
> +	spin_lock_irqsave(&mb_chann->lock, flags);
>  	head =3D mailbox_get_headptr(mb_chann, CHAN_RES_X2I);
>  	tail =3D mb_chann->x2i_tail;

[Severity: High]
This is a pre-existing issue, but does the bounds check in
xdna_mailbox_send_msg() allow a message to equal the total ring buffer
capacity, leaving no room for the wrap tombstone marker?

If a message is exactly equal to the maximum ring buffer capacity:

drivers/accel/amdxdna/amdxdna_mailbox.c:xdna_mailbox_send_msg() {
    ...
    if (pkg_size > mailbox_get_ringbuf_size(mb_chann, CHAN_RES_X2I)) {
    ...
}

During this first send, the tail pointer is advanced to equal the total
buffer size. On the next send, the wrap-around logic in mailbox_send_msg()
triggers:

drivers/accel/amdxdna/amdxdna_mailbox.c:mailbox_send_msg() {
    ...
    if (tail >=3D head && tmp_tail > ringbuf_size) {
        write_addr =3D mb_chann->mb->res.ringbuf_base + start_addr + tail;
        writel(TOMBSTONE, write_addr);
    ...
}

Since the tail is already at the end of the buffer, will this write the
4-byte TOMBSTONE marker out-of-bounds?

[ ... ]
> @@ -225,8 +228,10 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, s=
truct mailbox_msg *mb_msg)
>  		ret =3D read_poll_timeout(mailbox_get_headptr, head,
>  					tmp_tail < head || tail >=3D head,
>  					1, 100, false, mb_chann, CHAN_RES_X2I);

[Severity: High]
Does this code call a sleeping function while holding a spinlock in atomic
context?

mailbox_send_msg() acquires mb_chann->lock via spin_lock_irqsave(),
disabling interrupts. Inside this critical section, it calls
read_poll_timeout() with sleep_us =3D 1.

read_poll_timeout() internally calls poll_timeout_us(), which uses
usleep_range(), a sleeping function.

Could this lead to a scheduling-while-atomic bug when the driver waits for
ring buffer space?

> -		if (ret)
> +		if (ret) {
> +			spin_unlock_irqrestore(&mb_chann->lock, flags);
>  			return ret;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828221641.1003=
4-1-denizaydogan1902@gmail.com?part=3D1
