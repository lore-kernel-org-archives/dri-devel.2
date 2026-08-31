Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F99C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4C510E17C;
	Mon, 31 Aug 2026 17:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="VF43v8Xh";
	dkim-atps=neutral
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E019910EA40
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:47:21 +0000 (UTC)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2d58efc7356so45125505ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 10:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788198441; x=1788803241;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8SMtOJ/osvRZUUVirxa8WqBdhbLZGwquZyGnrs41czs=;
 b=Y0zde1uHF8vG71yh6vLSvrCG8sUUKkNdomxyytnVIJc0/Atg7INXZdFEM464MuCmwF
 fhyvmtjzwjsmgR0pVCgBtYcUSfnVLZYFFZ4ae3gme99mtLw2iOiXjccuGLPtLm2Ma5fB
 9ZHRYOoYDbnLOeoYKZFbjW/bR+OksYc1m3KOCSG/NujneTGG081eP03BtU8W1aBvBxR8
 lUzDeaFQeLe+cEG2xTcIDYA+IvEajBleW5ArJZTko8zNM8MOaUUqeX5UNkrLTeTi68MX
 MwII9d0WibyaCK0lhgu1w8Jz6nZ9gYUzXU0NhhAVUdVfnNP1gmQxqO4f6gzDny1aLOyM
 sMzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/OIag7uNi9hKk35Ji8oMFCjiCcjvrnaZ8ubzclzeCFe27FfxglmbVH93pO7T3nqA0PmMYmew9TBw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mMZ+BVkvbWsMdCQqqrzg9Rwq0wbquV1Y3cLvn+rr/6e9X4JBCu
 IK1OBEQstoCzabguTiW39jAx6PSiLkIJ72lDcmg4MIQKZSbOjmba2UIj+6JnCnxgc+Tq2WO5v52
 4tQ7OmE2/rZcea0RdQgDXC9ZMQsa4WcopKossV80YB7MX8jiqe4otHEnfVJwTbZRfzzENHTB81f
 Pvmq/7sNwA0XduQ3DiVO+RnRRVOMH4vVqtcDIBRyR2nLIISm6K3z1UZOAd14xEpKUsmwPHTsFh5
 vy1PPdSW5ML7o8Bd/G4
X-Gm-Gg: AYBFou0oMzsSn/FGRzOCw+nWKJX+38aOIo4WFCX6Kbcqt7HJLRfZokXl9zj5OryUTsQ
 CjoJCTVKebqOuNb6NInDtipQ1w7ADpzTYfQP9B9BuS+P1H2dlV59QBsirNaJwjUimNTHYTkf2tl
 51bSbchn2tO2w5TX3ei7QvIfvuK3coPAbCcqkxktqScWeyGfzOMaq768/GtfaCotGn7yum2PcKz
 NxV857deVewqoEzj9k//NrjfDj4nHikEbE5ARm35HPj9lvubpAfU36USuWV0zdn4i+Wru/pZXcZ
 MYQ0npjHcjQ06I/weT6pIqVgib2CIXxFWf7wLsDH+5hAxAHfk4qNA37L8mALLPzCOlj/18ztZil
 Pq8OwdnurVkbi0iuxfbLlWX7dbHwxW2rHihVNRsXbBY69BxHJxrTvjICOpPu6bE5iOKxA2mY9Ks
 /299ilnxixASnYJYerFBt6a3fsIuHILkHK
X-Received: by 2002:a17:90b:4a52:b0:393:288:29e3 with SMTP id
 98e67ed59e1d1-396d0eda189mr38579356a91.10.1788198441192; 
 Mon, 31 Aug 2026 10:47:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3990bf428e5sm105156a91.5.2026.08.31.10.47.20
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2026 10:47:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a2a9c119a2so17587391fa.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1788198438; x=1788803238;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8SMtOJ/osvRZUUVirxa8WqBdhbLZGwquZyGnrs41czs=;
 b=VF43v8XhAgGSR8gM1joUhVil+ujI5Qv0Fe7X6aE1ToslZnitMJ3Od5LMIO6fUGwFC1
 6p70ggI6EDv8b7ED2Wp/e+ELc+n07qWaJRQklpEDyKaTbb+/P7SCvqFXg61aBL6XUc/+
 Y6dqwncC6aVZj1xwPQCkpT4y/eXqBx/88KJo8=
X-Forwarded-Encrypted: i=1;
 AKwUvByPpOz1FpLJ0Leb0UBoo0ASzqjuh0y+fZRYzAWGOdvpQwWmTZgbr1yiFam3KmA0gHxC2Q2rQpkCEUA=@lists.freedesktop.org
