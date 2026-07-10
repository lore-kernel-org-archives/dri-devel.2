Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FCCC44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B5410E1D8;
	Fri, 10 Jul 2026 13:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QiOegJAu";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C292B10F8EB
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:27:36 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38096590070so209638a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 06:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783690056; cv=none;
 d=google.com; s=arc-20260327;
 b=F4OrrANRcuh9X7zuTzKz+yqSSrbpjn+JJo2kzYsZrjHgvnBLuN0HFIZsAXcZTnR4Sm
 p4eDW2ZUoA203XF56w5W9sBkwNOCp08bFeCDDUFrfUxakFkEGTA1nR3dZgScEpN2n27f
 wXNWWOQPH/DNGcFPMSA/FdqnsOsQj2dJlKKDqPnTX6SK2rbLmqnPwT7DF763JYuBgddu
 VH6wmno5ryVM3Tf05YMfa3IoOeRVslXHgNQ7pOlUir0P+CndpxB9aWsoCZT6/azs7ph0
 8dLAJdocxy+ICN2dhewWpa5b2Fy+jkti+bPSDrwnS5HRI0+RHENd8cs/Keb3JQY5hzBy
 dZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8Xz8mAiIS9bhxJSnBlNVStU7ycoiUswNHhwr3rObZng=;
 fh=ynoepbZjkm3j9pimh2LUBjGuaK4ZrRkyebdaalUFvso=;
 b=MRzN3gaHmTmlRp8b7Yi1O98CXfMJBAOXSiqAs0Hk9uv1/swIPsVV2F6LaHhZV7whe8
 51ofVojdmIsHrzBbXIAUGLadnzO1Gpq4S9NfwtN1xLQWZM/AFDLi/j9Jhdo9/Jyx8RJ7
 z+j0Sb+l/eXmqpHmyEEhDmzm+1gjCcmN6RW3U4Q6e8KDoUaoZ2A5PWtdwA8GfYQaOKWp
 u7CPlFaiCXAFbrrpXiF4kHZMcW2auiJ0Utakgk1dKe1T1iJCF4eXTY/sGiV1/gPlARC0
 Mfa5hGmvbey/lOJH2sCSB9yDt6Eo5ExjzRlyg3mX5yWsZZROHwR61Uiw/WloPZez7mqB
 BOaw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783690056; x=1784294856; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Xz8mAiIS9bhxJSnBlNVStU7ycoiUswNHhwr3rObZng=;
 b=QiOegJAu0Dati0+Qo2es+1AYTiX16oEq7iaiLSu1D7zDZwRkJnhG9TBcMNRnFS0D39
 2cBTI8XcKO0CEJWAtP5tgUt0fmDninA3ge3AlcqyC4awgo4yDXqQo601XnlqkTBv9uHX
 rjeCj3GxuchqHtJoxzWthwKPxnJ23RWBbX75dByjy9Y5ahFor9BGhVtM8NF4RjUk6nvh
 2g3zWrYcY734NAGfqKEZuNG6l23qnEUu7BbDssgKsP62miB4hSiCW/R0hbAhjcIT/dZw
 cRMN+vqL7HmEDPtv0OhQtek/nMAWh9RswNemljl4HnHhEVdtX2LseQlTzsqWzRukEUFq
 N42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690056; x=1784294856;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Xz8mAiIS9bhxJSnBlNVStU7ycoiUswNHhwr3rObZng=;
 b=Mp7gtSQ2B3VbtwgjBFPLofren/ZM2Vlru4FetcOpmZKXi4zqiKeMr6ofzPwy11bGwj
 cHcbTXeBK6PmINuI/HS/g2unVdqjj8lpQIV8EdICtSf25eV95BA09+0ohDn4faVOSmvR
 Kr39yhCBeBuTWWGVAZ6j0zGNdeD7WojqHnEQLtzKnQ41ss4K/7PrctajaVmUgNYRoixm
 h1cPVWE9GdtMEIBY8kAXUuFSnDYYo7Z32AxZtGa3lHxdpSH20q4LaXg1hsbkJ/KPU4YC
 EaNCOA64cL1b/1MsWTMVVReUgjSQxyA9KDaLcKB1ouMsljRydl4nmV2YzmGPaBi2k14r
 Pmhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpekOYct+RetgSR1cYwHoeomie0DOA86yDu0ek7RyWGQ34PRD6FY6Y8m2p++jwJMoeNP0z22Nyjnjc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtxpZ01QKDilSnrUByEqtC32N8QtMGiDmxpskM1XInJPVagrIm
 FlwEAUCNlit6jt64B8Op/UqMsORIb8B2EVC4PaiTfGquLDH5o1QdwvpS62SjfmaXJG5Bggr0XY4
 cztVVyhlHU/SaY6kRxpZlsDIHebU/kSK16g==
