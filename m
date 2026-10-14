Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C21CCC6B2A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C965F10FCF1;
	Wed, 14 Oct 2026 11:29:14 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F27610FCF5
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:29:08 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-35159e0092aso446339eec.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791977348; cv=none;
 d=google.com; s=arc-20260327;
 b=cq+6SbxUQ35cVZCOz6Q78cG+Fh2mjv2tg7e5GAsB1beGXWPsy5BWb/wHfHFlLTzv+R
 tpehwc/0Kkd2rsshJ9HnU0ZRSVpSp5sHoUIpSYKJw1K4Ed8H9MPOK0wtIovyf407U7kd
 JolDyjwVygZdyCPVYEyBOiZgoK0gpmyQbQAH+SWOtkOMkOQEh1w9XxRKrVi6oAljYwzO
 ZePA9QZ1ytdYqyRSj2ItVVteVrrGsv4S+I9/fZgdEBPrTJCivlkX0Dh6pE0pdbmRvO3N
 aEhtomIooye/KWdRM+tBr2oFh4plpHWgjMFrEiupnSh0NXIqAuWj8jdPfbUfjZTdcD4S
 DH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
 fh=ztaWjVTrg3+XeGL/ETd2qrCXjq0FK3Uh2uYQk5dftVM=;
 b=f5DklvBiqypV65ZjqM0+KSbV87mHph4X8Fhy2EGyoRQp22Za2/lOGZ+AuE4F7xljTz
 Wdw0N6lpNP1ZgWahD0jZWubyBLa/946z2NJ0XgnSkjnLK3lHNQ/WJj62h9D+cNIPjKEI
 hOfjfirdLr9PMxLHJ1/wU8UBzBxKJYFIeqSelkRvHc5NWZNvP/LscepO6AuM6WOepZK+
 4Jl/akJj0r08xnOnxH+KpPiK8y12GaXYSg4NiaDDfRvDoC1U5Jn//gPR8nYpiV1+bWXS
 /sAEOe13EZuu/BWOUWX952cM37WT+aBxATNw8+wX5GY7FpfBrgfS6Hx5gNFH/bd+a2/j
 t/WA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791977348; x=1792582148; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
 b=XkdFS9nKuMkap6AwWaSj38bobcTfI5jJw6mfcf2Alpnr+uVPQiPhOYV6sJog+k119v
 SGxnjaFREuoIo+j4k/HADeMK+1JkIeUKrnBYp5HictQ0BsJbobjfhbO7cryCpGHfnmoZ
 kxRiOzEq65HQxYb9DAyKaVKNgozmq05xB8ULTJsLD/lrTnVKZqik+JnJ/SFrLslzCqOw
 G5uCzEc38MXNlFD6cdsygVH1WKb95FjD69PSZahT/5ePhwiad243JH3BFrhCa27/0l2S
 tZjvuNtE8HhL1sax7IZTdxWVMSjVyrBCYTwSWbKEXrCfNCDy1DFIUwlncvg2lsFTGMms
 uUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791977348; x=1792582148;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
 b=KtVQT+uelhMy+XQkWCu4N/C0bQoQRhPyCvlM3ILR53rfXpAqtg6oK8Q+V1HuZB+VxI
 KvU9o97PP1Q2qjSjjgzWbJOb5lTVQI9WXhexQDv2ONziwRgJ5nEEU2RdjoQUAMfDgcSM
 t7TI1W32hSX08J5nsFhzc6LDHjugA2aTeBkIQsN50//lLUWrgVJa8A1ZIdcxhh8vkGFK
 DVMQ4AX4QnHWs7dFsbKVJaLuGHgg0KhUKxaQRrSQCKYIfY+Apf347ttV1L8ZAZoRFdCb
 t+hA7qu0TKFbsLQ5xeGjmyb5FfYl2AsCY5PBbQ9t6+5oangZH2Wkt64oxYGEolqjxsT4
 lSQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0L+47et3ygO7J6CIPG35WjtygRhcMDkUISxQnf8tE7TznmAdCAVpkT6wg8Npm87a4MuMkBWthwOM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ0Tp6jdah9V77V7xsa4Ebw24/uh+xmURANogR/yY1YqXTCNE5w
 4jgsrZpKeJZ0o8rcciwyPuDjQzZMEKglsxpbAPgadCYuQP/o3bL+Ttow49kbRTBuZGGyZQvBTRl
 pxXK13YIj223m+tR8TCjWQE9lIZq6eY8=
X-Gm-Gg: AYBFou0e28fDE8ftFoSY3HX178V1EZ0vu5LUyDJjP5u8xQroVIw6I8PEtA5cGdgl3BN
 C8QS7hyMcdmgyT1MuJfOHAccffZfUsGp/5CUvgpY8BQxP6NqR2U++UP3mBSNWaV/nEx0YoChbeP
 XmRgmgdW49OPyk9q1eTpb87TbBjyw6PNYWZOin6DfKsGNqalCxAd4ScFc6LoEQvMQbc0iUZjttM
 5T9Tg/H5CqO5fVxhiuFUqPNvP0gSk/9xtJi0EPH1k26UP8p/fkq5Zl+/sTVNLEUlWSa74aBL82Q
 7TmAotkN4z7G0IpV3E3XH3kAEgu5tXEYCmKc62Q8ETxBuqKHshJST/nNII72XAqVlq4Wjq+7oaE
 4hKs4BMti8CXcj2xoi8U67DxjYbfreZ4rrq2uSO2ZonKeTPBWnghss8SR6wm6hAEul0RXal+4be
 3dH8HtIvTX7qS82Li79oJ0hIuJSUBglqaHSGuHE+AHW97yS9AJ54E=
X-Received: by 2002:a05:693c:6215:b0:35b:cb8a:8ce7 with SMTP id
 5a478bee46e88-35bcb8a919dmr14326600eec.1.1791977347656; Wed, 14 Oct 2026
 04:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-2-irogers@google.com>
In-Reply-To: <20261013223946.1836757-2-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 13:28:55 +0200
X-Gm-Features: AclHuK8qVHO7HVQy6LgzcUgjYcQf3EimC6SJcN58PVqcWVdOf6T45eXZNeTLsEY
Message-ID: <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add
 __require_explicit_initialization macro
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
 Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, 
 Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 driver-core@lists.linux.dev, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> +/*
> + * Optional: not supported by gcc
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#require-ex=
plicit-initialization
> + */
> +#if __has_attribute(__require_explicit_initialization__)
> +# define __require_explicit_initialization __attribute__((__require_expl=
icit_initialization__))
> +#else
> +# define __require_explicit_initialization
> +#endif

The LPC slides mention Clang 14+, but from a quick test in Compiler
Explorer and a `git log --grep` on the LLVM repository to confirm, it
seems the attribute was introduced in Clang 20+, no?

If that is correct, then it is not available in all LLVM versions we
support (LLVM 17+), so we should add:

     * Optional: only supported since clang >=3D 20.0

With that:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
