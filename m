Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B3FCD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93DCB10E335;
	Wed, 13 May 2026 18:39:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k9w/lvRc";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBDE10E335
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:39:21 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-651c7ddf514so8096468d50.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778697560; cv=none;
 d=google.com; s=arc-20240605;
 b=JfwhpN02n3X1CF2J9+o9P8UW1I47afPwoY0uBF9oHcbQopUs/M/yE7BhXXqhd6egl8
 kPUAX20PsH3WqAocy9LwEf0tUU7NdQuYO1IvZe2nzO4C+5bJgLvmolhli0U6HF/OPzbX
 7HCsZa6I8p3ZK4PNAYa7U41PrS+uTCIxoPugTDMbJuM4D3HfMKjBvI3lcXUCq1E5s+iv
 MtzhEHETvxcVptv9Xu7jPhlAUU82yh5OshIA7PztVf4wHT3dUsF1oJNfL8dPLXsdEnw4
 lK81SP9JHjD8FWlxxGbTYr4312UAfHo1Yl8xVJmMOEoI5H4YffXTHXEwtF+OcZMLrS4y
 TNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QNjIBxdTI24J4nuaX+mtueI54MsI3QKTiFzpbMRC0CE=;
 fh=5CBiCYygUFq718NXy8pI7l04iaRZKN5qRWbrGzc/+sI=;
 b=XSJMEkQM2EXd3MLMjfg2LTiFSK5dUx06b9tYR9OFliSu+VXphW6XhIBJkqy2Ejh7EI
 Uq74O8qzenqV0AS+iOd9tNBerRvgcqID6kSb/k8ZHm18OnHvnFr1dm1fuueRe98fvjwT
 4hKJcZe2ldHUxpcmSUD0RMgQsHYhFS3+6cooQzG63oEBm2AEi+jeSv3+W4rTaAwAJ+0D
 qh2VRvLOmEmGrIJtYzLAKwG/4RZFQXwA2MGTwHSUwkLrAfwveILX7cd7dq48Maps2CnZ
 wQbr+djC54U0nPbcSsMaSynByOIh8I3aqBHyHOHjlhiTQH5qThyS8UnEIBxy0n+SwvEp
 xmNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778697560; x=1779302360; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNjIBxdTI24J4nuaX+mtueI54MsI3QKTiFzpbMRC0CE=;
 b=k9w/lvRc+1uzEU52O27ZrcKRmvbrDTCwqtURJX19Je/L6F38UbIcFrM8NVaBgVbszY
 m2I892+bfBCfiPCPFTHqJsQV2GD9/xXejrnRs/zgxHFi0JFwlkPsD7FogPRcUZSn+jSo
 w6mgG+W+WFag95UUEaAa8okJ2Y3VLVIeMGFjU3JRil2gq3sM43HUUL8ilYdHOtOUfVXm
 O10lWkeHVDsuRVD7R7BcqFZnP44ZzU/Uwsm5YJJF8fzWCdUiz7V2/u3HUiyjEljA1JAA
 Q5I0dsRhUzmfU9hy+cEBtuinADreUEgSTsJ2kLwYwkyAwkL7Fz9OA+NchvyYWMnxBE0L
 fogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778697560; x=1779302360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QNjIBxdTI24J4nuaX+mtueI54MsI3QKTiFzpbMRC0CE=;
 b=DKjb2sCf5i5ehGXZoBy3bKZVV2Og1qsXuf/SIjHalYWs7s0CPAb3bE1g2TtH0R9GbF
 hau5rNuFU7vfD+Zb+l6M5C8gzZjVP1v3qTk8DIwXh0xnp9zugYspFmjA1PUhuRgSeenQ
 Z4sNSBvEkGriTMHY4+McPlth++0JSiwpJKepy6f/DVUMb7omofvoM83VG2IEeBiTN2iF
 Jie1Pw90Z+KCziI6852jyCGMI7PSPndkOHCyq9h9O1x2IpfsT0aGGbtwJbbcmvXd3Yci
 GoOznah5uFSam3OtMApmnrt1R6RhqjSzDNy953WpXxwMq4AeBCz5E93wAieVzoQjY7xK
 rxow==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wub6FuRz5NvF+LEEX39Sykyp+1cJ64IutyTeF1uqmm7sLuuGzMPU82+1JfbVv9axzWa0tY9BfRAA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0xajgBjp9Jn47uOovP6JdsjM2fCOHyG2vxQaUlsgTvvYnWOzR
 0IEM713VBRyxJMDk2YTlyEGKlGLxPAo7cjnBkHpBgrvXI435Eo3WwoAq/NC5r+m8C1W9zIY9t4P
 /UArgd6DWGlucgHILyl7qXcPRv/utw69OS/hNoeY=
X-Gm-Gg: Acq92OGKdU3wkPnVB+/1P77Gx/ITjmZiX5bHCEX0ejXSUTWyMraK/eVXtfRkATv2VQr
 DoJDUkRcvz/9X8Ik1bB9byfXRwpJCXOUr8A4TPrbUKEW4UV+9Ioiwqu30bmKkiRn3qkI8qBRA0L
 W1yk5lJUItiQqd2M1MqE8dtYjg2E3dToQsQBFplFnmPDHWPMcnTG3HH7jKbaTMatmMIby1YWYvm
 gRmJxeD4yU0L90SfESxSRe3Q+XQmLuXqZS7SO0zBT+UA/fReRgx815L/mjcuNyN3ASsdN9gLqmI
 67pKaZ00mkeyUw1hTlpDsapvH2VSyPlXi4DGe9JKRlzfkX4njn8+6qkkMIGIa+rNUzsExX3M0Jp
 itD5juE6S
