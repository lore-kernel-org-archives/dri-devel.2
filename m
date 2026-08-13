Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164F6C5AC67
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8FF10E510;
	Thu, 13 Aug 2026 08:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qSKkRdD6";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB7010E510
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:19:20 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38fe113c792so332958a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 01:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786609160; cv=none;
 d=google.com; s=arc-20260327;
 b=K7KrBUNv7fR3KpAtfO+5VJ277DzJeJJ7I1mlhZSGAXHK3v+F2SXRoSyCQrb7RL5bW8
 yaQSE47qyOPHf23I8I6lgmdGItL3B/1OzpiLMHGcT5qGK1azUlQIafWUqyuIKm+kctUX
 jpEDqBg3e/EE16PK3v0xN7Xjmks5xpnJSQv58BXGpMyk97NooHsHfhg6V3N5VmhvCUct
 s289P/AUWGlVWE+Hqlff3X9D1L8BiENWgoyMW3QW10jgSGmLUHm3P/nNvjpYU+pIJX0/
 mb1pV3hu0Tf7sWItTMOzSmo70HEX3Pt7Yb0Mr+5pHuGyreAYcf5SullIwwtKfcBE3VBA
 pSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
 fh=9N/bOuhUhA+TmUmexb2rYtNpH6q98QH+vyxulhE8KAA=;
 b=NCaYuM+yQYHH1rEgRe+3DxdC85d8KQplGKOVijwCn9X2WPFR46cUgSaP1y+rhNagYW
 I/0QLzN2CiSnRHtf5bGLknb6XKIlaM5MNWh0UVW3Q+NHpAJG2Ug1U5abA5wxLvhqVkCQ
 6qnFw/Gk5R2dHnhb7LrcZ0V21+Op01WnTutUp++JhZZN3bNe8HHmSXLouFgUDfVw7qgy
 EnY4+frUe66QWWrc1jEsEr91t2oHT+z+qZLI7o2fT2QFGiQIKSkCCEWG7yudSScViL9j
 TlUicWpw42mex/MfpPEGJnJWbG3GrdZDnivK4wagdoIlVYgn4fJAD06jaZ4NffVcr567
 AjMA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786609160; x=1787213960; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
 b=qSKkRdD6PkPKc5dJnfeA+WEfa9F5QGD+A0gj5WWqcffMCfq8+zreK6Z2zXqQLmO7DB
 SgPv7/LhnnVpaXvpJBu5JL86l44Y0xzeZDX6mPkvI6oAR5kKlG0QzvKmMjSD2X1Olzlx
 gpuKaKae/Dr3XRs5Hhy6h2mTqJ52zEYnjDQEgMqdL2JJf/NRbboAfIAYoliJWEmwWZnY
 lsQQLJUO1QCDdDYmhqdT8/FjNymBj8A+MQKiRHy7G7+a2NxUlrGFDRta+pj+c5K6bquG
 XCK193dRkRX+AgFIN2/OyUgaoaq+nF90CTe1b2hjgsiFPo9pP+RG+PULCrKYDb4zBCKm
 4vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786609160; x=1787213960;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
 b=myQtbe7NcvfxPdE/WuAG+JxHqmg5Kk3MPqiSnkV5SevbkEzWSghjj2HS3X9EJjTKGU
 tIDRdEsFZ8AcFCVVQUvoNDLQLAAakTvxAW7rv9s14hLv74szjIXL2CGA19KHCCK1oyZE
 Ums33em6DcBzCJF7z5zetWhluoHBU/PplAxUbXGR0BI4axQbwD0bNvXr3mB9OFr71qor
 7Dp2KOPi3WMmUpxL6NJTJZQMzdb/jo/lFsaBx095TJsq4Dz5g/ZiTPWUQrY5ziOnM14w
 xpxj+amQJbRORPKphvYdTOh7xErEXguJr/slJNFz6ds7jMsdoLsGIHUz+ltomrkJUbxc
 f81A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrxy558esk8pbIYKUjGt+/yAM82VeQRkuj4tGzufBe1W2xrD92SNnEyc/gThRJLpcBKVGIc+ahclwc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFjtt9rl3sopSqFNt0ssGJbIiIte8UTk8NG7ty2y7XwUhUTQbt
 ZS5uckSOsSbSBZfO42r/QMDQRzU3FJL23wbpZg/oLygd0//yaNE/I3DBlFq459AqDUC0Dd22ef0
 XdRkr3DsbRL194BmAY9ic2FmSoh64iKY=
X-Gm-Gg: AR+sD11SuSDetz2DvZfjOnSOMwsw2krnvmMBRdO/8aiy6LYvFGc21Dg7k3REUcfSusL
 OucrCrUB7VuptzFznhW+6J9zaOmyRhXOA9zoS9i+CfvuQu3WS5yx6qft16Y2AnX39PbVhctyGDG
 54PBsuzPesf9uZ7s3bnnib3lJ7Ane6NmhSnFeFPDAXpMjoHdkWEMg7f0JCc4JvZW9GfuIX0GJfd
 Dj+k+du+yF1F3OkMCx39tIjDuFD1BUgFmMYbmZDWjk2g0ST1NEXDOx4xG6GxSX8zMGcgC23hYrS
 pxhIPQvHKx38y8JsKUXtXTNmAV1sfXbBXlS7zhoagOfwASgMlVbEbI9eqBmlhkLixMHgGjeSr6u
 J0teeXLFDa8AYqrPI0Za13S5CRd8TUaMGOlTkg3zK8rlumtSS1YnFpia4lGKtjQGflKOhTzc=
X-Received: by 2002:a17:90b:5807:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-3931e2aa828mr3336244a91.3.1786609159836; Thu, 13 Aug 2026
 01:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <0102f153-154b-430d-a3da-2c8423fb3f1f@linux.dev>
In-Reply-To: <0102f153-154b-430d-a3da-2c8423fb3f1f@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 10:19:07 +0200
X-Gm-Features: AUfX_mwh5p3w0RKVhg92eH8jsf5k7VluJKRFIvAAaH6tiIul7a7G8q8L9_4Mlig
Message-ID: <CANiq72mcFp-MODPkNGPcufxb0YhPDO_eN8J-ZFVzkd2-W6VK6A@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
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

On Thu, Aug 13, 2026 at 10:15=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
> Thanks for applying the series and catching the stray Acked-by.
> It was a v5 series-tag, from before the MAINTAINERS patch existed,
> so no need to re-add it. I'll be more careful with tags in future
> submissions.

Thanks for confirming! :)

Cheers,
Miguel
