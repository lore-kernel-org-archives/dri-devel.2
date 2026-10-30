Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCE606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzDuWjil
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6783310E208;
	Fri, 30 Oct 2026 20:30:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B16A10E208
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:30:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 270A8605CE;
 Fri, 30 Oct 2026 20:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D181F000C1;
 Fri, 30 Oct 2026 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793392237;
 bh=sRJYUBf+16vEk+dcbt1+sdlSFDQFkMyGXsdUv91ugFw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=dzDuWjilqGuz5SIKxjMLZs6XTCQftAuVNO1ODnB6k1DBtD+jxWQX+M0mZ0QnH8YII
 21RBX5eztF9PpYWKTzCBxhjMoShG7nWl5ZI8YUVdac77WbF/X6AYRm9KJtesiioUPh
 EnFYu7+Hh9PKkBIbYRPZ587Fz8eOTXcniQ1JHgBSqImyH+oRV8QuW4MNqXnUmRQ4Q6
 aZAjnKs9wRF5KcgDbL9TP9P0KvLe3xxc7n4xz9l1+wPpoUHwxN/YJRNKEn7vT4SGZy
 cfJ5OqICVIfm7NBPWeFLf2XWfZI6qqnq1LpsdSsrTk4C77aQeuWA1iTMuxNieRmqSn
 Ygy5InFMgDaPw==
Message-ID: <sashiko-outbox-191475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] accel/qaic: Add callbacks for DRM RAS netlink
 telemetry
To: "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261029203000.1763447-4-zachary.mckevitt@oss.qualcomm.com>
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
 <20261029203000.1763447-4-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 20:30:37 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] accel/qaic: NULL pointer dereference and race on qdev->tele_ch
- [High] accel/qaic: missing dev_lock SRCU sync and tele_ch state check in =
telemetry
- [High] accel/qaic: missing tele_wq flush and drmm/devm mismatch in create=
_qdev()
- [Medium] accel/qaic: qaic_telemetry_get() and qaic_telemetry_set() drop s=
tatus replies on error
- [Medium] accel/qaic: silent u8 truncation of u32 telemetry field in telem=
etry_request()
- [Medium] accel/qaic: ignored qaic_telemetry_register() failure in qaic_in=
it()
- [Medium] accel/qaic: telemetry_request() drops completed response and lea=
ks -ERESTARTSYS to netlink
--

commit 089cd42088c5c813480c90b14aeb8fbd79e5ff35
Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

accel/qaic: Add callbacks for DRM RAS netlink telemetry

This commit adds MHI telemetry channel support and registers a DRM RAS
telemetry node during PCI probe so userspace can read and write device
telemetry fields over Generic Netlink.

> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 9e1e184efe0d1..e24a4f271a585 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
> @@ -32,6 +32,7 @@
>  #include "qaic_debugfs.h"
>  #include "qaic_ras.h"
>  #include "qaic_ssr.h"
> +#include "qaic_telemetry.h"
>  #include "qaic_timesync.h"
>  #include "sahara.h"
> =20
> @@ -389,6 +390,7 @@ static void qaic_notify_reset(struct qaic_device *qde=
v)
>  	qdev->dev_state =3D QAIC_OFFLINE;
>  	/* wake up any waiters to avoid waiting for timeouts at sync */
>  	wake_all_cntl(qdev);
> +	wake_all_telemetry(qdev);
>  	for (i =3D 0; i < qdev->num_dbc; ++i)
>  		wakeup_dbc(qdev, i);
>  	synchronize_srcu(&qdev->dev_lock);
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
Can this cause a use-after-free of qdev if the PCI device is removed while a
userspace process holds an open file descriptor to /dev/accel/accelN?

In create_qdev(), qdev is allocated with devm_kzalloc(&pdev->dev, ...),
whereas qdev->tele_mutex and qdev->tele_wq are managed by drmm on struct
drm_device. If /dev/accel/accelN is open when qaic_pci_remove() runs:

1. qaic_telemetry_mhi_remove() calls mhi_unprepare_from_transfer(qdev->tele=
_ch)
   without flushing qdev->tele_wq.
2. When qaic_pci_remove() returns, devres_release_all(&pdev->dev) drops the
   initial drm_device reference via devm_drm_dev_init_release(), but
   drm_managed_release() does not run yet because the open file descriptor
   still holds a reference on drm_device.
3. devres_release_all() immediately frees the devm-allocated qdev.

