Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FEACD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 11:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D53310EC73;
	Tue, 19 May 2026 11:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XNSXDvzm";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733EB10EC73;
 Tue, 19 May 2026 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779191517;
 bh=jbSzG0VtOj+D5yiSmtQrt4/n6aP0jMaP1sW019EHN2Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XNSXDvzmZDxB4QwZBHIeI8DvfDu/jGjXBYWoi9SvzDGquBb+aLlPq7+pBUe28++LG
 8lV2PtzjO7a9LHYpj9WiWBKfXKw4dl88CXJegMU4HdnYKYmPTfuyasXvIhsIEItXDP
 gv6U3wbQbSjZLt9RyETQSfP7ueK+9Oxpz0T5q6ceDnRWAKcS4m6fsbA7BJcPiC48yT
 fpMiGnJ1ezyJNh6NLlJ+RopDlqJg2y3+BioLf3F3rQdcxLhGGgC/psWo5ixYFWWG8i
 0Beo6NhQLnVI9PhsSpEnojfbxR0qXQEYRJAArntKWZXKAEDeJvthsu9EqXsrWhnZvS
 /oE3WmYBUfuAw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5512417E0B69;
 Tue, 19 May 2026 13:51:56 +0200 (CEST)
Date: Tue, 19 May 2026 13:51:53 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Mark Brown <broonie@kernel.org>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>, Chia-I Wu
 <olvaffe@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry
 Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn
 Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Rob Clark <rob.clark@oss.qualcomm.com>
Subject: Re: [PATCH v4] drm/gem: Make the GEM LRU lock part of drm_device
Message-ID: <20260519135153.42c3f4a0@fedora>
In-Reply-To: <a1920a93-ac61-4246-a57c-b10bada3d70c@sirena.org.uk>
References: <20260518-panthor-shrinker-fixes-v4-1-1920234470d5@collabora.com>
 <20260518165225.145175b1@fedora>
 <a1920a93-ac61-4246-a57c-b10bada3d70c@sirena.org.uk>
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

On Tue, 19 May 2026 12:37:16 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Mon, May 18, 2026 at 04:52:25PM +0200, Boris Brezillon wrote:
> > +Mark for the silent conflict resolution needed to reconcile
> > drm-misc-fixes and drm-next/drm-misc-next.  
> 
> This doesn't appear to be a drm-misc thing, I was seeing issues on the
> DRM tree.  The patch does seem to ahve resolved things though.  Please
> consider topic branches!

I'm just following the dim guide for resolution of conflicts between
drm trees[1], so that's probably something to discuss with the
DRM/DRM-misc maintainers. As for the suggestion to use topic branches,
I've never heard of it being used for -fixes vs -next conflict
resolution, every time I've gone through this process it was for
xxx-next vs yyy-next conflict (xxx and yyy being different subsystem
trees).

Maxime, Thomas, Maarteen, Sima and/or Dave, any suggestion/opinion?

[1]https://drm.pages.freedesktop.org/maintainer-tools/committer/conflict-resolution.html
