Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A5ACA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 18:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400C910E1D3;
	Sat, 10 Oct 2026 18:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dDTZaFzz";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2261810E291
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 18:09:45 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1433e7b057fso573462c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 11:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791655784; cv=none;
 d=google.com; s=arc-20260327;
 b=aVNYF2XkjM3Oir2nt0vxxPBV2TmUbVyxJxSVFQcVEc6mp6cJ/YC3BluiJxw1NBb6k0
 0v6BJpmZLKfzfc7AWMZpe2e1DmAn0bJJb7+DY6Qx8EQLPPY2JBzbbhBsoSHnVUYq9mWv
 HxHWsZiKVFAE4hQmJ0OuGzox5yn8taREFK8reVvhAASMA40BW5pkE4DJAwl6zJbb7UsM
 zYpNvvlTLsmId1A+SgpQqROtTslRXbqueQG1bcEoc4BvZEoe4Xgbxyyk8CULmME9mjqp
 1w1qV2znDNpBEpY9A6IQXQb9s6ST3M3UgHDUyhr/BfOQjLKIpnhKO+iyqe36BlZctpyT
 bT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qGiROTseWXd0dME9H7wh1YysGqzgSrO+n+M61rA15TI=;
 fh=OonokRu22uhjJNGohrGZoQ0Eq1ZDmX8QreE2Ri9aKmg=;
 b=a4+/xZOh7PENnH5JcToE4QQE4PBWtknOa7UtnTavktHAUjzfr63O56Fu/fFkebiCYD
 bGqSGUpKcex3IiPQnaxU/UTWOthStzKKKFsuOULFzhxR/vIHLe+JC88Vb0Qi7IYTIBgJ
 AZD/T0pMXdvvU/5+7P75/1OGRRzA7wbuHP8UwcgBvFm4nO5xDhUT2f0UhnXH6LVakXVy
 cuquav9QLKrz2NTU5GJ1ChpHhZ6+qD1MrZiNfZnUiO/c/jb4R/WIHXRQGH8Fdxc0dW5v
 KiT3XT8v96etJ4ypHXbv7wDRM+gcFjt0F0dEC0ST5jXi6b14Q8tLptkDamrfGPNFUcRC
 q9EQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791655784; x=1792260584; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qGiROTseWXd0dME9H7wh1YysGqzgSrO+n+M61rA15TI=;
 b=dDTZaFzzWN/i8V5QI5PvT8NdwUij3T3w6i1GKQWL0rWK+S7sRGOXaXCJ0/Cs0mEeuh
 DtgkLMU3yD0SEHSAZqFsB+9VmNAIY6I3KRDwINyIf3PAVSc2enLpxyWBgEsPocwLm9RE
 aomGkj4SBHiiT5JIeaLqDYYYoB4hC9GjKN7uqNmEMF3vkAQKnatVSFpwQR9BssPFOsHu
 qH5si0X8F+Jg1FAOdHbEUi7yDwsbWBAxRoDphAdzYf8oCtQT6orLxNDBTTQQf4CD2cu9
 DBVaJWlk8ThXn7yr/0hMnyXjfnlGsvkNJoVPiE4XeIuUUwKVGA/eGcm4BKgiZfXrqkbK
 4oEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791655784; x=1792260584;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qGiROTseWXd0dME9H7wh1YysGqzgSrO+n+M61rA15TI=;
 b=v3GGntEU0zLDUk0OGrhq1y+CM7lxonSgf/YXXBOg4+DOTT5T9Quf2bSGRgz/Td3Toa
 DMDYmX1ulBOWwz2C0oa+VOHbskFLxU2cLNV/cm6AlKt6JXEdnjkCDfXqJIQWDA3dgaxk
 QRjEeHNa8oHRuGPDO5lhdv7goUJFQZ98ZAuGsa1mf5NhCxOGMNWU53ZmHSttfHeE0Y5h
 rEEFLSZ3bR/+9lIK5RKuSfloJitGDEEjLnZ85WCbgSoqooLwBlzPkL6ay4UAe/iNxYiG
 ncvNvBjCtmD/6doUCaTV4hQ4PzEeTeG1Y0Dx9jP9OQnNuKN7iu5HdP1H1Ki2xqFw6BJi
 /fTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVX+0HKWkYzCVvTBO9vWdyDkEDU3oHubOpyz/KMN+383EkVT53KoROtEvUMabgdMF4NOYuzRFBnL0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL8ZKBndNQZsUCUx42u2AULySBlfp+f5sdc5KBo41e5wthg2HUd
 d+aN365i3hTUAplyjvqj6pOUMAdIPKpWRcUzpyOSjZ5ERTEiJZNgvNFa2REP/sRxgUQRYk7F0Eh
 iomaNGRyfAj1rxtCC2AZtkWPDjfNTihU=
