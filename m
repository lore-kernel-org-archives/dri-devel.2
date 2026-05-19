Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EFECD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 00:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A3710EA01;
	Tue, 19 May 2026 00:36:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pY9hsAu7";
	dkim-atps=neutral
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB1910EA01
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:36:52 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-7c58e6eb2c8so23400697b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 17:36:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779151011; cv=none;
 d=google.com; s=arc-20240605;
 b=R8gWXlMAMS0EpYbbSTcnbYew1jyHrWIQTTF6CKig2zF8hqQfhE3+bU02Wk2QYfbCsd
 wPfwDtZGS5rPtIDDSUZeUreV8phO3x5rPvg16/OJmpkgrWMnXYVJRq6WH36waQZC3c1u
 YAuJuyWhSk0HPTNovIJb8tOUNoQ+6U3pE0eWRTNiMWwY2KgRpomE5GNc9+wO40gpd9bF
 pGgieixBbrv5d6ecvFDt8k4GDSjY6ZD2OYElqrhj1ym60ZbkfNArtwambcfeQ3Pr0xpH
 WRuxivOF1ZE/6Q0BwX+52yk1ynXK6SUGSBEeNrl3F/7rIdWqx/gcHJ1v6hSzCvJpKfol
 xIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e+1ZOpCnfvlGWakwJXz2+pZiiMxmIhCH5N4QtF0t85s=;
 fh=ODuPE8tvV2UzwFkHM+yspcsofO7Yx9j/eRxQRRBgyWM=;
 b=RuzfBdMyO1GEXMudkbNI7/pn2h/5GiJmbz206Wtl55DBy328JgfNJ/sjn1QeicASPe
 E4yQ/NlMeEamLflAEorjfEAGQBb2YP6mEjBr7BG7yqrv4wSJ/CV97viDRXVhe3pIQWqg
 HeD3doOVtAm9aTngZYhteXQCw4/B7R2HdSxGZhhaFK1a3K+63PXquVi6U4umGjEP+i2C
 do4oS8zX7sURmT2atCZgNI/eGOPpXBw8x1MVv190CQkwjkSnzjV4Rhum3803K3E5VK/J
 lOFJectGfWof0ziM0ERMhq2UrsFMw6cFz/jlt8MKjVbyaJI/9r19ibkAw3ArRwYXC8+9
 COxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779151011; x=1779755811; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+1ZOpCnfvlGWakwJXz2+pZiiMxmIhCH5N4QtF0t85s=;
 b=pY9hsAu7QNp2oxQdFZKPYCuw9KsuEYPl6ri3Lxb17q+QiT88xWvrfaf+r+CQMKORvJ
 15ELZWvkxEd7lYciKzSk4EFvl9wif5H5lUwSzqYZsqM1JRUtEnu2vbIU/LDvtxUSX5Lz
 b+AKEJLbt4hwwpO2ouT8uZ7FhfyhIqcqzfIUnhBR6W4jNIuri/35jtUii89hlMQbpb/r
 E3sTo7JKXs2MUF88vxbzPFiT5ZEQQZ9aff0zbZMLwz8GblXVGfrB/Ci4BXyEjOyoKJ64
 OlLSMJKHkV0FNrLSCXJw6V9hwuv5nwff+pIqM3FYkT2GJYGyorqi/jzKZseyC/1+yTjO
 89Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779151011; x=1779755811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e+1ZOpCnfvlGWakwJXz2+pZiiMxmIhCH5N4QtF0t85s=;
 b=repwl+gQsmhCzzhF8clNP4/4TJYBraDXakth28xFOnPKDAje4alzbccn/UgOFOTzmT
 iP15O6lXH7J34piC9xJeYxjyXeE4vfBgXqXvM9g/Qr9b+OzJLFP1kKab7HkUQ5DhIt7o
 bZr50Luox1y2Jka0c5vJGhgqvc7iuvuo3yFA+A3SG5JKBL+xsY9MGSeQp7E+5KjeL0IU
 VASoQ2uItUnucKtyHgMuQ0jKD0mPHf2G4BGa3QIh3E60BwksxzmohLEylKtmzhKD2Ybp
 mosZZ2UwQuTQGE8w7E+7yqDS7CH+so9jShSvh9kgYAYhmw6TGNSlQd6wINdW7dM+G1HP
 Ok3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6WQwPnErdGhMTjtkeLFLdJQyrmJVHkgrtzetmGQpZLYV9OFj2jhWXGBWkAcFl5Oz4NtyOqHph7P0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyO/Ho0q1JcXBeyoTblkTHT4HA3ei9o5Q1gb1SakidAB4fEDsXQ
 zhtuIVI70B2YugrYTkR7wUPRYSnmTAX6cjrHHY8cm/9Mbie85NG/78cncdMrDHosNpkZMKTOIrn
 tr1RryY3yPukGPYPWmW6Yyc1eYjq8kpM=