X-Received: by 2002:a2e:a54d:0:b0:39c:9955:9e00 with SMTP id
 38308e7fff4ca-3a3395c4327mr5361781fa.2.1788198438011; 
 Mon, 31 Aug 2026 10:47:18 -0700 (PDT)
X-Received: by 2002:a2e:a54d:0:b0:39c:9955:9e00 with SMTP id
 38308e7fff4ca-3a3395c4327mr5361651fa.2.1788198437503; Mon, 31 Aug 2026
 10:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
 <20260831-drm-no-more-plane-reset-v3-38-1877c7aa57b3@kernel.org>
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-38-1877c7aa57b3@kernel.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 31 Aug 2026 13:47:03 -0400
X-Gm-Features: AcwNN1VbSwQNGo0DIIA3k1fp_NqAH4PDZ3G0dieHoKRkUzBpFxESORVW85vPiE0
Message-ID: <CABQX2QNA0RyjTSLhBnkcfeop-ehXUhiubY1NZdKD83hYmPZMaQ@mail.gmail.com>
Subject: Re: [PATCH v3 38/40] drm/vmwgfx: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000b52fd4065a5b64b2"
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

--000000000000b52fd4065a5b64b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 12:20=E2=80=AFPM Maxime Ripard <mripard@kernel.org>=
 wrote:
