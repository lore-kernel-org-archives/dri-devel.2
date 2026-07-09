Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91634C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 04:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A2A10E00A;
	Thu,  9 Jul 2026 04:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DoCJXLos";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD68C10E00A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 04:31:48 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-80a1fb0c683so18547367b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 21:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783571507; cv=none;
 d=google.com; s=arc-20260327;
 b=a0g+zPEWQKa5Ugxb6tkHBN8m2ucQqoCqKBZk5Qbf7Umy7wn3OdAGUud2Aasr1ZYNgy
 Vhe3XD8ykw11B24ixVJJToQEgkIqyWN4UHYkVsVuEmM6QQgTUVdFUdKRVBTqYLqZRPEG
 zLjoC5WNeF5fbwdw+NuiFmRssyydypt6zcb5Isyab2imY0JbMDU1Rk3/iMHuDhVVWTZn
 xs87aEQBcTLYHmDudrWzdO3Mjm6NrDVc97LMiVNVOkhDMKDnXpdD9c8tTKyBaOtxuSAc
 DRCRYlC/pnB7zkhnDDT3hPdmdwctXF8FicYzKq04VHdnXF3R/BRAGTD/tBDp31sbVP92
 V5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=auIZfaOXEtlH8qbaTdplRzk6SYfXJKBB6E9yX6kDwoU=;
 fh=zSte5Vl8NwBEE6BZQlEnD+vo2ipzyUtaVjgjaa9K4wc=;
 b=CE0AcYLvesfqQoyBBf84ZvFdkLUZj0JeTD8TbezVRFHy+pXyoWgzveeScESvkod8W/
 gxy05JnMYSz3H7IPt9HTp7eMsWaGHvveFnTcbQQinDrzIiwB3I7V3jss+BILholBSY2v
 2hMDbBtTBdiTE5I98wtdhxOfTdE+gYcUrVwlnaVJbhPabTv+8U1rVieO3uBwySeoWvFB
 lru5YOvCIq3MN07O+QvAGrD1CYxz/Rf+40NHrPFJd09Z0isdt7DVW/t+5KFp4n+QXJRA
 pLgC3HeGTfJ7UFb0Xgzx7uADlkCaqF8lUeesYon8n+wtV09fMoXXiIUljbrm9dWupZwD
 jTFw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783571507; x=1784176307; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=auIZfaOXEtlH8qbaTdplRzk6SYfXJKBB6E9yX6kDwoU=;
 b=DoCJXLosfbPjFRRdwwD+g5C9nrav7cbdAK0YE+/mZcfcjbCZ8rFRojj7b6au3BwlPP
 a4Lsd6LPP+nYJEfqG0+QWXjSBr9CEGmvcizklphntEcUG8X+iMZpBLphy4dbBT18hVB/
 O6ZaRWWFJN50zK+RxB22LuxIJIdiZ4+L4Bm0YZKxIR4cLlFsqDn/pSNCo8GAyqt0x/S2
 y+4duqjCH8jH6cXG6YwXSjaQ7D9Iv/xHbI8IIUp9LX6NX3N5fOn4GTiLFIgNq24DMkSW
 vOXqjt2TLUxL+QMrHUEJyztz42KLQevImDEcUj8h+P2zHnZ6OkvSwS5T0AYmsc8F6Qiz
 3UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783571507; x=1784176307;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=auIZfaOXEtlH8qbaTdplRzk6SYfXJKBB6E9yX6kDwoU=;
 b=qZ4VaiZiz+crNfVuYp6wiIPUjBvDV++7iSpcxRJJsXDt7zRP9zmuIebWubSAOiuqSi
 MMCCyjx3JNtk6SGspuK/LV3yFdtI7e3HeCaDfEAZqRWN9ypoSa8zFgve5j4K5OWWJ5kg
 gWSm6NFo1WSExOneArDM3X4AksjUCIfcei/Ius/hHbK7dmRJPc5QGRfJ3e6CmNgL5Bvs
 /FBvpR4m7Z52On7Pp6yJpgtRu4IzS61xAvV7qNRxpPSuRFJQ++Gp6Ooiw1ByMNQjBylq
 iBfmURjrXK6pO5FvXf3fsfIqLKQ0xRMI6bq0tLTSBwHK3IZZUbelnnjlLfAOkDZHGLvB
 88Dw==
