Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC50CCD98CF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421AA10E4E3;
	Mon, 15 Jun 2026 15:10:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AkDdiArm";
	dkim-atps=neutral
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4761110E4E3
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:10:11 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-963a1640c19so101516241.0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781536210; cv=none;
 d=google.com; s=arc-20240605;
 b=iRYck+wb+c0tbas4PtKGTuCgzJCzbqTguBdR/AZWm43/33KqnDXiKfEXD+Buw/hoc2
 uIbxu5K3Tt1uagh9l37Iap0cYq/xxJ/cO8pO1y4wPrSibrzsYpWU9iZGEZ6HQZQ/0h8T
 MyN4KAZ+tgcsJ1v7Tm3pWQnXv71KRon6XXbpqAYVBDVufQw//JjjVPuEy9zwajhsqPDw
 5Xd5ndTQXbpN4rglbcCfL4e71kuNmbW6Cpk5ZYyBxO+yRgI4jhKXmeG71IwToqiwwrUl
 r+/DW0CujPHVXj2HkfVrD+pK2/bMb+xSRD5mVa70p+nnySrHpwDZSsu1x95bn13/ZcLZ
 mrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=13hVYdB7l/k+KcGd/9SBchGGp4mNuBG4mo9ptCsOsMw=;
 fh=6MtCzcPPvGIaXXy46Q/AHTSIgZJK4Z0E0F42g2Jy6Dw=;
 b=SL2oCymhDlQsLaemNb63wWkw16hEWC1FxbZU5r3mnOztoKHRqEpue5XbphlOjKFabX
 +2j2gAvWBRsPrs4MOwSTTBdf67UIYE54+IEz8BIJDwbEHjSVkXkVn1iE1YDTIlLJj6+7
 noA3e0LlqEuvkQupavxMrdmoskEhMco+Jnemrf8BG2JEmw+4kFvUZB9roIXmjLwTvF4Q
 UKCwc6Xgdeaus20XSEiYy1QFO1Y7+X72VV2SIo/XIpyK3Cdmf5DzQHp+ZVK0Nzbl/rJd
 Nned3JMz5gYWvaHC0L8P1IPTAjyf+nysS8DLO6T78p3c4GXVOrG6HDofQOwhZQF6+Py7
 9pEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781536210; x=1782141010; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13hVYdB7l/k+KcGd/9SBchGGp4mNuBG4mo9ptCsOsMw=;
 b=AkDdiArmVgzY7ypu3tT5g16tBL8BNCPhhY7slGpSyk7bOZZEwskHYhnJBu3jPmPjMX
 AcUVs+eNNcS+xbVjV+45LsgghLvYGwFmlm7rPcE375JpKX5h2FoRJOmGL2BSBfG2GF8h
 kSfQ8jGNhFeqjLb7WzFPU7bPunZU4L5SPUIcMhBIiFYGYVrGC/p/jEgJFhMaZlGb4Rge
 /0ppAYWi8UvfnBRe5UAXJQEm7ML+m6nzx4dG/8xYytelF9X26OgEUcjIcqUJWNIn4rDe
 p5gFGWOG/oDL9rnjpilKOX0LO51PNFL03hUMsaixY6IUbAejeSVpU+9xRNPfg6WsG07J
 08Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781536210; x=1782141010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=13hVYdB7l/k+KcGd/9SBchGGp4mNuBG4mo9ptCsOsMw=;
 b=JAGXb4RaEFtbqJZ4+Ips/FaUgMvtHJIiY8/Y3JnM6HzW30q3ZfeIPQcyl1KK7DrXJM
 q9AjTErUjFiUNZ+tFBUR/yzd2/1vvWBe+uNHM/fbJFPWGC/sqpsBV+RQN9q2YCaA42k6
 D/xHzIp5UrTJy+xbTiAVezNf7FCtIxpMfIcUhlH75Zfhnz7WSAhsKGqJDYst/mw+RFbU
 Cs0hoqo+jRU8UtPJ0q2KojUY9Su+GbTZqWx+e+pyZqff/whhbgiFc0ZM7TU88TaVcQni
 w/fJM6QIva4U9Ezae6IH77xUrkENGqA3t9ZytN2FqDagSrx+TN09iHP/svFj9z6XU4+J
 fRAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4v/DkT3hZ8lA8AL6QcRRC/hVQHIcXD+T1JtyK6AOfydvoIQDKrlEe4vGQEpryBo8acu9ltO/Rtic=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/QfgrXyMWSI383EJTw1Ci6HLIA1TtQA+mrZSn30FjvkexdYjW
 ttQ7f+SpOGZ3MZuCC7tFCE5+uyI8SjynNucy6RxK4wPzzw1PiPiEf82GCH/57I+5UX32eIYK5oj
 kkJMwsSbIzaAXRR0ZRcF9osxjucltwCM=
