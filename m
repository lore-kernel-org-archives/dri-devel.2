Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A2DC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0F310F5DB;
	Fri, 11 Sep 2026 13:26:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hc/zMNFD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B2610F5DB
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:26:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 305AD447D0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143331F0089C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789133184;
 bh=s8OmW6uRah0YzknSW+R3/+6wCJr+/gd8eErz9mCUko4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Hc/zMNFDktu8gFl2OHOSlM7VMoHxj7voeCgPc/5YIMUsYtYj3AP3zPSsWd8jYPydr
 xKrxQym0Mlii2g7ou1+SBoQX5zyI3ZxYOaCFCfhm9hdiLqwkPG6g/jo5nOR7EwXbLn
 Wr9fBmBvfU3LMarWjf+xk0ypjbCBJ4mJ2SmtwBgPZcQq7ZBK2wN++Z6+Vq07D2PC/F
 ElBpS5v6dNP4wmmI7vhnu6YSmnlXbOMouYcC4ZmzVoLwsYcDvtQA6YHSipL63H2JeK
 +AI1Quvgk+kv0Nd41+l9+9R+RQiO8oXae0qMjGSy8oLdtO8VxM/P8YRm8CV44YcilQ
 oE7pnE9jdA2qw==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f1801fso1189710e87.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 06:26:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzq7WtVQg+bGYyci59b2i0xXG6iPlXFII2p1xfEPjbhcEY+PntR9OX58/fMHUsrgIRsmTjOHbz+bh0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l5VvRZJjqvkquZ/1mju2GkKU7KDo2U/T1wU6x5LPzymIn/EOln
 thai99axld2EQrap2TMxpeirTxbE6gD+icPciFLkooB3DX4tkRsmALPkzNMLS3JUJfcsPqNVsbw
 B0o9Z0anvEB2imnFjTqZnu6p4xe91+JU=
X-Received: by 2002:a05:6512:12cd:b0:5b6:183b:d1fc with SMTP id
 2adb3069b0e04-5b8a0316224mr986014e87.35.1789133182772; Fri, 11 Sep 2026
 06:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <d3a928e0-6faa-4cd4-9d2e-cb9be4cf84c0@suse.de>
 <CAD++jLnAoOaRwWpkVX0o1z0wF=Qs9PRTKbq9iq-GWSkJ2kyX8w@mail.gmail.com>
In-Reply-To: <CAD++jLnAoOaRwWpkVX0o1z0wF=Qs9PRTKbq9iq-GWSkJ2kyX8w@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 11 Sep 2026 15:26:10 +0200
X-Gmail-Original-Message-ID: <CAD++jLnBPAw9CJ4JtZt46yBd7+UEHYA189Dma3tNfuV=wu1TDw@mail.gmail.com>
X-Gm-Features: AcwNN1XSiMJoAPcTfunp320f7ZpZ-xZnSE6SFGsu7ok8i8KeWHrSdJWL2xS9j-s
Message-ID: <CAD++jLnBPAw9CJ4JtZt46yBd7+UEHYA189Dma3tNfuV=wu1TDw@mail.gmail.com>
Subject: Re: [PATCH] drm/pl111: Advertise no pixel blending
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Roshan Kumar <roshaen09@gmail.com>, dri-devel@lists.freedesktop.org, 
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, pimyn@google.com, 
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

On Fri, Sep 11, 2026 at 3:24=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
> On Wed, Sep 9, 2026 at 10:16=E2=80=AFAM Thomas Zimmermann <tzimmermann@su=
se.de> wrote:
>
> > > The PL110/PL111 controller scans out a single framebuffer and does no=
t
> > > blend its alpha channel with a background. Advertise
> > > DRM_MODE_BLEND_PIXEL_NONE to match the existing hardware behavior.
> >
> > Why does the driver report ARGB formats in the first place. I'm looking
> > at the code at [1] and I don't see any difference to XRGB. Unless I'm
> > missing something, please remove ARGB formats from this driver instead.
> > Drivers should not report formats they don't support.
>
> This should be the TRM for PL111:
> https://support.arm.com/documentation/ddi0293/c/?lang=3Den
>
> I checked it and indeed the ARGB* should be search/replaced with
> XRGB everywhere.
>
> Shall I propose a patch?
>
> I also have the actual hardware so I can test it properly.

Ah I see Roshan has already sent a patch (sorry for the confusion).

I will review/test that patch.

Yours,
Linus Walleij
