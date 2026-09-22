Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB1CC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E27810EE70;
	Tue, 22 Sep 2026 20:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M3VaUaxU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097E110EE70
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:58:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 833E3600D4;
 Tue, 22 Sep 2026 20:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC3E1F000FF;
 Tue, 22 Sep 2026 20:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790110682;
 bh=L3fML1K9BkJZ/m4xdBlEA6lO7QL51Dx8OE31w/IjCWc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M3VaUaxUBrvA3Iw0BT/kvC/PbDdeDENqV3gHtHZeUE0XBr5hD8lSj0D16JKL6CbUc
 KP4zIB/VNswD/3Mtr7j4Uv9I7ne4CziBX+CwOkko8/zhnlBTpfWZtLu32mn14rK5SN
 lquo76RhbTf0kKFLN9cxpW8BjrvwSUOOVjSpCYMmBuqwijZvCEsW0FqoIkPhRIH3EK
 +mFaxV3rRigi3WfThtk7m6Ex0OpnnMsjrY5Hqxe03FsbuhfHs/3rBlvvsHyFyHAKu/
 ox1SL9vn37RogUuwBH3ZOQiIy9qIC80fbUHeTVE2XrB94qWIUse5Zv77h7qEHo+334
 fKj9KBHCcFKpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 14/27] drm/panthor: Add AM message helpers
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-15-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-15-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:58:01 +0000
Message-Id: <20260922205802.1AC3E1F000FF@smtp.kernel.org>
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
- [High] Hardware race condition in panthor_am_msg_send() allows mailbox ov=
erwrite
- [Medium] gpu_read64() unspecified evaluation order in panthor_am_msg_read=
()
--

commit f795794def90956d30543ae04795a4ad4e76dd7e
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add AM message helpers

This commit adds a shared helper layer for the AM_MESSAGE registers used by
v15 GPUs. It defines message IDs, register accessors, and a FIFO-backed
sending mechanism with spinlock serialization.

> diff --git a/drivers/gpu/drm/panthor/panthor_am_msg.h b/drivers/gpu/drm/p=
anthor/panthor_am_msg.h
> new file mode 100644
> index 0000000000000..fc1e3f1051fe5
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_am_msg.h
[ ... ]
> +static inline u64 panthor_am_msg_read(struct panthor_am_msg *msg)
> +{
> +	return gpu_read64(msg->iomem, AM_INCOMING_MESSAGE0);
> +}

[Severity: Medium]
Could the unspecified evaluation order of the bitwise OR in gpu_read64()
cause hardware side-effect issues here?

Looking at gpu_read64() in panthor_device_io.h:

static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
{
	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
}

The C standard leaves the evaluation order of bitwise OR operands unspecifi=
ed.

If reading AM_INCOMING_MESSAGE0 has side effects (like clearing an interrupt
or popping a message queue), could the compiler evaluating the upper word
read before the lower word read lead to corrupted data or desynchronized
hardware state?

[ ... ]
> +static inline int panthor_am_msg_retry(struct panthor_am_msg *msg)
> +{
> +	u64 message;
> +
> +	guard(spinlock_irqsave)(&msg->lock);
> +
> +	if (kfifo_is_empty(&msg->send_fifo))
> +		return 0;
> +
> +	if (panthor_am_msg_pending(msg))
> +		return -EBUSY;

[Severity: High]
Is it possible for a race condition to occur with the hardware status update
here?

If the workqueue executes rapidly after a previous write,
panthor_am_msg_pending() might read as not busy due to hardware or internal
firmware propagation delays.

If the hardware status hasn't updated yet, could this cause the software to
overwrite the previous message in the mailbox?

> +
> +	/* FIFO should never be empty at this point */
> +	if (!kfifo_get(&msg->send_fifo, &message))
> +		return -EINVAL;
> +
> +	panthor_am_msg_write(msg, message);
> +
> +	/* There are still messages in the FIFO, notify caller to retry again */
> +	if (!kfifo_is_empty(&msg->send_fifo))
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +
> +static inline int panthor_am_msg_send(struct panthor_am_msg *msg, u64 me=
ssage)
> +{
> +	guard(spinlock_irqsave)(&msg->lock);
> +
> +	/*
> +	 * If there already is a pending message in the FIFO or the outgoing
> +	 * message is still not read by the receipient, add to the FIFO.
> +	 */
> +	if (!kfifo_is_empty(&msg->send_fifo) || panthor_am_msg_pending(msg)) {

[Severity: High]
Similar to panthor_am_msg_retry(), could back-to-back calls to
panthor_am_msg_send() fail to observe the busy state from a preceding write?

If a CPU sends a message and another CPU (or the same CPU) immediately
acquires the lock to send a second message, the hardware status might
falsely read as 0.

Could this cause the second message to overwrite the first message in the
hardware mailbox before the firmware has processed it, leading to lost
messages?

> +		if (!kfifo_put(&msg->send_fifo, message))
> +			return -ENOSPC;
> +
> +		/*
> +		 * return -EBUSY to indicate to the caller to schedule work to
> +		 * retry sending messages in the FIFO.
> +		 */
> +		return -EBUSY;
> +	}
> +
> +	/* We are free to write to AM_OUTGOING_MESSAGE */
> +	panthor_am_msg_write(msg, message);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D14
