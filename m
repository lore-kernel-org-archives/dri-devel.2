Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F6BC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8832210E3C6;
	Tue, 21 Jul 2026 20:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hCEGACkh";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37CDC10E5D2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:47:01 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso66636705ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784666820; cv=none;
 d=google.com; s=arc-20260327;
 b=SdsmagvVBcNNPrS9xBtsmYVeA59DWfhOO0JVlnMBrJSSQCCshE+QAshff26KshRRyY
 dxOJrPHHp0AN4ztsAl7X7kAeQBbTbAs3mxV82G7Oj94OAciNkHaJaVxUZ8p49Gmn7tNc
 nz5TbZgd6vjCRtjZVpajZZlidrA+sBADGzHyI9+4p2KOXHeJuNjin0O+Dhyk2WU1iaBJ
 FJ+3ii+OqutSZapYTVRtSNSDXeC6sXxYlPCUyWEvXwqiQYH/lp/w8h0fpnzUF5QfJ963
 NpH/pR20kydkBQ3CZY3hTIwamkNTHYFMDOk8OWxGLjX7a7YgeA79SEMogXFEYf207hhL
 RkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GJbUbySs84LNWjl5SycArBud2hG3wkiE9tEYI1yGGjI=;
 fh=I99sHGDaPQv0PlNBVP4cPSvUVceJaqkJEEDfLnGP/z4=;
 b=H5glPw67rcELWQ6VPNRegLkDIuldqU/1aXSObFzVWpH1bK+3UI7jp5HdL48HiCfSkI
 rqEN5LVUOL+9v0ch5Ht3092rq2m8uO6wgQrSEseme1mqmUHRRHwQAmQW2/ZdiW3DTamM
 D53aneNkxNXO/KWMkDhRBMT54W97fnKI/GZragNTxWgznAryZa/hZ72UC980QdRylkj8
 Uyfe69QIO8bo+5VB5Ivf9B+FQYzW2n4UOoshOjHKSE4n+mx+e+5MESLRZMJXk23sJNey
 qgP2YBbIAszPzTeMx036RD8FGQJyEnQ62QifuNZXvbKvSdK78yTORuRHstsEASQAKNBJ
 Ybag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784666820; x=1785271620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GJbUbySs84LNWjl5SycArBud2hG3wkiE9tEYI1yGGjI=;
 b=hCEGACkh//oq7YDM1B7Px0QQLalluJ58VGC+OBjPvkqlWkGuN2JZ89MQtk5WXWn1nC
 2JO1DLcXN0OtRubo4XzTVKG2ZqpA0nnOMWq37QYraB9hMJjU1C4+RJhxQwSqkFOW7O4k
 M58nn/bJvGUGAMoXZtINWYDlH7WAV1KzKxuub22rIkIDv5bdj0sQGtyGO05JAm9apSLF
 fXjwYo/ZmnqrK5Yt1HOrCv1oTJSU7EYHHg/ESTozOjCe+VExjVAmSfMlrLcV4PqNlVG3
 txD/stf6S39xUZs3HXJFTMK4lqlf6teLyzmtIAHVlF+EdQm/1gAqIMZpelpDaJbyOxe8
 XMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784666820; x=1785271620;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GJbUbySs84LNWjl5SycArBud2hG3wkiE9tEYI1yGGjI=;
 b=M5QRhG/SYNasH70QxLoSizR5HJboAqAG88ctHysdQgQHOAWF4meRLMLV1QCXpWOVNu
 WDwpcXbEqX32SlEz+o3txMo36GGyn2rl32OnLrPL7fovYLCb8byhyVOLFv/b18kHD+Ej
 5eQT3CXmC65lxua7orZe1t4kk0J/+9PJv/Bz8P/DQZzlVIaWWMdGD/wZeE9Pq66uj7fU
 E3RecnLG5n72iFly7heo5w9E5hEBcGK5EyJHNJrvGvUseXlYEXwUbuUohE02i+yd3DVn
 mvbFGCKdAc4E4WkrsTQ/RXpvEqEYg1J//SP13Fzvs6tddNuobTtxq5vuRKBKFOotFRf6
 /xgA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDpX6Uv5Jnj4co8ufJosq0vYTtMYZh50KEKHJcoTwE5fw1ZvOP432zVK1czpi3nrXpToDt5xMJk6M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHoRA/RjiOP8jmiH6OrjQVkeBgSclQg6sOuILjUvGI9tacWabe
 rkRumuSlpVaybUwyr8J3boGLn4XTZpD7zs2TaKw9iS48kkA3niYLCFZU3VfRoVfiok3be/HqTmx
 fm7VKNuAb6yBQN72thOXt05w9BAF0Jxg=
