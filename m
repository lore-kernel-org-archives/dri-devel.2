Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D01FE51FC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F35EF10F4A6;
	Fri, 24 Apr 2026 09:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WZ+KVMEk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3BC310F4AA
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:49:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D691405F5;
 Fri, 24 Apr 2026 09:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16482C2BCB4;
 Fri, 24 Apr 2026 09:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1777024161;
 bh=bCmMLd7TT625UC3cRQD0EElDDVxXsrbMw+gPrcqFMLQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WZ+KVMEkBBHUpNlYmU5IIWtbtyf5QXsuQgX+/QHw0x7cJVo3iVTPDkQXxixA+EQap
 5fqnQ2S+GdO+sKzfQwN/40mcbooHmjK4P2TQyEAAVLtASArBnHm62P0MirKywSsvW6
 68xNHyXhihYSVy9ZQKT6UXp1EpM5OWQokJyYBIiY=
Date: Fri, 24 Apr 2026 11:49:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, andy@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fbtft-bus: replace function-defining
 macro with concrete functions
Message-ID: <2026042402-dictation-curtly-8267@gregkh>
References: <20260424092818.3322248-1-hossu.alexandru@gmail.com>
 <aes6JY3Ht6p1VpFa@ashevche-desk.local>
 <69eb3b01.5d0a0220.3c3ebd.f35b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69eb3b01.5d0a0220.3c3ebd.f35b@mx.google.com>
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

On Fri, Apr 24, 2026 at 09:40:48AM -0000, Alexandru Hossu wrote:
> On Fri, Apr 24, 2026 at 12:38:45PM +0300, Andy Shevchenko wrote:
> > I'm not sure this patch improves the code. What I see it's harder to follow.
> > NAK.
> 
> Fair point. Three near-identical functions hide the pattern the macro
> makes explicit. I'll drop this approach.
> 
> If there's appetite for a minimal fix, I can send a v2 that moves
> EXPORT_SYMBOL() outside the macro body only, leaving the function
> definition untouched. Otherwise I'll leave it as-is and wait for
> Greg's take.

Please leave as-is, there's nothing wrong with the existing code here.

thanks,

greg k-h
