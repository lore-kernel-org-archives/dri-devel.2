Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94727CD4840
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 16:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032A010E82D;
	Mon, 11 May 2026 16:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="JxYED0L5";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8C30410E828
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 16:27:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0CF416F2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 09:27:28 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 E4CEA3F85F
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778516854; bh=YonN8VL2BLEr4Q2OyxUKcgv3XivnvGDz2zoMI7+3kf0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JxYED0L5hD5f7S39vURTwe1p9M2Q3bGEayeu1Qa2P0mPELsUCPOi0xz58TkqdsYCO
 fo7Tna5AlR+Z1Q+coP6OmtTt14O/djiMCfeX86vcppVIZxWZv7G2G6XyfsJ5xEWQs6
 zJz2neF3KadJKzkjRKU1+8JyWgXDI2+JnncybbDI=
Date: Mon, 11 May 2026 17:27:13 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/gem: Make the GEM LRU lock part of drm_device
Message-ID: <agIDYZlOpZB5eZke@e142607>
References: <20260508-panthor-shrinker-fixes-v2-0-39cdb7d577c9@collabora.com>
 <20260508-panthor-shrinker-fixes-v2-4-39cdb7d577c9@collabora.com>
 <CACSVV00NdUKe6-05U3g0q5X3tw4zmqO_s2gk-KZxQVykpydvAA@mail.gmail.com>
 <20260511174429.35afcdee@fedora>
 <CACSVV02HQ-ci8mHg4os7e-yaf51hdHyQ6cFa9tGOpc9=keL28Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV02HQ-ci8mHg4os7e-yaf51hdHyQ6cFa9tGOpc9=keL28Q@mail.gmail.com>
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

On Mon, May 11, 2026 at 09:16:49AM -0700, Rob Clark wrote:
> On Mon, May 11, 2026 at 8:44 AM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Mon, 11 May 2026 06:18:44 -0700
> > Rob Clark <rob.clark@oss.qualcomm.com> wrote:
> >
> > > On Fri, May 8, 2026 at 3:41 AM Boris Brezillon
> > > <boris.brezillon@collabora.com> wrote:
> > > >
> > > > Recently, a few races have been discovered in the GEM LRU logic, all
> > > > of them caused by the fact the LRU lock is accessed through
> > > > gem->lru->lock, and that lock itself also protects changes to
> > > > gem->lru, leading to situations where gem->lru needs to first be
> > > > accessed without the lock held, to then get the lru to access the lock
> > > > through and finally take the lock and do the expected operation.
> > > >
> > > > Currently, the two drivers making use of this API declare device-wide
> > > > locks, and there's no clue that we will ever have a driver that wants
> > > > different pools of LRUs protected by different locks under the same
> > > > drm_device. So we're better off moving this lock to drm_device and
> > > > always locking it through obj->dev->gem_lru_mutex, or directly through
> > > > dev->gem_lru_mutex.
> > > >
> > > > If anyone ever needs more fine-grained locking, this can be revisited
> > > > to pass some drm_gem_lru_pool object represent the pool of LRUs under
> > > > a specific lock, but for now, the per-device lock seems to be enough.
> > > >
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > >
> > > Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>
> >
> > If every one is happy with patch 4, I'm tempted to drop patch 1 and 3,
> > since they are irrelevant if the locking is fixed the way it is in this
> > patch. Question is, do we care about patch 2 being backported to stable
> > kernels then?
> 
> Or backport patch 4?  It's a bit bigger, but mostly mechanical.. with
> only issue being backporting across addition of panthor shrinker, I
> guess?

I'm agreeing with Rob here, but it makes a mess of the backport. Maybe split
patch 4 into the drm_gem.c and msm changes and make another one for panthor,
as that is still in linux-next?

Best regards,
Liviu

> 
> BR,
> -R

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
