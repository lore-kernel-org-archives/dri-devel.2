Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B319CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C589210F880;
	Mon,  8 Jun 2026 18:25:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pFxD7YIG";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5EAC10F880
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 18:25:43 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-68c19f1f3ceso7256928a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 11:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780943142; cv=none;
 d=google.com; s=arc-20240605;
 b=F6i2znZpCWprrM77uzuSMEaU9ooZaEXOvK+ugPLXlEA8mfMPUjTidWm3r5LIFdSljp
 JqbU9BBKyJz8g0d26jl9hsVI10EC9X6C4A5Edx69xw2fbmZ764Ci77bl7NuDTgMxW4gP
 IVq87qfgsD6ZHeaK3YVrL5JJcYlQTU8Fsi/9feZOUNAnfaRvGD0EAQux6XPiu6bdHOgT
 4Ry1I29peWbo24qcG3ChgpehfrOOHPccV5SQhmS1o4K4E6B71GdWp3NrDQt2vqQlqTxn
 WwxWDepO//+hg6W/zZ9Q8+VjwOSwbzzytirJ2xE3Urxy/dmn37ZGPrz/CTexWSp5Xb5P
 +T7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bsRPENSdbfWpeWzjmLusfxbY/xjbYvZuSQQmkbsz4lc=;
 fh=NBN/LyR1jy+sa8fRAvfPcCdMytAGbCg1pkdZg9EKdYw=;
 b=gQT0JGW/HFufzqTjJ98OpyJd6oQVrpEEuzr2i4f0fcCwg4N5P3lfiKn13X1pOK4ovf
 jFMOhwvirNsrEqGzSxOFd9cqWE+0v7NZsCSexysrpCxPnJsrKIwczYWZYgFWHagf2iUs
 7cPgXGjylbgUwoo2sTCORSDl7hgrffaFRdQ4f8aroBeLczdz69K5YqvitS8szKIZP0Vd
 q7ULvImuBjcxUZUAxs/u0PSTy7Fc9ZL/u3NP9e1GBHi6E/Vu1ye2YJ7zthCTAbqEJm/Q
 UXqjWCC8w5cUEYoq57uWLlAck69gmKApUBsSg4zj+ggHDh7S4aA3lVgjss6C8I0rmUa2
 8/VQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780943142; x=1781547942; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsRPENSdbfWpeWzjmLusfxbY/xjbYvZuSQQmkbsz4lc=;
 b=pFxD7YIGKzt4rdDAJlJBuD0sPd3KziHZbU+pZzdFtLxTwiABOntgUqs1+/XUc4Uphn
 QpQYHLy+PVz44rMytIRSrU2x/RTO5Xj5XOu/xEmM/xu5pXxKJBrCq/PAch1+rSs+7HTg
 RWmHgzvXiBtUBTvlSWEQAPjXYsUFvXYnhIfmeC1J2RWSusX+XcinAkJglp9/9o+74Soe
 Yg/RF5Zz+b14ttDRn9P1sT6oJyhNNdytqgmBOWIgDfzNqEv4BRUcUQiQY5kANAZhJEkf
 34S5Cqr15U96oZEq8tVLzFXFXMtLdoPueT8v5iQo1D2N2IpNrwdGdKZFEV+J9D7zTgzE
 5LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780943142; x=1781547942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bsRPENSdbfWpeWzjmLusfxbY/xjbYvZuSQQmkbsz4lc=;
 b=o2cQ0+4yeoAPuRQ8Szjx7LulHZbG3cP2Hm1NizL25iejrfVmrzxQEVE1RhnFdoOUft
 /3QG3uzIqWCKouxDNne8t2F6Pqfhk4gIhaW0QCUD+/Vj3nqVrj5rqc1HSM8ogy3CY+6L
 kjFkNNoWruxjDA+fgQCHS29Toti4btRprq9LIqtHmEaBLPnRlHoNtO4DdRrEftyYeS/2
 duDMHqRlXmekWQG7lsLqx2lkEZ00Ondj3rP9HUWvL0C5bWuEbmbVbDy31V+iktQ5+PVN
 D36jXFxDlPLTsutwbZO4j1j2hPlq+JLxzLlXzCf1IrOT6U/0GM6nhSJmwXAvlEym5lKH
 h6WA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oJTg/NMZCIzVcPdw/Edr/YTbZOtcYLC+B+qE+mzxaUVIO8SCyCFSsRbpaHEbr8dA/hVkq2fOZML8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxk6bOCnIWR9k2bF27B4dm0TNNs5UMrD7zN6EdjdP1vrQrqXN8x
 7YmpzktolA07beTe7zUheOZbdpdiRX8UIXAYukDFEbiO0KBLep7ncU8dPLuVZu0W8CnSL3amMPi
 M7ZLeT1L/zY+2ugwA4SyLQ4jurQZGPDk=
