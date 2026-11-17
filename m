Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48BF606A8A1
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2WYHMHL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CA310EBB5;
	Tue, 17 Nov 2026 17:10:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C97C10EBB5
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 17:10:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C257440879;
 Tue, 17 Nov 2026 17:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFA31F000C5;
 Tue, 17 Nov 2026 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794935426;
 bh=LKJPGG/6jzqJMcdgYR/c5JzapitynsuFqa6O0BBfApg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=l2WYHMHLyjLq40uM2oAZ87HAb1BZdN1HIjbODZeaHNfABPPpG+s+RmURH/zEgeVuC
 T+IawwQOtZ0+sLbhGpRgsglqMy0jbSgIro6bXffphb+dN081z7Kmpzsv1SD2qQV/BY
 BSgRL82rlkyRi6BhH+2ZgUxN1E9LO2BxNrE5KfUTZpAp6j/uVyHg0uZ1uOu5g/DMDb
 wbBi0B58JMFMbFZH7ZTgzOT4JXpyXsTpa+Ne/0vvmNg+dSzJ8SEmXuHSTmAwMzo6kE
 IGX1P/IXDJ+kq91mqNDFpXbyeXvFdgZxd5qBqagqhCh0XLns8nObACEJE0bh9lOeSF
 7RXzCzl77BOpw==
Message-ID: <sashiko-outbox-219209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Destroy the context when hwctx
 restart fails
To: "Lizhi Hou" <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261117165731.132261-1-lizhi.hou@amd.com>
References: <20261117165731.132261-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:10:26 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] accel/amdxdna: hardware use-after-free in aie2_hwctx_fini()
  [1]
--

commit 3c1fe55acb7bc743b1d9dd435d5bd52e64f6bdb4
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Destroy the context when hwctx restart fails

This commit updates aie2_hwctx_restart() to stop and destroy the hardware
context when mapping host buffers, adding heaps, or configuring CUs fails.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index 74d7019268cb6..11f5421e497aa 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -122,7 +122,7 @@ static int aie2_hwctx_restart(struct amdxdna_dev *xdn=
a, struct amdxdna_hwctx *hw
>  				heap->mem.size);
>  	if (ret) {
>  		XDNA_ERR(xdna, "Map host buf failed, ret %d", ret);
> -		goto out;
> +		goto destroy;
>  	}
> =20
>  	xa_for_each_range(&hwctx->client->dev_heap_xa, heap_id, heap, 1,
> @@ -132,16 +132,20 @@ static int aie2_hwctx_restart(struct amdxdna_dev *x=
dna, struct amdxdna_hwctx *hw
>  					heap->mem.size);
>  		if (ret) {
>  			XDNA_ERR(xdna, "Add heap %ld failed ret %d", heap_id, ret);
> -			goto out;
> +			goto destroy;
>  		}
>  	}
> =20
>  	ret =3D aie2_config_cu(hwctx, NULL);
>  	if (ret) {
>  		XDNA_ERR(xdna, "Config cu failed, ret %d", ret);
> -		goto out;
> +		goto destroy;
>  	}
> =20
> +	return 0;
> +
> +destroy:
> +	aie2_hwctx_stop(xdna, hwctx, NULL);
>  out:
>  	XDNA_DBG(xdna, "%s restarted, ret %d", hwctx->name, ret);
>  	return ret;

[Severity: Critical]
This problem wasn't introduced by this patch, but can restarting the
scheduler in aie2_hwctx_fini() before destroying the entity issue pending
jobs to a destroyed hardware context [1]?

drivers/accel/amdxdna/aie2_ctx.c:aie2_hwctx_fini() {
    ...
	drm_sched_stop(hwctx->priv->sched, NULL);
	aie2_release_resource(hwctx);
	drm_sched_start(hwctx->priv->sched, 0);

	mutex_unlock(&xdna->dev_lock);
	drm_sched_entity_destroy(&hwctx->priv->entity);
    ...
}

drivers/accel/amdxdna/aie2_ctx.c:aie2_sched_job_run() {
    ...
	if (!hwctx->priv->mbox_chann)
		return NULL;
    ...
}

Because drm_sched_start() runs before drm_sched_entity_destroy(), the
scheduler thread pulls remaining pending jobs and passes them to
aie2_sched_job_run() after aie2_release_resource() has freed the hardware
context.  Since aie2_release_resource() clears hwctx->priv->mbox_chann,
aie2_sched_job_run() returns NULL instead of an error pointer such as
ERR_PTR(-ECANCELED), which the DRM scheduler treats as successful job
completion and silently drops the jobs while signaling success to
userspace.

[1] https://sashiko.dev/#/bug/linux-97541525-e808-4942-a13a-978ecaacc230

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117165731.1322=
61-1-lizhi.hou@amd.com?part=3D1
