Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E25CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 17:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5A710EDEC;
	Tue, 19 May 2026 17:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="ULomDrS9";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6076610EDEC
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 17:09:09 +0000 (UTC)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id EDFFB32B256
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 18:09:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1779210548; bh=AlJ1/t/6JcBQn3xvZ12SbKOodlIQ8ueQNBgDtOCG+Xk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ULomDrS9UqUbxh3IzJyvC4+q/VmRHFROIzfDMEyYaPejcn1rB1NEXGg3KBPnjmAEh
 iAPC/67qui6nmReo5x4MtCM9fnKz+0kMn4dTCuab25hyJJLy1Q9YTn4uW9hEH03S0g
 N1PfoTIr+iaK05XtPwZUOcd8Trz0rhKcZeeMgbhaWTAkM17z8cWoZ1kwXBXXdDd/9T
 3/iUa7kTM03makIM4O9+zXpGE3wRZFda52gjJGeBD+ck/25Vqhy9I9SqPXGq6wBaf1
 YkIRxjUw+J/Rz1TYDm3b+nP5PfQrVVIiQNgSwROSkJLhq1zjzkrOxqJLR1vGXyFmZe
 OatGh1T1ZXZrA==
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-65890a6ca20so4292084d50.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:09:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/JEinba5pfRecqzyoulXihttKICepMGkSnQCYyKHs4qCCwhl0fUbIoxS1ebL5jS4ElFv8eeCgYodU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yym60z0WAqXRyiknA4ji5ukWHTYUfcDAXn+xR9VEN34NyCUCKxa
 DTshhrPxo+jikLsB1J69m7S81gBYYpsJnbH6fbB9p/uS6dLiPDK+bncV5qx09tO4NjXqgMSIw3b
 J++WXKmSFC0xrxFQiqVXFT4m/GS5Lg0w=
X-Received: by 2002:a53:c041:0:20b0:658:509a:754f with SMTP id
 956f58d0204a3-65e226bb1acmr16811065d50.18.1779210546198; Tue, 19 May 2026
 10:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <c6c91de9-a34b-4b50-a3c1-d42bf7631f8e@amd.com>
 <CAHijbEUzWZC4GAMU6YGV42gOYkrQaMZZPiwS4Erb4H1J-fh_8Q@mail.gmail.com>
 <69dcbcc1-da58-4d34-bfb0-5c8d33b75d59@amd.com>
 <CAHijbEWqc2+kSkk3i_LxB2PQ6XwUetw1UkdUdXJfdv3zgKd1kA@mail.gmail.com>
 <38551bfe-75e1-4978-b57d-adc43cebc85e@amd.com>
 <CAHijbEWHp960qvZFoK7+9ppHAqkAR7=UQhtMUccqWzGd_pFPQA@mail.gmail.com>
 <5ee6d5af-ac48-41d7-a19f-e08a3c5b7d19@amd.com>
 <CAFZQkGwmeipZnvmBkcE7KhvUSMkSE=fzLBZtiMyhv3mM04Vudg@mail.gmail.com>
 <dff60378-4e47-4753-8878-feec6e1c2690@amd.com>
In-Reply-To: <dff60378-4e47-4753-8878-feec6e1c2690@amd.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Tue, 19 May 2026 19:08:54 +0200
X-Gmail-Original-Message-ID: <CAFZQkGz=UJqaJ_eTwKBy1pAg5xL+PLibh7W1vYf7JD7Jrx-LZQ@mail.gmail.com>
X-Gm-Features: AVHnY4K_IfI4nF31sGUOpZQLLhRb2Bvzlif26PEgJHTzyC-9E6RsTuVsRZfgh_U
Message-ID: <CAFZQkGz=UJqaJ_eTwKBy1pAg5xL+PLibh7W1vYf7JD7Jrx-LZQ@mail.gmail.com>
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

> > The part where we get this independent of attached hardware is quite
> > important for us though, since we can't just ignore explicit sync once
> > the device we previously imported the syncobj into is disconnected.
>
> Can you elaborate more on this?

In Wayland, the client is allowed to attach dmabuf and syncobj
independently, they don't have to be from the same device (and the
compositor wouldn't be able to verify the opposite anyways). The
compositor will usually import both into the same drm device, but
especially with compositors that render on multiple devices, that's
not necessarily the case either.

If for example we had a system with one internal GPU and one external
GPU, the client renders on the internal GPU and the compositor uses
the external one. Now when the user yanks the USB C cable, afaiu
- the buffers from the client stay valid
- the syncobj stays valid on the client side
- the syncobj becomes invalid on the compositor side

"invalid" there means either
- the acquire point of the client is marked as signaled, before
rendering on the client side is completed
- the acquire point of the client is never signaled. Since the
compositor waits for the acquire point, the Wayland surface is stuck
forever

Afaik the latter is currently the case. The former wouldn't be much
better though, not when it's preventable.

This is admittedly an edge case, but GPU hotunplug is something we try
to support as well as possible in Plasma, and all the edge cases cause
a lot of problems in combination and are a lot of headaches to handle
(or really work around) in the compositor.
Another edge case is when the client asks the compositor to import the
syncobj, which can fail when a hotunplug is in process, and ends up
disconnecting the client for no fault of either client or compositor.

> >>> 3. It removes the need to translate between syncobjs fds and handles.
> >>
> >> That's a pretty big no-go as well. The differentiation between FDs and handles is completely intentional.
> > Could you expand on why it's needed? For compositors, the handle is
> > just an intermediary thing when translating between file descriptors.
>
> Well what we could do is to add an IOCTL to directly attach an syncobj file descriptor to an eventfd.
That would be nice.

- Xaver
