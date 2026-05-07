Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E108FCD37AF
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB2010F3C9;
	Fri,  8 May 2026 07:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="OSEyMWuN";
	dkim-atps=neutral
X-Greylist: delayed 622 seconds by postgrey-1.36 at gabe;
 Thu, 07 May 2026 18:20:40 UTC
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1FB10E037
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 18:20:40 +0000 (UTC)
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
 (Authenticated sender: d@ilvokhin.com)
 by mail.ilvokhin.com (Postfix) with ESMTPSA id 7EBCBD011B;
 Thu, 07 May 2026 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
 s=mail; t=1778177416;
 bh=nY/8STcP17wypLqIMnvcBtkQl5e9XIg9NLgVj+cI2gI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OSEyMWuNxVXWFhRzBhkZDTBiz+5TltnQiEp5Uv3+bClIfu2NY4i9G4IT/BwShML1G
 qRv46qHsvjwY2h+iQ1OOD6RVQ06VSddnN0YKEQXKrQf922XlZEXHFLawKcbTLD66Um
 numpb/LiBz81Gq7Vs6DYAWpIO69zrYHpkPIjAUVo=
Date: Thu, 7 May 2026 18:10:12 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: mike.marciniszyn@gmail.com
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mike Marciniszyn <mmarcini@meta.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/fbdev-helper: Fix deletion of stub for
 drm_fb_helper_gem_is_fb()
Message-ID: <afzVhCHu3FTwn9w0@shell.ilvokhin.com>
References: <20260501204313.127616-1-mike.marciniszyn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501204313.127616-1-mike.marciniszyn@gmail.com>
X-Mailman-Approved-At: Fri, 08 May 2026 07:55:51 +0000
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

On Fri, May 01, 2026 at 04:43:13PM -0400, mike.marciniszyn@gmail.com wrote:
> From: Mike Marciniszyn <mmarcini@meta.com>
> 
> When CONFIG_DRM_FBDEV_EMULATION  is not defined this error results
> when building amdgpu_display.c with CONFIG_DRM_AMDGPU:
> 
> error: call to undeclared function 'drm_fb_helper_gem_is_fb'; ISO C99 and
> later do not support implicit function
> declarations [-Wimplicit-function-declaration]
> 
>  1777 |  if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Mike Marciniszyn <mmarcini@meta.com>

Just hit the same problem, thanks for the fix.

Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>
