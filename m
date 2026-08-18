Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2295C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E086B10E048;
	Tue, 18 Aug 2026 15:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nqc+L8Yj";
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2127010E048
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:52:59 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-66c9995ca60so1579017d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787068378; cv=none;
 d=google.com; s=arc-20260327;
 b=Ef5M3u752+nTERf461pG7SNabLPGxSqlf/0SZYeuNKQ7bvIb8845o8eMTTfaGJVjDy
 htMJ3CXT74WKM59g6FyoLZjBQFmGvTTzcNRdsXkkyMQMg02Oav205Nt5U4kEJHI0NWaY
 FCBk7hHr70DTFyJdHI/mOw2ksjzACZqXj+1ok9ezAV9mRN81bAN8Kmc7J4KKbIwawJn1
 CIQVyfD/uKXMX356xWCk8hN5/Z13nlwHB2doCZM5PIB64Oz5xd7hoEpNZxpvOvgIc0gT
 F+0k7leRA37OViA74aJymaPJbccFFv4B6qqkjyD+G8R9sUGwQLKpakZWRN3JIh+djgGE
 A03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O87k030fj+c1l8ObQoZQTDikjP/1edGoaP5zsebcvzM=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=HmJlCM3Gp3uNvt76h97M7fSreDsf/VnTx98MG2KWktyTlDpVnrLknmF6u4nMcomfW5
 mW1Xo2yq8tObnYdT5GEwloAawv4XUucWpfo7vrWYo8CjHlZRhI+szXw6fUh3EQArDO1P
 +D79MBg/Dft3+/X/rGgNfxvtrQ6MqOUHrJEeAwZfTa8vjDUgGZUE2N4hxr18v116S3Zq
 mOfDmUDymoizc7F5dLfsUpgO50yax/osofu6r5RuA42zHsaesiGzrILQ65WowbKhaKZJ
 YG/36dnOhmX67SVg8nYYrAnylBGKyhDMHpQ3rYYi0MhV7KZ3Kso/ne3WW8OqROQ956vQ
 YRUA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787068378; x=1787673178; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O87k030fj+c1l8ObQoZQTDikjP/1edGoaP5zsebcvzM=;
 b=Nqc+L8YjdZX4ehWE/X0NjBYSWj9qrSojdVUmKuFKbrUznxlEgFcQn//Qf/Zu+404dt
 PLqyrmz9RmQf4kicMwF4F1pzyUM2sfZM7vcTvlSKXxEWKo/5T1CXVzYWbkJZ2IuhnYIy
 FKibb6/YoeWCQT1Y0LlSy3BvhZsT8voKyfJ04egZdqpbH8I4iQULIZsImZXxwOS9BHE4
 lvrTvsm0VrY01obxulJL88C+0nYS/9CkQFKrYJcIIn38Lzu5oGfG0dwsitkARfCUVYod
 ofEaR67UPHu49KLadqUp6I0Z7ols7Zh+qRuV2J6HP1iYRkJD6Bu7jJj/UyOv9ok2UX8Q
 0zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787068378; x=1787673178;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O87k030fj+c1l8ObQoZQTDikjP/1edGoaP5zsebcvzM=;
 b=dszLA6q8fnChyLeY96KK+Ftcgw1GvYx+Rmcd1wzgxKXQH0SeU+NzeAXvxxKT1Ov53H
 5KBOiPzvp8IBqIk9TE6wz47I/ISwxLj0Bc1JLaASIXqjVfY06tUtZx0PMOGeW12svaHY
 KPK8q/2k0WRtbPbdAJ0xrEI/pM5U1mzRZaef0swO/yEV2NxfFEMmPbvB1E7VtF9yUraG
 b77dzcW3SKQvqsGhFruG/R+PVBqmusV6MPwzQ52mWcJy1VU7UfyxLuuh7NbKJ5iBZxt+
 UF8uvtv86ObAV4kmgiQG6KUai94qz4BN0zb65zjW4fC56jcScOHd6x0+xjv8XjbWIKpc
 pPkg==
X-Gm-Message-State: AOJu0YzjHtcBkqjusyDinht0738h6gQU2BqXs58ZjCQ1PiE3w26xx9sA
 CKKrWb+TJNP9uR5tkhMKvSlZ+KMCe30FQvuK1CXVBgdPk3yd4OeZdA5oHfcG0Y2suk10yrKuuJr
 L7PVcPH7Jg4TrI9SbehefNDcGdsgx/LlE9Jq6
