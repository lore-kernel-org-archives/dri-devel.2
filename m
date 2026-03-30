Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E811061B1E
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191D310E6B7;
	Mon, 30 Mar 2026 19:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AT+gYGKr";
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C90B10E6B7
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:40:51 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7d9bba96f7dso2605737a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 12:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774899650; cv=none;
 d=google.com; s=arc-20240605;
 b=FgEPFGHCr6CVxi97WlaPQy59yn7GNfyDIqQIxcdwpwjIpL6z92Ve23aMn3ueFbsymz
 JkfE+v42SOBUWosI8n5rAYouBtpY35mnaKPiV3Ed6E6uVytlVm0wWD8+mJhHKE1PqQ2L
 NxKAB2jW+ccert/kRO3Yt/465Nva0m+zHcTZTO7lOBQrJfBrRg9dnC5xzctvkoXbaTdy
 gI515Ej5M2LMLuLPje7hwmnapiNVclzP6VvYn2Ymxks09dFmo4rzMeuMjGk7nHBbfHZ8
 k9i0d5OqLDcf+ToZFPh/QleMgLOkyqjDNjAwQWo041YAbPwfcy4dryLHFS9hdqSoFMb6
 oPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MgOLE8rNdBeVw50FL1H/Cs48AXcvUXmUqQIxBQAsmUE=;
 fh=PYLRChkIaoNmmQTFD75uAy1tggQUBWgtqLC/HFU2xMI=;
 b=dg92PJCzkTHie1pi3BEH0njv12H5czq7ZSTUrrwdg5Rrx0WRgXu3mmfE/mVvWHEv46
 HadWnuRXUSeDRWhHieqTliDjLf2Xn0lVaLnhlwV3UTYptnwWx681RjyB0s3r0LzPU0Sn
 l4UHJvb+5xtDpWAXTQxDj0ivcRYbG6a9rbpfdnY7SZmgoer+mLyDcLdh/GMLxgEQug6j
 PDo5Uxt+tOrndjumjnuPJt/kB+Pl5yJCyqLLS9md0Xf1r3UWf4lm4VkY3C3sO7AIQhkO
 zocae8eLCVNdqf/mR8P90UEtaP2wB20x3qqLzX4/oNtsQkgmx9tdqY+0VLM9v42stfrP
 DtmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774899650; x=1775504450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgOLE8rNdBeVw50FL1H/Cs48AXcvUXmUqQIxBQAsmUE=;
 b=AT+gYGKrWkuJtvN+YwbqbfsiBs4uollLLa/XqfWrHQfoX/9fPavDF8PzaOn9lKp/IM
 0CLfWUkLnN0n0FXui43XPkgCgv0ioB7g/E19XglTcQl0Db1CqjYsLOnY868jxIMdCpMA
 TSQ6Ml5mCF7g3n+EzOb6JV5mFb7zaqEtipPpiYzMi6nBPF2pfBHCQAORarg/kp7PRy8U
 5oC0KYxHaJ+5gnHJ/cVFeTqZ4sUubUC1vTUpaTYlVyztIxCVGIP7bF3N31cvQYxodjNY
 PDcSZTqP5QXPLjLoVQi7184RQ5JKsQK5vDCtEurtX2rS8+PgQQFEkCD17zu/W+5Do8px
 z9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774899650; x=1775504450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MgOLE8rNdBeVw50FL1H/Cs48AXcvUXmUqQIxBQAsmUE=;
 b=ak5mPfZf21qyFZYq4HbbK8RsripdYMzE+JmRtWXO+Q6QLsE3ABRWne0k1ERhGE6O/v
 qY9tP6luO90mY1ZiBBKba97RV/I+OZv2MVYPXGIdjVKk9qTaZDr07wkJv11wTRYKINPJ
 eFxkmlXV9srEFJqXmiBryYWrwGY9AuSKHO0aRz6qkcKn0coATa93qgkyYfYMwTzVgrHl
 X3W6pvNjGr2yKMJPjbL+sAboB2tHq9a0cF2lGARBoBwsZzeHVMYjZ1N74KeDHQNeHsV5
 Bxmk0lYeWLGsAbJATVRue/hMZG3MOPyQtnU4EdOWb7ZYHEoJMWjVhgGaLYuhEl0Q1HRY
 pjuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeTSQfH2p9XlvA73/hb3zXAzOJCTIa06mveJ1jmXTCgFTULqGVgMi2SuVoYjD8z5zi2Jg372keUjY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx81lRNIyHxhB0dXlHaorcIBLmc+Eilh3kBIpvv/1+bR6RHnhcM
 IecwHSZImtA0T3/Sc08+YvvbmSipYOeKjgDKnBYh69W2zx3JqZFFkv8tMtTlSzXqbBZTXrx+cNI
 J3YZ7gaz4/linfefDe003p8x549y2ybI=
X-Gm-Gg: ATEYQzyIIyqKn73dD+UyM0uwjtPwusElUWHrmJ+nidZCnfDykjfSOCJbf6FS9oNiLP0
 oHwerQKK3qpBW8m/hl2IAwtB33JT5lvcbXY7451KkCyFZsc/uRhaTfyQ5jurfCLFJUtxJ+RG0Do
 8Ga2S0F12vjnfPVhv6lZmbRUEK6FQpTHlSGgGFDnzwWEpbrDK05i01MBLIsFm0l9HX+n3YUcHpF
 GElfpmWwwfzoph7X8meAyFdoiW5hm6XWlTYExiiXyVnR0l2+1B82om1MbKgmzzcO1V52470lxJ3
 geRdOa/U2w==
X-Received: by 2002:a05:6830:67d8:b0:7d7:cc53:623c with SMTP id
 46e09a7af769-7d9fad8747fmr8039420a34.7.1774899649966; Mon, 30 Mar 2026
 12:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260330145049.21936-1-mikhail.v.gavrilov@gmail.com>
 <d05a9c56-5248-462f-96b5-44ad167f284a@amd.com>
In-Reply-To: <d05a9c56-5248-462f-96b5-44ad167f284a@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 31 Mar 2026 00:40:37 +0500
X-Gm-Features: AQROBzCNLSSWm2n2ptMDD0gOB6l-aEGg2SU0scPbi356emx3GUuYWX7qeZGkREs
Message-ID: <CABXGCsOguZU1k2zS7ngbAMYU10A-sWtoQLQ7P+ThiXR-7e_Crg@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: replace PASID IDR with XArray
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
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

On Mon, Mar 30, 2026 at 10:33=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
> Sorry, I didn't mean to confuse. In v3, was only talking about
> alloc_cyclic call.
>
> As per the call trace posted, amdgpu_pasid_free() has a chance to be
> called from irq context and that may still use irq save/restore
> approach. Eric/Christian, could you confirm?

Hi Lijo,

You're right, xa_erase() uses plain xa_lock() without irqsave =E2=80=94
I verified in lib/xarray.c.

I've sent v5 which uses xa_lock_irqsave/__xa_erase for
amdgpu_pasid_free() since it can be called from hardirq via
amdgpu_pasid_free_cb.  xa_alloc_cyclic() in amdgpu_pasid_alloc()
is kept as-is since it handles irq-safe locking internally.

https://lore.kernel.org/all/20260330191120.105065-1-mikhail.v.gavrilov@gmai=
l.com/

Thanks for catching this.

--=20
Best Regards,
Mike Gavrilov.
