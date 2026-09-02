Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E9DC61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1503010F0C1;
	Wed,  2 Sep 2026 08:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WKG4iqQC";
	dkim-atps=neutral
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144EB10F0C2
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 08:55:14 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-51c0c45c580so8212431cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 01:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788339313; cv=none;
 d=google.com; s=arc-20260327;
 b=rPUuVN8Rk8i4KpxEbyTobD77h0E7fmk0RI1hbsD2whR159TWnEEbk57BuuM5X/lrc7
 q7ZcLc84LYZILCwrCe54w2+QvJw3p7g8oeeN9jAJLQ+/nlT3iPw50wePCSVDlMyXJOQP
 OUKFsjO3R+uIP2fM4F7LuC4PndzRuu/fzPBbjFdEw5COKyf5bbxfm3PJKfHavrIVjkCS
 Y775MM1pQhBYLpprdra1r939/3d7J+U/GmrVeJ8D5AruBsQxWK+xXM36KtPlU0SZPzx9
 vDt40i9V33w6zaFdNy3ii7D0gDM24ZURirfcpAuxD4Nhky9334Ix5T4YDsLqjRq/fnwL
 5+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A6NfQsMe4AWk/u2vAtduAV/QnsJCjKyJO6vpib7gRdc=;
 fh=MVyRPhBsf7KHuorREgMuC/2yfWD5j9l67Z+WoJVcAxo=;
 b=nPmeO1DtCY3Cgq+7OaHTenjJf400t/Je9ZVKbFR2G2pNylTKGJ9QjVA0KBG7BiTQnv
 icnZA0VIRs9m2860CcN2ooX+/Z2iRJARbdmh987CcG7HxECcInP7OjWmYxZTxW7cWotg
 XTsHb2pzzC13GSl2pvcZupALssA02+94Bxc5qzV4lscs3R0xDGaNR52Il86RUD9NYETk
 nRYU2ZZQIvsGt7mIvTwiMyopH4lo+f6eAEV9eqxs2AXsiGP4qA+rN9FCA1a/LqOtQr89
 MVdIvI6jBU+ygBvJ9fkBR3wTnUy1OLQfXHWYogdGE0JZiAq4/HyoCcPbjbeM0S1sCuFy
 ibkQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788339313; x=1788944113; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A6NfQsMe4AWk/u2vAtduAV/QnsJCjKyJO6vpib7gRdc=;
 b=WKG4iqQCK4+l0rjOgRE0xH7SNqB9Lb3q8QuB5QwvbHcx72OKykTI5V0mV9ABCaj1d6
 41O7AnvFv33MY3aeKWpu9ZUC9t1t8HUgDyFEvJQFdiRzK4hTyJnrV8ZbdXUWksbiOJDK
 kIvZ9ca6N5Jxbtzei+0ObeaIHlugOzNmm6EKYE/86CtMw6Awy0aC7E1YxoE0imefY1Z3
 qPQb/gQw+SQnvMm555jmcpNcn0B4mMkCOiz4dd4K1hIwBYz8gAs/4MVVR3+JBy7QK+47
 nV399KSnjN1kPLRBzpHPwDmYFt3aLOgvHIfEPpyHXnaUW/MhMgiNwuacHymGjuRXkkMP
 e5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788339313; x=1788944113;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A6NfQsMe4AWk/u2vAtduAV/QnsJCjKyJO6vpib7gRdc=;
 b=nay1ylhEYakRl19erE03zzOqGQd73yARPNlhgCH8Tlb5IaCGali5/72zjB9auCQfiu
 XiWy1/9Kl6PC6LENqqaBlfZj26XVR5ZLPqUp1zKP6ZqfBP4L4OO0+u/3gz/mP0GVxhZ7
 Jt5U1ffFFsmuR8rIyj8kh0sbEN57V5c5udD24/+S7HHWO0t1BNyorY9PXH+DhmhmTrI1
 5odYmagvdFL+oY24oxlVCkLk5hNrcQOMBU0/ADmuLitdOAbjnWsjf4GfblXpWkwMjnPn
 lxNIqdY1BefkHoGCCv6NGxeZzxQvdHOuZ2zPh/n0RaWK6VRlGGbDPHzLZwYzRM5BCtnN
 Ihcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RojUZ0vIZ5BK8wNf0z6KpzjxflzqLAbtx9e1NZiwet6RBzRTB2YG+VJXILuG198xvWVTwHRNnsbcUE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5kVhtbgA09qov8t2hRpmj1HyULpDT7agbT8HWHjZsf3lKaAve
 /fKgbyNLS5kqHaGfx87lQ+tAcLRh5l+YwJCG7rknujpHyFZazqrJ6B9elejLkJLBEJV8/uSW2po
 aLPNvnE2Pz7adEhMGUf8pGv3wyaEPVEA=
X-Gm-Gg: AR+sD12aclZZZAD09wddH8ldiFovdGA/yMdkHNKkHWxkd0pIe1FppDFLq2tBKkBCjIo
 tfzz5bY2u7g8EUopmV99losJjkJFJfW6G8gmq0UUSO/6DKyYR5/B69D6/laNzUcigUS4wMfPfDf
 cgunbUFqFDFnlCzjZwzQobtHcdhYORB0VdycES8xCUUqtcDa3rgikGQaIGDYAP1aCCcE1Pgpv7c
 qQ3cWZRaMm4hBjA72+/a4Y3AFe6nrdrks2JksxztBZV2pOwdzK8Wf8c1DwDn9JnWV9WyOcW6LYj
 KprwhI+KipT8duodC/OZ1IipS+iFKY1L5XJmHZkFHS06ATKeJR6HRUsZaN4Zdw11ZAtLbIQWUrO
 uB5DTO7OS8ETcB1piLdcg/l8yQjcLbINxPebP484b
