Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D050C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B3C10E88D;
	Wed, 26 Aug 2026 13:24:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oATMkiFP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FBB10E88D;
 Wed, 26 Aug 2026 13:24:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B6AE60A5B;
 Wed, 26 Aug 2026 13:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7F51F000E9;
 Wed, 26 Aug 2026 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1787750691;
 bh=MVP0EPkKNDW2dWvhW3j8ACNrTESSJX2Su++vyE31fZ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oATMkiFP1WoVX5vpqBshYrUpDmi9mqHTaBCg8rHG7UCqUPsEdMTDLu8W4QYS/iAo2
 vNywpTkGxU0uZHl1m33o3MM89IyCDUcm+e3P2X5raqQ0rusyZfDAbhOWUuHDj1Abss
 XcDacxBSaZwiBSp2fZwa6WpZx6xsXiuM0VKklGjI=
Date: Wed, 26 Aug 2026 15:24:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux@treblig.org, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com,
 amd-gfx@lists.freedesktop.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/amdgpu: Remove is_idle method
Message-ID: <2026082641-captivity-wrongly-ca1f@gregkh>
References: <20260815180033.8958-1-linux@treblig.org>
 <CADnq5_PgZx7aDGFD5pPQ=1MvF9_N_omVojNiDQFHjs0Tqasv+A@mail.gmail.com>
 <2026082644-monetize-tingling-0abd@gregkh>
 <CADnq5_N0AxaDZswgEQ7BEcKw8mF2hnSbAQp-w9U2Fy-MaEw8Rg@mail.gmail.com>
 <2026082654-gangrene-support-8541@gregkh>
 <CADnq5_N+bXX2cFjxr0xHX9Yso6+OHh=9i=61boEsRedYwid9aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_N+bXX2cFjxr0xHX9Yso6+OHh=9i=61boEsRedYwid9aw@mail.gmail.com>
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

On Wed, Aug 26, 2026 at 09:15:00AM -0400, Alex Deucher wrote:
> On Wed, Aug 26, 2026 at 9:09 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
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
> I assume this is the series that fixes the warning you are seeing:
> https://lore.kernel.org/all/20260813143605.106104-1-mwen@igalia.com/
> We are working on picking it up now.

Ok, great, sorry for the confusion, my bad.

greg k-h
