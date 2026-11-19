Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1E606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGxp9l+4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78303112423;
	Thu, 19 Nov 2026 13:51:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D4F411241E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:51:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E54F1464F8;
 Thu, 19 Nov 2026 13:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D81E1F000CA;
 Thu, 19 Nov 2026 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795096273;
 bh=JWRE6KIh2MLp6l1HMxtZoUUJ4DKR4m5a1Xi7yYQ7jYg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WGxp9l+4Dso2bnq0R4JUN22mvLj4tFRj8tmto5GpB05GqosgTm61z9WYbZoucxnKV
 HQgzDRgHKFY8ASNAZPMk+pS408MXKLLDKJMT63OjlT1Z7FwEpzZ3ijXtVBh3zjGboK
 n/jCQKqUNCfs2q+qgHsXaCvgs1/TrHXlrz8sXWOrLeEsj5TXRF55VaKtGL/1F3Ab8S
 DI6EdtUsIZOLSXN5MJHWpu9fhvgERKpehLb8QKHX1p3FrUgGCF62/jTMQh34xGq0y7
 PqxcjYqkTAnfEZEjPpXmTgIesVJTvd0yBToZOrHAYhqjPZ/Trow+9ynwamEap2WcCl
 BjyL/2SD0whXQ==
Message-ID: <sashiko-outbox-223213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm/vkms: count the composer users
To: "Oarora Etimis" <oaroraetimis@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-composer-v3-1-dd470a820303@gmail.com>
References: <20261119-composer-v3-0-dd470a820303@gmail.com>
 <20261119-composer-v3-1-dd470a820303@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 13:51:10 +0000
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
- [Medium] drm/vkms: composer_users underflow in vkms_set_crc_source()
  on error
--

commit 22fc9fb8d10e80e408b96eee292c039a0d2a1b22
Author: Oarora Etimis <oaroraetimis@gmail.com>

drm/vkms: count the composer users

This commit replaces the boolean composer_enabled flag with a reference
count so that concurrent CRC capture and writeback jobs do not disable
the composer while the other is still active.

> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 0fc915a954bad..96c40eeeb61ba 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -711,19 +711,33 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, c=
onst char *src_name,
>  	return 0;
>  }
> =20
> -void vkms_set_composer(struct vkms_output *out, bool enabled)
> +bool vkms_composer_get(struct vkms_output *out)
>  {
> -	bool old_enabled;
> +	unsigned int users;
> =20
> -	if (enabled)
> -		drm_crtc_vblank_get(&out->crtc);
> +	if (drm_crtc_vblank_get(&out->crtc))
> +		return false;
> +
> +	spin_lock_irq(&out->lock);
> +	users =3D out->composer_users++;
> +	spin_unlock_irq(&out->lock);
> +
> +	/* All users share a single vblank reference. */
> +	if (users)
> +		drm_crtc_vblank_put(&out->crtc);
> +
> +	return true;
> +}
> +
> +void vkms_composer_put(struct vkms_output *out)
> +{
> +	unsigned int users;
> =20
>  	spin_lock_irq(&out->lock);
> -	old_enabled =3D out->composer_enabled;
> -	out->composer_enabled =3D enabled;
> +	users =3D --out->composer_users;
>  	spin_unlock_irq(&out->lock);
> =20
> -	if (old_enabled)
> +	if (!users)
>  		drm_crtc_vblank_put(&out->crtc);
>  }
> =20
> @@ -735,7 +749,10 @@ int vkms_set_crc_source(struct drm_crtc *crtc, const=
 char *src_name)
> =20
>  	ret =3D vkms_crc_parse_source(src_name, &enabled);
> =20
> -	vkms_set_composer(out, enabled);
> +	if (enabled)
> +		vkms_composer_get(out);
> +	else
> +		vkms_composer_put(out);
> =20
>  	return ret;
>  }

[Severity: Medium]
Can this underflow out->composer_users when vkms_composer_get() or
vkms_crc_parse_source() fails?

crtc_crc_open() drops crtc->mutex after checking crtc->state->active and
before calling set_crc_source().  If the CRTC is disabled in that window,
drm_crtc_vblank_get() fails and vkms_composer_get() returns false without
incrementing out->composer_users.  Because vkms_set_crc_source() ignores
that failure and returns 0, crtc_crc_open() succeeds and the matching
crtc_crc_release() later calls vkms_set_crc_source(crtc, NULL) ->
vkms_composer_put(), decrementing out->composer_users without a prior
increment.  This either wraps out->composer_users to UINT_MAX (leaving the
composer permanently active and causing later vkms_composer_get() calls to
drop their vblank reference immediately) or prematurely drops a concurrent
writeback job's composer and vblank reference.

Also, if vkms_crc_parse_source() returns -EINVAL, enabled is false and
vkms_set_crc_source() still calls vkms_composer_put().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-composer-v=
3-0-dd470a820303@gmail.com?part=3D1
