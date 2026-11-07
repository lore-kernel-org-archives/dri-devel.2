Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FEE606A32D
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWTxDIt4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3D210E4AF;
	Sat,  7 Nov 2026 18:19:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A75010E0E2
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 18:18:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E16B06062E;
 Sat,  7 Nov 2026 18:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2021F0089F;
 Sat,  7 Nov 2026 18:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794075537;
 bh=2dGOk1u06anmr4o1IWnblYTeJLKSeg7i6YcrWcocwvk=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=gWTxDIt4ZK/6tV98B0BFvwui3cFsaajYo/GpZ3tlIAZhGUVgm9dCi+38dYN5durbT
 9goTlLyYetbLWK43rS8DFo5KWstA1q3K97ZKZsDDDHeQww7S1L3FyAYVq3mtdUvUYe
 /bBDdXP7mhUFMiaaQAKWbwXOkh5Rx/MS6vDvdnchJh5jSxHGTwkZzRiD4lPlkHcykB
 xi9VnGI7m5t5Wc5J6An6Dpg7AqmsVf9qhmLwEJZ9avNm1m+ITmcokfvmLeVz+GkZRh
 HSFUk7lvr4nFP1Ipb4SIZtVKIKNyN39OoAWEmDyNJCqBSfkanntA69jR50iML+EfTe
 iBwP3LI79ovRA==
Message-ID: <sashiko-outbox-203164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] accel/qaic: Add callbacks for DRM RAS netlink
 telemetry
To: "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261106181225.3333260-4-zachary.mckevitt@oss.qualcomm.com>
References: <20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com>
 <20261106181225.3333260-4-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 18:18:57 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] accel/qaic: missing tele_wq flush and drmm/devm mismatch in
  create_qdev()
- [Medium] accel/qaic: telemetry_request() returns positive jiffies on
  firmware error
- [Medium] accel/qaic: missing cleanup on error in
  qaic_telemetry_mhi_probe()
- [Medium] accel/qaic: unsynchronized tele_ch teardown in
  qaic_telemetry_mhi_remove()
- [Medium] accel/qaic: use-after-free of ras_node in
  qaic_drm_ras_unregister_node()
- [Low] accel/qaic: ignored qaic_telemetry_register() failure in
  qaic_init()
- [Low] accel/qaic: missing static on file-local telemetry arrays and
  helpers
- [Low] accel/qaic: commit message states RAS node is created in PCI
  probe
--

commit aee476e17f4e0ed7de92c77cb028e7ff6d94ed60
Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

accel/qaic: Add callbacks for DRM RAS netlink telemetry

This commit adds MHI telemetry channel support and registers a DRM RAS
telemetry node with read and write callbacks for QAIC devices.

> During PCI probe, create a DRM RAS node with DRM_RAS_NODE_TYPE_TELEMETRY
> type and add callbacks to telemetry_request for read and write operations.

[Severity: Low]
This isn't a bug, but the commit message says the DRM RAS node is created
during PCI probe, whereas qaic_drm_ras_register_node() is actually called
from qaic_telemetry_mhi_probe() when the QAIC_TELEMETRY MHI channel is
probed.

> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 9e1e184efe0d1..c2a30cb9af467 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c

[ ... ]

