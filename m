Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3F606A32D
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JbuZURG6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E85210FBA6;
	Wed,  4 Nov 2026 12:21:10 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9253E10E23F
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 12:21:03 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2e9eb579c0eso3794395ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 04:21:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793794863; cv=none;
 d=google.com; s=arc-20260327;
 b=Md8rJvXC27vDXJwUWlbuUxPQHFzac2EKv5ReDSAuCP1NkKju8lhpdWy5Axs5jgvQhq
 9QqlRjBn2MiHlQ/3xXvJMdaYdy2qA4vZa8zCBxb3E+pebNZGEeDm7xYCWNvf5eRNWKXt
 6/ZIbXQuZqQt9ZORdOLt+gaLjV1DhNc3AsCm6H+BjJtDUI7rv5/lqUZOMIgJTLnedt9w
 iyHI5rVMBrNj6trNGCa4IN8EvowCPLx9RHBieDPjIJWCqr+ZCe2pO4cq7suhlmi5gtW5
 CR49imlW0I48Nmv7k/uyneqtbRO0Rs5mJ++U1eHiAtTHKbg8Oez2fN1KPAhSVpnCFAe4
 y8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zpcmkLvepjbGKQ3ACqSVKunOIWNZQhJb9SW/YrhLa2Q=;
 fh=pE4PsR3KhyHbcwRVmKwqWPPxST92sQwYNIPm7M/tZh4=;
 b=b3UZcLujBgIHOaoNZW3S9X8B1zoCkCi98GS9cpiScRRTVA2SN5D1nnGpYzxlWhnAbo
 0fsSL7vBaCyanmzTAfo0RGkurNSVGEbgJpw33ZFvBErLibn2LKojHT9pX2coX8890b5b
 P0G6W/fyNVPjNTsjBvIREyxedjQDaT3KzrrnKXAfUbgz7UKGzvz0+XbQB3negap5fcDs
 AP1ls4xmP/1OQMvaJvo0O2SDYpcVF4w1AbfrPzeSRgygdxkZmiVEN39v6SWd7CTewg6A
 EP1LOth8adpJNIoLD66IbvysPLEYtNaPrUlYI3qExaafEjp6+gTS67zam3/YoN8FHzeS
 Ixug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793794863; x=1794399663; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zpcmkLvepjbGKQ3ACqSVKunOIWNZQhJb9SW/YrhLa2Q=;
 b=JbuZURG6nIm4WO0aByLMNzq3QW0pGOPRdcGNHyoQe8dJ3mhyGBe3RVRNdjeOIpGED8
 0yR3rajLUCgrhxqDJN3KaNQ/bmKPDsi3hP5s90GkGFz9+w869CoeJgx34Ipbtjktxwbz
 MyeeDddCbgH1PimNi94CdoSjK1i3TG2COx1g6ByQKJqdvmCk9dLVbjeDtgOpBxoHPFbT
 Gz9tP10s6OqFDUHBTpIqc3zgLIjV5zgBxH6Vzkz913lbxb0MIRE3dJ/8jZNoanQn4Ng/
 kTRiRdqWgCS0Y/mqp/WeLYoWgEUd2SijhiNWFEBl7tdpExzw7JVPYY7HFLxStkKBD6xj
 nRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793794863; x=1794399663;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zpcmkLvepjbGKQ3ACqSVKunOIWNZQhJb9SW/YrhLa2Q=;
 b=Iomv6ySWrQMCbFz24rELeAlRNg4GaVyzsx2MkHumtPn3iHiR7ImbyffDTaQAqIRNYF
 zmDIsD771wBtqPlOo+eJO7CLKL3chNkR+hvsgbEyAWrvto4s+3mOrTVGXco3SwVTv6CS
 KBhEn80pMSbZJzKwTO7PDd6zyw+sVimvxefa2rAB1jmbaZpkke1VO56FlIflMwHOc+ix
 yA/zCqwgfBp/mw+L218ScDW8z96mDfP2CC7vXArqVqH5ky7qGeDy/qhKDuVaIwyecGrG
 HFgRCI0ehfu42DAG5XG+XQWbcLyaMIz24d/zXtt/QI+k+n3K+oL0EMMdqjiokrh6Ou/K
 TtBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzadEJDD4YonUI3sP/yB/DtwZMUo4kCk+YU4GGFFhiRlGKwGI+MU8hyOizLNN4WRsxymsS5Uh7T2+k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8tntYFkW5Mu2q8qWH17D/xzg7QQVxO+1Y9ad+j25G5FOfaqznK
 bNfinNbtnLji9lZgu+x7qfAUOl/cCkqJqdBXQgp9vWN8T/vlM1pfb6GBRHhS/id2t+Tl4FK1x55
 YKb4P9UKen1+SpM1Owhvs3uKEVnw7d/kl58PqvrBlRQ==
