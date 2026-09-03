Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8495CC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9881A10F479;
	Thu,  3 Sep 2026 08:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F3Lgj7dq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE11210F479
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:30:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1B17600D1;
 Thu,  3 Sep 2026 08:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424A61F000E9;
 Thu,  3 Sep 2026 08:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1788424203;
 bh=wnGZxPBdOlznc/8mB6JQ2wgYprEsmK93tjnCCBwxzGk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=F3Lgj7dqtVIbV3TtSlR9AE8nRwjvTBBsywJkQXDkrXqrylnGo8hXCW3YSbxkYCMsG
 HES3SRK71bXj1zTL5Bids/Lr+tqR0UzmW5rfk5N3q+K9v5Qe0MUc3G8u9N79KMVEk7
 x/e2m5ikSaxBYSIdnQaxEdHCzhW8VNA7Wj/qGoNc=
Date: Thu, 3 Sep 2026 10:29:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Anshika Jain <anshikajain196872@gmail.com>,
 Andy Shevchenko <andy@kernel.org>, sashiko-bot@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: fix len<=0 buffer overflow in
 define_fbtft_write_reg()
Message-ID: <2026090347-squiggle-girdle-5ff4@gregkh>
References: <20260902045026.7442-1-anshikajain196872@gmail.com>
 <87wlt3vnzp.fsf@yellow.woof>
 <CABj3sPEMo3B9B0ynfLGD=NmMu+0zpZ_Ydf2yyT7NDaT3DDNq=A@mail.gmail.com>
 <87cxuu68u3.fsf@yellow.woof>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cxuu68u3.fsf@yellow.woof>
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

On Thu, Sep 03, 2026 at 10:24:36AM +0200, Nam Cao wrote:
> No html email please, the mailing lists will not get them.
> 
> Anshika Jain <anshikajain196872@gmail.com> writes:
> > I'd like to keep this as a small safety check for the future, not as a fix
> > for a bug happening today. If you think that's not worth adding, I'm fine
> > dropping the patch.
> 
> As mentioned, such bug would show up immediately in testing. So I vote
> dropping it.

Agreed, I've now dropped it from my review queue.

thanks,

greg k-h