At that point, any pending resp_worker() work item on qdev->tele_wq will
dereference freed qdev memory (qdev->tele_mutex and qdev->tele_xfer_list),
and when the userspace file descriptor is finally closed,
__drmm_mutex_release() will call mutex_destroy(&qdev->tele_mutex) on the
already-freed qdev.

Should qaic_telemetry_mhi_remove() flush qdev->tele_wq, and should the
lifetime of qdev->tele_mutex and qdev->tele_wq match the devm lifetime of
qdev?

[ ... ]

> @@ -611,6 +620,13 @@ static int qaic_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>  		return ret;
>  	}
> =20
> +	ret =3D qaic_drm_ras_register_node(qdev);
> +	if (ret) {
> +		qaic_mhi_free_controller(qdev->mhi_cntrl, link_up);
> +		qaic_destroy_drm_device(qdev, QAIC_NO_PARTITION);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -624,6 +640,7 @@ static void qaic_pci_remove(struct pci_dev *pdev)
>  		return;
> =20
>  	qaic_dev_reset_clean_local_state(qdev);
> +	qaic_drm_ras_unregister_node(qdev);
>  	qaic_mhi_free_controller(qdev->mhi_cntrl, link_up);
>  	qaic_destroy_drm_device(qdev, QAIC_NO_PARTITION);
>  }

[Severity: High]
Does qaic_pci_remove() risk a use-after-free on qdev and qdev->ras_node if a
netlink telemetry request is in flight during device removal or reset?

In qaic_notify_reset() (called by qaic_dev_reset_clean_local_state()), the
driver sets qdev->dev_state =3D QAIC_OFFLINE, calls wake_all_telemetry(qdev=
),
and then calls synchronize_srcu(&qdev->dev_lock) to wait for in-flight
readers.

However, unlike the control path in qaic_control.c, qaic_telemetry_get(),
qaic_telemetry_set(), and telemetry_request() never acquire
srcu_read_lock(&qdev->dev_lock) and never check whether qdev->dev_state is
QAIC_ONLINE. In addition, qaic_pci_remove() runs
qaic_dev_reset_clean_local_state(qdev) before qaic_drm_ras_unregister_node(=
),
and qaic_drm_ras_unregister_node() frees qdev->ras_node immediately after
drm_ras_node_unregister().

If a netlink caller is sleeping in
wait_for_completion_interruptible_timeout(&elem.xfer_done, HZ) inside
telemetry_request(), or enters telemetry_request() after wake_all_telemetry=
()
runs while qdev->ras_node is still registered, synchronize_srcu() will not
wait for it. When the waiter wakes up after qaic_pci_remove() completes,
telemetry_request() will call mutex_lock(&qdev->tele_mutex) and
list_del(&elem.list) on freed qdev memory.

Should qaic_drm_ras_unregister_node() be called before
qaic_dev_reset_clean_local_state(), and should the telemetry callbacks guard
access with srcu_read_lock(&qdev->dev_lock) and check qdev->dev_state?

> @@ -860,6 +877,10 @@ static int __init qaic_init(void)
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
> @@ -889,6 +910,7 @@ static void __exit qaic_exit(void)
>  	 * reinitializing the link_up state after the cleanup is done.
>  	 */
>  	link_up =3D true;
> +	qaic_telemetry_unregister();
>  	qaic_ssr_unregister();
>  	qaic_ras_unregister();
>  	qaic_bootlog_unregister();

[Severity: Medium]
If qaic_telemetry_register() fails in qaic_init(), qaic_init() logs a debug
message and returns 0, leaving qaic_telemetry_mhi_driver unregistered
(drv->p =3D=3D NULL). When the module is later unloaded, qaic_exit()
unconditionally calls qaic_telemetry_unregister() -> mhi_driver_unregister()
-> driver_unregister(), which triggers:

    WARN(1, "Unexpected driver unregister!\n");

in drivers/base/driver.c:driver_unregister(). Should qaic_init() unwind and
propagate the error when qaic_telemetry_register() fails, matching
qaic_ssr_register()?

> diff --git a/drivers/accel/qaic/qaic_telemetry.c b/drivers/accel/qaic/qai=
c_telemetry.c
> new file mode 100644
> index 0000000000000..fdce7a71d3eba
> --- /dev/null
> +++ b/drivers/accel/qaic/qaic_telemetry.c

[ ... ]

