Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55BEEBFD01
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A808920E;
	Mon, 13 Apr 2026 07:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LQ++lAtG";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A56638920E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:00:12 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-66f727d6849so5967831a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 00:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776063611; cv=none;
 d=google.com; s=arc-20240605;
 b=MGgTtzLZgAC3keVX1iNB8VxCeKFFB/dWxUWzVfhle9KGB3n+XdHRAV+dhBEojIiPTy
 xTsP0z2jLUF7vTDCGTXdDd0GMmEAzyiT2lFbB6yoyLkBgwjgg/lyjZM5y3I6i/ijKedB
 Txw2NQGxpBhZEUsprpsLziTBA89Mc11eXYJL53tlxubCKPAX2sL+OvtPHjON6m11TFfG
 UmTwcPw7l6re+xbcCos8ZTN1uX9HHvdBFPMSxmZHIQlvxruz8fkryw852+5HlHs5i41+
 XydGoHshwiVe7XTJ3N2x37XUmycn+zAIFVHWjaYc3x6ECN7fQ2TP7tAWke2b+MwUg6vH
 jBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X6pSeBoMwbk97qHNLEiiR0g4dw8qT9zFAczkuZLFIic=;
 fh=hP0gI/wds6TzU+g4KTgGj/dVm/FucfJm7gCuYMXNn6c=;
 b=EuHAG/8mts6lMbGjxlXU7ch/LZ+nh0uGh7fwLIydh7+mOJdtsP6Oh3qaFUoXX0qd7n
 aDTutvcdL2afW/Hd4Pron0KqpFv5IkPYTA6hKQ7Xx0Yf4tG/La8xmfzim8gF4Ndfxci1
 dcz7cOcP8cFfJqMx7JEbU1Snkm9icc6e9oII+0gnV6mUfs3A0LjBghN5YPflf+poaqO9
 KSKCH2+zSqL+VL3g1A6Tm7CgMGiuecHnzSlw6n0uSujW9xtf2TGIsopj4gVp9Qgy1ZM7
 rfpLyb1NTSLkTIxfxBrWxhO88zO7tYUsC8lR4HlFESXCTs+YjyJh7b0GImgVumdQoNQ7
 zWGA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776063611; x=1776668411; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6pSeBoMwbk97qHNLEiiR0g4dw8qT9zFAczkuZLFIic=;
 b=LQ++lAtGflVzB5LLpNUWWwC8yrVHjuglnJcT1uuur/dbrkFrZyi8hbgj+w+33hLMT9
 dQp3Ov6mDJEO3TOOE2D5x2jzerDWS+shlm+p6+eMqrmQzwmEpFGN/bnNNev7geuLc8ua
 SzCCi+vftjBtDd6M8aB8jxXZhZRNnuPiFpYKt4E57fM7Y48af34GvQ2HHUx2wn3pduCu
 f4Dpb6Ns0QAV6v0qnLwOsK3HLCw0aBBadvvb8excz1trFIJ1ZnUdV8v5FRd8MZEQLQLq
 gUyTdIb4+UlMbE2aI0f547ZCCMzuy/eUa1PXDiIKDl9MDkUGqJLNGBxtbpHYY9xhSiLR
 3oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776063611; x=1776668411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X6pSeBoMwbk97qHNLEiiR0g4dw8qT9zFAczkuZLFIic=;
 b=k6/8UWf6SsdYaLxofLaLlDULeomLvx8ZGjUYr/EGXz2kcNuOTCvTKdKxGiGL9DKKEx
 AVeHwFIyYddVlqK5tggPyGPfzE/6QXhvqkntb6VwqA2uzFa2n6Wo0yW8ZnFSVVgp5+Ur
 yIC7rKmOiok1CWedy6LgZgWhd5wF2mGlo2zqv2abC9Y7ZLTw3TI8DZElOFJhG2HgQ1pT
 791d/TctTqw/2yBDpWF6jrW2OZ3wXVympv/kcrkH3VvI+DAAJizs2AEg4N+qkz00LRzt
 PoU65L9FTz1cPCYPmFsyc7P3sAEpwkEqd4s8TeoXeYJU9ZfkjYOdy2lL/H6B67aFHf/k
 qRXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFcwVsH1nP+UZR6H3ERyicCMCTeE9q0RoEbfXH5J1Kz4c95UE1M305SpKGfBF1YxMdVG7tCajTQsY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+BdDdZESSoClitdsV+KBxYIj9o+LpUe8/Kh6y1ndYbDiJpJJu
 n/t1n1lBHZxAauRgXJmiegSF4t9BMjcd1q6ivhumqgbD5vD73GapL3H6NnbIu/YaFDZNX27excp
 q8Jl9doBN70/bHV6WLpNpXr6OvRjw2uc=
