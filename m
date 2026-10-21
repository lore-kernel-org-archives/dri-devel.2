Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5265606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ahB8ahlq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3830510E012;
	Wed, 21 Oct 2026 14:12:59 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98FFC10E043
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 14:12:53 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-7cc1848192fso43019137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 07:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792591972; cv=none;
 d=google.com; s=arc-20260327;
 b=EOURVeqe0kN0J/bRtKzUaLoO432eMkwMBtZwm2PXSnCu3O8WwX8m4Yf+N5dM7iu6EG
 Ci1k7/5qRbV7uq8cj1x6p/yCUiJq/p8rTQtXpqCXAnh+Y6riH01WE5Ea/09LxrsTLhzB
 L7VjAkcmmt1qbimS252jnWQS+TvPk1WHQ++iWmbgTY/RXJiNmnpoF3DNmujRRoA/KAcd
 zBWNp2P5N385VOaPqiWMI5xNkXlE2m4hRUtggO8tU0afSgJKFJ51m8GgSXr16/XjWJG1
 easIvyPJhpH0KGg23MyrRelR1dtfg3viuxUhZsDbnfXSnjuq5XLGxJSPnOqPcCREtmLu
 7QmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qQoWmb/HxHac52NQWhLiq+3ibthAyPMRZsuipu+rdAs=;
 fh=Z80vx8jJ+/6DIMSQr8Lx9q8/6HQxw3gA7BGkx4z6APM=;
 b=i7PPQzGv9qUkPNMKzoA5ZjmJMuFuVV8bf7/Temvz23olnslADmIP63Q1Ku70N+hJpU
 DlmOfCPqh2sP18syv9kazJsxIyAEDMjEXE7wUqEo7odGhyks0sxxRti/cAIeyXVCR9Ye
 Ug1U0IfCF4+pH7XUK1O0KdGb6f+iD3JeQ3/GxTonS8D1gFEaLhvA49CiKAeU1kjzdXXc
 LqoqJJBJPHJgJgljejqiCppx7PQu4h+YxOo/QHgsaMJ0bbvHvq27fjDCF4521sZRyRU2
 39JJQaHH6ZEueSVUJ18TaD4RbB9bQcLj9uCD39IM+qXCI2dB3inv90JS00AP30S2oH8/
 Hscg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792591972; x=1793196772; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qQoWmb/HxHac52NQWhLiq+3ibthAyPMRZsuipu+rdAs=;
 b=ahB8ahlqKm3bvzYZoQk6GRSrXfbgVueojP+Bskbno6m6dBORs04JUc+sr7d5dimzSd
 J5b1r2GTusllwswjMW0wAwPeqfAvj+ztdYAJ+tkd644vuJ2OwpZa5BAoYFeky/X7AsD8
 lp3ClWj7TtkdO2EyTgysDKrW6CTYMABbhxsM4JTWw2UDXpcuaOqyEY84IQpM2ItBe2ta
 ev/T3T41bmxDKGQJeS3ucoJ6Td3odakGvxM5r7Nd5ejAZc65eO4PhTNrCAQwsxMGTXk+
 DWnb4FRySmd0ywdwdo52KSRcGUBxsXCPHHpnppDv+6cOao4/AQVqmI71VsjvIX4TyZ1c
 1LyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792591972; x=1793196772;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qQoWmb/HxHac52NQWhLiq+3ibthAyPMRZsuipu+rdAs=;
 b=kmwbHcWhstQo0ttUd9qTt7DZRMJwgcgA4Pdn15xBYSyNUyndrVPCrNH9IlMxKXRFfr
 OKx00EH3TPCrPHiq5c6UwY8lpTKUr/E8bg8IDxQ5hx1Gs3N+FYYHz9xeb80jesdXN8Mc
 9uPbcL33xDhgzpNWhGw/nchaL2n9FIQhW/CINOaXq+p5A0WwVKXykj0dZlcbAXE+O/wu
 YvYkMqcAubnlvs3hVzgDwOh8Q3WXMD2jhDowShp5h3a81v0D8G9lPbNdVG/Cs1YfVl4e
 /BWrAnKwnuiayd7mbQgP+uzyFyEMRg0mWR8YVbumqBFK2WhkESYVorUnjxbu7EygQ1tY
 h+fw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWP5fr3gym0OaoHY/e7Chnnyb4XqGj3BmveuVfyoP/fYbahdsSwPpIUZVZYDf7uW3Iib8YgEnuqCA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI8NGVfpIW04uqfrr+i5n9peeE2JTTwuC64yhoDyFfw176DONj3
 flPWNiveYMBNQo1exCr3mp7Ypnd3X6PDrVAfjAdWjpax1covJkG4CHLEvF2vvwnGS9m0UD4nFbS
 2akkGm05GkONQonyDFwb+pbQUu6ik3lo=
