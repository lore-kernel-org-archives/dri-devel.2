Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2FEC55171
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 08:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504D310E3F1;
	Sun,  2 Aug 2026 08:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k9a+ntZY";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFA310E32D
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 08:43:13 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c9b3f380006so293933a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 01:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785660193; cv=none;
 d=google.com; s=arc-20260327;
 b=ejuC+4fDzqcEVrV0ahtqsT1VaxjxoJRKa/cbtMiUYA58wixFH9BM3XNUYSEZWzcZJg
 rGJG2G3/+4xks7GtXP8ikInwQ0wODRijFViZajPHWHnr0QkLNovOeRW1kGR64TWC+mDz
 sIP66jBJkaeG+bwxOIoBEKBhi5LZYdEf2SIaRh0YDxRZOexUc94I6hNgfDwc38Rkqw5F
 4O3D5A6BerRXrknJRBZ1x8iiblpDmQdlDVOJqzzBW8FYiyj70f2nxkrvaoAp0nfcC9KV
 pRHoo3Z9cn5pDCDXgedO3LHnM5gsIQi4xB+bQugSl+gosFv0A8LcaucWT9VE3+X5z2h0
 dLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Tm0k65FNbDrdx1vgSHrRVtMQQzAt2fySrdQkOW+gZyU=;
 fh=IxZDlefd8TvIdZL87sq9DP+q1RPMnvUE4l4B2knIROc=;
 b=CAaMNZQRjKlBuF0UmsIAaDByLmEd4JUF3E6ucW3PElVkfkQX1i71gim3h9lJtwiIEp
 PkldMm/sPeaJOrmvCYLS6Wm5q9vwKt6t2xan453qRbn3GQGm0+qWU0iPd8VnW0QYp1V7
 /EwF5GKpopc5E81Fj9tAGQ/O/FPCwl8pYCXEVF/HsdlOSFM95n9amCpSoMlII/U9b9K2
 FrfR9M25Bmzc1yHGhxG4hZTRddmhNJiwIPCyLx4ID6BQDW0jDanopoc68Gus70F2QkWw
 3SzES4ktc9yEFUDrPiO257eM+DKbYFVlg0RPRlfjlMDy8zdrQmfucP23o/TbwV2Dm9Im
 clmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785660193; x=1786264993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tm0k65FNbDrdx1vgSHrRVtMQQzAt2fySrdQkOW+gZyU=;
 b=k9a+ntZY79gtbOf8XZaZnlBd4ZYfDl0PYwbqfZKO1pnpbU0MfWyDM8hNDXlLQn8hXq
 WBzG42ayxWojFgj6qslPH1zx5vk4JGXNZBmHaVLMUhww2MkM65C9RnQNBT/LxhE5Mbp3
 5c+QNmP41YI1qV1oSQCNR27HmNCKAej9+DwvhiOdWfzENSVzCBLzi090C2F8W6zjKhoc
 ZE4kqVINvfxgHOeX5MZySBLl6DZCOXc/JilCR1AgmCOYpFJUH00yct8SeNG0Gv1TzjUw
 oU8jujfZOJEuIF8pwGn7PNrlfu/A7Z5QxUkg5uHtoaEgf6zi6lWyrESB5H/UJrfsO2YX
 dhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785660193; x=1786264993;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tm0k65FNbDrdx1vgSHrRVtMQQzAt2fySrdQkOW+gZyU=;
 b=ZHphHUDUviahjH6OQuTTLcEAvaMm/8HbrSUU7ISrCvBD0yA9N66DYsdK8qYq+ARzbL
 1iPVftTZTgd7OCASfgjW4eYvw2Gsgnz3NaxDbBV4S6UqhNlnkNTW0SFFPjsihRm6rahh
 +oBEyX8jgOafhbgh0M/svm1nE9KpNimEqmWxsAPYut5uyxhaAXp+n/kEpyKxDqgZovIA
 ZMvn0jHPQKCjaK7NitKff32xEok0nYxx0eAoDBg0Y9Xz/IsPLhCFEtU/t1UVz7izamWq
 iW5UD6uDw/bz2i/paKAqlsPeGFVYYPhMF7Z1ibuct6l32cmRl+jv9rBHFcv3o3P8JRNj
 EAWg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2YQ3iz4Ofyyr2fFaIXN4ZB9UTAwMXbMZGD8uVcAPyh/w9FyDqdFfu9/wmX/ygUFImuyLSYOM/iQE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzW3otcbFjicLW37GG45kVpJ9y2r3LQ43KMzJwM8XiwkZda4fTl
 kt3DF2xC7MyvIBYB1Bw6ZqRS3ZGjvgADVzWcIa6cCO3gvd12u9yGn1o5Tb1iOQTOF7Gyoltu/9P
 iNQQ430TsVqXIHThavXHywYAwBwNTgag=
X-Gm-Gg: AR+sD11TeP3uOSW1p9peXjY/UW+vE8Hn/uy+5LKNC4sfsl8hQY+jdemYgEFOjgWnZ9w
 i/PWcGac7HEjZziNY/YXoYJO3up+e9PqAj9lEHLnXsCDPeYdLiYjqh3w+asBNf1kv+4qIe/Slqh
 ITfrgk/0XZBPwQmV3EqYG9hujXaWjedJjstuXWLaAS+LGlZU7ibKIsueDPL0ENynwpWyUxDtro8
 QlXJC1t2GW05wvec4Fx+I7M+kw5arcq03sBXIYA8jB1SG31RqYP2DOW9fBYhrnnEk+uYiuJAgoO
 wlzuXrs1aAVJUeAtX9vOQ5BWfWdSghMHqchqAskn/Y8EImYGBe6NyF/k4fm3ziPS4Y+DAyYDEqa
 ZhBax/t/YdiO2s58Zv0TWjzm/5zR+K3/BISsjJ9TgIBFuQoH429qIdZn18pk+
X-Received: by 2002:a17:903:1450:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2d05246fbb8mr88691875ad.2.1785660192824; Sun, 02 Aug 2026
 01:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260730181717.95457-1-ojeda@kernel.org>
 <20260801154223.stable-0006@kernel.org>
In-Reply-To: <20260801154223.stable-0006@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 2 Aug 2026 10:42:59 +0200
X-Gm-Features: AUfX_mwSyBPjd02vvZ_CgqaO3HBOLCgHpt8D6b_pNGvF6OI_s99b49Kz6LgVuPc
Message-ID: <CANiq72kS0Ym1r5oEYcbhUDXcZ910YERpV8m3o06ebtXay52iWQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/675] 6.18.42-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, achill@achill.org, akpm@linux-foundation.org, 
 broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com, 
 hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
 linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org, 
 patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, 
 sr@sladewatkins.com, stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
 torvalds@linux-foundation.org, Miguel Ojeda <ojeda@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
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

On Sun, Aug 2, 2026 at 12:13=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> No, that was not intentional - part one got squashed into the part two
> backport by mistake on my end, which is also why the `lib` removal has
> no commit of its own to point at.
>
> I can revert and re-do if there's interest in that?

I guess it depends if there is some advantage/clarity by doing so for
the future for you, or maintainers, or people using the stable patches
etc. -- for me it is fine either way :)

i.e. I mostly mentioned it because it seemed odd and other issues
could be hiding, e.g. maybe a backporting script somewhere had a bug.

Cheers,
Miguel
