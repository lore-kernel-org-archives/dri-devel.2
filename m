Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247B1C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 586A910EE6C;
	Tue, 22 Sep 2026 20:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IkeTx1yy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF90010EE6C
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:56:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B8CDF4029D;
 Tue, 22 Sep 2026 20:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1DE1F000FF;
 Tue, 22 Sep 2026 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790110598;
 bh=N5Aew1QGpcGcgAL56cWdmFKQOzCE8HnWBXPBVpQMGY0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IkeTx1yy3ISSpJjMrAsgbJZKGW5yO38MIePUCBsLPsnjaC0OsXXeZVgqUBFa0mbyg
 jJtzD865/zvxEk7wcZy+HbzSSbgp1uLlw6POWG9oYpsyDVEAec3dKNuxIPPXN/tUCM
 0/kPsRb+/JsuNfJrgNpIDarciirVU1Cpt929bX2tsjLi095by8MIFU6N3jIi6PB41s
 q3BeEQttvDUqVFamN2Mbb+/rEw+PK4d0nMYIkOWdtSQJQ7KVDndpOYKw57L2N0kVKa
 X97DhHF2K6rBWcDVWyRpneMoFAsNq3bgtcxSKN0fllMUVTHKVmoEJMpZOS08bgfwn1
 IRvrqLPXDagTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 15/27] drm/panthor: Add AM_RESOURCE_GROUP support
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-16-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-16-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:56:38 +0000
Message-Id: <20260922205638.7B1DE1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Runtime PM handling missing in shared IRQ handler
- [High] Missing synchronize_irq() during runtime suspend
- [High] CPU busy-loop in message retry workqueue
- [Medium] Missing NULL pointer checks for devm_kasprintf allocations
- [Low] Uninitialized irq field in panthor_resource_group
--

commit 97f87eba41075ad8e7f232b378d4561b841f68e5
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add AM_RESOURCE_GROUP support

Add resource-group probing for the arbitration device, including MMIO
resources, IRQ handling, per-AW AM message helpers, handshake
negotiation, and retry work for deferred outgoing messages. Hook
resource groups into arbitration init, teardown, and runtime PM.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c=
 b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
> @@ -0,0 +1,323 @@
[ ... ]
> +static void rg_retry_messages(struct work_struct *work)
> +{
[ ... ]
> +	if (retry)
> +		queue_work(rg->wq, &rg->msg_retry_work);

[Severity: High]
Could this sequence lead to a CPU busy-loop? If the hardware has pending
messages and panthor_am_msg_retry() returns -EBUSY or -EAGAIN, this will
immediately requeue the work. Because it is an ordered workqueue and no
delay is specified, does this cause the worker thread to monopolize the
CPU at 100% until the hardware processes the messages?

[ ... ]
> +static irqreturn_t rg_irq_raw_handler(int irq, void *data)
> +{
> +	struct panthor_resource_group *rg =3D data;
> +	unsigned long message_mask;
> +	u32 status;
> +	u8 aw_id;
> +
> +	status =3D gpu_read(rg->iomem, AM_RG_IRQ_STATUS);
> +	if (!status)
> +		return IRQ_NONE;

[Severity: High]
Is it safe to perform this MMIO read without verifying device activity?
Since the IRQ is registered with IRQF_SHARED, this handler can be invoked
by other devices on the same line while this device is in runtime suspend.

If the device is powered down, the read will typically return ~0u, which
bypasses the !status check and could result in spurious processing of 16
pending messages. Should this use pm_runtime_get_if_active() to verify
the device is awake before accessing hardware?

[ ... ]
> +int panthor_resource_group_suspend(struct panthor_arbitration *adev)
> +{
> +	for (int i =3D 0; i < AM_ARB_MAX_RG_COUNT; i++) {
> +		struct panthor_resource_group *rg =3D adev->rg[i];
> +
> +		if (!rg)
> +			continue;
> +
> +		rg_irq_suspend(rg);
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Does this suspend sequence need to wait for in-flight interrupts? The IRQ
is masked at the device level, but since it is registered as IRQF_SHARED,
rg_irq_raw_handler() might still be executing concurrently on another CPU.
Should there be a synchronize_irq() call here to prevent the device from
powering down while the handler is still running?

[ ... ]
> +static int resource_group_init(struct panthor_arbitration *adev,
> +			       const struct fwnode_handle *child)
> +{
[ ... ]
> +	rg =3D devm_kzalloc(dev, sizeof(*rg), GFP_KERNEL);
> +	if (!rg)
> +		return -ENOMEM;
> +
> +	name =3D devm_kasprintf(dev, GFP_KERNEL, "rg%d", res.id);

[Severity: Medium]
Could name be NULL here under memory pressure? devm_kasprintf() isn't
checked for allocation failure before being passed into functions expecting
valid strings, like devm_alloc_ordered_workqueue() below.

[ ... ]
> +	irq =3D fwnode_irq_get(child, 0);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "%s: Failed to get IRQ", name);
> +
> +	irqdata =3D irq_get_irq_data(irq);
> +	if (irqdata)
> +		irq_flags =3D irqd_get_trigger_type(irqdata);

[Severity: Low]
Should the retrieved IRQ number be stored in rg->irq here? The local irq
variable is populated and used for requesting the interrupt, but it doesn't
appear to be assigned to the structure field for future use.

> +
> +	ret =3D devm_request_irq(
> +		dev, irq, rg_irq_raw_handler, irq_flags | IRQF_SHARED,
> +		devm_kasprintf(dev, GFP_KERNEL, "panthor-%s-irq", name), rg);

[Severity: Medium]
Similar to the earlier devm_kasprintf() call, could this inner allocation
fail and pass a NULL device name to devm_request_irq()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D15
