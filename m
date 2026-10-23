Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D540606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvdflLe9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D6710E073;
	Fri, 23 Oct 2026 07:37:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 779D710E073
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:37:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 499A743FAC;
 Fri, 23 Oct 2026 07:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41201F031E2;
 Fri, 23 Oct 2026 07:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792741026;
 bh=oE1FZicooVYFv3XUDMbZRMPTacNfmeiQiwaBy/+EciY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kvdflLe9EuwX4IDpp6hrN8aOix2/Fv6HoRuzHFujb9lrBF0gkvN7gK+j4eiiGQeBH
 P7fGlkb9WWEoqs/p8UBHUVam29I048O8V1EIR42RwNAa8UJ8KGKa9Rg4w6DTiRBAbp
 /ZytA0YuiyVG9YEICwY3w14gAuHp2dvVJfkqr6VoFX9Ho5eCBqPflvpaP4gl75NDlq
 A1TAIB89rtiGm0ZUcFV5Nd+qAiiT4NbBQeZr3B2MNfSoa62PLmgvl3P4s5ugVV/UMj
 PPMqXlfiyQfqedLeNrFzCejVglNCcS5wlytzAF98YPmtoAgezhNZGtCPkiN6jItov6
 QTAT1OGwCA4Lg==
Message-ID: <sashiko-outbox-182421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/16] accel/thames: Add driver for the C7x DSPs in
 TI SoCs
To: "Tomeu Vizoso" <tomeu.vizoso@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261023-thames-v3-5-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
 <20261023-thames-v3-5-3ab40aa17157@tomeuvizoso.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:37:05 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] accel/thames: persistent device link to rejected core in thames_co=
re_init()
- [High] accel/thames: embedded mbox_dev lifetime and reuse in thames_platf=
orm_probe()
- [High] accel/thames: broken rproc auto_boot check and power leak in thame=
s_core_init()
- [Medium] accel/thames: unconditional platform device creation in thames_r=
egister()
--

commit 33330c246e61374c538a20616d02df3f30a783af
Author: Tomeu Vizoso <tomeu.vizoso@gmail.com>

accel/thames: Add driver for the C7x DSPs in TI SoCs

This commit adds the initial DRM compute accelerator driver for Texas
Instruments C7x DSP cores on the J722S SoC. It discovers available DSP
cores via device tree, attaches to their remoteproc instances, performs a
shared-memory and mailbox doorbell handshake to validate firmware ABI and
capabilities, and exposes a device capability query ioctl to userspace.

