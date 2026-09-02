Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29DCC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22FE10F29A;
	Wed,  2 Sep 2026 15:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Fg1D/GVY";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBEED10F29A
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788363822; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cgVShNYSt+iFHQk3qVvMNuV9K1Bne7yyqmFC8CZeVEUMnCJulZH/+49WFMG50GRb0KeCdYPtVhoe9iyn664MXZAZk97mUWhjGFXHBQBVeFGW8go9M457zG+LUT6du0iWzN8yQQZA/kDLTeEW+UGL6wNFHmy40rqx6SQDPl4e6pY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788363822;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=C5RxmOHXXInNlzeMzSfYM95el3knAwvmC26Cdq9LXDw=; 
 b=SrFWnB+wXKaS3CSrw10HdCJZ015V41UqbZZfUmIJvLap0UawO9znqk8c8AJypV3uRfm9qn2bxCjt4Bye6AWRletLO6HRKw5BhqIfx/AMxKq3mz1/TD4VCavjqwtngBPUu5HMDjcmINHTIgtfUN/nEidpERlH98MGiWaX7kdfs3M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788363822; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=C5RxmOHXXInNlzeMzSfYM95el3knAwvmC26Cdq9LXDw=;
 b=Fg1D/GVYku5vOr1Ve4cTre4f1RXlJ9XKaLQTmiqjZ8IXJ9B5uFRI5jhaV2NbMnWZ
 byNhpurJbtLw3JQd1k05O7LSXG8nBkIqsRF6WQ5h4YAv2DoggzqCtlNpVRVeGxEcFQm
 oYIjzHUDp14l2Quy824oU5fUBWtWzIUBwYAzHquM=
Received: by mx.zohomail.com with SMTPS id 1788363820363785.9949142958419;
 Wed, 2 Sep 2026 08:43:40 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:43:34 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 13/17] drm/panfrost: Skip cache flush/invalidate when
 enabling perfcnt
Message-ID: <aphECpYnFuwIgzPQ@sobremesa>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-13-72a13b2c125d@collabora.com>
 <20260901153233.261fb14d@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901153233.261fb14d@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.352.18
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

On 01.09.2026 15:32, Boris Brezillon wrote:
> On Fri, 28 Aug 2026 21:56:53 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > The GPU cache flush/invalidate operation is unnecessary, because at present
> > all counters are always enabled for all sessions, and there are no plans to
> > expand the uAPI so as to let UM select specific counter groups.
> > 
> > If the above was ever implemented, then different counter groups being
> > selected between sessions might leave stale data in the GPU caches, so
> > the flush/invalidate would have to be reintroduced.
> 
> This explanation confuses me. To me, the reason we don't need a
> cache-flush has nothing to do with the fact we always enable all
> counters, it's just that, either the perfcnt buffer has been freshly
> allocated/mapped and the cache has no entry pointing to it, or it's
> been written already, and the flush should have happened after the
> dump. For the case where the enable happens after a RESET (which you
> introduce in one of the remaining commits, I guess), there's no flush
> needed either, because the RESET clears all the caches.

This is something I wrote after a chat with Steven about whether removing this flush/invalidate was fine.
If memory serves me right, he expressed his concern that flushing GPU caches after a sample might write
disabled counter data into system memory, but in that case UM should know better, and I guess reading off
disabled counter data is seen as undefined behaviour in the TRM.

> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > index f71534e741b6..ffc77121070e 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > @@ -124,21 +124,10 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
> >  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
> >  
> >  	/*
> > -	 * Invalidate the cache and clear the counters to start from a fresh
> > -	 * state.
> > +	 * Clear the counters to start from a fresh state.
> >  	 */
> > -	reinit_completion(&pfdev->perfcnt->dump_comp);
> > -	gpu_write(pfdev, GPU_INT_CLEAR,
> > -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > +	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> >  	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> > -	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_INV_CACHES);
> > -	ret = wait_for_completion_timeout(&pfdev->perfcnt->dump_comp,
> > -					  msecs_to_jiffies(1000));
> > -	if (!ret) {
> > -		ret = -ETIMEDOUT;
> > -		goto err_vunmap;
> > -	}
> >  
> >  	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> >  	if (ret < 0)
> > 

Adrian Larumbe
