Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB94CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186D810E6B6;
	Mon, 18 May 2026 07:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gf+s8wz+";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B89610E114
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:05:05 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8383fb7143aso4226388b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778850305; cv=none;
 d=google.com; s=arc-20240605;
 b=k94gjOU6Sxl4reSo6LvKVSQjwYjyUfdIDysEOrow0qhc7aC3YErNzK7Vi77We6ZMOI
 48Tnd+ebNfAfDrp1kidu2cKXIPqkS5LRx5tgK8eUV3bUKhjHcTJqL/gUdDuqyM7z0pKr
 QmaqdEgD3CxPBMO57eFlv+TQ2PQMyTT1U9iJU857LGm5LkyqAuG1IaH0hPGk2g5FdV2q
 3cy2m0nChj+gDVHRbpl5P68yB2NpkQGf/zdNzEap5QXw3GCRoKJzhujQCXh6fUM2ZivL
 Wv+5igMzjpa8JjHYpnyFLz+fvowRpxswIuuTzSyYQ6rBjwdi8AZuVM8ppsdX67jqU/kF
 xnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l/9aFXPo/Kj5zdvPDq/cdhqAB+Pc0j5dY01OZPwhcM8=;
 fh=v41vjA+mZqdUYt/Fu/pu5ImC+tLSqdC8bicX1z7MpK8=;
 b=W6LKGs1jGcvi44zFlzofnztrZ/NljmM3igf9g/7ndoZvq8NOB4A9O6hdAxzTDxX3sI
 iv87kxaalXPQES26WADa92ECCjp3GKAbOK0U+VQjgKygufFEojX5qt8in4qubUEHEai4
 VSuZDjpHhqkuFJalDUfaCYyyRSE/Q2O5C+fuzAGzJpge9fNyAjdyBkJtykPSpJwiaXK2
 jogA/HgtBDBY5aGwC8xrcmMMYyA3YdagF2FdssyQt/UDpD8/0PUH3I0l5OQw8cz4kPAL
 +nzOonzPgkS43F2aa85AGXLF/c79WQyLzLaJbZmHxFRUoT+KLGKDMmrnkOv2LOimsaDR
 oA1A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778850305; x=1779455105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/9aFXPo/Kj5zdvPDq/cdhqAB+Pc0j5dY01OZPwhcM8=;
 b=gf+s8wz+WwpoargpoN2Qxzwarvm6G1jfsUzhVqtNy0tJnarCO2EQKUJWqbyEMmzbbo
 EGUQVlbA1/JVvqiSrCfALpPinpKnGtOlZCa/i4cNayLG6NBxVub0ChqjtuxP1ZgTGiVf
 FRGqOW3VWslkCz8mgcFUwPdciMOUU2j1NaGSl1g3rNrpgGjzLLnkYPz1PoKAPE6ZFRo5
 PHwXiuaMaqkqmqT2qfOweo6UEqUWxBo0JReoLsr8Q+TT0vSoqMbQpSQXSQnK07mNzosw
 xGW+VueIYZsqDcIeHPx+fg7aJFk7d1PncEVZ7VvEatzsRD7vGaqDFYpuGzr506TnB3za
 FcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778850305; x=1779455105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l/9aFXPo/Kj5zdvPDq/cdhqAB+Pc0j5dY01OZPwhcM8=;
 b=Xm+Un4nHUP5dd76LKPuUcvqKuF1bnwtrJ6lQoMgXAPNs/TLfKHCFFJh3H1cwd5ZSUp
 0C1tsANugDPzJX2bSPHHlv8whF8jXz+46OWbzmiqNkGT0+/lGP0TYdmW0ZqTsZkSkFls
 KoFE2T6GspuoSh99KhjxIp8j0BR9gnJvksAOG3jdY78ok3TIvK1tTWa5A8BSx39HmcKM
 jYQkU7ZmsSq7K8lNJzj2Fr3ZPysDX2EeYccSLyEaN8y2B9XBJtnk7NvtZV8XJfwWOIaX
 9ATlqBNtQLXl6zcBDyNNPB1u1c8xUIq9/y/gOVI2vskE6z0FHBsBraJ0Cc/D0amLqIa1
 Kalg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9f63lEffglqYE6CD3o44X8ACP3W0bBUPIX4bF0oxSANIqen7WMV9xCDzQHFGTB1UaqhxSiVX2Kb50=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcX65581cI7unRFVxDEEed+aw2I1BY7BVHp8WwF93UXcfbPrNN
 h5UnU11HJyoiBwSFTLKasZ+KkeAhchuWW/xqYcT/IG8a2DKfuhqceeH3JzBOv1ogpjok5MkTEsQ
 La4Vt2Geps5Nt+SpQIbGph4N9RL7nLNg=
