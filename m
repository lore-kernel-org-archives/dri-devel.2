Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0685CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 23:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC5F310E910;
	Mon, 11 May 2026 23:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hkAeUVRc";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D57210E910
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 23:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778541122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0UCe28zV972AZiRYDMg8zfbzIHf06WRxGbzFTsKV4rk=;
 b=hkAeUVRcKy3yWV2CGUpfZPTR4wJoP1l4mwMV6z3RCpTFSEs4QH9b5UemYXB6DbHO5uWtrA
 nJLkEwJAM9HJfw2WwnXZk/nx9M7+E9XDv3ROdy1tvOLrGKNsKYBl3ejzpEKsSe/q20CHcP
 QQ1nZRSpJTDYMz+p6JpyOE7QAJac55E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-AmBSqXFdN6CpKoxtNF8kOA-1; Mon, 11 May 2026 19:12:01 -0400
X-MC-Unique: AmBSqXFdN6CpKoxtNF8kOA-1
X-Mimecast-MFC-AGG-ID: AmBSqXFdN6CpKoxtNF8kOA_1778541120
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36641bb3d97so2771930a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 16:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778541120; x=1779145920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0UCe28zV972AZiRYDMg8zfbzIHf06WRxGbzFTsKV4rk=;
 b=AK3FYke5QcdU1YkdfVLt4WEaNxBeP6tAFgreiSqJa5SxW8Gdii/qwCJHwTOsgU4O5v
 MobBYexoEy5VOPAHxzDtFCiBCS3o77TnwUFDurMgBG48X89dDJsiKnF6MKh+CWAeXRoK
 hLPCz+X5+FaMf4IWZQQCxQ2s3RT1LNJjAbRr5lbvZClWgP6SSn9ezAnHfH2pFfTw2CiQ
 TCxvxm7oalae+V40V/9Rv6c/oEtU/ctFWrJ4EWHD6UWRd208EB2H1rf6VfyJ7hXLVFxD
 QGXsMAEJaP+bh2dFseWv4T5pqOSVzRBmIcnCssBB/iPFq6WOk65L6zwfD+jyMeVRS5Od
 2x3A==
X-Gm-Message-State: AOJu0YxzXDj1ofdb0N/m4fk/llIxr+ugHcnEC/B6/lfQeUoG83+Ejdiw
 DzLldL9ojCJKOqCYRzLKYyWT6fCrHsb/wvhTJOE2E1TrNokAZwMPN4UXWZxoFOsS3H0mEcEPZIz
 ttlgrbSfJ7ChmqBTpBR038fMojs8YrAYKHdFs615OVesQo0DLCcJ9LGNSLaLvBt/Il6DYaEqwbn
 1FJAPHB2r7pPRtAPWWo5quxZhHQypW5f5T/X8rsy78cDcM
X-Gm-Gg: Acq92OEXdAmn0XFmACXKQkJPeyoRxZa0yWjsa2Vt0UOI+y+B/Ltvmm1oNPYm/eWQKzp
 CqSjk46ecJvg0AUHk7e7wpHVz4/hD16HBjOvua9w9WuQrJnPr8+/WbtB4XkPy4vwKRppxwvag8P
 O2MTI7JzaGNk8GcW/4czUiBBsoAbwZV9ngzmuGxA3j8G4N0YiyZv3JAW3fXd1/KuJECRA4ioh18
 zTjDIPBGSTL0f2p+FkTTtgbdjC9P7nTxoLbW0E=
X-Received: by 2002:a17:90b:3c0e:b0:366:4a47:f26d with SMTP id
 98e67ed59e1d1-367d4890ab9mr11754013a91.14.1778541119970; 
 Mon, 11 May 2026 16:11:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0e:b0:366:4a47:f26d with SMTP id
 98e67ed59e1d1-367d4890ab9mr11753982a91.14.1778541119467; Mon, 11 May 2026
 16:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260424220953.167058-1-mario.limonciello@amd.com>
