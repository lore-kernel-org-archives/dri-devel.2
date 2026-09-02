Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166E9C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D62810E483;
	Wed,  2 Sep 2026 05:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uzb/2fCt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA18910E46B
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 05:58:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48DFB40489;
 Wed,  2 Sep 2026 05:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49A61F000E9;
 Wed,  2 Sep 2026 05:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1788328729;
 bh=sTbax0D6dEo7/4ksum2O2WOquO8eB2u4AH6Op/kUQT0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=uzb/2fCtFJVlfE0iogpJbnq1AUZ4sfUHwB3+2PzRdqzengFtn9MnX4mPTw1AprQzp
 oaiVAaP4JKL+4Kr7Ygd9dQvzbRrp3igdP2t4JE9rCKlUBfmDLCWIaqKGHap8qlZpuk
 DVeOs303FJPmhKk22kef08otgQm89C2RjH/uCRGg=
Date: Wed, 2 Sep 2026 07:58:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Anshika Jain <anshikajain196872@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, sashiko-bot@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: fix len<=0 buffer overflow in
 define_fbtft_write_reg()
Message-ID: <2026090225-counting-headroom-4efc@gregkh>
References: <20260902045026.7442-1-anshikajain196872@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902045026.7442-1-anshikajain196872@gmail.com>
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

On Wed, Sep 02, 2026 at 10:20:26AM +0530, Anshika Jain wrote:
> If len is 0 or negative when a define_fbtft_write_reg()-generated
> function is called, len-- underflows to -1, causing the subsequent
> while (i--) loop to run approximately 2^31 times and write far past
> the end of buf.
> 
> This is a latent bug: nothing in the current code prevents two
> adjacent negative values in an init_sequence from producing len=0,
> and there is no guarantee future or out-of-tree panel definitions
> won't do so.
> 
> Add an early return for len <= 0, matching the existing guard already
> present in the sibling function fbtft_write_reg8_bus9().
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260830161529.14500-1-anshikajain196872@gmail.com?part=1
> 
> Signed-off-by: Anshika Jain <anshikajain196872@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 3 +++
>  1 file changed, 3 insertions(+)

Did you forget an assisted-by: tag that helped you write this patch and
changelog?

thanks,

greg k-h
