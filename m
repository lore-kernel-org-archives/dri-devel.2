Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0664606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzMeAW77
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110FF891AA;
	Mon, 16 Nov 2026 10:30:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627EC891AA
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:30:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28EF562884
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F2C1F000C4;
 Mon, 16 Nov 2026 10:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825013;
 bh=wSpKswCumLXRzMy4DetbCUxzkDWVDNtWP05JDYUhsow=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VzMeAW7724Oemf6ZPfCMt6GxSbXmtABfXC6srQnsHgUZG3Z7TxT1n19UumsutBt3o
 2fCm3w7kk2cRlgQnfZUXue36oW0piTboKzEjZxX6Fie4xSnQsm5wTTEYudPFmDt7jd
 GihJeQJjejdSXlMCT7kkP8idZZ/3f8uVns2QgSdRdCQk7ot0NuyY6OBsEG71gVwTZ9
 JNGWaZIteqCMZq7HukfQtbaYOjg/z4twQsUGgcOmQgI0yFFASk31YqOwN91hsouWo2
 p7tUNAM9OnNH58Yev7qWu8orxazePB+yKP/jMUyuVxtqHEVYDANkG3wrA9J264fIuz
 hgLWM1BUoPFrQ==
Message-ID: <sashiko-outbox-216737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/9] drm/lease: Add a helper to tell whether a lease
 was revoked
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-drm-reset-state-flag-v11-1-378b3f7bef32@kernel.org>
References: <20261116-drm-reset-state-flag-v11-0-378b3f7bef32@kernel.org>
 <20261116-drm-reset-state-flag-v11-1-378b3f7bef32@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:30:13 +0000
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
- [Medium] drm/lease: drm_lease_revoked() falsely reports empty leases
  as revoked
--

commit 607dbf11bac99a263d86d7f9e9dbfe6aff207269
Author: Maxime Ripard <mripard@kernel.org>

drm/lease: Add a helper to tell whether a lease was revoked

This commit adds drm_lease_revoked() to check whether a drm_file belongs
to a lessee whose lease has been revoked.

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
> +
> +	drm_master_put(&master);
> +	return ret;
> +}

[Severity: Medium]
Does drm_lease_revoked() falsely report an active empty lease as revoked?

Since commit 4bb2d367a5a2 ("drm/lease: allow empty leases"),
drm_mode_create_lease_ioctl() permits creating a lease with
object_count =3D=3D 0, leaving master->lessor set and master->leases empty =
on
an unrevoked lease.  Callers checking drm_lease_revoked() will treat valid
empty leases as revoked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-drm-reset-=
state-flag-v11-0-378b3f7bef32@kernel.org?part=3D1
