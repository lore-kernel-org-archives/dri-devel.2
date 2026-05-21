Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DFECD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 19:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D412610E550;
	Thu, 21 May 2026 19:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="lkOvdBwQ";
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9991410E55C
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 19:29:00 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-439cc157c21so3200216fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779391740; cv=none;
 d=google.com; s=arc-20240605;
 b=EYd+2u9HnamV5kmjLRt9EFV5lJOwgg602O/VfyCaXtKrQgLkwaZxEnexHENjNybBlt
 QVsXAdiWh19qK8e0r2WRYzajxL9LeHBK1X7c1i8PrpGKxky4JnCmV0j5+jziCVzLqbYs
 /TOMGek94kQEbd6wM189JJXYOMfORizcVOVX1Vwo1o6aidcwntEFHihfkhNAQ5WBlIv4
 EMbO6YvCrSYwQwIoZYx8e+g/vQZpPmWpvP2f1nLV4P6WvEovq2+imQPh/of9ivhgXHj+
 kOoK50HMUvfZxIF8woWkm44YpldvvjxfY0hVX28Ls6vsP9L77HNRJlt66z6lNzr5kUez
 Vu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7ws4Wuj3CXZZNtq4EC+PMmQ3IvviWpx3ix3T35qEpAQ=;
 fh=f5yxif735m/nYTC6665b8ngUNIsMDVjtCSUZMDmj0Eg=;
 b=ZzK0unui/C/XNUpypqsTj8Xoej2E78BBVWxNjgL9jOXGV6HkgjA2FtQsGL/9fDiawr
 HgyPXSewtCO6GJt8/NwBY7R3QthQ/6E0fIg4euJhVouS8Pg8TfPay4WCWugqEwgypFVh
 X+fCWzgBfTzyuc7uGDLO2YsPvIu2fQFkClnEbszpDM7jabEtlKc4jiZetbK8g/Iwh34r
 /7c9x2g3z6wKytvWELY8Xa1v/DDt4ZHJIuxoFiMbjUyFWfXDdq2lI0Zi6sVULYFq7mTv
 IQcEWKDzS7LCBxMxkN8k2bl8h+6oYZ9XX4ffodK4W+IeA4PS9xFDd3VLRixnJY509DTg
 Yy9g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779391740; x=1779996540;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ws4Wuj3CXZZNtq4EC+PMmQ3IvviWpx3ix3T35qEpAQ=;
 b=lkOvdBwQZloOsTveTWFaja1Dieuhw7jgKYBJvxE1ELnb6wjCi2a0sUJA5e5UcE26yO
 h38yX6zkoPfMHQWY8uXJRqIBnMlqUNwOM19GZkwaAMSfSVInt2T+WVNydQi9OhEX7swB
 KRN2/0FT6Tl3tvi3h94FEDBU+inHJGn6VrlailO1K7tJZRAss1ieKBh/nZVwj8UsvTTL
 pfUx1mFl+QSKlLs8mgoq5eNauNCkTG7tTkDTg7XGRzgUd0VjJ091VlE/AjEcuNNIbnru
 J/unE1YjhT9rfgXiLroCzfMgt+IegqnERfv6sTZrHzJ6zVaRiBgIxV65gf7cRPEAdx1b
 PJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779391740; x=1779996540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7ws4Wuj3CXZZNtq4EC+PMmQ3IvviWpx3ix3T35qEpAQ=;
 b=fJNCtWm7lihDtwtDpYrM0vlsdFLyIWGUuKRlSk2bcv8wm8VP6Pk8DLZKrmfsG3y6mS
 hl9YH8289QSsRDO0Gt5I4G9JCOIg0qN341JarSqyH3OOG0wBQW5WrpKOdjH2cLiAEVj5
 o/dCVfH9JVLbPV3vsHKftumK6v5HlWkEfSaazj4LYh5a+9wdky8iSiEz9UOy6uOA/6y2
 3CXS84gwZYjOQyVQMypgX0BzLF5m6ZC0Pv/wnwQqIh/hZdwvo2VFljL9tHmjrctq2xfs
 tAbQ7gnEDkwi0o5Ob1U1kzlhIz2uebV7dPPS7bpaWa1I7C5kql4Obct7NyXqj9I2RRXk
 H/Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BoLaVUROyG5jRQzLnq6gTw1LyukregYQjabWYhY8Uw6jx12jQiuoZPctnFLMAfmY7M6d/FWVfZyc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6U3QU8j3iGofUiofs5lcAIwxKXJj4u6vG0laKlQ/SMqN4W3IT
 SGGZYC2EXrPySTdDQ+rmyaUhyjpI3tH7C9YPqc6BBsBUW3aFkoJeTsmQSyXC7Kr07O6OuWe1ZuU
 M0EjjIxmbE4ZHUbvtFcd7OkDgoNHNjhZc2WlOzt/w
X-Gm-Gg: Acq92OGRTAm1Q2u935hX7Bnvjge4CbDMUh4idHvN2VqfeJc8q60JpU9H8l+FrbiM+A4
 7G8BZSP1ZdjMKuZKgJRaYuBkHWFFMI6fhgsNMcemj0xp7lakAsQ8TspF4XXAE+BvXLu788f/TPw
 XMjSV1leTfBGkCbEUbnH3JGQ5NIyVSOLMIZasnMIq3Yn98SfmxR9Y948JCSOi3T6ltUUybc5xnO
 tMlXXepZGU2RtiNJO9rnEyF1/szuyPNx+dcQ6mPwtRqiuJJ789VOgbR1N/h/inlpRm5dU7SDcDn
 fS6vDOwC0byegPxUlZKthBwoivK3ZqLFHjzZU9ivtRhmd3ZpBfmx5LlVtviONp0vM/QqzuadVbU
 eWM7SX/1l539juwcZ2GoMNF/v8BkKZQGR7WHXEZEtI4Jm3nC2DWbby5mAMMbZ