> @@ -439,6 +441,9 @@ static struct qaic_device *create_qdev(struct pci_dev=
 *pdev,
>  	if (ret)
>  		return NULL;
>  	ret =3D drmm_mutex_init(drm, &qdev->bootlog_mutex);
> +	if (ret)
> +		return NULL;
> +	ret =3D drmm_mutex_init(drm, &qdev->tele_mutex);
>  	if (ret)
>  		return NULL;
> =20
> @@ -451,6 +456,9 @@ static struct qaic_device *create_qdev(struct pci_dev=
 *pdev,
>  	qdev->ssr_wq =3D qaicm_wq_init(drm, "qaic_ssr");
>  	if (IS_ERR(qdev->ssr_wq))
>  		return NULL;
> +	qdev->tele_wq =3D qaicm_wq_init(drm, "qaic_tele");
> +	if (IS_ERR(qdev->tele_wq))
> +		return NULL;

[Severity: High]
Can managing qdev->tele_mutex and qdev->tele_wq with drmm while qdev is
allocated with devm_kzalloc() cause a use-after-free on PCI removal?

If a process holds an open file descriptor to /dev/accel/accelN when the
PCI device is removed, drm_device outlives qaic_pci_remove(), while
devres frees qdev as soon as qaic_pci_remove() returns.  Because
qaic_telemetry_mhi_remove() also does not flush qdev->tele_wq, a queued
resp_worker() item can run after qdev is freed, and closing the file
descriptor later runs __drmm_mutex_release() on the freed
qdev->tele_mutex:

CPU0                                  CPU1 (kworker)
qaic_pci_remove()
  ...
  qaic_telemetry_mhi_dl_xfer_cb()
    queue_work(qdev->tele_wq, &resp->work)
  qaic_mhi_free_controller()
    qaic_telemetry_mhi_remove()
  devres_release_all(&pdev->dev)
    kfree(qdev)
                                      resp_worker()
                                        mutex_lock(&qdev->tele_mutex)
                                          <-- use-after-free

Flushing qdev->tele_wq in qaic_telemetry_mhi_remove() after
mhi_unprepare_from_transfer() and tying qdev's lifetime to drmm (or
managing tele_mutex and tele_wq with devm) would avoid this.

[ ... ]

> @@ -860,6 +869,10 @@ static int __init qaic_init(void)
>  		goto free_bootlog;
>  	}
> =20
> +	ret =3D qaic_telemetry_register();
> +	if (ret)
> +		pr_debug("qaic: qaic_telemetry_register failed %d\n", ret);
> +
>  	return 0;
> =20
>  free_bootlog:
> @@ -889,6 +902,7 @@ static void __exit qaic_exit(void)
>  	 * reinitializing the link_up state after the cleanup is done.
>  	 */
>  	link_up =3D true;
> +	qaic_telemetry_unregister();

