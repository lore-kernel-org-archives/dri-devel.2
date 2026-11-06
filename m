Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497A606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKEOACF0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8D410E439;
	Fri,  6 Nov 2026 19:52:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFEBC10E439
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 19:52:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20E15601C0;
 Fri,  6 Nov 2026 19:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F6A1F0089F;
 Fri,  6 Nov 2026 19:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793994762;
 bh=rVfvbhDNoaNg5qEx1s/qKZFG3Q7oOTGOCFDhGecjowc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dKEOACF0AyVFaXepNzQRMBUpxO4tp9FuZeIQUi9uEdeEOPy/Po6d0s+1U22aJuLDO
 FSgNmy2QSDqhv6sVFopnoTflfk4NdNnKsIhvudt89wyp10Y6Otmjk+WCrCMF7CN3Vn
 rT+vLMI52gD8lW/VLckBo4mkdqMCXCHQbK1hRzyX11Y0Q1rPgvWXzs8L3GL8Bp7RwG
 pVqyDhmKK8VcET1tTKQmh5EeC1Tl/ypKBRpyAC3Vq7fABlaLGxm3GTGRFkhllShF+t
 1mToaaleSV/UlEUjTPS0E91KaYfW3zyqHsLonXFWWaptiPNtwgNzaNl5ywedDUHFpj
 MuMYB5nmu1jpQ==
Message-ID: <sashiko-outbox-202179@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/qaic: Harden checks in BO execute and wait IOCTLs
To: "Youssef Samir" <youssef.abdulrahman@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106194434.4062205-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20261106194434.4062205-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:52:42 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] accel/qaic: unlocked bo->dbc dereference in
  qaic_wait_bo_ioctl()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] accel/qaic: missing completion signal in
  send_bo_list_to_device() error path [1]
--

commit f3a92ee30bd740f37f373a9b22ee385311742a39
Author: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

accel/qaic: Harden checks in BO execute and wait IOCTLs

This commit adds checks in send_bo_list_to_device() and
qaic_wait_bo_ioctl() to verify that BOs are sliced and attached to the
specified DBC.

> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_dat=
a.c
> index ee35e13091b30..be3ceb8c51a09 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
> @@ -1256,6 +1256,11 @@ static int send_bo_list_to_device(struct qaic_devi=
ce *qdev, struct drm_file *fil
>  			goto unlock_bo;
>  		}
> =20
> +		if (bo->dbc->id !=3D dbc->id) {
> +			ret =3D -EINVAL;
> +			goto unlock_bo;
> +		}
> +
>  		if (is_partial && pexec[i].resize > bo->base.size) {
>  			ret =3D -EINVAL;
>  			goto unlock_bo;

[Severity: Medium]
This problem wasn't introduced by this patch, but can failing on a later BO
in the batch leave waiters on earlier BOs hung indefinitely [1]?

For each BO processed before the failure, send_bo_list_to_device() calls
reinit_completion(&bo->xfer_done) and adds the BO to dbc->xfer_list.  When a
subsequent BO jumps to unlock_bo and failed_to_send_bo, the rollback loop
removes those earlier BOs from dbc->xfer_list without calling
complete_all(&bo->xfer_done):

drivers/accel/qaic/qaic_data.c:send_bo_list_to_device() {
    ...
failed_to_send_bo:
	if (likely(obj))
		drm_gem_object_put(obj);
	for (j =3D 0; j < i; j++) {
		spin_lock_irqsave(&dbc->xfer_lock, flags);
		bo =3D list_last_entry(&dbc->xfer_list, struct qaic_bo, xfer_list);
		obj =3D &bo->base;
		list_del_init(&bo->xfer_list);
		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
		dma_sync_sgtable_for_cpu(&qdev->pdev->dev, bo->sgt, bo->dir);
		drm_gem_object_put(obj);
	}
}

Because the rolled-back BOs are no longer on dbc->xfer_list, the interrupt
handler will never complete them, so any thread waiting in
qaic_wait_bo_ioctl() will block until timeout.

> @@ -1769,6 +1774,17 @@ int qaic_wait_bo_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *file
>  	}
> =20
>  	bo =3D to_qaic_bo(obj);
> +
> +	if (!bo->sliced) {
> +		ret =3D -EINVAL;
> +		goto put_obj;
> +	}
> +
> +	if (bo->dbc->id !=3D dbc->id) {
> +		ret =3D -EINVAL;
> +		goto put_obj;
> +	}
> +
>  	timeout =3D args->timeout ? args->timeout : wait_exec_default_timeout_m=
s;
>  	timeout =3D msecs_to_jiffies(timeout);
>  	ret =3D wait_for_completion_interruptible_timeout(&bo->xfer_done, timeo=
ut);

[Severity: High]
Can this dereference a NULL bo->dbc when racing with
qaic_detach_slice_bo_ioctl()?

bo->sliced and bo->dbc are protected by bo->lock, which qaic_wait_bo_ioctl()
does not hold.  A concurrent detach clears bo->dbc in qaic_unprepare_bo()
before clearing bo->sliced in qaic_init_bo():

CPU0                                  CPU1
qaic_wait_bo_ioctl()                  qaic_detach_slice_bo_ioctl()
                                        mutex_lock(&bo->lock)
                                        detach_slice_bo()
                                          qaic_unprepare_bo()
                                            bo->dbc =3D NULL
  if (!bo->sliced)
  if (bo->dbc->id !=3D dbc->id)  <-- NULL pointer dereference
                                          qaic_init_bo()
                                            bo->sliced =3D false

Acquiring bo->lock around the bo->sliced and bo->dbc->id checks prevents the
race.

[1] https://sashiko.dev/#/bug/linux-3d10e194-452c-43b5-a7b5-0f068986229f

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106194434.4062=
205-1-youssef.abdulrahman@oss.qualcomm.com?part=3D1
