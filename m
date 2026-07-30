Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C09C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B7010E65A;
	Thu, 30 Jul 2026 09:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ktK+3ksr";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB8C10E65A
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:11:49 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c12614b81c9so338934966b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 02:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785402708; cv=none;
 d=google.com; s=arc-20260327;
 b=eH0thu4AB9ReKTrxeLZF2vtzh4dYwh8i+ix8hIE9RZhqVbRhlnG6q11r4N1owB9505
 c9Y6DTt7D8Bzc4pmCMRXAKtzxOpBdRymBX3UFIwjDbE/r5efdt5zskoKOVnS1mM1A630
 Eu2DumwyQEpBFad+z9nEstmwHQw+UWJAU2jBUP6x1kSpi1ufElo/ZIvW2UtE4XWplqjv
 KJU91rVUDltyyHWycelFftA0DTDHMT//IgRtV+HIZX8VSkMl0fr9aW4rWecG1Erssu0k
 qGj5vR3aBLKJKDlrk+dFutHbBdNOqb4TMbNVdQ+zcz8IYZL76NQFG0lc3Oq0sYRBqA1v
 PNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rNT8uuAYIOIz9by9aY3qoAX6TR1FHkQuOah2tZDQCkE=;
 fh=/A5RriDYcC3Mw1zmKfhBOoaWLjj1gWPJRVkGXffsCVE=;
 b=hrzDkZCtYXUYLrwu3/pu9EAm2ZW/rIzhbk+99mw9ukZMkqm+Gk2IMKCrXTj3Q1QRZP
 L0QPRmxT4kUMjVg4eFLldJmPji1mhd/4KMLkkvzTRXYma+1LVQAvGGQFIFZMcCNcgccO
 ZGCUkbnuw2ngdTLy47sCoUvAS+97gcy5gYSw748gqGbel6Zn5IdxSwUreEk7EXf8NeF/
 6NgQT8R7ymYFfBvZEu4fOEU8u/AOSlPKPz8XyAyL85LHYsKWshxn0l91C34FRv0vXN8W
 tOiL7NZS8Lc9WNVxyQNPLR6XhKWVzXEIxELqMSeCsvBuKofPfm7jm4NKXECE0gQPM2qU
 xgDw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785402708; x=1786007508; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rNT8uuAYIOIz9by9aY3qoAX6TR1FHkQuOah2tZDQCkE=;
 b=ktK+3ksrc+k3DaxD6JBspLu3Rce9xduYsucoktQrQ79mljytJvMRqMIfWgKWFJsPLR
 Yail5f1/Q51io+66A/Oym7OOLrXcyXmxMP9m9/PgOnryr293B+zk3OmbaX5Z8klDux1h
 B8VGutHvUmRW8pO7uW+f7LWcD1FRxqA1y5WlSLqsLbiOcXEWZJ1qscL8U4kXLvP4h87I
 vWFF9PufYwi9ZorxPF3L3ccw8xzIUBIKjOd7pavB4vuEEMBPN53Et5sGLV8BqUrnf5HJ
 vAaacfrCwGYliC5fCTSJkooXsO8C2MKtv67G5sjmKc5omD5nxO1y6vcjgIdMqMj9uNJi
 csag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785402708; x=1786007508;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rNT8uuAYIOIz9by9aY3qoAX6TR1FHkQuOah2tZDQCkE=;
 b=lIDcN//EHyuIzBwufG1VH/TO0Oyo9H+/lG7CFjzXu/p1A55gxwJPEbn9hYG2AiTx+R
 YZOeIwWpSH10Zb2+TwMhUm5omVF1D8k7jGjkClmdfcM1CHegthKl1RIPgjBerB+DqtAv
 JWEpxADl6/JlxpRC3Z8O9XNdkzrutqn6RrY8JjNvDo65HhnwMa+wKtjHcxVOUqRb/s0s
 Eiu7kbrTQFfFiNvzVU+nj5Frz31ksw5jUK6/KA7IHpW8gDNZ3mfFV5a1MR1Y2uZuaR29
 nYG128ZoYaB3Qn0LJXfAl4D/8M3On5v5lYlYzig7t2zzCLVUPqYJ5zG9wFh8mVSthUUl
 O2pA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr27Kvz2lIITF9/090VTInyfeiL5Ei/9xcCjKhqSA2F6DHq+TvLzi78iHqGuo77Z2v6oBBOxkIbbww=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAAtSDklbo9s3OpaMGyI5JuYbQCU55UMYZJItkl7SL9L2oAooV
 xcZ7ZOcLgzRCaG2Q6zXjJSuQl/RiGTTnEvuCPt4GVGNg1LAXxTmV3fWrWWXMQSUOGlZH0vm9z6G
 N1S6j8SUiJ+kVB2LWaRZuywhxkflyo8Y=
X-Gm-Gg: AR+sD11WlCldLqKZXevd3IHC2xISMDgEOu612R6G9EZ4BA3k9Md6CtkcpUp+h5+6V4A
 OoedKb7AEByaibIwHfMBnKmrLuK07X39+DwM6j/xMerk90txHKEVdMYY06/ISGSrZjnQNcZDtVd
 IgV4F8QRpSyXANo4BHNOQltmHna6ubOBjwl21trmxkG6IZMiGeAdT9tLWvVBUDPhUHVsCpM7dpR
 WQ0Yrpea345k1Xk+ighIH9PT/JnQObR/Gj2luPtbqPh8RP6/S2BVpixLYtL7DUXRQlkdb+xiwlO
 3w3KxrZlO0f3kfppKxNFT4fzfp6p9lJXJkn4gweCxj1OjJ2IybUCAkro8RROYpFAaoOGbq1bwaZ
 CWwX14g0gaeIKsL0GxMc5qm1Hi8GZvGhH3uE9ptWnY+d8AqZPv+J4ipH9dhwEN7soJDKyiIC1ug
 hiCL/lnSXQogL4JRqA/w3sOAMRZYogAHUyk0KVmy5QZmYQkjKhSWi9eadUIRFvaNw=
X-Received: by 2002:a17:907:3ea0:b0:c12:631c:67c6 with SMTP id
 a640c23a62f3a-c1fa554de59mr85960866b.1.1785402707552; Thu, 30 Jul 2026
 02:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260729-upd161704-typo-v3-v1-1-69c962e35d59.ref@yahoo.pl>
 <20260729-upd161704-typo-v3-v1-1-69c962e35d59@yahoo.pl>
In-Reply-To: <20260729-upd161704-typo-v3-v1-1-69c962e35d59@yahoo.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 30 Jul 2026 12:11:11 +0300
X-Gm-Features: AUfX_mzEOHyV3oJOY8-a69g92QJquL9A0mM8T77huwsnnp9py7IaA1ToOIFpAFg
Message-ID: <CAHp75VeHW7bB+0fSqO3fX=Wkb-216cdLfmd2W8dYD7Q2_hx1eA@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix typo in fb_upd161704.c comment
To: Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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

On Wed, Jul 29, 2026 at 1:49=E2=80=AFPM Tomasz Unger <tomasz.unger@yahoo.pl=
> wrote:
>
> Fix 'cencter' typo to 'center' in a register setting comment.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