[Severity: Low]
If qaic_telemetry_register() fails in qaic_init(), won't
qaic_telemetry_unregister() in qaic_exit() hit WARN(1, "Unexpected driver
unregister!\n") in driver_unregister() because drv->p is NULL?

> diff --git a/drivers/accel/qaic/qaic_telemetry.c b/drivers/accel/qaic/qai=
c_telemetry.c
> new file mode 100644
> index 0000000000000..eb86982f659d7
> --- /dev/null
> +++ b/drivers/accel/qaic/qaic_telemetry.c
> @@ -0,0 +1,563 @@

[ ... ]

> +const struct drm_ras_telemetry_field qaic_telemetry_fields_gettable[] =
=3D {
> +	{"QAIC_DEVINFO_THERMAL_SOC_MAX_TEMP", QAIC_DEVINFO_THERMAL_SOC_MAX_TEMP=
},

[ ... ]

> +};
> +
> +const struct drm_ras_telemetry_field qaic_telemetry_fields_settable[] =
=3D {
> +	{"QAIC_DEVINFO_THERMAL_WARNING_TEMP", QAIC_DEVINFO_THERMAL_WARNING_TEMP=
},

[ ... ]

> +	{"QAIC_DEVINFO_SOC_TDP", QAIC_DEVINFO_SOC_TDP},
> +	{},
> +};

[Severity: Low]
Should qaic_telemetry_fields_gettable and qaic_telemetry_fields_settable
be marked static?  They are only used within qaic_telemetry.c and have no
header declarations, which triggers sparse warnings.

Similarly, telemetry_request(), qaic_drm_ras_register_node(), and
qaic_drm_ras_unregister_node() have no callers outside qaic_telemetry.c
and could be made static and dropped from qaic_telemetry.h.

[ ... ]

> +	ret =3D wait_for_completion_interruptible_timeout(&elem.xfer_done, HZ);
> +	/*
> +	 * not using _interruptable because we have to cleanup or we'll
> +	 * likely cause memory corruption
> +	 */
> +	mutex_lock(&qdev->tele_mutex);
> +	if (!list_empty(&elem.list))
> +		list_del(&elem.list);
> +	/* resp_worker() processed the response but the wait was interrupted */
> +	else if (ret =3D=3D -ERESTARTSYS)
> +		ret =3D 0;
> +	if (!ret && !elem.buf)
> +		ret =3D -ETIMEDOUT;
> +	else if (ret > 0 && !elem.buf)
> +		ret =3D -EIO;
> +	mutex_unlock(&qdev->tele_mutex);
> +
> +	resp =3D elem.buf;
> +
> +	/*
> +	 * telemetry_request() is called from Generic Netlink .doit callbacks
> +	 * rather than a syscall boundary, so -ERESTARTSYS is never translated
> +	 * to -EINTR before it would otherwise be serialized as-is into the
> +	 * netlink error ack.
> +	 */
> +	if (ret =3D=3D -ERESTARTSYS)
> +		ret =3D -EINTR;
> +
> +	if (ret < 0)
> +		goto free_resp;
> +
> +	if (le16_to_cpu(resp->hdr.magic) !=3D MAGIC || le16_to_cpu(resp->hdr.ve=
r) !=3D VERSION ||
> +	    resp->hdr.type !=3D MSG_RESP || resp->hdr.id !=3D 0 ||
> +	    le16_to_cpu(resp->hdr.len) !=3D sizeof(resp->data) || resp->data.cm=
d !=3D cmd ||
> +	    resp->data.cmd_type !=3D cmd_type) {
> +		ret =3D -EINVAL;
> +		goto free_resp;
> +	}
> +
> +	if (resp->data.status) {
> +		switch ((int8_t) resp->data.status) {
> +		case ERR_READ_ONLY:
> +			*status =3D -EROFS;
> +			break;
> +		case ERR_NOT_SUPPORTED:
> +			*status =3D -EOPNOTSUPP;
> +			break;
> +		case ERR_WHILE_PROCESSING:
> +			*status =3D -EREMOTEIO;
> +			break;
> +		case ERR_INVALID_VALUE:
> +			*status =3D -EINVAL;
> +			break;
> +		case ERR_INVALID_HEADER:
> +			*status =3D -EBADR;
> +			break;
> +		default:
> +			*status =3D -EPROTO;
> +		}
> +		goto free_resp;
> +	}
> +
> +	if (cmd_type =3D=3D TYPE_READ)
> +		*val =3D le64_to_cpu(resp->data.val);
> +
> +	ret =3D 0;
> +
> +free_resp:
> +	kfree(resp);
> +free_req:
> +	kref_put(&wrapper->ref_count, free_wrapper);
> +
> +	return ret;
> +}

[Severity: Medium]
Does telemetry_request() return positive remaining jiffies when
resp->data.status is non-zero?

wait_for_completion_interruptible_timeout() sets ret to the remaining
jiffies (> 0) when the completion signals before the timeout, and the
"if (resp->data.status)" branch jumps to free_resp before "ret =3D 0;".
drm_ras_nl_telemetry_get_doit() and drm_ras_nl_telemetry_set_doit() treat
any non-zero return from telemetry_get() or telemetry_set() as a callback
error and free the reply message instead of sending *status to userspace,
while netlink_rcv_skb() only sends an NLMSG_ERROR ack for negative
returns, so userspace receives neither the status attribute nor an error
ack.

