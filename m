Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5267606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WxzS+3rL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1266710E4AD;
	Tue, 17 Nov 2026 06:52:53 +0000 (UTC)
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com
 [74.125.224.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ACF810E4AD
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 06:52:46 +0000 (UTC)
Received: by mail-yx1-f100.google.com with SMTP id
 956f58d0204a3-67da3d03263so2238289d50.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794898365; x=1795503165;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dmR058pMTSnD1f4cwA1OVEWBbsoeJ+iroxiR5n40l1k=;
 b=FkOoleb1VwimCAotOCE641TzEU/eQPOfSF3vWmurUTa2Zg/EVRNBPC21hoVgPKWZ44
 yQAOYERoEDBajAuKQjK+czISumjWSu+Y9lkUphUpypC40cZKyu5RlsPTySdHi/RtC9FT
 CZ/Kf7Sok7EqNm8Z3B8L23p4zRwStvBENzEiSEU6Our3xqkskQRNYxK2WUwn24Z6aZzX
 /ZlrlddjJ201N09i6OHa1z7SgP4OFi/7L4dB5TBrHpIbnMyEKRR5fVRtKMFtVEU/1EHn
 06LeduvIjkiHwExTnDeV1eHSUOt0V4OaTNzMmjl7+57DJYt25CPALDcFrAsmVljjtcPc
 7vBg==
X-Forwarded-Encrypted: i=1;
 AL+hErGWm0gzP+mfEPkgsAVQZCbPsnNX0USls0VAJzTU54+vbi45YjFfrvonTqDAWnh4p7SWlcNR13q3W7I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+iDTeFV9p6WR8FC9S6ORNnCD8iF96wChMrm+Hqjq6o1gYxzywe
 o+wPYMGLgZvxUn48kOESQMZMHu49ERk4XcPYHe8V3tMfMqUvheIwi7lcrb4Qzm0eAVW5n19xQ2p
 0ftE4dXsr14vGl3+BysKbSaoVVmZbJhFFnhg75y4R1Fzoik0lMg9ZH0CXRdAUVIUuI6/1LzCYkR
 Rc0fUI0EZ5J0S2dCZBx8r4QNM9NlhlxX/ogHWbFT4q1WAp3591iWLOgsH7lQ+PlQULel+a1/y69
 eQZFCjCF3m9yJr4O088
X-Gm-Gg: AZFdTZeeBI+kj5pYAcXv680OD2qb+mJSONGdeQFwAVHTFn68YAb3shnL7z3bdbqEHP0
 UrjYfFg5flZAw0qhFZ8UKi0W/zZZVVYZG+UhkN93WqosN7aM+9O0c5usF1C8Bt+i/Koed+gqlM3
 gmhhYBbbdKFgaCM8YbrCcPXALHOSV4MVr6pz47NQ8N5TtvOpd43GzPvPkn901NeGErfD+Im19Fl
 zsPcoi6XOd/cGI2jZyiibCL+7krLpJowUw6l77SA5CBy2G1RRxx+q97Iz+ouHepTbJ4NXpECc+4
 V/03Mf1yobLXPmz8bxwbpsLhTORExaRvABdCnp62mH5fnnMYoThvsItUe4+Zb0pgGELwOePXg9D
 cQ2G4QcDWrbNVjxYk6F88dwnNqrtuuRoXp7HlkVODdkrVOEk/EsaDQZUIku1YsynncF+iDxyfA/
 jZkoc4jUg6DlEE7QGuTvpH80yfRA69e8dA
X-Received: by 2002:a05:690e:b81:b0:67d:b309:a247 with SMTP id
 956f58d0204a3-67db309a338mr2477934d50.81.1794898365211; 
 Mon, 16 Nov 2026 22:52:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-67db02d8450sm49022d50.36.2026.11.16.22.52.44
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 22:52:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3ad00533aa8so21645761fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794898363; x=1795503163;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dmR058pMTSnD1f4cwA1OVEWBbsoeJ+iroxiR5n40l1k=;
 b=WxzS+3rL68aQgKz6ItnMtUAiDSQ4YGtFCUO0nw6LJXcfw/1jDZcVerg0EtGA/+DbJv
 fdgLapprESpIMtuZo6pZkZwgBzV6mHA6GMlrlYO20xMMdBDTpbhm8bB6BIRKYy3QB9k2
 NmLOZiopucQemU0izAATnoKyaGf91Lsk/EKd0=
X-Forwarded-Encrypted: i=1;
 AL+hErF++uwzKqGaUCCMxgYyMcrq1j1y359gBhRbaPDcnFAxdao/662aeIEsw1U0fO+LEKgYDZ+CXkj5VyE=@lists.freedesktop.org
X-Received: by 2002:a05:651c:1b0f:b0:3ac:e26b:d9cc with SMTP id
 38308e7fff4ca-3ae2b4f84b8mr43653621fa.23.1794898362862; 
 Mon, 16 Nov 2026 22:52:42 -0800 (PST)
X-Received: by 2002:a05:651c:1b0f:b0:3ac:e26b:d9cc with SMTP id
 38308e7fff4ca-3ae2b4f84b8mr43653521fa.23.1794898362305; Mon, 16 Nov 2026
 22:52:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-62-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-62-0bb471f4d1e0@kernel.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 17 Nov 2026 01:52:29 -0500
X-Gm-Features: AclHuK-kXIOcUwwupPxBTeRWlbJM_wlK3F1baDvdX1RKf53fn_J_wXitXoXalss
Message-ID: <CABQX2QM+Q8nZkniGA-zQFtdiwAKuvHRWJz-he9qcnR-WAHoh-w@mail.gmail.com>
Subject: Re: [PATCH v2 62/64] drm/vmwgfx: Switch to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000058ee680660735793"
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

--00000000000058ee680660735793
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 5:34=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
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
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 14 +++++++++++++-
>  drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  3 ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |  3 ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  3 ---
>  4 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index 90ab9380d883..4924649033bb 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -1173,15 +1173,27 @@ int vmw_kms_init(struct vmw_private *dev_priv)
>         if (ret) {
>                 ret =3D vmw_kms_sou_init_display(dev_priv);
>                 if (ret) /* Fallback */
>                         ret =3D vmw_kms_ldu_init_display(dev_priv);
>         }
> +       if (ret)
> +               return ret;
> +
>         BUILD_BUG_ON(ARRAY_SIZE(display_unit_names) !=3D (vmw_du_max + 1)=
);
>         drm_info(&dev_priv->drm, "%s display unit initialized\n",
>                  display_unit_names[dev_priv->active_display_unit]);
>
> -       return ret;
> +       /*
> +        * Create the initial state once, after the display unit that wil=
l
> +        * be used has been settled on: a failure in one of the display
> +        * unit initialization functions is used as a fallback condition =
to
> +        * try the next one, and creating the state on a partially
> +        * initialized device would both leave the KMS objects of the two
> +        * backends on the same drm_device and trip WARN_ON() on the obje=
cts
> +        * that don't have a state.
> +        */
> +       return drm_mode_config_create_initial_state(dev);
>  }
>
>  int vmw_kms_close(struct vmw_private *dev_priv)
>  {
>         int ret =3D 0;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_ldu.c
> index 0dea09cc29a7..dd5ca4dc75e8 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> @@ -537,11 +537,10 @@ static int vmw_ldu_init(struct vmw_private *dev_pri=
v, unsigned unit)
>         return ret;
>  }
>
>  int vmw_kms_ldu_init_display(struct vmw_private *dev_priv)
>  {
> -       struct drm_device *dev =3D &dev_priv->drm;
>         int i, ret;
>         int num_display_units =3D (dev_priv->capabilities & SVGA_CAP_MULT=
IMON) ?
>                                         VMWGFX_NUM_DISPLAY_UNITS : 1;
>
>         if (unlikely(dev_priv->ldu_priv)) {
> @@ -565,12 +564,10 @@ int vmw_kms_ldu_init_display(struct vmw_private *de=
v_priv)
>                         goto err_free;
>         }
>
>         dev_priv->active_display_unit =3D vmw_du_legacy;
>
> -       drm_mode_config_reset(dev);
> -
>         return 0;
>
>  err_free:
>         kfree(dev_priv->ldu_priv);
>         dev_priv->ldu_priv =3D NULL;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_scrn.c
> index 39d58fc392bf..291e24456d06 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> @@ -921,11 +921,10 @@ static int vmw_sou_init(struct vmw_private *dev_pri=
v, unsigned unit)
>         return ret;
>  }
>
>  int vmw_kms_sou_init_display(struct vmw_private *dev_priv)
>  {
> -       struct drm_device *dev =3D &dev_priv->drm;
>         int i;
>
>         /* Screen objects won't work if GMR's aren't available */
>         if (!dev_priv->has_gmr)
>                 return -ENOSYS;
> @@ -937,12 +936,10 @@ int vmw_kms_sou_init_display(struct vmw_private *de=
v_priv)
>         for (i =3D 0; i < VMWGFX_NUM_DISPLAY_UNITS; ++i)
>                 vmw_sou_init(dev_priv, i);
>
>         dev_priv->active_display_unit =3D vmw_du_screen_object;
>
> -       drm_mode_config_reset(dev);
> -
>         return 0;
>  }
>
>  static int do_bo_define_gmrfb(struct vmw_private *dev_priv,
>                                   struct vmw_framebuffer *framebuffer)
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_stdu.c
> index b505f8ba3e83..7a3e6ee10932 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> @@ -1683,11 +1683,10 @@ static void vmw_stdu_destroy(struct vmw_screen_ta=
rget_display_unit *stdu)
>   * RETURNS:
>   * 0 on success, error code otherwise
>   */
>  int vmw_kms_stdu_init_display(struct vmw_private *dev_priv)
>  {
> -       struct drm_device *dev =3D &dev_priv->drm;
>         int i, ret;
>
>
>         /* Do nothing if there's no support for MOBs */
>         if (!dev_priv->has_mob)
> @@ -1706,9 +1705,7 @@ int vmw_kms_stdu_init_display(struct vmw_private *d=
ev_priv)
>                                 "Failed to initialize STDU %d", i);
>                         return ret;
>                 }
>         }
>
> -       drm_mode_config_reset(dev);
> -
>         return 0;
>  }
>
> --
> 2.56.1
>

