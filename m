Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D7FCC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FBC210FE92;
	Wed, 14 Oct 2026 16:20:41 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A66610FE92
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:20:35 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-6dfc4510440so2663716eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791994834; cv=none;
 d=google.com; s=arc-20260327;
 b=gGanXfnKtc53LZySkeVHea6eS6tnjYxkE5jdfjBr5TlOl3BFuI14ZsHDDjjw8uaiKZ
 ExZ2R6HuDsfu91IA/4XIg0IXDqlA0KSih9JKEb8V/uej18TComrLqGvYIpIOVtoZ8rtl
 i2kd3D315oz+bfTEtgJVqyc+OVaGmONmxveEruWAVPcSNt45e/PEPY7u6xSs8gP1S5X/
 AsaD9j0W/jIg3JLlmeGXz58LZGCDxndDDXZGbSwCWz5YBm8Qk+avYQxSY0PNLugl+Ose
 5zc+SBRcsj7H3kkbsHyxoCWHWYKE/qAREJFVsj3SI6lOlFLiMBU6MkQwF2+q4EC2MYBp
 S5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ammrCi5lWW8CQm6Nxwkl2IMJ3J+LU9Xyj7wXDb4386U=;
 fh=iIfmz3BIijL6BOsMKNq6GtWj38luR2KrNgxVDOKaN70=;
 b=pc7sRnYPZH5/aKGMssU7xpQBknmBgVBMm0Gm+Umj+gX41ueuqsdc03jXEyRx44Nl+s
 gKRPlAh2+ARGLi6d0KPR/ML3tmVoAefR+5m4r6/Vhfgp7aIt/WKi68rnknoJM1O04D+x
 VMx1VuiDa0iOe3VzSUUnGtM1YSLjF2SSMHPOSm3LrSzoy/a7KfbwPEXSQLupA6YBUlj0
 WawjdyHIwYu73TZa6vvRmRG2npIldphkGQndVLUk2vGGUIRLYhhv09tlYjCDQmmqGdse
 tI23GmEWzC7YpWtQcKFHKeGZsvwqbqMPtYsbUma5OR9oPm6eH9dqNN1gPWQkEKCDdNQM
 PSBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791994834; x=1792599634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ammrCi5lWW8CQm6Nxwkl2IMJ3J+LU9Xyj7wXDb4386U=;
 b=NI16fX6++NASAVFCz/9CGiJzgxt+u9asu7pN8LVHy5S3Z1lbuSwHDL/TKJkLj7EjSP
 fHghaW6biZMPxq9o1PgiffWOK7Ru27lgJX9aOghoZgJinT7B0V+/oUNoZgCPtvqaiqcw
 rRM/hyMUkR5WcFpIqYXjxGUjoMOiyCGJT+/0xbu9+VFv7ZPIM2pu/1s93QTDbbSxxRu/
 32yScaoSr80esMHY+TWxsava0+eio8FO2ki9dMeEKa1V0UCXP5J+tM5T+oJjR0BC6yKj
 L4s+Kopx0KCJju04ON9mp/lzuiEP8SmnZYWzwMlyusuigwLXINPM8sreVmZMcQDoq7JQ
 JIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994834; x=1792599634;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ammrCi5lWW8CQm6Nxwkl2IMJ3J+LU9Xyj7wXDb4386U=;
 b=qF5k30BY3PILSCCwbWQhc+GfYr1Kdb5Z8MuVvnJfSkp8DEyxmFntmJegwksirriZFn
 4UEMjEckNJiuiZHyLIGll7kWCy3jV+YlfVTBKJVnm1a17BBq2Ddw2awARd4xUQMe3te6
 GxQbt6DaEvWzI9WyQVtr73XtT3VUV5AlEyR1ELrXAWw31i+0rqlIbm8h3t0+1XPVeOZL
 DZpKMr31QAuFHeKMRc3Qe3JwH8r9L96En1Pp3N8xP+q+n5Oor/Oh4eAZ/T+z1gf4VuiI
 F5IQURkN6wpFUjpqSF2sibeIluIf8c/kSJr+isnDiooU9829e1PRK5fHKWgMxWpw1r/q
 iPfA==
X-Gm-Message-State: AFq9FYIJ1edV4sOkP6IvQ/nqARBmwTLBDR2dgH0Aw5dq4azOntfkMoaq
 eqJzNxAqEUxrFIcNUOw1CDMeO2dfULjhwMHY2IrzqH+wxfTb/29b4D8F55FKm4YhEYBruc4nYu6
 2wvXV9gOLTmcrpzh7q5sWwWAM5RL/LHg=
