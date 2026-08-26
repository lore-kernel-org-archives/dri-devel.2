Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBC7C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC3F10ED1D;
	Wed, 26 Aug 2026 13:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NANCi/AR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE92B10E88D;
 Wed, 26 Aug 2026 13:24:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1DEF2601E9;
 Wed, 26 Aug 2026 13:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF1C1F00A3D;
 Wed, 26 Aug 2026 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1787750651;
 bh=Cqd5rlsTxLaedU9aEgEh2zTTHv2aryvw/tfpqEpns7M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NANCi/ARJj0kpSlQWpB06NKXifUcRwurJI4/eytsCGqntcl7nIx33U0nHQaA5wHjU
 v4WIpIyoKOE+7CZAta5JzftUI9NHRhIfYkSi/zkDqfujmKktt8jMK7oCN8UquhS+gj
 CtzZLR7hc2eDAtxumBaj0oZ2031GxhEZwviG8ihU=
Date: Wed, 26 Aug 2026 15:24:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/amdgpu: Remove is_idle method
Message-ID: <2026082651-collected-algebra-26c8@gregkh>
References: <20260815180033.8958-1-linux@treblig.org>
 <CADnq5_PgZx7aDGFD5pPQ=1MvF9_N_omVojNiDQFHjs0Tqasv+A@mail.gmail.com>
 <2026082644-monetize-tingling-0abd@gregkh>
 <CADnq5_N0AxaDZswgEQ7BEcKw8mF2hnSbAQp-w9U2Fy-MaEw8Rg@mail.gmail.com>
 <2026082654-gangrene-support-8541@gregkh>
 <ao7l2qRUJpomS6Bw@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ao7l2qRUJpomS6Bw@gallifrey>
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

On Wed, Aug 26, 2026 at 01:10:50PM +0000, Dr. David Alan Gilbert wrote:
> * Greg KH (gregkh@linuxfoundation.org) wrote:
> > On Wed, Aug 26, 2026 at 08:45:29AM -0400, Alex Deucher wrote:
> > > On Wed, Aug 26, 2026 at 6:21 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Aug 17, 2026 at 11:27:41AM -0400, Alex Deucher wrote:
> > > > > Applied.  Thanks.
> > > >
> > > > Any hints on where this was applied and if it will get to Linus "soon"?
> > > 
> > > It will show up in drm-next after the merge window closes. 7.4 material.
> > 
> > Sorry, but this is hitting me now, pre 7.3-rc1.  Booting and getting a
> > zillion kernel warnings isn't ok, that's a regression.  Please get this
> > merged sooner than that.
> 
> Hey? This patch doesn't fix anything - it's purely dead code.
> My comment about the log errors I saw were about the head of drm-next
> I tested on, not about this patch.

Ah, my fault, my search found that and assumed this thread was the fix
for that.  Nevermind :)

greg k-h
