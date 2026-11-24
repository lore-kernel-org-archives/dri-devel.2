Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9B6606A682
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOCOk28Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667AE10EB84;
	Tue, 24 Nov 2026 07:03:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C98210E7CF
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:03:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1345A405F8;
 Tue, 24 Nov 2026 07:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E031F000CA;
 Tue, 24 Nov 2026 07:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795503796;
 bh=IGKrZ0Ae2wZ/Z3TKu2BiHLvfoO6zY3rXrMj0uSJwdts=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=mOCOk28ZVM2jZDNrkPuiU9IRNKc4VyvDdliWVvFr7MeMSugJkTu5oKcTwE7ew5xKn
 z+AUJpXEZMOtCQnN5of/frKmge0ub95XlQQV5u2xv/v3EvPbbnw+t6fnQcRxsyikPN
 VCMYRWg9mYiyggl85F4T1bqevEC0Za1oVOGdatQWnhdRIU6XlHUToxeNMbZM9Dfc9e
 2KKIxZ/xPka8CTGy/dK0h52SvHLFmVGPG1wfXz8ncN1zUhajdqL6dYQjDwTi6uMXCq
 SqxyvXA5W95S8izgSiP0Eji+dYpQPTP+kwhySTAX2O3WWn1/A8QkYr1FpRNuno04JR
 qsbePfk3iC1zw==
Message-ID: <sashiko-outbox-230617@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/komeda: Use drmm_mode_config_init()
To: "Luo Liu" <Luo.Liu@cixtech.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261124065446.3107248-3-Luo.Liu@cixtech.com>
References: <20261124065446.3107248-1-Luo.Liu@cixtech.com>
 <20261124065446.3107248-3-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:03:15 +0000
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
- [High] drm/komeda: null pointer dereference in
  komeda_kms_irq_handler() [1]
--

commit 0e65e87085171dcf76021a4ce18f9f49413797fc
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/komeda: Use drmm_mode_config_init()

This commit switches komeda to drmm_mode_config_init(), drops explicit
drm_mode_config_cleanup() calls, and updates
komeda_kms_cleanup_private_objs() to walk pipelines instead of
mode_config.privobj_list.

> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index faa8b041373a7..37388d45b31f2 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c

[ ... ]

> @@ -315,7 +322,7 @@ struct komeda_kms_dev *komeda_kms_attach(struct komed=
a_dev *mdev)
>  			       komeda_kms_irq_handler, IRQF_SHARED,
>  			       drm->driver->name, drm);
>  	if (err)
> -		goto cleanup_mode_config;
> +		goto cleanup_private_objs;
> =20
>  	drm_kms_helper_poll_init(drm);
> =20
> @@ -327,9 +334,8 @@ struct komeda_kms_dev *komeda_kms_attach(struct komed=
a_dev *mdev)
> =20
>  free_interrupts:
>  	drm_kms_helper_poll_fini(drm);
> -cleanup_mode_config:
> -	drm_mode_config_cleanup(drm);
> -	komeda_kms_cleanup_private_objs(kms);
> +cleanup_private_objs:
> +	komeda_kms_cleanup_private_objs(mdev);
>  	drm->dev_private =3D NULL;
>  	return ERR_PTR(err);
>  }
> @@ -337,12 +343,12 @@ struct komeda_kms_dev *komeda_kms_attach(struct kom=
eda_dev *mdev)
>  void komeda_kms_detach(struct komeda_kms_dev *kms)
>  {
>  	struct drm_device *drm =3D &kms->base;
> +	struct komeda_dev *mdev =3D drm->dev_private;
> =20
>  	drm_dev_unregister(drm);
>  	drm_kms_helper_poll_fini(drm);
>  	drm_atomic_helper_shutdown(drm);
> -	drm_mode_config_cleanup(drm);
> -	komeda_kms_cleanup_private_objs(kms);
> +	komeda_kms_cleanup_private_objs(mdev);
>  	drm->dev_private =3D NULL;
>  }

[Severity: High]
This problem wasn't introduced by this patch, but can clearing
drm->dev_private here cause a NULL pointer dereference in
komeda_kms_irq_handler() [1]?

The IRQ is registered with IRQF_SHARED via devm_request_irq(), so it stays
active until devres cleanup runs after komeda_kms_attach() fails or
komeda_kms_detach() returns.  If another device on the shared line raises
an interrupt after drm->dev_private is set to NULL,
komeda_kms_irq_handler() dereferences mdev:

drivers/gpu/drm/arm/display/komeda/komeda_kms.c:komeda_kms_irq_handler() {
	struct drm_device *drm =3D data;
	struct komeda_dev *mdev =3D drm->dev_private;
	...
	status =3D mdev->funcs->irq_handler(mdev, &evts);
}

[1] https://sashiko.dev/#/bug/linux-7f3e9b9f-7fcd-447d-9114-8e6de2954834

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124065446.3107=
248-1-Luo.Liu@cixtech.com?part=3D2
