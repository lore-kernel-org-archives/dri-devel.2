Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EB3CD5BAE
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 15:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9004B10F0C3;
	Wed, 20 May 2026 15:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="T419hTEV";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E533910F0C3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 15:27:33 +0000 (UTC)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id BAF2232BAFD
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:27:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1779290852; bh=gcOIwOeeWzpvsrYJGYkpmTBiDOCGGGdp9mfugdpA+HY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=T419hTEVZCJohJJRY3tDRT94FAIrYPv48owA0ZwRJgpDxJ1GkS5YE5qsTj7HlWxqG
 3V0OQc9p8tVe1bzlkJw3wH9CgwBa4Tq6Qt2swVgcATaH/NH/QqycIMymlsurhx5jJp
 xoG7LB7vXJ2K1lJ6Rkao4L9H+YB3Mn93NyiK+FCSPeWNK8iY/Z1JHqT3ZpAHZcXfaK
 qRrsxp2MMtDMY+IW84d/Pr+INHZmye7hTxOVzdVNAtQRhU01gdhn40M1qUTchoyBzi
 mlCfRZVWAkqKhESz66+ZAA+K/TFRvVH3AtGOREFlYIHVplh2s/Xja6CMu+wBIRuke7
 /nTJQ/XCRtuog==
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-654672a6d68so5041532d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:27:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/xRbefv0dn80IHl1naKFpHEC5akw4A49Zvl90AydKaRJvVKJDrqOxXc6Y4nLtWhag2DaYnVEgUB3Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwoCOLvn55MZ5lbjMrLMGc733uo/vpntKrpKjKQxRN/BmZlhTsm
 tpPoI7eGrgHfmmkoNgIuquqswEBKBrHVr75CY3RAQjRtRIiYw9ixJUJOrXZU8AVN8GM1YsNzyWi
 Z5Sq5RjnmERSH9C5yoohhM4miNmWjV7U=
X-Received: by 2002:a05:690e:151b:b0:65d:8f98:6bb4 with SMTP id
 956f58d0204a3-65e2272ee9bmr21554674d50.29.1779290850965; Wed, 20 May 2026
 08:27:30 -0700 (PDT)
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
 <CAFZQkGz=UJqaJ_eTwKBy1pAg5xL+PLibh7W1vYf7JD7Jrx-LZQ@mail.gmail.com>
 <53edf0b5-e733-4b96-87d7-3307275500c0@amd.com>
 <CAFZQkGxpPm081Fz8UtDuBA1PKD42+9YDA+cc6fbSpfawXwu9+g@mail.gmail.com>
 <c9fbfdaf-2a58-4423-8dc5-6e29a88f6293@amd.com>
In-Reply-To: <c9fbfdaf-2a58-4423-8dc5-6e29a88f6293@amd.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Wed, 20 May 2026 17:27:20 +0200
X-Gmail-Original-Message-ID: <CAFZQkGyK-ZV-2QuC21sbGu2BELbAicN7EqCAY=bo+WsKXcA+Yg@mail.gmail.com>
X-Gm-Features: AVHnY4KO7S743c3zkoDggQQ_Kb7Ge56iO-xUbB5sb3ZY8i7QvLODzDohK8-8SEc
Message-ID: <CAFZQkGyK-ZV-2QuC21sbGu2BELbAicN7EqCAY=bo+WsKXcA+Yg@mail.gmail.com>
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

> In general the answer is yes, userspace needs to take care of inserting fences when wait before signal is used and the work can not be submitted to the HW for some reason.
>
> Currently we only have an IOCTL to insert the signaled dummy fence at some timeline sequence, but it should be trivial as well to insert a signaled fence with an error code.
>
> But the compositor needs to be able to handle that case anyway, because it can be that a malicious or just buggy client just never inserts the fence.
>
> So that a device is hot plugged is not different to just a client not inserting the fence in the first place.
A buggy client can always freeze its own surface, it doesn't need
handling beyond cleaning up properly when the client disconnects.
The hotplug case is different, since currently a well-behaved client
can only attempt to signal the point in the syncobj... but the drm
device is gone, so the ioctl will fail and the client's surface is
frozen, even though it did everything right.

So afaict, whatever new ioctl is added for this will need to be
independent of the drm device, or be special cased not to fail when
the device is removed.

> >> One problem is that only syncfile allows for querying such error codes at the moment, we have patches pending to add that to syncobj as well but we lack a compositor with support for that as userspace client.
> > As long as the error case can be detected with an eventfd,
>
> Yeah that's the problem. The eventfd only tells you if the operation is completed (or at least has materialized).
>
> To query the error you would need to ask the underlying syncobj or syncfile directly.
Issuing an additional ioctl after the eventfd fired for this rare case
wouldn't be particularly nice, but also not difficult. If we'd get
that with the eventfd directly, that would be much better though.

> Ah! I think I got the problem now. You basically want to avoid importing the syncobj because when the wrong device goes away you are busted.
Exactly.

> The reason we didn't considered having the IOCTLs on the FD is because if you don't import them and instead keep them around you can run out file descriptors quite quickly.
>
> When you have an use case where you receive an FD from the client and do a one shot conversion to an eventfd that will probably work, but for keeping them in the long run you need some kind of container for the syncobjs, don't you?
Compositors always run with vastly increased fd limits since they have
to handle a lot of fds for dmabufs alone, so keeping the fd around
wouldn't be an issue for us.

> > A device-independent way to create and use syncobj would still be
> > useful to us though, both to simplify the compositor and to improve
> > the software rendering use cases.
>
> Yeah not sure how to cleanly do that. We could have a dummy /dev/dri/rendersync or something like that, but that would be quite a hack.
I think for userspace it would be less of a hack than searching for a
random drm node that can import it. I'd gladly take another solution
as well though, if there is one.

- Xaver
