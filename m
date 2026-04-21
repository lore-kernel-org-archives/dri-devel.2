Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4C1F8FA7A
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 13:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C8A10E1E7;
	Tue, 21 Apr 2026 13:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l+dB0H8R";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AE110E1E7
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 13:42:34 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2e92c54bab4so260995eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 06:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776778954; cv=none;
 d=google.com; s=arc-20240605;
 b=HgMq0PG07xbq/ceVza9dRzHhvyuGhae176EU07vndMvROcR93vHV7fhCwy342jsBmd
 ZjoYI6B7o5Du53bntJQqv+eKW4eMIPzwXMq7dwOvi0vblFU7L7KGKPti/NZGc/Ei+5PL
 xy26HrYfKqp05En+7TL7n9vZAyGWMFYLKUEdCvj2tIVTD9YbHM1WUt9oqdDyGCYnfKde
 cNZQSwBcd1xWuSWTmtXTAn1tI0RQ8RWL247kDB/5JQ7vUSGVq5uDlRBvULJAPXPK9Ibv
 OrzlNXUz/PSX8qk0edcYLiOFj7Rt0j0EhELNtypq26Aqip+oxtsr+lbzJpOPbnAwOQCi
 ehgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AontFqJ29O9B4XddB2vlqOXKOaoCcdqy5Wv6UVFlFKM=;
 fh=jZCZX0x+DmsYwXrju07fsy3m3oRHiw+Z0sYeI3tC/1E=;
 b=iAywXgJ55Wz9/wgFok1tWtWRmQxuwqjDLKjFf5DpilvYYDJRIk60NMQOs61UJNMg/H
 XfzhVaHZG+38mvIJQdRFpgoIPaVKKaDncZ5CHQgz/QBm6h6EwSechDILOMLhZTGBtLT6
 zztvgXpQdhDsNygCmbl8tx3dQb3onrTksJaU72Dc64MsvAWkntenKVrHKqPiCTkfuwlq
 zv1DQOuY2TSUhAKu4t6NBfDGQxYtAgW4WS5HqSPgSSHzCF0bubxFlbmPX0obV09FOsMw
 B4JGTxsVbyBlvTPfSA2c0yCcX82OTM9bd41JrlZYpEnpWL2/mXg0Ch7t/fKlPako1nnB
 WRkg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776778954; x=1777383754; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AontFqJ29O9B4XddB2vlqOXKOaoCcdqy5Wv6UVFlFKM=;
 b=l+dB0H8RP+FHPEf/nZlUoB4zQtfErGqGtKlYOjMFwFDYdoU/FsJscYobNXNnb4C/Qh
 BoQlkSc9Oa344EyPN985zJYXiq/WrnNIUmwgWZk0Npjwc5C5Vgfmy7eS+MaXLil3+oPX
 gKtKY01FqaR/jga5pINv9h+jsvXMIEQL3wEmozKPCMjxdTZbhUd89rCa1JliFbG3FJdJ
 eDlv+7aYIiu7EteZxX5BTZEQbjGMW3dbKCAnKqbJnQZATh+d5z/y3F8//h8UO0v5eyN5
 l41Gpzh/x4HO6dMyYtOKlEyJQXGVMtuPnijTdCVwPn82/NbJAruap/XCGQgfSmeA8rfl
 7UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776778954; x=1777383754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AontFqJ29O9B4XddB2vlqOXKOaoCcdqy5Wv6UVFlFKM=;
 b=KGREGZibuaPeGw/EoH7XmdgeKhnP2VELfAIq7peMB0oRZj6aox1cXwk3AQ7Z63+NoO
 ftp8Fg+aTMEEwWgHMgE3adTeh1lDP/Cm+3P3jZ7lg2KiEcklyjpAAXBFqcA5gUSMmFwB
 9wHIDSkFgvL3Z3cMBfuY3PukEZ5dVk/I1jrnMW/hrVgB1ttX81fUmQ2ZVjFIdao9o8Ot
 RExS38TKJyQyCy4D5qSffTqp8BMgSVvAvmoKcJ1VgQFR/qhNcGGU/QpxiwzO9F+9SLcw
 L29xzxsmwYL2e2iuSp0nOgYPRmdSMR68tIkMEiIVEKIMQ+lgIO2Fk5eos3zG2iaNDFY7
 4Juw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9Ypu172PLH4kSlEf8SQvIlhs+xDY+6mf+Co8fXbJxqWgI0FNksy/v1Ct9LdFeGNEOUA1uAl14xg4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkZ3LApdm1ZjrnT3fhC3VhYYBdttcVLoZlXh5P5C+8y4vYGSpU
 g1duJTK4ubZAMrKZPbBRH6gkIWhS0VEYFjZ52f5IZN4emcxyRuCmWjmC7q11KEeKT42nfL4qpOr
 yuqZ09/oIeYYwNEiKoM/DeK3YAEUzQGQ=