X-Gm-Gg: AR+sD10x+URULTmQoSNAKAPsVEENLH5LN7YZ2T4YH82X0gWmZ+bFC4GEmXRnbZ2p9KK
 oSs15raz+4m7PMLvsOOsTZbgPAsX6topU1sAhoGU0mc9/L9YXlNW0/cdJled5uPEtX9A1t8r+wE
 Fo2mSYs+aKRaxTYFAjxSVKt9wNM0+nUrDsYC8ZWY6mtdjBqTRtB+pJ6FA0b90zcFHSotx+kIktc
 XqQ/QKFKaKMow+463crmX76QmieRWL0ypT1OzeU8JJGJESP+8O2jED06CucbRHLg5VtVg==
X-Received: by 2002:a17:90b:4b04:b0:37e:1620:dabc with SMTP id
 98e67ed59e1d1-38ea3203c92mr1107979a91.0.1784666820492; Tue, 21 Jul 2026
 13:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
 <d17afcac57059fc5effc786321ac43cc6d0b2c30.camel@redhat.com>
In-Reply-To: <d17afcac57059fc5effc786321ac43cc6d0b2c30.camel@redhat.com>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Wed, 22 Jul 2026 00:46:49 +0400
X-Gm-Features: AUfX_mzU0gvZD_QQT3Qph1MI2ZWe3n4-T0xRbt8Sz7wnfNAh6FJ04Xhdy4VnbSA
Message-ID: <CAA+WOBstz=K3MgfLSMG2Nh=gsrLyTi98qato0QtJicYoyG5LJQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] drm/nouveau: GSP telemetry via RUSD, and fdinfo
 telemetry exposure
To: lyude@redhat.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mary Guillemard <mary@mary.zone>, 
 Milos Tijanic <mtijanic@nvidia.com>, nouveau@lists.freedesktop.org
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

