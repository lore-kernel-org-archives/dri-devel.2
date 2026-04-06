Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF29EF4EC3
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 08:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4021010E06E;
	Mon,  6 Apr 2026 08:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pw66QeSS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C0F910E06E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 08:17:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C76843EE0;
 Mon,  6 Apr 2026 08:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5A2C4CEF7;
 Mon,  6 Apr 2026 08:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1775463453;
 bh=xUs+90y5FAnKMN1Wnt/wVKG65eqRgmIUfipA9j8ov+M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pw66QeSSV0OJYpQYUkc8tfsakgO/6joQ0alygYjATNwg84mEDm+gNoCNhi0i1BLAP
 vhjy8Cy8cIH+5u3oFSS3eKPuk53iqpRs7YoR5IYQqXmNyS0b7HJ/hWCl+SKUMornAZ
 LK2Umq4hpvtMpwyU5VpNz1LFTn6zrTnd64LNby5E=
Date: Mon, 6 Apr 2026 10:17:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matt Fagnani <matt.fagnani@bell.net>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Warnings and errors in drm_mode_config_cleanup when booting
 6.19.10 and 7.0-rc5
Message-ID: <2026040609-script-perpetual-16bb@gregkh>
References: <a8f058b3-ea2c-4af1-a19b-9ae2db46754c@bell.net>
 <9652ce0b-bb4c-489d-9e32-89c5af5c8101@leemhuis.info>
 <2026040259-glacial-reversal-9a75@gregkh>
 <35ed8f9a-66c2-40c3-a545-da4af629014f@bell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35ed8f9a-66c2-40c3-a545-da4af629014f@bell.net>
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

On Mon, Apr 06, 2026 at 03:54:39AM -0400, Matt Fagnani wrote:
> On 2026-04-02 08:12, Greg KH wrote:
> > On Sat, Mar 28, 2026 at 11:52:48AM +0100, Thorsten Leemhuis wrote:
> > > Matt, thx for the report.
> > > 
> > > On 3/28/26 11:30, Matt Fagnani wrote:
> > > > I could try to bisect. The commit
> > > > e493c135980f90c20308d1a98f2e0d1223951e94 drm: Fix use-after-free on
> > > > framebuffers and property blobs when calling drm_dev_unplug was included
> > > > in 6.19.10 and changed drm_mode_config_cleanup https://git.kernel.org/
> > > > pub/scm/linux/kernel/git/stable/linux.git/commit/?
> > > > h=linux-6.19.y&id=e493c135980f90c20308d1a98f2e0d1223951e94
> > > Did a quick search. Turns out this is mainline commit 6bee098b914176
> > > ("drm: Fix use-after-free on framebuffers and property blobs when
> > > calling drm_dev_unplug") -- and when searching for that (FWIW, this is
> > > not widely known, but that is really helpful in case like this, as the
> > > mainline commit id is way more relevant) is turns out that is in the
> > > process of getting reverted:
> > > 
> > > See https://lore.kernel.org/all/20260326082217.39941-2-dev@lankhorst.se/
> > > or 45ebe43ea00d6b ("Revert "drm: Fix use-after-free on framebuffers and
> > > property blobs when calling drm_dev_unplug"") [next-20260327
> > > (pending-fixes)].
> > > 
> > > Sasha and Greg: you might want to make sure to pick this up.
> > When it shows up in a Linus-released kernel, can someone remind us?
> > 
> > thanks,
> > 
> > greg k-h
> 
> 7.0-rc7 https://lwn.net/Articles/1066405/ had the patch Revert "drm: Fix
> use-after-free on framebuffers and property blobs when calling
> drm_dev_unplug" https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v7.0-rc7&id=45ebe43ea00d6b9f5b3e0db9c35b8ca2a96b7e70 Thanks.

Does not apply on 6.6.y or 6.1.y, so can someone provide a working
backport for those branches?

thanks,

greg k-h
