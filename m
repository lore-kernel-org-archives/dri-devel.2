Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB75C61DCB
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 08:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B7910E069;
	Sat, 29 Aug 2026 08:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WJghy8n2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE17910E069
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 08:09:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9BC62601FE;
 Sat, 29 Aug 2026 08:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA6D1F000E9;
 Sat, 29 Aug 2026 08:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787990943;
 bh=BwQM8yNn1KrjQcbMm93ywuioFEYyKpdFTK7iJqwIXng=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WJghy8n2jf0rVJqDdJr0jq+1/bHRoyMoB9obUP2U8oDgw68lrMUHDEYCByD3IKqs9
 tE5Gl5PPmk04iu3kDhznlB8vPzBNjEwVA/bPL3F/bpf4nXHRi+AhMYywQzKJP5fjhm
 Xuf14Y0OpEzMEz9+zYlbT9Yb/82HCMpqSaxOB8SqcGwIqBHwCqExx3jL2PLMGu9vSx
 zIRsR9ZgrTIqCa4wQ8uneu5kwYgGHi684gzpTeWqBh00b7CCOSnFrvi2yPARUCKQnd
 hjinz46HtVRk/FYFETejMdVC5XQdLmUjpfDiBcFTTd/E2MszKaMdXqVN92FvVDAeXr
 1MC9tR0yt8KYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/amdxdna: fix race condition in mailbox send path
To: "Deniz Aydogan" <denizaydogan1902@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260829075303.7457-1-denizaydogan1902@gmail.com>
References: <20260828221641.10034-1-denizaydogan1902@gmail.com>
 <20260829075303.7457-1-denizaydogan1902@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 08:09:02 +0000
Message-Id: <20260829080903.1EA6D1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Hardware stall and wait loop timeout due to missing TOMBSTONE =
notification.
- [High] Incorrect wait condition when the ring buffer wraps and head =3D=
=3D 0 leads to unconsumed messages being overwritten.
- [High] The tx_timeout parameter is ignored, causing premature failures.
- [High] Out-of-bounds write of TOMBSTONE due to incorrect maximum message =
size validation.
--

commit 267903cdb6f1ef0ba02cbd6bf4adfbe91f048bd9
Author: Deniz Aydogan <denizaydogan1902@gmail.com>

accel/amdxdna: fix race condition in mailbox send path

mailbox_send_msg() reads and updates x2i_tail without any
synchronization. The DRM scheduler and ioctl paths can call
xdna_mailbox_send_msg() concurrently on the same channel, which
allows two threads to read the same tail value and corrupt the
hardware ring buffer.

Add a mutex to serialize the entire send path. A mutex is used
rather than a spinlock because the existing code calls
read_poll_timeout() with a non-zero sleep, which can reschedule.

> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdx=
dna/amdxdna_mailbox.c
> index cc8865f4e79c9..1d554fb943f2a 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
[ ... ]
> @@ -225,8 +228,10 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, s=
truct mailbox_msg *mb_msg)
>  		ret =3D read_poll_timeout(mailbox_get_headptr, head,
>  					tmp_tail < head || tail >=3D head,
>  					1, 100, false, mb_chann, CHAN_RES_X2I);

[Severity: High]
This is a pre-existing issue, but xdna_mailbox_send_msg() receives a
tx_timeout parameter that is dropped here.

Does hardcoding a 100-microsecond timeout instead of using the caller's
requested tx_timeout cause the send path to fail with -ETIMEDOUT prematurely
under load?

> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&mb_chann->lock);
>  			return ret;
> +		}
> =20
>  		if (tail >=3D head)
>  			goto check_again;

I have a few questions about the wait condition and wrapping logic just bef=
ore
this wait loop:

drivers/accel/amdxdna/amdxdna_mailbox.c:mailbox_send_msg() {
	if (tail >=3D head && tmp_tail > ringbuf_size) {
		write_addr =3D mb_chann->mb->res.ringbuf_base + start_addr + tail;
		writel(TOMBSTONE, write_addr);

		/* tombstone is set. Write from the start of the ringbuf */
		tail =3D 0;
		tmp_tail =3D tail + mb_msg->pkg_size;
	}

	if (tail < head && tmp_tail >=3D head) {
		ret =3D read_poll_timeout(...);
...

[Severity: Critical]
This is a pre-existing issue, but when the ring buffer wraps and a TOMBSTONE
is written, does the hardware require a doorbell update before entering the
wait loop?

Because mailbox_set_tailptr() is not called after writel(TOMBSTONE,
write_addr), can the hardware stall and the wait loop timeout because it was
never notified to process the TOMBSTONE?

[Severity: High]
This is also a pre-existing issue, but if the ring buffer wraps and tail
resets to 0, does the next condition if (tail < head && tmp_tail >=3D head)
evaluate incorrectly if head is still 0?

If head is still 0 because the hardware hasn't processed early messages,
tail < head evaluates to false (0 < 0), completely bypassing the wait loop.
Can this bypass cause the driver to immediately overwrite unconsumed messag=
es
at offset 0?

Finally, regarding the size validation:

drivers/accel/amdxdna/amdxdna_mailbox.c:xdna_mailbox_send_msg() {
...
	if (pkg_size > mailbox_get_ringbuf_size(mb_chann, CHAN_RES_X2I)) {
		MB_ERR(mb_chann, "Message size larger than ringbuf size");
		return -EINVAL;
	}
...

[Severity: High]
This is a pre-existing issue, but does the maximum message size validation =
in
xdna_mailbox_send_msg() fail to reserve 4 bytes for the TOMBSTONE marker?

If a message size exactly matches the physical ring buffer size, it fills t=
he
buffer and tail advances to exactly ringbuf_size.

When the next send wraps and attempts to write the TOMBSTONE:

drivers/accel/amdxdna/amdxdna_mailbox.c:mailbox_send_msg() {
...
	if (tail >=3D head && tmp_tail > ringbuf_size) {
		write_addr =3D mb_chann->mb->res.ringbuf_base + start_addr + tail;
		writel(TOMBSTONE, write_addr);
...

Will this write the 4-byte TOMBSTONE entirely out-of-bounds past the end of
the allocated physical ring buffer, corrupting adjacent device memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829075303.7457=
-1-denizaydogan1902@gmail.com?part=3D1
