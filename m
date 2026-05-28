Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E69CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 14:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D989610F2DB;
	Thu, 28 May 2026 14:49:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Mo+dnrqq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9478810E2F9
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779979785;
 bh=OJJDUnp5ZGB7eJaK4RkkHVn9Y/x9ALExenskQ8NFqfM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Mo+dnrqqUUFz/YGaeU2EszgpBAzMxuKVzixWZiMCnvUiyru44zcEVX+TBd3Cu9s7c
 Ha3xZrrXhBYPE/iq+rgV0hIA+u8bR0t8CmgObeSAhrkKnlvG6XXfCA4ro028KeHXrz
 0b32BL0Ng0x/s1b0mb2qpEjr/aTE3alyUMw1M+tpPz28uR2M+mHj1c0YTpcqotr5Ph
 rdd/FZ4HEOFIep6Sdv3qhyB4RHyfn7HsBa6d5h7fIY5xXzKXkGikDPPW0omYhvCZdr
 GOWmVvCAoYXP+LaYW51Oiw7jkr1e9hS1pEYd4XnI1xTVrWx5J33kM4dzsJP3xSxLky
 ePygssAo1fKRA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 46BD117E0191;
 Thu, 28 May 2026 16:49:45 +0200 (CEST)
Date: Thu, 28 May 2026 16:49:41 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v5 1/2] drm/panthor: Implement evicted status for GEM
 objects
Message-ID: <20260528164941.35e36a4a@fedora>
In-Reply-To: <dhbTwVh9SgW4h4Fwktewag@collabora.com>
References: <20260521-panthor-bo-reclaim-observability-v5-0-49313994da55@collabora.com>
 <20260521-panthor-bo-reclaim-observability-v5-1-49313994da55@collabora.com>
 <dhbTwVh9SgW4h4Fwktewag@collabora.com>
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

On Thu, 21 May 2026 16:44:14 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> On Thursday, 21 May 2026 15:51:15 Central European Summer Time Nicolas Frattaroli wrote:
> > For fdinfo to be able to fill its evicted counter with data, panthor
> > needs to keep track of whether a GEM object has ever been reclaimed.
> > Just checking whether the pages are resident isn't enough, as newly
> > allocated objects also won't be resident.
> > 
> > Do this with a new atomic_t member on panthor_gem_object. It's increased
> > when an object gets evicted by the shrinker, and saturates at INT_MAX.
> > This means that once an object has been evicted at least once, its
> > reclaim counter will never return to 0.
> > 
> > Due to this, it's possible to distinguish evicted non-resident pages
> > from newly allocated non-resident pages by checking whether
> > reclaimed_count is != 0
> > 
> > Use this new member to then set the appropriate DRM_GEM_OBJECT_EVICTED
> > status flag for fdinfo.
> >   
> 
> Oops, feel free to drop this paragraph in the commit message when
> applying.
> 
> 

Queued to drm-misc-next with this paragraph removed.

Thanks,

Boris

