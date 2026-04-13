Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56395EBFD0B
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F99710E33A;
	Mon, 13 Apr 2026 07:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mcqMXpS1";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FDA610E345
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:28:01 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so608371866b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 00:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776065280; cv=none;
 d=google.com; s=arc-20240605;
 b=bJVZ1/+UGmf/YVZ055sC8V0nJyVn/yC3CWSIu1w+OKRUt+uiBCYYw50ZW1m4bfwMbK
 7QDwYb0gekbgu77JpVuqq0U8+udkf803ogPgJ27ttvEXwWcXoGDhdcdeFvyFDIwbnHW9
 sysrchi1nj1fFZ4Eydrt4Ki4mn9s+OY0sczLZG8IrcXUudPCHDL5RSrtajh2+9Zgsy8i
 O2eS5is2VJaA36xAEWY0swcdv3Dm/6fNn9seNAZrFLc2HoK6sZc0tshBzXsepGu4yVrH
 O6N8oGHQALZ0aZGXyg32PaJKKw8lpuTY/1BfPyagOudxmmpe6yqj2DdPU2P4HO32JRHP
 2mAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=esw3ZYWK8lMWwagwM2py2+1xYSPbr9lpYxI9c74FbXU=;
 fh=P2ky5h30Rc1P+zSRPzjzZqJlwRT2+eHWScZ/6XQbo7w=;
 b=MgMXimMfhuBFoN9YLKweEPB7c1iogpZ2N8FcUS/+uhU1z1WTyNaxrMqKa8w3sIX9ja
 f46/F2Lgz0l3GG0g7KnJtw2veraS/SH9igFHi9BfoIUJtRrySItKG/zF/uLOsd4KWsgP
 T4yILT2dx5E8qfgig3t3uMBVDlhcFYI4a1vBYbuqc4e7/jWej/NzwU54JveBOliz+x5N
 ARhGcgmq0Knou42blhPor41dJgNP4ZT0ueVPUwZNNNPkymt6QCbAI87Dvb4u1k5vqXjy
 xCRhQBqhzaKDU4J9LLpBs3NeUsYiFtvDzv6OH0kxCCidKFQfvrt+/4Rt3XQ323bUS3p7
 Voag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776065280; x=1776670080; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esw3ZYWK8lMWwagwM2py2+1xYSPbr9lpYxI9c74FbXU=;
 b=mcqMXpS1mFKXrGy0hqv1JkFakXGP06hTlwG7dwIf3XayvoQj7dzYNw5EpUqzuSfmiJ
 iBiJ5DU12G8IGl5saujWTXQyoM7EJHPqKzpm0P9E6TNqWtpWFKIqkwMzKgOUwogYJZw+
 oR+LSt18vzWtvYhaTaO55W/LQA/BlrxE9MSUWoUgQAloglk2CQCjOTs2T71Lxm3zYd3j
 FeKsftYTy4mt7x8gypDRQD5aKQgZexVdhUY4nJNy2w/ssMfLSJyQdURM7YxKgHR8E/H9
 2yd1StJYfWDgJPLzstnrTiZvBIJj68uFzufg2f3iU4MgkRmeaNcGBknPdBTKqdR2rxKd
 MZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776065280; x=1776670080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=esw3ZYWK8lMWwagwM2py2+1xYSPbr9lpYxI9c74FbXU=;
 b=JIVg0levUZl8+DYLek+iVJ6Xxv8N68L+XhV1ozRfi2q6jFV44JyvngtXqrJatPDkAU
 SIyxMlKqIr1Z4nTxYdt2AURkuvnE3nvAIkfOdwdxjKLWb9mOhrIHSZIvGE0HW8XMrAiK
 a0prdowhHWalXRbJTKrMsVW5u5ZD40lvF1bPCv/4Fvk0C3MDndHv7FrN/+QD5u6KU7ua
 sDH+NTZruIueGiRnVE2+VDrA8V4WU0FJ+r0XOSfVirp14c7ITHkwEfoRvDOgAJqI8YK8
 amUGsT4EjGG9KZG29SU5QInjMSPVEvNbQTQKajzC7blCg4G/CiNb5CPnC8pYilNWnjaD
 JWYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2gWt7Yk+RGwbiLHQd0BYrpXzr3BpCtVBqbMR6IMo3WQ1yq1Jo/4H8qpnXMHVa3dIbQ34XyXuHBnM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWuAIDkdyrLGmKBnFdZ3Jwh2EfanJFP0ajr4QXTKo38jXq4C6X
 VDpfE5XgUxnJaYyUfVYRX3HQalEYMcjsRbndLkWG2fmStaLBvuPiiz9RFXxa/j5GsrG+ABg24Uy
 VNv87vxcr0tj/NLzhLbjv+YjqLFUL3RM=
X-Gm-Gg: AeBDieu/+Bi6N81LwKtnjbU/JLaz0ySxaX28pJceQ3jdsQWp+zyvfUcBV8nwdwCdeXU
 8oAomGuGchBO4JowFOt02TrJSQ1upNNrvMt/Ei4nGwsss1YCKrAaf3u64omOCuNCH4oTR0vIH57
 Ex+V0v+Fg6Hi4a/MqLw6vXs4zGZVZiHlbGVhMTMiefUf6yYGi8FvUnxu/qEuvOUu1sZO7voZ35o
 DvizPMYGLokE7wVDQrixAwrHNRl9JmyjC9HceDgikXVDKlbhRrtdGj47wvKzNY18dselpzjn95m
 MZPSIf/IctwnUHnTfFBzq6Nuxw5/k6Xb+fuH1nHG0ehSdt63LZNuKeZrpsNtx0gd46p/Gg3lfxy
 HFxIx0eyNbiSc5/CZxw==
X-Received: by 2002:a17:907:a807:b0:b9d:6cec:23b9 with SMTP id
 a640c23a62f3a-b9d729c06ecmr660809466b.41.1776065279751; Mon, 13 Apr 2026
 00:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260411152220.89174-1-bcmouli2006@gmail.com>
In-Reply-To: <20260411152220.89174-1-bcmouli2006@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 10:27:23 +0300
X-Gm-Features: AQROBzB4Yfa7E8b9N0W--P-qDaiyqe5XsSiklgo618k0sYtUqoQ1QuzhuPe_kPs
Message-ID: <CAHp75Ve3gDPXOCqhXr=Ue1T8tX9rfh-JJrtOoFa+thcsXq1hOQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: improve TODO comment clarity
To: Chandra Mouli Baskaran <bcmouli2006@gmail.com>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, linux-staging@lists.linux.dev,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
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

On Sat, Apr 11, 2026 at 6:26=E2=80=AFPM Chandra Mouli Baskaran
<bcmouli2006@gmail.com> wrote:
>
> From: Chandra Mouli <bcmouli2006@gmail.com>
>
> Clarify the TODO comment in fbtft_ops_damage_range() to
> better describe that the current implementation updates
> the entire displayinstead of only the modified region.

Please, spellcheck the commit messages...

There was an attempt to improve that. Do you have HW to test?


> -       /* TODO: only mark changed area update all for now */
> +       /* TODO: Optimize to update only the modified region instead
> +        * of refreshing the entire display.
> +        */

/*
 * The style of multi-line comment is still wrong. You
 * may use this example.
 */

And also note:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/dri=
vers/staging/fbtft/README?h=3Dstaging-next

--=20
With Best Regards,
Andy Shevchenko
