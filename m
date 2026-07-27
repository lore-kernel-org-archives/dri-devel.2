Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0373AC531C9
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F58710E689;
	Mon, 27 Jul 2026 16:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VnJTbcQE";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFDBF10E648
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 16:46:42 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38f0f3c8da5so180155a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 09:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785170802; cv=none;
 d=google.com; s=arc-20260327;
 b=NUA1xbnundEXpGR3XOFBT2O33Be9ougmECpX8JbuGNTbwqFPbdIJwV0ErmnefuPT0I
 CIxxrZpZpZnjpJrJdchd+U2xgsyulo9JBq5v3T7t7FK4BjHTpKlwzebtbleTeu4cEANp
 AcoRZl7uEemkmgZsWx4NULfQzmOsOSl2kxOK9FGMPz3sJnTn8DJc0UI8aQMiTwJ6oCfr
 vx6zw7ts42XUuxwXPEEVWwZk5pfZgFFiHH1pWba2NiVkin2knWd8vyH6a4IbVEy4c7jb
 QMUx3yOAGytTKscq4iHd3sG2J4IFJN8MICEZBdf94P1l3mzDMb2clVtyVzlSrBTmdLku
 fBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZYf/rihhYlrBAKYiCrpMlaiVI/+cGiqgdriA9fSdZao=;
 fh=2uMRJdq6QFX+fyMeVXZRiXo7qlOM7y1ovVXqEqGC0pA=;
 b=ctjGsN+3NHNUIP2D3usREtnxwptri7n8fqlud/WKsRbIL0LbTiSVKBwqg7wmut14nt
 0Q7oZZreLuhusoKaQqN7lSCThgGLTkbTonhqsdIiCArn8d0eYRxTQ0EgQ3EFS0H5NKjY
 W9kEZvjNBEjvXN3uZzMpknSro6f9UG8cDl5kwpVLFL0LRV6JeGF8qQ59Gk8G0l/vK2ch
 YVmLbjdBAOhcNIMs4ygJxl1kONQxc4DmRxGDt4YXOwXG9WwuwD23FSGUXkKBRc/5oyNo
 6G4nCyJrtwT0IfYYlzYZ5d1mGVjUwgp8Y8OyKZifl9vWfLdaQxHWMZ3o2rxsPCGX6h3i
 g5RA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785170802; x=1785775602; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZYf/rihhYlrBAKYiCrpMlaiVI/+cGiqgdriA9fSdZao=;
 b=VnJTbcQEf6X8UxXL0p8s85FpkEyHhVNH3YFAL5SQfJ+h63vSt/3drr0KzfVoUxW0Zz
 VSLzKreHH77L9bANr6/5VlUwKFA+cAi0238QI04MRSTBaVkeFa+mUaRv/yjgDP0w9Jcj
 PPZS9uyODYz2DLbBd2Pl8n7T8fCrNHnUT99pDjN/TX1s4jsjsIu5gdAZi33D7VJFMdQB
 7JbuWJJkInE5pLPhFvecoBEVh4gHNi2WEF+7rrt37FJwVTwU32szcDXb78O3IHli2NfA
 rLZGv4v+Wn5vs9nWDtGspFcccpj0k1E/343XLWVpEXQOf/jxyog73idRMRbkwjAyukMo
 5Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785170802; x=1785775602;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZYf/rihhYlrBAKYiCrpMlaiVI/+cGiqgdriA9fSdZao=;
 b=EaG1xXOGgNDCe9kxjmq/6U/A8EBBjHi1gGWmWxblHZyBtTL2uGqGKAfAQiYdpD7gTq
 QXwYyJRY71KuhynKv7qbTWrPF5MAw/i4Hl/yolkeXzNxuWxT0r5Sj6YCPMKTPr04ygmP
 Qt92ZAGvTjgr8sH0vJlKKAbAPInaWesiZW2FHDPzfExOz+acecaPpfdQuxGc0vcuQpEF
 uZ+v0Y7JOb3p/evVNCY27HhIxOVKnT4A4ygCZmcqfQ2IDA7P9HhAehdpBsF4EEXQj0qs
 qQNEOIszEgx4aCg0WcckpgxPO6SRXWnG1vZEfyN/njxLJYuahmvSVPAzSfnaYo52sCV8
 Ye1g==