>
> The plane reset implementation creates a custom state
> subclass, but only initializes a pristine state without resetting any
> hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: zack.rusin@broadcom.com
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 17 +++++++----------
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  4 ++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |  4 ++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  4 ++--
>  5 files changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index 0b470809661c..9031dccad31d 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -277,31 +277,28 @@ vmw_du_plane_duplicate_state(struct drm_plane *plan=
e)
>         return state;
>  }
>
>
>  /**
> - * vmw_du_plane_reset - creates a blank vmw plane state
> + * vmw_du_plane_create_state - creates a blank vmw plane state
>   * @plane: drm plane
>   *
> - * Resets the atomic state for @plane by freeing the state pointer (whic=
h might
> - * be NULL, e.g. at driver load time) and allocating a new empty state o=
bject.
> + * Allocates a new empty state object.
>   */
> -void vmw_du_plane_reset(struct drm_plane *plane)
> +struct drm_plane_state *vmw_du_plane_create_state(struct drm_plane *plan=
e)
>  {
>         struct vmw_plane_state *vps;
>
> -       if (plane->state)
> -               vmw_du_plane_destroy_state(plane, plane->state);
> -
>         vps =3D kzalloc_obj(*vps);
> -
>         if (!vps) {
>                 DRM_ERROR("Cannot allocate vmw_plane_state\n");
> -               return;
> +               return ERR_PTR(-ENOMEM);
>         }
>
> -       __drm_atomic_helper_plane_reset(plane, &vps->base);
> +       __drm_atomic_helper_plane_state_init(&vps->base, plane);
> +
> +       return &vps->base;
>  }
>
>
>  /**
>   * vmw_du_plane_destroy_state - destroy plane state
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.h
> index e641f33341e6..5085d8bccf0a 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> @@ -409,11 +409,11 @@ void vmw_du_primary_plane_destroy(struct drm_plane =
*plane);
>  /* Atomic Helpers */
>  int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
>                                       struct drm_atomic_commit *state);
>  void vmw_du_plane_cleanup_fb(struct drm_plane *plane,
>                              struct drm_plane_state *old_state);
> -void vmw_du_plane_reset(struct drm_plane *plane);
> +struct drm_plane_state *vmw_du_plane_create_state(struct drm_plane *plan=
e);
>  struct drm_plane_state *vmw_du_plane_duplicate_state(struct drm_plane *p=
lane);
>  void vmw_du_plane_destroy_state(struct drm_plane *plane,
>                                 struct drm_plane_state *state);
>  void vmw_du_plane_unpin_surf(struct vmw_plane_state *vps);
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_ldu.c
> index a4b28341f622..b147f5db9df5 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> @@ -362,20 +362,20 @@ vmw_ldu_primary_plane_atomic_update(struct drm_plan=
e *plane,
>
>  static const struct drm_plane_funcs vmw_ldu_plane_funcs =3D {
>         .update_plane =3D drm_atomic_helper_update_plane,
>         .disable_plane =3D drm_atomic_helper_disable_plane,
>         .destroy =3D vmw_du_primary_plane_destroy,
> -       .reset =3D vmw_du_plane_reset,
> +       .atomic_create_state =3D vmw_du_plane_create_state,
>         .atomic_duplicate_state =3D vmw_du_plane_duplicate_state,
>         .atomic_destroy_state =3D vmw_du_plane_destroy_state,
>  };
>
>  static const struct drm_plane_funcs vmw_ldu_cursor_funcs =3D {
>         .update_plane =3D drm_atomic_helper_update_plane,
>         .disable_plane =3D drm_atomic_helper_disable_plane,
>         .destroy =3D vmw_cursor_plane_destroy,
> -       .reset =3D vmw_du_plane_reset,
> +       .atomic_create_state =3D vmw_du_plane_create_state,
>         .atomic_duplicate_state =3D vmw_du_plane_duplicate_state,
>         .atomic_destroy_state =3D vmw_du_plane_destroy_state,
>  };
>
>  /*
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_scrn.c
> index a05f935f1841..89714d5c235b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> @@ -754,20 +754,20 @@ vmw_sou_primary_plane_atomic_update(struct drm_plan=
e *plane,
>
>  static const struct drm_plane_funcs vmw_sou_plane_funcs =3D {
>         .update_plane =3D drm_atomic_helper_update_plane,
>         .disable_plane =3D drm_atomic_helper_disable_plane,
>         .destroy =3D vmw_du_primary_plane_destroy,
> -       .reset =3D vmw_du_plane_reset,
> +       .atomic_create_state =3D vmw_du_plane_create_state,
>         .atomic_duplicate_state =3D vmw_du_plane_duplicate_state,
>         .atomic_destroy_state =3D vmw_du_plane_destroy_state,
>  };
>
>  static const struct drm_plane_funcs vmw_sou_cursor_funcs =3D {
>         .update_plane =3D drm_atomic_helper_update_plane,
>         .disable_plane =3D drm_atomic_helper_disable_plane,
>         .destroy =3D vmw_cursor_plane_destroy,
> -       .reset =3D vmw_du_plane_reset,
> +       .atomic_create_state =3D vmw_du_plane_create_state,
>         .atomic_duplicate_state =3D vmw_du_plane_duplicate_state,
>         .atomic_destroy_state =3D vmw_du_plane_destroy_state,
>  };
>
>  /*
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_stdu.c
> index 939da0e11dbb..cbf55084110a 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> @@ -1472,20 +1472,20 @@ vmw_stdu_crtc_atomic_flush(struct drm_crtc *crtc,
>
>  static const struct drm_plane_funcs vmw_stdu_plane_funcs =3D {
>         .update_plane =3D drm_atomic_helper_update_plane,
>         .disable_plane =3D drm_atomic_helper_disable_plane,
>         .destroy =3D vmw_du_primary_plane_destroy,
> -       .reset =3D vmw_du_plane_reset,
> +       .atomic_create_state =3D vmw_du_plane_create_state,
>         .atomic_duplicate_state =3D vmw_du_plane_duplicate_state,
>         .atomic_destroy_state =3D vmw_du_plane_destroy_state,
>  };
>
>  static const struct drm_plane_funcs vmw_stdu_cursor_funcs =3D {
>         .update_plane =3D drm_atomic_helper_update_plane,
>         .disable_plane =3D drm_atomic_helper_disable_plane,
>         .destroy =3D vmw_cursor_plane_destroy,
> -       .reset =3D vmw_du_plane_reset,
> +       .atomic_create_state =3D vmw_du_plane_create_state,
>         .atomic_duplicate_state =3D vmw_du_plane_duplicate_state,
>         .atomic_destroy_state =3D vmw_du_plane_destroy_state,
>  };
>
>
>
> --
> 2.55.0
>

LGTM. Thanks.

Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

--000000000000b52fd4065a5b64b2
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKMx
XxbmEajPgBkWLnkCuROg8JT53ygcNv1iBGXdG6bIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDgzMTE3NDcxOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHaZDVzq/17TZytxKsFuEub8aq+dV3qvrh7oRYtY
R9Ad9N7E9zi+prAxEN/0NoETf3t6SDBOGQEIwz46ll4oulOOfyn3PC7KQO+nGF+g+AO9bq1+L41N
d756WXxOi99TSl2GqRA5NUp6BN5TKxOufcHhbyDPetuKq7P6fXJKcsKcXX8OF/j917451KCTYTXl
cKHVik4krWtQ+Wsv831WFh1Zuf9gDecFsfuAm2aaRqdIbWuoJ2wPWtKhce343okjehVl/zxTGRzU
DgTqtKGGSY0WRF1IpDQKZ8cpGIJLmrmmFnc6q4xdjGm/RwQFgLkocHX9NV9zA0vsVC0RoJ4B3ws=
--000000000000b52fd4065a5b64b2--