X-Gm-Gg: Acq92OHQFrzxCOd9glpFnAFke4/zbaSuoMa+wOX7iD5utUCqaDrhRX4di48NCz2fquP
 HMHp8FRsqdr+UL30948zrtxiOuJ3nR4d9bX3odFsYwk9HnDaDducJGNVcQwG/Dk4ACm75VUdgkE
 +LzOZ+WcB2rnTdN362HlhFok2eNTNK8be3DSq4e6KoGdr+idZ6+NeJh7yrxmVSuJFOs5I4oYleF
 ezgd9uS1lRDTT32piwsxG6AX9fUyE8L42mnbykGN8slY5lquPVsankCWdxGxv/LBKwmsXqfkFvR
 PwA6SGVTJD1sVU1uIloCY7KvNr7bMm2HecILFo3W8EiI209V+9ngIEd6d1uRggDIjNJD5A==
X-Received: by 2002:a05:6102:3e8e:b0:65b:c17:7052 with SMTP id
 ada2fe7eead31-71e88901b2fmr2314582137.0.1781536209683; Mon, 15 Jun 2026
 08:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-amdgpu-mutex-fix-2-v1-1-1d850180ed19@igalia.com>
 <2660d09d-b549-447e-a28c-ca8550c3b288@igalia.com>
In-Reply-To: <2660d09d-b549-447e-a28c-ca8550c3b288@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 11:09:56 -0400
X-Gm-Features: AVVi8CdwS2MMG0H1zzBQynG0YAIyC1zlvEr24KuG7IBFRX6FoZNz8vEgGeCWHFc
Message-ID: <CADnq5_OkcK6dPLXnBqWr10Dat8oRLp6CLdin6dHcUGUNwoaTtQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: initialize irq.lock spinlock earlier
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com
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

Applied.  Thanks!

