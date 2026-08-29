Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC27C61DBE
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 12:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9466710E0F1;
	Sat, 29 Aug 2026 12:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sk1SCSYT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC8B10E0F1
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 12:12:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2F4A60055;
 Sat, 29 Aug 2026 12:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206241F000E9;
 Sat, 29 Aug 2026 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1788005562;
 bh=e+inmMTn5EWTXc8jQrDrgX1pRmK3I54kXP3re76Ib9E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=sk1SCSYTK8jsRWXUxGDvLO5u4LVLBh8/rNdoOu7Hv/qF2fYA81EwRT2MfDqvzOYzh
 6Rg7hLXVvSpfh6oAq+oiD5ZZo9BsJs6UMWjfkZmr/oR5DiUrJUmeIQACPv2hmYxqe3
 5R7OqldmPdFrim52DvjWQTodJz8yGMkJa2BlA4nY=
Date: Sat, 29 Aug 2026 14:11:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Mackenzie <acm@muc.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Patch 3/9]: Replace scr_readw/writew by scr_readg/writeg, etc
Message-ID: <2026082934-irrigate-tastiness-c4ff@gregkh>
References: <apCEDM2sWv_M354-@MAC.fritz.box> <apCGKUotSUZLvngV@MAC.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apCGKUotSUZLvngV@MAC.fritz.box>
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

On Thu, Aug 27, 2026 at 06:47:05PM +0000, Alan Mackenzie wrote:
> 
> vt: 32b glyph: 3. replace scr_readw/writew by scr_readg/writeg, etc.

I don't understand these lines in your patches, where are they from and
what are they for?

thanks,

greg k-h
