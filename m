Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5251CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 12:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDBA910F0F3;
	Thu,  7 May 2026 12:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="H0sxO4IP";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D070E10F0F3;
 Thu,  7 May 2026 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778155833;
 bh=VzeTl1zd/0YqxA7PQbXWH87HGQtycpS00hXPs1oynRM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=H0sxO4IPU3e5uKOI2s/JrND6tYmrn5NV3IMqpmvH5O901Q0IkfumPjlbtzff1CDOX
 voD2ZfQsTZRnOUI7oaOzvU6ZsvmK6FW+taKt+9lLYQ5oA9ZBOo3Nk1BqOmYWVIw5VL
 KiGlS1gL5bgcnJGP7XKn9kKxgaEGVGspTehjuZN7DOK7ArgY+LTa9MBcZ4YAXpFRWO
 SDweQi6GfFt1OaVXFh7tLTNhQFKqM9BIy0R51fEoJ3y2Qw0cPFp4gPe57Abfn41WT3
 aPRj+MLoc+R4dWVydatbAdknxakTRdLxWLxUVkSlbewnZOv0jGDoFUZ2I2GhSYTpxI
 qjq3Y7fXXuAXA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BB9AF17E125C;
 Thu,  7 May 2026 14:10:32 +0200 (CEST)
Date: Thu, 7 May 2026 14:10:27 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org
Cc: Steven Price <steven.price@arm.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Maarten Lankhorst
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
Message-ID: <20260507141027.166ab00d@fedora>
In-Reply-To: <afxi9ab1O9J_7J1Y@e142607>
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-1-e7721526de96@collabora.com>
 <afxi9ab1O9J_7J1Y@e142607>
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

On Thu, 7 May 2026 11:01:25 +0100
Liviu Dudau <liviu.dudau@arm.com> wrote:

> On Wed, May 06, 2026 at 02:16:26PM +0200, Boris Brezillon wrote:
> > drm_gem_lru_remove() dereference stores drm_gem_object::lru in a local
> > variable that's then dereferenced to acquire the LRU lock. Because this
> > assignment in done without the LRU lock held, it can race with
> > drm_gem_lru_scan() where drm_gem_object::lru is temporarily assigned
> > a stack-allcated LRU that goes away when leaving the function. By
> > the time we dereference this local lru variable, the object might already
> > be gone.
> > 
> > It feels like drm_gem_lru_move_tail() was never meant to be used this
> > way, because there's no easy way we can avoid this race unless we defer
> > the locking to the caller. Let's add an explicit LRU for unreclaimable
> > BOs instead, and have all BOs added to this LRU at creation time.  
> 
> I would argue that drm_gem_lru_scan() is broken by design. If you're going
> to release the LRU lock in the middle of a loop you can expect that someone
> will get hold of your stack-allocated LRU and end up picking the pieces.

I think it's fine as long as you always use the drm_gem_lru helpers to
manipulate the lru field, which is true of a lot of kernel constructs.

> This patch is fine in itself by trying to avoid stepping into the fight,
> but I think we should also add a warning in drm_gem_lru_scan() for future
> users to be aware of the dangers.

Warning the user about what? There's nothing they can do about it, and
I don't even think it's unsafe per-se, unless someone goes off and
stores the drm_gem_object::lru value somewhere else while their shrink()
callback is called, and accesses it later, outside the shrinker path.
Given drm_gem_lru is not refcounted, there's no way one could safely
hold on the LRU they saw in the shrink() callback anyway, so I don't
think that's fair to blame the drm_gem_lru API for this kind of misuse.
