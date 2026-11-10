Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA27C60A262D
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KS2DPWE2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38D310F805;
	Tue, 10 Nov 2026 16:10:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5076410F80C
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:10:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0833D471A6;
 Tue, 10 Nov 2026 16:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24E31F00925;
 Tue, 10 Nov 2026 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794327019;
 bh=TkxvmwLdo0oRGQupVX1ZAM1/DKfPThJSqAoH0MrtGS4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=KS2DPWE2jJlMVEqtRmqGd6qhB7RBHcbz/PEW8MLc1ERHkOwLeKMWOfY1U5McGbuOd
 JVAHSu8omnFMOdMFg02vR2iVdqbprpcZstV0jsm2Tmjuj2eTLf/Di/CWt5uvkVvvGI
 yucMe9nO69TeYdmq560BVX067WZL8wqdDz7C5Q9DyRA4RJNt2nKATqH14QLPq5s3ci
 NRsI3+mfoiJ6ZzrLFyMTbCRbAvUUin/OLBnGOIsxcLvZE/lxN81vmlpAUCCLweClcQ
 0Z1X4MPIXZRC+uG07kKAV9mOgCU8oLkkQP6C0BVb7gi/b51IRXyaNyvyeAKNpUA91f
 r0qQRaKkRg7cw==
Message-ID: <sashiko-outbox-207343@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/28] drm/panthor: Add AM_PARTITION_CONTROL support
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-15-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-15-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:10:19 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] drm/panthor: TOCTOU race from multiple AM_PART_STATE reads in
  window helpers
- [Medium] drm/panthor: panthor_partition_control_term() fails on
  in-progress state transitions
- [Low] drm/panthor: unused devm allocations in partition_control_init()
  on -ENODEV
- [Low] drm/panthor: unchecked devm_kasprintf() in
  partition_control_init()
--

commit 9f7b5a10199859069acf5b5904f5b9aca326fc89
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add AM_PARTITION_CONTROL support

This commit adds the Panthor arbitration platform driver and partition
control support to manage access windows on Mali v15 AM GPUs.

Link: https://lore.kernel.org/all/20260922205802.1AC3E1F000FF@smtp.kernel.o=
rg/

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_contro=
l.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
> new file mode 100644
> index 0000000000000..330d0bf5fd375
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c

[ ... ]

> +static u32 partition_state_get(struct panthor_partition_control *pc)
> +{
> +	const u32 state =3D gpu_read(pc->iomem, AM_PART_STATE);
> +
> +	return AM_PART_STATE_GET(state);
> +}
> +
> +static u8 partition_aw_get(struct panthor_partition_control *pc)
> +{
> +	const u32 state =3D gpu_read(pc->iomem, AM_PART_STATE);
> +
> +	return AM_PART_STATE_WINDOW_GET(state);
> +}

[ ... ]

> +static int yield_now(struct panthor_partition_control *pc)
> +{
> +	guard(spinlock_irqsave)(&pc->lock);
> +
> +	if (partition_state_get(pc) =3D=3D PART_STATE_RESET)
> +		return 0;
> +
> +	if (partition_state_get(pc) !=3D PART_STATE_WINDOW_OPEN)
> +		return -EAGAIN;
> +
> +	gpu_write(pc->iomem, AM_PART_COMMAND,
> +		  AM_PART_SET_COMMAND(PART_CMD_YIELD_NOW));
> +
> +	return 0;
> +}
> +
> +static int yield_idle(struct panthor_partition_control *pc)
> +{
> +	guard(spinlock_irqsave)(&pc->lock);
> +
> +	if (partition_state_get(pc) =3D=3D PART_STATE_RESET)
> +		return 0;
> +
> +	if (partition_state_get(pc) !=3D PART_STATE_WINDOW_OPEN)
> +		return -EAGAIN;
> +
> +	gpu_write(pc->iomem, AM_PART_COMMAND,
> +		  AM_PART_SET_COMMAND(PART_CMD_YIELD_IDLE));
> +
> +	return 0;
> +}
> +
> +static int window_close(struct panthor_partition_control *pc)
> +{
> +	guard(spinlock_irqsave)(&pc->lock);
> +
> +	if (partition_state_get(pc) =3D=3D PART_STATE_RESET)
> +		return 0;
> +
> +	if (partition_state_get(pc) !=3D PART_STATE_WINDOW_OPEN)
> +		return -EAGAIN;
> +
> +	pc->closing =3D true;
> +
> +	gpu_write(pc->iomem, AM_PART_COMMAND,
> +		  AM_PART_SET_COMMAND(PART_CMD_CLOSE_WINDOW));
> +
> +	return 0;
> +}
> +
> +static int window_open(struct panthor_partition_control *pc, u8 aw_id)
> +{
> +	if (aw_id >=3D AM_ARB_MAX_AW_COUNT)
> +		return -EINVAL;
> +
> +	guard(spinlock_irqsave)(&pc->lock);
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
> +		return -EBUSY;
> +	}