That's a lot nicer than the v1, thanks. Sashiko is right that it leaks
in case of failure and something like:
- return drm_mode_config_create_initial_state(dev);
+ ret =3D drm_mode_config_create_initial_state(dev);
+ if (ret)
+ vmw_kms_close(dev_priv);
+
+ return ret;
would fix it but given that the leak happens when the screen failed to
initialize and the user has to deal with blank screen and the
allocation is small I would likely call it a low priority and probably
would be ok submitting as is.
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

--00000000000058ee680660735793
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPD3
eVzLbJAW1ZjOJa2SGQsq3Rkm9w8+kES9okaD3SFAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTExNzA2NTI0M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAGZOtotrFpaoDkKJCd4SsNb4m8Us+OKo9/+1TCnd
bzuwS/Hgc7+kNElSE39YXBZng86d89J+tSYP+y7t8hi2WBJS2VQzFKIKrntVXemhxNTee3HZsE8s
pmyRwzMXfYaM6twYbMuN6ws6joyo2teMEyA2hRmUIBLQ0rdaGgLTCuVVRJVzisPWYW3ekEcelb//
lv8z9+B5GE6PlYIibmBklEQIJiY0G1PCW6NC6xSGivRcKFAMLRtjo640ZuVamZm/ZtvdrUvqBsPL
bcoVA7G4F+wlOCijcADkixTPu3+tChvBiBjsKSVpPIzkqBMkvb6HBrAFURW+0nuvfk59R19OBGU=
--00000000000058ee680660735793--
