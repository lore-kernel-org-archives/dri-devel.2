Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8C4F9937A
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D61F10F0B7;
	Thu, 23 Apr 2026 11:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A9zIJ8W5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAEE10F0B7;
 Thu, 23 Apr 2026 11:40:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D18D7406C6;
 Thu, 23 Apr 2026 11:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D82C2BCAF;
 Thu, 23 Apr 2026 11:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1776944441;
 bh=XWpyzthTDl8osOJZCyGUAdA1IW4nOmyc8fO7wAVzzhk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A9zIJ8W5rUljqWcYOM2NMB8yCRv5QyRJso61Dr+oylA1kSt3a58vGL9WIEFRWn75I
 bPSFsVbGzQhg9+HByVx9r2XzSY1cjq3g/jexNuy/h4HkRV34294O5bRNUa5rlLt+Eg
 l544Jm3OVB4hk49omkplHMkr9Lg6RM4ONxWHrD6A=
Date: Thu, 23 Apr 2026 13:40:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org, Robert Garcia <rob_garcia@163.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Yifan Zha <Yifan.Zha@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] drm/amdgpu: remove two invalid BUG_ON()s
Message-ID: <2026042330-washhouse-amusement-db9e@gregkh>
References: <20260417074010.1607496-1-rob_garcia@163.com>
 <6064b45a-b8de-4848-856f-383d2d06680d@amd.com>
 <2026042335-probation-heftiness-7399@gregkh>
 <4885687.vXUDI8C0e8@timur-hyperion>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4885687.vXUDI8C0e8@timur-hyperion>
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

On Thu, Apr 23, 2026 at 01:34:42PM +0200, Timur Kristóf wrote:
> On Thursday, April 23, 2026 1:22:22 PM Central European Summer Time Greg 
> Kroah-Hartman wrote:
> > On Wed, Apr 22, 2026 at 04:11:15PM +0200, Christian König wrote:
> > > Those points are certainly valid.
> > > 
> > > I've also up-streamed a patch which completely rejects userspace
> > > submissions who try to use the CE.
> > > 
> > > The problem is that those BUG_ON() can lead to a deny of service because
> > > they crash the whole kernel.
> > > 
> > > A BUG_ON() is only justified if it prevents even worse things to happen,
> > > e.g. data corruption or it would crash later on anyway just not so
> > > obvious on what is wrong.
> > > 
> > > Otherwise we should use WARN_ON().
> > 
> > WARN_ON() crashes the kernel as well when panic-on-warn is enabled, as
> > it is in a few billion Linux systems :(
> > 
> > As this commit is upstream, and in other stable trees, I'll apply this
> > as it's not nice to have a simple way for userspace to crash the system.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Sounds reasonable, if you feel this improves stability.
> 
> That being said, there are many other ways besides this one for userspace to 
> crash the system equally easily.

Great, please fix up those as well :)
