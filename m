Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4168CEBFD06
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96FA510E32C;
	Mon, 13 Apr 2026 07:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MI/A6nz2";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAB610E32C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:04:37 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6714f678bdaso1370260a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 00:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776063876; cv=none;
 d=google.com; s=arc-20240605;
 b=I6JmaJkxpewBl2sCIDQWlkaA1A5fIA9wIqtf4QaeVVSwVmbZJR1wPn2c8UHbSACu6F
 d2jTv56iVSxhCZcS7Ytlw9tekfFOERD77uV0dnduoTTHlJP/S4hCwM606AroYNdDngYi
 axwRr90f8c34WTiJhVImDM7WOrHNGs8/5X+pH53fraOTb3z9F1ak4VXYG4/SdNojZc1c
 I96J+O6TeSxd22XS+bdgiTItSJ//qeSq1hGtr+bkiqnUJnDgha6OFN8lR1ybyN/pusIo
 ovLTAD6g+rk6Oouq2iW44BCY1H/bCH7shk57NMSIA8E7iZGPNJ7d7ig/divo3omMmQPJ
 eGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cHUon7mnOsFivonubjEmKa1tqwPu0cNQ4ngoVsPKvwA=;
 fh=qOVgiA7SoDCE8osp3K1F1yKv92RNO/+5NVQc3GgtcSk=;
 b=B4VhGF/d401OuT2zP2eAlMTUAFzigrbfI86phiH3AOIyU9QOAb1L3SBjE59CV5+aOk
 FovXMF5S7CmxXItEh/OYdAYp09ac8FjjLZ47gv7YUJ4H6CA4ec+moX9MAft6U4DIqWMp
 RQS8N8vClBO2xKlh+REnBMTuA9urHWMFpUWe3g/3j/1LeRlgZcHVkp0lgMQoVbBlGXSv
 jWHkQKpbK4qoPzZd6gPPEOBq9G06Uklz61OwZkJH1bJVFp6Csuvv6YOdYnk1/UywXifN
 D3/kvKXfw4lWV1rcuTuKRLYW924PTOKPp22DtHXz6JbJDu9i6CKb+Rv+sBL6STAW4+XO
 oyYA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776063876; x=1776668676; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHUon7mnOsFivonubjEmKa1tqwPu0cNQ4ngoVsPKvwA=;
 b=MI/A6nz2Uz1fMfWVcrJnvqHgqiVXMcL10xKmKN2hXpdziPte41jbrMEnNwmemDHphv
 wn92+c31fligUpfEbmZfUbgNqNIkgJvKIgYbRgCOOG0E98QqazbDMVfy2tKm8rcf6+Ho
 C3y8BP0mtxdTLVrrsww2pCIgLdYtwz04TITP/QoER7ecUsvt4kmAMUS1skjTdlvYEYP4
 0HE4hZf3la55onvA+CjLB9rk6zTePbyKYw2Cg31E4Jl4PMe7raARN/DnFAkIweqPHxek
 fiMhdHkVQBjuoKZV9+ryA9NhiriOxPfc7xdkY3hnNb483YZNzofq5OnC+cDXJdJ9tmpk
 pEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776063876; x=1776668676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cHUon7mnOsFivonubjEmKa1tqwPu0cNQ4ngoVsPKvwA=;
 b=G5QiMMv85FxErZYKpQzJDM89KTNwODCE8ZPRQFjBzp7nK04E4cVUeH+UdqrHQGfPa0
 qGzR2XQUdBhSQa78Fvm/tPI2X4UFcc4aLrcZXGeHPIAuO2SYiz8nQctyGOQ+okSTQDRJ
 q7Gxr2Y1AYcRZTEnSX5jSFCcNsdOkzLb6/fyiAtO+DDhrVl1CB//u9hw37ImuWiqkyE/
 BmqMrnTKOhkNel0BXAz9SmyUcVFPQ/LgUqnCFu+5AGaeHvjxBgbRhnMIbcpOk9dd4Aow
 +C1WaurJLyI7BDLK7TAfwxliw+g1GShjL3hwHjJ1AKn9RilUNeKqHMwQiz7CH0RB6F7G
 z1dg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EQSl1Y0KlEmEC0uXDI1FbHoQYEAYLC3CpQmluzKWI8hTfV0EnoSRNkt0Qzu4LhawPe10g7uaptko=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtaPsyKGrGDCMaWhkuJD8uMua5qOIZ3Mb+EWi5XP0aTTLjPVCl
 PSws1j6t6B1NC9LjREdD0KEKvU+Tc+K1lNiqit2DxpJLehPKIk+qctdXM3PKR1VdvW6asxwrGzV
 tlgddyIFTluvC7IjJBK0dExnBoTb5HIw=
X-Gm-Gg: AeBDiesI4yum58CAjSWqeS7y9+qPGgcAvpv00PYoIdyLQIqTnogdifyXvIuuuYwCyE6
 GvjZPien0XrS+2qjkMGcsQjmE2ExrC7cm0aiX1G6GVgJG9P14b9B8XKP/teg3Ox95vkDUsoWzZ+
 c+e9gBNcaq/Kyqtk90xLI3IwvKR2+MCRcSF8ed6QG/oEp6DV3TMjXHc6I4N5pm4rmaRPnRvdI/L
 wYDxri2J0H4Jnq2UjQOcDdtyi7lox5V5ns1qphcdQu9+NuVXVm1nP/exCu44QcQ9nlI6795Y7t+
 3f+PvVDa2dB6h9iRG0IxbfCEnEsxKGF4uNx2/LhL+AcvpJkR92D0WJWb4pdiK44GZKOWof8UT/e
 P8EHTZSE=
X-Received: by 2002:a17:907:788:b0:b9c:2a5f:41c4 with SMTP id
 a640c23a62f3a-b9d72683456mr663199566b.40.1776063875616; Mon, 13 Apr 2026
 00:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260412144552.18493-1-mahad.ibrahim.dev@gmail.com>
In-Reply-To: <20260412144552.18493-1-mahad.ibrahim.dev@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 10:03:58 +0300
X-Gm-Features: AQROBzA6J9Pun5_-q9iTAp8nKuVUe_q0RpEZJPgZRxShTkw4gmMnUf4srXfMbNM
Message-ID: <CAHp75Vdu6pih=NqkYT0CR_oLyr3YgNKBeqYM3+naqVp52UCgVw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Use %pe format specifier for error
 pointers
To: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Sun, Apr 12, 2026 at 5:46=E2=80=AFPM Mahad Ibrahim
<mahad.ibrahim.dev@gmail.com> wrote:
>
> The %pe format specifier resolves error pointers to their symbolic
> representation. Previously %ld with PTR_ERR() was being used, %pe is a
> better alternative.
>
> Fixes the following coccinelle warnings reported by coccicheck:
> WARNING: Consider using %pe to print PTR_ERR()
>
> Testing: I do not own the hardware, therefore I could not perform
> hardware testing. Compile tested only.

I don't think it makes any difference for this driver. But I am not
objecting to the change. Up to Greg if he wants to apply or not.

--=20
With Best Regards,
Andy Shevchenko
