Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10429C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A4D810EED2;
	Wed,  1 Jul 2026 10:52:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HzC+80HU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D87610EED2
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:52:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D2AB42D51;
 Wed,  1 Jul 2026 10:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008FC1F000E9;
 Wed,  1 Jul 2026 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782903169;
 bh=Z7cMtgTQgMlORW/Hj+HecTAZ4L9FuJf+Q4Ciu9e9w3A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HzC+80HUNje3x1grYUgZd35KmsVRTSJwOfkP92PHUd9tjmuCl4AX4QCiAWL4/Hhjv
 fX6R7KGzLsjAi+1NloDrISx91yA4pTfuX5kgI6bcsr79mbUPdIgON5EkheIB4hZHUu
 yQ5L5sHLSihWYD5SUZ0zhFVTrpa45QOVPQwI6QFs973tB526DZxSFBg6Gl+wvYj647
 8cB3Yh0zbC3iQY2V5HiRYvhVOn5EFmOP0HBEZrcjtLpSWJ6z9fWsBfS6JM3avW6ht6
 UUntaJA/qzNk8WvK9lXdlqG8wpvJP7hQDnXumy/K4fv+ozLo/s+dgYg7kForIzQ+oU
 ZIofk6aZBHnLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/7] bus: mhi: Expose DDR training data via
 controller sysfs
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-sahara_protocol_new_v2-v6-7-3a78362c4741@oss.qualcomm.com>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-7-3a78362c4741@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:52:48 +0000
Message-Id: <20260701105249.008FC1F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Module lifetime mismatch leads to Use-After-Free for sysfs att=
ribute and devres release callback.
- [High] Devres LIFO teardown ordering causes Use-After-Free during sysfs r=
ead.
- [High] Sysfs read callback returns incomplete or zero-padded data during =
ongoing transfers.

Pre-existing issues:
- [Critical] Module lifetime mismatch leads to Use-After-Free for pre-exist=
ing training data devres.
- [High] Sleeping in atomic context during MHI download transfer callback.
- [High] Missing cancellation of `read_data_work` causes Use-After-Free on =
removal.
- [Medium] TOCTOU race condition in `sahara_cntrl_training_get()` causes me=
mory leak.
--

commit 35f2a6a6ec964ce87d79329b526efc1e44cf02b8
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Expose DDR training data via controller sysfs

This commit exposes captured DDR training data to userspace via a read-only=
=20
binary sysfs attribute on the MHI controller device. It adds a sysfs read=20
callback to serve data from the controller-scoped storage and manages the=20
attribute's lifetime using devres.

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index 07bc743aa061d..72ac751c302a9 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> @@ -273,6 +273,66 @@ static struct sahara_cntrl_training_data *sahara_cnt=
rl_training_get(struct devic
>  	return ct;
>  }

[Severity: Critical]
This is a pre-existing issue, but does sahara_cntrl_training_get() have a
module lifetime mismatch?

When sahara_cntrl_training_get() allocates and attaches a devres structure =
to
the parent MHI controller device:

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_cntrl_training_get() {
    ...
    ct =3D devres_alloc(sahara_cntrl_training_release, sizeof(*ct), GFP_KER=
NEL);
    ...
    devres_add(dev, ct);
}

If the Sahara module is unloaded, the release callback function pointer
sahara_cntrl_training_release becomes dangling. When the controller device =
is
eventually removed, will the driver core execute the dangling devres release
function and cause a use-after-free?

[Severity: High]
This is a pre-existing issue, but can sahara_cntrl_training_get() be called
from an atomic context?

The MHI subsystem invokes the dl_xfer_cb callback in an atomic SoftIRQ/task=
let
context, and it calls sahara_cntrl_training_get():

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_mhi_dl_xfer_cb() {
    ...
    ct =3D sahara_cntrl_training_get(dev);
    ...
    mutex_lock(&ct->lock);
}

Since sahara_cntrl_training_get() uses GFP_KERNEL unconditionally, and
mutex_lock() can sleep, will this cause a scheduling while atomic panic when
DDR training data is received?

[Severity: Medium]
This is a pre-existing issue, but is there a race condition in
sahara_cntrl_training_get() when setting up the devres structure?

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_cntrl_training_get() {
    ...
    ct =3D devres_find(dev, sahara_cntrl_training_release,
                     sahara_cntrl_training_match, NULL);
    if (ct)
        return ct;

    ct =3D devres_alloc(sahara_cntrl_training_release, sizeof(*ct), GFP_KER=
NEL);
    ...
    devres_add(dev, ct);
}

If a sysfs reader and the MHI receive path call this concurrently, couldn't
both observe NULL and allocate separate structures? Because devres_find()
searches in reverse, the later allocation would shadow the earlier one, cau=
sing
the earlier one to leak memory and lose its lock/data state.

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
> +	if (!ct)
> +		return -ENODEV;
> +
> +	mutex_lock(&ct->lock);

[Severity: High]
Can ct be freed while we are trying to acquire the lock?

Devres resources are freed in Last-In-First-Out (LIFO) order. Since the sys=
fs
devres is added during probe, and the training data devres (ct) is added la=
ter
during transfer, ct is freed first on controller removal, and the sysfs file
is removed second.

If userspace reads the sysfs file concurrently with device removal, could t=
he
read callback retrieve the ct pointer just before it is freed by
devres_release_all, leading to a use-after-free when attempting to acquire
mutex_lock(&ct->lock)?

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
Does this correctly bound the read size during an ongoing transfer?

This logic uses ct->size (the expected total size) rather than ct->copied
(actual received bytes), and ignores ct->receiving.

Since the buffer is zero-filled by kzalloc(), if userspace reads the file
before the transfer completes, won't it successfully read the unwritten
portion as zeroes? This could cause the userspace tooling to persist a
truncated or corrupted DDR training image.

[ ... ]
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

[Severity: Critical]
Since sahara is a loadable module, what happens if the module is unloaded?

If the Sahara module is unloaded, the client device unbinds and the module
memory is freed. But since dev points to the parent MHI controller device, =
the
sysfs file and devres hook remain active on the controller device.

Will a subsequent userspace read of the sysfs file dereference
bin_attr_ddr_training_data and execute ddr_training_data_read in unmapped
memory, leading to a use-after-free?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does sahara_mhi_remove() fail to cancel
read_data_work?

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_mhi_remove() {
    ...
    cancel_work_sync(&context->fw_work);
    cancel_work_sync(&context->dump_work);
    cancel_work_sync(&context->cmd_work);
    vfree(context->mem_dump);
    ...
}

The driver initializes context->read_data_work and schedules it asynchronou=
sly
in sahara_mhi_ul_xfer_cb(). Since cancel_work_sync(&context->read_data_work)
is omitted during removal, if the work is scheduled just before device remo=
val
completes, will the workqueue execute on the devm-freed context memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-sahara_pro=
tocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com?part=3D7
