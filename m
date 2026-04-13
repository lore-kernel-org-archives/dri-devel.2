Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3537BF3ED5C
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B1010E09A;
	Mon, 13 Apr 2026 06:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N4tAMyQw";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8759410E09A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 06:09:25 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so647240066b.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 23:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776060564; cv=none;
 d=google.com; s=arc-20240605;
 b=YLVJwD9tarkLaUwC6xfvOz1TXEKd8ifQGqgvs3zts9aW44o/ZPAkD1tPU7wEFxIhaq
 NlnWYI0wVNsc+fjhun7s3C/ZB+DkSiDS+6+S3gS4nG8coTp/+9Sgf+piiys/J4JsJWCq
 gxZwR9jiHhPEVbOpbpy69M10G/pN/1nnxPRqgsfc01wcd15BY/LYlfK0IxdG6tCVlzXe
 RldNPF131TgP1WoApF7/Z73E16Bs4ktkkmdndvVuAviVPfxT5qEXGvoZpfMyVdQ7O1n6
 Poa1ynAIGobdpEzC09VrqXKD+HTS5EUwuDBNmhJB2X2obLPwzR5GrMkmtUIO8QSmtirW
 AB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OiV2w1gDFSOFwIi9IbkYMeKe/6rdSHAAIj+UVdB7T+Y=;
 fh=2EqbpQ+H2KMZ9RTKjlyNeRPHWSVXMMKDuiwkWBd9x8k=;
 b=b6yOVfwq/EFvKzX6D8oUG9IjRQAg4x4T6OUv9MqFSCnwYe371x3Wl2DCuaGaw2cs2C
 TQtS8Mbp1HXJ3apqDS3vBsUa4H9koAORFFRbj3oLtZdPT22TnSJfdXy91FvPMDK8RtcJ
 wiFu1j7qkpWVQeSwkrsKSbidZtiOSwG9NVmebjl8JI3RnyTbLIvu7j6m+6k2SijxLNwe
 glaAMJG0gcvxAOUlPuDwy4mzJG5SP5c8+G1SUczU7BbWYTehY2SSxUtJTAMSd2uv9DSO
 jZI6HEd8mGFFBIJJrR2z6M+V50mBYNpH7NhIKejMvUbpxcLWhgVXof9FW52ak9LOfvax
 sfPA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776060564; x=1776665364; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OiV2w1gDFSOFwIi9IbkYMeKe/6rdSHAAIj+UVdB7T+Y=;
 b=N4tAMyQwyyLic++CMovzgHbB5Ju53K4Ljpqu+hmBtIUuFrxJYFGblMbNOFoQfEc5Ap
 ZUCr4CiDRnd/T6/YI+WKIWchFkhTzMH6ZNfsTIyAocIa1aRKoCGXZOTiXz20mHKPj/Qs
 utflXypaGsegvxj9gfZ13dkABSdVCizRp2sSPAhdmwsRNeThxjvBRI34jeGdsgr7bpRe
 L1nvhRgQ+RdVWEsIOXzDiIFLgPPrytewTxRZuTZcOIMwjQdeWUE/N9cSAma00P+k8rFD
 WBGbiE03qhJjyNrL+YAvJRSCwzHcVg44J0WAzsX7lfdo++kTWvUQnl6lYO+w2f4VI5sC
 VSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776060564; x=1776665364;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OiV2w1gDFSOFwIi9IbkYMeKe/6rdSHAAIj+UVdB7T+Y=;
 b=gUngYmam0+WpwwIkGcfIfTCAYvbFsHLeUp9anDKQ/QBDhPL5Q3mVgUBfRRozz0Q3m4
 wvQcUY3tNSFEr8ggQAKyHEGImz0+Q7x1stRU9psHe9a7YzP+RODVZPqtCSOD6BflMnwp
 Et8l0lwRTBEaRrvqPQ6/sMSHIYcVgR3usc30RgkK46wJORM4gDsan5zygTggoYV3CCsa
 bStaL52bYHYqgigoiHQQspXfia28tN2TltqWqtISITag7bp1ZrZTU4FxzVIizzc0n0X8
 gMHbgFPJVcaOE13iZBrBkspMRbUpLw4Iu7XVwU8lnJ6Y460aBR9mfjEklSxPtha2ECKg
 dBMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdtD1ZS8QGXggRzsuaacwyB91mfaQA4dMvqZLZkN4EOa1DKxe+FzN5iNM+IwE62edFHikb5vA00Qw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywjm3sWNu5dt6rSCNLu8VoCU3dlXs+IaHgLNuf/kmUzrWhK44ol
 MBuMC0SJMGbx5fyN9jg1xf1gKXLShQSlWmRx5hAZhM37jyyzNDQp7iOqjpAETYdn7FoaAb6oVD/
 Euz02nLrCfqmUOZ5292xrvQjwRLHMgrk=
