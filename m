Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E2ECDB46F
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 23:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF46710E248;
	Sun, 21 Jun 2026 23:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gZoeN74r";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC78D10E248
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 23:21:21 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-915aa0a9293so516202485a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 16:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782084080; cv=none;
 d=google.com; s=arc-20240605;
 b=QjnJRLpmEOpUdWaSR02jD/oEQlBkTzxQY6n/2GfO7n6Q5zxLbhRFW30Slosz4I3lhn
 w/VDhPRAkUBLguOoPVd1AErLI25XTKosUx5uJpbb6uz7v36c8EfhHjhvOd8Bjhk2FbUt
 1zKPutaK6o0zUVEaqlPAnQIUYJA9ikt6C5Yu+0wU/w4/dtnsP1SjTLzSObElj7KRek2z
 QhiNG+8UI3rV8iJ4DETTU56k1iyVsfAhbqB8R6zQ6eEeM/9KDm+HaXhAx9+RwZJC7xNh
 2XZdAKIkGiDARXCdokXf4ziHHHyhrPvwTMCvsSecgG9CldZSr5K4I+iOUKGRANfXavX/
 DCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hxi8pAd5fXbOtgwDNhDucP856vxJgDI8S86xqAbImM4=;
 fh=TU+6IUoVl4Pp/AY4vNEcAUQJGYf7Ru1iTi6rjctoMVA=;
 b=DJMD60s1SD6jLDi543KrmxZ1mjs1kn4Y7PYkO46ihEuhQv+VviMBq01XRoRpWlH9xY
 OC1DUR0T9ZiaVjZwwuYrZ358P5ZnmudoWPt9PEbawP9+iMpTDa/tlQWB/WNCpfLA+P4U
 yU1w+alzlYGpe7VGBywWpH6HaCg7wAKuslgrWC8cyDtHyOo2iMQj/FsSySAnhw0vkBRv
 0x4RuZLpm4OIbGFFA/h29A0820FfPQNBcwi0ZWPiz/sBv3mjBrM3DMUx6aQnBUfrDTTr
 lJILjevWNXnvXMh2ViqKrnamxBl9r2zKg0ReP/FeeJPr3tWfGYStVTBCd965Acrpcleb
 Bn6Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782084080; x=1782688880; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxi8pAd5fXbOtgwDNhDucP856vxJgDI8S86xqAbImM4=;
 b=gZoeN74rgR4YH2r/4d9OSEMUnaDsmehqyvAKy6vW5Z9CgPLNkUcLbRGljqjvXpyc6T
 NicoCOeCUr/euYuCNuG10uAdPS5ZtusMZlr/9fr5K0yKq5TLZ+DKq044iYU9oPVAcnCo
 wgIcDLhk5GCSY4yHkDlNbMGqO11XUrlH78uiMZVszZ+v65uHHc+BPIdAwRJ0uang25N1
 qbHzVvpGYAgjjYeddYaPbJlhaLMthd+AtmCZNCZ1OPpckg+5zl2ybfSvEyAWMsKAb9iu
 sfGu6zVPAovKY5PXfgl7kjpjD9PzQupxJEoj1cryadT7Zgh29LWiaWlrBB0uWSyKmyBH
 tEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782084080; x=1782688880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hxi8pAd5fXbOtgwDNhDucP856vxJgDI8S86xqAbImM4=;
 b=WVJag6WQXQbB5KFQ+EHp4XeWLPBmkIZnEXboJma2nC9XF3yjqCeM5QPJt0LAv0gOHR
 CRvXWgNIeRz4XiyAJP53dk4ESw+vz6CQIx2NKrvj85lD3wOwaV8hpdmX73kdqFPwkW5q
 jnXkRr9FFmRWUx6tgsUP3T4iXt/purICjAUiE5X81fyVAFI+KHFXhFY9sIe1KSuH8xy1
 vVZV7vuKmb0Af9Fk9U/9Q0KhiP61+VaXmx3Jj4iQ9ljxZjQLVln87i2pxqEnQxxH4nqQ
 Hdk5KedzrP2FYlXgVp1e0jD9mxDMWxyeP8aYjTTp/kDES2Po8u5AYnxLZd3r8vfAhB3i
 pnBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uWt9LZ96VayG2Uk2ndwZizPT4afHcq92Ph110FF8ThZ2cO3Dzvn3xMAfZIuyVj1mHZ2CjOF822uE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7gMhDyJ8Sa0utNkw/IkyWSQ2olOOemLjCTCQ7x+zCM9ULaxaM
 KOZhLhPvzPVauiCvmsPFc13lbnEcWF6ASX6opewEjfVYz4rPM25kNwNBAr41lNaBjPcKIjzWnrf
 Khmetwhe/EASw65wv8kB+xa7VjjbJsrA=
