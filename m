Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869A2C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B540310E121;
	Thu, 30 Jul 2026 20:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CXSjjoqS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2771010E121
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:40:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3EDFD6001D;
 Thu, 30 Jul 2026 20:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8341F000E9;
 Thu, 30 Jul 2026 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785444026;
 bh=F95C80Tak7G6nyW1+tbl9Ya2tTotlK2In8QFGDAZP0s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CXSjjoqSUHbkRikCSrQdqEIsq/KWOspOfY9UTOq3LMSjn9dwtn+CjPz+vefJTpIR1
 tI+RcDWdNwCGSUPsbS1iu2MjdcZsV2daOZFV7C/GmTcNhf+LoytQa91K9w+iTnHdtV
 /aHxXnPtDZLjtUv3cz4j7bFc46L1Gu1QFpxSoqRaGAgzPgntbKC/5jBnTrYcq2lLzR
 rlOUhjBYqoyKfofM+EWHfdMwdTIqBmlcnkueME9gq2MRzb0PIg/Vuly0dx6VEa4sj2
 a4owcwsaftUha9fCuhvPq1tmZhUCITIKTcIoeSMDYXgREo1AjmyPsuc13GntXwPErM
 kFW8VqbgmFFSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] drm/nouveau: Fix cleanup bug in
 nouveau_drm_device_new()
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730203015.1572240-2-lyude@redhat.com>
References: <20260730203015.1572240-1-lyude@redhat.com>
 <20260730203015.1572240-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:40:26 +0000
Message-Id: <20260730204026.BC8341F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch erroneously changes the success return value of `nouveau=
_drm_device_new()` from returning the allocated `drm` struct pointer to ret=
urning `0`. In C, returning `0` in a pointer context evaluates to a NULL po=
inter, which bypasses `IS_ERR()` checks in callers and leads to an immediat=
e kernel panic upon dereference.
--

--- Patch [1]: [PATCH v3 1/5] drm/nouveau: Fix cleanup bug in nouveau_drm_d=
evice_new() ---
commit 764ec8f5aa922a913d49de424c5e71dadb787207
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau: Fix cleanup bug in nouveau_drm_device_new()

This patch refactors the error handling in nouveau_drm_device_new() to avoid
freeing an error pointer if the DRM device pointer allocation fails. It rep=
laces
the single done label with specific error labels for different cleanup path=
s.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 4d1ad718e09b7..3dfe21cd4bde4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
[ ... ]
> @@ -762,39 +762,43 @@ nouveau_drm_device_new(const struct drm_driver *drm=
_driver, struct device *paren
[ ... ]
>  	ret =3D nvif_mmu_ctor(&drm->device.object, "drmMmu", mmus[ret].oclass, =
&drm->mmu);
>  	if (ret) {
>  		NV_ERROR(drm, "MMU allocation failed: %d\n", ret);
> -		goto done;
> +		goto err_device_del;
>  	}
> =20
> -done:
> -	if (ret) {
> -		nouveau_drm_device_del(drm);
> -		drm =3D NULL;
> -	}
> +	return 0;

[Severity: High]
Does returning 0 here evaluate to a NULL pointer since the function's return
type is a pointer to struct nouveau_drm?

Callers like nouveau_drm_probe() check the return value using IS_ERR():

drivers/gpu/drm/nouveau/nouveau_drm.c:nouveau_drm_probe() {
	...
	drm =3D nouveau_drm_device_new(&driver_pci, &pdev->dev, device);
	if (IS_ERR(drm)) {
		ret =3D PTR_ERR(drm);
		goto fail_nvkm;
	}

	ret =3D nouveau_drm_device_init(drm);
	...
}

Because IS_ERR(NULL) is false, the error check is bypassed. The NULL pointer
is then passed to nouveau_drm_device_init() where it is immediately
dereferenced:

drivers/gpu/drm/nouveau/nouveau_drm.c:nouveau_drm_device_init() {
	struct drm_device *dev =3D drm->dev;
	...
}

Could this lead to a kernel panic during device probe? Should this return t=
he
allocated drm pointer instead of 0?

> +
> +err_free_drm:
> +	kfree(drm);
> +
> +	return ERR_PTR(ret);
> +
> +err_device_del:
> +	nouveau_drm_device_del(drm);
> =20
> -	return ret ? ERR_PTR(ret) : drm;
> +	return ERR_PTR(ret);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730203015.1572=
240-1-lyude@redhat.com?part=3D1
