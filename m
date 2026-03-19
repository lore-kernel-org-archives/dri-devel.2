Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE368108E1F8
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308D810E9A9;
	Thu, 19 Mar 2026 11:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iiZmfLJj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970FD10E9A6;
 Thu, 19 Mar 2026 11:53:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CBD394388C;
 Thu, 19 Mar 2026 11:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034EEC19424;
 Thu, 19 Mar 2026 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1773921231;
 bh=LAT+3NI5jlCHqSuRDDbQs0tHUk9ywZlB/MtsG4KYMds=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iiZmfLJjZhYiiTAsMUWHBjOEFauepALNXPx/JbXE5y4yVtNlL/syfs0a3FqJas+hq
 BOJ2RAr8HevNB9T7+cMqbnf4EtSfVdTTwHpPfmNMec/jHjrLxrHvp7V8fgdK+czP0x
 9NMD5dYh/00H9yh4QRs9Jln1T4F0hn2m1QTOSs4w=
Date: Thu, 19 Mar 2026 12:53:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Cc: Rosen Penev <rosenp@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>, Alex Hung <alex.hung@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, "chr[]" <chris@rudorff.com>,
 Sasha Levin <sashal@kernel.org>, Wentao Liang <vulab@iscas.ac.cn>,
 "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 for 6.112 and 6.6 0/2] amdgpu: fix panic on old GPUs
Message-ID: <2026031940-single-buddy-d53d@gregkh>
References: <20260228045356.3561-1-rosenp@gmail.com>
 <5828571.IbC2pHGDlb@timur-hyperion>
 <CAKxU2N9MHp+m3A0w38pfGEJUkLKCCsLgvmgAG3sfSn-Rhc0sgA@mail.gmail.com>
 <2332143.t9SDvczpPo@timur-hyperion>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2332143.t9SDvczpPo@timur-hyperion>
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

On Sun, Mar 08, 2026 at 02:15:54PM +0100, Timur Kristóf wrote:
> On Wednesday, March 4, 2026 11:23:33 PM Central European Standard Time Rosen 
> Penev wrote:
> > The DC code path just works bettter. So what if suspend is broken. I
> > would much rather a working system. Hyprsunset for example doesn't
> > work without DC. No idea why.
> 
> It's great that it works better for you. Unfortunately that isn't the case for 
> everyone. It wasn't feature complete until 6.19 so it wasn't a feasible 
> default until then on these GPUs. Since 6.19 I would say it's pretty good now.
> 
> > Speaking of suspend, the fixes for it are fairly trivial to backport
> > to 6.12 as well.
> 
> Yes. I don't understand why those patches weren't backported.
> Like I said, I sent them for backporting to 6.17 many months ago and expected 
> to see them backported to older kernels as well.
> 
> > > Now that the situation is cleared up, is there anything else we need to do
> > > for these two patches here?
> > 
> > Speaking of which, it's probably best to take over here. It's not fun
> > dealing with stable. I also didn't author these patches.
> 
> The question was meant for Christian and Greg.
> What do I need to do to get these patches backported?

I've taken them now, thanks.

greg k-h