X-Gm-Gg: AfdE7ckn6tBQ3xXiB5qDjyHFxiexX+rI9wL5Bsah0BUhHqKLQF3vogdH5XS2jz7tcO+
 RHHgSB85CiAR82vAOqfQWreeSeA+amm6SpI+aFNfh2ne5PZZZYTLx2DtZQ65Ie+PlX7l44+ntxG
 Gi8V/RI2Kqs8feCGn1lbmaup3Le/LVY8nTJbAa7n3dsnGkUzF+GTEybUa+h/78rdf01KSene4/x
 8rPXzWK3BHQXeZlIFcsDBIS4b8XYcahYAa1SyyhUedzI86KEhBzBmUZC2iDD/0CcLKCW0mDuItd
 pzd0Lgw/rCc9tSCQUjlSLIeI70FXjfhQPkVLN2VKI+boc3kzsL38gb4iwMHjxWU53ztwVA==
X-Received: by 2002:a17:90b:390e:b0:381:77cd:38ca with SMTP id
 98e67ed59e1d1-38a20c48ce0mr6963500a91.4.1783690056153; Fri, 10 Jul 2026
 06:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260708222035.7324-1-nico.antinori.7@gmail.com>
 <fd5ecc7b-b9b5-4653-b7ad-72bdcd0b8518@suse.de>
In-Reply-To: <fd5ecc7b-b9b5-4653-b7ad-72bdcd0b8518@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2026 09:27:24 -0400
X-Gm-Features: AVVi8CfC8WMQvuOOX9IbEu4pHDNwlbHNhnBztQ4WqIxX3gf9mAdHkuUx5nllMac
Message-ID: <CADnq5_OBYXSz2HG7SCA2eK5_z1J0SmJCwCW2RkGJ5d1-tAVC6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Inline drm_simple_encoder_init()
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?UTF-8?Q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Brigham Campbell <me@brighamcampbell.com>, 
 David Airlie <airlied@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
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

Applied.  Thanks!

On Thu, Jul 9, 2026 at 3:17=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
>
>
> Am 09.07.26 um 00:20 schrieb Nicol=C3=A1s Antinori:
> > Simple KMS helpers are deprecated because they introduce an unnecessary
> > intermediate layer between atomic modesetting and the DRM driver.
> >
> > Inline the functionality of drm_simple_encoder_init() to remove
> > dependencies on these deprecated helpers.
> >
> > Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vkms.c
> > index 170adaf7e76a..d5b0692fe860 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> > @@ -2,7 +2,7 @@
> >
> >   #include <drm/drm_atomic_helper.h>
> >   #include <drm/drm_edid.h>
> > -#include <drm/drm_simple_kms_helper.h>
> > +#include <drm/drm_encoder.h>
> >   #include <drm/drm_gem_framebuffer_helper.h>
> >   #include <drm/drm_vblank.h>
> >   #include <drm/drm_vblank_helper.h>
> > @@ -316,6 +316,10 @@ static struct drm_plane *amdgpu_vkms_plane_init(st=
ruct drm_device *dev,
> >       return plane;
> >   }
> >
> > +static const struct drm_encoder_funcs drm_encoder_funcs_cleanup =3D {
> > +     .destroy =3D drm_encoder_cleanup,
> > +};
> > +
> >   static int amdgpu_vkms_output_init(struct drm_device *dev, struct
> >                                  amdgpu_vkms_output *output, int index)
> >   {
> > @@ -342,7 +346,9 @@ static int amdgpu_vkms_output_init(struct drm_devic=
e *dev, struct
> >
> >       drm_connector_helper_add(connector, &amdgpu_vkms_conn_helper_func=
s);
> >
> > -     ret =3D drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VI=
RTUAL);
> > +     ret =3D drm_encoder_init(dev, encoder,
> > +                            &drm_encoder_funcs_cleanup,
> > +                            DRM_MODE_ENCODER_VIRTUAL, NULL);
> >       if (ret) {
> >               DRM_ERROR("Failed to init encoder\n");
> >               goto err_encoder;
> > --
> > 2.47.3
> >
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG N=C3=BCrnberg)
>
>
