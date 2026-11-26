Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4FE606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHO2TvCZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 510D110E384;
	Thu, 26 Nov 2026 21:23:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D0610E384;
 Thu, 26 Nov 2026 21:23:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 997FB6022A;
 Thu, 26 Nov 2026 21:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2808E1F00893;
 Thu, 26 Nov 2026 21:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795728182;
 bh=xA4rWx0M94ECdTTMqHI9PV7loz98QT6VdIcRLX77/ss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MHO2TvCZaEk/p2nCbckOSk/bDm6VNYaxnKgOckbHfua0p03dtjRQaFI9pgC1m3R8Z
 KyYZJTKVuW+RQwSkswkY67crQe90Tx7lp8/sigQaB4PK1HnuP9iyHD23xquLeo8X0U
 x08evBUYisfoKDxpO3DRiaHMXR+R21DYydCRKdGtJYswCw2cKg7zwNVsYCjFg2quL6
 qL8YkOKPiWG97fk+Xpr6H9oL24COBuWX9t8gx5oY1tWYTYVAzI3TJDul1nrOgRwjy1
 K8LneeoU1nUz7rya0gHvD1A6C+zd3ghMoI9kqRzFxkudVgK/23Cfo1IBw2D3kAi4LR
 B617YWNwpBVWA==
Message-ID: <sashiko-outbox-236230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] drm/xe/huc: load the DG2 HuC through the GSC via
 mei_pxp
To: "Arisa Snowbell" <arisa.snowbell@gmail.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261126205758.49845-4-arisa.snowbell@gmail.com>
References: <20261126205758.49845-1-arisa.snowbell@gmail.com>
 <20261126205758.49845-4-arisa.snowbell@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 21:23:01 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/xe/huc: missing flags argument to dma_fence_init() in
  huc_mei_fence_create()
- [Medium] drm/xe/huc: race on mei->state_lock in xe_huc_mei_start()
--

commit d092793f788c438939dcaa8d822c0755ed1b7fc7
Author: Arisa Snowbell <arisa.snowbell@gmail.com>

drm/xe/huc: load the DG2 HuC through the GSC via mei_pxp

This commit adds support for loading and authenticating the DG2 HuC
firmware asynchronously through the GSC via the mei_pxp component.

> diff --git a/drivers/gpu/drm/xe/xe_huc_mei.c b/drivers/gpu/drm/xe/xe_huc_=
mei.c
> new file mode 100644
> index 0000000000000..595405c4abfde
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_huc_mei.c
> @@ -0,0 +1,569 @@

[ ... ]

> +/* start() runs in the reset and resume paths, which must not wait on re=
claim */
> +static struct dma_fence *huc_mei_fence_create(struct xe_huc_mei *mei)
> +{
> +	struct huc_mei_fence *fence =3D kzalloc_obj(*fence, GFP_NOWAIT | __GFP_=
NOWARN);
> +
> +	if (!fence)
> +		return NULL;
> +
> +	spin_lock_init(&fence->lock);
> +	dma_fence_init(&fence->base, &huc_mei_fence_ops, &fence->lock,
> +		       mei->fence_context, atomic64_inc_return(&mei->seqno));
> +
> +	return &fence->base;
> +}

[Severity: High]
Is dma_fence_init() missing its sixth argument (unsigned long flags) here?
This fails to compile when CONFIG_DRM_XE is enabled.

[ ... ]

> +void xe_huc_mei_start(struct xe_huc *huc)
> +{
> +	struct xe_huc_mei *mei =3D &huc->mei;
> +	struct dma_fence *load, *old;
> +	bool wait;
> +
> +	if (!xe_huc_mei_is_used(huc) || !xe_uc_fw_is_loadable(&huc->fw))
> +		return;
> +
> +	scoped_guard(spinlock_irqsave, &mei->state_lock)
> +		wait =3D !mei->absent;
> +
> +	/* without a fence submissions just don't wait */
> +	load =3D wait ? huc_mei_fence_create(mei) : NULL;
> +
> +	scoped_guard(spinlock_irqsave, &mei->state_lock) {
> +		huc_mei_settle_locked(mei);
> +		old =3D mei->load;
> +		mei->state =3D wait ? XE_HUC_MEI_LOADING : XE_HUC_MEI_SETTLED;
> +		mei->load =3D load;
> +	}
> +	dma_fence_put(old);
> +
> +	if (wait)
> +		mod_delayed_work(system_dfl_wq, &mei->deadline,
> +				 msecs_to_jiffies(HUC_MEI_COMPONENT_TIMEOUT_MS));
> +	huc_mei_queue(mei);
> +}

[Severity: Medium]
Can dropping mei->state_lock before mod_delayed_work() leave mei->deadline
queued after the load has already settled?

CPU0                                  CPU1
xe_huc_mei_start()
  lock(&mei->state_lock)
  mei->state =3D XE_HUC_MEI_LOADING
  unlock(&mei->state_lock)
                                      huc_mei_auth_work()
                                        huc_mei_load_and_auth()
                                        lock(&mei->state_lock)
                                        huc_mei_settle_locked()
                                          mei->state =3D XE_HUC_MEI_SETTLED
                                          cancel_delayed_work(&mei->deadlin=
e)
                                        unlock(&mei->state_lock)
  mod_delayed_work(..., &mei->deadline, ...)  <-- re-arms cancelled work

Also, if mei->absent was true and huc_mei_component_bind() runs between
the two mei->state_lock sections, huc_mei_component_bind() clears
mei->absent =3D false while mei->state is still XE_HUC_MEI_DOWN.  Because
 the second critical section does not re-check mei->absent, it uses the
stale wait =3D=3D false and sets mei->state =3D XE_HUC_MEI_SETTLED with
mei->load =3D NULL, so submissions and HuC queries will not wait for the
pending load.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126205758.4984=
5-2-arisa.snowbell@gmail.com?part=3D3
