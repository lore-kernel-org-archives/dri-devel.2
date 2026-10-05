Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D68DCA5FFC
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF2CA10EDBC;
	Mon,  5 Oct 2026 15:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MIuVTQeL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D46710EDBC
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791214668;
 bh=A77lRtij3jyuzXv8DuCKc6btPgHKD5vhUgGG20sM+lM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MIuVTQeLjEjOjuKc2mvl1nFIbWUSiVX9gPBcogQVFX7lP0w8d8u74/gCurD6sF5lO
 iTla52yoE09QYgLqjG7l9jh5XFoi5Qbui64LneJa45wQELWFEqlxBIDlu/SiG6mFA4
 40ekiXbIpIlhZBNbiUWxywqvZ0zR+hW/OPccy6QCKODtQt8kyx/fgwiUbJemQ3Wa1l
 4wV9ADJE4Z1y2nQsqE2z+sAhtw3nBk5hsSBYwWMuNUQHLx+gbndBTNAQnPyjVc9nYJ
 VPB1jmOXKuyu3EtkAbBunTmjiX2G1A2ofP4xQOt59HRkhZNT+QjHUrhkfg4j/sTMeo
 G677/yzNKrLcA==
Received: from fedora-61.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 43F5817E0074;
 Mon, 05 Oct 2026 17:37:48 +0200 (CEST)
Date: Mon, 5 Oct 2026 17:37:41 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>, Rob
 Herring <robh@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Robin Murphy <robin.murphy@arm.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v12 12/15] drm/panfrost: Skip cache flush/invalidate
 when enabling perfcnt
Message-ID: <20261005173741.445715f0@fedora-61.home>
In-Reply-To: <5af99ba3-97e7-4a05-b91c-7d53a508b635@arm.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-12-62beb08de207@collabora.com>
 <95174a67-0eee-4bf7-b883-9f1138c74a6f@arm.com>
 <20261005103855.655f8199@fedora-61.home>
 <5af99ba3-97e7-4a05-b91c-7d53a508b635@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon, 5 Oct 2026 16:06:02 +0100
Steven Price <steven.price@arm.com> wrote:

> On 05/10/2026 09:38, Boris Brezillon wrote:
> > On Fri, 2 Oct 2026 16:14:38 +0100
> > Steven Price <steven.price@arm.com> wrote:
> >  =20
> >> On 29/09/2026 04:44, Adri=C3=A1n Larumbe wrote: =20
> >>> The GPU cache flush/invalidate operation is unnecessary. First off, t=
he
> >>> GPU doesn't read off the perfcnt sample buffer, only writes into it, =
so   =20
> >>
> >> I don't think this is entirely true. The GPU performance counter unit
> >> only writes the counters that are enabled, counters that share a cache
> >> line but are not enabled are not written by the performance counter
> >> unit, but if the L2 contains that cache line then the write can hit in
> >> the L2 and dirty the entire line including stale data where the
> >> unwritten cache line is. =20
> >=20
> > I don't think this can happen though, because _enable_locked() is
> > creating a BO (and its GPU mapping) just before enabling the perfcnt
> > block, meaning the buffer is known to have no dirty cacheline pointing
> > to it until the first dump happens. And we do flush and invalidate GPU
> > caches after each dump, so again, we should be covered. =20
>=20
> The situation isn't actually a dirty cache line at the start, but a
> stale one. We start off with the memory matching a clean line in the
> GPU's cache. But because we don't have coherency the clean line can stay
> even if it's inconsistent with everything else.
>=20
> CPU		|	GPU		| Memory
> ----------------+-----------------------+--------------------
>                 | clean line            | matches GPU cache
> ----------------+-----------------------+--------------------
>    CPU allocates new buffer and writes zeros
> ----------------+-----------------------+--------------------
> Dirty cache line| stale clean line      | unknown (cache line
>                 |                       | might be evicted)
> ----------------+-----------------------+--------------------
>    CPU cleans its own cache to memory
> ----------------+-----------------------+--------------------
> Potential clean | stale clean line      | Matches CPU
> cache line      |                       |
> ----------------+-----------------------+--------------------
>    Start dump without invaliding GPU
> ----------------+-----------------------+--------------------
> Potential clean | GPU writes data, and  | Unknown
> cache line      | hits in the clean line|
>                 | even though it's stale|
> ----------------+-----------------------+--------------------
>    CPU flushes the GPU's cache and invalidates it's own
> ----------------+-----------------------+--------------------
> No-cache line   | writes out clean line | Matches GPU
>=20
>=20
> Of course for the GPU to have ended up with that stale clean cache line
> means that the physical memory was previously used for something else on
> the GPU, so the newly allocated BO has to reuse memory from a previous
> BO that the GPU has accessed. And it's all "unlikely" due to the small
> size of the GPU's cache.

Hm, I'd say it's actually impossible because every unmap operation is
followed by a flush+inval of the GPU L2 and LSC, so for this stale
clean line to exist on the GPU side when a physical page is GPU-mapped
again, it would take a bug in the unmap logic or in the MMU HW, I
think. Am I missing something?

>=20
>=20
> >>
> >> The upshot is that if the CPU has cleared a block of memory which the
> >> GPU happens to have cached, then the "unused" counters may end up
> >> showing the old data before the CPU cleared it (if they share a cache
> >> line with an active counter). =20
> >=20
> > I agree, but that's not a case we can hit in the enable path. I think I
> > mentioned the commit message was misleading, and that we should instead
> > talk about the fact the GPU is not supposed to have cached anything up
> > until the first SAMPLE following a the ENABLE step.
> >  =20
> >>
> >> I have to admit it's probably somewhat academic given that Panfrost
> >> doesn't expose the ability to control which counters are enabled...
> >>
> >> Is there a good reason for this patch (i.e. have you seen a performance
> >> problem with doing the invalidate)? Otherwise I'd prefer we keep to the
> >> safe route rather than trying to over optimise cache maintenance. =20
> >=20
> > I think I was the one suggesting dropping this flush so that
> > panfrost_perfcnt_hw_enable() (in the last patch) has one less fallible
> > operation. Besides, I find it confusing to have a cache flush+inval in
> > a path where the GPU is not supposed to have accessed the buffer yet
> > (or later on, when we re-enable after a RESET, in a path where the GPU
> > has been reset and the caches are known to be empty). =20
>=20
> So I agree this Should Be Safe=E2=84=A2 because of how the driver is curr=
ently
> using the performance counters. If we really want to drop the invalidate
> then I think we need a comment explaining the logic. My worry is that
> someone extends this in the future (e.g. allow selecting which counters
> to enable) and breaks assumptions without them being documented.
>=20
> We normally do perform an invalidate when the GPU first touches a buffer
> (e.g. for a BO) - it's just normally more implicit because it's done as
> part of the job manager(/command stream).
>=20
> Also "caches known to be empty" is a dangerous thing to assume on
> anything that could involve speculation - AFAIK Mali doesn't really
> perform any form of speculation, but I'm not 100% sure on that.
> Certainly with CPUs you don't get such a luxury of knowing what it might
> have populated in the caches.

I suppose speculation pre-populating the caches with stale data would be
covered by the flush+inval we do after a map operation (this is
currently done in the unlock path regardless of the VM op, so both map
and unmap get it). I don't know, maybe the goal is to relax the flushing
policy around VM modifications in the future, but if things stay as
they are now, we can assume that a fresh BO being GPU-mapped guarantees
that no cacheline points to it until the first GPU access. But maybe
I'm missing something else...