X-Gm-Gg: AYBFou0cTX2VIooJ53GJ2x2KpGImQ6agI9XJhAATt+51LB0TDqWut3N1DF46ifGMelG
 r718ZQQ72jiE6B9aghouLRWKhJXEAbJtX2JGgkRKUJFnq5eRSLfEQgajqsHMZbz0Om9M6iLEkpk
 ee5BIC739AYK+bB+eajoyHenVNV6dP16Zzl5OP1thIjdgIa+kMoC9Qrlfb4XaA6SmHmQ5sA2e7m
 b80ab4kw7K/ON6aOvBgL9nUBXsw3NWNLlOV++kMcNX3Vj8/gn53NSizOi04sOD0a4BS18Hy1++I
 7O1LrjMp6B4Fe30h/IVUUhQReXpVXe/8X6tnP2WjCGzailJKVzWm2hd1whXFELEVu18RxbxKZ7r
 HEs8rhohVoNOYMwSdMnQ4ChOD2b/MaByVGsqM2GmV8JmV
X-Received: by 2002:a05:701b:21db:b0:166:29a2:f83f with SMTP id
 a92af1059eb24-16a56ab04e9mr7266318c88.5.1791655784097; Sat, 10 Oct 2026
 11:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260914193509.36836-1-pvmohammedanees2003@gmail.com>
In-Reply-To: <20260914193509.36836-1-pvmohammedanees2003@gmail.com>
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
Date: Sat, 10 Oct 2026 23:39:31 +0530
X-Gm-Features: AclHuK_-ruodxcJgIdXkonoM5FRZHR_kY7TG5l3g5XqKKFkt3Kmlgx5WfcKrBKs
Message-ID: <CAABpPxSucx-P=FFGGr_Ecyzxr5DTLcp_f_JSRJTbP4cSX7tFrQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: pass scanout position values directly
To: amd-gfx@lists.freedesktop.org
Cc: alex.hung@amd.com, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000922c7d065d805e58"
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

--000000000000922c7d065d805e58
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, just following up on this patch.

Thanks

On Tue, Sep 15, 2026 at 1:05=E2=80=AFAM Mohammed Anees <
pvmohammedanees2003@gmail.com> wrote:

