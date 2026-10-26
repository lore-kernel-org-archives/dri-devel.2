Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445A606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Iw3IGovv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723A510EC7B;
	Mon, 26 Oct 2026 08:36:51 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 878FA10E292
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:48:39 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-6e560e00a86so1817242eaf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 21:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792990119; cv=none;
 d=google.com; s=arc-20260327;
 b=E8NIyLtDxfq940AwFW2lJBb0FEDOc6GwDb02ScOQfE6jbmaEjRIjFM2a2GpU5dh4u+
 cFQZhCrRFNXq8CgDzIvpYPwALrsS3XS3BCKLlQGBr08bAyuXuqdF7WDl8JgUTt2c1Z6L
 d14jMQeswYrp1IlgrUmw25wU7hs/WTiHuSn0O7qNJvLgNZ//tMoYzumrc5FuoI87Mdji
 aaIr4/saW7fTChKqTZZi3iyYM7VTzS79asUnYGGaELwxvFRndy0WR8td4EenD5K2ljyF
 UP4Mau1kg9OzqAGKL+7NYi18Q92BpRkS0seYskvFjicCILWkuyD4A7157bHbv01f6uJg
 bylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=56Y4H+QOpsErxz20UwuJ3uqXiwvb5kpke2jcTVoosVI=;
 fh=VhYV5dAFv0bW8FirvumgmsDa855q0ueU9uaHw5E96SQ=;
 b=qXKo3DEyjV5WWtvwXS+5+qkarC6YIvbVRgFAxkwZjOVAObRxvFiEGKey2sle3oGJ/q
 Igy5xVG4JVXSkrIE0BzDsGpWlLJ/zDKcdZdlpmiW7hqr/x0TDpEBpXrY3JCfioBMbrB1
 tL8GDZugDOFcSMo7Bdle1Mm8WtVBGC7uA/Tg/ZXYZjxHvg69Ph/nSGMjGZOdyqjAVMaJ
 QGLlzbqIj/3aegpHaftcPtbMc6HpnEzypESaDogLGzjAGNXUqi8MeMGXWAznzcrGGueR
 BfoLV+tz/SqW4vbNYqA450MTD8so7xqdD3/x+6JpP0CjIssYdaRytfzkyKG6KijMuK9/
 +l/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792990119; x=1793594919; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=56Y4H+QOpsErxz20UwuJ3uqXiwvb5kpke2jcTVoosVI=;
 b=Iw3IGovvfeMSj7MVRBs+OQujnei1dExkJmrWa/5ShP5FtLuH37McHJSPjDt3IX4IuQ
 PGnSHOI4YotqgVPrACRuRJhWbd1rWso+orpUQNZUWgf1TIcTChITLzQiXbYNz1lHlgpE
 3duN0KVCqbkfHEz9MMZoGIMQpYy3ZYjKV195Q0agx9HXI9UUBKyQPXecdULnqOJE1i07
 CY6QOHSdkEM5oPliB9R90+UGRPWRN5AKAfqhZQ6SR/d+n9+5I7EFzKPBiAuHEq14aEgM
 VnFgM/KIXEe6+Xbf+DND2okWQuJ1azGbzUgAjL31MxHAuuZsqvYlndWEcrXjeHvJ4P+7
 T3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792990119; x=1793594919;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=56Y4H+QOpsErxz20UwuJ3uqXiwvb5kpke2jcTVoosVI=;
 b=FPFwZptRmhxW+k6mdZ8Zw5F2beWdAMmGzWQZHTq8P0IgP8aMLqaf97HNLEMBIiRW2C
 yg19TwghllI5yQRSi9M82eUD/9K6UdZzm329TAQWKXRCD7OqvqMtlvzisPHi59SXtTrA
 GchcZtn1a1B2WrkSMLbo9vxXJwZ4kZeaj5nR2aGa7DDfUtguYSGKEbFTyGMYT5oUEizZ
 x0t5wq7CvbEtMW8kW6/KXsv5rFyHIINvwk8nf/v+aejeKOt6dzcQfhtROhse2lpeYfo2
 uyjYkZRJ5GDwEI9BXhAjVcXTkls67D3etucZW07N6+e2D3MRYW9ykTYUKqs/TSZlpJ66
 RfzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMan5lKq5inH0NuU7sDSq7xag8g0vUGDjvDxEH2JheEy8Uko2OhHiAUdU4Js0UyeSwOwpFeg66dV0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ8V97gpeVJoZrVTEGg1HCJS45bA5XjUdj81RLDmJWkSwsreFbg
 CZT9C80V9vxQqfFtd5lv2FF5Oab5l0jt6kZC8zHBC5Pfx6QllgADlpb8+YEVxIpfK1ofLdOzJdf
 660D31Ar25MZBSLR1Tb8WaJbrHTbI9lU=