X-Gm-Gg: AYBFou0woLL1noHk+id91OzNC8AOH4ED2cxVJpWAWIObsAKrr6OJFi070W1gMeu2Aiw
 LeBU1TIaY9Yw2HgGPWDVg6QMZ9ddvEyCt5okcDDOimGdnKvImP8cS3FHwu42untNA3oNd/4gM/O
 wKe7nxhxsy+maFg+wuAGcjf8xOTboNdI3++yNdKJwuTkUQJaDGn8VsE4g6Uzd6aXCIHRrQS0gd/
 U65xkgD3ZuQZVWzNmkk9Ak3xgBFD5e7n6wVQloo3EPyaexj0brr5qcpQPqe6GlXKdsSHQOohSXq
 o0WshnS5fl91knQg+ZdTdULAPJNkVUtkFUzDW5w/43HeO1W1yxaMsp4PzKAeLEelyi3l+AJl02/
 yew+oL+59atgKNvXq3dKxE3IlfZR8YkjQfZmpzWb0i/485FvxzdIEn9pS7bT2Wm8x4hZpgIxY2i
 mY1VEW3C1jhGMyHtOwWjh05C0=
X-Received: by 2002:a05:6102:4194:b0:7c8:3b8c:82ae with SMTP id
 ada2fe7eead31-7cc926171f6mr628639137.2.1792591972231; Wed, 21 Oct 2026
 07:12:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021114122.94008-1-mptagliari@gmail.com>
 <8c60afb2-cb0b-4aec-9237-2ea3404d2793@amd.com>
In-Reply-To: <8c60afb2-cb0b-4aec-9237-2ea3404d2793@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2026 10:12:39 -0400
X-Gm-Features: AclHuK-Mw9BGZVWGR9q1KrhBrhnJKuPSqN4NUM_n9lJDGuHjZIzRA7A2WIY6Swg
Message-ID: <CADnq5_N-9O7Ba_o-mbPQU98Fr=LnRoGeJG5TtguSeK9wRM2kwA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/radeon: fix VCE1 encoding on SI by handling the
 VCE interrupt
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:10=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> [Adding Timur on CC]
>
> On 10/21/26 13:41, Matheus Tagliari wrote:
> > Hardware H.264 encoding with the VCE block on SI GPUs (radeon driver)
> > hangs the GPU after a few dozen frames.  I hit it with the KDE Plasma
> > RDP server, which encodes through VAAPI, and reproduced it with a
> > plain "ffmpeg -vaapi_device ... -c:v h264_vaapi" test on a Radeon HD
> > 8870M (Cape Verde).
> >
> > The VCE1 code never enables the VCE trap interrupt and the SI (and
> > Trinity) interrupt handlers do not process it, unlike the CIK code and
> > amdgpu.  Patch 1 adds the handlers, patch 2 enables the interrupt.
>
> Oh, I do remember that I intentionally never enabled interrupts for VCE o=
n radeon. But I honestly absolutely doesn't remember why (that was ~12-13 y=
ears ago!).
>
> Timur hammered out most (all?) of the UVD/VCE bugs on SI, CIK and partial=
ly Polaris hardware as well for amdgpu and we are strongly considering just=
 dropping SI/CIK support for radeon.
>
> The fence handling on radeon should work completely without interrupts si=
nce those have been rather flaky on really old HW.
>
> So no idea why that actually crashes for you if the interrupt is not enab=
led, my educated guess is that enabling interrupts actually doesn't fix the=
 crash but makes it less likely because of timing change.
>
> Would it be possible to just switch over to amdgpu instead? Or is there a=
ny support still missing there?

VCE1 was also on some older APUs that are radeon only.

Alex

>
> Regards,
> Christian.
>
> >
> > Results on Debian 6.12.113 (see patch 2 for numbers): hang before,
> > none after, and 34 fps instead of ~4 fps for the workaround that avoids
> > the hang.  The KDE RDP server (KRDP) itself, driven by a local FreeRDP
> > client, now encodes on the VCE ring for several minutes (about 40
> > fences per second on ring 6 in the radeon_fence_emit tracepoint) with a
> > clean kernel log.
> >
> > Two caveats:
> >
> >  - I have not worked out why the missing interrupt turns into ring
> >    lockups instead of only added latency.  What I know is that the
> >    hang needs the VCE ring to wait on a hardware semaphore (disabling
> >    only the waiting side, or both sides, of radeon_vce_semaphore_emit()
> >    avoids it) and that handling the interrupt makes it go away with
> >    the semaphores left enabled.  If someone knows why, I would be glad
> >    to improve the commit message.
> >  - The Trinity/Richland change is compile tested only.
> >
> > The series was developed and tested on Debian's 6.12.113 with the
> > radeon module built out of tree.  It applies cleanly on drm-next
> > (fad06cf), where drivers/gpu/drm/radeon builds without warnings (W=3D1,
> > allmodconfig) both after patch 1 and with the whole series.
> >
> > Matheus Tagliari (2):
> >   drm/radeon: process the VCE interrupt on SI and Trinity
> >   drm/radeon/vce1: enable the VCE trap interrupt
> >
> >  drivers/gpu/drm/radeon/evergreen.c | 14 ++++++++++++++
> >  drivers/gpu/drm/radeon/si.c        | 14 ++++++++++++++
> >  drivers/gpu/drm/radeon/sid.h       |  2 ++
> >  drivers/gpu/drm/radeon/vce_v1_0.c  |  4 ++++
> >  4 files changed, 34 insertions(+)
> >
> >
> > base-commit: fad06cfaf385787b9ffa2f73f049d42dbe1de57f
> > --
> > 2.47.3
> >
>
