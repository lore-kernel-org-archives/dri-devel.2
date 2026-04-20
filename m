Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A80F5A8C6
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86D610E747;
	Mon, 20 Apr 2026 20:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ji4HIU0v";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D4010E747
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 20:56:12 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-670ab084a39so5330988a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 13:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776718571; cv=none;
 d=google.com; s=arc-20240605;
 b=ChEtJ/z5yi/PWYXxaKp4UfrpPWQ6en6FxKYExWhaFRbGaIMAMvl84hMM3DCG7CA+Er
 rRse2Up65OqPj3e07DetefxDCOtVSQMTASprT+LmmOAE/6taCs51FYMs1KQwb5GLbVbO
 HJ1NNLLG2TroUWzXPw6o7Ak8gFWUg0CuGpZnC8O4Ec8S5xF14l1TXVIeoyHpwN+Hc4F8
 sxxarJbB0/bU1seIg+Qgpiwm9e9KmH4EjBdokCttWj/GtFdGehJECWoREjbVJ91cBFwv
 dSGcj3EfqtUty0Zy3VXPEyREXfY+x5hO65xFBF5gHpRwYZLHb1gj5VRd/iwjZ+VSz/zZ
 CiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P7+4wLenAVvJjKZLpFwLBcie9mbCuyFuXvL1EWX93f4=;
 fh=A4e7rnu22SJ6+yVQdm6lA2raE98e7NhD7NXzH8BDtks=;
 b=hSwvscPaLB8AmxNbUCV2DKctyBWampO/KDHh06WZnWXLfanc6sIPwXNgl1j5KbIgjJ
 gzjkyb1RWzhCN6RhehTAtTGPf7OKPyeeSpE+ZR9zrT+K0ssOQQZP5t6cQUIadcsRUfv1
 s+/6R+WfYMZM9jfCHbByk0L1PcAu451QbVihahOlLHpEboGbOCExtzjBcldho9GZgtzS
 XA/Uj4QHtbNFZS4gjjE/NQeub4B6FMjACvwNROKdEOhwU8kton73vat7CklJV0H6nzgN
 KWJRstNpnEb7fiFcFffbhyG96RRHBBq6JGi/+4Wwxfb9mgcm9DNKOuqnTfPJDl74uMY0
 2ndg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776718571; x=1777323371; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7+4wLenAVvJjKZLpFwLBcie9mbCuyFuXvL1EWX93f4=;
 b=Ji4HIU0vidgEAmofx253i1wS/IBPZd+wF6aLoOpxKbYcx2rBJJJLh0e0fWz40rYTko
 NTTF+xUhqmNHhpYSdIdez/1sH8UugZfbLB6TdelHNv7KEzn/BNWG2ncHhTXwlY5Cj+/9
 kkGd1d4qYrqGqYPiKxrpDQIJDh4JPMd+HptepdxQ3hBeuDsFjg3mGnCKvZ8fgAn9xOvN
 6wTohi+j0xGgUGjpdNSdeOsR8MEfQ3dvsZXbXBu1JVbwg5iw8ZFknEfPGHgOlIbJNLmO
 8+GUKyq+0NFlPaHl/vxOlxAu9N8TKQRf0ICr7Rb5Fzgzps9geK8AAuQ7Ie1IxBxrozhb
 XXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776718571; x=1777323371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P7+4wLenAVvJjKZLpFwLBcie9mbCuyFuXvL1EWX93f4=;
 b=MWTzcQYMUhQtxYTkktcnvSGRsbC0erOSUFyejQxwI6BEi1oyebzwudtDel1RVywi2R
 YL/+flki9AurmBBfuGQYq8/MOK4uH8pQN4csAzURABRK1g4viKv7ea8Ghx6E9HoVMMoF
 6BM/PITYmh8jOTdlbF4/QCyP8dDEwU0lCHyadm75Wv4Q43ApzusF1kuA1mtr5u1y/PHe
 5U05hyZr4YR8dZs79LwmfEBeJPA5Mxz/JU5ceKHGEVKxKODby72zZb/dwj8OcVklopRw
 NnSyRS8nx2ZqmjyPQDKXFvTIwo0MJxQQt+Gsd6XDUkhVdLL7yXTiQUo+NpUrPtnBB3fh
 VIaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+P2l4XpP10TwQKntGJi0xYnMJ59Q1gehDn2zYWl95njxflKaTcVJjEQZV9A9aEepu0B6asiJulqL4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqkfrSvzQBE0ZrsXyDxRhb+7Af1jhNhP/PnsJiNwSm2LmgiAAo
 xyfzIFyfDrs2tsx/BNNc/MEdlnf4v+b1TesV67mjUWv+XFkUdjjpTWMw9VVVnY6dGP7Nh9RKvB/
 y6qbWXRqEjuvYvk0Kdpe6J4JbVuUssB0=
