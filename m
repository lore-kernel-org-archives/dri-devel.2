Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E58DCD5BB0
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 09:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF81710E48E;
	Thu, 21 May 2026 09:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="T5mzFTbl";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B5210E483
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:07:37 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490229aa522so24479025e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 02:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1779354456; x=1779959256; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWcZf8xQyNgHL46GgzNOnTpRTb6xpQnkpgYkPgYwfTU=;
 b=T5mzFTbl/MmDGcEYdrcoxp15n/8iTPFym8Vh7fHKI/hTze+Xww/O37ZkkrmgjOQZjm
 Qd7HKlEz3+0O+r+3W8z2GslCYPcv7KemYkTI7WOtiUMjHFTsQWrhtX9VFDSykqVEiJ38
 44S5QGzVa6bthu0yG6ghB5sz/QUGViKk4vqMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779354456; x=1779959256;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EWcZf8xQyNgHL46GgzNOnTpRTb6xpQnkpgYkPgYwfTU=;
 b=mmgv0mFx+4KfqfzT3Wg/H6ExtOwDe3l0jxLRL9SytKIdJI5AC/vEAwqT7b8PRT3V4C
 YwbtwnsEXubiSfMLwDv0A0u8/XgrQJKf/ttGnI3/NgYzgMvbVvQf4NN4KEMqgb/sH2q6
 Im1ym9uVgjXCG6vo4LON9ThkXWS+U20d31VMOxODvWGvn05/porXTn1e3Eicjvj85koP
 IAfvdFhHcnZD34tRV1rdGLzqH3OSdttpduv5ztJ/ZjRF2QGl313zabiX/wkaeOlvHg3h
 kY40eBDLYU8UTCkutzbv/BvN1ngT9tfYs6QQXSWs2bETB7wNr0yGS0NQ/TrHmphOKwMr
 iKCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ipy+dOI9TbZvrFRTmFY8jstrQOXDl9ob459ISxgt5Mm6cCjNX+F8EDBBWydVsnnfWusTycHmN9V0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySuhcS7ZS0n/PqLociU+GxFEZd7FCpZdsvq5rMK6isrDuCRU0o
 8/RYB+52fwEXPYWMNFULRZuwhH6M64wQjrORIcXTv44CiZ0AFVZzGgdqOW1eYANBQNk=
X-Gm-Gg: Acq92OG/wfYUYlxN1T8Aj6TRfeetW4IwSiQiUB7KzQzjoX4prW2hlm4KM2Zp3j9AmJk
 pEZKCfHYqdGsbU/YjvPmzLVYFkc/xMMk/NcEidLtgXADUyAjOSCeDSPP/AgBPLozzzMztvLCq5w
 GYSFyoqSMzVogVBp8IhHDbYeepiCOGjJzv16HwpCL3wRxLurHcSCcichOWSduAa+jo5Envv3NS7
 EqdsSXOeU8m4hjcbBHhrMd60vnlwSJympnhhd8VKWGyY5u8A3FUQlNdlarKgGAXyGWgFNYGT6Oq
 jk/JaeFX+4Edk+MLxtPn8YPwCZBPjBjwQAOGiYt4Q3R86GXXp5P8klTln6h2x8iKvEXwzbHFCO2
 GGvkO+ozn3iMUBrMJMJQtdg8qKSn7h27wfelCTCfoPGJd9i/Vv122aV+LLas6H/8Pqc3slffk2D
 VH826iN2g2p+lNkfJJcssr+R8qGfvh04E5y+09l2uG1R1k0Q==
X-Received: by 2002:a05:600c:3b9d:b0:490:3b8b:6ba2 with SMTP id
 5b1f17b1804b1-4903b8b6e29mr19074285e9.8.1779354455523; 
 Thu, 21 May 2026 02:07:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7d9daasm1532388f8f.11.2026.05.21.02.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 02:07:34 -0700 (PDT)
Date: Thu, 21 May 2026 11:07:32 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <rob.clark@oss.qualcomm.com>
Subject: Re: [PATCH v4] drm/gem: Make the GEM LRU lock part of drm_device
Message-ID: <ag7LVI2mia92Oa8L@phenom.ffwll.local>
Mail-Followup-To: Boris Brezillon <boris.brezillon@collabora.com>,
 Mark Brown <broonie@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <rob.clark@oss.qualcomm.com>
References: <20260518-panthor-shrinker-fixes-v4-1-1920234470d5@collabora.com>
 <20260518165225.145175b1@fedora>
 <a1920a93-ac61-4246-a57c-b10bada3d70c@sirena.org.uk>
 <20260519135153.42c3f4a0@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519135153.42c3f4a0@fedora>
X-Operating-System: Linux phenom 6.19.10+deb14-amd64 
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

On Tue, May 19, 2026 at 01:51:53PM +0200, Boris Brezillon wrote:
> On Tue, 19 May 2026 12:37:16 +0100
> Mark Brown <broonie@kernel.org> wrote:
> 
> > On Mon, May 18, 2026 at 04:52:25PM +0200, Boris Brezillon wrote:
> > > +Mark for the silent conflict resolution needed to reconcile
> > > drm-misc-fixes and drm-next/drm-misc-next.  
> > 
> > This doesn't appear to be a drm-misc thing, I was seeing issues on the
> > DRM tree.  The patch does seem to ahve resolved things though.  Please
> > consider topic branches!
> 
> I'm just following the dim guide for resolution of conflicts between
> drm trees[1], so that's probably something to discuss with the
> DRM/DRM-misc maintainers. As for the suggestion to use topic branches,
> I've never heard of it being used for -fixes vs -next conflict
> resolution, every time I've gone through this process it was for
> xxx-next vs yyy-next conflict (xxx and yyy being different subsystem
> trees).
> 
> Maxime, Thomas, Maarteen, Sima and/or Dave, any suggestion/opinion?

Yeah, in general we do substantially fewer topic branches than other
subsystems. That's fallout from the committer model, which just want a
branch to push their patches and be done with it all - they're not full
maintainers, we don't magically have more of those. And sometimes that
results in more of a mess than necessary.

We try to keep the mess in check by doing backmerges as needed, ideally
before applying a patch. It's not super well documented since when/how to
backmerge is part of the section for maintainers:

https://drm.pages.freedesktop.org/maintainer-tools/maintainer/maintainer-drm-misc.html

The assumption is that committers will ask maintainers for help if they're
trying to push a patch that results in tons of conflicts when applying
(since development should happen on top of linux-next or drm-tip). Could
probably improve that a bit. But also, often it's only clear after
applying that a fixup is needed, and then it's pushed already. And with
committers there's no undoing pushed patches. So it's just part of the
deal with having lots of committers imo that history is a bit more a mess
at times.

Cheers, Sima

> [1]https://drm.pages.freedesktop.org/maintainer-tools/committer/conflict-resolution.html

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
