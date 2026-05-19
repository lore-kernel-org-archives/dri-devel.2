Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B25CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 13:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDFF410E282;
	Tue, 19 May 2026 13:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nZPAZFbw";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1D210E282
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:19:37 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-65c09c1d000so4173375d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779196777; cv=none;
 d=google.com; s=arc-20240605;
 b=U/YK0NMK1897V3VvAgKYADYwQaIA548JvvFeTxsbGm1Pvs9sFzs9UXO4L2eZFNFv2l
 Au4qZzh/xMbr/JBZnpaMvOjk0Y1tDkYA4WW5peQg07C0tE3Fa3PRiDfR4q7lTFPOo6nH
 Y+7n0d590Dl14/XlmsdvZpca5WW/MDQsoZEJgaxl/y4GLn71bHYjvVuz24d8lsemyzpv
 unAz6/Lmy2XA7Zr6EjQQwbacQANRtaQQCalQ2mxGOfFqFfSfvMWGYqfMH3iVpxnIF/Jv
 1ey+vpdkkogVMnUwnAKU2VbRdWVar2dyYjORkaSNpCcOEbcpzCiQo+NbGV4Onlz+rAPA
 itfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d+tNP9HiaB7786A6QlxY1NJuf5fPzSCRaviYw3QklB4=;
 fh=kUyRoDl+QLzl12hoLJKWH51RNGD45nhlmIrYu9GCyGI=;
 b=hV+g2pmJUd0n0o5CUydyimE+GrplggGnivleIMgris7BDvhPSWIm1T2ZKbIkl+A6CY
 ZvUsOqTmtTrBYyfVN/nCxAoYUe+5L2KWbmi5Zdur37OlxBhpoz05D3GbB3GGyoLcPf+s
 zEBZFI/iNV8lLvFl8Qr3+l+KwdbcfXqKv85EaBmQjGNUr1JkpjI6zJcsMZ7/t0CWmCjl
 FvETgnGKBbP//gUMLvwZ9ncobF7agZ8ztUVow2Muce+ruUxmm3WeRIMZAaj9HrGyoDlt
 55xvjJ4HZpO3O+EdYMAl1ofEsLzSNrwQN+XtJm3+sFlxO8kjJFhnLFIBkDW/WMCAxGx1
 hnIw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779196777; x=1779801577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+tNP9HiaB7786A6QlxY1NJuf5fPzSCRaviYw3QklB4=;
 b=nZPAZFbwFchJ0D6UsaoJ/JkhS5L4fSmR9VDmKSZs+r0RAzTwrKMW38KKyrydS8LjUK
 TcQFVZgoKhWFI+d+V3xAij3AjNWaN1OFDZjSV5EhM1isvKPoZcrlKomeFfg67jn8JAo8
 kPYEqJh4qaA1gmVNC8Ew6wdk401nh4e3sJ+PWcyTXoWdmhRtkCeJ5Rb52CVocbhLi9kq
 Fmz6VNuejeY8F0SPfHke71XkCb5GwyQbgjwxKWDYeGV7dPt720nIwz057i7XxVE3Pz4D
 ahl8AC8WrjsgZCnDHLz5R0pqyqd717LCPtv0e2vGWQdCeK2VRzQM7LP7zjgCuAduUUza
 lMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779196777; x=1779801577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+tNP9HiaB7786A6QlxY1NJuf5fPzSCRaviYw3QklB4=;
 b=okglarNGQ+nOEptYm3qHXe40MVvHWrVR7GLxeof1vCQZGOA8Tj1576Q6ReQsg75Il0
 Ew7ZNy/x2duSn41Qeeb5TYBLNHRtKNAgONoVbOMWbeDFyWXCn89gyjOSuOrCzRGlsOlo
 9WGMUCBUMVA5OSEZ8krTfF1Oj8nvY+LiE8qk3XOet7yNqbiGIMp8HY+AHkvvKPsaAl9A
 s7r3QmiG3qLTrVzo6weZ4Fc8ZGORzKqS7edMSqHxVDRHZ6HA3bQ0Ym8IoFvP5ubMFQsF
 wnu8O/XAu3jSKeycdlCKTgl9y0DrOpGgbp6AD1S9AZw82+pPjIcEdexlQoViv3wuzIJo
 72Gg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jRCbXv717Uru7bTFctAbeDzLIKwx5Y5SeCQh1GqAfbekvQqsnETgJwkjU7HONS8WvN3TKvYjEBnI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+KOIGTOwwJX97LdnBDvi8v8CauyFEQTHrA6xpYB+YiRGn6OjS
 /Xc6Srdl/qATy9W8vWJek8SLdT5lfHsMKJAq2PmWxhT/5ExlvmxWta7n80H6SB1BWdyPY2/l/Ku
 X79L5Av+vAj7+VoeQHCuTehjL2FNyxyM=