X-Forwarded-Encrypted: i=1;
 AHgh+RooMYuevt/eJjQGjEajx6SIfn8OgouGf1rX1cYYrtMFSSBwx7HA4bcb+YScsxJnRRPSLO6QCSnmlIE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj634EOZNypYsWKHMd3MbFwUzCDmLIs+BySLJmjOwTdN+BUHKy
 Imc+rGkrjdjE/ebOWanZcQmE3dUB1z0OCKwLYi/Wb3UHTYswdNYUcY/aDPgr4jpdy03pQvcBfaI
 kNn36PzCgZvsMwXtUwl1AeOOsM8xP1TXPKA==
X-Gm-Gg: AR+sD10r2kLzRONktBHhLRjq1eNLYRDuVgAIV1CRnW0Gn//utbo4TtOpHwv5DjSKmMM
 V5n6MlVG6H3MwawMqybA7gX8OigikTL8gtMWva9JbDfT0ZvVG13YB7R857kvpyH2VDizx1FKgOW
 2tXtoLx04zX9hUdf/HlHmU3KtNiq7F7HXIaS3N1Iw4hQwtsFxo9gH/4EfIe+wniRdcpyZWIXQVO
 HPNI4kn81P9nVYnTcrRbB5HvOLScVNEwumJ3TYv0+z7JKktTOnULG1wpb4kPrt/7jtvqQFVquA8
 Lt90DxfeZcBx0AAfkqbPUY3YnUKQUhA5L2sPv9KclS54JoybhwsFYun35m2/xro/bMXAgOcJct/
 bZsHUxJkDV2pcjUbYrvl56xD5ll0ZN3A=
X-Received: by 2002:a17:90b:2c87:b0:380:9cd1:d985 with SMTP id
 98e67ed59e1d1-38f628a2013mr619020a91.6.1785170802281; Mon, 27 Jul 2026
 09:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260429171644.8406-2-u.kleine-koenig@baylibre.com>
 <aimWvtBTQvd7O2F0@monoceros> <al4HlJxVqCDae5yL@monoceros>
In-Reply-To: <al4HlJxVqCDae5yL@monoceros>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jul 2026 12:46:30 -0400
X-Gm-Features: AUfX_mxH9LpbVN3XQked1-UcBEsMG3vSzn_JrwmOJW3uHzU_2audivCCcr6wjdA
Message-ID: <CADnq5_PtuGS_FXJJB6kh_xVUPFDXznLQbKuAGZN+choXhPTH9w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Consistently define pci_device_ids using
 named initializers
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks.

Alex

On Mon, Jul 20, 2026 at 7:44=E2=80=AFAM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Wed, Jun 10, 2026 at 06:55:09PM +0200, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
> > On Wed, Apr 29, 2026 at 07:16:44PM +0200, Uwe Kleine-K=C3=B6nig (The Ca=
pable Hub) wrote:
> > > ... and PCI device helpers.
> > >
> > > The struct pci_device_id array of supported device was initialized
> > > by list expressions. This isn't easily readable if you're not into PC=
I.
> > >
> > > Use PCI_DEVICE* helper macros and named initializers which is more
> > > explicit and thus easier to parse. Also skip explicit assignments of =
0
> > > (which the compiler then takes care of).
> > >
> > > The secret plan is to make struct pci_device_id::driver_data an
> > > anonymous union (similar to
> > > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@bayl=
ibre.com/)
> > > and that requires named initializers. But it's also a nice cleanup on
> > > its own.
> > >
> > > This change doesn't introduce changes to the compiled pci_device_id
> > > array. Tested on x86 and arm64.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koen=
ig@baylibre.com>
> >
> > Gentil ping! I'd like to work on changing pci_device_id, but that
> > requires that this patch hits mainline first ...
>
> Would it help to resend? Did I fail to Cc: someone to get this patch
> into some tracking?
>
> Best regards
> Uwe