X-Gm-Gg: AeBDievATB+a807nFjTjfAVkeWZii3SNf449aJ+3PIfvBTu3BGMjuAGIHesSMVDhwt7
 v2yfxVS80sibGpgzLEaEc9bHSVKONrvMPQ+mZcjss0E2FDuyg20iVtWp5XxBB3xUZX0aHYdNQTl
 K0hKFd8b6r1pFcZAb11v9OyHkKhQgMZuPl4iieuam6LJ3n/vHhL+FIKCCzzhY+aXjvk6JkDSI/c
 PGPcj7yxTG7UYeKp4uLpCwPoEMNslNM5z8AjGInBxVfdwa7fcbabhZIwzPKS9739s4u22Yhzvsy
 VGlUB64Rcz0YjKKYPu9jUNoRtqwiARBMTs+dhTvBXzJqWP0za54fQtwMO+ISHFC4y/xsRZ7vwPB
 x8vqN
X-Received: by 2002:a05:7022:6889:b0:124:af80:9d0c with SMTP id
 a92af1059eb24-12c73d26cc4mr3678862c88.0.1776778953884; Tue, 21 Apr 2026
 06:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <bug-221376-2300@https.bugzilla.kernel.org/>
 <20260420215717.223372-1-arjan@linux.intel.com>
 <34718f21-712a-4161-98e0-079dd9390ae6@amd.com>
In-Reply-To: <34718f21-712a-4161-98e0-079dd9390ae6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Apr 2026 09:42:22 -0400
X-Gm-Features: AQROBzDeqv9bDX2RaJLbOqX6UXVA0203SVdcLBSCszkeeI82FwKP2sCJ2EAHOV4
Message-ID: <CADnq5_McEDYBcU8B+T4MeRKoST10EhA=LWXju1y2BL48kJPBNA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix zero-size GDS range init on RDNA4
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: arjan@linux.intel.com, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org, 
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

On Tue, Apr 21, 2026 at 2:59=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/20/26 23:57, arjan@linux.intel.com wrote:
> >
> > RDNA4 (GFX 12) hardware removes the GDS, GWS, and OA on-chip memory
> > resources. The gfx_v12_0 initialisation code correctly leaves
> > adev->gds.gds_size, adev->gds.gws_size, and adev->gds.oa_size at
> > zero to reflect this.
> >
> > amdgpu_ttm_init() unconditionally calls amdgpu_ttm_init_on_chip() for
> > each of these resources regardless of size. When the size is zero,
> > amdgpu_ttm_init_on_chip() forwards the call to ttm_range_man_init(),
> > which calls drm_mm_init(mm, 0, 0). drm_mm_init() immediately fires
> > DRM_MM_BUG_ON(start + size <=3D start) -- trivially true when size is
> > zero -- crashing the kernel during modprobe of amdgpu on an RX 9070 XT.
>
> Mhm in general not a bad idea, but we are having tons of GFX 12 systems i=
n our test machines and nothing is crashing there.
>
> We are clearly missing something here. Is that on an upstream kernel or s=
omething backported?

Looks like that check only asserts if CONFIG_DRM_DEBUG_MM is set in
the user's kernel config.  I guess no one uses that option.  These
chips have been in the market for over a year and no one has reported
that until now.  Applied with a note about this in the commit message.

Thanks!

Alex

>
> Regards,
> Christian.
>
> >
> > Guard against this by returning 0 early from
> > amdgpu_ttm_init_on_chip() when size_in_page is zero. This skips TTM
> > resource manager registration for hardware resources that are absent,
> > without affecting any other GPU type.
> >
> > Link: https://lore.kernel.org/all/bug-221376-2300@https.bugzilla.kernel=
.org%2F/
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221376
> > Oops-Analysis: http://oops.fenrus.org/reports/bugzilla.korg/221376/repo=
rt.html
> > Assisted-by: GitHub Copilot:Claude Sonnet 4.6 linux-kernel-oops-x86.
> > Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |    3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index afaaab6496def..8075ac735321e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -75,6 +75,9 @@ static int amdgpu_ttm_init_on_chip(struct amdgpu_devi=
ce *adev,
> >                                     unsigned int type,
> >                                     uint64_t size_in_page)
> >  {
> > +       if (!size_in_page)
> > +               return 0;
> > +
> >         return ttm_range_man_init(&adev->mman.bdev, type,
> >                                   false, size_in_page);
> >  }
>
