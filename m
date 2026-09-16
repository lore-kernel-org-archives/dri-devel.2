Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10124C982CC
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B1310E1E5;
	Wed, 16 Sep 2026 23:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SiSRZ2Xv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 830C510E2DD
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 23:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789602852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hzPhM0cpITyXs1Muz62V+gilV41wWL46LsD2m7YxMD4=;
 b=SiSRZ2XvwCeZ65RNUkzsy/cbnPU+WssScjF2VcU6My3yZq/haviRme/ps6URfnm0TYxc8z
 ie4zbD+FZw6D+mLnK8Hw7rPnze3i6B7iaFJlW/iFs5kWFd8aV6hfzQnHp00xOnr6ERgO6Y
 mBkb9Q1TCx33zFh/xlokJxUkjL+rLEM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-lmdKUICJOLqNSQ9KiVGN-g-1; Wed, 16 Sep 2026 19:54:11 -0400
X-MC-Unique: lmdKUICJOLqNSQ9KiVGN-g-1
X-Mimecast-MFC-AGG-ID: lmdKUICJOLqNSQ9KiVGN-g_1789602851
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52fc0097865so6276871cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789602851; x=1790207651;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hzPhM0cpITyXs1Muz62V+gilV41wWL46LsD2m7YxMD4=;
 b=Y4FszsHMxthk4g8LCnQNFsU63Yag4h2kXmFkZrbFmS8AJCCW0UrAArD0lGk7uLMcaX
 Lupf8cJ6KISJne9GdsbiNu/4Qy/EutnoEQ5nRe1a23emigtufnKS8Wrvoi+os2UtNCF1
 1XdM0WvT9XvPaPAtdfUl8HsrZOMSp465pcL84ePMRooi5CgXxpUGVLArKBfGArG8D+5o
 ZBRMnwfOrD7b6cL/boshiK2w8kS8PGC4dwI0nvAK1m5GiGLXHWt3jlnUjml4brtj/rVa
 l4RP103LXxGE48seHe0HRMAb5airSDK9OsW+IutXLPURch75dp/gp0CylkH2AYyoEmpR
 B1iw==
X-Gm-Message-State: AFuF++ni8jnVcocoJFT+H1RtTUYriIVaomRvjzlnD7gDccZbUfYLeTs5
 K+qgLORMgEhtfqhXa23qWoRank+ldsMUUqByC/SD77xa5FWK8ak4M04w3MFo1Yt46nb98mPvKWC
 RjSICYycHY/uYIVza6y9uta7uNyY97/h6Ffx10A2R+o5kk/IT+E3y16yBeLTm6Chm6V4FLYM0YY
 /foaKFQR9OW1gmtRqgDtUkdfyI7hBD2CPx0Bm3So5oRAOR
X-Gm-Gg: AYBFou0VHhPst6TW8bgDVnufPycoJMm1IuLV6ofmRThirSyrPpLGrkjn2VU+O5LvvoB
 kFVypGF/ZSV5iD2T5IBgZgxgpim9Fw/qfH2E0b/OR50l3S16RSRyUQ6twkjDQenog2MwF8IzIZw
 b0UqGHiGMhSuqVJyU+rGwI+WUDO9znW9GU5q/ZHlzzSHvUPHv9pkyeYFLW4vNl1IrDm7A8rwSn8
 scqUcHBvYxCwz0c
X-Received: by 2002:a05:622a:5c07:b0:531:4a1:fecf with SMTP id
 d75a77b69052e-5327f205baemr75469291cf.5.1789602850728; 
 Wed, 16 Sep 2026 16:54:10 -0700 (PDT)
X-Received: by 2002:a05:622a:5c07:b0:531:4a1:fecf with SMTP id
 d75a77b69052e-5327f205baemr75468981cf.5.1789602850383; Wed, 16 Sep 2026
 16:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260916223358.507351-1-lyude@redhat.com>
