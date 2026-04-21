Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA28DF327B1
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FC910E18D;
	Tue, 21 Apr 2026 07:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="V8ARIdFK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2AD10E18D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 07:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776756132;
 bh=X1FK6MGQqeVZ00VWoKOOt0LXViOHrk4okQXH1e/xxI4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=V8ARIdFKucwV35FI/vYmjmRn2dankVqcm5aDE+/Wy1a3VNE2kVzQz1RgLe/RH/zi2
 ZgxCi6qJeL8BoBWmJOCCSt6ISjIFjyqyTiJDKnWxw6klpDzESG4QW5s6gGWfkNPIR8
 evrvxjlT45flzkswuOGwvgy2ZGNHCi1wGbbA/gQ1Yx6TZ41YIQBQTHkgXQAHSD8qCZ
 pSUtXbYN8Du8l6+5p75CFefbSbViKfv6ELtoAlp9J3OgGlyuBb7IpYy8l7RhFzA97w
 7ikjCZjP9wrcH1ydL1WcpwAv+oqa/wGSkEI8cOtArpVJsolxAmNWFn9SnMwU4iH41c
 2T1joqg20HXCA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D6F4B17E1321;
 Tue, 21 Apr 2026 09:22:11 +0200 (CEST)
Date: Tue, 21 Apr 2026 09:22:07 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH 2/2] drm/panthor: Implement evicted status for GEM objects
Message-ID: <20260421092207.07bc1f6c@fedora>
In-Reply-To: <ArK2sKSOQ3qNB7BnrfkXew@collabora.com>
References: <20260420-panthor-bo-reclaim-observability-v1-0-a4d1a36ee84f@collabora.com>
 <20260420-panthor-bo-reclaim-observability-v1-2-a4d1a36ee84f@collabora.com>
 <20260420181735.2990999e@fedora>
 <ArK2sKSOQ3qNB7BnrfkXew@collabora.com>
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

On Mon, 20 Apr 2026 19:46:52 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> > > +
> > >  	panthor_gem_dev_map_cleanup_locked(bo);
> > >  	panthor_gem_backing_cleanup_locked(bo);
> > >  	panthor_gem_update_reclaim_state_locked(bo, NULL);
> > > @@ -788,6 +792,8 @@ static enum drm_gem_object_status panthor_gem_status(struct drm_gem_object *obj)
> > >  
> > >  	if (drm_gem_is_imported(&bo->base) || bo->backing.pages)
> > >  		res |= DRM_GEM_OBJECT_RESIDENT;
> > > +	else if (atomic_read(&bo->reclaimed_count))
> > > +		res |= DRM_GEM_OBJECT_EVICTED;
> > >  
> > >  	return res;
> > >  }
> > > @@ -1595,6 +1601,7 @@ static void panthor_gem_debugfs_print_flag_names(struct seq_file *m)
> > >  	static const char * const gem_state_flags_names[] = {
> > >  		[PANTHOR_DEBUGFS_GEM_STATE_IMPORTED_BIT] = "imported",
> > >  		[PANTHOR_DEBUGFS_GEM_STATE_EXPORTED_BIT] = "exported",
> > > +		[PANTHOR_DEBUGFS_GEM_STATE_EVICTED_BIT] = "evicted",
> > >  	};
> > >  
> > >  	static const char * const gem_usage_flags_names[] = {
> > > @@ -1648,6 +1655,9 @@ static void panthor_gem_debugfs_bo_print(struct panthor_gem_object *bo,
> > >  
> > >  	if (drm_gem_is_imported(&bo->base))
> > >  		gem_state_flags |= PANTHOR_DEBUGFS_GEM_STATE_FLAG_IMPORTED;
> > > +	else if (!resident_size && atomic_read(&bo->reclaimed_count))
> > > +		gem_state_flags |= PANTHOR_DEBUGFS_GEM_STATE_FLAG_EVICTED;  
> > 
> > I think it'd be interesting to know the number of times a BO got
> > evicted.  
> 
> Agreed. Should I add that as a separate column?

Yes

> I think I'll keep the
> state flag even if I add a column, because even if it's technically
> redundant, it'll still be useful to see without having to compare
> three different columns.

Sure, keeping the "evicted" flag is fine.
