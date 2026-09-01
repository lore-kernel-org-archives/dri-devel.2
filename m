Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CB6C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 23:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A308610E03A;
	Tue,  1 Sep 2026 23:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="liixlRD9";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C3910E03A
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 23:19:20 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-84a6f026675so70391b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 16:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788304760; cv=none;
 d=google.com; s=arc-20260327;
 b=F4mU5DuxjEciqqLwC09CiUnCJLsoedWjrtOwYD1liV6FlvtLLeF2Or3WUvSl9Vf13B
 xgEyIzshoXbJ4L9Bc3ZXX5j8YWq12/g6IUB39DVFLPBn/M5y9lEGGVAo2bOcmznNM6Vw
 xRISGmVEx+BY464aFSAdY0rfzkHOIn8cg61Mb2iu9GVet9dlXyFDqrRswNCuE7/XVTRE
 SGq3LLcOacf+YacAmD5D72NGQUv+PSo18J3mAAevzGQVONZiM7NilpCwP991sj+0g+Zh
 AENE8PszkAtIdT4A/rpA2UKQzaKHjLGAM3HbhbvCE5C4Sm05Bs4XFoZ0rvVk5c8D/YOx
 xBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iTO9Bl1A4M4zo0TJ+YJltBWqZ51NBQa7Q62ZAYSv+dA=;
 fh=5++fC+tvZGjauxWA11zHXjh01arSR5sTe+4p1MO48nk=;
 b=I9R/Q6CzrCojjddSBoe+7XoDshFD09dn8Wc/s9NXninPdkpjTexOEKnrpGh8BuC8Sa
 K3bdXp7fkErtHSaeNXgRrs3i/WVxmJAZcVkRf0r5uZtjipTsnYxglU7993rZDNoi3omo
 ePqabFBexNJKdiBS3cIerCJ5/3sQJLO1FHK+YHJTZbsT2yw0mS7mw2WfuJCbLGiKz5eY
 oxDGNEM5qLqkACCY2Jk2eZcQQRdwZjF9IMbHEIC6A3d1Il5kQOPZ37+OLXTXFHUi2VoL
 7in5zN6+leVB6Ug4A8e17HTn8Gt+tzXc8qWWjUAYNAU8eS7vgQZuLEkth/f/PTCE1sHj
 u8Zg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788304760; x=1788909560; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iTO9Bl1A4M4zo0TJ+YJltBWqZ51NBQa7Q62ZAYSv+dA=;
 b=liixlRD9lxMdLAvMp0S6UlKVbr7UhjLCWc0WLTg/G55QC/zx4jBR1xWeViGAPnUvRh
 d25o6IV9k+GR18+evKlUcgXQwG3T3O9GrY+EytCaB0aa5Q751GjXve9zb/K/A4ripsRH
 izBdc1Jddy+Tbogf93IiXKd0C/wXLjtl/QB+i/zMbxkXOQX1gprHpIpGoLA7psidKw3s
 ZT5DoO4D6hKZ9ODBVu87rn6jd/xrJb1k5CiXeu8SkUwLu+EC5HCBGT7fdYFeSj+COIur
 30l8WurZi4SUSXVITS4LprFsGuewXfN7wBrZpiE8U9imrmETWdB50QD92yjyBRlPmyyI
 H1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788304760; x=1788909560;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iTO9Bl1A4M4zo0TJ+YJltBWqZ51NBQa7Q62ZAYSv+dA=;
 b=R01Si0H+HxTPEC0iSYf57Y+InoUBnvs5kg6dsUdh0dloBbSSJJihXyMdXI9KM1rUoO
 EPSAHwPMByML7oOY9hB/CmwwhC9BSF8FwC5yVz1umHLg8ecw3O+Jr2TkK+hjG/Dk5xOr
 lNSqMIJQbkiDjBnJGP81cafOMNC/JooNBFw7IxJ6M290rQrIWXV0AFOn+cVUwny86bvi
 KyXaugW35/OMC0MNRBTInG/VX5R/3K0cB32G4g5vhaDuiyHY7Lkk0MIWJ/C1FvDbO4sm
 URaHL5tGwS7E0EEq7KPLsWtVqwYO85brkdDviNhaTifIv6jzHEr02wgOkYibunUGLbMh
 8E3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYiYlPM28EJPmNYRo80E/p7q09XiSHIEXXmzP49iZcnSxBrcMl8M0HH2UGncK4yuyGzSCwJvyo33I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k34g7zPDhQl6Mf7Ib4iWTmkZSs1Y7uUoa/z8voy6kHaF9DsFEN
 LjmxBkaJsXb2Df6BdND5XrT2k7fjp0AgnX/44SuevhE4I9zsAEc+hvVOmVtQoazJWYVuFxxPClO
 DWl26Xn2KuqWab909o8pP+xdUCKXKpK0=
X-Gm-Gg: AYBFou3omCLim+H3GdoXWNiYk/VLCYWUHN5lVNt01MSP+lVbKXA9lnHodOTBacjwaYJ
 6KaNPV3SuCmLYn2c6FvLwGXr/g4162QaMASOyjYUVhuPsZSKu03tZH2ebISK4ZhVTWRd68PqKJ1
 6973cG2Fgu5M7vGwXOpapnEmu2t6cLt75J3c/slKc7R0t00OQb9SyYvt5wlx4/i8i0fAb72ClNQ
 WDNYIsiCj2t9FamRKm4Q4S+KZRxHs5MNgreTCOeKNK/pZbGRDnb3/OrU4xw90U4W0DZu5l0zZ6i
 R4ydb4aNxfJ0P3VX1qcG89P9ZZ6Vjt9P1UuYTfdT2CKdz65LdOPYpoTpkysVpsPldDwomkLzWlo
 38S2JLA1b/0TkJp9lKByUlL7XNH2KSACWxGZWK2l9vHM6B8Qw0cN2aWnkcN9D
X-Received: by 2002:a17:90b:4486:b0:398:cee0:67dc with SMTP id
 98e67ed59e1d1-39aee22219amr330724a91.5.1788304760234; Tue, 01 Sep 2026
 16:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
 <20260901-cv-v2-1-446bc69d2ade@nvidia.com>
 <a796c716-4db0-4bd4-b69a-accfe0d382d5@nvidia.com>
In-Reply-To: <a796c716-4db0-4bd4-b69a-accfe0d382d5@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Sep 2026 01:19:07 +0200
X-Gm-Features: AcwNN1XNkEF1AhN8yU_Q6na6OP_zes3C1-Rjq21wcY7gsKXPtUmdPm79OvrMDS0
Message-ID: <CANiq72=k3O03vh+2EbTamAZHOZebOZ1-X8=qiyHWX+YhGsocfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: num: add cv! macro to create values from
 constant expressions
To: John Hubbard <jhubbard@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
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

On Tue, Sep 1, 2026 at 10:19=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> Remarkable, in the sense that it seems like an oversight at the Rust
> language level.
>
> Alex, Miguel, is this worth mentioning at Kangrejos?

Yeah, it wouldn't hurt to discuss it if we have time, since we will
want an improvement here one way or another.

I raised it to upstream Rust in our last meeting last week (we also
discussed integer casts), i.e. they are aware and they agree some of
this can definitely be improved. It is of course not a new thing for
them, e.g. this issue:

  https://github.com/rust-lang/rust/issues/69329

I also have it in our usual lists ("Better `NonZero` ergonomics
(`f(1)` integer literal coercion, `1nz` literals or other
solutions)"):

  https://github.com/Rust-for-Linux/linux/issues/354

I hope that helps!

Cheers,
Miguel