In-Reply-To: <20260424220953.167058-1-mario.limonciello@amd.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Tue, 12 May 2026 01:11:48 +0200
X-Gm-Features: AVHnY4Lm9uuWDwEERXpiOWtAgRKphjtR16AykzOhcOiW8C0tKuItbULL4Vrthtk
Message-ID: <CA+hFU4wEODFP=oPw522MyQs1asGq+KyYw6rcKpxxxj0y75fPXg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Add support for a DRM backlight capability
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com, 
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <superm1@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eJDypIywYkZOx1uTW1y7jKZzMzfRKmvZncTJYdh9Be4_1778541120
X-Mimecast-Originator: redhat.com
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

On Sat, Apr 25, 2026 at 12:10=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> From: Mario Limonciello (AMD) <superm1@kernel.org>
>
> At Display Next Hackfest 2025 we discussed the renewed need for moving
> brightness control into the DRM connector properties.  I've taken the
> previous efforts from David and Marta, rebased and adjusted for the
> current kernel.

Thanks a lot for this!

I've wired it up for mutter but I don't have a machine with AMD
graphics and an internal panel, so I can't really test it.

https://gitlab.gnome.org/swick/mutter/-/commits/wip/kms-luminance-prop

I've also noticed a few things while doing so:

1. There isn't a bit of information which tells user space if the
property is actually backed by anything
2. A fixed range from 0 to uint16_t max might be problematic for
backlights with very few steps

Could maybe fix both of those issues by making the range dynamic to
the actual numbers of steps, where zero means that there isn't any
backing backlight device.

> The legacy sysfs interface is synchronized with the DRM connector (althou=
gh
> the scale may be different as DRM connector property is u16).
>
> Later after this has been adopted by enough userspace, it may make sense =
to
> configure the legacy sysfs interface to be configurable so that only
> DRM master controls backlight.
>
> I've done a first implementation with amdgpu with eDP connectors; but
> conceivably this can be extended to other connectors like DP for displays
> that can be controlled via DDC as well later.
>
> I have also used DRM review prompts to review this series and fix some bu=
gs
> which were caught with two different Claude models.  The fixes are squash=
ed
> into the patches.
>
> Assisted-by: Claude Opus
> Assisted-by: Claude Sonnet
>
> For ease of testing; this series is also available on this branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=
=3Dsuperm1/backlight-property-v3
>
> David Rheinsberg (1):
>   backlight: add kernel-internal backlight API
>
> Mario Limonciello (6):
>   drm: link connectors to backlight devices
>   DRM: Add support for client and driver indicating support for
>     luminance
>   drm/amd/display: Pass up errors reading actual brightness
>   drm/amd: Indicate driver supports luminance
>   drm/amd/display: Allow backlight registration to fail
>   drm/amd/display: use drm backlight
>
> Marta Lofstedt (1):
>   backlight: expose the current brightness in the new kernel API
>
>  drivers/gpu/drm/Kconfig                       |   1 +
>  drivers/gpu/drm/Makefile                      |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  88 +++-
>  drivers/gpu/drm/drm_atomic_uapi.c             |  24 ++
>  drivers/gpu/drm/drm_backlight.c               | 406 ++++++++++++++++++
>  drivers/gpu/drm/drm_connector.c               |  12 +
>  drivers/gpu/drm/drm_drv.c                     |   8 +
>  drivers/gpu/drm/drm_ioctl.c                   |  10 +
>  drivers/gpu/drm/drm_mode_config.c             |   7 +
>  drivers/gpu/drm/drm_mode_object.c             |  66 ++-
>  drivers/gpu/drm/drm_sysfs.c                   |  54 +++
>  drivers/video/backlight/backlight.c           |  83 ++++
>  include/drm/drm_backlight.h                   |  45 ++
>  include/drm/drm_connector.h                   |   8 +
>  include/drm/drm_drv.h                         |   7 +
>  include/drm/drm_file.h                        |   8 +
>  include/drm/drm_mode_config.h                 |   5 +
>  include/linux/backlight.h                     |  30 ++
>  include/uapi/drm/drm.h                        |  10 +
>  20 files changed, 852 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/gpu/drm/drm_backlight.c
>  create mode 100644 include/drm/drm_backlight.h
>
> --
> 2.53.0
>