X-Gm-Gg: Acq92OGzF52CZlOEPKMfBozSFOw9KNWB3JWVJx0LzIPNUsYtBMyK52UhtOgQsV/jkHD
 REn6I3Z8JiiPIoxNJlYy++sgrt/F7aaGyegggkIcxouf8Mua4RFBZhHbgNwxEjZNXLVkI4HfR46
 LK12O6ZQDHINYkmVBkmgY5vfF3dKw3YDH8wGy1ixRzZt8a6c03xyV4kdv1miAVdYmYiMj78s5qt
 dRwhIdkuU1wVROTfNEbip5hwoiNW5t616ekDa7xlLSsSIj3zFRg7itj3g/cMwuK3WY+eid2AaJX
 S8uhmxxQq/KxW4/0j9oFsrIfy8F7JZyfYV8LYghefc34vsBhx07lJCIeoiq1nIvg7O+vahl5
X-Received: by 2002:a05:690c:19:b0:7bd:5cc4:3e49 with SMTP id
 00721157ae682-7c9597a969fmr213746077b3.12.1779151010945; Mon, 18 May 2026
 17:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
 <20260505140516.1372388-5-ketil.johnsen@arm.com>
 <20260505181523.49a3d85c@fedora>
 <afxVIuVVPisBQ9p_@e129842.arm.com> <20260507135356.5428d50d@fedora>
 <agMvb_jeRsO7tSS-@e142607> <20260512161111.0cb7000e@fedora>
 <agNJasayW8VCHTiU@e142607>
 <CAPaKu7QC7FdjL6m_OSb+E5aYKs6bmT-9DAHc5PC=XctCmRph2Q@mail.gmail.com>
 <20260518091650.5a7a4f4a@fedora>
In-Reply-To: <20260518091650.5a7a4f4a@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Mon, 18 May 2026 17:36:40 -0700
X-Gm-Features: AVHnY4L_pqXJyhSchHbjEJHIXbJa2yYodKfZcbmSmhWAfddYBdzbaPZTcjMiQrU
Message-ID: <CAPaKu7R9ET767qc3eppBUfG2RAeyrg7E-gE0turgp-u_FU4+Vg@mail.gmail.com>
Subject: Re: [PATCH 4/8] drm/panthor: Add support for protected memory
 allocation in panthor
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@arm.com>, 
 Ketil Johnsen <ketil.johnsen@arm.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Steven Price <steven.price@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Florent Tomasin <florent.tomasin@arm.com>, nd@arm.com
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

