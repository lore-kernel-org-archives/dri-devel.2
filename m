Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF89DCC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328DA10E79D;
	Tue, 13 Oct 2026 12:18:05 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com
 [209.85.160.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422C610E79D
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:17:59 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-49de8ea072cso1157765fac.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791893878; cv=none;
 d=google.com; s=arc-20260327;
 b=AUDjEzkYXeawYVZu71AnJHwyDa3Db8zfrHSpzheKCVb21BcfpSFTPYkll+uDMpqYKa
 9tNwRv7+j5uP/u+0z/R7OlnQhX0U0UCOq+yu8TlLNCCg/cBX9oB/eFKn3tAngS2yhofi
 Bj2qvE8oZ04afq8qWTYRSX7W7enxlhusz0qTalbSbRkmsbjR+Xl3vRUEMWKOg3iJ428S
 mDazOqDoXVLeemaqdxECUM0DnGzJAiKQ9tpfiYTRSzjZF4pkrR3N7V1qPLGZ8u+pmx0d
 r2KvrIsOmd62G+5vYXkTGy1jYuMkrl510PvUko9lbq+GPC4aB9QIcELV+hEYYaClIKer
 w+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=52ntJQgHaqpg/GYORpwG/F/SvrAHAVug+tTyg9y3aII=;
 fh=iIfmz3BIijL6BOsMKNq6GtWj38luR2KrNgxVDOKaN70=;
 b=ING005Tsk64INhC/PNiRGGDKcojNVB/WrHWNqVQCutjxRO8AjBC1gVBr0Db5iaRubr
 38xDVqthUGF5k/RBsNPJzCxTOkPqSwZHuWfoKESR0T7TVOQ38BasAmD51uugX0Oz+psg
 +xGsJ4KbgFgh/tUmuUWp2hub5ArHXXfgY22axE8FJZNjOhH/9nQUSuwuwD5F7u647j5X
 vQ6BhRtDILc7Uw+RpqU3rMYb3nkh7miFvXyqJWajond+a4XR21QAuJ50qmVyUFEC1Pc/
 f+1L+XOhtPkrnQVviqGcXIfV6zI0MkrQHEzmiWVImTbIZg86jb5KxNPo/X7f59scfCwc
 M8fA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791893878; x=1792498678; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=52ntJQgHaqpg/GYORpwG/F/SvrAHAVug+tTyg9y3aII=;
 b=jjb8Qjm02nwEmf9tqy7nP2fWrXQLlDyIDxuWUDZ2UE7GmcKyumy/hf8/QYzPA0EQWc
 2DqNHFUEoA74zkO+HbqizswYrjJzK9OjRChodZSIl9xGLYTexezRjEATVxUoMXjH/ltz
 dNq0/mPhSZf+y0Y8RKm8vdSTzdIhbDIComnGNC2t1sRgxPNbpx1PfbjGXqqSpHsTORR1
 AezGgTWzddBJGqYyWac8meOmSmbmK9jsEYQv1FAexDav3Ce5TWprMA6YmiVOm7272BPP
 Xy9Z6KY7f7bO9OuOC7yBSijV/6xzi1k458nvig4sbLW7/ae2wj0I93hLlPFWBgJD0wPW
 wwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791893878; x=1792498678;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=52ntJQgHaqpg/GYORpwG/F/SvrAHAVug+tTyg9y3aII=;
 b=sK4AtEdf8P/f/3J4B2R48RYaZKRaap7MH9wVnLqw+M4RC/SEYd3oXbueho8zawbRMi
 wic9Gd/pKVCO+56hFQL+mdOfQjrmqyrivq5aecF0K6HcM3Wx2a1hiD2lKDlqRkUbshUd
 tGiUajdJ4eVzfrZLsStdcM1HMeeVQthX+JoWzrFKR6tb8VuzJ2StYTaVttFslOSGf0it
 +KerPNMLFM9XfKI+VBPknb98u+vmEs+HgVdrcIj0yrUxIz3VRszpLMIXOiAJ29KbNywG
 a+YmKh3nMIGJ8jnufWwS+mbtVFo1AtkKb+qWsl1CWKXLu1O7YEMTTjbW8/R/Sp9Br9Ak
 5XtA==
X-Gm-Message-State: AFq9FYLGXoZnbiIE4CQg8Su1KCO+FUR8jTap8FjJeGczupR2s1iF7Ocu
 6DtceGHXZIlJvv5tkdcjpPbWkwsbncb0IzkBBPchkdKILYRgFdSiNJoMMC6lOYhxXd3zHmziMBi
 1x6c0pdCFtR6+z6Uxr0+TM3CNbD+1QxQ=
X-Gm-Gg: AYBFou2BGqZ0Z+nVhuhudPu5dpCdvd2rOQXa5uE0yZaS6YXEvky/7NKjtuWDIK7d85A
 qnxOpqHVPRfyvbqtYDk8jS3Nd7ehDoWspjPAOqVETa3y8SEf+d4NP1mGpRIikpvPBHugMGPT8Xp
 Q185o/ZKaat73I7KQtHzZ41yHCmd0G396ap55usimHUcMWr3YPQrjdoa1U8+aiV3IaeMqkIjyvD
 cOZRjZLU/MwHNwKSSQCrDTm1zN75UbJaetF7LIMumBeYwSUd1cKioJiismsw0+EtE5oHFyBbF6c
 nMYHS2gcE2FHJ2qLSDYP+WBMGc6tbFpNWxkXmSZQ4ObPDrAk/RSOEiVVLE1oC23R1au/ShJK1qq
 /3k0UUgmdKwmK6A==
X-Received: by 2002:a05:6871:c8db:b0:49d:e4ee:659e with SMTP id
 586e51a60fabf-4a2a8a00708mr10063849fac.30.1791893878393; Tue, 13 Oct 2026
 05:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20261012170857.199561-1-hjf3108@gmail.com>
 <64707239-eac7-4259-a8ff-7ec43d13860e@suse.de>
In-Reply-To: <64707239-eac7-4259-a8ff-7ec43d13860e@suse.de>
From: Jie Feng <hjf3108@gmail.com>
Date: Tue, 13 Oct 2026 20:17:22 +0800
X-Gm-Features: AclHuK_mJZ03myM_AtOCYvoNr5sOjN6GcRZmHXgY4Oy3jSRdKK8mjAhisQLh4IY
Message-ID: <CABOQOSXgG2kBzs2sBEE69mmPcO0cKVgjyk_6DG5RST_4uL2+sg@mail.gmail.com>
Subject: Re: [PATCH] drm/format-helper: Add XRGB8888 to UYVY conversion
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
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

On Tue, 13 Oct 2026 at 15:11, Thomas Zimmermann <tzimmermann@suse.de> wrote=
:
>
> Hi
>
> Am 12.10.26 um 19:08 schrieb Ho Jie Feng:
> > Add a helper for devices that use packed UYVY but accept XRGB8888
> > framebuffers.
>
> Is there a description of UYVY available somewhere?
This is for a reverse engineered usb display adapter, which accepts
input in bytes of U, Y, V, Y in that order. I'm not sure what
counts as a description, apart from it matching DRM_FORMAT_UYVY?

This patch is meant to move this out of the driver:
https://github.com/rhgndf/ms912x/blob/main/ms912x_transfer.c#L153

> >
> > Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
> > ---
> > This is used for a driver, ms912x that I will be submitting. It only
> > supports uyvy framebuffers.
>
> Please resubmit as part of the driver series. We're not going to merge
> it without callers anyway.
> ...
> For naming, please follow the conventions used by the other helpers in
> this file.
Will send the driver in with this patch and its fixes, thanks for the revie=
w.

> ...
> > +             v =3D drm_pixel_rgb2_to_v_bt601(r, g, b);
> > +             u =3D drm_pixel_rgb2_to_u_bt601(r, g, b);
> > +
> > +             transfer_buffer[dst_offset++] =3D u;
> > +             transfer_buffer[dst_offset++] =3D y1;
> > +             transfer_buffer[dst_offset++] =3D v;
> > +             transfer_buffer[dst_offset++] =3D y2;
>
> Rather that writing bytes individually, use put_unaligned_le32() or a
> similar helper.  Byte order within a pixel is little endian, although
> I'm not sure what this means for UYVY.
This is meant to be sent over a usb transfer, so byte order needs to be
the same on both little and big endian systems.

> > ...
> > +static inline u32 drm_pixel_rgb_to_y_bt601(u32 r, u32 g, u32 b)
> > +{
> > +     const u32 luma =3D (16U << 16) + 16829 * r + 33039 * g + 6416 * b=
 + 32768;
> > +
> > +     return luma >> 16;
> > +}
> > +
> > +static inline u32 drm_pixel_rgb2_to_u_bt601(u32 r2, u32 g2, u32 b2)
> > +{
> > +     const u32 u =3D (128U << 17) - 9714 * r2 - 19071 * g2 + 28784 * b=
2 + 65536;
> > +
> > +     return u >> 17;
> > +}
> > +
> > +static inline u32 drm_pixel_rgb2_to_v_bt601(u32 r2, u32 g2, u32 b2)
> > +{
> > +     const u32 v =3D (128U << 17) + 28784 * r2 - 24103 * g2 - 4681 * b=
2 + 65536;
> > +
> > +     return v >> 17;
> > +}
> > +
>
> These helpers seem too fine-grained. IMHO it would be better to have a
> helper like  drm_pixel_rgb_to_uyvy() that takes two RGB values and
> returns the assembled 16-bit UYVY value.
Makes sense.

> Best regards
> Thomas
>
> >   /*
> >    * Conversion from ARGB8888
> >    */
> > diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_h=
elper.h
> > index 2b5c1aef80b0e..e50f96e07484c 100644
> > --- a/include/drm/drm_format_helper.h
> > +++ b/include/drm/drm_format_helper.h
> > @@ -136,4 +136,8 @@ void drm_fb_xrgb8888_to_gray2(struct iosys_map *dst=
, const unsigned int *dst_pit
> >                             const struct iosys_map *src, const struct d=
rm_framebuffer *fb,
> >                             const struct drm_rect *clip, struct drm_for=
mat_conv_state *state);
> >
> > +void drm_fb_xrgb8888_to_uyvy(struct iosys_map *dst, const unsigned int=
 *dst_pitch,
> > +                          const struct iosys_map *src, const struct dr=
m_framebuffer *fb,
> > +                          const struct drm_rect *clip, struct drm_form=
at_conv_state *state);
> > +
> >   #endif /* __LINUX_DRM_FORMAT_HELPER_H */
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG N=C3=BCrnbe=
rg)
>
>
