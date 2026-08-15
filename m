Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FCCC5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34FD10E030;
	Sat, 15 Aug 2026 19:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="Pd6x59u8";
	dkim-atps=neutral
X-Greylist: delayed 1976 seconds by postgrey-1.36 at gabe;
 Sat, 15 Aug 2026 19:22:35 UTC
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D20B10E030
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 19:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=6WuypneQn3cTHhX0dwJvE+PWf9laq6MT/r6uqMRRYko=; b=Pd6x59u8xZNcIbia
 8YI98wuNpUOrPFLzovlpKqVkqBfljTvNdfQdhzuxpb3He/gOEA4vffxZWNygHgXtzkjh/IY2ZhbtC
 NBUPzS6nrjo7FNtIlj6BqBKgSRG9pN7FIlbZ9U9+W0x8P05wgYxAHW7lZvK8o4QCGYYymfASQ6P5r
 6rDbGLdoiCOvbrLnDm66v+apvqhck1IgBAOovzWgms+zqLRymvWJAzYr6iV1UBaz5mcMMs99xW3xZ
 Dmnbb6ctigLeNmhSwSgM8vtG7DJcLFotootLVQMVdR9cdhDKcK2xdQK7eX0p/y041A+R/YqD1O/rY
 OMIrFL18in+n+BW+1A==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wvJRp-00000002HnN-3eX2;
 Sat, 15 Aug 2026 18:49:37 +0000
Date: Sat, 15 Aug 2026 18:49:37 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/4] drm/amdgpu: Remove is_idle (non trivial functions)
Message-ID: <aoC0wVsRCZ74YlOL@gallifrey>
References: <20260815180033.8958-1-linux@treblig.org>
 <20260815180033.8958-4-linux@treblig.org>
 <20260815183749.21F7F1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260815183749.21F7F1F000E9@smtp.kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.101+deb13-amd64 (x86_64)
X-Uptime: 18:49:20 up 8 days, 22:27, 2 users, load average: 0.06, 0.02, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
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

* sashiko-bot@kernel.org (sashiko-bot@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Incomplete API cleanup: The `is_idle` function pointer remains defined in `struct amd_ip_funcs`.
> --
> 
> --- Patch [3]: [PATCH 3/4] drm/amdgpu: Remove is_idle (non trivial functions) ---
> commit cf17e80a1ef9c0d7e6925465357af056c949e840
> Author: Dr. David Alan Gilbert <linux@treblig.org>
> 
> drm/amdgpu: Remove is_idle (non trivial functions)
> 
> This commit removes the various is_idle implementations across the amdgpu
> driver since the method is never called. The same logic is mostly duplicated
> in the wait_for_idle method which remains in use.
> 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> > --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> [ ... ]
> > @@ -435,7 +424,6 @@ static const struct amd_ip_funcs cik_ih_ip_funcs = {
> >  	.hw_fini = cik_ih_hw_fini,
> >  	.suspend = cik_ih_suspend,
> >  	.resume = cik_ih_resume,
> > -	.is_idle = cik_ih_is_idle,
> >  	.wait_for_idle = cik_ih_wait_for_idle,
> 
> [Severity: Low]
> Since we are removing the .is_idle assignments across the tree, is it also
> worth removing the is_idle function pointer from the struct amd_ip_funcs
> definition in drivers/gpu/drm/amd/include/amd_shared.h to complete the
> API cleanup?

That's what I do in the next patch!

Dave

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260815180033.8958-1-linux@treblig.org?part=3
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