X-Forwarded-Encrypted: i=1;
 AHgh+RouBTU9cyOb4W8sBaN1m+D2RMLqJz9Qp/bWk9N8J8HkjZsa4+9pQJ1AZ2qJ4tIA3rOHby3t7pYAkCQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIU88hpJzq0/ujfgaHPYH6VJJTwPvO1sUPldSr16eF5BequnLc
 f1WAjc7vdvaelcOoRBfI/7wDPOYxwQQ+7fzTY93zEkVKGPrkzPnG66gumDB8fOj838oDOhVS30w
 XLN/qzYGTLMnYiPVMRnJsxH7bVHeEQnA=
X-Gm-Gg: AfdE7ckA38mh5Y2Gj9n0s0gsr4Rys5yD+RwXjuP2V1cc5hhuAbCdW/OojNohBAl2vHx
 sX0lIk4T0/pao2GfhJLZf82eBjIvzHTvfdKsh7mhfEtiowTk1wR1utfhE4twXmWVI7b/2+P1VZA
 FF6ZcRAViUA9anx8FbFJO34GxATjrx68/DJB9GhT1i96F2eXv97riVTQ1VA+9LiQ4BZAhvWqC9Y
 GgcJ7oxb//Vhd61nRWR40oyAzH7c84SoTFBk00NADdAK9bwWJ1pjQECE92R3cxBbVvFkrMbR/za
 A1jHBlqZQS18SUILwCAepKRt16tIz3cwTa+eqgaoEwd5+3jQgpAf7L6SZg==
X-Received: by 2002:a05:690c:3747:b0:806:b6ab:a410 with SMTP id
 00721157ae682-81dbbbc3e84mr46430647b3.0.1783571507606; Wed, 08 Jul 2026
 21:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260706053413.154135-1-apopple@nvidia.com>
 <20260706053413.154135-4-apopple@nvidia.com>
 <59948bff927bd4ad3af5fbe68d5d5e7565c5f729.camel@nvidia.com>
 <DJRP5QO5JKVT.Y7LCZARVCWJ8@kernel.org> <ak7lU9X4pTwx5NDB@nvdebian.thelocal>
 <6fe208cc-f095-4d92-b34c-ad227d2710a4@nvidia.com>
In-Reply-To: <6fe208cc-f095-4d92-b34c-ad227d2710a4@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 9 Jul 2026 14:31:35 +1000
X-Gm-Features: AVVi8Ce52HUzDIAE6RQvUKGgLY8vfZ1_RiXa4OKoXWiwiGWM8AqznZHsuXPRA0w
Message-ID: <CAPM=9tzdBWOhPpO_JffaWvkuz7SejfZL=XAbwxrt0gt3xaDKGA@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm: nova: Add GETPARAM parameter to read the GPU
 chipset
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Timur Tabi <ttabi@nvidia.com>, 
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 "gary@garyguo.net" <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, "lossin@kernel.org" <lossin@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
 "aliceryhl@google.com" <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 9 Jul 2026 at 10:49, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 7/8/26 5:16 PM, Alistair Popple wrote:
> > On 2026-07-07 at 04:24 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> >> On Mon Jul 6, 2026 at 7:35 PM CEST, Timur Tabi wrote:
> >>> On Mon, 2026-07-06 at 15:34 +1000, Alistair Popple wrote:
> >>>> @@ -38,6 +38,7 @@ pub(crate) fn get_param(
> >>>>
> >>>>          let value = match getparam.param as u32 {
> >>>>              uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
> >>>> +            uapi::NOVA_GETPARAM_GPU_CHIPSET => reg_data.api.chipset() as u64,
> >>>
> >>> Can we assign these IOCtl values to match Nouveau as much as possible?  I think it would make
> >>> everyone's life easier if we could use the same user-space tools/libraries for Nova that we do for
> >>> Nouveau.
> >
> > I debated this, for the same reasons. However I came to the conclusion that it
> > wouldn't make a big difference - Nouveau only has a handful of GETPARAMs and
> > we already know we're going to need a lot more for Nova given the increased
> > scope of features it needs to support. The rest of the API also needs to be
> > sufficiently different so I didn't see any real practical advantage to keeping a
> > couple of parameters the same as tools will need updating anyway.
>
> Unless all, or nearly all of the ioctl values would be the same,
> there is absolutely no value in trying to make a small subset
> match.
>
> Let's not get distracted by this. Nouveau is sunsetted and we need
> to focus on building out Nova--without artificial constraints that
> don't add real value.
>

Yes it won't be possible to keep much aligned with nouveau's api, so
let's no bother, nvk already has an abstraction in place that we can
fill in at least.

Dave.
