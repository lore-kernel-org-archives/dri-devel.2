Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04466CD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D55010E325;
	Thu,  7 May 2026 15:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Tgcl6Rx6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A5F10E036;
 Thu,  7 May 2026 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778166228;
 bh=EoEm50eq18e3JDHSSBDVklCEN8e3aV3FIWaW7RmeUkc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Tgcl6Rx6RUwgIgvHBRoTqoUS8RYyZeNRieaTPs7AscQKz8h28tpcnt5eHLaKf5UMF
 tAF/Gh85D3rtNa2HHmTxTY6E4/SSI37ekgLPteUh6i9FsDIjxfwRNzdwhxMx6aRq8L
 LS0KAkxnkQ7c1Lt1F+evXMlSNxUd3cV3q4u4pgU/q/wRmLj1r5niD+bvlV+goDu+hr
 gUQlXIqBilYqfOkC1V7tFjmkqjWAh0bOi71ovlE+hFEGeUTrj7+rbHs3FmiXzS7SQV
 9HqGcxnKXQUsLgfYlIpcbPBVTvn5fijyml78CZjm6QKsRE7W7NDi+qzOfHicbxP3X8
 tHfqvoWanU8sw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D46B617E124B;
 Thu,  7 May 2026 17:03:47 +0200 (CEST)
Date: Thu, 7 May 2026 17:03:43 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>, Chia-I Wu
 <olvaffe@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry
 Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn
 Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/panthor: Don't use the racy
 drm_gem_lru_remove() helper
Message-ID: <20260507170343.044934a0@fedora>
In-Reply-To: <afykcyiURGZh0xdr@e142607>
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-1-e7721526de96@collabora.com>
 <afxi9ab1O9J_7J1Y@e142607> <20260507141027.166ab00d@fedora>
 <afykcyiURGZh0xdr@e142607>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 7 May 2026 15:40:51 +0100
Liviu Dudau <liviu.dudau@arm.com> wrote:

> On Thu, May 07, 2026 at 02:10:27PM +0200, Boris Brezillon wrote:
> > On Thu, 7 May 2026 11:01:25 +0100
> > Liviu Dudau <liviu.dudau@arm.com> wrote:
> >   
> > > On Wed, May 06, 2026 at 02:16:26PM +0200, Boris Brezillon wrote:  
> > > > drm_gem_lru_remove() dereference stores drm_gem_object::lru in a local
> > > > variable that's then dereferenced to acquire the LRU lock. Because this
> > > > assignment in done without the LRU lock held, it can race with
> > > > drm_gem_lru_scan() where drm_gem_object::lru is temporarily assigned
> > > > a stack-allcated LRU that goes away when leaving the function. By
> > > > the time we dereference this local lru variable, the object might already
> > > > be gone.
> > > > 
> > > > It feels like drm_gem_lru_move_tail() was never meant to be used this
> > > > way, because there's no easy way we can avoid this race unless we defer
> > > > the locking to the caller. Let's add an explicit LRU for unreclaimable
> > > > BOs instead, and have all BOs added to this LRU at creation time.    
> > > 
> > > I would argue that drm_gem_lru_scan() is broken by design. If you're going
> > > to release the LRU lock in the middle of a loop you can expect that someone
> > > will get hold of your stack-allocated LRU and end up picking the pieces.  
> > 
> > I think it's fine as long as you always use the drm_gem_lru helpers to
> > manipulate the lru field, which is true of a lot of kernel constructs.  
> 
> I think drm_gem_lru_scan() should never set an object's lru field to still_in_lru.
> It should set it to NULL when the object's node is removed from its lru and add
> it into still_in_lru without making the drm_gem_object->lru to point back to it.
> At the very end when we splice back the still_in_lru list back into lru's list we
> can then update obj->lru.

Then you run into another race between drm_gem_lru_scan() and
drm_gem_object_release(), where the LRU removal in _release() is
skipped because obj->lru is NULL, and all of a sudden, the still_in_lru
list has an element that's freed. Honestly, I don't think obj->lru
pointing to a stack allocated object is a problem as long as we don't
let gem users play freely with obj->lru (which we shouldn't do anyway).

> 
> >   
> > > This patch is fine in itself by trying to avoid stepping into the fight,
> > > but I think we should also add a warning in drm_gem_lru_scan() for future
> > > users to be aware of the dangers.  
> > 
> > Warning the user about what? There's nothing they can do about it, and
> > I don't even think it's unsafe per-se, unless someone goes off and
> > stores the drm_gem_object::lru value somewhere else while their shrink()
> > callback is called, and accesses it later, outside the shrinker path.
> > Given drm_gem_lru is not refcounted, there's no way one could safely
> > hold on the LRU they saw in the shrink() callback anyway, so I don't
> > think that's fair to blame the drm_gem_lru API for this kind of misuse.  
> 
> Yeah, that would be the warning: don't store the object's lru as you might
> get a temporary one that will become invalid after the shrinker has run.

Oh, you mean a comment explaining this should be avoided, not an actual
drm_warn(). Then yes, I think it's fine to document the expectations in
the drm_gem_object::lru doc.
