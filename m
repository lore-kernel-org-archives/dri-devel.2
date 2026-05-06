Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5111CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D1F10EDEA;
	Wed,  6 May 2026 15:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="fYyFlf7s";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11F910EDEA
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 15:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778082204; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fdZH5j80Z+w5iKIl1C69yOFF3BMAxZ6YJBVntLffDu/PLXSXtflWSPdzmDsjRz1H5ll8Lxj6XcJNrD2Uy3ugy/2fgOhUsIonApZ45nOnLMOKeT7SHymtM/6mQrHdCyyJ+6RRkyGs+FZPHajMoYXv1nIjWjEy3nYBF1N5CJVqx+M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778082204;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zpLoZnJSSvx/I/AHhCM0A94vwhGcJxh2mbqqLYmrIIc=; 
 b=bP0za7HMejDuoXD6AnuqTkSVSPbxrDfNaqm12VxhnwU4oY17uibwc+GH3CjWXJ1BU75Vl7OXyZWE00TYDC+slIWlcffYTwrPfdp5xoSCg8uvPRkrQvnqRjODMZl/PxcrFJcf9rwt5TBfezrJZQbOTxhEk11ay5M2p2Eevc6Q8ts=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778082204; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=zpLoZnJSSvx/I/AHhCM0A94vwhGcJxh2mbqqLYmrIIc=;
 b=fYyFlf7sPC0AsGLtJsiynyxfwIzc1AcoecIXj0E7+u7mWfShV52O6lBF98xwzqos
 A+tkDgjgxTGvbxvTiZAoyW9nm0Yx6BCCcGj16wxRh9rTW7AO/rBAV4/U02R17fr0hZf
 uoTz5gpe7jtMuTvQRNXDdln/13TlGoVPJnFs6zGo=
Received: by mx.zohomail.com with SMTPS id 1778082202486120.18991077078181;
 Wed, 6 May 2026 08:43:22 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Steven Price <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 0/4] Let userspace explicitly trigger memory reclaims
Date: Wed, 06 May 2026 17:43:18 +0200
Message-ID: <qxAaM8FMQLuQt09qti64IA@collabora.com>
In-Reply-To: <829b8887-48de-4cfa-8bb2-79db1471bb8d@arm.com>
References: <20260506-panthor-explicit-reclaim-v1-0-44f82ac147ce@collabora.com>
 <829b8887-48de-4cfa-8bb2-79db1471bb8d@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Wednesday, 6 May 2026 17:06:56 Central European Summer Time Steven Price wrote:
> On 06/05/2026 11:45, Nicolas Frattaroli wrote:
> > RAM is not, in fact, cheap. Especially on embedded systems with a low
> > amount of memory, but known and well-defined userspace, more explicit
> > resource management can lead to better utilisation patterns. As an
> > example, a resource manager process on a purpose-built device may wish
> > to launch, and then explicitly swap out, memory of processes that are
> > kept "warm", to improve perceived startup latency of individual
> > full-screen applications without making the kernel figure out the usage
> > pattern from observation alone in order to swap out the right pages.
> 
> Have you considered memory control groups (memcg) for this purpose?
> Imposing a lower limit than currently allocated should trigger reclaim,
> so 'background' applications could have the limit lowered and then
> restored when moved to the foreground.

This is a suggestion in line with what I've made to the entity for
whom I am adding this, but was told that for them they really do want
tight control without having to use cgroups into technically doing it
by dynamically adjusting the limits of them.

I do think that writing 0 to `memory.high` to swap it out and `"max"`
to allow it to swap back in might work, though that'll then apply to
all of the process' memory, not just the GPU resources.

I will ask for clarification internally.

> 
> > To allow for this explicit control in the context of panthor's GPU
> > memory, add two new sysfs knobs. The first, mem_reclaim, runs an
> > explicit priv BO reclaim cycle on the TGID written to it.
> > 
> > The second, mem_claim, does the opposite: it swaps BOs back into active
> > memory.
> 
> How necessary is this mem_claim for performance? Have you done any
> benchmarking of explicitly claiming vs just allowing it to happen
> naturally? My gut feeling is that mem_claim should be unnecessary in
> most situations, but I'm prepared to be proved wrong.

I've done no benchmarking, but can do so if you have any preferred
workloads for this. Since we have to keep entire groups either in
memory or out of memory right now AFAIK, I don't expect this to be
very beneficial at all. At most we avoid a single fault I think.

I can drop the mem_claim part, though it may become relevant if we
ever have more fine-grained memory eviction where a single job or
group can run into multiple faults before everything it needs to
render a new frame is back in memory. In that case, it will be
beneficial, because it avoids doing the swap-in dance several
times while the user wonders why the UI is rendering at powerpoint
speeds as it touches memory pages that are still swapped out during
subsequent frames.

> 
> I'm not saying this series is necessarily the wrong approach - but I
> think we need a bit more justification for adding a new API for this.
> 
> Thanks,
> Steve

Kind regards,
Nicolas Frattaroli

> 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> > Nicolas Frattaroli (4):
> >       drm/panthor: Add freed_sz parameter to reclaim_priv_bos
> >       MAINTAINERS: Add sysfs ABI docs to list of panthor files
> >       drm/panthor: Add explicit memory reclaim sysfs knob
> >       drm/panthor: Add explicit memory claim sysfs knob
> > 
> >  Documentation/ABI/testing/sysfs-driver-panthor-mem | 34 ++++++++
> >  MAINTAINERS                                        |  1 +
> >  drivers/gpu/drm/panthor/panthor_drv.c              | 93 ++++++++++++++++++++++
> >  drivers/gpu/drm/panthor/panthor_gem.c              |  7 +-
> >  drivers/gpu/drm/panthor/panthor_gem.h              |  1 +
> >  drivers/gpu/drm/panthor/panthor_mmu.c              | 70 +++++++++++++++-
> >  drivers/gpu/drm/panthor/panthor_mmu.h              |  4 +
> >  7 files changed, 205 insertions(+), 5 deletions(-)
> > ---
> > base-commit: 2c4b906cd135bbb44855287d0d0eff0ee0b47afe
> > change-id: 20260506-panthor-explicit-reclaim-3dffed028d8c
> > 
> > Best regards,
> > --  
> > Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > 
> 
> 




