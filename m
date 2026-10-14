Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C662CC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 997E410E4A3;
	Wed, 14 Oct 2026 05:36:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA94110E4A3;
 Wed, 14 Oct 2026 05:36:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D84B407C1;
 Wed, 14 Oct 2026 05:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60E01F000FF;
 Wed, 14 Oct 2026 05:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1791956207;
 bh=20IeJwlfbHOwAOqBybbPglj4DioVDbfCTggyOUmG6AM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Qh2L+lns+TC45tZ3ta2Bf3sHpQuD7ArGYrxTnkjJVsISJDd215cAUFX7buojC10XX
 PxZbUFGpn526urHl9iW1zA+jq+Q49VIAoWCaSVIjSYQA+Pdp0aIxZO/l3JMBTZ5a0o
 W38eNJtQMa+oY0XJ4+Fg38TXLC108OEL5jmzsnVI=
Date: Wed, 14 Oct 2026 07:36:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ian Rogers <irogers@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
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
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct
 kobj_type::release
Message-ID: <2026101425-why-boring-4f2d@gregkh>
References: <20261013223946.1836757-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
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

On Tue, Oct 13, 2026 at 03:39:35PM -0700, Ian Rogers wrote:
> Clang supports the 'require_explicit_initialization' attribute on struct
> fields to enforce that the field is explicitly initialized when an
> aggregate object is constructed, emitting -Wuninitialized-explicit-init
> (enabled by default) if the field is omitted.
> 
> Following discussion at the Linux Plumbers Conference [1], this series
> introduces __require_explicit_initialization in
> include/linux/compiler_attributes.h and applies it to
> struct kobj_type::release.

Cool, sorry I missed that talk.

> As Documentation/core-api/kobject.rst notes:
>   "One important point cannot be overstated: every kobject must have a
>   release() method, and the kobject must persist (in a consistent state)
>   until that method is called. If these constraints are not met, the code
>   is flawed."
> 
> Annotating struct kobj_type::release caught 30 struct kobj_type
> definitions across the tree that omitted .release:
> - Patches 2-10 fix 10 struct kobj_type definitions where dynamically
>   allocated kobjects, ksets, or enclosing structures were either leaked on
>   kobject_put() or freed prematurely before kobject release (risking a
>   use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=y).
> - Patch 11 annotates struct kobj_type::release with
>   __require_explicit_initialization and explicitly sets .release = NULL
>   (with explanatory comments) on the remaining legacy struct kobj_type
>   definitions whose kobjects are static, per-CPU, or embedded in devm- or
>   parent-managed structures.

Sounds great, but let's fix up the users before adding the attribute.
Looks like some of these need another version so it might take a bit of
time to get them all merged.

thanks,

greg k-h
