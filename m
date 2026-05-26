Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9C0CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 939B410E6A9;
	Tue, 26 May 2026 14:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ie93BQcd";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 053EC10E6B2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:44:10 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-30436e8f582so555911eec.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779806649; cv=none;
 d=google.com; s=arc-20240605;
 b=P05feJ5xJ5nx47LbRjkRUug6I5+2dvH5uaqmz3/GqUUpfdjJJiuZ6eAdOqN7wq6w/V
 4EPwgsanC9ZB5vstaWo890iKik9pLY1ENk9EadGEMeKCa3F1mvz3wQZm/Mrn4215W66p
 +500IwkENNdZKLVHJM08IvjPlXXS5+nMMHzHjlWRoFJ6p3IisdeecJ9roa3gJy7Q8AXr
 i34L+S8JmpGB+qisMt4XMwIQYxLq0BL0QkKuhMNl7xRhX5iOOtB6MODIPxRnMWO+1ZL9
 cVv/8oJltgOVt40GTpEcuYoj7pwBP5HqUtWGkU5N6FByUWC1m9ghlwIDJMBwKk4RTWIG
 s/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=onDrreUXj8UO+PdKcK84CFu/SdIlVa0bfR+p75TWDU8=;
 fh=TjwxvNpwRQ2dekhS26YP4RbC544c/E5bPxBeFoC5odg=;
 b=MMGOyq+ufGXPPXean8nyIoi3yp61sB91MXA6bRynJbxXvAZ7hMWoNDgWI4RMvmAD1X
 oErjr3jBXGUPCofyZ0up1RApv97FrTJpO0s++mfJkxFC339ay+RO5wx7oM8GbeN9N/Ds
 hrR1MvJXFljTZvuBFe70850emde3ybNdz8IM5+TTfL5ZTpBLl8tug8kblLbro0g+/pTT
 lt75JlWB6omTmleXLcTGxeDTAldpFO9WxasapOdrySYsE6eqLmXwxQoubfVaaj9KV7qq
 dw3iA+kpKYSTmtl8d6uACMTtmERKR2VlaJplZbNVizrfJmv8/XIZXtrq+e20aBkWgl9n
 mYng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779806649; x=1780411449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onDrreUXj8UO+PdKcK84CFu/SdIlVa0bfR+p75TWDU8=;
 b=Ie93BQcds3HsNqVIiFHtAWbhdzoNt2HgN4/hg9o3n76IEsutt09d98nkfj6IgvE7CW
 Ft6tSCXgWqGBHGSVzrM6O9iRRFOWeplZ9mLVeG/+HfEa/iPpBPu8wzEhBYUrLvKQfkRv
 u0zYaZhtPC4+V+wg3u8oHZqRs34lDFyTpQdOuW9o/K30nHm8qz8LN+F9UzXTSEIfRyp4
 lhMYfx+PiJxaOuA3F7dWyaA7GFZ87Th5ae7LTZIFTXvc6z68Yrnz3db4RrCw/GE6b5+0
 MJzhAw6q5dwRDmr/g7z6gyoO6601LW9yUo3YHLamdcpx2XdsaR2X4r6icsE87w124RLO
 jxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806649; x=1780411449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=onDrreUXj8UO+PdKcK84CFu/SdIlVa0bfR+p75TWDU8=;
 b=WqRI/wMzXlKKheNxyXU1eOsNlF0Cd/PTW/pIHd75TNZHRj4gOz1mLAkeoYVgUnFACe
 USMQmwZNZjGMJIVUaAo6y5u9FGiR8foTeY1b/CLDgKomtte3pl2RfLi4dNaGy7qfBW4l
 qJbDCW434IOWNdr7sFJJQTvpN4w1Ll+oMPUSxfgEMqSqLFayAP32WDBr/y9j/8hQTMzx
 jA6vVP+Z1IeJdT3OzErMkxYEciUwqliiB9LTN9/DIQdF/k+G5FHucbGUcJakI3Uc4cs1
 Bp+VjeQ6X6reOWjzz2hNMDumo8yrfEBZGyZ8KPUDyWkkhJL9EN+TrnXFllw9+F6Apkgq
 50lA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UzHOrRFIf99H6PlcmT3g00lutcmcHgCpqSYNLoPWUJ7QSnK3KnMaugOm4KUlmm7wKz1RaAe+0LRI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOgCrKeSKxpSO6+AuA5z+eHqQ0NkO55J3n5nWbEt1VOH7AfRw1
 vaZpZXucekadJ5VV9Ohi28LqeTiL+9Suc/bYO2wUoxOU8SA9tBye6Yg2utKjbboZMOb7ONMl062
 5Bna/Nw57nbYgNVALncftZ4epv6f0hBk=
X-Gm-Gg: Acq92OF0GLWXes04qfinRxNtK1eNFNhP3lcZiXXub/hAzBejdwzFfL2ZvJKhG3umlZY
 A/gdumoPunPjm1dmziE6ngbxPaMRIsf/0YkN4Vml29xrhrh9qEEPq1kcf3bKXA93ug4vHM38+Io
 gssOt9qJByZqyiNZ3dk6kVgWiMxa923aGLOZtKnigzVnzwa80Uaw9hXxkDxUOtLjxwxVrw0DmE8
 LIgA6mcUWQHzH0maVOiLhoBltTePnHiXQdMLPPD+3rSTH6Fug89Gmpn1k3OHvBS2CbpL/WPtA/Y
 HEO5u9wA+UTLQwAhc58P3/f/03nSMpBV7hP93g7SWrtGS60WnTLeyVuJKRHKPasrnTMHIZU4W4q
 bVY9b
