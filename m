Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7FBCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 15:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE5E10E166;
	Tue, 19 May 2026 15:31:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="aDPUmUeu";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14EAB10E38B
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 15:31:55 +0000 (UTC)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 42F3432B113
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:31:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1779204713; bh=oT6uiKktMScgUXFbTJP5r3yFWiKp5GOGABsHC9u3r+8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=aDPUmUeuxJlqZqy46DQkbghe5oLt/7qJ+U9GC1GMXypZ4yMWs9Fc4jxvYNVfhGdBF
 GiwjepgbzFtOFe1fGLLFCTve/IeCL90e/o7L6U2kzLlFasvIE7sL3BuotnzQMBiW1L
 cUsIWE9SouMzKLLH2Mz7X55nD6k5l2ea9nJZ/3Yz5/5TdzbAJi15YigNk9pY+3A2sl
 +ogiM5tf+SpGRtPtfkREMVLa36lsfwTps1or6J7NydftbNZbbmBsKbKllLY3os9Tn+
 2rFAgvBSGUwHo1N6IwZ1eK0796dXyEKE96czATup9FCe9DXyesJ9N5Czw87WJMO8Yz
 jPyos493GO4Kg==
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-65c7efdb7d8so3893419d50.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:31:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/0oU3IR3Z3qJ4bXWRS4T9eqQoLw7n/f2h3oZqrYdSo1tDsssE5KALpITAcT8rHt2l0734bSmiXPJ8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlKtOtYPuspt8JJtHPwi9C+Iwzc4hoQfYLG7lFMlzj1Ve4z1Mf
 DysjsTxF88xUDAfQP8jXEhGA6j6TTuzJU6H++fiJhglpu/yVf+f0dvhZbEyZGzmGa8km9kqkHTo
 PKY5zRiegs/wgmEDZNyheZ3CYU/r3CuE=
X-Received: by 2002:a53:acce:0:20b0:65d:f5e7:72bc with SMTP id
 956f58d0204a3-65e2276b844mr16430681d50.22.1779204711899; Tue, 19 May 2026
 08:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <c6c91de9-a34b-4b50-a3c1-d42bf7631f8e@amd.com>
 <CAHijbEUzWZC4GAMU6YGV42gOYkrQaMZZPiwS4Erb4H1J-fh_8Q@mail.gmail.com>
 <69dcbcc1-da58-4d34-bfb0-5c8d33b75d59@amd.com>
 <CAHijbEWqc2+kSkk3i_LxB2PQ6XwUetw1UkdUdXJfdv3zgKd1kA@mail.gmail.com>
 <38551bfe-75e1-4978-b57d-adc43cebc85e@amd.com>
 <CAHijbEWHp960qvZFoK7+9ppHAqkAR7=UQhtMUccqWzGd_pFPQA@mail.gmail.com>
 <5ee6d5af-ac48-41d7-a19f-e08a3c5b7d19@amd.com>
In-Reply-To: <5ee6d5af-ac48-41d7-a19f-e08a3c5b7d19@amd.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Tue, 19 May 2026 17:31:40 +0200
X-Gmail-Original-Message-ID: <CAFZQkGwmeipZnvmBkcE7KhvUSMkSE=fzLBZtiMyhv3mM04Vudg@mail.gmail.com>
X-Gm-Features: AVHnY4InFcbGFBQwqAypjrf9D3aYMpjvgQB5CvHgiLxe84oabRYNffn3PUsURt4
Message-ID: <CAFZQkGwmeipZnvmBkcE7KhvUSMkSE=fzLBZtiMyhv3mM04Vudg@mail.gmail.com>
Subject: Re: [PATCH 00/12] misc/syncobj: add /dev/syncobj device
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Julian Orth <ju.orth@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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

Am Di., 19. Mai 2026 um 15:29 Uhr schrieb Christian K=C3=B6nig
<christian.koenig@amd.com>:
> > 1. This series makes the ability to manipulate syncobjs available
> > independently of attached hardware.
> > 2. It makes it available under a consistent path /dev/syncobj.
>
> Exactly that is a big no-go. This has to be under /dev/dri.
FWIW udmabuf is also under /dev directly, but I don't think any
compositor developer would complain about a different path.
What are the rules for that? Could this simply be put in /dev/dri/syncobj?

The part where we get this independent of attached hardware is quite
important for us though, since we can't just ignore explicit sync once
the device we previously imported the syncobj into is disconnected.
Buffers can be from any device or allocated in system memory and
access should be synchronized properly in all cases.

How exactly it's made available isn't all that critical.

> > 3. It removes the need to translate between syncobjs fds and handles.
>
> That's a pretty big no-go as well. The differentiation between FDs and ha=
ndles is completely intentional.
Could you expand on why it's needed? For compositors, the handle is
just an intermediary thing when translating between file descriptors.

FTR for me at least, this part would be merely nice to have, since it
slightly reduces the amount of ioctls a compositor needs to call, but
it's not important.

> >> What about using VGEM for this?
> >
> > If the vgem render node were made available unconditionally under,
>
> Software rendering is a complete corner case, I don't think that this wil=
l be enabled by default.
That simply makes vgem unsuitable for solving the problems we face in
compositors.

- Xaver
