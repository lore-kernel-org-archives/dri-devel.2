Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568E7CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA08B10FE8D;
	Wed, 14 Oct 2026 16:41:45 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B3C10E9CD
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:41:39 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-533202fe429so1288941cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996098; cv=none;
 d=google.com; s=arc-20260327;
 b=IYNeG8zSprC4yZPnyh3a3o5kZR4LuPrc6O4I49533rf1TvhuxWeJnaOw/0tCvI541j
 mBrfqmTb/41OsgdVk+JQUdLpRa9UYzsmTNDfmEQGSN3XBn+eeT9bRMmeUoWVILwCbzNj
 TqkjVtte5glkcYyMNaCUjKLYdkFwnmnbASV/Ll4uiKuUjKgmQiL0Qf2WnklIO2QBHKoB
 /k4/rbjmXNt0H7LFyr7wOIiCVv0g5hQpcyUTZ1m00Dd/TZ7UiLZwG3nH7SvHUgU5MCdW
 lbRKmRBq/DTnM5cyBrD/qlrIig7vD629ekQjkR5X6uhhGYzjwpOsyANv8HoqvIfaEzql
 NSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
 fh=217/Eu0FBtqGdgU6u1heGYo6GdY5tPK2EFNm3VnW/Ek=;
 b=QQ4OSoE/EbyAVcgAXQkn2tdfzg3q7Yo7D3kHcuXGFhI71RPMmMgJn3gj7r22f+qoi2
 F9hoIue6cYs1+ptJ+0mpFr8HwIeDh9iKhkiOGMjoDuYh5YTGcZNugHEvXHAe8dQraept
 9Qfm6FWxYnPwbuOvrT2TUzaDmNz4HJsFrLnzK7BiwKcD7xtY1g3HOi1TQOJY+xJD9Sev
 Opx52NnkHtVsK1eeO6cQvd21vyFVAnvjePEa8GCq0QCWCiAAhV/kMErQQQ9HhgVR8wuk
 HTNRvuY1wnN5BoAUP4NLzev8iobGo7IzioXdEecD7eUmH31Scdu0bFvJPL8yzhrT/SoR
 izGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791996098; x=1792600898;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
 b=CVpVzMiKUSfq6swH4BzcS8fzbY7EQE/3ygYIu6JLRW6Kw5pduYpPT/BKCu1npw5ueK
 oVzback8qYUY3b5priKHbjbmysHdZHA4+wPQ4Pd2D6/ocN5KYpnpdeCU2sqYwsH7QTG/
 6dsjzyCMSK+twgg7UreLqRQDuppT/rnlCWIdKoj6rFmQSKvnazjTFQJfBvNUULkWRkOT
 Bml3tqKUNWVZPq0DREoNwc5Ut4HIbWEQWZLHrlwP6UOiB4ztZB516OTcUceHT75tynt2
 G+ke8JxnNMwhjVG8QemFwyb1nO3g7nrw9bSEmQjM2pE511MqsAsPP3xR1nMcXjUts5cz
 tn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996098; x=1792600898;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
 b=hREWXzSL5ZSCmtWR6ZPO4vXTJsxZCFgk8FD+XxTcRtdDC+yDs8iwFhfIJUKGoq/Pui
 YtB4/r2j/iQ97HSOasR868Mg09sn94cRS0qTKGsHoppib+gPaiL/XOAYCMEEYVTaDObL
 XeKQ4zav30GDXAq1SMvb+pSkVTl23x6ZomjkXmwArogW4kiTfvPepc/f0DSTi+VgvHXl
 YbWWHp9TrMRBRd9y8C1d8ECcgptdWDb4zBIig2jY79Y3EqvXcQ8s+csj8B1v8XQtKUdX
 mEZh/YeZeawNbWpyDgESuYfbKNzW4KoWlz8uz+UHttOT53rIVpp8Wca0C924yrsNESHn
 IFpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxnCzQWzrgLfl6uMf7RlKIRRt1OMe+/LhE8UD9apaCnqB77UnSUH7JCjZ2XY17peYQDi8Hl0TrBPg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIfEWKJapbkWd/uZg6pSaX9oEkOuovufuvaIhS4p3P4rR1/jsHs
 X8xizVF3oBaR/g9LfCl2d5As5hJSIuOfhri/uVelZdT3jfvTBEQzBESmMtkyHKiMn8AckyphgIb
 jp6HgAgaqV0MWAJxI284WJmELZewnQQhZcxV03ukG