X-Gm-Gg: AfdE7ckCBdRhl0t2GSYGAIXO8hEhl4bmCiwc7rELq4UCO0Cg+HAplPCKMfU29d6ligr
 jEr0rx4tN/BYjBmwTMovSMm5svqPCzVXFGMdkRG2i2n5ZXP0zMW7TnoFDcNPxwIqrNiQybbstPK
 3qYxhyVB7femTibMpAZc3ZvdjPQqkGgfK6keWcDXkhQM7lVDY43BDhgJwWG3R4mlnf1drAdJzEp
 KhAFsB0CJ5juhAkWolNuHZ1vDBeq6WGouDlQlGvygGky07eeGvq/C0zLi4p3MkIhRHp6YkrsVmn
 Qb8HutiYCkYRvGBCvXnRXS2muEmO0Fjkoxvuh9xjE+jn/EuPs09tn5fOZjAMAfqNR85Bw/sXW1F
 Oel4YVdJrtZkb6lM=
X-Received: by 2002:a05:620a:4053:b0:915:5216:e5bf with SMTP id
 af79cd13be357-9208c625028mr1587487185a.22.1782084080570; Sun, 21 Jun 2026
 16:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <ajLy2brwvOZEFNNN@gsse-cloud1.jf.intel.com>
 <ajL++rKbSpYgBRw6@gsse-cloud1.jf.intel.com>
In-Reply-To: <ajL++rKbSpYgBRw6@gsse-cloud1.jf.intel.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 22 Jun 2026 09:21:08 +1000
X-Gm-Features: AVVi8Cf985BzLxOdD7bf0TqUBm8eXlIQywh3agTZ7zRl3Lbgw2eToWnB5a8jug8
Message-ID: <CAPM=9tzO2Cg2e5BRQrvwtX08pmaq+hOvBb=BuYWQ0beLyoU5uw@mail.gmail.com>
Subject: Re: [PULL] drm-xe-next-fixes
To: Matthew Brost <matthew.brost@intel.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dim-tools@lists.freedesktop.org
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

On Thu, 18 Jun 2026 at 06:09, Matthew Brost <matthew.brost@intel.com> wrote=
:
>
> On Wed, Jun 17, 2026 at 12:17:45PM -0700, Matthew Brost wrote:
> > Hi Dave, Sima,
> >
> > Here are drm-xe-next-fixes for 7.2.
> >
> > Matt
> >
> > drm-xe-next-fixes-2026-06-17:
> > The following changes since commit 52d4ab1ca790a668cc8f2c27017138b1c467=
168c:
> >
>
> Rodrigo pointed out that I omitted the summary here...
>
> The changes we have are:
>
> - Set TTM beneficial order to 9 in Xe
> - Several error path cleanups
> - Fix TDR for unstarted jobs on kernel queues
> - Several TLB invalidation fixes related to suspending LR queues
> - Some small RAS fixes
> - Multi-queue suspend fix for LR queues
> - Revert inclusion of NVL_S firmware
>
> I also generated this PR using the following command, though I=E2=80=99m =
not sure it matters:
> dim pull-request drm-xe-next-fixes origin/master
>
> Rather than:
> dim pull-request drm-xe-next-fixes drm/drm-next
>
> Given these issues, please let me know if a regenerated PR would be prefe=
rred.

All good, I checked the changes and edited the commit msg to add the change=
log.

Dave.
