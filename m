Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BC6CA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F54C10FC73;
	Thu,  8 Oct 2026 06:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cQki93hi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 167AE10FC73
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:39:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3CA45601DB;
 Thu,  8 Oct 2026 06:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F9A1F000FF;
 Thu,  8 Oct 2026 06:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791441574;
 bh=xuxjy3emaPTDsE2ZJx/MoZ53dYPQF5Buox5VZW0/ozA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cQki93hijEkt3OQTJYFKxgIJQZnjP/X457iz+LO/hV8KgyRCZe815RGq/XqUlwAQu
 E2oDbAM06TX/RxuZu0lvN+spVUaCBiqUPQRRa4B8V1+ZIVBlETVEHLa8BHE1XdRqg0
 41YuQo9rj3EBRoxkhjp88BckiGr7M9IrLE4P9z5ELqwGEyHIaTqwdvFr7Kcj50k+CV
 2SS5ec4quy+jAHbW0xuRE9rSCRUQWeWAyIrxBFk+ZUnOTyK/OOXWe5Dtygfxp1fDmA
 yYR1hnFVUuDD0w74KSi6MSMpNP/ErRNCjyidMLGIdS7rGBNR5KW8tYZBpDgxmGAIJL
 7+IJLUj30pbIA==
Message-ID: <sashiko-outbox-163703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/7] bus: mhi: Expose DDR training data via
 controller sysfs
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-sahara_protocol_new_v2-v7-7-90d278bd7414@oss.qualcomm.com>
References: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
 <20261008-sahara_protocol_new_v2-v7-7-90d278bd7414@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:39:33 +0000
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
- [High] mhi: sahara: dangling devres and sysfs callbacks on module unload
- [High] mhi: sahara: ddr_training_data sysfs read exposes incomplete data
- [High] sahara: sleep in atomic context in sahara_mhi_dl_xfer_cb()
- [High] mhi/sahara: Use-After-Free of devres training data in sysfs read
- [Medium] bus: mhi: sahara: TOCTOU race in sahara_cntrl_training_get cause=
s split-brain and leak
--

commit 23130cc627e07ba76790886430e0130309cce1af
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Expose DDR training data via controller sysfs

This commit exposes DDR training data captured during Sahara command mode
via a read-only binary sysfs attribute on the MHI controller device. The da=
ta
is served directly from controller scoped storage to userspace to optimize
subsequent boots.

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index 11f65cbfa66b8..2f2d18e4ed4da 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> @@ -273,6 +273,66 @@ static struct sahara_cntrl_training_data *sahara_cnt=
rl_training_get(struct devic
>  	return ct;
>  }
> =20
> +static ssize_t ddr_training_data_read(struct file *filp, struct kobject =
*kobj,
> +				      const struct bin_attribute *attr, char *buf,
> +				      loff_t offset, size_t count)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct sahara_cntrl_training_data *ct;
> +	size_t available;
> +
> +	ct =3D sahara_cntrl_training_get(dev);

[Severity: Medium]
Since this sysfs read path doesn't hold any lock before calling
sahara_cntrl_training_get(), could we hit a race here?

sahara_cntrl_training_get() performs a check and then allocates:

	ct =3D devres_find(dev, sahara_cntrl_training_release, ...);
	if (ct)
		return ct;
	ct =3D devres_alloc(..., GFP_KERNEL);
	...
	devres_add(dev, ct);

If a userspace process reads this sysfs file concurrently while the MHI
device is receiving training data (which also enters this function via
sahara_mhi_dl_xfer_cb() or sahara_processing()), could two concurrent calle=
rs
bypass the singleton check, allocating and adding separate instances to the
devres list?

This would cause a memory leak and a split-brain state where the sysfs
reader and the MHI driver operate on different instances.

[Severity: High]
Could this devres allocation sequence also lead to a use-after-free during
controller unbind?

When ddr_training_data_read() creates ct via sahara_cntrl_training_get(),
it adds it to the controller device's devres list after the sysfs cookie
was already added during probe. Because devres lists are LIFO, ct will be
freed before the sysfs cookie is processed.

