Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E25C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E349910E0E0;
	Tue, 14 Jul 2026 21:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=asu.edu header.i=@asu.edu header.b="LY3rLhtu";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56D7D10E0E0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:49:03 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2ceb096e675so37992605ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784065743; cv=none;
 d=google.com; s=arc-20260327;
 b=rMsL2WFFIH7MelDm+2bbEw1sxNyOLV1q1FE8O+Xf2Oe2SKXlTd0x+7C6sX2GFDQQBn
 tvWIY4y2r6AmtK0K3sUOwqwGPTLqtw/oETtUaWuE59qPQSuDQ+8rOCxJTUmhpsvendLk
 hZ25vj5ngAejJ3C1A75TPlUnFsHiEbhsaB9gt970xvPKW0Lw8KFVMxU83lfnMXfHKIfr
 2g3hEE0jhZt5mrMxy5YrxivM8y/Gkrk+eoDZDoCl1OH+RdeGRr7UUr6PTsuLkI3P/dkv
 5TjRsSJSJkeeL3mLrcl/OWiaS9F7rMV1JnAvXVPIS2XxyqUcZvlkxgSmpgwLsE5w9srV
 i7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KiEkozbG/zzeFhbURXvQxjJe0ZNLrQY5+aHS5HFfXJU=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=qUEUtAG/DjwvgK1RmgnrlgZk7m3+XuBKVhe1h58U8gDRAi6zhg9K7ITw57lp0kM60R
 XR4j2ipRm9HT0ndg5SqeSEA126NFH/OM8m5bv94mDZYwEFIQZhLHIQf4vwIHOFQ8KVnf
 0AXzR6ungD8JyJ3EQJ0KiFur5zZu7CQvyi5p8Yop/eN1Zy7inAqeraw7TDhf3wpv0cF9
 EjBik+eWnMlrDgawDKV17gpThwFyNKokkAWUymn1OL3nb2m14tpNb0kJCYhT83xzs6yd
 xu3vFGNOX3gkHrAQsfaQzpRGxjyHFaEK0ZPBkAn1d6IcEFkq+qwKfiDkUOBMZS6oDnsG
 igug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=asu.edu; s=google; t=1784065743; x=1784670543; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KiEkozbG/zzeFhbURXvQxjJe0ZNLrQY5+aHS5HFfXJU=;
 b=LY3rLhtu8xYVZIDtj3xUV3tlqH0XBQlZSM/8m/Z2Qm+Hv6xNTGzkUgW7Gk9SOVv1Ni
 BP3xnnJIrx3TSIhPMs4BI2XNjg8yjfY9hK2tCGR2HGHy7xHVGyvuUYcwHIm9XwflYptT
 b/ZiYinHbqPHXQvCoru4eEY3RgYerHcSE/zPvsobRiFz3lC7pGuH2LGraa1+rYa49ZCC
 c0Wrtg9qr26oLfDwrtTy/UJlS+W1V+/hBtHS978uqH7YpZhoJXILu+Q7moog9l6qelsN
 jOLeKIji4g1MzWRu9ktRUhZSOW/1MCGKVgj9nR5YGKUJwjm9vm5bSaxP5VGvHtmxm8Ap
 QUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784065743; x=1784670543;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KiEkozbG/zzeFhbURXvQxjJe0ZNLrQY5+aHS5HFfXJU=;
 b=AKZDTRYsBM5GELVjAB/kTJu6fFjB6HhKKElPb8D+hAVSUPir7HobM43TfimN3D7ZIK
 RkgTGUIjBUAhq4Ps8ykPAifbz0Hvj2hJc17sG8dKscSZCYngnKtzoDnCenbGt67QKKIG
 0UK6+Zbv2ugBxJiciGl/nXl2are3tyzGHE3T51WV95opRlk4P9SemUCres70c3OEi/PS
 Qpktr3dzO6MQiUuYxa/B5QODZVsF3241mIfF572ox5P+zmli/RvfCu+fFCl54CQWzo9V
 FOLD/4DTFBXsVdpv1tKO3IAzj1X4GPO7TVW/5fCso7eFzZaVWRue8G9C7AmzIEsSge9g
 mRSA==
X-Gm-Message-State: AOJu0YzApZAEMrKLeK6YGgr899tEY/p91zws06VubNXrLSrK1lctCWI+
 utqds8mFo9rf6hZcKrEhbubxPG5lXf93dL09wTKk5Pl0mDLav0lvwPlMHObYBziOE1R3PB3V5WJ
 MSdMrpu+5ABcc8UzMQuyTivi0sS2OdjEh4t+01ePe