X-Gm-Gg: Acq92OHen8fxB01V23I4lhGayoAu9J0U1NUBuASCt6QOMV09DIcu9nd/9ZOJ+IphpiO
 HfKEBqYk3xOtGlbqiiP4a2jUulcw60cEefXw5WaYMIRaoJSHwYU5k/NhQUZoTijCHVJfX50HH1p
 UwwTigNG7poLJCcjaXSYLuUw1UTdiIlhVvQULqvoy4ZxbTBwxFjhqsUvb8pKrfUvJtaMsboDbwg
 Qa1LFxq+srs+Bs9Hu5Nn99YPsDA8+Bs6jSbIsIL5MYsCC33vlh0a9CBb0KSYSR7bn32Nj6Uudxu
 wwYHJpPdU9CkCpoEZA==
X-Received: by 2002:a05:6402:27cd:b0:691:affa:38da with SMTP id
 4fb4d7f45d1cf-691affa3b75mr3213281a12.1.1780943141898; Mon, 08 Jun 2026
 11:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260526210048.1162477-1-edson.drosdeck@gmail.com>
 <4ebe7f6b-aa32-4441-84db-1b09cc69c075@amd.com>
 <CAMSsBRw16QVwXCWWq0aeoKcqe9soBF9x_un6fGj5A4P+iVCv-Q@mail.gmail.com>
 <d4cfb50b-3b70-4393-9d95-04566767c778@amd.com>
In-Reply-To: <d4cfb50b-3b70-4393-9d95-04566767c778@amd.com>
From: edson drosdeck <edson.drosdeck@gmail.com>
Date: Mon, 8 Jun 2026 15:25:30 -0300
X-Gm-Features: AVVi8CfXclb6j0YdrCqCKvFp-PCdAED1IRl-uc6SCc1u1i6sh-ACyg87M_5t90I
Message-ID: <CAMSsBRxR9Ar6p0qyutfMcCmJb7yLUNwE-CRh1JHKa-PZHHzRTg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Avoid using zero AC/DC brightness levels
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, alex.hung@amd.com, Wayne.Lin@amd.com, 
 timur.kristof@gmail.com, superm1@kernel.org, aurabindo.pillai@amd.com, 
 ivan.lipski@amd.com, chen-yu.chen@amd.com, amd-gfx@lists.freedesktop.org, 
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

Thanks for looking into this.

I tested the proposed change and it fixes the issue on my system. With
this patch applied,
the initial brightness level is set correctly during boot instead of
starting at the minimum level.


Em qua., 3 de jun. de 2026 =C3=A0s 16:23, Mario Limonciello
<mario.limonciello@amd.com> escreveu:
>
>
>
> On 5/29/26 14:13, edson drosdeck wrote:
> > Hi,
> >
> > Please find attached the requested ACPI dump and EDID files:
> >
> > acpidump.txt
> > edid.txt
> >
> > Thanks for taking a look.
>
> Sorry for my delay.  I looked through your acpidump and you don't have
> an ATIF method (which would indicate preferred brightness values for AC
> and DC).
>
> I had expected this case is handled by
> amdgpu_dm_update_backlight_caps(), but it appears that only sets min/max
> not ac/dc default levels.
>
> Can you see if this helps?
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 832223c06b3f5..e2831bf48eaab 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5213,6 +5213,8 @@ static void amdgpu_dm_update_backlight_caps(struct
> amdgpu_display_manager *dm,
>          if (!caps->caps_valid) {
>                  caps->min_input_signal =3D AMDGPU_DM_DEFAULT_MIN_BACKLIG=
HT;
>                  caps->max_input_signal =3D AMDGPU_DM_DEFAULT_MAX_BACKLIG=
HT;
> +               caps->ac_level =3D 50;
> +               caps->dc_level =3D 50;
>                  caps->caps_valid =3D true;
>          }
>   #else
>
>
