Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C6CC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D4710FE7A;
	Wed, 14 Oct 2026 16:44:50 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61AB910FE01
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:44:44 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a1ad2e2391so15719285e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996283; cv=none;
 d=google.com; s=arc-20260327;
 b=CmEfy6TlW9hn2fWtKl5SrhyXyH4GwOjbXs238mf/Gvl8TSL5wozloLSRgCJPAwbIn5
 clCwS1cTx/H3uL5eG++YhBI1ywmZrnDrDKNOEuZqUNjDoB9LuBV8v0GhKCjDZHU7JJwQ
 PfZKeZmyqNMGFhcG1Ol0PHggVLk9QTNwGlJBHkviGeetzB1tG9aStC6YCuirPeqwi6AC
 AyEPlClYAgwKjK45FgjKtGtDQ2oP/fmeSPELiZwE2xR+8wNKPu4yr1DZCQqSz+pVXxAO
 9rxAm6FzN8JLpzTS2KdqZN6qggHhHlT6b4uB818sYSRoCdBxYwy18XJmLSCRHs5pa92R
 GKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
 fh=3PzL/biZR3jiDUsLhzSweetJLht8KVwJfu3YXcWRcl8=;
 b=XzY2BF66ns0qPDthtvfJC9KXSWdwRXQqxUXu3IFfSg6IXrLTyuR33qi+/nWe6z+k6j
 AWQA2s+S6FAE791A1UFUImcEwDmoGBITPKrjRGxiVv2y/pkwUFFvWt+7E0EUbTcLrw5e
 cPiTMyx2IMZ2P2Red8JdDMOB/jN/CpxGLljA5hAIXyB4niS7l/RrWJNIq6mEa9iSGbsh
 RyS41/iJQ6JvSsZrDS1dAIipMNTbcwLBIMfTTIL1o9P9htaJ99ZJhlUvdGp8E91/uzXE
 TLug8aAQM3pv9N6uhn3rQFIRyFymr/oKN5OLfFyQfOdzqgZXi0dtJ7ZPt3fllQbfPFS9
 S9Xg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791996283; x=1792601083;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
 b=ZReJNgdfC/q5Pfj68Q+6y9L6c/Es/fQ8caAJ9Kq5ytloCYUppTXSPFjPHACHbbLzHw
 z/50jN+e5h1Xjkds3yi5snJZk5VnI7bjSSRA2/bEs9AdDSx4yoKUGPiwMwD+IHmDztlI
 Y3Kqk83zyXj54fJlLq1O15uKCCOQgpbwtmP2j+5UQjiiq6saHLOJHxDbB+5VHt3bx6pr
 VIUrJ1pL0qTVnbSecsIq/sVZJnmJW3PRYTjB5CALSbTjyj6tHwnr1OgfCO2qBngVeS+n
 oNKxX4jK3FIx6W00Cn9etpphccOxlReGmPvOz6md0jNAm0G85V10OsUHr4aMW0m/YBbP
 BhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996283; x=1792601083;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
 b=jgzfsfZCF8hLCNHFXBR472DzoklKBmp8ieEUtfLRkiw9PPX3Hq7w8Lpu1wGY46lF8v
 6cFUFcGs/w8FCvPaWG7feAVy7jUyTF7lipMOIDS/+aB9h9IJ/1dbuD35OhJ4jhhWqwdv
 cq/2WzgCsmdpWYotHpT0zzL9mI3ftJ5Nz6vW7NLjWJi/F1OSN7HXO9P+hAUOIfR+FH5u
 dvtbXjsRPjIis5Q610pjOueL3zc5wyl1LQTFz5xNHkrQ0Z8y0uV5Pfhub6rA+2ccrVcl
 +WY37RxPSJXNKeVuvN6ytZzm3+brfPWNXyMHzr3Ff2CiVYSDPP7UmUHiyhHO+T/+wnKQ
 AdTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYsgScmeM8HSiZyZri3WVVnxAd5qiPivVpwEcGs6KdKoA+Y2IALa1gYIRp9ZrTqRbfFlcErssyP0E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL6CnW9vD6n5/tGFGmA+ivUgbS/0ynVRjtzUGycJXoMAicgxq1w
 Vcsc1W9E+rTHyYLJQ1qwEVNHvfxN9CO8oqA+DN9CE6ULvcu4a4hjSclkcPZFteFFYwTjSzXEH6K
 a8KhBJCesYzJESLQWCkkoGjpkO984GarXnDnRr1u4
X-Gm-Gg: AYBFou0wyY9kyz8fXA+3SgzXn3rScrZOWItOEQ9jvG7F68ZoMlsz4yM3lXg6X1fP7PX
 zOqYGFUrJ6iibcyODRmIfWKFNeF0PWiobMOW67PXkp+5fvJaA9MAp36FG0D/Wc3410TP9XOTD8F
 gr08SlB7Jb241s02qfOD3qDKrnO6Gx+wSK9pw3JT9BtXKAj/qcf3/VYcEj2BSWVNpnvPyMFgkp8
 ooxYZlmH9PL9GE0iwswgFw4oYOewfVlwXjsYqfQk4wUyuo0zRGGWaZ/qGq4b3ZKKl5qKJMfi2Qs
 xFgw3rfHqisPmvwxV5Ade/gZ4F6HrMxmPvMwebRdzHjTitB8G56YX48O68R+7a1Um+IMUJ2tVEH
 V831tjUkIkq28v7Wc+w5Q5mPCJaxXfoRpqKxGixTUXQJjKuiv36xKDuYa4XLHw9g+aPcoBKqkX5
 KnEIU14JMkJjMJ1g2D3vwgoGT69e0UPqlvLuL9YdBop8sq62DQUDMN
X-Received: by 2002:a05:600c:354a:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a18e3ef23cmr329192565e9.0.1791996281614; Wed, 14 Oct 2026
 09:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-2-irogers@google.com>
 <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
 <202610140937.B68C8C9AAC@keescook>
In-Reply-To: <202610140937.B68C8C9AAC@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 14 Oct 2026 09:44:29 -0700
X-Gm-Features: AclHuK9LUe2FvddsKjj0vYiArabpm2vrSaqioSsrjl7koqqOn_VyYRh6l-6milM
Message-ID: <CAKwvOdm6nO6skW4-AZtmzpGoNyO126L_AN3Mz2fu23+3QXcshg@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add
 __require_explicit_initialization macro
To: Kees Cook <kees@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Nayna Jain <nayna@linux.ibm.com>, 
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

On Wed, Oct 14, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 01:28:55PM +0200, Miguel Ojeda wrote:
> > On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > +/*
> > > + * Optional: not supported by gcc
> > > + *
> > > + * clang: https://clang.llvm.org/docs/AttributeReference.html#requir=
e-explicit-initialization
> > > + */
> > > +#if __has_attribute(__require_explicit_initialization__)
> > > +# define __require_explicit_initialization __attribute__((__require_=
explicit_initialization__))
> > > +#else
> > > +# define __require_explicit_initialization
> > > +#endif
> >
> > The LPC slides mention Clang 14+, but from a quick test in Compiler
> > Explorer and a `git log --grep` on the LLVM repository to confirm, it
> > seems the attribute was introduced in Clang 20+, no?
> >
> > If that is correct, then it is not available in all LLVM versions we
> > support (LLVM 17+), so we should add:
> >
> >      * Optional: only supported since clang >=3D 20.0
> >
> > With that:
> >
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Yup, I can confirm, I only see it with 20+ too.

Fix up the comment and have a coin, witcher.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> --
> Kees Cook



--=20
Thanks,
~Nick Desaulniers
