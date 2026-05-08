Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9038CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3D810E40A;
	Sun, 10 May 2026 10:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="FX5tuxwn";
	dkim-atps=neutral
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816FA10E029
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 12:55:51 +0000 (UTC)
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
 (Authenticated sender: d@ilvokhin.com)
 by mail.ilvokhin.com (Postfix) with ESMTPSA id E1C73D0175;
 Fri, 08 May 2026 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
 s=mail; t=1778244950;
 bh=L9LkP6IfnwuKgt1YNp8V3Dt/LBOhrd1qXUDJMhw/7h0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FX5tuxwnivsbvqENwf3dClXXsMHLdk4v/lilJMPu/NpBR/HTNXPwaDOL6QG30RXr0
 IdEv1gxNFGjPmslIbzyUIsXaoemqsXLPjLZXz9ig0+tzSsIG9E2F4r40tKksc5p4jg
 UNVUsR8MyOZK5TF6Ou728b8a8cSHLNtlwQ4q4OXE=
Date: Fri, 8 May 2026 12:55:46 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Mike Marciniszyn <mike.marciniszyn@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mike Marciniszyn <mmarcini@meta.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] drm/fbdev-helper: Fix deletion of stub for
 drm_fb_helper_gem_is_fb()
Message-ID: <af3dUohsYKMSZK6V@shell.ilvokhin.com>
References: <20260501204313.127616-1-mike.marciniszyn@gmail.com>
 <afzVhCHu3FTwn9w0@shell.ilvokhin.com>
 <afzkApARAHVuAcLW@PF5YBGDS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afzkApARAHVuAcLW@PF5YBGDS.localdomain>
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

On Thu, May 07, 2026 at 03:12:02PM -0400, Mike Marciniszyn wrote:
> On Thu, May 07, 2026 at 06:10:12PM +0000, Dmitry Ilvokhin wrote:
> > On Fri, May 01, 2026 at 04:43:13PM -0400, mike.marciniszyn@gmail.com wrote:
> > > From: Mike Marciniszyn <mmarcini@meta.com>
> > >
> > > When CONFIG_DRM_FBDEV_EMULATION  is not defined this error results
> > > when building amdgpu_display.c with CONFIG_DRM_AMDGPU:
> > >
> > > error: call to undeclared function 'drm_fb_helper_gem_is_fb'; ISO C99 and
> > > later do not support implicit function
> > > declarations [-Wimplicit-function-declaration]
> > >
> > >  1777 |  if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Mike Marciniszyn <mmarcini@meta.com>
> >
> > Just hit the same problem, thanks for the fix.
> >
> > Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>
> 
> Thanks, but actually there was already a fix.
> 
> Take a look at linux.git/master:
> 
> commit 927011b65a875302d08709bbe82eaf4d0d96c5d5
> Author: Yury Norov <ynorov@nvidia.com>
> Date:   Mon Apr 27 22:49:41 2026 -0400
> 
>     drm/amdgpu: fix build for CONFIG_DRM_FBDEV_EMULATION=n
> 
> I encountered this in net-next, but the above has yet to be put into net-next.
> 
> Mike

Indeed. Thanks, Mike.