> The DC scanout position helper already returns vblank start, vblank end,
> horizontal position and vertical position as separate values.
>
> dm_crtc_get_scanoutpos() currently packs these values into the legacy
> register-style vbl and position values, only for the amdgpu base driver
> to unpack them again.
>
> Change page_flip_get_scanoutpos() to return the individual values
> directly. Preserve the full 32 bit scanout position values returned
> by DC instead of truncating them to 13 bits through legacy packed
> register representation.
>
> For the legacy DCE implementations, keep decoding the packed hardware
> register values in the backend before returning them through the common
> interface. This keeps the register specific representation local to the
> DCE code.
>
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
> Changes in v2:
> - Move scanout position assignments to earlier place.
> - Restore the descriptive scanout position variable names.
> - Link to v1:
> https://lore.kernel.org/all/20260908082045.99555-1-pvmohammedanees2003@gm=
ail.com/
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 21 ++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |  5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  8 ++-
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 20 +++++--
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 20 +++++--
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 20 +++++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++-----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +-
>  .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 56 ++++++++++++-------
>  9 files changed, 125 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 59ea338b554c..88fb9b1abed2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1762,7 +1762,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct
> drm_device *dev,
>                         int *hpos, ktime_t *stime, ktime_t *etime,
>                         const struct drm_display_mode *mode)
>  {
> -       u32 vbl =3D 0, position =3D 0;
> +       u32 scan_vbl_start =3D 0, scan_vbl_end =3D 0;
> +       u32 scan_vpos =3D 0, scan_hpos =3D 0;
>         int vbl_start, vbl_end, vtotal, ret =3D 0;
>         bool in_vbl =3D true;
>
> @@ -1774,8 +1775,11 @@ int amdgpu_display_get_crtc_scanoutpos(struct
> drm_device *dev,
>         if (stime)
>                 *stime =3D ktime_get();
>
> -       if (amdgpu_display_page_flip_get_scanoutpos(adev, pipe, &vbl,
> &position) =3D=3D 0)
> +       if (amdgpu_display_page_flip_get_scanoutpos(adev, pipe,
> +                                                   &scan_vbl_start,
> &scan_vbl_end,
> +                                                   &scan_vpos,
> &scan_hpos) =3D=3D 0) {
>                 ret |=3D DRM_SCANOUTPOS_VALID;
> +       }
>
>         /* Get optional system timestamp after query. */
>         if (etime)
> @@ -1783,16 +1787,15 @@ int amdgpu_display_get_crtc_scanoutpos(struct
> drm_device *dev,
>
>         /* preempt_enable_rt() should go right here in PREEMPT_RT
> patchset. */
>
> -       /* Decode into vertical and horizontal scanout position. */
> -       *vpos =3D position & 0x1fff;
> -       *hpos =3D (position >> 16) & 0x1fff;
> +       *vpos =3D scan_vpos;
> +       *hpos =3D scan_hpos;
>
>         /* Valid vblank area boundaries from gpu retrieved? */
> -       if (vbl > 0) {
> -               /* Yes: Decode. */
> +       if (scan_vbl_start || scan_vbl_end) {
>                 ret |=3D DRM_SCANOUTPOS_ACCURATE;
> -               vbl_start =3D vbl & 0x1fff;
> -               vbl_end =3D (vbl >> 16) & 0x1fff;
> +               vbl_start =3D scan_vbl_start;
> +               vbl_end =3D scan_vbl_end;
>         } else {
>                 /* No: Fake something reasonable which gives at least ok
> results. */
>                 vbl_start =3D mode->crtc_vdisplay;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> index 49a29bf47a37..9de1891f50f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> @@ -33,7 +33,10 @@
>  #define amdgpu_display_hpd_get_gpio_reg(adev)
> (adev)->mode_info.funcs->hpd_get_gpio_reg((adev))
>  #define amdgpu_display_bandwidth_update(adev)
> (adev)->mode_info.funcs->bandwidth_update((adev))
>  #define amdgpu_display_page_flip(adev, crtc, base, async)
> (adev)->mode_info.funcs->page_flip((adev), (crtc), (base), (async))
> -#define amdgpu_display_page_flip_get_scanoutpos(adev, crtc, vbl, pos)
> (adev)->mode_info.funcs->page_flip_get_scanoutpos((adev), (crtc), (vbl),
> (pos))
> +#define amdgpu_display_page_flip_get_scanoutpos(adev, crtc,
> v_blank_start, v_blank_end, \
> +                                               v_position, h_position) \
> +       ((adev)->mode_info.funcs->page_flip_get_scanoutpos((adev), (crtc)=
,
> \
> +                       (v_blank_start), (v_blank_end), (v_position),
> (h_position)))
>  #define amdgpu_display_add_encoder(adev, e, s, c)
> (adev)->mode_info.funcs->add_encoder((adev), (e), (s), (c))
>  #define amdgpu_display_add_connector(adev, ci, sd, ct, ib, coi, h, r)
> (adev)->mode_info.funcs->add_connector((adev), (ci), (sd), (ct), (ib),
> (coi), (h), (r))
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index 7c784277396a..bb4d60698ee9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -277,8 +277,12 @@ struct amdgpu_display_funcs {
>         /* pageflipping */
>         void (*page_flip)(struct amdgpu_device *adev,
>                           int crtc_id, u64 crtc_base, bool async);
> -       int (*page_flip_get_scanoutpos)(struct amdgpu_device *adev, int
> crtc,
> -                                       u32 *vbl, u32 *position);
> +       int (*page_flip_get_scanoutpos)(struct amdgpu_device *adev,
> +                                       int crtc,
> +                                       u32 *v_blank_start,
> +                                       u32 *v_blank_end,
> +                                       u32 *v_position,
> +                                       u32 *h_position);
>         /* display topology setup */
>         void (*add_encoder)(struct amdgpu_device *adev,
>                             uint32_t encoder_enum,
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index 7de7adc8f225..cd12190fb962 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -256,14 +256,26 @@ static void dce_v10_0_page_flip(struct amdgpu_devic=
e
> *adev,
>         RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset)=
;
>  }
>
> -static int dce_v10_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int
> crtc,
> -                                       u32 *vbl, u32 *position)
> +static int dce_v10_0_crtc_get_scanoutpos(struct amdgpu_device *adev,
> +                                        int crtc,
> +                                        u32 *v_blank_start,
> +                                        u32 *v_blank_end,
> +                                        u32 *v_position,
> +                                        u32 *h_position)
>  {
> +       u32 vbl, position;
> +
>         if ((crtc < 0) || (crtc >=3D adev->mode_info.num_crtc))
>                 return -EINVAL;
>
> -       *vbl =3D RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
> -       *position =3D RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc])=
;
> +       vbl =3D RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
> +       position =3D RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
> +
> +       *v_blank_start =3D vbl & 0x1fff;
> +       *v_blank_end =3D (vbl >> 16) & 0x1fff;
> +
> +       *v_position =3D position & 0x1fff;
> +       *h_position =3D (position >> 16) & 0x1fff;
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index 3c1d6901127d..f2c60074f0f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -220,14 +220,26 @@ static void dce_v6_0_page_flip(struct amdgpu_device
> *adev,
>         RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset)=
;
>  }
>
> -static int dce_v6_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int
> crtc,
> -                                       u32 *vbl, u32 *position)
> +static int dce_v6_0_crtc_get_scanoutpos(struct amdgpu_device *adev,
> +                                       int crtc,
> +                                       u32 *v_blank_start,
> +                                       u32 *v_blank_end,
> +                                       u32 *v_position,
> +                                       u32 *h_position)
>  {
> +       u32 vbl, position;
> +
>         if ((crtc < 0) || (crtc >=3D adev->mode_info.num_crtc))
>                 return -EINVAL;
>
> -       *vbl =3D RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
> -       *position =3D RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc])=
;
> +       vbl =3D RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
> +       position =3D RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
> +
> +       *v_blank_start =3D vbl & 0x1fff;
> +       *v_blank_end =3D (vbl >> 16) & 0x1fff;
> +
> +       *v_position =3D position & 0x1fff;
> +       *h_position =3D (position >> 16) & 0x1fff;
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index a17944d5e843..5efdb5eea450 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -204,14 +204,26 @@ static void dce_v8_0_page_flip(struct amdgpu_device
> *adev,
>         RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset)=
;
>  }
>
> -static int dce_v8_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int
> crtc,
> -                                       u32 *vbl, u32 *position)
> +static int dce_v8_0_crtc_get_scanoutpos(struct amdgpu_device *adev,
> +                                       int crtc,
> +                                       u32 *v_blank_start,
> +                                       u32 *v_blank_end,
> +                                       u32 *v_position,
> +                                       u32 *h_position)
>  {
> +       u32 vbl, position;
> +
>         if ((crtc < 0) || (crtc >=3D adev->mode_info.num_crtc))
>                 return -EINVAL;
>
> -       *vbl =3D RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
> -       *position =3D RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc])=
;
> +       vbl =3D RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
> +       position =3D RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
> +
> +       *v_blank_start =3D vbl & 0x1fff;
> +       *v_blank_end =3D (vbl >> 16) & 0x1fff;
> +
> +       *v_position =3D position & 0x1fff;
> +       *h_position =3D (position >> 16) & 0x1fff;
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index df649ae66de2..3e8e45756bd4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -188,10 +188,13 @@ STATIC_IFN_KUNIT u32 dm_vblank_get_counter(struct
> amdgpu_device *adev, int crtc)
>  }
>  EXPORT_IF_KUNIT(dm_vblank_get_counter);
>
> -STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev,
> int crtc,
> -                                           u32 *vbl, u32 *position)
> +STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev,
> +                                           int crtc,
> +                                           u32 *v_blank_start,
> +                                           u32 *v_blank_end,
> +                                           u32 *v_position,
> +                                           u32 *h_position)
>  {
> -       u32 v_blank_start =3D 0, v_blank_end =3D 0, h_position =3D 0, v_p=
osition
> =3D 0;
>         struct amdgpu_crtc *acrtc =3D NULL;
>         struct dc *dc =3D adev->dm.dc;
>
> @@ -209,18 +212,16 @@ STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct
> amdgpu_device *adev, int crtc
>         if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
>                 dc_allow_idle_optimizations(dc, false);
>
> -       /*
> -        * TODO rework base driver to use values directly.
> -        * for now parse it back into reg-format
> -        */
> -       dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
> -                                &v_blank_start,
> -                                &v_blank_end,
> -                                &h_position,
> -                                &v_position);
> -
> -       *position =3D v_position | (h_position << 16);
> -       *vbl =3D v_blank_start | (v_blank_end << 16);
> +       if (!dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
> +                                     v_blank_start,
> +                                     v_blank_end,
> +                                     h_position,
> +                                     v_position)) {
> +               *v_blank_start =3D 0;
> +               *v_blank_end =3D 0;
> +               *v_position =3D 0;
> +               *h_position =3D 0;
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index c99a84bb040e..a13042951a4b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -1169,7 +1169,8 @@ int dm_set_powergating_state(struct amdgpu_ip_block
> *ip_block,
>  void dm_bandwidth_update(struct amdgpu_device *adev);
>  u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc);
>  int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
> -                          u32 *vbl, u32 *position);
> +                          u32 *v_blank_start, u32 *v_blank_end,
> +                          u32 *v_position, u32 *h_position);
>  struct dm_atomic_state *dm_atomic_get_new_state(struct drm_atomic_commit
> *state);
>  struct drm_private_state *dm_atomic_duplicate_state(struct
> drm_private_obj *obj);
>  void dm_atomic_destroy_state(struct drm_private_obj *obj,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> index 6335fc23e977..88d868178068 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> @@ -158,15 +158,19 @@ static void
> dm_test_vblank_get_counter_no_stream(struct kunit *test)
>  static void dm_test_crtc_get_scanoutpos_invalid_crtc(struct kunit *test)
>  {
>         struct amdgpu_device *adev =3D dm_kunit_alloc_adev(test);
> -       u32 vbl =3D 0;
> -       u32 position =3D 0;
> +       u32 v_blank_start =3D 0;
> +       u32 v_blank_end =3D 0;
> +       u32 v_position =3D 0;
> +       u32 h_position =3D 0;
>
>         adev->mode_info.num_crtc =3D 1;
>
> -       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, -1, &vbl,
> &position),
> -                       -EINVAL);
> -       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 1, &vbl,
> &position),
> -                       -EINVAL);
> +       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, -1,
> +                                                    &v_blank_start,
> &v_blank_end,
> +                                                    &v_position,
> &h_position), -EINVAL);
> +       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 1,
> +                                                    &v_blank_start,
> &v_blank_end,
> +                                                    &v_position,
> &h_position), -EINVAL);
>  }
>
>  /**
> @@ -177,8 +181,10 @@ static void
> dm_test_crtc_get_scanoutpos_no_stream(struct kunit *test)
>  {
>         struct amdgpu_device *adev =3D dm_kunit_alloc_adev(test);
>         struct amdgpu_crtc *acrtc;
> -       u32 vbl =3D 0;
> -       u32 position =3D 0;
> +       u32 v_blank_start =3D 0;
> +       u32 v_blank_end =3D 0;
> +       u32 v_position =3D 0;
> +       u32 h_position =3D 0;
>
>         acrtc =3D kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
>         KUNIT_ASSERT_NOT_NULL(test, acrtc);
> @@ -186,9 +192,13 @@ static void
> dm_test_crtc_get_scanoutpos_no_stream(struct kunit *test)
>         adev->mode_info.num_crtc =3D 1;
>         adev->mode_info.crtcs[0] =3D acrtc;
>
> -       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl,
> &position), 0);
> -       KUNIT_EXPECT_EQ(test, vbl, 0U);
> -       KUNIT_EXPECT_EQ(test, position, 0U);
> +       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0,
> +                                                    &v_blank_start,
> &v_blank_end,
> +                                                    &v_position,
> &h_position), 0);
> +       KUNIT_EXPECT_EQ(test, v_blank_start, 0U);
> +       KUNIT_EXPECT_EQ(test, v_blank_end, 0U);
> +       KUNIT_EXPECT_EQ(test, v_position, 0U);
> +       KUNIT_EXPECT_EQ(test, h_position, 0U);
>  }
>
>  /**
> @@ -1324,14 +1334,20 @@ static void
> dm_test_crtc_get_scanoutpos_unmapped_stream(struct kunit *test)
>  {
>         struct amdgpu_device *adev =3D dm_kunit_alloc_adev(test);
>         struct dc *dc =3D dm_kunit_alloc_dc_with_ctx(test);
> -       u32 vbl =3D 0xdeadbeef;
> -       u32 position =3D 0xdeadbeef;
> +       u32 v_blank_start =3D 0xdeadbeef;
> +       u32 v_blank_end =3D 0xdeadbeef;
> +       u32 v_position =3D 0xdeadbeef;
> +       u32 h_position =3D 0xdeadbeef;
>
>         dm_test_crtc_with_stream(test, adev, dc);
>
> -       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl,
> &position), 0);
> -       KUNIT_EXPECT_EQ(test, vbl, 0U);
> -       KUNIT_EXPECT_EQ(test, position, 0U);
> +       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0,
> +                                                    &v_blank_start,
> &v_blank_end,
> +                                                    &v_position,
> &h_position), 0);
> +       KUNIT_EXPECT_EQ(test, v_blank_start, 0U);
> +       KUNIT_EXPECT_EQ(test, v_blank_end, 0U);
> +       KUNIT_EXPECT_EQ(test, v_position, 0U);
> +       KUNIT_EXPECT_EQ(test, h_position, 0U);
>  }
>
>  /**
> @@ -1342,14 +1358,16 @@ static void
> dm_test_crtc_get_scanoutpos_exits_idle(struct kunit *test)
>  {
>         struct amdgpu_device *adev =3D dm_kunit_alloc_adev(test);
>         struct dc *dc =3D dm_kunit_alloc_dc_with_ctx(test);
> -       u32 vbl =3D 0;
> -       u32 position =3D 0;
> +       u32 v_blank_start =3D 0, v_blank_end =3D 0;
> +       u32 v_position =3D 0, h_position =3D 0;
>
>         dm_test_crtc_with_stream(test, adev, dc);
>         dc->caps.ips_support =3D true;
>         dc->idle_optimizations_allowed =3D true;
>
> -       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl,
> &position), 0);
> +       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0,
> +                                                    &v_blank_start,
> &v_blank_end,
> +                                                    &v_position,
> &h_position), 0);
>  }
>
>  static struct drm_atomic_commit *dm_test_alloc_commit(struct kunit *test=
,
> --
> 2.55.0
>
>

--000000000000922c7d065d805e58
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">

<p><span style=3D"background-color:transparent">Hi, just following up on th=
is patch.<br></span><span style=3D"background-color:transparent"><br>Thanks=
</span></p></div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15, 2026 at 1:05=E2=80=AFAM Mo=
hammed Anees &lt;<a href=3D"mailto:pvmohammedanees2003@gmail.com">pvmohamme=
danees2003@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">The DC scanout position helper already returns vblank s=
tart, vblank end,<br>
horizontal position and vertical position as separate values.<br>
<br>
dm_crtc_get_scanoutpos() currently packs these values into the legacy<br>
register-style vbl and position values, only for the amdgpu base driver<br>
to unpack them again.<br>
<br>
Change page_flip_get_scanoutpos() to return the individual values<br>
directly. Preserve the full 32 bit scanout position values returned<br>
by DC instead of truncating them to 13 bits through legacy packed<br>
register representation.<br>
<br>
For the legacy DCE implementations, keep decoding the packed hardware<br>
register values in the backend before returning them through the common<br>
interface. This keeps the register specific representation local to the<br>
DCE code.<br>
<br>
Signed-off-by: Mohammed Anees &lt;<a href=3D"mailto:pvmohammedanees2003@gma=
il.com" target=3D"_blank">pvmohammedanees2003@gmail.com</a>&gt;<br>
---<br>
Changes in v2:<br>
- Move scanout position assignments to earlier place. <br>
- Restore the descriptive scanout position variable names.<br>
- Link to v1: <a href=3D"https://lore.kernel.org/all/20260908082045.99555-1=
-pvmohammedanees2003@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https=
://lore.kernel.org/all/20260908082045.99555-1-pvmohammedanees2003@gmail.com=
/</a><br>
<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_display.c=C2=A0 =C2=A0| 21 ++++---<=
br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_display.h=C2=A0 =C2=A0|=C2=A0 5 +-<=
br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
8 ++-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/dce_v10_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2=
0 +++++--<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/dce_v6_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 20 +++++--<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/dce_v8_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 20 +++++--<br>
=C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++-----<br>
=C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |=C2=A0 3 +-<br>
=C2=A0.../display/amdgpu_dm/tests/amdgpu_dm_test.c=C2=A0 | 56 ++++++++++++-=
------<br>
=C2=A09 files changed, 125 insertions(+), 59 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 59ea338b554c..88fb9b1abed2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -1762,7 +1762,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_dev=
ice *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int *hpos, ktime_t *stime, ktime_t *etime,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const struct drm_display_mode *mode)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vbl =3D 0, position =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 scan_vbl_start =3D 0, scan_vbl_end =3D 0;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 scan_vpos =3D 0, scan_hpos =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vbl_start, vbl_end, vtotal, ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool in_vbl =3D true;<br>
<br>
@@ -1774,8 +1775,11 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_de=
vice *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stime)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *stime =3D ktime_ge=
t();<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_display_page_flip_get_scanoutpos(ade=
v, pipe, &amp;vbl, &amp;position) =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_display_page_flip_get_scanoutpos(ade=
v, pipe,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;scan_vbl_start, &amp;scan_vbl_end,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;scan_vpos, &amp;scan_hpos) =3D=3D 0)=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret |=3D DRM_SCANOU=
TPOS_VALID;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get optional system timestamp after query. *=
/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (etime)<br>
@@ -1783,16 +1787,15 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_d=
evice *dev,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* preempt_enable_rt() should go right here in =
PREEMPT_RT patchset. */<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Decode into vertical and horizontal scanout =
position. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*vpos =3D position &amp; 0x1fff;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*hpos =3D (position &gt;&gt; 16) &amp; 0x1fff;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*vpos =3D scan_vpos;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*hpos =3D scan_hpos;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Valid vblank area boundaries from gpu retrie=
ved? */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vbl &gt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Yes: Decode. */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (scan_vbl_start || scan_vbl_end) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret |=3D DRM_SCANOU=
TPOS_ACCURATE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vbl_start =3D vbl &=
amp; 0x1fff;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vbl_end =3D (vbl &g=
t;&gt; 16) &amp; 0x1fff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vbl_start =3D scan_=
vbl_start;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vbl_end =3D scan_vb=
l_end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* No: Fake somethi=
ng reasonable which gives at least ok results. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vbl_start =3D mode-=
&gt;crtc_vdisplay;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.h<br>
index 49a29bf47a37..9de1891f50f4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h<br>
@@ -33,7 +33,10 @@<br>
=C2=A0#define amdgpu_display_hpd_get_gpio_reg(adev) (adev)-&gt;mode_info.fu=
ncs-&gt;hpd_get_gpio_reg((adev))<br>
=C2=A0#define amdgpu_display_bandwidth_update(adev) (adev)-&gt;mode_info.fu=
ncs-&gt;bandwidth_update((adev))<br>
=C2=A0#define amdgpu_display_page_flip(adev, crtc, base, async) (adev)-&gt;=
mode_info.funcs-&gt;page_flip((adev), (crtc), (base), (async))<br>
-#define amdgpu_display_page_flip_get_scanoutpos(adev, crtc, vbl, pos) (ade=
v)-&gt;mode_info.funcs-&gt;page_flip_get_scanoutpos((adev), (crtc), (vbl), =
(pos))<br>
+#define amdgpu_display_page_flip_get_scanoutpos(adev, crtc, v_blank_start,=
 v_blank_end, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0v_position, h_position) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0((adev)-&gt;mode_info.funcs-&gt;page_flip_get_s=
canoutpos((adev), (crtc), \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(v_blank_start), (v_blank_end), (v_position), (h_position)))<br>
=C2=A0#define amdgpu_display_add_encoder(adev, e, s, c) (adev)-&gt;mode_inf=
o.funcs-&gt;add_encoder((adev), (e), (s), (c))<br>
=C2=A0#define amdgpu_display_add_connector(adev, ci, sd, ct, ib, coi, h, r)=
 (adev)-&gt;mode_info.funcs-&gt;add_connector((adev), (ci), (sd), (ct), (ib=
), (coi), (h), (r))<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_mode.h<br>
index 7c784277396a..bb4d60698ee9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h<br>
@@ -277,8 +277,12 @@ struct amdgpu_display_funcs {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* pageflipping */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void (*page_flip)(struct amdgpu_device *adev,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int crtc_id, u64 crtc_base, bool async);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*page_flip_get_scanoutpos)(struct amdgpu_d=
evice *adev, int crtc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *vbl,=
 u32 *position);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*page_flip_get_scanoutpos)(struct amdgpu_d=
evice *adev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int crtc,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *v_bl=
ank_start,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *v_bl=
ank_end,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *v_po=
sition,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *h_po=
sition);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* display topology setup */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void (*add_encoder)(struct amdgpu_device *adev,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t encoder_enum,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/dce_v10_0.c<br>
index 7de7adc8f225..cd12190fb962 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c<br>
@@ -256,14 +256,26 @@ static void dce_v10_0_page_flip(struct amdgpu_device =
*adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_=
crtc-&gt;crtc_offset);<br>
=C2=A0}<br>
<br>
-static int dce_v10_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int c=
rtc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *vbl,=
 u32 *position)<br>