X-Gm-Gg: AeBDiestD2vovaVZRJquobPyetFcyn5zMZZhobIR2fWJOCQ0St60wvlsXpryoGULvdR
 kvtrgdDmR0faKzE0GX6/0kpKcl6XSfMNOEGb+6tGtyfrOOwiNhdNnegF5t2J9/J9j2s7v5b3rU5
 ICNRVwHWVrmPxZXUXDCoJK7P8TSxLBnd0fSpsmyWnsitVGMANZUqvRYnqifCGWoVLgptWYA0HaL
 T2yIKBCNek5WdJZzn9avEHjA1L3KE/VwA3HrqsNMp6uTRotkUq91mhcPCD1j7DhZ6KQB4YPC3Dw
 NNaPnXivBv1Ao1/+sg==
X-Received: by 2002:a05:6402:90b:b0:66e:8ca6:e79f with SMTP id
 4fb4d7f45d1cf-672bfdc9488mr6320068a12.13.1776718570988; Mon, 20 Apr 2026
 13:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260420002513.216-1-dbgh9129@gmail.com>
 <17620d92-70ee-4bc4-8944-4075bb50a54e@suse.de>
In-Reply-To: <17620d92-70ee-4bc4-8944-4075bb50a54e@suse.de>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Mon, 20 Apr 2026 16:55:59 -0400
X-Gm-Features: AQROBzDpwYfnd0Kb00kmzALLsIrFR9BQA24i8aVhbVrfhqEwJ07kJ0sxy4uFiKM
Message-ID: <CACrCO_UK-XtK+0=AVO5uw_pi7rxfaP70cjU0bTkJAF-g0z+08w@mail.gmail.com>
Subject: Re: [PATCH v1] drm/sysfb: ofdrm: fix PCI device reference leaks
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, 
 Myeonghun Pak <mhun512@gmail.com>, Ijae Kim <ae878000@gmail.com>,
 Taegyu Kim <tmk5904@psu.edu>
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

Dear Thomas,

This issue was identified during our ongoing static-analysis research
while reviewing
kernel code. Specifically, an experimental static analysis tool found
that we are currently
developing. The tool is not public yet, so I prefer not to disclose
further project details
at this stage. AI was used only for cross-review, not as the primary
means of finding or
fixing the bug. I manually reviewed the code and verified the issue
before sending
the patch.

Best regards,
Yuho Choi


On Mon, 20 Apr 2026 at 02:21, Thomas Zimmermann <tzimmermann@suse.de> wrote=
:
>
> Hi,
>
> thanks for the patch.
>
> Am 20.04.26 um 02:25 schrieb Yuho Choi:
> > display_get_pci_dev_of() gets a referenced PCI device via
> > pci_get_device(). Drop that reference when pci_enable_device() fails an=
d
> > release it during the managed teardown path after pci_disable_device().
> >
> > Without that, ofdrm leaks the pci_dev reference on both the error path
> > and the normal cleanup path.
>
> Did you use an AI to find or fix this bug?
>
> https://docs.kernel.org/process/coding-assistants.html
>
> Best regards
> Thomas
>
> >
> > Fixes: c8a17756c425 ("drm/ofdrm: Add ofdrm for Open Firmware framebuffe=
rs")
> > Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
> > Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> > ---
> >   drivers/gpu/drm/sysfb/ofdrm.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdr=
m.c
> > index d38ba70f4e0d3..247cf13c80a05 100644
> > --- a/drivers/gpu/drm/sysfb/ofdrm.c
> > +++ b/drivers/gpu/drm/sysfb/ofdrm.c
> > @@ -350,6 +350,7 @@ static void ofdrm_pci_release(void *data)
> >       struct pci_dev *pcidev =3D data;
> >
> >       pci_disable_device(pcidev);
> > +     pci_dev_put(pcidev);
> >   }
> >
> >   static int ofdrm_device_init_pci(struct ofdrm_device *odev)
> > @@ -375,6 +376,7 @@ static int ofdrm_device_init_pci(struct ofdrm_devic=
e *odev)
> >       if (ret) {
> >               drm_err(dev, "pci_enable_device(%s) failed: %d\n",
> >                       dev_name(&pcidev->dev), ret);
> > +             pci_dev_put(pcidev);
> >               return ret;
> >       }
> >       ret =3D devm_add_action_or_reset(&pdev->dev, ofdrm_pci_release, p=
cidev);
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG N=C3=
=BCrnberg)
>
>