X-Received: by 2002:a05:6871:4390:b0:42c:5ce:3fbf with SMTP id
 586e51a60fabf-43b5aa61c4fmr270735fac.13.1779391739185; Thu, 21 May 2026
 12:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260521180143.2143262-1-sean@poorly.run>
 <6d8e36e2aea806f9973b3c501aad4523f7316d6a@intel.com>
In-Reply-To: <6d8e36e2aea806f9973b3c501aad4523f7316d6a@intel.com>
From: Sean Paul <seanpaul@google.com>
Date: Thu, 21 May 2026 15:28:21 -0400
X-Gm-Features: AVHnY4L2anUydq_L67QU46fv9RB9GULiXwcGBVPw2CKypMRulFNg7KoJtoZEDCs
Message-ID: <CAOw6vbL-+YZED15LFH0PRbxWbKhkOohNd+fnJMmVtdvF=A31RQ@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/color: Fix plane color pipeline programming bugs
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Thu, May 21, 2026 at 2:39=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Thu, 21 May 2026, Sean Paul <sean@poorly.run> wrote:
> > From: Sean Paul <seanpaul@google.com>
> >
> > Fix two bugs in the plane-level color pipeline programming:
> > 1. Fix a step discontinuity in the Post-CSC Gamma LUT when SDR dimming
> >    is active by clamping Segment 2 to the last user-provided LUT entry
> >    value instead of hardcoding it to 1.0 (1 << 24).
> > 2. Fix a typo in the loop condition in xelpd_program_plane_pre_csc_lut
> >    for Segment 2 degamma programming, changing 'while (i++ > 130)' to
> >    'while (i++ < 130)'. Also clamp Segment 2 to the last user-provided
> >    LUT entry value instead of hardcoding it to 1.0 (1 << 24) to fix
> >    a step discontinuity similar to the Post-CSC fix.
>
> One fix per patch, please.

Ack

>
> For #2 there's already [1].

This isn't in drm-tip or drm-intel afaict. I'll drop it out of my set,
but could you please apply it?

Sean

>
> BR,
> Jani.
>
> [1] https://lore.kernel.org/r/20260519075245.383864-1-pranay.samala@intel=
.com
>
> >
> > Signed-off-by: Sean Paul <seanpaul@google.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_color.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/d=
rm/i915/display/intel_color.c
> > index 2d318e922671..9b807b024ec3 100644
> > --- a/drivers/gpu/drm/i915/display/intel_color.c
> > +++ b/drivers/gpu/drm/i915/display/intel_color.c
> > @@ -3953,6 +3953,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb =
*dsb,
> >       enum plane_id plane =3D to_intel_plane(state->plane)->id;
> >       const struct drm_color_lut32 *pre_csc_lut =3D plane_state->hw.deg=
amma_lut->data;
> >       u32 i, lut_size;
> > +     u32 lut_val =3D 1 << 24;
> >
> >       if (icl_is_hdr_plane(display, plane)) {
> >               lut_size =3D 128;
> > @@ -3963,7 +3964,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb =
*dsb,
> >
> >               if (pre_csc_lut) {
> >                       for (i =3D 0; i < lut_size; i++) {
> > -                             u32 lut_val =3D drm_color_lut32_extract(p=
re_csc_lut[i].green, 24);
> > +                             lut_val =3D drm_color_lut32_extract(pre_c=
sc_lut[i].green, 24);
> >
> >                               intel_de_write_dsb(display, dsb,
> >                                                  PLANE_PRE_CSC_GAMC_DAT=
A_ENH(pipe, plane, 0),
> > @@ -3975,8 +3976,8 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb =
*dsb,
> >                       do {
> >                               intel_de_write_dsb(display, dsb,
> >                                                  PLANE_PRE_CSC_GAMC_DAT=
A_ENH(pipe, plane, 0),
> > -                                                (1 << 24));
> > -                     } while (i++ > 130);
> > +                                                lut_val);
> > +                     } while (i++ < 130);
> >               } else {
> >                       for (i =3D 0; i < lut_size; i++) {
> >                               u32 v =3D (i * ((1 << 24) - 1)) / (lut_si=
ze - 1);
> > @@ -4023,11 +4024,11 @@ xelpd_program_plane_post_csc_lut(struct intel_d=
sb *dsb,
> >                                                  lut_val);
> >                       }
> >
> > -                     /* Segment 2 */
> > +                     /* Segment 2 - clamp to the last LUT value to pre=
vent step discontinuity */
> >                       do {
> >                               intel_de_write_dsb(display, dsb,
> >                                                  PLANE_POST_CSC_GAMC_DA=
TA_ENH(pipe, plane, 0),
> > -                                                (1 << 24));
> > +                                                lut_val);
> >                       } while (i++ < 34);
> >               } else {
> >                       /*TODO: Add for segment 0 */
>
> --
> Jani Nikula, Intel
