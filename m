Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084AE606A333
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fv47qaTm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6660210EA6B;
	Wed, 11 Nov 2026 15:52:07 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4575F10EA6B
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:52:01 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-33bb5afa736so87629eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:52:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794412320; cv=none;
 d=google.com; s=arc-20260327;
 b=qXrDandJt7bS+xWeqJaH0UAtuTJ80n/cYmzIbBP3J1592Qj2W35Qy5kzp+XhkJ7U/L
 2NWZGSpJ37MlwKfaC/xI7556mpfaZDZVDRz5zDqrvBHZqgDJvbC0Tqcxb2CtObwDuvKL
 X0v246aDMaWYWHEZMQ8/eLDTe467gkMkSkcEQQibGNK0ubiiftDoA3wPrCWj2ibCHDaD
 Zrb9euPPPjr+7zQwFinMyxVVxN7bCwUqSV/HX9eIpX0bUQEWjkDlHO8Gno5FhyhmVIaH
 UjGAIv2xpH7C99gpi/UN3qNI6baEx6Ypnqa0zHmWj1QBALbQe1OmDadXU2ix21Bqqy4l
 seZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KBQmXpergQV0k3yAGb4YmxsK7ApjQIjQQTJj+akkdKY=;
 fh=2KYZG+vINQNh0SyYPWm9lKNmz7s/hNsjAv6PYTmCKeg=;
 b=BSkMqVYji+9h8LgUp2Y0aulqLfsB8Lt53AuhRbR0M7M+WqeimPD1ZUEIvbhJUgbBdX
 VW+bKNQ6/D4YiH0IzxpgK5FKSDQnpHRusuaTnEsGv+Q6LrmkxeXQuZFV46MYuW8kheHT
 wyN1UMEY8C9GCJH3iwTTGauDaNwKCeWL3lKuFWGY+WLFr9R9fBcyEc0nZ1EGGpimJFSQ
 TWLl0kotelOalrcxeLIlw5hp70OnDI4yZYLzVgvgxfqzjs3zgpMYLkSPX9dbu1o8plQ4
 670mi1YyFme4wHEjvqyVSPqmB9gxd44Pv1078ld198APkP1Wmh01Al15Ut3qWbwu0nLq
 k/ow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794412320; x=1795017120; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KBQmXpergQV0k3yAGb4YmxsK7ApjQIjQQTJj+akkdKY=;
 b=fv47qaTmBvXEMPG79Z3ghFoNqIxWFhQQ3rx3YmAVERLqUJ2SMxEw1K47eILxKKY3wb
 Hdku5bzxOvzB9LXRgL3U1WXKFdJVs9kp5JNPbtIWfrK2fM05MEf1XC+ww6nJXU01wTd/
 7TjHSeGG8bGyB6rsW306vampTxQ0Ix1J2e3r4lhO0f7ATISF+ONCyK96D1LxJn1gK9HG
 qyn0cAMpEvzUpTOLgfXpXhtNxt+qBBi5vYA3Mmh3L96Vc+tPtYXkpeQ/F98GNz/HLRC4
 6m/MdV+Q19E0ToxubIOJqvD+hTQn2Vb9TsJXYL6Xxj4imep5g7xGR7p2pgTXpnolT5Cf
 Zw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794412320; x=1795017120;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KBQmXpergQV0k3yAGb4YmxsK7ApjQIjQQTJj+akkdKY=;
 b=q1gxha0Fy3vYmqtY9IvyxRilZjtfbQ1ysUWnZxpn9qs4EJBrNJbYSkwk0rutTdr3DH
 5CEMB1GZyn9akYiirgf0i/6H9XEYWkygDE8gbeR9YSBtwHWt5+H4cJ0LzNlIbUmig4hn
 0vbLhmRuUUsR7b97z78bdfh7zHwwMyBUa9GwAmbh3r0np0fECgg3LBgdaCPa0i4zmRET
 pxhcZjZN1I6/CsYQZgfYtw3iblX2gY+qBV+d1jkm6C8N35+7XJ2YfefBnphta0uHgR/i
 i5lmFFtjJdxLelrriv06P9ANLSS5jVi8K8buK4uE/Sc4V/CZpTFl99Kxcd5uDDNEDR2E
 3Aaw==
X-Forwarded-Encrypted: i=1;
 AL+hErGg+KBo5VpU7aatZzNADSrPdzIOBMeu7oaUzrBMIq2wQwXwC0ogT3DS5li3UG2wFza2CaJ9sgBdSvw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+LucUuy16Y1J+Xf/qZo3CP/kSKkBB5mZV7cMAV1iSpRB+Q7+rY
 J3PxzFbOoGl2KtEbV/MWbbDYYNoFlMTQw5WywQgav/mav9DuAzV8QXvIl40ayptpn5gJ+AEeD0S
 pwbaAdEBTUIhNm0UF+eOJFYLA5iiIgPw=
