Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10DDCD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 09:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB60C10E186;
	Sat, 16 May 2026 09:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Do3ffFL4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F1A110E186
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 09:51:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 15F0660138;
 Sat, 16 May 2026 09:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A45C19425;
 Sat, 16 May 2026 09:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1778925115;
 bh=BUSSURdgLQ4YIhYewunrGBSH8jEmDTjnZ5bx7//RKTE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Do3ffFL45gZaMeh3qIm+wGMso7ZmQxL7Ss8PiQoU9Sr7W2vGtmPs6gnqidpTwuCX/
 AqcYWLKNQQCHHVXO7OhRFlzIkH53eVUtv/ORPnUxDRnRTLFmwHf0YhI4UHfkfsFRz0
 JkBA1oPR0ox/fv4utXvt2eGFVFXlRNmpyI+4BHJw=
Date: Sat, 16 May 2026 11:51:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: w15303746062 <w15303746062@163.com>
Cc: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
 melissa.srw@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: Re: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank disable
 and timer callback
Message-ID: <2026051633-skyward-parrot-cdd3@gregkh>
References: <20260515131826.388154-1-w15303746062@163.com>
 <2026051557-thermal-petite-7da0@gregkh>
 <581657f0.ba8.19e2eaaf003.Coremail.w15303746062@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <581657f0.ba8.19e2eaaf003.Coremail.w15303746062@163.com>
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

On Sat, May 16, 2026 at 10:43:35AM +0800, w15303746062 wrote:
> 
> Hi Greg,
> 
> Thanks for the quick response and review.
> 
> 
> At 2026-05-15 23:09:46, "Greg KH" <greg@kroah.com> wrote:
> >On Fri, May 15, 2026 at 09:18:26PM +0800, w15303746062@163.com wrote:
> >> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> >> 
> >> [Note: This patch addresses a legacy VKMS implementation deadlock specific
> >> to older stable trees (e.g., 6.18.y). Mainline has removed this code during
> >> the generic DRM_CRTC_VBLANK_TIMER_FUNCS refactoring.]
> >
> >Why not apply those upstream commits here as well?  No need to diverge
> >from Linus's tree, otherwise we will end up having a mess that nothing
> >can ever be backported to.
> >
> >How many commits need to be backported?  Have you tried?
> 
> I have looked into the upstream commits. The commit that removed this 
> vulnerable legacy code in mainline is:
> 02e2681ffe1a ("drm/vkms: Convert to DRM's vblank timer")
> 
> I tried to apply it to 6.18.y, but it does not apply cleanly. The reason 
> is that this upstream commit is not a simple bug fix, but a massive 
> refactoring. It completely rips out the custom VKMS hrtimer and ports 
> the driver to a newly introduced DRM core infrastructure 
> (DRM_CRTC_VBLANK_TIMER_FUNCS and drm_vblank_helper.h).
> 
> To backport commit 02e2681ffe1a, we would first need to backport the 
> entire DRM generic vblank timer infrastructure to 6.18.y. This seems 
> too intrusive and violates the minimal-risk policy for stable trees.

There is no "minimal-risk policy for stable trees".  And if there was,
the least ammount of risk would be to take the reviewed and tested
patches that are already in Linus's tree, and NOT take anything that is
not already there, as 90% of the time that we do that, it comes back to
bite us hard.

So please, just backport all the needed changes here.  Otherwise how are
we going to deal with the merge conflicts for the next 4 years in this
file?

Or, get the maintainers of this file to agree and review this one-off
change that it is acceptable.  As they are going to be the ones getting
the bug reports and not having their patches applied over the years, not
anyone else :)

thanks,

greg k-h