On Tue, Jun 9, 2026 at 4:07=E2=80=AFAM Tvrtko Ursulin <tvrtko.ursulin@igali=
a.com> wrote:
>
>
> On 08/06/2026 20:22, Thadeu Lima de Souza Cascardo wrote:
> > If there is an early failure during amdgpu probe, like missing firmware=
, it
> > will end up calling amdgpu_irq_disable_all, which takes irq.lock spinlo=
ck
> > without it being initialized.
> >
> > Initializing irq.lock earlier at amdgpu_device_init fixes the issue.
> >
> > [   79.334079] INFO: trying to register non-static key.
> > [   79.334081] The code is fine but needs lockdep annotation, or maybe
> > [   79.334083] you didn't initialize this object before use?
> > [   79.334084] turning off the locking correctness validator.
> > [   79.334088] CPU: 2 UID: 0 PID: 1819 Comm: bash Not tainted 7.1.0-rc5=
-gfd06300b2348 #96 PREEMPT  8e8f461221633dae3c832d6689eaf0546c0ed4cd
> > [   79.334092] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0133 08/05=
/2024
> > [   79.334094] Call Trace:
> > [   79.334095]  <TASK>
> > [   79.334097]  dump_stack_lvl+0x5d/0x80
> > [   79.334103]  register_lock_class+0x7af/0x7c0
> > [   79.334109]  __lock_acquire+0x416/0x2610
> > [   79.334114]  lock_acquire+0xcf/0x310
> > [   79.334117]  ? amdgpu_irq_disable_all+0x3b/0xf0 [amdgpu c88bab43d391=
d519ad0d5c8e5a099b4aceefa180]
> > [   79.334503]  ? _raw_spin_lock_irqsave+0x53/0x60
> > [   79.334508]  _raw_spin_lock_irqsave+0x3f/0x60
> > [   79.334510]  ? amdgpu_irq_disable_all+0x3b/0xf0 [amdgpu c88bab43d391=
d519ad0d5c8e5a099b4aceefa180]
> > [   79.334881]  amdgpu_irq_disable_all+0x3b/0xf0 [amdgpu c88bab43d391d5=
19ad0d5c8e5a099b4aceefa180]
> > [   79.335240]  amdgpu_device_fini_hw+0x90/0x32c [amdgpu c88bab43d391d5=
19ad0d5c8e5a099b4aceefa180]
> > [   79.335704]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu c88bab43d=
391d519ad0d5c8e5a099b4aceefa180]
> > [   79.336159]  amdgpu_pci_probe+0x204/0x440 [amdgpu c88bab43d391d519ad=
0d5c8e5a099b4aceefa180]
> > [   79.336494]  local_pci_probe+0x3c/0x80
> > [   79.336500]  pci_call_probe+0x55/0x2e0
> > [   79.336505]  ? _raw_spin_unlock+0x2d/0x50
> > [   79.336508]  ? pci_match_device+0x157/0x180
> > [   79.336512]  pci_device_probe+0x9b/0x170
> > [   79.336516]  really_probe+0xd5/0x370
> > [   79.336521]  __driver_probe_device+0x84/0x150
> > [   79.336525]  device_driver_attach+0x47/0xb0
> > [   79.336528]  bind_store+0x73/0xc0
> > [   79.336531]  kernfs_fop_write_iter+0x176/0x250
> > [   79.336536]  vfs_write+0x24d/0x560
> > [   79.336542]  ksys_write+0x71/0xe0
> > [   79.336546]  do_syscall_64+0x122/0x710
> > [   79.336550]  ? do_syscall_64+0xd1/0x710
> > [   79.336553]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > [   79.336557] RIP: 0033:0x7f92fd675006
> > [   79.336561] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19=
 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05=
 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
> > [   79.336562] RSP: 002b:00007ffe4fa867a0 EFLAGS: 00000202 ORIG_RAX: 00=
00000000000001
> > [   79.336565] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007f9=
2fd675006
> > [   79.336567] RDX: 000000000000000d RSI: 000055b2dfce59b0 RDI: 0000000=
000000001
> > [   79.336568] RBP: 00007ffe4fa867c0 R08: 0000000000000000 R09: 0000000=
000000000
> > [   79.336569] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000=
00000000d
> > [   79.336570] R13: 000055b2dfce59b0 R14: 00007f92fd7ca5c0 R15: 000055b=
2dfdbaf70
> > [   79.336574]  </TASK>
> >
> > Fixes: 9950cda2a018 ("drm/amdgpu: drop the drm irq pre/post/un install =
callbacks")
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 --
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 21a3fb574d53..e5a9f6325c4a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3749,6 +3749,8 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
> >       mutex_init(&adev->gfx.workload_profile_mutex);
> >       mutex_init(&adev->vcn.workload_profile_mutex);
> >
> > +     spin_lock_init(&adev->irq.lock);
>
> The fix and the Fixes: target look correct to me:
>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> The init paths are a bit of a mess though. The driver could use a
> systematic cleanup in this area path. Maybe consistent
> init/init_hw/init_early for purely software state, or something. It
> would be a gargantuan task probably. Some years ago we strived for a
> clean design along these lines in i915 and I think without a solid
> continuos integration with fault injection it possibly shouldn't be even
> attempted.
>
> Regards,
>
> Tvrtko
>
> > +
> >       amdgpu_device_init_apu_flags(adev);
> >
> >       r =3D amdgpu_device_check_arguments(adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_irq.c
> > index 254a4e983f40..40b8506ac66f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > @@ -309,8 +309,6 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
> >       unsigned int irq, flags;
> >       int r;
> >
> > -     spin_lock_init(&adev->irq.lock);
> > -
> >       /* Enable MSI if not disabled by module parameter */
> >       adev->irq.msi_enabled =3D false;
> >
> >
> > ---
> > base-commit: 60dc0946bbad3eef8bc66a5a8b09b98dbc6e09c0
> > change-id: 20260608-amdgpu-mutex-fix-2-381a3bed81f0
> >
> > Best regards,
> > --
> > Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> >
>
