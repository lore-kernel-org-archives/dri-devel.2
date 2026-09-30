Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF86CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E52B110E2BB;
	Wed, 30 Sep 2026 10:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C7xrtO7Y";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C6110E2BB
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:34:32 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-34b6f8b8113so636785eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790764472; cv=none;
 d=google.com; s=arc-20260327;
 b=M+vGTVhC6nMgq8tBxlcqsr8KH7It/l6KvYCDdU1Q0mmZ/pIGUIpRjiht8LC4Cg7IoZ
 XwhOK8DkH/rGU7k/fQF1dWrqZGVfwG5fZOoKlZBND1favVwLYmuwpZKTtM7EutHY91du
 o/3PULFKDGir9YH6WiFzbGKEXPlMz/Mf+dWhuryuOslLHCQA1cPu1uzp2tJfTKoJ986d
 DIPLSi9nB4qpWucumQMdmJlen/931aXRsdHdkGzCDBEfQmt5WU4PylnlYeZQolnYMedg
 8pEpGcO8yh6oRorNGqxMNNxkUZwjnjXvPRBG8MdhJ1S6gi8T3Jq9jTMzvWSXYdZloJcP
 uQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=o3Nzxky31E5PRv1JQth+E+SJrslWGDTCiHFn65qWNg4=;
 fh=OvQ2CNkm2J0uYegfDYZ6l30ChHuuh8Wq4cIRqChyVUw=;
 b=q0hai24gEs9JkiU6CIA161FrBiNiUR1xJsiaCufEVsZwwOwDy4l3s30S4lQQ4LRX68
 633e92tOXOoIPLdoQJSRhtmwDM08RPkQzIkKMCO3Etk/8B8zrBcESvXYT49HoNgx9OAm
 RItmHGIFCmYWdI2+dPuwfU09QPv9exfSsNBr/ccPgG4uOQ/Mfq0Sb8naA7Usxwp9/eAI
 pCknmFL5+Uz5KmVshXvtOL/duTy0YexqcbxGBKIIa3W892BkemIVK2Q8ycKzhsU7tbev
 1hk3Pr0fw9uwDlDrdAcU/bKiNh/KMR5QGiTzXuzfyNNonOnIjJdFg9ERxGTzSX0zP5zq
 WdOQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790764472; x=1791369272; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o3Nzxky31E5PRv1JQth+E+SJrslWGDTCiHFn65qWNg4=;
 b=C7xrtO7YLTIm/NmMz+8LysiJv6LVnTKhaUPsZ6MgcVcpqJzy8G6keTiUgchsU3FuFO
 ugGzpqi4WmxXEmpv3h6UHxvT7F593B9jRFl5+hrRHXE94EZFwaaZ/A6e24U2dKpvZxkj
 ecgRRZFMK2pacXGXSHuPDufnUj0xzugV/B7sZALB0jzYA6vGCSZBsdbAPKfEnfWgtQ6s
 g5AtcVg548p9H6y3jzQnDhKzoMw91NFkqb3k8fhICcW1DjWyaewvC1epOBiZphHqP0yj
 p4jzhCT4zjUn+zbRBPBW7MusbsmzKpyUDQp4JMzUb+9mSo5cIG/ZIYAkrADU0y0Tz9VO
 cNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790764472; x=1791369272;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o3Nzxky31E5PRv1JQth+E+SJrslWGDTCiHFn65qWNg4=;
 b=vwzvn7DpX5ud/9Z6CwdcpvaBnHr1iVe9u/pW8q0rYGDojd1lQ7IbwkvgS9dBPEr2D6
 wW/AMxpVkK/15HHGZHYxAQOqVNBUb01dxfYCPY4nw4Z+jIjTwNN1Sm4/VN45QHMiFK+v
 nD7KlzHDmVRRGSI+NUVghYiUr+D7p87wG6GeKIPO4qJpntjc4PKBnJkDSA2ml2wWpJby
 l/CtOHT/XUaDNtwEcAKLot7UREk2TMKnEMULKjRntdDxcGRrSWbaW+syScxuqHs3hrFY
 /BCBChv/Cc4ihfgl33y7LLGs+dcbbbgTBSAQQzo1otEhXYiWYX+7F/cOecuNMmuyvO86
 uZog==
X-Forwarded-Encrypted: i=1;
 AKwUvByY4Os9s4qR1EWfOvLsmHlyDrG+PqfQoeksge3zqlvk6TZybs+jqOR8yviqZlJPSJt1YOQuvosOJBo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL8XvFgqSWJs/LznaQzrvfDNUj4GLDN4lpnSYtmfMZ4sblhmega
 +4//DZNhPDrg9qMw+Vk9+yUsr9TegRFT4ec27Xa+KP2phVhVGnMe38GorU0inb4VYM6ZuriCfjL
 QePq45qBxCTFezbcKw/miQIwyhg21tug=
