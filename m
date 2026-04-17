Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522F1F8E4A8
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 04:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52B710E288;
	Fri, 17 Apr 2026 04:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XBxu5kJg";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5FA10E288
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 04:14:25 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8cb40149037so24343085a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 21:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776399264; x=1777004064; darn=lists.freedesktop.org;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=a468MN7UsQMQWAWWNfaFLFFyb4yh3JFzHFjkNyCLcng=;
 b=XBxu5kJgP8GzVQ72G3uaMmdrbPcLTjf8q5uDEmsf7ioeYU2NqfC/kXJrQgujLABKgf
 N9211rQaekDt1rGwSnir0QpOHdy8FKvVi8zhCQWnomWVXUvf9aO9KLubW2/OMVKjR9md
 mMtxRWi7f+Yqq4MdobEdEmd0G5RE7/kDfaAVgAFEyIDhQd91jYttUUQSLgDhKeV7xc5u
 RZlZLKeNtlF6ifDJGbEgTYAZBFO12b/VQtlu234EGGpqZEiRxE7Q3gzdgewZb8Cas53W
 9olMEL6hJeFoUrYs7W8ps95qtPqGshVwzzX8seAbIfkv+A/YZH+mzyklXjFkupGjAtNW
 Cd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776399264; x=1777004064;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a468MN7UsQMQWAWWNfaFLFFyb4yh3JFzHFjkNyCLcng=;
 b=WkAeKP3bch8gDkW4DdC7coqilIflicLdj5y1ZwXGGxqzHTw9jCn1edwT/BQ/Z/iW56
 uWn4BUSj+fvgx+Ao6qZm7ZoAOx96dSBFdWbSmQyF1hTcH407nCybJwRG4B0pQ7n0/qO7
 0sWvVVypd6qipElVzM9rnY/aSCLNW5JAc8iwCnCgp/+BKvAlAk3tbJCSNcgldhRKMRxB
 cKXAFA03xCpbFMxEuRNesdP+V7ebQVaxsSenZb4bkj3svowjfiHe/ELfmDb3cwMxsHAK
 JcZrsMhE/amyqkus5Paq1mbq7QXGswwVf7NtU9LITaWmEs9xwyTyysPqZ/Td/CIbvDel
 27Kw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3GB4IQzYc68jn9zOxbTSDeHLw7RtSw4n7ZviuWQvWQXBDjL/ZS9Vy2y025DT/91uzt+HtUsayqhI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywbnn6ZbGJiM4EKFHAbkJt1YGhCvnBhgDxd2L3UApLBn7XV5xXj
 vqj0Cqz20MIGDxkO8AHrKNC4N9wcnVUAaox2d4Zp8hJpqc4n+1LmCAiv
X-Gm-Gg: AeBDiesqTDO+naW7sufzMfW4VkXTKmXNIZL4DTzmctbPlz5646aq5yfw0Mw25aE5I9T
 pJS0aVZPFdkQ1xbRilnyLb528GFSnJ+O6fDUUHVp+zQXclpNxUkhFLT4xlLi4AaGizqvDnit6tg
 4TE7JUgSrA+ckDF6dkL55En8osqxLbh3KHJdSQklHm3fVu+6cfr46aGqlSALmI3PsbO2003eXkq
 My2zUqWJLEAEjocgA9ul2ki/Vzl+M4U11BCWTzguYq9x4bLlYeNEqD7hL7RRgOunY1VJzagduVy
 JZMv4QeIKPeSn4wuEj8mBExG1uClh01LrYvGr7m/sO2g4EUgHBh+Ae+7KGzVgDxBh2de23yVUYg
 A9pyCgelRBNdr7jihoVFbS9MPl7f72F+PAJOf+/pPc6d0VogScwNsXel9W+KFvvasklDjlIO9Cv
 D9Qd5uei0o4H/MAInyuO1hRxG09C7uyRFgmIgzHpf33lTHIBek
X-Received: by 2002:a05:620a:710b:b0:8cf:eafc:b7c with SMTP id
 af79cd13be357-8e79246c68amr158252285a.41.1776399264121; 
 Thu, 16 Apr 2026 21:14:24 -0700 (PDT)
Received: from [192.168.2.25] ([184.146.175.99])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5febde5sm22867685a.4.2026.04.16.21.14.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 21:14:22 -0700 (PDT)
Message-ID: <7a3eac3d-d44b-48db-af68-c5f0087a8ac2@gmail.com>
Date: Fri, 17 Apr 2026 00:14:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101
 Thunderbird/136.0
