Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9FE606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GfSkgKrg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E332110E289;
	Sat,  7 Nov 2026 01:32:43 +0000 (UTC)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B3D10E289
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 01:32:37 +0000 (UTC)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2e9d7791b00so8640895ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 17:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794015157; x=1794619957;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o0tyMpLVRGMz/SfqbWAZq6acOJWNHMe+7Y+AOuq26s4=;
 b=On5UlDa5Q5/sdaxSrt/Yl6dambfvZyS8MuM12ckkzcis3dCvFbBLL+4dgvHoQAClgV
 rfKtD7i7JeT7gOnPGsDMOTMhcjrkjBYbuKXi4Jwo0+F880ApjSLnsghEqSJXVW8QE4hW
 Gr6rHVeCZMhLI1FXG++BvS8hcmBZm1RfZ1diVRU0CUe/o7hQ3cFIYIUH+tjXHNKD7CrU
 EUSyjQrGFuF1bWtWK2G4y7x0PGopnsOC8kekKTNAbYGxOhx+p8vJyQHmYcr4e7W/jseQ
 6NHXMuLIQAd501Y5v3e8UQ+UkjL0rKVngBSW3CKCGew3WtsI1q21zBhI/5Or/0AvkUBg
 /iYA==
X-Forwarded-Encrypted: i=1;
 AL+hErHE3dkHVfWWpIB7ZiIhd0uB9rooArdqq4kmfi8TfSniYHnLnULtTW4isJ/caPONPKpISLaQ8zWO/B4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z83hbThAgiTBjm3ODE9wxCd2A1XUx1pwxmnDH5jS2UXoTyKom/2
 7gQe9aV1m7xxo+GUBscIzyduFQWUSO5qwYfWnVWNL6+aMVMwgjMapNsMf1qFjGRhPHIISpwvNrw
 yGiMdnLGp31GYrXjKTzkVmdY8aUYN8kjoAypOFqH6YCcFmliDnDzUEg70vDs7amz6ndZihCMB8N
 R5UQDnp1uxnQQiiACjPO0VpMyi8NirX0mo9iehLxdkBfeIGOqVwNPA/U3aArsO7EAy+r+UACen6
 CF12bJ0ryBkIhNyPyR9
X-Gm-Gg: AYBFou3juXz3vQbjl87XGHpZG/k3SMA/qmOylsE719SJRJc6nzx45YjnwLXeU84xR8R
 hXSpAOlO8MfG/M2jcS4/XE3Z0+SxKOnGg6e1UFEzqLeTGE5YySNRH431tUL97kkCMNr03HijBWj
 wldISzfBAVjnGFiJeyF+a2ETpD/rDZ7qTvxy0jWKDRmhtsmoioantp0ITHLXNPW6wbv8JqlDTI8
 JzRyqF2SwB5WKf3i8qcqkh554ZJ/koV/QHftPECe9416rbRUVj21voe0tzAgE+oN9Hz92fXytEl
 FqUiuZFE6j00mcj7S4tWU1yVTZpTvbWoV8AF0kCRUJqJrt/mycBF0amkra61versG0CK2bSvXvj
 /l8xpzvJ6BUwwI0XfcUHZtMBxqpO0t5axvPvKUvHToaiastwvl5J9lqv2gNYQpUHj1bNZ0lLhGc
 gdWhsb5xThCNL5DFBGNRdF5V8EEW8M0JcF
X-Received: by 2002:a17:90b:270e:b0:3b0:ac2c:1619 with SMTP id
 98e67ed59e1d1-3b0db70a2b5mr3984814a91.39.1794015157260; 
 Fri, 06 Nov 2026 17:32:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b1057da2c5sm599646a91.4.2026.11.06.17.32.36
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Nov 2026 17:32:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5bfd95238e3so133064e87.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 17:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794015155; x=1794619955;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o0tyMpLVRGMz/SfqbWAZq6acOJWNHMe+7Y+AOuq26s4=;
 b=GfSkgKrgrJ4WyIF+YQuqv5P5dI7UVMmyxJwtTSASbBVXXyiasQfggpfK8ww6zFPH7s
 QaKZjFLVTx335hFlnlMLj1585uV6enNtD0W8FV5pzDqaFpbzszul2tnm+NB9rJCZq2s8
 iMtRECFXsFEvUg26gi6e+pLoCQ/C7IRqR/F0Y=