X-Gm-Gg: AeBDiesyTzncJ2DphEg8Haz9bgUW2f2ncPk2E8jV/RKlaLfSDyw/mHcq020/e+WfXeT
 kc/HE6vD+bnHM0bAN22uzcDbmPyqbYt3zZ+q8Q4btVd4i9yvNj8rkEgZ0epxx8of0EIf/GbnEtv
 l9AzHW6T+C1NxGjPxlO2dbxwu+ODSsMBKRzumYkVIi159WaIPXhLyE2kvHfAUZrfa1e0HyLuyCC
 fT9G4AqGJRpOB8tF8NFVJhB5JfdR9vGlHLMM87q513lltSPzKudWp39n+SG6QukoeHUN2+jtc6O
 fbbq6+2V7xVUuK4ZKXep8OqFwz/L9TjnnxqeAeGxSFuVZm8mUMyCMLcEknTc4eDloGQDHQLps6t
 1vGf9zcc=
X-Received: by 2002:a17:906:eec7:b0:b9c:69df:4d99 with SMTP id
 a640c23a62f3a-b9d72ad8da9mr652948566b.46.1776063610650; Mon, 13 Apr 2026
 00:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251218061406.8043-1-arjunchangla7@gmail.com>
 <2025121827-lubricant-salad-860c@gregkh>
 <CALO5-psPGGxo9bu4Yjs54Sj=Hpq4x4Zgvp6tEY2MzV+utUfGpA@mail.gmail.com>
In-Reply-To: <CALO5-psPGGxo9bu4Yjs54Sj=Hpq4x4Zgvp6tEY2MzV+utUfGpA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 09:59:33 +0300
X-Gm-Features: AQROBzC-kH1OmWCu3fYOKS8_sAHANFaz5pop-O-JWmBJ0plqPTqCm4ToMsiAjdg
Message-ID: <CAHp75VeZyn+55A3T2_VCGUrvsRwODp2hJpL21Z46UeyOeYyQbg@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix spacing before close parenthesis
To: Arjun Changla <arjunchangla7@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, andy@kernel.org, 
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

On Mon, Apr 13, 2026 at 9:58=E2=80=AFAM Arjun Changla <arjunchangla7@gmail.=
com> wrote:
>
>
>
> On Thu, 18 Dec 2025 at 11:50, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Dec 18, 2025 at 06:14:06AM +0000, Arjun Changla wrote:
>> > Fix checkpatch error "space prohibited before that close parenthesis"
>> > on line 65 by removing the extra space.
>> >
>> > Signed-off-by: Arjun Changla <arjunchangla7@gmail.com>
>> > ---
>> >  drivers/staging/fbtft/fbtft-bus.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft=
/fbtft-bus.c
>> > index 30e436ff19e4..2f7c891177fb 100644
>> > --- a/drivers/staging/fbtft/fbtft-bus.c
>> > +++ b/drivers/staging/fbtft/fbtft-bus.c
>> > @@ -62,7 +62,7 @@ out:                                                =
                              \
>> >  }                                                                    =
         \
>> >  EXPORT_SYMBOL(func);
>> >
>> > -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
>> > +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
>>
>> But you just changed the function definition, does this still work now?
>> If so, how?
>>
>> confused,
>>
>> greg k-h
>
>
> Hi Greg,
>
> Thank you for the review. The change only removes extra spacing in
> the function parameter - no functional changes were made.
>
> Before:
>     const struct ia_css_output1_configuration *from ,
>
> After:
>     const struct ia_css_output1_configuration *from,
>
> I verified the module builds successfully with no errors:
>     make M=3Ddrivers/staging/fbtft

What are you talking about?
The original patch we are discussing is totally wrong. Please, compile
the code before submitting.

--=20
With Best Regards,
Andy Shevchenko
