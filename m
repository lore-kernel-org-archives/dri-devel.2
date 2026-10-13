Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71FFCC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA0E10E5FF;
	Tue, 13 Oct 2026 08:58:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB1D10E5FF
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:58:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A8AF60A6F;
 Tue, 13 Oct 2026 08:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62711F000FF;
 Tue, 13 Oct 2026 08:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791881895;
 bh=K5wR/8SIb4yEGlPBgdq2J5CqJY3TzYK9YqPKeF+oKow=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M/cggP5wr8Ag2QWl18BMUnZrysnpQIXeovasWx+udzOckFgkm0Y/ENKH4cVQpAM+f
 AaZo8h3BdWQ0nvYf7ktqPRIDFzZ1r9wwRz35HsMy3ztuG4NSEzlp8ytKn3S1TGVJxe
 6EYLuk/Rq4wAKkxSVClfDRLsC0wYVazHZ+9IBEwj3gPglcDP0AOcW93FfURp7ZERnU
 eegDlR1otYlhMoEocc8nyKZfLuvjK6mfzb2KyCsb6wYVST8UQApXpUQZuPUTqKHxVW
 T+YwIug9V3ClxT4u/H5amzEyiXlGlBOi3MPKWXhSbU7L3hP5JS5elUFqSckdghDjWv
 Cn+XTWA27sffw==
Message-ID: <sashiko-outbox-169290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 7/7] bus: mhi: Expose DDR training data via
 controller sysfs
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-7-dc9f24357c4a@oss.qualcomm.com>
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
 <20261013-sahara_protocol_new_v2-v9-7-dc9f24357c4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 08:58:15 +0000
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
- [High] mhi: sahara: module unload UAF due to controller-scoped devres and=
 sysfs
- [High] mhi: sahara: sleeping mutex_lock() in atomic dl_xfer_cb callback
- [High] bus: mhi: sahara: UAF in ddr_training_data_read due to devres rele=
ase order
- [Medium] mhi: sahara: lockless devres creation in sysfs read causes memor=
y leak
- [Low] sahara: unsigned length validation checked for < 0 is dead code
--

commit 17df5ced69df7ffe5c236bc241ec6e9939859682
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Expose DDR training data via controller sysfs

This commit exposes DDR training data through a new sysfs binary attribute
attached to the MHI controller device. This enables userspace to persist
the captured training data and reload it on subsequent boots to optimize
boot times.

> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/m=
hi/host/clients/sahara/sahara.c
> index aa684355b7a31..be5318fc5e221 100644
> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> @@ -272,6 +272,67 @@ static struct sahara_cntrl_training_data *sahara_cnt=
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
> +	if (!ct)
> +		return -ENODEV;
> +
> +	mutex_lock(&ct->lock);

[Severity: High]
In sahara_sysfs_create(), the sysfs devres cookie is added to the device
during probe. However, sahara_cntrl_training_get() dynamically allocates and
adds the ct structure to the same device's devres list lazily on first use.

Because ct is added to devres after the sysfs cookie, the LIFO nature of
devres_release_all() guarantees ct is freed before the sysfs file is remove=
d.

Could a concurrent sysfs read fetch the ct pointer, get preempted, and atte=
mpt
to lock ct->lock after devres has already freed it, leading to a
use-after-free during device removal?

> +
> +	/* No complete data yet or offset past end */
> +	if (!ct->data || ct->receiving || ct->copied !=3D ct->size ||
> +	    offset >=3D ct->size) {
> +		mutex_unlock(&ct->lock);
> +		return 0;
> +	}
> +
> +	available =3D ct->size - offset;
> +	count =3D min(count, available);
> +	memcpy(buf, (u8 *)ct->data + offset, count);
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

[Severity: High]
The sahara driver can be built as a loadable module. By attaching the
ddr_training_data sysfs file and devres cleanup cookie to the parent
controller device (mhi_cntrl->mhi_dev->dev), they outlive the sahara client
device.

When the sahara module is unloaded, the sysfs file and devres objects are
not detached. Once the module is unmapped, userspace reading the stale file
or the controller device being removed will cause the kernel to jump to the
freed ddr_training_data_read or sahara_sysfs_devres_release functions.

Does attaching the sysfs node and devres callback to the parent MHI
controller cause a use-after-free on module unload?

> +}

[ ... ]

I also noticed a few other issues in related Sahara functions that were
introduced in this series:

[Severity: Medium]
In sahara_cntrl_training_get(), we have a check-then-act sequence:

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_cntrl_training_get() {
    ...
	ct =3D devres_find(dev, sahara_cntrl_training_release,
			 sahara_cntrl_training_match, NULL);
	if (ct)
		return ct;

	ct =3D devres_alloc(sahara_cntrl_training_release, sizeof(*ct), GFP_KERNEL=
);
    ...
	devres_add(dev, ct);
	return ct;
}

Since ddr_training_data_read() can be invoked concurrently by multiple
userspace threads, multiple threads could see devres_find() return NULL
and allocate separate ct structures.

Does this permanently leak memory and break synchronization since different
threads would use different mutexes?

[Severity: High]
In sahara_mhi_dl_xfer_cb(), the MHI transfer callback executes in the MHI
event tasklet, which is an atomic context:

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_mhi_dl_xfer_cb() {
    ...
		ct =3D sahara_cntrl_training_get(dev);
		if (!ct)
			return;

		for (i =3D 0; i < context->training_nbuf; i++) {
			if (mhi_result->buf_addr =3D=3D context->cmd_buff[i]) {
				mutex_lock(&ct->lock);
    ...
}

Will unconditionally invoking mutex_lock() here result in a sleep-in-atomic=
 bug?

[Severity: Low]
In sahara_command_execute_resp(), there is a negative length validation:

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_command_execute_resp() {
    ...
	if (le32_to_cpu(context->rx->length) !=3D SAHARA_COMMAND_EXEC_RESP_LENGTH =
||
	    le32_to_cpu(context->rx->command_execute_resp.response_length) < 0) {
    ...
}

Since le32_to_cpu() returns an unsigned 32-bit integer, checking if
response_length is < 0 will always be false.

While an unexpectedly large length would gracefully fail the subsequent
memory allocation, should this check be corrected to prevent bypassing the
validation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-sahara_pro=
tocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com?part=3D7
