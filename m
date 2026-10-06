Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9132BCA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 17:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17D210E002;
	Tue,  6 Oct 2026 17:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="HOlGHupv";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11AEF10E002
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 17:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791307096; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hB62AdVTW3x1ecqefvoG2W/JW41ycYHB40LUiQ8GXGthlU5XqE+zPmV10dcW+KX944xbtu70B9bjByqqq5HhaflPnc+kz20Ggtjmi6MwSFmukXVNaLrAy566t7OqjVVifdeHxmsBUSIf2FbmYJKLNoL0qziIuIo9tLZQ2R0bugk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791307096;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iS1yf3CNwcl80VFN3tKnDuJ+FW28sI/p4KBTK3BXXMU=; 
 b=YUjWQtNIxXqsRIpr+ItlK8Z4Jo6mRJmjjm3q+btJZkAAbI/aB/xKscYNjOHSncXOyZJTpFR4SI2bBnnT5fBopvbXDRgmE0fghzOIh8PhMg/CeAX/mQXWsk3tSptL/a7NbgVnLk0MLxdT5F7rMA5OSzgva8eWDaDJKYDi/hf7IdE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791307096; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=iS1yf3CNwcl80VFN3tKnDuJ+FW28sI/p4KBTK3BXXMU=;
 b=HOlGHupv0PAVAXR5ZVGpLM4ESoejT7ewfW0/m8TIC2+bFeFHQ+eKaifWn/el9y5K
 /P2IbqlP+MDw8uquzwWU42Leo8MkNVV//KnzwiOPymYTVg4iPVTyoWiUyySrLSOytra
 26MaTwSDAyMXBa0nc4ag5z8bFcQ1LX6KvS0WCCGw=
Received: by smtp.zohomail.com with SMTPS id 1791307095879578.8132568543292;
 Tue, 6 Oct 2026 10:18:15 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 12/15] drm/panfrost: Skip cache flush/invalidate
 when enabling perfcnt
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Rob Herring <robh@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <5af99ba3-97e7-4a05-b91c-7d53a508b635@arm.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-12-62beb08de207@collabora.com>
 <95174a67-0eee-4bf7-b883-9f1138c74a6f@arm.com>
 <20261005103855.655f8199@fedora-61.home>
 <5af99ba3-97e7-4a05-b91c-7d53a508b635@arm.com>
Date: Tue, 06 Oct 2026 18:18:10 +0100
Message-Id: <179130709099.1018806.10936869787038535987.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5063;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=KH6ZKcJBkF+E3qcs6J1FuVg8hcjrj4CvuWvbn7rmvi0=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqxS1TaUUGJgIw/uGz2vGNewjkbRtHcbSaI0pau
 En7BlrDSJuJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasUtUwAKCRAOJn5M7lND
 PbAAC/9daAfZfkD39wUdWvyKDydoDKLe+sHRVtmGFOKwpkx2wL5xedeLfa2ywdWNamnElfgKBIa
 IEh8Muo4+Q0oUzWs3XsfEEV0cqdJpIdiIBpTwhS8otjHqdSj9mJlgp1ptf0L5SP9iTvzzFP4Kyi
 l/xCK0wOr8p27BjU/oL6js5ah+UHl+mHeIfUbBL4WWaPmeRGk1nyG75OGsaq1jqaOSbokvmI/3+
 mZxfbI6vp7tSVjhuPnapE33o+vGdVyAbC32ffctU0F8Z/C67cz+fSEIQOc2WJBnCT25v660rKq4
 07omGogXa6gmui9b5mei3LUH1JirJtnCRgIAWZRFqK4hP/WbCWIkms0x/jsQQJAOssuiTtu/Bit
 MVghZ8P6WonkZxGN5756C3ld1dU8dcU2y8e2gBqXZnJJ/UEE2QqsuGU23oqz7f4t5o47iji7x/f
 xsycNQJaGXfwxtPMITRVt4pODB9u6vPH7t1rdiSfZi05UiWRqMQHXy2tEeQ672tnl6fKY=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On 2026-10-05 16:06:02+01:00, Steven Price wrote:
> On 05/10/2026 09:38, Boris Brezillon wrote:
> 
> > On Fri, 2 Oct 2026 16:14:38 +0100
> > Steven Price <steven.price@arm.com> wrote:
> > 
> > 
> > I don't think this can happen though, because _enable_locked() is
> > creating a BO (and its GPU mapping) just before enabling the perfcnt
> > block, meaning the buffer is known to have no dirty cacheline pointing
> > to it until the first dump happens. And we do flush and invalidate GPU
> > caches after each dump, so again, we should be covered.
> 
> The situation isn't actually a dirty cache line at the start, but a
> stale one. We start off with the memory matching a clean line in the
> GPU's cache. But because we don't have coherency the clean line can stay
> even if it's inconsistent with everything else.
> 
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

We're not doing this explicitly for BO memory from the CPU. AFAIK the only way to
do that manually is calling dma_sync_single_for_device() on physical addresses. I
suppose this means the reason why the CPU can see up-to-date dump data is because
a GPU cache flush also invalidates CPU caches for the same lines?

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
> 
> 
> Of course for the GPU to have ended up with that stale clean cache line
> means that the physical memory was previously used for something else on
> the GPU, so the newly allocated BO has to reuse memory from a previous
> BO that the GPU has accessed. And it's all "unlikely" due to the small
> size of the GPU's cache.
> 
> >>
> > 
> > I agree, but that's not a case we can hit in the enable path. I think I
> > mentioned the commit message was misleading, and that we should instead
> > talk about the fact the GPU is not supposed to have cached anything up
> > until the first SAMPLE following a the ENABLE step.
> > 
> > 
> > I think I was the one suggesting dropping this flush so that
> > panfrost_perfcnt_hw_enable() (in the last patch) has one less fallible
> > operation. Besides, I find it confusing to have a cache flush+inval in
> > a path where the GPU is not supposed to have accessed the buffer yet
> > (or later on, when we re-enable after a RESET, in a path where the GPU
> > has been reset and the caches are known to be empty).
> 
> So I agree this Should Be Safe™ because of how the driver is currently
> using the performance counters. If we really want to drop the invalidate
> then I think we need a comment explaining the logic. My worry is that
> someone extends this in the future (e.g. allow selecting which counters
> to enable) and breaks assumptions without them being documentead.

Perfcnt ioctl's are currently marked as unstable, but even so, adding the
initial flush/invalidate back in case anyone ever wanted to redefine the
uAPI to add support for fine-grained selection of counters shouldn't be
much of an issue. It's just that, as things stand now, it simplifies error
handling quite a bit, and I guess it's a reasonable trade-off.

I'll add a comment explaining why it's safe not to do the initial
flush/invalidate in a new revision.

> We normally do perform an invalidate when the GPU first touches a buffer
> (e.g. for a BO) - it's just normally more implicit because it's done as
> part of the job manager(/command stream).

Does this mean instructions that are part of the command stream passed to the
submit ioctl can trigger a flush/invalidate without CPU intervention?

> 
> Also "caches known to be empty" is a dangerous thing to assume on
> anything that could involve speculation - AFAIK Mali doesn't really
> perform any form of speculation, but I'm not 100% sure on that.
> Certainly with CPUs you don't get such a luxury of knowing what it might
> have populated in the caches.
> 
> Thanks,
> Steve