X-Gm-Gg: AYBFou33xBDHESwI6UCJbMSUDkASs9h1B4AmSfID53fD9ag7AruHCwNICWWCLQq9QbR
 wJ9iqkk1+dmOR+JGWXe9hvk8ig7+SxlMKAHoJvX8rCozXCCaQ5S8EvLRKWkjEwEGi07k31MFnRr
 usiNMjfa1qkmB0F8HIzInQPwRGv1/1aKhgfEdL4/MfOPQwwwh90LGg5okwTcyIbIZXPQbH066u1
 rMunAFFR89B/FlRUiTSpHgjY96X/NEp+M1kwJbznPD87gnhdzUTb3AtN5WiBzGlVtQpzEY0JxdP
 2x1ei7bjnce/YtYzeX+831NTDZJ8fT0o6IiwtCFBCYs0eeenrqtwUVGikO8P61rZ+9YIdbdsu+F
 7iHYdtD3VEw==
X-Received: by 2002:a05:622a:1108:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-5360573c96fmr14813151cf.5.1791996097367; Wed, 14 Oct 2026
 09:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
 <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Oct 2026 09:41:25 -0700
X-Gm-Features: AclHuK8_g-YOJgMR77fEpf5RTsveF4u_ERdXz6lvoN6wh_uF7KP8ZsaUSV1ti8A
Message-ID: <CAP-5=fVLWh4uay2HGy6DOpZmtTr5WAd-TehAkN+P-pQgq_BZhg@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct
 kobj_type::release
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>,
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

On Wed, Oct 14, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 07:36:41AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 13, 2026 at 03:39:35PM -0700, Ian Rogers wrote:
> > > Clang supports the 'require_explicit_initialization' attribute on str=
uct
> > > fields to enforce that the field is explicitly initialized when an
> > > aggregate object is constructed, emitting -Wuninitialized-explicit-in=
it
> > > (enabled by default) if the field is omitted.
> > >
> > > Following discussion at the Linux Plumbers Conference [1], this serie=
s
> > > introduces __require_explicit_initialization in
> > > include/linux/compiler_attributes.h and applies it to
> > > struct kobj_type::release.
> >
> > Cool, sorry I missed that talk.
>
> Yeah, I'm really liking these compile-time checks. :)
>
> >
> > > As Documentation/core-api/kobject.rst notes:
> > >   "One important point cannot be overstated: every kobject must have =
a
> > >   release() method, and the kobject must persist (in a consistent sta=
te)
> > >   until that method is called. If these constraints are not met, the =
code
> > >   is flawed."
> > >
> > > Annotating struct kobj_type::release caught 30 struct kobj_type
> > > definitions across the tree that omitted .release:
> > > - Patches 2-10 fix 10 struct kobj_type definitions where dynamically
> > >   allocated kobjects, ksets, or enclosing structures were either leak=
ed on
> > >   kobject_put() or freed prematurely before kobject release (risking =
a
> > >   use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=3Dy).
> > > - Patch 11 annotates struct kobj_type::release with
> > >   __require_explicit_initialization and explicitly sets .release =3D =
NULL
> > >   (with explanatory comments) on the remaining legacy struct kobj_typ=
e
> > >   definitions whose kobjects are static, per-CPU, or embedded in devm=
- or
> > >   parent-managed structures.
> >
> > Sounds great, but let's fix up the users before adding the attribute.
> > Looks like some of these need another version so it might take a bit of
> > time to get them all merged.
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

I'm happy with that. I'm working to address/incorporate the other
feedback for a v2 of this series, but I can drop individual patches
that have already been merged. Thanks, everyone, for the positive
reception in getting this landed, I plan to follow up with patch
series for the other uses I found.

Thanks!
Ian

> --
> Kees Cook