+static int dce_v10_0_crtc_get_scanoutpos(struct amdgpu_device *adev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int crtc=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 *v_b=
lank_start,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 *v_b=
lank_end,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 *v_p=
osition,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 *h_p=
osition)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vbl, position;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((crtc &lt; 0) || (crtc &gt;=3D adev-&gt;mod=
e_info.num_crtc))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*vbl =3D RREG32(mmCRTC_V_BLANK_START_END + crtc=
_offsets[crtc]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*position =3D RREG32(mmCRTC_STATUS_POSITION + c=
rtc_offsets[crtc]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vbl =3D RREG32(mmCRTC_V_BLANK_START_END + crtc_=
offsets[crtc]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0position =3D RREG32(mmCRTC_STATUS_POSITION + cr=
tc_offsets[crtc]);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*v_blank_start =3D vbl &amp; 0x1fff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*v_blank_end =3D (vbl &gt;&gt; 16) &amp; 0x1fff=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*v_position =3D position &amp; 0x1fff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*h_position =3D (position &gt;&gt; 16) &amp; 0x=
1fff;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/dce_v6_0.c<br>
index 3c1d6901127d..f2c60074f0f4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c<br>
@@ -220,14 +220,26 @@ static void dce_v6_0_page_flip(struct amdgpu_device *=
adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_=
crtc-&gt;crtc_offset);<br>
=C2=A0}<br>
<br>
-static int dce_v6_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int cr=
tc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *vbl,=
 u32 *position)<br>
+static int dce_v6_0_crtc_get_scanoutpos(struct amdgpu_device *adev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int crtc,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *v_bl=
ank_start,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *v_bl=
ank_end,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *v_po=
sition,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *h_po=
sition)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vbl, position;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((crtc &lt; 0) || (crtc &gt;=3D adev-&gt;mod=
e_info.num_crtc))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*vbl =3D RREG32(mmCRTC_V_BLANK_START_END + crtc=
_offsets[crtc]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*position =3D RREG32(mmCRTC_STATUS_POSITION + c=
rtc_offsets[crtc]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vbl =3D RREG32(mmCRTC_V_BLANK_START_END + crtc_=
offsets[crtc]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0position =3D RREG32(mmCRTC_STATUS_POSITION + cr=
tc_offsets[crtc]);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*v_blank_start =3D vbl &amp; 0x1fff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*v_blank_end =3D (vbl &gt;&gt; 16) &amp; 0x1fff=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*v_position =3D position &amp; 0x1fff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*h_position =3D (position &gt;&gt; 16) &amp; 0x=
1fff;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/dce_v8_0.c<br>
index a17944d5e843..5efdb5eea450 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c<br>
@@ -204,14 +204,26 @@ static void dce_v8_0_page_flip(struct amdgpu_device *=
adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_=
crtc-&gt;crtc_offset);<br>
=C2=A0}<br>
<br>
-static int dce_v8_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int cr=
tc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *vbl,=
 u32 *position)<br>
+static int dce_v8_0_crtc_get_scanoutpos(struct amdgpu_device *adev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int crtc,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *v_bl=
ank_start,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *v_bl=
ank_end,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *v_po=
sition,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *h_po=
sition)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vbl, position;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((crtc &lt; 0) || (crtc &gt;=3D adev-&gt;mod=
e_info.num_crtc))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*vbl =3D RREG32(mmCRTC_V_BLANK_START_END + crtc=
_offsets[crtc]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*position =3D RREG32(mmCRTC_STATUS_POSITION + c=
rtc_offsets[crtc]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vbl =3D RREG32(mmCRTC_V_BLANK_START_END + crtc_=
offsets[crtc]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0position =3D RREG32(mmCRTC_STATUS_POSITION + cr=
tc_offsets[crtc]);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*v_blank_start =3D vbl &amp; 0x1fff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*v_blank_end =3D (vbl &gt;&gt; 16) &amp; 0x1fff=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*v_position =3D position &amp; 0x1fff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*h_position =3D (position &gt;&gt; 16) &amp; 0x=
1fff;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index df649ae66de2..3e8e45756bd4 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -188,10 +188,13 @@ STATIC_IFN_KUNIT u32 dm_vblank_get_counter(struct amd=
gpu_device *adev, int crtc)<br>
=C2=A0}<br>
=C2=A0EXPORT_IF_KUNIT(dm_vblank_get_counter);<br>
<br>
-STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, in=
t crtc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0u32 *vbl, u32 *position)<br>
+STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0int crtc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0u32 *v_blank_start,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0u32 *v_blank_end,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0u32 *v_position,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0u32 *h_position)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v_blank_start =3D 0, v_blank_end =3D 0, h_p=
osition =3D 0, v_position =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_crtc *acrtc =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dc *dc =3D adev-&gt;dm.dc;<br>
<br>
@@ -209,18 +212,16 @@ STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct am=
dgpu_device *adev, int crtc<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dc &amp;&amp; dc-&gt;caps.ips_support &amp;=
&amp; dc-&gt;idle_optimizations_allowed)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dc_allow_idle_optim=
izations(dc, false);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * TODO rework base driver to use values direct=
ly.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * for now parse it back into reg-format<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0dc_stream_get_scanoutpos(acrtc-&gt;dm_irq_param=
s.stream,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_blank_start,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_blank_end,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;h_position,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_position);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*position =3D v_position | (h_position &lt;&lt;=
 16);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*vbl =3D v_blank_start | (v_blank_end &lt;&lt; =
16);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dc_stream_get_scanoutpos(acrtc-&gt;dm_irq_=
params.stream,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v_blank_start,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v_blank_end,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0h_position,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v_position)) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*v_blank_start =3D =
0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*v_blank_end =3D 0;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*v_position =3D 0;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*h_position =3D 0;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
index c99a84bb040e..a13042951a4b 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
@@ -1169,7 +1169,8 @@ int dm_set_powergating_state(struct amdgpu_ip_block *=
ip_block,<br>
=C2=A0void dm_bandwidth_update(struct amdgpu_device *adev);<br>
=C2=A0u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc);<br>
=C2=A0int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u32 *vbl, u32 *position);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u32 *v_blank_start, u32 *v_blank_end,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u32 *v_position, u32 *h_position);<br>
=C2=A0struct dm_atomic_state *dm_atomic_get_new_state(struct drm_atomic_com=
mit *state);<br>
=C2=A0struct drm_private_state *dm_atomic_duplicate_state(struct drm_privat=
e_obj *obj);<br>
=C2=A0void dm_atomic_destroy_state(struct drm_private_obj *obj,<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c<br>
index 6335fc23e977..88d868178068 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c<br>
@@ -158,15 +158,19 @@ static void dm_test_vblank_get_counter_no_stream(stru=
ct kunit *test)<br>
=C2=A0static void dm_test_crtc_get_scanoutpos_invalid_crtc(struct kunit *te=
st)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D dm_kunit_alloc_a=
dev(test);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vbl =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 position =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v_blank_start =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v_blank_end =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v_position =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 h_position =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mode_info.num_crtc =3D 1;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(ad=
ev, -1, &amp;vbl, &amp;position),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0-EINVAL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(ad=
ev, 1, &amp;vbl, &amp;position),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0-EINVAL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(ad=
ev, -1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_blank_start, &amp;v_blank_end,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_position, &amp;h_position), -EINV=
AL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(ad=
ev, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_blank_start, &amp;v_blank_end,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_position, &amp;h_position), -EINV=
AL);<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
@@ -177,8 +181,10 @@ static void dm_test_crtc_get_scanoutpos_no_stream(stru=
ct kunit *test)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D dm_kunit_alloc_a=
dev(test);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_crtc *acrtc;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vbl =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 position =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v_blank_start =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v_blank_end =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v_position =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 h_position =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 acrtc =3D kunit_kzalloc(test, sizeof(*acrtc), G=
FP_KERNEL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 KUNIT_ASSERT_NOT_NULL(test, acrtc);<br>
@@ -186,9 +192,13 @@ static void dm_test_crtc_get_scanoutpos_no_stream(stru=
ct kunit *test)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mode_info.num_crtc =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mode_info.crtcs[0] =3D acrtc;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(ad=
ev, 0, &amp;vbl, &amp;position), 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, vbl, 0U);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, position, 0U);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(ad=
ev, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_blank_start, &amp;v_blank_end,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_position, &amp;h_position), 0);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, v_blank_start, 0U);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, v_blank_end, 0U);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, v_position, 0U);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, h_position, 0U);<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
@@ -1324,14 +1334,20 @@ static void dm_test_crtc_get_scanoutpos_unmapped_st=
ream(struct kunit *test)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D dm_kunit_alloc_a=
dev(test);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dc *dc =3D dm_kunit_alloc_dc_with_ctx(te=
st);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vbl =3D 0xdeadbeef;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 position =3D 0xdeadbeef;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v_blank_start =3D 0xdeadbeef;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v_blank_end =3D 0xdeadbeef;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v_position =3D 0xdeadbeef;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 h_position =3D 0xdeadbeef;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dm_test_crtc_with_stream(test, adev, dc);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(ad=
ev, 0, &amp;vbl, &amp;position), 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, vbl, 0U);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, position, 0U);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(ad=
ev, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_blank_start, &amp;v_blank_end,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_position, &amp;h_position), 0);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, v_blank_start, 0U);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, v_blank_end, 0U);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, v_position, 0U);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, h_position, 0U);<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
@@ -1342,14 +1358,16 @@ static void dm_test_crtc_get_scanoutpos_exits_idle(=
struct kunit *test)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D dm_kunit_alloc_a=
dev(test);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dc *dc =3D dm_kunit_alloc_dc_with_ctx(te=
st);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vbl =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 position =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v_blank_start =3D 0, v_blank_end =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 v_position =3D 0, h_position =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dm_test_crtc_with_stream(test, adev, dc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dc-&gt;caps.ips_support =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dc-&gt;idle_optimizations_allowed =3D true;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(ad=
ev, 0, &amp;vbl, &amp;position), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(ad=
ev, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_blank_start, &amp;v_blank_end,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;v_position, &amp;h_position), 0);<b=
r>
=C2=A0}<br>
<br>
=C2=A0static struct drm_atomic_commit *dm_test_alloc_commit(struct kunit *t=
est,<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div></div>

--000000000000922c7d065d805e58--
