Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5CAC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B254610E48D;
	Fri, 28 Aug 2026 05:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ARVC/fWA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B35E10E48D
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:47:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BA4D447C5;
 Fri, 28 Aug 2026 05:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F1F1F000E9;
 Fri, 28 Aug 2026 05:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1787896063;
 bh=/yqlHlAPjavdiFtaXHR1jSwfthvqrJDW2qjTGSZ2fOE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ARVC/fWAHi4wbcaBwUHdVyxOFpA+zDP2vDza8dVzAz4w2GoKUXeSfJ+NxKyNdCxAc
 RO8V8gxYpc5ggC75smc0LiNm78JB6wfP72uxbX5iSsgawi4t2Koj9yfjoEInAxX4k1
 dORc3KGJw3ZVBt3vuMOkNBB1x/Z5wmSSAlSYMG1w=
Date: Fri, 28 Aug 2026 07:47:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Preetish Amballi <amballip@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, andy@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Fix wrong controller name in fb_bd663474
Message-ID: <2026082818-finer-desecrate-d6b0@gregkh>
References: <20260809053253.14537-1-amballip@gmail.com>
 <CAHp75VcFkgrcBKJcvm8Br164MA8jM1xRKahBuZ-WPgEBwfi5Fg@mail.gmail.com>
 <CAEnJ0XJqjTDrV4Leq9ZGBQSRRJ8Gg0Nr9O8ZB90cCQftC5of=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnJ0XJqjTDrV4Leq9ZGBQSRRJ8Gg0Nr9O8ZB90cCQftC5of=w@mail.gmail.com>
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

On Fri, Aug 28, 2026 at 09:47:41AM +0530, Preetish Amballi wrote:
> Hi Team,
> 
> Could you please merge this.

It is the middle of the merge window, nothing can happen now.  If you
wish to see patches merged quicker, please help out in reviewing other
patches on the lists to reduce our workload.

Also, it's a comment change, not a major bugfix, so you want us to
handle regressions first, right?

thanks,

greg k-h