X-Gm-Gg: AYBFou3BNrUY9jp7JQt7C0bLBT8pEH7JfzpBaG19Q7gRxk+BZxziguEbkPfp+u3FynH
 KNIjPANS99kcEm6FYzoAOkeEVvtQsT0NvltYsj3ubspYwAZEesu/UDEyoyGsRQNj1+7n5zibgnR
 ekAJQdak9PJg/ESQGd4W6ncI+6aQFkvGwX+3HE7jMq1E8I6q134YCVBkkeq1kk/OV+dEQ5L8dDb
 Cjr2uLs2Hbkwwy/OTw5F2ms9CF/uIXr94th++uT5afMPA9baLiUMoXaDdpdiwtTDwNTs/Gcbem1
 1K1v67OrccGVY1dTC4zY7od9IMfClpRmXBA7BJUQWc1XFiVicXU4heyc4kYip4nwx02RY0bJIVn
 LaySDna3rLb6hxnBp6EIDdnWMi1v5AyAoR2tJBnoCwJz8RrnINKO6fOBPULd48PPCZPgAk4Q=
X-Received: by 2002:a05:6820:7184:b0:70d:a53e:845 with SMTP id
 006d021491bc7-70da53e26e4mr1017756eaf.17.1792990118754; Sun, 25 Oct 2026
 21:48:38 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024180803.108872-1-himanshu.bakshi478@gmail.com>
 <at4Zyt9QP3Yo-ZTC@ashevche-desk.local>
In-Reply-To: <at4Zyt9QP3Yo-ZTC@ashevche-desk.local>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 10:18:27 +0530
X-Gm-Features: AclHuK-hrVr9XIOU9ZgMN2G04tr1CEuz2jBrJcJQCkK3Fq75oom0ajhxJqnjf-0
Message-ID: <CAGLmz9+B4bcp4WKfBzpS1nO019J3yZppeGKx-ZgZjncik5e4Hw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Fix line length warning
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andy,

I have sent over the revised patch (v2) over the mail, and will be glad if
you go through it.

I have made sure that the \ (backslash) is properly aligned to the same
column as the rest of the macro. I have also taken into account your
advice and hence added a local variable for platform data.

After some thorough searching through the respective directory, I have
not found any calls for fbtft_init_dbg. This might be because it's a
helper macro that might be useful as the driver progresses.

I have also noticed that some other macros around this one have simple
style issues and if you would like, I can send another different patch
cleaning up those too.

I have also done minimal testing by using the macro once to make sure it
compiles and has no errors, if you would like, I can also run any
standalone tests for this macro.

Thanks and Regards,
        Himanshu Bakshi

On Sun, Oct 25, 2026 at 8:31=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sat, Oct 24, 2026 at 11:38:03PM +0530, himanshu bakshi wrote:
> >
> > Split the line in fbtft_init_dbg macro to keep it within the limit of 1=
00
> > columns and address the check-patch warning.
>
> checkpatch
> (in one word)
>
> ...
>
> >  #define fbtft_init_dbg(dev, format, arg...)                  \
> >  do {                                                         \
> >       if (unlikely((dev)->platform_data &&                 \
> > -         (((struct fbtft_platform_data *)(dev)->platform_data)->displa=
y.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
> > +         (((struct fbtft_platform_data *)(dev)->platform_data)-> \
> > +         display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
> >               dev_info(dev, format, ##arg);                \
> >  } while (0)
>
> First of all, make sure that \ (backslashes) occupy the same column on ea=
ch
> line of this macro. Next one, it's better to add a temporary variable to
> hold the platform data pointer. Something like
>
>         struct fbtft_platform_data *__pd =3D dev_get_platdata(dev);      =
     \
>                                                                          =
   \
>         if (unlikely(pd && pd->display.debug & DEBUG_DRIVER_INIT_FUNCTION=
S) \
>                 dev_info(dev, format, ##arg);                            =
   \
>
> And last, but not least, have you checked with `git grep` how it's being =
used?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
