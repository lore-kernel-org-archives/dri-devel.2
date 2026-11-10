Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B552606A323
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEkfPUv9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38B410E21A;
	Tue, 10 Nov 2026 16:07:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D9A10E21C
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:07:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3235161DB5;
 Tue, 10 Nov 2026 16:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6B81F0089F;
 Tue, 10 Nov 2026 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794326871;
 bh=dsVttSU2RkZpEDO+oRSOxLU+neTVzd8mYl0UGatgTJ8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=TEkfPUv9QqY0QG0lVxS8mJMQlomtTejjPnyCr66FZH/y2lsu0nyAgGD9y10BkgYDd
 aNhm9AThVNCURirY8A+a21WIineCCzLcyst7NvWy+ivGuUFP5nC8IkVgKxjL7O4tWG
 NeUly1eUG09jHbprSJz0WZm0n46QSfFK9SR/RzUmpLVewNFFzcHDINoAZkbjNpMzAK
 8BqvziPlI2xCBiK7s1mMvqUzgKM1PpDCED1sjWMevtilLNwTTS6yDskv6UC+xigyVL
 Qy0k6c+NFUypm10LyewH5kR/xnm32XeB+CLQFCBW82UgAPsXCk1sYIuuVv2t/I9X4T
 McTO2tLyQCnxg==
Message-ID: <sashiko-outbox-207340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/28] drm/panthor: Add AM_RESOURCE_GROUP support
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-17-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-17-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:07:51 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/panthor: lost AW message interrupt in
  rg_irq_raw_handler()
--

commit 4a3c9d76bb48fcfdcf16aaac9521c7316fca8936
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add AM_RESOURCE_GROUP support

This commit adds resource-group support to the Panthor arbitration driver,
including MMIO and IRQ setup, per-access-window message handling, handshake
negotiation, and runtime PM callbacks.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c=
 b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
> new file mode 100644
> index 0000000000000..e413cfd9e6d25
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c

[ ... ]

> +static irqreturn_t rg_irq_raw_handler(int irq, void *data)
> +{
> +	struct panthor_resource_group *rg =3D data;
> +	unsigned long message_mask;
> +	u32 status;
> +	u8 aw_id;
> +
> +	scoped_guard(spinlock_irqsave, &rg->irq_lock) {
> +		if (rg->irq_suspended)
> +			return IRQ_NONE;
> +	}
> +
> +	status =3D gpu_read(rg->iomem, AM_RG_IRQ_STATUS);
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	message_mask =3D status;
> +	for_each_set_bit(aw_id, &message_mask, AM_ARB_MAX_AW_COUNT) {
> +		u64 message =3D panthor_am_msg_read(&rg->aw_data[aw_id].msg);
> +
> +		rg_handle_message(rg, aw_id, message);
> +	}
> +
> +	gpu_write(rg->iomem, AM_RG_IRQ_CLEAR, status);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void rg_drain_pending_messages(struct panthor_resource_group *rg)
> +{
> +	unsigned long message_mask;
> +	u8 aw_id;
> +
> +	if (pm_runtime_status_suspended(rg->dev))
> +		return;
> +
> +	message_mask =3D gpu_read(rg->iomem, AM_RG_IRQ_RAWSTAT) & AM_RG_MESSAGE=
_MASK;
> +
> +	for_each_set_bit(aw_id, &message_mask, AM_ARB_MAX_AW_COUNT) {
> +		u64 message =3D panthor_am_msg_read(&rg->aw_data[aw_id].msg);
> +
> +		rg_handle_message(rg, aw_id, message);
> +	}
> +
> +	gpu_write(rg->iomem, AM_RG_IRQ_CLEAR, message_mask);
> +}

[Severity: Medium]
Can writing AM_RG_IRQ_CLEAR after the loop in rg_irq_raw_handler() and
rg_drain_pending_messages() clear a follow-up access-window interrupt
before its message is read?

When rg_handle_message() processes an unacknowledged VM_ARB_INIT from an
access window, rg_respond_to_handshake() immediately sends ARB_VM_INIT back
to that access window before the loop finishes and writes AM_RG_IRQ_CLEAR:

CPU0 (resource group)             CPU1 / VM (access window aw_id)
rg_irq_raw_handler()
  status =3D gpu_read(AM_RG_IRQ_STATUS)
  panthor_am_msg_read()
  rg_handle_message()
    rg_respond_to_handshake()
      rg_send_init_msg(ARB_VM_INIT)
                                  receives ARB_VM_INIT
                                  sends VM_ARB_GPU_REQUEST
                                  (asserts BIT(aw_id) in AM_RG_IRQ_RAWSTAT)
  gpu_write(AM_RG_IRQ_CLEAR, status)
    <-- clears BIT(aw_id) without reading VM_ARB_GPU_REQUEST

If the hardware also keeps the sender's AM_OUTGOING_MESSAGE_STATUS busy
until AM_RG_IRQ_CLEAR is written, delaying the clear until after
rg_handle_message() leaves the access window's outgoing slot busy while it
handles the reply.  In either case, a missed VM_ARB_GPU_REQUEST or
VM_ARB_GPU_STOPPED stalls GPU access acquisition or partition scheduling
until the request timeout expires.

Clearing BIT(aw_id) in AM_RG_IRQ_CLEAR right after panthor_am_msg_read()
and before rg_handle_message() would avoid this race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D16