On Mon, May 18, 2026 at 12:16=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Wed, 13 May 2026 12:31:32 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > On Tue, May 12, 2026 at 8:39=E2=80=AFAM Liviu Dudau <liviu.dudau@arm.co=
m> wrote:
> > >
> > > On Tue, May 12, 2026 at 04:11:11PM +0200, Boris Brezillon wrote:
> > > > On Tue, 12 May 2026 14:47:27 +0100
> > > > Liviu Dudau <liviu.dudau@arm.com> wrote:
> > > >
> > > > > On Thu, May 07, 2026 at 01:53:56PM +0200, Boris Brezillon wrote:
> > > > > > On Thu, 7 May 2026 11:02:26 +0200
> > > > > > Marcin =C5=9Alusarz <marcin.slusarz@arm.com> wrote:
> > > > > >
> > > > > > > On Tue, May 05, 2026 at 06:15:23PM +0200, Boris Brezillon wro=
te:
> > > > > > > > > @@ -277,9 +286,21 @@ int panthor_device_init(struct panth=
or_device *ptdev)
> > > > > > > > >                     return ret;
> > > > > > > > >     }
> > > > > > > > >
> > > > > > > > > +   /* If a protected heap name is specified but not foun=
d, defer the probe until created */
> > > > > > > > > +   if (protected_heap_name && strlen(protected_heap_name=
)) {
> > > > > > > >
> > > > > > > > Do we really need this strlen() > 0? Won't dma_heap_find() =
fail is the
> > > > > > > > name is "" already?
> > > > > > >
> > > > > > > If dma_heap_find() will fail, then the whole probe with fail =
too.
> > > > > > > This check prevents that.
> > > > > >
> > > > > > Yeah, that's also a questionable design choice. I mean, we can
> > > > > > currently probe and boot the FW even though we never setup the
> > > > > > protected FW sections, so why should we defer the probe here? C=
an't we
> > > > > > just retry the next time a group with the protected bit is crea=
ted and
> > > > > > fail if we can find a protected heap?
> > > > >
> > > > > The problem we have with the current firmware is that it does a n=
umber of setup steps at "boot"
> > > > > time only. One of the steps is preparing its internal structures =
for when it enters protected
> > > > > mode and it stores them in the buffer passed in at firmware loadi=
ng. We cannot later run the
> > > > > process when we have a group with protected mode set.
> > > >
> > > > No, but we can force a full/slow reset and have that thing
> > > > re-initialized, can't we? I mean, that's basically what we do when =
a
> > > > fast reset fails: we re-initialize all the sections and reset again=
, at
> > > > which point the FW should start from a fresh state, and be able to
> > > > properly initialize the protected-related stuff if protected sectio=
ns
> > > > are populated. Am I missing something?
> > >
> > > Right, we can do that. For some reason I keep associating the reset w=
ith the
> > > error handling and not with "normal" operations.
> > I kind of hope we end up with either
> >
> >  - panthor knows the exact heap to use and fails with EPROBE_DEFER if
> > the heap is missing, or
> >  - panthor gets a dma-buf from userspace and does the full reset
> >    - userspace also needs to provide a dma-buf for each protected
> > group for the suspend buffer
> >
> > than something in-between. The latter is more ad-hoc and basically
> > kicks the issue to the userspace.
>
> Indeed, the second option is more ad-hoc, but when you think about it,
> userspace has to have this knowledge, because it needs to know the
> dma-heap to use for buffer allocation that cross a device boundary
> anyway. Think about frames produced by a video decoder, and composited
> by the GPU into a protected scanout buffer that's passed to the KMS
> device. Why would the GPU driver be source of truth when it comes to
> choosing the heap to use to allocate protected buffers for the video
> decoder or those used for the display?
I don't think the GPU driver is ever the source of truth. If the
system integrator wants to specify the source of truth (SoT) from
kernel space, they should use the device tree (or module params /
config options). If they want to specify the SoT in userspace, then we
don't really care how it is done other than providing an ioctl.
Panthor is always on the receiving end.

If we don't want to delay this functionality, but it takes time to
converge on SoT, maybe a solution that is not a long-term promise can
work? Of the options on the table (dt, module params, kconfig options,
ioctls), a kconfig option, potentially marked as experimental, seems
like a good candidate.

>
> >
> > For the former, expressing the relation in DT seems to be the best,
> > but only if possible :-). Otherwise, a kconfig option (instead of
> > module param) should be easier to work with.
> >
> > Looking at the userspace implementation, can we also have an panthor
> > ioctl to return the heap to userspace?
>
> Yes, it's something we can add, but again, I'm questioning the
> usefulness of this: how can we ensure the heap used by panthor to
> allocate its protected FW buffers is suitable for scanout buffers
> (buffers that can be used by display drivers). There needs to be a glue
> leaving in usersland and taking the decision, and I'm not too sure
> trusting any of the component in the chain (vdec, gpu, display) is the
> right thing to do.
The heap returned by panthor is only for panfrost/panvk. It says
nothing about compatibility with other components on the system.