X-Gm-Gg: AR+sD11vminVQBXe8SYlpgNo7HoSMJcxzGFqmvoCRI0+FazUaa5oKLgmL6EW50YH8Pi
 21fv0aiGrH9PWeqUJp2tqM1KpCYAaw1OLF5/ZedVvUy7m2hoqdGabxQZIBoZcuz4dpglJq6NsLE
 3CwDG04VjRSJAzPJmYSg8OqdQolT4R5y0dPa21Q4A/ouDoJ7wlmX2DWY4bqeQ6PSEhVUeRk+PR8
 2TM0lF4JVbMKIjFPaWan9GUfoXlDOoJqlSalgdJaH1Uj5uroxSz5fyYB6j1x5lFSRxiYdHBXcE/
 EHuOEBXUazBjV4vSC2IKh/8QKYCnO2aC8IHu4yXM0usM84XInjxRJz88IEmTbg1qxd9BpSFKJrJ
 ty7JAG/M936THQzqAVAacdao=
X-Received: by 2002:a53:ed85:0:b0:66c:46f8:2f0 with SMTP id
 956f58d0204a3-66cbc40e5a1mr1868124d50.26.1787068377601; Tue, 18 Aug 2026
 08:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260815-null-fixes-v1-0-0df9dda951fb@gmail.com>
 <20260815-null-fixes-v1-1-0df9dda951fb@gmail.com>
 <20260815174056.B0ED91F000E9@smtp.kernel.org>
In-Reply-To: <20260815174056.B0ED91F000E9@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Tue, 18 Aug 2026 09:52:30 -0600
X-Gm-Features: AcwNN1WVDiy8KQ3o0wrfgqofVOccezwHUz5anToCGuW1uzXm3eLmSP5eGt7Z-Wk
Message-ID: <CAJfuBxyGobBD_=p8Lmv6F2mPJNe-SJ9+fHxW3jMS3CtRXM30oA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/nouveau: Fix NULL pointer dereferences in
 GETPARAM ioctl
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

On Sat, Aug 15, 2026 at 11:40=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] The patch fixes a NULL pointer dereference in the `GETPARAM`=
 ioctl when the graphics engine (`gr`) fails to initialize but misses an id=
entical issue in `nouveau_abi16_ioctl_get_zcull_info`.
> --
>
> --- Patch [1]: [PATCH 1/2] drm/nouveau: Fix NULL pointer dereferences in =
GETPARAM ioctl ---
> commit 6569813c05cdc1cf39cfd469b6745e81e7cad86d
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> drm/nouveau: Fix NULL pointer dereferences in GETPARAM ioctl
>
> This patch adds safety checks for the graphics engine and device function=
s
> in the GETPARAM ioctl handler. It returns -ENODEV to signal missing
> hardware state to userspace, preventing a kernel NULL pointer dereference
> when initialization fails.
>
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/=
nouveau/nouveau_abi16.c
> > index 291203121f0c2..c9270c5b0fac8 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> > @@ -306,7 +306,12 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
> >               getparam->value =3D 1;
> >               break;
> >       case NOUVEAU_GETPARAM_GRAPH_UNITS:
> > -             getparam->value =3D nvkm_gr_units(gr);
> > +             if (gr && gr->func) {
> > +                     getparam->value =3D nvkm_gr_units(gr);
> > +             } else {
> > +                     NV_ERROR_ONCE(drm, "GETPARAM_GRAPH_UNITS: no gr e=
ngine or func\n");
> > +                     return -ENODEV;
> > +             }
> >               break;
>
> [Severity: Critical]
> This is a pre-existing issue, but while you are fixing the NULL pointer
> dereference of the gr pointer here, is there a similar vulnerability
> in the adjacent nouveau_abi16_ioctl_get_zcull_info() function?
>
> If the graphics engine fails to initialize and gr is NULL, as addressed b=
y
> this patch, it looks like an unprivileged userspace process could still
> trigger an Oops by calling the DRM_IOCTL_NOUVEAU_GET_ZCULL_INFO ioctl,
> which only requires DRM_RENDER_ALLOW.
>
> Looking at the nouveau_abi16_ioctl_get_zcull_info() function in
> drivers/gpu/drm/nouveau/nouveau_abi16.c, the gr pointer is unconditionall=
y
> dereferenced:
>
> int
> nouveau_abi16_ioctl_get_zcull_info(ABI16_IOCTL_ARGS)
> {
>         struct nouveau_drm *drm =3D nouveau_drm(dev);
>         struct nvkm_gr *gr =3D nvxx_gr(drm);
>         struct drm_nouveau_get_zcull_info *out =3D data;
>
>         if (gr->has_zcull_info) {
>                 const struct nvkm_gr_zcull_info *i =3D &gr->zcull_info;
>                 ...
>
> Would it make sense to add a similar check for gr being NULL before
> dereferencing gr->has_zcull_info?

yes indeed, the next patch does so.
I hit them both, separately, but theyre mergable if you like.


>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-null-fix=
es-v1-0-0df9dda951fb@gmail.com?part=3D1
