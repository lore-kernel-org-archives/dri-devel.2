Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2737606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXXKFGqj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A42D10EAC2;
	Sun,  1 Nov 2026 22:39:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611E310EAC2
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:39:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8D14605CE;
 Sun,  1 Nov 2026 22:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9581F00919;
 Sun,  1 Nov 2026 22:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793572790;
 bh=OM0IoKNW8LVDk7VEBVSVvLLHvhPp9BQsI03LPIKz+CU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RXXKFGqjOA+gKf3Pu+6lVZ4dOIxqTydGV6Xx2O8QVejGE8Vb+O2qVg7Csr8CNgFxF
 ME9xR54Tfj4T/pZL6RL5ReHzhhI2xEFtqJOo6PZbimqx5uARu7XuChkDvkfr0JwywU
 AINuJOegI6gD9sBIj9IduM2go7A+9wpYm1RRwSX82o+x/yHzThLgyrUuOlPcfWmPxH
 6YU76AgxBnVQtDNMst0Z2sKaxRAit74www5ANtAx6vPJFhufp1W22itm+HxWCPXdWv
 mgcVZb+kQFfm8ewR+hlVR6R5ZAq0lB6uBagjP8571quFksW8Gkaw8hnjKNuNoMgkqA
 zeSllSbN4RDHw==
Message-ID: <sashiko-outbox-192722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/25] accel/qda: Assign a context bank to each session
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-4-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-4-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:39:49 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] accel/qda: dangling cb_dev pointer in struct qda_iommu_device afte=
r unpopulate
- [High] accel/qda: devm lifetime mismatch and premature teardown of qdev->=
iommu_mgr
--

commit 274f69c69f358c698c8f7dd37051492c7c060cc1
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Assign a context bank to each session

This commit introduces a context bank registry (struct qda_memory_manager) =
to
track a QDA device's compute context banks and exclusively assign one refco=
unted
struct qda_iommu_device per open session.

> diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
> index afb0bb71a1f44..6f1cff1133f9d 100644
> --- a/drivers/accel/qda/qda_cb.c
> +++ b/drivers/accel/qda/qda_cb.c
> @@ -7,8 +7,44 @@
>  #include <drm/drm_print.h>
>  #include "qda_cb.h"
>  #include "qda_drv.h"
> +#include "qda_memory_manager.h"
>  #include "qda_soc.h"
> =20
> +static int qda_cb_setup_device(struct qda_dev *qdev, struct device *cb_d=
ev)
> +{
> +	struct qda_iommu_device *iommu_dev;
> +	int ret;
> +
> +	iommu_dev =3D kzalloc_obj(*iommu_dev);
> +	if (!iommu_dev)
> +		return -ENOMEM;
> +
> +	iommu_dev->dev =3D cb_dev;
> +	iommu_dev->qdev =3D qdev;
> +
> +	ret =3D qda_memory_manager_register_device(qdev->iommu_mgr, iommu_dev);
> +	if (ret) {
> +		drm_err(&qdev->drm_dev, "Failed to register context bank: %d\n", ret);
> +		kfree(iommu_dev);
> +		return ret;
> +	}
> +
> +	dev_set_drvdata(cb_dev, iommu_dev);
> +
> +	return 0;
> +}
> +
> +static void qda_cb_teardown_device(struct device *cb_dev)
> +{
> +	struct qda_iommu_device *iommu_dev =3D dev_get_drvdata(cb_dev);
> +
> +	if (!iommu_dev)
> +		return;
> +
> +	qda_memory_manager_unregister_device(iommu_dev->qdev->iommu_mgr, iommu_=
dev);
> +	dev_set_drvdata(cb_dev, NULL);
> +}

[ ... ]

