Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C36E606A333
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CKyI5s3H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E92310E103;
	Mon,  2 Nov 2026 20:45:24 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A1810E103
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 20:45:18 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c4ceaee6770so76044566b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 12:45:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793652317; cv=none;
 d=google.com; s=arc-20260327;
 b=ojP6QCMg7lN+lrFIKQhFBDRMtQ4anutQn4aYEVO50HzqlMDtwXxilMY5eXQp7FXNW5
 UEBXeDi+4AGQSBBbZsRJ70UA6zE1ux9iVjTrFVW5bloNxVTSoYOH/EtNngrjGsTOWez2
 3s6B4uocwzt/+uUKLpwhDmth+y0BU6/RX+cW+i8t2QPIImxBPAdiCsDV8tLWXZOyxyWy
 /AWNQZ8xG2yfn+Hm5ounVHIvkbrRzV1QR0ctibOpEZ0BxyFLzVzRU+/9Fm9xm0oL0ilC
 5mKav4RsDD/dCv+vXnpIBTfVBVC8x3KqR2VYdFxeOZPbv4Gcxp/M7iRTWlnI1PEEQ/yE
 zRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9+4MG/RP98VFJErdCyXbOsA7c3c0RHEevq093WDWxVA=;
 fh=jt/5cKCK5n/VJRUCqElAWsx5zDABhwqdvdjIRKWuemA=;
 b=DqE6VtlTj6vhNwdRAQEMjj8oESXJNErGRjVreAin+K3SdiKl0ZsKi2cjux8HYlZK4Z
 hRns/N5rBEJeEerX8CXaWtjFPI65oVf2dZpVXC+5EfYUES3vbKOLUxXdbQ1mVI+lRTdK
 +ZAI9aA4Xt+xNXVZMS4Y4kN6sbrB7LPu5wUCgN6yjWsNtc7Qb1hiAOgJME6hC1oW7V74
 XYv8h0zY9KlFU52DmS6+ClC57zuoVgRrPlhkuhAyuOcRVq1qPNhMA/NO0thlgbJ6avC4
 O+ZW8mFFpaHtc8be/wE/eAqAAval9p1o+N4dLqpCwTfEaQzfJj5u9PjujDYyZiNgS2dV
 yvkg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793652317; x=1794257117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9+4MG/RP98VFJErdCyXbOsA7c3c0RHEevq093WDWxVA=;
 b=CKyI5s3HDtbGGBirXaxZFdWfqSawzFWvQaNbnPMUnOQEcBOJtmw5GGG3g1PUTJdGKj
 6JsT6tQtqLsIA2xqtl5f06hU+QZqGi9T/+l9zufpLN24vTJILEMvGzMno+u5eUxqS1nK
 eWmZRj9H/MQdIrQWA+Qri5FC6rvyGLjpRl6nFDxb+K7B2pSpZQHd4wt8msZIGMKoQKSB
 i2iN2op1eV71sYZ3ieqjvy+DhYKr6O4uMouQr9xlda64NqoACtoAp559smH1yl0rVi1w
 zsSXmD+XNAmD9iTfITIRT7ELJtfRtcikEgJTaXcqCDTfkUaKwZz5mcpa3TpZSZqgJoUH
 jldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793652317; x=1794257117;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9+4MG/RP98VFJErdCyXbOsA7c3c0RHEevq093WDWxVA=;
 b=VSctjk3GpZoBSK11i40lCADliOBHiVHUanvo9OEuxGKz4O5SSZi6kKX1PiOuPuWkhg
 wqSo046F6sKkT/WIYziv01PMd+zUZ53q5G11h9u+W3rSK90xdi/HwqO3qClKCYW4x11e
 s3bdqDB46yjajnZZhVfMK0AVwAy1kwwNYx9pT8mn8WDa03kxdW4aqkjruiuBcXl59MDp
 jbjtoYMTNxKlDxOYAKL3yDDhVHCf+5vt5OK83SbY/C/nbif2qVnFFKpFxyWPhwXXyGra
 cJvsyrxHrY7SfZ3bLsjQm2OGWmgbMO2RH7r+Js0BQqTnuq9Z89WMl3amI1lMDARkOplz
 YDAw==