X-Gm-Gg: AYBFou1CnSvKQC94VbV4Rf6Tlq5xV4KhYeDCn0SvdoX/nyU2HxQzpa6Mzb9tC67APQO
 uyuezaoEzMub3qsau9zK6WKtbeJ4qfmgglocUN8uQhw4VB2JCcs7MNK9AIsfMnHhAZQGv6DSYjc
 RJFbAczh0WI1EBN3czKYcGXmfBJrCkKl/U9eHjD1RTFu1k+cXxK6OObGibewNZbAHWSvZXR0FQg
 KTevLaSmhsoRr89BoHZvy5HkysJgiUXagiOVxJgF9GXOIScgF5yXbM9HGibPJcuFJ6Hngbs8/gi
 HB47nJTOf1YCQ4zYQFQ5uoQTjKtCsi6t1ff7T1Y+j4IeKao6j52ljZOVV6HxkSxolNIgjuVKyOs
 BnXeEx4AcjRrJa2QN8d+W5Eps1WAGomQLNYRKIzt+8Z6wx56bdoYUG6Nb3dUazvG0qU6uR6+MUo
 rGPPNCv10heDuy8DIqOALp6p5Nz7lWe+mC2SSq6n/ehmn9S4dJGSCbF7cOPb0=
X-Received: by 2002:a05:7022:5f1c:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1b3c02e9530mr3474381c88.2.1794412320307; Wed, 11 Nov 2026
 07:52:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110120326.538252-1-tzimmermann@suse.de>
 <CADnq5_NCF2J0Dzea5swubs+eEKBLq+8ontc5n=kihYZVA3A1aw@mail.gmail.com>
 <cd49a9ea-a992-4b38-a5d7-d46d1647010f@suse.de>
In-Reply-To: <cd49a9ea-a992-4b38-a5d7-d46d1647010f@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 10:51:47 -0500
X-Gm-Features: AclHuK-V9rhzh3ZjlBaGulsYdclwg7wvF6eK8h0-zGf088bOkC0LAbbJi1wg6Ks
Message-ID: <CADnq5_Oi3-zGYV_BiuJzV5VQvxTSTLN1btqFFH7JYz0ra+dP0g@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amdgpu,radeon: Inline drm_crtc_init()
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 4:35=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 10.11.26 um 22:49 schrieb Alex Deucher:
> > On Tue, Nov 10, 2026 at 7:11=E2=80=AFAM Thomas Zimmermann <tzimmermann@=
suse.de> wrote:
> >> The helper drm_crtc_init() sets up a CRTC with a primary plane for
> >> non-atomic mode setting. Only drivers for some AMD hardware still
> >> use it.
> >>
> >> Inline drm_crtc_init() into amdgpu and radeon and remove it from
> >> DRM. All new code implements atomic mode setting, which does not
> >> use drm_crtc_init().
> >>
> > I'd like to drop all of the old amdgpu non-DC code since DC is now the
> > default, and we have an LTS kernel now.  I'm planning to send these
> > out in the near future:
> > https://gitlab.freedesktop.org/agd5f/linux/-/commits/remove-non-dc-disp=
lay?ref_type=3Dheads
>
> That's even better. :) Do you have an ETA for this work? Resolving
> drm_crtc_init() is required for that series I referred to at [1].

Just sent them out.

Thanks,

Alex

>
>
> > So that just leaves radeon.
>
> I'll fix the Sashiko report and send this out in a separate patch.
>
> Best regards
> Thomas
>
> >
> > Alex
> >
> >> DRM support for kernel panic is only implemented in amdgpu. Take
> >> the panic helpers from drm_crtc_init() in amdgpu, but clean it up
> >> in radeon.
> >>
> >> With this series in place, DRM's helpers for drawing panic screens
> >> can be further integrated with other drawing helpers, as outlined
> >> in [1].
> >>
> >> Tested on radeon with a Radeon HD 6570.
> >>
> >> [1] https://lore.kernel.org/dri-devel/20261019154612.777074-1-tzimmerm=
ann@suse.de/
> >>
> >> Thomas Zimmermann (5):
> >>    drm/amdgpu: dce_v6_0: Inline drm_crtc_init()
> >>    drm/amdgpu: dce_v8_0: Inline drm_crtc_init()
> >>    drm/amdgpu: dce_v10_0: Inline drm_crtc_init()
> >>    drm/radeon: Inline drm_crtc_init()
> >>    drm: Remove drm_crtc_init()
> >>
> >>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c  | 44 ++++++++++++++-
> >>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c   | 44 ++++++++++++++-
> >>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c   | 44 ++++++++++++++-
> >>   drivers/gpu/drm/drm_crtc.c              | 26 +++------
> >>   drivers/gpu/drm/drm_modeset_helper.c    | 74 -----------------------=
--
> >>   drivers/gpu/drm/radeon/radeon_display.c | 47 +++++++++++++---
> >>   include/drm/drm_modeset_helper.h        |  3 -
> >>   include/drm/drm_plane.h                 |  5 --
> >>   8 files changed, 170 insertions(+), 117 deletions(-)
> >>
> >> --
> >> 2.56.0
> >>
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