> +static int qaic_telemetry_mhi_probe(struct mhi_device *mhi_dev, const st=
ruct mhi_device_id *id)
> +{
> +	struct qaic_device *qdev =3D pci_get_drvdata(to_pci_dev(mhi_dev->mhi_cn=
trl->cntrl_dev));
> +	int ret;
> +
> +	ret =3D mhi_prepare_for_transfer(mhi_dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_set_drvdata(&mhi_dev->dev, qdev);
> +	qdev->tele_ch =3D mhi_dev;
> +	qdev->tele_lost_buf =3D false;
> +
> +	ret =3D qaic_drm_ras_register_node(qdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

[Severity: Medium]
If qaic_drm_ras_register_node() fails here, does
qaic_telemetry_mhi_probe() leak the prepared MHI channel state and leave
qdev->tele_ch dangling?  Since probe fails, qaic_telemetry_mhi_remove()
will not run, so mhi_unprepare_from_transfer(mhi_dev) and clearing
qdev->tele_ch need to happen on this error path.

> +static void qaic_telemetry_mhi_remove(struct mhi_device *mhi_dev)
> +{
> +	struct qaic_device *qdev =3D dev_get_drvdata(&mhi_dev->dev);
> +
> +	qaic_drm_ras_unregister_node(qdev);
> +	mhi_unprepare_from_transfer(qdev->tele_ch);
> +	qdev->tele_ch =3D NULL;
> +}

[Severity: Medium]
Can qaic_telemetry_mhi_remove() race with an in-flight
telemetry_request() on qdev->tele_ch?

During module unload in qaic_exit() or MHI driver unbind,
qaic_telemetry_mhi_remove() runs while qdev->dev_state is still
QAIC_ONLINE, and drm_ras_node_unregister() only erases the node from
drm_ras_xa without waiting for running netlink callbacks:

CPU0                                  CPU1
qaic_telemetry_get()
  telemetry_request()
    mutex_lock_interruptible(&qdev->tele_mutex)
    if (!qdev->tele_ch)
                                      qaic_telemetry_mhi_remove()
                                        mhi_unprepare_from_transfer(...)
                                        qdev->tele_ch =3D NULL;
    mhi_queue_buf(qdev->tele_ch, ...)
      mhi_queue(NULL, ...)  <-- NULL pointer dereference

In addition, when mhi_unprepare_from_transfer() resets the DL channel,
qaic_telemetry_mhi_dl_xfer_cb() sees transaction_status !=3D 0 and drops the
buffer without completing elem.xfer_done.  Because
qaic_telemetry_mhi_remove() does not call wake_all_telemetry(qdev) and
telemetry_request() does not check qdev->dev_state under qdev->tele_mutex,
in-flight requests wait for the full timeout.

[ ... ]

> +void qaic_drm_ras_unregister_node(struct qaic_device *qdev)
> +{
> +	drm_ras_node_unregister(qdev->ras_node);
> +	kfree(qdev->ras_node->node_name);
> +	kfree(qdev->ras_node->device_name);
> +	kfree(qdev->ras_node);
> +}

[Severity: Medium]
Can freeing qdev->ras_node immediately after drm_ras_node_unregister()
cause a use-after-free in concurrent drm_ras netlink handlers?

drm_ras_nl_family enables .parallel_ops =3D true and looks up nodes in
drm_ras_xa via xa_load() or xa_for_each_start() without holding a lock or
reference across the callback, while drm_ras_node_unregister() only calls
xa_erase():

CPU0                                  CPU1
drm_ras_nl_pre_telemetry()
  node =3D xa_load(&drm_ras_xa, ...)
                                      qaic_telemetry_mhi_remove()
                                        qaic_drm_ras_unregister_node()
                                          drm_ras_node_unregister(ras_node)
                                          kfree(ras_node->node_name)
                                          kfree(ras_node->device_name)
                                          kfree(ras_node)
  node->telemetry_pre(node)  <-- use-after-free

Even on reset paths that call qaic_notify_reset() before MHI teardown,
synchronize_srcu(&qdev->dev_lock) runs before
qaic_drm_ras_unregister_node() erases the node from drm_ras_xa, and
qaic_telemetry_pre(), qaic_telemetry_get(), and qaic_telemetry_set() all
dereference ep before acquiring qdev->dev_lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106181225.3333=
260-1-zachary.mckevitt@oss.qualcomm.com?part=3D3