X-Forwarded-Encrypted: i=1;
 AKwUvByXhyjhnLJhdP92efyp5WvhqFQETUExC62ZMxPVuKaDNN2Vx3BbunyAEkh8bCe+/wD0VD+Kl5kDbE0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z//o+O3hkj7QY4hoSMtNi3pZC0EVL3zjXm/+hVlEnsWE28Jh9In
 diKT4IIyQhpNaA5DjrtmqINcJ3srn7l6L01INrEAKVYJEfFTxF7kXcf7iV+B7l+e7aTvbZM22e5
 DlJ0/ZhO2hVHWvO7FLm10FSYvlnj2tOA=
X-Gm-Gg: AYBFou0MwFs0ljnczfG64riWciDC6XacOnrFymuyBlmM97Ssn6Kgwlx96b2JQyU34Ib
 dpeT5Zp2Xcz1ee1cCgfieUP18yCgxhgfHBCiAmJr1M3i0Zv5oTV6QtzcKHL+onYzykq2IuJ/IxP
 EyZROinw7Di+hzp5HT5JoN6k9MRZtHfKMeJrU1jXycFZwa+DIYk+qIT3xi8ZYwbLoXaACmmyru4
 n7n0VZlqSUBsAnW7ZYm0bOgHkamHi70KWPyv55JfRt6g1dUQHuvzBpjfkuXqqNogk3aLsrIDhfG
 v8ATGrKAdqWVNQaZ/HXExPRzuOaMPs5Lu9ScOOdHajqI6IHJNGXGQGB9XOtlbHdoTAivvew4xxD
 c5/ETRp3MwE6SfhEHMhnJPHv2bW3SQ9f9VnUtcy7DAH+qbPAOvU+oowgUdjBugw+HsyZk1uGDVt
 Nm/fenR5yuEWqZm9YJ8DnYpFuUymVOHNydcNgkT77cX7h4kOyunVTbfDVr3KKK8O/xIsEYMFV+G
 7QIDrroEzqN2S4HRWA47C34Gw==
X-Received: by 2002:a17:907:7291:b0:c36:a4b4:b1ed with SMTP id
 a640c23a62f3a-c4ca7a18e9emr1040945766b.11.1793652316563; Mon, 02 Nov 2026
 12:45:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261031042315.1122699-1-eric.lee0305@gmail.com>
In-Reply-To: <20261031042315.1122699-1-eric.lee0305@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 2 Nov 2026 22:44:40 +0200
X-Gm-Features: AclHuK9vd6HXpTj_GoBsuPuHc9gsfqa_KIPnkW7tQj01sWOMQhU3GUHBUvE2PZg
Message-ID: <CAHp75VcvKkOmFTtJDHuKCNVUMXgjZLiNqmGcHFKT__dtTt_QJg@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix space prohibited before that close
 parenthesis
To: Eric LI <eric.lee0305@gmail.com>
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

On Sat, Oct 31, 2026 at 6:23=E2=80=AFAM Eric LI <eric.lee0305@gmail.com> wr=
ote:
>
> Clean up the following checkpatch error and warning in fbtft-bus.c.
> drivers/staging/fbtft/fbtft-bus.c:14: WARNING: macros should not use a tr=
ailing semicolon
> drivers/staging/fbtft/fbtft-bus.c:65: ERROR: space prohibited before that=
 close parenthesis ')'
> drivers/staging/fbtft/fbtft-bus.c:67: ERROR: space prohibited before that=
 close parenthesis ')'
>
> The reason of that error is the modifier argument is optional to the
> macro define_fbtft_write_reg. So, even if removing the space before close
> parenthesis, another error "space required after that ','" occurs.
>
> In this fix, I change that modifier argument as optional, so that
> it is both ok to use that macro with or without modifier argument.

It's not a fix, it does not fix anything.
Also study the mailing list archive (lore.kernel.org) to see what
happened to the similar patches in the past.

--=20
With Best Regards,
Andy Shevchenko