X-Gm-Gg: AYBFou3p+0PKBq6y/5OxSJibU/U0XhYasqnKyRhqh1pgvZEDtKA7VIn3yWrbfmSxLNF
 X4CyAdJvpgRIw1gniaD+ASen0/Utl4ko4nuniIwVuB6QQA2f9/2hBBPZGEu3onAk765exCU8wpb
 Nwrh+7kaCsm4eLU8O9PGaW6N/8zNDJJt78OTjaqJesmujmpG0pWNlEYW5x2V3XmbfzVnXYSD06O
 DzmjWWjVsGXBrC0TNOWv8THFNxQpYeb2hJ9hqKgnq+DERThJqdEqIEl2TxFf58dXfVMYglKziqE
 KACsObblQ6DU5h1oqapG3GilDrkY09beMbt2OJGclDRBOpV6UhK6eTEQ7vFFzLM3EUKHNZN+ykR
 9KSh0lpiCkMVdbLOK4wnFeVeDRpPIyI/l5xD9EO9/yrW0OHLzbZAYqXoCgeyHzXR7YNFWaUw=
X-Received: by 2002:a17:902:ef45:b0:2e9:5b20:1c2b with SMTP id
 d9443c01a7336-2eb36396190mr133772755ad.5.1793794862951; Wed, 04 Nov 2026
 04:21:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102-etna-mmuv1-iova-cycle-v1-1-1148f02da254@igalia.com>
 <eb6dc4502166eac99f1c5f8f579cc4c4fff94ef4.camel@pengutronix.de>
In-Reply-To: <eb6dc4502166eac99f1c5f8f579cc4c4fff94ef4.camel@pengutronix.de>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 4 Nov 2026 13:20:51 +0100
X-Gm-Features: AclHuK9Q86EuHEL6aid1MOBRmfEEKC9jeoNBaMIn0yDWb2US2IJq23YE1o0-1eg
Message-ID: <CAH9NwWcGfHZ8jVHdyBoDojs67FuOq6xxLNPnvLhqVUgn89oLPA@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Cycle through the MMUv1 address space again
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Lucas,

> Am Montag, dem 02.11.2026 um 13:22 +0100 schrieb Christian Gmeiner:
> > From: Christian Gmeiner <cgmeiner@igalia.com>
> >
> > On MMUv1, all clients share one address space and the allocator
> > always picks the lowest free IOVA. When a process frees a range,
> > it can immediately be reused by another process.
> >
> > The GL.FLUSH_MMU write before the next submit does not reliably
> > invalidate stale TLB entries for that range. The GPU may therefore
> > continue translating accesses to the old pages. Writes through
> > these stale entries are lost for the new owner and may corrupt
> > memory that has already been freed.
> >
> > The vendor driver works around this in a similar way. It does not
> > return freed MMUv1 ranges to its free list until the address space
> > is exhausted.
> >
> Do you have more info on which engine inside the GPU causes those
> issues? If the TLB flush doesn't work reliably we have a much bigger
> issue than just address space reuse. If the TLB entries of freed memory
> are not properly shot down the GPU may write to memory that has been
> reused for something other than GPU buffers with a malicious command
> stream. That would be a security issue that is not currently checked by
> our command stream validation.
>
> Can you help me understand this a bit better? Which circumstances do
> trigger this issue?
>

I found this while looking into the flaky GC2000 tests in Mesa CI.

Reproducer: Run piglit "copyteximage RECT" in a loop, one run right
after the other. 20 out of 21 runs fail. With a 1s pause between
runs, the GPU goes into runtime suspend and all runs pass. Some of
the flaky GC2000 dEQP tests (for example fbo.render.color_clear.tex2d_rgb)
fail for the same reason.

In the failing runs, the first part of the texture is correct, but
from some page onwards, all pages still contain their old content.
The GPU either did not write to them or the writes went somewhere
else. The border between good and bad data is always on a 4K page
boundary. The command stream is identical in good and bad runs.

The bug only shows up when a new process gets IOVAs that were just
freed by the previous process. If the allocator does not reuse them
right away, the failures disappear.

So GL.FLUSH_MMU does not always drop the old translations on this
GPU. You are right: the GPU can then write to pages that have
already been freed, and my patch does not fix that. It only makes
it much less likely to happen.

Galcore writes GL.FLUSH_MMU in the same way. It does not run into
this problem because its allocator only reuses freed ranges when
the address space is full.

With this patch, I managed to run 20 rounds of piglit in CI
successfully, with an empty flakes file:

https://gitlab.freedesktop.org/austriancoder/mesa/-/jobs/113663487

Is this the proper fix? I don't know. Maybe we need some special
handling for MMUv1 to make the flush work 100%. I could try playing
with some of the MC_MMU_*_PAGE_TABLE registers to see if
that helps.

Maybe you have a good idea or a gut feeling about how we could fix
this?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
