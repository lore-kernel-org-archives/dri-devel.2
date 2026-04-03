Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1718EE85367
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 13:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BAF210E41A;
	Fri,  3 Apr 2026 13:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sSWYnWqq";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A49D710E150
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 13:48:20 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2c98928e4bfso173164eec.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 06:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775224100; cv=none;
 d=google.com; s=arc-20240605;
 b=fnnwgOH3ooNn0w5WFu6HBLEBdbJszmIOkZD+jF0tkXHacerYekvonyN7w/2/vBAeBB
 NCsWf1Ew8YxtCyS8RiAPyv+q56GoI5K6wuK6kAO+FzvHqw1KxzHgctmbF94axfK59vvN
 9BPz95iC4t1ciSioNHNMjM90WFOXtREzJ0aC8M41ygCVnSLO2CiLjYy5dNK+Jh3jC/wR
 RFQDR5WXZvRrfxr3sPfK0Qck/dBp4+DIP4NCe/DXnxFqDeI3T2CMjlfExo9PCd8xwxoZ
 C1N4Db1dLyITe3TQSBY1O79BxQTlTsARK1djyOjkcCOSxjWOzUqnbqXTJzI+t/AmDHRK
 YjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/6n3KCej5MQV9Bk01yyr59P1O7+vxsy+mzauqkV/VeI=;
 fh=J35rz89OdyW0DtO/GHMkBaBkARKgB5+fiaHQkBYtIlY=;
 b=gCNVtFrSYPT8+PhQvI8sUmjSmn7wuaOUyhUvUDf2In4sUIIpnoMsCWFjo4/ca+vk2y
 JFYoedFO0LO7UE5h+IGKQwLyzqcKN7FQ7hw/ojHGMnkxOg+PAj/5t9v1SAEREeVH7R0z
 iJ6Yg0OvY2szBFKRTvcS9bCFqbM9xVglqyY9g+tekBu/v0dSp0NyqyTM13WF2n5EcYpH
 7MSE7q+O2t6mJ7l4NFpIBJSJY1sTuNcbnECDcG0m7BK4qoOIyKng58jLpjmkmQRZdita
 HxDjmRlZZlux+lQEWnRokizNk4P30Vysb7dCPm4hr4xrU7gXoVljJIkiXydcF9wdtFMp
 WN3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775224100; x=1775828900; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6n3KCej5MQV9Bk01yyr59P1O7+vxsy+mzauqkV/VeI=;
 b=sSWYnWqqPr8aDGIUft5FmACNTvoAoN0k064N5xGvYa8CEcj3huJm02+lR+l/9OF+85
 piyIl4AvQBI8i0HP7fQWVOVCTzgBLFDG4A002ju0WaIuQcg/FpeS90NMUsU8NAlzPyug
 LNSyrdLifV0LVWJ5vzkcx2qfFbjiNO7ujOKTBahvcFAYeBQuMNSoZCVRl3mgFOCZyqWN
 JcQXGFyX6GufFJV/w1VuFAkUzpWiLCuM/vy6WM1fd2OvnZl0bGSrhgC1Qh49vYoY0UYB
 9xiCY/WNz7epw1IYYu8fhQamTVodHaEYHmzPEQUM9xawbXbFtnG09tnn7pVier2L5WVG
 icXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775224100; x=1775828900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/6n3KCej5MQV9Bk01yyr59P1O7+vxsy+mzauqkV/VeI=;
 b=Eo1UB7yAGKqV0cJTvM2WzY8Ubqmm6/ogsz1Sw0vxhDXkLPyB8OLXrUoQigHN5ceSOU
 ykT4Kqx6Gw9QiaQy1zwzjP+eYSfdGrXjj1xux3sKdPkbay272tsl9xIODCBHMT7E1Exa
 lKQN5Qf15oj4IfDw66pR1mGKweSEFq7K9fTrrL3BniFDUmFQy9SHVdIWDwJTCVt1qK+T
 PDRkT1wDJoySnPaLjDNIhXMXw1LGnasncP1hfZ5xaM25iqPoyzn6Viqv602W0CJmlMXH
 J9waTXSj5GSzgvNG/ur8pyracSgRWq6rIgjYMWJm5hgaTzKqKj0oekmrPLIuODCSYcr1
 NUyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhcX8SRyNSJfLRGaPYtZNpUCQx1kkxfQlaSCCxLvmalkWkd7zLMV/JE7Q1sd9M0P5PMMVmuVJovWY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3OzL3g8JTAF9TcA0yd5Vtn9rdEjEWgkpU1Y8DCnOog8XMwyVp
 EtCLxO9T6uya1CE2wUuz08OdLKBwMm4xNhpcSg4zYTUImudWm6lUS58usawg6L4Nd7Gehf+/L3A
 sbYpzYkWoF8xYB+CScw/Jmv/rM0Qd6Q5Lokn4NIg=
X-Gm-Gg: AeBDietNhrQrXtmzewc5AoK+PwbyBuVC9VTiaoS6LK04ld/QsdBxx4oeabQH5vH/zY8
 BvJTZyydOQK+veJfX5xrGjeldw5wMw8PkYfGd1fKSWen2prTx+8mCYKRIzEXb5FuRgefNCfEeyR
 MBZr6iuImS5LYSWGUuDn8g4p4YiOfnogfPYXv292VUqoEVjsqtVfR6JAz2l+nfQctonLG0mJsVg
 BdKaU4cSNZa8infiFSXem2sxduEBrq6RslhUhUeS8tBhEB7Zw8cOqkOpW8oRgPAogurC2ktI2Em
 mhXCaazr3c4Ls0zjvXu/Nb0n+Oepa+Qj5ITReyUajlE89zLI140zxoDZ3tb0GZ6KkfB7J5qidCq
 TuQQLxdzN3XST/fzvXUCx9aMck/9RDVe31w==
X-Received: by 2002:a05:7300:e8a7:b0:2cb:de38:c76f with SMTP id
 5a478bee46e88-2cbfc16ec47mr691086eec.6.1775224099687; Fri, 03 Apr 2026
 06:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <ac_Byw5cYys_lJ1a@sirena.org.uk>
In-Reply-To: <ac_Byw5cYys_lJ1a@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Apr 2026 15:48:06 +0200
X-Gm-Features: AQROBzAgNLu3FVO2WbjFWnkQK_cV6Im7CR9MS8OnCMhCDor77Fm_bOLi5ArJBwQ
Message-ID: <CANiq72kj+NdJoEzoZHXs4B=y1eUFSmQwkYmNBuWjqQFg3pwfhA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm tree with the rust tree
To: Mark Brown <broonie@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>, 
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>
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

On Fri, Apr 3, 2026 at 3:34=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> I fixed it up (see below) and can carry the fix as necessary. This

Looks good, and I will build the tag later, but Cc'ing Daniel as well
so that he is aware.

Thanks!

Cheers,
Miguel