[Severity: Medium]
Can an asynchronous hardware state transition between these back-to-back
AM_PART_STATE reads cause yield_now(), yield_idle(), window_close(), and
window_open() to act on inconsistent state?

Each call to partition_state_get() and partition_aw_get() performs a
separate MMIO read of AM_PART_STATE.  If the partition finishes closing or
yielding and transitions into PART_STATE_RESET between the first and
second partition_state_get() in yield_now(), yield_idle(), or
window_close(), the first check is false and the second sees
PART_STATE_RESET !=3D PART_STATE_WINDOW_OPEN, returning -EAGAIN instead of 0
(which in panthor_partition_control_term() triggers WARN_ON() and skips
partition_state_wait()).  In window_open(), if the partition resets
between partition_state_get() and partition_aw_get(), cur_aw reads as 0;
when aw_id is 0, window_open() returns 0 without issuing
PART_CMD_OPEN_WINDOW.

Also, the dev_warn() in window_open() performs a third MMIO read of
AM_PART_STATE and still says "Closing..." even though window_open() no
longer closes the window.  Reading AM_PART_STATE once into a local
variable under pc->lock and extracting both fields from that value would
avoid these races.

[ ... ]

> +void panthor_partition_control_term(struct panthor_arbitration *adev)
> +{
> +	for (int i =3D 0; i < AM_ARB_MAX_PC_COUNT; i++) {
> +		struct panthor_partition_control *pc =3D adev->pc[i];
> +
> +		if (!pc)
> +			continue;
> +
> +		partition_irq_suspend(pc);
> +
> +		if (!pm_runtime_status_suspended(pc->dev))
> +			if (!WARN_ON(window_close(pc) < 0))
> +				WARN_ON(partition_state_wait(pc, PART_STATE_RESET));
> +	}
> +}

[Severity: Medium]
What happens in panthor_partition_control_term() if a partition is already
transitioning through PART_STATE_WINDOW_CLOSED or
PART_STATE_WINDOW_OPENING when teardown runs?

window_open(), window_close(), yield_now(), and yield_idle() issue
commands without waiting for the state transition to complete, and
window_close() returns -EAGAIN for any state other than PART_STATE_RESET
and PART_STATE_WINDOW_OPEN.  If a transition is still in flight when
panthor_partition_control_term() runs, window_close() returns -EAGAIN,
triggering WARN_ON() and skipping partition_state_wait() while the
hardware is still active.  Commit "drm/panthor: Reset partitions before
starting arbitration" later in this series adds partition_ensure_reset()
to handle in-progress states during init, so calling it here as well would
ensure teardown waits for the reset to complete.

> +static int partition_control_init(struct panthor_arbitration *adev, int =
i)
> +{
> +	struct panthor_partition_control *pc;
> +	struct device *dev =3D adev->dev;
> +	struct irq_data *irqdata;
> +	struct resource *res;
> +	void __iomem *iomem;
> +	u32 irq_flags =3D 0;
> +	char *name;
> +	int irq;
> +	int ret;
> +
> +	if (adev->pc[i])
> +		return dev_warn_probe(dev, -ENODEV,
> +				      "partition %u already present", i);
> +
> +	pc =3D devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> +	if (!pc)
> +		return -ENOMEM;
> +
> +	name =3D devm_kasprintf(dev, GFP_KERNEL, "pc%d", i);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource_byname(to_platform_device(dev),
> +					   IORESOURCE_MEM, name);
> +	if (!res)
> +		return -ENODEV;

[Severity: Low]
When platform_get_resource_byname() finds no resource and returns -ENODEV,
panthor_partition_control_init() ignores -ENODEV and probe succeeds,
leaving pc and name allocated on dev until the driver unbinds.  Could
pc be allocated after looking up res (or the unused devm allocations be
freed before returning -ENODEV)?

[ ... ]

> +	ret =3D devm_request_irq(
> +		dev, irq, partition_irq_raw_handler, irq_flags | IRQF_SHARED,
> +		devm_kasprintf(dev, GFP_KERNEL, "panthor-%s-irq", name), pc);
> +	if (ret)
> +		return ret;

[Severity: Low]
Can devm_kasprintf() return NULL here and pass a NULL devname into
devm_request_irq() instead of failing with -ENOMEM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D14
