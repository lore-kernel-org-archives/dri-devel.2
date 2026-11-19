Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A0606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ipev03UY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0EE210E873;
	Thu, 19 Nov 2026 13:09:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5078010E873
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:09:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A0CA6144B;
 Thu, 19 Nov 2026 13:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD6A1F000C4;
 Thu, 19 Nov 2026 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795093759;
 bh=RvFktFRgXSo7v21l/GvdbZGNcGdeD6BixLtRrL++jBM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ipev03UYxVPYNmauoxFDF49AB2zuHHM1+e77fui6SOLrPROyizaTaVDLatOpcbn53
 g3TSGgjRdmaz+/U6/5fXnWJfR8F/9sdNmDaglyBXZw2/nZ2MCwO2Epz3nTmqlNiNlE
 AM9RXhNhyasLRNpWcmubyUMpBMS9gjjCCpJRdQ5wgj/wn36FXIoVd+9rOfmIIEpH4c
 NH6y/cqwk08g2wRhASL06HLaem81XD3M6nqyFpg18ZHu2swLIohxYqdU5iTS3HVeTX
 J1sZRozSln04DeZugLjCfO/5w5UnmpgS6e3F2qeMWT0383oXVmOyGhlKmgD1G60lir
 Q9VPpuvSzwmdg==
Message-ID: <sashiko-outbox-223149@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/vkms: count the composer users
To: "Oarora Etimis" <oaroraetimis@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-composer-v2-1-a935e9bae6be@gmail.com>
References: <20261119-composer-v2-0-a935e9bae6be@gmail.com>
 <20261119-composer-v2-1-a935e9bae6be@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 13:09:18 +0000
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
- [Medium] drm/vkms: race on *held in vkms_composer_get() and
  vkms_composer_put()
--

commit f7732cf6eed7c5182c5ed8c82b94f91369a6ef0b
Author: Oarora Etimis <oaroraetimis@gmail.com>

drm/vkms: count the composer users

This commit replaces the single composer_enabled boolean with a reference
count of active composer users and per-user hold flags so CRC capture and
writeback jobs do not disable the composer for each other.

> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 0fc915a954bad..24b8436eaa74d 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -711,19 +711,39 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, c=
onst char *src_name,
>  	return 0;
>  }
> =20
> -void vkms_set_composer(struct vkms_output *out, bool enabled)
> +void vkms_composer_get(struct vkms_output *out, bool *held)
>  {
> -	bool old_enabled;
> +	unsigned int users;
> =20
> -	if (enabled)
> -		drm_crtc_vblank_get(&out->crtc);
> +	if (*held)
> +		return;
> +
> +	if (drm_crtc_vblank_get(&out->crtc))
> +		return;
> +
> +	spin_lock_irq(&out->lock);
> +	*held =3D true;
> +	users =3D out->composer_users++;
> +	spin_unlock_irq(&out->lock);
> +
> +	/* All users share a single vblank reference. */
> +	if (users)
> +		drm_crtc_vblank_put(&out->crtc);
> +}
> +
> +void vkms_composer_put(struct vkms_output *out, bool *held)
> +{
> +	unsigned int users;
> +
> +	if (!*held)
> +		return;
> =20
>  	spin_lock_irq(&out->lock);
> -	old_enabled =3D out->composer_enabled;
> -	out->composer_enabled =3D enabled;
> +	*held =3D false;
> +	users =3D --out->composer_users;
>  	spin_unlock_irq(&out->lock);
> =20
> -	if (old_enabled)
> +	if (!users)
>  		drm_crtc_vblank_put(&out->crtc);
>  }

[Severity: Medium]
Can concurrent calls to vkms_composer_get() and vkms_composer_put() race on
*held because it is checked outside out->lock and not re-checked after taki=
ng
the lock?

In drivers/gpu/drm/drm_debugfs_crc.c, crtc_crc_release() clears crc->opened
and drops crc->lock before calling crtc->funcs->set_crc_source(crtc, NULL),
while crtc_crc_open() sets crc->opened and drops crc->lock before calling
crtc->funcs->set_crc_source(crtc, crc->source).  Two tasks opening and
closing the CRC debugfs file can therefore call vkms_set_crc_source()
concurrently with &out->composer_crc_hold:

CPU0                                  CPU1
crtc_crc_release()
  crc->opened =3D false
  vkms_set_crc_source(..., NULL)
    vkms_composer_put()
      if (!*held) [false]
                                      crtc_crc_open()
                                        vkms_set_crc_source(..., "auto")
                                          vkms_composer_get()
                                            if (*held)
                                              return;  <-- skips get
      spin_lock_irq(&out->lock)
      *held =3D false
      users =3D --out->composer_users
      spin_unlock_irq(&out->lock)
      drm_crtc_vblank_put(&out->crtc)

This leaves the newly opened CRC reader active with composer_users =3D=3D 0=
 and
vblanks disabled.  Two concurrent puts or gets can likewise both pass the
unlocked check and double-decrement or double-increment out->composer_users,
underflowing the counter or leaking a composer and vblank reference.

Re-checking *held under out->lock (and dropping the vblank reference in
vkms_composer_get() if *held became true in the meantime) would avoid the
race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-composer-v=
2-0-a935e9bae6be@gmail.com?part=3D1
