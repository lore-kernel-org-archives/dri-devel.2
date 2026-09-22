Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1B0C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B1410EE6F;
	Tue, 22 Sep 2026 20:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l4IiCKPf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A16D10EE6F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:57:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2614600D4;
 Tue, 22 Sep 2026 20:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6934D1F000FF;
 Tue, 22 Sep 2026 20:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790110676;
 bh=jT69s10MQH+FGtD0wB9lDHVuM8jG8TfrHvCeU1k+JI4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l4IiCKPffaCWZ/lGuZCV0fAkfa6OCJWYzyl5Gb3Mcf54F48EBpS6sH/M+BMI2j8ui
 P6Wmcff8vKv0OEKKUqKIg5OQwTxBOZA44w1ycY1iqqgc01WSZ8P+oDxMa3A4OsbjW+
 Ff6zXWW4hdlrKbhxVwhN95QeOKmLMGWfVtot7T/lxPjNu8uXT6gsvU9uq3u8IDkUq7
 qv2z3fZVsfh5uHDEUrnNwziOAGcyiLVjTQQPyi/oDunQIqsXdvn+p+yMhKTObBkX9T
 ty4wxMJJO4xCsYoUPBSt/Y1iE+OLd58w2Oj0y8Tn9o6GDyuhVlSkfnhqUY+yePud0P
 YIXSrFomIc+1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/27] drm/panthor: Add AM_PARTITION_CONTROL support
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-14-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-14-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:57:56 +0000
Message-Id: <20260922205756.6934D1F000FF@smtp.kernel.org>
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
- [High] pm: Unsafe shared IRQ handling without Runtime PM validation
- [High] drm/panthor: CPU soft lockup risk in partition_state_wait()
- [Medium] pm: Hardware power leak due to pm_runtime_put_noidle() on teardo=
wn paths
- [Medium] drm/panthor: OPEN_WINDOW command issued without waiting for hard=
ware reset
- [Medium] drm/panthor: TOCTOU race in window_open() and window_close()
- [Medium] drm/panthor: Type mismatch passing resource_size_t to %llx forma=
t specifier
- [Low] drm/panthor: Missing NULL check for devm_kasprintf() string allocat=
ion
--

commit aae06968ea5bf0c6d7a668bdeb14d91ee2943a9e
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add AM_PARTITION_CONTROL support

Mali v15 AM GPUs expose AM_PARTITION_CONTROL blocks to manage partition
access windows. Add a panthor arbitration platform driver and wire it into
Kconfig and the panthor build.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.=
c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
> new file mode 100644
> index 0000000000000..09342245a47d1
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c

[ ... ]