In-Reply-To: <20260916223358.507351-1-lyude@redhat.com>
From: David Airlie <airlied@redhat.com>
Date: Thu, 17 Sep 2026 09:53:58 +1000
X-Gm-Features: AcwNN1Vpx5SyQyvxSmIp5NIx5rhO2o5NzGsoeUHN5bDWmRFbcrc4SeABQVS8KHw
Message-ID: <CAMwc25oJvW8gRjZ5J3+w2xSNyfjTT1X-MAiYPSPmq_-SB+=goQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] drm/nouveau/gsp/r570: Follow OpenRM's runtime PM
 process more closely
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Kees Cook <kees@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
 Mel Henning <mhenning@darkrefraction.com>,
 Hongling Zeng <zenghongling@kylinos.cn>, 
 Danilo Krummrich <dakr@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i3hSRYKPbPzDUiRX4HBA9vhJP1iYOp8UHJD-u180XTM_1789602851
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

On Thu, Sep 17, 2026 at 8:34=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrote=
:
>
> While we have runtime PM working a lot more reliably then in the past
> with R570, we're still doing things a lot differently then OpenRM. For
> instance, we don't save/restore comptag backing stores, and we don't ask
> GSP whether it's OK to enter GcOff.
>
> This series fixes this, and gets our runtime PM process to look a lot
> closer to OpenRM's by implementing some missing pieces and workarounds.
>
> Tested on my daily-driver desktop with an AD102, a ThinkPad P17 Gen1
> with a GA103GLM, a Dell Precision 7780 with an AD103, and my test
> machine with a GB206.

I've replied with a couple of minor fixes but with those applied.

Reviewed-by: Dave Airlie <airlied@redhat.com>

The rules for devices are 0080 ctrls on device.object and 2080 ctrls
on device.subdevice.

Dave.

>
> Patch series based on drm-misc/drm-misc-next. Branch with patches here:
>
>         https://gitlab.freedesktop.org/lyudess/linux/-/commits/nouveau/rp=
m-openrm-sync
>
> Previous version:
>
>         https://patchwork.freedesktop.org/series/173901/
>
> Lyude Paul (5):
>   drm/nouveau/gsp/r535: Add support for INTERNAL_GCX_ENTRY_PREREQUISITE
>   drm/nouveau/gsp/r535: Add support for MEMSYS_GET_STATIC_CONFIG
>   drm/nouveau/gsp/r570: Add comp mode workaround from issue #3172217
>   drm/nouveau/gsp/r570: Start saving comptag backing stores
>   drm/nouveau/gsp/r570: Enable Gcoff in fbsr again
>
>  drivers/gpu/drm/nouveau/include/nvif/cl0080.h | 10 +++
>  drivers/gpu/drm/nouveau/include/nvif/device.h |  1 +
>  .../gpu/drm/nouveau/include/nvkm/subdev/gsp.h |  6 ++
>  drivers/gpu/drm/nouveau/nouveau_drm.c         | 13 ++++
>  drivers/gpu/drm/nouveau/nvif/device.c         | 13 ++++
>  .../gpu/drm/nouveau/nvkm/engine/device/user.c | 35 +++++++++
>  .../gpu/drm/nouveau/nvkm/subdev/gsp/base.c    | 10 +++
>  .../gpu/drm/nouveau/nvkm/subdev/gsp/priv.h    |  1 +
>  .../drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c | 17 ++++
>  .../nvkm/subdev/gsp/rm/r535/nvrm/gsp.h        | 52 +++++++++++++
>  .../nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c    | 77 ++++++++++++++++++-
>  .../drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c | 36 +++++++++
>  .../nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h       | 29 +++++++
>  .../nvkm/subdev/gsp/rm/r570/nvrm/gsp.h        |  7 ++
>  .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |  3 +
>  15 files changed, 308 insertions(+), 2 deletions(-)
>
>
> base-commit: 5589ef09f93b85b6f506e279a502d4cf1654f232
> --
> 2.55.0
>