Subject: Re: [PATCH] drm/auth: Only drm_drop_master if it exists
To: Jonathan Cavitt <jonathan.cavitt@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmerman@suse.de, airlied@gmail.com, simona@ffwll.ch
References: <20260416210047.3904106-1-jonathan.cavitt@intel.com>
Content-Language: en-CA, en-US
From: Luben Tuikov <ltuikov89@gmail.com>
Autocrypt: addr=ltuikov89@gmail.com; keydata=
 xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1APnbnnRHN
 Ikx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoAQRYhBJkj7+VmFO9b
 eaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheA
 AAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlTMqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfy
 JwktF7REl1yt7IU2Sye1qmQMfJxdt9JMbMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSP
 cCE8uGe7FWo8C+nTSyWPXKTx9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl
 10wVR5QxozSvBQJlOiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKo
 aMDzO9eGz69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA==
In-Reply-To: <20260416210047.3904106-1-jonathan.cavitt@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eGCYUJsiqbjrkWPuTj7xBSVH"
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------eGCYUJsiqbjrkWPuTj7xBSVH
Content-Type: multipart/mixed; boundary="------------80IG00mtfce8l4iguWXcf60q";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Jonathan Cavitt <jonathan.cavitt@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmerman@suse.de, airlied@gmail.com, simona@ffwll.ch
Message-ID: <7a3eac3d-d44b-48db-af68-c5f0087a8ac2@gmail.com>
Subject: Re: [PATCH] drm/auth: Only drm_drop_master if it exists
References: <20260416210047.3904106-1-jonathan.cavitt@intel.com>
In-Reply-To: <20260416210047.3904106-1-jonathan.cavitt@intel.com>

--------------80IG00mtfce8l4iguWXcf60q
Content-Type: multipart/mixed; boundary="------------qh8o00ewZwPUOnqao5LNfmQ6"

--------------qh8o00ewZwPUOnqao5LNfmQ6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2026-04-16 17:00, Jonathan Cavitt wrote:
> It is possible that both dev->master and file_priv->master are NULL whe=
n
> passed to drm_master_release, which would result in dev being passed to=

> drm_drop_master (as NULL =3D=3D NULL here).  This would result in a NUL=
L
> pointer dereference when passing dev->master to drm_master_put in
> drm_drop_master.
>=20
> Only call drm_drop_master if dev->master exists.  Also, make sure the
> original calling requirement is maintained (dev->master =3D=3D
> file_priv->master).
>=20
> This fixes a static analysis issue.
>=20
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> index e17bb0f1f9e0..e5013b870ba0 100644
> --- a/drivers/gpu/drm/drm_auth.c
> +++ b/drivers/gpu/drm/drm_auth.c
> @@ -347,7 +347,7 @@ void drm_master_release(struct drm_file *file_priv)=

>  	if (!drm_is_current_master_locked(file_priv))
>  		goto out;
> =20
> -	if (dev->master =3D=3D file_priv->master)
> +	if (dev->master && dev->master =3D=3D file_priv->master)
>  		drm_drop_master(dev, file_priv);
>  out:
>  	if (drm_core_check_feature(dev, DRIVER_MODESET) && file_priv->is_mast=
er) {

This is a good catch.

Acked-by: Luben Tuikov <ltuikov89@gmail.com>

--=20
Regards,
Luben
--------------qh8o00ewZwPUOnqao5LNfmQ6
Content-Type: application/pgp-keys; name="OpenPGP_0x4C15479431A334AF.asc"
Content-Disposition: attachment; filename="OpenPGP_0x4C15479431A334AF.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1A
PnbnnRHNIkx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoA
QRYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiIC
BhUKCQgLAgQWAgMBAh4HAheAAAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlT
MqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfyJwktF7REl1yt7IU2Sye1qmQMfJxdt9JM
bMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSPcCE8uGe7FWo8C+nTSyWPXKTx
9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJl
OiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKoaMDzO9eG
z69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA=3D=3D
=3DqCaZ
-----END PGP PUBLIC KEY BLOCK-----

--------------qh8o00ewZwPUOnqao5LNfmQ6--

--------------80IG00mtfce8l4iguWXcf60q--

--------------eGCYUJsiqbjrkWPuTj7xBSVH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCaeGzkgUDAAAAAAAKCRBMFUeUMaM0r4no
AQCNQRCa7yk0UYHIkBddv6B3zVm/fGmFJ+F3ykOma+BSTwD/eVDNMx7CdumavDwJwnKAY5uXt6Ba
iPXa1B6i76zPBw0=
=JU5P
-----END PGP SIGNATURE-----

--------------eGCYUJsiqbjrkWPuTj7xBSVH--