> +int panthor_arbitration_parse_resource(struct device *dev,
> +				       const struct fwnode_handle *child,
> +				       struct panthor_arbitration_resource *res)
> +{

[ ... ]

> +	if (!fwnode_property_present(child, DT_ID)) {
> +		dev_warn(dev, "Missing '%s' property in %s@%llx", DT_ID, name,
> +			 res->res.start);
> +		return -ENODEV;
> +	}
> +
> +	ret =3D fwnode_property_read_u32(child, DT_ID, &res->id);
> +	if (ret) {
> +		dev_warn(dev, "Malformed '%s' property in %s@%llx", DT_ID, name,
> +			 res->res.start);

[Severity: Medium]
Will passing res->res.start (a resource_size_t) to a %llx format specifier
corrupt the variadic stack arguments on 32-bit builds?

[ ... ]

> +static int panthor_arbitration_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	ret =3D panthor_partition_control_init(adev);
> +	if (ret)
> +		goto err_term_pc;
> +
> +	ret =3D of_platform_populate(dev->of_node, NULL, NULL, dev);
> +	if (ret)
> +		goto err_depopulate;
> +
> +	pm_runtime_set_autosuspend_delay(dev, PANTHOR_PM_AUTOSUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +
> +err_depopulate:
> +	of_platform_depopulate(dev);
> +
> +err_term_pc:
> +	panthor_partition_control_term(adev);
> +	pm_runtime_put_noidle(dev);
> +	return ret;

[Severity: Medium]
Does using pm_runtime_put_noidle() here leave the hardware permanently
powered on during a probe failure?

Since devres cleanup will invoke pm_runtime_disable() and cancel any pending
PM operations, using put_noidle instead of put_sync_suspend() drops the usa=
ge
count but doesn't schedule an idle check.

[ ... ]

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_contro=
l.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
> new file mode 100644
> index 0000000000000..e6fbf5e58b51a
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c

[ ... ]

> +static int partition_state_wait(struct panthor_partition_control *pc, u3=
2 state)
> +{
> +	u32 partition_state;
> +
> +	return read_poll_timeout_atomic(partition_state_get, partition_state,
> +					partition_state =3D=3D state,
> +					PART_REG_POLL_SLEEP_US,
> +					PART_STATE_TRANSITION_TIMEOUT_US,
> +					false, pc);
> +}

[Severity: High]
Can read_poll_timeout_atomic() trigger CPU soft lockups if it busy-waits for
up to 5 seconds?

The PART_STATE_TRANSITION_TIMEOUT_US macro is set to 5,000,000 (5 seconds).
The atomic variant disables preemption and uses udelay(). Since callers run
in a sleepable context, should this use read_poll_timeout() instead?

[ ... ]

> +static int window_close(struct panthor_partition_control *pc)
> +{
> +	/* Partition already closed. */
> +	if (partition_state_get(pc) =3D=3D PART_STATE_RESET)
> +		return 1;
> +
> +	guard(spinlock_irqsave)(&pc->lock);

[Severity: Medium]
Is there a time-of-check to time-of-use (TOCTOU) race here since the
hardware state is checked before the pc->lock is acquired?

[ ... ]

> +static int window_open(struct panthor_partition_control *pc, u8 aw_id)
> +{
> +	if (aw_id >=3D AM_ARB_MAX_AW_COUNT)
> +		return -EINVAL;
> +
> +	if (partition_state_get(pc) =3D=3D PART_STATE_WINDOW_OPEN) {
> +		u8 cur_aw =3D partition_aw_get(pc);
> +
> +		if (cur_aw =3D=3D aw_id)
> +			return 0;
> +
> +		dev_warn(pc->dev,
> +			 "%s: OPEN_WINDOW(%u): Already opened for aw=3D%u, state=3D%u. Closin=
g...",
> +			 pc->name, aw_id, cur_aw, partition_state_get(pc));
> +
> +		window_close(pc);
> +	}
> +
> +	guard(spinlock_irqsave)(&pc->lock);

[Severity: Medium]
Similar to window_close(), we check the hardware state locklessly before
acquiring pc->lock. Can concurrent calls observe the state incorrectly?

> +
> +	gpu_write(pc->iomem, AM_PART_COMMAND,
> +		  AM_PART_SET_COMMAND(PART_CMD_OPEN_WINDOW) | AM_PART_SET_WINDOW(aw_id=
));

[Severity: Medium]
Does window_close() ensure the hardware has reached PART_STATE_RESET before
we issue the OPEN_WINDOW command here?

If window_close() asynchronously processes the close command, sending an op=
en
command immediately to the exact same register might create a race conditio=
n,
potentially causing a PART_INVALID_COMMAND fault.

[ ... ]

> +static irqreturn_t partition_irq_raw_handler(int irq, void *data)
> +{
> +	struct panthor_partition_control *pc =3D data;
> +	u32 status;
> +
> +	status =3D gpu_read(pc->iomem, AM_PART_IRQ_STATUS);
> +	if (!status)
> +		return IRQ_NONE;

[Severity: High]
Since this handler is registered with IRQF_SHARED, could reading from the
hardware register without Runtime PM validation cause issues?

Other devices on the same interrupt line can trigger this handler. If the
device is runtime-suspended, this unconditional read could result in a bus
fault or return garbage data. Should this use pm_runtime_get_if_active()
first?

[ ... ]

> +static int partition_control_init(struct panthor_arbitration *adev,
> +				   const struct fwnode_handle *child)
> +{

[ ... ]

> +	pc =3D devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> +	if (!pc)
> +		return -ENOMEM;
> +
> +	name =3D devm_kasprintf(dev, GFP_KERNEL, "pc%d", res.id);
> +
> +	iomem =3D devm_ioremap_resource(dev, &res.res);

[Severity: Low]
Is there a missing NULL check for the name allocation here?

If devm_kasprintf() fails, name will be NULL, which is later passed to
another devm_kasprintf() for the IRQ name.

[ ... ]

> +	irqdata =3D irq_get_irq_data(irq);
> +	if (irqdata)
> +		irq_flags =3D irqd_get_trigger_type(irqdata);
> +
> +	ret =3D devm_request_irq(
> +		dev, irq, partition_irq_raw_handler, irq_flags | IRQF_SHARED,
> +		devm_kasprintf(dev, GFP_KERNEL, "panthor-%s-irq", name), pc);
> +	if (ret)
> +		return ret;

[Severity: High]
The irq is requested here, but it doesn't seem to be saved into pc->irq.

Without storing it, panthor_partition_control_suspend() cannot call
synchronize_irq() during power down, which risks suspending the hardware
while an interrupt is mid-flight.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D13
