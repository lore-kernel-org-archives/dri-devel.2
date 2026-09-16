Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F89C982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF9E897AC;
	Wed, 16 Sep 2026 22:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C+Wdr8l+";
	dkim-atps=neutral
Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com
 [74.125.224.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E8E897AC
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 22:43:15 +0000 (UTC)
Received: by mail-yx2-f43.google.com with SMTP id
 956f58d0204a3-66f943b286fso175661d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 15:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789598594; cv=none;
 d=google.com; s=arc-20260327;
 b=B2GuM+Xq1NirogmtfIqNColeIhYflwP8HTGDGLxwDiF9xvQWqUTVp9oJJvkly7Z8xn
 6l4TZzC3N/jM6yr5rLt4GwEdTnX0cSrWvWJQLWnXYlpIuDosu0woij2Wwc7K6dB9jhQa
 d6HzG8ReMB4tRv8owLvfkxVZOrCeoEJpQIZnPGCEOIrKxIzvfMqo7JkssSjvmC3FoEwz
 vWp+L7rxAThH6wIwM/njQbS4pZqM5fPDpZubd/0yguP1MCQdPkhCotHZ3HZT0yMXL4Jj
 yzVJzq6XaEzbtP7VxiEOclt6ThazkqraeIRi6C7UsVTYaY6orBu60HPbvJJ1d8E1122Z
 br9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VP1gHgdIqBe+kEh6BoRGZQA0vXfJ71qE3TipRKbKn80=;
 fh=kAGRFKDN7aRGd6VO33HQbsOy3CoTfL4nr4GTMsDqfhg=;
 b=h33Tk60dnRxUwKPt8UOUSOYtQ3ed3cktRdIbpmQa3Q4DfeyZ0dhh9qIouJ+Bd1VQkX
 Hu+TrrBe+pFZe2ARCxirVX1G5RX+UmSdxT9KJuIM94wxhMm6xE/YHF9hKVoSePMDp7L9
 jFAz1gtRtvDOGH6Ff6koGSiOunf1pfgI1jh3ad6V+UiE/RfXNlS4aJngoXthF2q66Rai
 g1mYWHPC0HrcbLiGAb12utFuki1aTqXNkUjq20TbJALEiqZFKXnmqbr7nRCY6yuixlQs
 +PhpA7/xkoc/kdI+tDMDSf39uIOd+Fg2wdyOF4VGfWXXb6XnfY9CHyn7/OozesNKN/Om
 wm2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789598594; x=1790203394; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VP1gHgdIqBe+kEh6BoRGZQA0vXfJ71qE3TipRKbKn80=;
 b=C+Wdr8l+RRxAONKsfRCKJwjX/cVtrosiikZm8mWzX7TLC7h3+OQzN/EfJVWJZRYpJr
 /DkvMhtKXoet9h0+DSlR0AbSEUn2mdzdhAhc/vpDL9icF7hRICulO7oJMvFwOTlmvNDf
 4nfVWqqmh4fIl+pVfM3ZN3O40l9y3D/9YDr3fPGTsjMH6EBBMQmLNO4BzbNdvPO/+dpA
 edtLaESkMoV7/hd1gHzNaCLj5mPZkpUNO1pH7KADOkpQzWMaAwiFhoS//2uf/zwRe3I6
 888+5xeY7VYWrs3V01B474d+qhSQc1oPZWRJ5hFJflIIajxQ2XDb8MBBkQoaXlk14Anz
 VxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789598594; x=1790203394;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VP1gHgdIqBe+kEh6BoRGZQA0vXfJ71qE3TipRKbKn80=;
 b=l9Yj68f3dTmykIFoZFxeBOHpTke3dX2Ys/5DiWj2Q6zDZitSs1Ql2vQVPKjKcs+qES
 r7LSyNLVE+Ed1kBeTW8dhfzZh1V2n/UvNWjKMx1ds2bCUJGXk0NQM65jIf9idhhPq2zu
 HeSF3irdUggtBlsmfxZ46YDGGLBlwWOgfdOd4UxBuskhBPE/4aDlyyrOHzC6rYuXlmMN
 aX6T03KyhcQg7MRszMwZKGSo4gdveNmVWSoZej3gCwTHMrLNea/+vuUKQYgSgn5VoVwG
 zUTNqY0z7W7qukpmN+VjpZMZDb3+ldrPryIOxvlmJ3UE+ZWHK8EJyRZKdIo/qzlSnTmc
 ZXSA==
X-Gm-Message-State: AFuF++kQ9MWR10J1wxP5PRKaATkcs4NLOmeo+CUF4g7zDVzaEH0pBW53
 ywbCSbEz4qw6qAE9U5p6lXIXXtV3JPIjcXsDjW+usPSDyEPWn7ZavmQU/uFAMK10sNH+oaI2ST/
 zMoPswEvlpV4rkxF59E9Tr6HwAfjY3U8=
X-Gm-Gg: AYBFou3ASt0fjFIOpSZLPF50uqPV94ebgtAwFPOc7eeB28pLeLkeABJQAOXJZ8D/NzJ
 hHQL368ARAkxbyGR3emk14/c6E/ulnw4+fIH7A06Q2paquYkB5bbNfmh7w/jrqvmFNEEkETMrUg
 ddwtz9Yf5Ov1zdrK27ZvCnkmIJhHxe1kFELWbvcvvuUgxf00zUTrtNjELhpF4hWXsQVSu3Lli+/
 DYzN126JjT1ISUGBuBVJMl3iYi5ujrq/cE0YWpEu35kfGZKF1+eaRIIJGasuwzXBxXKua3mRqQA
 Z/mYpkfiOpUlYFIYBtYMgA9Q5nT1R9fsk44WkveQICbCbnG4mhhql00f+h8uvJiDN4/IoriOUTm
 Nan3z1mM0ePPK4VwfWlF77+5byy1WFkAjJw==
X-Received: by 2002:a05:690e:12cf:b0:671:23cc:8561 with SMTP id
 956f58d0204a3-67163201b32mr1574386d50.31.1789598594536; Wed, 16 Sep 2026
 15:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-8-af4cf4767707@gmail.com>
 <20260916160018.DC5F61F000FF@smtp.kernel.org>
In-Reply-To: <20260916160018.DC5F61F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Wed, 16 Sep 2026 16:42:48 -0600
X-Gm-Features: AcwNN1WFvT--q4ESZQXCY7SHYNMTMZrDrc-ogrmqFQnSBAonjPHMrZUlFUTsghI
Message-ID: <CAJfuBxzygOtC5DRjiioX3EN_pc_33dt9diNtoW7G3KiMqy_edg@mail.gmail.com>
Subject: Re: [PATCH v10 08/38] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
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

On Wed, Sep 16, 2026 at 10:00=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] drm: compilation failure due to DECLARE_DYNDBG_CLASSMAP stub
> --
>
> commit 96b109d4ffa1bfc809c49d548861d8dd8aa48aaf
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
>
> This commit moves the DECLARE_DYNDBG_CLASSMAP macro definition inside the
> DYNAMIC_DEBUG ifdef block. It also adds an empty stub macro for builds
> without dynamic debug enabled to provide a cleaner starting point for
> future changes.
>
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 05743900a1169..a10adac8e8f00 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> [ ... ]
> > @@ -314,6 +314,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor=
,
> >
> >  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
> >  #define DYNAMIC_DEBUG_BRANCH(descriptor) false
> > +#define DECLARE_DYNDBG_CLASSMAP(...)
>
> [Severity: Low]
> Does this empty stub lead to a compilation failure in the DRM subsystem?
>
> In drivers/gpu/drm/Makefile, CFLAGS is used but ignored by Kbuild for
> subdirectories, meaning DYNAMIC_DEBUG_MODULE is never actually defined
> for the DRM subsystem. Before this patch, DECLARE_DYNDBG_CLASSMAP was
> defined unconditionally, which masked the Kbuild typo.
>
> When CONFIG_DYNAMIC_DEBUG=3Dn, CONFIG_DYNAMIC_DEBUG_CORE=3Dy, and
> CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy, this empty stub is used because
> DYNAMIC_DEBUG_MODULE is undefined. This causes DECLARE_DYNDBG_CLASSMAP
> to expand to nothing.
>

CONFIG_DRM_USE_DYNAMIC_DEBUG is currently marked BROKEN
so its not happening accidentally,

And the following is guarded by #ifdef, so it wouldnt happen

> As a result, drm_print.c attempts to reference the undeclared
> drm_debug_classes variable, causing a build regression:
>
> drivers/gpu/drm/drm_print.c:drm_debug_bitmap() {
>     ...
>     .map =3D &drm_debug_classes,
>     ...
> }
>
> Would it be possible to handle the stub expansion differently or update
> the DRM Makefile to use ccflags-y instead?
>

that patch has been sent before (by me and others), it hasnt been picked up=
.
I will send a full set separately,
insisting on it here is cart-before-horse


> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-=
part2-clean-v10-0-af4cf4767707@gmail.com?part=3D8