X-Gm-Gg: Acq92OEsX4oYyKjh2GyEpAq6Vah72Mr1FAlLT/bZAcdQs7Dx/P39uNxEdtFMr/0B5JL
 NFuSM4vGEQaYLzBxSOarnuenXrVzL9JY7AYWNDUTutI+BVJhBY5M6uTXJ8+/vUPu/nP66wvL7LH
 i4nkn1N8H7WHKh7AWicc/idUBfqs3jyrhyDj8vzCc4t5kpkIEovMMRGBdnOJiytN/DcfC8VLlPY
 ul8FLoLYXPZmnNsdYgAg6TilRWvMuKkZuYQJ+1kfqtpEdSbg43lGkh98Npw2IXbS9NNHRNWlfpu
 IwGJ1PmGK10x7KY9lRhOMku2x4ZguiMAnC51V7g8H0TJU7bjphVd
X-Received: by 2002:a05:6a00:1ca0:b0:827:2ee0:411f with SMTP id
 d2e1a72fcca58-83f33bc8fc4mr4111977b3a.4.1778850304834; Fri, 15 May 2026
 06:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260507144425.2488057-1-liviu.dudau@arm.com>
 <agb9Bq2y6tq0z6at@e142607>
 <55dfe576-6c49-4051-92e3-a0a678ba8187@mailbox.org>
In-Reply-To: <55dfe576-6c49-4051-92e3-a0a678ba8187@mailbox.org>
From: Erik Kurzinger <ekurzinger@gmail.com>
Date: Fri, 15 May 2026 09:04:53 -0400
X-Gm-Features: AVHnY4KlpvaVCRlU9XpcXQy4LUQWZNayTYPhiwFxR5aspYXHEdVReyCcOGODxlI
Message-ID: <CAMPXRisk4anhOgrtfXvw7Pvy+MSg_b48zkbEgEOAg+4R1UW3Fg@mail.gmail.com>
Subject: Re: [PATCH] drm/syncobj: Fix memory leak in drm_syncobj_find_fence()
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simon Ser <contact@emersion.fr>, 
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, Sam Spencer <Sam.Spencer@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

On Fri, May 15, 2026 at 8:58=E2=80=AFAM Michel D=C3=A4nzer
<michel.daenzer@mailbox.org> wrote:
>
> On 5/15/26 13:01, Liviu Dudau wrote:
> > On Thu, May 07, 2026 at 03:44:25PM +0100, Liviu Dudau wrote:
> >> Commit 18226ba52159 ("drm/syncobj: reject invalid flags in
> >> drm_syncobj_find_fence") forgot to take into account the fact that
> >> drm_syncobj_find() takes a reference to syncobj and returns early
> >> without dropping the reference, leading to memory leaks.
> >>
> >> Fixes: 18226ba52159 ("drm/syncobj: reject invalid flags in drm_syncobj=
_find_fence")
> >> Reported by: Sam Spencer <sam.spencer@arm.com>
> >> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> >
> > Ping on this patch.
> >
> > Erik's email address is bouncing, anyone else willing to give an ack?
>
> Trying Erik's gmail address.
>
>

Whoops. Thanks for fixing this.
And, yeah, I'm not with Nvidia anymore.

Acked-by: Erik Kurzinger <ekurzinger@gmail.com>

> >> ---
> >>  drivers/gpu/drm/drm_syncobj.c | 10 ++++++----
> >>  1 file changed, 6 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_synco=
bj.c
> >> index 8d9fd1917c6e6..c9dbf64c0c9f2 100644
> >> --- a/drivers/gpu/drm/drm_syncobj.c
> >> +++ b/drivers/gpu/drm/drm_syncobj.c
> >> @@ -442,13 +442,15 @@ int drm_syncobj_find_fence(struct drm_file *file=
_private,
> >>      u64 timeout =3D nsecs_to_jiffies64(DRM_SYNCOBJ_WAIT_FOR_SUBMIT_TI=
MEOUT);
> >>      int ret;
> >>
> >> -    if (flags & ~DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
> >> -            return -EINVAL;
> >> -
> >>      if (!syncobj)
> >>              return -ENOENT;
> >>
> >> -    /* Waiting for userspace with locks help is illegal cause that ca=
n
> >> +    if (flags & ~DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
> >> +            ret =3D -EINVAL;
> >> +            goto out;
> >> +    }
> >> +
> >> +    /* Waiting for userspace with locks held is illegal cause that ca=
n
> >>       * trivial deadlock with page faults for example. Make lockdep co=
mplain
> >>       * about it early on.
> >>       */
> >> --
> >> 2.54.0
> >>
> >
>
>
> --
> Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa devel=
oper
> https://redhat.com             \               Libre software enthusiast