X-Gm-Gg: AfdE7cn3+x0oH1ShKdXqDpShVafBJp0Rw14RGdyPhqiVnrAHbVOIgvKyr+Rsotq5Pql
 92YvsmadYKfPP6/FH3yfLb9prMoCYWsd1f+52EYRuVlCkrZaNzUB324TghU5AyeavzOS0tY45vR
 WN6SUVO95PK0aSl40KHEWRCHshIMZMZwNeewaBpbEdEJ0PSDYZlwewa63QUsIRY1vDJh20+hxQp
 m6GiwO4feEAlaKHDqCmE6zIMUOnBaDtRViQxLpg0GIi32X2pNOi23C+x5D1iY8Rztbo8Hurzdjl
 /X+EgPTIsLv967qCtDkVBuFyIvS6+CpVvHpzcz8=
X-Received: by 2002:a17:902:f548:b0:2c9:97a7:3278 with SMTP id
 d9443c01a7336-2cf03d55d5emr1967745ad.41.1784065742737; Tue, 14 Jul 2026
 14:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260711230728.2250485-1-xmei5@asu.edu>
 <20260711232012.E57081F000E9@smtp.kernel.org>
In-Reply-To: <20260711232012.E57081F000E9@smtp.kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 14 Jul 2026 14:48:52 -0700
X-Gm-Features: AUfX_mwevLG8KMsflcSbp_AaCwRgqd89gYVracTIBY8fjD6NVrH4fqTpmwVqwrI
Message-ID: <CAPpSM+ThxPjj0uyfGfmGpu51jL9mKQt=OJU-9J=gS38vzu6r9w@mail.gmail.com>
Subject: Re: [PATCH] drm/modes: reject out-of-range GTF blanking duty cycle
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
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

On Sat, Jul 11, 2026 at 4:20=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Medium] Unchecked `vrefresh` parameter from kernel command line can ca=
use multiple divide-by-zero panics.
> --
>
> --- Patch [1]: [PATCH] drm/modes: reject out-of-range GTF blanking duty c=
ycle ---
> commit c78fc29b3d453bf33d5cd88746572b5f1e9a5c60
> Author: Xiang Mei <xmei5@asu.edu>
>
> drm/modes: reject out-of-range GTF blanking duty cycle
>
> This commit rejects GTF blanking duty cycles of 100% or more to prevent a
> divide-by-zero error that occurs when the divisor (100000 - ideal_duty_cy=
cle)
> evaluates to 0.
>
> > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> > index e1eed13a8e94f..291037706b587 100644
> > --- a/drivers/gpu/drm/drm_modes.c
> > +++ b/drivers/gpu/drm/drm_modes.c
> > @@ -966,6 +966,10 @@ drm_gtf_mode_complex(struct drm_device *dev, int h=
display, int vdisplay,
> >       /* 18.Find the ideal blanking duty cycle from blanking duty cycle=
 */
> >       ideal_duty_cycle =3D GTF_C_PRIME * 1000 -
> >                               (GTF_M_PRIME * 1000000 / hfreq_est);
>
> [Severity: Medium]
> This is a pre-existing issue, but while fixing divide-by-zero crashes her=
e,
> could an unvalidated vrefresh parameter cause other divide-by-zero panics
> in this function?
>
> For example, if an administrator provides a kernel command line parameter
> with a refresh rate of @0 (e.g., video=3D1024x768@0), vfieldrate_rqd
> evaluates to 0. This would cause a panic earlier in drm_gtf_mode_complex(=
):
>
>     hperiod =3D 1000000 / (vfieldrate_rqd * vtotal_lines);
>
> Also, if the refresh rate is @1818, tmp1 evaluates to 0:
>
>     tmp1 =3D (1000000  - MIN_VSYNC_PLUS_BP * vfieldrate_rqd) / 500;
>     // (1000000 - 550 * 1818) / 500 =3D 0
>
> This leads to another direct division by zero:
>
>     hfreq_est =3D (tmp2 * 1000 * vfieldrate_rqd) / tmp1;
>
> And if hfreq_est evaluates to 0, it causes a third divide-by-zero on the
> ideal_duty_cycle assignment above.
>
> Should drm_gtf_mode_complex() validate the vrefresh parameter before
> performing these calculations?
>
Good catch that those divisions can trap too, but they're on a different
reachability tier than the bug this patch fixes, so I'd keep them out of
this change.

The @0 and @1818 cases you describe are only reachable via
drm_mode_create_from_cmdline_mode() (drm_modes.c:2557), i.e. a
`video=3D...@0` kernel command-line argument. That's root/admin-at-boot,
not a crafted-input boundary.

Xiang
> > +     if (ideal_duty_cycle >=3D 100000) {
> > +             drm_mode_destroy(dev, drm_mode);
> > +             return NULL;
> > +     }
> >       /* 19.Find the number of pixels in the blanking time to the neare=
st
> >        * double character cell: */
> >       hblank =3D total_active_pixels * ideal_duty_cycle /
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711230728.22=
50485-1-xmei5@asu.edu?part=3D1
