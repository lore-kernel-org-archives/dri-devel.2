Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77133CD6E4C
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DB7112F74;
	Mon,  1 Jun 2026 08:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TNoXbwRv";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18B2112F74
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 08:25:48 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-bebc80100efso149184966b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 01:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780302347; cv=none;
 d=google.com; s=arc-20240605;
 b=lH5trUviU/o/ZpIphaUTz9QmFIgwec4pF3Y6XLLAWirhY5kdobH5x3qxUCE+ePvhct
 B6fQgmd8uW72GIGiZLFrw+POsa7aIY6zE9tPLbugpxt9AGYCAdsXypOWLFVedeOvFh3f
 soAp8KXytS8ENh4VKsjwDRn+kpVqz8hw5gap3wcPLYKrB+9MuC5whfI6eLlbVAgV3lnP
 AIa7FCYliSUXqZG0txjpcrUcDBROgHMHdrVdCUy92QawF7e31XOn04o34CkpbFrLbQ6Y
 a1mz1e+XS4ZkreojEzRbiv6v2SNHqu/Y/Nc6F9VxZVjLMoCVOc02ZmDECLMQ/lu9QdbU
 m75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sLmU3apQyYy1PimvVG7oezFtVWtKWxxDaqeRDTtr870=;
 fh=7Uqarj9dqgFVqQi7CGo31mMzN7IXM2G3JiML8WPi4dk=;
 b=Z5HOxYp5kfo3ISV7EdWr2rZNnfFBz8FWZKN6Lte0FMnq3JZt71PKF7roVzh4vpBhb+
 qcE1lbs11iyvIW5wvz3RF9BcbHAK0bwJquwpvq5dvKsXGEBC+sfYHPs6smRU2wuFEXDE
 1lVgorqrdyT0SrKshXg3wNquZpuK6JzJtSZug0t8Q50qcm2+txTjsgWYRclWUvmPAXqC
 6/aTmDmjgKQwBJiUbdddTjpGbmNkTanDoUZZ2Yao2rSYlQ8aHi1JLnxI7U7cUZMkNZyB
 ZZEaM7sFp8DunLSXwsU+M5vbLxFT1PaPzvvyWcoqyACnWu8larRCQ2V8bW/YyXXGiMSs
 TSLA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780302347; x=1780907147; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLmU3apQyYy1PimvVG7oezFtVWtKWxxDaqeRDTtr870=;
 b=TNoXbwRvJESMAvY7C6FjeIv04+uB+XnkyuSFs1XlIIoyDivECXT2Dzd9ewYO+41adz
 JUDLOs5dSovabc+J1V0HM9+tNw1CDwrNRACqTRumjpSwZc2UUatgTmZxP0G2v1fUbFN6
 Ntw3ry0o4+a+vyHM92S6UwKBt4hmSxauF4FrLISucj70zQHqz/Gk+Hwgq9mn7J5oXc0m
 kbkJnUkmXEx/hUsfsKcOoz+iWnhtnOKUG+jyTqfQfvbn96TmY5lJ4aD/TKhe4pPT4qpo
 adzB5U0ZCHb3moaz7IrzEHzAZl98SukStZK60dLwv5HlSZYD6y5DxIqOcghAUOOW8cnU
 hVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780302347; x=1780907147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sLmU3apQyYy1PimvVG7oezFtVWtKWxxDaqeRDTtr870=;
 b=giNJQtL7dpZ+M5lppOmn0D5Mhnm9iDEi2hDWozrpvhTBcUjETQk2tWYiZAWb5jifvE
 0bV14W+8gUNtBE57fjS37sGnMaHyo0teByB2WmlgslRQTkdG08yWEFy0U5kNjUeKUhjW
 /5vmabixPVhl0tdLNWvGmT+LdgCoYmGYBgBgLCNRVKCvl0OQzzB+JK0OvGW0a25nm9+d
 D9g63KVZ0CUc4Ut+qfiaeba5emMFh0ncek2jQlx9lV/uXtuXZzXhIntphIn7MEN59YvD
 YBXh1xawIYJTqXl00ONW4YLrqFeq6+9w3YNRP0rtOhnn7Nt9zQRcP+bk0mWnatbSVXCX
 MPkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Davw+T6yMkpdlhrSmKSqk6g6S/QhctvGvovAkZtqDkD5ize4zTLPtMQMC+sl6uL8JRbisfnyhw48=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkLoxJ+nAkDPsCr/7kPWqke1zkF4UtP2FHnTo2AKi2+kz9Bzrx
 /xkyB33vjO0OGjEfuw+o2KLMM3xP0Gw90ctnfNBW5J4nz34BGlS3zpSYV6Yl5i2RPVJZGd5s4D1
 Vx3V6np7hG9xrvHHB9yMDSQf4KIoC/QvSulXq68Q=
X-Gm-Gg: Acq92OH4rZPu6M8mNVfEyNba1LBhk4z8NvquGc7A6MJEJUhmJ3MNcSS8pK/zXn/HLbb
 kI8u4EQOpn3N02xmuoCQMDNLHdNjB8hU1Gn0/D+wNFo6DVTkzDMdbtnuUjfEL4sN5udkV2xePYc
 gXl0qk5NJRfbFB2+bkQPN4/UbUB3iwkSAaXAgHExALUk14lfh8Souf0oSnGMDBO5iUwfIX36FoC
 ED5hInWkthvk/P3edpYjTlgYqKMPKzoZxRCYxv4O4qZVMXmBat0zs6qsLkGrE7Un0xL2R9/arM/
 G/jkbvOPt+IPpfjF3Xgexd/WekuIR4gsnXs70PAxpjVG/fFSFs/zCs+XfmWAKNi4OLfXEzRtdJF
 s7deGtXdzY/ULya261zDC/JRtd2a3W/HASkKGc3bATmEQfZZrXrkOIdiu+3uBU7hJN3gOVsAXUb
 di/Ns=
X-Received: by 2002:a17:907:1dea:b0:bee:323d:1239 with SMTP id
 a640c23a62f3a-bee323d1a79mr47098966b.38.1780302346810; Mon, 01 Jun 2026
 01:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAOSULec2OpwTGB3OUb_n3CdKO6H_DGJnxw=qsBswbd+JBjemKA@mail.gmail.com>
In-Reply-To: <CAOSULec2OpwTGB3OUb_n3CdKO6H_DGJnxw=qsBswbd+JBjemKA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Jun 2026 11:25:09 +0300
X-Gm-Features: AVHnY4ISm8xxaxYs2i3jMM2LEcmjqM5kfzxGqhgIogRKxnB6Q3gXYQUiYHQb_g0
Message-ID: <CAHp75Vc15t7zmNGeuNG_fLHwCN=Ym9w5Cn92+eqbtsioGxFzCQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: replace sprintf with snprintf
To: Enchanted Hunter <enchantedredhunter@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, andy@kernel.org,
 dri-devel@lists.freedesktop.org
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

On Mon, Jun 1, 2026 at 3:44=E2=80=AFAM Enchanted Hunter
<enchantedredhunter@gmail.com> wrote:
>
> This patch replaces unsafe sprintf calls with snprintf in
> fbtft_register_framebuffer() to prevent potential buffer overflow.
>
> Signed-off-by: rat1bor <enchantedredhunter@gmail.com>

Does this change address any compiler warning or something like that?
At a glance I do not see any usefulness of this patch except an
unneeded churn.

--=20
With Best Regards,
Andy Shevchenko