> +int telemetry_request(struct qaic_device *qdev, u8 cmd, u8 cmd_type, s64=
 *val)
> +{
> +	struct wrapper_msg *wrapper;
> +	struct xfer_queue_elem elem;
> +	struct telemetry_msg *resp;
> +	struct telemetry_msg *req;
> +	long ret =3D 0;
> +
> +	wrapper =3D kzalloc_obj(*wrapper);
> +	if (!wrapper)
> +		return -ENOMEM;
> +
> +	kref_init(&wrapper->ref_count);
> +	req =3D &wrapper->msg;
> +
> +	ret =3D mutex_lock_interruptible(&qdev->tele_mutex);
> +	if (ret)
> +		goto free_req;
> +
> +	req->hdr.magic =3D cpu_to_le16(MAGIC);
> +	req->hdr.ver =3D cpu_to_le16(VERSION);
> +	req->hdr.seq_num =3D cpu_to_le32(qdev->tele_next_seq_num++);
> +	req->hdr.type =3D MSG_REQ;
> +	req->hdr.id =3D 0;
> +	req->hdr.len =3D cpu_to_le16(sizeof(req->data));
> +
> +	req->data.cmd =3D cmd;
> +	req->data.cmd_type =3D cmd_type;
> +	req->data.status =3D 0;
> +	if (cmd_type =3D=3D TYPE_READ)
> +		req->data.val =3D cpu_to_le64(0);
> +	else
> +		req->data.val =3D cpu_to_le64(*val);
> +
> +	elem.seq_num =3D qdev->tele_next_seq_num - 1;
> +	elem.buf =3D NULL;
> +	init_completion(&elem.xfer_done);
> +	if (likely(!qdev->tele_lost_buf)) {
> +		resp =3D kzalloc_obj(*resp);
> +		if (!resp) {
> +			mutex_unlock(&qdev->tele_mutex);
> +			ret =3D -ENOMEM;
> +			goto free_req;
> +		}
> +
> +		ret =3D mhi_queue_buf(qdev->tele_ch, DMA_FROM_DEVICE, resp, sizeof(*re=
sp), MHI_EOT);
> +		if (ret) {
> +			mutex_unlock(&qdev->tele_mutex);
> +			goto free_resp;
> +		}
> +	} else {
> +		/*
> +		 * we lost a buffer because we queued a recv buf, but then
> +		 * queuing the corresponding tx buf failed. To try to avoid
> +		 * a memory leak, lets reclaim it and use it for this
> +		 * transaction.
> +		 */
> +		qdev->tele_lost_buf =3D false;
> +	}
> +
> +	kref_get(&wrapper->ref_count);
> +	ret =3D mhi_queue_buf(qdev->tele_ch, DMA_TO_DEVICE, req, sizeof(*req), =
MHI_EOT);

[Severity: High]
What happens if telemetry_request() is called when qdev->tele_ch is NULL, or
while qaic_telemetry_mhi_remove() is running concurrently?

In qaic_pci_probe(), qaic_drm_ras_register_node(qdev) exposes the telemetry
netlink callbacks immediately after qaic_create_drm_device() creates
/dev/accel/accelN. However, qdev->tele_ch is only set asynchronously in
qaic_telemetry_mhi_probe() once the device enters AMSS, and is reset to NULL
in qaic_telemetry_mhi_remove().

If userspace sends a DRM_RAS_CMD_TELEMETRY_GET or DRM_RAS_CMD_TELEMETRY_SET
request before qaic_telemetry_mhi_probe() runs (or after
qaic_telemetry_mhi_remove() clears qdev->tele_ch), telemetry_request() pass=
es
qdev->tele_ch =3D=3D NULL to mhi_queue_buf() -> mhi_queue(), which immediat=
ely
dereferences mhi_dev->mhi_cntrl and crashes.

Furthermore, qaic_telemetry_mhi_probe() and qaic_telemetry_mhi_remove()
modify qdev->tele_ch and qdev->tele_lost_buf and call
mhi_unprepare_from_transfer(qdev->tele_ch) without holding qdev->tele_mutex,
and qaic_telemetry_mhi_remove() does not wake waiters on
qdev->tele_xfer_list. Should telemetry_request() check if (!qdev->tele_ch)
under qdev->tele_mutex (returning -ENODEV), and should
qaic_telemetry_mhi_probe() and qaic_telemetry_mhi_remove() serialize against
qdev->tele_mutex and wake pending waiters?

> +	if (ret) {
> +		qdev->tele_lost_buf =3D true;
> +		kref_put(&wrapper->ref_count, free_wrapper);
> +		mutex_unlock(&qdev->tele_mutex);
> +		goto free_req;
> +	}
> +
> +	list_add_tail(&elem.list, &qdev->tele_xfer_list);
> +	mutex_unlock(&qdev->tele_mutex);
> +
> +	ret =3D wait_for_completion_interruptible_timeout(&elem.xfer_done, HZ);
> +	/*
> +	 * not using _interruptable because we have to cleanup or we'll
> +	 * likely cause memory corruption
> +	 */
> +	mutex_lock(&qdev->tele_mutex);
> +	if (!list_empty(&elem.list))
> +		list_del(&elem.list);
> +	if (!ret && !elem.buf)
> +		ret =3D -ETIMEDOUT;
> +	else if (ret > 0 && !elem.buf)
> +		ret =3D -EIO;
> +	mutex_unlock(&qdev->tele_mutex);
> +
> +	resp =3D elem.buf;
> +
> +	if (ret < 0)
> +		goto free_resp;

[Severity: Medium]
What happens here when wait_for_completion_interruptible_timeout() (or the
earlier mutex_lock_interruptible()) is interrupted by a signal and returns
-ERESTARTSYS?

First, if resp_worker() already completed the transfer and set elem.buf
before telemetry_request() acquired qdev->tele_mutex, ret is still
-ERESTARTSYS, so if (ret < 0) branches to free_resp and discards the valid
response (unlike msg_xfer() in qaic_control.c, which resets ret =3D 0 when
elem.buf is present).

Second, because telemetry_request() is called from Generic Netlink .doit
callbacks (drm_ras_nl_telemetry_get_doit() and
drm_ras_nl_telemetry_set_doit()), returning -ERESTARTSYS causes
netlink_rcv_skb() -> netlink_ack() to serialize the kernel-internal
-ERESTARTSYS (-512) value directly into the NLMSG_ERROR payload sent to
userspace. Should this check for a completed elem.buf and translate any
remaining -ERESTARTSYS to -EINTR?

[ ... ]

> +static int qaic_telemetry_get(struct drm_ras_node *ep, u32 *field, s64 *=
value, s32 *status)
> +{
> +	struct qaic_device *qdev =3D ep->priv;
> +
> +	*status =3D (s32)telemetry_request(qdev, *field, TYPE_READ, value);
> +
> +	return *status;
> +}
> +
> +static int qaic_telemetry_set(struct drm_ras_node *ep, u32 *field, s64 *=
value, s32 *status)
> +{
> +	struct qaic_device *qdev =3D ep->priv;
> +
> +	*status =3D (s32)telemetry_request(qdev, *field, TYPE_WRITE, value);
> +
> +	return *status;
> +}

[Severity: Medium]
In qaic_telemetry_get() and qaic_telemetry_set(), *field is a u32 coming fr=
om
the netlink DRM_RAS_A_TELEMETRY_ATTRS_FIELD attribute (which drm_ras does n=
ot
validate against telemetry_fields_gettable or telemetry_fields_settable in
the doit path), whereas telemetry_request() takes u8 cmd.

Doesn't passing *field directly to telemetry_request() silently truncate
32-bit field IDs modulo 256 (for example, turning 0x101 into 1,
QAIC_DEVINFO_THERMAL_SOC_MAX_TEMP) instead of rejecting out-of-range or
unsupported field IDs?

[Severity: Medium]
Also in qaic_telemetry_get() and qaic_telemetry_set(), both functions assign
the return value of telemetry_request() to *status and then return *status.
Looking at drm_ras_nl_telemetry_get_doit() and
drm_ras_nl_telemetry_set_doit() in drivers/gpu/drm/drm_ras.c:

	ret =3D node->telemetry_get(node, &field, &value, &status);
	if (ret) {
		nlmsg_free(msg);
		return ret;
	}

	ret =3D nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);

When telemetry_request() returns a non-zero error code (such as when the
device returns a firmware status error in resp->data.status), returning
*status from the callback causes drm_ras to free the reply message and abort
before encoding DRM_RAS_A_TELEMETRY_ATTRS_STATUS. Is *status intended to be
reported in the netlink reply when the device returns a status error (with
the callback returning 0)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029203000.1763=
447-1-zachary.mckevitt@oss.qualcomm.com?part=3D3
