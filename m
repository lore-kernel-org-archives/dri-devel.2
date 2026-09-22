Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0177AC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2B210E7DA;
	Tue, 22 Sep 2026 05:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n+jfLWWH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F96410E7DA
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:49:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 66A346020F;
 Tue, 22 Sep 2026 05:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88841F00893;
 Tue, 22 Sep 2026 05:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790056160;
 bh=dWKyjSWb3KAKCTZjbpe5dmRoEOAE0Xq6Vw47SmujzM8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n+jfLWWHj6JD/55B0gfQQ9JwzbrB9Es4sJKU/EcWbtKijMtUqqfUB26MYUtz4zHFa
 7MoIU2zfymppV1l481cPPcuLVdQPT+2vfwBCJwKuX/UzdXzEC/4LYlvh55CrXYIMC3
 rKQGZuQ3p5lqCS7fnG/q1z1xpVGQf/q+kNHdyY/+IuKGw8gE8nmISKOhFx0/pkSX9W
 e1NnrVV82aEm+xXbYQnjfh+6z0GOVU2qkJTwVcMnQiM2Ia6AYerkM8D0EhLlJK6ae3
 RwuPP/yrXVPb2Sx2T0n1kumNfx1bMLIbsl866cVOcnvO6XfhuaxO2GET3Bzn5jzeUG
 fZ2VEFRt0CQsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/imagination: Fix parameter validation in
 pvr_fw_object_destroy()
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922-fix-null-pointer-dereference-v3-1-f099763ed676@imgtec.com>
References: <20260922-fix-null-pointer-dereference-v3-1-f099763ed676@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 05:49:19 +0000
Message-Id: <20260922054919.E88841F00893@smtp.kernel.org>
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
- [High] drm/imagination: memory leak of fw_obj on allocation error path
--

commit f0dd8a6ab034ccbc4cdc49ac4cbb537593b10a6d
Author: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: drm/imagination: Fix parameter validation in pvr_fw_object_destroy=
()

This patch attempts to fix a possible NULL pointer dereference in
pvr_fw_object_destroy() when handling allocation failures in
pvr_fw_object_create_and_map_common() by returning early.

Link: https://lore.kernel.org/dri-devel/20260810132202.3C16D1F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagi=
nation/pvr_fw.c
> index 850a3ec8e7750..9977f4da3d8d7 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw.c
> @@ -1429,6 +1429,12 @@ void pvr_fw_object_destroy(struct pvr_fw_object *f=
w_obj)
>  	struct drm_gem_object *gem_obj =3D gem_from_pvr_gem(pvr_obj);
>  	struct pvr_device *pvr_dev =3D to_pvr_device(gem_obj->dev);
> =20
> +	if (!fw_obj)
> +		return;
> +
> +	if (!fw_obj->gem)
> +		return;

[Severity: High]
Does this code leave the original NULL pointer dereference unfixed?

Since the local variables gem_obj and pvr_dev are declared and initialized
before these new early returns, fw_obj and fw_obj->gem are implicitly
dereferenced by accessing gem_obj->dev before the check is ever reached.
If either is NULL, an oops will still occur at the start of the function.

[ ... ]

> @@ -1439,8 +1445,7 @@ void pvr_fw_object_destroy(struct pvr_fw_object *fw=
_obj)
>  			return;
>  	}
> =20
> -	if (fw_obj->gem)
> -		pvr_gem_object_put(fw_obj->gem);
> +	pvr_gem_object_put(fw_obj->gem);
> =20
>  	kfree(fw_obj);

[Severity: High]
Could the early return added above cause a memory leak regression?

In pvr_fw_object_create_and_map_common(), if pvr_gem_object_create() fails,
fw_obj->gem is set to NULL and the error cleanup path calls
pvr_fw_object_destroy().

The new early return for !fw_obj->gem skips this kfree(fw_obj) at the end of
the function, permanently leaking the firmware object structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-fix-null-p=
ointer-dereference-v3-1-f099763ed676@imgtec.com?part=3D1
