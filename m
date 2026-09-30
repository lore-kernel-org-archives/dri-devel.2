Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72931CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA89D10E00D;
	Wed, 30 Sep 2026 17:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JwnIZf8C";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C48210E00D
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 17:02:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BCB260252;
 Wed, 30 Sep 2026 17:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43C31F00898;
 Wed, 30 Sep 2026 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790787734;
 bh=cp/BLIDs0kDmegPnSSiuh20ytnXYA/Hqr08U1gj7YdA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JwnIZf8C3klaBVY3W79fy+JwhWH98n7mGNkBK6JRttDvz1FpgKLPhgE5PebiQgbtK
 b1mjvpGWQws7d4TmA7pKgSRySCH3+O59FUzb1c7TvXli638JrgLlyAU/jZKg4w1jlE
 apFbOvPeUXQYW5iAZfDSdeId8qEF+e9hToYKeytJwYiBmsSoxe3yagPcJ2aVXSdAK1
 vlWk6BhuhxO5Y40/ihiHwqMWwEu0NgO+4CuUDWoEo+iVZr7b76T3GI+fWZ65SStyeJ
 Xs7bOVUjThJFZ3bjfCvgAlSzY+xkAE2PZmwUbYP77CP1WVfkMBM+6/V0Kj8Hmhx7pb
 wMyLqvqsHYElQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: eliminate GFP_KERNEL allocation from
 mailbox send path
To: "Max Zhen" <max.zhen@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930164704.1049735-1-max.zhen@amd.com>
References: <20260930164704.1049735-1-max.zhen@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 17:02:14 +0000
Message-Id: <20260930170214.A43C31F00898@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] amdxdna: ABA vulnerability in msg_id accepts stale firmware respon=
ses
- [High] amdxdna: management channel bottleneck causes concurrent -ENOBUFS =
failures
- [Medium] amdxdna: xdna_mailbox_wait_ack() misses completion due to TOCTOU=
 on tail
--

commit ea210dde67519c35a295be58a57ebd45f0948e98
Author: Max Zhen <max.zhen@amd.com>

accel/amdxdna: eliminate GFP_KERNEL allocation from mailbox send path

This patch replaces the per-message dynamic allocations with a pre-allocated
pool of N slots. The message ID is updated to encode the slot index directly
for O(1) lookup, and the management channel size is bound statically based =
on
the maximum number of asynchronous events plus one.

> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -385,11 +386,16 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>  	}
> =20
>  	xdna_mailbox_intr_reg =3D ndev->aie.mgmt_i2x.mb_head_ptr_reg + 4;
> +	/*
> +	 * At any given time, at most AMDXDNA_MAX_ASYNC_EVENT_BUFS async event
> +	 * messages plus 1 other management command can be unresponded.
> +	 */
>  	ret =3D xdna_mailbox_start_channel(ndev->aie.mgmt_chann,
>  					 &ndev->aie.mgmt_x2i,
>  					 &ndev->aie.mgmt_i2x,
>  					 xdna_mailbox_intr_reg,
> -					 mgmt_mb_irq);
> +					 mgmt_mb_irq,
> +					 AMDXDNA_MAX_ASYNC_EVENT_BUFS + 1);

[Severity: High]
Could this hardcoded capacity lead to spurious -ENOBUFS failures for usersp=
ace?

Since 4 of the 5 slots are permanently consumed by asynchronous event buffe=
rs
waiting for firmware errors, only 1 slot is left for other management comma=
nds.
If two threads execute concurrent IOCTLs that issue management commands, wo=
n't
the second thread immediately fail with -ENOBUFS?

> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
[ ... ]
> @@ -248,8 +297,9 @@ mailbox_get_resp(struct mailbox_channel *mb_chann, st=
ruct xdna_msg_header *heade
>  		 void __iomem *data)
>  {
[ ... ]
> -	msg_id &=3D ~MAGIC_VAL_MASK;
> -	mb_msg =3D xa_erase_irq(&mb_chann->chan_xa, msg_id);
> -	if (!mb_msg) {
> -		MB_ERR(mb_chann, "Cannot find msg 0x%x", msg_id);
> +	slot =3D msg_id & ~MAGIC_VAL_MASK;
> +	if (unlikely(slot >=3D mb_chann->msg_buf_num)) {
> +		MB_ERR(mb_chann, "Invalid msg_id 0x%x", msg_id);
>  		return -EINVAL;
>  	}
> +	mb_msg =3D mailbox_msg_ptr(mb_chann, slot);
> =20
>  	MB_DBG(mb_chann, "opcode 0x%x size %d id 0x%x",
>  	       header->opcode, header->total_size, header->id);
> -	if (mb_msg->notify_cb) {
> -		ret =3D mb_msg->notify_cb(mb_msg->handle, data, header->total_size);
> -		if (unlikely(ret))
> -			MB_ERR(mb_chann, "Message callback ret %d", ret);
> +
> +	if (unlikely(!mb_msg->busy)) {
> +		MB_WARN_ONCE(mb_chann, "Unexpected response for idle slot 0x%x", msg_i=
d);
> +		return 0;
>  	}

[Severity: High]
Does replacing xa_alloc_cyclic_irq with a static ID using slot | MAGIC_VAL
introduce an ABA vulnerability here?

If a stale or duplicate firmware response arrives after a slot has been
reused for a completely new message, mb_msg->busy will be true again.
Since the msg_id no longer contains a sequence number to differentiate
between the old and new message, won't this allow a stale firmware
response to bypass the check and invoke the wrong callback with invalid
data?

[ ... ]
> @@ -398,8 +451,33 @@ static void mailbox_rx_worker(struct work_struct *rx=
_work)
>  		goto again;
>  }
> =20
> +static int xdna_mailbox_wait_ack(struct mailbox_channel *mb_chann, u64 t=
x_timeout_ms)
> +{
> +	u32 tail =3D mb_chann->x2i_tail;
> +	u32 head;
> +	int ret;
> +
> +	/*
> +	 * Poll until firmware advances the head pointer past our message,
> +	 * confirming it has consumed (acknowledged) the send.
> +	 */
> +	ret =3D read_poll_timeout(mailbox_get_headptr, head,
> +				head =3D=3D tail, 1000, tx_timeout_ms * 1000,
> +				false, mb_chann, CHAN_RES_X2I);

[Severity: Medium]
Can this polling loop stall for the full timeout duration due to a race
condition on the tail pointer?

The tail pointer is read outside the lock and might reflect a subsequent
message's tail if another thread concurrently sends a message. When the
firmware processes both messages, the head pointer will advance past the
expected tail.

Since the completion condition uses strict equality (head =3D=3D tail), won=
't it
permanently fail and cause the caller to stall until timeout if the head
overtakes the captured tail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930164704.1049=
735-1-max.zhen@amd.com?part=3D1
