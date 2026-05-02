Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128B7CD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 16:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B4F410E079;
	Sat,  2 May 2026 16:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L1jmjPb2";
	dkim-atps=neutral
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com
 [209.85.221.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB6510E079
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 16:31:40 +0000 (UTC)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-56d933b555cso867607e0c.0
 for <dri-devel@lists.freedesktop.org>; Sat, 02 May 2026 09:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777739499; cv=none;
 d=google.com; s=arc-20240605;
 b=QyYgLNXCupCl3q11ejG9QW+TJoVCXVhm9Rbyi4XzDDLH8hUNcEMUjlyj0nOfdGCAB6
 YfbaYdzyEoVnftmVcHr+sQStuj/ZUGetxx7itN5D9BbdAfXVwueiVpxLbQKbXOLY6iKL
 Z1vUfalSDmTYyRza7Jc3LTDNweqJ/ofKD8IPQJqB/DiF6E4HSteoxM3MxT1w9Br4f9/k
 0LxaXID2ds7A/cenkJVOP9VR4ZvEmbWXdH5zVFUxa2kkt5VxN7jLiaCtANQmnO8PNpY9
 JbeJnIuVbbpgOcHxFFe258vvmXyc6591EuNatW7sw8BCwqXboPwKS0bBUPOYC3AxyKqG
 u6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MGdDvGq320w1mLt2e50WkCaMgh99/tsEa7oUId1axwY=;
 fh=i4fxN2r94pW05aG5jHXwXGQaFpSs6rwte/32NTwN8LI=;
 b=j2uMbFkfxLB8qFAj7dPTvOBks+l6+eMT3ePvWNwBbqTS2Dy3poicUUKFXrLenaVp0o
 i/2WUu0W1wufGTlyGRa6e4ns2b1ybdHAO37YS9iRqbuMvyICGdT+4aCbWmp8vpVWRBwG
 uoUx15RTF4Xo2gU3Bp7SkKg6nmY/odN15H5tN010d7pgc+VsO8IS1nVCxAdfDAE1t29o
 RV1/oSVUb7bCDB99eG8mg3bOGU2WsO3IwahfKAzNM9p697SVEpzuNoS1BaHoXJHt7pD4
 OYb/Oq6aLy3/Kovtku4U3qlgnkXTL5upy0svDL+Ifq84vjSa6MezMFHJavl/2zxPU3OQ
 lOXw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777739499; x=1778344299; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGdDvGq320w1mLt2e50WkCaMgh99/tsEa7oUId1axwY=;
 b=L1jmjPb2jz9aSAS5dTTm0USzOsNYKmJZT/J60qNLGIPXsDwi7ha5Zkb0U3rZxRPZP0
 WviYqPG32n0agw+2nBTWtyAH+bSyHTGiRVvaG2bwOOqT/d8UFh7z13QaEuWY3bvSxYsj
 scHlYiewRNNhNCBhsoKmoFccrF27yE+0mI1aSiBgupNShm6ZAPB+87VfIsLNYc388T1o
 iH3YelKmzy+RS16cJeJkj8xjGyfs9U6aoVkPeK5MS59DbFUonBXUt90xYekm+yqbOD2G
 ZKgqUl8hrHz+zkSXZGCrBLo3G0je9zHF52CifHZmkcyewx/CIuKtzsuNxU37/rOQloQy
 EcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777739499; x=1778344299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MGdDvGq320w1mLt2e50WkCaMgh99/tsEa7oUId1axwY=;
 b=o1TydllFnVXAstDy0TJOJjUDKuH7F37eopj5JDI32iGheu7pxGK9w6AEHcmmGWyvEV
 r2GPhjI7UXQad8rnLWtCJ0veRMKPCFyCOWrRFH2qVg401dkA8GdD+dqDQ6tmUU2l13Zp
 TGZsIP87CcO47/LiwThibo6dXPettfKT/E5eFpln72Q8/8BySF1V4NMTqq4YUCs7OE4V
 WmKrD5XomWizvTfQUjkF83CI2saylFDZDiILgxJ+a1URxPDxa0NQqh6ytO/TaW1xNXsh
 MoMGMnEYljHKurVKlT6glX7/KWPM4jujuLDXXDCQW7l4o5w2ToVSVbo0OjnKXyUCcv9m
 5OuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QtDJ0ZTiIKG16rgf58jIJU1e4rXcvd6olvIjKaBb/HA9rxEDrGSiT09rsRkACxqFtahmjwDkX25k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeLa1vVEIL2MnBfcdP/VV4O2dA7d215nNS+3gcWmSUfhT7G4di
 KcPvLE28CWki/vAbTUvrRlSlF4yv6w96D1d4/b46eCCedH2tQi2Yaawu9Wm/ZrPSyeUENLkq5eb
 QsC7T1OwOLdVgKbxw+KWeXR+47U3CxEM=
X-Gm-Gg: AeBDietfv2jWKeTJihdCaNIt6NlMIwvHt/M3OERnWWd03YPPucDgMnqq1iB4LPqds9G
 TWeFZqXKuzgW3Byki03a5nstlLv9Znzd/i9gUbPI7EUJ1haooSYlUGCeCoQXEbNiaZQnhaCcHKY
 p0k+0rf0frLj6d8VBjCNqoYm0nmG2VzwSdSfLRrEWSCCR5ObyUPdCZ97DVi/rhV5149rrlXtLmP
 D+FwdWoeU9jv5ZBgEzJssQ3XKDDcOt/S1ju+LBmA7/rGwnDdFpmmOzy90A8uBXh4jwC2XUzxw4e
 HtYXy/CgV5FF/XQ=
X-Received: by 2002:a05:6122:6282:b0:573:a779:62cf with SMTP id
 71dfb90a1353d-5750c57d5e1mr1521155e0c.7.1777739494126; Sat, 02 May 2026
 09:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260420160425.3919114-1-sean@poorly.run>
 <a30256a6-e451-4258-89e8-c92a83db6162@bootlin.com>
In-Reply-To: <a30256a6-e451-4258-89e8-c92a83db6162@bootlin.com>
From: jim.cromie@gmail.com
Date: Sat, 2 May 2026 10:31:07 -0600
X-Gm-Features: AVHnY4LHpC3hcAepmAtHXE9N0iD4t0rIMSXevOgyjpJU99-HiVLTybCfDwwUJ-g
Message-ID: <CAJfuBxzrjVtw1iAcA7HC9CmP-MRj0TVpb5ZyWssKrwNd7Owxmg@mail.gmail.com>
Subject: Re: [PATCH] drm: Fix DYNAMIC_DEBUG_MODULE propagation to
 subdirectories
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org, 
 Sean Paul <seanpaul@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
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

On Wed, Apr 29, 2026 at 7:40=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> On 4/20/26 18:04, Sean Paul wrote:
> > From: Sean Paul <seanpaul@google.com>
> >
> > Switch incompatible CFLAGS-y to ccflags-* and propagate the flag
> > to subdirectories to avoid implicit declaration errors for
> > _dynamic_func_call_cls when DRM_USE_DYNAMIC_DEBUG is enabled.
> >
> > Note that this flag is still disabled due to depends on BROKEN.
> >
> > Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor fa=
ctory macro")
> > Signed-off-by: Sean Paul <seanpaul@google.com>
>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
>

  Acked-by: Jim Cromie <jim.cromie@gmail.com>
  Link: https://lore.kernel.org/lkml/20260326185413.1205870-39-jim.cromie@g=
mail.com/