X-Received: by 2002:a05:690c:86:b0:7b2:136d:2436 with SMTP id
 00721157ae682-7c6d924d638mr37588517b3.8.1778697560337; Wed, 13 May 2026
 11:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-kasan-v1-1-d8d3e275d71b@gmail.com>
 <20260513111100.3b2e080d@fedora>
In-Reply-To: <20260513111100.3b2e080d@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 13 May 2026 11:39:09 -0700
X-Gm-Features: AVHnY4KdY32-E70JuFOOj5gszczZhcuozJZplwr54_LWaLyRlAdvTym_0krE_CA
Message-ID: <CAPaKu7RkKuGF4nGbOPhXtRWvJzf0njR6c=hn-CG2nTdEa1-DMw@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: set __GFP_SKIP_KASAN
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Chia-I Wu via B4 Relay <devnull+olvaffe.gmail.com@kernel.org>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, 
 Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org
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

+KASAN and shmem maintainers

On Wed, May 13, 2026 at 2:11=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 12 May 2026 10:36:28 -0700
> Chia-I Wu via B4 Relay <devnull+olvaffe.gmail.com@kernel.org> wrote:
>
> > From: Chia-I Wu <olvaffe@gmail.com>
> >
> > Pages that can be swapped out should be allocated with __GFP_SKIP_KASAN=
.
> > Rather than setting the flag directly, replace GFP_HIGHUSER by
> > (GFP_HIGHUSER_MOVABLE & ~__GFP_MOVABLE) instead, which should match the
> > preceding comment better.
>
> I'm not too sure GFP_HIGHUSER_MOVABLE & ~__GFP_MOVABLE is clearer than
> GFP_HIGHUSER (without MOVABLE in the name) to reflect we don't want the
> MOVABLE property.
>
> >
> > On a CONFIG_KASAN_HW_TAGS=3Dy system, without __GFP_SKIP_KASAN, the pag=
e
> > allocator assigns a valid tag to both the kernel mapping and MTE,
> > instead of assigning the match-all KASAN_TAG_KERNEL tag to the kernel
> > mapping. If userspace also maps the page with PROT_MTE and modifies the
> > MTE tag, accessing the page via the kernel mapping results in KASAN
> > invalid-access, such as
> >
> >   BUG: KASAN: invalid-access in swap_writepage+0xb0/0x21c
> >   Read at addr f5ffff81aa71dff8 by task WM.task-4/6956
> >   Pointer tag: [f5], memory tag: [f9]
> >
> > While userspace cannot map drm gem objects with PROT_MTE, the problem i=
s
> > shmem_swapin_cluster. When it swaps in a cluster of pages using our gfp
> > flags, some of the pages might belong to other mappings that have
> > PROT_MTE.
>
> Okay, let me see if I get this right. The gfp flags we set right now
> do what we want for out GEM mappings, it's only when swap readahead is
> involved that this becomes problematic:
>
> 1. swapin folio for GEM inode X
> 2. shmem layer optimistically does a readahead on the global swap, with
>    our GEM gfp flags
> 3. the next swap entry belongs to some other tmpfs/anonymous mapping
>    (not even something on the same GEM mountpoint actually)
> 4. because it's our gfp flags that get used for the folio allocation,
>   the KASAN poisoning takes place, thus messing up with the original
>   user-request PROT_MTE
Yes, that's right. At least that's what I observed.

A little more on the last point. shmem readahead allocates a folio for
an unrelated mapping using our gfp flags. It unpoisons both the page
tag and mte tag for the folio because our gfp flags do not have
__GFP_SKIP_KASAN.

When the unrelated mapping is an anonymous one, and when do_swap_page
maps the folio, arch_swap_restore restores the mte tag. This creates
mismatching page tag and mte tag. When, for example, swap_writepage
tries to access the folio, kasan triggers a false positive error.

>
> To me, this looks like a bad isolation of the readahead logic: we
> shouldn't cross the inode boundary, because gfp flags for one inode
> might be completely different from gfp flags for a different inode.
> Let alone the fact the boundary being crossed here is not just inode,
> it's basically the entire tmpfs mountpoint.
>
> TLDR; I strongly believe we're papering over some more fundamental
> issue in the shmem swap readahead logic: with MTE, we can no longer
> assume gfp flags are interchangeable, they have to be enforced and
> match exactly what the user of the swap entry expects, meaning
> readahead should be constrained by the inode boundary.
I totally agree. shmem should not readahead past its inode. Or perhaps
it should force __GFP_SKIP_KASAN when it does.

Adding shmem and kasan maintainers for suggestions/corrections.

>
> >
> > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> > ---
> > The latest snapdragons appear to have MTE support. drm/msm might need
> > the same treatment.
> > ---
> >  drivers/gpu/drm/panthor/panthor_gem.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/pa=
nthor/panthor_gem.c
> > index 13295d7a593df..08c03aa0db2f7 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gem.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> > @@ -1013,7 +1013,8 @@ panthor_gem_create(struct drm_device *dev, size_t=
 size, uint32_t flags,
> >        * going to pin these pages.
> >        */
> >       mapping_set_gfp_mask(bo->base.filp->f_mapping,
> > -                          GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_N=
OWARN);
> > +                          (GFP_HIGHUSER_MOVABLE & ~__GFP_MOVABLE) |
> > +                                  __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> >
> >       ret =3D drm_gem_create_mmap_offset(&bo->base);
> >       if (ret)
> >
> > ---
> > base-commit: 6101f78b684895d5860a96322e607e0f46f433ad
> > change-id: 20260512-panthor-kasan-10477239bad1
> >
> > Best regards,
> > --
> > Chia-I Wu <olvaffe@gmail.com>
> >
> >
>