> @@ -70,6 +112,7 @@ void qda_cb_unpopulate(struct qda_dev *qdev)
> =20
>  	list_for_each_entry_safe(entry, tmp, &qdev->cb_devs, node) {
>  		list_del(&entry->node);
> +		qda_cb_teardown_device(&entry->pdev->dev);
>  		of_platform_device_destroy(&entry->pdev->dev, NULL);

[Severity: High]
Can this leave a dangling pointer in iommu_dev->dev when the rpmsg channel
goes away while a session is still open?

In qda_cb_setup_device(), iommu_dev->dev stores the raw cb_dev pointer
(&pdev->dev) without taking a reference via get_device(cb_dev), and
iommu_device_free() frees struct qda_iommu_device without calling
put_device().

When a session owns a context bank via qda_memory_manager_assign_device(),
assign_available_device() takes a second reference on iommu_dev->ref so that
struct qda_iommu_device stays alive until qda_postclose() ->
qda_session_free() calls qda_memory_manager_release_device().

If qda_rpmsg_remove() runs while a DRM file is open:

  qda_rpmsg_remove()
    qda_cb_unpopulate()
      qda_cb_teardown_device(&entry->pdev->dev)
        qda_memory_manager_unregister_device()
          kref_put(&iommu_dev->ref, iommu_device_free)  /* ref drops 2 -> 1=
 */
      of_platform_device_destroy(&entry->pdev->dev, NULL)

of_platform_device_destroy() unregisters and frees entry->pdev (and its
embedded struct device), while session->assigned_iommu_dev remains alive wi=
th
iommu_dev->dev still pointing to the freed struct device for the remainder =
of
the open session's lifetime.

Should qda_cb_setup_device() and iommu_device_free() manage a device
reference with get_device() and put_device(), or otherwise invalidate
iommu_dev->dev under synchronization when the context bank is torn down?

> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 6ecb6a966f686..a99e23933f6ba 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c

[ ... ]

> @@ -70,6 +76,26 @@ struct qda_dev *qda_alloc_device(struct device *dev)
>  	return qdev;
>  }
> =20
> +int qda_init_device(struct qda_dev *qdev, int num_cbs)
> +{
> +	int ret;
> +
> +	qdev->iommu_mgr =3D devm_kzalloc(qdev->dev, sizeof(*qdev->iommu_mgr), G=
FP_KERNEL);
> +	if (!qdev->iommu_mgr)
> +		return -ENOMEM;
> +
> +	ret =3D qda_memory_manager_init(qdev->iommu_mgr, num_cbs);
> +	if (ret)
> +		drm_err(&qdev->drm_dev, "Failed to initialize memory manager: %d\n", r=
et);
> +
> +	return ret;
> +}
> +
> +void qda_deinit_device(struct qda_dev *qdev)
> +{
> +	qda_memory_manager_exit(qdev->iommu_mgr);
> +}

[Severity: High]
Does allocating qdev->iommu_mgr with devm_kzalloc(qdev->dev, ...) and teari=
ng
it down in qda_rpmsg_remove() -> qda_deinit_device() mismatch the lifetime =
of
struct qda_dev?

qda_alloc_device() allocates struct qda_dev with devm_drm_dev_alloc(), which
keeps qdev alive until the last drm_device reference is dropped when all op=
en
drm_file descriptors are closed. In contrast, devm_kzalloc(qdev->dev, ...)
ties qdev->iommu_mgr to the rpmsg_device driver binding.

When qda_rpmsg_remove() runs while a file is open:

  qda_rpmsg_remove()
    drm_dev_unplug(&qdev->drm_dev)
    qda_cb_unpopulate(qdev)
    qda_deinit_device(qdev)
      qda_memory_manager_exit(qdev->iommu_mgr)
        kfree(mem_mgr->devices)
        mutex_destroy(&mem_mgr->assignment_lock)

When qda_rpmsg_remove() returns, devres releases qdev->iommu_mgr, leaving
qdev->iommu_mgr as a non-NULL dangling pointer to freed memory and a destro=
yed
mutex while qdev and open qda_session instances are still alive. Moreover,
because drm_ioctl() only performs a point-in-time drm_dev_is_unplugged() ch=
eck
at entry before calling the ioctl handler, any in-flight operation that pas=
sed
that check before drm_dev_unplug() and calls
qda_memory_manager_assign_device(qdev->iommu_mgr, session) can race with
qda_memory_manager_exit() and devres teardown.

Should struct qda_memory_manager be embedded in struct qda_dev (or managed =
via
drmm) so its lifetime and mutex match qdev->drm_dev?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D4