On Wed, Jul 22, 2026 at 12:40=E2=80=AFAM <lyude@redhat.com> wrote:
>
> With the various nits addressed or responded to, for the whole series:
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> (I assume with you moving stuff into nvkm I might need to re-review
> later, but that's fine with me)
>

Thanks a lot! All your suggestions are fine by me so I'll incorporate
them, do the shifting around to prevent the errors on unsupported
metrics/cold reads from reaching userspace, and push a V2.

> On Wed, 2026-07-15 at 01:14 +0400, Mohamed Ahmed wrote:
> > On the GSP firmware, nouveau reports nothing about the GPU. The GSP
> > owns
> > the sensors, so the legacy nvkm therm/clk/volt hwmon paths never run,
> > and
> > monitoring tools have no data to read.
> >
> > GSP on later firmware does publish all of it through a stable
> > interface.
> > It maintains a shared-memory region called "RM User Shared Data"
> > (RUSD),
> > which the firmware fills with all the relevant sensor readings like
> > power,
> > temperatures, clocks, and many others. Consuming it needs only two
> > internal subdevice controls: INIT_USER_SHARED_DATA to register the
> > buffer,
> > and SET_DATA_POLL to tell the GSP which data groups to poll and how
> > often.
> >
> > This series makes nouveau a RUSD client and exposes the data through
> > two
> > main surfaces:
> >
> >   - hwmon, for the values that map onto standard channels: GPU and
> > memory
> >     temperature, GPU/board/VRAM power, power cap.
> >
> >   - sysfs, under /sys/class/drm/cardN/device/rusd/, for everything
> > hwmon
> >     has no channel type for: clocks, utilisation, pstate, throttle
> > reason,
> >     ECC counters, PCIe error counters, and everything exposed to
> > hwmon as
> >     well. One value per file according to sysfs convention.
> >
> > Polling is demand-driven. GSP polls a group only while a client is
> > reading
> > it, and a group idles off after 10s after the last read. Polling
> > costs
> > power, so nothing is polled unless someone is looking. A section that
> > has
> > not been polled yet, or that the board does not support, reads -
> > ENODATA.
> >
> > The sysfs interface is documented in
> > Documentation/ABI/testing/sysfs-driver-nouveau.
> >
> > While the original scope was RUSD support only, monitoring tools
> > needed
> > two extra additions to complete the picture:
> >
> >   - VRAM size and usage on sysfs (patch 5): since this series adds a
> > sysfs
> >     interface for nouveau, it's better to expose VRAM metrics there
> > rather
> >     than force monitoring apps to pull in libdrm for the GETPARAM
> > memory
> >     ioctls.
> >
> >   - fdinfo (patch 6): nouveau implemented none at all, and monitoring
> > apps
> >     could not show per-process GPU and memory usage. It now reports
> >     per-client memory and per-engine busy time, accounted from the
> > DRM
> >     scheduler that the EXEC/VM_BIND path already uses.
> >
> > Limitations, caveats, and additional considerations or questions:
> >
> >   - RUSD needs r570 or newer GSP firmware; r535 does not have the
> > needed
> >     controls. Pre-GSP and r535 behavior is identical to what it was:
> > the
> >     rusd/ group is not created, and hwmon keeps its current behavior.
> >
> >   - This is all read-only telemetry. Clock, voltage, or power control
> > is
> >     through other interfaces out of scope of this series.
> >
> >   - The sysfs interface exposed here should be stable and valid for
> > nova
> >     as well. RUSD is stable and only grows more fields with newer GSP
> >     firmware (e.g., fan telemetry gets added in r580), so it is
> > possible
> >     to keep the same interface as we use newer firmware or as we move
> > to
> >     nova and any potential considerations should be ironed out before
> > this
> >     gets merged and the interface gets frozen.
> >
> >   - amdgpu offers a single binary blob with all the telemetry
> > embedded in
> >     addition to the sysfs sensor files. This series currently only
> > exposes
> >     sensor files, but it is possible to add a similar binary for a
> > v2.
> >     This mainly offers a more efficient way to read the telemetry as
> >     clients would read only a few files instead of reading all of
> > them.
> >
> >   - The last two patches don't depend on RUSD and work on every GPU.
> > But
> >     they are here because they complete the sensor telemetry story. I
> > am
> >     happy to split them into their own series if that is preferred.
> >
> > Userspace WIP work built on this sysfs surface exists in form of
> > nouveau
> > backends for nvtop, LACT, and a NVK HUD:
> >
> >   - nvtop: https://github.com/mohamexiety/nvtop/tree/nvtop-nouvtop
> >
> >   - LACT: https://github.com/mohamexiety/LACT/tree/lnouvct
> >
> >   - NVK HUD:
> >     https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/39898
> >
> > None of these are merged yet and exist for testing only. Upstreaming
> > will
> > begin when this series gets merged and the interface is stable.
> >
> > Mohamed Ahmed (6):
> >   drm/nouveau/gsp: vendor the RUSD header
> >   drm/nouveau/gsp: add RUSD telemetry support
> >   drm/nouveau: add GSP hwmon support
> >   drm/nouveau: expose RUSD telemetry via sysfs
> >   drm/nouveau: expose global VRAM size and usage via sysfs
> >   drm/nouveau: expose per-client GPU usage via fdinfo
> >
> >  .../ABI/testing/sysfs-driver-nouveau          | 167 ++++++
> >  MAINTAINERS                                   |   1 +
> >  drivers/gpu/drm/nouveau/Kbuild                |   1 +
> >  .../gpu/drm/nouveau/include/nvkm/subdev/gsp.h |  33 ++
> >  .../drm/nouveau/include/nvkm/subdev/rusd.h    | 114 ++++
> >  .../gpu/drm/nouveau/include/nvrm/nvtypes.h    |   3 +
> >  drivers/gpu/drm/nouveau/nouveau_abi16.c       |  16 +
> >  drivers/gpu/drm/nouveau/nouveau_chan.h        |   2 +
> >  drivers/gpu/drm/nouveau/nouveau_drm.c         |  22 +
> >  drivers/gpu/drm/nouveau/nouveau_drv.h         |  29 +
> >  drivers/gpu/drm/nouveau/nouveau_exec.c        |   3 +
> >  drivers/gpu/drm/nouveau/nouveau_gem.c         |  16 +
> >  drivers/gpu/drm/nouveau/nouveau_hwmon.c       | 375 ++++++++++---
> >  drivers/gpu/drm/nouveau/nouveau_sched.c       |  87 +++
> >  drivers/gpu/drm/nouveau/nouveau_sched.h       |  11 +
> >  drivers/gpu/drm/nouveau/nouveau_sysfs.c       | 311 ++++++++++
> >  drivers/gpu/drm/nouveau/nouveau_sysfs.h       |  10 +
> >  .../drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c |  26 +
> >  .../drm/nouveau/nvkm/subdev/gsp/rm/r535/rm.c  |   1 +
> >  .../nouveau/nvkm/subdev/gsp/rm/r570/Kbuild    |   1 +
> >  .../nvkm/subdev/gsp/rm/r570/nvrm/rusd.h       | 303 ++++++++++
> >  .../drm/nouveau/nvkm/subdev/gsp/rm/r570/rm.c  |   1 +
> >  .../nouveau/nvkm/subdev/gsp/rm/r570/rusd.c    | 531
> > ++++++++++++++++++
> >  .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |   7 +
> >  24 files changed, 1990 insertions(+), 81 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-nouveau
> >  create mode 100644
> > drivers/gpu/drm/nouveau/include/nvkm/subdev/rusd.h
> >  create mode 100644 drivers/gpu/drm/nouveau/nouveau_sysfs.c
> >  create mode 100644 drivers/gpu/drm/nouveau/nouveau_sysfs.h
> >  create mode 100644
> > drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/rusd.h
> >  create mode 100644
> > drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rusd.c
>
