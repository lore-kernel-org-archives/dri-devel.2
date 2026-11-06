Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34990606A338
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+kr5/q+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766FE1124F8;
	Fri,  6 Nov 2026 15:25:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 977351124F8
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:24:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A2A7414A1
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EF01F0089F;
 Fri,  6 Nov 2026 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793978698;
 bh=DbSPWuPLN0bxRLrS6+EC4jPqjR+kLvl0toaoFXAPehQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y+kr5/q+H+NzaNg9rAHNF6m/I+Mod937evcdPm4KncKnOJ8EER57c32dqOlhTBG4y
 dmpdMuFodoBQ8C24LSTHS/Xy33M3TdlsE+yWA0bbS14ZMyK+sWMJUxy0ZSDbCmWDOK
 7+KB6yYdSA1LGoZ9PiNM+gEQV/Og+t+riwIAeH+IwCjqSAizaJcwwr6XAOGDyeQOqE
 bZ2AU2zMgmMS0jVA2Pd1dyo1ia/fEDIGWup2XylR4I4+QACBBxrxo1x4GO0hKYqLfW
 r8wvNmPBI8X/PeIrKMdE2lPDmzHPqIPk761dy6Bz9CFeafcKfoAzEAF3tDJNCuScZ6
 6R9bc1l4QqYDg==
Message-ID: <sashiko-outbox-201688@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/7] drm/lease: Add a helper to tell whether a lease
 was revoked
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-reset-state-flag-v8-3-50fd046b705f@kernel.org>
References: <20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org>
 <20261106-drm-reset-state-flag-v8-3-50fd046b705f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:24:57 +0000
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
- [Medium] drm/lease: false revocation report for empty leases in
  drm_lease_revoked()
--

commit 15b02cb8a3b3d4a5372c96b45134239f8d815a69
Author: Maxime Ripard <mripard@kernel.org>

drm/lease: Add a helper to tell whether a lease was revoked

This commit adds drm_lease_revoked() to check whether a drm_file's lease
has been revoked by testing if its master->leases IDR is empty.

> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index 5d2cf724cbd7b..dd59df14dcc02 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
> @@ -147,6 +147,32 @@ bool drm_lease_held(struct drm_file *file_priv, int =
id)
>  	return ret;
>  }
> =20
> +/*
> + * Checks whether the file is a lessee whose lease has been revoked. A
> + * lease is always revoked as a whole, so an empty one has been revoked.
> + */
> +bool drm_lease_revoked(struct drm_file *file_priv)
> +{
> +	struct drm_master *master;
> +	bool ret =3D false;
> +
> +	if (!file_priv)
> +		return false;
> +
> +	master =3D drm_file_get_master(file_priv);
> +	if (!master)
> +		return false;
> +
> +	if (master->lessor) {
> +		mutex_lock(&master->dev->mode_config.idr_mutex);
> +		ret =3D idr_is_empty(&master->leases);
> +		mutex_unlock(&master->dev->mode_config.idr_mutex);
> +	}

[Severity: Medium]
Does drm_lease_revoked() falsely report valid empty leases as revoked?

Since 4bb2d367a5a2 ("drm/lease: allow empty leases"),
drm_mode_create_lease_ioctl() permits creating a lease with
object_count =3D=3D 0, which leaves master->leases empty from creation.
Callers of drm_lease_revoked() will treat any such unrevoked empty lease
as revoked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-reset-=
state-flag-v8-0-50fd046b705f@kernel.org?part=3D3