X-Gm-Gg: Acq92OHfn5I4vwIjdBFIXCBBsFEWHR7HaF7v1aJMFM9jiJ+sbPFcLME+L2XlXhQPsYU
 zCb0wHMSNLeAcuKUt6C4K7cUeDwtmOPTF+G7e7EOinSIrTFf1v1idDdUDXGNk7D04NrujCNjw2N
 rZqBcZMTKOQVW/SBYwtlxOF5jxaNbf0joLcpH1V0ok2bEu6LljPl/rD6yA+zu3OYsRLMd4+jx2T
 Y0c81n1kkShD3PE9lO6u4EqoJiWg6DnIaIqfH5bcqqZFkgLv1gyp6ySD7b1NxuBDuBOC25vV16B
 Zn7wJIc+n8RgXEBEzgnBQJaM0lHlLFf6xI+w6JpCXIaewMh6
X-Received: by 2002:a53:d005:0:b0:65c:6f05:ae25 with SMTP id
 956f58d0204a3-65e216d83d6mr14649417d50.30.1779196776397; Tue, 19 May 2026
 06:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <c6c91de9-a34b-4b50-a3c1-d42bf7631f8e@amd.com>
 <CAHijbEUzWZC4GAMU6YGV42gOYkrQaMZZPiwS4Erb4H1J-fh_8Q@mail.gmail.com>
 <69dcbcc1-da58-4d34-bfb0-5c8d33b75d59@amd.com>
 <CAHijbEWqc2+kSkk3i_LxB2PQ6XwUetw1UkdUdXJfdv3zgKd1kA@mail.gmail.com>
 <38551bfe-75e1-4978-b57d-adc43cebc85e@amd.com>
In-Reply-To: <38551bfe-75e1-4978-b57d-adc43cebc85e@amd.com>
From: Julian Orth <ju.orth@gmail.com>
Date: Tue, 19 May 2026 15:19:24 +0200
X-Gm-Features: AVHnY4LOerIoiS4EJslI_YZhkER_543_y_7-NPEIgz5Ez-WK_fluwXi0cmnkr5s
Message-ID: <CAHijbEWHp960qvZFoK7+9ppHAqkAR7=UQhtMUccqWzGd_pFPQA@mail.gmail.com>
Subject: Re: [PATCH 00/12] misc/syncobj: add /dev/syncobj device
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
 wayland-devel@lists.freedesktop.org, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
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

On Tue, May 19, 2026 at 10:18=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/18/26 14:58, Julian Orth wrote:
> > On Mon, May 18, 2026 at 2:41=E2=80=AFPM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> ...
> >> It could be that we have eventfd integration for that as well now, but=
 in that case you could give the compositor an eventfd instead of a drm_syn=
cobj fd in the first place.
> >
> > Yes, all compositors use the DRM_IOCTL_SYNCOBJ_EVENTFD ioctl to wait
> > async for the timeline point to materialize and/or be signaled. The
> > wayland protocol was the motivation for that ioctl.
> >
> >>
> >> So as far as I can see using drm_syncobj for software rendering really=
 doesn't make sense, eventfd is a much better fit for that use case.
> >
> > Using eventfd has some disadvantages:
> >
> > - We've just added syncobj support to vulkan:
> > https://github.com/KhronosGroup/Vulkan-Docs/issues/2473#issuecomment-44=
46117280.
> > For eventfd we would not only have to add yet another extension, that
> > would realistically only be exposed by llvmpipe, but also every
> > compositor and every client would have to support both extensions.
> > - Similarly, a new wayland protocol would need to be designed to
> > support sync over eventfd.
> > - Eventfd does not support timeline semantics. Meaning that you would
> > have to send two eventfds over the wire for each commit, one for the
> > acquire point and one for the release point. Whereas with syncobj you
> > only need to send two integers per commit.
> >
> > I don't see the advantage when drm_syncobj already does everything we n=
eed.
> >
> > You seem to believe that compositors would not be ready for this and
> > from that perspective I can understand your apprehension. But I can
> > assure you that compositors are already fully set up to support all of
> > the usecases I've described: The wayland protocol requires the
> > compositor to support wait before signal.
> Yeah that's much better than I thought it would be.
>
> And that eventfds don't support timeline points is indeed a pretty good a=
rgument.
>
> But I still don't see much justification for creating a /dev/syncobj devi=
ce, this is clearly something DRM specific.

The justification is given in the cover letter. To repeat them briefly:

1. This series makes the ability to manipulate syncobjs available
independently of attached hardware.
2. It makes it available under a consistent path /dev/syncobj.
3. It removes the need to translate between syncobjs fds and handles.

>
> What about using VGEM for this?

If the vgem render node were made available unconditionally under,
say, /dev/vgem and DRIVER_SYNCOBJ_TIMELINE were added to the driver,
then maybe that could solve points 1 and 2 above.

But it would not solve point 3 and it sounds like a hack to me to have
a render node available outside of /dev/dri.

>
> Regards,
> Christian.
>
> >
> >>
> >> Regards,
> >> Christian.
