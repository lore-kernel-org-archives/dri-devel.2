Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7671CA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F128410F2FA;
	Mon, 12 Oct 2026 18:33:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB1D510F2DF
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:32:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9106141092;
 Mon, 12 Oct 2026 18:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541B21F0089B;
 Mon, 12 Oct 2026 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791829979;
 bh=nj+q7/XOsNPhJquiinjqoEJRnHTCBnGwz7C1m1JGF7c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kSpMFo7BKiG9uSmFYOIA8o+Yi8bfWNuy+59Qm6q014vQZbJDEvwCdFNoLIdsdpAr1
 iHYy3/SviQPJqugzv56A89Hr7z/+apzwB5O3m6on49TdaLjQQF+6Xc7eRlqBYiWnHI
 zwpV8NjUsum6KaGw0IVvMbOzHgTlcM20OCyUwFOLBjY1X6wjxK3jvO9XsbGu19n8rg
 SWCl02Wb/3sdufcnXCAvp2jcNCDrZ7Bevdoeswc0pYJQGSEQIw1lGhdhgVrSui+gMf
 JJvOYNcWUaYaBH8Trg4K7J6FHL4RnHmj29n7/Uq7cYjG5QwBdgAYq6wiCZYzcrScLg
 fj3ugJA/aprOg==
Message-ID: <sashiko-outbox-168542@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/7] bus: mhi: Expose DDR training data via
 controller sysfs
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-sahara_protocol_new_v2-v8-7-e12939d229a1@oss.qualcomm.com>
References: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
 <20261012-sahara_protocol_new_v2-v8-7-e12939d229a1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:32:58 +0000
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
- [High] mhi: use-after-free on module unload due to controller-tied sysfs =
attr
- [High] mhi: use-after-free in sysfs read due to devres LIFO removal order
- [High] bus/mhi: sleep in atomic context in sahara_mhi_dl_xfer_cb
- [High] mhi: sahara: unbounded kzalloc due to statically false unsigned ch=
eck
- [High] mhi/sahara: devres cleanup order causes UAF in ddr_training_data_r=
ead
- [Medium] mhi/sahara: TOCTOU race in devres allocation via sysfs read
- [Medium] mhi/sahara: concurrent sahara_cntrl_training_get calls corrupt d=
evres state
--

commit e76bebb5952f7ff670194a8d2b492b0ba3646b57
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Expose DDR training data via controller sysfs
   =20
DDR training data captured during Sahara command mode needs to be
accessible to userspace so it can be persisted and reused on subsequent
boots. Expose the captured DDR training data via a read-only binary sysfs
attribute on the MHI controller device.

> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
[ ... ]
>  static struct sahara_cntrl_training_data *sahara_cntrl_training_get(stru=
ct device *dev)
>  {
>  	struct sahara_cntrl_training_data *ct;
> =20
>  	ct =3D devres_find(dev, sahara_cntrl_training_release,
>  			 sahara_cntrl_training_match, NULL);
>  	if (ct)
>  		return ct;
> =20
>  	ct =3D devres_alloc(sahara_cntrl_training_release, sizeof(*ct), GFP_KER=
NEL);
[Severity: Medium]
Since this function is now exposed to userspace via the
ddr_training_data_read() sysfs attribute, could concurrent reads race here?

If a sysfs read races with the driver's internal state machine (cmd_work),
both will find NULL and add a new devres object, and devres_find() will
subsequently return the most recently added object.

If the sysfs-created object (which lacks actual data) is added last and sha=
dows
the driver-created object, wouldn't subsequent MHI RX callbacks write to the
wrong object or discard the data due to a 0-sized copy limit, indefinitely
stalling the DDR training data transfer?

>  	if (!ct)
>  		return NULL;
> =20
>  	mutex_init(&ct->lock);
>  	ct->data =3D NULL;
>  	ct->size =3D 0;
>  	ct->copied =3D 0;
>  	ct->receiving =3D false;
> =20
>  	devres_add(dev, ct);
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
Does adding the ct structure to devres late cause a use-after-free during
sysfs read?

Since sahara_sysfs_create() adds a devres cookie to the controller device
during probe to remove the sysfs file, and devres releases items in reverse
order of addition (LIFO), during controller device removal, ct will be freed
before the sysfs cookie is released.

If a user is concurrently reading the sysfs file, couldn't
ddr_training_data_read() fetch ct, be preempted while device removal frees =
ct,
and then resume to execute mutex_lock(&ct->lock) on the freed memory before
the sysfs removal can block it?

[ ... ]
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
[Severity: High]
Does this cause a use-after-free on module unload?

When the Sahara module is unloaded, sahara_mhi_remove() unbinds the client
device but explicitly leaves the sysfs node and devres callbacks attached to
the parent controller.

Since the sysfs attribute structure, its ddr_training_data_read callback,
and the devres release functions all reside in the module memory, won't
accessing the sysfs file from userspace (or removing the controller device
after unload) dereference unmapped memory and cause a kernel panic?

[ ... ]
>  static void sahara_command_execute_resp(struct sahara_context *context)
>  {
>  	struct device *dev =3D &context->mhi_dev->mhi_cntrl->mhi_dev->dev;
>  	struct sahara_cntrl_training_data *ct;
>  	u32 client_cmd, resp_len;
>  	int ret;
>  	u64 remaining;
>  	u32 i;
> =20
>  	if (le32_to_cpu(context->rx->length) !=3D SAHARA_COMMAND_EXEC_RESP_LENG=
TH ||
>  	    le32_to_cpu(context->rx->command_execute_resp.response_length) < 0)=
 {
[Severity: High]
Is the < 0 check statically false?

Since le32_to_cpu() returns an unsigned __u32, this check fails to validate
untrusted input from the device.

>  		dev_err(&context->mhi_dev->dev,
>  			"Malformed command execute resp packet - length %d\n",
>  			le32_to_cpu(context->rx->length));
>  		return;
>  	}
[ ... ]
>  	ct =3D sahara_cntrl_training_get(dev);
>  	if (!ct) {
>  		context->is_cmd_mode =3D false;
>  		sahara_switch_mode_to_img_tx(context);
>  		return;
>  	}
> =20
>  	mutex_lock(&ct->lock);
>  	kfree(ct->data);
>  	ct->data =3D kzalloc(resp_len, GFP_KERNEL);
[Severity: High]
Could a malicious or malfunctioning device trigger a warning in the memory
allocator or cause memory exhaustion (OOM) by sending an excessively large =
size?

Since the response_length is unchecked (due to the statically false < 0 che=
ck),
an unbounded size is passed directly to kzalloc().

[ ... ]
>  static void sahara_mhi_dl_xfer_cb(struct mhi_device *mhi_dev, struct mhi=
_result *mhi_result)
>  {
>  	struct sahara_context *context =3D dev_get_drvdata(&mhi_dev->dev);
>  	struct sahara_cntrl_training_data *ct;
>  	struct device *dev;
>  	size_t copy;
>  	int ret;
>  	u32 i;
[ ... ]
>  		for (i =3D 0; i < context->training_nbuf; i++) {
>  			if (mhi_result->buf_addr =3D=3D context->cmd_buff[i]) {
>  				mutex_lock(&ct->lock);
[Severity: High]
Can this sleep in atomic context?

sahara_mhi_dl_xfer_cb() is an MHI data transfer callback.
The MHI core calls dl_xfer_cb from the event processing tasklet mhi_ev_task=
()
while holding spin_lock_bh(&mhi_event->lock).

Acquiring a mutex within an atomic context (tasklet + spinlock) causes a
scheduling while atomic panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-sahara_pro=
tocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com?part=3D7