X-Received: by 2002:a05:701b:2918:b0:136:b46c:31fb with SMTP id
 a92af1059eb24-136b46c3666mr918902c88.5.1779806649245; Tue, 26 May 2026
 07:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260523142748.50034-1-jpeisach@ubuntu.com>
 <20260523142748.50034-3-jpeisach@ubuntu.com>
In-Reply-To: <20260523142748.50034-3-jpeisach@ubuntu.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 10:43:57 -0400
X-Gm-Features: AVHnY4Ic2QxJYCZjWu-ixtMOMOd8y0Sy8SHI4wjdkygVoGxyWm41zFJuuBDIHho
Message-ID: <CADnq5_M1niot3YbBxLbLnfG8KJDRBSBxmTKvgYwMEs5Ln55F5g@mail.gmail.com>
Subject: Re: [PATCH NEXT 2/2] drm/radeon/radeon_connectors: remove
 radeon_connector_free_edid
To: Joshua Peisach <jpeisach@ubuntu.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied the series.  Thanks!

Alex

On Sat, May 23, 2026 at 10:28=E2=80=AFAM Joshua Peisach <jpeisach@ubuntu.co=
m> wrote:
>
> Since we are using struct drm_edid, we can call drm_edid_free directly.
> Also make sure to set the pointer to NULL afterwards.
>
> Signed-off-by: Joshua Peisach <jpeisach@ubuntu.com>
> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 30 +++++++++++-----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm=
/radeon/radeon_connectors.c
> index d3a2efbcfd0d..da678f41823d 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -314,14 +314,6 @@ static void radeon_connector_get_edid(struct drm_con=
nector *connector)
>         }
>  }
>
> -static void radeon_connector_free_edid(struct drm_connector *connector)
> -{
> -       struct radeon_connector *radeon_connector =3D to_radeon_connector=
(connector);
> -
> -       kfree(radeon_connector->edid);
> -       radeon_connector->edid =3D NULL;
> -}
> -
>  static int radeon_ddc_get_modes(struct drm_connector *connector)
>  {
>         struct radeon_connector *radeon_connector =3D to_radeon_connector=
(connector);
> @@ -895,7 +887,9 @@ static void radeon_connector_destroy(struct drm_conne=
ctor *connector)
>  {
>         struct radeon_connector *radeon_connector =3D to_radeon_connector=
(connector);
>
> -       radeon_connector_free_edid(connector);
> +       drm_edid_free(radeon_connector->edid);
> +       radeon_connector->edid =3D NULL;
> +
>         kfree(radeon_connector->con_priv);
>         drm_connector_unregister(connector);
>         drm_connector_cleanup(connector);
> @@ -1007,7 +1001,8 @@ radeon_vga_detect(struct drm_connector *connector, =
bool force)
>                 dret =3D radeon_ddc_probe(radeon_connector, false);
>         if (dret) {
>                 radeon_connector->detected_by_load =3D false;
> -               radeon_connector_free_edid(connector);
> +               drm_edid_free(radeon_connector->edid);
> +               radeon_connector->edid =3D NULL;
>                 radeon_connector_get_edid(connector);
>
>                 if (!radeon_connector->edid) {
> @@ -1022,7 +1017,8 @@ radeon_vga_detect(struct drm_connector *connector, =
bool force)
>                          * with a shared ddc line (often vga + hdmi)
>                          */
>                         if (radeon_connector->use_digital && radeon_conne=
ctor->shared_ddc) {
> -                               radeon_connector_free_edid(connector);
> +                               drm_edid_free(radeon_connector->edid);
> +                               radeon_connector->edid =3D NULL;
>                                 ret =3D connector_status_disconnected;
>                         } else {
>                                 ret =3D connector_status_connected;
> @@ -1251,7 +1247,8 @@ radeon_dvi_detect(struct drm_connector *connector, =
bool force)
>         }
>         if (dret) {
>                 radeon_connector->detected_by_load =3D false;
> -               radeon_connector_free_edid(connector);
> +               drm_edid_free(radeon_connector->edid);
> +               radeon_connector->edid =3D NULL;
>                 radeon_connector_get_edid(connector);
>
>                 if (!radeon_connector->edid) {
> @@ -1277,7 +1274,8 @@ radeon_dvi_detect(struct drm_connector *connector, =
bool force)
>                          * with a shared ddc line (often vga + hdmi)
>                          */
>                         if ((!radeon_connector->use_digital) && radeon_co=
nnector->shared_ddc) {
> -                               radeon_connector_free_edid(connector);
> +                               drm_edid_free(radeon_connector->edid);
> +                               radeon_connector->edid =3D NULL;
>                                 ret =3D connector_status_disconnected;
>                         } else {
>                                 ret =3D connector_status_connected;
> @@ -1301,7 +1299,8 @@ radeon_dvi_detect(struct drm_connector *connector, =
bool force)
>                                                 if (list_connector->conne=
ctor_type !=3D DRM_MODE_CONNECTOR_VGA) {
>                                                         /* hpd is our onl=
y option in this case */
>                                                         if (!radeon_hpd_s=
ense(rdev, radeon_connector->hpd.hpd)) {
> -                                                               radeon_co=
nnector_free_edid(connector);
> +                                                               drm_edid_=
free(radeon_connector->edid);
> +                                                               radeon_co=
nnector->edid =3D NULL;
>                                                                 ret =3D c=
onnector_status_disconnected;
>                                                         }
>                                                 }
> @@ -1635,7 +1634,8 @@ radeon_dp_detect(struct drm_connector *connector, b=
ool force)
>                 goto out;
>         }
>
> -       radeon_connector_free_edid(connector);
> +       drm_edid_free(radeon_connector->edid);
> +       radeon_connector->edid =3D NULL;
>
>         if ((connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) ||
>             (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_LVDS)) {
> --
> 2.53.0
>