X-Gm-Gg: AYBFou2VV+JPG/l430f1mzP2irglTmAcDEolFM/1VXcPTpMNsZD4ZdEeMMvbXDzAi8m
 MnsSD3T0EThNTcnSEMU0Jbn88+wPZ/upnn6bhNSf8y96OS/TmJkHKe11zKuqgeoyVZPTcv1eAh/
 JIU/UxWKhLaOm9Rx8Y5dl1R+FUv3lUuUHSjy8EZSB9pvl417gcxvNWnqnWfd3kSWrwAxoyhdAkp
 KLnC0uEKQ+vOVInmZK1oBZsUwrs/7Ld7L8WofMrWFotJ740qfW2POePDk+mLU1Zz8IWLC2JXU1s
 LlTidVMveKRGeqDts1IwOnSQKIGSzpxkh2bau5VmnxR/VgIFS0R/a0VhqdCQcaV6/el9PVMY6W6
 J/gIodkehDlWZAg==
X-Received: by 2002:a05:6820:4c8b:b0:6d9:1ba8:7e3f with SMTP id
 006d021491bc7-6eee446ec53mr11086455eaf.49.1791994834621; Wed, 14 Oct 2026
 09:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20261012170857.199561-1-hjf3108@gmail.com>
 <64707239-eac7-4259-a8ff-7ec43d13860e@suse.de>
 <CABOQOSXgG2kBzs2sBEE69mmPcO0cKVgjyk_6DG5RST_4uL2+sg@mail.gmail.com>
 <c9460a8d-3fdf-439f-9655-82b60617b85c@suse.de>
 <CABOQOSUE17pQQYydLxCLHg1Jg90dwCEvMZYyo6TzYHMn9RAL2Q@mail.gmail.com>
 <fdc5b911-407f-437f-ab05-33d1287e20da@suse.de>
In-Reply-To: <fdc5b911-407f-437f-ab05-33d1287e20da@suse.de>
From: Jie Feng <hjf3108@gmail.com>
Date: Thu, 15 Oct 2026 00:19:57 +0800
X-Gm-Features: AclHuK8O-BspYB86WXY2JYISSnm83sfhUSUuKRxBs_LC6CJMRni-SeacCv5PZgs
Message-ID: <CABOQOSWf1Yqt2E+hXC5bPxJhjKNJ_W3AMX30k-stNZzQG32F9g@mail.gmail.com>
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

On Wed, 14 Oct 2026 at 17:03, Thomas Zimmermann <tzimmermann@suse.de> wrote=
:
> >>>> ...
> >>>>> +             v =3D drm_pixel_rgb2_to_v_bt601(r, g, b);
> >>>>> +             u =3D drm_pixel_rgb2_to_u_bt601(r, g, b);
> >>>>> +
> >>>>> +             transfer_buffer[dst_offset++] =3D u;
> >>>>> +             transfer_buffer[dst_offset++] =3D y1;
> >>>>> +             transfer_buffer[dst_offset++] =3D v;
> >>>>> +             transfer_buffer[dst_offset++] =3D y2;
> >>>> Rather that writing bytes individually, use put_unaligned_le32() or =
a
> >>>> similar helper.  Byte order within a pixel is little endian, althoug=
h
> >>>> I'm not sure what this means for UYVY.
> >>> This is meant to be sent over a usb transfer, so byte order needs to =
be
> >>> the same on both little and big endian systems.
> >> DRM formats always refer to little endian. As it is implemented now,
> >> it's not clear what the endianess of your output is. Please duplicate
> >> the other helpers' logic. They all pack the output with appropriate
> >> helpers. If the USB device requires BE, you have to write a separate
> >> conversion helper for that.
> >>
> >> BTW, you have an OOB access if the line width is not a multiple of 2.
> > How should I handle this? Rounding it within the helper doesn't seem
> > to make sense and the function return is a void, so it can't return -EI=
NVAL.
>
> It's the callers responsibility to pass in enough pixels. You'll have to
> take care of it in the driver by rounding the damage area accordingly.
> It's not optimal but it's not a big deal either.
>
> In the line-conversion helper, simply round down to the nearest multiple
> of 2.
Yes, that is already done in my driver.

> >
> > Other helpers ignore the -ENOMEM error when drm_format_conv_state_reser=
ve
> > fails, so should it follow this convention?
>
> Do you have a specific example?

The call chain goes like this:
drm_fb_xrgb8888_to_rgb888
drm_fb_xfrm
__drm_fb_xfrm:
        stmp =3D drm_format_conv_state_reserve(state, sbuf_len, GFP_KERNEL)=
;
        if (!stmp)
            return -ENOMEM;

Since drm_fb_xrgb8888_to_rgb888 is a void, it calls drm_fb_xfrm without
checking for the return value. Similarly for other drm_fb_xrgb8888_to*
functions. For the uyvy helper it could just return without
doing any work if it is not a multiple of 2, like in the -ENOMEM case.

> >
> > Alternatively, drm_fb_xfrm can be exported, and let the driver define
> > the rgb->yuv coefficients? But I think it is fine since _to_gray8 also
> > cites BT.601.
>
> The current constants seem fine. With the 2-pixel alignment, there
> shouldn't be any other cases required.
>
> Best regards
> Thomas
>
>
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