> diff --git a/drivers/accel/thames/thames_core.c b/drivers/accel/thames/th=
ames_core.c
> new file mode 100644
> index 0000000000000..d74c74b8f8ebf
> --- /dev/null
> +++ b/drivers/accel/thames/thames_core.c
[ ... ]
> +/* Embedded in struct thames_core: nothing to free. */
> +static void thames_core_mbox_dev_release(struct device *dev)
> +{
> +}
> +
> +/*
> + * A device of the driver's own carrying the DSP node, so the mailbox co=
re finds
> + * the node's mboxes without borrowing the K3 driver's device.
> + */
> +static int thames_core_request_doorbell(struct thames_core *core)
> +{
> +	struct mbox_client *cl =3D &core->mbox_client;
> +	struct device *mbox_dev =3D &core->mbox_dev;
> +	int err;
> +
> +	device_initialize(mbox_dev);
> +	mbox_dev->parent =3D core->tdev->ddev.dev;
> +	mbox_dev->release =3D thames_core_mbox_dev_release;
> +	device_set_node(mbox_dev, of_fwnode_handle(core->of_node));
> +	dev_set_name(mbox_dev, "thames-mbox.%u", core->index);
> +
> +	err =3D device_add(mbox_dev);
> +	if (err) {
> +		put_device(mbox_dev);
> +		return err;
> +	}
> +
> +	cl->dev =3D mbox_dev;
> +	cl->rx_callback =3D thames_mbox_rx;
> +	cl->tx_block =3D false;
> +	cl->knows_txdone =3D false;
> +
> +	core->mbox_chan =3D mbox_request_channel(cl, 1);
> +	if (IS_ERR(core->mbox_chan)) {
> +		err =3D PTR_ERR(core->mbox_chan);
> +		core->mbox_chan =3D NULL;
> +		device_del(mbox_dev);
> +		put_device(mbox_dev);
> +		return err;
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Can embedding struct device mbox_dev inside struct thames_core with an empty
thames_core_mbox_dev_release() callback corrupt kobject state or cause a
use-after-free?

In thames_core_init(), thames_core_request_doorbell() registers core->mbox_=
dev
via device_initialize() and device_add() before rproc_boot(),
thames_core_wait_handshake(), and thames_core_read_handshake(). If core 0
fails any of those steps (for example, when its firmware handshake is
refused), thames_core_free_doorbell() calls device_del() and put_device(), =
and
thames_platform_probe() in drivers/accel/thames/thames_drv.c immediately do=
es:

	if (err) {
		dev_warn(&pdev->dev, "Leaving out the core at %pOF: %d\n", np, err);
		of_node_put(np);
		memset(&tdev->cores[core], 0, sizeof(tdev->cores[core]));
		continue;
	}

Without incrementing core, the next loop iteration zeroes and re-registers =
the
same tdev->cores[0].mbox_dev memory in-place via device_initialize() and
device_add(). Furthermore, tdev is allocated with devm_drm_dev_alloc(), so =
its
lifetime is tied to tdev->ddev rather than mbox_dev's kobject refcount. If a
sysfs reader, uevent handler, or CONFIG_DEBUG_KOBJECT_RELEASE still holds a
reference to mbox_dev->kobj after put_device(), zeroing and re-initializing
tdev->cores[0] or freeing tdev on unbind will access or overwrite live kobj=
ect
memory.

[ ... ]
> +int thames_core_init(struct thames_core *core)
> +{
> +	struct thames_caps caps =3D {};
> +	struct rproc *rproc;
> +	int err;
> +
> +	/* Without a phandle the lookup would defer forever. */
> +	if (!core->of_node->phandle) {
> +		dev_err(core->tdev->ddev.dev, "%pOF has no phandle to find its remotep=
roc by\n",
> +			core->of_node);
> +		return -EINVAL;
> +	}
> +
> +	rproc =3D rproc_get_by_phandle(core->of_node->phandle);
> +	if (!rproc)
> +		return dev_err_probe(core->tdev->ddev.dev, -EPROBE_DEFER,
> +				     "%pOF: no remoteproc registered for it yet\n", core->of_node);
> +
> +	/*
> +	 * remoteproc's own boot is still to come: booting the core here as well
> +	 * would leave two power counts, and a reset or a suspend could not stop
> +	 * it.
> +	 */
> +	if (rproc->state =3D=3D RPROC_OFFLINE && rproc->auto_boot) {
> +		rproc_put(rproc);
> +		return dev_err_probe(core->tdev->ddev.dev, -EPROBE_DEFER,
> +				     "%pOF: remoteproc has not booted it yet (auto-boot pending)\n",
> +				     core->of_node);
> +	}
> +
> +	core->rproc =3D rproc;
> +	core->dev =3D rproc->dev.parent;
> +	snprintf(core->name, sizeof(core->name), "DSP core %s (index %u)", dev_=
name(core->dev),
> +		 core->index);
> +
> +	/*
> +	 * The PM core then suspends this driver before the DSP, and an unbind
> +	 * of the K3 driver unbinds this one first.
> +	 */
> +	if (!device_link_add(core->tdev->ddev.dev, core->dev, DL_FLAG_AUTOPROBE=
_CONSUMER)) {
> +		dev_err(core->tdev->ddev.dev, "Failed to link to %s\n", dev_name(core-=
>dev));
> +		err =3D -EINVAL;
> +		goto err_put;
> +	}
> +
> +	err =3D thames_core_read_windows(core);
> +	if (err)
> +		goto err_put;
> +
> +	err =3D thames_core_get_timers(core);
> +	if (err)
> +		goto err_put;
> +
> +	err =3D thames_core_map_ipc(core);
> +	if (err)
> +		goto err_timers;
> +
> +	err =3D thames_core_request_doorbell(core);
> +	if (err)
> +		goto err_unmap;
> +
> +	if (rproc->state =3D=3D RPROC_OFFLINE) {
> +		err =3D rproc_boot(rproc);
> +		if (err)
> +			goto err_doorbell;
> +	}
> +
> +	err =3D thames_core_wait_handshake(core);
> +	if (err)
> +		goto err_doorbell;
> +
> +	err =3D thames_core_read_handshake(core, &caps);
> +	if (err)
> +		goto err_doorbell;
> +
> +	if (!core->tdev->num_cores)
> +		core->tdev->caps =3D caps;
> +
> +	return 0;
> +
> +err_doorbell:
> +	thames_core_free_doorbell(core);
> +err_unmap:
> +	thames_core_unmap_ipc(core);
> +err_timers:
> +	thames_core_put_timers(core);
> +err_put:
> +	rproc_put(rproc);
> +	core->rproc =3D NULL;
> +	return err;
> +}

[Severity: High]
Does adding the managed device link via device_link_add() before validating
the core's resources and firmware handshake leave an active supplier link t=
o a
rejected DSP core?

In thames_core_init(), device_link_add(core->tdev->ddev.dev, core->dev,
DL_FLAG_AUTOPROBE_CONSUMER) is called before thames_core_read_windows(),
thames_core_get_timers(), thames_core_map_ipc(),
thames_core_request_doorbell(), rproc_boot(), thames_core_wait_handshake(),
and thames_core_read_handshake(). If any of those steps fail (for instance,
when one of the two DSP cores runs non-Thames firmware and is refused at
handshake), the error path unwinds without removing the managed device link,
and thames_platform_probe() continues probing with the remaining DSP core.

When thames_platform_probe() succeeds using the other core,
device_links_driver_bound() activates all managed links on
core->tdev->ddev.dev, including the link to the refused core->dev. If the
user later unbinds the remoteproc driver from the refused DSP core,
device_links_unbind_consumers() will forcefully unbind the thames driver and
unplug the active DRM device, and device_links_check_suppliers() will block
thames from re-probing with -EPROBE_DEFER while that core's remoteproc rema=
ins
unbound.

[Severity: High]
In addition, how can the offline boot path in thames_core_init() be reached
given that rproc->auto_boot remains true?

In rproc_alloc(), rproc->auto_boot is initialized to true, and neither
k3_dsp_rproc_probe() nor the remoteproc core clears rproc->auto_boot after
rproc_trigger_auto_boot() completes, fails, or when a core is stopped via
sysfs. Because of the earlier check:

	if (rproc->state =3D=3D RPROC_OFFLINE && rproc->auto_boot) {
		rproc_put(rproc);
		return dev_err_probe(core->tdev->ddev.dev, -EPROBE_DEFER, ...);
	}

any core in RPROC_OFFLINE causes thames_core_init() to return -EPROBE_DEFER
(which aborts thames_platform_probe() for all cores), making the subsequent
if (rproc->state =3D=3D RPROC_OFFLINE) rproc_boot(rproc) block unreachable =
unless
rproc->state changes concurrently without rproc->lock. Even when
rproc_auto_boot_callback() is genuinely in flight, returning -EPROBE_DEFER
relies on driver_deferred_probe_trigger(), which is only invoked when a dev=
ice
binds to a driver; since this firmware creates no virtio or remoteproc
subdevices, completing rproc_boot() will not re-trigger deferred probing.

Also, if rproc_boot(rproc) in thames_core_init() is reached via a race on
rproc->state and succeeds, but thames_core_wait_handshake() or
thames_core_read_handshake() then fails, jumping to err_doorbell drops the
rproc reference via rproc_put() without calling rproc_shutdown(), leaking t=
he
rproc->power count. And in both thames_core_init() and thames_core_suspend(=
),
rproc->state is read without holding rproc->lock.

> diff --git a/drivers/accel/thames/thames_drv.c b/drivers/accel/thames/tha=
mes_drv.c
> new file mode 100644
> index 0000000000000..de93bc87756c3
> --- /dev/null
> +++ b/drivers/accel/thames/thames_drv.c
[ ... ]
> +static int __init thames_register(void)
> +{
> +	int ret;
> +
> +	drm_dev =3D platform_device_register_simple("thames", -1, NULL, 0);
> +	if (IS_ERR(drm_dev))
> +		return PTR_ERR(drm_dev);
> +
> +	ret =3D platform_driver_register(&thames_platform_driver);
> +	if (ret)
> +		platform_device_unregister(drm_dev);
> +
> +	return ret;
> +}

[Severity: Medium]
Should thames_register() check whether a compatible DSP node is available in
the device tree before calling platform_device_register_simple()?

On multiplatform kernels where CONFIG_DRM_ACCEL_THAMES is built-in or loaded
on a SoC without an available "ti,am62a-c7xv-dsp" node, thames_register()
unconditionally creates the "thames" platform device. This triggers
thames_platform_probe(), which logs an error ("No DSP core attached") and
fails with -ENODEV, while platform_driver_register() still returns 0 and
leaves the unbound platform device registered in sysfs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-thames-v3-=
0-3ab40aa17157@tomeuvizoso.net?part=3D5
