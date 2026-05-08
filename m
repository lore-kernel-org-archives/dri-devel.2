Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C670CD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 14:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C1810F4F1;
	Fri,  8 May 2026 14:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="IcBm+RQi";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2767C10F4EB
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 14:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778250096; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cZRc/W216m8fKpLIXQVwlhLul4vpcAlT1ooAPr3wpWSTXEiDejmftvdW6Za30E9TtHTcfjUO8la9qEwPHZowm/Nbj6W0MuvfplENlFxYGq9HT6WxQjFUHWFEVLXIDu9+pj16MWyAHtJt2ZKwACIXd6lPOyVfCUCk0qkfftfoox4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778250096;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4gloFifugrfVm3nhB4BnQvOjHDLnV2uv7DC6X6OQOkE=; 
 b=Eu9PUo9OL65TRIIqYM4XOGhv1GabuJXgXQ8ZpBODO75MPyZErN5HhGYkK/gAcaz0WItAjcvQVeb8IsACZOUM/LwD6chuBVcub6epzM75P/79F3A2VHx0lK4QX49lDUoNG/4pj3zly52XxQp2SOYBKMr0WjIQfuFDBxihX5i8gwY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778250096; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=4gloFifugrfVm3nhB4BnQvOjHDLnV2uv7DC6X6OQOkE=;
 b=IcBm+RQiOCmsRoDcyI/Ssk2fSfS56u386yqZVtrw6KV7icsem7URENHLixYSm6Kf
 JHGcV6vSx8iEJooUJoYhCYnZe54WbKBRAwAIv1iwmaEnnkE5b8dBjrlUwsVZB7oj7Pm
 qMZTCVyut8xzrcVhwG1jeYgagxGD0H/d2d860s4o=
Received: by mx.zohomail.com with SMTPS id 177825009450368.5628071820671;
 Fri, 8 May 2026 07:21:34 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] drm/fdinfo: Add "evicted" memory accounting
Date: Fri, 08 May 2026 16:21:29 +0200
Message-ID: <AUXeYVnmTfKzaCIY1xm-CQ@collabora.com>
In-Reply-To: <85d22f7e-af44-4a6e-911f-54830c91e339@ursulin.net>
References: <20260423-panthor-bo-reclaim-observability-v3-0-60af32164a4f@collabora.com>
 <20260423-panthor-bo-reclaim-observability-v3-1-60af32164a4f@collabora.com>
 <85d22f7e-af44-4a6e-911f-54830c91e339@ursulin.net>
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

On Friday, 24 April 2026 18:01:10 Central European Summer Time Tvrtko Ursulin wrote:
> 
> On 23/04/2026 13:33, Nicolas Frattaroli wrote:
> > Currently, there's no way to know for certain how much GPU memory was
> > swapped out. The difference between total and resident memory would
> > include newly allocated pages, which are not resident, but also aren't
> > swapped out.
> > 
> > Add a new drm_gem_object_status so drivers can signal when an object has
> > been evicted to swap, and add a new "evicted" counter to
> > drm_memory_stats.
> > 
> > Due to how the supported_flags bitmask is determined, the "evicted"
> > count won't be printed to fdinfo if there's no swapped out pages.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >   Documentation/gpu/drm-usage-stats.rst | 6 ++++++
> >   drivers/gpu/drm/drm_file.c            | 8 ++++++++
> >   include/drm/drm_file.h                | 2 ++
> >   include/drm/drm_gem.h                 | 2 ++
> >   4 files changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> > index 24d3012ca7a6..11570976095e 100644
> > --- a/Documentation/gpu/drm-usage-stats.rst
> > +++ b/Documentation/gpu/drm-usage-stats.rst
> > @@ -200,6 +200,12 @@ One practical example of this could be the presence of unsignaled fences in a
> >   GEM buffer reservation object. Therefore, the active category is a subset of the
> >   resident category.
> >   
> > +- drm-evicted-<region>: <uint> [KiB|MiB]
> > +
> > +The total size of buffers that have been evicted and are currently in swap
> > +space. Only present if there are buffers that are currently swapped out, and the
> > +driver implements reporting of this type of memory.
> 
> Please hold off merging this for a few days, I just noticed it and would 
> like to set aside some time next week to think about the semantics, how 
> it applies to discrete GPUs where evicted != swapped and some other 
> questions.
> 
> Regards,
> 
> Tvrtko
> 

It's been more than a few days (2 weeks, in fact), with no follow-up.
I'm getting a little grumpy because people expressing vague concerns,
and then disappearing over the hills for weeks, is an ongoing problem
in the DRM subsystem. If you want me to reword the documentation to
decouple eviction from swapping, then I can do that, but please say
so and then review the follow-up revision so that we're actually
working towards a solution and not just rolling the dice of who saw
the e-mail thread and felt like responding this time around.

Kind regards,
Nicolas Frattaroli