X-Gm-Gg: AeBDietj95jMFU+S0qWBIodtr1cKzdmYILzHMW2KM0NjcFaMZSH5rd+f/EruFppIXeK
 HWsqBt2/MHOZnERvu091MLvw7RTZLYkAUmKU0C9DU+2V4Yz4LygCvfs5JrurMZ3VSHZnwJCfueH
 fVg3AMusPHCE5TwSxDsJC20Bi6ZCcEnT/WcQcFlnAV1ARUWOn2N7NbDhzkmkizVQAwHSVM9l78T
 u9jTxdCncZhWc/iClYDwSPa81QiLLOVSLYJeU7UvYXNTfz4R4b/Ka+WdLuFNw9K37amDyDnc96y
 a38N/pqLQH9PnerLJ8lZ419mP60H6YJRjSoqlqXjIcergem19jqqu+ARnVn/DlksvRzpmH/Wncc
 kJEBVKJ4=
X-Received: by 2002:a17:907:1c97:b0:b98:6984:6630 with SMTP id
 a640c23a62f3a-b9d724362a7mr613445466b.8.1776060563823; Sun, 12 Apr 2026
 23:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260412173317.3329-1-mzndmzn@gmail.com>
 <20260412173317.3329-2-mzndmzn@gmail.com>
 <CAHp75VcdWMvvM-oKTqRACSXSUiVsEh1Ep_82MsJxfbrG4thUdA@mail.gmail.com>
 <2026041338-guiding-concur-3831@gregkh>
In-Reply-To: <2026041338-guiding-concur-3831@gregkh>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 09:08:47 +0300
X-Gm-Features: AQROBzBRxOFTl4Y0hRK_IfrGAfpqN1gBxS94tU4qKCixCJahw8eu990-6JlRl2s
Message-ID: <CAHp75VeME9eDOZ5KosN_sXTP5CAcOGqPfh4Ld=mamaO=jOJ37w@mail.gmail.com>
Subject: Re: [PATCH v3] staging: fbtft: replace empty macro args with identity
 converter
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Baker <mzndmzn@gmail.com>, andy@kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org
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

On Mon, Apr 13, 2026 at 9:03=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Mon, Apr 13, 2026 at 08:58:50AM +0300, Andy Shevchenko wrote:
> > On Sun, Apr 12, 2026 at 8:33=E2=80=AFPM Baker <mzndmzn@gmail.com> wrote=
:
> > >
> > > The define_fbtft_write_reg macro calls 'modifier' as a function.
> > > Passing an empty token as modifier is undefined behavior in C for
> > > fixed-arity macros. Introduce fbtft_no_conv() as an identity
> > > function to replace the empty args in the no-conversion cases.
> >
> > This trick is used in the kernel (usually for u8). If you really want
> > to improve, use _Generic() instead.
>
> No, sorry, this code is fine as-is.

Works for me. I suggested they explore the possibilities, it might be
helpful somewhere else in case of the similar requirements (like in a
new code).

--=20
With Best Regards,
Andy Shevchenko