X-Received: by 2002:a05:622a:4185:b0:52e:a11:571e with SMTP id
 d75a77b69052e-53036bb6af6mr33554901cf.11.1788339308272; Wed, 02 Sep 2026
 01:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260820031901.1018324-1-iridescentrosesfall@gmail.com>
 <aoczaCuoaZfUkfm5@gsse-cloud1.jf.intel.com>
 <CAMpTW2cxRrG4oJ0HrRoKhHrVHxWO01-L+QDoWMLCAUaSfw75sA@mail.gmail.com>
 <CAMpTW2fxFRrpn1b5WGYBrtLLMfUo_fmx9s2D0b552GJp-sF5qg@mail.gmail.com>
 <8b7001c68c94491095f41d2a3dff45090c0a95cf.camel@linux.intel.com>
 <aoeUdfrPX+0ZnZMr@gsse-cloud1.jf.intel.com>
 <CAPM=9twBded3B553KYzwDtVd0NbhbAwbiVDGw_bdrmBnOKgtKA@mail.gmail.com>
 <CAMpTW2eXS9tBzppJvvfZ-FiwoJ5MKOAdB9sqYgCDPVQ_+___ZA@mail.gmail.com>
 <ao+acQG/wyZYNYfW@gsse-cloud1.jf.intel.com>
 <apfZcEF8IlDak/As@gsse-cloud1.jf.intel.com>
In-Reply-To: <apfZcEF8IlDak/As@gsse-cloud1.jf.intel.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 2 Sep 2026 18:54:55 +1000
X-Gm-Features: AcwNN1WILUlKuU0Lq9lIUugwcS75tHY73FPdHaQF0ZD-dcIRr3i6vZZ9zmPYrQw
Message-ID: <CAPM=9tw9dtxN+tZLrb4fvPGndUT+He7Y=o39ByMEva8wWyq56g@mail.gmail.com>
Subject: Re: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt on
 non-TT resources
To: Matthew Brost <matthew.brost@intel.com>
Cc: Nathan Bourgeois <iridescentrosesfall@gmail.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Simona Vetter <simona@ffwll.ch>
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

On Wed, 2 Sept 2026 at 18:08, Matthew Brost <matthew.brost@intel.com> wrote=
:
>
> On Wed, Aug 26, 2026 at 07:01:21PM -0700, Matthew Brost wrote:
>
> Dave ping. Question below.
>
> > On Thu, Aug 20, 2026 at 10:34:49PM -0400, Nathan Bourgeois wrote:
> > > > Shouldn't we just be calling xe_bo_validate() here instead of
> > > > ttm_tt_populate? (With the correct xe_validation_guard() wrapping).
> > >
> > > > Yes, this might be a better solution, making ttm_bo_setup_export()
> > > > completely unnecessary.
> > >
> > > If ttm_bo_setup_export() is unnecessary, I'm happy to change the patc=
h
> > > or make a new patch. I will attempt to implement and test this locall=
y.
> > >
> > > > This part looks good as different patch from what I'm assuming will=
 be a
> > > > TTM fix.
> > >
> > > Regarding this, what do you recommend I do, assuming the patch
> > > remains local to drm/xe? I'm still learning the ropes of contributing=
.
> > >
> >
> >
> > For Xe I believe Thomas and I aligned a xe_bo_validate with a correct
> > xe_validation_guard is the Xe preferred solution in the existing
> > design... But a question to Dave below before I commit to anything.
> >
> > > Nathan
> > >
> > > On Thu, Aug 20, 2026 at 9:08=E2=80=AFPM Dave Airlie <airlied@gmail.co=
m> wrote:
> > > >
> > > > > Yes, this might be a better solution, making ttm_bo_setup_export(=
)
> > > > > completely unnecessary.
> > > > >
> > > > > It's also a bit odd that, in flows where we don't have backing st=
orage
> > > > > on export, we populate with pages and charge the system memory cg=
roup,
> > > > > only to move the data to VRAM when the import attach is triggered=
,
> > > > > resulting in a copy and a change in cgroup charging.
> > > > >
> > > > > I guess the question is why was ttm_bo_setup_export() introduced =
over
> > > > > just a validation at export?
> > > > >
> > > >
> > > > I'd like to think I had an answer for that, but I don't. Likely
> > > > because I wasn't thinking about VRAM charging at all, and just
> > > > worrying about making sure we had populated some pages for system
> > > > memory ones, so the other side couldn't DoS us.
> > > >
> >
> > Dave:
> >
> > We don't charge any cgroups yet, right? This would only come into play
> > once a version of [1] merges, correct?
> >
> > What would prevent the pages populated for a TTM BO from being
> > immediately reclaimed and discarded? I'm fairly certain Xe's shrinker
> > could do exactly that, since we don't pin those pages. This seems to
> > imply that we'd need to store the cgroup associated with the TTM BO at
> > creation time and charge allocations to that cgroup, regardless of whic=
h
> > task ultimately triggers the page allocation.

This was actually to fix a non-cgroup bug with a possible priority
inversion problems.

i.e. a client could allocate a BO export it to a compositor, and then
the compositor would populate it for the first time and get ENOMEM.

This was to avoid that case by making sure a client had tried to
allocate all the pages for the BO before exporting it, so it would get
the failure at that time.

I don't believe xe should just be reclaiming and discarding these
pages without swapping them to shmem first?

Validating is probably fine as well.

Dave.