X-Forwarded-Encrypted: i=1;
 AL+hErHey1+WOqWZR0QiIXpJah6pMBYQ6eeZylgeQxc/sT37aAfytUACjwPDc+09MEz/aEgi/gjGSMl8+PY=@lists.freedesktop.org
X-Received: by 2002:a05:6512:1585:b0:5c0:1c6:69ee with SMTP id
 2adb3069b0e04-5c00b609da4mr138120e87.4.1794015154794; 
 Fri, 06 Nov 2026 17:32:34 -0800 (PST)
X-Received: by 2002:a05:6512:1585:b0:5c0:1c6:69ee with SMTP id
 2adb3069b0e04-5c00b609da4mr138118e87.4.1794015154255; Fri, 06 Nov 2026
 17:32:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-81-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-81-1f58d1e33380@kernel.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 6 Nov 2026 20:32:22 -0500
X-Gm-Features: AclHuK82P0H9PYI848O6qIh9OVQqrPdudm2dMansQX7WHTGnvbQX4fRyp21QPwo
Message-ID: <CABQX2QMg=Jybnpe+06uS8YX5nph4KJt=vUVu-49e+kXM8-0thg@mail.gmail.com>
Subject: Re: [PATCH RESEND 81/83] drm/vmwgfx: Switch to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000000d6156065fa5b42d"
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000000d6156065fa5b42d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 10:35=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>
> Switch to drm_mode_config_create_initial_state().
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  | 4 +++-
>  drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c | 4 +---
>  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 4 +---
>  3 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_ldu.c
> index 0dea09cc29a7..93d755b81887 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> @@ -568,5 +568,7 @@ int vmw_kms_ldu_init_display(struct vmw_private *dev_=
priv)
>         dev_priv->active_display_unit =3D vmw_du_legacy;
>
> -       drm_mode_config_reset(dev);
> +       ret =3D drm_mode_config_create_initial_state(dev);
> +       if (ret)
> +               goto err_free;
>
>         return 0;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_scrn.c
> index 39d58fc392bf..82fe7db26633 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> @@ -940,7 +940,5 @@ int vmw_kms_sou_init_display(struct vmw_private *dev_=
priv)
>         dev_priv->active_display_unit =3D vmw_du_screen_object;
>
> -       drm_mode_config_reset(dev);
> -
> -       return 0;
> +       return drm_mode_config_create_initial_state(dev);
>  }
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_stdu.c
> index b505f8ba3e83..80defd735813 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> @@ -1709,6 +1709,4 @@ int vmw_kms_stdu_init_display(struct vmw_private *d=
ev_priv)
>         }
>
> -       drm_mode_config_reset(dev);
> -
> -       return 0;
> +       return drm_mode_config_create_initial_state(dev);
>  }
>
> --
> 2.55.0
>

Hi, Maxime.

Sashiko is right that this is not ideal. To be fair that code just
doesn't have recovery paths so if you'd like to just add a /* FIXME:
recover in case of an error */ for the code in vmwgfx_scrn.c and
vmwgfx_stdu.c then we can handle the rest.

z

--0000000000000d6156065fa5b42d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFNk
iwLAyF++qHxpH5d8YCIJXH/mWVTzf1jaVQWMeAJUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTEwNzAxMzIzNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAB+eSYaq45V+9TPGzqBV1XnNuB72h7tig+vPHVvd
t7kXDIqR+GmXJ+QRW2jBHNvVTIKHPzsXA7YGvZA5QZixQXjfqo644jG72xxoZnP4QjdTdOrqr2K6
4wXTfcJcc454lMVAnfULC/i8uido7dClR0N/pJYRBN9gmeaxfvcKzHlgVeUyZb0yb46ogR4ZveCU
bXP8+z87VsoQbBRUxc7bx3jnqLXLUxjeotAMMRQE4hwOsyBb6dJWdCvNQQg4DjSNzJHkLUzn1SvS
P41T9XWcjF6h5F4Kw9Vw9Wng2nUysFKK9tL7wm0WHEiPEX5kaa+nDoTo/37g3NFpWNqmuVvwROc=
--0000000000000d6156065fa5b42d--