X-Gm-Gg: AYBFou3xCpy1pBfcL2IHnuvBISDqEnGxPWy2vpVSnA9aajWutdJiu5PYlOLvjSQwtus
 BHjfs7tr8QqTaWqx9TCquWHmScMymVsyOb77vQWsoB1+tOtroZ6apBbjlmKl6J3r8E0KgexUCbQ
 YydzEBISWddi6rxAkaS6RRPMS1PMjWytiWFdqMn+GE7BGWYfJEI6zJucm08nWjoZeXA0DBzKbvk
 U1TetSUeVdrE/ou4hG3y28wlaGZ1xeD9oNpZ00NtucLIpusRYjbSlLYfVHy7IGbu+m02sLGZshu
 wFx1RqlJkKSf5IBArF1ZJiWWpVtmsnPv09Si0M7YgiyahCCHnt3oQgaxa2ew7WMbAofTzWCt+sB
 9ppR1QfCWq2a3w6nHnJLtvhU=
X-Received: by 2002:a05:693c:4092:b0:332:94e9:a732 with SMTP id
 5a478bee46e88-34ce4683bf7mr1420176eec.13.1790764471845; Wed, 30 Sep 2026
 03:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-7-clamor95@gmail.com>
 <arzNgbx465QIKYdX@orome>
 <CAPVz0n2QdSWL8=KBXnsQQkdNEJ9m6HSQ0+6mJji_RHZ8QgXN-g@mail.gmail.com>
 <arzilGz4akKvRF1K@orome>
In-Reply-To: <arzilGz4akKvRF1K@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 13:34:19 +0300
X-Gm-Features: AclHuK9nWzYGgxYyAeFQUOiXDBSTKrGnZ3E_AfgUmTUKQbpwZQYV_7ChXtWTs0A
Message-ID: <CAPVz0n0-baCzHOXjWLOCLjv8fb5GbE9a2v=8tBYr3RgHkEu+qg@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] drm/panel: Add Hitachi TX10D07VM0BAA and LG
 LH400WV3-SD04 MIPI DBI panel driver
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:23 Thie=
rry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 30, 2026 at 12:08:41PM +0300, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12:02 =
Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > On Wed, Sep 30, 2026 at 10:05:35AM +0300, Svyatoslav Ryhel wrote:
> [...]
> > > > +static const struct of_device_id panel_dbi_of_match[] =3D {
> > > > +     { .compatible =3D "hit,tx10d07vm0baa", .data =3D (void *)PANE=
L_DBI_TX10D07VM0BAA },
> > > > +     { .compatible =3D "lg,lh400wv3-sd04", .data =3D (void *)PANEL=
_DBI_LH400WV3 },
> > >
> > > Why the detour through that PANEL_DB_* enum? You could just pass the
> > > panel funcs pointers directly via .data here.
> > >
> >
> > Passing API/OPS via .data is discouraged.
>
> No it's not. We do it all the time.
>

I have had some controversial experience with MFD, with passing cell
composition. If DRM subsystem allows this, I am more then happy to
pass panel ops directly.

> > > Also, looking at the enable/disable sequences these are in fact two
> > > different drivers, with the only commonality being that they happen t=
o
> > > be used in the same device. Rolling them both into one driver seems a
> > > bit odd.
> >
> > I did this to simplify maintainance. Both panels are used in the LG
> > Optimus 2X. My assumption is that LG switched one to another at some
> > point, hence they share same timings, controls and supplies, but
> > differ in en/disable sequence. Additionally, these are the the only
> > DBI Type B-only panels in the kernel, from what I can see.
>
> That's just one more reason to put them into more of a generic driver,
> which would allow people to find it and extend/improve it as needed.
>

This driver cannot be "generic". Both panels don't fall into any
category of being "generic". They are grouped solely cause they share
same timings, controls and supplies (only these 2 panels, other will
definitely differ) and are used in the same device. I have no problems
in splitting them into 2 distinct drivers.

> > > If you really want to avoid duplication, maybe they should go
> > > into some kind of "simple" or "generic" DBI driver.
> >
> > DBI Type B is not well supported in the kernel.
>
> Well, you always start somewhere.
>

I don't think that DBI Type B needs some deep and fundamental support.
Even for its time it does not seem to be common, not saying today.
More a curiosity.

> Thierry
