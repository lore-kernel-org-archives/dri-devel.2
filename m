Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9375ECC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93D410E14D;
	Wed, 14 Oct 2026 16:37:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54E510F6BF;
 Wed, 14 Oct 2026 16:37:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C9B3E4094A;
 Wed, 14 Oct 2026 16:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E201F000C4;
 Wed, 14 Oct 2026 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791995864;
 bh=ovAqcUcR1GnKTtcInlqEnrexmz1gsb8w6q2FfK1T5r4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GwrpOxogXrqhTXQ0pfmjgGMR/nhqs689d6d2T2UbxyqwEi+VJ/4ET2F3bxSsa/yCN
 EaglIPzBQ4qutHm/Eihe0pPBAWe+NlyY72FoJLC4Rcx8zYnrd+VBcodEifrd7JTzwT
 8EqOjY6NHHc/4uGTfqT13dIP1aP05fs1tpq0wWe/LFtLEAv3fcER387/hVuHvXtsuD
 UxSDlOug9/2BlYA6zAYEAL+qTg5TM5momYM01f0IFfrqT1XCvpcIhwvzWCD/yfd3Rd
 ixvRP2r8X3I5Gfn87O/r4tNbn1q5lLdLD9Jj9tp7JpRRBzFzF6fUQnw/3GazF0kGmz
 Z7FdXtLFV/36A==
Date: Wed, 14 Oct 2026 09:37:44 -0700
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ian Rogers <irogers@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 David Teigland <teigland@redhat.com>,
 Alexander Aring <aahringo@redhat.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 gfs2@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] Compiler Attributes: Add
 __require_explicit_initialization macro
Message-ID: <202610140937.B68C8C9AAC@keescook>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-2-irogers@google.com>
 <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
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

On Wed, Oct 14, 2026 at 01:28:55PM +0200, Miguel Ojeda wrote:
> On Wed, Oct 14, 2026 at 12:40 AM Ian Rogers <irogers@google.com> wrote:
> >
> > +/*
> > + * Optional: not supported by gcc
> > + *
> > + * clang: https://clang.llvm.org/docs/AttributeReference.html#require-explicit-initialization
> > + */
> > +#if __has_attribute(__require_explicit_initialization__)
> > +# define __require_explicit_initialization __attribute__((__require_explicit_initialization__))
> > +#else
> > +# define __require_explicit_initialization
> > +#endif
> 
> The LPC slides mention Clang 14+, but from a quick test in Compiler
> Explorer and a `git log --grep` on the LLVM repository to confirm, it
> seems the attribute was introduced in Clang 20+, no?
> 
> If that is correct, then it is not available in all LLVM versions we
> support (LLVM 17+), so we should add:
> 
>      * Optional: only supported since clang >= 20.0
> 
> With that:
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Yup, I can confirm, I only see it with 20+ too.

-- 
Kees Cook
