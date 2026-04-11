Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B80F3ED40
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 14:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F05210E139;
	Sat, 11 Apr 2026 14:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KfCU4ci9";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDFF710E139
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 14:45:44 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso35502235e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775918743; x=1776523543; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AZfIjpy54chd/oLiMe2eh5RXXChJ594JYVimVPk7UU=;
 b=KfCU4ci9oJj63aEPMUXvgOkiz5MiBgE7wTR0wjxNMOxvJ8T6eC0GI8YlJTfeSHd8gt
 KnhQxbHd0D5dqmht34cM+p4DP2SgcQwFbSGOkflOStsGKyR2bXona0vwBe4il60pSSds
 4HzYI5WHpFjtxpNbOzCIgPkoR30bs+5W0gWT+C/N1Nfgg2w2fzvse0rONErTNz/Exu+M
 828AOTuENghj5hGYOQG0wLbyqlu/wshj/pg1yuzIfo3IbIfXX0EwCgWaok3DUKVPE2nB
 YHxWpYKM2T3cE7PyDkxdsz50FYlDB+ZmeY3CKcG+XXGVyHn3D124KBzjCz8aq9cPhL88
 4D/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775918743; x=1776523543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6AZfIjpy54chd/oLiMe2eh5RXXChJ594JYVimVPk7UU=;
 b=iI/jKtYmJ2D6ZW8PQV+qdapeatmMPUZ9oiv/NubmAfqX+p68YQLgLZZ0oXSIazl6I/
 yPu8TU4AWJu0xeeGgfoarN8hDp4LEQ7JxK1odE4yzmVJoaHEm+ge0vImg8IOWs9HLqHD
 94Uy56pv92iLS6dRCjWUK7yyV/1KYIsRz3RAsxrHKTqNjzGOPy/4vmQc/1IUzba6xSyM
 tKrhcPqMadKWgxtw5YzTwnrr4qRegnZ8frvsIlCsPWmW/4vLGMYTIq0CY8LTg1XPCKTz
 kECFm9vrG1s1eOyapiq8aSPJr3uxF8cPNanX9sx7lJplHYgQKnJQbkFAP7IFkLxZZjGV
 LyCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfnQaycdFl6TABK4sVfhTdVEyRA858UZtYvCAQlnHYk509bmnYZCQaICBvVIAHyAujfimmCOxclh0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9NuVFCGu+oZn1IG8BKG1hhq2G+FlJg61WB1YZ0NKX7ITI926g
 4OqT9fLg2g2dFcnajeTgOGce/T3YWRY28G8Zcuyn8M38cSdX8FexEfG6
X-Gm-Gg: AeBDievTWrUGOoo44kLqd87H62tDEA4CywhgbG8/NBi5Z0CxjM0UtDBWNsP9dsvlcaS
 cKrFLhOWJlWF9kCDyOQ+3TzsGAXbGIHpUSmJ/MM2tFqBUOxef0qrEq7pUBeVn36rw80iybD9vEY
 6hEYCBBllz7WtuXC8/4+OEOL/ScxRyCkxXy7i+dxfMb8L7JBkvFIPYxVpucPShmrqdNG5yokm18
 rr2OlM4adhvULxSxMstKfOT9v/5xn62cAYWd85Sqe5wstJesIi8wvVLp4U4LwUPiKE52vt89AB0
 gV4Rw4uZb/2Zjy9+bfV9c0covUHeMwayVygAdmVVoxUhWvuf9nQ5DlYXhTEsufCEGqi2N6DLUyi
 dwtyhx9et4p2Alg+KgH/JqGiqQJqRFmPDeNPBTg6zyXnYmKwefrh78LhtWSG77IiKDL42rotbhs
 ESB4BQo/zr+YRKO1olk1/WeFqWMMoI2T9ekh/mCSlVtTjg2gxvjuukbxxVNS/ZXGB5
X-Received: by 2002:a05:600c:460a:b0:488:a824:fdff with SMTP id
 5b1f17b1804b1-488e00fdbc3mr13943905e9.22.1775918743193; 
 Sat, 11 Apr 2026 07:45:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5b3c597sm151294875e9.12.2026.04.11.07.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 07:45:42 -0700 (PDT)
Date: Sat, 11 Apr 2026 15:45:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Jie Gan <jie.gan@oss.qualcomm.com>, Akhil P Oommen
 <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, Konrad Dybcio
 <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, Abhinav
 Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Antonino Maniscalco
 <antomani103@gmail.com>, Connor Abbott <cwabbott0@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/17] drm/msm/a8xx: Preemption support for A840
Message-ID: <20260411154541.3d5d637a@pumpkin>
In-Reply-To: <CACSVV03gr87bJcywyt1wHoaLRaaUJEmKAz3jTmipUt9NGSqbtQ@mail.gmail.com>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-15-2b53c38d2101@oss.qualcomm.com>
 <07fcf759-b53c-4bc8-8e88-48b82713fecb@oss.qualcomm.com>
 <CACSVV03gr87bJcywyt1wHoaLRaaUJEmKAz3jTmipUt9NGSqbtQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sat, 11 Apr 2026 06:56:15 -0700
Rob Clark <rob.clark@oss.qualcomm.com> wrote:

> On Fri, Apr 10, 2026 at 7:22=E2=80=AFPM Jie Gan <jie.gan@oss.qualcomm.com=
> wrote:
> >
> >
> >
> > On 3/27/2026 8:14 AM, Akhil P Oommen wrote: =20
...
> > > +     struct a7xx_cp_smmu_info *smmu_info_ptr =3D
> > > +             a6xx_gpu->preempt_smmu[ring->id];
> > > +     struct a6xx_preempt_record *record_ptr =3D a6xx_gpu->preempt[ri=
ng->id];
> > > +     u64 ttbr0 =3D ring->memptrs->ttbr0;
> > > +     u32 context_idr =3D ring->memptrs->context_idr; =20
> >
> > Shall we declare these variables at the top of the function body?
> > =20
>=20
> We can use c11 / mixed code/declarations now.  It's actually kinda
> required for cleanup.h stuff (which I recommend for new code, where
> possible.. I've been using it for PERFCNTR_CONFIG ioctl that I'm
> working on, and it makes error path cleanup much more straightforward)

It is also still frowned upon for normal variables.
It does make reading code - especially large functions harder.

	David


>=20
> BR,
> -R
>=20

