Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E0606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImQqGyiH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A0D211219D;
	Thu, 19 Nov 2026 08:48:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9AF10E535
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:48:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A912C60F8B;
 Thu, 19 Nov 2026 08:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420471F000C4;
 Thu, 19 Nov 2026 08:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795078094;
 bh=XCR/KyRArRdCf7jfxW7SPyXEaCl5rSr3iytbdV5GvDQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ImQqGyiHMhaIREcTJfGmchQOhIbkVH7hzRPjzWExoniJbIOZn15AoIfZXIzdT1hWf
 AWcbkp3bSQ3/EEda3LPRp+IKdZQ9wlUUYUXaeOp9/p1pLZZeESP1q8vsfq2bBXtYki
 UKR0zrVM5AQYpwTs5CU/8SVlESNkmZtJH4TzZ9rHFQO0R8RbkgHyPHGIWHagbzISx/
 zuSFkQ6jzBtxtgGl5H01UpWU7uly8woou6KWxp8IVap8DB4q4UWFySBh7IQUH4J+Gn
 SdIyDkdEDVYyV1S8w5dT2mRs3y90G0fEzboHQDb0AF9sucmYrZUFKn0hCy+FqN4in6
 OGxDmQjR5/B2g==
Message-ID: <sashiko-outbox-222715@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/2] drm/msm: release the cursor flip work before
 the KMS is torn down
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119083133.3437277-1-shunsheng1218@gmail.com>
References: <20261119023604.1495603-1-shunsheng1218@gmail.com>
 <20261119083133.3437277-1-shunsheng1218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:48:13 +0000
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
- [Medium] drm/msm/mdp4: mdp4_kms->dev dereferenced before NULL check in
  mdp4_destroy()
--

commit 26c33f96a5c574b9e64b260a7b6a74a4cfcc0b65
Author: Yaohan Li <shunsheng1218@gmail.com>

drm/msm: release the cursor flip work before the KMS is torn down

This commit releases the DRM-managed cursor flip work cleanup action from
mdp4_destroy() and mdp5_kms_destroy() before the KMS VM is destroyed.

> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/m=
sm/disp/mdp4/mdp4_kms.c
> index ab7b62381685f..3fd528eeff0e3 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> @@ -136,6 +136,19 @@ static void mdp4_destroy(struct msm_kms *kms)
>  {
>  	struct mdp4_kms *mdp4_kms =3D to_mdp4_kms(to_mdp_kms(kms));
>  	struct device *dev =3D mdp4_kms->dev->dev;
> +	struct drm_crtc *crtc;
> +
> +	/*
> +	 * Release the cursor flip work while the VM is still alive.  The
> +	 * cleanup is registered as a DRM-managed action, so it would only run
> +	 * at the final drm_dev_put(), long after drm_gpuvm_put() below has
> +	 * destroyed the VM that unref_cursor_worker() needs.  The interrupts
> +	 * and the KMS workqueue have been stopped at this point, so no new
> +	 * cursor update can be queued any more.
> +	 */
> +	if (mdp4_kms->dev)
> +		drm_for_each_crtc(crtc, mdp4_kms->dev)
> +			mdp4_crtc_release_flip_work(crtc);

[Severity: Medium]
Can the new NULL check on mdp4_kms->dev ever protect against a NULL
mdp4_kms->dev when mdp4_kms->dev->dev is dereferenced right at the top of
mdp4_destroy()?

In mdp4_kms_init(), mdp_kms_init() -> msm_kms_init() sets kms->funcs before
mdp4_kms->dev is assigned, so if msm_kms_init() fails afterwards,
msm_drm_kms_uninit() calls mdp4_destroy() with mdp4_kms->dev =3D=3D NULL and
triggers a NULL pointer dereference before reaching the new guard (while
dev is only used later under if (mdp4_kms->rpm_enabled)).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083133.3437=
277-1-shunsheng1218@gmail.com?part=3D1