If the controller device unbinds concurrently, devres_release_all() will
free ct first, and only then call device_remove_bin_file() to drain
active sysfs readers. Would the active sysfs reader continue executing and
call mutex_lock(&ct->lock) on the now-freed ct pointer?

> +	if (!ct)
> +		return -ENODEV;
> +
> +	mutex_lock(&ct->lock);

[Severity: High]
Does taking this mutex cause a scheduling while atomic bug when interacting
with the MHI transfer callbacks?

The MHI transfer callback sahara_mhi_dl_xfer_cb() is executed from the MHI
event tasklet (mhi_ev_task()), which is an atomic context. In that context,
it calls sahara_cntrl_training_get() (which performs a sleeping GFP_KERNEL
allocation) and then acquires this same mutex via mutex_lock(&ct->lock).

Is it safe to sleep in this path?

> +
> +	/* No data yet or offset past end */
> +	if (!ct->data || offset >=3D ct->size) {
> +		mutex_unlock(&ct->lock);
> +		return 0;
> +	}
> +
> +	available =3D ct->size - offset;
> +	count =3D min(count, available);
> +	memcpy(buf, (u8 *)ct->data + offset, count);

[Severity: High]
Could this read expose incomplete or uninitialized data to userspace?

The read computes available data based on ct->size without checking if the
asynchronous transfer is still ongoing (i.e., whether ct->receiving is true=
).

ct->size is initialized to the full target length in
sahara_command_execute_resp() before the data is actually received via DMA.
Data is then incrementally copied into the buffer from the DL callback
(sahara_mhi_dl_xfer_cb) using ct->copied.

If a userspace process reads the sysfs file concurrently while the transfer
is in progress, wouldn't it receive a partially zero-padded buffer instead
of the actual DDR training data?

Should this rely on ct->copied or check ct->receiving instead?

> +
> +	mutex_unlock(&ct->lock);
> +
> +	return count;
> +}
> +static BIN_ATTR_RO(ddr_training_data, 0);
> +
> +static void sahara_sysfs_devres_release(struct device *dev, void *res)
> +{
> +	device_remove_bin_file(dev, &bin_attr_ddr_training_data);
> +}
> +
> +static void sahara_sysfs_create(struct mhi_device *mhi_dev)
> +{
> +	struct device *dev =3D &mhi_dev->mhi_cntrl->mhi_dev->dev;
> +	void *cookie;
> +	int ret;
> +
> +	if (devres_find(dev, sahara_sysfs_devres_release, NULL, NULL))
> +		return;
> +
> +	ret =3D device_create_bin_file(dev, &bin_attr_ddr_training_data);
> +	if (ret) {
> +		dev_warn(&mhi_dev->dev,
> +			 "Failed to create DDR training sysfs node (%d)\n", ret);
> +		return;
> +	}
> +
> +	cookie =3D devres_alloc(sahara_sysfs_devres_release, 1, GFP_KERNEL);
> +	if (!cookie) {
> +		device_remove_bin_file(dev, &bin_attr_ddr_training_data);
> +		return;
> +	}
> +
> +	devres_add(dev, cookie);
> +}

[Severity: High]
Does this leave dangling pointers when the driver module is unloaded?

sahara_sysfs_create() attaches a module-scoped devres release callback
(sahara_sysfs_devres_release) and a sysfs attribute
(bin_attr_ddr_training_data) to the long-lived controller device
(&mhi_dev->mhi_cntrl->mhi_dev->dev).

Since the controller device outlives the client device, and
sahara_mhi_remove() doesn't manually remove the sysfs file and devres
callbacks, won't they become dangling pointers when the module is unloaded?

If the module is unloaded (e.g., rmmod mhi_sahara), any subsequent
teardown of the controller device or a userspace read of the sysfs file
would dereference these unmapped pointers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-sahara_pro=
tocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com?part=3D7
