Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D21BC98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 16:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA9F10E4B7;
	Sun, 27 Sep 2026 16:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IV4X067J";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1758F10E4B7
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 16:41:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 254BA601F7;
 Sun, 27 Sep 2026 16:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3436D1F000FF;
 Sun, 27 Sep 2026 16:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1790527287;
 bh=D6N0ka76+/dxsubKOKwa/GFQ3VXKzfJaU5NPUA6DuSU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IV4X067JIQagFTorx2nsqMjUvRM5NSwWWvspgy6Iv541CJ/C6rwRfQWAhPJP54Zon
 wtPtnyfqT4EtnlgjpZiT55kR3CfkQNVV/nnj7IIkXY5QF5wmJJiAKGfm7oeRnceGI4
 oNicnc8Bskp7RXMyQHOsyNchu3TL1VDBkn53uqDA=
Date: Sun, 27 Sep 2026 18:41:25 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: krishnanand G <krishnanandgeetheswaran@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: fix spacing in macro calls
Message-ID: <2026092758-salary-wheat-735e@gregkh>
References: <CAG_41B+424_C5FA0PX9g1pDEPz2WX8JSeFhTWFpJ2TWgWLQjBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_41B+424_C5FA0PX9g1pDEPz2WX8JSeFhTWFpJ2TWgWLQjBw@mail.gmail.com>
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

On Sat, Sep 26, 2026 at 08:02:38PM +0530, krishnanand G wrote:
> The two calls to define_fbtft_write_reg() that use the default
> modifier have a space before the closing parenthesis. This triggers
> two checkpatch.pl errors.
> 
> Add an inline comment for the intentionally empty modifier argument.
> It satisfies the spacing check without changing the macro expansion.
> 
> Tests: scripts/checkpatch.pl --no-tree -f --terse --strict
>   drivers/staging/fbtft/fbtft-bus.c
> 
> A full kernel build was not run because the sparse checkout does not
> include the architecture makefiles.

Do not ever work with sparse checkouts,that's not how to do kernel
development.

> Signed-off-by: Krishnanand G <
> 118352827+Krishnanand-G@users.noreply.github.com>

There is no patch here :(
